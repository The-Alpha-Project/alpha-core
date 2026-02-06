import hashlib
import os
import socket
from dataclasses import dataclass
from struct import pack, unpack_from

from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.UpdateServerCodes import UpdateServerOpCode
from game.update.RsyncHelper import RsyncHelper, RsyncDeltaPlan
from utils.PathManager import PathManager

MAX_PACKET_BYTES = 4096
PATCH_FILESET = 'base'
EXPECTED_SIGNATURE_MAGIC = 0xB11224F0
EXPECTED_SIGNATURE_VERSION = 0x00000069


@dataclass(frozen=True)
class UpdateFileEntry:
    content: bytes
    no_zlib: bool = False


class UpdateSessionStateHandler:
    def __init__(self, client_socket, client_address):
        self.client_socket = client_socket
        self.client_address = client_address
        self.keep_alive = False
        self.current_fileset = None
        self.update_server_enabled = config.Patcher.update_server_enabled
        self.rsync_helper = RsyncHelper.from_config()
        self.file_catalog = self._load_patch_catalog() if self.update_server_enabled else {}
        self.fileset_signatures = {PATCH_FILESET: self._build_fileset_signature(self.file_catalog)}

    def handle(self):
        try:
            self.keep_alive = True
            if not self.update_server_enabled:
                Logger.debug(f'[UpdateServer] Disabled, closing connection from {self.client_address}')
                return
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

                Logger.debug(f'[UpdateServer] Handling {self._opcode_label(opcode)} client {self.client_address}')

                if not handshake_done:
                    if opcode != UpdateServerOpCode.CLIENT_HELLO:
                        Logger.warning(f'[UpdateServer] Unexpected opcode {self._opcode_label(opcode)} from {self.client_address}')
                        break

                    # Accept handshake (non-zero byte) so the client proceeds to the signature packet.
                    self._send_packet(bytes([UpdateServerOpCode.SERVER_HELLO_ACK, 1]))

                    sig_packet = self._recv_packet()
                    if sig_packet:
                        if not self._parse_signature_packet(sig_packet):
                            break

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
                elif opcode == UpdateServerOpCode.CLIENT_REQUEST_FILE_MD5:
                    path, offset = self._read_cstring(packet, 1)
                    if path:
                        requested_md5 = None
                        if len(packet) >= offset + 16:
                            requested_md5 = packet[offset:offset + 16].hex()
                        if self._handle_md5_request(path, requested_md5):
                            continue
                        self._send_file(path)
                elif opcode == UpdateServerOpCode.CLIENT_REQUEST_FILE:
                    path, _ = self._read_cstring(packet, 1)
                    if path:
                        self._send_file(path)
                else:
                    Logger.debug(f'[UpdateServer] Ignoring opcode {self._opcode_label(opcode)}')
        except (ConnectionResetError, OSError) as exc:
            Logger.debug(f'[UpdateServer] Session error from {self.client_address} ({exc})')
        finally:
            self.disconnect()

    def _recv_packet(self):
        size = self._recv_frame_size()
        if size is None:
            return None
        if size == 0:
            Logger.debug(f'[UpdateServer] Connection closed by {self.client_address}')
            return b''
        if size <= 0:
            return b''
        if size > MAX_PACKET_BYTES:
            Logger.warning(f'[UpdateServer] Frame size {size} exceeds limit from {self.client_address}')
            return b''
        payload = self._recv_exact(size)
        if payload is None:
            return None
        return payload

    def _send_packet(self, payload: bytes) -> None:
        size = len(payload)
        header = self._build_frame_header(size)
        try:
            self.client_socket.sendall(header + payload)
        except (ConnectionResetError, OSError) as exc:
            Logger.debug(f'[UpdateServer] Send failed to {self.client_address} ({exc})')
            self.keep_alive = False

    def _recv_exact(self, size: int):
        data = bytearray()
        while len(data) < size:
            try:
                chunk = self.client_socket.recv(size - len(data))
            except socket.timeout:
                return None
            except (ConnectionResetError, OSError):
                return b''
            if not chunk:
                if data:
                    Logger.debug(f'[UpdateServer] Connection closed mid-packet by {self.client_address}')
                return b''  # Don't return partial packets.
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

    def _parse_signature_packet(self, payload: bytes) -> bool:
        if not payload:
            return False
        offset = 0
        if len(payload) >= 9:
            magic, version = unpack_from('<2I', payload, 0)
            if magic == EXPECTED_SIGNATURE_MAGIC:
                offset = 8
                flags = payload[offset]
                offset += 1
            else:
                magic = version = flags = None
        else:
            magic = version = flags = None

        if magic is None:
            if payload[0] != 0x69 or len(payload) < 9:
                Logger.warning(f'[UpdateServer] Signature packet opcode {self._opcode_label(payload[0])}, expected 0x69 or magic')
                return False
            magic, version = unpack_from('<2I', payload, 1)
            flags = payload[9]
            offset = 10

        if magic != EXPECTED_SIGNATURE_MAGIC or version != EXPECTED_SIGNATURE_VERSION:
            Logger.warning(f'[UpdateServer] Signature mismatch magic={magic:#010x} version={version:#010x} from {self.client_address}')
            return False

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

        return True

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
        full_files = []
        flagged_files = []
        for path, content, no_zlib in self._iter_file_entries():
            if no_zlib:
                flagged_files.append((path, content))
            else:
                full_files.append((path, content))

        file_list = bytearray()
        file_list.append(UpdateServerOpCode.SERVER_FILELIST)
        file_list += pack('<I', len(full_files) + len(flagged_files))  # total file count
        file_list += self._pack_cstring(PATCH_FILESET)
        file_list += pack('<I', len(full_files))  # full files.
        for path, content in full_files:
            md5_digest = hashlib.md5(content).digest()
            file_size = len(content)
            file_list += self._pack_cstring(path)
            file_list += md5_digest
            file_list += pack('<I', file_size)
        file_list += pack('<I', len(flagged_files))  # flagged files.
        for path, content in flagged_files:
            md5_digest = hashlib.md5(content).digest()
            file_size = len(content)
            file_list += self._pack_cstring(path)
            file_list += md5_digest
            file_list += pack('<I', file_size)
            file_list += pack('<B', 1)  # Disable downloadZSt for this file.
        file_list += pack('<I', 0)  # moves
        self._send_packet(bytes(file_list))

    def _send_file(self, path: str) -> None:
        content, no_zlib = self._get_file_entry(path)
        if content is None:
            Logger.warning(f'[UpdateServer] Missing content for {path}, sending error')
            self._send_packet(bytes([UpdateServerOpCode.SERVER_ERROR]))
            return
        file_size = len(content)

        request = bytearray()
        request.append(UpdateServerOpCode.SERVER_FILE_REQUEST)
        request += self._pack_cstring(path)
        request += pack('<I', file_size)
        request += pack('<B', 1 if no_zlib else 0)
        self._send_packet(bytes(request))

        if content:
            self._send_packet(bytes([UpdateServerOpCode.SERVER_FILE_DATA]) + content)
        self._send_packet(bytes([UpdateServerOpCode.SERVER_FILE_FINALIZE]))

    def _handle_md5_request(self, path: str, requested_md5: str | None) -> bool:
        if not requested_md5:
            return False
        content, _ = self._get_file_entry(path)
        if content is None:
            return False

        server_md5 = hashlib.md5(content).hexdigest()
        if server_md5 == requested_md5:
            self._send_packet(bytes([UpdateServerOpCode.SERVER_READY]))
            return True

        delta_plan = self._try_build_delta(path, content, requested_md5)
        if delta_plan:
            self._send_rsync_delta(path, delta_plan)
            return True

        return False

    def _try_build_delta(self, path: str, content: bytes, requested_md5: str) -> RsyncDeltaPlan | None:
        if not self.rsync_helper.enabled:
            return None
        if not self.rsync_helper.can_build_delta():
            Logger.warning('[UpdateServer] Rsync enabled but helper not available')
            return None
        return self.rsync_helper.build_delta(path, content, requested_md5)

    def _send_rsync_delta(self, path: str, plan: RsyncDeltaPlan) -> None:
        meta_payload = bytearray()
        meta_payload.append(UpdateServerOpCode.SERVER_RSYNC_META)
        meta_payload += pack('<I', plan.basis_size)
        meta_payload += plan.basis_signature
        self._send_packet(bytes(meta_payload))

        delta_header = bytearray()
        delta_header.append(UpdateServerOpCode.SERVER_RSYNC_DELTA)
        delta_header += self._pack_cstring(path)
        delta_header += pack('<I', plan.target_size)
        delta_header += pack('<B', plan.target_flag)
        self._send_packet(bytes(delta_header))

        for block in plan.delta_blocks:
            self._send_packet(bytes([UpdateServerOpCode.SERVER_DELTA_BLOCK]) + block)
        self._send_packet(bytes([UpdateServerOpCode.SERVER_FILE_FINALIZE]))

    def _get_file_entry(self, path: str) -> tuple[bytes | None, bool]:
        entry = self.file_catalog.get(path)
        if entry is not None:
            if isinstance(entry, UpdateFileEntry):
                return entry.content, entry.no_zlib
            return entry, self._infer_no_zlib(path)
        sig_prefix = 'version-'
        sig_suffix = '.sig'
        if path.startswith(sig_prefix) and path.endswith(sig_suffix):
            fileset = path[len(sig_prefix):-len(sig_suffix)]
            return self._get_fileset_signature(fileset), False
        return None, False

    def _get_fileset_signature(self, fileset: str) -> bytes:
        signature = self.fileset_signatures.get(fileset)
        if signature is None:
            signature = hashlib.md5(fileset.encode('ascii', errors='ignore')).digest()
        return signature

    @staticmethod
    def _build_fileset_signature(file_catalog: dict[str, UpdateFileEntry | bytes]) -> bytes:
        hasher = hashlib.md5()
        for path, entry in sorted(file_catalog.items()):
            content, _ = UpdateSessionStateHandler._unpack_entry(entry)
            hasher.update(path.encode('ascii', errors='ignore'))
            hasher.update(b'\x00')
            hasher.update(content)
        return hasher.digest()

    @staticmethod
    def _unpack_entry(entry: UpdateFileEntry | bytes) -> tuple[bytes, bool]:
        if isinstance(entry, UpdateFileEntry):
            return entry.content, entry.no_zlib
        return entry, False

    @staticmethod
    def _infer_no_zlib(path: str) -> bool:
        lower_path = path.lower()
        return lower_path.endswith(('.exe', '.dll', '.mpq', '.zip', '.7z', '.rar'))

    def _iter_file_entries(self):
        for path, entry in self.file_catalog.items():
            if isinstance(entry, UpdateFileEntry):
                content, no_zlib = entry.content, entry.no_zlib
            else:
                content, no_zlib = entry, self._infer_no_zlib(path)
            yield path, content, no_zlib

    @staticmethod
    def _pack_cstring(value: str) -> bytes:
        return value.encode('ascii') + b'\x00'

    @staticmethod
    def _opcode_label(opcode: int) -> str:
        try:
            name = UpdateServerOpCode(opcode).name
            return f'{name}'
        except ValueError:
            return f'{opcode:#04x}'

    def disconnect(self):
        try:
            self.client_socket.shutdown(socket.SHUT_RDWR)
            self.client_socket.close()
            Logger.debug(f'[UpdateServer] Disconnected {self.client_address}')
        except OSError:
            pass

    @staticmethod
    def _load_patch_catalog() -> dict[str, UpdateFileEntry | bytes]:
        patch_root = PathManager.get_patches_path()
        file_catalog: dict[str, UpdateFileEntry | bytes] = {}
        if not os.path.isdir(patch_root):
            Logger.debug(f'[UpdateServer] Patch directory not found: {patch_root}')
            return file_catalog

        for root, _, files in os.walk(patch_root):
            for filename in files:
                if filename == '.nomedia':
                    continue
                absolute_path = os.path.join(root, filename)
                relative_path = os.path.relpath(absolute_path, patch_root)
                if relative_path.startswith('rsync_basis' + os.sep):
                    continue
                patch_path = relative_path.replace(os.sep, '/')
                try:
                    with open(absolute_path, 'rb') as handle:
                        content = handle.read()
                except OSError as exc:
                    Logger.warning(f'[UpdateServer] Failed to read patch file {absolute_path} ({exc})')
                    continue
                # UpdateServer does not compress payloads; mark all patch files as no-zlib to
                # prevent the client from expecting downloadZSt (compressed) streams.
                file_catalog[patch_path] = UpdateFileEntry(content, no_zlib=True)

        return file_catalog
