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
    # Patches.
    PATCHES_RELATIVE_PATH = 'etc/patches/'
    PATCHES_RSYNC_RELATIVE_PATH = 'etc/patches/rsync_basis/'

    # Git.
    GIT_RELATIVE_PATH = '.git/'

    # MDX file path cache.
    MDX_FILE_PATHS = dict()

    # WMO file path cache.
    WMO_FILE_PATHS = dict()

    # Mdx.
    MDX_RELATIVE_PATH = 'etc/mdx/'

    # Wmo.
    WMO_RELATIVE_PATH = 'etc/wmo_liquids/'
    WMO_GEOMETRY_RELATIVE_PATH = 'etc/wmo_geometry/'

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
    def get_patches_path():
        return path.join(PathManager.ROOT_PATH, PathManager.PATCHES_RELATIVE_PATH)

    @staticmethod
    def get_patches_rsync_basis_path():
        return path.join(PathManager.ROOT_PATH, PathManager.PATCHES_RSYNC_RELATIVE_PATH)

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
    def get_wmo_liquids_path():
        return path.join(PathManager.ROOT_PATH, PathManager.WMO_RELATIVE_PATH)

    @staticmethod
    def get_wmo_geometry_path():
        return path.join(PathManager.ROOT_PATH, PathManager.WMO_GEOMETRY_RELATIVE_PATH)

    @staticmethod
    def get_git_path():
        return path.join(PathManager.ROOT_PATH, PathManager.GIT_RELATIVE_PATH)

    @staticmethod
    def find_mpq_path(directory, file_name, is_wmo=False):
        file_name = file_name.lower()
        cache = PathManager.MDX_FILE_PATHS if not is_wmo else PathManager.WMO_FILE_PATHS

        # Fill file paths cache.
        if not cache:
            PathManager._fill_file_paths(directory, cache)

        if file_name in cache:
            return cache[file_name]

        return None

    @staticmethod
    def _fill_file_paths(directory, cache):
        for base, _, files in os.walk(directory):
            for f in files:
                cache[path.basename(f).lower().replace('.mpq', '')] = path.join(base, f)
