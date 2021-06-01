from database.realm.RealmDatabaseManager import *
from network.packet.PacketReader import *
from utils.Logger import Logger


class BugHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty bug packet.
            # Content is limited to 4096 bytes, if trimmed by the client, data will come malformed.
            try:
                is_bug = unpack('<I', reader.data[:4])[0] == 0
                full_body = PacketReader.read_string(reader.data, 8)
                # This packet is even sending the password in plain text, so we don't want that, we only care about the text
                body = full_body[:full_body.index('Username:')].strip()

                RealmDatabaseManager.ticket_add(Ticket(
                    is_bug=is_bug,
                    account_name=world_session.account_mgr.account.name,
                    account_id=world_session.account_mgr.account.id,
                    character_name=world_session.player_mgr.player.name,
                    text_body=body
                ))
            except:
                Logger.warning(f'Unable to process CMSG_BUG')

        return 0
