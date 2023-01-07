from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from utils.constants.MiscCodes import ObjectTypeIds
from threading import RLock


class Cell:
    def __init__(self, min_x=0.0, min_y=0.0, max_x=0.0, max_y=0.0, map_=0.0, key=''):
        self.min_x = min_x
        self.min_y = min_y
        self.max_x = max_x
        self.max_y = max_y
        self.map_ = map_
        self.key = key
        # Cell lock.
        self.cell_lock = RLock()
        # Instances.
        self.gameobjects = dict()
        self.creatures = dict()
        self.players = dict()
        self.dynamic_objects = dict()
        self.corpses = dict()
        # Spawns.
        self.creatures_spawns = dict()
        self.gameobject_spawns = dict()

        if not key:
            self.key = f'{round(self.min_x, 5)}:{round(self.min_y, 5)}:{round(self.max_x, 5)}:{round(self.max_y, 5)}:{self.map_}'

    def has_players(self):
        return len(self.players) > 0

    def has_cameras(self):
        return FarSightManager.has_camera_in_cell(self)

    def contains(self, world_object=None, vector=None, map_=None):
        if world_object:
            vector = world_object.location
            map_ = world_object.map_

        if vector and map_:
            return self.min_x <= round(vector.x, 5) <= self.max_x and \
                   self.min_y <= round(vector.y, 5) <= self.max_y and \
                   map_ == self.map_
        return False

    def add_world_object_spawn(self, world_object_spawn):
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        if isinstance(world_object_spawn, CreatureSpawn):
            self.creatures_spawns[world_object_spawn.spawn_id] = world_object_spawn
        else:
            self.gameobject_spawns[world_object_spawn.spawn_id] = world_object_spawn

    def add_world_object(self, world_object):
        # Update world_object cell so the below messages affect the new cell surroundings.
        world_object.current_cell = self.key

        if world_object.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.players[world_object.guid] = world_object
        elif world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
            self.creatures[world_object.guid] = world_object
        elif world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            self.gameobjects[world_object.guid] = world_object
        elif world_object.get_type_id() == ObjectTypeIds.ID_DYNAMICOBJECT:
            self.dynamic_objects[world_object.guid] = world_object
        elif world_object.get_type_id() == ObjectTypeIds.ID_CORPSE:
            self.corpses[world_object.guid] = world_object

        camera = FarSightManager.get_camera_by_object(world_object)
        if camera:
            FarSightManager.update_camera_cell_placement(world_object, self)

    def update_creatures(self, now):
        with self.cell_lock:
            # Update creature instances.
            for guid, creature in list(self.creatures.items()):
                creature.update(now)

    def stop_movement(self):
        with self.cell_lock:
            # Try to stop movement from all creatures in this cell.
            for guid, creature in list(self.creatures.items()):
                creature.stop_movement()

    def update_gameobjects(self, now):
        with self.cell_lock:
            # Update gameobject instances.
            for guid, gameobject in list(self.gameobjects.items()):
                gameobject.update(now)

    def update_dynobjects(self, now):
        with self.cell_lock:
            # Update dynobject instances.
            for guid, dynobject in list(self.dynamic_objects.items()):
                dynobject.update(now)

    def update_spawns(self, now):
        with self.cell_lock:
            # Update creatures spawn points.
            for spawn_id, spawn_creature in list(self.creatures_spawns.items()):
                spawn_creature.update(now)

            # Update gameobject spawn points.
            for spawn_id, spawn_gameobject in list(self.gameobject_spawns.items()):
                spawn_gameobject.update(now)

    def update_corpses(self, now):
        with self.cell_lock:
            for guid, corpse in list(self.corpses.items()):
                corpse.update(now)

    # Make each player update its surroundings, adding, removing or updating world objects as needed.
    def update_players_surroundings(self, world_object=None, has_changes=False, has_inventory_changes=False):
        affected_players = set()
        for player in list(self.players.values()):
            affected_players.add(player.guid)
            self._update_player_surroundings(player, world_object, has_changes, has_inventory_changes)

        for camera in FarSightManager.get_cell_cameras(self):
            for player in list(camera.players.values()):
                if player.guid in affected_players:
                    continue
                self._update_player_surroundings(player, world_object, has_changes, has_inventory_changes)

    # noinspection PyMethodMayBeStatic
    def _update_player_surroundings(self, player, world_object=None, has_changes=False, has_inventory_changes=False):
        if world_object:
            player.update_world_object_on_me(world_object, has_changes, has_inventory_changes)
        else:
            player.update_known_objects_on_tick = True

    def remove(self, world_object):
        guid = world_object.guid
        if world_object.get_type_id() == ObjectTypeIds.ID_PLAYER and guid in self.players:
            self.players.pop(world_object.guid, None)
            return True
        elif world_object.get_type_id() == ObjectTypeIds.ID_UNIT and guid in self.creatures:
            self.creatures.pop(world_object.guid, None)
            return True
        elif world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT and guid in self.gameobjects:
            self.gameobjects.pop(world_object.guid, None)
            return True
        elif world_object.get_type_id() == ObjectTypeIds.ID_DYNAMICOBJECT and guid in self.dynamic_objects:
            self.dynamic_objects.pop(world_object.guid, None)
            return True
        elif world_object.get_type_id() == ObjectTypeIds.ID_CORPSE and guid in self.corpses:
            self.corpses.pop(world_object.guid, None)
            return True
        return False

    def send_all(self, packet, source, include_source=False, exclude=None, use_ignore=False):
        players_reached = set()
        for guid, player_mgr in list(self.players.items()):
            if player_mgr.online:
                if not include_source and player_mgr.guid == source.guid:
                    continue
                if exclude and player_mgr.guid in exclude:
                    continue
                if use_ignore and source and player_mgr.friends_manager.has_ignore(source.guid):
                    continue
                # Never send messages to a player that does not know the source object.
                if not player_mgr.guid == source.guid and source.guid not in player_mgr.known_objects:
                    continue
                players_reached.add(player_mgr.guid)
                player_mgr.enqueue_packet(packet)

        # If this cell has cameras, route packets.
        for camera in FarSightManager.get_cell_cameras(self):
            camera.broadcast_packet(packet, exclude=players_reached)

    def send_all_in_range(self, packet, range_, source, include_source=True, exclude=None, use_ignore=False):
        if range_ <= 0:
            self.send_all(packet, source, exclude)
        else:
            players_reached = set()
            for guid, player_mgr in list(self.players.items()):
                if player_mgr.online and player_mgr.location.distance(source.location) <= range_:
                    if not include_source and player_mgr.guid == source.guid:
                        continue
                    if use_ignore and player_mgr.friends_manager.has_ignore(source.guid):
                        continue
                    # Never send messages to a player that does not know the source object.
                    if not player_mgr.guid == source.guid and source.guid not in player_mgr.known_objects:
                        continue
                    players_reached.add(player_mgr.guid)
                    player_mgr.enqueue_packet(packet)

            # If this cell has cameras, route packets.
            for camera in FarSightManager.get_cell_cameras(self):
                camera.broadcast_packet(packet, exclude=players_reached)
