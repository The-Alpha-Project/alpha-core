from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class CameraManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.lock = 0
        self.cinematic_id = 0
        self.event_id = 0

    # override
    def initialize_from_gameobject_template(self, gobject_template):
        super().initialize_from_gameobject_template(gobject_template)
        self.lock = self.get_data_field(0, int)
        self.cinematic_id = self.get_data_field(1, int)
        self.event_id = self.get_data_field(2, int)

    # override
    def use(self, player=None, target=None, from_script=False):
        if self.cinematic_id and player:
            if DbcDatabaseManager.cinematic_sequences_get_by_id(self.cinematic_id):
                packet = PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, pack('<I', self.cinematic_id))
                player.enqueue_packet(packet)

            if not from_script:
                self.trigger_script(player)

        super().use(player, target, from_script)
