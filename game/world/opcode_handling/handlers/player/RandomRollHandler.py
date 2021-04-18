from random import randint
from struct import pack, unpack

from game.world.managers.objects.player.GroupManager import GroupManager
from network.packet.PacketWriter import *


class RandomRollHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty random roll packet
            minimum, maximum = unpack('<2I', reader.data[:8])
            roll = randint(minimum, maximum)

            roll_packet = PacketWriter.get_packet(OpCode.MSG_RANDOM_ROLL,
                                                  pack('<3IQ', minimum, maximum, roll, world_session.player_mgr.guid))

            if world_session.player_mgr.group_manager:
                world_session.player_mgr.group_manager.send_packet_to_members(roll_packet, use_ignore=True)
            else:
                world_session.send_message(roll_packet)

        return 0
