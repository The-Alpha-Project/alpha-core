from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class PetitionShowlistHandler:

    @staticmethod
    def handle(world_session, reader):
        # NPC needs 0x80 | 0x40 flag
        if len(reader.data) >= 8:  # Avoid handling empty petition showlist packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                data = pack(
                    '<QB5I',
                    guid,  # npc guid
                    1,  # count
                    1,  # muid (index?)
                    PetitionManager.CHARTER_ENTRY,  # charter entry
                    PetitionManager.CHARTER_DISPLAY_ID,  # charter display id
                    PetitionManager.CHARTER_COST,  # charter cost (10s)
                    1  # unknown flag
                )
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PETITION_SHOWLIST, data))

        return 0
