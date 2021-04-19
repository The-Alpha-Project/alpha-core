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
            Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to teleport himself.')

        return 0

    @staticmethod
    def handle_ack(world_session, socket, reader):
        if world_session.player_mgr:
            world_session.player_mgr.spawn_player_from_teleport()
        return 0
