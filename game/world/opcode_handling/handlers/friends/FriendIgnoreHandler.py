from network.packet.PacketReader import *


class FriendIgnoreHandler(object):

    @staticmethod
    def handle(world_session, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        world_session.player_mgr.friends_manager.try_add_ignore(target_name)

        return 0
