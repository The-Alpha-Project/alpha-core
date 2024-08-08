from network.packet.update.UpdateBuilder import UpdateBuilder
from utils.constants.MiscCodes import ObjectTypeIds


class UpdateManager:
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.update_builder = UpdateBuilder(player_mgr)
        self.pending_known_object_types_updates = {
            ObjectTypeIds.ID_PLAYER: False,
            ObjectTypeIds.ID_UNIT: False,
            ObjectTypeIds.ID_GAMEOBJECT: False,
            ObjectTypeIds.ID_DYNAMICOBJECT: False,
            ObjectTypeIds.ID_CORPSE: False
        }

    def process_update(self):
        # Process pending surrounding updates (Create/Destroy).
        self._update_surrounding_known_objects()
        # Send all required update packets.
        self.update_builder.process_update()

    def _update_surrounding_known_objects(self):
        obj_types = [object_type for object_type in self.pending_known_object_types_updates.keys()
                     if self.pending_known_object_types_updates[object_type]]
        if not obj_types:
            return

        # Retrieve surrounding active objects.
        objects = self.player_mgr.get_map().get_surrounding_objects(self.player_mgr, obj_types)

        with self.update_builder.update_lock:
            self.update_builder.clear_active_objects()

        # Update each object type.
        [self._update_known_objects_for_type(obj_type, objects[obj_types.index(obj_type)]) for obj_type in obj_types]

    def _update_known_objects_for_type(self, object_type, objects):
        # Flag as obj type updated.
        self.pending_known_object_types_updates[object_type] = False

        # Which active objects were found in self surroundings.
        if objects:
            update_func = self._get_update_func_for_type(object_type)
            # Surrounding objects.
            [update_func(object_) for object_ in objects.values()]

        if not self.player_mgr.known_objects:
            return

        # Destroy those known objects that are no longer found in player surroundings.
        [self.update_builder.add_destroy_object(guid) for guid, object_ in list(self.player_mgr.known_objects.items())
         if not self.update_builder.has_active_guid(guid) and object_.get_type_id() == object_type]

    def _get_update_func_for_type(self, object_type) -> callable:
        if object_type == ObjectTypeIds.ID_UNIT:
            return self._update_known_creature
        elif object_type == ObjectTypeIds.ID_PLAYER:
            return self._update_known_player
        elif object_type == ObjectTypeIds.ID_GAMEOBJECT:
            return self._update_known_gameobject
        elif object_type == ObjectTypeIds.ID_DYNAMICOBJECT:
            return self._update_known_dynobject
        return self._update_known_corpse

    def enqueue_known_objects_update(self, object_type=None):
        # Single object type update.
        if object_type:
            self.pending_known_object_types_updates[object_type] = True
            return

        # No type provided, flag all available.
        for type_id in ObjectTypeIds:
            # Not a valid type or already pending update, skip.
            if (type_id not in self.pending_known_object_types_updates
                    or self.pending_known_object_types_updates[type_id]):
                continue
            self.pending_known_object_types_updates[type_id] = True

    # Player update, packets are sent immediately.
    def _update_self(self, has_changes, inventory_changes, update_data):
        # Update self inventory if needed, updates are sent immediately.
        if inventory_changes:
            item__queries, create_packets, partial_packets = self.player_mgr.get_inventory_update_packets(
                requester=self.player_mgr)
            self.player_mgr.enqueue_packets(item__queries)
            self.player_mgr.enqueue_packets(create_packets)
            self.player_mgr.enqueue_packets(partial_packets)
        # Enqueue a partial update if needed.
        if has_changes:
            self.update_builder.add_partial_update_from_object(self.player_mgr, update_data=update_data)

    # Retrieve update packets from world objects, this is called only if object has pending changes.
    # (update_mask bits set).
    def update_world_object_on_self(self, world_object, has_changes=False, has_inventory_changes=False, update_data=None):
        # Self updates, send directly.
        if world_object.guid == self.player_mgr.guid:
            self._update_self(has_changes, has_inventory_changes, update_data)
            return

        can_detect = self.player_mgr.can_detect_target(world_object)[0]
        if world_object.guid in self.player_mgr.known_objects and can_detect and has_changes:
            self.update_builder.add_partial_update_from_object(world_object, update_data=update_data)
        # Stealth detection.
        # Unit is now visible.
        elif world_object.guid not in self.player_mgr.known_objects and can_detect \
                and world_object.guid in self.player_mgr.known_stealth_units:
            self.player_mgr.known_stealth_units[world_object.guid] = (world_object, False)
        # Unit went stealth.
        elif (world_object.guid in self.player_mgr.known_objects and not can_detect
              and world_object.guid not in self.player_mgr.known_stealth_units):
            # Update self with known world object partial update packet.
            if has_changes:
                self.update_builder.add_partial_update_from_object(world_object, update_data=update_data)
            self.player_mgr.known_stealth_units[world_object.guid] = (world_object, True)

    def _update_known_dynobject(self, dynobject):
        self.update_builder.add_active_object(dynobject)
        if dynobject.guid not in self.player_mgr.known_objects or not self.player_mgr.known_objects[dynobject.guid]:
            if dynobject.is_spawned:
                self.update_builder.add_create_update_from_object(dynobject)
        # Player knows the dynamic object but is not spawned anymore, destroy it for self.
        elif dynobject.guid in self.player_mgr.known_objects and not dynobject.is_spawned:
            self.update_builder.pop_active_object(dynobject)

    def _update_known_gameobject(self, gobject):
        self.update_builder.add_active_object(gobject)
        if gobject.guid not in self.player_mgr.known_objects or not self.player_mgr.known_objects[gobject.guid]:
            if gobject.is_spawned:
                self.update_builder.add_create_update_from_object(gobject)
        # Player knows the game object but is not spawned anymore, destroy it for self.
        elif gobject.guid in self.player_mgr.known_objects and not gobject.is_spawned:
            self.update_builder.pop_active_object(gobject)

    def _update_known_creature(self, creature):
        # Handle visibility/stealth.
        if not self.player_mgr.can_detect_target(creature)[0]:
            self.player_mgr.known_stealth_units[creature.guid] = (creature, True)
            creature.known_players[self.player_mgr.guid] = self
            return
        elif creature.guid in self.player_mgr.known_stealth_units:
            del self.player_mgr.known_stealth_units[creature.guid]

        self.update_builder.add_active_object(creature)
        if creature.guid not in self.player_mgr.known_objects or not self.player_mgr.known_objects[creature.guid]:
            if not creature.is_spawned:
                return
            self.update_builder.add_create_update_from_object(creature)
        # Player knows the creature but is not spawned anymore, destroy it for self.
        elif creature.guid in self.player_mgr.known_objects and not creature.is_spawned:
            self.update_builder.pop_active_object(creature)

    def _update_known_corpse(self, corpse):
        if self.player_mgr.guid == corpse.guid:
            return
        self.update_builder.add_active_object(corpse)
        if corpse.guid not in self.player_mgr.known_objects or not self.player_mgr.known_objects[corpse.guid]:
            # Create packet.
            self.update_builder.add_create_update_from_object(corpse)
        self.player_mgr.known_objects[corpse.guid] = corpse

    def _update_known_player(self, player_mgr):
        if self.player_mgr.guid == player_mgr.guid:
            return

        # Handle visibility/stealth.
        if not self.player_mgr.can_detect_target(player_mgr)[0]:
            self.player_mgr.known_stealth_units[player_mgr.guid] = (player_mgr, True)
            return
        elif player_mgr.guid in self.player_mgr.known_stealth_units:
            del self.player_mgr.known_stealth_units[player_mgr.guid]

        self.update_builder.add_active_object(player_mgr)
        if player_mgr.guid not in self.player_mgr.known_objects or not self.player_mgr.known_objects[player_mgr.guid]:
            self.update_builder.add_create_update_from_object(player_mgr)
            self.player_mgr.known_objects[player_mgr.guid] = player_mgr
