from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import SkillLineAbility, Spell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import TrainerTemplate
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.TextUtils import GameTextFormatter
from utils.constants.MiscCodes import TrainerServices, TrainerTypes
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellEffects
from utils.constants.UnitCodes import PowerTypes


class TrainerUtils:

    # TODO Add skills (Two-Handed Swords etc.) to trainers for skill points https://i.imgur.com/tzyDDqL.jpg
    @staticmethod
    def send_trainer_list(creature_mgr, player_mgr):
        if not TrainerUtils.can_train(creature_mgr, player_mgr):
            Logger.anticheat(f'send_trainer_list called from NPC {creature_mgr.entry} by player with GUID '
                             f'{player_mgr.guid} but this unit does not train that '
                             f'player\'s class. Possible cheating')
            return

        train_spell_bytes: bytes = b''
        train_spell_count: int = 0

        trainer_ability_list: list[
            TrainerTemplate] = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_mgr.entry)

        if not trainer_ability_list or trainer_ability_list.count == 0:
            Logger.warning(f'send_trainer_list called from NPC {creature_mgr.entry} but no trainer spells found!')
            return

        trainer_type: TrainerTypes = TrainerTypes(WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
            creature_mgr.entry).trainer_type)

        item_templates = []
        # trainer_spell: The spell the trainer uses to teach the player.
        for trainer_spell in trainer_ability_list:
            player_spell_id = trainer_spell.playerspell
            spell: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(player_spell_id)
            if not spell:
                continue

            if spell.EffectItemType_1:
                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(
                    spell.EffectItemType_1)
                if item_template:
                    item_templates.append(item_template)

            # Search previous spell.
            preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(
                spell.ID)
            preceded_spell = 0 if not preceded_skill_line else preceded_skill_line.Spell

            # Skill step.
            skill_step: int = 0
            if spell.Effect_2 == SpellEffects.SPELL_EFFECT_SKILL_STEP:
                skill_step = spell.EffectMiscValue_2

            # Required skill.
            fulfill_skill_reqs = True
            if trainer_spell.reqskill:
                skill_value = player_mgr.skill_manager.get_total_skill_value(trainer_spell.reqskill, no_bonus=True)
                fulfill_skill_reqs = skill_value >= trainer_spell.reqskillvalue

            # Required spell. Take override from database if available.
            req_level = trainer_spell.reqlevel if trainer_spell.reqlevel else spell.BaseLevel

            status = TrainerUtils.get_training_list_spell_status(spell, trainer_spell, req_level,
                                                                 preceded_spell, player_mgr, fulfill_skill_reqs)

            train_spell_bytes += TrainerUtils.get_spell_data(trainer_spell.spell, status, trainer_spell.spellcost,
                                                             trainer_spell.talentpointcost,
                                                             trainer_spell.skillpointcost, req_level,
                                                             trainer_spell.reqskill, trainer_spell.reqskillvalue,
                                                             skill_step, preceded_spell)
            train_spell_count += 1

        placeholder_greeting: str = f'Hello, $c!  Ready for some training?'
        trainer_greeting = WorldDatabaseManager.get_npc_trainer_greeting(creature_mgr.entry)
        greeting_to_use = trainer_greeting.content_default if trainer_greeting else placeholder_greeting
        greeting_bytes = PacketWriter.string_to_bytes(GameTextFormatter.format(player_mgr, greeting_to_use))
        greeting_bytes_packed = pack(f'<{len(greeting_bytes)}s', greeting_bytes)

        # Send item query details first if needed. (Needs to be SMSG_ITEM_QUERY_SINGLE_RESPONSE)
        if item_templates:
            packets = []
            for item_template in item_templates:
                query_data = ItemManager.generate_query_details_data(item_template)
                query_packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data)
                packets.append(query_packet)
            player_mgr.enqueue_packets(packets)

        data_header = pack('<Q2I', creature_mgr.guid, trainer_type, train_spell_count)
        data = data_header + train_spell_bytes + greeting_bytes_packed
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))

    @staticmethod
    def get_spell_data(spell_id, status, cost, tp_cost, sp_cost, lvl, skill, req_skill, skill_step, preceded):
        data: bytes = pack(
            '<IBI3B6I',
            spell_id,  # Trainer Spell id.
            status,  # Status.
            cost,  # Cost.
            tp_cost,  # Talent Point Cost.
            sp_cost,  # Skill Point Cost.
            lvl,  # Required Level.
            skill,  # Required Skill Line.
            req_skill,  # Required Skill Rank.
            skill_step,  # Required Skill Step.
            preceded,  # Required Ability (1).
            0,  # Required Ability (2).
            0  # Required Ability (3).
        )
        return data

    @staticmethod
    def get_training_list_spell_status(spell: Spell, trainer_spell_template: TrainerTemplate, req_level: int,
                                       preceded_spell: int, player_mgr, fulfills_skill: bool = True):
        trainer_spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell_template.spell)
        is_taught_to_pet = trainer_spell.Effect_1 == SpellEffects.SPELL_EFFECT_LEARN_PET_SPELL
        active_pet = player_mgr.pet_manager.get_active_permanent_pet()
        if is_taught_to_pet and not active_pet:
            return TrainerServices.TRAINER_SERVICE_UNAVAILABLE

        target_spells = active_pet.get_pet_data().spells if is_taught_to_pet else player_mgr.spell_manager.spells
        if spell.ID in target_spells:
            return TrainerServices.TRAINER_SERVICE_USED

        if not fulfills_skill or (preceded_spell and preceded_spell not in target_spells) or \
            trainer_spell_template.reqskill != 0 and \
                (not player_mgr.skill_manager.has_skill(trainer_spell_template.reqskill) or
                    player_mgr.skill_manager.get_total_skill_value(trainer_spell_template.reqskill)
                    < trainer_spell_template.reqskillvalue):
            return TrainerServices.TRAINER_SERVICE_UNAVAILABLE

        if player_mgr.level >= req_level:
            return TrainerServices.TRAINER_SERVICE_AVAILABLE

        return TrainerServices.TRAINER_SERVICE_UNAVAILABLE

    @staticmethod
    def trainer_has_spell(creature_mgr, spell_id):
        if not creature_mgr.is_trainer():
            return False

        trainer_spells: list[TrainerTemplate] = \
            WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_mgr.entry)

        for trainer_spell in trainer_spells:
            if trainer_spell.spell == spell_id:
                return True

        return False

    # TODO: Validate trainer_spell field and Pet trainers.
    @staticmethod
    def can_train(creature_mgr, player_mgr) -> bool:
        if not creature_mgr.is_trainer():
            return False

        if not creature_mgr.is_within_interactable_distance(player_mgr) and not player_mgr.session.account_mgr.is_gm():
            return False

        # If expecting a specific class, check if they match.
        if creature_mgr.creature_template.trainer_class > 0:
            return creature_mgr.creature_template.trainer_class == player_mgr.player.class_

        # Mount, TradeSkill or Pet trainer.
        return True

    @staticmethod
    def player_can_ever_learn_talent(training_spell: TrainerTemplate, spell: Spell,
                                     skill_line_ability: SkillLineAbility, player_mgr) -> bool:
        spell_item_class = spell.EquippedItemClass
        spell_item_subclass_mask = spell.EquippedItemSubclass
        # Check for required proficiencies for this talent.
        if spell_item_class != -1 and spell_item_subclass_mask != 1:
            # Don't display talent if the player can never learn the proficiency needed.
            if not player_mgr.skill_manager.can_ever_use_equipment(spell_item_class, spell_item_subclass_mask):
                return False

        # Get player race/class masks.
        race_mask = 1 << player_mgr.race - 1
        class_mask = 1 << player_mgr.class_ - 1

        # Get skill.
        required_skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(training_spell.reqskill)

        # Check player race/class masks with skill race/class masks.
        if required_skill:
            skill_race_mask = required_skill.RaceMask
            skill_class_mask = required_skill.ClassMask

            if skill_race_mask and not race_mask & skill_race_mask:
                return False
            if skill_class_mask and not class_mask & skill_class_mask:
                return False
        return True
