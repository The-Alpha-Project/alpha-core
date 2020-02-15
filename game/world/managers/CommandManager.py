from struct import pack

from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
from game.world.managers.ChatManager import ChatManager
from database.world.WorldDatabaseManager import WorldDatabaseManager


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
            speed = float(args)
            world_session.player_mgr.change_speed(speed)

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
        location = WorldDatabaseManager.get_location_by_name(world_session.world_db_session, tel_name)

        if location:
            tel_location = Vector(location.x, location.y, location.z)
            world_session.player_mgr.teleport(location.map, tel_location)

            return 0, ''
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


PLAYER_COMMAND_DEFINITIONS = {
    'help': CommandManager.help
}

GM_COMMAND_DEFINITIONS = {
    'speed': CommandManager.speed,
    'gps': CommandManager.gps,
    'tel': CommandManager.tel,
    'port': CommandManager.port
}
