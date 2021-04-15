import time
from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import *
from database.realm.RealmDatabaseManager import *


class CharEnumHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        characters = RealmDatabaseManager.account_get_characters(world_session.account_mgr.account.id)
        count = len(characters)

        data = pack('<B', count)
        for character in characters:
            data += CharEnumHandler.get_char_packet(world_session, character)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_CHAR_ENUM, data))

        return 0

    @staticmethod
    def get_char_packet(world_session, character):
        name_bytes = PacketWriter.string_to_bytes(character.name)
        char_fmt = f'<Q{len(name_bytes)}s9B2I3f4I'
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
            0  # TODO: Handle PetFamily,
        )

        for slot in range(InventorySlots.SLOT_HEAD, InventorySlots.SLOT_BAG2):
            item = RealmDatabaseManager.character_get_item_by_slot(character.guid, slot)
            display_id = 0
            inventory_type = 0

            if item:
                item_template = WorldDatabaseManager.item_template_get_by_entry(item.item_template)
                if item_template:
                    display_id = item_template.display_id
                    inventory_type = item_template.inventory_type
            char_packet += pack('<IB', display_id, inventory_type)

        return char_packet
