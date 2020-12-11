from struct import pack, unpack

from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import *
from utils.Logger import Logger
from game.world.managers.GridManager import GridManager
from utils.constants.ObjectCodes import UpdateTypes


class WorldTeleportHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if world_session.player_mgr.is_gm:
            pack_guid, map_, x, y, z, o = unpack('<IB4f', reader.data)
            world_session.player_mgr.teleport(map_, Vector(x, y, z, o))
        else:
            Logger.anticheat('Player %s (%s) tried to teleport himself.' % (world_session.player_mgr.player.name,
                                                                            world_session.player_mgr.guid))

        return 0

    @staticmethod
    def handle_ack(world_session, socket, reader):
        world_session.player_mgr.send_update_self(create=True)
        world_session.player_mgr.send_update_surrounding(world_session.player_mgr.generate_proper_update_packet(
            create=True), include_self=False, create=True)
        GridManager.update_object(world_session.player_mgr)

        world_session.player_mgr.is_teleporting = False

        return 0
