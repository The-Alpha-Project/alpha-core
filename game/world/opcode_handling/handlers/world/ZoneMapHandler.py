class ZoneMapHandler:

    @staticmethod
    def handle(world_session, reader):
        # Client only sends CMSG_ZONE_MAP when debug zone boundaries are toggled.
        # When enabled, the client expects SMSG_ZONE_MAP to return a full 256x256
        # zone-id grid encoded as run-length-encoding (RLE) pairs:
        #   - zone_id_byte: the zone id to repeat
        #   - run_length_uint32: how many consecutive cells repeat that zone id
        # Cell size = 133.3333.
        return 0
