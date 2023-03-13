class GooberManager(object):

    def __init__(self, goober_object):
        self.goober_object = goober_object
        self.quest_id = goober_object.gobject_template.data1
        self.has_custom_animation = goober_object.gobject_template.data4 > 0
        self.is_consumable = goober_object.gobject_template.data5 > 0

    def goober_use(self, player):
        if self.has_custom_animation:
            self.goober_object.send_custom_animation(0)
        if self.is_consumable:
            self.goober_object.destroy()
        if self.quest_id:
            player.quest_manager.handle_goober_use(self.goober_object, self.quest_id)
