import os
import hashlib

zero = bytes([0, 0, 0, 0])
SHA1 = hashlib.sha1


class Srp6:
    g = 7
    g_bytes = g.to_bytes(1, byteorder='little')
    N = 0x894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7
    N_Bytes = N.to_bytes(32, byteorder='little')
    k = 3
    xorNg = bytes([
        221, 123, 176, 58, 56, 172, 115, 17, 3, 152, 124,
        90, 80, 111, 202, 150, 108, 123, 194, 167,
    ])

    @staticmethod
    # Derive private x from username/password and salt.
    def calculate_x(username: str, password: str, salt: bytes) -> bytes:
        interim = SHA1((username.upper() + ':' + password.upper()).encode()).digest()
        x = SHA1(salt + interim).digest()
        return x

    @staticmethod
    # Generate a random 32-byte salt for SRP.
    def generate_salt():
        return os.urandom(32)

    @staticmethod
    # Compute the verifier v = g^x mod N.
    def calculate_password_verifier(username: str, password: str, salt: bytes) -> bytes:
        x = int.from_bytes(Srp6.calculate_x(username, password, salt), byteorder='little')
        v = pow(Srp6.g, x, Srp6.N)
        return int.to_bytes(v, 32, 'little')

    @staticmethod
    # Compute the server public key B.
    def calculate_server_public_key(password_verifier: bytes, server_private_key: bytes) -> bytes:
        password_verifier = int.from_bytes(password_verifier, byteorder='little')
        server_private_key = int.from_bytes(server_private_key, byteorder='little')
        server_public_key = (Srp6.k * password_verifier + pow(Srp6.g, server_private_key, Srp6.N)) % Srp6.N
        if server_public_key % Srp6.N == 0:
            raise ValueError('Invalid server public key')
        return int.to_bytes(server_public_key, 32, 'little')

    @staticmethod
    # Compute the client-side shared secret S.
    def calculate_client_s_key(client_private_key: bytes, server_public_key: bytes, x: bytes, u: bytes) -> bytes:
        client_private_key = int.from_bytes(client_private_key, byteorder='little')
        server_public_key = int.from_bytes(server_public_key, byteorder='little')
        x = int.from_bytes(x, byteorder='little')
        u = int.from_bytes(u, byteorder='little')
        s_key = pow((server_public_key - Srp6.k * pow(Srp6.g, x, Srp6.N)), (client_private_key + u * x), Srp6.N)
        return int.to_bytes(s_key, 32, 'little')

    @staticmethod
    # Compute the server-side shared secret S.
    def calculate_server_s_key(client_public_key, password_verifier, u, server_private_key) -> bytes:
        client_public_key = int.from_bytes(client_public_key, byteorder='little')
        password_verifier = int.from_bytes(password_verifier, byteorder='little')
        u = int.from_bytes(u, byteorder='little')
        server_private_key = int.from_bytes(server_private_key, byteorder='little')
        s_key = pow((client_public_key * pow(password_verifier, u, Srp6.N)), server_private_key, Srp6.N)
        return int.to_bytes(s_key, 32, 'little')

    @staticmethod
    # Compute the scrambling parameter u = H(A|B).
    def calculate_u(client_public_key: bytes, server_public_key: bytes) -> bytes:
        u = SHA1(client_public_key + server_public_key).digest()
        return u

    @staticmethod
    # Derive the session key from the shared secret.
    def calculate_interleaved(s_key: bytes) -> bytes:
        while s_key[0] == 0:
            s_key = s_key[2:]
        e = s_key[0::2]
        f = s_key[1::2]
        g = SHA1(e).digest()
        h = SHA1(f).digest()
        session_key = bytearray(x for y in zip(g, h) for x in y)
        return session_key

    @staticmethod
    # Compute the server proof M2 from client proof and session key.
    def calculate_server_proof(client_public_key: bytes, m1: bytes, session_key: bytes) -> bytes:
        m2 = SHA1(client_public_key + m1 + session_key).digest()
        return m2

    @staticmethod
    # Compute the client proof M1 for SRP verification.
    def calculate_client_proof(x: bytes, username: str, session_key: bytes, client_public_key: bytes,
                               server_public_key: bytes, salt: bytes) -> bytes:
        u = SHA1(username.upper().encode()).digest()
        m1 = SHA1(x + u + salt + client_public_key + server_public_key + session_key).digest()
        return m1

    @staticmethod
    # Compute the client public key A = g^a mod N.
    def calculate_client_public_key(a: bytes) -> bytes:
        client_private_key = int.from_bytes(a, byteorder='little')
        client_public_key = pow(Srp6.g, client_private_key, Srp6.N)
        if client_public_key % Srp6.N == 0:
            raise ValueError('Invalid client public key')
        return int.to_bytes(client_public_key, 32, 'little')

    @staticmethod
    # Compute world server proof for the game connection.
    def calculate_world_server_proof(username: str, client_seed: bytes, server_seed: bytes, session_key: bytes) -> bytes:
        return SHA1(username.upper().encode() + zero + client_seed + zero + server_seed + session_key).digest()
