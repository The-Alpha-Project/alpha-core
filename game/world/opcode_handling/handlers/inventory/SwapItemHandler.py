from struct import unpack


class SwapItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty swap item packet.
            dest_bag, dest_slot, source_bag, source_slot = unpack('<4B', reader.data[:4])
            world_session.player_mgr.inventory.swap_item(source_bag, source_slot, dest_bag, dest_slot)
        return 0
