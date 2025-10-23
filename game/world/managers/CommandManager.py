import hashlib
import os
from datetime import datetime
from os import path
from pathlib import Path
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import CreatureTemplate
from game.world import WorldManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.ChatManager import ChatManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from utils.ConfigManager import config
from utils.GitUtils import GitUtils
from utils.Srp6 import Srp6
from utils.TextUtils import GameTextFormatter
from utils.constants import CustomCodes
from utils.constants.MiscCodes import UnitDynamicTypes, MoveFlags
from utils.constants.SpellCodes import SpellEffects, SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, WeaponMode
from utils.constants.UpdateFields import PlayerFields

import platform


# noinspection SpellCheckingInspection,PyUnusedLocal
class CommandManager(object):

    DEV_LOG_PATH = config.Server.Logging.log_dev_path
    DEV_LOC_LOG_FILE_NAME = 'locations.log'

    DEV_LOC_LOG_FULL_PATH = path.join(DEV_LOG_PATH, DEV_LOC_LOG_FILE_NAME)

    @staticmethod
    def handle_conole_command(command_msg):
        terminator_index = command_msg.find(' ') if ' ' in command_msg else len(command_msg)
        command = command_msg[0:terminator_index].strip()
        args = command_msg[terminator_index:].strip()

        if command in CONSOLE_COMMAND_DEFINITIONS:
            command_func = CONSOLE_COMMAND_DEFINITIONS[command][0]
            return command_func(args)

        return -1, 'Invalid command'

    @staticmethod
    def handle_command(world_session, command_msg):
        terminator_index = command_msg.find(' ') if ' ' in command_msg else len(command_msg)

        command = command_msg[1:terminator_index].strip()
        args = command_msg[terminator_index:].strip()

        if command in PLAYER_COMMAND_DEFINITIONS:
            command_func = PLAYER_COMMAND_DEFINITIONS[command][0]
        elif command in GM_COMMAND_DEFINITIONS and world_session.account_mgr.is_gm():
            command_func = GM_COMMAND_DEFINITIONS[command][0]
        elif command in DEV_COMMAND_DEFINITIONS and world_session.account_mgr.is_dev():
            command_func = DEV_COMMAND_DEFINITIONS[command][0]
        else:
            ChatManager.send_system_message(world_session, 'Command not found, type .help for help.')
            return

        if command_func:
            code, res = command_func(world_session, args)
            if code != 0:
                ChatManager.send_system_message(world_session, f'Error with <{command}> command: {res}')
            elif res:
                # Split message lines to overcome buffer limits.
                lines = res.rsplit('\n')
                for line in lines:
                    ChatManager.send_system_message(world_session, line)

    @staticmethod
    def _target_or_self(world_session, only_players=False):
        player_mgr = world_session.player_mgr
        if player_mgr.current_selection and player_mgr.current_selection != player_mgr.guid:
            if only_players:
                unit = player_mgr.get_map().get_surrounding_player_by_guid(player_mgr, player_mgr.current_selection)
            else:
                unit = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection, True)
            if unit:
                return unit

        return world_session.player_mgr

    @staticmethod
    def help(world_session, args):
        total_number = 0

        # If player is Dev, send Dev commands first.
        if world_session.account_mgr.is_dev():
            total_number += len(DEV_COMMAND_DEFINITIONS)
            ChatManager.send_system_message(world_session, '|cFFFFFFFF[Dev Commands]|r')
            for command in DEV_COMMAND_DEFINITIONS:
                ChatManager.send_system_message(world_session, f'|cFF00FFFF{command}|r: '
                                                               f'{DEV_COMMAND_DEFINITIONS[command][1]}')
            ChatManager.send_system_message(world_session, '\n')

        # If player is GM, send GM commands first.
        if world_session.account_mgr.is_gm():
            total_number += len(GM_COMMAND_DEFINITIONS)
            ChatManager.send_system_message(world_session, '|cFFFFFFFF[GM Commands]|r')
            for command in GM_COMMAND_DEFINITIONS:
                ChatManager.send_system_message(world_session, f'|cFF00FFFF{command}|r: '
                                                               f'{GM_COMMAND_DEFINITIONS[command][1]}')
            ChatManager.send_system_message(world_session, '\n')

        ChatManager.send_system_message(world_session, '|cFFFFFFFF[Player Commands]|r\n')
        total_number += len(PLAYER_COMMAND_DEFINITIONS)
        for command in PLAYER_COMMAND_DEFINITIONS:
            ChatManager.send_system_message(world_session, f'|cFF00FFFF{command}|r: '
                                                           f'{PLAYER_COMMAND_DEFINITIONS[command][1]}')

        return 0, f'{total_number} commands found.'

    @staticmethod
    def toggle_collision(world_session, args):
        state = world_session.player_mgr.toggle_collision()
        return 0, f'collision cheat {state}'

    @staticmethod
    def speed(world_session, args):
        try:
            speed = config.Unit.Defaults.run_speed * float(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            player_mgr.change_speed(speed)

            return 0, ''
        except ValueError:
            return -1, 'wrong speed value.'

    @staticmethod
    def swim_speed(world_session, args):
        try:
            speed = config.Unit.Defaults.swim_speed * float(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            player_mgr.change_swim_speed(speed)

            return 0, ''
        except ValueError:
            return -1, 'wrong speed value.'

    @staticmethod
    def gps(world_session, args):
        player_mgr = world_session.player_mgr
        map_ = player_mgr.get_map()
        player_x = player_mgr.location.x
        player_y = player_mgr.location.y
        player_z = player_mgr.location.z
        player_o = player_mgr.location.o
        maps_z, z_locked = map_.calculate_z_for_object(player_mgr)
        maps_z_str = f'{maps_z:.3f}' if not z_locked else 'Invalid'
        liq = map_.get_liquid_information(player_x, player_y, player_z)
        liq_str = f'{liq.get_height():.3f}' if liq else 'Not found'
        adt_tile = map_.get_tile(player_x, player_y)
        return 0, f'Map: {world_session.player_mgr.map_id}\n' \
                  f'InstanceID: {world_session.player_mgr.instance_id}\n' \
                  f'Zone: {world_session.player_mgr.zone}\n' \
                  f'ADT: [{adt_tile[0]},{adt_tile[1]}]\n' \
                  f'X: {player_x:.3f}, ' \
                  f'Y: {player_y:.3f}, ' \
                  f'Z: {player_z:.3f}, ' \
                  f'MapZ: {maps_z_str}, ' \
                  f'Liq: {liq_str}, ' \
                  f'O: {player_o:.3f}'

    @staticmethod
    def activate_script_waypoints(world_session, args):
        try:
            unit = CommandManager._target_or_self(world_session)
            if unit == world_session.player_mgr:
                return -1, f'invalid unit selection.'
            unit.movement_manager.move_automatic_waypoints_from_script()
            return 0, ''
        except ValueError:
            return -1, 'invalid unit selection.'

    @staticmethod
    def move_object(world_session, args):
        game_object = world_session.player_mgr.last_debug_ai_state_object
        if not game_object:
            return -1, 'invalid object selection.'

        if not game_object.is_gameobject():
            return -1, 'invalid gameobject selection.'

        try:
            player_mgr = world_session.player_mgr
            operator, prop, step = args.split()
            current_loc = game_object.location.copy()
            exec(f'current_loc.{prop} {operator}= {step}')
            from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
            new_object = GameObjectBuilder.create(game_object.entry, current_loc, player_mgr.map_id,
                                                  player_mgr.instance_id, state=1, ttl=0)
            world_session.player_mgr.get_map().spawn_object(world_object_instance=new_object)
            game_object.get_map().remove_object(game_object)
            # Replace old selection with new.
            world_session.player_mgr.last_debug_ai_state_object = new_object
            return 0, (f'{new_object.get_name()} moved to: X:{round(new_object.location.x,3)}'
                       f' Y:{round(new_object.location.y,3)} Z:{round(new_object.location.z,3)}')
        except ValueError:
            return -1, 'invalid arguments, e.g. .moveobject + z .1.'

    @staticmethod
    def distance_unit(world_session, args):
        try:
            unit = CommandManager._target_or_self(world_session)
            if unit == world_session.player_mgr:
                return -1, f'invalid unit selection.'
            return 0, f'{round(world_session.player_mgr.location.distance(unit.location), 3)}'
        except ValueError:
            return -1, 'invalid unit selection.'

    @staticmethod
    def move_unit(world_session, args):
        try:
            unit = CommandManager._target_or_self(world_session)
            if unit == world_session.player_mgr:
                return -1, f'invalid unit selection.'

            x, y, z = args.split()
            location = Vector(float(x), float(y), float(z))
            unit.movement_manager.move_to_point(location, speed=unit.running_speed)
            return 0, ''
        except ValueError:
            return -1, 'please use the "x y z" format.'

    @staticmethod
    def tel_unit(world_session, args):
        try:
            unit = CommandManager._target_or_self(world_session)
            if unit == world_session.player_mgr:
                return -1, f'invalid unit selection.'

            x, y, z = args.split()
            tel_location = Vector(float(x), float(y), float(z))
            success = unit.near_teleport(tel_location)

            if success:
                return 0, ''
            return -1, f'invalid location ({args}).'
        except ValueError:
            return -1, 'please use the "x y z" format.'

    @staticmethod
    def tel(world_session, args):
        try:
            tel_name = args.split()[0]
        except IndexError:
            return -1, 'please specify a location name.'
        location = WorldDatabaseManager.worldport_get_by_name(tel_name)

        if location:
            tel_location = Vector(location.x, location.y, location.z, location.o)
            success = world_session.player_mgr.teleport(location.map, tel_location)

            if success:
                return 0, f'Teleported to "{location.name}".'
            return -1, f'location not found ({tel_location}, {location.map}).'
        return -1, f'"{tel_name}" not found.'

    @staticmethod
    def stel(world_session, args):
        try:
            tel_name = args.split()[0]
        except IndexError:
            return -1, 'please specify a location name to start searching.'
        locations = WorldDatabaseManager.worldport_get_by_name(tel_name, return_all=True)

        for location in locations:
            port_text = f'|cFF00FFFF[Map {location.map}]|r - {location.name}'
            ChatManager.send_system_message(world_session, port_text)
        return 0, f'{len(locations)} worldports found.'

    @staticmethod
    def sitem(world_session, args):
        item_name = args.strip()
        if not item_name:
            return -1, 'please specify an item name to start searching.'
        items = WorldDatabaseManager.item_template_get_by_name(item_name, return_all=True)

        for item in items:
            item_link = GameTextFormatter.generate_item_link(item.entry, item.name, item.quality)
            item_text = f'{item.entry} - {item_link}'
            ChatManager.send_system_message(world_session, item_text)
        return 0, f'{len(items)} items found.'

    @staticmethod
    def flushbags(world_session, args):
        world_session.player_mgr.inventory.flush_bags()
        return 0, ''

    @staticmethod
    def additem(world_session, args):
        try:
            split_args = args.split()
            entry = int(split_args[0])
            if len(split_args) > 1:
                count = int(split_args[1])
            else:
                count = 1

            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            item_mgr = player_mgr.inventory.add_item(entry=entry, count=count)
            if item_mgr:
                return 0, ''
            else:
                return -1, f'unable to find and / or add item id {entry}.'
        except (IndexError, ValueError):
            return -1, 'please specify a valid item entry and the quantity (optional).'

    @staticmethod
    def additems(world_session, args):
        try:
            entries = args.split()
            added = []
            invalid = []
            for entry in entries:
                code, res = CommandManager.additem(world_session, entry)
                if code == 0:
                    added.append(entry)
                else:
                    invalid.append(entry)

            if len(entries) == len(invalid):
                return -1, f'item ID(s) {", ".join(invalid)} are not valid.'
            else:
                return 0, f'Item ID(s) {", ".join(added)} added to the inventory.'
        except ValueError:
            return -1, 'please specify one or more valid item ID(s).'

    @staticmethod
    def sspell(world_session, args):
        spell_name = args.strip()
        if not spell_name:
            return -1, 'please specify a spell name to start searching.'
        spells = DbcDatabaseManager.spell_get_by_name(spell_name)

        for spell in spells:
            spell_name = spell.Name_enUS.replace('\\', '')
            spell_text = f'{spell.ID} - |cFF00FFFF[{spell_name}]|r'
            if spell.NameSubtext_enUS:
                spell_text += f' ({spell.NameSubtext_enUS})'

            learned_spells = []
            if spell.Effect_1 == SpellEffects.SPELL_EFFECT_LEARN_SPELL:
                learned_spells.append(spell.EffectTriggerSpell_1)
            if spell.Effect_2 == SpellEffects.SPELL_EFFECT_LEARN_SPELL:
                learned_spells.append(spell.EffectTriggerSpell_2)
            if spell.Effect_3 == SpellEffects.SPELL_EFFECT_LEARN_SPELL:
                learned_spells.append(spell.EffectTriggerSpell_3)

            if learned_spells:
                learned_spells_text = ', '.join([str(spell_id) for spell_id in learned_spells])
                spell_text += f' [Teaches: {learned_spells_text}]'

            ChatManager.send_system_message(world_session, spell_text)
        return 0, f'{len(spells)} spells found.'

    @staticmethod
    def lspell(world_session, args):
        code, res = CommandManager._parse_spell_id_check_spell_exist(args)
        if code == 0:
            spell_id = res
            if not world_session.player_mgr.spell_manager.learn_spell(spell_id):
                return -1, 'unable to learn spell, already known or skill limit reached.'
            return 0, 'Spell learned.'
        return code, res

    @staticmethod
    def _parse_spell_id_check_spell_exist(args):
        try:
            spell_id = int(args)
            if not spell_id:
                return -1, 'please specify a spell ID.'
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            return (-1, 'the spell was not found.') if not spell else (0, spell_id)
        except ValueError:
            return -1, 'invalid ID.'

    @staticmethod
    def lspells(world_session, args):
        try:
            spell_ids = args.split()
            added = []
            invalid = []
            for spell_id in spell_ids:
                code, res = CommandManager.lspell(world_session, spell_id)
                if code == 0:
                    added.append(spell_id)
                else:
                    invalid.append(spell_id)

            if len(spell_ids) == len(invalid):
                return -1, f'spell ID(s) {", ".join(invalid)} are not valid.'
            else:
                return 0, f'Spell ID(s) {", ".join(added)} learned.'
        except ValueError:
            return -1, 'please specify one or more valid spell ID(s).'

    @staticmethod
    def unlspell(world_session, args):
        code, res = CommandManager._parse_spell_id_check_spell_exist(args)
        if code == 0:
            spell_id = res
            code, res = CommandManager._unlearn_spell(world_session, spell_id)
            if code == 0:
                return 0, f'{res} Spell unlearned.'
        return code, res

    @staticmethod
    def unltalent(world_session, args):
        code, res = CommandManager._parse_spell_id_check_spell_exist(args)
        if code == 0:
            spell_id = res
            code, res = CommandManager._unlearn_spell(world_session, spell_id)
            if code == 0:
                talent_cost = world_session.player_mgr.talent_manager.get_talent_cost_by_id(spell_id)
                world_session.player_mgr.add_talent_points(talent_cost)
                return 0, f'{res} Talent points were returned.'
            return code, res
        return code, res

    @staticmethod
    def _unlearn_spell(world_session, spell_id):
        if world_session.player_mgr.spell_manager.unlearn_spell(spell_id):
            world_session.player_mgr.aura_manager.cancel_auras_by_spell_id(spell_id,
                                                                           source_restriction=world_session.player_mgr)
            return 0, 'Spell unlearned.'
        return -1, 'you do not know this spell yet.'

    @staticmethod
    def cast(world_session, args):
        try:
            spell_id = int(args)
            if not spell_id:
                return -1, 'please specify a spell ID.'
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if not spell:
                return -1, 'the spell was not found.'

            unit = CommandManager._target_or_self(world_session)
            world_session.player_mgr.spell_manager.handle_cast_attempt(spell_id, unit, SpellTargetMask.UNIT,
                                                                       validate=False)
            return 0, ''
        except ValueError:
            return -1, 'invalid ID.'

    @staticmethod
    def addaura(world_session, args):
        try:
            spell_id = int(args)
            if not spell_id:
                return -1, 'please specify a spell ID.'
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if not spell:
                return -1, 'the spell was not found.'

            unit = CommandManager._target_or_self(world_session)
            spell_cast = world_session.player_mgr.spell_manager.try_initialize_spell(spell, unit,
                                                                                SpellTargetMask.UNIT, validate=False)

            for effect in spell_cast.get_effects():
                if effect.effect_type in {SpellEffects.SPELL_EFFECT_APPLY_AURA,
                                          SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA}:
                    effect.start_aura_duration()
                    unit.aura_manager.apply_spell_effect_aura(world_session.player_mgr, spell_cast, effect)

            return 0, ''
        except ValueError:
            return -1, 'invalid ID.'

    @staticmethod
    def clearauras(world_session, args):
        unit = CommandManager._target_or_self(world_session)
        unit.aura_manager.remove_all_auras()
        return 0, ''

    @staticmethod
    def sskill(world_session, args):
        skill_name = args.strip()
        if not skill_name:
            return -1, 'please specify a skill name to start searching.'
        skills = DbcDatabaseManager.skill_get_by_name(skill_name)

        for skill in skills:
            skill_name = skill.DisplayName_enUS.replace('\\', '')
            skill_text = f'{skill.ID} - |cFF00FFFF[{skill_name}]|r'
            ChatManager.send_system_message(world_session, skill_text)
        return 0, f'{len(skills)} skills found.'

    @staticmethod
    def lskill(world_session, args):
        try:
            skill_id = int(args)
            if not skill_id:
                return -1, 'please specify a skill ID.'
            skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id)
            if not skill:
                return -1, 'the skill was not found.'

            if not world_session.player_mgr.skill_manager.add_skill(skill_id):
                return -1, 'unable to learn skill or already learned.'

            return 0, 'Skill learned.'
        except ValueError:
            return -1, 'invalid ID.'

    @staticmethod
    def lskills(world_session, args):
        try:
            skill_ids = args.split()
            added = []
            invalid = []
            for skill_id in skill_ids:
                code, res = CommandManager.lskill(world_session, skill_id)
                if code == 0:
                    added.append(skill_id)
                else:
                    invalid.append(skill_id)

            if len(skill_ids) == len(invalid):
                return -1, f'skill ID(s) {", ".join(invalid)} are not valid.'
            else:
                return 0, f'Skill ID(s) {", ".join(added)} learned.'
        except ValueError:
            return -1, 'please specify one or more valid skill ID(s).'

    @staticmethod
    def setrep(world_session, args):
        try:
            factionid, value = args.split()
            f_id = int(factionid)
            standing = int(value)

            new_standing = world_session.player_mgr.reputation_manager.modify_reputation(f_id, standing, is_final=True)
            if not new_standing:
                return -1, 'Invalid faction.'

            return 0, f'Reputation set to {new_standing}'
        except ValueError:
            return -1, 'please specify the faction ID and new value.'

    @staticmethod
    def setskill(world_session, args):
        try:
            skill_id, skill_value = args.split()
            skill_id = int(skill_id)
            skill_value = int(skill_value)
            skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id)
            if not skill:
                return -1, 'invalid skill.'

            if skill_value <= 0 or skill_value >= pow(2, 16):
                return -1, 'invalid skill value.'

            if not world_session.player_mgr.skill_manager.set_skill(skill_id, skill_value):
                return -1, 'you haven\'t learned that skill.'

            world_session.player_mgr.skill_manager.build_update()
            return 0, 'Skill set.'
        except ValueError:
            return -1, 'please specify the skill ID and new value.'

    @staticmethod
    def port(world_session, args):
        try:
            x, y, z, map_id = args.split()
            tel_location = Vector(float(x), float(y), float(z))
            success = world_session.player_mgr.teleport(int(map_id), tel_location)

            if success:
                return 0, ''
            return -1, f'invalid location ({args}).'
        except ValueError:
            return -1, 'please use the "x y z map" format.'

    @staticmethod
    def tickets(world_session, args):
        tickets = RealmDatabaseManager.ticket_get_all()
        for ticket in tickets:
            ticket_color = '|cFFFF0000' if ticket.is_bug else '|cFF00FFFF'
            ticket_title = 'Bug report' if ticket.is_bug else 'Suggestion'
            ticket_text = f'{ticket_color}[{ticket.id}]|r {ticket.submit_time}: {ticket_title} from {ticket.character_name}.'
            ChatManager.send_system_message(world_session, ticket_text)
        return 0, f'{len(tickets)} tickets shown.'

    @staticmethod
    def rticket(world_session, args):
        try:
            ticket_id = int(args)
            ticket = RealmDatabaseManager.ticket_get_by_id(ticket_id)
            if ticket:
                ticket_color = '|cFFFF0000' if ticket.is_bug else '|cFF00FFFF'
                return 0, f'{ticket_color}[{ticket_id}] {ticket.character_name}:|r {ticket.text_body}'
            return -1, 'ticket not found.'
        except ValueError:
            return -1, 'please specify a valid ticket id.'

    @staticmethod
    def dticket(world_session, args):
        try:
            ticket_id = int(args)
            if RealmDatabaseManager.ticket_delete(ticket_id) == 0:
                return 0, f'Ticket {ticket_id} deleted.'
            return -1, 'ticket not found.'

        except ValueError:
            return -1, 'please specify a valid ticket id.'

    @staticmethod
    def goplayer(world_session, args):
        player_name = args
        online = True

        player = WorldSessionStateHandler.find_player_by_name(player_name)
        player_location = None
        map_id = 0

        if player:
            player_location = player.location
            map_id = player.map_id
        else:
            online = False
            player = RealmDatabaseManager.character_get_by_name(player_name)

        if player:
            if not online:
                player_location = Vector(float(player.position_x), float(player.position_y), float(player.position_z))
                map_id = player.map
        else:
            return -1, 'player not found.'

        world_session.player_mgr.teleport(int(map_id), player_location)

        status_text = 'Online' if online else 'Offline'
        return 0, f'Teleported to player {player_name.capitalize()} ({status_text}).'

    @staticmethod
    def gocreature(world_session, args):
        if not args:
            return -1, 'please specify a creature name.'

        creature_name = args.strip()
        creature = WorldDatabaseManager.\
            CreatureTemplateHolder.creature_get_by_name(creature_name, remove_space=True)

        if not creature:
            return -1, f'"{creature_name}" not found.'

        spawns = WorldDatabaseManager.creature_spawn_get_by_entry(creature.entry)
        spawns_ignored_values = [spawn.ignored for spawn in spawns]
        are_ignored = 0 not in spawns_ignored_values  # 0 means 'not ignored'.

        if are_ignored: 
            return -1, f'"{creature.name}" not spawned.'

        effective_spawn = spawns[spawns_ignored_values.index(0)]
        tel_location = Vector(
            effective_spawn.position_x, 
            effective_spawn.position_y, 
            effective_spawn.position_z, 
            effective_spawn.orientation)

        success = world_session.player_mgr.teleport(
            effective_spawn.map, tel_location)

        if not success:
            return -1, f'unable to teleport to ({tel_location}, {effective_spawn.map}).'
        
        return 0, f'Teleported to "{creature.name}".'
    
    @staticmethod
    def summon(world_session, args):
        player_name = args
        online = True

        player = WorldSessionStateHandler.find_player_by_name(player_name)

        if player:
            player.teleport(world_session.player_mgr.map_id, world_session.player_mgr.location)
        else:
            online = False
            player = RealmDatabaseManager.character_get_by_name(player_name)

        if player:
            if not online:
                player.map = world_session.player_mgr.map_id
                player.zone = world_session.player_mgr.zone
                player.position_x = world_session.player_mgr.location.x
                player.position_y = world_session.player_mgr.location.y
                player.position_z = world_session.player_mgr.location.z
                RealmDatabaseManager.character_update(player)
        else:
            return -1, 'player not found.'

        status_text = 'Online' if online else 'Offline'
        return 0, f'Summoned player {player_name.capitalize()} ({status_text}).'

    @staticmethod
    def ann(world_session, args):
        ann = str(args)

        for session in WorldSessionStateHandler.get_world_sessions():
            if session.player_mgr and session.player_mgr.online:
                ChatManager.send_system_message(session, f'[SERVER] {ann}')

        return 0, ''

    @staticmethod
    def mount(world_session, args):
        try:
            mount_display_id = int(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            if not player_mgr.mount(mount_display_id):
                return -1, 'please specify a valid mount display id.'
            return 0, ''
        except ValueError:
            return -1, 'please specify a valid mount display id.'

    @staticmethod
    def unmount(world_session, args):
        player_mgr = CommandManager._target_or_self(world_session, only_players=True)
        if player_mgr.unit_flags & UnitFlags.UNIT_MASK_MOUNTED:
            player_mgr.unmount()
        return 0, ''

    @staticmethod
    def setvirtualitem(world_session, args):
        try:
            item_id = int(args)
            unit = CommandManager._target_or_self(world_session)
            if not unit.is_unit():
                return -1, 'target must be unit.'
            unit.set_virtual_equipment(slot=0, item_id=item_id)
            return 0, ''
        except ValueError:
            return -1, 'please specify a valid display id.'

    @staticmethod
    def morph(world_session, args):
        try:
            display_id = int(args)
            unit = CommandManager._target_or_self(world_session)
            unit.set_display_id(display_id)
            return 0, ''
        except ValueError:
            return -1, 'please specify a valid display id.'

    @staticmethod
    def demorph(world_session, args):
        unit = CommandManager._target_or_self(world_session)
        unit.reset_display_id()
        return 0, ''

    @staticmethod
    def weaponmode(world_session, args):
        try:
            player_mgr = world_session.player_mgr
            creature = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection)
            if creature:
                weapon_mode = int(args)
                if weapon_mode < 0 or weapon_mode >= WeaponMode.NUMMODES:
                    return -1, 'invalid weapon mode.'
                creature.set_weapon_mode(weapon_mode)
                return 0, f'Weapon mode set to {WeaponMode(weapon_mode).name}'
            else:
                return -1, 'unable to locate creature.'
        except:
            return -1, 'please specify a valid weapon mode.'

    # TODO, implement event/script forcing.
    @staticmethod
    def fevent(world_session, args):
        try:
            player_mgr = world_session.player_mgr
            creature = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection)
            if not creature:
                return -1, 'unable to locate creature.'

            event_id = int(args)
            event = WorldDatabaseManager.CreatureAiEventHolder.creature_ai_event_get_by_event_id(event_id)
            if not event:
                return -1, 'invalid event id.'

            if event.creature_id != creature.entry:
                return -1, 'invalid creature for provided event.'

            # creature.get_map().set_random_ooc_event(creature, event, forced=True)
            return -1, 'NYI.'
        except:
            return -1, 'invalid event id.'

    @staticmethod
    def unit_flags(world_session, args):
        unit = CommandManager._target_or_self(world_session)
        result = ''
        if unit:
            flag_count = 0
            result += f'Unit: {unit.get_name()}\n'
            for flag in UnitFlags:
                if unit.unit_flags & flag:
                    flag_count += 1
                    result += f'|c0066FF00[SET]|r {UnitFlags(flag).name}\n'
                if flag == UnitFlags.UNIT_FLAG_SHEATHE:  # Last unit flag, prevent checking masks.
                    break

            for flag in UnitDynamicTypes:
                if unit.dynamic_flags & flag:
                    flag_count += 1
                    result += f'|c0066FF00[SET]|r {UnitDynamicTypes(flag).name}\n'

            for flag in MoveFlags:
                if unit.movement_flags & flag:
                    flag_count += 1
                    result += f'|c0066FF00[SET]|r {MoveFlags(flag).name}\n'

            result += f'{flag_count} active unit flags.'
        return 0, result

    @staticmethod
    def creature_info(world_session, args):
        player_mgr = world_session.player_mgr
        creature = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, player_mgr.current_selection)
        if creature:
            return 0, f'[{creature.get_name()}]\n' \
                      f'Spawn ID: {creature.spawn_id}\n' \
                      f'Guid: {creature.get_low_guid()}\n' \
                      f'Entry: {creature.creature_template.entry}\n' \
                      f'Display ID: {creature.current_display_id}\n' \
                      f'Faction: {creature.faction}\n' \
                      f'Unit Flags: {hex(creature.unit_flags)}\n' \
                      f'Static Flags: {hex(creature.static_flags)}\n' \
                      f'Alive: {creature.is_alive}\n' \
                      f'X: {creature.location.x}, ' \
                      f'Y: {creature.location.y}, ' \
                      f'Z: {creature.location.z}, ' \
                      f'O: {creature.location.o}\n' \
                      f'Map: {creature.map_id}'
        return -1, 'error retrieving creature info.'

    @staticmethod
    def player_info(world_session, args):
        # Because you can select party members on different maps, we search in the entire session pool
        player_mgr = CommandManager._target_or_self(world_session, only_players=True)

        if player_mgr:
            return 0, f'[{player_mgr.get_name()}] - Guid: {player_mgr.get_low_guid()}\n' \
                      f'Account ID: {player_mgr.session.account_mgr.account.id}\n' \
                      f'Account name: {player_mgr.session.account_mgr.account.name}'
        return -1, 'error retrieving player info.'

    @staticmethod
    def gobject_info(world_session, args):
        try:
            if args:
                max_distance = int(args)
            else:
                max_distance = 10
            found_count = 0
            player_mgr = world_session.player_mgr
            for guid, gobject in list(player_mgr.get_map().get_surrounding_gameobjects(player_mgr).items()):
                distance = player_mgr.location.distance(gobject.location)
                if distance > max_distance:
                    continue
                found_count += 1
                ChatManager.send_system_message(world_session,
                                                f'[{gobject.get_name()}]\n'
                                                f'Spawn ID: {gobject.spawn_id}\n'
                                                f'Guid: {gobject.get_low_guid()}\n'
                                                f'Entry: {gobject.gobject_template.entry}\n'
                                                f'Display ID: {gobject.current_display_id}\n'
                                                f'X: {gobject.location.x}, '
                                                f'Y: {gobject.location.y}, '
                                                f'Z: {gobject.location.z}, '
                                                f'O: {gobject.location.o}, '
                                                f'Map: {gobject.map_id}\n'
                                                f'Distance: {distance}')
            return 0, f'{found_count} game objects found within {max_distance} distance units.'
        except ValueError:
            return -1, 'please specify a valid distance.'

    @staticmethod
    def level(world_session, args):
        try:
            input_level = int(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            player_mgr.xp = 0
            player_mgr.set_uint32(PlayerFields.PLAYER_XP, 0)
            player_mgr.mod_level(input_level)

            return 0, ''
        except ValueError:
            return -1, 'please specify a valid level.'

    @staticmethod
    def petlevel(world_session, args):
        try:
            input_level = int(args)
            active_pet = world_session.player_mgr.pet_manager.get_active_controlled_pet()
            if not active_pet:
                return -1, 'you must have an active pet to use this command.'

            # Same boundaries as client-side petlevel command.
            if input_level < 1 or input_level > 100:
                raise ValueError

            active_pet.set_level(input_level, replenish=True)

            return 0, ''
        except ValueError:
            return -1, 'please specify a valid level.'

    @staticmethod
    def money(world_session, args):
        try:
            money = int(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            player_mgr.mod_money(money)

            return 0, ''
        except ValueError:
            return -1, 'please specify a money amount.'

    @staticmethod
    def guildcreate(world_session, args):
        GuildManager.create_guild(world_session.player_mgr, args)

        return 0, ''

    @staticmethod
    def alltaxis(world_session, args):
        taxi_nodes_count = world_session.player_mgr.taxi_manager.enable_all_taxi_nodes()

        return 0, f'Enabled {taxi_nodes_count} taxi nodes.'
    
    @staticmethod
    def squest(world_session, args):
        quest_title = args.strip()
        if not quest_title:
            return -1, 'please specifiy a quest title to start searching.'
        quests = WorldDatabaseManager.quest_get_by_title(quest_title)
        
        for quest in quests:
            quest_title = quest.Title
            quest_text = f'{quest.entry} - |cFF00FFFF[{quest_title}]|r'
            ChatManager.send_system_message(world_session, quest_text)
        return 0, f'{len(quests)} quests found.'

    @staticmethod
    def qdel(world_session, args):
        try:
            quest_id = int(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            player_mgr.quest_manager.remove_quest(quest_id)

            return 0, ''
        except ValueError:
            return -1, 'please specify a valid quest entry.'

    @staticmethod
    def qadd(world_session, args):
        try:
            quest_id = int(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            if player_mgr.quest_manager.is_quest_log_full():
                return -1, 'quest log is full.'
            player_mgr.quest_manager.handle_accept_quest(quest_id, 0)

            return 0, ''
        except ValueError:
            return -1, 'please specify a valid quest entry.'

    @staticmethod
    def die(world_session, args):
        unit = CommandManager._target_or_self(world_session)
        world_session.player_mgr.deal_damage(unit, DamageInfoHolder(attacker=world_session.player_mgr,
                                                                    target=unit,
                                                                    total_damage=unit.health))

        return 0, ''

    @staticmethod
    def los(world_session, args):
        unit = CommandManager._target_or_self(world_session)
        source_ray = world_session.player_mgr.get_ray_position()
        dest_ray = unit.get_ray_position()
        los = unit.get_map().los_check(source_ray, dest_ray)

        return 0, f'Is in line of sight: {los}\nSource: {source_ray}\nTarget: {dest_ray}\nMap: {unit.map_id}'

    @staticmethod
    def kick(world_session, args):
        player = CommandManager._target_or_self(world_session, only_players=True)
        if player:
            player.session.disconnect()

        return 0, ''

    @staticmethod
    def worldoff(world_session, args):
        confirmation = str(args)

        if confirmation.strip() != 'confirm':
            return -1, 'this command is DANGEROUS, it will shutdown the server. Write \'.worldoff confirm\' to do it.'

        # Prevent more sockets to be opened
        WorldManager.WORLD_ON = False

        # Kick all players
        for session in WorldSessionStateHandler.get_world_sessions():
            if session.player_mgr and session.player_mgr.online:
                session.disconnect()

        return 0, ''

    @staticmethod
    def serverinfo(world_session, args):
        commit_hash = GitUtils.get_current_commit_hash()
        short_rev = commit_hash[:7] if commit_hash else 'unknown'

        if commit_hash:
            branch = GitUtils.get_current_branch() or 'unknown'
            
            commit_date = GitUtils.get_current_commit_date()
            if commit_date:
                try:
                    dt = datetime.strptime(commit_date[:19], '%Y-%m-%d %H:%M:%S')
                    date_str = dt.strftime('%Y-%m-%d %H:%M:%S')
                    timezone = commit_date[20:] if len(commit_date) > 20 else '+0000'
                except (ValueError, IndexError):
                    date_str = 'unknown'
                    timezone = '+0000'
            else:
                date_str = 'unknown'
                timezone = '+0000'
        else:
            branch = 'no git found'
            date_str = '1970-01-01 00:00:00'
            timezone = '+0000'
        
        platform_short = platform.system()
        platform_full = platform.platform(terse=True)
        python_ver = platform.python_version()
        revision = (
            f'alpha-core rev. {short_rev} {date_str} {timezone} '
            f'({branch} branch) (Platform: {platform_short}, Python: {python_ver})'
        )

        uptime_seconds = int(WorldManager.get_seconds_since_startup())
        hours, remainder = divmod(uptime_seconds, 3600)
        minutes, seconds = divmod(remainder, 60)
        uptime_parts = []
        if hours:
            uptime_parts.append(f'{hours} hour(s)')
        if minutes:
            uptime_parts.append(f'{minutes} minute(s)')
        if seconds or not uptime_parts:
            uptime_parts.append(f'{seconds} second(s)')
        server_uptime = ' '.join(uptime_parts)

        message = f'{revision}\nServer Uptime: {server_uptime}\n'
        server_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        message += f'Server Current Time: {server_time}.\n'
        message += f'Running on: {platform_full}'
        return 0, message

    @staticmethod
    def createmonster(world_session, args):
        try:
            creature_entry = int(args)
            player_mgr = world_session.player_mgr
            creature_template: CreatureTemplate = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creature_entry)
            faction = creature_template.faction if creature_template else player_mgr.faction
            creature_instance = CreatureBuilder.create(creature_entry, player_mgr.location.copy(),
                                                       player_mgr.map_id, player_mgr.instance_id,
                                                       subtype=CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON,
                                                       faction=faction)

            if not creature_instance:
                return -1, f'creature entry {creature_entry} not found'
            else:
                player_mgr.get_map().spawn_object(world_object_instance=creature_instance)
        except (IndexError, ValueError):
            return -1, 'please specify a valid creature entry.'

        return 0, ''

    @staticmethod
    def mapstats(world_session, args):
        from game.world.managers.maps.MapManager import MapManager
        tile_count = MapManager.get_active_tiles_count()
        maps = MapManager.get_active_maps()
        result = f'Total active tiles/adts: {tile_count}\n'
        for m in maps:
            result += (f'Id:{m.map_id}, '
                       f'Name:{m.name}, '
                       f'InstanceId:{m.instance_id}, '
                       f'Active Cells: {m.get_active_cell_count()}\n'
                       )
        return 0, result

    @staticmethod
    def deactivate_cells(world_session, args):
        from game.world.managers.maps.MapManager import MapManager
        MapManager.deactivate_cells()
        return 0, ''

    @staticmethod
    def destroymonster(world_session, args):
        try:
            creature_guid = int(args) if args else 0
            player_mgr = world_session.player_mgr

            if not creature_guid or creature_guid == 0:
                creature_instance = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr,
                                                                                      player_mgr.current_selection)
            else:
                creature_instance = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, creature_guid)

            if not creature_instance:
                return -1, f'creature not found'
            else:
                player_mgr.get_map().remove_object(creature_instance)

        except (IndexError, ValueError):
            return -1, 'please select a valid creature.'

        return 0, ''

    @staticmethod
    def pwdchange(world_session, args):
        try:
            old_password, new_password, confirmation_password = args.split()
            if new_password != confirmation_password:
                return -1, 'please make sure the confirmation password matches the new password'

            success = RealmDatabaseManager.account_try_update_password(world_session.account_mgr.account.name,
                                                                       old_password, new_password)
            if not success:
                return -1, 'something went wrong, make sure the current password is correct and the new ' \
                           'password has 16 characters maximum'
            return 0, 'Password updated successfully, remember to update it in your wow.ses file'
        except ValueError:
            return -1, 'please use it like: .pwdchange current_password new_password new_password'

    @staticmethod
    def save_location(world_session, args):
        if args:
            logline = f'{world_session.player_mgr.location.x} {world_session.player_mgr.location.y} ' \
                      f'{world_session.player_mgr.location.z} {world_session.player_mgr.map_id} - {args}'
            Path(CommandManager.DEV_LOG_PATH).mkdir(parents=True, exist_ok=True)
            with open(CommandManager.DEV_LOC_LOG_FULL_PATH, 'a+') as log:
                log.write(f'{logline}\n')
            return 0, 'Location saved.'
        else:
            return -1, 'please use it like: .sloc comment'

    @staticmethod
    def save_waypoint(world_session, args):
        try:
            entry = int(args)
            Path(CommandManager.DEV_LOG_PATH).mkdir(parents=True, exist_ok=True)
            f_name = path.join(CommandManager.DEV_LOG_PATH, f'{entry}_waypoints.log')
            l = world_session.player_mgr.location
            with open(f_name, 'a+') as f:
                point_id = len(f.readlines())
                f.write(f'({entry}, {point_id}, {round(l.x, 3)}, {round(l.y, 3)}, {round(l.z, 3)}, 0, 0, 0, 0),\n')

            return 0, f'Successfully created/updated waypoints in {f_name}'
        except ValueError:
            return -1, 'please use it like: .savewp <entry>'

    @staticmethod
    def gmtag(world_session, args):
        arg = str(args).strip().lower()
        if arg not in ('on', 'off', 'enable', 'disable', '1', '0'):
            return -1, 'please use it like .gmtag on|off'

        enable = arg in ('on', 'enable', '1')
        world_session.player_mgr.set_gm_tag(enable, reload=True)

        return 0, f'<GM> tag {"enabled" if enable else "disabled"}.'

    @staticmethod
    def create_account(args):
        args = str(args).strip().split()
        if len(args) != 2:
            return -1, 'please use it like: createacc username password'
        username, password = args
        salt = os.urandom(32)
        verifier = Srp6.calculate_password_verifier(username, password, salt)
        account = RealmDatabaseManager.account_create(username, hashlib.sha256(password.encode('utf-8')).hexdigest(),
                                                      "127.0.0.1", salt.hex(), verifier.hex())
        if not account:
            return -1, 'unable to create account'
        return 0, 'account created'


CONSOLE_COMMAND_DEFINITIONS = {
    'createacc' : [CommandManager.create_account, 'create srp6 account']
}


PLAYER_COMMAND_DEFINITIONS = {
    'help': [CommandManager.help, 'print this message'],
    'serverinfo': [CommandManager.serverinfo, 'print server information'],
    'pwdchange': [CommandManager.pwdchange, 'change your password']
}

# noinspection SpellCheckingInspection
GM_COMMAND_DEFINITIONS = {
    'collision': [CommandManager.toggle_collision, 'toggle collision'],
    'speed': [CommandManager.speed, 'change your run speed'],
    'swimspeed': [CommandManager.swim_speed, 'change your swim speed'],
    'gps': [CommandManager.gps, 'display information about your location'],
    'tel': [CommandManager.tel, 'teleport you to a location'],
    'stel': [CommandManager.stel, 'search for a location where you can teleport'],
    'telunit': [CommandManager.tel_unit, 'teleport a unit to a given location in the same map'],
    'moveunit': [CommandManager.move_unit, 'command a unit to move to a given location'],
    'distunit': [CommandManager.distance_unit, 'get the distance between you and target unit'],
    'sitem': [CommandManager.sitem, 'search items'],
    'additem': [CommandManager.additem, 'add an item to your bag'],
    'additems': [CommandManager.additems, 'add items to your bag'],
    'sspell': [CommandManager.sspell, 'search spells'],
    'lspell': [CommandManager.lspell, 'learn a spell'],
    'lspells': [CommandManager.lspells, 'learn multiple spells'],
    'unlspell': [CommandManager.unlspell, 'unlearn a spell'],
    'unltalent': [CommandManager.unltalent, 'unlearn a talent'],
    'cast': [CommandManager.cast, 'cast a spell'],
    'addaura': [CommandManager.addaura, 'add an aura by spell id'],
    'clearauras': [CommandManager.clearauras, 'clear all auras'],
    'sskill': [CommandManager.sskill, 'search skills'],
    'lskill': [CommandManager.lskill, 'learn a skill'],
    'lskills': [CommandManager.lskills, 'learn skills'],
    'setskill': [CommandManager.setskill, 'set a skill level'],
    'setrep': [CommandManager.setrep, 'set reputation value'],
    'port': [CommandManager.port, 'teleport using coordinates'],
    'tickets': [CommandManager.tickets, 'list all tickets'],
    'rticket': [CommandManager.rticket, 'search a ticket'],
    'dticket': [CommandManager.dticket, 'delete a ticket'],
    'goplayer': [CommandManager.goplayer, 'go to a player position'],
    'gocreature': [CommandManager.gocreature, 'go to a creature position'],
    'summon': [CommandManager.summon, 'summon a player to your position'],
    'ann': [CommandManager.ann, 'write a server side announcement'],
    'mount': [CommandManager.mount, 'mount'],
    'unmount': [CommandManager.unmount, 'dismount'],
    'morph': [CommandManager.morph, 'morph the targeted unit'],
    'demorph': [CommandManager.demorph, 'demorph the targeted unit'],
    'setvirtualitem': [CommandManager.setvirtualitem, 'equips virtual item on unit main hand'],
    'cinfo': [CommandManager.creature_info, 'get targeted creature info'],
    'unitflags': [CommandManager.unit_flags, 'get targeted unit flags status'],
    'weaponmode': [CommandManager.weaponmode, 'set targeted creature weapon mode'],
    'pinfo': [CommandManager.player_info, 'get targeted player info'],
    'goinfo': [CommandManager.gobject_info, 'get gameobject information near you'],
    'level': [CommandManager.level, 'set your or others level'],
    'petlevel': [CommandManager.petlevel, 'set your active pet level'],
    'money': [CommandManager.money, 'give yourself money'],
    'die': [CommandManager.die, 'kills target or yourself if no target is selected'],
    'kick': [CommandManager.kick, 'kick your target from the server'],
    'guildcreate': [CommandManager.guildcreate, 'create and join a guild'],
    'alltaxis': [CommandManager.alltaxis, 'discover all flight paths'],
    'squest': [CommandManager.squest, 'search quests'],
    'qadd': [CommandManager.qadd, 'adds a quest to your log'],
    'qdel': [CommandManager.qdel, 'delete active or completed quest'],
    'gmtag': [CommandManager.gmtag, 'enable or disable the <GM> tag']
}

DEV_COMMAND_DEFINITIONS = {
    'scriptwp': [CommandManager.activate_script_waypoints, 'tries to activate the selected unit script waypoints'],
    'flushbags': [CommandManager.flushbags, 'flush all items from bags'],
    'los': [CommandManager.los, 'check unit line of sight'],
    'fevent': [CommandManager.fevent, 'force the given event to execute'],
    'moveobject': [CommandManager.move_object, 'move last debug ai state mouse hovered object'],
    'savewp': [CommandManager.save_waypoint, 'save your current location as creature_movement waypoint'],
    'mapstats': [CommandManager.mapstats, 'active maps, adts and cells'],
    'deactivatecells': [CommandManager.deactivate_cells, 'run cell deactivate process'],
    'destroymonster': [CommandManager.destroymonster, 'destroy the selected creature'],
    'createmonster': [CommandManager.createmonster, 'spawn a creature at your position'],
    'sloc': [CommandManager.save_location, 'save your location to locations.log along with a comment'],
    'worldoff': [CommandManager.worldoff, 'stop the world server']
}
