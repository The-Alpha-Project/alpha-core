from struct import pack, unpack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *


class AttackSwingHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty attack swing packet
            # TODO: Finish implementing this
            enemy_guid = unpack('<Q', reader.data[:8])[0]
            enemy = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, enemy_guid, include_players=True)

            if not enemy or not enemy.is_alive:  # Check if it's enemy too
                AttackSwingHandler.handle_stop(world_session, socket, reader)
                return 0

            world_session.player_mgr.combat_target = enemy_guid
            data = pack('<2Q', world_session.player_mgr.guid, enemy_guid)
            socket.sendall(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTART, data))

        return 0

    @staticmethod
    def handle_stop(world_session, socket, reader):
        data = pack('<2QI',
                    world_session.player_mgr.guid,
                    world_session.player_mgr.combat_target,
                    0)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTOP, data))

        return 0
