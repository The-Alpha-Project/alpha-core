class GooberManager:

    def __init__(self, goober_object):
        self.goober_object = goober_object
        self.quest_id = goober_object.gobject_template.data1
        self.has_custom_animation = goober_object.gobject_template.data4 > 0
        self.is_consumable = goober_object.gobject_template.data5 > 0
        self.page_text = goober_object.gobject_template.data7

    def goober_use(self, player):
        if self.has_custom_animation:
            self.goober_object.send_custom_animation(0)
        if self.is_consumable:
            self.goober_object.despawn()
        if self.page_text:
            self.goober_object.send_page_text(player)
        if self.quest_id:
            player.quest_manager.handle_goober_use(self.goober_object, self.quest_id)
