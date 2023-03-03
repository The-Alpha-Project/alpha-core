from game.world.managers.objects.units.ChatManager import ChatManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger


class GodModeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to set god mode.')
            return 0

        if len(reader.data) >= 1:  # Avoid handling empty god mode packet.
            # Client sends `0` if you type `godmode`, and `1` if you type `godmode 1` (or a number greater than 1).
            player_mgr.is_god = unpack('<B', reader.data[:1])[0] >= 1
            player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GODMODE, reader.data[:1]))
        ChatManager.send_system_message(world_session, f'Godmode '
                                                       f'{"enabled" if player_mgr.is_god else "disabled"}')

        return 0
