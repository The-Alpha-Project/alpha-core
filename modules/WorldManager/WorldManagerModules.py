from modules import TelnetCommandHandler
import threading
from utils.ConfigManager import config

class WorldManagerModules:
    def __init__(self):
        pass  # Add any initialization code here
    
    def start(self, parent_conn):
        # Start Telnet command handler
        self.start_telnet_command_handler(parent_conn)
        
        # Add more module starts here as needed
    
    def start_telnet_command_handler(self, parent_conn):
        # CommandManager used by Telnet
        if config.Telnet.Defaults.enabled and not config.Server.Settings.console_mode:
            WorldManagerExtended_thread = threading.Thread(target=TelnetCommandHandler.starts,args=(parent_conn,))
            WorldManagerExtended_thread.daemon = True
            WorldManagerExtended_thread.start()