import socket
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger

MAX_PACKET_BYTES = 4096


class LoginSessionStateHandler:
    def __init__(self, client_socket, client_address):
        self.client_socket = client_socket
        self.client_address = client_address

        self.keep_alive = False

    def handle(self):
        try:
            self.keep_alive = True
            self.client_socket.settimeout(120)  # 2 minutes timeout should be more than enough.

            while self.receive(self.client_socket) != -1 and self.keep_alive:
                continue

        finally:
            self.disconnect()

    def receive(self, sck):
        try:
            reader = self.receive_client_message(sck)
            if reader and self.keep_alive and reader.opcode:
                return self.process_incoming(reader)
            else:
                return -1
        except (socket.timeout, OSError, ConnectionResetError, ValueError):
            self.disconnect()
            return -1

    def process_incoming(self, reader):
        from game.world.opcode_handling.Definitions import Definitions
        res = -1
        try:
            handler, found = Definitions.get_handler_from_packet(self, reader.opcode)
            if handler:
                res = handler(self, reader)
                if res == 0:
                    Logger.debug(f'[{self.client_address[0]}] Handling {reader.opcode_str()}')
                elif res == 1:
                    Logger.debug(f'[{self.client_address[0]}] Ignoring {reader.opcode_str()}')
                elif res < 0:
                    Logger.warning(f'[{self.client_address[0]}] Handling {reader.opcode_str()} failed.')
                    res = -1
            elif not found:
                Logger.warning(f'[{self.client_address[0]}] Received unknown data: {reader.data}')
        except:
            pass

        return res

    def receive_client_message(self, sck):
        header_bytes = self.receive_all(sck, 6)  # 6 = header size
        if not header_bytes:
            return None

        reader = PacketReader(header_bytes)
        reader.data = self.receive_all(sck, int(reader.size))
        return reader

    def receive_all(self, sck, expected_size):
        # Prevent wrong size because of malformed packets.
        if expected_size <= 0:
            return b''

        # Try to fill at once.
        received = sck.recv(expected_size)
        if not received:
            return b''

        # We got what we expect, return buffer.
        if received == expected_size:
            return received

        # If we got incomplete data, request missing payload.
        buffer = bytearray(received)
        current_buffer_size = len(buffer)
        while current_buffer_size < expected_size:
            received = sck.recv(expected_size - current_buffer_size)
            if not received:
                return b''
            buffer.extend(received)  # Keep appending to our buffer until we're done.
            current_buffer_size = len(buffer)
            # Avoid handling any packet that's above the maximum packet size.
            if current_buffer_size > MAX_PACKET_BYTES:
                return b''
        return buffer

    def disconnect(self):
        try:
            self.client_socket.shutdown(socket.SHUT_RDWR)
            self.client_socket.close()
        except OSError:
            pass
