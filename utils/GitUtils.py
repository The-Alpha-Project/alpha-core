from os import path

from utils.PathManager import PathManager


class GitUtils:
    HEAD_FILE_NAME = 'HEAD'

    @staticmethod
    def get_head_path():
        try:
            with open(path.join(PathManager.get_git_path(), GitUtils.HEAD_FILE_NAME), 'r') as git_head_file:
                # Contains e.g. ref: ref/heads/master if on "master".
                git_head_data = str(git_head_file.read())
                return git_head_data.split(' ')[1].strip()
        except FileNotFoundError:
            return None

    @staticmethod
    def get_current_branch():
        head_path = GitUtils.get_head_path()
        if head_path:
            return head_path.split('/')[-1]
        return None

    @staticmethod
    def get_current_commit_hash():
        head_path = GitUtils.get_head_path()
        if not head_path:
            return None

        try:
            refs_path = path.join(PathManager.get_git_path(), GitUtils.get_head_path())
            # Get the commit hash.
            with open(refs_path, 'r') as git_head_ref_file:
                commit_id = git_head_ref_file.read()
                return commit_id.strip()
        except FileNotFoundError:
            return None
