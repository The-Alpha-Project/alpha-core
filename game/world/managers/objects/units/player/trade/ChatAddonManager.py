from enum import IntEnum
from struct import pack
from time import monotonic, time

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
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
PET = 'pet'
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
MAX_ADDON_SETTINGS_LENGTH = 72
MAX_ADDON_FLAGS_VALUE = 18446744073709551615
# Public addon API versions start at 1 for each currently supported feature surface.
ADDON_API_VERSION_ORDER = ('auras', 'distance', 'config', 'guild', 'pet')
ADDON_API_VERSIONS = {
    'auras': 1,
    'distance': 1,
    'config': 1,
    'guild': 1,
    'pet': 1,
}
INVALID_LEGACY_COMMANDS = {
    'getunitauras',
    'getunitdistance',
    'get_auras_version',
    'get_target_dist_version'
}
OUTDATED_ADDON_NOTIFICATION = (
    'Your AlphaUI addon API is outdated. Please update AlphaUI '
    f'(Auras v{ADDON_API_VERSIONS["auras"]}, '
    f'TargetDistance v{ADDON_API_VERSIONS["distance"]}, '
    f'Config v{ADDON_API_VERSIONS["config"]}, '
    f'Guild v{ADDON_API_VERSIONS["guild"]}, '
    f'Pet v{ADDON_API_VERSIONS["pet"]}).'
)


class ChatAddonManager:

    @staticmethod
    def _get_spell_icon_path(icon_id):
        # Resolve icon filenames server-side so 0.5.3 clients can render aura icons without bundling a spell icon database.
        spell_icon = DbcDatabaseManager.SpellIconHolder.spell_icon_get_by_id(int(icon_id or 0))
        if spell_icon and spell_icon.TextureFilename:
            return ChatAddonManager._sanitize_csv_field(spell_icon.TextureFilename)
        return 'Interface\\Icons\\Temp'

    @staticmethod
    def process_addon_request(channel, player_mgr, message: str):
        command = ''
        args = []
        try:
            command, args = ChatAddonManager._parse_request(message)
            Logger.debug(f'Addon request [{command}] from [{player_mgr.get_name()}], args={args}.')

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
        api_fields = [
            f'{api_name}={ADDON_API_VERSIONS[api_name]}'
            for api_name in ADDON_API_VERSION_ORDER
        ]
        api_fields.append('strict=1')
        return (
            AddonErrorCodes.SUCCESS,
            'api,' + ','.join(api_fields),
            PLAYER,
            ''
        )

    @staticmethod
    def get_character_config(player_mgr, args):
        if not args or len(args) != 1:
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        request_token = ChatAddonManager._sanitize_request_token(args[0])
        if request_token is None or request_token == '':
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        addon_settings = RealmDatabaseManager.character_get_addon_settings(player_mgr.guid)
        flags = int(addon_settings.flags) if addon_settings else 0
        settings = addon_settings.settings if addon_settings and addon_settings.settings else ''

        return (AddonErrorCodes.SUCCESS,
                ChatAddonManager._build_config_response(flags, request_token, settings),
                PLAYER,
                request_token)

    @staticmethod
    def set_character_config(player_mgr, args):
        if not args or len(args) != 2:
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        request_token = ChatAddonManager._sanitize_request_token(args[0])
        if request_token is None or request_token == '':
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        parse_result, flags, settings = ChatAddonManager._parse_config_payload(args[1])
        if parse_result != AddonErrorCodes.SUCCESS:
            return parse_result, '', PLAYER, request_token

        RealmDatabaseManager.character_update_addon_settings(
            player_mgr.guid,
            flags=flags,
            settings=settings,
            updated_at=int(time())
        )

        return (AddonErrorCodes.SUCCESS,
                ChatAddonManager._build_config_response(flags, request_token, settings),
                PLAYER,
                request_token)

    @staticmethod
    def get_unit_auras(player_mgr, args):
        parse_result, unit_id, request_token = ChatAddonManager._parse_versioned_unit_and_token(args)
        if parse_result != AddonErrorCodes.SUCCESS:
            return parse_result, '', unit_id, request_token

        result, unit, unit_id = ChatAddonManager._get_unit(player_mgr, unit_id)

        if result != AddonErrorCodes.SUCCESS:
            return result, '', unit_id, request_token

        auras_information = []
        unit_guid = str(unit.guid) if unit else ''
        if unit:
            for aura in unit.aura_manager.get_active_auras():
                if aura.passive or not aura.displays_in_aura_bar():
                    continue
                if not aura.source_spell or not aura.source_spell.spell_entry:
                    continue
                name = ChatAddonManager._sanitize_csv_field(aura.source_spell.spell_entry.Name_enUS)
                texture = aura.source_spell.spell_entry.SpellIconID
                texture_path = ChatAddonManager._get_spell_icon_path(texture)
                remaining = int(aura.get_duration())
                harmful = 1 if aura.harmful else 0
                auras_information.append(f'ae,{name},{harmful},{remaining},{texture_path}')
                if len(auras_information) >= MAX_AURA_RESULTS:
                    break

        header = f'au,{unit_id},{request_token},{unit_guid},{len(auras_information)}'
        if not auras_information:
            return AddonErrorCodes.SUCCESS, header, unit_id, request_token
        res = header + '\n' + str.join('\n', auras_information)
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

        distance = int(player_mgr.location.distance(unit.location) + 0.5)
        return AddonErrorCodes.SUCCESS, f'{unit_id},{distance},{request_token}', unit_id, request_token

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
    def _sanitize_settings_payload(settings_payload):
        if settings_payload is None:
            return ''

        payload = str(settings_payload).strip()
        if not payload or payload == '-':
            return ''

        if len(payload) > MAX_ADDON_SETTINGS_LENGTH:
            return None

        for char in payload:
            if char.isalnum():
                continue
            if char not in {'_', '-', '.', ':', ';', '='}:
                return None

        return payload

    @staticmethod
    def _parse_config_payload(payload):
        if payload is None:
            return AddonErrorCodes.INVALID_REQUEST, 0, ''

        config_payload = str(payload).strip()
        if not config_payload:
            return AddonErrorCodes.INVALID_REQUEST, 0, ''

        if '|' in config_payload:
            flags_text, settings_payload = config_payload.split('|', 1)
        else:
            flags_text, settings_payload = config_payload, ''

        try:
            flags = int(flags_text)
        except (TypeError, ValueError):
            return AddonErrorCodes.INVALID_REQUEST, 0, ''

        if flags < 0 or flags > MAX_ADDON_FLAGS_VALUE:
            return AddonErrorCodes.INVALID_REQUEST, 0, ''

        settings_payload = ChatAddonManager._sanitize_settings_payload(settings_payload)
        if settings_payload is None:
            return AddonErrorCodes.INVALID_REQUEST, 0, ''

        return AddonErrorCodes.SUCCESS, flags, settings_payload

    @staticmethod
    def _build_config_response(flags, request_token, settings_payload=''):
        response = f'cfg,{int(flags)},{request_token}'
        safe_settings = ChatAddonManager._sanitize_settings_payload(settings_payload)
        if safe_settings:
            response += f',{safe_settings}'
        return response

    @staticmethod
    def _extract_request_token(args):
        if not args:
            return ''

        if len(args) == 1:
            token = ChatAddonManager._sanitize_request_token(args[0])
            return token if token else ''

        token = ChatAddonManager._sanitize_request_token(args[1])
        if token:
            return token

        # Fallback for request formats where the token is the first argument.
        token = ChatAddonManager._sanitize_request_token(args[0])
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
    def get_guild_roster(player_mgr, args):
        if not args or len(args) != 1:
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        request_token = ChatAddonManager._sanitize_request_token(args[0])
        if request_token is None or request_token == '':
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        if not player_mgr.guild_manager:
            return AddonErrorCodes.NO_DATA, '', PLAYER, request_token

        guild_mgr = player_mgr.guild_manager
        guild_name = ChatAddonManager._sanitize_csv_field(guild_mgr.guild.name or '')[:50]
        motd = ChatAddonManager._sanitize_csv_field(guild_mgr.guild.motd or '')[:150]

        online_count = 0
        total_count = 0
        member_lines = []

        for guid, member in guild_mgr.members.items():
            total_count += 1
            online_player = WorldSessionStateHandler.find_player_by_guid(guid)
            is_online = 1 if online_player and online_player.online else 0
            if is_online:
                online_count += 1

            name = ChatAddonManager._sanitize_csv_field(member.character.name if member.character else '?')
            level = member.character.level if member.character else 0
            class_id = member.character.class_ if member.character else 0
            rank = int(member.rank)

            member_lines.append(f'gm,{name},{level},{class_id},{rank},{is_online}')

        header = f'gr,{request_token},{guild_name},{motd},{online_count},{total_count}'
        lines = [header] + member_lines
        return AddonErrorCodes.SUCCESS, '\n'.join(lines), PLAYER, request_token

    @staticmethod
    def notify_reload_ui(player_mgr, args):
        if args:
            return AddonErrorCodes.INVALID_REQUEST, '', PLAYER, ''

        if player_mgr.pet_manager:
            player_mgr.pet_manager.refresh_pet_update_fields()

        return AddonErrorCodes.SUCCESS, '', PLAYER, ''

    @staticmethod
    def get_pet_action_bar(player_mgr, args):
        if not args or len(args) != 1:
            return AddonErrorCodes.INVALID_REQUEST, '', PET, ''

        request_token = ChatAddonManager._sanitize_request_token(args[0])
        if request_token is None or request_token == '':
            return AddonErrorCodes.INVALID_REQUEST, '', PET, ''

        if not player_mgr.pet_manager or not player_mgr.pet_manager.refresh_pet_update_fields():
            return AddonErrorCodes.NO_DATA, '', PET, request_token

        return AddonErrorCodes.SUCCESS, '', PET, request_token

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
    'get_cfg': ChatAddonManager.get_character_config,
    'get_auras': ChatAddonManager.get_unit_auras,
    'get_target_dist': ChatAddonManager.get_unit_distance,
    'set_cfg': ChatAddonManager.set_character_config,
    'get_guild_roster': ChatAddonManager.get_guild_roster,
    'notify_reloadui': ChatAddonManager.notify_reload_ui,
    'get_pet_bar': ChatAddonManager.get_pet_action_bar,
}
