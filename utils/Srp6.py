import os
import hashlib

'''
N	Large safe prime
g	Generator
k	K value
'''

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
    def calculate_x(username: str, password: str, salt: bytes) -> bytes:
        """
        x = SHA1( salt | SHA1( username | : | password ))
        """
        interim = SHA1((username.upper() + ':' + password.upper()).encode()).digest()
        x = SHA1(salt + interim).digest()
        return x

    @staticmethod
    def generate_salt():
        return os.urandom(32)

    @staticmethod
    def calculate_password_verifier(username: str, password: str, salt: bytes) -> bytes:
        """
        password_verifier = g^x % N
        """
        x = int.from_bytes(Srp6.calculate_x(username, password, salt), byteorder='little')
        v = pow(Srp6.g, x, Srp6.N)
        return int.to_bytes(v, 32, 'little')

    @staticmethod
    def calculate_server_public_key(password_verifier: bytes, server_private_key: bytes) -> bytes:
        """
        server_public_key = (k * password_verifier + (g^server_private_key % N)) % N
        """
        password_verifier = int.from_bytes(password_verifier, byteorder='little')
        server_private_key = int.from_bytes(server_private_key, byteorder='little')
        server_public_key = (Srp6.k * password_verifier + pow(Srp6.g, server_private_key, Srp6.N)) % Srp6.N
        assert server_public_key % Srp6.N != 0
        return int.to_bytes(server_public_key, 32, 'little')

    @staticmethod
    def calculate_client_s_key(client_private_key: bytes, server_public_key: bytes, x: bytes, u: bytes) -> bytes:
        """
        s_key = (server_public_key - (k * (g^x % N)))^(client_private_key + u * x) % N
        """
        client_private_key = int.from_bytes(client_private_key, byteorder='little')
        server_public_key = int.from_bytes(server_public_key, byteorder='little')
        x = int.from_bytes(x, byteorder='little')
        u = int.from_bytes(u, byteorder='little')
        s_key = pow((server_public_key - Srp6.k * pow(Srp6.g, x, Srp6.N)), (client_private_key + u * x), Srp6.N)
        return int.to_bytes(s_key, 32, 'little')

    @staticmethod
    def calculate_server_s_key(client_public_key, password_verifier, u, server_private_key) -> bytes:
        """
        s_key = (client_public_key * (password_verifier^u % N))^server_private_key % N,
        """
        client_public_key = int.from_bytes(client_public_key, byteorder='little')
        password_verifier = int.from_bytes(password_verifier, byteorder='little')
        u = int.from_bytes(u, byteorder='little')
        server_private_key = int.from_bytes(server_private_key, byteorder='little')
        s_key = pow((client_public_key * pow(password_verifier, u, Srp6.N)), server_private_key, Srp6.N)
        return int.to_bytes(s_key, 32, 'little')

    @staticmethod
    def calculate_u(client_public_key: bytes, server_public_key: bytes) -> bytes:
        """
        u = SHA1( client_public_key | server_public_key )
        """
        u = SHA1(client_public_key + server_public_key).digest()
        return u

    @staticmethod
    def calculate_interleaved(s_key: bytes) -> bytes:
        """
        session key
        """
        while s_key[0] == 0:
            s_key = s_key[2:]
        e = s_key[0::2]
        f = s_key[1::2]
        g = SHA1(e).digest()
        h = SHA1(f).digest()
        session_key = bytes(x for y in zip(g, h) for x in y)
        return session_key

    @staticmethod
    def calculate_server_proof(client_public_key: bytes, m1: bytes, session_key: bytes) -> bytes:
        """
        m2 = SHA1(client_public_key | m1 | session_key)
        """
        m2 = SHA1(client_public_key + m1 + session_key).digest()
        return m2

    @staticmethod
    def calculate_client_proof(x: bytes, username: str, session_key: bytes, client_public_key: bytes,
                               server_public_key: bytes, salt: bytes) -> bytes:
        """
        m1 = SHA1( x | SHA1(username) | salt | client_public_key | server_public_key | session_key )
        """
        u = SHA1(username.upper().encode()).digest()
        m1 = SHA1(x + u + salt + client_public_key + server_public_key + session_key).digest()
        return m1

    @staticmethod
    def calculate_client_public_key(a: bytes) -> bytes:
        """
        client_public_key = generator^private_client_key % N
        """
        client_private_key = int.from_bytes(a, byteorder='little')
        client_public_key = pow(Srp6.g, client_private_key, Srp6.N)
        assert client_public_key % Srp6.N != 0
        return int.to_bytes(client_public_key, 32, 'little')

    @staticmethod
    def calculate_world_server_proof(username: str, client_seed: bytes, server_seed: bytes, session_key: bytes) -> bytes:
        """
        SHA1( username | 0 | client_seed | server_seed | session_key )
        """
        return SHA1(username.upper().encode() + zero + client_seed + zero + server_seed + session_key).digest()
