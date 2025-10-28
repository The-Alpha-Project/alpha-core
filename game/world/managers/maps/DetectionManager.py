class DetectionManager:
    def __init__(self, grid_manager):
        self.grid_manager = grid_manager
        self.units = {}  # key: guid, value: unit object.

    def has_unit(self, unit):
        return unit.guid in self.units

    def update(self):
        all_units = [u for u in list(self.units.values()) if self.can_target_unit_for_aggro(u)]
        for unit_a in all_units:
            for unit_b in all_units:
                if unit_b.guid == unit_a.guid:
                    continue
                dist = unit_a.location.distance(unit_b.location)
                detection_range = unit_a.get_detection_range(unit_b)
                if dist > detection_range:
                    continue
                unit_a.notify_move_in_line_of_sight(self.grid_manager.map_, unit_b)

    def can_target_unit_for_aggro(self, unit):
        # Check if unit's cell_key is valid and in active_cells and alive.
        return (unit.current_cell and unit.current_cell in self.grid_manager.active_cell_keys
                and unit.can_be_targeted_for_surrounding_aggro())

    def add(self, unit):
        if not unit.is_unit(by_mask=True):
            return False
        if unit.guid in self.units:
            # Unit already present.
            return False
        self.units[unit.guid] = unit
        return True

    def remove(self, unit):
        if not unit.is_unit(by_mask=True):
            return False
        if unit.guid not in self.units:
            return False
        del self.units[unit.guid]
        return True
