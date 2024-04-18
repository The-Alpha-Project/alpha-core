from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.ChatManager import ChatManager
from utils.constants.SpellCodes import SpellEffects
from game.world.managers.CommandManager import CommandManager

from utils.Logger import Logger


class TelnetCommandManager(CommandManager):
    @staticmethod
    def _handle_command(command_dict, parent_conn):
        if parent_conn:
            Logger.set_parent_conn(parent_conn)

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

        ChatManager.send_system_message(world_session, f'You got all taxis enabled until logout')
        return 0, f'{player} got all taxis enabled'

    @staticmethod
    def additem(world_session=None, args=None, player=None):
        if not world_session:
            return -1, f'Missing session or player'
        
        code, res = CommandManager.additem(world_session, args)
        return code, f'{res}'
        
    @staticmethod
    def additems(world_session=None, args=None, player=None):
        if not world_session:
            return -1, f'Missing session or player'
        
        code, res = CommandManager.additems(world_session, args)
        return code, f'{res}'

    @staticmethod
    def ann(world_session=None, args=None, player=None):
        msg = player + ' ' + args
        code, res = CommandManager.ann(world_session, msg.strip())

        if code != 0:
            return code, res

        return code, f'Sent "{msg}" message to server'

    @staticmethod
    def dticket(world_session=None, args=None, player=None):
        return CommandManager.dticket(world_session, player)

    @staticmethod
    def gps(world_session=None, args=None, player=None):
        if not world_session or not player:
            return -1, f'Missing session or player'
          
        code, res = CommandManager.gps(world_session, player)

        return code, f'GPS: \n{res}'

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

        if 0 < int(args) > 1000000000:
            return -1, f'Copper not within interval (min 1, max 1000000000)'

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
                Logger.plain(f'{session.player_mgr.get_name()}\n') 
            else:
                Logger.plain(f'In character creation.\n')

        return 0, f''
    
    @staticmethod
    def player_info(world_session=None, args=None, player=None):
        if not world_session or not player:
            return -1, f'Missing session or player'
      
        code, res = CommandManager.player_info(world_session, player) 

        if code != 0:
            return code, res

        return code, f'Player info: \n{res}'

    @staticmethod
    def petlevel(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'

        code, res = CommandManager.petlevel(world_session, args) 

        if code != 0:
            return code, res

        return 0, f'pet {player} level is now {args}'
    
    @staticmethod
    def qadd(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'
        
        code, res = CommandManager.qadd(world_session, args) 
        return code, f'{res}'
    
    @staticmethod
    def qdel(world_session=None, args=None, player=None):
        if not world_session or not args:
            return -1, f'Missing session or player'
        
        code, res = CommandManager.qdel(world_session, args) 
        return code, f'{res}'
    
    @staticmethod
    def qlist(world_session=None, args=None, player=None):
        # player_mgr = CommandManager._target_or_self(world_session)
        player_mgr = world_session.player_mgr
        active_quests = player_mgr.quest_manager.active_quests

        if not active_quests:
            return -1, 'Player got no quests.'

        for entry in active_quests:
            quests = WorldDatabaseManager.quest_get_by_entry(entry)
        
            for quest in quests:
                quest_text = f'id: {quest.entry} - {quest.Title}'
                Logger.info(f'{quest_text}')
        
        return 0, f'{len(active_quests)} quests found.'

    @staticmethod
    def rticket(world_session=None, args=None, player=None):
        try:
            ticket_id = int(player)
            ticket = RealmDatabaseManager.ticket_get_by_id(ticket_id)
            if ticket:
                return 0, f'id: {ticket_id} : {ticket.character_name} : {ticket.text_body}'
            return -1, 'ticket not found.'
        except ValueError:
            return -1, 'please specify a valid ticket id.'

    @staticmethod
    def serverinfo(world_session=None, args=None, player=None):
        code, res = CommandManager.serverinfo(world_session, args) 

        if code != 0:
            return code, res

        return code, f'Server info: \n{res}'
    
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
    
    @staticmethod
    def tickets(world_session=None, args=None, player=None):
        tickets = RealmDatabaseManager.ticket_get_all()
        for ticket in tickets:
            ticket_title = 'Bug report' if ticket.is_bug else 'Suggestion'
            ticket_text = f'id: {ticket.id} : {ticket.submit_time} : {ticket_title} from {ticket.character_name}.\n'
            Logger.plain(ticket_text)
        return 0, f'{len(tickets)} tickets shown.'


TELNET_COMMAND_DEFINITIONS = {
    'alltaxis': [TelnetCommandManager.alltaxis, 'Discover all flight paths. Usage: /alltaxis <player name>'],
    'additem': [TelnetCommandManager.additem, 'Add an item to player bag'],
    'additems': [TelnetCommandManager.additems, 'Add items to player bag'],
    'ann': [TelnetCommandManager.ann, 'Write a server side announcement'],
    'dticket': [TelnetCommandManager.dticket, 'Delete a ticket'],
    'gps': [TelnetCommandManager.gps, 'Display information about player location'],
    'help': [TelnetCommandManager.help, 'Prints this message'],
    'kick': [TelnetCommandManager.kick, 'Kick player from the server. Usage: /kick <player name>.'],
    'level': [TelnetCommandManager.level, 'Set player level. Value must be between 1-25. Usage: /level <player name> <1-25>.'],
    'msg': [TelnetCommandManager.msg, 'Send message to player. Usage: /msg <player name> <msg>'],
    'money': [TelnetCommandManager.money, 'Give money to player. Usage /money <player name> <copper, max 1000000000>'],
    'online': [TelnetCommandManager.online, 'List all online players. Usage: /online'],
    'pinfo': [TelnetCommandManager.player_info, 'Get targeted player info'],
    'petlevel': [TelnetCommandManager.petlevel, 'Set player active pet level. Usage: /petlevel <player name> <1-100>'],
    'qadd': [TelnetCommandManager.qadd, 'adds a quest to your log'],
    'qdel': [TelnetCommandManager.qdel, 'delete active or completed quest'],
    'qlist': [TelnetCommandManager.qlist, 'List player quests'],
    'rticket': [TelnetCommandManager.rticket, 'search a ticket'],
    'serverinfo': [TelnetCommandManager.serverinfo, 'Print server information. Usage: /serverinfo.'],
    'sitem': [TelnetCommandManager.sitem, 'Search items. Usage: /sitem <query>'],
    'sspell': [TelnetCommandManager.sspell, 'search spells'],
    'speed': [TelnetCommandManager.speed, 'Change run speed. Usage: /speed <player name> <value, max 10>'],
    'squest': [TelnetCommandManager.squest, 'Search quests. Usage: /squest <query>'],
    'stel': [TelnetCommandManager.stel, 'Search for teleport location. Usage: /stel <query>'],
    'summon': [TelnetCommandManager.summon, 'Summon a player to another player position. Usage: /summon <player name> <to other player>. Can summon to offline players.'],
    'swimspeed': [TelnetCommandManager.swimspeed, 'change player swim speed. Usage: /swimspeed <player name> <value, max 10'],
    'tel': [TelnetCommandManager.tel, 'Teleport player to a location. Usage: /tel <player name> <location>'],
    'tickets': [TelnetCommandManager.tickets, 'List all tickets'],
 
    # 'pwdchange': [CommandManager.pwdchange, 'change your password']
    # 'telunit': [CommandManager.tel_unit, 'teleport a unit to a given location in the same map'],
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
       # 'goplayer': [CommandManager.goplayer, 'go to a player position'],
     # 'gocreature': [CommandManager.gocreature, 'go to a creature position'], 
    # 'mount': [CommandManager.mount, 'mount'],
    # 'unmount': [CommandManager.unmount, 'dismount'],
    # 'morph': [CommandManager.morph, 'morph the targeted unit'],
    # 'demorph': [CommandManager.demorph, 'demorph the targeted unit'],
    # 'die': [CommandManager.die, 'kills target or yourself if no target is selected'],
     # 'guildcreate': [CommandManager.guildcreate, 'create and join a guild'],
     # 'fevent': [CommandManager.fevent, 'force the given event to execute']
     # 'worldoff': [CommandManager.worldoff, 'stop the world server']
}
