import math
import random

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.script.Script import Script
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from game.world.managers.objects.script.ScriptOocEvent import ScriptOocEvent
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.movement.helpers.CommandMoveInfo import CommandMoveInfo
from game.world.opcode_handling.handlers.social.ChatHandler import ChatHandler
from utils.constants import CustomCodes
from utils.constants.MiscCodes import BroadcastMessageType, ChatMsgs, Languages, ScriptTypes, ObjectTypeFlags, \
    ObjectTypeIds, GameObjectTypes, GameObjectStates, NpcFlags, MoveFlags
from utils.constants.SpellCodes import SpellSchoolMask, SpellTargetMask, SpellCheckCastResult
from utils.constants.UnitCodes import UnitFlags, Genders
from utils.constants.ScriptCodes import ModifyFlagsOptions, MoveToCoordinateTypes, TurnToFacingOptions, \
    ScriptCommands, SetHomePositionOptions, CastFlags, SetPhaseOptions, TerminateConditionFlags, WaypointPathOrigin
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.Logger import Logger
from utils.ConfigManager import config
from utils.constants.UpdateFields import GameObjectFields, UnitFields, PlayerFields


class ScriptHandler:

    def __init__(self, world_object):
        self.owner = world_object
        self.script_queue = set()
        self.ooc_ignore = set()
        self.ooc_events = {}

    def enqueue_script(self, source, target, script_type, script_id, delay=0.0, ooc_event=None):
        if script_id in self.script_queue:
            Logger.warning(f'Skip duplicate script {script_id}.')
            return
        # Grab start script command(s).
        script_commands = self.resolve_script_actions(script_type, script_id)
        if not script_commands:
            if self.owner.get_type_id() == ObjectTypeIds.ID_UNIT and self.owner.creature_template.script_name:
                Logger.warning(f'Unimplemented advanced script: {self.owner.creature_template.script_name}.')
            elif self.owner.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT and self.owner.gobject_template.script_name:
                Logger.warning(f'Unimplemented advanced script: {self.owner.gobject_template.script_name}.')
            return
        script_commands.sort(key=lambda command: command.delay)
        new_script = Script(script_id, script_commands, source, target, self, delay=delay, ooc_event=ooc_event)
        self.script_queue.add(new_script)

    # noinspection PyMethodMayBeStatic
    def handle_script_command_execution(self, script_command):
        try:
            SCRIPT_COMMANDS[script_command.command](script_command)
        except KeyError:
            Logger.warning(f'Unknown script command: {script_command.command}.')

    # noinspection PyMethodMayBeStatic
    def resolve_script_actions(self, script_type, script_id):
        try:
            return SCRIPT_TYPES[script_type](script_id)
        except KeyError:
            Logger.warning(f'Unknown script type: {script_type}.')
            return None

    def reset(self):
        self.script_queue.clear()
        self.ooc_events.clear()

    def update(self, now):
        # Update scripts, each one can contain multiple script actions.
        for script in list(self.script_queue):
            script.update(now)
            if not script.is_complete():
                continue
            # Finished all actions, remove.
            self.script_queue.remove(script)

        # Check if we need to initialize or remove ooc event.
        self._check_ooc_events(now)

    def _check_ooc_events(self, now):
        if not self.ooc_events:
            return
        if self.owner.in_combat or self.owner.is_evading:
            return

        for event_id, ooc_event in list(self.ooc_events.items()):
            # Check if we should remove the ongoing ooc event.
            if ooc_event.started and ooc_event.is_complete(now):
                ooc_event.started = False
                # Should not repeat, remove.
                if event_id in self.ooc_ignore:
                    self.ooc_events.pop(event_id)
            elif not ooc_event.started and ooc_event.check_phase():
                # Initialize the ooc event.
                ooc_event.initialize(now)
                for script_id in ooc_event.script_ids:
                    self.enqueue_script(self.owner, ooc_event.target, script_type=ScriptTypes.SCRIPT_TYPE_AI,
                                        script_id=script_id, delay=ooc_event.delay, ooc_event=ooc_event)

    def set_random_ooc_event(self, target, event, forced=False):
        if not ConditionChecker.validate(event.condition_id, self.owner, target):
            return

        # Ignored or already running a script.
        if event.id in self.ooc_ignore or event.id in self.ooc_events:
            if not forced:
                return
            # Event is already in, force it.
            if event.id in self.ooc_events:
                self.ooc_events[event.id].force()
                return
            # Remove from ignored if needed.
            if event.id in self.ooc_ignore:
                self.ooc_ignore.remove(event.id)

        occ_event = ScriptOocEvent(event, target, self.owner, forced=forced)
        # Has no scripts, ignore.
        if not occ_event.scripts:
            self.ooc_ignore.add(event.id)
            return

        self.ooc_events[event.id] = occ_event
        if not occ_event.should_repeat():
            self.ooc_ignore.add(event.id)

    # Handlers

    @staticmethod
    def handle_script_command_start_script(command):
        # source = Map
        # datalong1-4 = event_script id
        # dataint1-4 = chance (total cant be above 100)
        scripts = [datalong for datalong in ScriptHelpers.get_filtered_datalong(command)]
        weights = [dataint for dataint in ScriptHelpers.get_filtered_dataint(command)]
        script_id = random.choices(scripts, cum_weights=weights, k=1)[0]
        command.source.script_handler.enqueue_script(source=command.source, target=command.target,
                                                     script_type=ScriptTypes.SCRIPT_TYPE_GENERIC,
                                                     script_id=script_id)

    @staticmethod
    def handle_script_command_talk(command):
        # source = WorldObject
        # target = Unit/None
        # datalong = chat_type (see enum ChatType)
        # dataint = broadcast_text id. dataint2-4 optional for random selected text.
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return

        texts = ScriptHelpers.get_filtered_dataint(command)
        if texts:
            text_id = random.choice(texts)
            broadcast_message = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(text_id)
        else:
            Logger.warning(f'ScriptHandler: Broadcast messages for {command.get_info()}, not found.')
            return

        if command.source.get_type_id() != ObjectTypeIds.ID_UNIT:
            Logger.warning(f'ScriptHandler: Wrong target type, aborting {command.get_info()}.')
            return

        if command.source.gender == Genders.GENDER_MALE and broadcast_message.male_text:
            text_to_say = broadcast_message.male_text
        elif command.source.gender == Genders.GENDER_FEMALE and broadcast_message.female_text:
            text_to_say = broadcast_message.female_text
        else:
            text_to_say = broadcast_message.male_text if broadcast_message.male_text else broadcast_message.female_text

        if not text_to_say:
            Logger.warning(f'ScriptHandler: Broadcast message {text_id} has no text to say.')
            return

        chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_SAY
        lang = broadcast_message.language_id
        if broadcast_message.chat_type == BroadcastMessageType.BROADCAST_MSG_YELL:
            chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_YELL
        elif broadcast_message.chat_type == BroadcastMessageType.BROADCAST_MSG_EMOTE:
            chat_msg_type = ChatMsgs.CHAT_MSG_MONSTER_EMOTE
            lang = Languages.LANG_UNIVERSAL
        
        ChatManager.send_monster_message(command.source, text_to_say, chat_msg_type, lang,
                                         ChatHandler.get_range_by_type(chat_msg_type), command.target)

        # Neither emote_delay nor emote_id2 or emote_id3 seem to be ever used so let's just skip them.
        if broadcast_message.emote_id1 != 0:
            command.source.play_emote(broadcast_message.emote_id1)

    @staticmethod
    def handle_script_command_emote(command):
        # source = Unit
        # datalong1-4 = emote_id
        # dataint = (bool) is_targeted
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return
        emotes = ScriptHelpers.get_filtered_datalong(command)
        if emotes:
            command.source.play_emote(random.choice(emotes))
            if command.dataint and command.target:
                # TODO: Properly handle delays and returning back to default orientation.
                #  https://github.com/vmangos/core/blob/1ee2d05c4532e89ddce76740e5888ff873ce2623/src/game/Maps/ScriptCommands.cpp#L88
                command.source.movement_manager.face_target(command.target)

    @staticmethod
    def handle_script_command_field_set(_command):
        # source = Object
        # datalong = field_id
        # datalong2 = value
        Logger.debug('ScriptHandler: handle_script_command_field_set not implemented yet')

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
        if not command.source or not command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: Invalid source, aborting {command.get_info()}.')
            return

        coordinates_type = command.datalong
        time_ = command.datalong2
        # movement_options = script.datalong3  # Not used for now.
        # move_to_flags = script.datalong4  # Not used for now.
        # path_id = script.dataint  # Not used for now.
        speed = config.Unit.Defaults.walk_speed  # VMaNGOS sets this to zero by default for whatever reason.
        angle = 0
        location = None

        if coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_NORMAL:
            location = Vector(command.x, command.y, command.z, command.o)
            distance = command.source.location.distance(location)
            speed = distance / time_ * 0.001 if time_ > 0 else config.Unit.Defaults.walk_speed
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RELATIVE_TO_TARGET and command.target:
            location = Vector(command.target.location.x + command.x, command.target.location.y + command.y,
                              command.target.location.z + command.z, command.o)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_DISTANCE_FROM_TARGET:
            distance = command.x
            angle = command.source.location.o if command.o < 0 else random.uniform(0, 2 * math.pi)
            target_point = command.source.location.get_point_in_radius_and_angle(distance, angle)
            location = Vector(target_point.x, target_point.y, target_point.z, command.o)
        elif coordinates_type == MoveToCoordinateTypes.SO_MOVETO_COORDINATES_RANDOM_POINT:
            # Unclear how this works as the data doesn't seem to provide any information about the radius.
            return

        if angle:
            command.source.movement_manager.set_face_angle(angle)
        if location:
            command.source.movement_manager.move_to_point(location, speed)

    @staticmethod
    def handle_script_command_modify_flags(command):
        # source = Object
        # datalong = field_id
        # datalong2 = raw bitmask
        # datalong3 = ModifyFlagsOptions
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return

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

        flag_equivalences_5875_to_3368: dict[int, tuple[int, int, callable]] = {
            # GAMEOBJECT_FLAGS
            9: (GameObjectFields.GAMEOBJECT_FLAGS, command.source.flags, command.source.set_uint32)
            if command.source.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT else (None, None, None),
            # GAMEOBJECT_DYN_FLAGS
            19: (GameObjectFields.GAMEOBJECT_DYN_FLAGS, command.source.flags, command.source.set_uint32)
            if command.source.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT else (None, None, None),
            # UNIT_FIELD_FLAGS
            46: (UnitFields.UNIT_FIELD_FLAGS, command.source.unit_flags, command.source.set_uint32)
            if command.source.get_type_id() == ObjectTypeIds.ID_UNIT else (None, None, None),
            # UNIT_DYNAMIC_FLAGS
            143: (UnitFields.UNIT_DYNAMIC_FLAGS, command.source.dynamic_flags, command.source.set_uint32)
            if command.source.get_type_id() == ObjectTypeIds.ID_UNIT else (None, None, None),
            # UNIT_NPC_FLAGS
            147: (UnitFields.UNIT_FIELD_BYTES_1, command.source.npc_flags, command.source.set_npc_flag)
            if command.source.get_type_id() == ObjectTypeIds.ID_UNIT else (None, None, None),
            # PLAYER_FLAGS
            190: (PlayerFields.PLAYER_BYTES_2, command.source.player.extra_flags, command.source.player.set_extra_flag)
            if command.source.get_type_id() == ObjectTypeIds.ID_PLAYER else (None, None, None)
        }

        try:
            flag_data = flag_equivalences_5875_to_3368[command.datalong]
        except KeyError:
            Logger.warning(f'ScriptHandler: Equivalence for 5875 flags not found ({command.datalong}), '
                           f'aborting {command.get_info()}.')
            return

        # TODO: Finish adding more equivalences.
        # Value equivalences.  # TODO: Do this on loading?
        # Npc flags.
        if flag_data[0] == UnitFields.UNIT_FIELD_BYTES_1:
            npc_flags = 0x0
            if command.datalong2 & 0x4:  # Vendor.
                npc_flags |= NpcFlags.NPC_FLAG_VENDOR
            if command.datalong2 & 0x2:  # Quest giver.
                npc_flags |= NpcFlags.NPC_FLAG_QUESTGIVER
            if command.datalong2 & 0x8:  # Flight master
                npc_flags |= NpcFlags.NPC_FLAG_FLIGHTMASTER
            if command.datalong2 & 0x10:  # Trainer.
                npc_flags |= NpcFlags.NPC_FLAG_TRAINER
            if command.datalong2 & 0x80:  # Innkeeper.
                npc_flags |= NpcFlags.NPC_FLAG_BINDER
            if command.datalong2 & 0x100:  # Banker.
                npc_flags |= NpcFlags.NPC_FLAG_BANKER
            if command.datalong2 & 0x400:  # Tabard designer.
                npc_flags |= NpcFlags.NPC_FLAG_TABARDDESIGNER
            if command.datalong2 & 0x200:  # Petitioner.
                npc_flags |= NpcFlags.NPC_FLAG_PETITIONER
            command.datalong2 = npc_flags
        # Player extra flags.
        elif flag_data[0] == PlayerFields.PLAYER_BYTES_2:
            # TODO: Not implemented, doesn't seem relevant for 0.5.3 as PlayerFlags are very limited.
            return

        # Set flag.
        if command.datalong3 == ModifyFlagsOptions.SO_MODIFYFLAGS_SET:
            if flag_data[0] == UnitFields.UNIT_FIELD_BYTES_1 or flag_data[0] == PlayerFields.PLAYER_BYTES_2:
                flag_data[2](command.datalong2)
            else:
                flag_data[2](flag_data[0], command.datalong2)
        # Remove flag.
        elif command.datalong3 == ModifyFlagsOptions.SO_MODIFYFLAGS_REMOVE:
            if flag_data[0] == UnitFields.UNIT_FIELD_BYTES_1 or flag_data[0] == PlayerFields.PLAYER_BYTES_2:
                flag_data[2](command.datalong2, False)
            else:
                flag_data[2](flag_data[0], flag_data[1] & ~command.datalong2)
        # Toggle flag.
        elif command.datalong3 == ModifyFlagsOptions.SO_MODIFYFLAGS_TOGGLE:
            if flag_data[0] == UnitFields.UNIT_FIELD_BYTES_1 or flag_data[0] == PlayerFields.PLAYER_BYTES_2:
                # Second param means: if flag exists, remove (and viceversa).
                flag_data[2](command.datalong2, not flag_data[1] & command.datalong2)
            else:
                # Flag enabled, disable,
                if flag_data[1] & command.datalong2:
                    flag_data[2](flag_data[0], flag_data[1] & ~command.datalong2)
                # Flag disabled, enable.
                else:
                    flag_data[2](flag_data[0], command.datalong2)

    # TODO: Missing delayed handling. (SPELL_STATE_DELAYED)
    @staticmethod
    def handle_script_command_interrupt_casts(command):
        # source = Unit
        # datalong = (bool) with_delayed
        # datalong2 = spell_id (optional)
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return
        command.source.spell_manager.remove_cast_by_id(command.datalong2, interrupted=True)

    @staticmethod
    def handle_script_command_teleport_to(command):
        # source = Unit
        # datalong = map_id (only used for players but still required)
        # datalong2 = teleport_options (see enum TeleportToOptions)
        # x/y/z/o = coordinates
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return
        # Units.
        if command.source.get_type_id() == ObjectTypeIds.ID_UNIT:
            command.source.near_teleport(Vector(command.x, command.y, command.z, command.o))
            return
        # Players.
        command.source.teleport(command.datalong, Vector(command.x, command.y, command.z, command.o), is_instant=True)

    @staticmethod
    def handle_script_command_quest_explored(command):
        # source = Player (from provided source or target)
        # target = WorldObject (from provided source or target)
        # datalong = quest_id
        # datalong2 = distance or 0
        # datalong3 = (bool) group
        quest_target = None
        if not ConditionChecker.is_player(command.source) and not ConditionChecker.is_player(command.target):
            Logger.warning('ScriptHandler: handle_script_command_quest_explored failed, no player found!')
            return True  # Abort.

        player = command.source if ConditionChecker.is_player(command.source) else command.target
        quest_giver = command.target if ConditionChecker.is_player(command.source) else command.source

        if not quest_giver:
            Logger.warning('ScriptHandler: handle_script_command_quest_explored failed, no quest_target found!')
            return True

        if command.datalong not in player.quest_manager.active_quests:
            return True

        in_range = player.location.distance(quest_giver.location) <= command.datalong2
        if command.datalong3 and player.group_manager and in_range:
            player.group_manager.reward_quest_completion(player, command.datalong)
            return

        if in_range:
            player.quest_manager.active_quests[command.datalong].set_explored_or_event_complete()
            player.quest_manager.reward_quest_event()

    @staticmethod
    def handle_script_command_kill_credit(_command):
        # source = Player (from provided source or target)
        # datalong = creature entry
        # datalong2 = bool (0=personal credit, 1=group credit)
        Logger.debug('ScriptHandler: handle_script_command_kill_credit not implemented yet')

    @staticmethod
    def handle_script_command_respawn_gameobject(command):
        # source = Map
        # target = GameObject (from datalong, provided source or target)
        # datalong = db_guid
        # datalong2 = despawn_delay
        go_spawn = MapManager.get_surrounding_gameobject_spawn_by_spawn_id(command.source, command.datalong)
        if not go_spawn:
            Logger.warning(f'ScriptHandler: No gameobject {command.datalong} found, aborting {command.get_info()}.')
            return
        go_spawn.spawn(ttl=command.datalong2)

    @staticmethod
    def handle_script_command_despawn_gameobject(command):
        # source = GameObject(from datalong, provided source or target)
        # datalong = db_guid
        # datalong2 = despawn_delay
        go_spawn = MapManager.get_surrounding_gameobject_spawn_by_spawn_id(command.source, command.datalong)
        if not go_spawn:
            Logger.warning(f'ScriptHandler: No gameobject {command.datalong} found, aborting {command.get_info()}.')
            return
        go_spawn.despawn(ttl=command.datalong2)

    @staticmethod
    def handle_script_command_temp_summon_creature(command):
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
            return
        
        if command.datalong3:
            units = MapManager.get_surrounding_units_by_location(command.source.location, command.source.map_id,
                                                                 command.source.instance_id, command.datalong4)
            summoned = [unit for unit in units if unit.creature_template.entry == command.datalong]
            if summoned and len(summoned) >= command.datalong3:
                return

        creature_manager = CreatureBuilder.create(command.datalong, Vector(command.x, command.y, command.z, command.o),
                                                  command.source.map_id, command.source.instance_id,
                                                  ttl=command.datalong2 / 1000,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC
                                                  if command.dataint4 > 0
                                                  else CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON)
        if not creature_manager:
            return
        MapManager.spawn_object(world_object_instance=creature_manager)

        # Generic script.
        if command.dataint2:
            creature_manager.script_handler.enqueue_script(source=creature_manager, target=None,
                                                           script_type=ScriptTypes.SCRIPT_TYPE_GENERIC,
                                                           script_id=command.dataint2)
        # Attack target.
        if command.dataint3 <= 0:  # Can be -1.
            return

        from game.world.managers.objects.script.ScriptManager import ScriptManager
        attack_target = ScriptManager.get_target_by_type(command.source, command.target, command.dataint3)
        if attack_target and attack_target.is_alive:
            creature_manager.attack(attack_target)

        # TODO: dataint = flags. Needs an enum and handling.
        # TODO: dataint4 = despawn_type. Not currently supported by CreatureBuilder.create() so this needs to be added.
        #  For now we just use TEMP_SUMMON if dataint4 is not 0 and SUBTYPE_GENERIC if it is.

    @staticmethod
    def handle_script_command_open_door(command):
        # source = GameObject (from datalong, provided source or target)
        # If provided target is BUTTON GameObject, command is run on it too.
        # datalong = db_guid
        # datalong2 = reset_delay
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return

        provided_spawn_id = command.datalong
        if provided_spawn_id:
            gobject_spawn = MapManager.get_surrounding_gameobject_spawn_by_spawn_id(command.source, provided_spawn_id)
            if not gobject_spawn:
                Logger.warning(f'ScriptHandler: Aborting {command.get_info()}, '
                               f'Gameobject with Spawn ID {provided_spawn_id} not found.')
                return
            gobject_spawn.gameobject_instance.use()
        elif command.source.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            command.source.use()

        if command.target and command.target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT and \
                command.target.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            command.target.use()

        # TODO: Handle reset_delay

    @staticmethod
    def handle_script_command_close_door(command):
        # source = GameObject (from datalong, provided source or target)
        # If provided target is BUTTON GameObject, command is run on it too.
        # datalong = db_guid
        # datalong2 = reset_delay
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return

        provided_spawn_id = command.datalong
        if provided_spawn_id:
            gobject_spawn = MapManager.get_surrounding_gameobject_spawn_by_spawn_id(command.source, provided_spawn_id)
            if not gobject_spawn:
                Logger.warning(f'ScriptHandler: Aborting {command.get_info()}, '
                               f'Gameobject with Spawn ID {provided_spawn_id} not found.')
                return
            gobject_spawn.gameobject_instance.set_ready()
        elif command.source.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            command.source.set_ready()

        if command.target and command.target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT and \
                command.target.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            command.target.set_ready()

        # TODO: Handle reset_delay

    @staticmethod
    def handle_script_command_activate_object(command):
        # source = GameObject
        # target = Unit
        if command.target:
            target = command.target
        elif command.source:
            target = command.source
        else:
            Logger.warning(f'ScriptHandler: No source or target, aborting {command.get_info()}')
            return

        if target.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT:
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return

        target.use()

    @staticmethod
    def handle_script_command_remove_aura(command):
        # source = Unit
        # datalong = spell_id
        if command.source and command.source.aura_manager:
            command.source.aura_manager.cancel_auras_by_spell_id(command.datalong)
        else:
            Logger.warning(f'ScriptHandler: No aura manager found, aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_cast_spell(command):
        # source = Unit
        # target = Unit
        # datalong = spell_id
        # datalong2 = eCastSpellFlags
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return

        spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(command.datalong)
        if not spell_entry:
            return

        target = command.target if command.target else command.source
        target_mask = SpellTargetMask.UNIT if command.target else SpellTargetMask.SELF
        targets_terrain = spell_entry.Targets & SpellTargetMask.CAN_TARGET_TERRAIN
        if targets_terrain:
            target = target.location
            target_mask = SpellTargetMask.DEST_LOCATION

        spell = command.source.spell_manager.try_initialize_spell(spell_entry, target, target_mask, validate=False)
        if command.datalong2 & CastFlags.CF_TRIGGERED:
            spell.force_instant_cast()
        elif not targets_terrain and command.source.get_type_id() == ObjectTypeIds.ID_UNIT:
            cast_result = command.source.object_ai.try_to_cast(target, spell, command.datalong2, chance=100)
            if cast_result != SpellCheckCastResult.SPELL_NO_ERROR:
                Logger.warning(f'[Script] Unable to cast spell {command.datalong}, script_id {command.script_id}.')
                return

        command.source.spell_manager.start_spell_cast(initialized_spell=spell)

    @staticmethod
    def handle_script_command_create_item(command):
        # source = Player (from provided source or target)
        # datalong = item_id
        # datalong2 = amount
        if command.source and command.source.inventory:
            command.source.inventory.add_item(command.datalong, command.datalong2)
        else:
            Logger.warning(f'ScriptHandler: No inventory found, aborting aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_despawn_creature(command):
        # source = Creature
        # datalong = despawn_delay
        if command.source and command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT and command.source.is_alive:
            # TODO: handle despawn delay
            command.source.despawn()
        else:
            Logger.warning(f'ScriptHandler: No valid source found or source is dead, aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_set_equipment(command):
        # source = Creature
        # datalong = (bool) reset_default
        # dataint = main-hand item_id
        # dataint2 = off-hand item_id
        # dataint3 = ranged item_id
        if not command.source or not command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: No creature manager found, aborting {command.get_info()}.')
            return

        if command.datalong == 1:
            command.source.reset_virtual_equipment()
            return

        if command.dataint > 0:
            command.source.set_virtual_equipment(0, command.dataint)
        if command.dataint2 > 0:
            command.source.set_virtual_equipment(1, command.dataint2)
        if command.dataint3 > 0:
            command.source.set_virtual_equipment(2, command.dataint3)

    @staticmethod
    def handle_script_command_movement(command):
        # source = Creature
        # datalong = see enum MovementGeneratorType (not all are supported)
        # datalong2 = bool_param (meaning depends on the motion type)
        # datalong3 = int_param (meaning depends on the motion type)
        # datalong4 = (bool) clear
        # x = distance (only for some motion types)
        # o = angle (only for some motion types)
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return
        Logger.debug('ScriptHandler: handle_script_command_movement not implemented yet')

    @staticmethod
    def handle_script_command_set_activeobject(_command):
        # source = Creature
        # datalong = (bool) 0=off, 1=on
        Logger.debug('ScriptHandler: handle_script_command_set_activeobject not implemented yet')

    @staticmethod
    def handle_script_command_set_faction(command):
        # source = Creature
        # datalong = faction_Id,
        # datalong2 = see enum TemporaryFactionFlags
        if not command.source or not command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: No creature manager found, aborting {command.get_info()}.')
            return
        if not command.datalong:
            command.source.reset_faction()
        else:
            command.source.set_faction(command.datalong)

    @staticmethod
    def handle_script_command_morph_to_entry_or_model(command):
        # source = Unit
        # datalong = creature_id/display_id (depend on datalong2)
        # datalong2 = (bool) is_display_id
        if not command.source or not command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: No creature manager found, aborting {command.get_info()}.')
            return

        if not command.source.is_alive:
            return

        creature_or_model_entry = command.datalong
        display_id = command.datalong2

        if not creature_or_model_entry:
            command.source.reset_display_id()
            return
        elif display_id:
            command.source.set_display_id(display_id)
            return

        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creature_or_model_entry)
        if creature_template:
            command.source.set_display_id(creature_template.display_id)
        else:
            Logger.warning(f'ScriptHandler: No creature template found, aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_mount_to_entry_or_model(command):
        # source = Creature
        # datalong = creature_id/display_id (depend on datalong2)
        # datalong2 = (bool) is_display_id
        # datalong3 = (bool) permanent
        if not command.source or not command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: No creature manager found, aborting {command.get_info()}.')
            return

        if not command.source.is_alive:
            return

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
            if creature_template and creature_template.display_id:
                command.source.mount(creature_template.display_id)
            else:
                command.source.unmount()

    @staticmethod
    def handle_script_command_set_run(command):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not command.source or not command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            Logger.warning(f'ScriptHandler: No creature manager found, aborting {command.get_info()}.')
            return

        run_enabled = command.datalong == 1
        if run_enabled:
            command.source.set_move_flag(MoveFlags.MOVEFLAG_WALK, active=False)
        else:
            command.source.set_move_flag(MoveFlags.MOVEFLAG_WALK, active=True)

    @staticmethod
    def handle_script_command_attack_start(command):
        # source = Creature
        # target = Player
        if not command.source:
            Logger.warning(f'ScriptHandler: Invalid attacker, aborting {command.get_info()}.')
            return

        attacker = command.source
        victim = command.target

        if victim and victim.is_alive:
            attacker.attack(victim)
        else:
            Logger.warning(f'ScriptHandler: Unable to resolve target, aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_update_entry(_command):
        # source = Creature
        # datalong = creature_entry
        Logger.debug('ScriptHandler: handle_script_command_update_entry not implemented yet')

    @staticmethod
    def handle_script_command_stand_state(command):
        # source = Unit
        # datalong = stand_state (enum UnitStandStateType)
        if command.source and command.source.is_alive:
            command.source.set_stand_state(command.datalong)
        else:
            Logger.warning(f'ScriptHandler: No source found or source is dead, aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_modify_threat(_command):
        # source = Creature
        # datalong = eModifyThreatTargets
        # x = percent
        Logger.debug('ScriptHandler: handle_script_command_modify_threat not implemented yet')

    @staticmethod
    def handle_script_command_terminate_script(_command):
        # source = Any
        # datalong = creature_entry
        # datalong2 = search_distance
        # datalong3 = eTerminateScriptOptions
        Logger.debug('ScriptHandler: handle_script_command_terminate_script not implemented yet')

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
            return

        _target = None
        if ConditionChecker.is_player(command.source):
            _target = command.source
        elif command.target and ConditionChecker.is_player(command.target):
            _target = command.target

        if result:
            command.script.abort()

        if not _target:
            Logger.warning(f'ScriptHandler: Invalid target, aborting {command.get_info()}.')
            return

        if _target.online and result:
            if _target.group_manager:
                _target.group_manager.fail_quest_for_group(_target, command.datalong2)
            else:
                _target.quest_manager.fail_quest_by_id(command.datalong2)

    @staticmethod
    def handle_script_command_enter_evade_mode(command):
        # source = Creature
        if command.source and command.source.object_ai:
            command.source.leave_combat()
        else:
            Logger.warning(f'ScriptHandler: Invalid target, aborting {command.get_info()}.')

    @staticmethod
    def handle_script_command_set_home_position(command):
        # source = Creature
        # datalong = eSetHomePositionOptions
        # x/y/z/o = coordinates
        if not command.source or command.source.get_type_id() != ObjectTypeIds.ID_UNIT:
            Logger.warning(f'ScriptHandler: Invalid source, aborting {command.get_info()}.')
            return

        if not command.source.spawn_id:
            Logger.warning(f'ScriptHandler: No spawn id, aborting {command.get_info()}.')
            return

        # All other SetHomePositionOptions are not valid for 0.5.3.
        if command.datalong != SetHomePositionOptions.SET_HOME_DEFAULT_POSITION:
            return

        spawn = WorldDatabaseManager.creature_spawn_get_by_spawn_id(command.source.spawn_id)
        if not spawn:
            Logger.warning(f'ScriptHandler: Unable to locate spawn, aborting {command.get_info()}.')
            return

        command.source.spawn_position = spawn.get_default_location()

    @staticmethod
    def handle_script_command_turn_to(command):
        # source = Unit
        # target = WorldObject (optional depending on TurnToFacingOptions)
        # o = angle to turn to (optional depending on TurnToFacingOptions)
        # datalong = eTurnToFacingOptions
        if not command.source:
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}).')
            return

        if not command.target and command.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
            Logger.warning(f'ScriptHandler: No target found, aborting {command.get_info()}).')
            return

        if command.datalong == TurnToFacingOptions.SO_TURNTO_FACE_TARGET:
            command.source.movement_manager.face_target(command.target)
        else:
            command.source.movement_manager.face_angle(command.o)

    @staticmethod
    def handle_script_command_set_inst_data(_command):
        # source = Map
        # datalong = field
        # datalong2 = data
        # datalong3 = eSetInstDataOptions
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data not implemented yet')

    @staticmethod
    def handle_script_command_set_inst_data64(_command):
        # source = Map
        # target = Object (when saving guid)
        # datalong = field
        # datalong2 = data
        # datalong3 = eSetInstData64Options
        Logger.debug('ScriptHandler: handle_script_command_set_inst_data64 not implemented yet')

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
        else:
            Logger.warning('ScriptHandler: Neither source nor target are a player, aborting SCRIPT_COMMAND_REMOVE_ITEM')

    @staticmethod
    def handle_script_command_remove_object(_command):
        # source = GameObject
        # target = Unit
        Logger.debug('ScriptHandler: handle_script_command_remove_object not implemented yet')

    @staticmethod
    def handle_script_command_set_melee_attack(command):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not command.source:
            Logger.warning(f'ScriptHandler: Invalid source, aborting {command.get_info()}.')
            return
        command.source.object_ai.set_melee_attack(command.datalong > 0)

    @staticmethod
    def handle_script_command_set_combat_movement(command):
        # source = Creature
        # datalong = (bool) 0 = off, 1 = on
        if not command.source or not ConditionChecker.is_creature(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, aborting {command.get_info()}.')
            return

        command.source.object_ai.set_combat_movement(command.datalong > 0)

    @staticmethod
    def handle_script_command_set_phase(command):
        # source = Creature
        # datalong = phase
        # datalong2 = eSetPhaseOptions
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, aborting {command.get_info()}.')
            return

        if command.datalong2 == SetPhaseOptions.SO_SETPHASE_RAW:
            command.source.object_ai.script_phase = command.datalong
        elif command.datalong2 == SetPhaseOptions.SO_SETPHASE_INCREMENT:
            command.source.object_ai.script_phase += command.datalong
        elif command.datalong2 == SetPhaseOptions.SO_SETPHASE_DECREMENT:
            command.source.object_ai.script_phase = max(0, command.source.object_ai.script_phase - command.datalong)

    @staticmethod
    def handle_script_command_set_phase_random(command):
        # source = Creature
        # datalong1-4 = phase
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, aborting {command.get_info()}.')
            return
        command.source.object_ai.script_phase = random.choice([command.datalong1, command.datalong2,
                                                               command.datalong3, command.datalong4])

    @staticmethod
    def handle_script_command_set_phase_range(command):
        # source = Creature
        # datalong = phase_min
        # datalong2 = phase_max
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, aborting {command.get_info()}')
            return
        command.source.object_ai.script_phase = random.randrange(command.datalong, command.datalong2)

    @staticmethod
    def handle_script_command_flee(command):
        # source = Creature
        # datalong = seek_assistance (bool) 0 = off, 1 = on
        if not command.source or not command.source.is_alive:
            Logger.warning(f'ScriptHandler: No source or source is dead, aborting {command.get_info()}')
            return

        flee_text = WorldDatabaseManager.BroadcastTextHolder.broadcast_text_get_by_id(1150)
        command.source.set_unit_flag(UnitFlags.UNIT_FLAG_FLEEING, True)
        ChatManager.send_monster_message(command.source, flee_text.male_text,
                                         ChatMsgs.CHAT_MSG_MONSTER_EMOTE, Languages.LANG_UNIVERSAL,
                                         ChatHandler.get_range_by_type(ChatMsgs.CHAT_MSG_MONSTER_EMOTE),
                                         command.target)
        if command.source.spell_manager:
            command.source.spell_manager.remove_casts(remove_active=False)
        command.source.movement_manager.move_fear(duration_seconds=7)  # Flee for 7 seconds.

    @staticmethod
    def handle_script_command_deal_damage(command):
        # source = Unit
        # target = Unit
        # datalong = damage
        # datalong2 = (bool) is_percent
        if not command.source or not command.target:
            Logger.warning(f'ScriptHandler: No source or no target, aborting {command.get_info()}')
            return

        if command.datalong2 == 1:
            # Damage is a percentage of the target's health.
            damage_to_deal = int(command.target.health * (command.datalong / 100))
        else:
            damage_to_deal = command.datalong

        if damage_to_deal > 0:
            attacker = command.source if command.source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT else None
            damage_info = DamageInfoHolder(attacker=attacker, target=command.target, total_damage=damage_to_deal,
                                           damage_school_mask=SpellSchoolMask.SPELL_SCHOOL_MASK_NORMAL)
            command.source.deal_damage(command.target, damage_info)
        else:
            Logger.warning(f'ScriptHandler: Attempted to deal 0 damage, aborting {command.get_info()}')

    @staticmethod
    def handle_script_command_set_sheath(command):
        # source = Unit
        # datalong = see enum WeaponMode
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, aborting {command.get_info()}')
            return
        # 0.5.3 weapon modes for sheathed and unsheathed status are swapped compared to later versions.
        # In order to keep full compatibility with VMaNGOS scripts, we do the swap here instead of changing the value
        # in the database.
        weapon_mode = command.datalong ^ 1 if command.datalong < 2 else command.datalong
        command.source.set_weapon_mode(weapon_mode)

    @staticmethod
    def handle_script_command_invincibility(command):
        # source = Creature
        # datalong = health
        # datalong2 = (bool) is_percent
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, aborting {command.get_info()}')
            return
        invincibility_hp_lvl = command.source.max_health * command.datalong / 100 if command.datalong2 else \
            command.datalong
        command.source.invincibility_hp_level = invincibility_hp_lvl

    @staticmethod
    def handle_script_command_game_event(_command):
        # source = None
        # datalong = event_id
        # datalong2 = (bool) start
        # datalong3 = (bool) overwrite
        Logger.debug('ScriptHandler: handle_script_command_game_event not implemented yet')

    @staticmethod
    def handle_script_command_set_server_variable(_command):
        # source = None
        # datalong = index
        # datalong2 = value
        Logger.debug('ScriptHandler: handle_script_command_set_server_variable not implemented yet')

    @staticmethod
    def handle_script_command_remove_guardians(_command):
        # source = Unit
        # datalong = creature_id
        Logger.debug('ScriptHandler: handle_script_command_remove_guardians not implemented yet')

    @staticmethod
    def handle_script_command_add_spell_cooldown(command):
        # source = Unit
        # datalong = spell_id
        # datalong2 = cooldown in seconds
        if not command.source or not ConditionChecker.is_unit(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, aborting {command.get_info()}.')
            return

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(command.datalong)
        if not spell:
            Logger.warning(f'ScriptHandler: Invalid spell Id, aborting {command.get_info()}.')
            return

        command.source.spell_manager.set_on_cooldown(spell, command.datalong2 * 1000)

    @staticmethod
    def handle_script_command_remove_spell_cooldown(command):
        # source = Unit
        # datalong = spell_id
        if not command.source or not ConditionChecker.is_unit(command.source):
            Logger.warning(f'ScriptHandler: Invalid source, aborting {command.get_info()}.')
            return

        command.source.spell_manager.unlock_spell_cooldown(command.datalong)

    @staticmethod
    def handle_script_command_set_react_state(_command):
        # source = Creature
        # datalong = see enum ReactStates
        Logger.debug('ScriptHandler: handle_script_command_set_react_state not implemented yet')

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
            Logger.warning(f'ScriptHandler: No source found, aborting {command.get_info()}.')
            return
        move_info = CommandMoveInfo(wp_source=WaypointPathOrigin(command.datalong), start_point=command.datalong2,
                                    initial_delay=command.datalong3, repeat=command.datalong4 > 0,
                                    overwrite_guid=command.dataint, overwrite_entry=command.dataint2)
        command.source.movement_manager.move_automatic_waypoints_from_script(command_move_info=move_info)

    @staticmethod
    def handle_script_command_start_map_event(command):
        # source = Map
        # datalong = event_id
        # datalong2 = time_limit
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_start_map_event invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.add_event(command.source, command.target, command.source.map_id, command.datalong,
                                         command.datalong2, command.dataint, command.dataint2, command.dataint3,
                                         command.dataint4)

    @staticmethod
    def handle_script_command_end_map_event(command):
        # source = Map
        # datalong = event_id
        # datalong2 = (bool) success
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_end_map_event invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.end_event(command.datalong, command.datalong2)

    @staticmethod
    def handle_script_command_add_map_event_target(command):
        # source = Map
        # target = WorldObject
        # datalong = event_id
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_add_map_event_target invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.add_event_target(command.target, command.datalong, command.dataint,
                                                command.dataint2, command.dataint3, command.dataint4)

    @staticmethod
    def handle_script_command_remove_map_event_target(command):
        # source = Map
        # target = WorldObject
        # datalong = event_id
        # datalong2 = condition_id
        # datalong3 = eRemoveMapEventTargetOptions
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_remove_map_event_target invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.remove_event_target(command.target, command.datalong, command.datalong2,
                                                   command.datalong3)

    @staticmethod
    def handle_script_command_set_map_event_data(command):
        # source = Map
        # datalong = event_id
        # datalong2 = index
        # datalong3 = data
        # datalong4 = eSetMapScriptDataOptions
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_set_map_event_data invalid map '
                           f'({command.source.map_id}) and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.set_event_data(command.datalong, command.datalong2, command.datalong3,
                                              command.datalong4)

    @staticmethod
    def handle_script_command_send_map_event(command):
        # source = Map
        # datalong = event_id
        # datalong2 = data
        # datalong3 = eSendMapEventOptions
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_send_map_event invalid map ({command.source.map_id}) '
                           f'and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.send_event_data(command.datalong, command.datalong2, command.datalong3)

    @staticmethod
    def handle_script_command_set_default_movement(_command):
        # source = Creature
        # datalong = movement_type
        # datalong2 = (bool) always_replace
        # datalong3 = param1
        Logger.debug('ScriptHandler: handle_script_command_set_default_movement not implemented yet')

    @staticmethod
    def handle_script_command_start_script_for_all(_command):
        # source = WorldObject
        # datalong = script_id
        # datalong2 = eStartScriptForAllOptions
        # datalong3 = object_entry
        # datalong4 = search_radius
        Logger.debug('ScriptHandler: handle_script_command_start_script_for_all not implemented yet')

    @staticmethod
    def handle_script_command_edit_map_event(command):
        # source = Map
        # datalong = event_id
        # dataint = success_condition
        # dataint2 = success_script
        # dataint3 = failure_condition
        # dataint4 = failure_script
        map_ = MapManager.get_map(command.source.map_id, command.source.instance_id)
        if not map_:
            Logger.warning(f'ScriptHandler: handle_script_command_edit_map_event invalid map ({command.source.map_id}) '
                           f'and/or instance ({command.source.instance_id}).')
            return

        map_.map_event_manager.edit_map_event_data(command.datalong, command.dataint, command.dataint2,
                                                   command.dataint3, command.dataint4)

    @staticmethod
    def handle_script_command_fail_quest(command):
        # source = Player
        # datalong = quest_id
        if command.source.quest_target:
            command.source.quest_target.quest_manager.fail_quest_by_id(command.datalong)
        else:
            Logger.warning('ScriptHandler: handle_script_command_fail_quest failed, no valid target')

    @staticmethod
    def handle_script_command_respawn_creature(command):
        # source = Creature
        # datalong = (bool) even_if_alive
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, aborting {command.get_info()}')
            return

        if command.datalong or not command.source.is_alive:
            command.source.despawn()
            command.source.respawn()

    @staticmethod
    def handle_script_command_assist_unit(command):
        # source = Creature
        # target = Unit
        if not command.source:
            Logger.warning(f'ScriptHandler: No source, aborting {command.get_info()}')
            return

        command.source.object_ai.assist_unit(command.target)

    @staticmethod
    def handle_script_command_combat_stop(_command):
        # source = Unit
        Logger.debug('ScriptHandler: handle_script_command_combat_stop not implemented yet')

    @staticmethod
    def handle_script_command_add_aura(_command):
        # source = Unit
        # datalong = spell_id
        # datalong2 = flags
        Logger.debug('ScriptHandler: handle_script_command_add_aura not implemented yet')

    @staticmethod
    def handle_script_command_add_threat(command):
        # source = Creature
        # target = Unit
        if not command.source or not command.target:
            Logger.warning(f'ScriptHandler: No source or target, aborting {command.get_info()}')
            return
        if command.source.is_alive and command.source.in_combat:
            command.source.threat_manager.add_threat(command.target)
        else:
            Logger.warning(f'ScriptHandler: Source is not in combat, aborting {command.get_info()}')

    @staticmethod
    def handle_script_command_summon_object(_command):
        # source = WorldObject
        # datalong = gameobject_entry
        # datalong2 = respawn_time
        # x/y/z/o = coordinates
        Logger.debug('ScriptHandler: handle_script_command_summon_object not implemented yet')

    @staticmethod
    def handle_script_command_join_creature_group(_command):
        # source = Creature
        # target = Creature
        # datalong = OptionFlags
        # x = distance
        # o = angle
        Logger.debug('ScriptHandler: handle_script_command_join_creature_group not implemented yet')

    @staticmethod
    def handle_script_command_leave_creature_group(command):
        # source = Creature
        if not command.source or not ConditionChecker.is_creature(command.source):
            Logger.warning(f'ScriptHandler: No or invalid target (must be creature), aborting {command.get_info()}')
            return

        if not command.source.creature_group:
            Logger.warning(f'ScriptHandler: No source or target, aborting {command.get_info()}')
            return

        command.source.creature_group.remove_member(command.source)

    @staticmethod
    def handle_script_command_set_go_state(command):
        # source = GameObject
        # datalong = GOState
        if command.target:
            target = command.target
        elif command.source:
            target = command.source
        else:
            Logger.warning(f'ScriptHandler: No source or target, aborting {command.get_info()}')
            return

        if target.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT:
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return

        target.set_state(GameObjectStates(command.datalong))

    @staticmethod
    def handle_script_command_quest_credit(_command):
        # source = Player (from provided source or target)
        # target = WorldObject (from provided source or target)
        Logger.debug('ScriptHandler: handle_script_command_quest_credit not implemented yet')

    @staticmethod
    def handle_script_command_send_script_event(_command):
        # source = Creature
        # target = WorldObject
        # datalong = event_id
        # datalong2 = event_data
        Logger.debug('ScriptHandler: handle_script_command_send_script_event not implemented yet')

    @staticmethod
    def handle_script_command_reset_door_or_button(command):
        # source = GameObject
        if not command.source or not ConditionChecker.is_gameobject(command.source):
            Logger.warning(f'ScriptHandler: Invalid object type (needs to be gameobject) for {command.get_info()}')
            return

        command.source.gameobject_instance.set_ready()

    @staticmethod
    def handle_script_command_set_command_state(_command):
        # source = Creature
        # datalong = command_state (see enum CommandStates)
        Logger.debug('ScriptHandler: handle_script_command_set_command_state not implemented yet')

    @staticmethod
    def handle_script_command_play_custom_anim(_command):
        # source = GameObject
        # datalong = anim_id
        Logger.debug('ScriptHandler: handle_script_command_play_custom_anim not implemented yet')

    @staticmethod
    def handle_script_command_start_script_on_group(_command):
        # source = Unit
        # datalong1-4 = generic_script id
        # dataint1-4 = chance (total cant be above 100)
        Logger.debug('ScriptHandler: handle_script_command_start_script_on_group not implemented yet')

    @staticmethod
    def handle_script_command_call_for_help(_command):
        # source = Creature
        # x = radius
        Logger.debug('ScriptHandler: handle_script_command_call_for_help not implemented yet')

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
    def handle_script_type_ai(script_id):
        return WorldDatabaseManager.CreatureAIScriptHolder.creature_ai_scripts_get_by_id(script_id)

    @staticmethod
    def handle_script_type_creature_movement(script_id):
        return WorldDatabaseManager.CreatureMovementScriptHolder.creature_movement_scripts_get_by_id(script_id)


SCRIPT_TYPES = {
    ScriptTypes.SCRIPT_TYPE_AI: ScriptHandler.handle_script_type_ai,
    ScriptTypes.SCRIPT_TYPE_QUEST_START: ScriptHandler.handle_script_type_quest_start,
    ScriptTypes.SCRIPT_TYPE_QUEST_END: ScriptHandler.handle_script_type_quest_end,
    ScriptTypes.SCRIPT_TYPE_CREATURE_MOVEMENT: ScriptHandler.handle_script_type_creature_movement,
    # ScriptTypes.SCRIPT_TYPE_CREATURE_SPELL: ScriptHandler.handle_script_type_creature_spell,
    ScriptTypes.SCRIPT_TYPE_GAMEOBJECT: ScriptHandler.handle_script_type_gameobject,
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
