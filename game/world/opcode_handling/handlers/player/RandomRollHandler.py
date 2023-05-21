from random import randint

from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class RandomRollHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty random roll packet.
            minimum, maximum = unpack('<2I', reader.data[:8])

            roll = randint(minimum, maximum)

            roll_packet = PacketWriter.get_packet(OpCode.MSG_RANDOM_ROLL,
                                                  pack('<3IQ', minimum, maximum, roll, player_mgr.guid))

            if player_mgr.group_manager and player_mgr.group_manager.is_party_formed():
                player_mgr.group_manager.send_packet_to_members(roll_packet, use_ignore=True)
            else:
                player_mgr.enqueue_packet(roll_packet)

        return 0
