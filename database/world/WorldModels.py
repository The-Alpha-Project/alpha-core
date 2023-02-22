# coding: utf-8
from sqlalchemy import CHAR, Column, Float, ForeignKey, Index, String, Table, Text, text
from sqlalchemy.dialects.mysql import INTEGER, LONGTEXT, MEDIUMINT, SMALLINT, TINYINT
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()
metadata = Base.metadata


class AppliedUpdates(Base):
    __tablename__ = 'applied_updates'

    id = Column(String(9), primary_key=True, server_default=text("'000000000'"))


class AreatriggerTeleport(Base):
    __tablename__ = 'areatrigger_teleport'

    id = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"), comment='Identifier')
    name = Column(Text)
    required_level = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    required_item = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    required_item2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    required_quest_done = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    target_map = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    target_position_x = Column(Float, nullable=False, server_default=text("'0'"))
    target_position_y = Column(Float, nullable=False, server_default=text("'0'"))
    target_position_z = Column(Float, nullable=False, server_default=text("'0'"))
    target_orientation = Column(Float, nullable=False, server_default=text("'0'"))


class AreaTemplate(Base):
    __tablename__ = 'area_template'

    entry = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"), comment='Identifier')
    map_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    zone_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    explore_flag = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    flags = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    area_level = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    name = Column(Text, nullable=False, server_default=text(""))
    team = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    liquid_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))


class ExplorationBaseXP(Base):
    __tablename__ = 'exploration_base_xp'

    level = Column(TINYINT, primary_key=True, server_default=text("'0'"))
    base_xp = Column(MEDIUMINT, nullable=False, server_default=text("'0'"))


class CreatureModelInfo(Base):
    __tablename__ = 'creature_model_info'

    modelid = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    bounding_radius = Column(Float, nullable=False, server_default=text("'0'"))
    combat_reach = Column(Float, nullable=False, server_default=text("'0'"))
    gender = Column(TINYINT(3), nullable=False, server_default=text("'2'"))
    modelid_other_gender = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    modelid_other_team = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class CreatureSpell(Base):
    __tablename__ = 'creature_spells'

    entry = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    name = Column(String(255), nullable=False, server_default=text("''"))
    spellId_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_1 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_1 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_1 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_2 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_2 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_2 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_3 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_3 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_3 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_4 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_4 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_4 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_5 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_5 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_5 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_5 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_6 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_6 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_6 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_6 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_7 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_7 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_7 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_7 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_7 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spellId_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    probability_8 = Column(TINYINT(3), nullable=False, server_default=text("'100'"))
    castTarget_8 = Column(TINYINT(2), nullable=False, server_default=text("'1'"))
    targetParam1_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    targetParam2_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    castFlags_8 = Column(TINYINT(2), nullable=False, server_default=text("'0'"))
    delayInitialMin_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayInitialMax_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMin_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    delayRepeatMax_8 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    scriptId_8 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


t_creature_spells_scripts = Table(
    'creature_spells_scripts', metadata,
    Column('id', MEDIUMINT(8), nullable=False, server_default=text("'0'")),
    Column('delay', INTEGER(10), nullable=False, server_default=text("'0'")),
    Column('command', MEDIUMINT(8), nullable=False, server_default=text("'0'")),
    Column('datalong', MEDIUMINT(8), nullable=False, server_default=text("'0'")),
    Column('datalong2', INTEGER(10), nullable=False, server_default=text("'0'")),
    Column('datalong3', INTEGER(10), nullable=False, server_default=text("'0'")),
    Column('datalong4', INTEGER(10), nullable=False, server_default=text("'0'")),
    Column('target_param1', INTEGER(10), nullable=False, server_default=text("'0'")),
    Column('target_param2', INTEGER(10), nullable=False, server_default=text("'0'")),
    Column('target_type', TINYINT(3), nullable=False, server_default=text("'0'")),
    Column('data_flags', TINYINT(3), nullable=False, server_default=text("'0'")),
    Column('dataint', INTEGER(11), nullable=False, server_default=text("'0'")),
    Column('dataint2', INTEGER(11), nullable=False, server_default=text("'0'")),
    Column('dataint3', INTEGER(11), nullable=False, server_default=text("'0'")),
    Column('dataint4', INTEGER(11), nullable=False, server_default=text("'0'")),
    Column('x', Float, nullable=False, server_default=text("'0'")),
    Column('y', Float, nullable=False, server_default=text("'0'")),
    Column('z', Float, nullable=False, server_default=text("'0'")),
    Column('o', Float, nullable=False, server_default=text("'0'")),
    Column('condition_id', MEDIUMINT(8), nullable=False, server_default=text("'0'")),
    Column('comments', String(255), nullable=False)
)


class CreatureTemplate(Base):
    __tablename__ = 'creature_template'

    entry = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    display_id1 = Column(MEDIUMINT(8), nullable=False, index=True, server_default=text("'0'"))
    display_id2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    display_id3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    display_id4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    mount_display_id = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    name = Column(CHAR(100), nullable=False, index=True, server_default=text("'0'"))
    subname = Column(CHAR(100))
    static_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    gossip_menu_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    level_min = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    level_max = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    health_min = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    health_max = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    mana_min = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    mana_max = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    armor = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    faction = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    npc_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    speed_walk = Column(Float, nullable=False, server_default=text("'1'"), comment='Result of 2.5/2.5, most common value')
    speed_run = Column(Float, nullable=False, server_default=text("'1.14286'"), comment='Result of 8.0/7.0, most common value')
    scale = Column(Float, nullable=False, server_default=text("'1'"))
    detection_range = Column(Float, nullable=False, server_default=text("'20'"))
    call_for_help_range = Column(Float, nullable=False, server_default=text("'5'"))
    leash_range = Column(Float, nullable=False, server_default=text("'0'"))
    rank = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    xp_multiplier = Column(Float, nullable=False, server_default=text("'1'"))
    dmg_min = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_max = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_school = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    attack_power = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    dmg_multiplier = Column(Float, nullable=False, server_default=text("'1'"))
    base_attack_time = Column(INTEGER(10), nullable=False, server_default=text("'2000'"))
    ranged_attack_time = Column(INTEGER(10), nullable=False, server_default=text("'2000'"))
    unit_class = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    unit_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    dynamic_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    beast_family = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    trainer_type = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    trainer_spell = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    trainer_class = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    trainer_race = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    ranged_dmg_min = Column(Float, nullable=False, server_default=text("'0'"))
    ranged_dmg_max = Column(Float, nullable=False, server_default=text("'0'"))
    ranged_attack_power = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    type_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    loot_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    pickpocket_loot_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    skinning_loot_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    holy_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    fire_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    nature_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    frost_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    shadow_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    arcane_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spell_id1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spell_id2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spell_id3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spell_id4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spell_list_id = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    pet_spell_list_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    auras = Column(Text)
    gold_min = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    gold_max = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ai_name = Column(CHAR(64), nullable=False, server_default=text("''"))
    movement_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    inhabit_type = Column(TINYINT(3), nullable=False, server_default=text("'3'"))
    civilian = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    racial_leader = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    regeneration = Column(TINYINT(3), nullable=False, server_default=text("'3'"))
    equipment_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    trainer_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    vendor_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    mechanic_immune_mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    school_immune_mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    flags_extra = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    script_name = Column(CHAR(64), nullable=False, server_default=text("''"))

    quest_involved = relationship('QuestTemplate', secondary='creature_quest_finisher')
    quest_relation = relationship('QuestTemplate', secondary='creature_quest_starter')


class GameobjectTemplate(Base):
    __tablename__ = 'gameobject_template'

    entry = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    display_id = Column('displayId', MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    name = Column(String(100), nullable=False, index=True, server_default=text("''"))
    faction = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    scale = Column('size', Float, nullable=False, server_default=text("'1'"))
    data0 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    data2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data3 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data4 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data5 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    data7 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data8 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    data9 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    mingold = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    maxgold = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    script_name = Column(String(64), nullable=False, server_default=text("''"))


class ItemTemplate(Base):
    __tablename__ = 'item_template'

    entry = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    class_ = Column('class', TINYINT(3), nullable=False, index=True, server_default=text("'0'"))
    subclass = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    name = Column(String(255), nullable=False, server_default=text("''"))
    description = Column(String(255), nullable=False, server_default=text("''"))
    display_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    quality = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    buy_count = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    buy_price = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    sell_price = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    inventory_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    allowable_class = Column(MEDIUMINT(9), nullable=False, server_default=text("'-1'"))
    allowable_race = Column(MEDIUMINT(9), nullable=False, server_default=text("'-1'"))
    item_level = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    required_level = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    required_skill = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    required_skill_rank = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    required_spell = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    required_honor_rank = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    required_city_rank = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    required_reputation_faction = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    required_reputation_rank = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    max_count = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    stackable = Column(SMALLINT(5), nullable=False, server_default=text("'1'"))
    container_slots = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_type1 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value1 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type2 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value2 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type3 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value3 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type4 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value4 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type5 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value5 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type6 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value6 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type7 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value7 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type8 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value8 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type9 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value9 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    stat_type10 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    stat_value10 = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    delay = Column(SMALLINT(5), nullable=False, server_default=text("'1000'"))
    range_mod = Column(Float, nullable=False, server_default=text("'0'"))
    ammo_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    dmg_min1 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_max1 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_type1 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    dmg_min2 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_max2 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_type2 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    dmg_min3 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_max3 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_type3 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    dmg_min4 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_max4 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_type4 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    dmg_min5 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_max5 = Column(Float, nullable=False, server_default=text("'0'"))
    dmg_type5 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    block = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    armor = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    holy_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    fire_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    nature_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    frost_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    shadow_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    arcane_res = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spellid_1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spelltrigger_1 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spellcharges_1 = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    spellppmrate_1 = Column(Float, nullable=False, server_default=text("'0'"))
    spellcooldown_1 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellcategory_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spellcategorycooldown_1 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellid_2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spelltrigger_2 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spellcharges_2 = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    spellppmrate_2 = Column(Float, nullable=False, server_default=text("'0'"))
    spellcooldown_2 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellcategory_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spellcategorycooldown_2 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellid_3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spelltrigger_3 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spellcharges_3 = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    spellppmrate_3 = Column(Float, nullable=False, server_default=text("'0'"))
    spellcooldown_3 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellcategory_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spellcategorycooldown_3 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellid_4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spelltrigger_4 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spellcharges_4 = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    spellppmrate_4 = Column(Float, nullable=False, server_default=text("'0'"))
    spellcooldown_4 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellcategory_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spellcategorycooldown_4 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellid_5 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    spelltrigger_5 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spellcharges_5 = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    spellppmrate_5 = Column(Float, nullable=False, server_default=text("'0'"))
    spellcooldown_5 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    spellcategory_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    spellcategorycooldown_5 = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    bonding = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    page_text = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    page_language = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    page_material = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    start_quest = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    lock_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    material = Column(TINYINT(4), nullable=False, server_default=text("'0'"))
    sheath = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    random_property = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    set_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    max_durability = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    area_bound = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    map_bound = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    duration = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    bag_family = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    disenchant_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    food_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    min_money_loot = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    max_money_loot = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    extra_flags = Column(TINYINT(1), nullable=False, server_default=text("'0'"))
    ignored = Column(TINYINT(1), nullable=False, server_default=text("'0'"))


class AppliedItemUpdates(Base):
    __tablename__ = 'applied_item_updates'

    entry = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    version = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class AreatriggerQuestRelation(Base):
    __tablename__ = 'areatrigger_quest_relation'
    __table_args__ = {'comment': 'Trigger System'}

    id = Column(MEDIUMINT(8), primary_key=True, server_default=text("0"), comment='Identifier')
    quest = Column(MEDIUMINT(8), nullable=False, server_default=text("0"), comment='Quest Identifier')


class NpcText(Base):
    __tablename__ = 'npc_text'

    id = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    text0_0 = Column(LONGTEXT, nullable=False)
    text0_1 = Column(LONGTEXT, nullable=False)
    lang0 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob0 = Column(Float, nullable=False, server_default=text("'0'"))
    em0_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em0_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em0_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em0_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em0_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em0_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text1_0 = Column(LONGTEXT, nullable=False)
    text1_1 = Column(LONGTEXT, nullable=False)
    lang1 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob1 = Column(Float, nullable=False, server_default=text("'0'"))
    em1_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em1_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em1_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em1_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em1_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em1_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text2_0 = Column(LONGTEXT, nullable=False)
    text2_1 = Column(LONGTEXT, nullable=False)
    lang2 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob2 = Column(Float, nullable=False, server_default=text("'0'"))
    em2_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em2_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em2_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em2_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em2_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em2_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text3_0 = Column(LONGTEXT, nullable=False)
    text3_1 = Column(LONGTEXT, nullable=False)
    lang3 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob3 = Column(Float, nullable=False, server_default=text("'0'"))
    em3_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em3_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em3_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em3_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em3_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em3_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text4_0 = Column(LONGTEXT, nullable=False)
    text4_1 = Column(LONGTEXT, nullable=False)
    lang4 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob4 = Column(Float, nullable=False, server_default=text("'0'"))
    em4_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em4_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em4_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em4_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em4_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em4_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text5_0 = Column(LONGTEXT, nullable=False)
    text5_1 = Column(LONGTEXT, nullable=False)
    lang5 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob5 = Column(Float, nullable=False, server_default=text("'0'"))
    em5_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em5_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em5_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em5_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em5_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em5_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text6_0 = Column(LONGTEXT, nullable=False)
    text6_1 = Column(LONGTEXT, nullable=False)
    lang6 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob6 = Column(Float, nullable=False, server_default=text("'0'"))
    em6_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em6_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em6_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em6_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em6_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em6_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    text7_0 = Column(LONGTEXT, nullable=False)
    text7_1 = Column(LONGTEXT, nullable=False)
    lang7 = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    prob7 = Column(Float, nullable=False, server_default=text("'0'"))
    em7_0 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em7_1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em7_2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em7_3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em7_4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    em7_5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))


class PlayerClasslevelstats(Base):
    __tablename__ = 'player_classlevelstats'

    _class = Column('class', TINYINT(3), primary_key=True, nullable=False)
    level = Column(TINYINT(3), primary_key=True, nullable=False)
    basehp = Column(SMALLINT(5), nullable=False)
    basemana = Column(SMALLINT(5), nullable=False)


class PlayerLevelstats(Base):
    __tablename__ = 'player_levelstats'

    race = Column(TINYINT(3), primary_key=True, nullable=False)
    _class = Column('class', TINYINT(3), primary_key=True, nullable=False)
    level = Column(TINYINT(3), primary_key=True, nullable=False)
    str = Column(TINYINT(3), nullable=False)
    agi = Column(TINYINT(3), nullable=False)
    sta = Column(TINYINT(3), nullable=False)
    inte = Column(TINYINT(3), nullable=False)
    spi = Column(TINYINT(3), nullable=False)


class PetLevelstat(Base):
    __tablename__ = 'pet_levelstats'

    creature_entry = Column(MEDIUMINT(8), primary_key=True, nullable=False)
    level = Column(TINYINT(3), primary_key=True, nullable=False)
    hp = Column(SMALLINT(5), nullable=False)
    mana = Column(SMALLINT(5), nullable=False)
    armor = Column(INTEGER(10), nullable=False, server_default=text("0"))
    str = Column(SMALLINT(5), nullable=False)
    agi = Column(SMALLINT(5), nullable=False)
    sta = Column(SMALLINT(5), nullable=False)
    inte = Column(SMALLINT(5), nullable=False)
    spi = Column(SMALLINT(5), nullable=False)


class Playercreateinfo(Base):
    __tablename__ = 'playercreateinfo'

    id = Column(INTEGER(10), primary_key=True, nullable=False, index=True)
    race = Column(TINYINT(3), primary_key=True, nullable=False, server_default=text("'0'"))
    _class = Column('class', TINYINT(3), primary_key=True, nullable=False, server_default=text("'0'"))
    map = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    zone = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    position_x = Column(Float, nullable=False, server_default=text("'0'"))
    position_y = Column(Float, nullable=False, server_default=text("'0'"))
    position_z = Column(Float, nullable=False, server_default=text("'0'"))
    orientation = Column(Float, nullable=False, server_default=text("'0'"))


class PlayercreateinfoAction(Base):
    __tablename__ = 'playercreateinfo_action'
    __table_args__ = (
        Index('playercreateinfo_race_class_index', 'race', 'class'),
    )

    race = Column(TINYINT(3), primary_key=True, nullable=False, server_default=text("'0'"))
    _class = Column('class', TINYINT(3), primary_key=True, nullable=False, server_default=text("'0'"))
    button = Column(SMALLINT(5), primary_key=True, nullable=False, server_default=text("'0'"))
    action = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    type = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))


class PlayercreateinfoItem(Base):
    __tablename__ = 'playercreateinfo_item'
    __table_args__ = (
        Index('playercreateinfo_race_class_index', 'race', 'class'),
    )

    id = Column(INTEGER(10), primary_key=True, index=True)
    race = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    _class = Column('class', TINYINT(3), nullable=False, server_default=text("'0'"))
    itemid = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    amount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))


class PlayercreateinfoSpell(Base):
    __tablename__ = 'playercreateinfo_spell'

    race = Column(TINYINT(3), primary_key=True, nullable=False, server_default=text("'0'"))
    _class = Column('class', TINYINT(3), primary_key=True, nullable=False, server_default=text("'0'"))
    Spell = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    Note = Column(String(255))


class QuestTemplate(Base):
    __tablename__ = 'quest_template'

    entry = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))
    Method = Column(TINYINT(3), nullable=False, server_default=text("'2'"))
    ZoneOrSort = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))
    MinLevel = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    MaxLevel = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    QuestLevel = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    Type = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RequiredClasses = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RequiredRaces = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RequiredSkill = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RequiredSkillValue = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RepObjectiveFaction = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RepObjectiveValue = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RequiredMinRepFaction = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RequiredMinRepValue = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RequiredMaxRepFaction = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RequiredMaxRepValue = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    SuggestedPlayers = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    LimitTime = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    QuestFlags = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    SpecialFlags = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    PrevQuestId = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    NextQuestId = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    ExclusiveGroup = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    NextQuestInChain = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    SrcItemId = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    SrcItemCount = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    SrcSpell = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    Title = Column(Text)
    Details = Column(Text)
    Objectives = Column(Text)
    OfferRewardText = Column(Text)
    RequestItemsText = Column(Text)
    EndText = Column(Text)
    ObjectiveText1 = Column(Text)
    ObjectiveText2 = Column(Text)
    ObjectiveText3 = Column(Text)
    ObjectiveText4 = Column(Text)
    ReqItemId1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqItemId2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqItemId3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqItemId4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqItemCount1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqItemCount2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqItemCount3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqItemCount4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqSourceId1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSourceId2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSourceId3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSourceId4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSourceCount1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqSourceCount2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqSourceCount3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqSourceCount4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOId1 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOId2 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOId3 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOId4 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOCount1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOCount2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOCount3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqCreatureOrGOCount4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    ReqSpellCast1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSpellCast2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSpellCast3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ReqSpellCast4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemId1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemId2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemId3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemId4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemId5 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemId6 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewChoiceItemCount1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewChoiceItemCount2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewChoiceItemCount3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewChoiceItemCount4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewChoiceItemCount5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewChoiceItemCount6 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewItemId1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewItemId2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewItemId3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewItemId4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewItemCount1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewItemCount2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewItemCount3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewItemCount4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    RewRepFaction1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"), comment='faction id from Faction.dbc in this case')
    RewRepFaction2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"), comment='faction id from Faction.dbc in this case')
    RewRepFaction3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"), comment='faction id from Faction.dbc in this case')
    RewRepFaction4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"), comment='faction id from Faction.dbc in this case')
    RewRepFaction5 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"), comment='faction id from Faction.dbc in this case')
    RewRepValue1 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RewRepValue2 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RewRepValue3 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RewRepValue4 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RewRepValue5 = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RewXP = Column(MEDIUMINT(9), nullable=False, server_default=text("'0'"))
    RewOrReqMoney = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RewSpell = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewSpellCast = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewMailTemplateId = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    RewMailDelaySecs = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RewMailMoney = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    PointMapId = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    PointX = Column(Float, nullable=False, server_default=text("'0'"))
    PointY = Column(Float, nullable=False, server_default=text("'0'"))
    PointOpt = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    DetailsEmote1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    DetailsEmote2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    DetailsEmote3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    DetailsEmote4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    DetailsEmoteDelay1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DetailsEmoteDelay2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DetailsEmoteDelay3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DetailsEmoteDelay4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    IncompleteEmote = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    CompleteEmote = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    OfferRewardEmote1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    OfferRewardEmote2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    OfferRewardEmote3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    OfferRewardEmote4 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    OfferRewardEmoteDelay1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    OfferRewardEmoteDelay2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    OfferRewardEmoteDelay3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    OfferRewardEmoteDelay4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    StartScript = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    CompleteScript = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    ignored = Column(TINYINT(1), nullable=False, server_default=text("'0'"))


class QuestGreeting(Base):
    __tablename__ = 'quest_greeting'

    entry = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("0"))
    type = Column(TINYINT(3), primary_key=True, nullable=False, server_default=text("0"))
    content_default = Column(Text, nullable=False)
    content_loc1 = Column(Text)
    content_loc2 = Column(Text)
    content_loc3 = Column(Text)
    content_loc4 = Column(Text)
    content_loc5 = Column(Text)
    content_loc6 = Column(Text)
    content_loc7 = Column(Text)
    content_loc8 = Column(Text)
    emote_id = Column(SMALLINT(5), nullable=False, server_default=text("0"))
    emote_delay = Column(INTEGER(10), nullable=False, server_default=text("0"))


class Worldports(Base):
    __tablename__ = 'worldports'

    entry = Column(INTEGER(11), autoincrement=True, primary_key=True)
    x = Column(Float, nullable=False, server_default=text("'0'"))
    y = Column(Float, nullable=False, server_default=text("'0'"))
    z = Column(Float, nullable=False, server_default=text("'0'"))
    o = Column(Float, nullable=False, server_default=text("'0'"))
    map = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    name = Column(String(255), nullable=False, server_default=text("''"))


class CreatureOnkillReputation(Base):
    __tablename__ = 'creature_onkill_reputation'
    __table_args__ = {'comment': 'Creature OnKill Reputation gain'}

    creature_id = Column(MEDIUMINT(8), primary_key=True, server_default=text("0"), comment='Creature Identifier')
    RewOnKillRepFaction1 = Column(SMALLINT(6), nullable=False, server_default=text("0"))
    RewOnKillRepFaction2 = Column(SMALLINT(6), nullable=False, server_default=text("0"))
    MaxStanding1 = Column(TINYINT(4), nullable=False, server_default=text("0"))
    RewOnKillRepValue1 = Column(MEDIUMINT(9), nullable=False, server_default=text("0"))
    MaxStanding2 = Column(TINYINT(4), nullable=False, server_default=text("0"))
    RewOnKillRepValue2 = Column(MEDIUMINT(9), nullable=False, server_default=text("0"))
    TeamDependent = Column(TINYINT(3), nullable=False, server_default=text("0"))


class CreatureLootTemplate(Base):
    __tablename__ = 'creature_loot_template'

    entry = Column(ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"), comment='entry 0 used for player insignia loot')
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


t_creature_quest_starter = Table(
    'creature_quest_starter', metadata,
    Column('entry', ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"), comment='Identifier'),
    Column('quest', ForeignKey('quest_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"), comment='Quest Identifier')
)


t_creature_quest_finisher = Table(
    'creature_quest_finisher', metadata,
    Column('entry', ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"), comment='Identifier'),
    Column('quest', ForeignKey('quest_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"), comment='Quest Identifier')
)


t_gameobject_quest_starter = Table(
    'gameobject_quest_starter', metadata,
    Column('entry', ForeignKey('gameobject_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"), comment='Identifier'),
    Column('quest', ForeignKey('quest_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"), comment='Quest Identifier')
)


t_gameobject_quest_finisher = Table(
    'gameobject_quest_finisher', metadata,
    Column('entry', ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"), comment='Identifier'),
    Column('quest', ForeignKey('quest_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"), comment='Quest Identifier')
)


class GameobjectLootTemplate(Base):
    __tablename__ = 'gameobject_loot_template'

    entry = Column(ForeignKey('gameobject_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class FishingLootTemplate(Base):
    __tablename__ = 'fishing_loot_template'

    entry = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class SkillFishingBaseLevel(Base):
    __tablename__ = 'skill_fishing_base_level'

    entry = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    skill = Column(SMALLINT(6), nullable=False, server_default=text("'0'"))


class ItemLootTemplate(Base):
    __tablename__ = 'item_loot_template'

    entry = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))

class DefaultProfessionSpell(Base):
    __tablename__ = 'default_profession_spell'
    
    trainer_spell = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    default_spell = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))

class TrainerTemplate(Base):
    __tablename__ = 'trainer_template'
    
    template_entry = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    spell = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    playerspell = Column(MEDIUMINT(8), nullable=False, server_default=text("'0"))
    spellcost = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    talentpointcost = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    skillpointcost = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    reqskill = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    reqskillvalue = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    reqlevel = Column(TINYINT(3), nullable=False, server_default=text("'0'"))


class NpcTrainerGreeting(Base):
    __tablename__ = 'npc_trainer_greeting'

    entry = Column(INTEGER(11), primary_key=True, server_default=text("0"))
    content_default = Column(Text, nullable=False)


class SpellChain(Base):
    __tablename__ = 'spell_chain'

    spell_id = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    prev_spell = Column(MEDIUMINT(8), primary_key=False, nullable=False, server_default=text("'0'"))
    first_spell = Column(MEDIUMINT(8), primary_key=False, nullable=False, server_default=text("'0'"))
    rank = Column(TINYINT(3), primary_key=False, nullable=False, server_default=text("'0'"))
    req_spell = Column(MEDIUMINT(8), primary_key=False, nullable=False, server_default=text("'0'"))


class SpellTargetPosition(Base):
    __tablename__ = 'spell_target_position'

    id = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("0"))
    target_map = Column(SMALLINT(5), primary_key=True, nullable=False, server_default=text("0"))
    target_position_x = Column(Float, nullable=False, server_default=text("0"))
    target_position_y = Column(Float, nullable=False, server_default=text("0"))
    target_position_z = Column(Float, nullable=False, server_default=text("0"))
    target_orientation = Column(Float, nullable=False, server_default=text("0"))


class NpcVendor(Base):
    __tablename__ = 'npc_vendor'

    entry = Column(ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    incrtime = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    itemflags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    slot = Column(TINYINT(3), nullable=False, server_default=text("'0'"))


class PickpocketingLootTemplate(Base):
    __tablename__ = 'pickpocketing_loot_template'

    entry = Column(ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class ReferenceLootTemplate(Base):
    __tablename__ = 'reference_loot_template'

    entry = Column(MEDIUMINT(8), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class SkinningLootTemplate(Base):
    __tablename__ = 'skinning_loot_template'

    entry = Column(ForeignKey('creature_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, server_default=text("'0'"))
    item = Column(ForeignKey('item_template.entry', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ChanceOrQuestChance = Column(Float, nullable=False, server_default=text("'100'"))
    groupid = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    mincountOrRef = Column(MEDIUMINT(9), nullable=False, server_default=text("'1'"))
    maxcount = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class SpawnsCreatures(Base):
    __tablename__ = 'spawns_creatures'

    spawn_id = Column(INTEGER(10), primary_key=True, comment='Global Unique Identifier')
    spawn_entry1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"), comment='Creature Template Id')
    spawn_entry2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"), comment='Creature Template Id')
    spawn_entry3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"), comment='Creature Template Id')
    spawn_entry4 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"), comment='Creature Template Id')
    map = Column(SMALLINT(5), nullable=False, index=True, server_default=text("'0'"), comment='Map Identifier')
    position_x = Column(Float, nullable=False, server_default=text("'0'"))
    position_y = Column(Float, nullable=False, server_default=text("'0'"))
    position_z = Column(Float, nullable=False, server_default=text("'0'"))
    orientation = Column(Float, nullable=False, server_default=text("'0'"))
    spawntimesecsmin = Column(INTEGER(10), nullable=False, server_default=text("'120'"))
    spawntimesecsmax = Column(INTEGER(10), nullable=False, server_default=text("'120'"))
    wander_distance = Column(Float, nullable=False, server_default=text("'5'"))
    health_percent = Column(Float, nullable=False, server_default=text("'100'"))
    mana_percent = Column(Float, nullable=False, server_default=text("'100'"))
    movement_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spawn_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    visibility_mod = Column(Float, server_default=text("'0'"))
    ignored = Column(TINYINT(1), nullable=False, server_default=text("'0'"))

    addon = relationship('CreatureAddon', foreign_keys='CreatureAddon.guid',
                         primaryjoin='SpawnsCreatures.spawn_id == CreatureAddon.guid',
                         lazy='joined', uselist=False)
    npc_text = relationship('NpcText', secondary='npc_gossip')


class SpawnsGameobjects(Base):
    __tablename__ = 'spawns_gameobjects'

    spawn_id = Column(INTEGER(10), primary_key=True, comment='Global Unique Identifier')
    spawn_entry = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"), comment='Gameobject Template Id')
    spawn_map = Column(SMALLINT(5), nullable=False, index=True, server_default=text("'0'"), comment='Map Identifier')
    spawn_positionX = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_positionY = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_positionZ = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_orientation = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_rotation0 = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_rotation1 = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_rotation2 = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_rotation3 = Column(Float, nullable=False, server_default=text("'0'"))
    spawn_spawntimemin = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    spawn_spawntimemax = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    spawn_animprogress = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spawn_state = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    spawn_flags = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    spawn_visibility_mod = Column(Float, nullable=True, server_default=text("'0'"))
    ignored = Column(TINYINT(1), nullable=False, server_default=text("'0'"))


class NpcGossip(Base):
    __tablename__ = 'npc_gossip'

    npc_guid = Column(ForeignKey('spawns_creatures.spawn_id', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    textid = Column(ForeignKey('npc_text.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True, server_default=text("'0'"))

class PageText(Base):
    __tablename__ = 'page_text'

    entry = Column(MEDIUMINT(8), primary_key=True)
    text = Column(LONGTEXT, nullable=False, server_default=text("''"))
    next_page = Column(MEDIUMINT(8), nullable=False)


class CreatureEquipTemplate(Base):
    __tablename__ = 'creature_equip_template'

    entry = Column(MEDIUMINT(8), primary_key=True)
    equipentry1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    equipentry2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    equipentry3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))


class CreatureAddon(Base):
    __tablename__ = 'creature_addon'

    guid = Column(INTEGER(10), primary_key=True, comment='Global Unique Identifier')
    display_id = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    mount_display_id = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    equipment_id = Column(INTEGER(11), nullable=False, server_default=text("'-1'"))
    stand_state = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    sheath_state = Column(TINYINT(3), nullable=False, server_default=text("'1'"))
    emote_state = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    auras = Column(Text)

class QuestStartScript(Base):
    __tablename__ = 'quest_start_scripts'

    id = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))    
    quest_id = Column(MEDIUMINT(5), primary_key=False, server_default=text("'0'"))    
    delay = Column(INTEGER(10), primary_key=False, server_default=text("'0'"))
    priority = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))
    command = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    datalong = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    datalong2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    datalong3 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    datalong4 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_param1 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_param2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_type = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))
    data_flags = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))    
    dataint = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    x = Column(Float, nullable=False, server_default=text("'0'"))
    y = Column(Float, nullable=False, server_default=text("'0'"))
    z = Column(Float, nullable=False, server_default=text("'0'"))
    o = Column(Float, nullable=False, server_default=text("'0'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    comments = Column(Text)

class QuestEndScript(Base):
    __tablename__ = 'quest_end_scripts'

    id = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))       
    quest_id = Column(MEDIUMINT(5), primary_key=False, server_default=text("'0'"))     
    delay = Column(INTEGER(10), primary_key=False, server_default=text("'0'"))
    priority = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))
    command = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    datalong = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    datalong2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    datalong3 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    datalong4 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_param1 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_param2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_type = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))
    data_flags = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))    
    dataint = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    x = Column(Float, nullable=False, server_default=text("'0'"))
    y = Column(Float, nullable=False, server_default=text("'0'"))
    z = Column(Float, nullable=False, server_default=text("'0'"))
    o = Column(Float, nullable=False, server_default=text("'0'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    comments = Column(Text)    

class CreatureAIScript(Base):
    __tablename__ = 'creature_ai_scripts'

    id = Column(MEDIUMINT(8), primary_key=True, server_default=text("'0'"))       
    quest_id = Column(MEDIUMINT(5), primary_key=False, server_default=text("'0'"))     
    delay = Column(INTEGER(10), primary_key=False, server_default=text("'0'"))
    priority = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))
    command = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    datalong = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    datalong2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    datalong3 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    datalong4 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_param1 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_param2 = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    target_type = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))
    data_flags = Column(TINYINT(3), primary_key=False, server_default=text("'0'"))    
    dataint = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    dataint4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    x = Column(Float, nullable=False, server_default=text("'0'"))
    y = Column(Float, nullable=False, server_default=text("'0'"))
    z = Column(Float, nullable=False, server_default=text("'0'"))
    o = Column(Float, nullable=False, server_default=text("'0'"))
    condition_id = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    comments = Column(Text) 

class BroadcastText(Base):
    __tablename__ = 'broadcast_text'

    entry = Column(MEDIUMINT(8), primary_key=True)
    male_text = Column(LONGTEXT, nullable=True)
    female_text = Column(LONGTEXT, nullable=True)
    chat_type = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    sound_id = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    language_id = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    emote_id1 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    emote_id2 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    emote_id3 = Column(SMALLINT(5), nullable=False, server_default=text("'0'"))
    emote_delay1 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    emote_delay2 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))
    emote_delay3 = Column(MEDIUMINT(8), nullable=False, server_default=text("'0'"))

class CreatureAIEvent(Base):
    __tablename__ = 'creature_ai_events'

    id = Column(INTEGER(11), primary_key=True, nullable=False)
    creature_id = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    condition_id = Column(INTEGER(8), nullable=False, server_default=text("'0'"))
    event_type = Column(TINYINT(5), nullable=False, server_default=text("'0'"))
    event_inverse_phase_mask = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    event_chance = Column(INTEGER(3), nullable=False, server_default=text("'100'"))
    event_flags = Column(INTEGER(3), nullable=False, server_default=text("'0'"))
    event_param1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    event_param2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    event_param3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    event_param4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    action1_script = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    action2_script = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    action3_script = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    comment = Column(Text)
