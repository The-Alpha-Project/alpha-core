class ButtonManager:

    def __init__(self, button_object):
        self.button_object = button_object
        self.start_open_state = bool(button_object.gobject_template.data0)
        self.lock = button_object.gobject_template.data1
        self.auto_close_secs = button_object.gobject_template.data2
        self.linked_trap = button_object.gobject_template.data3

    def use_button(self, player):
        self.button_object.set_active()

        if self.linked_trap:
            self.button_object.trigger_linked_trap(self.linked_trap, player)
