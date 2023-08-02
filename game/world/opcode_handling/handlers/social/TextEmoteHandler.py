from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.ConfigManager import config
from utils.constants.MiscCodes import Emotes, ObjectTypeIds
from utils.constants.UnitCodes import StandState


class TextEmoteHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if world_session.player_mgr.is_alive and len(reader.data) >= 12:
            emote_text_id, guid = unpack('<IQ', reader.data)
            emote = DbcDatabaseManager.emote_text_get_by_id(emote_text_id)

            if emote:
                data = pack('<QI', world_session.player_mgr.guid, emote_text_id)
                target = world_session.player_mgr.get_map().get_surrounding_unit_by_guid(world_session.player_mgr,
                                                                                         guid, include_players=True)

                if not target:
                    data += pack('<B', 0)
                elif target.get_type_id() == ObjectTypeIds.ID_PLAYER:
                    player_name_bytes = PacketWriter.string_to_bytes(target.get_name())
                    data += pack(f'<{len(player_name_bytes)}s',
                                 player_name_bytes)
                elif target.get_type_id() == ObjectTypeIds.ID_UNIT and target.creature_template:
                    unit_name_bytes = PacketWriter.string_to_bytes(target.get_name())
                    data += pack(f'<{len(unit_name_bytes)}s',
                                 unit_name_bytes)

                    # Notify CreatureAI about emote sent to this creature.
                    target.object_ai.receive_emote(world_session.player_mgr, emote_text_id)
                else:
                    data += pack('<B', 0)

                MapManager.send_surrounding_in_range(PacketWriter.get_packet(OpCode.SMSG_TEXT_EMOTE, data),
                                                     world_session.player_mgr, config.World.Chat.ChatRange.emote_range)

                # Perform visual emote action if needed

                emote_id = emote.EmoteID
                state = StandState.UNIT_STANDING

                if emote_text_id == Emotes.SIT:
                    if not world_session.player_mgr.is_sitting():
                        state = StandState.UNIT_SITTING
                        world_session.player_mgr.set_stand_state(state)
                elif emote_text_id == Emotes.STAND:
                    world_session.player_mgr.set_stand_state(state)
                elif emote_text_id == Emotes.SLEEP:
                    if world_session.player_mgr.stand_state != StandState.UNIT_SLEEPING:
                        state = StandState.UNIT_SLEEPING
                    world_session.player_mgr.set_stand_state(state)
                elif emote_text_id == Emotes.KNEEL:
                    if world_session.player_mgr.stand_state != StandState.UNIT_KNEEL:
                        state = StandState.UNIT_KNEEL
                    world_session.player_mgr.set_stand_state(state)
                else:
                    world_session.player_mgr.play_emote(emote_id)

        return 0
