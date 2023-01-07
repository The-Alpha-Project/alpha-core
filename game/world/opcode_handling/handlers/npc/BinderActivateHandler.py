from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils import Formulas
from utils.constants.SpellCodes import SpellTargetMask

BIND_SPELL = 3286


class BinderActivateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty binder activate packet.
            binder_guid = unpack('<Q', reader.data[:8])[0]
            binder = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, binder_guid)
            if not binder or binder.location.distance(world_session.player_mgr.location) > Formulas.Distances.MAX_BIND_DISTANCE:
                return 0

            if binder.get_low_guid() == world_session.player_mgr.deathbind.creature_binder_guid:
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYERBINDERROR))
            else:
                binder.spell_manager.handle_cast_attempt(BIND_SPELL, world_session.player_mgr,
                                                         SpellTargetMask.UNIT, validate=False)

        return 0
