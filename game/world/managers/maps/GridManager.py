import math

from utils.ConfigManager import config
from utils.constants.MiscCodes import ObjectTypes

TOLERANCE = 0.00001
CELL_SIZE = config.Server.Settings.cell_size


class GridManager(object):
    def __init__(self, map_id, active_cell_callback, instance_id=0):
        self.map_id = map_id
        self.instance_id = instance_id
        self.active_cell_keys = set()
        self.cells = dict()
        self.active_cell_callback = active_cell_callback

    def get_create_cell(self, world_object):
        cell_key = GridManager.get_cell_key(world_object.location.x, world_object.location.y, world_object.map_)
        cell = self.cells.get(cell_key)
        if not cell:
            min_x, min_y, max_x, max_y = GridManager.generate_coord_data(world_object.location.x, world_object.location.y)
            cell = Cell(min_x, min_y, max_x, max_y, world_object.map_)
            self.cells[cell.key] = cell
        return cell

    def update_object(self, world_object, old_grid_manager):
        source_cell_key = world_object.current_cell
        current_cell_key = GridManager.get_cell_key(world_object.location.x, world_object.location.y, world_object.map_)

        # Handle teleport between different maps.
        if old_grid_manager and old_grid_manager != self:
            # Remove from old location.
            old_grid_manager.remove_object(world_object)
            # Add to new location.
            self.add_object(world_object)
            # Update old location surrounding players.
            old_grid_manager.update_players(source_cell_key)
            # Update new location surrounding players.
            self.update_players(current_cell_key)
        # Handle cell change within the same map.
        elif current_cell_key != source_cell_key:
            # Remove from old location and Add to new location.
            self.remove_object(world_object, update_players=False)
            self.add_object(world_object, update_players=False)
            # Update old location surroundings, even if in the same grid, both cells quadrants might not see each other.
            self.update_players(source_cell_key)
            # Update new location surroundings.
            self.update_players(current_cell_key)

        # Notify cell changed if needed.
        if old_grid_manager and old_grid_manager != self or current_cell_key != source_cell_key:
            world_object.on_cell_change()

    def add_object(self, world_object, update_players=True):
        cell = self.get_create_cell(world_object)
        cell.add(self, world_object)

        if world_object.get_type() == ObjectTypes.TYPE_PLAYER:
            # Initialize map tiles for this player if needed.
            if cell.key not in self.active_cell_keys:
                self.active_cell_callback(world_object)
            # Set this Cell and surrounding ones as Active if needed.
            for cell in list(self.get_surrounding_cells_by_object(world_object)):
                if cell.key not in self.active_cell_keys:
                    # Load tile maps of adjacent cells if there's at least one creature on them.
                    for creature in list(cell.creatures.values()):
                        self.active_cell_callback(creature)
                    self.active_cell_keys.add(cell.key)

        # Notify surrounding players.
        if update_players:
            self.update_players(cell.key)

    def remove_object(self, world_object, update_players=True):
        cell = self.cells.get(world_object.current_cell)
        if cell:
            cell.remove(world_object)
            # Notify surrounding players.
            if update_players:
                self.update_players(cell.key)

    def update_players(self, cell_key):
        # Avoid update calls if no players are present.
        if len(self.active_cell_keys) == 0:
            return

        source_cell = self.cells.get(cell_key)
        if source_cell:
            for cell in self.get_surrounding_cells_by_cell(source_cell):
                cell.update_players()

    def is_active_cell(self, cell_key):
        return cell_key in self.active_cell_keys

    # TODO: Should cleanup loaded tiles for deactivated cells.
    def deactivate_cells(self):
        for cell_key in list(self.active_cell_keys):
            players_near = False
            for cell in self.get_surrounding_cells_by_cell(self.cells[cell_key]):
                if cell.has_players():
                    players_near = True
                    break

            # Make sure only Cells with no players near are removed from the Active list.
            if not players_near:
                self.active_cell_keys.discard(cell_key)

    def get_surrounding_cell_keys(self, world_object, vector=None, x_s=-1, x_m=1, y_s=-1, y_m=1):
        if not vector:
            vector = world_object.location
        near_cell_keys = set()

        for x in range(x_s, x_m + 1):
            for y in range(y_s, y_m + 1):
                cell_coords = GridManager.get_cell_key(vector.x + (x * CELL_SIZE), vector.y + (y * CELL_SIZE),
                                                       world_object.map_)
                if cell_coords in self.cells:
                    near_cell_keys.add(cell_coords)

        return near_cell_keys

    def get_surrounding_cells_by_cell(self, cell):
        mid_x = (cell.min_x + cell.max_x) / 2
        mid_y = (cell.min_y + cell.max_y) / 2
        return self.get_surrounding_cells_by_location(mid_x, mid_y, cell.map_)

    def get_surrounding_cells_by_object(self, world_object, x_s=-1, x_m=1, y_s=-1, y_m=1):
        vector = world_object.location
        return self.get_surrounding_cells_by_location(vector.x, vector.y, world_object.map_, x_s=x_s, x_m=x_m, y_s=y_s, y_m=y_m)

    def get_surrounding_cells_by_location(self, x, y, map_, x_s=-1, x_m=1, y_s=-1, y_m=1):
        near_cells = set()

        for x2 in range(x_s, x_m + 1):
            for y2 in range(y_s, y_m + 1):
                cell_coords = GridManager.get_cell_key(x + (x2 * CELL_SIZE), y + (y2 * CELL_SIZE), map_)
                if cell_coords in self.cells:
                    near_cells.add(self.cells[cell_coords])

        return near_cells

    def send_surrounding(self, packet, world_object, include_self=True, exclude=None, use_ignore=False):
        for cell in self.get_surrounding_cells_by_object(world_object):
            cell.send_all(packet, source=None if include_self else world_object, exclude=exclude, use_ignore=use_ignore)

    def send_surrounding_in_range(self, packet, world_object, range_, include_self=True, exclude=None, use_ignore=False):
        for cell in self.get_surrounding_cells_by_object(world_object):
            cell.send_all_in_range(
                packet, range_, world_object, include_self, exclude, use_ignore)

    def get_surrounding_objects(self, world_object, object_types):
        surrounding_objects = [{}, {}, {}]
        for cell in self.get_surrounding_cells_by_object(world_object):
            if ObjectTypes.TYPE_PLAYER in object_types:
                surrounding_objects[0] = { **surrounding_objects[0], **cell.players}
            if ObjectTypes.TYPE_UNIT in object_types:
                surrounding_objects[1] = {**surrounding_objects[1], **cell.creatures}
            if ObjectTypes.TYPE_GAMEOBJECT in object_types:
                surrounding_objects[2] = {**surrounding_objects[2], **cell.gameobjects}

        return surrounding_objects

    def get_surrounding_players(self, world_object):
        return self.get_surrounding_objects(world_object, [ObjectTypes.TYPE_PLAYER])[0]

    def get_surrounding_units(self, world_object, include_players=False):
        object_types = [ObjectTypes.TYPE_PLAYER, ObjectTypes.TYPE_UNIT] if include_players else [ObjectTypes.TYPE_UNIT]
        res = self.get_surrounding_objects(world_object, object_types)
        if include_players:
            return res[0], res[1]
        else:
            return res[1]

    def get_surrounding_units_by_location(self, vector, target_map, range_, include_players=False):
        units = [{}, {}]
        for cell in self.get_surrounding_cells_by_location(vector.x, vector.y, target_map):
            for guid, creature in list(cell.creatures.items()):
                if creature.location.distance(vector) <= range_:
                    units[0][guid] = creature
            if not include_players:
                continue
            for guid, player in list(cell.players.items()):
                if player.location.distance(vector) <= range_:
                    units[1][guid] = player
        return units

    def get_surrounding_gameobjects(self, world_object):
        return self.get_surrounding_objects(world_object, [ObjectTypes.TYPE_GAMEOBJECT])[2]

    def get_surrounding_player_by_guid(self, world_object, guid):
        for p_guid, player in list(self.get_surrounding_players(world_object).items()):
            if p_guid == guid:
                return player
        return None

    def get_surrounding_unit_by_guid(self, world_object, guid, include_players=False):
        surrounding_units = self.get_surrounding_units(world_object, include_players)
        if include_players:
            for p_guid, player in list(surrounding_units[0].items()):
                if p_guid == guid:
                    return player

        creature_dict = surrounding_units[1] if include_players else surrounding_units
        for u_guid, unit in list(creature_dict.items()):
            if u_guid == guid:
                return unit

        return None

    def get_surrounding_gameobject_by_guid(self, world_object, guid):
        for g_guid, gameobject in list(self.get_surrounding_gameobjects(world_object).items()):
            if g_guid == guid:
                return gameobject
        return None

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
    def get_cell_key(x, y, map_):
        min_x, min_y, max_x, max_y = GridManager.generate_coord_data(x, y)
        key = f'{round(min_x, 5)}:{round(min_y, 5)}:{round(max_x, 5)}:{round(max_y, 5)}:{map_}'

        return key

    def get_cells(self):
        return self.cells

    def update_creatures(self):
        for key in list(self.active_cell_keys):
            cell = self.cells[key]
            for guid, creature in list(cell.creatures.items()):
                creature.update()

    def update_gameobjects(self):
        for key in list(self.active_cell_keys):
            cell = self.cells[key]
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

    def contains(self, world_object=None, vector=None, map_=None):
        if world_object:
            vector = world_object.location
            map_ = world_object.map_

        if vector and map_:
            return self.min_x <= round(vector.x, 5) <= self.max_x and self.min_y <= round(vector.y, 5) <= self.max_y \
                and map_ == self.map_
        return False

    def add(self, grid_manager, world_object):
        # Update world_object cell so the below messages affect the new cell surroundings.
        world_object.current_cell = self.key

        if world_object.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players[world_object.guid] = world_object
        elif world_object.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures[world_object.guid] = world_object
        elif world_object.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects[world_object.guid] = world_object

    # Make each player update its surroundings, adding or removing world objects as needed.
    def update_players(self):
        for player in list(self.players.values()):
            player.update_surrounding_on_me()

    def remove(self, world_object):
        if world_object.get_type() == ObjectTypes.TYPE_PLAYER:
            self.players.pop(world_object.guid, None)
        elif world_object.get_type() == ObjectTypes.TYPE_UNIT:
            self.creatures.pop(world_object.guid, None)
        elif world_object.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            self.gameobjects.pop(world_object.guid, None)

    def send_all(self, packet, source=None, exclude=None, use_ignore=False):
        for guid, player_mgr in list(self.players.items()):
            if player_mgr.online:
                if source and player_mgr.guid == source.guid:
                    continue
                if exclude and player_mgr.guid in exclude:
                    continue
                if use_ignore and source and player_mgr.friends_manager.has_ignore(source.guid):
                    continue

                player_mgr.enqueue_packet(packet)

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

                    player_mgr.enqueue_packet(packet)
