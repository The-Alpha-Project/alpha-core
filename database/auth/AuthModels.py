# coding: utf-8
from sqlalchemy import Column, String, text
from sqlalchemy.dialects.mysql import INTEGER, TINYINT
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
    salt = Column(String(256), nullable=False)
    verifier = Column(String(256), nullable=False)
    sessionkey = Column(String(256), nullable=False)


class RealmList(Base):
    __tablename__ = 'realmlist'

    realm_id = Column(INTEGER(11), autoincrement=True, nullable=False, primary_key=True)
    realm_name = Column(String(255), nullable=False, server_default=text(""))
    proxy_address = Column(String(15), nullable=False, server_default="0.0.0.0")
    proxy_port = Column(INTEGER(11), nullable=False, server_default="9090")
    realm_address = Column(String(15), nullable=False, server_default="0.0.0.0")
    realm_port = Column(INTEGER(11), nullable=False, server_default="9100")
    online_player_count = Column(INTEGER(11), nullable=False, server_default="0")


class AppliedUpdate(Base):
    __tablename__ = 'applied_updates'

    id = Column(String(9), primary_key=True, server_default=text("'000000000'"))