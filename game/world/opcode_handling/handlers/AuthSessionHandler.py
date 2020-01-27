import hashlib

from struct import pack, unpack

from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from utils.ConfigManager import config
from utils.constants.AuthCodes import *
from database.realm.RealmDatabaseManager import *


class AuthSessionHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        version, login = unpack(
            '<II', packet[:8]
        )
        username, password = PacketReader.read_string(packet, 8).strip().split()
        password = hashlib.sha256(password.encode('utf-8')).hexdigest()

        auth_code = AuthCode.AUTH_OK.value

        if version != config.Server.Settings.supported_client:
            auth_code = AuthCode.AUTH_VERSION_MISMATCH.value

        login_res, world_session.account = RealmDatabaseManager.account_try_login(username, password)
        if login_res == 0:
            auth_code = AuthCode.AUTH_INCORRECT_PASSWORD.value
        elif login_res == -1:
            auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT.value

        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_AUTH_RESPONSE) + 'B'
        header = PacketWriter.get_packet_header(OpCode.SMSG_AUTH_RESPONSE, fmt)
        packet = pack(
            fmt,
            header[0], header[1], header[2], header[3], header[4], header[5],
            auth_code
        )
        socket.sendall(packet)

        return 0 if auth_code == AuthCode.AUTH_OK.value else -1
