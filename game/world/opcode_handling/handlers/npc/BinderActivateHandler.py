from struct import unpack, pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils import Formulas


BIND_SPELL = 3286


class BinderActivateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty binder activate packet.
            binder_guid = unpack('<Q', reader.data[:8])[0]
            binder = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, binder_guid)
            if not binder or binder.location.distance(world_session.player_mgr.location) > Formulas.Distances.MAX_BIND_DISTANCE:
                return 0

            if binder.location.distance(x=world_session.player_mgr.deathbind.deathbind_position_x,
                                        y=world_session.player_mgr.deathbind.deathbind_position_y,
                                        z=world_session.player_mgr.deathbind.deathbind_position_z)\
                    < Formulas.Distances.MAX_BIND_RADIUS_CHECK:
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PLAYERBINDERROR))
            else:
                bind_spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(BIND_SPELL)
                binder.spell_manager.start_spell_cast(spell=bind_spell, caster=binder, spell_target=world_session.player_mgr)

        return 0
