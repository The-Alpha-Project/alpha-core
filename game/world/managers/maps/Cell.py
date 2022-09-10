from utils.constants.MiscCodes import ObjectTypeIds


class Cell:
    def __init__(self, min_x=0.0, min_y=0.0, max_x=0.0, max_y=0.0, map_=0.0, key=''):
        self.min_x = min_x
        self.min_y = min_y
        self.max_x = max_x
        self.max_y = max_y
        self.map_ = map_
        self.key = key
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

    def update_creatures(self, now):
        updated_by_spawn = set()
        # Update creatures Spawns.
        for spawn_id, spawn_creature in list(self.creatures_spawns.items()):
            updated_by_spawn.add(spawn_creature.update(now))
        # Update orphan creature instances.
        for guid, creature in list(self.creatures.items()):
            if guid not in updated_by_spawn:
                creature.update(now)

    def update_gameobject(self, now):
        updated_by_spawn = set()
        # Update gameobjects Spawns.
        for spawn_id, spawn_gameobject in list(self.gameobject_spawns.items()):
            updated_by_spawn.add(spawn_gameobject.update(now))
        # Update orphan gameobject instances.
        for guid, gameobject in list(self.gameobjects.items()):
            if guid not in updated_by_spawn:
                gameobject.update(now)

    def update_corpses(self, now):
        for guid, corpse in list(self.corpses.items()):
            corpse.update(now)

    # Make each player update its surroundings, adding, removing or updating world objects as needed.
    def update_players(self, world_object=None, has_changes=False, has_inventory_changes=False):
        for player in list(self.players.values()):
            if world_object:
                player.update_world_object_on_me(world_object, has_changes, has_inventory_changes)
            else:
                player.update_known_world_objects()

    def remove(self, world_object):
        if world_object.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.players.pop(world_object.guid, None)
        elif world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
            self.creatures.pop(world_object.guid, None)
        elif world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            self.gameobjects.pop(world_object.guid, None)
        elif world_object.get_type_id() == ObjectTypeIds.ID_DYNAMICOBJECT:
            self.dynamic_objects.pop(world_object.guid, None)
        elif world_object.get_type_id() == ObjectTypeIds.ID_CORPSE:
            self.corpses.pop(world_object.guid, None)

    def send_all(self, packet, source=None, exclude=None, use_ignore=False):
        for guid, player_mgr in list(self.players.items()):
            if player_mgr.online:
                if source and player_mgr.guid == source.guid:
                    continue
                if exclude and player_mgr.guid in exclude:
                    continue
                if use_ignore and source and player_mgr.friends_manager.has_ignore(source.guid):
                    continue

                player_mgr.enqueue_packet(packet)

    def send_all_in_range(self, packet, range_, source, include_self=True, exclude=None, use_ignore=False):
        if range_ <= 0:
            self.send_all(packet, source, exclude)
        else:
            for guid, player_mgr in list(self.players.items()):
                if player_mgr.online and player_mgr.location.distance(source.location) <= range_:
                    if not include_self and player_mgr.guid == source.guid:
                        continue
                    if use_ignore and player_mgr.friends_manager.has_ignore(source.guid):
                        continue

                    player_mgr.enqueue_packet(packet)