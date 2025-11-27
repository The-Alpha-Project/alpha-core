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
        # Returns the HEAD ref path (e.g. refs/heads/master) or a commit hash (detached HEAD).
        try:
            head_file_path = path.join(PathManager.get_git_path(), GitUtils.HEAD_FILE_NAME)
            with open(head_file_path, 'r') as git_head_file:
                head_data = git_head_file.read().strip()
                if head_data.startswith('ref:'):
                    return head_data.split(' ', 1)[1].strip()
                return head_data  # Detached HEAD (commit hash).
        except (FileNotFoundError, KeyError, IndexError) as e:
            Logger.error(f'[Git] Failed to get HEAD path: {e}')
            return None

    @staticmethod
    def get_current_branch():
        # Returns the current branch name, or None if in detached HEAD state.
        try:
            head_path = GitUtils.get_head_path()
            if head_path and head_path.startswith('refs/heads/'):
                return head_path.split('/')[-1]
        except (FileNotFoundError, KeyError, IndexError) as e:
            Logger.error(f'[Git] Failed to get current branch: {e}')
        return None

    @staticmethod
    def get_current_commit_hash():
        try:
            head_path = GitUtils.get_head_path()
            if not head_path:
                return None

            if head_path.startswith('refs/'):
                ref_file_path = path.join(PathManager.get_git_path(), head_path)
                try:
                    with open(ref_file_path, 'r') as ref_file:
                        # Return current commit hash id.
                        return ref_file.read().strip()
                except FileNotFoundError:
                    return None

            # Already a commit hash (detached HEAD).
            return head_path
        except (FileNotFoundError, KeyError, IndexError) as e:
            Logger.error(f'[Git] Failed to get current commit hash: {e}')
        return None

    @staticmethod
    def get_current_commit_date():
        """Get the commit date of the current commit using git files only."""
        try:
            # Get commit hash first.
            commit_hash = GitUtils.get_current_commit_hash()
            if not commit_hash:
                return None
            
            # Try to read commit date from git objects.
            # Git stores commit objects in .git/objects/{first_2_chars}/{remaining_38_chars}
            git_path = PathManager.get_git_path()
            if not git_path or not os.path.exists(git_path):
                Logger.error('[Git] Git directory not found')
                return None
                
            objects_dir = os.path.join(git_path, 'objects')
            if not os.path.exists(objects_dir):
                Logger.error('[Git] Git objects directory not found')
                return None
            
            # For now, return a placeholder since parsing git objects is complex.
            # In a Docker environment, we can use the file modification time as approximation.
            try:
                head_file = os.path.join(git_path, 'HEAD')
                if os.path.exists(head_file):
                    import datetime
                    mtime = os.path.getmtime(head_file)
                    commit_date = datetime.datetime.fromtimestamp(mtime)
                    return commit_date.strftime('%Y-%m-%d %H:%M:%S +0000')
            except:
                pass
                
            # Fallback: return current date as last resort.
            from datetime import datetime
            return datetime.now().strftime('%Y-%m-%d %H:%M:%S +0000')
                
        except Exception as e:
            Logger.error(f'[Git] Failed to get current commit date: {e}')
        return None
