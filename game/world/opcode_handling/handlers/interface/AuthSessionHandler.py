from database.realm.RealmDatabaseManager import *
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Srp6 import Srp6
from utils.constants.AuthCodes import *


class AuthSessionHandler(object):

    @staticmethod
    def handle_srp6_begin(world_session, reader):
        region, language, user_length = unpack(
            '<IIB', reader.data[:9]
        )

        username = PacketReader.read_string(reader.data, 9, user_length - 1).strip()
        account = RealmDatabaseManager.account_get(username)

        # Can't auto generate from here, we have no plain password.
        if not account:
            data = pack('<1B', 21)
            world_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return 0

        salt = bytes.fromhex(account.salt)
        verifier = bytes.fromhex(account.verifier)
        private_key = os.urandom(32)
        public_key = Srp6.calculate_server_public_key(verifier, private_key)

        # TODO: LogonChallenge

        return -1

    @staticmethod
    def handle(world_session, reader):
        version, login = unpack(
            '<II', reader.data[:8]
        )

        username = ''
        password = ''
        auth_code = AuthCode.AUTH_OK

        try:
            username, password = PacketReader.read_string(reader.data, 8).strip().split()
        except ValueError:
            auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT

        if version != config.Server.Settings.supported_client:
            auth_code = AuthCode.AUTH_VERSION_MISMATCH

        if username and password:
            login_res, world_session.account_mgr = RealmDatabaseManager.account_try_login(
                username, hashlib.sha256(password.encode('utf-8')).hexdigest(),
                world_session.client_socket.getpeername()[0])
            if login_res == 0:
                auth_code = AuthCode.AUTH_INCORRECT_PASSWORD
            elif login_res == -1:
                if config.Server.Settings.auto_create_accounts:
                    salt = os.urandom(32)
                    verifier = Srp6.calculate_password_verifier(username, password, salt)
                    world_session.account_mgr = (
                        RealmDatabaseManager.account_create(username,
                                                            hashlib.sha256(password.encode('utf-8')).hexdigest(),
                                                            world_session.client_socket.getpeername()[0],
                                                            salt.hex(),
                                                            verifier.hex())
                    )
                else:
                    auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT

        WorldSessionStateHandler.disconnect_old_session(world_session)
        WorldSessionStateHandler.add(world_session)

        data = pack('<B', auth_code)
        # We directly send this through the socket, skipping queue model.
        world_session.client_socket.sendall(PacketWriter.get_packet(OpCode.SMSG_AUTH_RESPONSE, data))

        return 0 if auth_code == AuthCode.AUTH_OK else -1
