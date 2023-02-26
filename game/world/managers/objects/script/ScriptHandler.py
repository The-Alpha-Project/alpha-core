from dataclasses import dataclass
import math
import random
import time
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps import MapManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.units import DamageInfoHolder
from game.world.managers.objects.units.creature import CreatureBuilder
from utils.constants import CustomCodes
from utils.constants.MiscCodes import ChatMsgs, Languages, ScriptTypes
from utils.constants.SpellCodes import SpellSchoolMask, SpellTargetMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.ScriptCodes import ModifyFlagsOptions, MoveToCoordinateTypes, TurnToFacingOptions, ScriptCommands, SetHomePositionOptions
from game.world.managers.objects.units.player.ChatManager import ChatManager
from utils.Logger import Logger
from utils.ConfigManager import config
from utils.constants.UpdateFields import UnitFields

@dataclass
class Script:
    id: int
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
    dataint4: int
    delay: int
    condition_id: int
    source: object
    target: object    
    time_added: float

class ScriptHandler:
    def __init__(self, object):
        self.object = object
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
        self.CREATURE_FLEE_TEXT = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(1150)

    def handle_script(self, script):
            if script.command in SCRIPT_COMMANDS:
                SCRIPT_COMMANDS[script.command](self, script)
            else:
                Logger.warning(f'Unknown script command {script.command}.')
    
    def enqueue_ai_script(self, source, script):
        if script:
            self.script_queue.append(Script(
                script.id,
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
                script.dataint4,
                script.delay,
                script.condition_id,
                source,
                None,
                time.time()
            ))    

    def set_generic_script(self, source, target, script_id):
        scripts = WorldDatabaseManager.generic_script_get_by_id(script_id)

        for script in scripts:
            self.enqueue_script(source, target, ScriptTypes.SCRIPT_TYPE_GENERIC, script.id)

    def set_random_ooc_event(self, target, event):

        if event.condition_id > 0:
            if not ConditionChecker.check_condition(event.condition_id, self.object, target):
                return

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

            # Some events have a repeat delay of 0, which means they should not repeat.
            if self.ooc_repeat_min_delay > 0 and self.ooc_repeat_max_delay > 0:
                self.ooc_next = time.time() + script.delay
            else:
                self.ooc_next = None

            self.enqueue_ai_script(self.ooc_target, script)

    def enqueue_script(self, source, target, script_type, entry_id):                
        if script_type in SCRIPT_TYPES:
            scripts = SCRIPT_TYPES[script_type](entry_id)
        else:
            Logger.warning(f'Unhandled script type {script_type}.')
            return

        if scripts:
            for script in scripts:

                if script.condition_id > 0:
                    if not ConditionChecker.check_condition(script.condition_id, self.object, target):
                        continue

                self.script_queue.append(Script(
                    script.id,
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
                    script.dataint4,
                    script.delay,
                    script.condition_id,
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

                    if script in self.script_queue:                
                        self.script_queue.remove(script)   

        if self.ooc_scripts:            
            if self.ooc_next is not None and time.time() >= self.ooc_next and not self.ooc_running:                
                self.ooc_running = True
                script = WorldDatabaseManager.creature_ai_script_get_by_id(random.choice(self.ooc_scripts))

                if script:                                               
                    script.delay = random.randint(self.ooc_repeat_min_delay, self.ooc_repeat_max_delay)
                    self.ooc_next = time.time() + script.delay                
                    self.enqueue_ai_script(self.ooc_target, script)
                    
                self.ooc_running = False

    def handle_script_command_talk(self, script):        
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
                # Neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them.
            else:
                Logger.warning(f'ScriptHandler: Broadcast message {script.dataint} has no text to say.')
        else:
            Logger.warning(f'ScriptHandler: Broadcast message {script.dataint} not found.')


    def handle_script_command_emote(self, script):
        emotes = []
        if script.datalong != 0:
            emotes.append(script.datalong)
        if script.datalong2 != 0:
            emotes.append(script.datalong2)
        if script.datalong3 != 0:
            emotes.append(script.datalong3)
        if script.datalong4 != 0:
            emotes.append(script.datalong4)

        script.source.play_emote(random.choice(emotes))

    def handle_script_command_field_set(self, script):
        Logger.debug('ScriptHandler: handle_script_command_field_set not implemented yet')
        pass

    def handle_script_command_move_to(self, script):
        if script.source and script.source.creature_manager:
            coordinates_type = script.datalong
            time = script.datalong2
            movement_options = script.datalong3 # Not used for now.
            move_to_flags = script.datalong4 # Not used for now.
            path_id = script.dataint # Not used for now.
            speed = config.Unit.Defaults.walk_speed # Vmangos sets this to zero by default for whatever reason.
            x, y, z = 0, 0, 0
            angle = 0
            
            if coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_NORMAL:
                distance = script.source.location.distance(Vector(script.x, script.y, script.z))                
                speed = distance / time * 0.001 if time > 0 else config.Unit.Defaults.walk_speed
                x = script.x
                y = script.y
                z = script.z                
                
            elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RELATIVE_TO_TARGET:
                x = script.target.location.x + script.x
                y = script.target.location.y + script.y
                z = script.target.location.z + script.z
                
            elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_DISTANCE_FROM_TARGET:
                distance = script.x                
                if script.o < 0:
                    angle = script.source.location.o
                else:
                    angle = random.uniform(0, 2 * math.pi)

                target_point = script.source.location.get_point_in_radius_and_angle(distance, angle)
                x = target_point.x
                y = target_point.y
                z = target_point.z
                                
            elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RANDOM_POINT:
                # Unclear how this works as the data doesn't seem to provide any information about the radius.
                pass                

            if angle != 0:
                script.source.movement_manager.set_face_angle(angle)

            script.source.creature_manager.movement_manager.send_move_normal([Vector(x, y, z)], speed)
        else:
            Logger.warning(f'ScriptHandler: handle_script_command_move_to: invalid source.')
        pass

    def handle_script_command_modify_flags(self, script):
        Logger.debug('ScriptHandler: handle_script_command_modify_flags not implemented yet')
        if script.datalong2 == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
            pass
        elif script.datalong2 == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
            pass
        else: 
            pass

    def handle_script_command_interrupt_casts(self, script):
        Logger.debug('ScriptHandler: handle_script_command_interrupt_casts not implemented yet')
        pass

    def handle_script_command_teleport_to(self, script):
        script.source.teleport(script.datalong, Vector(script.x, script.y, script.z, script.o))

    def handle_script_command_quest_explored(self, script):
        Logger.debug('ScriptHandler: handle_script_command_quest_explored not implemented yet')
        pass

    def handle_script_command_kill_credit(self, script):
        Logger.debug('ScriptHandler: handle_script_command_kill_credit not implemented yet')
        pass

    def handle_script_command_respawn_gameobject(self, script):
        Logger.debug('ScriptHandler: handle_script_command_respawn_gameobject not implemented yet')
        pass

    def handle_script_command_temp_summon_creature(self, script):
        # TODO: add support for datalong4 (unique_distance).

        summoned_count = 0
        surrounding = MapManager.get_surrounding_units(script.source.location, False)
        if len(surrounding) > 0:
            for unit in surrounding:
                if unit.creature_manager is not None and unit.creature_manager.creature_template.entry == script.datalong \
                and unit.creature_manager.is_unit_pet(script.source):
                    summoned_count += 1                                    

        if summoned_count < script.datalong3:
            creature_manager = CreatureBuilder.create(script.datalong, script.source.map_id, script.source.instance_id, \
                                                    location = Vector(script.x, script.y, script.z, script.o), \
                                                    summoner = script.source, faction = script.source.faction, ttl = script.datalong2, \
                                                    subtype = CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON)
            if creature_manager is not None:
                MapManager.spawn_object(world_object_instance = creature_manager)
        else:
            Logger.warning(f'ScriptHandler: handle_script_command_temp_summon_creature: failed to create creature {script.datalong}.')

    def handle_script_command_open_door(self, script):
        Logger.debug('ScriptHandler: handle_script_command_open_door not implemented yet')
        pass

    def handle_script_command_close_door(self, script):
        Logger.debug('ScriptHandler: handle_script_command_close_door not implemented yet')
        pass

    def handle_script_command_activate_object(self, script):
        Logger.debug('ScriptHandler: handle_script_command_activate_object not implemented yet')
        pass

    def handle_script_command_remove_aura(self, script):
        if script.source and script.source.spell_manager:
            script.source.spell_manager.remove_aura(script.datalong)
        else:
            Logger.warning('ScriptHandler: No spell manager found, aborting SCRIPT_COMMAND_REMOVE_AURA')

    def handle_script_command_cast_spell(self, script):
        if script.source and script.source.spell_manager:
            script.source.spell_manager.handle_cast_attempt(script.datalong, script.target if not script.target == None else script.source, SpellTargetMask.SELF, validate=False)
        else:
            Logger.warning('ScriptHandler: No spell manager found, aborting SCRIPT_COMMAND_CAST_SPELL')

    def handle_script_command_create_item(self, script):
        if script.source and script.source.inventory:
            script.source.inventory.add_item(script.datalong, script.datalong2)
        else:
            Logger.warning('ScriptHandler: No inventory found, aborting SCRIPT_COMMAND_CREATE_ITEM')

    def handle_script_command_despawn_creature(self, script):
        if script.source and script.source.is_alive:
            if script.source.creature_manager:
                script.source.creature_manager.destroy()
            else:
                Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_DESPAWN_CREATURE')
        else:
            Logger.warning('ScriptHandler: No source found or source is dead, aborting SCRIPT_COMMAND_DESPAWN_CREATURE')

    def handle_script_command_set_equipment(self, script):
        if script.source and script.source.creature_manager:
            if script.datalong == 1:
                script.source.creature_manager.reset_virtual_equipment()
            else:
                if script.dataint > 0:
                    script.source.creature_manager.set_virtual_equipment(0, script.dataint)
                if script.dataint2 > 0:
                    script.source.creature_manager.set_virtual_equipment(1, script.dataint2)
                if script.dataint3 > 0:
                    script.source.creature_manager.set_virtual_equipment(2, script.dataint3)  
        else:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_EQUIPMENT')

    def handle_script_command_movement(self, script):
        Logger.debug('ScriptHandler: handle_script_command_movement not implemented yet')
        pass

    def handle_script_command_set_activeobject(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_activeobject not implemented yet')
        pass

    def handle_script_command_set_faction(self, script):
        if script.source and script.source.creature_manager:
            if script.datalong == 0:
                script.source.creature_manager.reset_faction()
            else:
                script.source.creature_manager.set_faction(script.datalong)
        else:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_FACTION')

    def handle_script_command_morph_to_entry_or_model(self, script):        
        if script.source and script.source.is_alive and script.source.creature_manager:  
            creatureOrModelEntry = script.datalong
            display_id = script.datalong2

            if not creatureOrModelEntry:
                script.source.reset_display_id()                
            elif script.display_id:
                script.source.set_display_id(display_id)
                pass
            else:
                creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creatureOrModelEntry)
                if creature_template:
                    script.source.set_display_id(creature_template.display_id)
                else:
                    Logger.warning('ScriptHandler: No creature template found, aborting SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL')
                pass
            
        else:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL')

    def handle_script_command_mount_to_entry_or_model(self, script):
        if script.source and script.source.is_alive and script.source.creature_manager:
            display_id = script.datalong2
            creatureOrModelEntry = script.datalong

            if not creatureOrModelEntry and not display_id:
                display_id = script.source.creature_manager.creature_template.mount_display_id
                if display_id:
                    script.source.mount(display_id)
                else:
                    script.source.unmount()
            else:
                if creatureOrModelEntry:
                    creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creatureOrModelEntry)
                    if creature_template:
                        display_id = creature_template.display_id
                        if display_id:
                            script.source.mount(display_id)
                    else:
                        script.source.unmount()
        else:
            Logger.warning('ScriptHandler: No creature manager found or creature is dead, aborting SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL')

    def handle_script_command_set_run(self, script):
        if script.source and script.source.creature_manager:
            script.source.change_speed(script.source.creature_manager.creature_template.speed_run if script.datalong == 1 else \
                                       script.source.creature_manager.creature_template.speed_walk)
        else:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_RUN')        

    def handle_script_command_attack_start(self, script):
        attacker = script.source
        victim = script.target    

        if attacker and attacker.is_alive and attacker.object_ai:
            if victim and victim.is_alive:
                attacker.attack(victim)
            elif not victim:
                from game.world.managers.objects.script.ScriptManager import ScriptManager
                victim = ScriptManager.get_target_by_type(attacker, victim, script.target_type, script.target_param1, script.target_param2, None)
                attacker.attack(victim)
        else:
            Logger.warning('ScriptHandler: Invalid attacker, aborting SCRIPT_COMMAND_ATTACK_START')

    def handle_script_command_update_entry(self, script):
        Logger.debug('ScriptHandler: handle_script_command_update_entry not implemented yet')
        pass
    
    def handle_script_command_stand_state(self, script):
        if script.source and script.source.is_alive:
            script.source.set_stand_state(script.datalong)
        else:
            Logger.warning('ScriptHandler: No source found or source is dead, aborting SCRIPT_COMMAND_STAND_STATE')

    def handle_script_command_modify_threat(self, script):
        Logger.debug('ScriptHandler: handle_script_command_modify_threat not implemented yet')
        pass

    def handle_script_command_terminate_script(self, script):
        Logger.debug('ScriptHandler: handle_script_command_terminate_script not implemented yet')
        pass

    def handle_script_command_terminate_condition(self, script):
        Logger.debug('ScriptHandler: handle_script_command_terminate_condition not implemented yet')
        pass

    def handle_script_command_enter_evade_mode(self, script):
        if script.source and script.source.object_ai:
            script.source.leave_combat()
        else:
            Logger.warning('ScriptHandler: Invalid target, aborting SCRIPT_COMMAND_ENTER_EVADE_MODE')

    def handle_script_command_set_home_position(self, script):
        # All other SetHomePositionOptions are not valid for 0.5.3.
        if script.source and script.source.creature_manager:
            if script.datalong == SetHomePositionOptions.SET_HOME_DEFAULT_POSITION:
                if script.source.creature_manager.spawn_id:
                    spawn = WorldDatabaseManager.creature_spawn_get_by_spawn_id(script.source.creature_manager.spawn_id)
                    script.source.creature_manager.spawn_position = Vector(spawn.position_x, spawn.position_y, spawn.position_y, spawn.orientation)
                    #TODO: actually move the creature to the spawn position.
        else:                        
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_HOME_POSITION')
            pass 

    def handle_script_command_turn_to(self, script):
        if script.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
            script.source.movement_manager.send_face_target(script.player_mgr)
        else:
            script.source.movement_manager.send_face_angle(script.o)

    def handle_script_command_set_inst_data(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data not implemented yet')
        pass

    def handle_script_command_set_inst_data64(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data64 not implemented yet')
        pass

    def handle_script_command_start_script(self, script):
        scripts = [] # Datalong to datalong4.
        weights = () # Dataint to dataint4.

        if script.datalong > 0:
            scripts.append(script.datalong)
            weights += (script.dataint,)
        if script.datalong2 > 0:
            scripts.append(script.datalong2)
            weights += (script.dataint2,)
        if script.datalong3 > 0:
            scripts.append(script.datalong3)
            weights += (script.dataint3,)
        if script.datalong4 > 0:
            scripts.append(script.datalong4)
            weights += (script.dataint4,)

        random_script_id = random.choices(scripts, cum_weights=weights, k=1)[0]
        
        self.set_generic_script(script.source, script.target, random_script_id)

        pass

    def handle_script_command_remove_item(self, script):
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


    def handle_script_command_remove_object(self, script):
        Logger.debug('ScriptHandler: handle_script_command_remove_object not implemented yet')
        pass

    def handle_script_command_set_melee_attack(self, script):
        if script.source and script.source.is_alive and script.source:
            if script.source.has_melee():
                if script.target and script.target.is_alive:
                    script.source.attack(script.target)                    
        else:
            Logger.warning('ScriptHandler: Invalid source, aborting SCRIPT_COMMAND_SET_MELEE_ATTACK')

        pass

    def handle_script_command_set_combat_movement(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_combat_movement not implemented yet')
        pass

    def handle_script_command_set_phase(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_phase not implemented yet')
        pass

    def handle_script_command_set_phase_random(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_phase_random not implemented yet')
        pass

    def handle_script_command_set_phase_range(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_phase_range not implemented yet')
        pass

    def handle_script_command_flee(self, script):
        if script.source and script.source.is_alive:
            if not script.source.unit_flags & UnitFlags.UNIT_FLAG_FLEEING:
                script.source.unit_flags |= UnitFlags.UNIT_FLAG_FLEEING
                script.source.set_uint32(UnitFields.UNIT_FIELD_FLAGS, script.source.unit_flags)

                # I feel so dirty doing this but it's not working otherwise.
                flee_text = self.CREATURE_FLEE_TEXT.male_text
                flee_text = flee_text.replace('%s ', '')                            

                ChatManager.send_monster_emote_message(script.source, script.source.guid, Languages.LANG_UNIVERSAL, flee_text, \
                    ChatMsgs.CHAT_MSG_MONSTER_EMOTE)
                
                if script.source.spell_manager:
                    script.source.spell_manager.remove_casts()

                # TODO: Actual fleeing movement has to wait until the movement update is implemented.
        else:
            Logger.warning('ScriptHandler: No source or source is dead, aborting SCRIPT_COMMAND_FLEE')

        pass

    def handle_script_command_deal_damage(self, script):        
        if script.target:
            damage_to_deal = 0
            if script.datalong2 == 1:
                # Damage is a percentage of the target's health.
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

    def handle_script_command_set_sheath(self, script):
        script.source.set_weapon_mode(script.datalong)

    def handle_script_command_invincibility(self, script):
        if script.datalong2 == 1:
            script.source.unit_flags |= UnitFlags.UNIT_MASK_NON_ATTACKABLE
            script.source.set_uint32(UnitFields.UNIT_FIELD_FLAGS, script.source.unit_flags)
        else:
            script.source.unit_flags &= UnitFlags.UNIT_MASK_NON_ATTACKABLE
            script.source.set_uint32(UnitFields.UNIT_FIELD_FLAGS, script.source.unit_flags)

    def handle_script_command_game_event(self, script):
        Logger.debug('ScriptHandler: handle_script_command_game_event not implemented yet')
        pass

    def handle_script_command_set_server_variable(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_server_variable not implemented yet')
        pass

    def handle_script_command_remove_guardians(self, script):
        Logger.debug('ScriptHandler: handle_script_command_remove_guardians not implemented yet')
        pass

    def handle_script_command_add_spell_cooldown(self, script):
        Logger.debug('ScriptHandler: handle_script_command_add_spell_cooldown not implemented yet')
        pass

    def handle_script_command_remove_spell_cooldown(self, script):
        Logger.debug('ScriptHandler: handle_script_command_remove_spell_cooldown not implemented yet')
        pass

    def handle_script_command_set_react_state(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_react_state not implemented yet')
        pass

    def handle_script_command_start_waypoints(self, script):
        Logger.debug('ScriptHandler: handle_script_command_start_waypoints not implemented yet')
        pass

    def handle_script_command_start_map_event(self, script):
        Logger.debug('ScriptHandler: handle_script_command_start_map_event not implemented yet')
        pass

    def handle_script_command_end_map_event(self, script):
        Logger.debug('ScriptHandler: handle_script_command_end_map_event not implemented yet')
        pass

    def handle_script_command_add_map_event_target(self, script):
        Logger.debug('ScriptHandler: handle_script_command_add_map_event_target not implemented yet')
        pass

    def handle_script_command_remove_map_event_target(self, script):
        Logger.debug('ScriptHandler: handle_script_command_remove_map_event_target not implemented yet')
        pass

    def handle_script_command_set_map_event_data(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_map_event_data not implemented yet')
        pass

    def handle_script_command_send_map_event(self, script):
        Logger.debug('ScriptHandler: handle_script_command_send_map_event not implemented yet')
        pass

    def handle_script_command_set_default_movement(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_default_movement not implemented yet')
        pass

    def handle_script_command_start_script_for_all(self, script):
        Logger.debug('ScriptHandler: handle_script_command_start_script_for_all not implemented yet')
        pass

    def handle_script_command_edit_map_event(self, script):
        Logger.debug('ScriptHandler: handle_script_command_edit_map_event not implemented yet')
        pass

    def handle_script_command_fail_quest(self, script):
        Logger.debug('ScriptHandler: handle_script_command_fail_quest not implemented yet')
        pass

    def handle_script_command_respawn_creature(self, script):
        Logger.debug('ScriptHandler: handle_script_command_respawn_creature not implemented yet')
        pass

    def handle_script_command_assist_unit(self, script):
        Logger.debug('ScriptHandler: handle_script_command_assist_unit not implemented yet')
        pass

    def handle_script_command_combat_stop(self, script):
        Logger.debug('ScriptHandler: handle_script_command_combat_stop not implemented yet')
        pass

    def handle_script_command_add_aura(self, script):
        Logger.debug('ScriptHandler: handle_script_command_add_aura not implemented yet')
        pass

    def handle_script_command_add_threat(self, script):
        if script.target:
            if script.source.is_alive and script.source.in_combat:
                script.source.threat_manager.add_threat(script.target, script.datalong)
            else:
                Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT: source is not in combat')
        else:
            Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT: invalid target')        

    def handle_script_command_summon_object(self, script):
        Logger.debug('ScriptHandler: handle_script_command_summon_object not implemented yet')
        pass

    def handle_script_command_join_creature_group(self, script):
        Logger.debug('ScriptHandler: handle_script_command_join_creature_group not implemented yet')
        pass

    def handle_script_command_leave_creature_group(self, script):
        Logger.debug('ScriptHandler: handle_script_command_leave_creature_group not implemented yet')
        pass

    def handle_script_command_set_go_state(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_go_state not implemented yet')
        pass

    def handle_script_command_despawn_gameobject(self, script):
        Logger.debug('ScriptHandler: handle_script_command_despawn_gameobject not implemented yet')
        pass

    def handle_script_command_quest_credit(self, script):
        Logger.debug('ScriptHandler: handle_script_command_quest_credit not implemented yet')
        pass

    def handle_script_command_send_script_event(self, script):
        Logger.debug('ScriptHandler: handle_script_command_send_script_event not implemented yet')
        pass

    def handle_script_command_reset_door_or_button(self, script):
        Logger.debug('ScriptHandler: handle_script_command_reset_door_or_button not implemented yet')
        pass

    def handle_script_command_set_command_state(self, script):
        Logger.debug('ScriptHandler: handle_script_command_set_command_state not implemented yet')
        pass

    def handle_script_command_play_custom_anim(self, script):
        Logger.debug('ScriptHandler: handle_script_command_play_custom_anim not implemented yet')
        pass

    def handle_script_command_start_script_on_group(self, script):
        Logger.debug('ScriptHandler: handle_script_command_start_script_on_group not implemented yet')
        pass

    # Script types.

    @staticmethod
    def handle_script_type_quest_start(quest_id):
        return WorldDatabaseManager.quest_start_script_get_by_quest_id(quest_id)
    
    @staticmethod
    def handle_script_type_quest_end(quest_id):
        return WorldDatabaseManager.quest_end_script_get_by_quest_id(quest_id)
    
    @staticmethod
    def handle_script_type_generic(script_id):
        return WorldDatabaseManager.generic_script_get_by_id(script_id)

SCRIPT_TYPES = {
    ScriptTypes.SCRIPT_TYPE_QUEST_START: ScriptHandler.handle_script_type_quest_start,
    ScriptTypes.SCRIPT_TYPE_QUEST_END: ScriptHandler.handle_script_type_quest_end,
    #ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT: ScriptHandler.handle_script_type_creature_movement,
    #ScriptTypes.SCRIPT_TYPE_CREATURE_SPELL: ScriptHandler.handle_script_type_creature_spell,
    #ScriptTypes.SCRIPT_TYPE_GAMEOBJECT: ScriptHandler.handle_script_type_gameobject,
    ScriptTypes.SCRIPT_TYPE_GENERIC: ScriptHandler.handle_script_type_generic,
    #ScriptTypes.SCRIPT_TYPE_GOSSIP: ScriptHandler.handle_script_type_gossip,
    #ScriptTypes.SCRIPT_TYPE_SPELL: ScriptHandler.handle_script_type_spell
}
      
SCRIPT_COMMANDS = {
    ScriptCommands.SCRIPT_COMMAND_TALK: ScriptHandler.handle_script_command_talk,
    ScriptCommands.SCRIPT_COMMAND_EMOTE: ScriptHandler.handle_script_command_emote,
    ScriptCommands.SCRIPT_COMMAND_FIELD_SET: ScriptHandler.handle_script_command_field_set,
    ScriptCommands.SCRIPT_COMMAND_MOVE_TO: ScriptHandler.handle_script_command_move_to,
    ScriptCommands.SCRIPT_COMMAND_MODIFY_FLAGS: ScriptHandler.handle_script_command_modify_flags,
    ScriptCommands.SCRIPT_COMMAND_INTERRUPT_CASTS: ScriptHandler.handle_script_command_interrupt_casts,
    ScriptCommands.SCRIPT_COMMAND_TELEPORT_TO: ScriptHandler.handle_script_command_teleport_to,
    ScriptCommands.SCRIPT_COMMAND_QUEST_EXPLORED: ScriptHandler.handle_script_command_quest_explored,
    ScriptCommands.SCRIPT_COMMAND_KILL_CREDIT: ScriptHandler.handle_script_command_kill_credit,
    ScriptCommands.SCRIPT_COMMAND_RESPAWN_GAMEOBJECT: ScriptHandler.handle_script_command_respawn_gameobject,
    ScriptCommands.SCRIPT_COMMAND_TEMP_SUMMON_CREATURE: ScriptHandler.handle_script_command_temp_summon_creature,
    ScriptCommands.SCRIPT_COMMAND_OPEN_DOOR: ScriptHandler.handle_script_command_open_door,
    ScriptCommands.SCRIPT_COMMAND_CLOSE_DOOR: ScriptHandler.handle_script_command_close_door,
    ScriptCommands.SCRIPT_COMMAND_ACTIVATE_OBJECT: ScriptHandler.handle_script_command_activate_object,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_AURA: ScriptHandler.handle_script_command_remove_aura,
    ScriptCommands.SCRIPT_COMMAND_CAST_SPELL: ScriptHandler.handle_script_command_cast_spell,
    ## ScriptCommands.SCRIPT_COMMAND_PLAY_SOUND: ScriptHandler.handle_script_command_play_sound, opcodes for playing sound not implemented in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_CREATE_ITEM: ScriptHandler.handle_script_command_create_item,
    ScriptCommands.SCRIPT_COMMAND_DESPAWN_CREATURE: ScriptHandler.handle_script_command_despawn_creature,
    ScriptCommands.SCRIPT_COMMAND_SET_EQUIPMENT: ScriptHandler.handle_script_command_set_equipment,
    ScriptCommands.SCRIPT_COMMAND_MOVEMENT: ScriptHandler.handle_script_command_movement,
    ScriptCommands.SCRIPT_COMMAND_SET_ACTIVEOBJECT: ScriptHandler.handle_script_command_set_activeobject,
    ScriptCommands.SCRIPT_COMMAND_SET_FACTION: ScriptHandler.handle_script_command_set_faction,
    ScriptCommands.SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL: ScriptHandler.handle_script_command_morph_to_entry_or_model,
    ScriptCommands.SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL: ScriptHandler.handle_script_command_mount_to_entry_or_model,
    ScriptCommands.SCRIPT_COMMAND_SET_RUN: ScriptHandler.handle_script_command_set_run,
    ScriptCommands.SCRIPT_COMMAND_ATTACK_START: ScriptHandler.handle_script_command_attack_start,
    ScriptCommands.SCRIPT_COMMAND_UPDATE_ENTRY: ScriptHandler.handle_script_command_update_entry,
    ScriptCommands.SCRIPT_COMMAND_STAND_STATE: ScriptHandler.handle_script_command_stand_state,
    ScriptCommands.SCRIPT_COMMAND_MODIFY_THREAT: ScriptHandler.handle_script_command_modify_threat,
    ## ScriptCommands.SCRIPT_COMMAND_SEND_TAXI_PATH: ScriptHandler.handle_script_command_send_taxi_path, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_TERMINATE_SCRIPT: ScriptHandler.handle_script_command_terminate_script,
    ScriptCommands.SCRIPT_COMMAND_TERMINATE_CONDITION: ScriptHandler.handle_script_command_terminate_condition,
    ScriptCommands.SCRIPT_COMMAND_ENTER_EVADE_MODE: ScriptHandler.handle_script_command_enter_evade_mode,
    ScriptCommands.SCRIPT_COMMAND_SET_HOME_POSITION: ScriptHandler.handle_script_command_set_home_position,
    ScriptCommands.SCRIPT_COMMAND_TURN_TO: ScriptHandler.handle_script_command_turn_to,
    ## ScriptCommands.SCRIPT_COMMAND_MEETINGSTONE: ScriptHandler.handle_script_command_meetingstone, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_SET_INST_DATA: ScriptHandler.handle_script_command_set_inst_data,
    ScriptCommands.SCRIPT_COMMAND_SET_INST_DATA64: ScriptHandler.handle_script_command_set_inst_data64,
    ScriptCommands.SCRIPT_COMMAND_START_SCRIPT: ScriptHandler.handle_script_command_start_script,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_ITEM: ScriptHandler.handle_script_command_remove_item,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_OBJECT: ScriptHandler.handle_script_command_remove_object,
    ScriptCommands.SCRIPT_COMMAND_SET_MELEE_ATTACK: ScriptHandler.handle_script_command_set_melee_attack,
    ScriptCommands.SCRIPT_COMMAND_SET_COMBAT_MOVEMENT: ScriptHandler.handle_script_command_set_combat_movement,
    ScriptCommands.SCRIPT_COMMAND_SET_PHASE: ScriptHandler.handle_script_command_set_phase,
    ScriptCommands.SCRIPT_COMMAND_SET_PHASE_RANDOM: ScriptHandler.handle_script_command_set_phase_random,
    ScriptCommands.SCRIPT_COMMAND_SET_PHASE_RANGE: ScriptHandler.handle_script_command_set_phase_range,
    ScriptCommands.SCRIPT_COMMAND_FLEE: ScriptHandler.handle_script_command_flee,
    ScriptCommands.SCRIPT_COMMAND_DEAL_DAMAGE: ScriptHandler.handle_script_command_deal_damage,
    ## ScriptCommands.SCRIPT_COMMAND_ZONE_COMBAT_PULSE: ScriptHandler.handle_script_command_zone_combat_pulse, unused in 0.5.3
    ## ScriptCommands.SCRIPT_COMMAND_CALL_FOR_HELP: ScriptHandler.handle_script_command_call_for_help, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_SET_SHEATH: ScriptHandler.handle_script_command_set_sheath,
    ScriptCommands.SCRIPT_COMMAND_INVINCIBILITY: ScriptHandler.handle_script_command_invincibility,
    ScriptCommands.SCRIPT_COMMAND_GAME_EVENT: ScriptHandler.handle_script_command_game_event,
    ScriptCommands.SCRIPT_COMMAND_SET_SERVER_VARIABLE: ScriptHandler.handle_script_command_set_server_variable,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_GUARDIANS: ScriptHandler.handle_script_command_remove_guardians,
    ScriptCommands.SCRIPT_COMMAND_ADD_SPELL_COOLDOWN: ScriptHandler.handle_script_command_add_spell_cooldown,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_SPELL_COOLDOWN: ScriptHandler.handle_script_command_remove_spell_cooldown,
    ScriptCommands.SCRIPT_COMMAND_SET_REACT_STATE: ScriptHandler.handle_script_command_set_react_state,
    ScriptCommands.SCRIPT_COMMAND_START_WAYPOINTS: ScriptHandler.handle_script_command_start_waypoints,
    ScriptCommands.SCRIPT_COMMAND_START_MAP_EVENT: ScriptHandler.handle_script_command_start_map_event,
    ScriptCommands.SCRIPT_COMMAND_END_MAP_EVENT: ScriptHandler.handle_script_command_end_map_event,
    ScriptCommands.SCRIPT_COMMAND_ADD_MAP_EVENT_TARGET: ScriptHandler.handle_script_command_add_map_event_target,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_MAP_EVENT_TARGET: ScriptHandler.handle_script_command_remove_map_event_target,
    ScriptCommands.SCRIPT_COMMAND_SET_MAP_EVENT_DATA: ScriptHandler.handle_script_command_set_map_event_data,
    ScriptCommands.SCRIPT_COMMAND_SEND_MAP_EVENT: ScriptHandler.handle_script_command_send_map_event,
    ScriptCommands.SCRIPT_COMMAND_SET_DEFAULT_MOVEMENT: ScriptHandler.handle_script_command_set_default_movement,
    ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_FOR_ALL: ScriptHandler.handle_script_command_start_script_for_all,
    ScriptCommands.SCRIPT_COMMAND_EDIT_MAP_EVENT: ScriptHandler.handle_script_command_edit_map_event,
    ScriptCommands.SCRIPT_COMMAND_FAIL_QUEST: ScriptHandler.handle_script_command_fail_quest,
    ScriptCommands.SCRIPT_COMMAND_RESPAWN_CREATURE: ScriptHandler.handle_script_command_respawn_creature,
    ScriptCommands.SCRIPT_COMMAND_ASSIST_UNIT: ScriptHandler.handle_script_command_assist_unit,
    ScriptCommands.SCRIPT_COMMAND_COMBAT_STOP: ScriptHandler.handle_script_command_combat_stop,
    ScriptCommands.SCRIPT_COMMAND_ADD_AURA: ScriptHandler.handle_script_command_add_aura,
    ScriptCommands.SCRIPT_COMMAND_ADD_THREAT: ScriptHandler.handle_script_command_add_threat,
    ScriptCommands.SCRIPT_COMMAND_SUMMON_OBJECT: ScriptHandler.handle_script_command_summon_object,
    ## ScriptCommands.SCRIPT_COMMAND_SET_FLY: ScriptHandler.handle_script_command_set_fly, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_JOIN_CREATURE_GROUP: ScriptHandler.handle_script_command_join_creature_group,
    ScriptCommands.SCRIPT_COMMAND_LEAVE_CREATURE_GROUP: ScriptHandler.handle_script_command_leave_creature_group,
    ScriptCommands.SCRIPT_COMMAND_SET_GO_STATE: ScriptHandler.handle_script_command_set_go_state,
    ScriptCommands.SCRIPT_COMMAND_DESPAWN_GAMEOBJECT: ScriptHandler.handle_script_command_despawn_gameobject,
    ScriptCommands.SCRIPT_COMMAND_QUEST_CREDIT: ScriptHandler.handle_script_command_quest_credit,
    ## ScriptCommands.SCRIPT_COMMAND_SET_GOSSIP_MENU: ScriptHandler.handle_script_command_set_gossip_menu, not implemented in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_SEND_SCRIPT_EVENT: ScriptHandler.handle_script_command_send_script_event,
    ## ScriptCommands.SCRIPT_COMMAND_SET_PVP: ScriptHandler.handle_script_command_set_pvp, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON: ScriptHandler.handle_script_command_reset_door_or_button,
    ScriptCommands.SCRIPT_COMMAND_SET_COMMAND_STATE: ScriptHandler.handle_script_command_set_command_state,
    ScriptCommands.SCRIPT_COMMAND_PLAY_CUSTOM_ANIM: ScriptHandler.handle_script_command_play_custom_anim,
    ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_ON_GROUP: ScriptHandler.handle_script_command_start_script_on_group
}