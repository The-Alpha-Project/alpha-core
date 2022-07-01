from datetime import datetime, timedelta
from enum import Enum

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world import WorldManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.player.ChatManager import ChatManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.ConfigManager import config
from utils.GitUtils import GitUtils
from utils.TextUtils import GameTextFormatter
from utils.constants.MiscCodes import HighGuid
from utils.constants.SpellCodes import SpellEffects, SpellTargetMask
from utils.constants.UpdateFields import PlayerFields

import platform

# noinspection SpellCheckingInspection,PyUnusedLocal
class CommandManager(object):

    @staticmethod
    def handle_command(world_session, command_msg):
        terminator_index = command_msg.find(' ') if ' ' in command_msg else len(command_msg)

        command = command_msg[1:terminator_index].strip()
        args = command_msg[terminator_index:].strip()

        if command in PLAYER_COMMAND_DEFINITIONS:
            command_func = PLAYER_COMMAND_DEFINITIONS[command][0]
        elif command in GM_COMMAND_DEFINITIONS and world_session.player_mgr.is_gm:
            command_func = GM_COMMAND_DEFINITIONS[command][0]
        else:
            ChatManager.send_system_message(world_session, 'Command not found, type .help for help.')
            return

        if command_func:
            code, res = command_func(world_session, args)
            if code != 0:
                ChatManager.send_system_message(world_session, f'Wrong arguments for <{command}> command: {res}')
            elif res:
                ChatManager.send_system_message(world_session, res)

    @staticmethod
    def _target_or_self(world_session, only_players=False):
        if world_session.player_mgr.current_selection \
                and world_session.player_mgr.current_selection != world_session.player_mgr.guid:
            if only_players:
                unit = MapManager.get_surrounding_player_by_guid(world_session.player_mgr,
                                                                 world_session.player_mgr.current_selection)
            else:
                unit = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr,
                                                               world_session.player_mgr.current_selection,
                                                               include_players=True)
            if unit:
                return unit

        return world_session.player_mgr

    # Display each commands with a message regarding account status (player or gm)
    @staticmethod
    def help(world_session, args):
        total_number = 0

        # If player is GM, send GM commands first.
        if world_session.player_mgr.is_gm:
            ChatManager.send_system_message(world_session, '[GM Commands]')
            for command in GM_COMMAND_DEFINITIONS:
                ChatManager.send_system_message(world_session, command +  " - " + GM_COMMAND_DEFINITIONS[command][1])
            ChatManager.send_system_message(world_session, '\n')

        ChatManager.send_system_message(world_session, '[Player Commands]\n')
        for command in PLAYER_COMMAND_DEFINITIONS:
            ChatManager.send_system_message(world_session, command +  " - " + PLAYER_COMMAND_DEFINITIONS[command][1])

        return 0, f'{total_number} commands found.'

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
        player_x = world_session.player_mgr.location.x
        player_y = world_session.player_mgr.location.y
        player_z = world_session.player_mgr.location.z
        player_o = world_session.player_mgr.location.o
        maps_z = MapManager.calculate_z_for_object(world_session.player_mgr)[0]
        adt_tile = MapManager.get_tile(player_x, player_y)
        return 0, f'Map: {world_session.player_mgr.map_},  ' \
                  f'Zone: {world_session.player_mgr.zone}, ' \
                  f'ADT: [{adt_tile[0]},{adt_tile[1]}], ' \
                  f'X: {player_x:.3f}, ' \
                  f'Y: {player_y:.3f}, ' \
                  f'Z: {player_z:.3f}, ' \
                  f'MapZ: {maps_z:.3f}, ' \
                  f'O: {player_o:.3f}'

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
            return -1, f'map not found ({location.map}).'
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
                return -1, 'you already know that spell.'
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
            world_session.player_mgr.aura_manager.cancel_auras_by_spell_id(spell_id)
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
                return -1, 'The spell was not found.'

            unit = CommandManager._target_or_self(world_session)
            world_session.player_mgr.spell_manager.handle_cast_attempt(spell_id, unit, SpellTargetMask.UNIT,
                                                                       validate=False)
            return 0, ''
        except ValueError:
            return -1, 'Invalid ID.'

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
                return -1, 'The skill was not found.'

            world_session.player_mgr.skill_manager.add_skill(skill_id)
            return 0, 'Skill learned.'
        except ValueError:
            return -1, 'Invalid ID.'

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
    def port(world_session, args):
        try:
            x, y, z, map_ = args.split()
            tel_location = Vector(float(x), float(y), float(z))
            success = world_session.player_mgr.teleport(int(map_), tel_location)

            if success:
                return 0, ''
            return -1, f'map not found ({int(map_)}).'
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
        map_ = 0

        if player:
            player_location = player.location
            map_ = player.map_
        else:
            online = False
            player = RealmDatabaseManager.character_get_by_name(player_name)

        if player:
            if not online:
                player_location = Vector(float(player.position_x), float(player.position_y), float(player.position_z))
                map_ = player.map
        else:
            return -1, 'player not found.'

        world_session.player_mgr.teleport(int(map_), player_location)

        status_text = 'Online' if online else 'Offline'
        return 0, f'Teleported to player {player_name.capitalize()} ({status_text}).'

    @staticmethod
    def summon(world_session, args):
        player_name = args
        online = True

        player = WorldSessionStateHandler.find_player_by_name(player_name)

        if player:
            player.teleport(world_session.player_mgr.map_, world_session.player_mgr.location)
        else:
            online = False
            player = RealmDatabaseManager.character_get_by_name(player_name)

        if player:
            if not online:
                player.map = world_session.player_mgr.map_
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
        player_mgr.unmount()
        return 0, ''

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
    def creature_info(world_session, args):
        creature = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr,
                                                           world_session.player_mgr.current_selection)

        if creature:
            return 0, f'[{creature.creature_template.name}] - Guid: {creature.guid & ~HighGuid.HIGHGUID_UNIT}, ' \
                      f'Entry: {creature.creature_template.entry}, ' \
                      f'Display ID: {creature.current_display_id}, ' \
                      f'X: {creature.location.x}, ' \
                      f'Y: {creature.location.y}, ' \
                      f'Z: {creature.location.z}, ' \
                      f'O: {creature.location.o}, ' \
                      f'Map: {creature.map_}'
        return -1, 'error retrieving creature info.'

    @staticmethod
    def player_info(world_session, args):
        # Because you can select party members on different maps, we search in the entire session pool
        player_mgr = CommandManager._target_or_self(world_session, only_players=True)

        if player_mgr:
            return 0, f'[{player_mgr.player.name}] - Guid: {player_mgr.guid & ~HighGuid.HIGHGUID_PLAYER}, ' \
                      f'Account ID: {player_mgr.session.account_mgr.account.id}, ' \
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
            for guid, gobject in list(MapManager.get_surrounding_gameobjects(world_session.player_mgr).items()):
                distance = world_session.player_mgr.location.distance(gobject.location)
                if distance <= max_distance:
                    found_count += 1
                    ChatManager.send_system_message(world_session,
                                                    f'[{gobject.gobject_template.name}] - Guid: {gobject.guid & ~HighGuid.HIGHGUID_GAMEOBJECT}, '
                                                    f'Entry: {gobject.gobject_template.entry}, '
                                                    f'Display ID: {gobject.current_display_id}, '
                                                    f'X: {gobject.location.x}, '
                                                    f'Y: {gobject.location.y}, '
                                                    f'Z: {gobject.location.z}, '
                                                    f'O: {gobject.location.o}, '
                                                    f'Map: {gobject.map_}, '
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
    def money(world_session, args):
        try:
            money = int(args)
            player_mgr = CommandManager._target_or_self(world_session, only_players=True)
            player_mgr.mod_money(money)

            return 0, ''
        except ValueError:
            return -1, 'please specify a money amount.'

    @staticmethod
    def suicide(world_session, args):
        world_session.player_mgr.deal_damage(world_session.player_mgr, world_session.player_mgr.health)

        return 0, ''

    @staticmethod
    def guildcreate(world_session, args):
        GuildManager.create_guild(world_session.player_mgr, args)

        return 0, ''

    @staticmethod
    def alltaxis(world_session, args):
        taxi_nodes_count = world_session.player_mgr.taxi_manager.enable_all_taxi_nodes()

        return 0, f'Enabled {taxi_nodes_count} taxi nodes.'

    @staticmethod
    def die(world_session, args):
        unit = CommandManager._target_or_self(world_session)
        world_session.player_mgr.deal_damage(unit, unit.health)

        return 0, ''

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
        os_platform = f'{platform.system()} {platform.release()} ({platform.version()})'
        message = f'Platform: {os_platform}.\n'

        server_time = f'{datetime.now()}'
        message += f'Server Time: {server_time}.\n'

        server_uptime = timedelta(seconds=WorldManager.get_seconds_since_startup())
        message += f'Uptime: {server_uptime}.\n'

        current_commit_hash = GitUtils.get_current_commit_hash()
        current_branch = GitUtils.get_current_branch()
        message += f'Commit: [{current_branch}] {current_commit_hash}.'

        return 0, message

PLAYER_COMMAND_DEFINITIONS = {
    "help": [CommandManager.help, "print this message"],
    "suicide": [CommandManager.suicide, "kill yourself and respwan at your hearthstone location"],
    "serverinfo": [CommandManager.serverinfo, "print server information"]
}

# noinspection SpellCheckingInspection
GM_COMMAND_DEFINITIONS = {
    'speed': [CommandManager.speed, "change your walk speed"],
    'swimspeed': [CommandManager.swim_speed, "change your swim speed"],
    'gps': [CommandManager.gps, "display information on your location"],
    'tel': [CommandManager.tel, "teleport you to a location"],
    'stel': [CommandManager.stel, "search for a location where you can teleport"],
    'sitem': [CommandManager.sitem, "search an item"],
    'additem': [CommandManager.additem, "add an item to your bag"],
    'additems': [CommandManager.additems, "add items to your bag"],
    'sspell': [CommandManager.sspell, "search a spell"],
    'lspell': [CommandManager.lspell, "learn a spell"],
    'lspells': [CommandManager.lspells, "unlearn a spell"],
    'unlspell': [CommandManager.unlspell, "unlearn spells"],
    'unltalent': [CommandManager.unltalent, "unlearn a talent"],
    'cast': [CommandManager.cast, "cast a spell"],
    'sskill': [CommandManager.sskill, "search skills"],
    'lskill': [CommandManager.lskill, "learn a skill"],
    'lskills': [CommandManager.lskills, "learn skills"],
    'port': [CommandManager.port, "teleport using coordinates"],
    'tickets': [CommandManager.tickets, "list all tickets (bug reports)"],
    'rticket': [CommandManager.rticket, "search a ticket"],
    'dticket': [CommandManager.dticket, "delete a ticket"],
    'goplayer': [CommandManager.goplayer, "go to a player position"],
    'summon': [CommandManager.summon, "summon a player to your position"],
    'ann': [CommandManager.ann, "?"],
    'mount': [CommandManager.mount, "mount"],
    'unmount': [CommandManager.unmount, "dismount"],
    'morph': [CommandManager.morph, "transform the targeted player"],
    'demorph': [CommandManager.demorph, "untransform the targeted player"],
    'cinfo': [CommandManager.creature_info, "get targeted creature info"],
    'pinfo': [CommandManager.player_info, "get targeted player info"],
    'goinfo': [CommandManager.gobject_info, "get information near you"],
    'level': [CommandManager.level, "set your level"],
    'money': [CommandManager.money, "give you money"],
    'die': [CommandManager.die, "kill yourself"],
    'kick': [CommandManager.kick, "disconnect from the server"],
    'worldoff': [CommandManager.worldoff, "stop the server"],
    'guildcreate': [CommandManager.guildcreate, "create and join a guild"],
    'alltaxis': [CommandManager.alltaxis, "discover all flights"]
}
