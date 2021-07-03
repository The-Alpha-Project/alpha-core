from game.world.managers.objects.creature.CreatureManager import CreatureManager
from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import CreatureTemplate
from game.world.opcode_handling.handlers.quest.QuestGiverHelloHandler import QuestGiverHelloHandler


class ListInventoryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty list inventory packet.
            npc_guid = unpack('<Q', reader.data[:8])[0]

            if npc_guid > 0:
                vendor: CreatureManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, npc_guid)
                vendor_template: CreatureTemplate = WorldDatabaseManager.creature_get_by_entry(vendor.entry)

                if vendor and vendor.is_within_interactable_distance(world_session.player_mgr):
                    if vendor_template:
                        quests: int = world_session.player_mgr.quest_manager.get_active_quest_num_from_quest_giver(vendor)
                        if quests > 0:
                            world_session.player_mgr.quest_manager.handle_quest_giver_hello(vendor, npc_guid)
                            return 0

                    vendor.send_inventory_list(world_session)
        return 0
