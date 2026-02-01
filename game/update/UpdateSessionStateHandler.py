import hashlib
import socket
from struct import pack, unpack_from

from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.UpdateServerCodes import UpdateServerOpCode

MAX_PACKET_BYTES = 4096
PATCH_FILE_PATH = 'realmlist.wtf'
DEFAULT_PATCH_REALMLIST = b'set realmlist 127.0.0.1'
PATCH_FILESET = 'base'


class UpdateSessionStateHandler:
    def __init__(self, client_socket, client_address):
        self.client_socket = client_socket
        self.client_address = client_address
        self.keep_alive = False
        self.current_fileset = None
        patch_client_realmlist = config.Patcher.patch_client_realmlist
        if patch_client_realmlist is None:
            realmlist_bytes = DEFAULT_PATCH_REALMLIST
        else:
            realmlist_bytes = patch_client_realmlist.encode('ascii', errors='replace')
        self.file_catalog = {PATCH_FILE_PATH: realmlist_bytes}
        self.fileset_signatures = {PATCH_FILESET: self._build_fileset_signature(self.file_catalog)}

    def handle(self):
        try:
            self.keep_alive = True
            self.client_socket.settimeout(30)
            self._send_packet(bytes([UpdateServerOpCode.SERVER_HELLO]) + pack('<I', 0))

            handshake_done = False
            while self.keep_alive:
                packet = self._recv_packet()
                if packet is None:
                    continue
                if not packet:
                    break
                opcode = packet[0]

                if not handshake_done:
                    if opcode != UpdateServerOpCode.CLIENT_HELLO:
                        Logger.warning(f'UpdateServer: unexpected opcode {opcode:#04x} from {self.client_address}')
                        continue

                    # Accept handshake (non-zero byte) so the client proceeds to the signature packet.
                    self._send_packet(bytes([UpdateServerOpCode.SERVER_HELLO_ACK, 1]))

                    sig_packet = self._recv_packet()
                    if sig_packet:
                        self._parse_signature_packet(sig_packet)

                    self._send_file_list()
                    handshake_done = True
                    continue

                if opcode == UpdateServerOpCode.CLIENT_HELLO:
                    self._send_packet(bytes([UpdateServerOpCode.SERVER_HELLO_ACK, 1]))
                    self._send_file_list()
                elif opcode == UpdateServerOpCode.CLIENT_SET_FILESET:
                    fileset, _ = self._read_cstring(packet, 1)
                    if fileset:
                        self.current_fileset = fileset
                        Logger.debug(f'UpdateServer: client fileset set to {fileset}')
                elif opcode == UpdateServerOpCode.CLIENT_REQUEST_FILE_MD5:
                    path, offset = self._read_cstring(packet, 1)
                    if path:
                        requested_md5 = None
                        if len(packet) >= offset + 16:
                            requested_md5 = packet[offset:offset + 16].hex()
                        Logger.debug(f'UpdateServer: client requested {path} md5={requested_md5}')
                        self._send_file(path)
                elif opcode == UpdateServerOpCode.CLIENT_REQUEST_FILE:
                    path, _ = self._read_cstring(packet, 1)
                    if path:
                        Logger.debug(f'UpdateServer: client requested {path}')
                        self._send_file(path)
                else:
                    Logger.debug(f'UpdateServer: ignoring opcode {opcode:#04x} ({len(packet)} bytes)')
        finally:
            self.disconnect()

    def _recv_packet(self):
        size = self._recv_frame_size()
        if size is None:
            return None
        if size == 0:
            Logger.debug(f'UpdateServer: connection closed by {self.client_address}')
            return b''
        if size <= 0:
            return b''
        payload = self._recv_exact(size)
        if payload is None:
            return None
        if payload:
            Logger.debug(f'UpdateServer: recv opcode {payload[0]:#04x} size={len(payload)}')
        return payload

    def _send_packet(self, payload: bytes) -> None:
        size = len(payload)
        if payload:
            Logger.debug(f'UpdateServer: send opcode {payload[0]:#04x} size={size}')
        header = self._build_frame_header(size)
        self.client_socket.sendall(header + payload)

    def _recv_exact(self, size: int):
        data = bytearray()
        while len(data) < size:
            try:
                chunk = self.client_socket.recv(size - len(data))
            except socket.timeout:
                return None
            if not chunk:
                if data:
                    Logger.debug(f'UpdateServer: connection closed mid-packet by {self.client_address}')
                break
            data.extend(chunk)
        return bytes(data)

    def _recv_frame_size(self) -> int | None:
        header = self._recv_exact(1)
        if header is None:
            return None
        if not header:
            return 0
        first = header[0]
        if first & 0x80:
            # 3-byte size header: high 7 bits in first byte + next two bytes.
            extra = self._recv_exact(2)
            if extra is None:
                return None
            if len(extra) != 2:
                return 0
            return ((first & 0x7F) << 16) | (extra[0] << 8) | extra[1]
        # 2-byte size header.
        extra = self._recv_exact(1)
        if extra is None:
            return None
        if len(extra) != 1:
            return 0
        return (first << 8) | extra[0]

    @staticmethod
    def _build_frame_header(size: int) -> bytes:
        # CDataStore framing: 2 bytes for < 0x8000, otherwise 3 bytes with 0x80 flag set.
        if size < 0x8000:
            return bytes([(size >> 8) & 0xFF, size & 0xFF])
        return bytes([((size >> 16) & 0x7F) | 0x80, (size >> 8) & 0xFF, size & 0xFF])

    def _parse_signature_packet(self, payload: bytes) -> None:
        if not payload:
            return
        offset = 0
        if len(payload) >= 9:
            magic, version = unpack_from('<2I', payload, 0)
            if magic == 0xB11224F0:
                offset = 8
                flags = payload[offset]
                offset += 1
            else:
                magic = version = flags = None
        else:
            magic = version = flags = None

        if magic is None:
            if payload[0] != 0x69 or len(payload) < 9:
                Logger.debug(f'UpdateServer: signature packet opcode {payload[0]:#04x}, expected 0x69 or magic')
                return
            magic, version = unpack_from('<2I', payload, 1)
            flags = payload[9]
            offset = 10

        signatures = []
        for _ in range(4):
            name, offset = self._read_cstring(payload, offset)
            if name is None:
                break
            if len(payload) < offset + 16:
                break
            sig = payload[offset:offset + 16]
            offset += 16
            signatures.append((name, sig.hex()))

        Logger.info(f'UpdateServer: client sig magic={magic:#010x} version={version:#010x} flags={flags:#04x}')
        for name, sig in signatures:
            Logger.info(f'UpdateServer: sig {name}={sig}')

    @staticmethod
    def _read_cstring(payload: bytes, offset: int):
        if offset >= len(payload):
            return None, offset
        end = payload.find(b'\x00', offset)
        if end == -1:
            return None, offset
        raw = payload[offset:end]
        try:
            value = raw.decode('ascii')
        except UnicodeDecodeError:
            value = raw.decode('ascii', errors='replace')
        return value, end + 1

    def _send_file_list(self) -> None:
        file_items = list(self.file_catalog.items())

        file_list = bytearray()
        file_list.append(UpdateServerOpCode.SERVER_FILELIST)
        file_list += pack('<I', len(file_items))  # total file count
        file_list += self._pack_cstring(PATCH_FILESET)
        file_list += pack('<I', len(file_items))  # full files
        for path, content in file_items:
            md5_digest = hashlib.md5(content).digest()
            file_size = len(content)
            file_list += self._pack_cstring(path)
            file_list += md5_digest
            file_list += pack('<I', file_size)
        file_list += pack('<I', 0)  # flagged files
        file_list += pack('<I', 0)  # moves
        self._send_packet(bytes(file_list))

    def _send_file(self, path: str) -> None:
        content = self._get_file_content(path)
        if content is None:
            Logger.warning(f'UpdateServer: missing content for {path}, sending empty file')
            content = b''
        file_size = len(content)

        request = bytearray()
        request.append(UpdateServerOpCode.SERVER_FILE_REQUEST)
        request += self._pack_cstring(path)
        request += pack('<I', file_size)
        request += pack('<B', 0)  # uncompressed
        self._send_packet(bytes(request))

        if content:
            self._send_packet(bytes([UpdateServerOpCode.SERVER_FILE_DATA]) + content)
        self._send_packet(bytes([UpdateServerOpCode.SERVER_FILE_FINALIZE]))

    def _get_file_content(self, path: str) -> bytes | None:
        content = self.file_catalog.get(path)
        if content is not None:
            return content
        sig_prefix = 'version-'
        sig_suffix = '.sig'
        if path.startswith(sig_prefix) and path.endswith(sig_suffix):
            fileset = path[len(sig_prefix):-len(sig_suffix)]
            return self._get_fileset_signature(fileset)
        return None

    def _get_fileset_signature(self, fileset: str) -> bytes:
        signature = self.fileset_signatures.get(fileset)
        if signature is None:
            signature = hashlib.md5(fileset.encode('ascii', errors='ignore')).digest()
        return signature

    @staticmethod
    def _build_fileset_signature(file_catalog: dict[str, bytes]) -> bytes:
        hasher = hashlib.md5()
        for path, content in sorted(file_catalog.items()):
            hasher.update(path.encode('ascii', errors='ignore'))
            hasher.update(b'\x00')
            hasher.update(content)
        return hasher.digest()

    @staticmethod
    def _pack_cstring(value: str) -> bytes:
        return value.encode('ascii') + b'\x00'

    def disconnect(self):
        try:
            self.client_socket.shutdown(socket.SHUT_RDWR)
            self.client_socket.close()
            Logger.debug(f'UpdateServer: disconnected {self.client_address}')
        except OSError:
            pass
