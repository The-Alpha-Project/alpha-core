import yaml
import json

from os import path
from collections import namedtuple

from utils.PathManager import PathManager


class ConfigManager:

    def __init__(self):
        self.config = None

    # noinspection PyArgumentList
    def load(self):
        with open(PathManager.get_config_file_path(), 'r') as stream:
            data = yaml.load(stream, Loader=yaml.Loader)
            self.config = json.loads(
                json.dumps(data), object_hook=lambda d: namedtuple('Configs', d.keys())(*d.values())
            )
            return self


# Config data holder
config = ConfigManager().load().config
