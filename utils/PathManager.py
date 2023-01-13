from os import path

from utils.ConfigManager import config


class PathManager:
    ROOT_PATH = ''

    # Config.
    CONFIG_RELATIVE_PATH = 'etc/config/'
    CONFIG_FILE_NAME = 'config.yml'

    # Maps.
    MAPS_RELATIVE_PATH = 'etc/maps/'

    # Navs
    NAVS_RELATIVE_PATH = 'etc/navs/'

    # Git.
    GIT_RELATIVE_PATH = '.git/'

    # Chat logging.
    CHAT_LOG_PATH = config.Server.Logging.log_chat_path
    CHAT_LOG_FILE_NAME = 'chat.log'

    @staticmethod
    def set_root_path(root_path):
        PathManager.ROOT_PATH = root_path

    @staticmethod
    def get_root_path():
        return PathManager.ROOT_PATH

    @staticmethod
    def get_config_file_path():
        return path.join(PathManager.ROOT_PATH, PathManager.CONFIG_RELATIVE_PATH, PathManager.CONFIG_FILE_NAME)

    @staticmethod
    def get_navs_path():
        return path.join(PathManager.ROOT_PATH, PathManager.NAVS_RELATIVE_PATH)

    @staticmethod
    def get_nav_map_path(map_name):
        return path.join(path.join(PathManager.get_navs_path(), 'Nav'), map_name)

    @staticmethod
    def get_maps_path():
        return path.join(PathManager.ROOT_PATH, PathManager.MAPS_RELATIVE_PATH)

    @staticmethod
    def get_map_file_path(map_file):
        return path.join(PathManager.get_maps_path(), map_file)

    @staticmethod
    def get_git_path():
        return path.join(PathManager.ROOT_PATH, PathManager.GIT_RELATIVE_PATH)

    @staticmethod
    def get_chat_log_path():
        return path.join(PathManager.CHAT_LOG_PATH, PathManager.CHAT_LOG_FILE_NAME)
