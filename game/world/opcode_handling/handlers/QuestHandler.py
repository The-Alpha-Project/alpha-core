from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants import ObjectCodes

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestHandler(object):

    ##  Questgiver

    @staticmethod
    def handle_questgiver_status(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty set selection packet
            questgiver_guid = unpack('<Q', reader.data[:8])[0]  # Send this shit... somehow... and your done!
            if world_session.player_mgr:
                #   Get the quest status, lets assume it is a unit
                questgiver_status = ObjectCodes.QuestGiverStatuses.QUEST_GIVER_NONE
                #   Send that with the guid to a method that will pack it up and piss it off to the client
                #   Where does this method belong? that is you step 1.
                questgiver_npc = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, questgiver_guid)
                print(vars(questgiver_npc))
                # Terminate method if questgiver could not be found
                if not questgiver_npc:
                    Logger.error("Error in OpCode CMSG_QUESTGIVER_STATUS_QUERY, could not find questgiver with guid of: %s"%(questgiver_guid))
                    return 0

                
                
                #   If unit is hostile to player, do not display status

                world_session.player_mgr.get_dialog_status(questgiver_npc, questgiver_status)
        
        return 0

    @staticmethod
    def handle_questgiver_hello(world_session, socket, reader):
        # Cancel feign death, if it even exists at this point
        # Stop the npc if they are moving
        if len(reader.data) >= 8:
            guid = unpack('<Q', reader.data[:8])[0]
            questgiver_npc = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)

            Logger.debug( "guid: %s"%(guid) )
            Logger.debug( "questgiver_npc.entry: %s"%(questgiver_npc.entry) )

            if world_session.player_mgr:
                Logger.debug("player_mgr was detected")
                # Logger.debug( "player_mgr: %s"%( vars(world_session.player_mgr) ) )

        return 0

    @staticmethod
    def handle_questgiver_accept(world_session, socket, reader):
        pass

    @staticmethod
    def handle_questgiver_query(world_session, socket, reader):
        pass

    @staticmethod
    def handle_questgiver_choose_reward(world_session, socket, reader):
        pass

    @staticmethod
    def handle_questgiver_request_reward(world_session, socket, reader):
        pass

    @staticmethod
    def handle_questgiver_complete(world_session, socket, reader):
        pass

    # @staticmethod
    # def handle_questgiver_auto_launch(world_session, socket, reader):
    #     pass


    @staticmethod
    def handle_questgiver_cancel(world_session, socket, reader):
        pass


    ##  Quest

    @staticmethod
    def handle_quest_query(world_session, socket, reader):
        pass

    @staticmethod
    def handle_quest_push_to_party(world_session, socket, reader):
        pass

    @staticmethod
    def handle_quest_push_result(world_session, socket, reader):
        pass


    @staticmethod
    def handle_quest_confirm_accept(world_session, socket, reader):
        pass


        ##  Quest Log
    @staticmethod
    def handle_questlog_swap(world_session, socket, reader):
        pass

    @staticmethod
    def handle_questlog_remove(world_session, socket, reader):
        pass


    @staticmethod
    def get_dialog_status(player, questgiver, defstatus):
        pass

    @staticmethod
    def can_interact_with_questgiver(guid, descr):
        pass