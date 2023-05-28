from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.OpCodes import OpCode


class TriggerCinematicCheatHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to force trigger a cinematic.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty trigger cinematic cheat packet.
            cinematic_id = unpack('<I', reader.data[:4])[0]
            if DbcDatabaseManager.cinematic_sequences_get_by_id(cinematic_id):
                data = pack('<I', cinematic_id)
                player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, data))

        return 0
