from database.realm.RealmDatabaseManager import *
from game.login.Srp6Session import Srp6Session
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
            data = pack('<2B', 21, 0)
            world_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return 0

        world_session.account_mgr = account

        salt = bytes.fromhex(account.salt)
        verifier = bytes.fromhex(account.verifier)
        server_private_key = os.urandom(32)
        server_public_key = Srp6.calculate_server_public_key(verifier, server_private_key)
        account.srp6_session = Srp6Session(server_public_key, server_private_key)
        g = 7
        N = 0x894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7

        data = pack('<2B', 12, 0)
        data += pack('<B', 1)
        data += g.to_bytes(1, byteorder='little')
        data += pack('<B', 32)
        data += N.to_bytes(32, byteorder='little')
        data += salt
        data += server_public_key
        world_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))

        return 0

    @staticmethod
    def handle_srp6_proof(world_session, reader):
        client_public_key = reader.data[:32]
        c_M1 = reader.data[32:52]

        xorNg = bytes([
             221, 123, 176, 58, 56, 172, 115, 17, 3, 152, 124,
             90, 80, 111, 202, 150, 108, 123, 194, 167,
         ])

        u = Srp6.calculate_u(client_public_key, world_session.account_mgr.srp6_session.server_public_key)
        s_S = Srp6.calculate_server_S_key(client_public_key, bytes.fromhex(world_session.account_mgr.verifier), u,
                                          world_session.account_mgr.srp6_session.server_private_key)
        s_K = Srp6.calculate_interleaved(s_S)
        s_M1 = Srp6.calculate_client_proof(xorNg, world_session.account_mgr.name, s_K, client_public_key,
                                           world_session.account_mgr.srp6_session.server_public_key,
                                           bytes.fromhex(world_session.account_mgr.salt))

        # Invalid password.
        if not s_M1 == c_M1:
            data = pack('<2B', 22, 1)
            world_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return 0

        if not RealmDatabaseManager.account_try_update_session_key(world_session.account_mgr.name, s_K.hex()):
            data = pack('<2B', 22, 1)
            world_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return 0

        # Server proof.
        s_M2 = Srp6.calculate_server_proof(client_public_key, s_M1, s_K)

        data = pack('<2B', 12, 1)
        data += s_M2
        data += pack('<I', 0)
        world_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))

        return 0

    @staticmethod
    def handle(world_session, reader):
        version, login_server_id = unpack(
            '<II', reader.data[:8]
        )

        username = ''
        password = ''
        auth_code = AuthCode.AUTH_OK

        try:
            username, password = PacketReader.read_string(reader.data, 8).strip().split()
        except ValueError:
            auth_code = AuthCode.AUTH_UNKNOWN_ACCOUNT

        # Through launcher (WoW.exe)
        if not username and not password:
            username = PacketReader.read_string(reader.data, 8)
            account_mgr = RealmDatabaseManager.account_get(username.lower())
            if account_mgr:
                # TODO: Figure how do we validate launcher authentication using the data below.
                #  CDataStore::Put(&resp, 478); - Opcode
                #  CDataStore::Put(&resp, 3368); - Version
                #  CDataStore::Put(&resp, this->m_loginData.m_loginServerID); - 0
                #  CDataStore::PutString(&resp, this->m_loginData.m_account); - Username
                #  localChallenge = NTempest::CRandom::uint32_(&g_rndSeed); - Seed
                #  CDataStore::Put(&resp, localChallenge);
                #  SHA1_Update((const char *) & ctx, this->m_loginData.m_account, v6);
                #  SHA1_Update((const char *) & ctx, (char *) & msgId, 4u);
                #  SHA1_Update((const char *) & ctx, (char *) & localChallenge, 4u);
                #  SHA1_Update((const char *) & ctx, (char *) & loginServerID, 4u);
                #  SHA1_Update((const char *) & ctx, (char *) & challenge, 4u);
                #  SHA1_Update((const char *) & ctx, this->m_loginData.m_sessionKey, 0x28u);
                #  SHA1_Final((SHA1_CONTEXT *)localDigest, (int) & ctx);
                #  CDataStore::PutData( & resp, localDigest, 0x14u); - 20 byte digest.
                client_seed = reader.data[len(username) + 8:len(username) + 12]
                client_digest = reader.data[len(username) + 12:-1]
                server_seed = os.urandom(4)
                server_auth = Srp6.calculate_world_server_proof(username, client_seed, server_seed,
                                                                bytes.fromhex(account_mgr.sessionkey))

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
