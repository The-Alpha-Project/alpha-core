import os


from utils.Logger import Logger
from utils.PathManager import PathManager

from tools.extractors.definitions.Wdt import Wdt
from tools.extractors.pydbclib.structs.Map import Map
from tools.extractors.pydbclib.DbcReader import DbcReader
from tools.extractors.helpers.DataHolders import DataHolders
from tools.extractors.pympqlib.MpqArchive import MpqArchive
from tools.extractors.pydbclib.structs.AreaTable import AreaTable


REQUIRED_DBC = 'dbc.MPQ'


class MapExtractor:

    @staticmethod
    def run(data_path, wow_maps_folder):
        # Validate /etc/maps.
        map_files_path = PathManager.get_maps_path()
        if not os.path.exists(map_files_path):
            Logger.error(f'Unable to locate {map_files_path}.')
            return

        # Validate dbc.MPQ.
        dbc_path = os.path.join(data_path, REQUIRED_DBC)
        if not os.path.exists(dbc_path):
            Logger.error(f'Unable to locate {dbc_path}.')
            return

        maps_path = os.path.join(data_path, wow_maps_folder)
        if not os.path.exists(dbc_path):
            Logger.error(f'Unable to locate {wow_maps_folder}.')
            return

        # Flush existent files.
        filelist = [f for f in os.listdir(map_files_path) if f.endswith(".map")]
        if filelist:
            Logger.warning(f'Existent {len(filelist)} .map files will be deleted, continue? Y/N [Y]')
            if input().lower() in ['y', '']:
                [os.remove(os.path.join(map_files_path, file)) for file in filelist]
            else:
                return

        # Extract available maps and area tables from dbc.
        with MpqArchive(dbc_path) as archive:
            map_dbc = archive.find_file('Map.dbc')
            area_table_dbc = archive.find_file('AreaTable.dbc')
            if not map_dbc:
                Logger.error(f'Unable to locate Map.dbc')
            if not area_table_dbc:
                Logger.error(f'Unable to locate AreaTable.dbc')
            if not map_dbc or not area_table_dbc:
                exit()

            with DbcReader(buffer=archive.read_file_bytes(map_dbc)) as dbc_reader:
                for dbc_map in dbc_reader.read_records_by_type(Map):
                    DataHolders.add_map(dbc_map)

            with DbcReader(buffer=archive.read_file_bytes(area_table_dbc)) as dbc_reader:
                for area_table in dbc_reader.read_records_by_type(AreaTable):
                    DataHolders.add_area_table(area_table)

        # Validate we have maps.
        if not DataHolders.MAPS:
            Logger.error(f'Unable to read maps from {dbc_path}.')
            return

        if not DataHolders.AREA_TABLES_BY_MAP:
            Logger.error(f'Unable to read area tables from {dbc_path}.')
            return

        for dbc_map in DataHolders.get_maps():
            # Interested in ADT based maps, not WMO based.
            if not dbc_map.is_in_map:
                continue
            # Check if Map.dbc data points to a valid wdt file.
            if not dbc_map.exists(root_path=maps_path):
                Logger.warning(f'Map [{dbc_map.name}] does not exist as defined in Map.dbc, skipping.')
                continue
            # Process wdt.
            with MpqArchive(dbc_map.get_wdt_path(root_path=maps_path)) as wdt_reader:
                with Wdt(dbc_map, wdt_reader) as wdt:
                    wdt.process()

        # Finished.
        filelist = [f for f in os.listdir(map_files_path) if f.endswith(".map")]
        if filelist:
            Logger.success(f'Generated {len(filelist)} .map files.')
        else:
            Logger.error('Unable to extract map files.')
