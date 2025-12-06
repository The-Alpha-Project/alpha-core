from network.packet.update.UpdateBuilder import UpdateBuilder
from utils.constants.MiscCodes import ObjectTypeIds


class UpdateManager:
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.update_builder = UpdateBuilder(player_mgr)
        self.pending_object_types_updates = {
            ObjectTypeIds.ID_PLAYER: False,
            ObjectTypeIds.ID_UNIT: False,
            ObjectTypeIds.ID_GAMEOBJECT: False,
            ObjectTypeIds.ID_DYNAMICOBJECT: False,
            ObjectTypeIds.ID_CORPSE: False
        }

    def process_tick_updates(self):
        # Process pending surrounding updates (Create/Destroy).
        self._update_surrounding_objects()
        # Send all required update packets.
        self.update_builder.process_update()

    def _update_surrounding_objects(self):
        obj_types = [object_type for object_type in self.pending_object_types_updates.keys()
                     if self.pending_object_types_updates[object_type]]
        if not obj_types:
            return

        # Retrieve surrounding active objects.
        objects = self.player_mgr.get_map().get_surrounding_objects(self.player_mgr, obj_types)

        self.update_builder.clear_active_objects()

        # Update each object type.
        [self._update_objects_for_type(obj_type, objects[obj_types.index(obj_type)]) for obj_type in obj_types]

    def _update_objects_for_type(self, object_type, objects):
        # Flag as obj type updated.
        self.pending_object_types_updates[object_type] = False

        # Which active objects were found in self surroundings.
        if objects:
            [self._update_object_visibility(object_) for object_ in objects.values()]

        # Destroy those known objects that are no longer found in player surroundings.
        [self.destroy_known_object(guid) for guid, object_ in list(self.player_mgr.known_objects.items())
         if not self.update_builder.has_active_guid(guid) and object_.get_type_id() == object_type]

    def destroy_known_object(self, guid):
        known_object = self.player_mgr.known_objects.get(guid, None)
        if not known_object:
            return
        self.update_builder.add_destroy_update_from_object(known_object)

    def destroy_self(self):
        self.update_builder.add_destroy_update_from_object(self.player_mgr)

    def enqueue_object_update(self, object_type=None):
        # Single object type update.
        if object_type:
            self.pending_object_types_updates[object_type] = True
            return

        # No type provided, flag all available.
        for type_id in ObjectTypeIds:
            # Not a valid type or already pending update, skip.
            if (type_id not in self.pending_object_types_updates
                    or self.pending_object_types_updates[type_id]):
                continue
            self.pending_object_types_updates[type_id] = True

    def update_world_object_creation_now(self, world_object):
        self.update_builder.add_create_update_from_object(world_object)
        self.update_builder.process_update()  # Notify instantly.

    # Player update, packets are sent immediately.
    def _update_self(self, has_changes, inventory_changes, update_data):
        # Inventory.
        if inventory_changes:
            item_queries, item_create_packets, item_partial_packets = self.player_mgr.get_inventory_update_packets(
                requester=self.player_mgr)
            self.player_mgr.enqueue_packets(item_queries + item_create_packets + item_partial_packets)
        # UpdateFields.
        if has_changes:
            partial_packet = self.player_mgr.generate_partial_packet(requester=self.player_mgr, update_data=update_data)
            self.player_mgr.enqueue_packet(partial_packet)

    def update_gameobject_dynamic_flag(self, gameobject):
        dyn_flags_bytes = gameobject.get_dynamic_flag_update_bytes(requester=self.player_mgr)
        self.update_builder.add_partial_update_from_bytes(dyn_flags_bytes)

    # Retrieve update packets from world objects, this is called only if object has pending changes.
    # (update_mask bits set).
    def update_world_object_on_self(self, world_object, has_changes=False, has_inventory_changes=False, update_data=None):
        # Self updates, send directly.
        if world_object.guid == self.player_mgr.guid:
            self._update_self(has_changes, has_inventory_changes, update_data)
            return

        can_detect = self.player_mgr.can_detect_target(world_object)[0]
        if world_object.guid in self.player_mgr.known_objects and can_detect and has_changes:
            if not world_object.is_spawned:
                self.enqueue_object_update(world_object.get_type_id())  # Update known objects for type.
            else:
                self.update_builder.add_partial_update_from_object(world_object, update_data=update_data)
        elif (world_object.guid not in self.player_mgr.known_objects and can_detect and has_changes
              and world_object.is_spawned and world_object.guid not in self.player_mgr.known_stealth_units):
            # Temporary summons, pet or guardian, update immediately.
            if world_object.is_temp_summon_or_pet_or_guardian():
                self.update_world_object_creation_now(world_object)
            else:
                self.enqueue_object_update(world_object.get_type_id())  # Update known objects for type.
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

    def _update_object_visibility(self, world_object):
        object_type = world_object.get_type_id()
        is_player = object_type == ObjectTypeIds.ID_PLAYER
        if is_player and world_object == self.player_mgr:
            return

        # Check visibility/stealth detection for units.
        if world_object.is_unit(by_mask=True):
            if not self.player_mgr.can_detect_target(world_object)[0]:
                self.player_mgr.known_stealth_units[world_object.guid] = (world_object, True)
                if object_type == ObjectTypeIds.ID_UNIT:
                    world_object.known_players[self.player_mgr.guid] = self
                return
            elif world_object.guid in self.player_mgr.known_stealth_units:
                del self.player_mgr.known_stealth_units[world_object.guid]

        self.update_builder.add_active_object(world_object)
        if world_object.guid not in self.player_mgr.known_objects or not self.player_mgr.known_objects[world_object.guid]:
            if not world_object.is_spawned:
                return
            self.update_builder.add_create_update_from_object(world_object)
        # Player knows the object but is not spawned anymore, destroy it for self.
        elif not is_player and world_object.guid in self.player_mgr.known_objects and not world_object.is_spawned:
            self.update_builder.pop_active_object(world_object)
