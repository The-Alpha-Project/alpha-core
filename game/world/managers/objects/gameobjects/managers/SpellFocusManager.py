from database.dbc.DbcDatabaseManager import DbcDatabaseManager


class SpellFocusManager:
    def __init__(self, gameobject):
        self.gameobject = gameobject
        self.spell_focus_object = DbcDatabaseManager.spell_get_focus_by_id(gameobject.gobject_template.data0)
        self.radius = gameobject.gobject_template.data1 / 2.0
        self.linked_trap = gameobject.gobject_template.data2

    def use_spell_focus(self, who):
        if self.linked_trap:
            self.gameobject.trigger_linked_trap(self.linked_trap, who, self.radius)
        return True
