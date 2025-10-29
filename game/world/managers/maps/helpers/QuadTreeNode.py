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
            return None

        # Check if the unit can be inserted into a child.
        if len(self.children) > 0:
            fits_in_child = False
            for child in self.children:
                if child.bounds.contains_box(unit_box):
                    # If it fits perfectly, insert it into that child and stop.
                    return child.insert(all_units_dict, unit_object)

        # If it doesn't fit in a single child, place it in this node.
        if len(self.children) == 0 and len(self.units) >= self.capacity and self.depth < 10:
            self.subdivide(all_units_dict)
            return self.insert(all_units_dict, unit_object)

        self.units.append(unit_guid)
        return self

    def subdivide(self, all_units_dict):
        sub_width = self.bounds.width / 2
        sub_height = self.bounds.height / 2
        x = self.bounds.x
        y = self.bounds.y

        # Pre-calculate the bounding boxes for each quadrant.
        ne_bounds = BoundingBox(x + sub_width, y, sub_width, sub_height)
        nw_bounds = BoundingBox(x, y, sub_width, sub_height)
        se_bounds = BoundingBox(x + sub_width, y + sub_height, sub_width, sub_height)
        sw_bounds = BoundingBox(x, y + sub_height, sub_width, sub_height)

        # Create the child nodes using the pre-calculated bounding boxes.
        self.children.append(QuadTreeNode(nw_bounds, self.capacity, self.depth + 1))
        self.children.append(QuadTreeNode(ne_bounds, self.capacity, self.depth + 1))
        self.children.append(QuadTreeNode(sw_bounds, self.capacity, self.depth + 1))
        self.children.append(QuadTreeNode(se_bounds, self.capacity, self.depth + 1))

        units_to_reinsert_guids = self.units.copy()
        self.units = []

        for unit_guid in units_to_reinsert_guids:
            unit_object = all_units_dict.get(unit_guid)
            if unit_object:
                unit_object.quadtree_node = None  # Make sure unit is not stuck at Root after division.
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
