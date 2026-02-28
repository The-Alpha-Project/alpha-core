from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import TrainerTemplate
from network.packet.PacketWriter import PacketWriter
from utils.Formulas import Distances
from utils.Logger import Logger
from utils.ObjectQueryUtils import ObjectQueryUtils
from utils.TextUtils import GameTextFormatter
from utils.constants.MiscCodes import TrainerServices, TrainerTypes
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellEffects
from utils.constants.UnitCodes import Classes


class TrainerUtils:
    PICK_LOCK_SPELLS = {1804, 6461, 6463}

    @staticmethod
    def send_trainer_list(creature_mgr, player_mgr):
        if not TrainerUtils.can_train(creature_mgr, player_mgr):
            Logger.anticheat(f'send_trainer_list called from NPC {creature_mgr.entry} by player with GUID '
                             f'{player_mgr.guid} but this unit does not train that '
                             f'player\'s class. Possible cheating')
            return False

        train_spell_bytes = bytearray()
        train_spell_count: int = 0

        trainer_ability_list: list[
            TrainerTemplate] = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_mgr.entry)

        if not trainer_ability_list or trainer_ability_list.count == 0:
            Logger.warning(f'send_trainer_list called from NPC {creature_mgr.entry} but no trainer spells found!')
            return False

        trainer_type: TrainerTypes = TrainerTypes(WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
            creature_mgr.entry).trainer_type)

        is_player_class_trainer = TrainerUtils.is_player_class_trainer(creature_mgr, player_mgr)
        has_available_spells = False

        item_templates = []
        # trainer_spell: The spell the trainer uses to teach the player.
        for trainer_spell in trainer_ability_list:
            player_spell_id = trainer_spell.playerspell
            spell: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(player_spell_id)
            if not spell:
                continue

            # Handle other classes training Lockpicking through rogue trainers.
            if not is_player_class_trainer and spell.ID not in TrainerUtils.PICK_LOCK_SPELLS:
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

            if DbcDatabaseManager.SkillLineAbilityHolder.spell_has_skill_line_ability(spell.ID):
                skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_ability_get_by_spell_race_and_class(
                    spell.ID, player_mgr.race, player_mgr.class_, player_mgr.is_gm)
                # Spell is not available to player.
                if not skill_line_ability:
                    continue

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

            status = TrainerUtils.get_training_list_spell_status(spell, trainer_spell, req_level,player_mgr,
                                                                 fulfill_skill_reqs, preceded_spell=preceded_spell,
                                                                 req_spell_2=trainer_spell.req_spell_2,
                                                                 req_spell_3=trainer_spell.req_spell_3)

            train_spell_bytes.extend(TrainerUtils.get_spell_data(trainer_spell.spell, status, trainer_spell.spellcost,
                                                                 trainer_spell.talentpointcost,
                                                                 trainer_spell.skillpointcost, req_level,
                                                                 trainer_spell.reqskill, trainer_spell.reqskillvalue,
                                                                 skill_step, preceded_spell))
            train_spell_count += 1

            if not has_available_spells and status == TrainerServices.TRAINER_SERVICE_AVAILABLE:
                has_available_spells = True

        placeholder_greeting: str = f'Hello, $c!  Ready for some training?'
        trainer_greeting = WorldDatabaseManager.get_npc_trainer_greeting(creature_mgr.entry)
        greeting_to_use = trainer_greeting.content_default if trainer_greeting else placeholder_greeting
        greeting_bytes = PacketWriter.string_to_bytes(GameTextFormatter.format(player_mgr, greeting_to_use))
        greeting_bytes_packed = pack(f'<{len(greeting_bytes)}s', greeting_bytes)

        # Send item query details first if needed. (Needs to be SMSG_ITEM_QUERY_SINGLE_RESPONSE)
        if item_templates:
            packets = []
            for item_template in item_templates:
                query_data = ObjectQueryUtils.get_query_details_data(template=item_template)
                query_packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data)
                packets.append(query_packet)
            player_mgr.enqueue_packets(packets)

        if not is_player_class_trainer and not has_available_spells:
            return False
        data_header = pack('<Q2I', creature_mgr.guid, trainer_type, train_spell_count)
        data = data_header + train_spell_bytes + greeting_bytes_packed
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))
        return True

    @staticmethod
    def get_spell_data(spell_id, status, cost, tp_cost, sp_cost, lvl, skill, req_skill, skill_step, required_spell_1=0,
                       required_spell_2=0, required_spell_3=0):

        required_spells = list(filter((0).__ne__, [required_spell_1, required_spell_2, required_spell_3]))
        data: bytes = pack(
            '<IBI3B3I',
            spell_id,  # Trainer Spell id.
            status,  # Status.
            cost,  # Cost.
            tp_cost,  # Talent Point Cost.
            sp_cost,  # Skill Point Cost.
            lvl,  # Required Level.
            skill,  # Required Skill Line.
            req_skill,  # Required Skill Rank.
            skill_step,  # Required Skill Step.
        )

        for index in range(3):
            data += pack('<I', required_spells[index] if index < len(required_spells) else 0)

        return data

    @staticmethod
    def get_training_list_spell_status(spell: Spell, trainer_spell_template: TrainerTemplate, req_level: int,
                                       player_mgr, fulfills_skill: bool = True,  preceded_spell: int = 0,
                                       req_spell_2: int = 0, req_spell_3: int = 0):
        trainer_spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell_template.spell)
        is_taught_to_pet = trainer_spell.Effect_1 == SpellEffects.SPELL_EFFECT_LEARN_PET_SPELL
        active_pet = player_mgr.pet_manager.get_active_permanent_pet()
        if is_taught_to_pet and not active_pet:
            return TrainerServices.TRAINER_SERVICE_UNAVAILABLE

        target_spells = active_pet.get_pet_data().spells if is_taught_to_pet else player_mgr.spell_manager.spells
        if spell.ID in target_spells:
            return TrainerServices.TRAINER_SERVICE_USED

        if not fulfills_skill:
            return TrainerServices.TRAINER_SERVICE_UNAVAILABLE

        required_spells = list(filter((0).__ne__, [preceded_spell, req_spell_2, req_spell_3]))
        if required_spells and not all(req_spell in target_spells for req_spell in required_spells):
            return TrainerServices.TRAINER_SERVICE_UNAVAILABLE

        if trainer_spell_template.reqskill:
            if (not player_mgr.skill_manager.has_skill(trainer_spell_template.reqskill) or
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

        if not player_mgr.is_gm and not Distances.is_within_shop_distance(player_mgr, creature_mgr):
            return False

        # If expecting a specific class, check if they match.
        # Always allow other classes to interact with rogue trainers for Lockpicking training.
        # https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Cities/Ironforge/images_7297.jpg
        if 0 < creature_mgr.creature_template.trainer_class != Classes.CLASS_ROGUE:
            return creature_mgr.creature_template.trainer_class == player_mgr.player.class_

        # Mount, TradeSkill or Pet trainer.
        return True

    @staticmethod
    def is_player_class_trainer(creature_mgr, player_mgr):
        if creature_mgr.creature_template.trainer_class > 0:
            return creature_mgr.creature_template.trainer_class == player_mgr.player.class_
        return True

    @staticmethod
    def player_can_learn_talent(training_spell: TrainerTemplate, spell: Spell, player_mgr, self_talent=False):
        spell_item_class = spell.EquippedItemClass
        spell_item_subclass_mask = spell.EquippedItemSubclass
        # Check for required proficiencies for this talent.
        if spell_item_class != -1 and spell_item_subclass_mask != 1:
            # Don't display talent if the player can never learn the proficiency needed.
            if not player_mgr.skill_manager.can_ever_use_equipment(spell_item_class, spell_item_subclass_mask):
                return False
            # Player talents require that the player already meets the needed requirements.
            if self_talent:
                if not player_mgr.skill_manager.can_use_equipment_now(spell_item_class, spell_item_subclass_mask):
                    return False

        # Get player race/class masks.
        race_mask = 1 << player_mgr.race - 1
        class_mask = 1 << player_mgr.class_ - 1

        # Set in trainer template.
        template_req_skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(training_spell.reqskill)
        if template_req_skill:
            # Check player race/class masks with skill race/class masks.
            skill_race_mask = template_req_skill.RaceMask
            if template_req_skill.ExcludeRace:
                skill_race_mask = ~skill_race_mask

            skill_class_mask = template_req_skill.ClassMask
            if template_req_skill.ExcludeClass:
                skill_class_mask = ~skill_class_mask

            if skill_race_mask and not race_mask & skill_race_mask:
                return False
            if skill_class_mask and not class_mask & skill_class_mask:
                return False

        return True
