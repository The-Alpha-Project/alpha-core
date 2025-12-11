from network.packet.PacketReader import *


class PetSetActionHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        if len(reader.data) >= 16:  # Avoid handling empty pet action packet.
            count = 2 if len(reader.data) == 24 else 1  # Client will append a 2nd pair of slot/action data when swapping.
            pet_guid = unpack('<Q', reader.data[:8])[0]
            for i in range(1, count + 1):
                slot, action = unpack('<2I', reader.data[8*i:16*i])
                world_session.player_mgr.pet_manager.handle_set_action(pet_guid, slot, action)

        return 0
