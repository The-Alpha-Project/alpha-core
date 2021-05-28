from database.world.WorldModels import CreatureTemplate
from game.world.managers.objects.creature.CreatureManager import CreatureManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from struct import unpack

from network.packet.PacketReader import PacketReader

class TrainerListHandler(object):

    @staticmethod
    def handle(world_session, socket: int, reader: PacketReader) -> int:
        if len(reader.data) >= 8:  # Avoid handling empty trainer list packet.
            guid: int = unpack('<Q', reader.data[:8])[0]

            # Player talents
            if guid == world_session.player_mgr.guid:
                world_session.player_mgr.talent_manager.send_talent_list()                
            # NPC offering
            else:
                trainer: CreatureManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
                trainer_template: CreatureTemplate = WorldDatabaseManager.creature_get_by_entry(trainer.entry)

                if trainer and trainer.is_within_interactable_distance(world_session.player_mgr):
                    if trainer_template and trainer_template.trainer_class == world_session.player_mgr.player.class_:
                        trainer.send_trainer_list(world_session)
                    else:
                        return 0

        return 0
