from typing import Dict

from game.world.managers.maps.helpers.BoundingBox import BoundingBox
from game.world.managers.maps.helpers.CellUtils import ORIGIN
from game.world.managers.maps.helpers.QuadTree import QuadTree
from game.world.managers.objects.units.UnitManager import UnitManager


class DetectionManager:
    def __init__(self, grid_manager):
        self.grid_manager = grid_manager
        self.units = {}  # key: guid, value: unit object.
        self.world_bounds = BoundingBox(x=-ORIGIN, y=-ORIGIN, width=ORIGIN * 2, height=ORIGIN * 2)
        self.unit_visibility_bounds = BoundingBox(0, 0, 0, 0)
        self.quadtree = QuadTree(self.world_bounds, self.unit_visibility_bounds, 4)
        self.pending_placement_updates: Dict[int, UnitManager] = {}
        self.pending_adds: Dict[int, UnitManager] = {}
        self.pending_removes: Dict[int, UnitManager] = {}

    def has_unit(self, unit):
        return unit.guid in self.units

    def update(self):
        # Process pending queues.
        self.process_add_batch()
        self.process_remove_batch()
        self.process_update_placement_batch()

        if not self.units:
            return

        all_units = list(self.units.values())
        for unit_a in all_units:
            if not self.is_in_valid_cell(unit_a):
                continue
            # Query potential targets within visibility range using spatial partitioning.
            unit_a.update_visibility_bounds(self.unit_visibility_bounds)
            potential_targets_guids = self.quadtree.query_guids(self.unit_visibility_bounds)
            ooc_events = unit_a.has_ooc_events()

            for unit_b_guid in potential_targets_guids:
                unit_b = self.units.get(unit_b_guid, None)
                if not unit_b or unit_b.guid == unit_a.guid:
                    continue
                if not self.is_in_valid_cell(unit_b):
                    continue
                # Perform the precise distance check using unit_a's potentially dynamic
                # detection range against unit_b.
                dist = unit_a.location.distance(unit_b.location)
                detection_range = unit_a.get_detection_range(unit_b)
                in_range = dist <= detection_range
                if in_range or ooc_events:
                     unit_a.notify_move_in_line_of_sight(self.grid_manager.map_, unit_b, ooc_events, in_range)

    def is_in_valid_cell(self, unit):
        # Check if unit's cell_key is valid and in active_cells.
        return unit.current_cell and unit.current_cell in self.grid_manager.active_cell_keys

    def queue_update_unit_placement(self, unit):
        self.pending_placement_updates[unit.guid] = unit

    def queue_add(self, unit):
        self.pending_adds[unit.guid] = unit

    def queue_remove(self, unit):
        self.pending_removes[unit.guid] = unit

    def process_add_batch(self):
        if not self.pending_adds:
            return
        batch = list(self.pending_adds.values())
        self.pending_adds.clear()
        for unit in batch:
            self._add(unit)

    def process_remove_batch(self):
        if not self.pending_removes:
            return
        batch = list(self.pending_removes.values())
        self.pending_removes.clear()
        for unit_guid in batch:
            self._remove(unit_guid)

    def process_update_placement_batch(self):
        if not self.pending_placement_updates:
            return
        batch = list(self.pending_placement_updates.values())
        self.pending_placement_updates.clear()
        for unit in batch:
            self._update_unit_placement(unit)

    def _update_unit_placement(self, unit):
        if not unit.is_unit(by_mask=True):
            return
        if unit.guid not in self.units:
            return
        self.quadtree.update_unit_placement(unit)

    def _add(self, unit):
        if not unit.is_unit(by_mask=True):
            return False
        if unit.guid in self.units:
            return False
        self.units[unit.guid] = unit
        self.quadtree.insert_unit(unit)
        return True

    def _remove(self, unit):
        if not unit.is_unit(by_mask=True):
            return False
        if unit.guid not in self.units:
            return False
        del self.units[unit.guid]
        self.quadtree.remove_unit(unit.guid)
        return True
