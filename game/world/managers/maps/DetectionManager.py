from functools import lru_cache
from typing import Dict

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.helpers.BoundingBox import BoundingBox
from game.world.managers.maps.helpers.CellUtils import ORIGIN
from game.world.managers.maps.helpers.QuadTree import QuadTree
from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager


# False if units of this faction template can't be hostile to anyone, see ObjectManager._allegiance_status_checker: no
# enemy group, no enemy factions and no reputation (player factions, the only other reputation source, have none).
@lru_cache(maxsize=None)
def faction_can_be_hostile(faction_template_id):
    faction_template = DbcDatabaseManager.FactionTemplateHolder.faction_template_get_by_id(faction_template_id)
    if not faction_template:
        return True
    if (faction_template.EnemyGroup or faction_template.Enemies_1 or faction_template.Enemies_2
            or faction_template.Enemies_3 or faction_template.Enemies_4):
        return True
    faction = DbcDatabaseManager.FactionHolder.faction_get_by_id(faction_template.Faction)
    return not faction or faction.ReputationIndex > -1


class DetectionManager:
    def __init__(self, grid_manager):
        self.grid_manager = grid_manager
        self.units = {}  # key: guid, value: unit object.
        self.world_bounds = BoundingBox(x=-ORIGIN, y=-ORIGIN, width=ORIGIN * 2, height=ORIGIN * 2)
        self.unit_visibility_bounds = BoundingBox(0, 0, 0, 0)
        self.detection_bounds = BoundingBox(0, 0, 0, 0)
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
        active_unit_guids = {unit.guid for unit in all_units if self.is_in_valid_cell(unit)}
        for unit_a in all_units:
            if unit_a.guid not in active_unit_guids:
                continue
            # Players don't generate OOC LoS events.
            if unit_a.is_player():
                continue
            # Query potential targets within visibility range using spatial partitioning.
            ooc_events = unit_a.has_ooc_events()
            if ooc_events:
                unit_a.update_visibility_bounds(self.unit_visibility_bounds)
                search_bounds = self.unit_visibility_bounds
            else:
                # Without out of combat events only units that can attack something hostile act on what they see.
                if not unit_a.threat_manager.can_resolve_target() or not faction_can_be_hostile(unit_a.faction):
                    continue
                # Only units within detection range matter, which is at most 25 yards over the template range.
                search_range = max(unit_a.creature_template.detection_range + 25, 45)
                search_bounds = self.detection_bounds
                search_bounds.x = unit_a.location.x - search_range
                search_bounds.y = unit_a.location.y - search_range
                search_bounds.width = search_bounds.height = search_range * 2
            potential_targets_guids = self.quadtree.query_guids(search_bounds)

            for unit_b_guid in potential_targets_guids:
                unit_b = self.units.get(unit_b_guid, None)
                if not unit_b or unit_b.guid == unit_a.guid:
                    continue
                if unit_b_guid not in active_unit_guids:
                    continue
                # Perform the precise distance check using unit_a's potentially dynamic
                # detection range against unit_b.
                dist = unit_a.location.distance(unit_b.location)
                detection_range = unit_a.get_detection_range(unit_b)
                in_range = dist <= detection_range
                if in_range or ooc_events:
                    unit_a.notify_move_in_line_of_sight(
                        self.grid_manager.map_, unit_b, ooc_events, in_range, distance=dist
                    )

    def is_in_valid_cell(self, unit):
        # Check if unit's cell_key is valid and in active_cells.
        return unit.current_cell and unit.current_cell in self.grid_manager.active_cell_keys

    def queue_update_unit_placement(self, unit):
        self.pending_placement_updates[unit.guid] = unit

    def queue_add(self, unit):
        # A unit can be removed and re-added in the same tick; keep the add.
        self.pending_removes.pop(unit.guid, None)
        self.pending_adds[unit.guid] = unit

    def queue_remove(self, unit):
        self.pending_removes[unit.guid] = unit

    # Other threads queue units while these run, pop one at a time so none queued in between is lost.
    @staticmethod
    def _drain(pending):
        while pending:
            try:
                yield pending.popitem()[1]
            except KeyError:
                return

    def process_add_batch(self):
        for unit in self._drain(self.pending_adds):
            self._add(unit)

    def process_remove_batch(self):
        for unit in self._drain(self.pending_removes):
            # Don't remove creature LoS tracking if any player still knows it and still spawned.
            if isinstance(unit, CreatureManager):
                if unit.is_in_world() and unit.known_players:
                    continue
            self._remove(unit)

    def process_update_placement_batch(self):
        for unit in self._drain(self.pending_placement_updates):
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
