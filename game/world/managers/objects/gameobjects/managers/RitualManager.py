from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from utils.Logger import Logger
from utils.constants.SpellCodes import SpellTargetMask, SpellCheckCastResult


class RitualManager(GameObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.required_participants = 0
        self.summon_spell_id = 0
        self.channel_spell_id = 0
        self.persistent = False
        self.caster_target_spell = 0
        self.caster_target_spell_targets = False
        self.casters_grouped = False
        self.ritual_participants = []

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.required_participants = self.get_data_field(0, int) - 1  # -1 to include caster.
        self.summon_spell_id = self.get_data_field(1, int)
        self.channel_spell_id = self.get_data_field(2, int)
        self.persistent = self.get_data_field(3, bool)
        self.caster_target_spell = self.get_data_field(4, int)
        self.caster_target_spell_targets = self.get_data_field(5, bool)
        self.casters_grouped = self.get_data_field(6, bool)

    # override
    def use(self, unit=None, target=None, from_script=False):
        if unit and unit.is_player():
            # Ritual should have a summoner.
            if not self.summoner:
                Logger.warning(f'Player {unit.get_name()} tried to use Ritual with no summoner set.')
                unit.spell_manager.send_cast_result(self.summon_spell_id, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
                return

            if unit is self.summoner or unit in self.ritual_participants:
                return  # No action needed for this player.

            # Make the player channel for summoning.
            channel_spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.channel_spell_id)
            spell = unit.spell_manager.try_initialize_spell(channel_spell_entry, self, SpellTargetMask.GAMEOBJECT,
                                                            validate=False)

            # These triggered casts will skip the actual effects of the summoning spell, only starting the channel.
            unit.spell_manager.remove_colliding_casts(spell)
            unit.spell_manager.casting_spells.append(spell)
            unit.spell_manager.handle_channel_start(spell)
            unit.set_channel_object(self.guid)
            self.ritual_participants.append(unit)

            # Check if the ritual can be completed with the current participants.
            if len(self.ritual_participants) >= self.required_participants:
                # Cast the finishing spell.
                spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.summon_spell_id)
                spell_cast = self.summoner.spell_manager.try_initialize_spell(spell_entry, self.summoner,
                                                                              SpellTargetMask.SELF,
                                                                              triggered=True, validate=False)
                if spell_cast:
                    self.summoner.spell_manager.start_spell_cast(initialized_spell=spell_cast)
                else:
                    # Interrupt ritual channel if summon fails.
                    self.summoner.spell_manager.remove_cast_by_id(self.channel_spell_id)

        super().use(unit, target, from_script)

    def channel_end(self, caster):
        # If the ritual caster interrupts channeling, interrupt others and remove the portal.
        if caster is self.summoner:
            self.get_map().remove_object(self)
            for player in self.ritual_participants:
                # Note that this call will lead to _handle_summoning_channel_end() calls from the participants.
                player.spell_manager.remove_cast_by_id(self.channel_spell_id)
        # If a participant interrupts their channeling, remove from participants and interrupt summoning if necessary.
        elif caster in self.ritual_participants:
            self.ritual_participants.remove(caster)
            caster.flush_channel_fields()
            if not self.meets_participants():
                self.summoner.spell_manager.remove_cast_by_id(self.summon_spell_id)

    def meets_participants(self):
        return len(self.ritual_participants) >= self.required_participants
