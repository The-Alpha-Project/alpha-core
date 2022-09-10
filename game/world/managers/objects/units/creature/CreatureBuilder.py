from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants import CustomCodes
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.UnitCodes import MovementTypes, UnitFlags


class CreatureBuilder:
    CURRENT_HIGHEST_GUID = 0

    @staticmethod
    def create(entry, location, map_id, health_percent, mana_percent, summoner=None, faction=0,
               despawn_time=1, spell_id=0, ttl=0, addon=None, wander_distance=0, movement_type=MovementTypes.IDLE,
               subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC):

        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(entry)
        if not creature_template:
            return None

        CreatureBuilder.CURRENT_HIGHEST_GUID += 1
        from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
        creature_instance = CreatureManager()
        creature_instance.guid = creature_instance.generate_object_guid(CreatureBuilder.CURRENT_HIGHEST_GUID)
        creature_instance.creature_template = creature_template
        creature_instance.location = location
        creature_instance.spawn_position = creature_instance.location.copy()
        creature_instance.map_ = map_id
        creature_instance.health_percent = health_percent
        creature_instance.mana_percent = mana_percent
        creature_instance.summoner = summoner
        creature_instance.subtype = subtype
        creature_instance.spell_id = spell_id
        creature_instance.despawn_time = despawn_time
        creature_instance.time_to_live_timer = ttl
        creature_instance.faction = faction if faction else creature_template.faction
        creature_instance.addon = addon
        creature_instance.wander_distance = wander_distance
        creature_instance.movement_type = movement_type

        if summoner and summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
            creature_instance.unit_flags |= UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED

        creature_instance.initialize_from_creature_template(creature_template)

        return creature_instance
