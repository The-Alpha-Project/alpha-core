from network.packet.PacketReader import *


class FriendDeleteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty friend delete packet.
            guid = unpack('<Q', reader.data[:8])[0]
            world_session.player_mgr.friends_manager.remove_friend(guid)

        return 0
