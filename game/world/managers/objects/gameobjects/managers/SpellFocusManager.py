from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager


class SpellFocusManager(GameObjectManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.spell_focus_type = 0
        self.radius = 0
        self.linked_trap = 0
        self.linked_trap_object = None

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.spell_focus_type = self.get_data_field(0, int)
        self.radius = self.get_data_field(1, float) / 2.0
        self.linked_trap = self.get_data_field(2, int)

    def update(self, now):
        if now <= self.last_tick or self.last_tick <= 0:
            self.last_tick = now
            return

        if self.is_active_object():
            self._check_linked_trap()

        self.last_tick = now
        super().update(now)

    # override
    def use(self, unit=None, target=None, from_script=False):
        if unit and self.linked_trap:
            self.trigger_linked_trap(self.linked_trap, unit, self.radius)
        super().use(unit, target, from_script)

    def _check_linked_trap(self):
        if not self.linked_trap or self.linked_trap_object:
            return

        go_objects = self.get_map().get_surrounding_gameobjects(self).values()
        should_spawn = not go_objects or not any(go for go in go_objects
                                                 if go.entry == self.linked_trap
                                                 and self.location.distance(go.location) < self.radius)
        if not should_spawn:
            return

        self.linked_trap_object = self.spawn_linked_trap(trap_entry=self.linked_trap)
