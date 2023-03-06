from dataclasses import dataclass
import math
import random
import time

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.opcode_handling.handlers.social.ChatHandler import ChatHandler
from utils.TextUtils import GameTextFormatter
from utils.constants import CustomCodes
from utils.constants.MiscCodes import BroadcastMessageType, ChatMsgs, Languages, ScriptTypes, ObjectTypeFlags, \
    ObjectTypeIds
from utils.constants.SpellCodes import SpellSchoolMask, SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, Genders
from utils.constants.ScriptCodes import ModifyFlagsOptions, MoveToCoordinateTypes, TurnToFacingOptions, ScriptCommands, \
    SetHomePositionOptions, CastFlags
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.Logger import Logger
from utils.ConfigManager import config


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

    def get_filtered_dataint(self):
        return list(filter((0).__ne__, [self.dataint, self.dataint2, self.dataint3, self.dataint4]))

    def get_filtered_datalong(self):
        return list(filter((0).__ne__, [self.datalong, self.datalong2, self.datalong3, self.datalong4]))


# noinspection PyMethodMayBeStatic
class ScriptHandler:
    def __init__(self, object_manager):
        self.object = object_manager
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
        self.last_hp_event_id = -1
        self.flee_text = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(1150)

    def handle_script(self, script):
        if script.command in SCRIPT_COMMANDS:
            # noinspection PyArgumentList
            SCRIPT_COMMANDS[script.command](self, script)
        else:
            Logger.warning(f'Unknown script command {script.command}.')

    def enqueue_ai_script(self, source, script, target=None):
        if not script:
            return

        from game.world.managers.objects.script.ScriptManager import ScriptManager
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
            ScriptManager.get_target_by_type(source, target, script.target_type, script.target_param1,
                                             script.target_param2),
            time.time()
        ))

    def set_generic_script(self, source, target, script_id):
        scripts = WorldDatabaseManager.generic_script_get_by_id(script_id)

        for script in scripts:
            self.enqueue_scripts(source, target, ScriptTypes.SCRIPT_TYPE_GENERIC, script.id)

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
            script.delay = random.uniform(self.ooc_spawn_min_delay, self.ooc_spawn_max_delay)

            # Some events have a repeat delay of 0, which means they should not repeat.
            if self.ooc_repeat_min_delay > 0 and self.ooc_repeat_max_delay > 0:
                self.ooc_next = time.time() + script.delay
            else:
                self.ooc_next = None

            self.enqueue_ai_script(self.ooc_target, script)

    def enqueue_scripts(self, source, target, script_type, entry_id):
        if script_type in SCRIPT_TYPES:
            scripts = SCRIPT_TYPES[script_type](entry_id)
        else:
            Logger.warning(f'Unhandled script type {script_type}.')
            return

        if scripts:
            from game.world.managers.objects.script.ScriptManager import ScriptManager
            for script in scripts:
                if script.condition_id > 0:
                    if not ConditionChecker.check_condition(script.condition_id, self.object, target):
                        continue
                self.enqueue_ai_script(source, script, target=target)

    def reset(self):
        self.script_queue.clear()
        self.ooc_scripts = None
        self.ooc_repeat_min_delay = 0
        self.ooc_repeat_max_delay = 0
        self.ooc_next = 0
        self.ooc_target = None
        self.ooc_running = False
        self.last_hp_event_id = -1

    def update(self):
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
        # source = WorldObject
        # target = Unit/None
        # datalong = chat_type (see enum ChatType)
        # dataint = broadcast_text id. dataint2-4 optional for random selected text.
        if not script.source:
            return

        texts = script.get_filtered_dataint()
        if texts:
            text_id = random.choice(texts)
            broadcast_message = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(text_id)
        else:
            Logger.warning(f'ScriptHandler: Broadcast messages for {script.id} not found.')
            return

        if script.source.gender == Genders.GENDER_MALE and broadcast_message.male_text:
            text_to_say = broadcast_message.male_text
        elif script.source.gender == Genders.GENDER_FEMALE and broadcast_message.female_text:
            text_to_say = broadcast_message.female_text
        else:
            text_to_say = broadcast_message.male_text if broadcast_message.male_text else broadcast_message.female_text

        if not text_to_say:
            Logger.warning(f'ScriptHandler: Broadcast message {text_id} has no text to say.')
            return

        # Format text if target is a player.
        if script.target and script.target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            text_to_say = GameTextFormatter.format(script.target, text_to_say)

        chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_SAY
        lang = broadcast_message.language_id
        if broadcast_message.chat_type == BroadcastMessageType.BROADCAST_MSG_YELL:
            chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_YELL
        elif broadcast_message.chat_type == BroadcastMessageType.BROADCAST_MSG_EMOTE:
            chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_EMOTE
            lang = Languages.LANG_UNIVERSAL

        target = script.target.guid if script.target else script.source.guid
        ChatManager.send_monster_emote_message(script.source, target, text_to_say, chat_msg_type, lang,
                                               ChatHandler.get_range_by_type(chat_msg_type))

        # Neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them.
        if broadcast_message.emote_id1 != 0:
            script.source.play_emote(broadcast_message.emote_id1)

    def handle_script_command_emote(self, script):
        # source = Unit
        # datalong1-4 = emote_id
        # dataint = (bool) is_targeted
        if not script.source:
            return

        emotes = script.get_filtered_datalong()
        if emotes:
            script.source.play_emote(random.choice(emotes))

    def handle_script_command_field_set(self, script):
        # source = Object
        # datalong = field_id
        # datalong2 = value
        Logger.debug('ScriptHandler: handle_script_command_field_set not implemented yet')

    def handle_script_command_move_to(self, script):
        # source = Creature
        # target = WorldObject (for datalong > 0)
        # datalong = coordinates_type (see enum eMoveToCoordinateTypes)
        # datalong2 = time
        # datalong3 = movement_options (see enum MoveOptions)
        # datalong4 = eMoveToFlags
        # dataint = path_id
        # x/y/z/o = coordinates
        if not script.source or not script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: handle_script_command_move_to: invalid source (script {script.id}).')
            return

        coordinates_type = script.datalong
        time_ = script.datalong2
        # movement_options = script.datalong3  # Not used for now.
        # move_to_flags = script.datalong4  # Not used for now.
        # path_id = script.dataint  # Not used for now.
        speed = config.Unit.Defaults.walk_speed  # VMaNGOS sets this to zero by default for whatever reason.
        angle = 0
        location = None

        if coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_NORMAL:
            distance = script.source.location.distance(Vector(script.x, script.y, script.z))
            speed = distance / time_ * 0.001 if time_ > 0 else config.Unit.Defaults.walk_speed
            location = Vector(script.x, script.y, script.z)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RELATIVE_TO_TARGET and script.target:
            location = Vector(script.target.location.x + script.x, script.target.location.y + script.y,
                              script.target.location.z + script.z)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_DISTANCE_FROM_TARGET:
            distance = script.x
            angle = script.source.location.o if script.o < 0 else random.uniform(0, 2 * math.pi)
            target_point = script.source.location.get_point_in_radius_and_angle(distance, angle)
            location = Vector(target_point.x, target_point.y, target_point.z)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RANDOM_POINT:
            # Unclear how this works as the data doesn't seem to provide any information about the radius.
            return

        if angle:
            script.source.movement_manager.set_face_angle(angle)
        if location:
            script.source.movement_manager.move_to_point(location, speed)

    def handle_script_command_modify_flags(self, script):
        # source = Object
        # datalong = field_id
        # datalong2 = bitmask
        # datalong3 = eModifyFlagsOptions
        Logger.debug('ScriptHandler: handle_script_command_modify_flags not implemented yet')
        if script.datalong2 == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
            pass
        elif script.datalong2 == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
            pass
        else:
            pass

    def handle_script_command_interrupt_casts(self, script):
        # source = Unit
        # datalong = (bool) with_delayed
        # datalong2 = spell_id (optional)
        Logger.debug('ScriptHandler: handle_script_command_interrupt_casts not implemented yet')

    def handle_script_command_teleport_to(self, script):
        # source = Unit
        # datalong = map_id (only used for players but still required)
        # datalong2 = teleport_options (see enum TeleportToOptions)
        # x/y/z/o = coordinates
        if script.source:
            script.source.teleport(script.datalong, Vector(script.x, script.y, script.z, script.o))

    def handle_script_command_quest_explored(self, script):
        # source = Player (from provided source or target)
        # target = WorldObject (from provided source or target)
        # datalong = quest_id
        # datalong2 = distance or 0
        # datalong3 = (bool) group
        Logger.debug('ScriptHandler: handle_script_command_quest_explored not implemented yet')

    def handle_script_command_kill_credit(self, script):
        # source = Player (from provided source or target)
        # datalong = creature entry
        # datalong2 = bool (0=personal credit, 1=group credit)
        Logger.debug('ScriptHandler: handle_script_command_kill_credit not implemented yet')

    def handle_script_command_respawn_gameobject(self, script):
        # source = Map
        # target = GameObject (from datalong, provided source or target)
        # datalong = db_guid
        # datalong2 = despawn_delay
        Logger.debug('ScriptHandler: handle_script_command_respawn_gameobject not implemented yet')

    def handle_script_command_temp_summon_creature(self, script):
        # source = WorldObject (from provided source or buddy)
        # datalong = creature_entry
        # datalong2 = despawn_delay
        # datalong3 = unique_limit
        # datalong4 = unique_distance
        # dataint = eSummonCreatureFlags
        # dataint2 = script_id
        # dataint3 = attack_target (see enum ScriptTarget)
        # dataint4 = despawn_type (see enum TempSummonType)
        # x/y/z/o = coordinates
        if not script.source:
            return
        
        if script.datalong3:
            units = MapManager.get_surrounding_units_by_location(script.source.location, script.source.map_id,
                                                                 script.source.instance_id, script.datalong4)
            summoned = [unit for unit in units if unit.creature_template.entry == script.datalong]
            if summoned and len(summoned) >= script.datalong3:
                return

        creature_manager = CreatureBuilder.create(script.datalong, Vector(script.x, script.y, script.z, script.o),
                                                  script.source.map_id, script.source.instance_id,
                                                  summoner=None, faction=script.source.faction,
                                                  ttl=script.datalong2 / 1000,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC
                                                  if script.dataint4 > 0
                                                  else CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON)
        if not creature_manager:
            return
        MapManager.spawn_object(world_object_instance=creature_manager)

        # Generic script.
        if script.dataint2:
            self.enqueue_scripts(creature_manager, None, ScriptTypes.SCRIPT_TYPE_GENERIC, script.dataint2)
        # Attack target.
        if script.dataint3:
            from game.world.managers.objects.script.ScriptManager import ScriptManager
            attack_target = ScriptManager.get_target_by_type(script.source, script.target, script.dataint3)
            if attack_target and attack_target.is_alive:
                creature_manager.attack(attack_target)

        # TODO: dataint = flags. Needs an enum and handling.
        # TODO: dataint4 = despawn_type. Not currently supported by CreatureBuilder.create() so this needs to be added.
        #  For now we just use TEMP_SUMMON if dataint4 is not 0 and SUBTYPE_GENERIC if it is.

    def handle_script_command_open_door(self, script):
        # source = GameObject (from datalong, provided source or target)
        # If provided target is BUTTON GameObject, command is run on it too.
        # datalong = db_guid
        # datalong2 = reset_delay
        Logger.debug('ScriptHandler: handle_script_command_open_door not implemented yet')

    def handle_script_command_close_door(self, script):
        # source = GameObject (from datalong, provided source or target)
        # If provided target is BUTTON GameObject, command is run on it too.
        # datalong = db_guid
        # datalong2 = reset_delay
        Logger.debug('ScriptHandler: handle_script_command_close_door not implemented yet')

    def handle_script_command_activate_object(self, script):
        # source = GameObject
        # target = Unit
        Logger.debug('ScriptHandler: handle_script_command_activate_object not implemented yet')

    def handle_script_command_remove_aura(self, script):
        # source = Unit
        # datalong = spell_id
        if script.source and script.source.aura_manager:
            script.source.aura_manager.cancel_auras_by_spell_id(script.datalong)
        else:
            Logger.warning('ScriptHandler: No aura manager found, aborting SCRIPT_COMMAND_REMOVE_AURA')

    def handle_script_command_cast_spell(self, script):
        # source = Unit
        # target = Unit
        # datalong = spell_id
        # datalong2 = eCastSpellFlags
        if script.source and script.source.spell_manager:
            spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(script.datalong)
            if not spell_entry:
                return

            target = script.target if script.target else script.source
            target_mask = SpellTargetMask.UNIT if script.target else SpellTargetMask.SELF
            if spell_entry.Targets & SpellTargetMask.CAN_TARGET_TERRAIN:
                target = target.location
                target_mask = SpellTargetMask.DEST_LOCATION

            spell = script.source.spell_manager.try_initialize_spell(spell_entry, target, target_mask, validate=False)
            if script.datalong2 & CastFlags.CF_TRIGGERED:
                spell.force_instant_cast()

            script.source.spell_manager.start_spell_cast(initialized_spell=spell)
        else:
            Logger.warning('ScriptHandler: No spell manager found, aborting SCRIPT_COMMAND_CAST_SPELL')

    def handle_script_command_create_item(self, script):
        # source = Player (from provided source or target)
        # datalong = item_id
        # datalong2 = amount
        if script.source and script.source.inventory:
            script.source.inventory.add_item(script.datalong, script.datalong2)
        else:
            Logger.warning('ScriptHandler: No inventory found, aborting SCRIPT_COMMAND_CREATE_ITEM')

    def handle_script_command_despawn_creature(self, script):
        # source = Creature
        # datalong = despawn_delay
        if script.source and script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT and script.source.is_alive:
            script.source.destroy()
        else:
            Logger.warning('ScriptHandler: No valid source found or source is dead, '
                           'aborting SCRIPT_COMMAND_DESPAWN_CREATURE')

    def handle_script_command_set_equipment(self, script):
        # source = Creature
        # datalong = (bool) reset_default
        # dataint = main-hand item_id
        # dataint2 = off-hand item_id
        # dataint3 = ranged item_id
        if not script.source or not script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_EQUIPMENT')
            return

        if script.datalong == 1:
            script.source.reset_virtual_equipment()
        else:
            if script.dataint > 0:
                script.source.set_virtual_equipment(0, script.dataint)
            if script.dataint2 > 0:
                script.source.set_virtual_equipment(1, script.dataint2)
            if script.dataint3 > 0:
                script.source.set_virtual_equipment(2, script.dataint3)

    def handle_script_command_movement(self, script):
        # source = Creature
        # datalong = see enum MovementGeneratorType (not all are supported)
        # datalong2 = bool_param (meaning depends on the motion type)
        # datalong3 = int_param (meaning depends on the motion type)
        # datalong4 = (bool) clear
        # x = distance (only for some motion types)
        # o = angle (only for some motion types)
        if not script.source:
            Logger.warning('ScriptHandler: No source found, aborting SCRIPT_COMMAND_MOVEMENT')
            return
        script.source.movement_manager.move_waypoints_from_script()

    def handle_script_command_set_activeobject(self, script):
        # source = Creature
        # datalong = (bool) 0=off, 1=on
        Logger.debug('ScriptHandler: handle_script_command_set_activeobject not implemented yet')

    def handle_script_command_set_faction(self, script):
        # source = Creature
        # datalong = faction_Id,
        # datalong2 = see enum TemporaryFactionFlags
        if not script.source or not script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_FACTION')
            return
        if not script.datalong:
            script.source.reset_faction()
        else:
            script.source.set_faction(script.datalong)

    def handle_script_command_morph_to_entry_or_model(self, script):
        # source = Unit
        # datalong = creature_id/display_id (depend on datalong2)
        # datalong2 = (bool) is_display_id
        if not script.source or not script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL')
            return

        if not script.source.is_alive:
            return

        creature_or_model_entry = script.datalong
        display_id = script.datalong2

        if not creature_or_model_entry:
            script.source.reset_display_id()
        elif display_id:
            script.source.set_display_id(display_id)
        else:
            creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
                creature_or_model_entry)
            if creature_template:
                script.source.set_display_id(creature_template.display_id)
            else:
                Logger.warning('ScriptHandler: No creature template found, SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL')

    def handle_script_command_mount_to_entry_or_model(self, script):
        # source = Creature
        # datalong = creature_id/display_id (depend on datalong2)
        # datalong2 = (bool) is_display_id
        # datalong3 = (bool) permanent
        if not script.source or not script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning('ScriptHandler: No creature manager found, SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL')
            return

        if not script.source.is_alive:
            return

        display_id = script.datalong2
        creature_or_model_entry = script.datalong

        if not creature_or_model_entry and not display_id:
            if script.source.creature_template.mount_display_id:
                script.source.mount(display_id)
            else:
                script.source.unmount()
        elif creature_or_model_entry:
            creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
                creature_or_model_entry)
            if creature_template and creature_template.display_id:
                script.source.mount(creature_template.display_id)
            else:
                script.source.unmount()

    def handle_script_command_set_run(self, script):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not script.source or not script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning('ScriptHandler: No creature manager found, SCRIPT_COMMAND_SET_RUN')
            return

        script.source.change_speed(
            script.source.creature_template.speed_run if script.datalong == 1 else
            script.source.creature_template.speed_walk)

    def handle_script_command_attack_start(self, script):
        # source = Creature
        # target = Player
        if not script.source:
            Logger.warning('ScriptHandler: Invalid attacker, SCRIPT_COMMAND_ATTACK_START')
            return

        attacker = script.source
        victim = script.target

        if victim and victim.is_alive:
            attacker.attack(victim)
        else:
            Logger.warning('ScriptHandler: Unable to resolve target, SCRIPT_COMMAND_ATTACK_START')

    def handle_script_command_update_entry(self, script):
        # source = Creature
        # datalong = creature_entry
        Logger.debug('ScriptHandler: handle_script_command_update_entry not implemented yet')

    def handle_script_command_stand_state(self, script):
        # source = Unit
        # datalong = stand_state (enum UnitStandStateType)
        if script.source and script.source.is_alive:
            script.source.set_stand_state(script.datalong)
        else:
            Logger.warning('ScriptHandler: No source found or source is dead, aborting SCRIPT_COMMAND_STAND_STATE')

    def handle_script_command_modify_threat(self, script):
        # source = Creature
        # datalong = eModifyThreatTargets
        # x = percent
        Logger.debug('ScriptHandler: handle_script_command_modify_threat not implemented yet')

    def handle_script_command_terminate_script(self, script):
        # source = Any
        # datalong = creature_entry
        # datalong2 = search_distance
        # datalong3 = eTerminateScriptOptions
        Logger.debug('ScriptHandler: handle_script_command_terminate_script not implemented yet')

    def handle_script_command_terminate_condition(self, script):
        # source = Any
        # datalong = condition_id
        # datalong2 = failed_quest_id
        # datalong3 = eTerminateConditionFlags
        Logger.debug('ScriptHandler: handle_script_command_terminate_condition not implemented yet')

    def handle_script_command_enter_evade_mode(self, script):
        # source = Creature
        if script.source and script.source.object_ai:
            script.source.leave_combat()
        else:
            Logger.warning('ScriptHandler: Invalid target, aborting SCRIPT_COMMAND_ENTER_EVADE_MODE')

    def handle_script_command_set_home_position(self, script):
        # source = Creature
        # datalong = eSetHomePositionOptions
        # x/y/z/o = coordinates

        # All other SetHomePositionOptions are not valid for 0.5.3.
        if script.source and script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            if script.datalong == SetHomePositionOptions.SET_HOME_DEFAULT_POSITION:
                if script.source.spawn_id:
                    spawn = WorldDatabaseManager.creature_spawn_get_by_spawn_id(script.source.spawn_id)
                    script.source.spawn_position = Vector(spawn.position_x, spawn.position_y,
                                                          spawn.position_y, spawn.orientation)
                    # TODO: actually move the creature to the spawn position.
        else:
            Logger.warning('ScriptHandler: No creature manager found, aborting SCRIPT_COMMAND_SET_HOME_POSITION')

    def handle_script_command_turn_to(self, script):
        # source = Unit
        # target = WorldObject
        # datalong = eTurnToFacingOptions
        if not script.source:
            return

        if script.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
            script.source.movement_manager.send_face_target(script.player_mgr)
        else:
            script.source.movement_manager.send_face_angle(script.o)

    def handle_script_command_set_inst_data(self, script):
        # source = Map
        # datalong = field
        # datalong2 = data
        # datalong3 = eSetInstDataOptions
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data not implemented yet')

    def handle_script_command_set_inst_data64(self, script):
        # source = Map
        # target = Object (when saving guid)
        # datalong = field
        # datalong2 = data
        # datalong3 = eSetInstData64Options
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data64 not implemented yet')

    def handle_script_command_start_script(self, script):
        # source = Map
        # datalong1-4 = event_script id
        # dataint1-4 = chance (total cant be above 100)
        scripts = []  # datalong to datalong4.
        weights = ()  # dataint to dataint4.

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

    def handle_script_command_remove_item(self, script):
        # source = Player (from provided source or target)
        # datalong = item_id
        # datalong2 = amount
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
        # source = GameObject
        # target = Unit
        Logger.debug('ScriptHandler: handle_script_command_remove_object not implemented yet')

    def handle_script_command_set_melee_attack(self, script):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if script.source and script.source.is_alive:
            pass
            # TODO: This command enables or disables melee combat.
        else:
            Logger.warning(f'ScriptHandler: Invalid source (script {script.id})'
                           f', aborting SCRIPT_COMMAND_SET_MELEE_ATTACK.')

    def handle_script_command_set_combat_movement(self, script):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        Logger.debug('ScriptHandler: handle_script_command_set_combat_movement not implemented yet')

    def handle_script_command_set_phase(self, script):
        # source = Creature
        # datalong = phase
        # datalong2 = eSetPhaseOptions
        Logger.debug('ScriptHandler: handle_script_command_set_phase not implemented yet')

    def handle_script_command_set_phase_random(self, script):
        # source = Creature
        # datalong1-4 = phase
        Logger.debug('ScriptHandler: handle_script_command_set_phase_random not implemented yet')

    def handle_script_command_set_phase_range(self, script):
        # source = Creature
        # datalong = phase_min
        # datalong2 = phase_max
        Logger.debug('ScriptHandler: handle_script_command_set_phase_range not implemented yet')

    def handle_script_command_flee(self, script):
        # source = Creature
        # datalong = seek_assistance (bool) 0 = off, 1 = on
        if script.source and script.source.is_alive:
            script.source.set_unit_flag(UnitFlags.UNIT_FLAG_FLEEING, True)
            ChatManager.send_monster_emote_message(script.source, script.source.guid, self.flee_text.male_text,
                                                   ChatMsgs.CHAT_MSG_MONSTER_EMOTE, Languages.LANG_UNIVERSAL,
                                                   ChatHandler.get_range_by_type(ChatMsgs.CHAT_MSG_MONSTER_EMOTE))

            if script.source.spell_manager:
                script.source.spell_manager.remove_casts(remove_active=False)
            script.source.movement_manager.move_fear(7)  # Flee for 7 seconds.
        else:
            Logger.warning('ScriptHandler: No source or source is dead, aborting SCRIPT_COMMAND_FLEE')

    def handle_script_command_deal_damage(self, script):
        # source = Unit
        # target = Unit
        # datalong = damage
        # datalong2 = (bool) is_percent
        if script.source and script.target:
            if script.datalong2 == 1:
                # Damage is a percentage of the target's health.
                damage_to_deal = int(script.target.health * (script.datalong / 100))
            else:
                damage_to_deal = script.datalong

            if damage_to_deal > 0:
                attacker = script.source if script.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT else None
                damage_info = DamageInfoHolder(attacker=attacker, target=script.target, total_damage=damage_to_deal,
                                               damage_school_mask=SpellSchoolMask.SPELL_SCHOOL_MASK_NORMAL)
                script.source.deal_damage(script.target, damage_info)
            else:
                Logger.warning('ScriptHandler: SCRIPT_COMMAND_DEAL_DAMAGE attempted to deal 0 damage')
        else:
            Logger.warning('ScriptHandler: SCRIPT_COMMAND_DEAL_DAMAGE attempted to run with no source or target')

    def handle_script_command_set_sheath(self, script):
        # source = Unit
        # datalong = see enum SheathState
        if script.source:
            script.source.set_weapon_mode(script.datalong)

    def handle_script_command_invincibility(self, script):
        # source = Creature
        # datalong = health
        # datalong2 = (bool) is_percent
        if not script.source:
            return

        # TODO: HP should be locked according to data - see VMaNGOS.
        script.source.set_unit_flag(UnitFlags.UNIT_MASK_NON_ATTACKABLE, remove=script.datalong == 0)

    def handle_script_command_game_event(self, script):
        # source = None
        # datalong = event_id
        # datalong2 = (bool) start
        # datalong3 = (bool) overwrite
        Logger.debug('ScriptHandler: handle_script_command_game_event not implemented yet')

    def handle_script_command_set_server_variable(self, script):
        # source = None
        # datalong = index
        # datalong2 = value
        Logger.debug('ScriptHandler: handle_script_command_set_server_variable not implemented yet')

    def handle_script_command_remove_guardians(self, script):
        # source = Unit
        # datalong = creature_id
        Logger.debug('ScriptHandler: handle_script_command_remove_guardians not implemented yet')

    def handle_script_command_add_spell_cooldown(self, script):
        # source = Unit
        # datalong = spell_id
        # datalong2 = cooldown
        Logger.debug('ScriptHandler: handle_script_command_add_spell_cooldown not implemented yet')

    def handle_script_command_remove_spell_cooldown(self, script):
        # source = Unit
        # datalong = spell_id
        Logger.debug('ScriptHandler: handle_script_command_remove_spell_cooldown not implemented yet')

    def handle_script_command_set_react_state(self, script):
        # source = Creature
        # datalong = see enum ReactStates
        Logger.debug('ScriptHandler: handle_script_command_set_react_state not implemented yet')

    def handle_script_command_start_waypoints(self, script):
        # source = Creature
        # datalong = waypoints_source
        # datalong2 = start_point
        # datalong3 = initial_delay
        # datalong4 = (bool) repeat
        # dataint = overwrite_guid
        # dataint2 = overwrite_entry
        Logger.debug('ScriptHandler: handle_script_command_start_waypoints not implemented yet')

    def handle_script_command_start_map_event(self, script):
        # source = Map
        # datalong = event_id
        # datalong2 = time_limit
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        Logger.debug('ScriptHandler: handle_script_command_start_map_event not implemented yet')

    def handle_script_command_end_map_event(self, script):
        # source = Map
        # datalong = event_id
        # datalong2 = (bool) success
        Logger.debug('ScriptHandler: handle_script_command_end_map_event not implemented yet')

    def handle_script_command_add_map_event_target(self, script):
        # source = Map
        # target = WorldObject
        # datalong = event_id
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        Logger.debug('ScriptHandler: handle_script_command_add_map_event_target not implemented yet')

    def handle_script_command_remove_map_event_target(self, script):
        # source = Map
        # target = WorldObject
        # datalong = event_id
        # datalong2 = condition_id
        # datalong3 = eRemoveMapEventTargetOptions
        Logger.debug('ScriptHandler: handle_script_command_remove_map_event_target not implemented yet')

    def handle_script_command_set_map_event_data(self, script):
        # source = Map
        # datalong = event_id
        # datalong2 = index
        # datalong3 = data
        # datalong4 = eSetMapScriptDataOptions
        Logger.debug('ScriptHandler: handle_script_command_set_map_event_data not implemented yet')

    def handle_script_command_send_map_event(self, script):
        # source = Map
        # datalong = event_id
        # datalong2 = data
        # datalong3 = eSendMapEventOptions
        Logger.debug('ScriptHandler: handle_script_command_send_map_event not implemented yet')

    def handle_script_command_set_default_movement(self, script):
        # source = Creature
        # datalong = movement_type
        # datalong2 = (bool) always_replace
        # datalong3 = param1
        Logger.debug('ScriptHandler: handle_script_command_set_default_movement not implemented yet')

    def handle_script_command_start_script_for_all(self, script):
        # source = WorldObject
        # datalong = script_id
        # datalong2 = eStartScriptForAllOptions
        # datalong3 = object_entry
        # datalong4 = search_radius
        Logger.debug('ScriptHandler: handle_script_command_start_script_for_all not implemented yet')

    def handle_script_command_edit_map_event(self, script):
        # source = Map
        # datalong = event_id
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        Logger.debug('ScriptHandler: handle_script_command_edit_map_event not implemented yet')

    def handle_script_command_fail_quest(self, script):
        # source = Player
        # datalong = quest_id
        Logger.debug('ScriptHandler: handle_script_command_fail_quest not implemented yet')

    def handle_script_command_respawn_creature(self, script):
        # source = Creature
        # datalong = (bool) even_if_alive
        Logger.debug('ScriptHandler: handle_script_command_respawn_creature not implemented yet')

    def handle_script_command_assist_unit(self, script):
        # source = Creature
        # target = Unit
        Logger.debug('ScriptHandler: handle_script_command_assist_unit not implemented yet')

    def handle_script_command_combat_stop(self, script):
        # source = Unit
        Logger.debug('ScriptHandler: handle_script_command_combat_stop not implemented yet')

    def handle_script_command_add_aura(self, script):
        # source = Unit
        # datalong = spell_id
        # datalong2 = flags
        Logger.debug('ScriptHandler: handle_script_command_add_aura not implemented yet')

    def handle_script_command_add_threat(self, script):
        # source = Creature
        # target = Unit
        if script.source and script.target:
            if script.source.is_alive and script.source.in_combat:
                script.source.threat_manager.add_threat(script.target)
            else:
                Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT: source is not in combat')
        else:
            Logger.warning('ScriptHandler: SCRIPT_COMMAND_ADD_THREAT: invalid target')

    def handle_script_command_summon_object(self, script):
        # source = WorldObject
        # datalong = gameobject_entry
        # datalong2 = respawn_time
        # x/y/z/o = coordinates
        Logger.debug('ScriptHandler: handle_script_command_summon_object not implemented yet')

    def handle_script_command_join_creature_group(self, script):
        # source = Creature
        # target = Creature
        # datalong = OptionFlags
        # x = distance
        # o = angle
        Logger.debug('ScriptHandler: handle_script_command_join_creature_group not implemented yet')

    def handle_script_command_leave_creature_group(self, script):
        # source = Creature
        Logger.debug('ScriptHandler: handle_script_command_leave_creature_group not implemented yet')

    def handle_script_command_set_go_state(self, script):
        # source = GameObject
        # datalong = GOState
        Logger.debug('ScriptHandler: handle_script_command_set_go_state not implemented yet')

    def handle_script_command_despawn_gameobject(self, script):
        # source = GameObject (from datalong, provided source or target)
        # datalong = db_guid
        # datalong2 = despawn_delay
        Logger.debug('ScriptHandler: handle_script_command_despawn_gameobject not implemented yet')

    def handle_script_command_quest_credit(self, script):
        # source = Player (from provided source or target)
        # target = WorldObject (from provided source or target)
        Logger.debug('ScriptHandler: handle_script_command_quest_credit not implemented yet')

    def handle_script_command_send_script_event(self, script):
        # source = Creature
        # target = WorldObject
        # datalong = event_id
        # datalong2 = event_data
        Logger.debug('ScriptHandler: handle_script_command_send_script_event not implemented yet')

    def handle_script_command_reset_door_or_button(self, script):
        # source = GameObject
        Logger.debug('ScriptHandler: handle_script_command_reset_door_or_button not implemented yet')

    def handle_script_command_set_command_state(self, script):
        # source = Creature
        # datalong = command_state (see enum CommandStates)
        Logger.debug('ScriptHandler: handle_script_command_set_command_state not implemented yet')

    def handle_script_command_play_custom_anim(self, script):
        # source = GameObject
        # datalong = anim_id
        Logger.debug('ScriptHandler: handle_script_command_play_custom_anim not implemented yet')

    def handle_script_command_start_script_on_group(self, script):
        # source = Unit
        # datalong1-4 = generic_script id
        # dataint1-4 = chance (total cant be above 100)
        Logger.debug('ScriptHandler: handle_script_command_start_script_on_group not implemented yet')

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
    # ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT: ScriptHandler.handle_script_type_creature_movement,
    # ScriptTypes.SCRIPT_TYPE_CREATURE_SPELL: ScriptHandler.handle_script_type_creature_spell,
    # ScriptTypes.SCRIPT_TYPE_GAMEOBJECT: ScriptHandler.handle_script_type_gameobject,
    ScriptTypes.SCRIPT_TYPE_GENERIC: ScriptHandler.handle_script_type_generic,
    # ScriptTypes.SCRIPT_TYPE_GOSSIP: ScriptHandler.handle_script_type_gossip,
    # ScriptTypes.SCRIPT_TYPE_SPELL: ScriptHandler.handle_script_type_spell
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
    # ScriptCommands.SCRIPT_COMMAND_PLAY_SOUND: ScriptHandler.handle_script_command_play_sound, opcodes for playing sound not implemented in 0.5.3
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
    # ScriptCommands.SCRIPT_COMMAND_SEND_TAXI_PATH: ScriptHandler.handle_script_command_send_taxi_path, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_TERMINATE_SCRIPT: ScriptHandler.handle_script_command_terminate_script,
    ScriptCommands.SCRIPT_COMMAND_TERMINATE_CONDITION: ScriptHandler.handle_script_command_terminate_condition,
    ScriptCommands.SCRIPT_COMMAND_ENTER_EVADE_MODE: ScriptHandler.handle_script_command_enter_evade_mode,
    ScriptCommands.SCRIPT_COMMAND_SET_HOME_POSITION: ScriptHandler.handle_script_command_set_home_position,
    ScriptCommands.SCRIPT_COMMAND_TURN_TO: ScriptHandler.handle_script_command_turn_to,
    # ScriptCommands.SCRIPT_COMMAND_MEETINGSTONE: ScriptHandler.handle_script_command_meetingstone, unused in 0.5.3
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
    # ScriptCommands.SCRIPT_COMMAND_ZONE_COMBAT_PULSE: ScriptHandler.handle_script_command_zone_combat_pulse, unused in 0.5.3
    # ScriptCommands.SCRIPT_COMMAND_CALL_FOR_HELP: ScriptHandler.handle_script_command_call_for_help, unused in 0.5.3
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
    # ScriptCommands.SCRIPT_COMMAND_SET_FLY: ScriptHandler.handle_script_command_set_fly, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_JOIN_CREATURE_GROUP: ScriptHandler.handle_script_command_join_creature_group,
    ScriptCommands.SCRIPT_COMMAND_LEAVE_CREATURE_GROUP: ScriptHandler.handle_script_command_leave_creature_group,
    ScriptCommands.SCRIPT_COMMAND_SET_GO_STATE: ScriptHandler.handle_script_command_set_go_state,
    ScriptCommands.SCRIPT_COMMAND_DESPAWN_GAMEOBJECT: ScriptHandler.handle_script_command_despawn_gameobject,
    ScriptCommands.SCRIPT_COMMAND_QUEST_CREDIT: ScriptHandler.handle_script_command_quest_credit,
    # ScriptCommands.SCRIPT_COMMAND_SET_GOSSIP_MENU: ScriptHandler.handle_script_command_set_gossip_menu, not implemented in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_SEND_SCRIPT_EVENT: ScriptHandler.handle_script_command_send_script_event,
    # ScriptCommands.SCRIPT_COMMAND_SET_PVP: ScriptHandler.handle_script_command_set_pvp, unused in 0.5.3
    ScriptCommands.SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON: ScriptHandler.handle_script_command_reset_door_or_button,
    ScriptCommands.SCRIPT_COMMAND_SET_COMMAND_STATE: ScriptHandler.handle_script_command_set_command_state,
    ScriptCommands.SCRIPT_COMMAND_PLAY_CUSTOM_ANIM: ScriptHandler.handle_script_command_play_custom_anim,
    ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_ON_GROUP: ScriptHandler.handle_script_command_start_script_on_group
}
