class DataHolders:
    AREA_TABLES_BY_MAP = {}
    MAPS = {}

    @staticmethod
    def add_area_table(area_table):
        if area_table.continent_id not in DataHolders.AREA_TABLES_BY_MAP:
            DataHolders.AREA_TABLES_BY_MAP[area_table.continent_id] = {}
        DataHolders.AREA_TABLES_BY_MAP[area_table.continent_id][area_table.area_number] = area_table

    @staticmethod
    def get_area_table_by_area_number(map_id, area_number):
        if map_id not in DataHolders.AREA_TABLES_BY_MAP:
            return None
        return DataHolders.AREA_TABLES_BY_MAP[map_id].get(area_number, None)

    @staticmethod
    def add_map(dbc_map):
        DataHolders.MAPS[dbc_map.id] = dbc_map

    @staticmethod
    def get_maps():
        return list(DataHolders.MAPS.values())

    @staticmethod
    def get_map_by_id(map_id):
        return DataHolders.MAPS.get(map_id, None)
