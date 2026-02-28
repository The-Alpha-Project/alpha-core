from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from network.packet.PacketWriter import PacketWriter
from utils.Formulas import Distances
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask

BIND_SPELL = 3286


class BinderActivateHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session or not world_session.player_mgr:
            return 0

        # Avoid handling an empty binder activate packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        player_mgr = world_session.player_mgr
        if not player_mgr.is_alive:
            return 0

        binder_guid = unpack('<Q', reader.data[:8])[0]
        if binder_guid <= 0:
            return 0

        binder = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, binder_guid)
        if not binder:
            return 0
        if not Distances.is_within_bind_distance(player_mgr, binder):
            return 0

        if binder.get_low_guid() == player_mgr.deathbind.creature_binder_guid:
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYERBINDERROR))
            return 0

        binder.spell_manager.handle_cast_attempt(BIND_SPELL, player_mgr, SpellTargetMask.UNIT, validate=False)

        return 0
