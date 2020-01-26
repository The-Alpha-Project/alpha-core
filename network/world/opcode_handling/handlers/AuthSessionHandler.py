from struct import pack, unpack

from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from utils.ConfigManager import config
from utils.constants.AuthCodes import *


class AuthSessionHandler(object):

    @staticmethod
    def handle(socket, packet):
        version, login = unpack(
            '<II', packet[:8]
        )
        username, password = PacketReader.read_string(packet, 8).strip().split()

        auth_code = AuthCode.AUTH_OK.value

        if version != config.Server.Settings.supported_client:
            auth_code = AuthCode.AUTH_VERSION_MISMATCH.value

        # TODO: Handle account login stuff

        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_AUTH_RESPONSE) + 'B'
        header = PacketWriter.get_packet_header(OpCode.SMSG_AUTH_RESPONSE, fmt)
        packet = pack(
            fmt,
            header[0], header[1], header[2], header[3], header[4], header[5],
            auth_code
        )
        socket.sendall(packet)
