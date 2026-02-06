import os
from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.Srp6 import Srp6
from utils.constants import CustomCodes
from utils.constants.AuthCodes import Srp6ResponseType, AuthCode


class AccountManager:
    EXPECTED_SRP_KEY_SIZE = 32

    def __init__(self, account):
        self.account = account
        self._server_public_key = b''
        self._server_private_key = b''
        self._client_public_key = b''
        self._session_key = b''
        self._client_server_proof = b''

    def get_security_level(self) -> CustomCodes.AccountSecurityLevel:
        return self.account.gmlevel

    def is_player(self):
        return self.get_security_level() == CustomCodes.AccountSecurityLevel.PLAYER

    def is_gm(self):
        return self.get_security_level() >= CustomCodes.AccountSecurityLevel.GM or config.Server.Settings.is_gm_server

    def is_dev(self):
        return self.get_security_level() >= CustomCodes.AccountSecurityLevel.DEV

    # Srp6 - AuthSession.

    def update_server_public_private_keys(self):
        self._server_private_key = os.urandom(self.EXPECTED_SRP_KEY_SIZE)
        self._server_public_key = Srp6.calculate_server_public_key(self.get_verifier_bytes(), self._server_private_key)

    def _ensure_server_keys(self):
        if len(self._server_private_key) != self.EXPECTED_SRP_KEY_SIZE \
                or len(self._server_public_key) != self.EXPECTED_SRP_KEY_SIZE:
            self.update_server_public_private_keys()

    def _is_valid_client_public_key(self, client_public_key: bytes) -> bool:
        if len(client_public_key) != self.EXPECTED_SRP_KEY_SIZE:
            return False
        return int.from_bytes(client_public_key, byteorder='little') % Srp6.N != 0

    def clear_srp_state(self):
        self._server_public_key = b''
        self._server_private_key = b''
        self._client_public_key = b''
        self._session_key = b''
        self._client_server_proof = b''

    def get_salt_bytes(self) -> bytes:
        return bytes.fromhex(self.account.salt)

    def get_verifier_bytes(self) -> bytes:
        return bytes.fromhex(self.account.verifier)

    def calculate_client_server_proof(self, client_public_key):
        if not self._is_valid_client_public_key(client_public_key):
            return b''
        self._ensure_server_keys()
        self._client_public_key = client_public_key
        u = Srp6.calculate_u(client_public_key, self._server_public_key)
        if int.from_bytes(u, byteorder='little') == 0:
            return b''
        s_key = Srp6.calculate_server_s_key(client_public_key, self.get_verifier_bytes(), u, self._server_private_key)
        self._session_key = Srp6.calculate_interleaved(s_key)
        self._client_server_proof = Srp6.calculate_client_proof(Srp6.xorNg, self.account.name, self._session_key,
                                                                client_public_key, self._server_public_key,
                                                                self.get_salt_bytes())
        return self._client_server_proof

    def get_srp6_server_proof_packet(self) -> bytes:
        s_m2 = Srp6.calculate_server_proof(self._client_public_key, self._client_server_proof, self._session_key)
        data = pack('<2B', AuthCode.AUTH_OK, Srp6ResponseType.AuthProof)
        data += s_m2
        data += pack('<I', 0)
        packet = PacketWriter.get_srp6_packet(data)
        self.clear_srp_state()
        return packet

    def get_srp6_server_proof(self) -> bytes:
        return Srp6.calculate_server_proof(self._client_public_key, self._client_server_proof, self._session_key)

    def get_srp6_logon_challenge_packet(self) -> bytes:
        data = pack('<2B', AuthCode.AUTH_OK, Srp6ResponseType.AuthChallenge)
        data += pack('<B', len(Srp6.g_bytes)) + Srp6.g_bytes
        data += pack('<B', len(Srp6.N_Bytes)) + Srp6.N_Bytes
        data += self.get_salt_bytes()
        data += self._server_public_key
        return PacketWriter.get_srp6_packet(data)

    def save_session_key(self):
        from database.auth.AuthDatabaseManager import AuthDatabaseManager
        return AuthDatabaseManager.account_try_update_session_key(self.account.name, self._session_key.hex())

    def get_session_key_bytes(self) -> bytes:
        if not self.account.sessionkey:
            return b''
        try:
            return bytes.fromhex(self.account.sessionkey)
        except ValueError:
            return b''
