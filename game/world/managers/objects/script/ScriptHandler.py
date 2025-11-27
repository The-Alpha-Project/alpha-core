import random
import time

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import CreatureGroup
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.gameobjects.managers.ButtonManager import ButtonManager
from game.world.managers.objects.gameobjects.managers.DoorManager import DoorManager
from game.world.managers.objects.gameobjects.managers.GooberManager import GooberManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.script.Script import Script
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from game.world.managers.objects.script.ScriptManager import ScriptManager
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
from game.world.managers.objects.units.creature.groups.CreatureGroupManager import CreatureGroupManager
from game.world.managers.objects.units.movement.helpers.CommandMoveInfo import CommandMoveInfo
from game.world.managers.objects.units.movement.helpers.SplineEvent import SplineRestoreOrientationEvent, \
    SplineTargetedEmoteEvent
from game.world.opcode_handling.handlers.social.ChatHandler import ChatHandler
from utils.constants import CustomCodes
from utils.constants.MiscCodes import BroadcastMessageType, ChatMsgs, Languages, ScriptTypes, \
    GameObjectTypes, GameObjectStates, NpcFlags, MoveFlags, MotionTypes, TempSummonType, SummonCreatureFlags
from utils.constants.SpellCodes import SpellSchoolMask, SpellTargetMask, SpellCheckCastResult
from utils.constants.UnitCodes import UnitFlags, Genders, CreatureReactStates
from utils.constants.ScriptCodes import ModifyFlagsOptions, MoveToCoordinateTypes, TurnToFacingOptions, \
    ScriptCommands, SetHomePositionOptions, CastFlags, SetPhaseOptions, TerminateConditionFlags, WaypointPathOrigin, \
    ScriptTarget
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.Logger import Logger
from collections import namedtuple
from utils.ConfigManager import config
from utils.constants.UpdateFields import GameObjectFields, UnitFields, PlayerFields

MAX_3368_SPELL_ID = 7913


class ScriptHandler:

    def __init__(self, map_):
        self.map = map_
        self.scripts_set = set()
        self.forced_event_ids = set()

    def enqueue_script(self, source, target, script_type, script_id, delay=0.0, event=None):
        # Grab start script command(s).
        script_commands = self.resolve_script_actions(script_type, script_id)
        if not script_commands:
            Logger.warning(f'Script [{script_id}] not found, '
                            f'Event: {event.get_event_info() if event else "None"}, '
                            f'Caller: {source.get_name()}')
            return

        if event:
            Logger.script(f'Id [{script_id}] [{source.get_name()}] Event [{event.get_event_info()}]')
        else:
            Logger.script(f'Id [{script_id}] [{source.get_name()}] Type [{ScriptTypes(script_type).name}]')

        script_commands.sort(key=lambda command: command.delay)
        new_script = Script(script_id, script_commands, source, target, self, delay=delay, event=event)

        # If no delay, update right away.
        if not delay:
            new_script.update(time.time())
            if not new_script.is_complete():
                self.scripts_set.add(new_script)
        else:
            self.scripts_set.add(new_script)

    # noinspection PyMethodMayBeStatic
    def handle_script_command_execution(self, script_command):
        try:
            return SCRIPT_COMMANDS[script_command.command](script_command)
        except KeyError:
            Logger.warning(f'Unknown script command: {script_command.command}.')
            return True  # Abort.

    # noinspection PyMethodMayBeStatic
    def resolve_script_actions(self, script_type, script_id):
        try:
            return SCRIPT_TYPES[script_type](script_id)
        except KeyError:
            Logger.warning(f'Unsupported script command type: {ScriptCommands(script_type).name}.')
            return None

    def reset(self):
        self.scripts_set.clear()

    def update(self, now):
        # Update scripts, each one can contain multiple script actions.
        for script in list(self.scripts_set):
            # Check if there is a forced event trigger.
            if self.forced_event_ids and script.event.id in self.forced_event_ids:
                Logger.debug(f'Event {script.event.get_event_info()}  unlocked by request.')
                script.delay = 0
                self.forced_event_ids.discard(script.event.id)
            # Update/Run script.
            script.update(now)
            if not script.is_complete():
                continue
            # Finished all actions, remove.
            if script in self.scripts_set:
                self.scripts_set.remove(script)

    # Handlers

    @staticmethod
    def handle_script_command_start_script(command):
        # source = Map
        # datalong1-4 = event_script id
        # dataint1-4 = chance (total cant be above 100)
        scripts = [datalong for datalong in ScriptHelpers.get_filtered_datalong(command)]
        weights = [dataint for dataint in ScriptHelpers.get_filtered_dataint(command)]
        script_id = random.choices(scripts, cum_weights=weights, k=1)[0]
        command.source.get_map().enqueue_script(source=command.source, target=command.target,
                                                script_type=ScriptTypes.SCRIPT_TYPE_GENERIC, script_id=script_id)
        return False

    @staticmethod
    def handle_script_command_talk(command):
        # source = WorldObject
        # target = Unit/None
        # datalong = chat_type (see enum ChatType)
        # dataint = broadcast_text id. dataint2-4 optional for random selected text.
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()

        texts = ScriptHelpers.get_filtered_dataint(command)
        if texts:
            text_id = random.choice(texts)
            broadcast_message = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(text_id)
        else:
            Logger.warning(f'ScriptHandler: Broadcast messages for {command.get_info()}, not found.')
            return command.should_abort()

        if not command.source.is_unit():
            Logger.warning(f'ScriptHandler: Wrong target type, {command.get_info()}.')
            return command.should_abort()

        if command.source.gender == Genders.GENDER_MALE and broadcast_message.male_text:
            text_to_say = broadcast_message.male_text
        elif command.source.gender == Genders.GENDER_FEMALE and broadcast_message.female_text:
            text_to_say = broadcast_message.female_text
        else:
            text_to_say = broadcast_message.male_text if broadcast_message.male_text else broadcast_message.female_text

        if not text_to_say:
            Logger.warning(f'ScriptHandler: Broadcast message {text_id} has no text to say.')
            return command.should_abort()

        chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_SAY

        # Chat type override.
        if command.datalong:
            chat_type = command.datalong
        else:
            chat_type = broadcast_message.chat_type

        lang = broadcast_message.language_id
        if chat_type == BroadcastMessageType.BROADCAST_MSG_YELL:
            chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_YELL
        elif chat_type == BroadcastMessageType.BROADCAST_MSG_EMOTE:
            chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_EMOTE
            lang = Languages.LANG_UNIVERSAL

        ChatManager.send_monster_message(command.source, text_to_say, chat_msg_type, lang,
                                         ChatHandler.get_range_by_type(chat_msg_type), command.target)

        # Neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them.
        if broadcast_message.emote_id1 != 0:
            command.source.play_emote(broadcast_message.emote_id1)

        return False

    @staticmethod
    def handle_script_command_emote(command):
        # source = Unit
        # datalong1-4 = emote_id
        # dataint = (bool) is_targeted
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()
        # Abort if target is in combat, or already doing a targeted emote.
        if command.source.in_combat or command.source.movement_manager.has_spline_events():
            return command.should_abort()
        emotes = ScriptHelpers.get_filtered_datalong(command)
        if not emotes and not command.dataint:
            return command.should_abort()

        emote = random.choice(emotes) if emotes else 0

        # Targeted emote.
        if command.dataint and command.target:
            # Pause ooc if needed.
            command.source.object_ai.player_interacted()
            emote_event = SplineTargetedEmoteEvent(command.source, command.target, start_seconds=2, emote=emote)
            reset_orientation_event = SplineRestoreOrientationEvent(command.source, start_seconds=6)
            command.source.movement_manager.add_spline_events([emote_event, reset_orientation_event])
        else:
            command.source.play_emote(emote)

        return False

    @staticmethod
    def handle_script_command_field_set(command):
        # source = Object
        # datalong = field_id
        # datalong2 = value
        Logger.debug('ScriptHandler: handle_script_command_field_set not implemented yet')

        return command.should_abort()

    @staticmethod
    def handle_script_command_move_to(command):
        # source = Creature
        # target = WorldObject (for datalong > 0)
        # datalong = coordinates_type (see enum eMoveToCoordinateTypes)
        # datalong2 = time
        # datalong3 = movement_options (see enum MoveOptions)
        # datalong4 = eMoveToFlags
        # dataint = path_id
        # x/y/z/o = coordinates
        if not command.source or not command.source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        coordinates_type = command.datalong
        time_ = command.datalong2
        # movement_options = script.datalong3  # Not used for now.
        # move_to_flags = script.datalong4  # Not used for now.
        # path_id = script.dataint  # Not used for now.
        location = None

        if coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_NORMAL:
            location = Vector(command.x, command.y, command.z, command.o)
        # Coordinates are added to those of the target.
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RELATIVE_TO_TARGET:
            if not command.target or not command.target.is_object(by_mask=True):
                return command.should_abort()
            location = Vector(command.target.location.x + command.x, command.target.location.y + command.y,
                              command.target.location.z + command.z, command.o)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_DISTANCE_FROM_TARGET:
            if not command.target or not command.target.is_object(by_mask=True):
                return command.should_abort()
            o = command.o if command.o else command.target.location.get_angle_towards_vector(command.source.location)
            target_point = command.target.location.get_point_in_radius_and_angle(command.x, o)
            location = Vector(target_point.x, target_point.y, target_point.z, command.o)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RANDOM_POINT:
            location = command.source.location.get_random_point_in_radius(command.o, command.source.map_id)

        if location:
            distance = command.source.location.distance(location)
            speed = round((distance / (time_ * 0.001) if time_ > 0 else config.Unit.Defaults.walk_speed), 4)
            command.source.movement_manager.move_to_point(location, speed, command.datalong3)
        else:
            return command.should_abort()

        return False

    @staticmethod
    def handle_script_command_modify_flags(command):
        # source = Object
        # datalong = field_id
        # datalong2 = raw bitmask
        # datalong3 = ModifyFlagsOptions
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()

        # enum UpdateFields5875
        # {
        #     FIELD_GAMEOBJECT_FLAGS           = 9,
        #     FIELD_GAMEOBJECT_DYN_FLAGS       = 19,
        #     FIELD_ITEM_FIELD_FLAGS           = 21,
        #     FIELD_CORPSE_FIELD_FLAGS         = 35,
        #     FIELD_CORPSE_FIELD_DYNAMIC_FLAGS = 36,
        #     FIELD_UNIT_FIELD_FLAGS           = 46,
        #     FIELD_UNIT_DYNAMIC_FLAGS         = 143,
        #     FIELD_UNIT_NPC_FLAGS             = 147,
        #     FIELD_PLAYER_FLAGS               = 190,
        # };

        # Data helper.
        FlagEquivalence = namedtuple('FlagEquivalence', ['field', 'flags', 'modify'])
        # Initialize an empty dictionary.
        flag_equivalences_5875_to_3368: dict[int, FlagEquivalence] = {}

        # Add entries conditionally based on the source type.
        if command.source.is_gameobject():
            flag_equivalences_5875_to_3368[9] = FlagEquivalence(
                GameObjectFields.GAMEOBJECT_FLAGS,
                command.source.flags,
                command.source.set_uint32
            )
            flag_equivalences_5875_to_3368[19] = FlagEquivalence(
                GameObjectFields.GAMEOBJECT_DYN_FLAGS,
                command.source.flags,
                command.source.set_uint32
            )

        if command.source.is_unit():
            flag_equivalences_5875_to_3368[46] = FlagEquivalence(
                UnitFields.UNIT_FIELD_FLAGS,
                command.source.unit_flags,
                command.source.set_unit_flag
            )
            flag_equivalences_5875_to_3368[143] = FlagEquivalence(
                UnitFields.UNIT_DYNAMIC_FLAGS,
                command.source.dynamic_flags,
                command.source.set_dynamic_type_flag
            )
            flag_equivalences_5875_to_3368[147] = FlagEquivalence(
                UnitFields.UNIT_FIELD_BYTES_1,
                command.source.npc_flags,
                command.source.set_npc_flag
            )

        if command.source.is_player():
            flag_equivalences_5875_to_3368[190] = FlagEquivalence(
                PlayerFields.PLAYER_BYTES_2,
                command.source.player.extra_flags,
                command.source.player.set_extra_flag
            )

        try:
            flag_data = flag_equivalences_5875_to_3368[command.datalong]
        except KeyError:
            Logger.warning(f'ScriptHandler: Equivalence for 5875 flags not found ({command.datalong}), '
                           f'aborting {command.get_info()}.')
            return command.should_abort()

        # TODO: Finish adding more equivalences.
        # Value equivalences.  # TODO: Do this on loading?
        # Npc flags.
        if flag_data.field == UnitFields.UNIT_FIELD_BYTES_1:
            # Mapping of bitmask to corresponding NpcFlags.
            npc_flag_mapping = {
                0x4: NpcFlags.NPC_FLAG_VENDOR,
                0x2: NpcFlags.NPC_FLAG_QUESTGIVER,
                0x8: NpcFlags.NPC_FLAG_FLIGHTMASTER,
                0x10: NpcFlags.NPC_FLAG_TRAINER,
                0x80: NpcFlags.NPC_FLAG_BINDER,
                0x100: NpcFlags.NPC_FLAG_BANKER,
                0x400: NpcFlags.NPC_FLAG_TABARDDESIGNER,
                0x200: NpcFlags.NPC_FLAG_PETITIONER,
            }

            npc_flags = 0x0
            for bitmask, flag in npc_flag_mapping.items():
                if command.datalong2 & bitmask:
                    npc_flags |= flag

            command.datalong2 = npc_flags
        # Player extra flags.
        elif flag_data.field == PlayerFields.PLAYER_BYTES_2:
            # Not implemented, doesn't seem relevant for 0.5.3 as PlayerFlags are very limited.
            return command.should_abort()

        special_fields = {
            UnitFields.UNIT_FIELD_BYTES_1,
            UnitFields.UNIT_FIELD_FLAGS,
            UnitFields.UNIT_DYNAMIC_FLAGS,
            PlayerFields.PLAYER_BYTES_2
        }

        def set_flag():
            if flag_data.field in special_fields:
                flag_data.modify(command.datalong2)
            else:
                flag_data.modify(flag_data.field, command.datalong2)

        def remove_flag():
            if flag_data.field in special_fields:
                flag_data.modify(command.datalong2, False)
            else:
                flag_data.modify(flag_data.field, flag_data.flags & ~command.datalong2)

        def toggle_flag():
            if flag_data.field in special_fields:
                # Second param: toggle based on whether flag is currently set.
                flag_data.modify(command.datalong2, not (flag_data.flags & command.datalong2))
            else:
                if flag_data.flags & command.datalong2:
                    # Flag is enabled, disable it.
                    flag_data.modify(flag_data.field, flag_data.flags & ~command.datalong2)
                else:
                    # Flag is disabled, enable it.
                    flag_data.modify(flag_data.field, command.datalong2)

        # Modify flag.
        if command.datalong3 == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
            set_flag()
        elif command.datalong3 == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
            remove_flag()
        elif command.datalong3 == ModifyFlagsOptions.SO_MODIFYFLAGS_TOGGLE:
            toggle_flag()

        return False

    # TODO: Missing delayed handling. (SPELL_STATE_DELAYED)
    @staticmethod
    def handle_script_command_interrupt_casts(command):
        # source = Unit
        # datalong = (bool) with_delayed
        # datalong2 = spell_id (optional)
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()
        command.source.spell_manager.remove_cast_by_id(command.datalong2, interrupted=True)

        return False

    @staticmethod
    def handle_script_command_teleport_to(command):
        # source = Unit
        # datalong = map_id (only used for players but still required)
        # datalong2 = teleport_options (see enum TeleportToOptions)
        # x/y/z/o = coordinates
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()

        # Units.
        if command.source.is_unit():
            command.source.near_teleport(Vector(command.x, command.y, command.z, command.o))
            return command.should_abort()

        # Players.
        command.source.teleport(command.datalong, Vector(command.x, command.y, command.z, command.o))

        return False

    @staticmethod
    def handle_script_command_quest_explored(command):
        # source = Player (from provided source or target)
        # target = WorldObject (from provided source or target)
        # datalong = quest_id
        # datalong2 = distance or 0
        # datalong3 = (bool) group
        if not ConditionChecker.is_player(command.source) and not ConditionChecker.is_player(command.target):
            Logger.warning('ScriptHandler: handle_script_command_quest_explored failed, no player found!')
            return command.should_abort()

        player = command.source if ConditionChecker.is_player(command.source) else command.target
        quest_giver = command.target if ConditionChecker.is_player(command.source) else command.source

        if not quest_giver:
            Logger.warning('ScriptHandler: handle_script_command_quest_explored failed, no quest_target found!')
            return command.should_abort()

        if command.datalong not in player.quest_manager.active_quests:
            return command.should_abort()

        in_range = not command.datalong2 or player.location.distance(quest_giver.location) <= command.datalong2
        if command.datalong3 and player.group_manager and in_range:
            player.group_manager.reward_quest_completion(player, command.datalong)
            return command.should_abort()

        if in_range:
            player.quest_manager.active_quests[command.datalong].set_explored_or_event_complete()
            player.quest_manager.reward_quest_event(command.datalong)
        else:
            return command.should_abort()

        return False

    @staticmethod
    def handle_script_command_kill_credit(command):
        # source = Player (from provided source or target)
        # datalong = creature entry
        # datalong2 = bool (0=personal credit, 1=group credit)
        Logger.debug('ScriptHandler: handle_script_command_kill_credit not implemented yet')

        return command.should_abort()

    @staticmethod
    def handle_script_command_respawn_gameobject(command):
        # source = Map
        # target = GameObject (from datalong, provided source or target)
        # datalong = db_guid
        # datalong2 = despawn_delay
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        go_spawn = map_.get_surrounding_gameobject_spawn_by_spawn_id(command.source, command.datalong)
        if not go_spawn:
            Logger.warning(f'ScriptHandler: No gameobject {command.datalong} found, {command.get_info()}.')
            return command.should_abort()

        go_spawn.spawn(ttl=command.datalong2)

        return False

    @staticmethod
    def handle_script_command_despawn_gameobject(command):
        # source = GameObject(from datalong, provided source or target)
        # datalong = db_guid
        # datalong2 = respawn_delay
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        go_obj = None
        if command.datalong:
            go_spawn = map_.get_surrounding_gameobject_spawn_by_spawn_id(command.source, command.datalong)
            if not go_spawn:
                Logger.warning(f'ScriptHandler: No gameobject {command.datalong} found, {command.get_info()}.')
                return command.should_abort()
            go_obj = go_spawn.gameobject_instance
        elif command.target and command.target.is_gameobject():
            go_obj = command.target
        elif command.source and command.source.is_gameobject():
            go_obj = command.source

        if not go_obj:
            Logger.warning(f'ScriptHandler: No gameobject found: Source: {command.source.get_name()}, '
                           f'SpawnID: {command.datalong}, {command.get_info()}.')
            return command.should_abort()

        if not go_obj.is_spawned:
            return command.should_abort()

        go_obj.despawn(respawn_delay=command.datalong2)

        return False

    @staticmethod
    def handle_script_command_summon_temp_creature(command):
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
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}.')
            return command.should_abort()

        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        summon_type = TempSummonType(command.dataint4)
        summon_location = Vector(command.x, command.y, command.z, command.o)

        if command.dataint & (SummonCreatureFlags.SF_SUMMON_CREATURE_UNIQUE |
                              SummonCreatureFlags.SF_SUMMON_CREATURE_UNIQUE_TEMP):
            distance = command.datalong4 if command.datalong4 else (
                    (command.source.location.distance(summon_location) + 50.0) * 2)

            # Search by source object location.
            units = map_.get_surrounding_units_by_location(command.source.location, command.source.map_id,
                                                           command.source.instance_id, distance,
                                                           include_players=False)[0].values()

            found_units = [unit for unit in units if unit.creature_template.entry == command.datalong]

            if found_units:
                req_amount = command.datalong3 if command.datalong3 else 1
                count_dead = summon_type in {TempSummonType.TEMP_SUMMON_TIMED_DESPAWN,
                                             TempSummonType.TEMP_SUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,
                                             TempSummonType.TEMP_SUMMON_MANUAL_DESPAWN}

                if command.dataint & SummonCreatureFlags.SF_SUMMON_CREATURE_UNIQUE:
                    ex_amount = len(found_units) if count_dead else sum(1 for u in found_units if u.is_alive)
                else:
                    ex_amount = sum(1 for u in found_units if u.is_temp_summon() and (count_dead or u.is_alive))

                if ex_amount >= req_amount:
                    return command.should_abort()

        creature_manager = CreatureBuilder.create(command.datalong, summon_location,
                                                  command.source.map_id, command.source.instance_id,
                                                  ttl=command.datalong2 / 1000,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON,
                                                  summon_type=summon_type)
        if not creature_manager:
            return command.should_abort()

        map_.spawn_object(world_object_instance=creature_manager)

        # Generic script.
        if command.dataint2:
            map_.enqueue_script(source=creature_manager, target=None, script_type=ScriptTypes.SCRIPT_TYPE_GENERIC,
                                script_id=command.dataint2)

        # Run.
        if command.dataint & SummonCreatureFlags.SF_SUMMON_CREATURE_SET_RUN:
            creature_manager.set_move_flag(MoveFlags.MOVEFLAG_WALK, active=False)

        # Attack target type.
        if command.dataint3 < ScriptTarget.TARGET_T_PROVIDED_TARGET:  # Can be -1.
            return False

        from game.world.managers.objects.script.ScriptManager import ScriptManager
        attack_target = ScriptManager.get_target_by_type(command.source, command.target, command.dataint3)
        if attack_target and attack_target.is_alive:
            creature_manager.attack(attack_target)

        return False

    @staticmethod
    def handle_script_command_open_door(command):
        # source = GameObject (from datalong, provided source or target)
        # If provided target is BUTTON GameObject, command is run on it too.
        # datalong = db_guid
        # datalong2 = reset_delay
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()

        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        spawn_id = command.datalong
        if spawn_id:
            gobject_spawn = map_.get_surrounding_gameobject_spawn_by_spawn_id(command.source, spawn_id)
            if not gobject_spawn:
                Logger.warning(f'ScriptHandler: {command.get_info()}, '
                               f'Gameobject with Spawn ID {spawn_id} not found.')
                return command.should_abort()
            gobject_spawn.gameobject_instance.use()
        elif command.source.is_gameobject():
            command.source.use()

        if command.target and command.target.is_gameobject() and \
                command.target.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            command.target.use()

        # TODO: Handle reset_delay
        return False

    @staticmethod
    def handle_script_command_close_door(command):
        # source = GameObject (from datalong, provided source or target)
        # If provided target is BUTTON GameObject, command is run on it too.
        # datalong = db_guid
        # datalong2 = reset_delay
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()

        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        spawn_id = command.datalong
        if spawn_id:
            gobject_spawn = map_.get_surrounding_gameobject_spawn_by_spawn_id(command.source, spawn_id)
            if not gobject_spawn:
                Logger.warning(f'ScriptHandler: {command.get_info()}, '
                               f'Gameobject with Spawn ID {spawn_id} not found.')
                return command.should_abort()
            gobject_spawn.gameobject_instance.set_ready()
        elif command.source.is_gameobject():
            command.source.set_ready()

        if command.target and command.target.is_gameobject() and \
                command.target.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            command.target.set_ready()

        # TODO: Handle reset_delay
        return False

    @staticmethod
    def handle_script_command_activate_object(command):
        # source: Unit/GameObject.
        # target: Unit/GameObject.
        user = None
        gameobject = None

        # Determine the user (Unit).
        if command.source and command.source.is_unit(by_mask=True):
            user = command.source
        elif command.target and command.target.is_unit(by_mask=True):
            user = command.target

        if not user:
            Logger.warning(f'ScriptHandler: No source or target, {command.get_info()}')
            return command.should_abort()

        # Determine the GameObject.
        if command.target and command.target.is_gameobject(by_mask=True):
            gameobject = command.target
        elif command.source and command.source.is_gameobject(by_mask=True):
            gameobject = command.source

        if not gameobject:
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return command.should_abort()

        gameobject.use(unit=user, from_script=True)
        return False

    @staticmethod
    def handle_script_command_remove_aura(command):
        # source = Unit
        # datalong = spell_id
        if command.source and command.source.aura_manager:
            ScriptHandler._validate_spell_id(command)
            command.source.aura_manager.cancel_auras_by_spell_id(command.datalong)
            return False

        Logger.warning(f'ScriptHandler: No aura manager found, {command.get_info()}.')

        return command.should_abort()

    @staticmethod
    def handle_script_command_cast_spell(command):
        # source = Unit
        # target = Unit
        # datalong = spell_id
        # datalong2 = eCastSpellFlags
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()

        spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(command.datalong)
        if not spell_entry:
            ScriptHandler._validate_spell_id(command)
            return command.should_abort()

        self_cast = not command.target or command.target == command.source
        target = command.target if command.target else command.source
        target_mask = SpellTargetMask.UNIT if not self_cast else SpellTargetMask.SELF
        targets_terrain = spell_entry.Targets & SpellTargetMask.CAN_TARGET_TERRAIN
        if targets_terrain:
            target = target.location
            target_mask = SpellTargetMask.DEST_LOCATION

        spell = command.source.spell_manager.try_initialize_spell(spell_entry, target, target_mask, validate=False)
        if not spell:
            Logger.warning(f'[Script] [{command.script_id}], Unable to cast spell {command.datalong}')
            return command.should_abort()

        if command.datalong2 & CastFlags.CF_TRIGGERED:
            spell.force_instant_cast()
        elif not targets_terrain and command.source.is_unit():
            cast_result = command.source.object_ai.try_to_cast(target, spell, command.datalong2, chance=100)
            if cast_result != SpellCheckCastResult.SPELL_NO_ERROR:
                Logger.warning(f'[Script] [{command.script_id}],'
                               f' Unable to cast spell {command.datalong}-{spell.spell_entry.Name_enUS},'
                               f' Cast result {SpellCheckCastResult(cast_result).name}')
                return command.should_abort()

        command.source.spell_manager.start_spell_cast(initialized_spell=spell)

        return False

    @staticmethod
    def handle_script_command_create_item(command):
        # source = Player (from provided source or target)
        # datalong = item_id
        # datalong2 = amount
        if command.source and command.source.inventory:
            command.source.inventory.add_item(command.datalong, command.datalong2)
            return False

        Logger.warning(f'ScriptHandler: No inventory found, aborting {command.get_info()}.')

        return command.should_abort()

    @staticmethod
    def handle_script_command_despawn_creature(command):
        # source = Creature
        # datalong = despawn_delay
        # datalong2 = respawn_delay
        if command.source and command.source.is_unit(by_mask=True):
            command.source.despawn(ttl=command.datalong, respawn_delay=command.datalong2)
            return False

        Logger.warning(f'ScriptHandler: No valid source found, {command.get_info()}.')

        return command.should_abort()

    @staticmethod
    def handle_script_command_set_equipment(command):
        # source = Creature
        # datalong = (bool) reset_default
        # dataint = main-hand item_id
        # dataint2 = off-hand item_id
        # dataint3 = ranged item_id
        if not command.source or not command.source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        if command.datalong == 1:
            command.source.reset_virtual_equipment()
        if command.dataint > 0:
            command.source.set_virtual_equipment(0, command.dataint)
        if command.dataint2 > 0:
            command.source.set_virtual_equipment(1, command.dataint2)
        if command.dataint3 > 0:
            command.source.set_virtual_equipment(2, command.dataint3)

        return False

    @staticmethod
    def handle_script_command_movement(command):
        # source = Creature
        # datalong = see enum MovementGeneratorType (not all are supported)
        # datalong2 = bool_param (meaning depends on the motion type)
        # datalong3 = int_param (meaning depends on the motion type)
        # datalong4 = (bool) clear
        # x = distance (only for some motion types)
        # o = angle (only for some motion types)
        source = command.source if command.source else command.target
        target = command.target if command.target else command.source

        if not target:
            Logger.warning(f'ScriptHandler: No target found, {command.get_info()}.')
            return command.should_abort()

        if not source or not source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        if not source.is_alive:
            return command.should_abort()

        clear = command.datalong4 != 0
        bool_param = command.datalong2 != 0
        motion_type = MotionTypes(command.datalong)

        if clear:
            source.movement_manager.flush()

        # Handler functions for each motion type.
        def handle_idle():
            source.movement_manager.flush()
            return False

        def handle_random():
            wandering_distance = command.x if command.x else 0
            source.movement_manager.move_wander(use_current_position=bool_param, wandering_distance=wandering_distance)
            return False

        def handle_waypoint():
            move_info = CommandMoveInfo(
                wp_source=WaypointPathOrigin.PATH_NO_PATH,
                start_point=command.datalong3,
                initial_delay=0,
                repeat=bool_param,
                overwrite_entry=0,
                overwrite_guid=0
            )
            command.source.movement_manager.move_automatic_waypoints_from_script(command_move_info=move_info)
            return False

        def handle_confused():
            source.movement_manager.move_confused()
            return False

        def handle_chase():
            #  TODO: Check VMaNGOS, for now, just trigger combat through threat if source has no target.
            if not source.combat_target and target != source:
                source.threat_manager.add_threat(target)
            return False

        def handle_home():
            source.leave_combat()
            return False

        def handle_flee():
            source.movement_manager.move_fear(command.datalong3, target=target)
            return False

        def handle_distracted():
            source.movement_manager.move_distracted(command.datalong3)
            return False

        def handle_follow():
            source.movement_manager.move_follow(command.target)

        # Map motion types to handler functions
        motion_handlers = {
            MotionTypes.IDLE_MOTION_TYPE: handle_idle,
            MotionTypes.RANDOM_MOTION_TYPE: handle_random,
            MotionTypes.WAYPOINT_MOTION_TYPE: handle_waypoint,
            MotionTypes.CONFUSED_MOTION_TYPE: handle_confused,
            MotionTypes.CHASE_MOTION_TYPE: handle_chase,
            MotionTypes.HOME_MOTION_TYPE: handle_home,
            MotionTypes.FLEEING_MOTION_TYPE: handle_flee,
            MotionTypes.DISTRACT_MOTION_TYPE: handle_distracted,
            MotionTypes.FOLLOW_MOTION_TYPE: handle_follow,
        }

        # Execute handler or abort result for unknown types.
        handler = motion_handlers.get(motion_type, None)

        if not handler:
            Logger.warning(f'ScriptHandler: handle_script_command_movement, {motion_type} not implemented yet')
            return command.should_abort()

        handler()
        return False

    @staticmethod
    def handle_script_command_set_activeobject(command):
        # source = Creature
        # datalong = (bool) 0=off, 1=on
        Logger.debug('ScriptHandler: handle_script_command_set_activeobject not implemented yet')

        return command.should_abort()

    @staticmethod
    def handle_script_command_set_faction(command):
        # source = Creature
        # datalong = faction_Id,
        # datalong2 = see enum TemporaryFactionFlags
        if not command.source or not command.source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()
        if not command.datalong:
            command.source.reset_faction()
        else:
            command.source.set_faction(command.datalong, command.datalong2)

        return False

    @staticmethod
    def handle_script_command_morph_to_entry_or_model(command):
        # source = Unit
        # datalong = creature_id/display_id (depend on datalong2)
        # datalong2 = (bool) is_display_id
        if not command.source or not command.source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        if not command.source.is_alive:
            return command.should_abort()

        creature_or_model_entry = command.datalong
        display_id = command.datalong2

        if not creature_or_model_entry:
            command.source.reset_display_id()
            return command.should_abort()
        elif display_id:
            command.source.set_display_id(display_id)
            return command.should_abort()

        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creature_or_model_entry)
        if creature_template:
            command.source.set_display_id(creature_template.display_id1)
        else:
            Logger.warning(f'ScriptHandler: No creature template found, {command.get_info()}.')
            return command.should_abort()

        return False

    @staticmethod
    def handle_script_command_mount_to_entry_or_model(command):
        # source = Creature
        # datalong = creature_id/display_id (depend on datalong2)
        # datalong2 = (bool) is_display_id
        # datalong3 = (bool) permanent
        if not command.source or not command.source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        if not command.source.is_alive:
            return command.should_abort()

        display_id = command.datalong2
        creature_or_model_entry = command.datalong

        if not creature_or_model_entry and not display_id:
            if command.source.creature_template.mount_display_id:
                command.source.mount(display_id)
            else:
                command.source.unmount()
        elif creature_or_model_entry:
            creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
                creature_or_model_entry)
            if creature_template and creature_template.display_id1:
                command.source.mount(creature_template.display_id1)
            else:
                command.source.unmount()

        return False

    @staticmethod
    def handle_script_command_set_run(command):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not command.source or not command.source.is_unit(by_mask=True):
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        run_enabled = command.datalong == 1
        flag_changed = ((run_enabled and command.source.movement_flags & MoveFlags.MOVEFLAG_WALK) or
                        (not run_enabled and not command.source.movement_flags & MoveFlags.MOVEFLAG_WALK))
        if flag_changed:
            command.source.set_move_flag(MoveFlags.MOVEFLAG_WALK, active=not run_enabled)
            command.source.movement_manager.set_speed_dirty()

        return False

    @staticmethod
    def handle_script_command_start_attack(command):
        # source = Unit
        # target = Unit
        if not command.source:
            Logger.warning(f'ScriptHandler: Invalid attacker, {command.get_info()}.')
            return command.should_abort()

        attacker = command.source
        victim = command.target

        if victim and victim.is_alive:
            attacker.attack(victim)
            return False

        Logger.warning(f'ScriptHandler: Unable to resolve target, {command.get_info()}.')

        return command.should_abort()

    @staticmethod
    def handle_script_command_update_entry(command):
        # source = Creature
        # datalong = creature_entry
        if not command.source:
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(command.datalong)
        if not creature_template:
            Logger.warning(f'ScriptHandler: Invalid creature template, {command.get_info()}.')
            return command.should_abort()

        command.source.initialize_from_creature_template(creature_template)

        return command.should_abort()

    @staticmethod
    def handle_script_command_stand_state(command):
        # source = Unit
        # datalong = stand_state (enum UnitStandStateType)
        if command.source and command.source.is_alive:
            command.source.set_stand_state(command.datalong)
            return False

        Logger.warning(f'ScriptHandler: No source found or source is dead, {command.get_info()}.')

        return command.should_abort()

    @staticmethod
    def handle_script_command_modify_threat(command):
        # source = Creature
        # datalong = eModifyThreatTargets
        # x = percent
        if not command.source:
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        if command.datalong == 8:  #  SO_MODIFYTHREAT_ALL_ATTACKERS.
            for unit in command.source.threat_manager.get_threat_holder_units():
                command.source.threat_manager.modify_thread_percent(unit, command.x)
        else:
            target = ScriptManager.get_target_by_type(command.source, command.target, command.datalong)
            if target:
                command.source.threat_manager.modify_thread_percent(target, command.x)

        return False

    @staticmethod
    def handle_script_command_terminate_script(command):
        # source = Any
        # datalong = creature_entry
        # datalong2 = search_distance
        # datalong3 = eTerminateScriptOptions
        searcher = command.source or command.target
        if not searcher:
            if not command.source or not command.source.is_unit():
                Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
                return command.should_abort()

        if command.datalong:
            target = ScriptManager.resolve_nearest_creature_with_entry(caster=searcher, param1=command.datalong,
                                                                       param2=command.datalong2)

            if not target and command.datalong3 == 0:
                return True  # Abort when not found.
            elif target and command.datalong3 == 1:
                return True  # Abort when found.
        else:
            return True

        return False

    @staticmethod
    def handle_script_command_terminate_condition(command):
        # source = Any
        # datalong = condition_id
        # datalong2 = failed_quest_id
        # datalong3 = eTerminateConditionFlags
        if command.datalong:
            result = ConditionChecker.validate(command.datalong, command.source, command.target)
            if command.datalong3 & TerminateConditionFlags.SF_TERMINATECONDITION_WHEN_FALSE:
                result = not result
        else:
            result = True

        if not command.datalong2:
            return command.should_abort()

        _target = None
        if ConditionChecker.is_player(command.source):
            _target = command.source
        elif ConditionChecker.is_player(command.target):
            _target = command.target

        if result:
            command.script.abort()

        if not _target:
            Logger.warning(f'ScriptHandler: Invalid target, {command.get_info()}.')
            return command.should_abort()

        if _target.online and result:
            if _target.group_manager:
                _target.group_manager.fail_quest_for_group(_target, command.datalong2)
            else:
                _target.quest_manager.fail_quest_by_id(command.datalong2)

        return False

    @staticmethod
    def handle_script_command_enter_evade_mode(command):
        # source = Creature
        if command.source and command.source.object_ai:
            command.source.leave_combat()
            return False

        Logger.warning(f'ScriptHandler: Invalid target, {command.get_info()}.')

        return command.should_abort()

    @staticmethod
    def handle_script_command_set_home_position(command):
        # source = Creature
        # datalong = eSetHomePositionOptions
        # x/y/z/o = coordinates
        if not command.source or not command.source.is_unit():
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        if not command.source.spawn_id:
            Logger.warning(f'ScriptHandler: No spawn id, {command.get_info()}.')
            return command.should_abort()

        # All other SetHomePositionOptions are not valid for 0.5.3.
        if command.datalong != SetHomePositionOptions.SET_HOME_DEFAULT_POSITION:
            return command.should_abort()

        spawn = WorldDatabaseManager.creature_spawn_get_by_spawn_id(command.source.spawn_id)
        if not spawn:
            Logger.warning(f'ScriptHandler: Unable to locate spawn, {command.get_info()}.')
            return command.should_abort()

        if isinstance(spawn, CreatureSpawn):
            command.source.spawn_position = spawn.get_default_location()

        return False

    @staticmethod
    def handle_script_command_turn_to(command):
        # source = Unit
        # target = WorldObject (optional depending on TurnToFacingOptions)
        # o = angle to turn to (optional depending on TurnToFacingOptions)
        # datalong = eTurnToFacingOptions
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}).')
            return command.should_abort()

        if not command.target and command.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
            Logger.warning(f'ScriptHandler: No target found, {command.get_info()}).')
            return command.should_abort()

        if command.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
            command.source.movement_manager.face_target(command.target)
        else:
            command.source.movement_manager.face_angle(command.o)

        return False

    @staticmethod
    def handle_script_command_set_inst_data(command):
        # source = Map
        # datalong = field
        # datalong2 = data
        # datalong3 = eSetInstDataOptions
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data not implemented yet')

        return command.should_abort()

    @staticmethod
    def handle_script_command_set_inst_data64(command):
        # source = Map
        # target = Object (when saving guid)
        # datalong = field
        # datalong2 = data
        # datalong3 = eSetInstData64Options
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data64 not implemented yet')

        return command.should_abort()

    @staticmethod
    def handle_script_command_remove_item(command):
        # source = Player (from provided source or target)
        # datalong = item_id
        # datalong2 = amount
        src = None
        if command.source and not command.target:
            src = command.source
        elif command.target and not command.source:
            src = command.target
        elif command.source and command.target:
            src = command.source if command.source.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED else \
                command.target if command.target.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED else None

        if src and src.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED:
            src.inventory.remove_items(command.datalong, command.datalong2)
            return False

        Logger.warning('ScriptHandler: Neither source nor target are a player, aborting SCRIPT_COMMAND_REMOVE_ITEM')

        return command.should_abort()

    @staticmethod
    def handle_script_command_remove_object(command):
        # source = GameObject
        # target = Unit
        target = command.target or command.source
        if not target:
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        target.get_map().remove_object(target)

        return False

    @staticmethod
    def handle_script_command_set_melee_attack(command):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not command.source:
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()
        command.source.object_ai.set_melee_attack(command.datalong > 0)

        return False

    @staticmethod
    def handle_script_command_set_combat_movement(command):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not ConditionChecker.is_creature(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        command.source.object_ai.set_combat_movement(command.datalong > 0)

        return False

    @staticmethod
    def handle_script_command_set_phase(command):
        # source = Creature
        # datalong = phase
        # datalong2 = eSetPhaseOptions
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, {command.get_info()}.')
            return command.should_abort()

        if command.datalong2 == SetPhaseOptions.SO_SETPHASE_RAW:
            command.source.object_ai.script_phase = command.datalong
        elif command.datalong2 == SetPhaseOptions.SO_SETPHASE_INCREMENT:
            command.source.object_ai.script_phase += command.datalong
        elif command.datalong2 == SetPhaseOptions.SO_SETPHASE_DECREMENT:
            command.source.object_ai.script_phase = max(0, command.source.object_ai.script_phase - command.datalong)

        return False

    @staticmethod
    def handle_script_command_set_phase_random(command):
        # source = Creature
        # datalong1-4 = phase
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, {command.get_info()}.')
            return command.should_abort()

        command.source.object_ai.script_phase = random.choice([command.datalong1, command.datalong2,
                                                               command.datalong3, command.datalong4])
        return False

    @staticmethod
    def handle_script_command_set_phase_range(command):
        # source = Creature
        # datalong = phase_min
        # datalong2 = phase_max
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, {command.get_info()}')
            return command.should_abort()

        command.source.object_ai.script_phase = random.randrange(command.datalong, command.datalong2)

        return False

    @staticmethod
    def handle_script_command_flee(command):
        # source = Creature
        # datalong = seek_assistance (bool) 0 = off, 1 = on
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, {command.get_info()}')
            return command.should_abort()

        flee_text = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(1150)
        ChatManager.send_monster_message(command.source, flee_text.male_text,
                                         ChatMsgs.CHAT_MSG_MONSTER_EMOTE, Languages.LANG_UNIVERSAL,
                                         ChatHandler.get_range_by_type(ChatMsgs.CHAT_MSG_MONSTER_EMOTE),
                                         command.target)
        if command.source.spell_manager:
            command.source.spell_manager.remove_casts(remove_active=False)
        seek_assist = command.datalong != 0
        # Flee for 7 seconds or until assist is found (If nearby units can assist).
        command.source.movement_manager.move_fear(duration_seconds=7, seek_assist=seek_assist)

        return False

    @staticmethod
    def handle_script_command_deal_damage(command):
        # source = Unit
        # target = Unit
        # datalong = damage
        # datalong2 = (bool) is_percent
        if not command.source or not command.target:
            Logger.warning(f'ScriptHandler: No source or no target, {command.get_info()}')
            return command.should_abort()

        if command.datalong2 == 1:
            # Damage is a percentage of the target's health.
            damage_to_deal = int(command.target.health * (command.datalong / 100))
        else:
            damage_to_deal = command.datalong

        if damage_to_deal > 0:
            attacker = command.source if command.source.is_unit(by_mask=True) else None
            damage_info = DamageInfoHolder(attacker=attacker, target=command.target, total_damage=damage_to_deal,
                                           damage_school_mask=SpellSchoolMask.SPELL_SCHOOL_MASK_NORMAL)
            command.source.deal_damage(command.target, damage_info)
            return False

        Logger.warning(f'ScriptHandler: Attempted to deal 0 damage, {command.get_info()}')
        return command.should_abort()

    @staticmethod
    def handle_script_command_set_sheath(command):
        # source = Unit
        # datalong = see enum WeaponMode
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()
        # 0.5.3 weapon modes for sheathed and unsheathed status are swapped compared to later versions.
        # In order to keep full compatibility with VMaNGOS scripts, we do the swap here instead of changing the value
        # in the database.
        weapon_mode = command.datalong ^ 1 if command.datalong < 2 else command.datalong
        command.source.set_weapon_mode(weapon_mode)

        return False

    @staticmethod
    def handle_script_command_invincibility(command):
        # source = Creature
        # datalong = health
        # datalong2 = (bool) is_percent
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()
        invincibility_hp_lvl = command.source.max_health * command.datalong / 100 if command.datalong2 else \
            command.datalong
        command.source.invincibility_hp_level = invincibility_hp_lvl

        return False

    @staticmethod
    def handle_script_command_game_event(command):
        # source = None
        # datalong = event_id
        # datalong2 = (bool) start
        # datalong3 = (bool) overwrite
        Logger.debug('ScriptHandler: handle_script_command_game_event not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_set_server_variable(command):
        # source = None
        # datalong = index
        # datalong2 = value
        Logger.debug('ScriptHandler: handle_script_command_set_server_variable not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_remove_guardians(command):
        # source = Unit
        # datalong = creature_id
        if not ConditionChecker.is_unit(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        command.source.pet_manager.detach_pets_by_entry(command.datalong)
        return False

    @staticmethod
    def handle_script_command_add_spell_cooldown(command):
        # source = Unit
        # datalong = spell_id
        # datalong2 = cooldown in seconds
        if not ConditionChecker.is_unit(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(command.datalong)
        if not spell:
            ScriptHandler._validate_spell_id(command)
            return command.should_abort()

        command.source.spell_manager.set_on_cooldown(spell, command.datalong2 * 1000)
        return False

    @staticmethod
    def handle_script_command_remove_spell_cooldown(command):
        # source = Unit
        # datalong = spell_id
        if not ConditionChecker.is_unit(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        ScriptHandler._validate_spell_id(command)
        command.source.spell_manager.unlock_spell_cooldown(command.datalong)
        return False

    @staticmethod
    def handle_script_command_set_react_state(command):
        # source = Creature
        # datalong = see enum ReactStates
        # source = Creature
        if not ConditionChecker.is_unit(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, {command.get_info()}.')
            return command.should_abort()

        charmer_or_summoner = command.source.get_charmer_or_summoner()
        if charmer_or_summoner and charmer_or_summoner.is_unit():
            charmer_or_summoner.react_state = CreatureReactStates(command.datalong)

        command.source.react_state = CreatureReactStates(command.datalong)
        return False

    @staticmethod
    def handle_script_command_start_waypoints(command):
        # source = Creature
        # datalong = waypoints_source
        # datalong2 = start_point
        # datalong3 = initial_delay
        # datalong4 = (bool) repeat
        # dataint = overwrite_guid
        # dataint2 = overwrite_entry
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, {command.get_info()}.')
            return command.should_abort()
        move_info = CommandMoveInfo(wp_source=WaypointPathOrigin(command.datalong), start_point=command.datalong2,
                                    initial_delay=command.datalong3, repeat=command.datalong4 > 0,
                                    overwrite_guid=command.dataint, overwrite_entry=command.dataint2)
        command.source.movement_manager.move_automatic_waypoints_from_script(command_move_info=move_info)

        return False

    @staticmethod
    def handle_script_command_start_map_event(command):
        # source = Map
        # datalong = event_id
        # datalong2 = time_limit
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_start_map_event invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.add_event(command.source, command.target, command.source.map_id, command.datalong, command.datalong2,
                       command.dataint, command.dataint2, command.dataint3, command.dataint4)

        return False

    @staticmethod
    def handle_script_command_end_map_event(command):
        # source = Map
        # datalong = event_id
        # datalong2 = (bool) success
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_end_map_event invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.end_event(command.datalong, command.datalong2)
        return False

    @staticmethod
    def handle_script_command_add_map_event_target(command):
        # source = WorldObject
        # datalong = event_id
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_add_map_event_target invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.add_event_target(command.source, command.datalong, command.dataint, command.dataint2, command.dataint3,
                              command.dataint4)
        return False

    @staticmethod
    def handle_script_command_remove_map_event_target(command):
        # source = Map
        # target = WorldObject
        # datalong = event_id
        # datalong2 = condition_id
        # datalong3 = eRemoveMapEventTargetOptions
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_remove_map_event_target invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.remove_event_target(command.target, command.datalong, command.datalong2, command.datalong3)
        return False

    @staticmethod
    def handle_script_command_set_map_event_data(command):
        # source = Map
        # datalong = event_id
        # datalong2 = index
        # datalong3 = data
        # datalong4 = eSetMapScriptDataOptions
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_set_map_event_data invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.set_event_data(command.datalong, command.datalong2, command.datalong3, command.datalong4)
        return False

    @staticmethod
    def handle_script_command_send_map_event(command):
        # source = Map
        # datalong = event_id
        # datalong2 = data
        # datalong3 = eSendMapEventOptions
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_send_map_event invalid map ({command.source.map_id}) '
                           f'and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.send_event_data(command.datalong, command.datalong2, command.datalong3)
        return False

    @staticmethod
    def handle_script_command_set_default_movement(command):
        # source = Creature
        # datalong = movement_type
        # datalong2 = (bool) always_replace
        # datalong3 = param1
        Logger.debug('ScriptHandler: handle_script_command_set_default_movement not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_start_script_for_all(command):
        # source = WorldObject
        # datalong = script_id
        # datalong2 = eStartScriptForAllOptions
        # datalong3 = object_entry
        # datalong4 = search_radius
        Logger.debug('ScriptHandler: handle_script_command_start_script_for_all not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_edit_map_event(command):
        # source = Map
        # datalong = event_id
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        map_ = command.source.get_map()
        if not map_:
            Logger.warning(f'ScriptHandler: No map found, {command.get_info()}.')
            return command.should_abort()

        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_edit_map_event invalid map ({command.source.map_id}) '
                           f'and/or instance ({command.source.instance_id}).')
            return command.should_abort()

        map_.edit_map_event_data(command.datalong, command.dataint, command.dataint2, command.dataint3,
                                 command.dataint4)

        return False

    @staticmethod
    def handle_script_command_fail_quest(command):
        # source = Unit
        # target = Unit
        # datalong = quest_id
        if ConditionChecker.is_player(command.target):
            command.target.quest_manager.fail_quest_by_id(command.datalong)
            return False

        if ConditionChecker.is_player(command.source):
            command.source.quest_manager.fail_quest_by_id(command.datalong)
            return False

        Logger.warning('ScriptHandler: handle_script_command_fail_quest failed, no valid target')
        return command.should_abort()

    @staticmethod
    def handle_script_command_respawn_creature(command):
        # source = Creature
        # datalong = (bool) even_if_alive
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()

        if command.datalong or not command.source.is_alive:
            command.source.despawn()
            command.source.respawn()

        return False

    @staticmethod
    def handle_script_command_assist_unit(command):
        # source = Creature
        # target = Unit
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()

        command.source.object_ai.assist_unit(command.target)
        return False

    @staticmethod
    def handle_script_command_combat_stop(command):
        # source = Unit
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()

        command.source.attack_stop()
        command.source.leave_combat()
        return False

    @staticmethod
    def handle_script_command_add_aura(command):
        # Unused.
        return command.should_abort()

    @staticmethod
    def handle_script_command_add_threat(command):
        # source = Creature
        # target = Unit
        if not command.source or not command.target:
            Logger.warning(f'ScriptHandler: No source or target, {command.get_info()}')
            return command.should_abort()
        if command.source.is_alive and command.source.in_combat:
            command.source.threat_manager.add_threat(command.target)
            return False

        Logger.warning(f'ScriptHandler: Source is not in combat, {command.get_info()}')
        return command.should_abort()

    @staticmethod
    def handle_script_command_summon_object(command):
        # source = WorldObject
        # datalong = gameobject_entry
        # datalong2 = respawn_time
        # x/y/z/o = coordinates
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()

        x = command.x if command.x else command.source.location.x
        y = command.y if command.y else command.source.location.y
        z = command.z if command.z else command.source.location.z
        o = command.o if command.o else command.source.location.o
        location = Vector(x, y, z, o)

        from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
        new_object = GameObjectBuilder.create(command.datalong, location, command.source.map_id,
                                              command.source.instance_id, state=GameObjectStates.GO_STATE_READY,
                                              ttl=command.datalong2)

        command.source.get_map().spawn_object(world_object_instance=new_object)

        return False

    @staticmethod
    def handle_script_command_join_creature_group(command):
        # source = Creature
        # target = Creature
        # datalong = OptionFlags
        # x = distance
        # o = angle
        if not ConditionChecker.is_creature(command.source):
            Logger.warning(f'ScriptHandler: No or invalid source (must be creature), {command.get_info()}')
            return command.should_abort()

        if not ConditionChecker.is_creature(command.target):
            Logger.warning(f'ScriptHandler: No or invalid target (must be creature), {command.get_info()}')
            return command.should_abort()

        creature_group_mgr = command.target.creature_group
        if not creature_group_mgr:
            Logger.debug(f'Creating creature group, leader is {command.target.get_name()}')
            creature_group_mgr = CreatureGroupManager.get_create_group(CreatureGroup(
                leader_guid=command.target.spawn_id,
                member_guid=command.target.spawn_id,
                dist=command.x,
                angle=command.o,
                flags=command.datalong
            ))
            command.target.creature_group = creature_group_mgr
            creature_group_mgr.add_member(command.target)

        creature_group_mgr.add_member(command.source, dist=command.x, angle=command.o, flags=command.datalong)
        return False

    @staticmethod
    def handle_script_command_leave_creature_group(command):
        # source = Creature
        if not ConditionChecker.is_creature(command.source):
            Logger.warning(f'ScriptHandler: No or invalid source (must be creature), {command.get_info()}')
            return command.should_abort()

        Logger.debug(f'{command.source.get_name()} leaving creature group.')
        if not command.source.creature_group:
            Logger.warning(f'ScriptHandler: No creature group, {command.get_info()}')
            return command.should_abort()

        command.source.creature_group.remove_member(command.source)
        return False

    @staticmethod
    def handle_script_command_set_go_state(command):
        # source = GameObject
        # datalong = GOState
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, {command.get_info()}')
            return command.should_abort()

        if not command.source.is_gameobject():
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return command.should_abort()

        command.source.set_state(GameObjectStates(command.datalong))
        return False

    @staticmethod
    def handle_script_command_quest_credit(command):
        # source = Player (from provided source or target)
        # target = WorldObject (from provided source or target)
        Logger.debug('ScriptHandler: handle_script_command_quest_credit not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_send_script_event(command):
        # source = Creature
        # target = WorldObject
        # datalong = event_id
        # datalong2 = event_data
        if not command.source or not command.source.is_unit():
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        if not command.source.object_ai:
            Logger.warning(f'ScriptHandler: No creature AI manager found, {command.get_info()}.')
            return command.should_abort()

        command.source.object_ai.on_script_event(command.datalong, command.datalong2, command.target)
        return False

    @staticmethod
    def handle_script_command_reset_door_or_button(command):
        # source = GameObject
        if not ConditionChecker.is_gameobject(command.source):
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return command.should_abort()

        if isinstance(command.source.gameobject_instance, DoorManager):
            command.source.gameobject_instance.reset_door_state()
        elif isinstance(command.source.gameobject_instance, ButtonManager):
            command.source.gameobject_instance.reset_button_state()
        elif isinstance(command.source.gameobject_instance, GooberManager):
            command.source.gameobject_instance.reset_goober_state()

        return False

    @staticmethod
    def handle_script_command_set_command_state(command):
        # source = Creature
        # datalong = command_state (see enum CommandStates)
        Logger.debug('ScriptHandler: handle_script_command_set_command_state not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_play_custom_anim(command):
        # source = GameObject
        # datalong = anim_id
        target = command.target if command.target else command.source
        if not ConditionChecker.is_gameobject(target):
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return command.should_abort()

        target.send_custom_animation(command.datalong)
        return False

    @staticmethod
    def handle_script_command_start_script_on_group(command):
        # source = Unit
        # datalong1-4 = generic_script id
        # dataint1-4 = chance (total cant be above 100)
        Logger.debug('ScriptHandler: handle_script_command_start_script_on_group not implemented yet')
        return command.should_abort()

    @staticmethod
    def handle_script_command_call_for_help(command):
        # source = Creature
        # x = radius
        if not command.source or not command.source.is_unit():
            Logger.warning(f'ScriptHandler: No creature manager found, {command.get_info()}.')
            return command.should_abort()

        if not command.source.combat_target:
            return command.should_abort()

        command.source.threat_manager.call_for_help(command.source.combat_target, radius=command.x)

        return False

    # Script types.

    @staticmethod
    def handle_script_type_quest_start(quest_id):
        return WorldDatabaseManager.quest_start_script_get_by_quest_id(quest_id)

    @staticmethod
    def handle_script_type_quest_end(quest_id):
        return WorldDatabaseManager.quest_end_script_get_by_quest_id(quest_id)

    @staticmethod
    def handle_script_type_gameobject(spawn_id):
        return WorldDatabaseManager.GameobjectScriptHolder.gameobject_scripts_get_by_id(spawn_id)

    @staticmethod
    def handle_script_type_generic(script_id):
        return WorldDatabaseManager.GenericScriptsHolder.generic_scripts_get_by_id(script_id)

    @staticmethod
    def handle_script_type_event_script(script_id):
        return WorldDatabaseManager.EventScriptHolder.event_scripts_get_by_id(script_id)

    @staticmethod
    def handle_script_type_ai(script_id):
        return WorldDatabaseManager.CreatureAIScriptHolder.creature_ai_scripts_get_by_id(script_id)

    @staticmethod
    def handle_script_type_creature_movement(script_id):
        return WorldDatabaseManager.CreatureMovementScriptHolder.creature_movement_scripts_get_by_id(script_id)

    @staticmethod
    def handle_script_type_area_trigger(script_id):
        return WorldDatabaseManager.area_trigger_script_get_by_id(script_id)

    @staticmethod
    def _validate_spell_id(command):
        if command.datalong > MAX_3368_SPELL_ID:
            Logger.error(f'ScriptHandler: Invalid spell id ({command.datalong}), {command.get_info()}')


SCRIPT_TYPES = {
    ScriptTypes.SCRIPT_TYPE_AI: ScriptHandler.handle_script_type_ai,
    ScriptTypes.SCRIPT_TYPE_QUEST_START: ScriptHandler.handle_script_type_quest_start,
    ScriptTypes.SCRIPT_TYPE_QUEST_END: ScriptHandler.handle_script_type_quest_end,
    ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT: ScriptHandler.handle_script_type_creature_movement,
    ScriptTypes.SCRIPT_TYPE_GAMEOBJECT: ScriptHandler.handle_script_type_gameobject,
    ScriptTypes.SCRIPT_TYPE_GENERIC: ScriptHandler.handle_script_type_generic,
    ScriptTypes.SCRIPT_TYPE_EVENT_SCRIPT: ScriptHandler.handle_script_type_event_script,
    ScriptTypes.SCRIPT_TYPE_AREA_TRIGGER: ScriptHandler.handle_script_type_area_trigger
    # Unused in 0.5.3.
    # ScriptTypes.SCRIPT_TYPE_CREATURE_SPELL: ScriptHandler.handle_script_type_creature_spell,
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
    ScriptCommands.SCRIPT_COMMAND_TEMP_SUMMON_CREATURE: ScriptHandler.handle_script_command_summon_temp_creature,
    ScriptCommands.SCRIPT_COMMAND_OPEN_DOOR: ScriptHandler.handle_script_command_open_door,
    ScriptCommands.SCRIPT_COMMAND_CLOSE_DOOR: ScriptHandler.handle_script_command_close_door,
    ScriptCommands.SCRIPT_COMMAND_ACTIVATE_OBJECT: ScriptHandler.handle_script_command_activate_object,
    ScriptCommands.SCRIPT_COMMAND_REMOVE_AURA: ScriptHandler.handle_script_command_remove_aura,
    ScriptCommands.SCRIPT_COMMAND_CAST_SPELL: ScriptHandler.handle_script_command_cast_spell,
    ScriptCommands.SCRIPT_COMMAND_CREATE_ITEM: ScriptHandler.handle_script_command_create_item,
    ScriptCommands.SCRIPT_COMMAND_DESPAWN_CREATURE: ScriptHandler.handle_script_command_despawn_creature,
    ScriptCommands.SCRIPT_COMMAND_SET_EQUIPMENT: ScriptHandler.handle_script_command_set_equipment,
    ScriptCommands.SCRIPT_COMMAND_MOVEMENT: ScriptHandler.handle_script_command_movement,
    ScriptCommands.SCRIPT_COMMAND_SET_ACTIVEOBJECT: ScriptHandler.handle_script_command_set_activeobject,
    ScriptCommands.SCRIPT_COMMAND_SET_FACTION: ScriptHandler.handle_script_command_set_faction,
    ScriptCommands.SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL: ScriptHandler.handle_script_command_morph_to_entry_or_model,
    ScriptCommands.SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL: ScriptHandler.handle_script_command_mount_to_entry_or_model,
    ScriptCommands.SCRIPT_COMMAND_SET_RUN: ScriptHandler.handle_script_command_set_run,
    ScriptCommands.SCRIPT_COMMAND_ATTACK_START: ScriptHandler.handle_script_command_start_attack,
    ScriptCommands.SCRIPT_COMMAND_UPDATE_ENTRY: ScriptHandler.handle_script_command_update_entry,
    ScriptCommands.SCRIPT_COMMAND_STAND_STATE: ScriptHandler.handle_script_command_stand_state,
    ScriptCommands.SCRIPT_COMMAND_MODIFY_THREAT: ScriptHandler.handle_script_command_modify_threat,
    ScriptCommands.SCRIPT_COMMAND_TERMINATE_SCRIPT: ScriptHandler.handle_script_command_terminate_script,
    ScriptCommands.SCRIPT_COMMAND_TERMINATE_CONDITION: ScriptHandler.handle_script_command_terminate_condition,
    ScriptCommands.SCRIPT_COMMAND_ENTER_EVADE_MODE: ScriptHandler.handle_script_command_enter_evade_mode,
    ScriptCommands.SCRIPT_COMMAND_SET_HOME_POSITION: ScriptHandler.handle_script_command_set_home_position,
    ScriptCommands.SCRIPT_COMMAND_TURN_TO: ScriptHandler.handle_script_command_turn_to,
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
    ScriptCommands.SCRIPT_COMMAND_JOIN_CREATURE_GROUP: ScriptHandler.handle_script_command_join_creature_group,
    ScriptCommands.SCRIPT_COMMAND_LEAVE_CREATURE_GROUP: ScriptHandler.handle_script_command_leave_creature_group,
    ScriptCommands.SCRIPT_COMMAND_SET_GO_STATE: ScriptHandler.handle_script_command_set_go_state,
    ScriptCommands.SCRIPT_COMMAND_DESPAWN_GAMEOBJECT: ScriptHandler.handle_script_command_despawn_gameobject,
    ScriptCommands.SCRIPT_COMMAND_QUEST_CREDIT: ScriptHandler.handle_script_command_quest_credit,
    ScriptCommands.SCRIPT_COMMAND_SEND_SCRIPT_EVENT: ScriptHandler.handle_script_command_send_script_event,
    ScriptCommands.SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON: ScriptHandler.handle_script_command_reset_door_or_button,
    ScriptCommands.SCRIPT_COMMAND_SET_COMMAND_STATE: ScriptHandler.handle_script_command_set_command_state,
    ScriptCommands.SCRIPT_COMMAND_PLAY_CUSTOM_ANIM: ScriptHandler.handle_script_command_play_custom_anim,
    ScriptCommands.SCRIPT_COMMAND_START_SCRIPT_ON_GROUP: ScriptHandler.handle_script_command_start_script_on_group,
    ScriptCommands.SCRIPT_COMMAND_CALL_FOR_HELP: ScriptHandler.handle_script_command_call_for_help,
    # Unused in 0.5.3.
    # ScriptCommands.SCRIPT_COMMAND_PLAY_SOUND: ScriptHandler.handle_script_command_play_sound
    # ScriptCommands.SCRIPT_COMMAND_SEND_TAXI_PATH: ScriptHandler.handle_script_command_send_taxi_path,
    # ScriptCommands.SCRIPT_COMMAND_ZONE_COMBAT_PULSE: ScriptHandler.handle_script_command_zone_combat_pulse,
    # ScriptCommands.SCRIPT_COMMAND_SET_FLY: ScriptHandler.handle_script_command_set_fly
    # ScriptCommands.SCRIPT_COMMAND_SET_GOSSIP_MENU: ScriptHandler.handle_script_command_set_gossip_menu,
    # ScriptCommands.SCRIPT_COMMAND_MEETINGSTONE: ScriptHandler.handle_script_command_meeting_stone,
    # ScriptCommands.SCRIPT_COMMAND_SET_PVP: ScriptHandler.handle_script_command_set_pvp,
}
