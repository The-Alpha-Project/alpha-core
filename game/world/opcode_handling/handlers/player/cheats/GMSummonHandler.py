from game.world.managers.CommandManager import CommandManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.Logger import Logger


class GMSummonHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not player_mgr.session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to summon a player.')
            return 0

        # Avoid handling an empty gm summon packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=1):
            return 0
        player_name: str = PacketReader.read_string(reader.data, 0)
        CommandManager.summon(world_session, player_name)

        return 0
