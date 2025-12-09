from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.DuelCodes import *
from utils.constants.MiscCodes import Emotes
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import PlayerFields

BOUNDARY_RADIUS = 50
GROVEL_SPELL = 7267
OUT_OF_BOUNDARY_GRACE_TIME = 10  # Seconds.


class PlayerDuelInformation:
    def __init__(self, player, target, team_id):
        self.player = player
        self.target = target
        self.timer = OUT_OF_BOUNDARY_GRACE_TIME
        self.status = DuelStatus.DUEL_STATUS_INBOUNDS
        self.team_id = team_id
        self.accepted = False

    def deplete_timer(self):
        self.timer = 0

    def timer_expired(self):
        return self.timer <= 0


class DuelArbiterManager(GameObjectManager):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.duel_info: dict[int, PlayerDuelInformation] = {}
        self.duel_state = DuelState.DUEL_STATE_REQUESTED

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            # Validate both players are linked to self.
            self._validate_arbiter()

            if self._duel_started():
                # Check players within boundaries.
                self._boundary_check(now - self.last_tick)
            # Check if both participants have accepted the duel, if they did, start the duel.
            elif self._start_duel_check():
                self._start_duel()

        super().update(now)

    def request_duel(self, requester, target):
        self._set_participants(requester, target)
        self._update_arbiter()
        self._notify_duel_request(requester, target)

    def handle_duel_accept(self, player_mgr):
        duel_info = self.duel_info.get(player_mgr.guid, None)
        if not duel_info:
            return
        duel_info.accepted = True

    def handle_duel_canceled(self, player_mgr):
        duel_info = self.duel_info.get(player_mgr.guid, None)
        if not duel_info:
            return
        self.end_duel(DuelWinner.DUEL_WINNER_RETREAT, self._get_canceled_flag(), duel_info.target)

    def force_duel_end(self, player_mgr, retreat=True):
        duel_info = self.duel_info.get(player_mgr.guid, None)
        if not duel_info:
            return
        winner_reason = DuelWinner.DUEL_WINNER_RETREAT if retreat else DuelWinner.DUEL_WINNER_KNOCKOUT
        self.end_duel(winner_reason, DuelComplete.DUEL_FINISHED, duel_info.target)

    def end_duel(self, duel_winner_flag, duel_complete_flag, winner: Optional[PlayerManager]):
        if winner and not winner.is_player():
            # If the provided unit is a pet, check for its owner instead.
            winner = winner.get_charmer_or_summoner(include_self=True)

        # Set this first to prevent next tick to trigger.
        self.duel_state = DuelState.DUEL_STATE_FINISHED

        # Loser cast Grovel (Stun 3 secs).
        if winner and duel_winner_flag == DuelWinner.DUEL_WINNER_KNOCKOUT:
            loser = self.duel_info[winner.guid].target
            # Say grovel emote text, animation handled by spell.
            loser.say_emote_text(Emotes.GROVEL, target=winner)
            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(GROVEL_SPELL)
            spell_target_mask = spell_template.Targets
            loser.spell_manager.handle_cast_attempt(GROVEL_SPELL, loser, spell_target_mask)

        # Send either the duel ended by natural means or if it was canceled/interrupted.
        self._notify_duel_complete(duel_complete_flag)
        # Both players leave combat.
        self._leave_combat()

        # Was not interrupted, broadcast duel result.
        if duel_complete_flag == DuelComplete.DUEL_FINISHED and winner:
            self._notify_winner(winner, self.duel_info[winner.guid].target, duel_winner_flag)

        self.despawn()

    def is_unit_involved(self, who):
        if not who.is_player():
            # If the provided unit is a pet, check for its owner instead.
            who = who.get_charmer_or_summoner(include_self=True)

        return self.duel_info and who and who.guid in self.duel_info

    # override
    def despawn(self, ttl=0, respawn_delay=0):
        # Arbiter expired.
        if self.duel_state != DuelState.DUEL_STATE_FINISHED:
            self.end_duel(DuelWinner.DUEL_WINNER_RETREAT, DuelComplete.DUEL_CANCELED_INTERRUPTED, winner=None)

        self._update_teams(remove=True)
        self._update_arbiter(remove=True)
        self.duel_info.clear()
        super().despawn(ttl, respawn_delay)

    def _set_participants(self, requester, target):
        duel_info_requester = PlayerDuelInformation(requester, target, team_id=1)
        duel_info_target = PlayerDuelInformation(target, requester, team_id=2)
        self.duel_info[requester.guid] = duel_info_requester
        self.duel_info[target.guid] = duel_info_target

    def _duel_started(self):
        return self.duel_state == DuelState.DUEL_STATE_STARTED

    def _start_duel(self):
        self.duel_state = DuelState.DUEL_STATE_STARTED
        self._update_teams(remove=False)

    def _update_arbiter(self, remove=False):
        for duel_info in list(self.duel_info.values()):
            arbiter_guid = self.guid if not remove else 0
            duel_info.player.set_uint64(PlayerFields.PLAYER_DUEL_ARBITER, arbiter_guid)

    def _update_teams(self, remove=False):
        for duel_info in list(self.duel_info.values()):
            team_id = duel_info.team_id if not remove else 0
            duel_info.player.set_uint32(PlayerFields.PLAYER_DUEL_TEAM, team_id)

    def _notify_duel_request(self, requester, target):
        packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_REQUESTED, pack('<2Q', self.guid, requester.guid))
        target.enqueue_packet(packet)  # '<player> has challenged you to a duel ui box'
        requester.enqueue_packet(packet)  # 'You have requested a duel.' Message.

    def _notify_winner(self, winner, losser, flag):
        winner_name_bytes = PacketWriter.string_to_bytes(winner.get_name())
        loser_name_bytes = PacketWriter.string_to_bytes(losser.get_name())
        data = pack(f'<B{len(winner_name_bytes)}s{len(loser_name_bytes)}s', flag, winner_name_bytes, loser_name_bytes)
        self.get_map().send_surrounding(PacketWriter.get_packet(OpCode.SMSG_DUEL_WINNER, data), self)

    def _notify_duel_cancel(self):
        for duel_info in list(self.duel_info.values()):
            duel_info.player.enqueue_packet(PacketWriter.get_packet(OpCode.CMSG_DUEL_CANCELLED))

    def _notify_duel_complete(self, flag):
        for duel_info in list(self.duel_info.values()):
            duel_info.player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_DUEL_COMPLETE, pack('<B', flag)))

    def _leave_combat(self):
        for duel_info in list(self.duel_info.values()):
            duel_info.player.leave_combat()

    def _validate_arbiter(self):
        for duel_info in list(self.duel_info.values()):
            if duel_info.player.get_duel_arbiter() != self or duel_info.player.map_id != self.map_id:
                self.force_duel_end(duel_info.player)
                break

    def _get_canceled_flag(self):
        if self.duel_state == DuelState.DUEL_STATE_STARTED:
            return DuelComplete.DUEL_FINISHED
        return DuelComplete.DUEL_CANCELED_INTERRUPTED

    def _start_duel_check(self):
        if self.duel_state == DuelState.DUEL_STATE_REQUESTED:
            return all(duel_info.accepted for duel_info in list(self.duel_info.values()))
        return False

    def _boundary_check(self, elapsed):
        if self.duel_state != DuelState.DUEL_STATE_STARTED:
            return

        for duel_info in list(self.duel_info.values()):
            # Check if player switched maps, if he did, end duel as retreat.
            if duel_info.player.map_id != self.map_id:
                duel_info.deplete_timer()
            else:
                dist = self.location.distance(duel_info.player.location)
                if dist >= BOUNDARY_RADIUS:
                    if duel_info.status == DuelStatus.DUEL_STATUS_OUTOFBOUNDS:
                        duel_info.timer -= elapsed  # Seconds.
                    else:  # Was in range and now is out of bounds.
                        self._notify_out_of_bounds(duel_info.player)
                else:  # In range
                    if duel_info.status == DuelStatus.DUEL_STATUS_OUTOFBOUNDS:  # Just got in range again, notify
                        self._notify_inside_bound(duel_info.player)

            if duel_info.timer_expired():
                self.end_duel(DuelWinner.DUEL_WINNER_RETREAT, DuelComplete.DUEL_FINISHED, duel_info.target)

    def _notify_inside_bound(self, player):
        duel_info = self.duel_info[player.guid]
        duel_info.status = DuelStatus.DUEL_STATUS_INBOUNDS
        duel_info.player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_DUEL_INBOUNDS))

    def _notify_out_of_bounds(self, player):
        duel_info = self.duel_info[player.guid]
        duel_info.status = DuelStatus.DUEL_STATUS_OUTOFBOUNDS
        duel_info.timer = OUT_OF_BOUNDARY_GRACE_TIME
        packet = PacketWriter.get_packet(OpCode.SMSG_DUEL_OUTOFBOUNDS, pack('<I', duel_info.timer))
        duel_info.player.enqueue_packet(packet)
