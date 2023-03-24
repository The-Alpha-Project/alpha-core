from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.guids.GuidManager import GuidManager


class GameObjectBuilder:
    GUID_MANAGER = GuidManager()

    @staticmethod
    def create(entry_id, location, map_id, instance_id, state, summoner=None, rot0=0, rot1=0, rot2=0, rot3=0, faction=0,
               spell_id=0, ttl=0, spawn_id=0, is_spawned=True, is_default=False):

        gobject_template = WorldDatabaseManager.GameobjectTemplateHolder.gameobject_get_by_entry(entry_id)
        if not gobject_template:
            return None

        gameobject_instance = GameObjectManager()
        gameobject_instance.is_default = is_default
        gameobject_instance.is_spawned = is_spawned
        gameobject_instance.spawn_id = spawn_id
        gameobject_instance.entry = gobject_template.entry
        gameobject_instance.gobject_template = gobject_template
        gameobject_instance.guid = gameobject_instance.generate_object_guid(GameObjectBuilder.GUID_MANAGER.get_new_guid())
        gameobject_instance.map_id = map_id if not summoner else summoner.map_id
        gameobject_instance.instance_id = instance_id if not summoner else summoner.instance_id
        gameobject_instance.zone = summoner.zone if summoner else 0
        gameobject_instance.summoner = summoner
        gameobject_instance.spell_id = spell_id

        # Initialize from gameobject template.
        gameobject_instance.initialize_from_gameobject_template(gobject_template)

        # Continue initialization. (Faction and Flags will be overriden below)
        gameobject_instance.faction = faction if faction else gobject_template.faction
        gameobject_instance.location = location
        gameobject_instance.rot0 = rot0
        gameobject_instance.rot1 = rot1
        gameobject_instance.rot2 = rot2
        gameobject_instance.rot3 = rot3
        gameobject_instance.state = state
        gameobject_instance.time_to_live_timer = ttl

        # if summoner:
        #     gameobject_instance.flags |= GameObjectFlags.TRIGGERED

        return gameobject_instance
