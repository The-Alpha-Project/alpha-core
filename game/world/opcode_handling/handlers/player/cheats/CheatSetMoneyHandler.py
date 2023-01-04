from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from struct import unpack


class CheatSetMoneyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to give himself money.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty cheat set money packet.
            new_money = unpack('<I', reader.data[:4])[0]
            player_mgr.mod_money(new_money)

        return 0
