import os.path
import traceback
import multiprocessing
from time import sleep

from utils.GitUtils import GitUtils
from utils.Logger import Logger
from utils.PathManager import PathManager

class NavExtractor:

    maps_navs = {
        'DeadminesInstance' : 36,
        'GnomeragonInstance' : 1,
        'Monastery' : 1,
        'RazorfenDowns' : 1,
        'RazorfenKraulInstance' : 6,
        'Blackfathom' : 1,
        'StormwindJail' : 1,
        'StormwindPrison' : 1,
        'SunkenTemple' : 1,
        'Uldaman' : 1,
        'WailingCaverns' : 1,
        'Kalidar' : 56,
        'Shadowfang' : 25,
        'Kalimdor' : 951,
        'Azeroth' : 685
    }

    @staticmethod
    def run(data_path):
        if not GitUtils.check_download_namigator_bindings():
            Logger.error(f'Unable to locate/download namigator bindings.')
            return

        try:
            from namigator import mapbuild
        except:
            Logger.warning(traceback.format_exc())
            return

        # Internal namigator 'Nav' folder.
        nav_path = os.path.join(PathManager.get_navs_path(), 'Nav')
        if not os.path.exists(nav_path):
            os.mkdir(nav_path)

        try:
            threads = 1
            Logger.info('[NavExtractor] Building bhv files...')
            NavExtractor._extract_bhv(data_path, mapbuild)

            Logger.info(f'[NavExtractor] Building navs, using {threads} threads.')
            for map_name in NavExtractor.maps_navs.keys():
                map_path = os.path.join(nav_path, map_name)
                if not os.path.exists(map_path):
                    os.mkdir(map_path)

                # Extractor process.
                process = multiprocessing.Process(target=NavExtractor._extract_map,
                                                  args=(data_path, map_name, threads, mapbuild))
                process.start()

                # Wait for process.
                NavExtractor._show_progress(process, map_name)
        except:
            Logger.warning(traceback.format_exc())

    @staticmethod
    def _show_progress(process, map_name):
        total = NavExtractor.maps_navs[map_name]
        progress = 0
        while process.is_alive():
            progress = NavExtractor._get_progress(map_name)
            if progress:
                Logger.progress(f'[NavExtractor] Building nav files for {map_name} ...', progress, total)
            sleep(1)

        # Final progress.
        if progress and progress != total:
            progress = NavExtractor._get_progress(map_name)
            Logger.progress(f'[NavExtractor] Building nav files for {map_name} ...', progress, total)

    @staticmethod
    def _get_progress(map_name):
        return len(os.listdir(os.path.join(PathManager.get_navs_path(), f'Nav/{map_name}/')))

    @staticmethod
    def _extract_bhv(data_path, mapbuild):
        try:
            if mapbuild.bvh_files_exist(PathManager.get_navs_path()):
                Logger.info(f'[NavExtractor] Skipping bhv files, already found.')
                return 0
            count = mapbuild.build_bvh(data_path, PathManager.get_navs_path(), 1)
            Logger.info(f'[NavExtractor] Successfully extracted {count} bhv files.')
            return count
        except:
            Logger.warning(traceback.format_exc())

    @staticmethod
    def _extract_map(data_path, map_name, threads, mapbuild):
        try:
            if mapbuild.map_files_exist(PathManager.get_navs_path(), map_name):
                Logger.info(f'[NavExtractor] Skipping map {map_name}, already found.')
                return
            mapbuild.build_map(data_path[:-1], PathManager.get_navs_path(), map_name, threads, '')
        except:
            Logger.warning(traceback.format_exc())
