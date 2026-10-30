from multiprocessing import RLock

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.helpers.InstanceToken import InstanceToken
from utils.Logger import Logger

# Instances tokens per player/map.
INSTANCES: dict[int, dict[int, InstanceToken]] = dict()


class InstancesManager:
    INSTANCE_ID = DbcDatabaseManager.get_max_map_id() + 1  # Max map_id + 1.
    LOCK = RLock()
    # Like vmangos, dungeons have no reset timer, they reset once nobody has been inside for this long.
    INSTANCE_UNLOAD_DELAY = 1800

    @staticmethod
    def unload_empty_instances():
        # Read player_mgr once per session, a logout on another thread can set it to None at any time.
        players = [session.player_mgr for session in WorldSessionStateHandler.get_world_sessions()]
        occupied_instances = {(player_mgr.map_id, player_mgr.instance_id) for player_mgr in players if player_mgr}
        # Tokens go together with their maps, so nobody can rebuild an instance id that is being unloaded.
        with InstancesManager.LOCK:
            empty_maps = MapManager.pop_empty_instance_maps(occupied_instances, InstancesManager.INSTANCE_UNLOAD_DELAY)
            for instance_map in empty_maps:
                InstancesManager._remove_instance_tokens(instance_map.map_id, instance_map.instance_id)
        for instance_map in empty_maps:
            Logger.info(f'[Instance] Unloading empty instance, Map:{instance_map.map_id} '
                        f'Instance:{instance_map.instance_id}')
            instance_map.unload()

    @staticmethod
    def _remove_instance_tokens(map_id, instance_id):
        # Circular ref.
        from game.world.managers.objects.units.player.GroupManager import GROUPS
        with InstancesManager.LOCK:
            for player_guid, instance_tokens in list(INSTANCES.items()):
                instance_token = instance_tokens.get(map_id)
                if instance_token and instance_token.id == instance_id:
                    instance_tokens.pop(map_id)
                if not instance_tokens:
                    INSTANCES.pop(player_guid)
            for group_manager in list(GROUPS.values()):
                instance_token = group_manager.instance_tokens.get(map_id)
                if instance_token and instance_token.id == instance_id:
                    group_manager.instance_tokens.pop(map_id)

    @staticmethod
    def get_or_create_instance_token_by_player(player_mgr, map_id):
        # World/Pvp maps use map_id as instance_id.
        if not MapManager.is_dungeon_map_id(map_id):
            return InstanceToken(map_id, map_id)
        with InstancesManager.LOCK:
            group_manager = player_mgr.group_manager
            # Group priority.
            if group_manager:
                if group_manager.has_instance_token(map_id):
                    instance_token = group_manager.get_instance_token(map_id)
                    group_manager.update_instance_token_for_members(instance_token)
                    return instance_token
                instance_token = InstancesManager._generate_instance_token(player_mgr.guid, map_id)
                group_manager.add_instance_token(map_id, instance_token)
            else:
                instance_token = InstancesManager.get_instance_token_for_player_guid(player_mgr.guid, map_id)
                if not instance_token:
                    instance_token = InstancesManager._generate_instance_token(player_mgr.guid, map_id)

            return instance_token

    @staticmethod
    def get_instance_token_for_player_guid(player_guid, map_):
        if player_guid in INSTANCES and map_ in INSTANCES[player_guid]:
            return INSTANCES[player_guid][map_]
        return None

    @staticmethod
    def remove_token_for_player(player_guid, instance_token: InstanceToken):
        if player_guid in INSTANCES and instance_token.map_id in INSTANCES[player_guid]:
            INSTANCES[player_guid].pop(instance_token.map_id)

    @staticmethod
    def _generate_instance_token(player_guid, map_):
        if player_guid not in INSTANCES:
            INSTANCES[player_guid] = dict()
        instance_token = InstanceToken(InstancesManager.INSTANCE_ID, map_)
        INSTANCES[player_guid][map_] = instance_token
        InstancesManager.INSTANCE_ID += 1
        return instance_token
