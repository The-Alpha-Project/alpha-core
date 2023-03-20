# coding: utf-8
from sqlalchemy import Column, Float, Text, text
from sqlalchemy.dialects.mysql import INTEGER, TINYINT
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()
metadata = Base.metadata


class AreaTable(Base):
    __tablename__ = 'AreaTable'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    AreaNumber = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ContinentID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ParentAreaNum = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaBit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SoundProviderPref = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SoundProviderPrefUnderwater = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MIDIAmbience = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MIDIAmbienceUnderwater = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ZoneMusic = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    IntroSound = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    IntroPriority = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaName_enUS = Column(Text)
    AreaName_enGB = Column(Text)
    AreaName_koKR = Column(Text)
    AreaName_frFR = Column(Text)
    AreaName_deDE = Column(Text)
    AreaName_enCN = Column(Text)
    AreaName_zhCN = Column(Text)
    AreaName_enTW = Column(Text)
    AreaName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class TransportAnimation(Base):
    __tablename__ = 'TransportAnimation'

    ID = Column(INTEGER(11), primary_key=True)
    TransportID = Column(INTEGER(11), nullable=False)
    TimeIndex = Column(INTEGER(11), nullable=False)
    X = Column(Float, nullable=False)
    Y = Column(Float, nullable=False)
    Z = Column(Float, nullable=False)


class AreaTrigger(Base):
    __tablename__ = 'AreaTrigger'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ContinentID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    X = Column(Float, nullable=False, server_default=text("'0'"))
    Y = Column(Float, nullable=False, server_default=text("'0'"))
    Z = Column(Float, nullable=False, server_default=text("'0'"))
    Radius = Column(Float, nullable=False, server_default=text("'0'"))


class BankBagSlotPrices(Base):
    __tablename__ = 'BankBagSlotPrices'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Cost = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class CharBaseInfo(Base):
    __tablename__ = 'CharBaseInfo'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    RaceID = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    ClassID = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    Proficiency = Column(INTEGER(11), nullable=False, server_default=text("'0'"))

    proficiency = relationship('ChrProficiency', foreign_keys='ChrProficiency.ID',
                               primaryjoin="CharBaseInfo.Proficiency == ChrProficiency.ID", uselist=False, lazy='joined')


class CharStartOutfit(Base):
    __tablename__ = 'CharStartOutfit'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    RaceID = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    ClassID = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    GenderID = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    OutfitID = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    ItemID_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemID_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayItemID_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InventoryType_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class CharacterCreateCamera(Base):
    __tablename__ = 'CharacterCreateCameras'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Race = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Height = Column(Float, nullable=False, server_default=text("'0'"))
    Radius = Column(Float, nullable=False, server_default=text("'0'"))
    Target = Column(Float, nullable=False, server_default=text("'0'"))


class CharacterFacialHairStyle(Base):
    __tablename__ = 'CharacterFacialHairStyles'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    RaceID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    GenderID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    VariationID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    BeardGeoset = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MoustacheGeoset = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SideburnGeoset = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class ChrClass(Base):
    __tablename__ = 'ChrClasses'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    PlayerClass = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DamageBonusStat = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayPower = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    PetNameToken = Column(Text)
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class ChrProficiency(Base):
    __tablename__ = 'ChrProficiency'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Proficiency_MinLevel_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_13 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_14 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_15 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_MinLevel_16 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_13 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_14 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_15 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_AcquireMethod_16 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_13 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_14 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_15 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemClass_16 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_13 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_14 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_15 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Proficiency_ItemSubClassMask_16 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class ChrRaces(Base):
    __tablename__ = 'ChrRaces'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FactionID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MaleDisplayId = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FemaleDisplayId = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ClientPrefix = Column(Text)
    MountScale = Column(Float, nullable=False, server_default=text("'0'"))
    BaseLanguage = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CreatureType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    LoginEffectSpellID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CombatStunSpellID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ResSicknessSpellID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SplashSoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    StartingTaxiNodes = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ClientFileString = Column(Text)
    CinematicSequenceID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class CinematicCamera(Base):
    __tablename__ = 'CinematicCamera'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Model = Column(Text)
    SoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    OriginX = Column(Float, nullable=False, server_default=text("'0'"))
    OriginY = Column(Float, nullable=False, server_default=text("'0'"))
    OriginZ = Column(Float, nullable=False, server_default=text("'0'"))
    OriginFacing = Column(Float, nullable=False, server_default=text("'0'"))


class CinematicSequence(Base):
    __tablename__ = 'CinematicSequences'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    SoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Camera_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class CreatureDisplayInfo(Base):
    __tablename__ = 'CreatureDisplayInfo'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ModelID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ExtendedDisplayInfoID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CreatureModelScale = Column(Float, nullable=False, server_default=text("'0'"))
    CreatureModelAlpha = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TextureVariation_1 = Column(Text)
    TextureVariation_2 = Column(Text)
    TextureVariation_3 = Column(Text)
    BloodID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class CreatureDisplayInfoExtra(Base):
    __tablename__ = 'CreatureDisplayInfoExtra'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    DisplayRaceID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayGenderID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SkinID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FaceID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    HairStyleID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    HairColorID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FacialHairID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NPCItemDisplay_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    BakeName = Column(Text)


class CreatureFamily(Base):
    __tablename__ = 'CreatureFamily'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    MinScale = Column(Float, nullable=False, server_default=text("'0'"))
    MinScaleLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MaxScale = Column(Float, nullable=False, server_default=text("'0'"))
    MaxScaleLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SkillLine_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SkillLine_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class Emote(Base):
    __tablename__ = 'Emotes'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    EmoteAnimID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteSpecProc = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteSpecProcParam = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class EmotesText(Base):
    __tablename__ = 'EmotesText'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Name = Column(Text)
    EmoteID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_11 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_12 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_13 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_14 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_15 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EmoteText_16 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class EmotesTextDatum(Base):
    __tablename__ = 'EmotesTextData'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Text_enUS = Column(Text)
    Text_enGB = Column(Text)
    Text_koKR = Column(Text)
    Text_frFR = Column(Text)
    Text_deDE = Column(Text)
    Text_enCN = Column(Text)
    Text_zhCN = Column(Text)
    Text_enTW = Column(Text)
    Text_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class Faction(Base):
    __tablename__ = 'Faction'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ReputationIndex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationRaceMask_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationRaceMask_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationRaceMask_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationRaceMask_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationClassMask_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationClassMask_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationClassMask_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationClassMask_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationBase_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationBase_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationBase_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReputationBase_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class FactionGroup(Base):
    __tablename__ = 'FactionGroup'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    MaskID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InternalName = Column(Text)
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class FactionTemplate(Base):
    __tablename__ = 'FactionTemplate'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Faction = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FactionGroup = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FriendGroup = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EnemyGroup = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Enemies_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Enemies_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Enemies_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Enemies_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Friend_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Friend_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Friend_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Friend_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class GameObjectDisplayInfo(Base):
    __tablename__ = 'GameObjectDisplayInfo'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ModelName = Column(Text)
    Sound_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sound_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class ItemClas(Base):
    __tablename__ = 'ItemClass'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ClassID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SubclassMapID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ClassName_enUS = Column(Text)
    ClassName_enGB = Column(Text)
    ClassName_koKR = Column(Text)
    ClassName_frFR = Column(Text)
    ClassName_deDE = Column(Text)
    ClassName_enCN = Column(Text)
    ClassName_zhCN = Column(Text)
    ClassName_enTW = Column(Text)
    ClassName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class ItemDisplayInfo(Base):
    __tablename__ = 'ItemDisplayInfo'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ModelName_1 = Column(Text)
    ModelName_2 = Column(Text)
    ModelTexture_1 = Column(Text)
    ModelTexture_2 = Column(Text)
    InventoryIcon = Column(Text)
    GroundModel = Column(Text)
    GeosetGroup_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    GeosetGroup_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    GeosetGroup_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    GeosetGroup_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpellVisualID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    GroupSoundIndex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ItemSize = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    HelmetGeosetVisID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Texture_1 = Column(Text)
    Texture_2 = Column(Text)
    Texture_3 = Column(Text)
    Texture_4 = Column(Text)
    Texture_5 = Column(Text)
    Texture_6 = Column(Text)
    Texture_7 = Column(Text)
    Texture_8 = Column(Text)
    ItemVisual = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class ItemSubClass(Base):
    __tablename__ = 'ItemSubClass'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ClassID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SubClassID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    PrerequisiteProficiency = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    PostrequisiteProficiency = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    WeaponParrySeq = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    WeaponReadySeq = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    WeaponAttackSeq = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    WeaponSwingSize = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayName_enUS = Column(Text)
    DisplayName_enGB = Column(Text)
    DisplayName_koKR = Column(Text)
    DisplayName_frFR = Column(Text)
    DisplayName_deDE = Column(Text)
    DisplayName_enCN = Column(Text)
    DisplayName_zhCN = Column(Text)
    DisplayName_enTW = Column(Text)
    DisplayName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    VerboseName_enUS = Column(Text)
    VerboseName_enGB = Column(Text)
    VerboseName_koKR = Column(Text)
    VerboseName_frFR = Column(Text)
    VerboseName_deDE = Column(Text)
    VerboseName_enCN = Column(Text)
    VerboseName_zhCN = Column(Text)
    VerboseName_enTW = Column(Text)
    VerboseName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class LanguageWord(Base):
    __tablename__ = 'LanguageWords'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    LanguageID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Word = Column(Text)


class Language(Base):
    __tablename__ = 'Languages'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class Lock(Base):
    __tablename__ = 'Lock'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Type_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Type_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Type_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Type_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Index_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Index_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Index_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Index_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Skill_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Skill_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Skill_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Skill_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Action_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Action_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Action_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Action_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class LockType(Base):
    __tablename__ = 'LockType'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    ResourceName_enUS = Column(Text)
    ResourceName_enGB = Column(Text)
    ResourceName_koKR = Column(Text)
    ResourceName_frFR = Column(Text)
    ResourceName_deDE = Column(Text)
    ResourceName_enCN = Column(Text)
    ResourceName_zhCN = Column(Text)
    ResourceName_enTW = Column(Text)
    ResourceName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    Verb_enUS = Column(Text)
    Verb_enGB = Column(Text)
    Verb_koKR = Column(Text)
    Verb_frFR = Column(Text)
    Verb_deDE = Column(Text)
    Verb_enCN = Column(Text)
    Verb_zhCN = Column(Text)
    Verb_enTW = Column(Text)
    Verb_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class Map(Base):
    __tablename__ = 'Map'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Directory = Column(Text)
    PVP = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    IsInMap = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MapName_enUS = Column(Text)
    MapName_enGB = Column(Text)
    MapName_koKR = Column(Text)
    MapName_frFR = Column(Text)
    MapName_deDE = Column(Text)
    MapName_enCN = Column(Text)
    MapName_zhCN = Column(Text)
    MapName_enTW = Column(Text)
    MapName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class Material(Base):
    __tablename__ = 'Material'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    MaterialID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FoleySoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class Resistance(Base):
    __tablename__ = 'Resistances'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FizzleSoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SkillLine(Base):
    __tablename__ = 'SkillLine'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    RaceMask = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ClassMask = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ExcludeRace = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ExcludeClass = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CategoryID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SkillType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MinCharLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MaxRank = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Abandonable = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayName_enUS = Column(Text)
    DisplayName_enGB = Column(Text)
    DisplayName_koKR = Column(Text)
    DisplayName_frFR = Column(Text)
    DisplayName_deDE = Column(Text)
    DisplayName_enCN = Column(Text)
    DisplayName_zhCN = Column(Text)
    DisplayName_enTW = Column(Text)
    DisplayName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SkillLineAbility(Base):
    __tablename__ = 'SkillLineAbility'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    SkillLine = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Spell = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RaceMask = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ClassMask = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ExcludeRace = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ExcludeClass = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MinSkillLineRank = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SupercededBySpell = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TrivialSkillLineRankHigh = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TrivialSkillLineRankLow = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Abandonable = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class SoundEntry(Base):
    __tablename__ = 'SoundEntries'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    SoundType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name = Column(Text)
    File_1 = Column(Text)
    File_2 = Column(Text)
    File_3 = Column(Text)
    File_4 = Column(Text)
    File_5 = Column(Text)
    File_6 = Column(Text)
    File_7 = Column(Text)
    File_8 = Column(Text)
    File_9 = Column(Text)
    File_10 = Column(Text)
    Freq_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_9 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Freq_10 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DirectoryBase = Column(Text)
    VolumeFloat = Column(Float, nullable=False, server_default=text("'0'"))
    Pitch = Column(Float, nullable=False, server_default=text("'0'"))
    PitchVariation = Column(Float, nullable=False, server_default=text("'0'"))
    Priority = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Channel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MinDistance = Column(Float, nullable=False, server_default=text("'0'"))
    MaxDistance = Column(Float, nullable=False, server_default=text("'0'"))
    DistanceCutoff = Column(Float, nullable=False, server_default=text("'0'"))
    EAXDef = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class Spell(Base):
    __tablename__ = 'Spell'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    School = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Category = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CastUI = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Attributes = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AttributesEx = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ShapeshiftMask = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Targets = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TargetCreatureType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RequiresSpellFocus = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CasterAuraState = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TargetAuraState = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CastingTimeIndex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RecoveryTime = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CategoryRecoveryTime = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    InterruptFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AuraInterruptFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ChannelInterruptFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ProcFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ProcChance = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ProcCharges = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MaxLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    BaseLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpellLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DurationIndex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    PowerType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ManaCost = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ManaCostPerLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ManaPerSecond = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ManaPerSecondPerLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RangeIndex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Speed = Column(Float, nullable=False, server_default=text("'0'"))
    ModalNextSpell = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Totem_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Totem_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Reagent_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_4 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_5 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_6 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_7 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ReagentCount_8 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EquippedItemClass = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EquippedItemSubclass = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Effect_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Effect_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Effect_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectDieSides_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectDieSides_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectDieSides_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectBaseDice_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectBaseDice_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectBaseDice_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectDicePerLevel_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectDicePerLevel_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectDicePerLevel_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectRealPointsPerLevel_1 = Column(Float, nullable=False, server_default=text("'0'"))
    EffectRealPointsPerLevel_2 = Column(Float, nullable=False, server_default=text("'0'"))
    EffectRealPointsPerLevel_3 = Column(Float, nullable=False, server_default=text("'0'"))
    EffectBasePoints_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectBasePoints_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectBasePoints_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImplicitTargetA_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImplicitTargetA_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImplicitTargetA_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImplicitTargetB_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImplicitTargetB_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImplicitTargetB_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectRadiusIndex_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectRadiusIndex_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectRadiusIndex_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAura_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAura_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAura_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAuraPeriod_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAuraPeriod_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAuraPeriod_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectAmplitude_1 = Column(Float, nullable=False, server_default=text("'0'"))
    EffectAmplitude_2 = Column(Float, nullable=False, server_default=text("'0'"))
    EffectAmplitude_3 = Column(Float, nullable=False, server_default=text("'0'"))
    EffectChainTargets_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectChainTargets_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectChainTargets_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectItemType_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectItemType_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectItemType_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectMiscValue_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectMiscValue_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectMiscValue_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectTriggerSpell_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectTriggerSpell_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectTriggerSpell_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpellVisualID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpellIconID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ActiveIconID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpellPriority = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    NameSubtext_enUS = Column(Text)
    NameSubtext_enGB = Column(Text)
    NameSubtext_koKR = Column(Text)
    NameSubtext_frFR = Column(Text)
    NameSubtext_deDE = Column(Text)
    NameSubtext_enCN = Column(Text)
    NameSubtext_zhCN = Column(Text)
    NameSubtext_enTW = Column(Text)
    NameSubtext_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    Description_enUS = Column(Text)
    Description_enGB = Column(Text)
    Description_koKR = Column(Text)
    Description_frFR = Column(Text)
    Description_deDE = Column(Text)
    Description_enCN = Column(Text)
    Description_zhCN = Column(Text)
    Description_enTW = Column(Text)
    Description_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    ManaCostPct = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    StartRecoveryCategory = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    StartRecoveryTime = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    custom_DispelType = Column(INTEGER(4), nullable=False, server_default=text("'0'"))


class SpellAuraName(Base):
    __tablename__ = 'SpellAuraNames'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    EnumID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpecialMiscValue = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Globalstrings_Tag = Column(Text)
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SpellCastTimes(Base):
    __tablename__ = 'SpellCastTimes'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Base = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    PerLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Minimum = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class SpellChainEffect(Base):
    __tablename__ = 'SpellChainEffects'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    AvgSegLen = Column(Float, nullable=False, server_default=text("'0'"))
    Width = Column(Float, nullable=False, server_default=text("'0'"))
    NoiseScale = Column(Float, nullable=False, server_default=text("'0'"))
    TexCoordScale = Column(Float, nullable=False, server_default=text("'0'"))
    SegDuration = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegDelay = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Texture = Column(Text)


class SpellDispelType(Base):
    __tablename__ = 'SpellDispelType'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SpellDuration(Base):
    __tablename__ = 'SpellDuration'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Duration = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DurationPerLevel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MaxDuration = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class SpellEffectName(Base):
    __tablename__ = 'SpellEffectNames'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    EnumID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SpellFocusObject(Base):
    __tablename__ = 'SpellFocusObject'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SpellItemEnchantment(Base):
    __tablename__ = 'SpellItemEnchantment'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Effect_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Effect_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Effect_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectPointsMin_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectPointsMin_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectPointsMin_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectPointsMax_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectPointsMax_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectPointsMax_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectArg_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectArg_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    EffectArg_3 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    ItemVisual = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class SpellRadius(Base):
    __tablename__ = 'SpellRadius'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Radius = Column(Float, nullable=False, server_default=text("'0'"))
    RadiusPerLevel = Column(Float, nullable=False, server_default=text("'0'"))
    RadiusMax = Column(Float, nullable=False, server_default=text("'0'"))


class SpellRange(Base):
    __tablename__ = 'SpellRange'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    RangeMin = Column(Float, nullable=False, server_default=text("'0'"))
    RangeMax = Column(Float, nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DisplayName_enUS = Column(Text)
    DisplayName_enGB = Column(Text)
    DisplayName_koKR = Column(Text)
    DisplayName_frFR = Column(Text)
    DisplayName_deDE = Column(Text)
    DisplayName_enCN = Column(Text)
    DisplayName_zhCN = Column(Text)
    DisplayName_enTW = Column(Text)
    DisplayName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    DisplayNameShort_enUS = Column(Text)
    DisplayNameShort_enGB = Column(Text)
    DisplayNameShort_koKR = Column(Text)
    DisplayNameShort_frFR = Column(Text)
    DisplayNameShort_deDE = Column(Text)
    DisplayNameShort_enCN = Column(Text)
    DisplayNameShort_zhCN = Column(Text)
    DisplayNameShort_enTW = Column(Text)
    DisplayNameShort_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class SpellShapeshiftForm(Base):
    __tablename__ = 'SpellShapeshiftForm'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    BonusActionBar = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class SpellVisual(Base):
    __tablename__ = 'SpellVisual'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    PrecastKit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    CastKit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ImpactKit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    StateKit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ChannelKit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    HasMissile = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MissileModel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MissilePathType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MissileDestinationAttachment = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MissileSound = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    HasAreaEffect = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaModel = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaKit = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AnimEventSoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    WeaponTrailRed = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    WeaponTrailGreen = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    WeaponTrailBlue = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    WeaponTrailAlpha = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    WeaponTrailFadeoutRate = Column(TINYINT(3), nullable=False, server_default=text("'0'"))
    WeaponTrailDuration = Column(INTEGER(11), nullable=False, server_default=text("'0'"))

    precast_kit = relationship('SpellVisualKit', foreign_keys='SpellVisualKit.ID',
                               primaryjoin="SpellVisual.PrecastKit == SpellVisualKit.ID", uselist=False, lazy='joined')


class SpellVisualAnimName(Base):
    __tablename__ = 'SpellVisualAnimName'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    AnimID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Name = Column(Text)


class SpellVisualKit(Base):
    __tablename__ = 'SpellVisualKit'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    KitType = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Anim = Column(INTEGER(11), nullable=False, server_default=text("'0'"))

    visual_anim_name = relationship('SpellVisualAnimName', foreign_keys='SpellVisualAnimName.AnimID',
                                    primaryjoin="SpellVisualKit.Anim == SpellVisualAnimName.AnimID", uselist=False,
                                    lazy='joined')


class SpellVisualEffectName(Base):
    __tablename__ = 'SpellVisualEffectName'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    FileName = Column(Text)
    SpecialID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SpecialAttachPoint = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaEffectSize = Column(Float, nullable=False, server_default=text("'0'"))
    VisualEffectNameFlags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class TaxiNode(Base):
    __tablename__ = 'TaxiNodes'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    ContinentID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    X = Column(Float, nullable=False, server_default=text("'0'"))
    Y = Column(Float, nullable=False, server_default=text("'0'"))
    Z = Column(Float, nullable=False, server_default=text("'0'"))
    Name_enUS = Column(Text)
    Name_enGB = Column(Text)
    Name_koKR = Column(Text)
    Name_frFR = Column(Text)
    Name_deDE = Column(Text)
    Name_enCN = Column(Text)
    Name_zhCN = Column(Text)
    Name_enTW = Column(Text)
    Name_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))
    custom_Team = Column(INTEGER(3), nullable=False, server_default=text("'0'"))


class TaxiPath(Base):
    __tablename__ = 'TaxiPath'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    FromTaxiNode = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ToTaxiNode = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Cost = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class TaxiPathNode(Base):
    __tablename__ = 'TaxiPathNode'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    PathID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NodeIndex = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ContinentID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    LocX = Column(Float, nullable=False, server_default=text("'0'"))
    LocY = Column(Float, nullable=False, server_default=text("'0'"))
    LocZ = Column(Float, nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class TerrainType(Base):
    __tablename__ = 'TerrainType'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    TerrainID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TerrainDesc = Column(Text)
    FootstepSprayRun = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    FootstepSprayWalk = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))


class WMOAreaTable(Base):
    __tablename__ = 'WMOAreaTable'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    WMOID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NameSetID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    WMOGroupID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    DayAmbienceSoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    NightAmbienceSoundID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SoundProviderPref = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SoundProviderPrefUnderwater = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MIDIAmbience = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    MIDIAmbienceUnderwater = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ZoneMusic = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    IntroSound = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    IntroPriority = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Flags = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaName_enUS = Column(Text)
    AreaName_enGB = Column(Text)
    AreaName_koKR = Column(Text)
    AreaName_frFR = Column(Text)
    AreaName_deDE = Column(Text)
    AreaName_enCN = Column(Text)
    AreaName_zhCN = Column(Text)
    AreaName_enTW = Column(Text)
    AreaName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class WorldMapArea(Base):
    __tablename__ = 'WorldMapArea'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    MapID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    LeftBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RightBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TopBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    BottomBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    AreaName = Column(Text)


class WorldMapContinent(Base):
    __tablename__ = 'WorldMapContinent'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    MapID = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    LeftBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    RightBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    TopBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    BottomBoundary = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    ContinentOffsetX = Column(Float, nullable=False, server_default=text("'0'"))
    ContinentOffsetY = Column(Float, nullable=False, server_default=text("'0'"))


class WorldSafeLocs(Base):
    __tablename__ = 'WorldSafeLocs'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    Continent = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    LocX = Column(Float, nullable=False, server_default=text("'0'"))
    LocY = Column(Float, nullable=False, server_default=text("'0'"))
    LocZ = Column(Float, nullable=False, server_default=text("'0'"))
    AreaName_enUS = Column(Text)
    AreaName_enGB = Column(Text)
    AreaName_koKR = Column(Text)
    AreaName_frFR = Column(Text)
    AreaName_deDE = Column(Text)
    AreaName_enCN = Column(Text)
    AreaName_zhCN = Column(Text)
    AreaName_enTW = Column(Text)
    AreaName_Mask = Column(INTEGER(10), nullable=False, server_default=text("'0'"))


class ZoneMusic(Base):
    __tablename__ = 'ZoneMusic'

    ID = Column(INTEGER(11), primary_key=True, server_default=text("'0'"))
    VolumeFloat = Column(Float, nullable=False, server_default=text("'0'"))
    MusicFile_1 = Column(Text)
    MusicFile_2 = Column(Text)
    SilenceIntervalMin_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SilenceIntervalMin_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SilenceIntervalMax_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SilenceIntervalMax_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegmentLength_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegmentLength_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegmentPlayMin_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegmentPlayMin_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegmentPlayMax_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    SegmentPlayMax_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sounds_1 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
    Sounds_2 = Column(INTEGER(11), nullable=False, server_default=text("'0'"))
