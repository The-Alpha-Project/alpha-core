from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.TextUtils import GameTextFormatter
from utils.constants.SpellCodes import SpellEffects, SpellTargetMask
from game.world.managers.CommandManager import CommandManager, PLAYER_COMMAND_DEFINITIONS, GM_COMMAND_DEFINITIONS, DEV_COMMAND_DEFINITIONS

from utils.Logger import Logger


class CommandManagerExtended(CommandManager):
     # Telnet commands
    
    @staticmethod
    def handle_command(world_session, command_msg):
        """
        Handles commands sent by telnet. It uses players session (which we get from player name)
        but buypass all dev or gm tests. Also send all output to Logger instead of chat.
        """
        terminator_index = command_msg.find(' ') if ' ' in command_msg else len(command_msg)

        command = command_msg[1:terminator_index].strip()
        args = command_msg[terminator_index:].strip()


        if command in TELNET_COMMAND_DEFINITIONS:
            command_func = TELNET_COMMAND_DEFINITIONS[command][0]
     #   elif commandmoneyfunc = DEV_COMMAND_DEFINITIONS[command][0]
        else:
            Logger.error(f'Command not found, type /help for help.')
            return

        if command_func:
            try:
                code, res = command_func(world_session, args)
                if code != 0:
                    Logger.error(f'Error with <{command}> command: {res}')
                elif res:
                    Logger.success(f'{res}')
            except Exception as e:
                Logger.error(f'{e}')
                

    @staticmethod
    def help(world_session, args):
        Logger.info(f'Listening server commands') 
        Logger.info(f'Please notice, in most commands you need') 
        Logger.info(f'to add player ex. /<command> <player> <args>') 

        Logger.plain(f'All server commands: \n\n')

        for command in TELNET_COMMAND_DEFINITIONS:
            Logger.plain(f'{command}\n')
      #  for command in DEV_COMMAND_DEFINITIONS:
      #      Logger.plain(f'{command}\n') 
      #  for command in GM_COMMAND_DEFINITIONS:
      #      Logger.plain(f'{command}\n') 
      #  for command in PLAYER_COMMAND_DEFINITIONS:
      #      Logger.plain(f'{command}\n')  
        
        return 0, f''
    
    @staticmethod
    def check_if_player_online(world_session, args):
        world_sessions = WorldSessionStateHandler.get_world_sessions()
        
        for session in world_sessions:
            # Logger.info(f'{session.player_mgr.get_name()}')

            if args.lower() == session.player_mgr.get_name().lower():
                return 1
            
        return 0

    @staticmethod
    def online(world_session, args): 
        world_sessions = WorldSessionStateHandler.get_world_sessions()
                        

        if len(world_sessions) <= 0:
            Logger.info(f'No players are online') 
            return 0, f''

        Logger.info(f'Online players')

        for session in world_sessions:
            Logger.info(f'{session.player_mgr.get_name()}')
        
        return 0, f''

    @staticmethod
    def tickets(world_session, args):
        tickets = RealmDatabaseManager.ticket_get_all()
        for ticket in tickets:
            ticket_color = '|cFFFF0000' if ticket.is_bug else '|cFF00FFFF'
            ticket_title = 'Bug report' if ticket.is_bug else 'Suggestion'
            ticket_text = f'{ticket_color}[{ticket.id}]|r {ticket.submit_time}: {ticket_title} from {ticket.character_name}.'
            
            Logger.info(f'{ticket_text}')

        return 0, ''

    @staticmethod
    def msg(world_session, args):
        player, msg = args.split(' ', 1)
        msg = "Server: " + msg

        if CommandManagerExtended.check_if_player_online(world_session, player):
            ChatManager.send_system_message(world_session, msg)
            return 0, ''

        Logger.error(f'Cannot find player: {player}') 
        return 1, ''

    @staticmethod
    def stel(world_session, args):
        try:
            tel_name = args.split()[0]
        except IndexError:
            Logger.error(f'please specify a location name to start searching.') 
            return -1, ''

        locations = WorldDatabaseManager.worldport_get_by_name(tel_name, return_all=True)

        for location in locations:
            port_text = f'|cFF00FFFF[Map {location.map}]|r - {location.name}'
            Logger.info(f'{port_text}') 

        return 0, f''

    @staticmethod
    def sitem(world_session, args):
        item_name = args.strip()
        if not item_name:
            Logger.error(f'please specify an item name to start searching.') 
            return -1, ''
        items = WorldDatabaseManager.item_template_get_by_name(item_name, return_all=True)

        for item in items:
            item_link = GameTextFormatter.generate_item_link(item.entry, item.name, item.quality)
            item_text = f'{item.entry} - {item_link}'
            Logger.info(f'{item_text}') 
        return 0, f''

    @staticmethod
    def sspell(world_session, args):
        spell_name = args.strip()
        if not spell_name:
            Logger.error(f'please specify a spell name to start searching.') 
            return -1, ''
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

            Logger.info(f'{spell_text}') 
        return 0, f''

    @staticmethod
    def lspell(world_session, args):
        code, res = CommandManager._parse_spell_id_check_spell_exist(args)
        if code == 0:
            spell_id = res
            if not world_session.player_mgr.spell_manager.learn_spell(spell_id):
                Logger.error(f'unable to learn spell, already known or skill limit reached.') 
                return -1, ''
            Logger.info(f'Spell lerned') 
            return 0, ''
        return code, res

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

                Logger.info(f'[{gobject.get_name()}]\n'
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

            Logger.info(f'{found_count} game objects found within {max_distance} distance units.')
            return 0, f''
        except ValueError:
            Logger.error(f'please specify a valid distance.')
            return -1, ''
        

TELNET_COMMAND_DEFINITIONS = {
    'help': [CommandManagerExtended.help, 'prints this message'],
    'msg': [CommandManagerExtended.msg, 'Send message to player'],
    'online': [CommandManagerExtended.online, 'shows a list on all people online'],
    'money': [CommandManager.money, 'shows a list on all people online']
}