import os

from tools.extractors.MapExtractor import MapExtractor
from tools.extractors.NavExtractor import NavExtractor
from utils.ConfigManager import config
from utils.Logger import Logger

WOW_DATA_FOLDER = 'Data/'
WOW_WORLD_FOLDER = 'World/'
WOW_MAPS_FOLDER = os.path.join(WOW_WORLD_FOLDER, 'Maps')


class Extractor:
    @staticmethod
    def run(adt_x=-1, adt_y=-1):
        # Validate WoW root.
        if not config.Extractor.Maps.wow_root_path:
            Logger.error('No wow root path provided, check config.yml. (World of Warcraft base directory)')
            return
        # Validate its existence.
        elif not os.path.exists(config.Extractor.Maps.wow_root_path):
            Logger.error(f'Data path "{config.Extractor.Maps.wow_root_path}" does not exist.')
            return

        # Validate /Data/.
        data_path = os.path.join(config.Extractor.Maps.wow_root_path, WOW_DATA_FOLDER)
        if not os.path.exists(data_path):
            Logger.error(f'Unable to locate {data_path}.')
            return

        if input('Extract .map files? [Y/N]').lower() == 'y':
            MapExtractor.run(data_path, WOW_MAPS_FOLDER, WOW_WORLD_FOLDER, adt_x, adt_y)

        if input('Extract .nav files? [Y/N]').lower() == 'y':
            NavExtractor.run(data_path)
