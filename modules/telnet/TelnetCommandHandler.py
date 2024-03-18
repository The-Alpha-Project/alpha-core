# from utils.Logger import Logger

from utils.Logger import Logger
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from modules.telnet.CommandManagerExtended import CommandManagerExtended

class TelnetCommandHandler:
    
    def starts(parent_conn=None):
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

                        if not msg_list[0] in exeptions:
                            msg = f"{msg_list[0]} {' '.join(msg_list[2:])}".strip()
                            user = msg_list[1]
                        else:
                            msg = f"{msg_list[0]} {' '.join(msg_list[1:])}".strip()
                    except:
                        msg = f"{msg_list[0]} {' '.join(msg_list[1:])}".strip()

                    msg = msg.replace('/', '.', 1)
                    msg = msg.replace('/', ' ')

                    Logger.success(f'Sent {msg} to {user}')
                    CommandManagerExtended.handle_command(player_session, msg)