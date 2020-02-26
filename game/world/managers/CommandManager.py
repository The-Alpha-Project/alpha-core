from struct import pack

from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
from game.world.managers.ChatManager import ChatManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager


class CommandManager(object):

    @staticmethod
    def handle_command(world_session, command_msg):
        terminator_index = command_msg.find(' ') if ' ' in command_msg else len(command_msg)

        command = command_msg[1:terminator_index].strip()
        args = command_msg[terminator_index:].strip()

        if command in PLAYER_COMMAND_DEFINITIONS:
            command_func = PLAYER_COMMAND_DEFINITIONS.get(command)
        elif command in GM_COMMAND_DEFINITIONS and world_session.player_mgr.is_gm:
            command_func = GM_COMMAND_DEFINITIONS.get(command)
        else:
            ChatManager.send_system_message(world_session, 'Command not found, type .help for help.')
            return

        if command_func:
            code, res = command_func(world_session, args)
            if code != 0:
                ChatManager.send_system_message(world_session, 'Wrong arguments for <%s> command: %s' % (command, res))
            elif res:
                ChatManager.send_system_message(world_session, res)

    @staticmethod
    def help(world_session, args):
        help_str = ''

        if world_session.player_mgr.is_gm:
            gm_commands = [k for k in GM_COMMAND_DEFINITIONS.keys()]
            help_str += '[GM Commands]: \n%s\n\n' % ', '.join(gm_commands)

        player_commands = [k for k in PLAYER_COMMAND_DEFINITIONS.keys()]
        help_str += '[Player Commands]: \n%s' % ', '.join(player_commands)

        return 0, help_str

    @staticmethod
    def speed(world_session, args):
        try:
            speed = 7.0 * float(args)
            world_session.player_mgr.change_speed(speed)

            return 0, ''
        except ValueError:
            return -1, 'wrong speed value.'

    @staticmethod
    def swim_speed(world_session, args):
        try:
            speed = 4.7222223 * float(args)
            world_session.player_mgr.change_swim_speed(speed)

            return 0, ''
        except ValueError:
            return -1, 'wrong speed value.'

    @staticmethod
    def gps(world_session, args):
        return 0, 'Map: %u, Zone: %u, X: %f, Y: %f, Z: %f, O: %f' % (
            world_session.player_mgr.map_,
            world_session.player_mgr.zone,
            world_session.player_mgr.location.x,
            world_session.player_mgr.location.y,
            world_session.player_mgr.location.z,
            world_session.player_mgr.location.o
        )

    @staticmethod
    def tel(world_session, args):
        tel_name = args.split()[0]
        location = WorldDatabaseManager.worldport_get_by_name(world_session.world_db_session, tel_name)

        if location:
            tel_location = Vector(location.x, location.y, location.z)
            world_session.player_mgr.teleport(location.map, tel_location)

            return 0, 'Teleported to "%s".' % location.name
        return -1, '"%s" not found.' % tel_name

    @staticmethod
    def port(world_session, args):
        try:
            x, y, z, map_ = args.split()
            tel_location = Vector(float(x), float(y), float(z))
            world_session.player_mgr.teleport(int(map_), tel_location)

            return 0, ''
        except ValueError:
            return -1, 'please use the "x y z map" format.'

    @staticmethod
    def tickets(world_session, args):
        tickets = RealmDatabaseManager.ticket_get_all(world_session.realm_db_session)
        for ticket in tickets:
            ticket_text = '%s[%s]|r %s: %s from %s.' % ('|cFFFF0000' if ticket.is_bug else '|cFF00FFFF',
                                                        ticket.id,
                                                        ticket.submit_time,
                                                        'Bug report' if ticket.is_bug else 'Suggestion',
                                                        ticket.character_name)
            ChatManager.send_system_message(world_session, ticket_text)
        return 0, '%u tickets shown.' % len(tickets)

    @staticmethod
    def rticket(world_session, args):
        try:
            ticket_id = int(args)
            ticket = RealmDatabaseManager.ticket_get_by_id(world_session.realm_db_session, ticket_id)
            if ticket:
                return 0, '%s[%s] %s:|r %s' % ('|cFFFF0000' if ticket.is_bug else '|cFF00FFFF', ticket_id,
                                               ticket.character_name, ticket.text_body)
            return -1, 'ticket not found.'
        except ValueError:
            return -1, 'please specify a valid ticket id.'

    @staticmethod
    def dticket(world_session, args):
        try:
            ticket_id = int(args)
            if RealmDatabaseManager.ticket_delete(world_session.realm_db_session, ticket_id) == 0:
                return 0, 'Ticket %u deleted.' % ticket_id
            return -1, 'ticket not found.'

        except ValueError:
            return -1, 'please specify a valid ticket id.'

    @staticmethod
    def goplayer(world_session, args):
        player_name = args
        is_online = True

        player = WorldSessionStateHandler.find_player_by_name(player_name)
        player_location = None
        map_ = 0

        if player:
            player_location = player.location
            map_ = player.map_
        else:
            is_online = False
            player = RealmDatabaseManager.character_get_by_name(world_session.realm_db_session, player_name)

        if player:
            if not is_online:
                player_location = Vector(float(player.position_x), float(player.position_y), float(player.position_z))
                map_ = player.map
        else:
            return -1, 'player not found.'

        world_session.player_mgr.teleport(int(map_), player_location)

        return 0, 'Teleported to player %s (%s).' % (player_name.capitalize(), 'Online' if is_online else 'Offline')

    @staticmethod
    def summon(world_session, args):
        player_name = args
        is_online = True

        player = WorldSessionStateHandler.find_player_by_name(player_name)

        if player:
            player.teleport(world_session.player_mgr.map_, world_session.player_mgr.location)
        else:
            is_online = False
            player = RealmDatabaseManager.character_get_by_name(world_session.realm_db_session, player_name)

        if player:
            if not is_online:
                player.map = world_session.player_mgr.map_
                player.zone = world_session.player_mgr.zone
                player.position_x = world_session.player_mgr.location.x
                player.position_y = world_session.player_mgr.location.y
                player.position_z = world_session.player_mgr.location.z
                RealmDatabaseManager.save(world_session.realm_db_session)
        else:
            return -1, 'player not found.'

        return 0, 'Summoned player %s (%s).' % (player_name.capitalize(), 'Online' if is_online else 'Offline')

    @staticmethod
    def ann(world_session, args):
        ann = str(args)

        for session in WorldSessionStateHandler.get_world_sessions():
            if session.player_mgr and session.player_mgr.is_online:
                ChatManager.send_system_message(session, '[SERVER] %s' % ann)

        return 0, ''


PLAYER_COMMAND_DEFINITIONS = {
    'help': CommandManager.help
}

GM_COMMAND_DEFINITIONS = {
    'speed': CommandManager.speed,
    'swimspeed': CommandManager.swim_speed,
    'gps': CommandManager.gps,
    'tel': CommandManager.tel,
    'port': CommandManager.port,
    'tickets': CommandManager.tickets,
    'rticket': CommandManager.rticket,
    'dticket': CommandManager.dticket,
    'goplayer': CommandManager.goplayer,
    'summon': CommandManager.summon,
    'ann': CommandManager.ann
}
