from typing import Dict

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

        ctor = GO_CONSTRUCTORS.get(gobject_template.type, GameObjectBuilder.get_go_ctor)()

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

        # Continue initialization. (Faction and Flags will be overridden below).
        go_instance.faction = faction if faction else gobject_template.faction
        go_instance.location = location
        go_instance.rot0 = rot0
        go_instance.rot1 = rot1
        go_instance.rot2 = rot2
        go_instance.rot3 = rot3
        go_instance.time_to_live = ttl

        # Set channel object update field for rituals and fishing nodes.
        if (gobject_template.type in {GameObjectTypes.TYPE_RITUAL, GameObjectTypes.TYPE_FISHINGNODE}
                and summoner and summoner.is_unit(by_mask=True)):
            summoner.set_channel_object(go_instance.guid)

        return go_instance

    @staticmethod
    def get_door_ctor():
        from game.world.managers.objects.gameobjects.managers.DoorManager import DoorManager
        return DoorManager

    @staticmethod
    def get_trap_ctor():
        from game.world.managers.objects.gameobjects.managers.TrapManager import TrapManager
        return TrapManager

    @staticmethod
    def get_chair_ctor():
        from game.world.managers.objects.gameobjects.managers.ChairManager import ChairManager
        return ChairManager

    @staticmethod
    def get_chest_ctor():
        from game.world.managers.objects.gameobjects.managers.ChestMananger import ChestManager
        return ChestManager

    @staticmethod
    def get_go_ctor():
        from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
        return GameObjectManager

    @staticmethod
    def get_camera_ctor():
        from game.world.managers.objects.gameobjects.managers.CameraManager import CameraManager
        return CameraManager

    @staticmethod
    def get_goober_ctor():
        from game.world.managers.objects.gameobjects.managers.GooberManager import GooberManager
        return GooberManager

    @staticmethod
    def get_button_ctor():
        from game.world.managers.objects.gameobjects.managers.ButtonManager import ButtonManager
        return ButtonManager

    @staticmethod
    def get_ritual_ctor():
        from game.world.managers.objects.gameobjects.managers.RitualManager import RitualManager
        return RitualManager

    @staticmethod
    def get_transport_ctor():
        from game.world.managers.objects.gameobjects.managers.TransportManager import TransportManager
        return TransportManager

    @staticmethod
    def get_spell_focus_ctor():
        from game.world.managers.objects.gameobjects.managers.SpellFocusManager import SpellFocusManager
        return SpellFocusManager

    @staticmethod
    def get_quest_giver_ctor():
        from game.world.managers.objects.gameobjects.managers.QuestGiverManager import QuestGiverManager
        return QuestGiverManager

    @staticmethod
    def get_fishing_node_ctor():
        from game.world.managers.objects.gameobjects.managers.FishingNodeManager import FishingNodeManager
        return FishingNodeManager

    @staticmethod
    def get_duel_arbiter_ctor():
        from game.world.managers.objects.gameobjects.managers.DuelArbiterManager import DuelArbiterManager
        return DuelArbiterManager


GO_CONSTRUCTORS: Dict[int, callable] = {
    GameObjectTypes.TYPE_DOOR : GameObjectBuilder.get_door_ctor,
    GameObjectTypes.TYPE_BUTTON : GameObjectBuilder.get_button_ctor,
    GameObjectTypes.TYPE_CHEST : GameObjectBuilder.get_chest_ctor,
    GameObjectTypes.TYPE_QUESTGIVER : GameObjectBuilder.get_quest_giver_ctor,
    GameObjectTypes.TYPE_TRAP : GameObjectBuilder.get_trap_ctor,
    GameObjectTypes.TYPE_FISHINGNODE : GameObjectBuilder.get_fishing_node_ctor,
    GameObjectTypes.TYPE_GOOBER : GameObjectBuilder.get_goober_ctor,
    GameObjectTypes.TYPE_CAMERA : GameObjectBuilder.get_camera_ctor,
    GameObjectTypes.TYPE_TRANSPORT : GameObjectBuilder.get_transport_ctor,
    GameObjectTypes.TYPE_RITUAL : GameObjectBuilder.get_ritual_ctor,
    GameObjectTypes.TYPE_CHAIR : GameObjectBuilder.get_chair_ctor,
    GameObjectTypes.TYPE_DUEL_ARBITER : GameObjectBuilder.get_duel_arbiter_ctor,
    GameObjectTypes.TYPE_SPELL_FOCUS : GameObjectBuilder.get_spell_focus_ctor,
}