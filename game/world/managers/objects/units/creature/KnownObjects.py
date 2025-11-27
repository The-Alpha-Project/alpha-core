class KnownObjects(dict):
    def __init__(self, player_mgr):
        super().__init__()
        self.player_mgr = player_mgr

    def __setitem__(self, key, value):
        self.update_detection_manager(key, value)
        return super().__setitem__(key, value)

    def __delitem__(self, key):
        if key in self:
            self.update_detection_manager(key, self[key], delete_item=True)
        return super().__delitem__(key)

    def pop(self, __key, *args, **kwargs):
        if __key in self:
            self.update_detection_manager(__key, self[__key], delete_item=True)
        return super().pop(__key, *args, **kwargs)

    def update_detection_manager(self, guid, world_object, delete_item=False):
        if not world_object.is_unit():
            return

        detection_manager = self.player_mgr.get_map().get_detection_manager()

        if not delete_item:
            # Add self player if needed.
            if not detection_manager.has_unit(self.player_mgr):
                detection_manager.queue_add(self.player_mgr)

            # Unit has not been added to our detection_manager.
            if not detection_manager.has_unit(world_object) and not world_object.is_critter():
                detection_manager.queue_add(world_object)
        else:
            # Unit won't know any player after self removal.
            if (detection_manager.has_unit(world_object) and not world_object.is_player()
                    and not (len(world_object.known_players) - 1)):
                detection_manager.queue_remove(world_object)
