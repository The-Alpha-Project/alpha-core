from struct import pack, unpack

from network.packet.PacketWriter import *


class PlayerMacroHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # TODO: Not implemented, not sure what to do with this data (called with /v oom, for example)
        print('Size: %u' % len(reader.data))
        print('Data: %s' % reader.data)
        print('Data uint32: %u' % unpack('<I', reader.data))

        return 0
