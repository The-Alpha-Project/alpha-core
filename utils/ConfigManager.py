import json
import os
import shutil
from collections import namedtuple
import yaml

from utils.PathManager import PathManager


class ConfigManager:
    EXPECTED_VERSION = 19

    def __init__(self):
        self.config = None

    # noinspection PyArgumentList
    def load(self):
        self.create_default_config_file()
        with open(PathManager.get_config_file_path(), 'r') as stream:
            data = yaml.load(stream, Loader=yaml.Loader)
            self.config = json.loads(
                json.dumps(data), object_hook=lambda d: namedtuple('Configs', d.keys())(*d.values())
            )
            return self

    def create_default_config_file(self):
        if os.path.exists(PathManager.get_config_file_path()):
            return
        if not os.path.exists(PathManager.get_default_config_path()):
            return
        shutil.copy(PathManager.get_default_config_path(), PathManager.get_config_file_path())
        print(f"Created default configuration file at {PathManager.get_default_config_path()}")

# Config data holder
config = ConfigManager().load().config
