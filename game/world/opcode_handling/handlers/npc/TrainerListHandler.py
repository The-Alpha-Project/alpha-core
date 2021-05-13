from struct import pack, unpack
import time

from network.packet.PacketWriter import *


class TrainerListHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty trainer list packet.
            guid = unpack('<Q', reader.data[:8])[0]

            # Player talents
            if guid == world_session.player_mgr.guid:
                world_session.player_mgr.talent_manager.send_talent_list()
            # NPC offering
            else:
                pass

        return 0
