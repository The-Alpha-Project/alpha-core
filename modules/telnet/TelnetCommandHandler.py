from modules.telnet.TelnetCommandManager import TelnetCommandManager
from utils.Logger import Logger

class TelnetCommandHandler:

    def starts(parent_conn=None):
        if parent_conn:
            Logger.set_parent_conn(parent_conn)
        
        while True:
            if parent_conn.poll():
                str = parent_conn.recv()

                if isinstance(str, bytes):
                    msg = str.decode('utf-8')
    
                    if '/' in msg[0]: 
                        msg = msg[1:]        
                    else:
                        # Logger.error(f'Error with <{msg}>. command is missing')
                        return 0

                    parts = msg.split(maxsplit=2)

                    command_dict = {
                        'command': parts[0],
                        'player': parts[1] if len(parts) > 1 else None,
                        'args': parts[2] if len(parts) > 2 else None
                    }   

                    TelnetCommandManager._handle_command(command_dict, parent_conn)