import yaml
import json

from os import path
from collections import namedtuple


class ConfigManager(object):

    def __init__(self):
        self.config = None

    def load(self):
        current_dir = path.dirname(__file__)
        main_config = '../etc/config/config.yml'

        with open(path.join(current_dir, main_config), 'r') as stream:
            data = yaml.load(stream, Loader=yaml.Loader)
            self.config = json.loads(
                json.dumps(data), object_hook=lambda d: namedtuple('Configs', d.keys())(*d.values())
            )
            return self


# Config data holder
config = ConfigManager().load().config
