from tools.extractors.definitions.chunks.MLIQ import MLIQ
from tools.extractors.definitions.enums.LiquidFlags import MOGP_Flags
from tools.extractors.definitions.objects.CAaBox import CAaBox
from tools.extractors.definitions.reader.StreamReader import StreamReader


class WmoGroupFile:
    def __init__(self):
        self.flags = 0
        self.bounding = None
        self.group_liquid = 0
        self.mliqs = []

    def has_liquids(self):
        return bool(self.mliqs)

    @staticmethod
    def from_reader(reader: StreamReader):
        wmo_group_file = WmoGroupFile()

        reader.read_int32()  # group_name_start
        reader.read_int32()  # descriptive_group_name
        flags = reader.read_uint32()
        wmo_group_file.bounding = CAaBox.from_reader(reader)
        reader.read_uint32()  # portal_start
        reader.read_uint32()  # portal_count
        reader.read_bytes(4)  # fogs_id
        wmo_group_file.group_liquid = reader.read_int32()

        # IntBatch.
        for i in range(0, 4):
            reader.read_uint16()  # Vert start.
            reader.read_uint16()  # Vert count.
            reader.read_uint16()  # Batch start.
            reader.read_uint16()  # Batch count.

        # ExtBatch.
        for i in range(0, 4):
            reader.read_uint16()  # Vert start.
            reader.read_uint16()  # Vert count.
            reader.read_uint16()  # Batch start.
            reader.read_uint16()  # Batch count.

        wmo_group_id = reader.read_uint32()
        reader.move_forward(8)  # Padding.

        error, token, size = reader.read_chunk_information('MOPY')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MOVT')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MONR')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MOTV')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MOLV')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MOIN')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MOBA')
        if error:
            raise ValueError(f'{error}')
        reader.move_forward(size)

        # Optional Chunks.
        if MOGP_Flags.HasLights & flags:
            error, token, size = reader.read_chunk_information('MOLR')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

        if MOGP_Flags.HasDoodads & flags:
            error, token, size = reader.read_chunk_information('MODR')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

        if MOGP_Flags.HasBSP & flags:
            error, token, size = reader.read_chunk_information('MOBN')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

            error, token, size = reader.read_chunk_information('MOBR')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

        if MOGP_Flags.HasMPBX & flags:
            error, token, size = reader.read_chunk_information('MPBV')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

            error, token, size = reader.read_chunk_information('MPBP')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

            error, token, size = reader.read_chunk_information('MPBI')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

            error, token, size = reader.read_chunk_information('MPBG')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

        if MOGP_Flags.HasVertexColors & flags:
            error, token, size = reader.read_chunk_information('MOCV')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

        if MOGP_Flags.HasLightmap & flags:
            error, token, size = reader.read_chunk_information('MOLM')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

            error, token, size = reader.read_chunk_information('MOLD')
            if error:
                raise ValueError(f'{error}')
            reader.move_forward(size)

        # TODO.
        # WMOs can have liquid in them even if MLIQ is not present!
        # If MOGP.groupLiquid is set but no MLIQ is present or
        # xtiles = 0 or ytiles = 0 then entire group is filled with liquid.
        # In this case liquid height is equal to MOGP.boundingBox.max.z.
        # This seems to only happen if MOHD.flags.use_liquid_type_dbc_id is set.
        #
        # In older WMOs without the MOHD root flag flag_use_liquid_type_dbc_id set : if MOGP.groupLiquid == 15 (green lava),
        # the tile flags legacyLiquidType are used to set the liquid type.
        if MOGP_Flags.HasLiquids & flags:
            error, token, size = reader.read_chunk_information('MLIQ')
            if error:
                raise ValueError(f'{error}')
            final_position = reader.get_position() + size
            while reader.get_position() < final_position:
                wmo_group_file.mliqs.append(MLIQ.from_reader(reader, wmo_group_file.bounding.min))
        #elif group_liquid:
        #    Logger.warning(f'TODO: Wmo group liquid with no MLIQ, height hint: {bounding.max.Z}')

        return wmo_group_file

