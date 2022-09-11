from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger

# TODO: Scripting system.
SCRIPTS = {16398: 16397}  # Defias Cannon - IronClad door.


class GooberManager(object):

    def __init__(self, goober_object):
        self.goober_object = goober_object
        self.quest_id = goober_object.gobject_template.data1
        self.has_custom_animation = goober_object.gobject_template.data4 > 0
        self.is_consumable = goober_object.gobject_template.data5 > 0

    def get_script_go(self):
        if self.goober_object.entry not in SCRIPTS:
            return None
        go_entry = SCRIPTS[self.goober_object.entry]
        gameobjects = [go for go in
                       MapManager.get_surrounding_gameobjects(self.goober_object).values() if go.entry == go_entry]
        return gameobjects[0] if len(gameobjects) > 0 else None

    def goober_use(self, player):
        # Check scripted gameobject first.
        scripted_gameobject = self.get_script_go()
        if scripted_gameobject:
            if self.has_custom_animation:
                self.goober_object.send_custom_animation(0)
            scripted_gameobject.set_active()

        # Check if player quests need this goober interaction.
        if player.quest_manager.handle_goober_use(self, self.quest_id):
            if self.has_custom_animation:
                self.goober_object.send_custom_animation(0)
            if self.is_consumable:
                self.goober_object.destroy()
        else:
            entry = self.goober_object.entry
            name = self.goober_object.gobject_template.name
            Logger.warning(f'Unimplemented gameobject use for type Goober entry {entry} name {name}')
