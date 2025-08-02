from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager


class QuestGiverManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.lock = self.get_data_field(0, int)

    # override
    def use(self, unit=None, target=None, from_script=False):
        if target and unit and unit.is_player():
            unit.quest_manager.handle_quest_giver_hello(target, target.guid)

        super().use(unit, target, from_script)
