from struct import pack

from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.DuelCodes import *
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.UpdateFields import PlayerFields


class PlayerDuelInformation(object):
    def __init__(self, player_mgr, target, is_target):
        self.player = player_mgr
        self.target = target
        self.timer = 10
        self.duel_status = DuelStatus.DUEL_STATUS_INBOUNDS
        self.is_target = is_target  # Player which accepted the duel.


# TODO: Missing checks before requesting a duel, does the map allow duel, etc.
class DuelManager(object):
    BOUNDARY_RADIUS = 50

    # Both players will share this DuelManager instance.
    def __init__(self, player1, player2, arbiter):
        self.players = {player1.guid: PlayerDuelInformation(player1, player2, False),
                        player2.guid: PlayerDuelInformation(player2, player1, True)}
        self.team_ids = {player1.guid: 1, player2.guid: 2}
        self.duel_state = DuelState.DUEL_STATE_FINISHED
        self.arbiter = arbiter
        self.elapsed = 0  # Used to control 1 update per second based on global tick rate.
        self.map_id = player1.map_id

    @staticmethod
    def request_duel(requester, target, arbiter):
        # If target is already dueling, fail Duel spell cast.
        if target.duel_manager:
            return

        # If requester is already dueling, lose current duel before starting a new one.
        if requester.duel_manager:
            requester.duel_manager.force_duel_end(requester, retreat=False)

        if arbiter:
            duel_manager = DuelManager(requester, target, arbiter)
            duel_manager.duel_state = DuelState.DUEL_STATE_REQUESTED

            data = pack('<2Q', arbiter.guid, requester.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, data)
            target.enqueue_packet(packet)  # '<player> has challenged you to a duel ui box'

            data = pack('<2Q', arbiter.guid, requester.guid)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, data)
            requester.enqueue_packet(packet)  # 'You have requested a duel.' Message.

            for entry in list(duel_manager.players.values()):
                entry.player.duel_manager = duel_manager

            return
        else:
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_COMPLETE, pack('<B', DuelComplete.DUEL_CANCELED_INTERRUPTED))
            requester.enqueue_packet(packet)
            return

    # Only accept the trigger from the target
    def handle_duel_accept(self, player_mgr):
        if self.players and player_mgr.guid in self.players and self.players[player_mgr.guid].is_target:
            self.start_duel()

    def handle_duel_canceled(self, player_mgr):
        if self.players and player_mgr.guid in self.players:
            self.end_duel(DuelWinner.DUEL_WINNER_RETREAT, DuelComplete.DUEL_CANCELED_INTERRUPTED, self.players[player_mgr.guid].target)

    def start_duel(self):
        self.duel_state = DuelState.DUEL_STATE_STARTED
        for entry in list(self.players.values()):
            entry.duel_status = DuelStatus.DUEL_STATUS_INBOUNDS
            self.build_update(entry.player)

    def force_duel_end(self, player_mgr, retreat=True):
        if player_mgr.guid in self.players:
            self.end_duel(DuelWinner.DUEL_WINNER_RETREAT if retreat else DuelWinner.DUEL_WINNER_KNOCKOUT,
                          DuelComplete.DUEL_FINISHED, self.players[player_mgr.guid].target)

    def end_duel(self, duel_winner_flag, duel_complete_flag, winner):
        if not self.arbiter or self.duel_state == DuelState.DUEL_STATE_FINISHED or not self.players:
            return

        if self.duel_state == DuelState.DUEL_STATE_STARTED:
            duel_complete_flag = DuelComplete.DUEL_FINISHED

        # Set this first to prevent next tick to trigger.
        self.duel_state = DuelState.DUEL_STATE_FINISHED

        if duel_winner_flag == DuelWinner.DUEL_WINNER_KNOCKOUT:
            # TODO: Should trigger EMOTE BEG on loser?
            # TODO: Should root loser for 3 secs?
            pass

        # Send either the duel ended by natural means or if it was canceled/interrupted
        packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_COMPLETE, pack('<B', duel_complete_flag))
        MapManager.send_surrounding(packet, self.arbiter)

        # Was not interrupted, broadcast duel result.
        if duel_complete_flag == DuelComplete.DUEL_FINISHED:
            winner_name_bytes = PacketWriter.string_to_bytes(winner.get_name())
            loser_name_bytes = PacketWriter.string_to_bytes(self.players[winner.guid].target.get_name())
            data = pack(f'<B{len(winner_name_bytes)}s{len(loser_name_bytes)}s', duel_winner_flag, winner_name_bytes,
                        loser_name_bytes)
            packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_WINNER, data)
            MapManager.send_surrounding(packet, self.arbiter)

        packet = PacketWriter.get_packet(OpCode.SMSG_CANCEL_COMBAT)
        for entry in list(self.players.values()):
            if entry.player.combo_target:
                entry.player.remove_combo_points()
            entry.player.enqueue_packet(packet)

            # Make sure to clear threat in case players finish out of combat.
            #  TODO This should be handled elsewhere.
            entry.player.threat_manager.remove_unit_threat(entry.target)
            entry.player.leave_combat()
            self.build_update(entry.player)

            entry.player.spell_manager.remove_unit_from_all_cast_targets(entry.target.guid)
            entry.player.aura_manager.remove_harmful_auras_by_caster(entry.target.guid)

        # Clean up arbiter go and cleanup.
        MapManager.remove_object(self.arbiter)

        # Finally, flush this DualManager instance.
        self.flush()

    def flush(self):
        for duel_info in list(self.players.values()):
            duel_info.player.duel_manager = None

        self.players.clear()
        self.team_ids.clear()
        self.arbiter = None
        self.map_id = None

    def is_unit_involved(self, who):
        if who.get_type_id() != ObjectTypeIds.ID_PLAYER:
            # If the provided unit is a pet, check for its owner instead.
            who = who.get_charmer_or_summoner(include_self=True)

        return self.players and who.guid in self.players

    def boundary_check(self):
        for entry in list(self.players.values()):  # Prevent mutability
            # Check if player switched maps, if he did, end duel as retreat.
            if entry.player.map_id != self.map_id:
                self.end_duel(DuelWinner.DUEL_WINNER_RETREAT, DuelComplete.DUEL_FINISHED, entry.target)
                break
            dist = self.arbiter.location.distance(entry.player.location)
            if dist >= DuelManager.BOUNDARY_RADIUS:
                if entry.duel_status == DuelStatus.DUEL_STATUS_OUTOFBOUNDS:
                    entry.timer -= self.elapsed  # seconds
                    if entry.timer <= 0:
                        self.end_duel(DuelWinner.DUEL_WINNER_RETREAT, DuelComplete.DUEL_FINISHED, entry.target)
                        break
                else:  # Was in range and now is out of bounds.
                    entry.duel_status = DuelStatus.DUEL_STATUS_OUTOFBOUNDS
                    entry.timer = 10  # 10 seconds to come back.
                    data = pack('<I', entry.timer)
                    packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_OUTOFBOUNDS, data)
                    entry.player.enqueue_packet(packet)  # Notify out of bounds.
            else:  # In range
                if entry.duel_status == DuelStatus.DUEL_STATUS_OUTOFBOUNDS:  # Just got in range again, notify
                    entry.duel_status = DuelStatus.DUEL_STATUS_INBOUNDS
                    entry.player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_DUEL_INBOUNDS))

    def update(self, player_mgr, elapsed):
        if not self.players or not self.arbiter or self.duel_state != DuelState.DUEL_STATE_STARTED:
            return

        # Only player who initiated the duel should update the Duel status.
        if self.players[player_mgr.guid].is_target:
            return

        self.elapsed += elapsed
        if self.elapsed >= 1:
            self.boundary_check()
            self.elapsed = 0

    def build_update(self, player_mgr):
        arbiter_guid = self.arbiter.guid if self.duel_state == DuelState.DUEL_STATE_STARTED else 0
        team_id = self.team_ids[player_mgr.guid] if self.duel_state != DuelState.DUEL_STATE_FINISHED else 0
        player_mgr.set_uint64(PlayerFields.PLAYER_DUEL_ARBITER, arbiter_guid)
        player_mgr.set_uint32(PlayerFields.PLAYER_DUEL_TEAM, team_id)
