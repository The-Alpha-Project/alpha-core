from game.world.managers.objects.player.PlayerManager import PlayerManager
from random import randint
from struct import unpack

from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class RandomRollHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 8:  # Avoid handling empty random roll packet.
            minimum, maximum = unpack('<II', reader.data[:8])

            roll = randint(minimum, maximum)
            player: PlayerManager = world_session.player_mgr

            roll_packet = PacketWriter.get_packet(OpCode.MSG_RANDOM_ROLL,
                                                  pack('<3IQ', minimum, maximum, roll, player.guid))

            if player.group_manager and player.group_manager.is_party_formed():
                player.group_manager.send_packet_to_members(roll_packet, use_ignore=True)
            else:
                world_session.enqueue_packet(roll_packet)

        return 0
