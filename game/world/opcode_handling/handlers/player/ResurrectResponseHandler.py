from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class ResurrectResponseHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Ignore if player is update locked or already alive.
        if player_mgr.update_lock or player_mgr.is_alive:
            return 0

        # Avoid handling an empty resurrect response packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=9):
            return 0
        guid, status = unpack('<QB', reader.data[:9])

        # Resurrection request declined.
        if status == 0:
            return 0

        # Resurrection request data not available.
        if not player_mgr.resurrect_data:
            return 0

        # Original resuscitator doesn't match with the received one.
        if player_mgr.resurrect_data.resuscitator_guid != guid:
            return 0

        player_mgr.resurrect()

        return 0

    @staticmethod
    def handle_reclaim_corpse(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling an empty reclaim corpse packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        player_mgr.reclaim_corpse(guid)

        return 0
