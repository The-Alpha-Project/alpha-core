from game.world.managers.objects.ai.BasicCreatureAI import BasicCreatureAI
from utils.constants.CustomCodes import Permits
from utils.constants.UnitCodes import UnitStates, UnitFlags

DEFAULT_MAX_ASSIST_DISTANCE =  40.0


class EscortAI(BasicCreatureAI):
    def __init__(self, creature):
        super().__init__(creature)
        self.player_mgr = None
        self.group_mgr = None
        self.assist_timer = 0  # Check every second.

    # override
    def update_ai(self, elapsed, now):
        super().update_ai(elapsed, now)
        if not self.creature or not self.player_mgr or not self.is_ready_for_new_attack():
            return
        self.assist_timer += elapsed
        if self.assist_timer < 1:
            return
        self.assist_timer = 0
        self.assist_unit(self.player_mgr)

    # override
    def permissible(self, creature):
        return Permits.PERMIT_BASE_NO

    # override
    def attach_escort_link(self, player_mgr):
        if self.player_mgr:
            return
        self.player_mgr = player_mgr
        self.group_mgr = player_mgr.group_manager if player_mgr else None

    # override
    def detach_escort_link(self, player_mgr=None):
        if not self.player_mgr:
            return
        if player_mgr and player_mgr.guid != self.player_mgr.guid:
            return
        self.player_mgr = None
        self.group_mgr = None

    # override
    def just_died(self, killer=None):
        super().just_died(killer)
        self.detach_escort_link()

    # override
    def assist_unit(self, target):
        victim = self._get_assist_target()
        if not victim:
            return
        self.creature.attack(victim)

    # override
    def just_despawned(self):
        super().just_despawned()
        self.detach_escort_link()

    def _get_assist_target(self):
        victim = None
        if self.group_mgr:
            players = self.group_mgr.get_members_players(alive=True)
            if players:
                # Sort by distance to self.
                players.sort(key=lambda player: player.location.distance(self.creature.location))
                victim = next((self._get_player_victim(p) for p in players), None)
        else:
            victim = self._get_player_victim(self.player_mgr)
        return victim

    def _get_player_victim(self, player_mgr):
        if self.creature.location.distance(self.player_mgr.location) > DEFAULT_MAX_ASSIST_DISTANCE:
            return None
        victim = player_mgr.combat_target if player_mgr.combat_target else player_mgr.threat_manager.get_hostile_target()
        if not victim:
            return None
        return victim
