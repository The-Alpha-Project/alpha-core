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
    @staticmethod
    def _handle_command(command_dict):
        command = command_dict['command']
        args = command_dict['args']
        player = command_dict['player']

        world_session = None

        if player:
            world_session = WorldSessionStateHandler.get_session_by_character_name(player) 
        
        if command in TELNET_COMMAND_DEFINITIONS:
            command_func = TELNET_COMMAND_DEFINITIONS[command][0]
        else:
            Logger.error(f'Command not found, type /help for help.')
            return 0
        
        if command_func:
            try:
                code, res = command_func(world_session, args, player)
                if code != 0:
                    Logger.error(f'Error with <{command}> command: {res}')
                elif res:
                    Logger.success(f'{res}')
            except Exception as e:
                Logger.error(f'{e}')

    @staticmethod
    def help(world_session=None, args=None, cmd=None):
        Logger.info(f'Listening server commands') 
        Logger.info(f'Please use this format: /<command> <player> <args>') 
        Logger.info(f'You can shwo help text on one command: /help <command>\n') 

        if not cmd:
            for command in TELNET_COMMAND_DEFINITIONS:
                Logger.info(f'{command}')
        else:
            command = TELNET_COMMAND_DEFINITIONS[cmd]
            Logger.info(f'{cmd}:')
            Logger.info(f'{command[1]}')

        return 0, f''
    
    @staticmethod
    def kick(world_session, args, player):
        if not world_session or not player:
            return 1, f'Missing session or player'

        code, res = CommandManager.kick(world_session, args)
 
        if code != 0:
            return code, res

        return 0, f"{player} has been kicked"

    @staticmethod
    def level(world_session, args, player):
        if not world_session or not args:
            return 1, f'Missing session or player'

        code, res = CommandManager.level(world_session, args) 

        if code != 0:
            return code, res

        return 0, f"{player} level is now {args}"
   
    @staticmethod
    def money(world_session, args, player):
        if not world_session or not args:
            return 1, f'Missing session or player'

        code, res = CommandManager.money(world_session, args)

        if code != 0:
            return code, res

        return 0, f"{player} got {args} coppar"
    
    @staticmethod
    def msg(world_session, args, player):
        if not world_session or not args:
            return 1, f'Missing session or player'
      
        ChatManager.send_system_message(world_session, args)

        return 0, f'Sent {args} to {player}'
    
    @staticmethod
    def online(world_session,args, player):
        world_sessions = WorldSessionStateHandler.get_world_sessions()

        if len(world_sessions) <= 0:
            return 1, f'No players online'

        Logger.info(f'Online players')

        for session in world_sessions:
            if hasattr(session.player_mgr, 'get_name'):
                Logger.info(f'{session.player_mgr.get_name()}') 
            else:
                Logger.info(f'No player online yet, in character creation')

        return 0, f''
         

TELNET_COMMAND_DEFINITIONS = {
    'help': [CommandManagerExtended.help, 'Prints this message'],
    'kick': [CommandManagerExtended.kick, 'Kick player from the server'],
    'level': [CommandManagerExtended.level, 'Set player level'],
    'msg': [CommandManagerExtended.msg, 'Send message to player'],
    'money': [CommandManagerExtended.money, 'Give money to player'],
    'online': [CommandManagerExtended.online, 'List all online players'],

    # 'serverinfo': [CommandManager.serverinfo, 'print server information'],
    # 'pwdchange': [CommandManager.pwdchange, 'change your password']
    # 'speed': [CommandManager.speed, 'change your run speed'],
    # 'swimspeed': [CommandManager.swim_speed, 'change your swim speed'],
    # 'tel': [CommandManager.tel, 'teleport you to a location'],
    # 'stel': [CommandManager.stel, 'search for a location where you can teleport'],
    # 'gps': [CommandManager.gps, 'display information about your location'],
    # 'tel': [CommandManager.tel, 'teleport you to a location'],
    # 'stel': [CommandManager.stel, 'search for a location where you can teleport'],
    # 'telunit': [CommandManager.tel_unit, 'teleport a unit to a given location in the same map'],
    # 'sitem': [CommandManager.sitem, 'search items'],
    # 'additem': [CommandManager.additem, 'add an item to your bag'],
    # 'additems': [CommandManager.additems, 'add items to your bag'],
    # 'sspell': [CommandManager.sspell, 'search spells'],
    # 'lspell': [CommandManager.lspell, 'learn a spell'],
    # 'lspells': [CommandManager.lspells, 'learn multiple spells'],
    # 'unlspell': [CommandManager.unlspell, 'unlearn a spell'],
    # 'unltalent': [CommandManager.unltalent, 'unlearn a talent'],
    # 'addaura': [CommandManager.addaura, 'add an aura by spell id'],
    # 'clearauras': [CommandManager.clearauras, 'clear all auras'],
    # 'sskill': [CommandManager.sskill, 'search skills'],
    # 'lskill': [CommandManager.lskill, 'learn a skill'],
    # 'lskills': [CommandManager.lskills, 'learn skills'],
    # 'setskill': [CommandManager.setskill, 'set a skill level'],
    # 'port': [CommandManager.port, 'teleport using coordinates'],
    # 'tickets': [CommandManager.tickets, 'list all tickets'],
    # 'rticket': [CommandManager.rticket, 'search a ticket'],
    # 'dticket': [CommandManager.dticket, 'delete a ticket'],
    # 'goplayer': [CommandManager.goplayer, 'go to a player position'],
    # 'gocreature': [CommandManager.gocreature, 'go to a creature position'],
    # 'summon': [CommandManager.summon, 'summon a player to your position'],
    # 'ann': [CommandManager.ann, 'write a server side announcement'],
    # 'mount': [CommandManager.mount, 'mount'],
    # 'unmount': [CommandManager.unmount, 'dismount'],
    # 'morph': [CommandManager.morph, 'morph the targeted unit'],
    # 'demorph': [CommandManager.demorph, 'demorph the targeted unit'],
    # 'pinfo': [CommandManager.player_info, 'get targeted player info'],
    # 'petlevel': [CommandManager.petlevel, 'set your active pet level'],
    # 'die': [CommandManager.die, 'kills target or yourself if no target is selected'],
    # 'kick': [CommandManager.kick, 'kick your target from the server'],
    # 'guildcreate': [CommandManager.guildcreate, 'create and join a guild'],
    # 'alltaxis': [CommandManager.alltaxis, 'discover all flight paths'],
    # 'squest': [CommandManager.squest, 'search quests'],
    # 'qadd': [CommandManager.qadd, 'adds a quest to your log'],
    # 'qdel': [CommandManager.qdel, 'delete active or completed quest'],
    # 'fevent': [CommandManager.fevent, 'force the given event to execute']
    # 'destroymonster': [CommandManager.destroymonster, 'destroy the selected creature'],
    # 'createmonster': [CommandManager.createmonster, 'spawn a creature at your position'],
    # 'sloc': [CommandManager.save_location, 'save your location to locations.log along with a comment'],
    # 'worldoff': [CommandManager.worldoff, 'stop the world server']
}
