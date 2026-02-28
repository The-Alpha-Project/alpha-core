from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from struct import unpack

from game.world.managers.objects.units.creature.utils.VendorUtils import VendorUtils
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Formulas import Distances


class ListInventoryHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if not player_mgr.is_alive:
            return 0

        # Avoid handling an empty list inventory packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        npc_guid = unpack('<Q', reader.data[:8])[0]
        if npc_guid <= 0:
            return 0

        vendor: CreatureManager = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, npc_guid)
        if not vendor:
            return 0
        if not Distances.is_within_shop_distance(player_mgr, vendor):
            return 0

        vendor.object_ai.player_interacted()
        # If vendor is a quest giver and player has an active quest involving this NPC, send quest window
        # instead of vendor window.
        if vendor.is_quest_giver():
            quests: int = player_mgr.quest_manager.get_active_quest_num_from_quest_giver(vendor)
            if quests > 0:
                player_mgr.quest_manager.handle_quest_giver_hello(vendor, npc_guid)
                return 0

        VendorUtils.send_inventory_list(vendor, player_mgr)
        return 0
