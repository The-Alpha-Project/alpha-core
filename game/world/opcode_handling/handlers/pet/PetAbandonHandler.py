from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class PetAbandonHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Avoid handling an empty pet abandon packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        pet_guid = unpack('<Q', reader.data[:8])[0]
        world_session.player_mgr.pet_manager.handle_pet_abandon(pet_guid)
        return 0
