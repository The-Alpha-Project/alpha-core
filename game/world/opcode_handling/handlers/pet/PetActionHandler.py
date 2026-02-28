from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *


class PetActionHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Avoid handling an empty pet action packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=20):
            return 0
        pet_guid, action, target_guid = unpack('<QIQ', reader.data[:20])
        world_session.player_mgr.pet_manager.handle_action(pet_guid, target_guid, action)

        return 0
