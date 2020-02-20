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
        socket.sendall(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            world_session.player_mgr.get_update_packet(update_type=UpdateTypes.UPDATE_FULL.value, is_self=True)))

        GridManager.send_surrounding(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            world_session.player_mgr.get_update_packet(update_type=UpdateTypes.UPDATE_FULL.value, is_self=False)),
            world_session.player_mgr,
            include_self=False)

        return 0
