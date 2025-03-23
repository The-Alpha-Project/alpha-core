import os
import sys
from io import BytesIO

import requests
import zipfile
from os import path

from utils.Logger import Logger
from utils.PathManager import PathManager

class GitUtils:
    HEAD_FILE_NAME = 'HEAD'
    CONFIG_FILE_NAME = 'config'
    MAPBUILD_FILE_NAME = 'mapbuild'
    PATHFIND_FILE_NAME = 'pathfind'
    BASE_NAMIGATOR_URL = 'https://github.com/The-Alpha-Project/alpha-core/releases/download/Namigator/'

    @staticmethod
    def check_download_namigator_bindings():
        try:
            if os.name == 'nt':
                ext = 'pyd'
                os_prefix = 'win'
            else:
                ext = 'so'
                os_prefix = 'nix'

            # TODO: lib naming which includes python version in order to check if we need to update/downgrade.
            if (os.path.isfile('namigator/' + GitUtils.MAPBUILD_FILE_NAME + '.' + ext)
                    and os.path.isfile('namigator/' + GitUtils.PATHFIND_FILE_NAME + '.' + ext)):
                Logger.info('[Namigator] Found python bindings.')
                return True

            py_runtime = str(sys.version_info[0]) + '.' + str(sys.version_info[1])
            filename = 'namigator_' + os_prefix + '_' + py_runtime + '.zip'
            download_url = GitUtils.BASE_NAMIGATOR_URL + filename

            zip_data = requests.get(download_url)
            Logger.info('[Namigator] Attempting to download ' + download_url)
            with zipfile.ZipFile(BytesIO(zip_data.content)) as zip_file:
                zip_file.extractall('namigator')
            Logger.info('[Namigator] Binding installed.')

            return True
        except:
            return False

    @staticmethod
    def get_head_path():
        try:
            with open(os.path.join(PathManager.get_git_path(), GitUtils.HEAD_FILE_NAME), 'r') as git_head_file:
                # Contains e.g. ref: ref/heads/master if on "master".
                git_head_data = str(git_head_file.read())
                return git_head_data.split(' ')[1].strip()
        except (FileNotFoundError, KeyError):
            return None

    @staticmethod
    def get_current_branch():
        head_path = GitUtils.get_head_path()
        if head_path:
            try:
                return head_path.split('/')[-1]
            except KeyError:
                return None
        return None

    @staticmethod
    def get_current_commit_hash():
        head_path = GitUtils.get_head_path()
        if not head_path:
            return None

        try:
            refs_path = path.join(PathManager.get_git_path(), head_path)
            # Get the commit hash.
            with open(refs_path, 'r') as git_head_ref_file:
                commit_id = git_head_ref_file.read()
                return commit_id.strip()
        except FileNotFoundError:
            return None
