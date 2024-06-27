from struct import unpack, pack

from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter
from utils.GuidUtils import GuidUtils
from utils.constants.MiscCodes import HighGuid
from utils.constants.OpCodes import OpCode


# CMSG_DEBUG_AISTATE is sent by the client if you have `SET debugTargetInfo` option set to "1".
# You then can answer with SMSG_DEBUG_AISTATE including text messages that will be appended to the
# object tooltip you are hovering.
class DebugAIStateHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty debug AI state packet.
            guid = unpack('<Q', reader.data[:8])[0]

            high_guid: HighGuid = GuidUtils.extract_high_guid(guid)
            if high_guid == HighGuid.HIGHGUID_UNIT or high_guid == HighGuid.HIGHGUID_PLAYER or high_guid == HighGuid.HIGHGUID_PET:
                world_object = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid, include_players=True)
            else:
                world_object = player_mgr.get_map().get_surrounding_gameobject_by_guid(player_mgr, guid)

            # No object with that Guid? Return.
            if not world_object:
                return 0

            messages: list[str] = world_object.get_debug_messages(player_mgr)
            data = pack(
                '<QI',
                guid,
                len(messages)
            )

            for message in messages:
                message_bytes = PacketWriter.string_to_bytes(message[:127])  # Max length is 128 (127 + null byte).
                data += pack(
                    f'<{len(message_bytes)}s',
                    message_bytes
                )

            player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_DEBUG_AISTATE, data))

        return 0
