from struct import pack, unpack

from network.packet.PacketWriter import *


class SwapInvItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty swap inv item packet
            source_slot, dest_slot = unpack('<2B', reader.data[:2])
            # TODO: Finish
        return 0
