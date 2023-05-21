from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import *
from utils.TextUtils import GameTextFormatter
from utils.constants.OpCodes import OpCode


class PageTextQueryHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty page text query packet.
            page_id = unpack('<I', reader.data[:4])[0]
            keep_looking = True

            while keep_looking:
                page = WorldDatabaseManager.page_text_get_by_id(page_id)
                data = pack('<I', page_id)

                if page:
                    page_text_bytes = PacketWriter.string_to_bytes(GameTextFormatter.format(world_session.player_mgr,
                                                                                            page.text))
                    data += pack(
                        f'<{len(page_text_bytes)}sI',
                        page_text_bytes,
                        page.next_page
                    )
                    page_id = page.next_page

                    if page_id <= 0:
                        keep_looking = False
                else:
                    missing_page_bytes = PacketWriter.string_to_bytes('Item page missing.')
                    data += pack(
                        f'<{len(missing_page_bytes)}sI',
                        missing_page_bytes,
                        0
                    )

                    keep_looking = False

                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PAGE_TEXT_QUERY_RESPONSE, data))

        return 0
