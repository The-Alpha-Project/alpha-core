from database.dbc.DbcDatabaseManager import DbcDatabaseManager
# from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.TextUtils import GameTextFormatter
from utils.constants.SpellCodes import SpellEffects, SpellTargetMask
from game.world.managers.CommandManager import CommandManager

from utils.Logger import Logger


class TelnetCommandManager(CommandManager):
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
    def alltaxis(world_session=None, args=None, player=None):
        if not world_session:
            return -1, f'Missing session or player'

        code, res = CommandManager.alltaxis(world_session, args)

        if code != 0:
            return code, res

        return 0, f'{player} got all taxis enabled'

    @staticmethod
    def ann(world_session=None, player=None, args=None):
        code, res = CommandManager.ann(world_session, args)

        if code != 0:
            return code, res

        return 0, f'Sent \'{args}\' message to server'

    @staticmethod
    def gps(world_session=None, args=None, player=None):
        if not world_session or not player:
            return -1, f'Missing session or player'
          
        return CommandManager.gps(world_session, args)

    @staticmethod
    def help(world_session=None, args=None, cmd=None):

        if not cmd:
            Logger.plain(f'Listening server commands\n') 
            Logger.plain(f'Please use this format: /<command> <player> <args>\n') 
            Logger.plain(f'You can shwo help text on one command: /help <command>\n\n') 

            for command in TELNET_COMMAND_DEFINITIONS:
                Logger.plain(f'{command}\n')
        else:
            command = TELNET_COMMAND_DEFINITIONS[cmd]
            Logger.plain(f'Help text for {cmd}: {command[1]}\n')

        return 0, f''
    
    @staticmethod
    def kick(world_session, args, player):
        if not world_session or not player:
            return -1, f'Missing session or player'

        code, res = CommandManager.kick(world_session, args)
 
        if code != 0:
            return code, res

        return 0, f'{player} has been kicked'

    @staticmethod
    def level(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        if not 1 <= int(args) <= 25:
            return -1, f'Level need to be between 1 and 25'

        code, res = CommandManager.level(world_session, args) 

        if code != 0:
            return code, res

        return 0, f'{player} level is now {args}'
   
    @staticmethod
    def money(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        code, res = CommandManager.money(world_session, args)

        if code != 0:
            return code, res

        ChatManager.send_system_message(world_session, f'You got {args} copper')
        return 0, f'{player} got {args} copper'
    
    @staticmethod
    def msg(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'
      
        ChatManager.send_system_message(world_session, args)

        return 0, f'Sent {args} to {player}'
    
    @staticmethod
    def online(world_session=None, args=None, player=None):
        world_sessions = WorldSessionStateHandler.get_world_sessions()

        if len(world_sessions) <= 0:
            return -1, f'No players online'

        Logger.info(f'Online players')

        for session in world_sessions:
            if hasattr(session.player_mgr, 'get_name'):
                Logger.info(f'{session.player_mgr.get_name()}') 
            else:
                Logger.info(f'No player online yet. Some are in character creation.')

        return 0, f''
    
    @staticmethod
    def player_info(world_session=None, args=None, player=None):
        if not world_session or not player:
            return -1, f'Missing session or player'
      
        code, res = CommandManager.pinfo(world_session, player) 

        if code != 0:
            return code, res

        return 0, f''

    @staticmethod
    def petlevel(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        code, res = CommandManager.petlevel(world_session, args) 

        if code != 0:
            return code, res

        return 0, f'pet {player} level is now {args}'
    
    @staticmethod
    def serverinfo(world_session=None, args=None, player=None):
        code, res = CommandManager.serverinfo(world_session, args) 

        if code != 0:
            return code, res

        return 0, f'{res}'
    
    @staticmethod
    def sitem(world_session=None, player=None, args=None):
        item_name = args
        
        if not item_name:
            return -1, 'please specify an item name to start searching.'
        items = WorldDatabaseManager.item_template_get_by_name(item_name, return_all=True)

        for item in items:
            item_text = f'id: {item.entry} - {item.name}\n'
            Logger.plain(f'{item_text}')
        return 0, f''

    @staticmethod
    def speed(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        if not 1 <= int(args) <=10:
            return -1, f'Speed arg need to be between 1 and 10'

        code, res = CommandManager.speed(world_session, args) 

        if code != 0:
            return code, res

        ChatManager.send_system_message(world_session, f'Your speed is set to {args}')
        return 0, f'{player} speed is now {args}'
    
    @staticmethod
    def squest(world_session=None, player=None, args=None):
        quest_title = args

        if not quest_title:
            return -1, 'please specifiy a quest title to start searching.'
        quests = WorldDatabaseManager.quest_get_by_title(quest_title)
        
        for quest in quests:
            quest_title = quest.Title
            quest_text = f'id: {quest.entry} - {quest_title}'
            Logger.plain(f'{quest_text}\n')
        return 0, f'{len(quests)} quests found.'

    @staticmethod
    def sspell(world_session=None, args=None, player=None):
        spell_name = args

        if not spell_name:
            return -1, 'please specify a spell name to start searching.'
        spells = DbcDatabaseManager.spell_get_by_name(spell_name)

        for spell in spells:
            spell_name = spell.Name_enUS.replace('\\', '')
            spell_text = f'{spell.ID} - {spell_name}]\n'
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
                spell_text += f'\tTeaches: {learned_spells_text}'

            Logger.plain(f'{spell_text}')
        return 0, f'{len(spells)} spells found.'
    
    @staticmethod
    def stel(world_session=None, player=None, args=None):
        try:
            tel_name = args
        except IndexError:
            return -1, 'please specify a location name to start searching.'
        locations = WorldDatabaseManager.worldport_get_by_name(tel_name, return_all=True)

        for location in locations:
            port_text = f'map: {location.map} - {location.name}'
            Logger.plain(f'{port_text}\n')

        return 0, f''
    
    @staticmethod
    def summon(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        code, res = CommandManager.summon(world_session, args)

        if code != 0:
            return code, res

        return 0, f'Summoned {args} to {player}'

    @staticmethod
    def swimspeed(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        if not 1 <= int(args) <= 10:
            return -1, f'Speed arg need to be between 1 and 10'

        code, res = CommandManager.swim_speed(world_session, args) 

        if code != 0:
            return code, res

        ChatManager.send_system_message(world_session, f'Your swimspeed is set to {args}')
        return 0, f'{player} swimspeed is now {args}'
    
    @staticmethod
    def tel(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        code, res = CommandManager.tel(world_session, args) 

        if code != 0:
            return code, res

        return 0, f'Teleported {player} to {args}'
    

TELNET_COMMAND_DEFINITIONS = {
    'alltaxis': [TelnetCommandManager.alltaxis, 'discover all flight paths. Usage: /alltaxis <player name>'],
    'ann': [TelnetCommandManager.ann, 'write a server side announcement'],
    'gps': [TelnetCommandManager.gps, 'display information about your location'],
    'help': [TelnetCommandManager.help, 'Prints this message'],
    'kick': [TelnetCommandManager.kick, 'Kick player from the server. Usage: /kick <player name>.'],
    'level': [TelnetCommandManager.level, 'Set player level. Value must be between 1-25. Usage: /level <player name> <1-25>.'],
    'msg': [TelnetCommandManager.msg, 'Send message to player. Usage: /msg <player name> <msg>'],
    'money': [TelnetCommandManager.money, 'Give money to player. Usage /money <player name> <copper, max 100000>'],
    'online': [TelnetCommandManager.online, 'List all online players. Usage: /online'],
    'pinfo': [TelnetCommandManager.player_info, 'get targeted player info'],
    'petlevel': [TelnetCommandManager.petlevel, 'Set player active pet level. Usage: /petlevel <player name> <1-100>'],
    'serverinfo': [TelnetCommandManager.serverinfo, 'Print server information. Usage: /serverinfo.'],
    'sitem': [TelnetCommandManager.sitem, 'Search items. Usage: /sitem <query>'],
    'sspell': [TelnetCommandManager.sspell, 'search spells'],
    'speed': [TelnetCommandManager.speed, 'Change run speed. Usage: /speed <player name> <value, max 10>'],
    'squest': [TelnetCommandManager.squest, 'Search quests. Usage: /squest <query>'],
    'stel': [TelnetCommandManager.stel, 'Search for teleport location. Usage: /stel <query>'],
    'summon': [TelnetCommandManager.summon, 'summon a player to your position. Usage: /summon <player name> <other player name>. Can summon offline players.'],
    'swimspeed': [TelnetCommandManager.swimspeed, 'change player swim speed. Usage: /swimspeed <player name> <value, max 10'],
    'tel': [TelnetCommandManager.tel, 'teleport player to a location. Usage: /tel <player name> <location>'],
 
    # 'pwdchange': [CommandManager.pwdchange, 'change your password']
    # 'telunit': [CommandManager.tel_unit, 'teleport a unit to a given location in the same map'],
       # 'additem': [CommandManager.additem, 'add an item to your bag'],
       # 'additems': [CommandManager.additems, 'add items to your bag'],
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
    # 'mount': [CommandManager.mount, 'mount'],
    # 'unmount': [CommandManager.unmount, 'dismount'],
    # 'morph': [CommandManager.morph, 'morph the targeted unit'],
    # 'demorph': [CommandManager.demorph, 'demorph the targeted unit'],
    # 'die': [CommandManager.die, 'kills target or yourself if no target is selected'],
     # 'guildcreate': [CommandManager.guildcreate, 'create and join a guild'],
       # 'qadd': [CommandManager.qadd, 'adds a quest to your log'],
       # 'qdel': [CommandManager.qdel, 'delete active or completed quest'],
     # 'fevent': [CommandManager.fevent, 'force the given event to execute']
    # 'destroymonster': [CommandManager.destroymonster, 'destroy the selected creature'],
    # 'createmonster': [CommandManager.createmonster, 'spawn a creature at your position'],
    # 'sloc': [CommandManager.save_location, 'save your location to locations.log along with a comment'],
     # 'worldoff': [CommandManager.worldoff, 'stop the world server']
}