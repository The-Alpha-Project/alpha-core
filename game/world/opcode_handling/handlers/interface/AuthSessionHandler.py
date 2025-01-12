from database.realm.RealmDatabaseManager import *
from game.world import WorldManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Srp6 import Srp6
from utils.constants.AuthCodes import *


class AuthSessionHandler(object):

    @staticmethod
    def handle_srp6_begin(auth_session, reader):
        region, language, user_length = unpack(
            '<IIB', reader.data[:9]
        )

        username = PacketReader.read_string(reader.data, 9, user_length - 1).strip()
        account_mgr = RealmDatabaseManager.account_get(username)

        # Can't auto generate from here, we have no plain password.
        if not account_mgr:
            data = pack('<2B', 21, 0)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        auth_session.account_mgr = account_mgr
        account_mgr.update_server_public_private_keys()
        auth_session.client_socket.sendall(account_mgr.get_srp6_logon_challenge_packet())

        return 0

    @staticmethod
    def handle_srp6_proof(auth_session, reader):
        client_public_key = reader.data[:32]

        # Client proof.
        c_M1 = reader.data[32:52]
        # Server proof.
        s_M1 = auth_session.account_mgr.calculate_client_server_proof(client_public_key)

        # Invalid password.
        if not s_M1 == c_M1:
            data = pack('<2B', 22, 1)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return 0

        if not auth_session.account_mgr.save_session_key():
            data = pack('<2B', 22, 1)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return 0

        # Send server proof, at this point client is authenticated.
        auth_session.client_socket.sendall(auth_session.account_mgr.get_srp6_server_proof_packet())

        return 0

    @staticmethod
    def handle(world_session, reader):
        version, login_server_id = unpack('<II', reader.data[:8])

        if version != config.Server.Settings.supported_client:
            AuthSessionHandler.send_result(world_session, AuthCode.AUTH_VERSION_MISMATCH)
            return -1

        auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT
        username = ''
        password = ''
        client_seed = b''
        client_digest = b''
        server_digest = b''

        # Legacy wow.ses.
        try:
            username, password = PacketReader.read_string(reader.data, 8).strip().split()
        except ValueError:
            # Launcher srp6.
            try:
                username = PacketReader.read_string(reader.data, 8)
            except:
                pass

        if not username:
            AuthSessionHandler.send_result(world_session, AuthCode.AUTH_UNKNOWN_ACCOUNT)
            return -1

        account_mgr = RealmDatabaseManager.account_get(username)
        # Can only auto generate accounts through old wow.ses which exposes plain password.
        if not account_mgr and config.Server.Settings.auto_create_accounts and password:
            salt = Srp6.generate_salt().hex()
            verifier = Srp6.calculate_password_verifier(username, password, salt).hex()
            account_mgr = RealmDatabaseManager.account_create(username,
                                                              hashlib.sha256(password.encode('utf-8')).hexdigest(),
                                                              world_session.client_socket.getpeername()[0],
                                                              salt, verifier)

        if not account_mgr:
            AuthSessionHandler.send_result(world_session, AuthCode.AUTH_UNKNOWN_ACCOUNT)
            return -1

        # Srp6.
        if not password:
            client_seed = reader.data[len(username) + 9:len(username) + 13]
            client_digest = reader.data[len(username) + 13:]
            server_digest = Srp6.calculate_world_server_proof(username, client_seed, WorldManager.SERVER_SEED,
                                                              bytes.fromhex(account_mgr.account.sessionkey))

        # Attempt login.
        password = hashlib.sha256(password.encode('utf-8')).hexdigest() if password else ''
        login_res, world_session.account_mgr = RealmDatabaseManager.account_try_login(
                username, password, world_session.client_socket.getpeername()[0], client_digest, server_digest)

        if login_res == 0:
            auth_code = AuthCode.AUTH_INCORRECT_PASSWORD
        elif login_res == -1:
            auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT
        else:
            auth_code = AuthCode.AUTH_OK

        AuthSessionHandler.send_result(world_session, auth_code)

        return 0 if auth_code == AuthCode.AUTH_OK else -1

    @staticmethod
    def send_result(world_session, auth_code):
        WorldSessionStateHandler.disconnect_old_session(world_session)
        WorldSessionStateHandler.add(world_session)
        packet = PacketWriter.get_packet(OpCode.SMSG_AUTH_RESPONSE, pack('<B', auth_code))
        world_session.client_socket.sendall(packet)