import time
from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.constants.ItemCodes import InventoryError, InventorySlots
from utils.constants.MiscCodes import Languages
from utils.constants.OpCodes import OpCode


class ReadItemHandler:
    READ_ITEM_STATE_TRANSLATED = 0
    READ_ITEM_STATE_TRANSLATION = 1
    READ_ITEM_STATE_CLOSE = 2  # Any state >= 2 closes the item text frame on client.
    READ_ITEM_TRANSLATION_DELAY_MS = 5000

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 2:  # Avoid handling empty read item packet.
            bag, slot = unpack('<2B', reader.data[:2])
            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value
            item = world_session.player_mgr.inventory.get_item(bag, slot)

            # Item does not exist in inventory or is not a readable page-text item.
            if not item or not item.item_template.page_text:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
                return 0

            # Clear any previous item’s delayed translation.
            world_session.player_mgr.inventory.clear_item_read_translation_timers()

            result = world_session.player_mgr.inventory.can_use_item(item.item_template)

            if result != InventoryError.BAG_OK:
                world_session.player_mgr.inventory.send_equip_error(result, item_1=item)
                # Client parser expects uint64 guid + uint8 state. For state 1, uint32 timer follows.
                ReadItemHandler._send_read_item_state(
                    world_session,
                    item.guid,
                    ReadItemHandler.READ_ITEM_STATE_CLOSE
                )
                return 0

            language_id = int(item.item_template.page_language)
            use_page_translation = config.World.Gameplay.enable_experimental_page_translation
            # Non-universal item text should still open when unknown (client displays scrambled text).
            # If the language is known, use translation timer flow first, then state 0.
            if language_id != Languages.LANG_UNIVERSAL:
                if use_page_translation and world_session.player_mgr.skill_manager.can_read_language(language_id):
                    ReadItemHandler._send_read_item_state(
                        world_session,
                        item.guid,
                        ReadItemHandler.READ_ITEM_STATE_TRANSLATION,
                        timer_ms=ReadItemHandler.READ_ITEM_TRANSLATION_DELAY_MS
                    )

                    world_session.player_mgr.inventory.update_item_read_translation_timers(
                        time.time(),
                        item,
                        delay_ms=ReadItemHandler.READ_ITEM_TRANSLATION_DELAY_MS
                    )
                else:
                    ReadItemHandler._send_read_item_state(
                        world_session,
                        item.guid,
                        ReadItemHandler.READ_ITEM_STATE_TRANSLATED
                    )
            else:
                data = pack('<Q', item.guid)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_OK, data))

        return 0

    @staticmethod
    def _send_read_item_state(world_session, item_guid, state, timer_ms=0):
        data = pack('<QB', item_guid, state)
        if state == ReadItemHandler.READ_ITEM_STATE_TRANSLATION:
            data += pack('<I', timer_ms)
        # Packet name uses "FAILED" which is misleading; state values also drive normal open/translation behavior.
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_READ_ITEM_FAILED, data))
