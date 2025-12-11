from network.packet.PacketReader import *


class PetActionHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        if len(reader.data) >= 20:  # Avoid handling empty pet action packet.
            pet_guid, action, target_guid = unpack('<QIQ', reader.data[:20])
            world_session.player_mgr.pet_manager.handle_action(pet_guid, target_guid, action)

        return 0
