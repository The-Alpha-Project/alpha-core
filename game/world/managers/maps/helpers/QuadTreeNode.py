from game.world.managers.maps.helpers.BoundingBox import BoundingBox


class QuadTreeNode:
    __slots__ = ('bounds', 'capacity', 'depth', 'units', 'children')

    def __init__(self, bounds, capacity, depth):
        self.bounds = bounds
        self.capacity = capacity
        self.depth = depth
        self.units = []
        self.children = []

    def insert(self, all_units_dict, unit_object):
        unit_box = unit_object.get_detection_range_box()
        unit_guid = unit_object.guid

        if not self.bounds.intersects(unit_box):
            return None  # Indicate no insertion happened

        if len(self.children) == 0:
            if len(self.units) < self.capacity or self.depth >= 10:
                self.units.append(unit_guid)
                return self  # Return the current leaf node
            else:
                self.subdivide(all_units_dict)
                return self.insert(all_units_dict, unit_object)

        inserted_node = None
        for child in self.children:
            if child.bounds.intersects(unit_box):
                node = child.insert(all_units_dict, unit_object)
                if node:
                    inserted_node = node

        if inserted_node:
            return inserted_node

        # If it wasn't inserted into a child, keep it in the parent.
        self.units.append(unit_guid)
        return self  # Return the current node.

    def subdivide(self, all_units_dict):
        sub_width = self.bounds.width / 2
        sub_height = self.bounds.height / 2
        x = self.bounds.x
        y = self.bounds.y

        self.children.append(QuadTreeNode(BoundingBox(x, y, sub_width, sub_height), self.capacity, self.depth + 1))
        self.children.append(
            QuadTreeNode(BoundingBox(x + sub_width, y, sub_width, sub_height), self.capacity, self.depth + 1))
        self.children.append(
            QuadTreeNode(BoundingBox(x, y + sub_height, sub_width, sub_height), self.capacity, self.depth + 1))
        self.children.append(
            QuadTreeNode(BoundingBox(x + sub_width, y + sub_height, sub_width, sub_height), self.capacity,
                         self.depth + 1))

        units_to_reinsert_guids = self.units
        self.units = []

        for unit_guid in units_to_reinsert_guids:
            unit_object = all_units_dict[unit_guid]
            self.insert(all_units_dict, unit_object)

    def query(self, all_units_dict, search_box, found_unit_guids):
        if not self.bounds.intersects(search_box):
            return

        for unit_guid in self.units:
            unit_object = all_units_dict.get(unit_guid)
            if unit_object and search_box.contains_point(unit_object.location.x, unit_object.location.y):
                found_unit_guids.add(unit_guid)

        for child in self.children:
            child.query(all_units_dict, search_box, found_unit_guids)

    def remove(self, unit_guid):
        if unit_guid in self.units:
            self.units.remove(unit_guid)

        for child in self.children:
            child.remove(unit_guid)
