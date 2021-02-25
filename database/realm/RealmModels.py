# coding: utf-8
from sqlalchemy import Column, Float, ForeignKey, String, TIMESTAMP, Text, text
from sqlalchemy.dialects.mysql import BIGINT, INTEGER, LONGTEXT, MEDIUMINT, SMALLINT, TINYINT
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class Account(Base):
    __tablename__ = 'accounts'

    id = Column(INTEGER(10), primary_key=True, index=True)
    name = Column(String(250), nullable=False)
    password = Column(String(256), nullable=False)
    ip = Column(String(256), nullable=False)
    gmlevel = Column(TINYINT(4), nullable=False, server_default=text("1"))


class AppliedUpdate(Base):
    __tablename__ = 'applied_updates'

    id = Column(String(9), primary_key=True, server_default=text("'000000000'"))


class Character(Base):
    __tablename__ = 'characters'

    guid = Column(INTEGER(11), primary_key=True, autoincrement=True)
    account_id = Column('account', ForeignKey('accounts.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True, server_default=text("0"), comment='Account Identifier')
    name = Column(String(12), nullable=False, index=True, server_default=text("''"))
    race = Column(TINYINT(3), nullable=False, server_default=text("0"))
    class_ = Column('class', TINYINT(3), nullable=False, server_default=text("0"))
    gender = Column(TINYINT(3), nullable=False, server_default=text("0"))
    level = Column(TINYINT(3), nullable=False, server_default=text("0"))
    xp = Column(INTEGER(10), nullable=False, server_default=text("0"))
    money = Column(INTEGER(10), nullable=False, server_default=text("0"))
    skin = Column(TINYINT(3), nullable=False, server_default=text("0"))
    face = Column(TINYINT(3), nullable=False, server_default=text("0"))
    hairstyle = Column(TINYINT(3), nullable=False, server_default=text("0"))
    haircolour = Column(TINYINT(3), nullable=False, server_default=text("0"))
    facialhair = Column(TINYINT(3), nullable=False, server_default=text("0"))
    bankslots = Column(TINYINT(3), nullable=False, server_default=text("0"))
    talentpoints = Column(TINYINT(3), nullable=False, server_default=text("0"))
    skillpoints = Column(TINYINT(3), nullable=False, server_default=text("0"))
    position_x = Column(Float, nullable=False, server_default=text("0"))
    position_y = Column(Float, nullable=False, server_default=text("0"))
    position_z = Column(Float, nullable=False, server_default=text("0"))
    map = Column(INTEGER(11), nullable=False, server_default=text("0"), comment='Map Identifier')
    orientation = Column(Float, nullable=False, server_default=text("0"))
    taximask = Column(LONGTEXT)
    online = Column(TINYINT(3), nullable=False, index=True, server_default=text("0"))
    totaltime = Column(INTEGER(11), nullable=False, server_default=text("0"))
    leveltime = Column(INTEGER(11), nullable=False, server_default=text("0"))
    extra_flags = Column(INTEGER(11), nullable=False, server_default=text("0"))
    zone = Column(INTEGER(11), nullable=False, server_default=text("0"))
    taxi_path = Column(Text)
    drunk = Column(SMALLINT(5), nullable=False, server_default=text("0"))
    health = Column(INTEGER(10), nullable=False, server_default=text("0"))
    power1 = Column(INTEGER(10), nullable=False, server_default=text("0"))
    power2 = Column(INTEGER(10), nullable=False, server_default=text("0"))
    power3 = Column(INTEGER(10), nullable=False, server_default=text("0"))
    power4 = Column(INTEGER(10), nullable=False, server_default=text("0"))
    power5 = Column(INTEGER(10), nullable=False, server_default=text("0"))

    account = relationship('Account')


class Ticket(Base):
    __tablename__ = 'tickets'

    id = Column(INTEGER(11), primary_key=True, autoincrement=True)
    is_bug = Column(INTEGER(1), nullable=False, server_default=text("0"))
    account_name = Column(String(250), nullable=False, server_default=text("''"))
    account_id = Column(ForeignKey('accounts.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True, server_default=text("0"))
    character_name = Column(String(12), nullable=False, server_default=text("''"))
    text_body = Column(Text, nullable=False)
    submit_time = Column(TIMESTAMP, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    account = relationship('Account')


class CharacterDeathbind(Base):
    __tablename__ = 'character_deathbind'

    deathbind_id = Column(INTEGER(11), primary_key=True, autoincrement=True)
    player_guid = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True)
    creature_binder_guid = Column(INTEGER(11), nullable=False, server_default=text("0"))
    deathbind_map = Column(INTEGER(11), nullable=False, server_default=text("0"))
    deathbind_zone = Column(INTEGER(11), nullable=False, server_default=text("0"))
    deathbind_position_x = Column(Float, nullable=False, server_default=text("0"))
    deathbind_position_y = Column(Float, nullable=False, server_default=text("0"))
    deathbind_position_z = Column(Float, nullable=False, server_default=text("0"))

    character = relationship('Character')


class CharacterInventory(Base):
    __tablename__ = 'character_inventory'

    guid = Column(INTEGER(11), primary_key=True, autoincrement=True)
    owner = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True, server_default=text("0"), comment='Global Unique Identifier')
    creator = Column(INTEGER(11), nullable=False, server_default=text("0"))
    bag = Column(INTEGER(11), nullable=False, server_default=text("0"))
    slot = Column(TINYINT(3), nullable=False, server_default=text("0"))
    item_template = Column(MEDIUMINT(8), nullable=False, server_default=text("0"), comment='Item Identifier')
    stackcount = Column(INTEGER(11), nullable=False, server_default=text("1"))
    SpellCharges1 = Column(INTEGER(11), nullable=False, server_default=text("-1"))
    SpellCharges2 = Column(INTEGER(11), nullable=False, server_default=text("-1"))
    SpellCharges3 = Column(INTEGER(11), nullable=False, server_default=text("-1"))
    SpellCharges4 = Column(INTEGER(11), nullable=False, server_default=text("-1"))
    SpellCharges5 = Column(INTEGER(11), nullable=False, server_default=text("-1"))
    item_flags = Column(INTEGER(10), nullable=False, server_default=text("0"))

    character = relationship('Character')


class CharacterSkill(Base):
    __tablename__ = 'character_skills'

    guid = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("0"))
    skill = Column(MEDIUMINT(9), primary_key=True, nullable=False, server_default=text("0"))
    value = Column(MEDIUMINT(9), nullable=False, server_default=text("0"))
    max = Column(MEDIUMINT(9), nullable=False, server_default=text("0"))

    character = relationship('Character')


class CharacterSocial(Base):
    __tablename__ = 'character_social'

    guid = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("0"), comment='Character Global Unique Identifier')
    friend = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("0"), comment='Friend Global Unique Identifier')
    ignore = Column(TINYINT(1), nullable=False, server_default=text("0"), comment='Friend Flags')

    character_friend = relationship('Character', primaryjoin='CharacterSocial.friend == Character.guid')
    character_ignore = relationship('Character', primaryjoin='CharacterSocial.guid == Character.guid')


class CharacterSpellCooldown(Base):
    __tablename__ = 'character_spell_cooldown'

    guid = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("0"))
    spell = Column(INTEGER(11), primary_key=True, nullable=False, server_default=text("0"))
    item = Column(INTEGER(11), nullable=False, server_default=text("0"))
    time = Column(BIGINT(20), nullable=False, server_default=text("0"))
    category_time = Column(BIGINT(20), nullable=False, server_default=text("0"))

    character = relationship('Character')


class CharacterSpell(Base):
    __tablename__ = 'character_spells'

    guid = Column(ForeignKey('characters.guid', ondelete='CASCADE', onupdate='CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("0"))
    spell = Column(INTEGER(11), primary_key=True, nullable=False, index=True, server_default=text("0"))
    active = Column(TINYINT(3), nullable=False, server_default=text("1"))
    disabled = Column(TINYINT(3), nullable=False, server_default=text("0"))

    character = relationship('Character')
