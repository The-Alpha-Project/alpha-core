from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from struct import unpack


class PetLevelCheatHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to modify their pet level.')
            return 0

        # Avoid handling an empty packet level cheat packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        new_level = unpack('<I', reader.data[:4])[0]
        # Client-side boundaries.
        if new_level < 1 or new_level > 100:
            return 0

        active_pet = world_session.player_mgr.pet_manager.get_active_controlled_pet()
        if not active_pet:
            return 0

        active_pet.set_level(new_level, replenish=True)

        return 0
