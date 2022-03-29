from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from struct import unpack


class CheatSetMoneyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 4:  # Avoid handling empty cheat set money packet.
            new_money = unpack('<I', reader.data[:4])[0]
            if not world_session.player_mgr.is_gm:
                Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to give himself {new_money} copper.')
                return 0

            world_session.player_mgr.mod_money(new_money)

        return 0
