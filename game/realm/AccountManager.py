import os
from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.Srp6 import Srp6
from utils.constants import CustomCodes
from utils.constants.AuthCodes import Srp6ResponseType, AuthCode


class AccountManager(object):

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
        self._server_private_key = os.urandom(32)
        self._server_public_key = Srp6.calculate_server_public_key(self.get_verifier_bytes(), self._server_private_key)

    def get_salt_bytes(self) -> bytes:
        return bytes.fromhex(self.account.salt)

    def get_verifier_bytes(self) -> bytes:
        return bytes.fromhex(self.account.verifier)

    def calculate_client_server_proof(self, client_public_key):
        self._client_public_key = client_public_key
        u = Srp6.calculate_u(client_public_key, self._server_public_key)
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
        return PacketWriter.get_srp6_packet(data)

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
