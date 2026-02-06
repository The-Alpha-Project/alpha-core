import hashlib
import hmac
import time

from database.auth.AuthDatabaseManager import AuthDatabaseManager
from database.realm.RealmDatabaseManager import *
from game.world import WorldManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Srp6 import Srp6
from utils.constants.AuthCodes import *
from utils.Logger import Logger


class AuthSessionHandler:
    MAX_USERNAME_LEN = 64
    SRP6_PROOF_LEN = 52
    SRP6_RECODE_LEN = 64
    SRP6_RECODE_WINDOW_SECONDS = 30
    _srp6_recode_cache = {}

    @staticmethod
    def _store_recode_proof(username: str, proof: bytes, ip_address: str) -> None:
        key = username.lower()
        AuthSessionHandler._srp6_recode_cache[key] = (proof, time.time(), ip_address)
        Logger.debug(f'[LoginServer] Cached recode proof for {username} from {ip_address}')

    @staticmethod
    def _get_recode_proof(username: str, ip_address: str) -> bytes:
        key = username.lower()
        entry = AuthSessionHandler._srp6_recode_cache.get(key)
        if not entry:
            Logger.debug(f'[LoginServer] Recode cache miss for {username}')
            return b''
        proof, ts, cached_ip = entry
        if cached_ip != ip_address:
            Logger.debug(f'[LoginServer] Recode cache IP mismatch for {username}')
            return b''
        if time.time() - ts > AuthSessionHandler.SRP6_RECODE_WINDOW_SECONDS:
            AuthSessionHandler._srp6_recode_cache.pop(key, None)
            Logger.debug(f'[LoginServer] Recode cache expired for {username}')
            return b''
        Logger.debug(f'[LoginServer] Recode cache hit for {username}')
        return proof

    @staticmethod
    def handle_srp6_begin(auth_session, reader):
        if len(reader.data) < 9:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthChallenge)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        region, language, user_length = unpack('<IIB', reader.data[:9])

        if user_length <= 0 or user_length > AuthSessionHandler.MAX_USERNAME_LEN:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthChallenge)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        if len(reader.data) < 9 + user_length:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthChallenge)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        username_bytes = reader.data[9:9 + user_length]
        username = username_bytes.split(b'\x00', 1)[0].decode('latin1', errors='ignore').strip()
        account_mgr = AuthDatabaseManager.account_try_get(username)

        # Can't auto generate from here, we have no plain password.
        if not account_mgr:
            data = pack('<2B', AuthCode.AUTH_UNKNOWN_ACCOUNT, Srp6ResponseType.AuthChallenge)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        auth_session.account_mgr = account_mgr
        client_ip = auth_session.client_address[0] if auth_session.client_address else ''
        cached_proof = AuthSessionHandler._get_recode_proof(username, client_ip)
        if config.Server.Settings.srp6_reconnect_enabled and cached_proof:
            Logger.debug(f'[LoginServer] Using recode challenge for {username}')
            data = pack('<2B', AuthCode.AUTH_OK, Srp6ResponseType.AuthRecode)
            data += cached_proof
            data += pack('<B', len(Srp6.g_bytes)) + Srp6.g_bytes
            data += pack('<B', len(Srp6.N_Bytes)) + Srp6.N_Bytes
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return 0
        Logger.debug(f'[LoginServer] Using full SRP6 challenge for {username}')

        account_mgr.update_server_public_private_keys()
        logon_challenge_packet = account_mgr.get_srp6_logon_challenge_packet()
        auth_session.client_socket.sendall(logon_challenge_packet)

        return 0

    @staticmethod
    def handle_srp6_proof(auth_session, reader):
        if not auth_session.account_mgr:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        if len(reader.data) != AuthSessionHandler.SRP6_PROOF_LEN:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1

        client_public_key = reader.data[:32]

        # Reject invalid A values per SRP6.
        if int.from_bytes(client_public_key, byteorder='little') % Srp6.N == 0:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1

        # Client proof.
        c_m1 = reader.data[32:52]
        # Client Server proof.
        s_m1 = auth_session.account_mgr.calculate_client_server_proof(client_public_key)

        # Invalid password.
        if not hmac.compare_digest(s_m1, c_m1):
            data = pack('<2B', AuthCode.AUTH_INCORRECT_PASSWORD, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1

        if not auth_session.account_mgr.save_session_key():
            data = pack('<2B', AuthCode.AUTH_INCORRECT_PASSWORD, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1

        # Send server proof, at this point client is authenticated.
        server_proof_packet = auth_session.account_mgr.get_srp6_server_proof_packet()
        client_ip = auth_session.client_address[0] if auth_session.client_address else ''
        AuthSessionHandler._store_recode_proof(auth_session.account_mgr.account.name,
                                               auth_session.account_mgr.get_srp6_server_proof(),
                                               client_ip)
        auth_session.client_socket.sendall(server_proof_packet)
        auth_session.client_socket.close()

        return 0

    @staticmethod
    def handle_srp6_recode(auth_session, reader):
        Logger.debug(f'[LoginServer] Handling recode proof for {auth_session.account_mgr.account.name if auth_session.account_mgr else "Unknown"}')
        if not auth_session.account_mgr:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            return -1

        if len(reader.data) != AuthSessionHandler.SRP6_RECODE_LEN:
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1

        client_ip = auth_session.client_address[0] if auth_session.client_address else ''
        cached_proof = AuthSessionHandler._get_recode_proof(auth_session.account_mgr.account.name, client_ip)
        if not cached_proof:
            Logger.debug(f'[LoginServer] Recode proof unavailable for {auth_session.account_mgr.account.name}')
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1
        session_key = auth_session.account_mgr.get_session_key_bytes()
        if not session_key:
            Logger.debug(f'[LoginServer] Recode session key unavailable for {auth_session.account_mgr.account.name}')
            data = pack('<2B', AuthCode.AUTH_FAILED, Srp6ResponseType.AuthProof)
            auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
            auth_session.account_mgr.clear_srp_state()
            return -1

        recode_nonce = reader.data[:32]
        recode_proof = reader.data[32:64]
        exp = hashlib.sha1(recode_nonce + session_key).digest()
        expected = pow(Srp6.g, int.from_bytes(exp, byteorder='little'), Srp6.N).to_bytes(32, byteorder='little')
        Logger.debug(f'[LoginServer] Recode client proof match: {hmac.compare_digest(expected, recode_proof)}')

        data = pack('<2B', AuthCode.AUTH_OK, Srp6ResponseType.AuthRecodeProof)
        data += exp
        Logger.debug(f'[LoginServer] Sending recode proof response for {auth_session.account_mgr.account.name}')
        auth_session.client_socket.sendall(PacketWriter.get_srp6_packet(data))
        auth_session.client_socket.close()
        auth_session.account_mgr.clear_srp_state()
        return 0

    @staticmethod
    def handle(world_session, reader):
        version, login_server_id = unpack('<II', reader.data[:8])

        if version != config.Server.Settings.supported_client:
            AuthSessionHandler.send_result(world_session, AuthCode.AUTH_VERSION_MISMATCH)
            return -1

        username = ''
        password = ''
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

        account_mgr = AuthDatabaseManager.account_try_get(username)
        # Can only auto generate accounts through old wow.ses which exposes plain password.
        if not account_mgr and config.Server.Settings.auto_create_accounts and password:
            salt = Srp6.generate_salt()
            verifier = Srp6.calculate_password_verifier(username, password, salt).hex()
            account_mgr = AuthDatabaseManager.account_create(username,
                                                             hashlib.sha256(password.encode('utf-8')).hexdigest(),
                                                             world_session.client_socket.getpeername()[0],
                                                             salt.hex(), verifier)

        if not account_mgr:
            AuthSessionHandler.send_result(world_session, AuthCode.AUTH_UNKNOWN_ACCOUNT)
            return -1

        # Srp6.
        if not password:
            seed_offset = len(username) + 9
            digest_offset = seed_offset + 4
            if len(reader.data) < digest_offset + 20:
                AuthSessionHandler.send_result(world_session, AuthCode.AUTH_FAILED)
                return -1
            client_seed = reader.data[seed_offset:digest_offset]
            client_digest = reader.data[digest_offset:digest_offset + 20]
            server_digest = Srp6.calculate_world_server_proof(username, client_seed, WorldManager.SERVER_SEED,
                                                              bytes.fromhex(account_mgr.account.sessionkey))

        # Attempt login.
        password = hashlib.sha256(password.encode('utf-8')).hexdigest() if password else ''
        login_res, world_session.account_mgr = AuthDatabaseManager.account_try_login(
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
