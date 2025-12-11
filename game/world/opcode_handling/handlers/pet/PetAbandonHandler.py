from network.packet.PacketReader import *


class PetAbandonHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        if len(reader.data) >= 8:  # Avoid handling empty pet abandon packet.
            pet_guid = unpack('<Q', reader.data[:8])[0]
            world_session.player_mgr.pet_manager.handle_pet_abandon(pet_guid)
        return 0
