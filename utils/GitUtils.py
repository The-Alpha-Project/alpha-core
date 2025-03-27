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
            ext = 'pyd' if os.name == 'nt' else 'so'
            os_prefix = 'win' if os.name == 'nt' else 'nix'
            pathfind_path = f'namigator/{GitUtils.PATHFIND_FILE_NAME}.{ext}'
            mapbuild_path = f'namigator/{GitUtils.MAPBUILD_FILE_NAME}.{ext}'

            # TODO: Improve this logic?
            if os.path.isfile(pathfind_path):
                Logger.info('[Namigator] Found Python bindings.')
                if not os.path.isfile(mapbuild_path):
                    Logger.warning(
                        f"[Namigator] {GitUtils.MAPBUILD_FILE_NAME}.{ext} not found; "
                        "map extraction won't be possible. Please clear the namigator folder "
                        "to automatically download all required dependencies."
                    )
                return True

            py_runtime = f"{sys.version_info[0]}.{sys.version_info[1]}"
            filename = f'namigator_{os_prefix}_{py_runtime}.zip'
            download_url = f'{GitUtils.BASE_NAMIGATOR_URL}{filename}'

            Logger.info(f'[Namigator] Attempting to download {download_url}')
            zip_data = requests.get(download_url)
            zip_data.raise_for_status()  # Ensure we catch HTTP errors.

            with zipfile.ZipFile(BytesIO(zip_data.content)) as zip_file:
                zip_file.extractall('namigator')

            Logger.info('[Namigator] Binding installed.')
            return True
        except requests.RequestException as e:
            Logger.error(f'[Namigator] Download failed: {e}')
        except zipfile.BadZipFile:
            Logger.error('[Namigator] Invalid zip file format.')
        except Exception as e:
            Logger.error(f'[Namigator] Unexpected error: {e}')

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
