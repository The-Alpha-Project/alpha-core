from multiprocessing import RLock
from game.world.managers.maps.helpers.InstanceToken import InstanceToken

PLAYER_INSTANCES = dict()


class InstancesManager:
    INSTANCE_ID = 130  # Max map_id + 1.
    LOCK = RLock()

    @staticmethod
    def get_instance_token(player_mgr, map_):
        with InstancesManager.LOCK:
            group = player_mgr.group_manager
            # Group priority.
            if group:
                if group.has_instance_token(map_):
                    return group.get_instance_token(map_)
                instance_token = InstancesManager._generate_instance_token(player_mgr.guid, map_)
                group.add_instance_token(map_, instance_token.instance_id, instance_token)
            else:
                instance_token = InstancesManager._get_instance_token_for_player_guid(player_mgr.guid, map_)

            print(f'Instance ID {instance_token.instance_id}')
            return instance_token

    @staticmethod
    def _generate_instance_token(guid, map_):
        if guid not in PLAYER_INSTANCES:
            PLAYER_INSTANCES[guid] = dict()
        instance_token = InstanceToken(InstancesManager.INSTANCE_ID, map_)
        PLAYER_INSTANCES[guid][map_] = instance_token
        InstancesManager.INSTANCE_ID += 1
        return instance_token

    @staticmethod
    def _get_instance_token_for_player_guid(guid, map_):
        if guid in PLAYER_INSTANCES:
            if map_ in PLAYER_INSTANCES[guid]:
                return PLAYER_INSTANCES[guid]
        return InstancesManager._generate_instance_token(guid, map_)
