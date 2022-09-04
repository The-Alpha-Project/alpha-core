from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils import Formulas


class ListInventoryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty list inventory packet.
            npc_guid = unpack('<Q', reader.data[:8])[0]
            if npc_guid <= 0:
                return 0

            vendor: CreatureManager = MapManager.get_surrounding_unit_by_guid(player_mgr, npc_guid)
            if vendor and vendor.location.distance(player_mgr.location) < Formulas.Distances.MAX_SHOP_DISTANCE:
                # If vendor is a quest giver and player has an active quest involving this NPC, send quest window
                # instead of vendor window.
                if vendor.is_quest_giver():
                    quests: int = player_mgr.quest_manager.get_active_quest_num_from_quest_giver(vendor)
                    if quests > 0:
                        player_mgr.quest_manager.handle_quest_giver_hello(vendor, npc_guid)
                        return 0

                vendor.send_inventory_list(player_mgr)
        return 0
