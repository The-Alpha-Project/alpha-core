from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.player.ReputationManager import ReputationManager
from game.world.managers.objects.player.SkillManager import SkillManager, SkillTypes
from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *
from database.world.WorldDatabaseManager import *
from utils import TextUtils
from utils.constants.CharCodes import *
from utils.ConfigManager import config
from utils.constants.ItemCodes import InventorySlots
from utils.constants.MiscCodes import SkillCategories
from utils.constants.SpellCodes import SpellEffects
from utils.constants.UnitCodes import Classes


class CharCreateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        name = PacketReader.read_string(reader.data, 0)
        if not config.Server.Settings.blizzlike_names:
            name = name.capitalize()

        race, class_, gender, skin, face, hairstyle, haircolor, facialhair, outfit_id = unpack(
            '<9B', reader.data[len(name)+1:]
        )
        race_mask = 1 << (race - 1)
        class_mask = 1 << (class_ - 1)

        result = CharCreate.CHAR_CREATE_SUCCESS

        # Disabled race & class checks (only if not a GM)
        if world_session.account_mgr.account.gmlevel == 0:
            disabled_race_mask = config.Server.General.disabled_race_mask
            disabled = disabled_race_mask & race_mask == race_mask

            if not disabled:
                disabled_class_mask = config.Server.General.disabled_class_mask
                disabled = disabled_class_mask & class_mask == class_mask

            if disabled:
                result = CharCreate.CHAR_CREATE_DISABLED

        if RealmDatabaseManager.character_does_name_exist(name):
            result = CharCreate.CHAR_CREATE_NAME_IN_USE

        if not TextUtils.TextChecker.valid_text(name, is_name=True):
            result = CharCreate.CHAR_CREATE_ERROR

        if result == CharCreate.CHAR_CREATE_SUCCESS:
            map_, zone, x, y, z, o = CharCreateHandler.get_starting_location(race, class_)
            base_stats = WorldDatabaseManager.player_get_class_level_stats(class_,
                                                                           config.Unit.Player.Defaults.starting_level)
            character = Character(account_id=world_session.account_mgr.account.id,
                                  name=name,
                                  race=race,
                                  class_=class_,
                                  gender=gender,
                                  skin=skin,
                                  face=face,
                                  hairstyle=hairstyle,
                                  haircolour=haircolor,
                                  facialhair=facialhair,
                                  map=map_,
                                  zone=zone,
                                  position_x=x,
                                  position_y=y,
                                  position_z=z,
                                  orientation=o,
                                  health=base_stats.basehp,
                                  power1=base_stats.basemana,
                                  power2=0,
                                  power3=100 if class_ == Classes.CLASS_HUNTER else 0,
                                  power4=100 if class_ == Classes.CLASS_ROGUE else 0,
                                  level=config.Unit.Player.Defaults.starting_level)
            RealmDatabaseManager.character_create(character)
            CharCreateHandler.generate_starting_reputations(character.guid)
            CharCreateHandler.generate_starting_spells(character.guid, race, class_, character.level)
            CharCreateHandler.generate_starting_items(character.guid, race, class_, gender)
            default_deathbind = CharacterDeathbind(
                player_guid=character.guid,
                creature_binder_guid=0,
                deathbind_map=map_,
                deathbind_zone=zone,
                deathbind_position_x=x,
                deathbind_position_y=y,
                deathbind_position_z=z
            )
            RealmDatabaseManager.character_add_deathbind(default_deathbind)

        data = pack('<B', result)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHAR_CREATE, data))

        return 0

    @staticmethod
    def get_starting_location(race, class_):
        info = WorldDatabaseManager.player_create_info_get(race, class_)
        return info.map, info.zone, info.position_x, info.position_y, info.position_z, info.orientation

    @staticmethod
    def generate_starting_reputations(guid):
        for faction in DbcDatabaseManager.FactionHolder.FACTIONS.values():
            if faction.ReputationIndex > -1:
                reputation_entry = CharacterReputation()
                reputation_entry.guid = guid
                reputation_entry.faction = faction.ID
                reputation_entry.standing = faction.ReputationBase_1
                reputation_entry.index = faction.ReputationIndex
                reputation_entry.flags = ReputationManager.reputation_flag_by_reaction(
                    ReputationManager.reaction_by_standing(faction.ReputationBase_1))

                RealmDatabaseManager.character_add_reputation(reputation_entry)

    @staticmethod
    def generate_starting_spells(guid, race, class_, level):
        added_skills = []
        added_spells = []

        def insert_skill(skill_id_to_insert, override_rank_value=-1, override_max_rank_value=-1):
            if skill_id_to_insert in added_skills:
                return

            skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id_to_insert)
            if not skill:
                return

            if override_rank_value == -1:
                start_rank_value = 1
                if skill.CategoryID == SkillCategories.MAX_SKILL:
                    start_rank_value = skill.MaxRank
            else:
                start_rank_value = override_rank_value

            skill_to_set = CharacterSkill()
            skill_to_set.guid = guid
            skill_to_set.skill = skill_id_to_insert
            skill_to_set.value = start_rank_value
            skill_to_set.max = SkillManager.get_max_rank(level, skill_id_to_insert) if override_max_rank_value == -1 else \
                override_max_rank_value

            RealmDatabaseManager.character_add_skill(skill_to_set)
            added_skills.append(skill_id_to_insert)

        for spell in WorldDatabaseManager.player_create_spell_get(race, class_):
            spell_to_load = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell.Spell)
            if spell_to_load:
                if spell_to_load.ID not in added_spells:
                    spell_to_set = CharacterSpell()
                    spell_to_set.guid = guid
                    spell_to_set.spell = spell_to_load.ID

                    RealmDatabaseManager.character_add_spell(spell_to_set)
                    added_spells.append(spell_to_load.ID)

                    # Insert related skill
                    skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_ability_get_by_spell(spell_to_load.ID)
                    if skill_line_ability:
                        skill_id = skill_line_ability.SkillLine

                        # The value in SkillLineAbility for languages is equal to "language TEMP",
                        # the proper skill is 1 number below.
                        if spell_to_load.Effect_1 == SpellEffects.SPELL_EFFECT_LANGUAGE:
                            skill_id -= 1

                        insert_skill(skill_id)

                    # Add the block skill if character has the Block spell (107)
                    if spell_to_load.ID == 107:
                        insert_skill(SkillTypes.BLOCK.value)

        # TODO: Investigate the below behavior
        """
        # This doesn't seem to work well in 0.5.3, it bugs out the Common language. Maybe it was only possible 
        # in 0.5.5+ as seen here: https://i.imgur.com/kJD11ve.png, or maybe a bad implementation.

        # Insert remaining languages but with value 1
        for lang_id, lang_desc in SkillManager.get_all_languages():
            if lang_desc.spell_id not in added_spells:
                lang_spell = CharacterSpell()
                lang_spell.guid = guid
                lang_spell.spell = lang_desc.spell_id

                RealmDatabaseManager.character_add_spell(lang_spell)
                added_spells.append(lang_desc.spell_id)

                insert_skill(lang_desc.skill_id, override_rank_value=1, override_max_rank_value=1)
        """

    @staticmethod
    def generate_starting_items(guid, race, class_, gender):
        start_items = DbcDatabaseManager.char_start_outfit_get(race, class_, gender)
        items_to_add = [
            start_items.ItemID_1,
            start_items.ItemID_2,
            start_items.ItemID_3,
            start_items.ItemID_4,
            start_items.ItemID_5,
            start_items.ItemID_6,
            start_items.ItemID_7,
            start_items.ItemID_8,
            start_items.ItemID_9,
            start_items.ItemID_10,
            start_items.ItemID_11,
            start_items.ItemID_12
        ]
        last_bag_slot = InventorySlots.SLOT_INBACKPACK.value
        for entry in items_to_add:
            item = ItemManager.generate_starting_item(guid, entry, last_bag_slot)
            if item and item.item_instance:
                RealmDatabaseManager.character_inventory_add_item(item.item_instance)
                if item.current_slot >= InventorySlots.SLOT_INBACKPACK:
                    last_bag_slot += 1
