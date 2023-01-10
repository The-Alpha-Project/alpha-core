from multiprocessing import RLock
from game.world.managers.maps.helpers.InstanceToken import InstanceToken

# Instances tokens per player/map.
INSTANCES: dict[int, dict[int, InstanceToken]] = dict()


class InstancesManager:
    # TODO: Generate a new id on map creation instead of starting from this hardcoded value. At the very least, grab the
    #  max map id from the dbc files.
    INSTANCE_ID = 130  # Max map_id + 1.
    LOCK = RLock()

    @staticmethod
    def get_or_create_instance_token_by_player(player_mgr, map_id):
        # World/Pvp maps use map_id as instance_id.
        if not InstancesManager._is_dungeon_map_id(map_id):
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

    @staticmethod
    def _is_dungeon_map_id(map_id):
        # TODO: Move to Map db table as custom field?
        return map_id not in (0, 1, 13, 17, 25, 29, 30, 37, 42)
