from struct import unpack

from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.Formulas import Distances
from utils.constants.OpCodes import OpCode


class InspectHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling an empty inspect packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0
        inspected_player: PlayerManager = player_mgr.get_map().get_surrounding_player_by_guid(player_mgr, guid)
        if not inspected_player or not inspected_player.is_alive:
            return 0
        if not Distances.is_within_inspect_distance(player_mgr, inspected_player):
            return 0

        player_mgr.set_current_selection(guid)
        data = pack('<Q', player_mgr.guid)
        inspected_player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_INSPECT, data))

        return 0
