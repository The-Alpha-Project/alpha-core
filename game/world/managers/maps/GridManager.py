from __future__ import annotations
from threading import RLock
import time
from game.world.managers.maps.Cell import Cell
from game.world.managers.maps.helpers.CellUtils import CELL_SIZE, CellUtils, VIEW_DISTANCE, NUM_CELLS
from game.world.managers.maps.helpers.MapUtils import MapUtils
from game.world.managers.maps.DetectionManager import DetectionManager
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds


class GridManager:
    def __init__(self, map_, map_id, instance_id, active_cell_callback, inactive_cell_callback):
        self.map_ = map_
        self.map_id = map_id
        self.grid_lock = RLock()
        self.instance_id = instance_id
        self.active_cell_keys: set[str] = set()
        self.cells: dict[str, Cell] = {}
        self.active_adt_cell_refs: dict[str, set[str]] = {}
        self.active_cell_callback = active_cell_callback
        self.inactive_cell_callback = inactive_cell_callback
        self.detection_manager = DetectionManager(self)

    def spawn_object(self, owner=None, instance=None):
        if instance:
            self._add_world_object(instance)
        if owner:
            self._add_world_object_spawn(owner)
        if not owner and not instance:
            Logger.warning(f'Spawn object called with None arguments.')

    def update_object(self, world_object, has_changes=False, has_inventory_changes=False):
        source_cell_key = world_object.current_cell
        current_cell_key = CellUtils.get_cell_key_for_object(world_object)
        cell_swap = source_cell_key is not None and current_cell_key != source_cell_key

        # Handle cell change within the same map.
        if current_cell_key != source_cell_key:
            # Players will always query all surrounding objects. Any other object caller will trigger
            # an update upon players based only on its type. (Unit, Go, Corpse, etc)
            object_type = world_object.get_type_id()
            if object_type == ObjectTypeIds.ID_PLAYER:
                object_type = None

            # Add to a new cell.
            self._add_world_object(world_object, update_players=False, is_update=True)
            # Remove from old cell.
            if source_cell_key:
                self.remove_object(world_object, update_players=False, from_cell=source_cell_key, is_update=True)
            # Update old location surroundings, even if in the same grid, both cells quadrants might not see each other.
            affected_cells = self._update_players_surroundings(source_cell_key, object_type=object_type)
            # Update new location surroundings, excluding intersecting cells from previous call.
            self._update_players_surroundings(current_cell_key, exclude_cells=affected_cells, object_type=object_type)

        # If this world object has pending field/inventory updates, trigger an update on interested players.
        if has_changes or has_inventory_changes:
            update_data = None
            if has_changes:
                # Grab the current state of this world object update fields mask and values,
                # which will be used for all interested requesters.
                update_data = world_object.update_packet_factory.generate_update_data(flush_current=True)

            self._update_players_surroundings(current_cell_key, world_object=world_object, has_changes=has_changes,
                                              has_inventory_changes=has_inventory_changes, update_data=update_data)
            # At this point all player observers updated this world object, reset update fields bit masks.
            if has_inventory_changes:
                world_object.inventory.reset_fields_older_than(time.time())

        # Notify cell changed if needed.
        if current_cell_key != source_cell_key:
            if current_cell_key not in self.active_cell_keys and cell_swap:
                self.activate_cell_by_world_object(world_object)
                adt_x, adt_y = MapUtils.get_tile(world_object.location.x, world_object.location.y)
                Logger.debug(f'Unit {world_object.get_name()} triggered inactive cell {current_cell_key} '
                             f'at ADT {adt_x},{adt_y}')
            world_object.on_cell_change()

    # Remove a world_object from its cell and notify surrounding players if required.
    def remove_object(self, world_object, update_players=True, from_cell=None, is_update=False):
        cell = self.cells.get(from_cell if from_cell else world_object.current_cell)
        if cell and cell.remove(world_object):
            if not is_update and world_object.is_player():
                self.detection_manager.queue_remove(world_object)
            if update_players:
                self._update_players_surroundings(cell.key, object_type=world_object.get_type_id())

    def unit_should_relocate(self, world_object, destination, destination_map, destination_instance):
        destination_cells = self._get_surrounding_cells_by_location(destination.x, destination.y, destination_map,
                                                                    destination_instance)
        current_cell = self.get_cells()[world_object.current_cell]
        return current_cell in destination_cells

    def is_active_cell(self, cell_key):
        return cell_key in self.active_cell_keys

    def is_active_cell_for_location(self, location):
        cell_key = CellUtils.get_cell_key_by_world_pos(location.x, location.y, self.map_id, self.instance_id)
        return self.is_active_cell(cell_key)

    def get_active_cell_count(self):
        return len(self.active_cell_keys)

    def deactivate_cells(self):
        with self.grid_lock:
            for cell_key in list(self.active_cell_keys):

                # Make sure only Cells with no players near are removed from the Active list.
                if any(not cell.can_deactivate() for cell in self._get_surrounding_cells_by_cell(self.cells[cell_key])):
                    continue

                cell = self.cells[cell_key]
                self.active_cell_keys.discard(cell_key)
                cell.stop_movement()

                if cell.adt_key in self.active_adt_cell_refs:
                    self.active_adt_cell_refs[cell.adt_key].discard(cell.key)

            for adt_key, ref_count in list(self.active_adt_cell_refs.items()):
                # If an active cell still using the adt, continue.
                if ref_count:
                    continue
                del self.active_adt_cell_refs[adt_key]
                # No active cells for given adt, unload.
                adt_x, adt_y = adt_key.split(',')
                self.inactive_cell_callback(self.map_id, int(adt_x), int(adt_y))

    def _add_world_object_spawn(self, world_object_spawn):
        cell = self._get_create_cell(world_object_spawn.location, world_object_spawn.map_id,
                                     world_object_spawn.instance_id)
        cell.add_world_object_spawn(world_object_spawn)

    def _add_world_object(self, world_object, update_players=True, is_update=False):
        cell: Cell = self._get_create_cell(world_object.location, world_object.map_id, world_object.instance_id)
        cell.add_world_object(world_object)

        if world_object.is_player() or world_object.is_temp_summon_or_pet_or_guardian():
            self.activate_cell_by_world_object(world_object, load_tile_data=True)

        # Notify surrounding players.
        if update_players:
            # Immediately notify temporary summons, pets and guardians to players.
            if world_object.is_temp_summon_or_pet_or_guardian():
                self._update_players_surroundings(cell.key, world_object=world_object, has_changes=True)
            # Enqueue for lazy update by object type.
            else:
                self._update_players_surroundings(cell.key, object_type=world_object.get_type_id())

    def activate_cell_by_world_object(self, world_object, load_tile_data=False):
        # Surrounding cells.
        affected_cells = set(self._get_surrounding_cells_by_cell(self.cells[world_object.current_cell]))
        # Self cell.
        affected_cells.add(self.cells[world_object.current_cell])
        self._activate_cells(affected_cells, load_tile_data)

    def _activate_cells(self, cells: set[Cell], load_tile_data=False):
        with self.grid_lock:
            [self._activate_cell(cell, load_tile_data) for cell in cells]

    def _activate_cell(self, cell, load_tile_data=False):
        if cell.key in self.active_cell_keys:
            return

        self.active_cell_keys.add(cell.key)

        # Tile/nav loading.
        if not load_tile_data:
            return

        # Initialize ref count for this adt if needed.
        if cell.adt_key in self.active_adt_cell_refs:
            return

        self.active_adt_cell_refs[cell.adt_key] = set()
        self.active_adt_cell_refs[cell.adt_key].add(cell.key)
        self.active_cell_callback(self.map_id, cell.adt_x, cell.adt_y)

    def _update_players_surroundings(self, cell_key, exclude_cells=None, world_object=None, has_changes=False,
                                     has_inventory_changes=False, update_data=None, object_type=None):
        # Avoid update calls if no players are present.
        if exclude_cells is None:
            exclude_cells = set()
        if len(self.active_cell_keys) == 0:
            return set()

        affected_cells = set()
        source_cell = self.cells.get(cell_key)
        if source_cell:
            for cell in self._get_surrounding_cells_by_cell(source_cell):
                if cell in exclude_cells:
                    continue
                cell.update_players_surroundings(world_object=world_object, has_changes=has_changes,
                                                 has_inventory_changes=has_inventory_changes, update_data=update_data,
                                                 object_type=object_type)
                affected_cells.add(cell)

        return affected_cells

    def _get_surrounding_cells_by_cell(self, cell=None, cell_x=0, cell_y=0, map_id=0, instance_id=0, range_=0):
        if cell:
            cell_x = cell.cell_x
            cell_y = cell.cell_y
            map_id = cell.map_id
            instance_id = cell.instance_id

        view_distance = VIEW_DISTANCE if not range_ else range_
        # Calculate how many cells to include in each direction given the view distance, at least 1.
        max_cells_radius = max(1, int(view_distance // CELL_SIZE))
        surrounding_cells = set()

        for dx in range(-max_cells_radius, max_cells_radius + 1):
            for dy in range(-max_cells_radius, max_cells_radius + 1):
                nx = cell_x + dx
                ny = cell_y + dy
                # Clamp to valid range.
                nx_clamped = max(0, min(NUM_CELLS - 1, nx))
                ny_clamped = max(0, min(NUM_CELLS - 1, ny))
                cell_key = CellUtils.get_cell_key_by_cell(nx_clamped, ny_clamped, map_id, instance_id)
                if cell_key not in self.cells:
                    continue
                surrounding_cells.add(self.cells[cell_key])

        return surrounding_cells

    def _get_surrounding_cells_by_object(self, world_object, range_=0):
        pos = world_object.location
        return self._get_surrounding_cells_by_location(
            pos.x, pos.y, world_object.map_id, world_object.instance_id, range_=range_)

    def _get_surrounding_cells_by_location(self, x, y, map_, instance_id, range_=0):
        cell_x, cell_y = CellUtils.generate_coord_data(x, y)
        return self._get_surrounding_cells_by_cell(cell_x=cell_x, cell_y=cell_y, map_id=map_,
                                                   instance_id=instance_id, range_=range_)

    def send_surrounding(self, packet, world_object, include_self=True, exclude=None, use_ignore=False):
        if world_object.current_cell:
            for cell in self._get_surrounding_cells_by_object(world_object):
                cell.send_all(packet, world_object, include_source=include_self, exclude=exclude, use_ignore=use_ignore)
        # This player has no current cell, send the message directly.
        elif world_object.is_player() and include_self:
            world_object.enqueue_packet(packet)

    def send_surrounding_in_range(self, packet, world_object, range_, include_self=True, exclude=None,
                                  use_ignore=False):
        if not world_object.current_cell:
            Logger.warning(f'{world_object.get_name()} Cannot send surrounding in range without current cell.')
            return

        for cell in self._get_surrounding_cells_by_object(world_object, range_=range_):
            cell.send_all_in_range(packet, range_, world_object, include_self, exclude, use_ignore)

    def get_surrounding_objects(self, world_object, object_types):
        found_objects = []

        players_index = 0
        creatures_index = 0
        gameobject_index = 0
        dynamic_index = 0
        corpse_index = 0
        # Resolve return collection and indexes dynamically.
        for index in range(len(object_types)):
            found_objects.append(dict())
            if object_types[index] == ObjectTypeIds.ID_PLAYER:
                players_index = index
            elif object_types[index] == ObjectTypeIds.ID_UNIT:
                creatures_index = index
            elif object_types[index] == ObjectTypeIds.ID_GAMEOBJECT:
                gameobject_index = index
            elif object_types[index] == ObjectTypeIds.ID_DYNAMICOBJECT:
                dynamic_index = index
            elif object_types[index] == ObjectTypeIds.ID_CORPSE:
                corpse_index = index

        # Original surrounding cells for requester.
        cells = self._get_surrounding_cells_by_object(world_object)

        # Handle Far Sight.
        if world_object.is_player():
            camera = FarSightManager.get_camera_for_player(world_object)
            # If the player has a camera object, aggregate camera cells.
            if camera:
                cells.update(self._get_surrounding_cells_by_object(camera.world_object))

        for cell in cells:
            if ObjectTypeIds.ID_PLAYER in object_types:
                found_objects[players_index] = {**found_objects[players_index], **cell.players}
            if ObjectTypeIds.ID_UNIT in object_types:
                found_objects[creatures_index] = {**found_objects[creatures_index], **cell.creatures}
            if ObjectTypeIds.ID_GAMEOBJECT in object_types:
                found_objects[gameobject_index] = {**found_objects[gameobject_index], **cell.gameobjects}
            if ObjectTypeIds.ID_DYNAMICOBJECT in object_types:
                found_objects[dynamic_index] = {**found_objects[dynamic_index], **cell.dynamic_objects}
            if ObjectTypeIds.ID_CORPSE in object_types:
                found_objects[corpse_index] = {**found_objects[corpse_index], **cell.corpses}

        return found_objects

    def get_surrounding_players(self, world_object):
        return self.get_surrounding_objects(world_object, [ObjectTypeIds.ID_PLAYER])[0]

    def get_surrounding_units(self, world_object, include_players=False):
        object_types = [ObjectTypeIds.ID_PLAYER, ObjectTypeIds.ID_UNIT] if include_players else [ObjectTypeIds.ID_UNIT]
        res = self.get_surrounding_objects(world_object, object_types)
        if include_players:
            return res[0], res[1]
        else:
            return res[0]

    def get_creature_spawn_by_id(self, spawn_id):
        for cell in set(self.cells.values()):
            spawn_found = cell.creatures_spawns.get(spawn_id)
            if spawn_found:
                return spawn_found
        return None

    def get_gameobject_spawn_by_id(self, spawn_id):
        for cell in set(self.cells.values()):
            spawn_found = cell.gameobject_spawns.get(spawn_id)
            if spawn_found:
                return spawn_found
        return None

    def _get_surrounding_creature_spawns(self, world_object):
        spawns = dict()
        location = world_object.location
        cells = self._get_surrounding_cells_by_location(location.x, location.y, world_object.map_id,
                                                        world_object.instance_id)

        for cell in cells:
            for spawn_id, spawn in list(cell.creatures_spawns.items()):
                spawns[spawn_id] = spawn
        return spawns

    def get_surrounding_units_by_location(self, vector, target_map, target_instance, range_, include_players=False):
        units = [{}, {}]
        for cell in self._get_surrounding_cells_by_location(vector.x, vector.y, target_map, target_instance):
            for guid, creature in list(cell.creatures.items()):
                if creature.location.distance(vector) <= range_:
                    units[0][guid] = creature
            if not include_players:
                continue
            for guid, player in list(cell.players.items()):
                if player.location.distance(vector) <= range_:
                    units[1][guid] = player
        return units

    def get_surrounding_players_by_location(self, vector, target_map, target_instance, range_):
        players = {}
        for cell in self._get_surrounding_cells_by_location(vector.x, vector.y, target_map, target_instance):
            for guid, player in list(cell.players.items()):
                if player.location.distance(vector) <= range_:
                    players[guid] = player
        return players

    def get_surrounding_gameobjects(self, world_object):
        return self.get_surrounding_objects(world_object, [ObjectTypeIds.ID_GAMEOBJECT])[0]

    def _get_surrounding_gameobjects_spawns(self, world_object):
        spawns = {}
        location = world_object.location
        surrounding_cells = self._get_surrounding_cells_by_location(location.x, location.y, world_object.map_id,
                                                                    world_object.instance_id)
        for cell in surrounding_cells:
            for spawn_id, spawn in list(cell.gameobject_spawns.items()):
                spawns[spawn_id] = spawn
        return spawns

    def get_surrounding_player_by_guid(self, world_object, guid):
        surrounding_players = self.get_surrounding_players(world_object)
        try:
            return surrounding_players[guid]
        except KeyError:
            return None

    def get_surrounding_unit_by_guid(self, world_object, guid, include_players=False):
        surrounding_units = self.get_surrounding_units(world_object, include_players)
        if include_players and guid in surrounding_units[0]:
            return surrounding_units[0][guid]

        creature_dict = surrounding_units[1] if include_players else surrounding_units
        try:
            return creature_dict[guid]
        except KeyError:
            return None

    def get_surrounding_creature_spawn_by_spawn_id(self, world_object, spawn_id):
        surrounding_units_spawns = self._get_surrounding_creature_spawns(world_object)
        try:
            return surrounding_units_spawns[spawn_id]
        except KeyError:
            return None

    def get_surrounding_gameobject_by_guid(self, world_object, guid):
        surrounding_gameobjects = self.get_surrounding_gameobjects(world_object)
        try:
            return surrounding_gameobjects[guid]
        except KeyError:
            return None

    def get_surrounding_gameobject_spawn_by_spawn_id(self, world_object, spawn_id_):
        surrounding_gameobjects_spawns = self._get_surrounding_gameobjects_spawns(world_object)
        try:
            return surrounding_gameobjects_spawns[spawn_id_]
        except KeyError:
            return None

    def _get_create_cell(self, vector, map_, instance_id) -> Cell:
        cell_key = CellUtils.get_cell_key_by_world_pos(vector.x, vector.y, map_, instance_id)
        cell = self.cells.get(cell_key)
        if not cell:
            cell_x, cell_y = CellUtils.generate_coord_data(vector.x, vector.y)
            cell = Cell(cell_x, cell_y, map_, instance_id)
            self.cells[cell.key] = cell
        return cell

    def get_cells(self):
        return self.cells

    def update_detection_range_collision(self):
        self.detection_manager.update()

    def update_creatures(self):
        with self.grid_lock:
            now = time.time()
            for key in list(self.active_cell_keys):
                self.cells[key].update_creatures(now)

    def update_gameobjects(self):
        with self.grid_lock:
            now = time.time()
            for key in list(self.active_cell_keys):
                self.cells[key].update_gameobjects(now)

    def update_transports(self):
        with self.grid_lock:
            now = time.time()
            for key in list(self.active_cell_keys):
                self.cells[key].update_transports(now)

    def update_dynobjects(self):
        with self.grid_lock:
            now = time.time()
            for key in list(self.active_cell_keys):
                self.cells[key].update_dynobjects(now)

    def update_spawns(self):
        with self.grid_lock:
            now = time.time()
            for key in list(self.active_cell_keys):
                self.cells[key].update_spawns(now)

    def update_corpses(self):
        with self.grid_lock:
            now = time.time()
            for key in list(self.active_cell_keys):
                self.cells[key].update_corpses(now)
