from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.constants.MiscCodes import Emotes, EmoteUnitState
from utils.constants.UnitCodes import StandState


class TextEmoteHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if not player_mgr.is_alive or len(reader.data) < 12:
            return 0

        emote_id, guid = unpack('<IQ', reader.data)
        emote = DbcDatabaseManager.emote_text_get_by_id(emote_id)

        if not emote:
            return 0

        target = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid, include_players=True)

        # Say emote text.
        world_session.player_mgr.say_emote_text(emote_id, target)

        # Perform visual emote action if needed
        emote_id = emote.EmoteID

        if emote_id == EmoteUnitState.SIT:
            if not player_mgr.is_sitting():
                player_mgr.set_stand_state(StandState.UNIT_SITTING)
        elif emote_id == EmoteUnitState.STAND:
            if not player_mgr.is_standing():
                player_mgr.set_stand_state(StandState.UNIT_STANDING)
        elif emote_id == EmoteUnitState.SLEEP:
            if player_mgr.stand_state != StandState.UNIT_SLEEPING:
                player_mgr.set_stand_state(StandState.UNIT_SLEEPING)
        elif emote_id == EmoteUnitState.KNEEL:
            if player_mgr.stand_state != StandState.UNIT_KNEEL:
                player_mgr.set_stand_state(StandState.UNIT_KNEEL)
        else:
            player_mgr.play_emote(emote_id)

        return 0
