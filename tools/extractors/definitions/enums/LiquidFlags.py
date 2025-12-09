from enum import IntEnum


class LiquidFlags(IntEnum):
    NONE = 0x0
    FLAG_SHADOW = 0x1
    FLAG_IMPASS = 0x2
    FLAG_LQ_RIVER = 0x4
    FLAG_LQ_OCEAN = 0x8
    FLAG_LQ_MAGMA = 0x10
    FLAG_LQ_DEEP = 0x14

    HAS_LIQUID = FLAG_LQ_RIVER | FLAG_LQ_OCEAN | FLAG_LQ_MAGMA

    @staticmethod
    def get_liquid_flags(liquids_flags):
        flags = []
        for idx, flag in enumerate(LiquidFlags):
            if idx < 3 or idx > 6:
                continue
            if not flag & liquids_flags:
                continue
            flags.append(flag)
        return flags


class WmoGroupLiquidType(IntEnum):
    INTERIOR_WATER = 0
    EXTERIOR_WATER = 1
    MAGMA = 2
    SLIME = 3


class MOGP_Flags(IntEnum):
    NONE = 0
    HasBSP = 0x1
    HasLightmap = 0x2
    HasVertexColors = 0x4
    IsExterior = 0x8
    Unknown_0x10 = 0x10
    Unknown_0x20 = 0x20
    IsExteriorLit = 0x40
    Unreachable = 0x80
    Unknown_0x100 = 0x100
    HasLights = 0x200
    HasMPBX = 0x400
    HasDoodads = 0x800
    HasLiquids = 0x1000
    IsInterior = 0x2000
    Unknown_0x4000 = 0x4000
    Unknown_0x8000 = 0x8000
    AlwaysDraw = 0x10000
    HasTriangleStrips = 0x20000
    ShowSkybox = 0x40000
    IsOceanicWater = 0x80000
    Unknown_0x100000 = 0x100000
    IsMountAllowed = 0x200000
    Unknown_0x400000 = 0x400000
    Unknown_0x800000 = 0x800000
    HasTwoVertexShadingSets = 0x1000000
    HasTwoTextureCoordinateSets = 0x2000000
    IsAntiportal = 0x4000000
    Unknown_0x8000000 = 0x8000000
    Unknown_0x10000000 = 0x10000000
    ExteriorCull = 0x20000000
    HasThreeTextureCoordinateSets = 0x40000000
    Unknown_0x80000000 = 0x80000000

class WmoLiquidFlags(IntEnum):
    LiquidSurface = 0x1000
    IsNotWaterButOcean = 0x80000

class LiquidTypes(IntEnum):
    LIQUID_Slow_Water = 5
    LIQUID_Slow_Ocean = 6
    LIQUID_Slow_Magma = 7
    LIQUID_Slow_Slime = 8
    LIQUID_Fast_Water = 9
    LIQUID_Fast_Ocean = 10
    LIQUID_Fast_Magma = 11
    LIQUID_Fast_Slime = 12
    LIQUID_WMO_Water = 13
    LIQUID_WMO_Ocean = 14
    LIQUID_Green_Lava = 15
    LIQUID_WMO_Water_Interior = 17
    LIQUID_WMO_Magma = 19
    LIQUID_WMO_Slime = 20

    LIQUID_END_BASIC_LIQUIDS = 20
    LIQUID_FIRST_NONBASIC_LIQUID_TYPE = 21

    LIQUID_NAXX_SLIME = 21
    LIQUID_Coilfang_Raid_Water = 41
    LIQUID_Hyjal_Past_Water = 61
    LIQUID_Lake_Wintergrasp_Water = 81
    LIQUID_Basic_Procedural_Water = 100
    LIQUID_CoA_Black_Magma = 121
    LIQUID_Chamber_Magma = 141
    LIQUID_Orange_Slime = 181

    @staticmethod
    def get_liquid_type(liquid_type):
        for idx, flag in enumerate(LiquidTypes):
            if liquid_type == flag:
                return flag
        return 0
