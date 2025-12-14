from database.realm.RealmDatabaseManager import *
from network.packet.PacketReader import *


class BugHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty bug packet.
            if not world_session.account_mgr or not world_session.player_mgr:
                return 0

            is_bug = unpack('<I', reader.data[:4])[0] == 0
            full_body = PacketReader.read_string(reader.data, 8)
            # This packet is even sending the password in plain text, so we don't want that, we only care about the text
            body = full_body[:full_body.index('Username:')].strip()

            RealmDatabaseManager.ticket_add(Ticket(
                is_bug=is_bug,
                account_name=world_session.account_mgr.account.name,
                account_id=world_session.account_mgr.account.id,
                realm_id=config.Server.Connection.Realm.local_realm_id,
                character_name=world_session.player_mgr.get_name(),
                text_body=body
            ))

        return 0
