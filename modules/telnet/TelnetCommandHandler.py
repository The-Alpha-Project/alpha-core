# from utils.Logger import Logger

from utils.Logger import Logger
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from modules.telnet.CommandManagerExtended import CommandManagerExtended

class TelnetCommandHandler:

    def starts(parent_conn=None):
        if parent_conn:
            Logger.set_parent_conn(parent_conn)
        
        while True:
            if parent_conn.poll():
                str = parent_conn.recv()

                if isinstance(str, bytes):
                    msg = str.decode('utf-8')
    
                    if "/" in msg[0]: 
                        msg = msg[1:]        
                    else:
                        # Logger.error(f'Error with <{msg}>. command is missing')
                        return 0

                    parts = msg.split(maxsplit=2)

                    command_dict = {
                        "command": parts[0],
                        "player": parts[1] if len(parts) > 1 else None,
                        "args": parts[2] if len(parts) > 2 else None
                    }   

                    CommandManagerExtended._handle_command(command_dict)   

    
    def starts_bk(parent_conn=None):
        if parent_conn:
            Logger.set_parent_conn(parent_conn)
        
        exeptions = ['/ann', '/msg']

        while True:
            if parent_conn.poll():
                str = parent_conn.recv()

                if isinstance(str, bytes):
                    msg_list = str.decode('utf-8').split()
                    player_session = None
                    user = "server"
                        
                    try:
                        player_session = WorldSessionStateHandler.get_session_by_character_name(msg_list[1])

                      #  if not msg_list[0] in exeptions:
                        msg = f"{msg_list[0]} {' '.join(msg_list[2:])}".strip()
                        user = msg_list[1]
                       # else:
                        #    msg = f"{msg_list[0]} {' '.join(msg_list[1:])}".strip()
                    except:
                        msg = f"{msg_list[0]} {' '.join(msg_list[1:])}".strip()

                    Logger.success(f'Sent {msg} to {user}')

                    msg = msg.replace('/', '.', 1)
                    msg = msg.replace('/', ' ')
                    
                    CommandManagerExtended.handle_command(player_session, msg)