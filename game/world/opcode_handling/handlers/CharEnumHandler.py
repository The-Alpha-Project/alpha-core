from struct import pack, unpack

from network.packet.PacketWriter import *
from database.realm.RealmDatabaseManager import *


class CharEnumHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        characters = RealmDatabaseManager.account_get_characters(world_session.account.id)
        count = len(characters)

        fmt = PacketWriter.get_packet_header_format(OpCode.SMSG_CHAR_ENUM) + 'B'
        header = PacketWriter.get_packet_header(OpCode.SMSG_CHAR_ENUM, fmt)

        packet = pack(
            fmt,
            header[0], header[1], header[2], header[3], header[4], header[5],
            count
        )
        char_packets = []
        for character in characters:
            #char_packets.append(CharEnumHandler.get_char_packet(character))
            packet += CharEnumHandler.get_char_packet(character)
        print(packet + b''.join(char_packets))
        socket.sendall(packet)

        return 0

    @staticmethod
    def get_char_packet(character):
        name_bytes = PacketWriter.string_to_bytes(character.name)
        char_fmt = '!Q%usBBBBBBBBBIIfffIIIIIBIBIBIBIBIBIBIBIBIBIBIBIBIBIBIBIBIBIBIB' % len(name_bytes)
        char_packet = pack(
            char_fmt,
            character.guid,
            name_bytes,
            character.race,
            character.class_,
            character.gender,
            character.skin,
            character.face,
            character.hairstyle,
            character.haircolour,
            character.facialhair,
            character.level,
            character.zone,
            character.map,
            character.position_x,
            character.position_y,
            character.position_z,
            0,  # TODO: Handle Guild GUID,
            0,  # TODO: Handle PetDisplayInfo
            0,  # TODO: Handle PetLevel
            0,  # TODO: Handle PetFamily
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  # TODO: Handle ItemInventory
        )
        return char_packet
