from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.guids.GuidManager import GuidManager
from utils.constants import CustomCodes
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.UnitCodes import MovementTypes, UnitFlags


class CreatureBuilder:
    GUID_MANAGER = GuidManager()

    @staticmethod
    def create(entry, location, map_id, health_percent=100, mana_percent=100, summoner=None, faction=0,
               spell_id=0, ttl=0, addon=None, wander_distance=0, movement_type=MovementTypes.IDLE,
               subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC):

        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(entry)
        if not creature_template:
            return None

        from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
        creature_instance = CreatureManager()
        creature_instance.entry = creature_template.entry
        creature_instance.guid = creature_instance.generate_object_guid(CreatureBuilder.GUID_MANAGER.get_new_guid())
        creature_instance.creature_template = creature_template
        creature_instance.summoner = summoner
        creature_instance.subtype = subtype
        creature_instance.mana_percent = mana_percent
        creature_instance.health_percent = health_percent

        # Initialize from creature template.
        creature_instance.initialize_from_creature_template(creature_template)

        # Continue initialization, order above matters.
        creature_instance.faction = faction if faction else creature_template.faction
        creature_instance.location = location
        creature_instance.spawn_position = creature_instance.location.copy()
        creature_instance.map_ = map_id if not summoner else summoner.map_
        creature_instance.zone = summoner.zone if summoner else 0
        creature_instance.spell_id = spell_id
        creature_instance.time_to_live_timer = ttl
        creature_instance.addon = addon
        creature_instance.wander_distance = wander_distance
        creature_instance.movement_type = movement_type

        if summoner and summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
            creature_instance.unit_flags |= UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED

        return creature_instance
