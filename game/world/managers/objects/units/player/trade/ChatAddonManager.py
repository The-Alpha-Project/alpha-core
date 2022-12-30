from enum import IntEnum
from struct import pack

from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ChatFlags, ChatMsgs, Languages
from utils.constants.OpCodes import OpCode


class AddonErrorCodes(IntEnum):
    NO_DATA = -2
    INVALID_FUNCTION = -1
    SUCCESS = 0,


class ChatAddonManager:

    @staticmethod
    def process_addon_request(channel, player_mgr, message: str):
        terminator_index = message.find(' ') if ' ' in message else len(message)

        command = message[0:terminator_index].strip().lower()
        args = message[terminator_index:].strip()

        if command not in ADDON_COMMAND_DEFINITIONS:
            ChatAddonManager._send_error(channel, player_mgr, AddonErrorCodes.INVALID_FUNCTION, '')
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

    @staticmethod
    def get_unit_auras(player_mgr, args):
        unit = MapManager.get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection, include_players=True)
        unit = player_mgr if not unit else unit
        unit_id = 'player' if unit and unit.guid == player_mgr.guid or not unit else 'target'
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



