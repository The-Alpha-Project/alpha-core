import time
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from database.realm.RealmDatabaseManager import *
from network.packet.PacketReader import *


# Every report is a database row written on the session thread, a client in a loop must not fill the table.
MAX_REPORT_TEXT_LENGTH = 2000  # The client form holds far less.
MIN_SECONDS_BETWEEN_REPORTS = 10


class BugHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty bug packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        if not world_session.account_mgr or not world_session.player_mgr:
            return 0

        now = time.time()
        if now - world_session.last_bug_report_at < MIN_SECONDS_BETWEEN_REPORTS:
            return 0
        world_session.last_bug_report_at = now

        report_type = unpack('<I', reader.data[:4])[0]
        report_len = unpack('<I', reader.data[4:8])[0]
        offset = 8
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=offset + report_len + 4):
            return 0

        report_bytes = reader.data[offset:offset + report_len]
        offset += report_len
        category_len = unpack('<I', reader.data[offset:offset + 4])[0]
        offset += 4
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=offset + category_len):
            return 0

        category_bytes = reader.data[offset:offset + category_len]

        report_text = report_bytes.split(b'\x00', 1)[0].decode('latin1', errors='ignore')
        category_text = category_bytes.split(b'\x00', 1)[0].decode('latin1', errors='ignore')

        marker = 'Username:'
        marker_index = report_text.find(marker)
        if marker_index != -1:
            report_text = report_text[:marker_index]
        report_text = report_text.strip()[:MAX_REPORT_TEXT_LENGTH]

        if category_text:
            report_text = f'[{category_text}] {report_text}'

        RealmDatabaseManager.ticket_add(Ticket(
            is_bug=report_type == 0,
            account_name=world_session.account_mgr.account.name,
            account_id=world_session.account_mgr.account.id,
            realm_id=config.Server.Connection.Realm.local_realm_id,
            character_name=world_session.player_mgr.get_name(),
            text_body=report_text
        ))

        return 0
