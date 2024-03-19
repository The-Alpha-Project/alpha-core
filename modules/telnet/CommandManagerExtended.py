from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.TextUtils import GameTextFormatter
from utils.constants.SpellCodes import SpellEffects, SpellTargetMask
from game.world.managers.CommandManager import CommandManager, PLAYER_COMMAND_DEFINITIONS, GM_COMMAND_DEFINITIONS, DEV_COMMAND_DEFINITIONS

from utils.Logger import Logger


## TODO: Add more methods for commands, 
## TODO: Add method to check if user is online
## TODO: Add method method to check if any player is online


class CommandManagerExtended(CommandManager):
     # Telnet commands
    
    @staticmethod
    def _check_if_player_online(world_session, args):
        world_sessions = WorldSessionStateHandler.get_world_sessions()
        
        for session in world_sessions:
            if args.lower() == session.player_mgr.get_name().lower():
                return 1
            
        return 0

    def _execute_command(world_session, args, method_name):
        player, msg = args.split(' ', 1)
        
        if CommandManagerExtended._check_if_player_online(world_session, player):
            getattr(CommandManager, method_name)(world_session, msg)
            return 0, ''
    
        Logger.error(f'Cannot find player: {player}') 
        return 1, ''

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
        
        return 0, f''
    
    """
    @staticmethod
    def kick(world_session, args):
        player, msg = args.split(' ', 1)
        
        if CommandManagerExtended._check_if_player_online(world_session, player):
            CommandManager.kick(world_session, player)
            return 0, ''
        
        Logger.error(f'Cannot find player: {player}') 
        return 1, '' 

    @staticmethod
    def level(world_session, args):
        player, msg = args.split(' ', 1)
        
        if CommandManagerExtended._check_if_player_online(world_session, player):
            CommandManager.money(world_session, msg)
            return 0, ''
        
        Logger.error(f'Cannot find player: {player}') 
        return 1, ''"""

    @staticmethod
    def kick(world_session, args):
        return CommandManagerExtended._execute_command(world_session, args, 'kick') 

    @staticmethod
    def level(world_session, args):
        return CommandManagerExtended._execute_command(world_session, args, 'level')
    
    @staticmethod
    def msg(world_session, args):
        return CommandManagerExtended._execute_command(world_session, args, 'msg')

    @staticmethod
    def money(world_session, args):
        return CommandManagerExtended._execute_command(world_session, args, 'money')

    """@staticmethod
    def msg(world_session, args):
        player, msg = args.split(' ', 1)
        msg = "Server: " + msg

        if CommandManagerExtended._check_if_player_online(world_session, player):
            ChatManager.send_system_message(world_session, msg)
            return 0, ''

        Logger.error(f'Cannot find player: {player}') 
        return 1, ''

    @staticmethod
    def money(world_session, args):
        player, msg = args.split(' ', 1)

        if CommandManagerExtended._check_if_player_online(world_session, player):
            CommandManager.money(world_session, msg)
            return 0, ''

        Logger.error(f'Cannot find player: {player}') 
        return 1, ''
        """

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
    

TELNET_COMMAND_DEFINITIONS = {
    'help': [CommandManagerExtended.help, 'prints this message'],
    'kick': [CommandManagerExtended.kick, 'kick your target from the server'],
    'level': [CommandManagerExtended.level, 'set your or others level'],
    'msg': [CommandManagerExtended.msg, 'Send message to player'],
    'money': [CommandManagerExtended.money, 'shows a list on all people online'],
    'online': [CommandManagerExtended.online, 'shows a list on all people online'],
    'tel': [CommandManager.tel, 'teleport you to a location'],
    'stel': [CommandManager.stel, 'search for a location where you can teleport']
}