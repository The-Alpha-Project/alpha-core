from struct import pack
from database.world.WorldModels import SpawnsGameobjects
from game.world.managers.GridManager import GridManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode
from game.world.managers.objects.GameObjectManager import GameObjectManager
from utils.constants.DuelCodes import *
from utils.constants.UpdateFields import PlayerFields, UnitFields


class DuelManager(object):
    ARBITERS_GUID = 40000  # TODO: Need a way to dynamically generate available guids for go's

    def __init__(self, owner):
        self.owner = owner
        self.dueling_with = None
        self.duel_status = DUEL_STATUS.DUEL_STATUS_INBOUNDS
        self.duel_state = DUEL_STATE.DUEL_STATE_REQUESTED
        self.arbiter = None
        self.count_down_timer = 3000

    def is_dueling(self):
        return not self.dueling_with

    def start_duel(self):
        self.duel_state = DUEL_STATE.DUEL_STATE_STARTED
        self.dueling_with.duel_manager.duel_state = DUEL_STATE.DUEL_STATE_STARTED

    def end_duel(self, duel_winner_flag, winner):

        if duel_winner_flag == DUEL_WINNER.DUEL_WINNER_KNOCKOUT and winner == self.owner:
            pass
            #self.dueling_with.emote(EMOTES.EMOTE_ONESHOT_BEG)
            #self.dueling_with.root(3000)

        if winner == self.owner:
            winner_name_bytes = PacketWriter.string_to_bytes(winner.player.name)
            data = pack(f'<B{len(winner_name_bytes)}s', duel_winner_flag, winner_name_bytes)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_WINNER, data)
            GridManager.send_surrounding(packet, winner)

        GridManager.remove_object(self.arbiter)

        packet = PacketWriter.get_packet(OpCode.SMSG_CANCEL_COMBAT)
        self.owner.session.send_message(packet)
        self.owner.leave_combat()

        self.dueling_with = None
        self.arbiter = None
        self.count_down_timer = 3000
        self.duel_state = DUEL_STATE.DUEL_STATE_REQUESTED
        self.duel_status = DUEL_STATUS.DUEL_STATUS_INBOUNDS

    def duel_countdown(self, elapsed):
        self.count_down_timer -= elapsed
        if self.count_down_timer <= 0:
            print('Start/Cancel')
        else:
            print(f'Time left: {self.count_down_timer}')

    def boundary_test(self):
        dist = self.arbiter.location.distance(self.owner.location)
        if dist >= 75:
            if self.duel_status == DUEL_STATUS.DUEL_STATUS_OUTOFBOUNDS:
                self.count_down_timer -= 500
                if self.count_down_timer == 0:
                    self.dueling_with.duel_manager.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT)
            else:
                self.count_down_timer = 10000
                data = pack('<I', self.count_down_timer)
                packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_OUTOFBOUNDS, data)
                self.owner.session.send_message(packet)  # Notify out of bounds.
        else:  # in range
            if self.duel_status == DUEL_STATUS.DUEL_STATUS_OUTOFBOUNDS: # Just got in range again, notify
                self.owner.session.send_message(PacketWriter.get_packet(OpCode.SMSG_DUEL_INBOUNDS))

    def set_arbiter(self, arbiter):
        self.arbiter = arbiter
        self.build_update()

    def update(self, elapsed):
        if self.dueling_with and self.duel_state == DUEL_STATE.DUEL_STATE_REQUESTED:
            self.duel_countdown(elapsed)
        if self.arbiter and self.duel_state == DUEL_STATE.DUEL_STATE_STARTED:
            self.boundary_test()

    def build_update(self):
        if self.arbiter:
            self.owner.set_uint64(PlayerFields.PLAYER_DUEL_ARBITER, self.arbiter.guid)
            if self.duel_state == DUEL_STATE.DUEL_STATE_STARTED:
                self.owner.set_uint32(UnitFields.UNIT_FIELD_POWER2, 0)
                self.owner.set_uint32(PlayerFields.PLAYER_DUEL_TEAM, self.owner.guid)
        else:
            self.owner.set_uint64(PlayerFields.PLAYER_DUEL_ARBITER, 0)
            if self.duel_state == DUEL_STATE.DUEL_STATE_REQUESTED:
                self.owner.set_uint32(UnitFields.UNIT_FIELD_POWER2, 0)
                self.owner.set_uint32(PlayerFields.PLAYER_DUEL_TEAM, 0)

    def request_duel(self, target):
        print(f'{self.owner.player.name} requested a duel to {target.player.name}')
        self.duel_state = DUEL_STATE.DUEL_STATE_REQUESTED
        self.dueling_with = target
        target.duel_manager.dueling_with = self.owner

        arbiter = self._create_arbiter(target)
        if arbiter:
            self.set_arbiter(arbiter)
            target.duel_manager.set_arbiter(arbiter)

            data = pack('<2Q', arbiter.guid, self.owner.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, data)
            target.session.send_message(packet) # '<player> has challenged you to a duel ui box'

            data = pack('<2Q', arbiter.guid, self.owner.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, data)
            self.owner.session.send_message(packet) # 'You have requested a duel.' Message

            self.count_down_timer = 3000

    def _create_arbiter(self, target):
        try:
            go_template = WorldDatabaseManager.gameobject_template_get_by_entry(21680)[0]  # Why does it returns a tuple
            go_template.scale = 0.3

            in_between_pos = self.owner.location.get_point_in_middle(target.location)

            #  TODO: Need a builder for this.
            instance = SpawnsGameobjects()
            instance.spawn_id = DuelManager.ARBITERS_GUID
            instance.spawn_entry = 21680
            instance.spawn_map = self.owner.map_
            instance.spawn_rotation0 = 0
            instance.spawn_orientation = 0
            instance.spawn_rotation2 = 0
            instance.spawn_rotation1 = 0
            instance.spawn_rotation3 = 0
            instance.spawn_positionX = in_between_pos.x
            instance.spawn_positionY = in_between_pos.y
            instance.spawn_positionZ = in_between_pos.z
            instance.spawn_state = True
            DuelManager.ARBITERS_GUID += 1

            go_arbiter = GameObjectManager(
                gobject_template=go_template,  # go_template returns wrapped in a tuple...
                gobject_instance=instance
            )

            go_arbiter.load()
            go_arbiter.send_update_surrounding()  # spawn arbiter
            return go_arbiter
        except:
            return None


