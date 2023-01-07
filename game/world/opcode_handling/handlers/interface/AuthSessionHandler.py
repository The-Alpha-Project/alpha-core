from database.realm.RealmDatabaseManager import *
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.constants.AuthCodes import *


class AuthSessionHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        version, login = unpack(
            '<II', reader.data[:8]
        )

        username = ''
        password = ''
        auth_code = AuthCode.AUTH_OK

        try:
            username, password = PacketReader.read_string(reader.data, 8).strip().split()
            password = hashlib.sha256(password.encode('utf-8')).hexdigest()
        except ValueError:
            auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT

        if version != config.Server.Settings.supported_client:
            auth_code = AuthCode.AUTH_VERSION_MISMATCH

        if username and password:
            login_res, world_session.account_mgr = RealmDatabaseManager.account_try_login(username, password,
                                                                                          socket.getpeername()[0])
            if login_res == 0:
                auth_code = AuthCode.AUTH_INCORRECT_PASSWORD
            elif login_res == -1:
                if config.Server.Settings.auto_create_accounts:
                    world_session.account_mgr = RealmDatabaseManager.account_create(username, password,
                                                                                    socket.getpeername()[0])
                else:
                    auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT

        WorldSessionStateHandler.disconnect_old_session(world_session)
        WorldSessionStateHandler.add(world_session)

        data = pack('<B', auth_code)
        # We directly send this through the socket, skipping queue model.
        world_session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_RESPONSE, data))

        return 0 if auth_code == AuthCode.AUTH_OK else -1
