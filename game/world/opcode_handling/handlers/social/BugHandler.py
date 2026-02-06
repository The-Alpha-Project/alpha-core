from database.realm.RealmDatabaseManager import *
from network.packet.PacketReader import *


class BugHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty bug packet.
            if not world_session.account_mgr or not world_session.player_mgr:
                return 0

            report_type = unpack('<I', reader.data[:4])[0]
            report_len = unpack('<I', reader.data[4:8])[0]
            offset = 8
            if len(reader.data) < offset + report_len + 4:
                return 0

            report_bytes = reader.data[offset:offset + report_len]
            offset += report_len
            category_len = unpack('<I', reader.data[offset:offset + 4])[0]
            offset += 4
            if len(reader.data) < offset + category_len:
                return 0

            category_bytes = reader.data[offset:offset + category_len]

            report_text = report_bytes.split(b'\x00', 1)[0].decode('latin1', errors='ignore')
            category_text = category_bytes.split(b'\x00', 1)[0].decode('latin1', errors='ignore')

            marker = 'Username:'
            marker_index = report_text.find(marker)
            if marker_index != -1:
                report_text = report_text[:marker_index]
            report_text = report_text.strip()

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
