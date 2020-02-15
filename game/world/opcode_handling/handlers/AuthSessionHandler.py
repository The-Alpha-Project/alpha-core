import hashlib

from struct import pack, unpack

from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from utils.ConfigManager import config
from utils.constants.AuthCodes import *
from database.realm.RealmDatabaseManager import *
from game.realm.AccountManager import AccountManager


class AuthSessionHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        version, login = unpack(
            '<II', reader.data[:8]
        )
        username, password = PacketReader.read_string(reader.data, 8).strip().split()
        password = hashlib.sha256(password.encode('utf-8')).hexdigest()

        auth_code = AuthCode.AUTH_OK.value

        if version != config.Server.Settings.supported_client:
            auth_code = AuthCode.AUTH_VERSION_MISMATCH.value

        login_res, world_session.account_mgr = RealmDatabaseManager.account_try_login(world_session.realm_db_session,
                                                                                      username, password)
        if login_res == 0:
            auth_code = AuthCode.AUTH_INCORRECT_PASSWORD.value
        elif login_res == -1:
            if config.Server.Settings.auto_create_accounts:
                world_session.account_mgr = RealmDatabaseManager.account_create(world_session.realm_db_session,
                                                                                username, password,
                                                                                socket.getpeername()[0])
            else:
                auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT.value

        data = pack('<B', auth_code)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_RESPONSE, data))

        return 0 if auth_code == AuthCode.AUTH_OK.value else -1
