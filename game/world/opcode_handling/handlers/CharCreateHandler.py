from struct import pack, unpack

from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *
from database.world.WorldDatabaseManager import *
from utils.constants.CharCodes import *


class CharCreateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # In reality, names with more than 1 upper letter were allowed in Alpha, but I don't like that
        name = PacketReader.read_string(reader.data, 0).capitalize()
        race, class_, gender, skin, face, hairstyle, haircolor, facialhair, unk = unpack(
            '<BBBBBBBBB', reader.data[len(name)+1:]
        )

        result = CharCreate.CHAR_CREATE_SUCCESS.value
        if RealmDatabaseManager.character_does_name_exist(name):
            result = CharCreate.CHAR_CREATE_NAME_IN_USE.value

        if result == CharCreate.CHAR_CREATE_SUCCESS.value:
            map_, zone, x, y, z, o = CharCreateHandler.get_starting_location(race, class_)
            character = Character(guid=RealmDatabaseManager.character_get_next_available_guid(),
                                  account_id=world_session.account_mgr.account.id,
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
                                  level=1)
            RealmDatabaseManager.character_create(character)

        data = pack('<B', result)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_CHAR_CREATE, data))

        return 0

    @staticmethod
    def get_starting_location(race, class_):
        info = WorldDatabaseManager.player_create_info_get(race, class_)
        return info.map, info.zone, info.position_x, info.position_y, info.position_z, info.orientation
