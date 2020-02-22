from game.world.managers.objects.item.ContainerManager import ContainerManager


class InventoryManager(object):
    def __init__(self):
        self.containers = []
        self.backpack = None

    def load_items(self, guid):
        pass
