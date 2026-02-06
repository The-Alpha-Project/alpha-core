from enum import IntEnum


class UpdateServerOpCode(IntEnum):
    SERVER_FILELIST = 0x00
    # Inferred from WoW.exe.c (Rsy/rsync update client). Payloads are CDataStore frames.
    SERVER_READY = 0x07
    SERVER_RSYNC_META = 0x08
    SERVER_RSYNC_DELTA = 0x09
    SERVER_ERROR = 0x0A
    SERVER_FILE_DATA = 0x0B
    SERVER_FILE_FINALIZE = 0x0C
    SERVER_DELTA_BLOCK = 0x10
    SERVER_FILE_REQUEST = 0x11
    SERVER_END = 0x13

    CLIENT_REQUEST_FILE_MD5 = 0x02
    CLIENT_REQUEST_FILE = 0x06
    CLIENT_SET_FILESET = 0x12
    CLIENT_HELLO = 0x14
    CLIENT_SIGNATURE = 0xF0
    CLIENT_SIGNATURE_LEGACY = 0x69
    SERVER_HELLO = 0x15
    SERVER_HELLO_ACK = 0x14  # Server reply to CLIENT_HELLO (single non-zero byte to accept).
