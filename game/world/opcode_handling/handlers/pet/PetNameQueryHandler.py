from struct import pack
from network.packet.PacketReader import *
from network.packet.PacketWriter import PacketWriter


class PetNameQueryHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        if len(reader.data) >= 12:  # Avoid handling empty pet name query packet.
            pet_id, pet_guid = unpack('<IQ', reader.data[:12])

            pet_creature = world_session.player_mgr.get_map().get_surrounding_unit_by_guid(world_session.player_mgr,
                                                                                           pet_guid)
            owner = pet_creature.get_charmer_or_summoner()
            if not owner:
                return 0
            active_pet = owner.pet_manager.get_active_permanent_pet()
            if not active_pet:
                return 0

            pet_data = active_pet.get_pet_data()
            pet_name_bytes = PacketWriter.string_to_bytes(pet_data.name)
            name_timestamp = pet_data.rename_time
            data = pack(f'<I{len(pet_name_bytes)}sI', pet_id, pet_name_bytes, name_timestamp)
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_NAME_QUERY_RESPONSE, data))
        return 0
