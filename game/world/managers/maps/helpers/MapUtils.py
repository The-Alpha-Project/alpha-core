from game.world.managers.maps.helpers.Constants import RESOLUTION_ZMAP, ADT_SIZE


class MapUtils:

    @staticmethod
    def calculate_tile(x, y, resolution=RESOLUTION_ZMAP - 1):
        # Check both axis within boundaries.
        x = MapUtils._validate_map_coord(x)
        y = MapUtils._validate_map_coord(y)
        adt_x = int(32.0 - (x / ADT_SIZE))
        adt_y = int(32.0 - (y / ADT_SIZE))
        cell_x = int(round(resolution * (32.0 - (x / ADT_SIZE) - adt_x)))
        cell_y = int(round(resolution * (32.0 - (y / ADT_SIZE) - adt_y)))
        return adt_x, adt_y, cell_x, cell_y

    @staticmethod
    def get_tile(x, y):
        adt_x = int(32.0 - MapUtils._validate_map_coord(x) / ADT_SIZE)
        adt_y = int(32.0 - MapUtils._validate_map_coord(y) / ADT_SIZE)
        return [adt_x, adt_y]

    @staticmethod
    def _validate_map_coord(coord):
        if coord > 32.0 * ADT_SIZE:
            return 32.0 * ADT_SIZE
        elif coord < -32.0 * ADT_SIZE:
            return -32.0 * ADT_SIZE
        return coord

    @staticmethod
    def is_valid_position(x, y):
        if x > 32.0 * ADT_SIZE or y > 32.0 * ADT_SIZE:
            return False
        elif x < -32.0 * ADT_SIZE or y < -32.0 * ADT_SIZE:
            return False
        return True
