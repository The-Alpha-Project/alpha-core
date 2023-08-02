from enum import IntEnum
from struct import pack

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


class ChatAddonManager:

    @staticmethod
    def process_addon_request(channel, player_mgr, message: str):
        args = None
        try:
            terminator_index = message.find(' ') if ' ' in message else len(message)
            command = message[0:terminator_index].strip().lower()
            args = message[terminator_index:].strip()

            if args:
                args = args.split()

            if command not in ADDON_COMMAND_DEFINITIONS:
                ChatAddonManager._send_error(channel, player_mgr, AddonErrorCodes.INVALID_FUNCTION, 'player')
                return

            code, res, unit_id = ADDON_COMMAND_DEFINITIONS[command](player_mgr, args)

            if code < AddonErrorCodes.SUCCESS:
                ChatAddonManager._send_error(channel, player_mgr, code, unit_id)
                return

            lines = list(filter((0).__ne__, res.rsplit('\n')))
            packets = []
            for line in lines:
                packet = ChatAddonManager._get_message_packet(player_mgr.guid, ChatFlags.CHAT_TAG_NONE, line,
                                                              ChatMsgs.CHAT_MSG_CHANNEL, Languages.LANG_UNIVERSAL,
                                                              channel=channel.name)
                packets.append(packet)

            # Send reply.
            player_mgr.enqueue_packets(packets)
        except:
            target = 'player' if not args else args[0]
            ChatAddonManager._send_error(channel, player_mgr, AddonErrorCodes.INVALID_REQUEST, target)
            Logger.warning('Invalid addon request.')

    @staticmethod
    def get_unit_auras(player_mgr, args):
        unit_id = None

        if args and args[0].lower() not in UNIT_ID_TARGETS:
            return AddonErrorCodes.INVALID_TARGET, '', args[0].lower()
        elif args:
            unit_id = args[0].lower()

        result, unit, unit_id = ChatAddonManager._get_unit(player_mgr, unit_id)

        if result != AddonErrorCodes.SUCCESS:
            return result, '', unit_id,

        auras_information = []
        if unit:
            for aura in unit.aura_manager.get_active_auras():
                if aura.passive or not aura.displays_in_aura_bar():
                    continue
                name = aura.source_spell.spell_entry.Name_enUS
                texture = aura.source_spell.spell_entry.SpellIconID
                remaining = int(aura.get_duration())
                harmful = 1 if aura.harmful else 0
                auras_information.append(f'{unit_id},{name},{harmful},{texture},{remaining}')

        if not auras_information:
            return AddonErrorCodes.NO_DATA, '', unit_id
        res = f'{len(auras_information)}\n' + str.join('\n', auras_information)
        return AddonErrorCodes.SUCCESS, res, unit_id

    @staticmethod
    def _get_unit(player_mgr, unit_id=None):
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
                    index = int(unit_id[-1])
                    unit = player_mgr.group_manager.get_member_at(index)
                    error_code = (AddonErrorCodes.SUCCESS if unit is not None else
                                  AddonErrorCodes.EMPTY_OFFLINE_GROUP_SLOT)

        return error_code, unit if unit else None, unit_id

    @staticmethod
    def _send_error(channel, player_mgr, code: AddonErrorCodes, unit_id):
        error = f'{str(code.value)}, {unit_id}'
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


ADDON_COMMAND_DEFINITIONS = {
    'getunitauras': ChatAddonManager.get_unit_auras
}
