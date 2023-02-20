import time
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.MiscCodes import ChatMsgs
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.ScriptCodes import ModifyFlagsOptions, TurnToFacingOptions
from game.world.managers.objects.units.player.ChatManager import ChatManager

class QuestScriptHandler():
    def __init__(self, creature_mgr):
        self.quest_script_queue = []
        self.quest_giver = creature_mgr        

    def handle_quest_script(self, quest_script):

            if not self.quest_giver or not self.quest_giver.is_alive:
                return

            match quest_script['command']:
                case 0: # talk
                    print('QuestScriptHandler: Talk')
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
                            print('QuestScriptHandler: Say ' + text_to_say)
                            ChatManager.send_monster_emote_message(self.quest_giver, self.quest_giver.guid, broadcast_message.language_id, text_to_say,
                            ChatMsgs.CHAT_MSG_MONSTER_SAY if broadcast_message.chat_type == 0 else ChatMsgs.CHAT_MSG_MONSTER_YELL)
                            if broadcast_message.emote_id1 != 0:                            
                                self.quest_giver.play_emote(broadcast_message.emote_id1)
                            # neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them

                case 1: # emote
                    print('QuestScriptHandler: Emote ' + str(quest_script['datalong']))
                    self.quest_giver.play_emote(quest_script['datalong'])

                case 3: # move 
                    pass
                case 4: # modify NPC flags
                    print('QuestScriptHandler: Modify NPC flags')
                    if quest_script['datalong2'] == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
                        pass
                    elif quest_script['datalong2'] == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
                        pass
                    else: 
                        pass

                case 5: # stop cast
                    pass
                case 7: # complete quest
                    pass
                case 9: # spawn game object
                    pass
                case 10: # summon creature
                    pass
                case 11: # unknown
                    pass
                case 15: # cast spell
                    print('QuestScriptHandler: Cast spell ' + str(quest_script['datalong']))
                    if not quest_script['player_mgr']:
                        print('QuestScriptHandler: No player manager found, aborting cast')
                        return
                    self.quest_giver.spell_manager.handle_cast_attempt(quest_script['datalong'], quest_script['player_mgr'], SpellTargetMask.UNIT, validate=False)                        

                case 20: # start waypoint movement
                    pass
                case 22: # set faction
                    pass
                case 25: # set walk
                    pass
                case 26: # attack player                    
                    pass
                case 27: # set quest entry?
                    pass
                case 28: # set stand state
                    print('QuestScriptHandler: Set stand state to ' + str(quest_script['datalong']))
                    self.quest_giver.set_stand_state(quest_script['datalong'])

                case 32: # terminate script
                    pass
                case 35: # set orientation
                    print('QuestScriptHandler: Set orientation') 
                    if quest_script['datalong'] == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
                       self.quest_giver.movement_manager.send_face_target(quest_script['player_mgr'])
                    else:
                       self.quest_giver.movement_manager.send_face_angle(quest_script['o'])

                case 39: # start script
                    pass
                case 40: # remove from map
                    pass
                case 44: # set phase
                    pass
                case 52: # make unkillable
                    print('QuestScriptHandler: Make unkillable ' + str(quest_script['datalong2']))
                    if quest_script['datalong2'] == 1:
                        self.quest_giver.unit_flags += UnitFlags.UNIT_MASK_NON_ATTACKABLE
                    else:
                        self.quest_giver.unit_flags -= UnitFlags.UNIT_MASK_NON_ATTACKABLE
                case 55: # add/remove spell list
                    pass
                case 60: # start waypoints
                    pass
                case 61: # start scripted event
                    pass
                case 69: # change map event condition
                    pass
                case 71: # respawn
                    pass
                case 74: # add aura
                    pass
                case 76: # unused?
                    pass
                case 81: # remove from map
                    pass
                case _:
                    pass
    
    def enqueue_quest_script(self, quest_id, player_mgr, end_script=False):
        scripts = None

        if not end_script:
            scripts = WorldDatabaseManager.quest_start_script_get_by_quest_id(quest_id)
        else:
            scripts = WorldDatabaseManager.quest_end_script_get_by_quest_id(quest_id)

        print("Found " + str(len(scripts)) + " scripts for quest " + str(quest_id))

        if scripts:
            for script in scripts:
                self.quest_script_queue.append({ 'command': script.command, 'datalong': script.datalong, 'datalong2': script.datalong2,
                'o': script.o,
                 'delay': script.delay, 'player_mgr': player_mgr, 'time_added': time.time() })
                print("Added to quest script queue, new length: " + str(len(self.quest_script_queue)))

    def reset(self):        
        self.quest_script_queue.clear()

    def update(self):
        if len(self.quest_script_queue) > 0:
            for quest_script in self.quest_script_queue:
                if time.time() - quest_script["time_added"] >= quest_script["delay"]:
                    QuestScriptHandler.handle_quest_script(self, quest_script)
                    self.quest_script_queue.remove(quest_script)
                    print("Removed from quest script queue, new length: " + str(len(self.quest_script_queue)))