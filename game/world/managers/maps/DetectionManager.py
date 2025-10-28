from game.world.managers.maps.helpers.BoundingBox import BoundingBox
from game.world.managers.maps.helpers.CellUtils import VIEW_DISTANCE, ORIGIN
from game.world.managers.maps.helpers.QuadTree import QuadTree


class DetectionManager:
    def __init__(self, grid_manager):
        self.grid_manager = grid_manager
        self.units = {}  # key: guid, value: unit object.
        self.world_bounds = BoundingBox(x=-ORIGIN, y=-ORIGIN, width=ORIGIN * 2, height=ORIGIN * 2)
        self.quadtree = QuadTree(self.world_bounds, 4)

    def has_unit(self, unit):
        return unit.guid in self.units

    def update(self):
        all_units = [u for u in list(self.units.values()) if self.can_target_unit_for_aggro(u)]
        for unit_a in all_units:
            # Query potential targets using the search box.
            search_box = unit_a.get_detection_range_box()
            potential_targets_guids = self.quadtree.query_guids(search_box)
            ooc_events = unit_a.object_ai and unit_a.object_ai.ai_event_handler.has_ooc_los_events()

            for unit_b_guid in potential_targets_guids:
                unit_b = self.units.get(unit_b_guid, None)
                if not unit_b or unit_b.guid == unit_a.guid:
                    continue
                # Perform the precise distance check using unit_a's potentially dynamic
                # detection range against unit_b.
                dist = unit_a.location.distance(unit_b.location)
                detection_range = unit_a.get_detection_range(unit_b)
                in_range = dist <= detection_range
                if in_range or ooc_events:
                     unit_a.notify_move_in_line_of_sight(self.grid_manager.map_, unit_b, ooc_events, in_range)

    def can_target_unit_for_aggro(self, unit):
        # Check if unit's cell_key is valid and in active_cells and alive.
        return (unit.current_cell and unit.current_cell in self.grid_manager.active_cell_keys
                and unit.can_be_targeted_for_surrounding_aggro())

    def update_unit_placement(self, unit):
        if not unit.is_unit(by_mask=True):
            return
        if unit.guid not in self.units:
            return
        self.quadtree.update_unit_placement(unit)

    def add(self, unit):
        if not unit.is_unit(by_mask=True):
            return False
        if unit.guid in self.units:
            return False
        self.units[unit.guid] = unit
        self.quadtree.insert_unit(unit)
        return True

    def remove(self, unit):
        if not unit.is_unit(by_mask=True):
            return False
        if unit.guid not in self.units:
            return False
        del self.units[unit.guid]
        self.quadtree.remove_unit(unit)
        return True
