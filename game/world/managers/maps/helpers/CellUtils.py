
from utils.ConfigManager import config

ADT_SIZE = 533.33333  # Yards.
ADT_BLOCKS = 64
ADT_CHUNK_SIZE = 16
TOTAL_SIZE = total_size = ADT_BLOCKS * ADT_SIZE  # 34133.33312 yards.
CELL_SIZE = ADT_SIZE / ADT_CHUNK_SIZE  # 33.33333 yards.
NUM_CELLS = int(TOTAL_SIZE / CELL_SIZE)  # ~1024.
ORIGIN = TOTAL_SIZE / 2  # 17066.666 yards.
VIEW_DISTANCE = config.Server.Settings.view_distance
FOLLOW_LAG_CORRECTION_DISTANCE = VIEW_DISTANCE / 3.0


class CellUtils:

    @staticmethod
    def generate_coord_data(x, y):
        relative_x = x + ORIGIN
        relative_y = y + ORIGIN

        cell_x = int(relative_x // CELL_SIZE)
        cell_y = int(relative_y // CELL_SIZE)

        # Clamp to valid range
        cell_x = max(0, min(NUM_CELLS - 1, cell_x))
        cell_y = max(0, min(NUM_CELLS - 1, cell_y))

        return cell_x, cell_y

    @staticmethod
    def cell_to_adt(cell_x, cell_y):
        from game.world.managers.maps.helpers.MapUtils import MapUtils
        x = (cell_x * CELL_SIZE) - ORIGIN + (CELL_SIZE / 2)
        y = (cell_y * CELL_SIZE) - ORIGIN + (CELL_SIZE / 2)
        return MapUtils.get_tile(x, y)

    @staticmethod
    def get_cell_key_by_world_pos(x, y, map_, instance_id):
        cell_x, cell_y = CellUtils.generate_coord_data(x, y)
        key = f'{cell_x}:{cell_y}:{map_}:{instance_id}'
        return key

    @staticmethod
    def get_cell_key_by_cell(cell_x, cell_y, map_, instance_id):
        key = f'{cell_x}:{cell_y}:{map_}:{instance_id}'
        return key

    @staticmethod
    def get_cell_key_for_object(world_object):
        x = world_object.location.x
        y = world_object.location.y
        map_id = world_object.map_id
        instance_id = world_object.instance_id
        return CellUtils.get_cell_key_by_world_pos(x, y, map_id, instance_id)
