import os
from os import path


class PathManager:
    ROOT_PATH = ''

    # Config.
    CONFIG_RELATIVE_PATH = 'etc/config/'
    CONFIG_FILE_NAME = 'config.yml'
    DEFAULT_CONFIG_FILE_NAME = 'config.yml.dist'

    # Maps.
    MAPS_RELATIVE_PATH = 'etc/maps/'

    # Navs.
    NAVS_RELATIVE_PATH = 'etc/navs/'

    # Git.
    GIT_RELATIVE_PATH = '.git/'

    # File path cache.
    FILE_PATHS = dict()

    # Mdx.
    MDX_RELATIVE_PATH = 'etc/mdx/'

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
    def get_default_config_path():
        return  path.join(PathManager.ROOT_PATH, PathManager.CONFIG_RELATIVE_PATH, PathManager.DEFAULT_CONFIG_FILE_NAME)

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
    def get_mdx_path():
        return path.join(PathManager.ROOT_PATH, PathManager.MDX_RELATIVE_PATH)

    @staticmethod
    def get_git_path():
        return path.join(PathManager.ROOT_PATH, PathManager.GIT_RELATIVE_PATH)

    @staticmethod
    def find_mpq_path(directory, file_name):
        file_name = file_name.lower()

        # Fill file paths cache.
        if not PathManager.FILE_PATHS:
            PathManager._fill_file_paths(directory, PathManager.FILE_PATHS)

        if file_name in PathManager.FILE_PATHS:
            return PathManager.FILE_PATHS[file_name]

        return None

    @staticmethod
    def _fill_file_paths(directory, cache):
        for base, _, files in os.walk(directory):
            for f in files:
                cache[path.basename(f).lower().replace('.mpq', '')] = path.join(base, f)
