from struct import pack, unpack, error

from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode
from utils.Logger import Logger


class MovementHandler(object):

    @staticmethod
    def handle_movement_status(world_session, socket, reader):
        movement_fmt = '<QfffffffffI'
        try:
            transport_guid, transport_x, transport_y, transport_z, transport_o, x, y, z, o, pitch, flags = \
                unpack(movement_fmt, reader.data)

            movement_data = PacketWriter.get_packet(OpCode(reader.opcode),
                                                    pack(movement_fmt,
                                                         transport_guid,
                                                         transport_x,
                                                         transport_y,
                                                         transport_z,
                                                         transport_o,
                                                         x, y, z, o,
                                                         pitch,
                                                         flags))
            socket.sendall(movement_data)
        except error:
            Logger.error('Error while handling %s, skipping.' % OpCode(reader.opcode))

        # TODO: Update in DB

        return 0
