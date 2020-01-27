from struct import pack, unpack

from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from database.realm.RealmDatabaseManager import *
from utils.constants.CharCodes import *


class CharCreateHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        # In reality, names with more than 1 upper letter were allowed in Alpha, but I don't like that
        name = PacketReader.read_string(packet, 0).capitalize()
        race, class_, gender, skin, face, hairstyle, haircolor, facialhair, unk = unpack(
            '<BBBBBBBBB', packet[len(name)+1:]
        )
        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_CHAR_CREATE) + 'B'
        header = PacketWriter.get_packet_header(OpCode.SMSG_CHAR_CREATE, fmt)

        result = CharCreate.CHAR_CREATE_SUCCESS.value
        if RealmDatabaseManager.character_does_name_exist(name):
            result = CharCreate.CHAR_CREATE_NAME_IN_USE.value

        if result == CharCreate.CHAR_CREATE_SUCCESS.value:
            character = Character(guid=RealmDatabaseManager.character_get_next_available_guid(),
                                  account=world_session.account.id,
                                  name=name,
                                  race=race,
                                  class_=class_,
                                  gender=gender,
                                  skin=skin,
                                  face=face,
                                  hairstyle=hairstyle,
                                  haircolour=haircolor,
                                  facialhair=facialhair,
                                  level=1)
            RealmDatabaseManager.character_create(character)

        packet = pack(
            fmt,
            header[0], header[1], header[2], header[3], header[4], header[5],
            result
        )
        socket.sendall(packet)

        return 0
