from struct import pack, unpack

from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import *
from utils.Logger import Logger
from game.world.managers.GridManager import GridManager


class WorldTeleportHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if world_session.player_mgr.is_gm:
            pack_guid, map_, x, y, z, o = unpack('<IB4f', reader.data)
            world_session.player_mgr.teleport(map_, Vector(x, y, z, o))
        else:
            Logger.warning('Player %s (%s) tried to teleport himself.' % (world_session.player_mgr.player.name,
                           world_session.player_mgr.guid))

        return 0

    @staticmethod
    def handle_ack(world_session, socket, reader):
        GridManager.send_surrounding(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT, world_session.player_mgr.get_update_packet()), world_session.player_mgr,
            include_self=True)

        return 0
