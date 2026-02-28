from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.ObjectQueryUtils import ObjectQueryUtils
from utils.constants.OpCodes import OpCode


class ItemQuerySingleHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty item query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=12):
            return 0
        entry = unpack('<I', reader.data[:4])[0]
        if entry <= 0:
            return 0

        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
        if not item_template:
            return 0

        query_data = ObjectQueryUtils.get_query_details_data(template=item_template)
        query_packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data)
        world_session.enqueue_packet(query_packet)

        return 0
