import os
from dataclasses import dataclass


@dataclass
class Map:
    id: int
    directory: str
    pvp: int
    is_in_map: int
    name: str
    name_en_gb: str
    name_ko_kr: str
    name_fr_fr: str
    name_de_de: str
    name_en_cn: str
    name_zh_ch: str
    name_en_tw: str
    mask: int

    def exists(self, root_path):
        return os.path.exists(self.get_wdt_path(root_path))

    def get_wdt_path(self, root_path):
        return os.path.join(os.path.join(root_path, self.directory), self.name) + '.wdt.MPQ'

    @staticmethod
    def from_bytes(dbc_reader):
        id_ = dbc_reader.read_int()
        directory = dbc_reader.read_string()
        pvp = dbc_reader.read_int()
        is_in_map = dbc_reader.read_int()
        name_en_us = dbc_reader.read_string()
        name_en_gb = dbc_reader.read_string()
        name_ko_kr = dbc_reader.read_string()
        name_fr_fr = dbc_reader.read_string()
        name_de_de = dbc_reader.read_string()
        name_en_cn = dbc_reader.read_string()
        name_zh_ch = dbc_reader.read_string()
        name_en_tw = dbc_reader.read_string()
        mask = dbc_reader.read_int()

        return Map(id_, directory, pvp, is_in_map, name_en_us, name_en_gb, name_ko_kr, name_fr_fr, name_de_de,
                   name_en_cn, name_zh_ch, name_en_tw, mask)
