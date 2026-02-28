from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import PacketWriter
from utils import TextUtils


class PetRenameHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Avoid handling an empty pet rename packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        pet_guid = unpack('<Q', reader.data[:8])[0]
        name = PacketReader.read_string(reader.data, 8)
        if not TextUtils.TextChecker.valid_text(name, is_name=True):
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_NAME_INVALID))
            return 0

        world_session.player_mgr.pet_manager.handle_pet_rename(pet_guid, name)
        return 0
