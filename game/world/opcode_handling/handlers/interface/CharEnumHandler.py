from database.realm.RealmDatabaseManager import *
from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class CharEnumHandler:

    @staticmethod
    def handle(world_session, reader):
        characters = RealmDatabaseManager.character_get_by_account(world_session.account_mgr.account.id)
        count = len(characters)

        data = pack('<B', count)
        for character in characters:
            data += CharEnumHandler.get_char_packet(world_session, character)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHAR_ENUM, data))

        return 0

    @staticmethod
    def get_char_packet(_world_session, character):
        guild = RealmDatabaseManager.character_get_guild(character)
        pet_info = CharEnumHandler._get_pet_info(character.guid)

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
            guild.guild_id if guild else 0,
            *pet_info
        )

        for slot in range(InventorySlots.SLOT_HEAD, InventorySlots.SLOT_BAG2):
            item = RealmDatabaseManager.character_get_item_by_slot(character.guid, slot)
            display_id = 0
            inventory_type = 0

            if item:
                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item.item_template)
                if item_template:
                    display_id = item_template.display_id
                    inventory_type = item_template.inventory_type
            char_packet += pack('<IB', display_id, inventory_type)

        return char_packet

    @staticmethod
    def _get_pet_info(character_guid):
        pets = RealmDatabaseManager.character_get_pets(character_guid)
        for pet in pets:
            if not pet.is_active:
                continue

            pet_creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(pet.creature_id)
            # TODO tamed variant display id? Affects two tamable creatures (8933, 9696).
            pet_display_id = pet_creature_template.display_id1
            pet_level = pet.level
            pet_family = pet_creature_template.beast_family
            return [pet_display_id, pet_level, pet_family]

        return [0, 0, 0]
