from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack, pack

from network.packet.PacketWriter import PacketWriter
from utils.Formulas import Distances
from utils.constants.MiscCodes import NpcFlags
from utils.constants.OpCodes import OpCode


class TabardVendorActivateHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session or not world_session.player_mgr:
            return 0

        # Avoid handling an empty tabard vendor activate packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]
        if guid <= 0:
            return 0

        player_mgr = world_session.player_mgr
        if not player_mgr.is_alive:
            return 0

        tabard_vendor = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if not tabard_vendor:
            return 0
        if not Distances.is_within_shop_distance(player_mgr, tabard_vendor):
            return 0
        if (tabard_vendor.get_npc_flags() & NpcFlags.NPC_FLAG_TABARDDESIGNER) == 0:
            return 0

        data = pack('<Q', guid)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_TABARDVENDOR_ACTIVATE, data))

        return 0
