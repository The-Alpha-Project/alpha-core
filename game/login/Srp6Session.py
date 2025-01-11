class Srp6Session:
    def __init__(self, server_public_key, server_private_key):
        self.server_public_key: bytes = server_public_key
        self.server_private_key: bytes = server_private_key
