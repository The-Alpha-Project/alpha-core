from struct import pack, unpack

from network.packet.PacketWriter import *


CHARTER_ENTRY = 5863
CHARTER_DISPLAY_ID = 9199
CHARTER_COST = 1000


class PetitionShowlistHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 8:  # Avoid handling empty petition showlist packet
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                data = pack(
                    '<QB5I',
                    guid,  # npc guid
                    1,  # count
                    1,  # muid (index?)
                    CHARTER_ENTRY,  # charter entry
                    CHARTER_DISPLAY_ID,  # charter display id
                    CHARTER_COST,  # charter cost (10s)
                    1  # unknown flag
                )
                socket.sendall(PacketWriter.get_packet(OpCode.SMSG_PETITION_SHOWLIST, data))

        return 0
