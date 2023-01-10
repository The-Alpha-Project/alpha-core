import math

from utils.ConfigManager import config

TOLERANCE = 0.00001
CELL_SIZE = config.Server.Settings.cell_size


class CellUtils:

    @staticmethod
    def generate_coord_data(x, y):
        mod_x = x / CELL_SIZE
        mod_y = y / CELL_SIZE

        max_x = math.ceil(mod_x) * CELL_SIZE - TOLERANCE
        max_y = math.ceil(mod_y) * CELL_SIZE - TOLERANCE
        min_x = max_x - CELL_SIZE + TOLERANCE
        min_y = max_y - CELL_SIZE + TOLERANCE

        return min_x, min_y, max_x, max_y

    @staticmethod
    def get_cell_key(x, y, map_, instance_id):
        min_x, min_y, max_x, max_y = CellUtils.generate_coord_data(x, y)
        key = f'{round(min_x, 5)}:{round(min_y, 5)}:{round(max_x, 5)}:{round(max_y, 5)}:{map_}:{instance_id}'
        return key

    @staticmethod
    def get_cell_key_for_object(world_object):
        x = world_object.location.x
        y = world_object.location.y
        map_id = world_object.map_id
        instance_id = world_object.instance_id
        return CellUtils.get_cell_key(x, y, map_id, instance_id)
