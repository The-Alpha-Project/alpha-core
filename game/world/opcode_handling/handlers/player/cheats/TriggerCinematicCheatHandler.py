from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.Logger import Logger


class TriggerCinematicCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 4:  # Avoid handling empty trigger cinematic cheat packet.
            if not world_session.player_mgr.is_gm:
                Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to force trigger a cinematic.')
                return 0

            cinematic_id = unpack('<I', reader.data[:4])[0]
            if DbcDatabaseManager.cinematic_sequences_get_by_id(cinematic_id):
                data = pack('<I', cinematic_id)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, data))

        return 0
