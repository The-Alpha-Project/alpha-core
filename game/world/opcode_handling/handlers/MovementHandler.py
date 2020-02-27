from struct import pack, unpack, error, calcsize

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode
from utils.Logger import Logger
from utils.constants.UnitCodes import StandState


class MovementHandler(object):

    @staticmethod
    def handle_movement_status(world_session, socket, reader):
        movement_fmt = '<QfffffffffI'

        if len(reader.data) >= 48:  # Avoid handling malformed movement packets
            try:
                transport_guid, transport_x, transport_y, transport_z, transport_o, x, y, z, o, pitch, flags = \
                    unpack(movement_fmt, reader.data[:48])

                world_session.player_mgr.transport_id = transport_guid

                world_session.player_mgr.transport_x = transport_x
                world_session.player_mgr.transport_y = transport_y
                world_session.player_mgr.transport_z = transport_z
                world_session.player_mgr.transport_orientation = transport_o

                world_session.player_mgr.location.x = x
                world_session.player_mgr.location.y = y
                world_session.player_mgr.location.z = z
                world_session.player_mgr.location.o = o

                world_session.player_mgr.pitch = pitch
                world_session.player_mgr.movement_flags = flags

                movement_data = pack('<Q%us' % len(reader.data),
                                     world_session.player_mgr.guid,
                                     reader.data)

                GridManager.send_surrounding(PacketWriter.get_packet(OpCode(reader.opcode), movement_data),
                                             world_session.player_mgr, include_self=False)
                GridManager.update_object(world_session.player_mgr)
                world_session.player_mgr.sync_player()

                if reader.opcode == OpCode.MSG_MOVE_JUMP and \
                        world_session.player_mgr.stand_state != StandState.UNIT_DEAD:
                    world_session.player_mgr.stand_state = StandState.UNIT_STANDING
                    world_session.player_mgr.flagged_for_update = True

            except error:
                Logger.error('Error while handling %s, skipping. Data: %s' % (OpCode(reader.opcode), reader.data))

        return 0
