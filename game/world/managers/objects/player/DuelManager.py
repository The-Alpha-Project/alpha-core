from struct import pack
from database.world.WorldModels import SpawnsGameobjects
from game.world.managers.GridManager import GridManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode
from game.world.managers.objects.GameObjectManager import GameObjectManager
from utils.constants.DuelCodes import *
from utils.constants.UpdateFields import PlayerFields


# TODO: Need to figure a way to make both players hostile to each other while duel is ongoing.
# TODO: Missing checks before requesting a duel, check if already in duel, faction, etc.
class DuelManager(object):
    ARBITERS_GUID = 40000  # TODO: HackFix, We need a way to dynamically generate valid guids for go's
    BOUNDARY_RADIUS = 50

    def __init__(self, owner):
        self.owner = owner
        self.dueling_with = None
        self.duel_status = DUEL_STATUS.DUEL_STATUS_INBOUNDS
        self.duel_state = DUEL_STATE.DUEL_STATE_FINISHED
        self.arbiter = None
        self.out_bounds_timer = 10  # seconds
        self.elapsed = 0
        self.team_id = 0

    def request_duel(self, target):
        print(f'{self.owner.player.name} requested a duel to {target.player.name}')
        self.duel_state = DUEL_STATE.DUEL_STATE_REQUESTED
        self.dueling_with = target
        target.duel_manager.dueling_with = self.owner
        self.team_id = 1
        target.duel_manager.team_id = 2

        arbiter = self._create_arbiter(target)
        if arbiter:
            self.set_arbiter(arbiter)
            target.duel_manager.set_arbiter(arbiter)

            data = pack('<2Q', arbiter.guid, self.owner.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, data)
            target.session.send_message(packet)  # '<player> has challenged you to a duel ui box'

            data = pack('<2Q', arbiter.guid, self.owner.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, data)
            self.owner.session.send_message(packet)  # 'You have requested a duel.' Message
            self.out_bounds_timer = 10

    def handle_duel_accept(self):
        self.build_update()
        self.start_duel()

    def handle_duel_canceled(self):
        self.dueling_with.duel_manager.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT, DUEL_COMPLETE.DUEL_CANCELED_INTERRUPTED, self.dueling_with)
        self.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT, DUEL_COMPLETE.DUEL_CANCELED_INTERRUPTED, self.dueling_with)

    def start_duel(self):
        self.duel_state = DUEL_STATE.DUEL_STATE_STARTED
        self.duel_status = DUEL_STATUS.DUEL_STATUS_INBOUNDS
        self.out_bounds_timer = 10  # seconds
        self.build_update(set_dirty=True)

    def force_duel_retreat(self):
        if self.dueling_with:
            self.dueling_with.duel_manager.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT, DUEL_COMPLETE.DUEL_FINISHED,
                                                    self.dueling_with)
            self.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT, DUEL_COMPLETE.DUEL_FINISHED, self.dueling_with)

    def end_duel(self, duel_winner_flag, duel_complete_flag, winner):
        if not self.dueling_with:
            return

        self.duel_state = DUEL_STATE.DUEL_STATE_FINISHED
        if duel_winner_flag == DUEL_WINNER.DUEL_WINNER_KNOCKOUT and winner == self.owner:
            # TODO: Should trigger EMOTE BEG on target?
            # TODO: Should root target for 3 secs?
            pass

        # Only the winner will broadcast result to its surroundings.
        if winner == self.owner:
            # Send either the duel ended by natural means or if it was canceled/interrupted
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_COMPLETE, pack('<B', duel_complete_flag))
            GridManager.send_surrounding(packet, winner)
            # Was not interrupted, broadcast duel result.
            if duel_complete_flag == DUEL_COMPLETE.DUEL_FINISHED:
                winner_name_bytes = PacketWriter.string_to_bytes(winner.player.name)
                loser_name_bytes = PacketWriter.string_to_bytes(self.dueling_with.player.name)
                data = pack(f'<B{len(winner_name_bytes)}s{len(loser_name_bytes)}s', duel_winner_flag, winner_name_bytes, loser_name_bytes)
                packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_WINNER, data)
                GridManager.send_surrounding(packet, winner)

        # Clean up arbiter go and cleanup.
        GridManager.remove_object(self.arbiter)

        packet = PacketWriter.get_packet(OpCode.SMSG_CANCEL_COMBAT)
        self.owner.session.send_message(packet)
        self.owner.leave_combat(force_update=True)

        self.dueling_with = None
        self.arbiter = None
        self.out_bounds_timer = 10
        self.duel_status = DUEL_STATUS.DUEL_STATUS_INBOUNDS
        self.build_update(set_dirty=True)

    # Boundary check by Arbiter every second. We can tweak this later if sample rate is not sufficient
    def boundary_check(self, elapsed):
        self.elapsed += elapsed
        if self.elapsed >= 1:
            dist = self.arbiter.location.distance(self.owner.location)
            if dist >= DuelManager.BOUNDARY_RADIUS:
                if self.duel_status == DUEL_STATUS.DUEL_STATUS_OUTOFBOUNDS:
                    self.out_bounds_timer -= self.elapsed  # seconds
                    if self.out_bounds_timer <= 0:
                        self.dueling_with.duel_manager.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT, DUEL_COMPLETE.DUEL_FINISHED, self.dueling_with)
                        self.end_duel(DUEL_WINNER.DUEL_WINNER_RETREAT, DUEL_COMPLETE.DUEL_FINISHED, self.dueling_with)
                else:  # Was in range and now is out of bounds.
                    self.duel_status = DUEL_STATUS.DUEL_STATUS_OUTOFBOUNDS
                    self.out_bounds_timer = 10  # 10 seconds to come back.
                    data = pack('<I', self.out_bounds_timer)
                    packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_OUTOFBOUNDS, data)
                    self.owner.session.send_message(packet)  # Notify out of bounds.
            else:  # in range
                if self.duel_status == DUEL_STATUS.DUEL_STATUS_OUTOFBOUNDS:  # Just got in range again, notify
                    self.duel_status = DUEL_STATUS.DUEL_STATUS_INBOUNDS
                    self.owner.session.send_message(PacketWriter.get_packet(OpCode.SMSG_DUEL_INBOUNDS))
            self.elapsed = 0

    def is_dueling(self):
        return self.dueling_with

    def set_arbiter(self, arbiter):
        self.arbiter = arbiter
        self.build_update(set_dirty=True)

    def update(self, elapsed):
        if self.arbiter and self.duel_state == DUEL_STATE.DUEL_STATE_STARTED:
            self.boundary_check(elapsed)

    def build_update(self, set_dirty=False):
        if self.arbiter:
            self.owner.set_uint64(PlayerFields.PLAYER_DUEL_ARBITER, self.arbiter.guid)
            if self.duel_state == DUEL_STATE.DUEL_STATE_STARTED:
                self.owner.set_uint32(PlayerFields.PLAYER_DUEL_TEAM, self.team_id)
        else:
            self.owner.set_uint64(PlayerFields.PLAYER_DUEL_ARBITER, 0)
            if self.duel_state == DUEL_STATE.DUEL_STATE_FINISHED:
                self.owner.set_uint32(PlayerFields.PLAYER_DUEL_TEAM, 0)

        if set_dirty:
            self.owner.set_dirty()

    def _create_arbiter(self, target):
        try:
            go_template = WorldDatabaseManager.gameobject_template_get_by_entry(21680)[0]  # Why does it returns a tuple
            go_template.scale = 0.5
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
                gobject_template=go_template,
                gobject_instance=instance
            )

            go_arbiter.load()
            go_arbiter.send_update_surrounding()  # spawn arbiter
            return go_arbiter
        except:
            return None
