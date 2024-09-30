from typing import Callable

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.GuidManager import GuidManager
from utils.constants.MiscCodes import GameObjectTypes


class GameObjectBuilder:
    MAX_SPAWN_ID = WorldDatabaseManager.gameobject_get_max_spawn_id()

    GUID_MANAGER = GuidManager()

    @staticmethod
    def create(entry_id, location, map_id, instance_id, state, summoner=None, rot0=0, rot1=0, rot2=0, rot3=0, faction=0,
               spell_id=0, ttl=0, spawn_id=0, is_spawned=True, is_default=False):

        gobject_template = WorldDatabaseManager.GameobjectTemplateHolder.gameobject_get_by_entry(entry_id)
        if not gobject_template:
            return None

        # If no spawn_id is provided (for gameobjects spawned on runtime), generate a new unique one.
        is_dynamic_spawn = False
        if spawn_id == 0:
            is_dynamic_spawn = True
            GameObjectBuilder.MAX_SPAWN_ID += 1
            spawn_id = GameObjectBuilder.MAX_SPAWN_ID

        ctor = GameObjectBuilder.get_object_type_ctor(gobject_template)
        go_instance = ctor(
            entry=gobject_template.entry,
            location=location,
            map_id=map_id if not summoner else summoner.map_id,
            zone=summoner.zone if summoner else 0)

        go_instance.guid = go_instance.generate_object_guid(GameObjectBuilder.GUID_MANAGER.get_new_guid())
        go_instance.is_default = is_default
        go_instance.is_spawned = is_spawned
        go_instance.spawn_id = spawn_id
        go_instance.is_dynamic_spawn = is_dynamic_spawn
        go_instance.gobject_template = gobject_template
        go_instance.instance_id = instance_id if not summoner else summoner.instance_id
        go_instance.summoner = summoner
        go_instance.spell_id = spell_id
        go_instance.initial_state = state

        # Initialize from gameobject template.
        go_instance.initialize_from_gameobject_template(gobject_template)

        # Continue initialization. (Faction and Flags will be overriden below)
        go_instance.faction = faction if faction else gobject_template.faction
        go_instance.location = location
        go_instance.rot0 = rot0
        go_instance.rot1 = rot1
        go_instance.rot2 = rot2
        go_instance.rot3 = rot3
        go_instance.time_to_live_timer = ttl

        # Set channel object update field for rituals and fishing nodes.
        if (gobject_template.type in {GameObjectTypes.TYPE_RITUAL, GameObjectTypes.TYPE_FISHINGNODE}
                and summoner and summoner.is_unit(by_mask=True)):
            summoner.set_channel_object(go_instance.guid)

        return go_instance

    @staticmethod
    def get_object_type_ctor(template) -> Callable:
        from game.world.managers.objects.gameobjects.managers.DoorManager import DoorManager
        from game.world.managers.objects.gameobjects.managers.TrapManager import TrapManager
        from game.world.managers.objects.gameobjects.managers.ChairManager import ChairManager
        from game.world.managers.objects.gameobjects.managers.ChestMananger import ChestManager
        from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
        from game.world.managers.objects.gameobjects.managers.CameraManager import CameraManager
        from game.world.managers.objects.gameobjects.managers.GooberManager import GooberManager
        from game.world.managers.objects.gameobjects.managers.ButtonManager import ButtonManager
        from game.world.managers.objects.gameobjects.managers.RitualManager import RitualManager
        from game.world.managers.objects.gameobjects.managers.TransportManager import TransportManager
        from game.world.managers.objects.gameobjects.managers.SpellFocusManager import SpellFocusManager
        from game.world.managers.objects.gameobjects.managers.MiningNodeManager import MiningNodeManager
        from game.world.managers.objects.gameobjects.managers.QuestGiverManager import QuestGiverManager
        from game.world.managers.objects.gameobjects.managers.FishingNodeManager import FishingNodeManager
        from game.world.managers.objects.gameobjects.managers.DuelArbiterManager import DuelArbiterManager

        if template.type == GameObjectTypes.TYPE_DOOR:
            return DoorManager
        elif template.type == GameObjectTypes.TYPE_BUTTON:
            return ButtonManager
        elif template.type == GameObjectTypes.TYPE_CHEST and template.data4 != 0 and template.data5 > template.data4:
            return MiningNodeManager
        elif template.type == GameObjectTypes.TYPE_CHEST:
            return ChestManager
        elif template.type == GameObjectTypes.TYPE_QUESTGIVER:
            return QuestGiverManager
        elif template.type == GameObjectTypes.TYPE_TRAP:
            return TrapManager
        elif template.type == GameObjectTypes.TYPE_FISHINGNODE:
            return FishingNodeManager
        elif template.type == GameObjectTypes.TYPE_GOOBER:
            return GooberManager
        elif template.type == GameObjectTypes.TYPE_CHAIR:
            return ChairManager
        elif template.type == GameObjectTypes.TYPE_CAMERA:
            return CameraManager
        elif template.type == GameObjectTypes.TYPE_TRANSPORT:
            return TransportManager
        elif template.type == GameObjectTypes.TYPE_RITUAL:
            return RitualManager
        elif template.type == GameObjectTypes.TYPE_SPELL_FOCUS:
            return SpellFocusManager
        elif template.type == GameObjectTypes.TYPE_DUEL_ARBITER:
            return DuelArbiterManager
        else:
            return GameObjectManager
