import math

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.mmaps.MMapManager import MMapManager
from utils.ConfigManager import config
from utils.constants.ObjectCodes import ObjectTypes

TOLERANCE = 0.00001
CELL_SIZE = config.Server.Settings.cell_size

CELLS = dict()


class GridManager(object):
    ACTIVE_CELL_KEYS = set()

    @staticmethod
    def add_or_get(world_obj, store=False):
        min_x, min_y, max_x, max_y = GridManager.generate_coord_data(world_obj.location)
        cell_coords = GridManager.get_cell_key(world_obj.location, world_obj.map_)
        if cell_coords in CELLS:
            cell = CELLS[cell_coords]
        else:
            cell = Cell(min_x, min_y, max_x, max_y, world_obj.map_)
            CELLS[cell.key] = cell

        if store:
            cell.add(world_obj)

        return cell

    @staticmethod
    def update_object(world_obj):
        cell_coords = GridManager.get_cell_key(world_obj.location, world_obj.map_)

        if cell_coords != world_obj.current_cell:
            if world_obj.current_cell in CELLS:
                cell = CELLS[world_obj.current_cell]
                cell.remove(world_obj)

            if cell_coords in CELLS:
                CELLS[cell_coords].add(world_obj)
            else:
                GridManager.add_or_get(world_obj, store=True)

            world_obj.on_cell_change()

    @staticmethod
    def remove_object(world_obj):
        if world_obj.current_cell in CELLS:
            cell = CELLS[world_obj.current_cell]
            cell.remove(world_obj)
            cell.send_all_in_range(world_obj.get_destroy_packet(), source=world_obj, range_=CELL_SIZE)

    # TODO: Should cleanup loaded tiles for deactivated cells.
    @staticmethod
    def deactivate_cells():
        for cell_key in list(GridManager.ACTIVE_CELL_KEYS):
            players_near = False
            for cell in GridManager.get_surrounding_cells_by_cell(CELLS[cell_key]):
                if cell.has_players():
                    players_near = True
                    break

            # Make sure only Cells with no players near are removed from the Active list.
            if not players_near:
                GridManager.ACTIVE_CELL_KEYS.discard(cell_key)

    @staticmethod
    def load_mmaps_for_active_cells():
        if not MMapManager.ENABLED:
            return

        for key in list(GridManager.ACTIVE_CELL_KEYS):
            cell = CELLS[key]
            for guid, creature in list(cell.creatures.items()):
                MMapManager.load_mmap(creature.map_, creature.location.x, creature.location.y)

    @staticmethod
    def get_surrounding_cell_keys(world_obj, vector=None, x_s=-1, x_m=1, y_s=-1, y_m=1):
        if not vector:
            vector = world_obj.location
        near_cell_keys = set()

        for x in range(x_s, x_m + 1):
            for y in range(y_s, y_m + 1):
                cell_coords = GridManager.get_cell_key(
                    Vector(vector.x + (x * CELL_SIZE), vector.y + (y * CELL_SIZE), 0),
                    world_obj.map_)
                if cell_coords in CELLS:
                    near_cell_keys.add(cell_coords)

        return near_cell_keys

    @staticmethod
    def get_surrounding_cells_by_cell(cell):
        mid_x = (cell.min_x + cell.max_x) / 2
        mid_y = (cell.min_y + cell.max_y) / 2
        vector = Vector(mid_x, mid_y)
        return GridManager.get_surrounding_cells_by_location(vector, cell.map_)

    @staticmethod
    def get_surrounding_cells_by_object(world_obj, x_s=-1, x_m=1, y_s=-1, y_m=1):
        vector = world_obj.location
        return GridManager.get_surrounding_cells_by_location(vector, world_obj.map_, x_s=x_s, x_m=x_m, y_s=y_s, y_m=y_m)

    @staticmethod
    def get_surrounding_cells_by_location(location, map_, x_s=-1, x_m=1, y_s=-1, y_m=1):
        near_cells = set()

        for x in range(x_s, x_m + 1):
            for y in range(y_s, y_m + 1):
                cell_coords = GridManager.get_cell_key(
                    Vector(location.x + (x * CELL_SIZE), location.y + (y * CELL_SIZE), 0), map_)
                if cell_coords in CELLS:
                    near_cells.add(CELLS[cell_coords])

        return near_cells

    @staticmethod
    def send_surrounding(packet, world_obj, include_self=True, exclude=None, use_ignore=False):
        for cell in GridManager.get_surrounding_cells_by_object(world_obj):
            cell.send_all(packet, source=None if include_self else world_obj, exclude=exclude, use_ignore=use_ignore)

    @staticmethod
    def send_surrounding_in_range(packet, world_obj, range_, include_self=True, exclude=None, use_ignore=False):
        for cell in GridManager.get_surrounding_cells_by_object(world_obj):
            cell.send_all_in_range(packet, range_, world_obj, include_self, exclude, use_ignore)

    @staticmethod
    def get_surrounding_objects(world_obj, object_types):
        surrounding_objects = [{}, {}, {}]
        for cell in GridManager.get_surrounding_cells_by_object(world_obj):
            if ObjectTypes.TYPE_PLAYER in object_types:
                surrounding_objects[0] = {**surrounding_objects[0], **cell.players}
            if ObjectTypes.TYPE_UNIT in object_types:
                surrounding_objects[1] = {**surrounding_objects[1], **cell.creatures}
            if ObjectTypes.TYPE_GAMEOBJECT in object_types:
                surrounding_objects[2] = {**surrounding_objects[2], **cell.gameobjects}

        return surrounding_objects

    @staticmethod
    def get_surrounding_players(world_obj):
        return GridManager.get_surrounding_objects(world_obj, [ObjectTypes.TYPE_PLAYER])[0]

    @staticmethod
    def get_surrounding_units(world_obj, include_players=False):
        object_types = [ObjectTypes.TYPE_PLAYER, ObjectTypes.TYPE_UNIT] if include_players else [ObjectTypes.TYPE_UNIT]
        res = GridManager.get_surrounding_objects(world_obj, object_types)
        if include_players:
            return res[0], res[1]
        else:
            return res[1]

    @staticmethod
    def get_surrounding_gameobjects(world_obj):
        return GridManager.get_surrounding_objects(world_obj, [ObjectTypes.TYPE_GAMEOBJECT])[2]

    @staticmethod
    def get_surrounding_player_by_guid(world_obj, guid):
        for p_guid, player in list(GridManager.get_surrounding_players(world_obj).items()):
            if p_guid == guid:
                return player
        return None

    @staticmethod
    def get_surrounding_unit_by_guid(world_obj, guid, include_players=False):
        surrounding_units = GridManager.get_surrounding_units(world_obj, include_players)
        if include_players:
            for p_guid, player in list(surrounding_units[0].items()):
                if p_guid == guid:
                    return player

        creature_dict = surrounding_units[1] if include_players else surrounding_units
        for u_guid, unit in list(creature_dict.items()):
            if u_guid == guid:
                return unit

        return None

    @staticmethod
    def get_surrounding_gameobject_by_guid(world_obj, guid):
        for g_guid, gameobject in list(GridManager.get_surrounding_gameobjects(world_obj).items()):
            if g_guid == guid:
                return gameobject
        return None

    @staticmethod
    def generate_coord_data(vector):
        mod_x = vector.x / CELL_SIZE
        mod_y = vector.y / CELL_SIZE

        max_x = math.ceil(mod_x) * CELL_SIZE - TOLERANCE
        max_y = math.ceil(mod_y) * CELL_SIZE - TOLERANCE
        min_x = max_x - CELL_SIZE + TOLERANCE
        min_y = max_y - CELL_SIZE + TOLERANCE

        return min_x, min_y, max_x, max_y

    @staticmethod
    def get_cell_key(vector, map_):
        min_x, min_y, max_x, max_y = GridManager.generate_coord_data(vector)
        key = f'{round(min_x, 5)}:{round(min_y, 5)}:{round(max_x, 5)}:{round(max_y, 5)}:{map_}'

        return key

    @staticmethod
    def get_cells():
        return CELLS

    @staticmethod
    def update_creatures():
        for key in list(GridManager.ACTIVE_CELL_KEYS):
            cell = CELLS[key]
            for guid, creature in list(cell.creatures.items()):
                creature.update()

    @staticmethod
    def update_gameobjects():
        for key in list(GridManager.ACTIVE_CELL_KEYS):
            cell = CELLS[key]
            for guid, gameobject in list(cell.gameobjects.items()):
                gameobject.update()


class Cell(object):
    def __init__(self, min_x=0.0, min_y=0.0, max_x=0.0, max_y=0.0, map_=0.0, gameobjects=None,
                 creatures=None, players=None, key=''):
        self.min_x = min_x
        self.min_y = min_y
        self.max_x = max_x
        self.max_y = max_y
        self.map_ = map_
        self.key = key
        self.gameobjects = gameobjects
        self.creatures = creatures
        self.players = players

        if not key:
            self.key = f'{round(self.min_x, 5)}:{round(self.min_y, 5)}:{round(self.max_x, 5)}:{round(self.max_y, 5)}:{self.map_}'

        if not gameobjects:
            self.gameobjects = dict()
        if not creatures:
            self.creatures = dict()
        if not players:
            self.players = dict()

    def has_players(self):
        return len(self.players) > 0

    def contains(self, world_obj=None, vector=None, map_=None):
        if world_obj:
            vector = world_obj.location
            map_ = world_obj.map_

        if vector and map_:
            return self.min_x <= round(vector.x, 5) <= self.max_x and self.min_y <= round(vector.y, 5) <= self.max_y \
                   and map_ == self.map_
        return False

    def add(self, world_obj):
        if world_obj.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players[world_obj.guid] = world_obj
            # Set this Cell and surrounding ones as Active
            for cell_key in list(GridManager.get_surrounding_cell_keys(world_obj)):
                GridManager.ACTIVE_CELL_KEYS.add(cell_key)

            # If needed or enabled, load corresponding mmap for active grid and adjacent.
            GridManager.load_mmaps_for_active_cells()
        elif world_obj.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures[world_obj.guid] = world_obj
        elif world_obj.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects[world_obj.guid] = world_obj

        world_obj.current_cell = self.key

    def remove(self, world_obj):
        if world_obj.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players.pop(world_obj.guid, None)
        elif world_obj.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures.pop(world_obj.guid, None)
        elif world_obj.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects.pop(world_obj.guid, None)

    def send_all(self, packet, source=None, exclude=None, use_ignore=False):
        for guid, player_mgr in list(self.players.items()):
            if player_mgr.online:
                if source and player_mgr.guid == source.guid:
                    continue
                if exclude and player_mgr.guid in exclude:
                    continue
                if use_ignore and source and player_mgr.friends_manager.has_ignore(source.guid):
                    continue

                player_mgr.session.enqueue_packet(packet)

    def send_all_in_range(self, packet, range_, source, include_self=True, exclude=None, use_ignore=False):
        if range_ <= 0:
            self.send_all(packet, source, exclude)
        else:
            for guid, player_mgr in list(self.players.items()):
                if player_mgr.online and player_mgr.location.distance(source.location) <= range_:
                    if not include_self and player_mgr.guid == source.guid:
                        continue
                    if use_ignore and player_mgr.friends_manager.has_ignore(source.guid):
                        continue

                    player_mgr.session.enqueue_packet(packet)
