from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.ConfigManager import config
import requests

from utils.Logger import Logger

master_server_uri = f"{config.MasterServer.master_server_uri}:{config.MasterServer.master_server_port}"
master_server_enabled = config.MasterServer.enabled
server_id = config.Server.Connection.Realm.local_realm_id


class MasterServerManager:

    @staticmethod
    def checkout():
        if not master_server_enabled:
            return
        try:
            requests.get(f"{master_server_uri}/checkout/{server_id}")
        except requests.exceptions.Timeout:
            Logger.warning('MasterServerManager: unable to connect to master server (request timeout)')
        except requests.exceptions.HTTPError:
            Logger.warning('MasterServerManager: unable to connect to master server (HTTP error)')
        except requests.exceptions.ConnectionError:
            Logger.warning('MasterServerManager: unable to connect to master server (connection error)')
        except requests.exceptions.RequestException as e:
            Logger.warning(f'MasterServerManager: unable to connect to master server ({e})')

    @staticmethod
    def update():
        if not master_server_enabled:
            return
        try:
            count = RealmDatabaseManager.character_get_online_count(server_id)
            requests.get(f"{master_server_uri}/update/{server_id}/{count}")
        except requests.exceptions.Timeout:
            Logger.warning('MasterServerManager: unable to connect to master server (request timeout)')
        except requests.exceptions.HTTPError:
            Logger.warning('MasterServerManager: unable to connect to master server (HTTP error)')
        except requests.exceptions.ConnectionError:
            Logger.warning('MasterServerManager: unable to connect to master server (connection error)')
        except requests.exceptions.RequestException as e:
            Logger.warning(f'MasterServerManager: unable to connect to master server ({e})')

    @staticmethod
    def query():
        if not master_server_enabled:
            return None
        data = None
        try:
            data = requests.get(f"{master_server_uri}/query").json()
        except requests.exceptions.Timeout:
            Logger.warning('MasterServerManager: unable to connect to master server (request timeout)')
        except requests.exceptions.HTTPError:
            Logger.warning('MasterServerManager: unable to connect to master server (HTTP error)')
        except requests.exceptions.ConnectionError:
            Logger.warning('MasterServerManager: unable to connect to master server (connection error)')
        except requests.exceptions.RequestException as e:
            Logger.warning(f'MasterServerManager: unable to connect to master server ({e})')

        return data