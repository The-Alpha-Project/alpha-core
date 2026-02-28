from struct import unpack

from game.world.managers.objects.units.player.guild.PetitionManager import PetitionManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketWriter import *
from utils.Formulas import Distances
from utils.constants.MiscCodes import NpcFlags
from utils.constants.OpCodes import OpCode


class PetitionShowlistHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # NPC needs 0x80 | 0x40 flag
        # Avoid handling an empty petition showlist packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0

        if not player_mgr.is_alive:
            return 0

        petition_npc = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if not petition_npc:
            return 0
        if not Distances.is_within_shop_distance(player_mgr, petition_npc):
            return 0
        if (petition_npc.get_npc_flags() & NpcFlags.NPC_FLAG_PETITIONER) == 0:
            return 0

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
