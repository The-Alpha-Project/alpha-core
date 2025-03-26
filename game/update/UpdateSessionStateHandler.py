import socket

MAX_PACKET_BYTES = 4096


class UpdateSessionStateHandler:
    def __init__(self, client_socket, client_address):
        self.client_socket = client_socket
        self.client_address = client_address

    # TODO: UpdateServer seems to use some kind of RSYNC protocol for file patching.
    def handle(self):
        self.disconnect()

    def disconnect(self):
        try:
            self.client_socket.shutdown(socket.SHUT_RDWR)
            self.client_socket.close()
        except OSError:
            pass
