from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class GetDeathBindPointHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if player_mgr.deathbind:
            area_number = player_mgr.get_map().get_area_number_by_zone_id(player_mgr.deathbind.deathbind_zone)
            data = pack('<2I', player_mgr.map_id, area_number)
            packet = PacketWriter.get_packet(OpCode.SMSG_BINDZONEREPLY, data)
            player_mgr.enqueue_packet(packet)

        return 0
