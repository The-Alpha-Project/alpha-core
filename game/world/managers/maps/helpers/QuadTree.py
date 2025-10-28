from game.world.managers.maps.helpers.QuadTreeNode import QuadTreeNode


class QuadTree:
    def __init__(self, world_bounds, capacity):
        self.root = QuadTreeNode(world_bounds, capacity, 0)
        self.all_units = {}

    def insert_unit(self, unit):
        self.all_units[unit.guid] = unit
        leaf_node = self.root.insert(self.all_units, unit)
        if leaf_node:
            unit.quadtree_node = leaf_node

    def remove_unit(self, unit_guid):
        unit_object = self.all_units.get(unit_guid)

        if unit_object:
            unit_object.quadtree_node = None

        self.root.remove(unit_guid)

        if unit_guid in self.all_units:
            del self.all_units[unit_guid]

    def update_unit_placement(self, unit):
        if not unit.has_moved_significantly():
            return
        self.remove_unit(unit.guid)
        self.insert_unit(unit)

    def query_guids(self, search_box):
        found_unit_guids = set()
        self.root.query(self.all_units, search_box, found_unit_guids)
        return found_unit_guids
