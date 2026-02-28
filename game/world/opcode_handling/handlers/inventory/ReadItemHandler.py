from game.world.opcode_handling.HandlerValidator import HandlerValidator
import time
from struct import unpack

from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.constants.ItemCodes import InventoryError, InventorySlots, ReadItemState
from utils.constants.MiscCodes import Languages
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import Races


class ReadItemHandler:
    READ_ITEM_TRANSLATION_DELAY_MS = 5000
    NATIVE_LANGUAGES = {
        Races.RACE_HUMAN: Languages.LANG_COMMON,
        Races.RACE_ORC: Languages.LANG_ORCISH,
        Races.RACE_DWARF: Languages.LANG_DWARVISH,
        Races.RACE_NIGHT_ELF: Languages.LANG_DARNASSIAN,
        Races.RACE_UNDEAD: Languages.LANG_COMMON,
        Races.RACE_TAUREN: Languages.LANG_TAURAHE,
        Races.RACE_GNOME: Languages.LANG_GNOMISH,
        Races.RACE_TROLL: Languages.LANG_TROLL
    }

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty read item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        bag, slot = unpack('<2B', reader.data[:2])
        if bag == 0xFF:
            bag = InventorySlots.SLOT_INBACKPACK.value
        inventory = player_mgr.inventory
        item = inventory.get_item(bag, slot)

        # Item does not exist in inventory or is not a readable page-text item.
        if not item or not item.item_template.page_text:
            inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return 0

        # Clear any previous item's delayed translation.
        inventory.clear_item_read_translation_timers()

        result = inventory.can_use_item(item.item_template)

        if result != InventoryError.BAG_OK:
            inventory.send_equip_error(result, item_1=item)
            # Client parser expects uint64 guid + uint8 state. For state 1, uint32 timer follows.
            ReadItemHandler._send_read_item_state(
                world_session,
                item.guid,
                ReadItemState.CLOSE
            )
            return 0

        language_id = int(item.item_template.page_language)
        use_page_translation = config.World.Gameplay.enable_experimental_page_translation
        # For text written in the universal language or in a language native to the character's race,
        # no translation is performed.
        if language_id == Languages.LANG_UNIVERSAL or language_id == ReadItemHandler.NATIVE_LANGUAGES.get(
                player_mgr.race):
            data = pack('<Q', item.guid)
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_OK, data))
        else:
            # If the experimental page translation mechanism is enabled and the player can speak the language,
            # start the translation process. Otherwise, mark the text as translated either way (it will display
            # scrambled text if the player does not know the language, or fully translated text if the player
            # has it maxed out).
            # NOTE: The interesting part about this experimental feature is that originally players could learn
            # other languages and start levelling them, instead of knowing a fixed amount and always starting at
            # max skill level. The amount of correctly translated text depends on the skill level.
            # More info can be found here: https://github.com/vmangos/core/issues/3216
            if use_page_translation and player_mgr.skill_manager.can_read_language(language_id):
                ReadItemHandler._send_read_item_state(
                    world_session,
                    item.guid,
                    ReadItemState.TRANSLATION,
                    timer_ms=ReadItemHandler.READ_ITEM_TRANSLATION_DELAY_MS
                )

                inventory.update_item_read_translation_timers(
                    time.time(),
                    item,
                    delay_ms=ReadItemHandler.READ_ITEM_TRANSLATION_DELAY_MS
                )
            else:
                ReadItemHandler._send_read_item_state(
                    world_session,
                    item.guid,
                    ReadItemState.TRANSLATED
                )

        return 0

    @staticmethod
    def _send_read_item_state(world_session, item_guid, state, timer_ms=0):
        data = pack('<QB', item_guid, state)
        if state == ReadItemState.TRANSLATION:
            data += pack('<I', timer_ms)
        # Packet name uses "FAILED" which is misleading; state values also drive normal open/translation behavior.
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_FAILED, data))
