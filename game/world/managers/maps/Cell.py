from game.world.managers.maps.helpers.CellUtils import  CellUtils
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from threading import RLock

from utils.ConfigManager import config
from utils.constants.MiscCodes import UpdateFlags


class Cell:
    def __init__(self, cell_x=0, cell_y=0, map_id=0, instance_id=0, key=''):
        self.map_id = map_id
        self.instance_id = instance_id
        self.key = key
        self.cell_x = cell_x
        self.cell_y = cell_y
        self.adt_x, self.adt_y = CellUtils.cell_to_adt(cell_x, cell_y)
        self.adt_key = f'{self.adt_x},{self.adt_y}'
        # Cell lock.
        self.cell_lock = RLock()
        # Instances.
        self.gameobjects = dict()
        self.transports = dict()
        self.creatures = dict()
        self.players = dict()
        self.dynamic_objects = dict()
        self.corpses = dict()
        # Spawns.
        self.creatures_spawns = dict()
        self.gameobject_spawns = dict()

        if not key:
            self.key = f'{cell_x}:{cell_y}:{self.map_id}:{self.instance_id}'

        self.hash = hash(self.key)

    def __hash__(self):
        return self.hash

    def has_players(self):
        return len(self.players) > 0

    def has_cameras(self):
        return FarSightManager.has_camera_in_cell(self)

    def add_world_object_spawn(self, world_object_spawn):
        from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
        if isinstance(world_object_spawn, CreatureSpawn):
            self.creatures_spawns[world_object_spawn.spawn_id] = world_object_spawn
        else:
            self.gameobject_spawns[world_object_spawn.spawn_id] = world_object_spawn

    def add_world_object(self, world_object):
        # Update world_object cell so the below messages affect the new cell surroundings.
        world_object.current_cell = self.key

        if world_object.is_player():
            self.players[world_object.guid] = world_object
        elif world_object.is_unit():
            self.creatures[world_object.guid] = world_object
        elif world_object.is_gameobject():
            self.gameobjects[world_object.guid] = world_object
            if world_object.is_transport():
                self.transports[world_object.guid] = world_object
        elif world_object.is_dyn_object():
            self.dynamic_objects[world_object.guid] = world_object
        elif world_object.is_corpse():
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
                creature.movement_manager.stop()

    def update_gameobjects(self, now):
        with self.cell_lock:
            # Update gameobject instances.
            for guid, gameobject in list(self.gameobjects.items()):
                if guid not in self.transports:
                    gameobject.update(now)

    def update_transports(self, now):
        with self.cell_lock:
            # Update transport instances.
            for guid, transport in list(self.transports.items()):
                transport.update(now)

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
    def update_players_surroundings(self, world_object=None, update_flags=UpdateFlags.NONE,
                                    update_data=None, object_type=None):
        affected_players = set()
        for player in list(self.players.values()):
            affected_players.add(player.guid)
            self._update_player_surroundings(player, world_object, update_flags, update_data,
                                             object_type)

        for camera in FarSightManager.get_cell_cameras(self):
            for player in list(camera.players.values()):
                if player.guid in affected_players:
                    continue
                self._update_player_surroundings(player, world_object, update_flags, update_data,
                                                 object_type)

    # noinspection PyMethodMayBeStatic
    def _update_player_surroundings(self, player, world_object=None, update_flags=UpdateFlags.NONE,
                                    update_data=None, object_type=None):
        if world_object:
            player.update_manager.update_world_object_on_self(world_object, update_flags, update_data)
        else:
            player.update_manager.enqueue_object_update(object_type=object_type)

    def remove(self, world_object):
        guid = world_object.guid

        if world_object.is_player() and guid in self.players:
            self.players.pop(world_object.guid, None)
            return True
        elif world_object.is_unit() and guid in self.creatures:
            self.creatures.pop(world_object.guid, None)
            return True
        elif world_object.is_gameobject() and guid in self.gameobjects:
            self.gameobjects.pop(world_object.guid, None)
            self.transports.pop(world_object.guid, None)
            return True
        elif world_object.is_dyn_object() and guid in self.dynamic_objects:
            self.dynamic_objects.pop(world_object.guid, None)
            return True
        elif world_object.is_corpse() and guid in self.corpses:
            self.corpses.pop(world_object.guid, None)
            return True
        return False

    def send_all(self, packet, source, include_source=False, exclude=None, use_ignore=False):
        players_reached = set()
        for guid, player_mgr in list(self.players.items()):
            if not player_mgr.online:
                continue
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
        # If range is non-positive, send to all players without filtering.
        if range_ <= 0:
            self.send_all(packet, source, exclude)
            return

        is_yell = int(range_) == int(config.World.Chat.ChatRange.yell_range)
        is_say = int(range_) == int(config.World.Chat.ChatRange.say_range)

        players_reached = set()
        for guid, player_mgr in list(self.players.items()):
            # Skip offline players.
            if not player_mgr.online:
                continue
            # Check distance.
            distance = player_mgr.location.distance(source.location)
            if distance > range_:
                continue
            # Optionally exclude source.
            if not include_source and player_mgr.guid == source.guid:
                continue
            # Skip players that have ignored the source.
            if use_ignore and player_mgr.friends_manager.has_ignore(source.guid):
                continue
            # Ensure the player knows about the source object if this is not a chat message.
            if not is_say and not is_yell:
                if guid != source.guid and source.guid not in player_mgr.known_objects:
                    continue

            # Add to reached players.
            players_reached.add(guid)
            # Send packet.
            player_mgr.enqueue_packet(packet)

        # Route packets via cameras if applicable.
        for camera in FarSightManager.get_cell_cameras(self):
            camera.broadcast_packet(packet, exclude=players_reached)

    def can_deactivate(self):
        return not self.has_players() and not self.has_cameras()
