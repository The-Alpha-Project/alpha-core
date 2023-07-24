from struct import pack
from dataclasses import dataclass
from tools.map_extractor.pydbclib.helpers.VanillaAreaHelper import VanillaAreaHelper


@dataclass
class AreaTable:
    id: int
    area_number: int
    continent_id: int
    parent_area_number: int
    area_bit: int
    flags: int
    sound_provider: int
    sound_provider_water: int
    midi_ambience: int
    midi_ambience_water: int
    zone_music: int
    intro_sound: int
    intro_priority: int
    name: str

    # Vanilla Fields.
    explore_bit: int
    area_flags: int
    area_level: int
    has_exploration: bool

    def write_to_file(self, file_writer):
        data = pack('<2i2BH', self.id, self.area_number, self.area_flags, self.area_level, self.explore_bit)
        file_writer.write(data)

    @staticmethod
    def from_bytes(dbc_reader):
        _id: int = dbc_reader.read_int()
        area_number: int = dbc_reader.read_int()
        continent_id: int = dbc_reader.read_int()
        parent_area_number: int = dbc_reader.read_int()
        area_bit: int = dbc_reader.read_int()
        flags: int = dbc_reader.read_int()
        sound_provider: int = dbc_reader.read_int()
        sound_provider_water: int = dbc_reader.read_int()
        midi_ambience: int = dbc_reader.read_int()
        midi_ambience_water: int = dbc_reader.read_int()
        zone_music: int = dbc_reader.read_int()
        intro_sound: int = dbc_reader.read_int()
        intro_priority: int = dbc_reader.read_int()
        name: str = dbc_reader.read_string()

        # Skip locale names and name mask.
        dbc_reader.move_forward(32)

        # Vanilla data that allows exploration feature.
        explore_bit: int = 0
        area_flags: int = 0
        area_level: int = 0

        vanilla_area = VanillaAreaHelper.get_vanilla_area_data(_id)
        has_exploration = area_number < 4000000000 and vanilla_area
        if vanilla_area:
            explore_bit = vanilla_area[0]
            area_flags = vanilla_area[1]
            area_level = vanilla_area[2]

        return AreaTable(_id, area_number, continent_id, parent_area_number, area_bit, flags, sound_provider,
                         sound_provider_water, midi_ambience, midi_ambience_water, zone_music, intro_sound,
                         intro_priority, name, explore_bit, area_flags, area_level, has_exploration)
