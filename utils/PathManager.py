from os import path


class PathManager:
    ROOT_PATH = ''

    # Config
    CONFIG_RELATIVE_PATH = 'etc/config/'
    CONFIG_FILE_NAME = 'config.yml'

    # Maps
    MAPS_RELATIVE_PATH = 'etc/maps/'

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
    def get_maps_path():
        return path.join(PathManager.ROOT_PATH, PathManager.MAPS_RELATIVE_PATH)

    @staticmethod
    def get_map_file_path(map_file):
        return path.join(PathManager.get_maps_path(), map_file)
