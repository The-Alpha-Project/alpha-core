from dataclasses import dataclass
import random
import time
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps import MapManager
from game.world.managers.objects.units import DamageInfoHolder
from game.world.managers.objects.units.creature import CreatureBuilder
from utils.constants import CustomCodes
from utils.constants.MiscCodes import ChatMsgs, ScriptTypes
from utils.constants.SpellCodes import SpellSchoolMask, SpellTargetMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.ScriptCodes import ModifyFlagsOptions, TurnToFacingOptions, ScriptCommands, SetHomePositionOptions
from game.world.managers.objects.units.player.ChatManager import ChatManager
from utils.Logger import Logger

@dataclass
class Script:
    command: int
    datalong: int
    datalong2: int
    datalong3: int
    datalong4: int
    x: float
    y: float
    z: float
    o: float
    target_param1: int
    target_param2: int
    target_type: int
    data_flags: int
    dataint: int
    dataint2: int
    dataint3: int
    delay: int
    source: object
    target: object    
    time_added: float

class ScriptHandler():
    def __init__(self):
        self.script_queue = []       
        self.ooc_spawn_min_delay = 0
        self.ooc_spawn_max_delay = 0
        self.ooc_repeat_min_delay = 0
        self.ooc_repeat_max_delay = 0
        self.ooc_scripts = []
        self.ooc_event = None
        self.ooc_next = 0
        self.ooc_target = None
        self.ooc_running = False
        self.last_flee_event = None

    def handle_script(self, script):

            match script.command:
                case ScriptCommands.SCRIPT_COMMAND_TALK: # talk
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_TALK')
                    broadcast_message = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(script.dataint)

                    if broadcast_message: 
                        text_to_say = None
                        if script.source.gender is not None and script.source.gender == 0 and broadcast_message.male_text is not None:
                            text_to_say = broadcast_message.male_text
                        elif script.source.gender is not None and script.source.gender == 1 and broadcast_message.female_text is not None:
                            text_to_say = broadcast_message.female_text
                        else:
                            text_to_say = broadcast_message.male_text if broadcast_message.male_text is not None else broadcast_message.female_text

                        if text_to_say is not None:     
                            ChatManager.send_monster_emote_message(script.source, script.source.guid, broadcast_message.language_id, text_to_say,
                            ChatMsgs.CHAT_MSG_MONSTER_SAY if broadcast_message.chat_type == 0 else ChatMsgs.CHAT_MSG_MONSTER_YELL)
                            if broadcast_message.emote_id1 != 0:                                    
                                    script.source.play_emote(broadcast_message.emote_id1)
                            # neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them
                        else:
                            Logger.warning(f'ScriptHandler: Broadcast message {script.dataint} has no text to say.')
                    else:
                        Logger.warning(f'ScriptHandler: Broadcast message {script.dataint} not found.')

                case ScriptCommands.SCRIPT_COMMAND_EMOTE: # emote
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_EMOTE')
                    script.source.play_emote(script.datalong)

                case ScriptCommands.SCRIPT_COMMAND_FIELD_SET: # field set
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_FIELD_SET not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MOVE_TO: # move 
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_MOVE_TO not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MODIFY_FLAGS: # modify NPC flags
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_MODIFY_FLAGS')
                    if script.datalong2 == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
                        pass
                    elif script.datalong2 == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
                        pass
                    else: 
                        pass

                case ScriptCommands.SCRIPT_COMMAND_INTERRUPT_CASTS: # stop cast
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_INTERRUPT_CASTS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TELEPORT_TO: # teleport
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_TELEPORT_TO')
                    script.source.teleport(script.datalong, Vector(script.x, script.y, script.z, script.o))
    
                case ScriptCommands.SCRIPT_COMMAND_QUEST_EXPLORED: # complete quest
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_QUEST_EXPLORED not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_KILL_CREDIT: # kill credit
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_KILL_CREDIT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_RESPAWN_GAMEOBJECT: # respawn game object
                    # not implemented for 0.5.3 as it seems to be never used                    
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TEMP_SUMMON_CREATURE: # summon creature
                    # TODO: add support for datalong3 (unique_limit) and datalong4 (unique_distance)

                    creature_manager = CreatureBuilder.create(script.datalong, script.target, \
                         script.source.map_id, script.source.instance_id, location = Vector(script.x, script.y, script.z, script.o), \
                         summoner = script.source, faction = script.source.faction, ttl = script.datalong2, \
                         subtype = CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON)
                    if creature_manager is not None:
                        MapManager.spawn_object(world_object_instance = creature_manager)

                case ScriptCommands.SCRIPT_COMMAND_OPEN_DOOR: # open door
                    # not used in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CLOSE_DOOR: # close door
                    # not used in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ACTIVATE_OBJECT: # activate object
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_ACTIVATE_OBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_AURA: # remove aura
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_REMOVE_AURA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CAST_SPELL: # cast spell
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_CAST_SPELL')    
                    script.source.spell_manager.handle_cast_attempt(script.datalong, script.target if not script.target == None else script.source, SpellTargetMask.SELF, validate=False)                        

                case ScriptCommands.SCRIPT_COMMAND_PLAY_SOUND: # play sound
                    # can't be implemented as opcodes to play sounds are not implemented in 0.5.3                    
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CREATE_ITEM: # create item
                    if script.source.inventory:
                        script.source.inventory.add_item(script.datalong, script.datalong2)
                    else:
                        Logger.warning('ScriptHandler: No inventory found, aborting SCRIPT_COMMAND_CREATE_ITEM')
                    
                case ScriptCommands.SCRIPT_COMMAND_DESPAWN_CREATURE: # despawn creature
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_DESPAWN_CREATURE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_EQUIPMENT: # set equipment
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_EQUIPMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MOVEMENT: # start waypoint movement
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_MOVEMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_ACTIVEOBJECT: # set active object
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_ACTIVEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_FACTION: # set faction
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_FACTION not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL: # morph to entry or model
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL: # mount to entry or model
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_RUN: # set run
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_RUN not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ATTACK_START: # attack start                    
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_ATTACK_START not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_UPDATE_ENTRY: # update quest entry
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_UPDATE_ENTRY not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_STAND_STATE: # set stand state
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_STAND_STATE')
                    script.source.set_stand_state(script.datalong)

                case ScriptCommands.SCRIPT_COMMAND_MODIFY_THREAT: # modify threat
                    # not used in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SEND_TAXI_PATH: # send taxi path
                    # not used in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TERMINATE_SCRIPT: # terminate script
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_TERMINATE_SCRIPT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_TERMINATE_CONDITION: # terminate condition
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_TERMINATE_CONDITION not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ENTER_EVADE_MODE: # enter evade mode
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_ENTER_EVADE_MODE')
                    if script.source and script.source.object_ai:
                        script.source.leave_combat()
                    else:
                        Logger.warning('ScriptHandler: SCRIPT_COMMAND_ENTER_EVADE_MODE failed, source has no AI')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_HOME_POSITION: # set home position
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_SET_HOME_POSITION')
                    if script.datalong == SetHomePositionOptions.SET_HOME_DEFAULT_POSITION:
                        pass
                        # TODO: Implement
                    else:                        
                        # all other options are unused in 0.5.3
                        pass                

                case ScriptCommands.SCRIPT_COMMAND_TURN_TO: # turn to target
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_TURN_TO') 
                    if script.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
                        script.source.movement_manager.send_face_target(script.player_mgr)
                    else:
                        script.source.movement_manager.send_face_angle(script.o)

                case ScriptCommands.SCRIPT_COMMAND_MEETINGSTONE: # meeting stone
                    # not implemented in 0.5.3 as there are no meeting stones
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_INST_DATA: # set instance data
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_INST_DATA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_INST_DATA64: # set instance data64
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_INST_DATA64 not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_SCRIPT: # start script
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_START_SCRIPT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_ITEM: # remove item
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_REMOVE_ITEM')
                    src = None
                    if script.source and not script.target:
                        src = script.source
                    elif script.target and not script.source:
                        src = script.target
                    elif script.source and script.target:
                        src = script.source if script.source.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED else \
                            script.target if script.target.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED else None

                    if src and src.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED:
                        src.inventory.remove_items(script.datalong, script.datalong2)
                    else:
                        Logger.warning('ScriptHandler: Neither source nor target are a player, aborting SCRIPT_COMMAND_REMOVE_ITEM')

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_OBJECT: # remove object
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_REMOVE_OBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_MELEE_ATTACK: # set melee attack
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_MELEE_ATTACK not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_COMBAT_MOVEMENT: # set combat movement
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_COMBAT_MOVEMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PHASE: # set phase
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_PHASE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PHASE_RANDOM: # set phase random
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_PHASE_RANDOM not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PHASE_RANGE: # set phase range
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_PHASE_RANGE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_FLEE: # flee
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_FLEE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_DEAL_DAMAGE: # deal damage
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_DEAL_DAMAGE')
                    if script.target:
                        damage_to_deal = 0
                        if script.datalong2 == 1:
                            # damage is a percentage of the target's health
                            damage_to_deal = int(script.target.health * (script.datalong / 100))
                        else:
                            damage_to_deal = script.datalong

                        if damage_to_deal > 0:
                            damage_info = DamageInfoHolder(attacker = script.source, victim = script.target, damage = damage_to_deal, school_mask = SpellSchoolMask.SPELL_SCHOOL_MASK_ALL)
                            script.source.deal_damage(damage_info)
                        else:
                            Logger.warning('ScriptHandler: SCRIPT_COMMAND_DEAL_DAMAGE attempted to deal 0 damage')
                    else:
                        Logger.warning('ScriptHandler: SCRIPT_COMMAND_DEAL_DAMAGE attempted to run with no target')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ZONE_COMBAT_PULSE: # zone combat pulse
                    # not implemented because 0.5.3 didn't know combat pulse                    
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CALL_FOR_HELP: # call for help
                    # not implemented because 0.5.3 didn't have call for help
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_SHEATH: # set sheath
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_SET_SHEATH')
                    script.source.set_weapon_mode(script.datalong)
                    pass

                case ScriptCommands.SCRIPT_COMMAND_INVINCIBILITY: # make invincible
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_INVINCIBILITY')
                    if script.datalong2 == 1:
                        script.source.unit_flags += UnitFlags.UNIT_MASK_NON_ATTACKABLE
                    else:
                        script.source.unit_flags -= UnitFlags.UNIT_MASK_NON_ATTACKABLE

                case ScriptCommands.SCRIPT_COMMAND_GAME_EVENT: # game event
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_GAME_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_SERVER_VARIABLE: # set server variable
                    # not used in any way in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_CREATURE_SPELLS: # add/remove spell list
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_CREATURE_SPELLS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_GUARDIANS: # remove guardians
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_REMOVE_GUARDIANS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_SPELL_COOLDOWN: # add spell cooldown
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_SPELL_COOLDOWN not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_SPELL_COOLDOWN: # remove spell cooldown
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_REMOVE_SPELL_COOLDOWN not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_REACT_STATE: # set react state
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_REACT_STATE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_WAYPOINTS: # start waypoints
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_START_WAYPOINTS not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_MAP_EVENT: # start scripted event
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_START_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_END_MAP_EVENT: # end scripted event
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_END_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_MAP_EVENT_TARGET: # add event target
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_MAP_EVENT_TARGET not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_REMOVE_MAP_EVENT_TARGET: # remove event target
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_REMOVE_MAP_EVENT_TARGET not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_MAP_EVENT_DATA: # set map event data
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_MAP_EVENT_DATA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SEND_MAP_EVENT: # send map event
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SEND_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_DEFAULT_MOVEMENT: # set default movement
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_DEFAULT_MOVEMENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_FOR_ALL: # start script for all
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_START_SCRIPT_FOR_ALL not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_EDIT_MAP_EVENT: # change map event condition
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_EDIT_MAP_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_FAIL_QUEST: # fail quest
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_FAIL_QUEST not implemented yet')
                    pass                

                case ScriptCommands.SCRIPT_COMMAND_RESPAWN_CREATURE: # respawn
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_RESPAWN_CREATURE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ASSIST_UNIT: # assist unit
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_ASSIST_UNIT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_COMBAT_STOP: # combat stop
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_COMBAT_STOP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_AURA: # add aura
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_AURA not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_ADD_THREAT: # add threat
                    Logger.debug('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT')
                    if script.target:
                        if script.source.is_alive and script.source.in_combat:
                            script.source.threat_manager.add_threat(script.target, script.datalong)
                        else:
                            Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT: source is not in combat')
                    else:
                        Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT: invalid target')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SUMMON_OBJECT: # summon object
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SUMMON_OBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_FLY: # set flying
                    # not used in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_JOIN_CREATURE_GROUP: # join creature group
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_JOIN_CREATURE_GROUP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_LEAVE_CREATURE_GROUP: # leave creature group
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_LEAVE_CREATURE_GROUP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_GO_STATE: # set go state
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_GO_STATE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_DESPAWN_GAMEOBJECT: #  despawn gameobject
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_DESPAWN_GAMEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_LOAD_GAMEOBJECT: # load gameobject
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_LOAD_GAMEOBJECT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_QUEST_CREDIT: # quest credit
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_QUEST_CREDIT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_GOSSIP_MENU: # set gossip menu
                    # not implemented in 0.5.3
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SEND_SCRIPT_EVENT: # send script event
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SEND_SCRIPT_EVENT not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_PVP: # set pvp
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_PVP not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON: # reset door or button
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_SET_COMMAND_STATE: # set command state
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_SET_COMMAND_STATE not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_PLAY_CUSTOM_ANIM: # play custom anim
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_PLAY_CUSTOM_ANIM not implemented yet')
                    pass

                case ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_ON_GROUP: # start script on group
                    Logger.warning('ScriptHandler: SCRIPT_COMMAND_START_SCRIPT_ON_GROUP not implemented yet')
                    pass

                case _:
                    Logger.warning('ScriptHandler: Unknown script command ' + str(script.command))
                    pass
    
    def enqueue_ai_script(self, source, script):
        if script:
            self.script_queue.append(Script(
                script.command,
                script.datalong,
                script.datalong2,
                script.datalong3,
                script.datalong4,
                script.x,
                script.y,
                script.z,
                script.o,
                script.target_param1,
                script.target_param2,
                script.target_type,
                script.data_flags,
                script.dataint,
                script.dataint2,
                script.dataint3,
                script.delay,
                source,
                None,
                time.time()
            ))    
            Logger.debug('ScriptHandler: AI script enqueued')

    def set_random_ooc_event(self, target, event):

        self.ooc_event = event

        if event.action1_script > 0:
            self.ooc_scripts.append(event.action1_script)
        if event.action2_script > 0:
            self.ooc_scripts.append(event.action2_script)
        if event.action3_script > 0:
            self.ooc_scripts.append(event.action3_script)           

        self.ooc_spawn_min_delay = event.event_param1 / 1000
        self.ooc_spawn_max_delay = event.event_param2 / 1000
        self.ooc_repeat_min_delay = event.event_param3 / 1000
        self.ooc_repeat_max_delay = event.event_param4 / 1000

        script = WorldDatabaseManager.creature_ai_script_get_by_id(random.choice(self.ooc_scripts))

        if script:
            self.ooc_target = target
                        
            script.delay = random.randint(self.ooc_spawn_min_delay, self.ooc_spawn_max_delay)
            self.ooc_next = time.time() + script.delay
            self.enqueue_ai_script(self.ooc_target, script)

    def enqueue_script(self, source, target, script_type, quest_id = None):
        scripts = None

        match script_type:
            case ScriptTypes.SCRIPT_TYPE_QUEST_START:
                scripts = WorldDatabaseManager.quest_start_script_get_by_quest_id(quest_id)
            case ScriptTypes.SCRIPT_TYPE_QUEST_END:
                scripts = WorldDatabaseManager.quest_end_script_get_by_quest_id(quest_id)
            case ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT:
                Logger.warning('ScriptHandler: SCRIPT_TYPE_CREATURE_MOVEMENT not implemented yet')
                pass
            case ScriptTypes.SCRIPT_TYPE_CREATURE_SPELL:
                Logger.warning('ScriptHandler: SCRIPT_TYPE_CREATURE_SPELL not implemented yet')
                pass
            case ScriptTypes.SCRIPT_TYPE_GAMEOBJECT:
                Logger.warning('ScriptHandler: SCRIPT_TYPE_GAMEOBJECT not implemented yet')
                pass
            case ScriptTypes.SCRIPT_TYPE_GENERIC:
                Logger.warning('ScriptHandler: SCRIPT_TYPE_GENERIC not implemented yet')
                pass
            case ScriptTypes.SCRIPT_TYPE_GOSSIP:
                Logger.warning('ScriptHandler: SCRIPT_TYPE_GOSSIP not implemented yet')
                pass
            case ScriptTypes.SCRIPT_TYPE_SPELL:
                Logger.warning('ScriptHandler: SCRIPT_TYPE_SPELL not implemented yet')
                pass

        if scripts:
            for script in scripts:
                self.script_queue.append(Script(
                    script.command,
                    script.datalong,
                    script.datalong2,
                    script.datalong3,
                    script.datalong4,
                    script.x,
                    script.y,
                    script.z,
                    script.o,
                    script.target_param1,
                    script.target_param2,
                    script.target_type,
                    script.data_flags,
                    script.dataint,
                    script.dataint2,
                    script.dataint3,
                    script.delay,
                    source,
                    target,
                    time.time()
                ))

    def reset(self):        
        self.script_queue.clear()
        self.ooc_scripts = None
        self.ooc_repeat_min_delay = 0
        self.ooc_repeat_max_delay = 0
        self.ooc_next = 0
        self.ooc_target = None
        self.ooc_running = False
        self.last_flee_event = None

    def update(self):
        if len(self.script_queue) > 0:
            for script in self.script_queue:
                if time.time() - script.time_added >= script.delay:
                    ScriptHandler.handle_script(self, script)
                    self.script_queue.remove(script)   

        if self.ooc_scripts:            
            if time.time() >= self.ooc_next and not self.ooc_running:                
                self.ooc_running = True
                script = WorldDatabaseManager.creature_ai_script_get_by_id(random.choice(self.ooc_scripts))

                if script:                                               
                    script.delay = random.randint(self.ooc_repeat_min_delay, self.ooc_repeat_max_delay)
                    self.ooc_next = time.time() + script.delay                
                    self.enqueue_ai_script(self.ooc_target, script)
                    
                self.ooc_running = False