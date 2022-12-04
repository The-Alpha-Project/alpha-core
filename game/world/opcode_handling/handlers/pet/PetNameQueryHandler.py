from struct import pack

from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import PacketWriter


class PetNameQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 12:  # Avoid handling empty pet name query packet.
            pet_id, pet_guid = unpack('<IQ', reader.data[:12])

            pet_creature = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, pet_guid)
            owner = pet_creature.get_charmer_or_summoner()
            if not owner:
                return 0
            pet_info = owner.pet_manager.get_active_pet_info()
            if not pet_info or not pet_info.permanent:
                return 0

            pet_name_bytes = PacketWriter.string_to_bytes(pet_info.name)
            name_timestamp = pet_info.rename_time
            data = pack(f'<I{len(pet_name_bytes)}sI', pet_id, pet_name_bytes, name_timestamp)
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_NAME_QUERY_RESPONSE, data))
        return 0
