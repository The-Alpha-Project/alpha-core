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
REQUIRED_MODELS_DBC = 'model.MPQ'
MAP_SKIP = ['Scott Test', 'CashTest', 'Under Mine']


class MapExtractor:

    @staticmethod
    def run(data_path, wow_maps_folder, wow_world_folder, adt_x, adt_y):
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

        # Validate model.MPQ.
        model_path = os.path.join(data_path, REQUIRED_MODELS_DBC)
        if not os.path.exists(model_path):
            Logger.error(f'Unable to locate {model_path}.')
            return

        # Validate WORLD path.
        world_path = os.path.join(data_path, wow_world_folder)
        if not os.path.exists(world_path):
            Logger.error(f'Unable to locate {wow_world_folder}.')
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

        mdx_path = PathManager.get_mdx_path()
        if not os.path.exists(mdx_path):
            os.makedirs(mdx_path)

        wmo_liquids_path = PathManager.get_wmo_liquids_path()
        if not os.path.exists(wmo_liquids_path):
            os.makedirs(wmo_liquids_path)

        wmo_geometry_path = PathManager.get_wmo_geometry_path()
        if not os.path.exists(wmo_geometry_path):
            os.makedirs(wmo_geometry_path)

        MapExtractor._validate_wmo_cache_versions(wmo_liquids_path, wmo_geometry_path)

        # Extract models data.
        with MpqArchive(model_path) as archive:
            mdx_files = [mpq_entry for mpq_entry in archive.mpq_entries if 'mdx' in mpq_entry.filename]
            current = 0
            total = len(mdx_files)
            for mpq_entry in mdx_files:
                final_path = os.path.join(mdx_path, mpq_entry.file_path)
                # Create intermediary directories if needed.
                os.makedirs(os.path.dirname(final_path), exist_ok=True)
                current += 1
                Logger.progress(f'{REQUIRED_MODELS_DBC.capitalize()} extracting mdx models ...', current, total, divisions=1)
                # Extract file.
                with open(os.path.join(mdx_path, mpq_entry.file_path), 'wb') as f:
                    f.write(archive.read_file_bytes(mpq_entry))

        for dbc_map in [dbc_map for dbc_map in DataHolders.get_maps() if dbc_map.name not in MAP_SKIP]:
            # Check if Map.dbc data points to a valid wdt file.
            if not dbc_map.exists(root_path=maps_path):
                Logger.warning(f'Map [{dbc_map.name}] does not exist as defined in Map.dbc, skipping.')
                continue

            # Process wdt.
            with MpqArchive(dbc_map.get_wdt_path(root_path=maps_path)) as wdt_reader:
                with Wdt(dbc_map, wdt_reader, data_path, mdx_path, adt_x, adt_y) as wdt:
                    wdt.process()

        # Finished.
        filelist = [f for f in os.listdir(map_files_path) if f.endswith(".map")]
        if filelist:
            Logger.success(f'Generated {len(filelist)} .map files.')
        else:
            Logger.error('Unable to extract map files.')

    @staticmethod
    def _validate_wmo_cache_versions(wmo_liquids_path, wmo_geometry_path):
        invalid_reason = MapExtractor._find_invalid_cache_file(
            wmo_liquids_path,
            '.liq',
            Wdt._has_expected_wliq,
            'WLIQ',
        )
        if not invalid_reason:
            invalid_reason = MapExtractor._find_invalid_cache_file(
                wmo_geometry_path,
                '.wgeo',
                Wdt._has_expected_wgeo,
                'WGEO',
            )

        if not invalid_reason:
            return

        Logger.warning(f'Invalid WMO cache version detected ({invalid_reason}). Clearing cache files.')
        removed_liq = MapExtractor._purge_cache_dir(wmo_liquids_path, '.liq')
        removed_geo = MapExtractor._purge_cache_dir(wmo_geometry_path, '.wgeo')
        Logger.warning(
            f'Removed {removed_liq} .liq files and {removed_geo} .wgeo files. Cache will be re-extracted.'
        )

    @staticmethod
    def _find_invalid_cache_file(cache_path, extension, validator, label):
        if not os.path.exists(cache_path):
            return None
        for filename in os.listdir(cache_path):
            if not filename.endswith(extension):
                continue
            file_path = os.path.join(cache_path, filename)
            try:
                if not validator(file_path):
                    return f'{label} cache file "{file_path}"'
            except ValueError as exc:
                return f'{label} cache file "{file_path}": {exc}'
        return None

    @staticmethod
    def _purge_cache_dir(cache_path, extension):
        if not os.path.exists(cache_path):
            return 0
        removed = 0
        for filename in os.listdir(cache_path):
            if not filename.endswith(extension):
                continue
            os.remove(os.path.join(cache_path, filename))
            removed += 1
        return removed
