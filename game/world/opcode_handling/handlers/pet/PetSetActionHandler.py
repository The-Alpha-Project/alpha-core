from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class PetSetActionHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Avoid handling an empty pet action packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=16):
            return 0
        # Client will append a 2nd pair of slot/action data when swapping.
        count = 2 if HandlerValidator.validate_packet_length(reader, exact_length=24) else 1
        pet_guid = unpack('<Q', reader.data[:8])[0]
        for i in range(1, count + 1):
            slot, action = unpack('<2I', reader.data[8*i:16*i])
            world_session.player_mgr.pet_manager.handle_set_action(pet_guid, slot, action)

        return 0
