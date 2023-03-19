from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds, ObjectTypeFlags
from utils.constants.SpellCodes import SpellTargetMask, SpellCheckCastResult


class RitualManager:
    def __init__(self, ritual_object):
        self.ritual_object = ritual_object
        self.required_participants = ritual_object.gobject_template.data0 - 1  # -1 to include caster.
        self.ritual_summon_spell_id = ritual_object.gobject_template.data1
        self.ritual_channel_spell_id = ritual_object.gobject_template.data2
        self.persistent = ritual_object.gobject_template.data3 > 0
        self.caster_target_spell = ritual_object.gobject_template.data4
        self.caster_target_spell_targets = ritual_object.gobject_template.data5 > 0
        self.casters_grouped = ritual_object.gobject_template.data6 > 0
        self.ritual_participants = []

        # Set channel object update field.
        if ritual_object.summoner and ritual_object.summoner.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            ritual_object.summoner.set_channel_object(ritual_object.guid)

    def ritual_use(self, player_mgr):
        # Ritual should have a summoner.
        if not self.ritual_object.summoner:
            Logger.warning(f'Player {player_mgr.get_name()} tried to use Ritual with no summoner set.')
            player_mgr.spell_manager.send_cast_result(self.ritual_summon_spell_id,
                                                      SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
            return

        # Grab the ritual summoner.
        summoner = self.ritual_object.summoner

        # Group check for players.
        if summoner.get_type_id() == ObjectTypeIds.ID_PLAYER and self.casters_grouped:
            if not summoner.group_manager or not summoner.group_manager.is_party_member(player_mgr.guid):
                player_mgr.spell_manager.send_cast_result(self.ritual_summon_spell_id,
                                                          SpellCheckCastResult.SPELL_FAILED_TARGET_NOT_IN_PARTY)
                return

        if player_mgr is summoner or player_mgr in self.ritual_participants:
            return  # No action needed for this player.

        # Make the player channel for summoning.
        channel_spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.ritual_channel_spell_id)
        spell = player_mgr.spell_manager.try_initialize_spell(channel_spell_entry, self, SpellTargetMask.GAMEOBJECT,
                                                              validate=False)

        # Note: these triggered casts will skip the actual effects of the summoning spell, only starting the channel.
        player_mgr.spell_manager.remove_colliding_casts(spell)
        player_mgr.spell_manager.casting_spells.append(spell)
        player_mgr.spell_manager.handle_channel_start(spell)
        player_mgr.set_channel_object(self.ritual_object.guid)
        self.ritual_participants.append(player_mgr)

        # Check if the ritual can be completed with the current participants.
        if len(self.ritual_participants) >= self.required_participants:
            # Cast the finishing spell.
            spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.ritual_summon_spell_id)
            spell_cast = summoner.spell_manager.try_initialize_spell(spell_entry, summoner, SpellTargetMask.SELF,
                                                                     triggered=True, validate=False)
            if spell_cast:
                summoner.spell_manager.start_spell_cast(initialized_spell=spell_cast)
            else:
                # Interrupt ritual channel if summon fails.
                summoner.spell_manager.remove_cast_by_id(self.ritual_channel_spell_id)

    def channel_end(self, caster):
        # If the ritual caster interrupts channeling, interrupt others and remove the portal.
        if caster is self.ritual_object.summoner:
            MapManager.remove_object(self.ritual_object)
            for player in self.ritual_participants:
                # Note that this call will lead to _handle_summoning_channel_end() calls from the participants.
                player.spell_manager.remove_cast_by_id(self.ritual_channel_spell_id)
        # If a participant interrupts their channeling, remove from participants and interrupt summoning if necessary.
        elif caster in self.ritual_participants:
            self.ritual_participants.remove(caster)
            caster.flush_channel_fields()
            if not self.meets_participants():
                self.ritual_object.summoner.spell_manager.remove_cast_by_id(self.ritual_summon_spell_id)

    def meets_participants(self):
        return len(self.ritual_participants) >= self.required_participants
