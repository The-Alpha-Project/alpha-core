import os, hashlib
from ctypes import c_ubyte

'''
A	Client public key
a	Client private key
B	Server public key
b	Server private key
N	Large safe prime
g	Generator
k	K value
s	Salt
U	Username
p	Password
v	Password verifier
M1	Client proof (proof first sent by client, calculated by both)
M2	Server proof (proof first sent by server, calculated by both)
M	(Client or server) proof
S	S key
K	Session key

LS  Login Server
WS  World Server
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
    def calculate_x(U:str, p:str, s:bytes) -> bytes:
        """
        x = SHA1( s | SHA1( U | : | p ))
        """
        interim = SHA1((U.upper() + ':' + p.upper()).encode()).digest()
        x = SHA1(s + interim).digest()
        return x

    @staticmethod
    def generate_salt():
        return os.urandom(32)

    @staticmethod
    def calculate_password_verifier(U:str, p:str, s:bytes) -> bytes:
        """
        v = g^x % N
        """
        x = int.from_bytes(Srp6.calculate_x(U, p, s), byteorder='little')
        v = pow(Srp6.g, x, Srp6.N)
        return int.to_bytes(v, 32, 'little')

    @staticmethod
    def calculate_server_public_key(v:bytes, b:bytes) -> bytes:
        """
        B = (k * v + (g^b % N)) % N
        """
        v = int.from_bytes(v, byteorder='little')
        b = int.from_bytes(b, byteorder='little')
        B = (Srp6.k * v + pow(Srp6.g, b, Srp6.N)) % Srp6.N
        assert B % Srp6.N != 0
        return int.to_bytes(B, 32, 'little')

    @staticmethod
    def calculate_client_S_key(a:bytes, B:bytes, x:bytes, u:bytes) ->bytes:
        """
        S = (B - (k * (g^x % N)))^(a + u * x) % N
        """
        a = int.from_bytes(a, byteorder='little')
        B = int.from_bytes(B, byteorder='little')
        x = int.from_bytes(x, byteorder='little')
        u = int.from_bytes(u, byteorder='little')
        S = pow((B - Srp6.k * pow(Srp6.g, x, Srp6.N)), (a + u * x), Srp6.N)
        return int.to_bytes(S, 32, 'little')

    @staticmethod
    def calculate_server_S_key(A, v, u, b) -> bytes:
        """
        S = (A * (v^u % N))^b % N,
        """
        A = int.from_bytes(A, byteorder='little')
        v = int.from_bytes(v, byteorder='little')
        u = int.from_bytes(u, byteorder='little')
        b = int.from_bytes(b, byteorder='little')
        S = pow((A * pow(v, u, Srp6.N)), b, Srp6.N)
        return int.to_bytes(S, 32, 'little')

    @staticmethod
    def calculate_u(A:bytes, B:bytes) -> bytes:
        """
        u = SHA1( A | B )
        """
        u = SHA1(A + B).digest()
        return u

    @staticmethod
    def calculate_interleaved(s_key:bytes) -> bytes:
        """
        session key
        """
        while s_key[0] == 0:
            s_key = s_key[2:]
        E = s_key[0::2]
        F = s_key[1::2]
        G = SHA1(E).digest()
        H = SHA1(F).digest()
        K = bytes(x for y in zip(G, H) for x in y)
        return K

    @staticmethod
    def calculate_server_proof(A:bytes, M1:bytes, K:bytes) -> bytes:
        """
        M2 = SHA1(A | M1 | K)
        """
        M2 = SHA1(A + M1 + K).digest()
        return M2

    @staticmethod
    def calculate_xor_hash() -> bytes:
        """
        SHA1(N) XOR SHA1(g)
        """
        x1 = int.to_bytes(Srp6.g, 1, 'little')
        x2 = bytes.fromhex('894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7')[::-1]
        t1 = SHA1(x1).digest()
        t2 = SHA1(x2).digest()
        assert len(t1) == len(t2) == 20
        result = (c_ubyte * 20)()
        for n in range(20):
            result[n] = t1[n] ^ t2[n]
        return bytes(result)

    @staticmethod
    def calculate_client_proof(X:bytes, U:str, K:bytes, A:bytes, B:bytes, s:bytes) -> bytes:
        """
        M1 = SHA1( X | SHA1(U) | s | A | B | K )
        """
        U = SHA1(U.upper().encode()).digest()
        M1 = SHA1(X + U + s + A + B + K).digest()
        return M1

    @staticmethod
    def calculate_client_public_key(a:bytes) -> bytes:
        '''
        A = g^a % N
        '''
        a = int.from_bytes(a, byteorder='little')
        A = pow(Srp6.g, a, Srp6.N)
        assert A % Srp6.N != 0
        return int.to_bytes(A, 32, 'little')

    @staticmethod
    def calculate_reconnect_proof(username:str, client_data:bytes, server_data:bytes, session_key:bytes) -> bytes:
        '''
        SHA1( username | client_data | server_data | session_key )
        '''
        return SHA1(username.upper().encode() + client_data + server_data + session_key).digest()

    @staticmethod
    def encrypt(data:bytes, session_key:bytes) -> bytes:
        '''
        E = (x ^ S) + L
        '''
        index = 0
        last_value = 0
        size = len(data)
        result = (c_ubyte * size)()
        session_key_length = len(session_key)
        for n in range(size):
            unencrypted = data[n]
            encrypted = (unencrypted ^ session_key[index]) + last_value
            index = (index + 1) % session_key_length
            last_value = encrypted
            result[n] = encrypted
        return bytes(result)

    @staticmethod
    def decrypt(data:bytes, session_key:bytes) -> bytes:
        '''
        x = (E - L) ^ S
        '''
        index = 0
        last_value = 0
        size = len(data)
        result = (c_ubyte * size)()
        session_key_length = len(session_key)
        for n in range(size):
            encrypted = data[n]
            unencrypted = (encrypted - last_value) ^ session_key[index]
            index = (index + 1) % session_key_length
            last_value = encrypted
            result[n] = unencrypted
        return bytes(result)

    @staticmethod
    def calculate_world_server_proof(username:str, client_seed:bytes, server_seed:bytes, session_key:bytes) -> bytes:
        '''
        SHA1( username | 0 | client_seed | server_seed | session_key )
        '''
        return SHA1(username.upper().encode() + zero + client_seed + zero + server_seed + session_key).digest()



    # # bytes.fromhex()[::-1] == big -> little
    #
    # # test1
    # h1 = SHA1('test'.encode()).hexdigest()
    # assert h1 == 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3'
    # h2 = SHA1(b'\x53\x51').hexdigest()
    # assert h2 == '0c3d7a19ac7c627290bf031ec3df76277b0f7f75'
    #
    #
    # # test2
    # salt = bytes.fromhex('AFE5D28E925DBB3DAFED5D91ACA0928940E8FBFEF2D2A3CC154ADA0FE6ABEF6F')[::-1]
    # expected = bytes.fromhex('21B4153B0A938D0A69D28F2690CC3F79A99A13C40CACB525B3B79D4201EB33FF')[::-1]
    # #-------------------------
    # U = 'LF2BGFQIFQ3HZ1ZF'
    # p = 'MVRVMUJFWRA0IBVK'
    # s = salt
    # v = calculate_password_verifier(U, p, s)
    # assert v == expected
    #
    #
    # # test3
    # salt = bytes.fromhex('CAC94AF32D817BA64B13F18FDEDEF92AD4ED7EF7AB0E19E9F2AE13C828AEAF57')[::-1]
    # expected = bytes.fromhex('D927E98BE3E9AF84FDC99DE9034F8E70ED7E90D6')[::-1]
    # #-------------------------
    # U = 'USERNAME123'
    # p = 'PASSWORD123'
    # s = salt
    # x = calculate_x(U, p, s)
    # assert expected == x
    #
    #
    # # test4
    # expected = bytes.fromhex('E2F9A0F1E824006C98DA753448E743F7DAA1EAA1')[::-1]
    # #-------------------------
    # U = '00XD0QOSA9L8KMXC'
    # p = '43R4Z35TKBKFW8JI'
    # s = salt
    # x = calculate_x(U, p, s)
    # assert expected == x
    #
    #
    # # test5
    # password_verifier = bytes.fromhex('870A98A3DA8CCAFE6B2F4B0C43A022A0C6CEF4374BA4A50CEBF3FACA60237DC4')[::-1]
    # server_private_key = bytes.fromhex('ACDCB7CB1DE67DB1D5E0A37DAE80068BCCE062AE0EDA0CBEADF560BCDAE6D6B9')[::-1]
    # expected = bytes.fromhex('85A204C987B68764FA69C523E32B940D1E1822B9E0F134FDC5086B1408A2BB43')[::-1]
    # #-------------------------
    # v = password_verifier
    # b = server_private_key
    # B = calculate_server_public_key(v, b)
    # assert expected == B
    #
    #
    # # test6
    # server_public_key = bytes.fromhex('E232D2C71AD1BF58DB9F7DBE51FFE271B6BDC61524F2E6B32ABFFFCAB09D09AB')[::-1]
    # client_private_key = bytes.fromhex('FC3D610C4E2CEC5ECC7E47344D0ED81D2ACB938AB198EC7E2ED474AEFCC3ABD1')[::-1]
    # x = bytes.fromhex('A4A7CB7DFBE00D26EE06F6B3DACC51E5779D7E8B')[::-1]
    # u = bytes.fromhex('FDAFAEF0E77F0FE1BD2956CF1820D4BC964E5283')[::-1]
    # expected = bytes.fromhex('3898DF5193EA6AA8111524A253DB480A51EA6160D1E41BC4B662420299B4A435')[::-1]
    # #-------------------------
    # a = client_private_key
    # B = server_public_key
    # S = calculate_client_S_key(a, B, x, u)
    # assert expected == S
    #
    #
    # # test7
    # client_public_key = bytes.fromhex('51CCDDFACF7F960EDF5030F09F0B033C0D08DB1E43FCBA3A92ABB4BE3535D1DB')[::-1]
    # password_verifier = bytes.fromhex('6FC7D4ACFCFFFDCF780EE9BBD17AE507FFCDF586F83B2C9AEE2198F195DB3AB5')[::-1]
    # u = bytes.fromhex('F9CEDDD82E776BEDB1A94852A9A7FFA4FCADD5DE')[::-1]
    # server_private_key = bytes.fromhex('A5DBBFCB4C7A1B7C3041CAC9DDBD36CD646F9FBABDAD66A019BCBB8FEDF2FAAE')[::-1]
    # expected = bytes.fromhex('3503B289A60D6DD59EBD6FD88DF24836833433E39048ECAFF7E887313554F85C')[::-1]
    # #-------------------------
    # A = client_public_key
    # v = password_verifier
    # b = server_private_key
    # S = calculate_server_S_key(A, v, u, b)
    # assert expected == S
    #
    #
    # # test8
    # client_public_key = bytes.fromhex('6FCEEEE7D40AAF0C7A08DFE1EFD3FCE80A152AA436CECB77FC06DAF9E9E5BDF3')[::-1]
    # server_public_key = bytes.fromhex('F8CD769BDE603FC8F48B9BE7C5BEAAA7BD597ABDBDAC1AEFCACF0EE13443A3B9')[::-1]
    # expected = bytes.fromhex('1309BD7851A1A505B95D6F60A8D884133458D24E')[::-1]
    # #-------------------------
    # A = client_public_key
    # B = server_public_key
    # u = calculate_u(A, B)
    # assert expected == u
    #
    #
    # # test9
    # s_key = bytes.fromhex('8F4CEBD60DFC34E5C007E51BD4F3A4FF2BC1D930E2D3EA770D8D3EEDFF2DCCFC')
    # expected = bytes.fromhex('EE144E1AE08DAC891AB63ABC42BF89738003343422E6B58131BEE4C3087A7027E55A7216D18D556C')
    # #-------------------------
    # session_key = calculate_interleaved(s_key)
    # assert expected == session_key
    #
    #
    # # test10
    # client_public_key = bytes.fromhex('BFD1AC65C8DAAAD88BF9DFF9AF8D1DCDF11DFD0C7E398EDCDF5DBBD08EFB39D3')[::-1]
    # client_proof = bytes.fromhex('7EBBC190D9AB2DC0CD891372CB30DF1ED35CDA1E')[::-1]
    # session_key = bytes.fromhex('9382b5e82c16e1105b8e8e88a99118811d88170fad6e8b35f236dbebbcc9c99bcab6cc9f8fe67648')
    # expected = bytes.fromhex('269E3A3EF5DCD15944F043513BDA20D20FEBA2E0')[::-1]
    # #-------------------------
    # A = client_public_key
    # M1 = client_proof
    # K = session_key
    # M2 = calculate_server_proof(A, M1, K)
    # assert expected == M2
    #
    #
    # # test11
    # #-------------------------
    # X = calculate_xor_hash()
    # assert xorNg == X
    #
    #
    # # test12
    # username = '7WG6SHZL33JMGPO4'
    # session_key = bytes.fromhex('77a4d39cf9c0bf373ef870bd2941c339c575fdd1cbaa31c919ea7bd5023267d303e20fec9a9c402f')
    # client_public_key = bytes.fromhex('0095FE039AFE5E1BADE9AC0CAEC3CB73D2D08BBF4CA8ADDBCDF0CE709ED5103F')[::-1]
    # server_public_key = bytes.fromhex('00B0C41F58CCE894CFB816FA72CA344C9FE2ED7CE799452ADBA7ABDCD26EAE75')[::-1]
    # salt = bytes.fromhex('00a4a09e0b5aca438b8cd837d0816ca26043dbd1eaef138eef72dcf3f696d03d')[::-1]
    # expected = bytes.fromhex('7D07022B4064CCE633D679F61C6B212B6F8BC5C3')[::-1]
    # #-------------------------
    # U = username
    # K = session_key
    # A = client_public_key
    # B = server_public_key
    # s = salt
    # M1 = calculate_client_proof(xorNg, U, K, A, B, s)
    # assert expected == M1
    #
    #
    # # test13
    # client_private_key = bytes.fromhex('A47DD4CD70DA1B0EF7E1FA8C02DE68AF0CEFCC77ACA287FBC3ADCDE0E7B78FE7')[::-1]
    # expected = bytes.fromhex('7186DF27C1A309B5B26E293CD00ADD01E7037E09116089F26E810FD2D962BC42')[::-1]
    # #-------------------------
    # a = client_private_key
    # A = calculate_client_public_key(a)
    # assert expected == A
    #
    #
    # # test14
    # username = 'GXJ8M6VDUAC0JL9W'
    # client_data = bytes.fromhex('DD801B2FBCF4F7ABC6023EFAAF6A9AEA')
    # server_data = bytes.fromhex('0D27763BDEEF92CB273B7BC4EE72D0EC')
    # session_key = bytes.fromhex('6A0E7B35C70C70DA142D57BF49FD25D84CCEE3D21CC1A10AD71323FB34F45F3006D606F1F39A6BB9')
    # expected = bytes.fromhex('D94CE2B08B7FAC0919D7D5419D78CABFA372B6A9')
    # #-------------------------
    # reconnect = calculate_reconnect_proof(username, client_data, server_data, session_key)
    # assert expected == reconnect
    #
    #
    # # test15
    # session_key = bytes.fromhex('2EFEE7B0C177EBBDFF6676C56EFC2339BE9CAD14BF8B54BB5A86FBF81F6D424AA23CC9A3149FB175')
    # data = bytes.fromhex('3d9ae196ef4f5be4df9ea8b9f4dd95fe68fe58b653cf1c2dbeaa0be167db9b27df32fd230f2eab9bd7e9b2f3fbf335d381ca')
    # expected = bytes.fromhex('13777da3d109b912322a08841e3ff5bc92f4e98b77bb03997da999b22ae0b926a3b1e56580314b3932499ee11b9f7deb6915')
    # #-------------------------
    # encrypted_data = encrypt(data, session_key)
    # assert expected == encrypted_data
    #
    #
    # # test16
    # session_key = bytes.fromhex('2EFEE7B0C177EBBDFF6676C56EFC2339BE9CAD14BF8B54BB5A86FBF81F6D424AA23CC9A3149FB175')
    # data = bytes.fromhex('3d9ae196ef4f5be4df9ea8b9f4dd95fe68fe58b653cf1c2dbeaa0be167db9b27df32fd230f2eab9bd7e9b2f3fbf335d381ca')
    # expected = bytes.fromhex('13a3a0059817e73404d97cd455159b50d40af74a22f719aacb6a9a2e991982c61a6f0285f880cc8512ec2ef1c98fa923512f')
    # #-------------------------
    # unencrypted_data = decrypt(data, session_key)
    # assert expected == unencrypted_data
    #
    #
    # # test17
    # username = 'HQO7EWULX09Z4RE4'
    # session_key = bytes.fromhex('77295B4E6745E8833293E07650252D635D5E4B14D2A9DA4FB1AE22FB00131E42C2B2EE7BF0D4D185')[::-1]
    # server_seed = bytes.fromhex('2d0a01e2')
    # client_seed = bytes.fromhex('a2ba5fb2')
    # expected = bytes.fromhex('b26af9256f4bd20f0f11e2c786710542b92115bb')
    # #-------------------------
    # world_server_proof = calculate_world_server_proof(username, client_seed, server_seed, session_key)
    # assert expected == world_server_proof
    #
    #
    #
    # # final test
    # #-------------------------
    # username = 'Mario'
    # password = '5#BB-:*!skTu'
    #
    # # 1. create account, save s and v to database
    # # salt
    # s = os.urandom(32)
    # # password verified
    # v = calculate_password_verifier(username, password, s)
    #
    #
    # # 2. [LogonChallenge] client -> LS: username
    #
    #
    # # 3. [LogonChallenge] LS -> client: B, s, N, g
    # # read s and v from database by username
    # # server private key
    # b = os.urandom(32)
    # # server public key
    # B = calculate_server_public_key(v, b)
    #
    #
    # # 4. [LogonProof] client -> LS: A, M1
    # # client private key
    # a = os.urandom(32)
    # # client public key
    # A = calculate_client_public_key(a)
    # # client S key
    # x = calculate_x(username, password, s)
    # u = calculate_u(A, B)
    # c_S = calculate_client_S_key(a, B, x, u)
    # # client session key
    # c_K = calculate_interleaved(c_S)
    # # client proof
    # c_M1 = calculate_client_proof(xorNg, username, c_K, A, B, s)
    #
    #
    # # 5. [LogonProof] LS -> client: M2
    # # server S key
    # u = calculate_u(A, B)
    # s_S = calculate_server_S_key(A, v, u, b)
    # # server session key
    # s_K = calculate_interleaved(s_S)
    # # check M
    # s_M1 = calculate_client_proof(xorNg, username, s_K, A, B, s)
    # # authenticated
    # assert c_M1 == s_M1
    # # server proof
    # s_M2 = calculate_server_proof(A, s_M1, s_K)
    #
    #
    # # 6. [RealmList] ...
    # c_M2 = calculate_server_proof(A, c_M1, c_K)
    # # authenticated
    # assert c_M2 == s_M2
    #
    #
    # # 7. [ReconnectChallenge] client -> LS: username
    #
    #
    # # 8. [ReconnectChallenge] LS -> client: server_data
    # # checks for an existing session with the username
    # server_data = os.urandom(16)
    #
    #
    # # 9. [ReconnectProof] client -> LS: client_data, client_proof
    # client_data = os.urandom(16)
    # client_proof = calculate_reconnect_proof(username, client_data, server_data, c_K)
    #
    #
    # # 10. [ReconnectProof] ...
    # server_proof = calculate_reconnect_proof(username, client_data, server_data, s_K)
    # # authenticated
    # assert server_proof == client_proof
    #
    #
    # # 11. client connects to the WS
    #
    #
    # # 12. [AuthChallenge] WS -> client: server_seed
    # server_seed = os.urandom(4)
    #
    #
    # # 13. [AuthSession] client -> server: client_seed, client_auth
    # client_seed = os.urandom(4)
    # client_auth = calculate_world_server_proof(username, client_seed, server_seed, c_K)
    #
    #
    # # 14. [AuthSession] server -> client: encrypt_msg
    # server_auth = calculate_world_server_proof(username, client_seed, server_seed, s_K)
    # # authenticated
    # assert client_auth == server_auth
    # # send data
    # server_msg = 'WeLcOmE oNbOaRd'.encode()
    # encrypt_msg = encrypt(server_msg, s_K)
    #
    #
    # # 15. [SessionMsg] client
    # client_msg = decrypt(encrypt_msg, c_K)
    # # verify
    # assert server_msg == client_msg