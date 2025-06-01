from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.ObjectQueryUtils import ObjectQueryUtils
from utils.constants.OpCodes import OpCode


class ItemQuerySingleHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty item query packet.
            entry = unpack('<I', reader.data[:4])[0]
            if entry > 0:
                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
                if item_template:
                    query_data = ObjectQueryUtils.get_query_details_data(template=item_template)
                    query_packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data)
                    world_session.enqueue_packet(query_packet)

        return 0
