from struct import unpack, pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class SetTargetHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        #  Obsolete, this event triggers on client MouseOver event, triggered by mobs, game objects, npcs.
        #  Selection instead triggers only when the user mouse clicks one of the above, which asure us he wants to interact.
        return 0
