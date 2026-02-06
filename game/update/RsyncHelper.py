import hashlib
import io
import os
from dataclasses import dataclass
from enum import IntEnum
from typing import Optional

from utils.ConfigManager import config
from utils.Logger import Logger
from utils.PathManager import PathManager


@dataclass(frozen=True)
class RsyncDeltaPlan:
    basis_size: int
    basis_signature: bytes
    target_size: int
    target_flag: int
    delta_blocks: list[bytes]

class RsyncBackend(IntEnum):
    LIBRSYNC = 0


# TODO: Rsync deltas require a third-party helper like (librsync) plus native dependencies,
#  which would make deployment/setup more complicated, for now, we only support full file patching.
class RsyncHelper:
    def __init__(self, enabled: bool, base_dir: str):
        self.enabled = enabled
        self.base_dir = base_dir
        self._backend = None
        self._backend_error = None

    @classmethod
    def from_config(cls):
        enabled = config.Patcher.rsync_enabled
        base_dir = PathManager.get_patches_rsync_basis_path()
        return cls(enabled, base_dir)

    def can_build_delta(self) -> bool:
        return self.enabled and self._ensure_backend() is not None

    def build_delta(self, path: str, target_bytes: bytes, requested_md5_hex: str) -> Optional[RsyncDeltaPlan]:
        if not self.can_build_delta():
            return None
        basis_path = self._resolve_basis_path(requested_md5_hex)
        if not basis_path:
            Logger.debug(f'[UpdateServer] Rsync basis not found for {requested_md5_hex} ({path})')
            return None

        backend = self._ensure_backend()
        if backend is None:
            return None

        try:
            with open(basis_path, 'rb') as handle:
                basis_bytes = handle.read()
        except OSError as exc:
            Logger.warning(f'[UpdateServer] Rsync basis read failed for {path} ({exc})')
            return None

        delta_bytes = self._build_delta_bytes(backend, basis_bytes, target_bytes)
        if not delta_bytes:
            Logger.warning(f'[UpdateServer] Rsync delta empty for {path}')
            return None

        basis_size = len(basis_bytes)
        basis_signature = hashlib.md5(basis_bytes).digest()
        target_size = len(target_bytes)
        target_flag = 0

        delta_blocks = self._split_blocks(delta_bytes, 0x1000)

        return RsyncDeltaPlan(
            basis_size=basis_size,
            basis_signature=basis_signature,
            target_size=target_size,
            target_flag=target_flag,
            delta_blocks=delta_blocks,
        )

    def _resolve_basis_path(self, requested_md5_hex: str) -> Optional[str]:
        if not self.base_dir or not requested_md5_hex:
            return None
        candidate = os.path.join(self.base_dir, requested_md5_hex.lower())
        return candidate if os.path.exists(candidate) else None

    def _ensure_backend(self):
        if self._backend is not None or self._backend_error is not None:
            return self._backend
        try:
            import librsync  # type: ignore
            self._backend = (RsyncBackend.LIBRSYNC, librsync)
            return self._backend
        except Exception as exc:
            self._backend_error = exc
            Logger.warning('[UpdateServer] Rsync enabled but python librsync module not available')
            return None

    @staticmethod
    def _build_delta_bytes(backend, basis_bytes: bytes, target_bytes: bytes) -> bytes | None:
        backend_type, module = backend
        if backend_type == RsyncBackend.LIBRSYNC:
            return RsyncHelper._delta_with_librsync(module, basis_bytes, target_bytes)
        return None

    @staticmethod
    def _delta_with_librsync(module, basis_bytes: bytes, target_bytes: bytes) -> bytes | None:
        signature = None
        for basis in (basis_bytes, io.BytesIO(basis_bytes)):
            try:
                signature = module.signature(basis)
                break
            except TypeError:
                continue
        if signature is None:
            return None

        delta = None
        for target in (target_bytes, io.BytesIO(target_bytes)):
            try:
                delta = module.delta(target, signature)
                break
            except TypeError:
                continue
        if delta is None:
            return None
        return bytes(delta) if not isinstance(delta, (bytes, bytearray)) else delta

    @staticmethod
    def _split_blocks(data: bytes, size: int) -> list[bytes]:
        return [data[i:i + size] for i in range(0, len(data), size)]
