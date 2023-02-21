import time
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.MiscCodes import ChatMsgs
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.ScriptCodes import ModifyFlagsOptions, TurnToFacingOptions, ScriptCommands
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
                case ScriptCommands.SCRIPT_COMMAND_TALK: # talk
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_TALK')
                    broadcast_message = WorldDatabaseManager.broadcast_message_get_by_id(quest_script['dataint'])

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
                        else:
                            Logger.warning(f'QuestScriptHandler: Broadcast message {quest_script["dataint"]} has no text to say.')
                    else:
                        Logger.warning(f'QuestScriptHandler: Broadcast message {quest_script["dataint"]} not found.')

                case ScriptCommands.SCRIPT_COMMAND_EMOTE: # emote
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_EMOTE ' + str(quest_script['datalong']))
                    self.quest_giver.play_emote(quest_script['datalong'])

                case ScriptCommands.SCRIPT_COMMAND_FIELD_SET: # field set
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_FIELD_SET not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MOVE_TO: # move 
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_MOVE_TO not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MODIFY_FLAGS: # modify NPC flags
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_MODIFY_FLAGS')
                    if quest_script['datalong2'] == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
                        pass
                    elif quest_script['datalong2'] == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
                        pass
                    else: 
                        pass

                case ScriptCommands.SCRIPT_COMMAND_INTERRUPT_CASTS: # stop cast
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_INTERRUPT_CASTS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TELEPORT_TO: # teleport
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_TELEPORT_TO not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_QUEST_EXPLORED: # complete quest
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_QUEST_EXPLORED not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_KILL_CREDIT: # kill credit
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_KILL_CREDIT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_RESPAWN_GAMEOBJECT: # respawn game object
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_RESPAWN_GAMEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TEMP_SUMMON_CREATURE: # summon creature
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_TEMP_SUMMON_CREATURE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_OPEN_DOOR: # open door
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_OPEN_DOOR not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CLOSE_DOOR: # close door
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_CLOSE_DOOR not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ACTIVATE_OBJECT: # activate object
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ACTIVATE_OBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_AURA: # remove aura
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_REMOVE_AURA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CAST_SPELL: # cast spell
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_CAST_SPELL')
                    if not quest_script['player_mgr']:
                        Logger.warning('QuestScriptHandler: No player manager found, aborting cast')
                        return
                    self.quest_giver.spell_manager.handle_cast_attempt(quest_script['datalong'], quest_script['player_mgr'], SpellTargetMask.UNIT, validate=False)                        

                case ScriptCommands.SCRIPT_COMMAND_PLAY_SOUND: # play sound
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_PLAY_SOUND not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CREATE_ITEM: # create item
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_CREATE_ITEM not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_DESPAWN_CREATURE: # despawn creature
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_DESPAWN_CREATURE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_EQUIPMENT: # set equipment
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_EQUIPMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MOVEMENT: # start waypoint movement
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_MOVEMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_ACTIVEOBJECT: # set active object
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_ACTIVEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_FACTION: # set faction
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_FACTION not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL: # morph to entry or model
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL: # mount to entry or model
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_RUN: # set run
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_RUN not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ATTACK_START: # attack start                    
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ATTACK_START not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_UPDATE_ENTRY: # update quest entry
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_UPDATE_ENTRY not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_STAND_STATE: # set stand state
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_STAND_STATE')
                    self.quest_giver.set_stand_state(quest_script['datalong'])

                case ScriptCommands.SCRIPT_COMMAND_MODIFY_THREAT: # modify threat
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_MODIFY_THREAT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SEND_TAXI_PATH: # send taxi path
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SEND_TAXI_PATH not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TERMINATE_SCRIPT: # terminate script
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_TERMINATE_SCRIPT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TERMINATE_CONDITION: # terminate condition
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_TERMINATE_CONDITION not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ENTER_EVADE_MODE: # enter evade mode
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ENTER_EVADE_MODE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_HOME_POSITION: # set home position
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_HOME_POSITION not implemented yet')
                    pass                

                case ScriptCommands.SCRIPT_COMMAND_TURN_TO: # turn to target
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_TURN_TO') 
                    if quest_script['datalong'] == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
                       self.quest_giver.movement_manager.send_face_target(quest_script['player_mgr'])
                    else:
                       self.quest_giver.movement_manager.send_face_angle(quest_script['o'])

                case ScriptCommands.SCRIPT_COMMAND_MEETINGSTONE: # meeting stone
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_MEETINGSTONE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_INST_DATA: # set instance data
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_INST_DATA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_INST_DATA64: # set instance data64
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_INST_DATA64 not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_SCRIPT: # start script
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_START_SCRIPT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_ITEM: # remove item
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_REMOVE_ITEM not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_OBJECT: # remove object
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_REMOVE_OBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_MELEE_ATTACK: # set melee attack
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_MELEE_ATTACK not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_COMBAT_MOVEMENT: # set combat movement
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_COMBAT_MOVEMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PHASE: # set phase
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_PHASE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PHASE_RANDOM: # set phase random
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_PHASE_RANDOM not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PHASE_RANGE: # set phase range
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_PHASE_RANGE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_FLEE: # flee
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_FLEE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_DEAL_DAMAGE: # deal damage
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_DEAL_DAMAGE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ZONE_COMBAT_PULSE: # zone combat pulse
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ZONE_COMBAT_PULSE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CALL_FOR_HELP: # call for help
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_CALL_FOR_HELP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_SHEATH: # set sheath
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_SHEATH not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_INVINCIBILITY: # make invincible
                    Logger.debug('QuestScriptHandler: SCRIPT_COMMAND_INVINCIBILITY')
                    if quest_script['datalong2'] == 1:
                        self.quest_giver.unit_flags += UnitFlags.UNIT_MASK_NON_ATTACKABLE
                    else:
                        self.quest_giver.unit_flags -= UnitFlags.UNIT_MASK_NON_ATTACKABLE

                case ScriptCommands.SCRIPT_COMMAND_GAME_EVENT: # game event
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_GAME_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_SERVER_VARIABLE: # set server variable
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_SERVER_VARIABLE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CREATURE_SPELLS: # add/remove spell list
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_CREATURE_SPELLS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_GUARDIANS: # remove guardians
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_REMOVE_GUARDIANS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_SPELL_COOLDOWN: # add spell cooldown
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ADD_SPELL_COOLDOWN not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_SPELL_COOLDOWN: # remove spell cooldown
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_REMOVE_SPELL_COOLDOWN not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_REACT_STATE: # set react state
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_REACT_STATE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_WAYPOINTS: # start waypoints
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_START_WAYPOINTS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_MAP_EVENT: # start scripted event
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_START_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_END_MAP_EVENT: # end scripted event
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_END_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_MAP_EVENT_TARGET: # add event target
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ADD_MAP_EVENT_TARGET not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_MAP_EVENT_TARGET: # remove event target
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_REMOVE_MAP_EVENT_TARGET not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_MAP_EVENT_DATA: # set map event data
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_MAP_EVENT_DATA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SEND_MAP_EVENT: # send map event
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SEND_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_DEFAULT_MOVEMENT: # set default movement
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_DEFAULT_MOVEMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_FOR_ALL: # start script for all
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_START_SCRIPT_FOR_ALL not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_EDIT_MAP_EVENT: # change map event condition
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_EDIT_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_FAIL_QUEST: # fail quest
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_FAIL_QUEST not implemented yet')
                    pass                

                case ScriptCommands.SCRIPT_COMMAND_RESPAWN_CREATURE: # respawn
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_RESPAWN_CREATURE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ASSIST_UNIT: # assist unit
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ASSIST_UNIT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_COMBAT_STOP: # combat stop
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_COMBAT_STOP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_AURA: # add aura
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ADD_AURA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_THREAT: # add threat
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_ADD_THREAT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SUMMON_OBJECT: # summon object
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SUMMON_OBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_FLY: # set flying
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_FLY not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_JOIN_CREATURE_GROUP: # join creature group
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_JOIN_CREATURE_GROUP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_LEAVE_CREATURE_GROUP: # leave creature group
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_LEAVE_CREATURE_GROUP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_GO_STATE: # set go state
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_GO_STATE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_DESPAWN_GAMEOBJECT: #  despawn gameobject
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_DESPAWN_GAMEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_LOAD_GAMEOBJECT: # load gameobject
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_LOAD_GAMEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_QUEST_CREDIT: # quest credit
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_QUEST_CREDIT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_GOSSIP_MENU: # set gossip menu
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_GOSSIP_MENU not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SEND_SCRIPT_EVENT: # send script event
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SEND_SCRIPT_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PVP: # set pvp
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_PVP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON: # reset door or button
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_COMMAND_STATE: # set command state
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_SET_COMMAND_STATE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_PLAY_CUSTOM_ANIM: # play custom anim
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_PLAY_CUSTOM_ANIM not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_ON_GROUP: # start script on group
                    Logger.warning('QuestScriptHandler: SCRIPT_COMMAND_START_SCRIPT_ON_GROUP not implemented yet')
                    pass

                case _:
                    Logger.warning('QuestScriptHandler: Unknown script command ' + str(quest_script['command']))
                    pass
    
    def enqueue_quest_script(self, quest_id, player_mgr, end_script=False):
        scripts = None

        if not end_script:
            scripts = WorldDatabaseManager.quest_start_script_get_by_quest_id(quest_id)
        else:
            scripts = WorldDatabaseManager.quest_end_script_get_by_quest_id(quest_id)

        if scripts:
            for script in scripts:
                self.quest_script_queue.append({
                    'command': script.command, 
                    'datalong': script.datalong, 
                    'datalong2': script.datalong2,
                    'datalong3': script.datalong3, 
                    'datalong4': script.datalong4, 
                    'x': script.x,
                    'y': script.y,
                    'z': script.z, 
                    'o': script.o, 
                    'target_param1': script.target_param1,
                    'target_param2': script.target_param2,
                    'target_type': script.target_type,
                    'data_flags': script.data_flags,
                    'dataint': script.dataint,
                    'dataint2': script.dataint2,
                    'dataint3': script.dataint3,
                    'delay': script.delay, 
                    'player_mgr': player_mgr, 
                    'time_added': time.time() 
                })                

    def reset(self):        
        self.quest_script_queue.clear()

    def update(self):
        if len(self.quest_script_queue) > 0:
            for quest_script in self.quest_script_queue:
                if time.time() - quest_script["time_added"] >= quest_script["delay"]:
                    QuestScriptHandler.handle_quest_script(self, quest_script)
                    self.quest_script_queue.remove(quest_script)                    