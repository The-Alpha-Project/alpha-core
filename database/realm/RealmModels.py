# coding: utf-8
from sqlalchemy import Column, DateTime, Float, ForeignKey, Integer, SmallInteger, String, Text, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()
metadata = Base.metadata


class Account(Base):
    __tablename__ = 'accounts'

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(250), nullable=False)
    password = Column(String(256), nullable=False)
    ip = Column(String(256), nullable=False)
    gmlevel = Column(Integer, nullable=False, server_default=text("'1'"))


class AppliedUpdate(Base):
    __tablename__ = 'applied_updates'

    id = Column(String(9), primary_key=True, server_default=text("'000000000'"))


class CharacterInventory(Base):
    __tablename__ = 'character_inventory'

    guid = Column(Integer, primary_key=True, autoincrement=True)
    owner = Column(ForeignKey(u'characters.guid', ondelete=u'CASCADE', onupdate=u'CASCADE'), nullable=False, index=True, server_default=text("'0'"))
    creator = Column(Integer, nullable=False, index=True, server_default=text("'0'"))
    bag = Column(Integer, nullable=False, server_default=text("'0'"))
    slot = Column(Integer, nullable=False, server_default=text("'0'"))
    item_template = Column(Integer, nullable=False, server_default=text("'0'"))
    stackcount = Column(Integer, nullable=False, server_default=text("'1'"))
    SpellCharges1 = Column(Integer, nullable=False, server_default=text("'-1'"))
    SpellCharges2 = Column(Integer, nullable=False, server_default=text("'-1'"))
    SpellCharges3 = Column(Integer, nullable=False, server_default=text("'-1'"))
    SpellCharges4 = Column(Integer, nullable=False, server_default=text("'-1'"))
    SpellCharges5 = Column(Integer, nullable=False, server_default=text("'-1'"))

    character = relationship(u'Character')


class CharacterSocial(Base):
    __tablename__ = 'character_social'

    guid = Column(ForeignKey(u'characters.guid', ondelete=u'CASCADE', onupdate=u'CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    friend = Column(ForeignKey(u'characters.guid', ondelete=u'CASCADE', onupdate=u'CASCADE'), primary_key=True, nullable=False, index=True, server_default=text("'0'"))
    ignore = Column(Integer, nullable=False, server_default=text("'0'"))

    character_friend = relationship(u'Character', primaryjoin='CharacterSocial.friend == Character.guid')
    character_ignore = relationship(u'Character', primaryjoin='CharacterSocial.guid == Character.guid')


class Character(Base):
    __tablename__ = 'characters'

    guid = Column(Integer, primary_key=True, autoincrement=True, server_default=text("'0'"))
    account_id = Column('account', ForeignKey(u'accounts.id', ondelete=u'CASCADE', onupdate=u'CASCADE'), nullable=False, index=True, server_default=text("'0'"))
    name = Column(String(12), nullable=False, index=True, server_default=text("''"))
    race = Column(Integer, nullable=False, server_default=text("'0'"))
    class_ = Column('class', Integer, nullable=False, server_default=text("'0'"))
    gender = Column(Integer, nullable=False, server_default=text("'0'"))
    level = Column(Integer, nullable=False, server_default=text("'0'"))
    xp = Column(Integer, nullable=False, server_default=text("'0'"))
    money = Column(Integer, nullable=False, server_default=text("'0'"))
    skin = Column(Integer, nullable=False, server_default=text("'0'"))
    face = Column(Integer, nullable=False, server_default=text("'0'"))
    hairstyle = Column(Integer, nullable=False, server_default=text("'0'"))
    haircolour = Column(Integer, nullable=False, server_default=text("'0'"))
    facialhair = Column(Integer, nullable=False, server_default=text("'0'"))
    bankslots = Column(Integer, nullable=False, server_default=text("'0'"))
    talentpoints = Column(Integer, nullable=False, server_default=text("'0'"))
    skillpoints = Column(Integer, nullable=False, server_default=text("'0'"))
    position_x = Column(Float, nullable=False, server_default=text("'0'"))
    position_y = Column(Float, nullable=False, server_default=text("'0'"))
    position_z = Column(Float, nullable=False, server_default=text("'0'"))
    map = Column(Integer, nullable=False, server_default=text("'0'"))
    orientation = Column(Float, nullable=False, server_default=text("'0'"))
    taximask = Column(String)
    online = Column(Integer, nullable=False, index=True, server_default=text("'0'"))
    totaltime = Column(Integer, nullable=False, server_default=text("'0'"))
    leveltime = Column(Integer, nullable=False, server_default=text("'0'"))
    extra_flags = Column(Integer, nullable=False, server_default=text("'0'"))
    zone = Column(Integer, nullable=False, server_default=text("'0'"))
    taxi_path = Column(Text)
    drunk = Column(SmallInteger, nullable=False, server_default=text("'0'"))
    health = Column(Integer, nullable=False, server_default=text("'0'"))
    power1 = Column(Integer, nullable=False, server_default=text("'0'"))
    power2 = Column(Integer, nullable=False, server_default=text("'0'"))
    power3 = Column(Integer, nullable=False, server_default=text("'0'"))
    power4 = Column(Integer, nullable=False, server_default=text("'0'"))
    power5 = Column(Integer, nullable=False, server_default=text("'0'"))

    account = relationship(u'Account')


class Ticket(Base):
    __tablename__ = 'tickets'

    id = Column(Integer, primary_key=True, autoincrement=True)
    is_bug = Column(Integer, nullable=False, server_default=text("'0'"))
    account_name = Column(String(250), nullable=False, server_default=text("''"))
    account_id = Column(ForeignKey(u'accounts.id', ondelete=u'CASCADE', onupdate=u'CASCADE'), nullable=False, index=True, server_default=text("'0'"))
    character_name = Column(String(12), nullable=False, server_default=text("''"))
    text_body = Column(Text, nullable=False)
    submit_time = Column(DateTime, nullable=False, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"))

    account = relationship(u'Account')
