from modules import TelnetCommandHandler
import threading
from utils.ConfigManager import config

class WorldManagerModules:
    def __init__(self):
        pass 
    
    def start(self, parent_conn):
        self.startTelnetCommandHandler(parent_conn)
        
        # Add more module starts here as needed
    
    def startTelnetCommandHandler(self, parent_conn):
        if config.Telnet.Defaults.enabled and not config.Server.Settings.console_mode:
            WorldManagerExtended_thread = threading.Thread(target=TelnetCommandHandler.starts,args=(parent_conn,))
            WorldManagerExtended_thread.daemon = True
            WorldManagerExtended_thread.start()