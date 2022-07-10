from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.Formulas import PlayerFormulas
from utils.Logger import Logger
from utils.constants.MiscCodes import ReputationFlag, ReputationSourceGain
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import UnitReaction, Teams

CLIENT_MAX = 64
MIN_REPUTATION = -4200
MAX_REPUTATION = 3300


class ReputationManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.reputations = {}

    def load_reputations(self):
        reputations = RealmDatabaseManager.character_get_reputations(self.player_mgr.player.guid)
        for reputation in reputations:
            self.reputations[reputation.index] = reputation

    def send_initialize_factions(self, set_visible=True):
        data = pack('<I', CLIENT_MAX)
        for x in range(CLIENT_MAX):
            if x in self.reputations:
                faction = DbcDatabaseManager.FactionHolder.faction_get_by_index(x)
                data += pack('<Bi', self.reputations[x].flags, self.reputations[x].standing - faction.ReputationBase_1)
            else:
                data += pack('<Bi', 0, 0)
        packet = PacketWriter.get_packet(OpCode.SMSG_INITIALIZE_FACTIONS, data)
        self.player_mgr.enqueue_packet(packet)

        if set_visible:
            for reputation in self.reputations.values():
                self.send_set_faction_visible(reputation)

    def send_set_faction_visible(self, faction):
        packet = PacketWriter.get_packet(OpCode.SMSG_SET_FACTION_VISIBLE, pack('<I', faction.index))
        self.player_mgr.enqueue_packet(packet)

    def reward_reputation_on_kill(self, creature, rate=1.0):
        reputation_on_kill_entry = WorldDatabaseManager.creature_get_reputation_on_kill_by_entry(creature.entry)
        if not reputation_on_kill_entry:
            return

        for team in range(1, 3):
            mod_reputation, faction = self._get_reputation_modifier(reputation_on_kill_entry, team, creature, rate)
            if mod_reputation and faction:
                self.modify_reputation(faction, mod_reputation)

    def _get_reputation_modifier(self, reputation_on_kill_entry, team, creature, rate) -> tuple:
        teams = [Teams.TEAM_ALLIANCE, Teams.TEAM_HORDE]
        team_index = team - 1
        reward_on_kill_reputation_faction = eval(f'reputation_on_kill_entry.RewOnKillRepFaction{team}')
        team_dependant = reputation_on_kill_entry.TeamDependent
        reputation_source = ReputationSourceGain.REPUTATION_SOURCE_KILL
        reputation_mod = 0
        reputation_faction = 0
        if reward_on_kill_reputation_faction and (not team_dependant or self.player_mgr.team == teams[team_index]):
            reputation_qty = eval(f'reputation_on_kill_entry.RewOnKillRepValue{team}')
            reputation_faction = eval(f'reputation_on_kill_entry.RewOnKillRepFaction{team}')
            reputation_mod = int(PlayerFormulas.calculate_reputation_gain(self.player_mgr, reputation_source,
                                                                          reputation_qty, creature.level) * rate)
        return reputation_mod, reputation_faction

    def modify_reputation(self, faction_id, amount):
        faction_template = DbcDatabaseManager.FactionHolder.faction_get_by_id(faction_id)

        if not faction_template or faction_template.ReputationIndex not in self.reputations:
            Logger.warning(f'Unable to modify reputation for faction {faction_id}.')
            return

        faction = self.reputations[faction_template.ReputationIndex]
        new_standing = self.reputations[faction.index].standing + amount

        # Prevent spillage client crash.
        if new_standing > MAX_REPUTATION:
            new_standing = MAX_REPUTATION
        elif new_standing < -MIN_REPUTATION:
            new_standing = MIN_REPUTATION

        # Notify only if there was an actual change.
        if new_standing != self.reputations[faction.index].standing:
            self.reputations[faction.index].standing = new_standing
            RealmDatabaseManager.character_update_reputation(self.reputations[faction.index])

            # Notify the client
            standing = self.reputations[faction.index].standing - faction_template.ReputationBase_1
            data = pack('<2i', faction.index, standing)
            packet = PacketWriter.get_packet(OpCode.SMSG_SET_FACTION_STANDING, data)
            self.player_mgr.enqueue_packet(packet)

    def get_reputation_flag(self, faction):
        standing = -1
        if faction.index in self.reputations:
            standing = self.reputations[faction.index].standing
        if standing > -1:
            reaction = ReputationManager.reaction_by_standing(standing)
            return ReputationManager.reputation_flag_by_reaction(reaction)
        return ReputationFlag.HIDDEN.value

    def get_reaction_for_faction(self, faction):
        for index, reputation in self.reputations.items():
            if reputation.faction == faction:
                return ReputationManager.reaction_by_standing(reputation.standing)
        return UnitReaction.UNIT_REACTION_NEUTRAL

    @staticmethod
    def faction_has_reputation(faction):
        return faction.ReputationIndex > -1

    @staticmethod
    def reputation_flag_by_reaction(reaction):
        if reaction < UnitReaction.UNIT_REACTION_UNFRIENDLY:
            return ReputationFlag.ATWAR.value
        return ReputationFlag.HIDDEN.value

    @staticmethod
    def reaction_by_standing(standing):
        if standing >= 2100:
            return UnitReaction.UNIT_REACTION_REVERED
        elif standing >= 900:
            return UnitReaction.UNIT_REACTION_FRIENDLY
        elif standing >= 300:
            return UnitReaction.UNIT_REACTION_AMIABLE
        elif standing >= 0:
            return UnitReaction.UNIT_REACTION_NEUTRAL
        elif standing < -300:
            return UnitReaction.UNIT_REACTION_HOSTILE if standing >= -600 else UnitReaction.UNIT_REACTION_HATED
        return UnitReaction.UNIT_REACTION_UNFRIENDLY
