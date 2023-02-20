import time
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.MiscCodes import ChatMsgs
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.ScriptCodes import ModifyFlagsOptions, TurnToFacingOptions
from game.world.managers.objects.units.player.ChatManager import ChatManager
from utils.Logger import Logger

class QuestScriptHandler():
    def __init__(self, creature_mgr):
        self.quest_script_queue = []
        self.quest_giver = creature_mgr        

    def handle_quest_script(self, quest_script):

            if not self.quest_giver or not self.quest_giver.is_alive:
                return

            match quest_script['command']:
                case 0: # talk
                    Logger.debug('QuestScriptHandler: Talk')
                    broadcast_message = WorldDatabaseManager.broadcast_message_get_by_id(quest_script['datalong'])

                    if broadcast_message: 
                        text_to_say = None
                        if self.quest_giver.gender == 0 and broadcast_message.male_text is not None:
                            text_to_say = broadcast_message.male_text
                        elif self.quest_giver.gender == 1 and broadcast_message.female_text is not None:
                            text_to_say = broadcast_message.female_text
                        else:
                            text_to_say = broadcast_message.male_text if broadcast_message.male_text is not None else broadcast_message.female_text

                        if text_to_say is not None:     
                            ChatManager.send_monster_emote_message(self.quest_giver, self.quest_giver.guid, broadcast_message.language_id, text_to_say,
                            ChatMsgs.CHAT_MSG_MONSTER_SAY if broadcast_message.chat_type == 0 else ChatMsgs.CHAT_MSG_MONSTER_YELL)
                            if broadcast_message.emote_id1 != 0:                            
                                self.quest_giver.play_emote(broadcast_message.emote_id1)
                            # neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them

                case 1: # emote
                    Logger.debug('QuestScriptHandler: Emote ' + str(quest_script['datalong']))
                    self.quest_giver.play_emote(quest_script['datalong'])

                case 3: # move 
                    Logger.warning('QuestScriptHandler: Move not implemented yet')
                    pass
                case 4: # modify NPC flags
                    Logger.debug('QuestScriptHandler: Modify NPC flags')
                    if quest_script['datalong2'] == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
                        pass
                    elif quest_script['datalong2'] == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
                        pass
                    else: 
                        pass

                case 5: # stop cast
                    Logger.warning('QuestScriptHandler: Stop cast not implemented yet')
                    pass
                case 7: # complete quest
                    Logger.warning('QuestScriptHandler: Complete quest not implemented yet')
                    pass
                case 9: # spawn game object
                    Logger.warning('QuestScriptHandler: Spawn game object not implemented yet')
                    pass
                case 10: # summon creature
                    Logger.warning('QuestScriptHandler: Summon creature not implemented yet')
                    pass
                case 11: # unknown
                    Logger.warning('QuestScriptHandler: Unknown command 11')
                    pass
                case 15: # cast spell
                    Logger.debug('QuestScriptHandler: Cast spell ' + str(quest_script['datalong']))
                    if not quest_script['player_mgr']:
                        Logger.warning('QuestScriptHandler: No player manager found, aborting cast')
                        return
                    self.quest_giver.spell_manager.handle_cast_attempt(quest_script['datalong'], quest_script['player_mgr'], SpellTargetMask.UNIT, validate=False)                        

                case 20: # start waypoint movement
                    Logger.warning('QuestScriptHandler: Start waypoint movement not implemented yet')
                    pass
                case 22: # set faction
                    Logger.warning('QuestScriptHandler: Set faction not implemented yet')
                    pass
                case 25: # set walk
                    Logger.warning('QuestScriptHandler: Set walk not implemented yet')
                    pass
                case 26: # attack player                    
                    Logger.warning('QuestScriptHandler: Attack player not implemented yet')
                    pass
                case 27: # set quest entry?
                    Logger.warning('QuestScriptHandler: Set quest entry not implemented yet')
                    pass
                case 28: # set stand state
                    Logger.debug('QuestScriptHandler: Set stand state to ' + str(quest_script['datalong']))
                    self.quest_giver.set_stand_state(quest_script['datalong'])

                case 32: # terminate script
                    Logger.warning('QuestScriptHandler: Terminate script not implemented yet')
                    pass
                case 35: # set orientation
                    Logger.debug('QuestScriptHandler: Set orientation') 
                    if quest_script['datalong'] == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
                       self.quest_giver.movement_manager.send_face_target(quest_script['player_mgr'])
                    else:
                       self.quest_giver.movement_manager.send_face_angle(quest_script['o'])

                case 39: # start script
                    Logger.warning('QuestScriptHandler: Start script not implemented yet')
                    pass
                case 40: # remove from map
                    Logger.warning('QuestScriptHandler: Remove from map not implemented yet')
                    pass
                case 44: # set phase
                    Logger.warning('QuestScriptHandler: Set phase not implemented yet')
                    pass
                case 52: # make unkillable
                    Logger.debug('QuestScriptHandler: Make unkillable ' + str(quest_script['datalong2']))
                    if quest_script['datalong2'] == 1:
                        self.quest_giver.unit_flags += UnitFlags.UNIT_MASK_NON_ATTACKABLE
                    else:
                        self.quest_giver.unit_flags -= UnitFlags.UNIT_MASK_NON_ATTACKABLE
                case 55: # add/remove spell list
                    Logger.warning('QuestScriptHandler: Add/remove spell list not implemented yet')
                    pass
                case 60: # start waypoints
                    Logger.warning('QuestScriptHandler: Start waypoints not implemented yet')
                    pass
                case 61: # start scripted event
                    Logger.warning('QuestScriptHandler: Start scripted event not implemented yet')
                    pass
                case 69: # change map event condition
                    Logger.warning('QuestScriptHandler: Change map event condition not implemented yet')
                    pass
                case 71: # respawn
                    Logger.warning('QuestScriptHandler: Respawn not implemented yet')
                    pass
                case 74: # add aura
                    Logger.warning('QuestScriptHandler: Add aura not implemented yet')
                    pass
                case 76: # unused?
                    Logger.warning('QuestScriptHandler: Unused command 76')
                    pass
                case 81: # remove from map
                    Logger.warning('QuestScriptHandler: Remove from map not implemented yet')
                    pass
                case _:
                    pass
    
    def enqueue_quest_script(self, quest_id, player_mgr, end_script=False):
        scripts = None

        if not end_script:
            scripts = WorldDatabaseManager.quest_start_script_get_by_quest_id(quest_id)
        else:
            scripts = WorldDatabaseManager.quest_end_script_get_by_quest_id(quest_id)

        Logger.debug("Found " + str(len(scripts)) + " scripts for quest " + str(quest_id))

        if scripts:
            for script in scripts:
                self.quest_script_queue.append({ 'command': script.command, 'datalong': script.datalong, 'datalong2': script.datalong2,
                'o': script.o,
                 'delay': script.delay, 'player_mgr': player_mgr, 'time_added': time.time() })
                Logger.debug("QuestScriptHandler: added to quest script queue, new length: " + str(len(self.quest_script_queue)))

    def reset(self):        
        self.quest_script_queue.clear()

    def update(self):
        if len(self.quest_script_queue) > 0:
            for quest_script in self.quest_script_queue:
                if time.time() - quest_script["time_added"] >= quest_script["delay"]:
                    QuestScriptHandler.handle_quest_script(self, quest_script)
                    self.quest_script_queue.remove(quest_script)
                    Logger.debug("Removed from quest script queue, new length: " + str(len(self.quest_script_queue)))