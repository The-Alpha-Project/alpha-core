from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import TrainerServices, TrainerTypes

TALENT_SKILL_ID = 3
# Weapon, Attribute, Slayer, Magic, Defensive
SKILL_LINE_TALENT_IDS = [222, 230, 231, 233, 234]


class TalentManager(object):
    class Talent(object):
        def __init__(self,
                     spell_id,
                     status,
                     cost,
                     talent_points,
                     skill_points,
                     required_level,
                     required_skill_line,
                     required_skill_rank,
                     required_skill_step,
                     required_ability):
            self.spell_id = spell_id
            self.status = status
            self.cost = cost
            self.talent_points = talent_points
            self.skill_points = skill_points
            self.required_level = required_level
            self.required_skill_line = required_skill_line
            self.required_skill_rank = required_skill_rank
            self.required_skill_step = required_skill_step
            self.required_ability = required_ability

        def to_bytes(self):
            data = pack('<IBI3B6I',
                        self.spell_id,
                        self.status,
                        self.cost,
                        self.talent_points,
                        self.skill_points,
                        self.required_level,
                        self.required_skill_line,
                        self.required_skill_rank,
                        self.required_skill_step,
                        self.required_ability[0],
                        self.required_ability[1],
                        self.required_ability[2]
                        )
            return data

    def __init__(self, player_mgr):
        self.player_mgr = player_mgr

    def send_talent_list(self):
        next_talent = []
        talents = []

        skill_line_abilities = DbcDatabaseManager.skill_line_ability_get_by_skill_lines(SKILL_LINE_TALENT_IDS)
        rank_1_spells = DbcDatabaseManager.get_spells_by_rank(1, only_ids=True)

        for ability in skill_line_abilities:
            # We only want the ones having an attached spell
            if not ability.Spell:
                continue

            if ability.Spell in self.player_mgr.spells:
                if ability.SupercededBySpell > 0:
                    next_talent.append(ability.SupercededBySpell)
                status = TrainerServices.TRAINER_SERVICE_USED
            else:
                if ability.Spell in next_talent:
                    status = TrainerServices.TRAINER_SERVICE_AVAILABLE
                elif ability.Spell in rank_1_spells:
                    status = TrainerServices.TRAINER_SERVICE_AVAILABLE
                else:
                    status = TrainerServices.TRAINER_SERVICE_UNAVAILABLE

            # TODO: Investigate Talent Point cost per rank:
            # We do know that Rank 1 cost 10 TP and Rank 2 cost 15 TP (https://i.imgur.com/eFi3cf4.jpg),
            # but we don't know about other ranks.
            #
            # When you level you gain the following amount of TP on each level (5 more each ten levels):
            # 2 - 9:   10 TP
            # 10 - 19: 15 TP
            # 20 - 29: 20 TP
            # 30 - 39: 25 TP
            # 40 - 49: 30 TP
            # 50 - 59: 35 TP
            # 60:      40 TP

            talent = TalentManager.Talent(
                ability.Spell,
                status,
                0, 10, 0, 0, 0, 0, 0, [0, 0, 0]
            )
            talents.append(talent)

        data = pack('<Q2I', self.player_mgr.guid, TrainerTypes.TRAINER_TYPE_TALENTS, len(talents))
        for talent in talents:
            data += talent.to_bytes()
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))
