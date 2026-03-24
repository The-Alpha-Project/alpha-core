from enum import IntEnum
from struct import pack
from time import monotonic

from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.MiscCodes import ChatFlags, ChatMsgs, Languages
from utils.constants.OpCodes import OpCode


class AddonErrorCodes(IntEnum):
    EMPTY_OFFLINE_GROUP_SLOT = -6
    NO_GROUP = -5
    INVALID_REQUEST = -4
    INVALID_TARGET = -3
    NO_DATA = -2
    INVALID_FUNCTION = -1
    SUCCESS = 0,


# Available UnitIDs.
PLAYER = 'player'
TARGET = 'target'
PARTY1 = 'party1'
PARTY2 = 'party2'
PARTY3 = 'party3'
PARTY4 = 'party4'

UNIT_ID_TARGETS = {
    'player', 'target', 'party1', 'party2', 'party3', 'party4'
}

MAX_ADDON_REQUEST_LENGTH = 128
MAX_ADDON_REQUEST_ARGS = 2
MAX_ADDON_RESPONSE_LINE_LENGTH = 256
MAX_AURA_RESULTS = 40
ADDON_REQUEST_MIN_INTERVAL_SECONDS = 0.01
MAX_ADDON_TOKEN_LENGTH = 24
ADDON_API_AURAS_VERSION = 2
ADDON_API_DISTANCE_VERSION = 2
INVALID_LEGACY_COMMANDS = {'getunitauras', 'getunitdistance'}
VERSIONED_DATA_COMMANDS = {'get_auras_version', 'get_target_dist_version'}
OUTDATED_ADDON_NOTIFICATION = (
    f'Your addon API version is outdated. Please update 053-AddOns '
    f'(Auras v{ADDON_API_AURAS_VERSION}, TargetDistance v{ADDON_API_DISTANCE_VERSION}).'
)


class ChatAddonManager:

    @staticmethod
    def process_addon_request(channel, player_mgr, message: str):
        command = ''
        args = []
        try:
            command, args = ChatAddonManager._parse_request(message)

            if not ChatAddonManager._request_allowed(player_mgr, command):
                unit_id = PLAYER
                if args and args[0].lower() in UNIT_ID_TARGETS:
                    unit_id = args[0].lower()
                request_token = ChatAddonManager._extract_request_token(args)
                ChatAddonManager._send_error(channel, player_mgr, AddonErrorCodes.INVALID_REQUEST, unit_id,
                                             request_token)
                return

            if command not in ADDON_COMMAND_DEFINITIONS:
                if command in INVALID_LEGACY_COMMANDS:
                    ChatAddonManager._notify_outdated_addon_once(player_mgr)
                request_token = ChatAddonManager._extract_request_token(args)
                ChatAddonManager._send_error(channel, player_mgr, AddonErrorCodes.INVALID_FUNCTION, 'player',
                                             request_token)
                return

            code, res, unit_id, request_token = ADDON_COMMAND_DEFINITIONS[command](player_mgr, args)

            if code < AddonErrorCodes.SUCCESS:
                if command in VERSIONED_DATA_COMMANDS and code == AddonErrorCodes.INVALID_REQUEST:
                    ChatAddonManager._notify_outdated_addon_once(player_mgr)
                ChatAddonManager._send_error(channel, player_mgr, code, unit_id, request_token)
                return

            lines = [line[:MAX_ADDON_RESPONSE_LINE_LENGTH] for line in res.rsplit('\n') if line]
            packets = []
            for line in lines:
                packet = ChatAddonManager._get_message_packet(player_mgr.guid, ChatFlags.CHAT_TAG_NONE, line,
                                                              ChatMsgs.CHAT_MSG_CHANNEL, Languages.LANG_UNIVERSAL,
                                                              channel=channel.name)
                packets.append(packet)

            # Send reply.
            if packets:
                player_mgr.enqueue_packets(packets)
        except Exception as ex:
            target = PLAYER if not args else args[0]
            request_token = ChatAddonManager._extract_request_token(args)
            ChatAddonManager._send_error(channel, player_mgr, AddonErrorCodes.INVALID_REQUEST, target, request_token)
            Logger.warning(
                f'Invalid addon request. Command [{command}], sender [{player_mgr.get_name()}], reason [{ex}].')

    @staticmethod
    def get_addon_api_version(player_mgr, args):
        if args:
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''
        return (
            AddonErrorCodes.SUCCESS,
            f'api,auras={ADDON_API_AURAS_VERSION},distance={ADDON_API_DISTANCE_VERSION},strict=1',
            PLAYER,
            ''
        )

    @staticmethod
    def get_unit_auras(player_mgr, args):
        parse_result, unit_id, request_token = ChatAddonManager._parse_versioned_unit_and_token(args)
        if parse_result != AddonErrorCodes.SUCCESS:
            return parse_result, '', unit_id, request_token

        result, unit, unit_id = ChatAddonManager._get_unit(player_mgr, unit_id)

        if result != AddonErrorCodes.SUCCESS:
            return result, '', unit_id, request_token

        auras_information = []
        if unit:
            unit_guid = str(unit.guid)
            for aura in unit.aura_manager.get_active_auras():
                if aura.passive or not aura.displays_in_aura_bar():
                    continue
                if not aura.source_spell or not aura.source_spell.spell_entry:
                    continue
                name = ChatAddonManager._sanitize_csv_field(aura.source_spell.spell_entry.Name_enUS)
                texture = aura.source_spell.spell_entry.SpellIconID
                remaining = int(aura.get_duration())
                harmful = 1 if aura.harmful else 0
                auras_information.append(f'{unit_id},{name},{harmful},{texture},{remaining},{request_token},{unit_guid}')
                if len(auras_information) >= MAX_AURA_RESULTS:
                    break

        if not auras_information:
            return AddonErrorCodes.NO_DATA, '', unit_id, request_token
        res = f'{len(auras_information)}\n' + str.join('\n', auras_information)
        return AddonErrorCodes.SUCCESS, res, unit_id, request_token

    @staticmethod
    def get_unit_distance(player_mgr, args):
        parse_result, unit_id, request_token = ChatAddonManager._parse_versioned_unit_and_token(args)
        if parse_result != AddonErrorCodes.SUCCESS:
            return parse_result, '', unit_id, request_token

        result, unit, unit_id = ChatAddonManager._get_unit(player_mgr, unit_id)

        if result != AddonErrorCodes.SUCCESS:
            return result, '', unit_id, request_token

        if not unit:
            return AddonErrorCodes.NO_DATA, '', unit_id, request_token

        if not player_mgr.location or not unit.location:
            return AddonErrorCodes.NO_DATA, '', unit_id, request_token

        distance = player_mgr.location.distance(unit.location)
        return AddonErrorCodes.SUCCESS, f'{unit_id},{distance:.3f},{request_token}', unit_id, request_token

    @staticmethod
    def _get_unit(player_mgr, unit_id=None):
        if unit_id and unit_id not in UNIT_ID_TARGETS:
            return AddonErrorCodes.INVALID_TARGET, None, unit_id

        error_code = AddonErrorCodes.INVALID_TARGET
        unit = None

        if not unit_id:
            unit = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection,
                                                                     include_players=True)
            unit = player_mgr if not unit else unit
            unit_id = 'player' if unit and unit.guid == player_mgr.guid or not unit else 'target'
            error_code = AddonErrorCodes.SUCCESS if unit is not None else AddonErrorCodes.INVALID_TARGET
        else:
            if unit_id == PLAYER:
                unit = player_mgr
                error_code = AddonErrorCodes.SUCCESS
            elif unit_id == TARGET:
                # Skip target search if we have the current selection guid as combat target.
                if player_mgr.combat_target and player_mgr.current_selection == player_mgr.combat_target.guid:
                    unit = player_mgr.combat_target
                else:
                    unit = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection,
                                                                             include_players=True)
                error_code = AddonErrorCodes.SUCCESS if unit is not None else AddonErrorCodes.INVALID_TARGET
            elif 'party' in unit_id:
                if not player_mgr.group_manager or not player_mgr.group_manager.is_party_formed():
                    error_code = AddonErrorCodes.NO_GROUP
                else:
                    try:
                        index = int(unit_id[-1])
                    except (TypeError, ValueError):
                        return AddonErrorCodes.INVALID_TARGET, None, unit_id
                    unit = player_mgr.group_manager.get_member_at(index)
                    error_code = (AddonErrorCodes.SUCCESS if unit is not None else
                                  AddonErrorCodes.EMPTY_OFFLINE_GROUP_SLOT)

        return error_code, unit if unit else None, unit_id

    @staticmethod
    def _send_error(channel, player_mgr, code: AddonErrorCodes, unit_id, request_token=''):
        error_unit_id = ChatAddonManager._sanitize_identifier(unit_id)
        error = f'{str(code.value)}, {error_unit_id}'
        if request_token:
            error += f', {request_token}'
        packet = ChatAddonManager._get_message_packet(player_mgr.guid, ChatFlags.CHAT_TAG_NONE, error,
                                                      ChatMsgs.CHAT_MSG_CHANNEL, Languages.LANG_UNIVERSAL,
                                                      channel=channel.name)
        player_mgr.enqueue_packet(packet)

    @staticmethod
    def _get_message_packet(guid, chat_flags, message, chat_type, lang, channel=None):
        message_bytes = PacketWriter.string_to_bytes(message)

        data = pack('<BI', chat_type, lang)
        if not channel:
            data += pack('<Q', guid)
        else:
            channel_bytes = PacketWriter.string_to_bytes(channel)
            data += pack(f'<{len(channel_bytes)}sQ', channel_bytes, guid)
        data += pack(f'<{len(message_bytes)}sB', message_bytes, chat_flags)

        return PacketWriter.get_packet(OpCode.SMSG_MESSAGECHAT, data)

    @staticmethod
    def _parse_request(message):
        if not isinstance(message, str):
            raise ValueError('Non-string addon message.')

        message = message.strip()
        if not message or len(message) > MAX_ADDON_REQUEST_LENGTH:
            raise ValueError('Invalid addon message length.')

        args = message.split()
        if not args or len(args) > MAX_ADDON_REQUEST_ARGS + 1:
            raise ValueError('Invalid addon message args.')

        command = args[0].lower()
        command_args = args[1:] if len(args) > 1 else []
        return command, command_args

    @staticmethod
    def _request_allowed(player_mgr, command):
        now = monotonic()
        command_key = str(command or '').lower()
        per_command_last_request = player_mgr.addon_api_last_request_ts
        if not isinstance(per_command_last_request, dict):
            per_command_last_request = {}
            player_mgr.addon_api_last_request_ts = per_command_last_request
        last_request = per_command_last_request.get(command_key, 0.0)
        if now - last_request < ADDON_REQUEST_MIN_INTERVAL_SECONDS:
            return False
        per_command_last_request[command_key] = now
        return True

    @staticmethod
    def _sanitize_csv_field(value):
        safe_value = '' if value is None else str(value)
        safe_value = safe_value.replace('\n', ' ').replace('\r', ' ').replace(',', ' ')
        return safe_value.strip()

    @staticmethod
    def _sanitize_identifier(unit_id):
        safe_id = PLAYER if not unit_id else str(unit_id).lower()
        safe_id = safe_id.replace('\n', '').replace('\r', '').replace(',', '').replace(' ', '')
        return safe_id if safe_id else PLAYER

    @staticmethod
    def _sanitize_request_token(request_token):
        if request_token is None:
            return ''
        token = str(request_token).strip()
        if not token:
            return ''
        if len(token) > MAX_ADDON_TOKEN_LENGTH:
            return None
        if not token.replace('_', '').replace('-', '').isalnum():
            return None
        return token

    @staticmethod
    def _extract_request_token(args):
        if not args or len(args) < 2:
            return ''
        token = ChatAddonManager._sanitize_request_token(args[1])
        return token if token else ''

    @staticmethod
    def _notify_outdated_addon_once(player_mgr):
        if player_mgr.outdated_addon_api:
            return
        player_mgr.outdated_addon_api = True
        ChatAddonManager._send_notification(player_mgr, OUTDATED_ADDON_NOTIFICATION)

    @staticmethod
    def _send_notification(player_mgr, message):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(f'<{len(message_bytes)}s', message_bytes)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NOTIFICATION, data))

    @staticmethod
    def _parse_versioned_unit_and_token(args):
        if not args or len(args) != 2:
            return AddonErrorCodes.INVALID_REQUEST, PLAYER, ''
        unit_id = args[0].lower()
        if unit_id not in UNIT_ID_TARGETS:
            return AddonErrorCodes.INVALID_TARGET, unit_id, ''
        request_token = ChatAddonManager._sanitize_request_token(args[1])
        if request_token is None or request_token == '':
            return AddonErrorCodes.INVALID_REQUEST, unit_id, ''
        return AddonErrorCodes.SUCCESS, unit_id, request_token


ADDON_COMMAND_DEFINITIONS = {
    'getaddonapi': ChatAddonManager.get_addon_api_version,
    'get_auras_version': ChatAddonManager.get_unit_auras,
    'get_target_dist_version': ChatAddonManager.get_unit_distance
}
