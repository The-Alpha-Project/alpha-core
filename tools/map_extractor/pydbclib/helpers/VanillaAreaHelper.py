class VanillaAreaHelper:
    # 1.12 required date for exploration in alpha.

    @staticmethod
    def get_vanilla_area_data(area_id):
        return VanillaAreaHelper.AREA_TABLE_DATA.get(area_id, None)

    # ID : (Explore bit, area_flags, area_level)
    AREA_TABLE_DATA = {
        1: (0, 65, 0),       # Dun Morogh
        2: (1, 64, 0),       # Longshore
        3: (2, 64, 0),       # Badlands
        4: (3, 64, 0),       # Blasted Lands
        7: (4, 64, 0),       # Blackwater Cove
        8: (5, 64, 0),       # Swamp of Sorrows
        9: (6, 64, 0),       # Northshire Valley
        10: (7, 64, 0),      # Duskwood
        11: (8, 64, 0),      # Wetlands
        12: (9, 64, 0),      # Elwynn Forest
        13: (10, 64, 0),     # The World Tree
        14: (11, 64, 0),     # Durotar
        15: (12, 64, 0),     # Dustwallow Marsh
        16: (13, 64, 0),     # Aszhara
        17: (14, 64, 0),     # The Barrens
        18: (15, 64, 7),     # Crystal Lake
        19: (16, 64, 40),    # Zul Gurub
        20: (17, 64, 14),    # Moonbrook
        21: (18, 64, 0),     # Kul Tiras
        22: (19, 64, 0),     # Programmer Isle
        23: (20, 64, 0),     # Northshire River
        24: (21, 64, 0),     # Northshire Abbey
        25: (22, 64, 0),     # Blackrock Mountain
        26: (23, 64, 0),     # Lighthouse
        28: (24, 64, 0),     # Western Plaguelands
        30: (25, 64, 0),     # Nine
        32: (26, 64, 0),     # The Cemetary
        33: (27, 64, 0),     # Stranglethorn Vale
        34: (28, 64, 0),     # Echo Ridge Mine
        35: (29, 64, 42),    # Booty Bay
        36: (30, 64, 0),     # Alterac Mountains
        37: (31, 64, 36),    # Lake Nazferiti
        38: (32, 64, 0),     # Loch Modan
        40: (33, 64, 0),     # Westfall
        41: (34, 64, 0),     # Deadwind Pass
        42: (35, 64, 25),    # Darkshire
        43: (36, 64, 42),    # Wild Shore
        44: (37, 64, 0),     # Redridge Mountains
        45: (38, 64, 0),     # Arathi Highlands
        46: (39, 64, 0),     # Burning Steppes
        47: (40, 64, 0),     # The Hinterlands
        49: (41, 64, 0),     # Dead Man's Hole
        51: (42, 64, 0),     # Searing Gorge
        53: (43, 64, 0),     # Thieves Camp
        54: (44, 64, 8),     # Jasperlode Mine
        55: (45, 64, 0),     # Valley of Heroes
        56: (46, 64, 0),     # Hero's Vigil
        57: (47, 64, 5),     # Fargodeep Mine
        59: (48, 64, 0),     # Northshire Vineyards
        60: (49, 64, 8),     # Forest's Edge
        61: (50, 64, 0),     # Thunder Falls
        62: (51, 64, 8),     # Brackwell Pumpkin Patch
        63: (52, 64, 6),     # The Stonefield Farm
        64: (53, 64, 6),     # The Maclure Vineyards
        65: (54, 68, 0),     # ***On Map Dungeon***
        66: (55, 68, 0),     # ***On Map Dungeon***
        67: (56, 68, 0),     # ***On Map Dungeon***
        68: (57, 64, 16),    # Lake Everstill
        69: (58, 64, 15),    # Lakeshire
        70: (59, 64, 24),    # Stonewatch
        71: (60, 64, 20),    # Stonewatch Falls
        72: (61, 64, 63),    # Dark Portal
        73: (62, 64, 50),    # Demonic Stronghold
        74: (63, 64, 43),    # Pool of Tears
        75: (64, 64, 37),    # Stonard
        76: (65, 64, 37),    # Fallow Sanctuary
        77: (66, 64, 0),     # Anvilmar
        80: (67, 64, 10),    # Stormwind City
        81: (68, 64, 0),     # Jeff NE Quadrant
        82: (69, 64, 0),     # Jeff NW Quadrant
        83: (70, 64, 0),     # Jeff SE Quadrant
        84: (71, 64, 0),     # Jeff SW Quadrant
        85: (72, 64, 0),     # Tirisfal Glades
        86: (73, 64, 8),     # Stone Cairn Lake
        87: (74, 64, 5),     # Goldshire
        88: (75, 64, 6),     # Eastvale Logging Camp
        89: (76, 64, 0),     # Mirror Lake Orchard
        91: (77, 64, 8),     # Tower of Azora
        92: (78, 64, 0),     # Mirror Lake
        93: (79, 64, 28),    # Vul'Gol Ogre Mound
        94: (80, 64, 24),    # Raven Hill
        95: (81, 64, 20),    # Redridge Canyons
        96: (82, 64, 25),    # Tower of Ilgalar
        97: (83, 64, 19),    # Alther's Mill
        98: (84, 64, 17),    # Rethban Caverns
        99: (85, 64, 30),    # Rebel Camp
        100: (86, 64, 31),   # Nesingwary's Expedition
        101: (87, 64, 32),   # Kurzen's Compound
        102: (88, 64, 41),   # Ruins of Zul'Kunda
        103: (89, 64, 40),   # Ruins of Zul'Mamwe
        104: (90, 64, 37),   # The Vile Reef
        105: (91, 64, 42),   # Mosh'Ogg Ogre Mound
        106: (92, 64, 0),    # The Stockpile
        107: (93, 64, 14),   # Saldean's Farm
        108: (94, 64, 15),   # Sentinel Hill
        109: (95, 64, 15),   # Furlbrow's Pumpkin Farm
        111: (96, 64, 12),   # Jangolode Mine
        113: (97, 64, 15),   # Gold Coast Quarry
        115: (98, 64, 17),   # Westfall Lighthouse
        116: (99, 64, 39),   # Misty Valley
        117: (100, 64, 35),  # Grom'gol Base Camp
        118: (101, 64, 22),  # Whelgar's Excavation Site
        120: (102, 64, 8),   # Westbrook Garrison
        121: (103, 64, 28),  # Tranquil Gardens Cemetary
        122: (104, 64, 37),  # Zuuldaia Ruins
        123: (105, 64, 34),  # Bal'lal Ruins
        125: (106, 64, 35),  # Kal'ai Ruins
        126: (107, 64, 0),   # Tkashi Ruins
        127: (108, 64, 40),  # Balia'mah Ruins
        128: (109, 64, 36),  # Ziata'jai Ruins
        129: (110, 64, 37),  # Mizjah Ruins
        130: (111, 64, 0),   # Silverpine Forest
        131: (112, 64, 5),   # Kharanos
        132: (113, 64, 0),   # Coldridge Valley
        133: (114, 64, 10),  # Gnomeregan
        134: (115, 64, 10),  # Gol'Bolar Quarry
        135: (116, 64, 7),   # Frostmane Hold
        136: (117, 64, 5),   # The Grizzled Den
        137: (118, 64, 7),   # Brewnall Village
        138: (119, 64, 7),   # Misty Pine Refuge
        139: (120, 64, 0),   # Eastern Plaguelands
        141: (121, 64, 0),   # Teldrassil
        142: (122, 64, 15),  # Ironband's Excavation Site
        143: (123, 64, 18),  # Mo'grosh Stronghold
        144: (124, 64, 10),  # Thelsamar
        145: (125, 64, 18),  # Algaz Gate
        146: (126, 64, 15),  # Stonewrought Dam
        147: (127, 64, 15),  # The Farstrider Lodge
        148: (128, 64, 0),   # Darkshore
        149: (129, 64, 12),  # Silver Stream Mine
        150: (130, 64, 20),  # Menethil Harbor
        151: (131, 64, 0),   # Designer Island
        152: (132, 64, 9),   # The Bulwark
        153: (133, 64, 10),  # Ruins of Lordaeron
        154: (134, 64, 0),   # Deathknell
        155: (135, 64, 0),   # Night Web's Hollow
        156: (136, 64, 6),   # Solliden Farmstead
        157: (137, 64, 8),   # Agamand Mills
        158: (138, 64, 0),   # Agamand Family Crypt
        159: (139, 64, 5),   # Brill
        160: (140, 64, 12),  # Whispering Gardens
        161: (141, 64, 10),  # Terrace of Repose
        162: (142, 64, 7),   # Brightwater Lake
        163: (143, 64, 0),   # Gunther's Retreat
        164: (144, 64, 7),   # Garren's Haunt
        165: (145, 64, 5),   # Balnir Farmstead
        166: (146, 64, 5),   # Cold Hearth Manor
        167: (147, 64, 8),   # Crusader Outpost
        168: (148, 64, 0),   # The North Coast
        169: (149, 64, 0),   # Whispering Shore
        170: (150, 64, 0),   # Lordamere Lake
        172: (151, 64, 18),  # Fenris Isle
        173: (152, 64, 0),   # Faol's Rest
        186: (153, 64, 5),   # Dolanaar
        187: (154, 64, 7),   # Darnassus
        188: (155, 64, 0),   # Shadowglen
        189: (156, 64, 5),   # Steelgrill's Depot
        190: (157, 64, 56),  # Hearthglenn
        192: (158, 64, 55),  # Northridge Lumber Camp
        193: (159, 64, 55),  # Ruins of Anderhol
        195: (160, 64, 0),   # School of Necromancy
        196: (161, 64, 0),   # Uther's Tomb
        197: (162, 64, 50),  # Sorrow Hill
        198: (163, 64, 55),  # The Weeping Cave
        199: (164, 64, 50),  # Felstone Field
        200: (165, 64, 54),  # Dalson's Tears
        201: (166, 64, 57),  # Gahrron's Withering
        202: (167, 64, 46),  # The Writhing Haunt
        203: (168, 64, 0),   # Mardenholde Keep
        204: (169, 64, 15),  # Pyrewood Village
        205: (170, 64, 28),  # Dun Modr
        206: (171, 64, 0),   # Westfall
        207: (172, 64, 0),   # The Great Sea
        208: (173, 64, 0),   # Ironclad Cove
        209: (174, 0, 16),   # Shadowfang
        210: (175, 68, 0),   # ***On Map Dungeon***
        211: (176, 64, 7),   # Iceflow Lake
        212: (177, 64, 8),   # Helm's Bed Lake
        213: (178, 64, 13),  # Deep Elem Mine
        214: (179, 64, 0),   # The Great Sea
        215: (180, 64, 0),   # Mulgore
        219: (181, 64, 15),  # Alexston Farmstead
        220: (182, 64, 0),   # Red Cloud Mesa
        221: (183, 64, 0),   # Camp Narache
        222: (184, 64, 5),   # Bloodhoof Village
        223: (185, 64, 0),   # Stonebull Lake
        224: (186, 64, 7),   # Ravaged Caravan
        225: (187, 64, 9),   # Red Rocks
        226: (188, 64, 11),  # The Skittering Dark
        227: (189, 64, 11),  # Valgan's Field
        228: (190, 64, 10),  # The Sepulcher
        229: (191, 64, 12),  # Olsen's Farthing
        230: (192, 64, 18),  # The Greymane Wall
        231: (193, 64, 20),  # Beren's Peril
        232: (194, 64, 0),   # The Dawning Isles
        233: (195, 64, 15),  # Ambermill
        235: (196, 64, 0),   # Fenris Keep
        236: (197, 64, 16),  # Shadowfang Keep
        237: (198, 64, 16),  # The Decrepit Ferry
        238: (199, 64, 0),   # Malden's Orchard
        239: (200, 64, 11),  # The Ivar Patch
        240: (201, 64, 12),  # The Dead Field
        241: (202, 64, 26),  # The Rotting Orchard
        242: (203, 64, 28),  # Brightwood Grove
        243: (204, 64, 0),   # Forlorn Rowe
        244: (205, 64, 0),   # The Whipple Estate
        245: (206, 64, 25),  # The Yorgen Farmstead
        246: (207, 64, 48),  # The Cauldron
        247: (208, 64, 45),  # Grimesilt Dig Site
        249: (209, 64, 50),  # Dreadmaul Rock
        250: (210, 64, 54),  # Ruins of Thaurisan
        251: (211, 64, 0),   # Flame Crest
        252: (212, 64, 57),  # Blackrock Stronghold
        253: (213, 64, 56),  # The Pillar of Ash
        254: (214, 64, 55),  # Blackrock Spire
        255: (215, 64, 59),  # Altar of Storms
        256: (216, 64, 0),   # Aldrassil
        257: (217, 64, 0),   # Shadowthread Cave
        258: (218, 64, 0),   # Fel Rock
        259: (219, 64, 5),   # Lake Al'Ameth
        260: (220, 64, 6),   # Starbreeze Village
        261: (221, 64, 8),   # Gnarlpine Hold
        262: (222, 64, 0),   # Ban'ethil Barrow Den
        263: (223, 64, 0),   # The Cleft
        264: (224, 64, 9),   # The Oracle Glade
        265: (225, 64, 11),  # The Wellspring River
        266: (226, 64, 9),   # Wellspring Lake
        267: (227, 64, 0),   # Hillsbrad Foothills
        268: (228, 64, 0),   # Plains of Snow
        269: (229, 64, 18),  # Dun Algaz
        271: (230, 64, 22),  # Southshore
        272: (231, 64, 20),  # Tarren Mill
        275: (232, 64, 21),  # Durnholde Keep
        276: (233, 64, 0),   # Stonewrought Pass
        277: (234, 64, 0),   # The Foothill Caverns
        278: (235, 64, 32),  # Lordamere Internment Camp
        279: (236, 64, 30),  # Dalaran
        280: (237, 64, 34),  # Strahnbrad
        281: (238, 64, 36),  # Ruins of Alterac
        282: (239, 64, 35),  # Crushridge Hold
        283: (240, 64, 35),  # Slaughter Hollow
        284: (241, 64, 27),  # The Uplands
        285: (242, 64, 21),  # Southpoint Tower
        286: (243, 64, 22),  # Hillsbrad Fields
        287: (244, 64, 0),   # Hillsbrad
        288: (245, 64, 27),  # Azureload Mine
        289: (246, 64, 26),  # Nethander Stead
        290: (247, 64, 30),  # Dun Garok
        293: (248, 64, 30),  # Thoradin's Wall
        294: (249, 64, 30),  # Eastern Strand
        295: (250, 64, 30),  # Western Strand
        296: (251, 64, 0),   # South Seas
        297: (252, 64, 50),  # Jaguero Isle
        298: (253, 64, 0),   # Baradin Bay
        299: (254, 64, 0),   # Menethil Bay
        300: (255, 64, 41),  # Mistyreed Strand
        301: (256, 64, 0),   # The Savage Coast
        302: (257, 64, 0),   # The Crystal Shore
        303: (258, 64, 0),   # Shell Beach
        305: (259, 64, 0),   # North Tide's Run
        306: (260, 64, 0),   # South Tide's Run
        307: (261, 64, 48),  # The Overlook Cliffs
        308: (262, 64, 0),   # The Forbidding Sea
        309: (263, 64, 24),  # Ironbeard's Tomb
        310: (264, 64, 41),  # Crystalvein Mine
        311: (265, 64, 44),  # Ruins of Aboraz
        312: (266, 64, 0),   # Janeiro's Point
        313: (267, 64, 31),  # Northfold Manor
        314: (268, 64, 33),  # Go'Shek Farm
        315: (269, 64, 31),  # Dabyrie's Farmstead
        316: (270, 64, 35),  # Boulderfist Hall
        317: (271, 64, 33),  # Witherbark Village
        318: (272, 64, 36),  # Drywhisker Gorge
        320: (273, 64, 30),  # Refuge Pointe
        321: (274, 64, 30),  # Hammerfall
        322: (275, 64, 0),   # Blackwater Shipwrecks
        323: (276, 64, 0),   # O'Breen's Camp
        324: (277, 64, 36),  # Stromgarde Keep
        325: (278, 64, 0),   # The Tower of Arathor
        326: (279, 64, 0),   # The Sanctum
        327: (280, 64, 40),  # Faldir's Cove
        328: (281, 64, 0),   # The Drowned Reef
        330: (282, 64, 0),   # Thandol Span
        331: (283, 64, 0),   # Ashenvale
        332: (284, 64, 0),   # The Great Sea
        333: (285, 64, 38),  # Circle of East Binding
        334: (286, 64, 38),  # Circle of West Binding
        335: (287, 64, 38),  # Circle of Inner Binding
        336: (288, 64, 38),  # Circle of Outer Binding
        337: (289, 64, 36),  # Apocryphan's Rest
        338: (290, 64, 39),  # Angor Fortress
        339: (291, 64, 45),  # Lethlor Ravine
        340: (292, 64, 38),  # Kargath
        341: (293, 64, 36),  # Camp Kosh
        342: (294, 64, 39),  # Camp Boff
        343: (295, 64, 0),   # Camp Wurg
        344: (296, 64, 43),  # Camp Cagg
        345: (297, 64, 39),  # Agmond's End
        346: (298, 64, 36),  # Hammertoe's Digsite
        347: (299, 64, 43),  # Dustbelch Grotto
        348: (300, 64, 41),  # Aerie Peak
        349: (301, 64, 0),   # Wildhammer Keep
        350: (302, 64, 45),  # Quel'Danil Lodge
        351: (303, 64, 48),  # Skulk Rock
        352: (304, 64, 0),   # Zun'watha
        353: (305, 64, 44),  # Shadra'Alor
        354: (306, 64, 45),  # Jintha'Alor
        355: (307, 64, 46),  # The Altar of Zul
        356: (308, 64, 41),  # Seradane
        357: (309, 64, 0),   # Feralas
        358: (310, 64, 0),   # Brambleblade Ravine
        359: (311, 64, 25),  # Bael Modan
        360: (312, 64, 7),   # The Venture Co. Mine
        361: (313, 64, 0),   # Felwood
        362: (314, 64, 5),   # Razor Hill
        363: (315, 64, 0),   # Valley of Trials
        364: (316, 64, 0),   # The Den
        365: (317, 64, 0),   # Burning Blade Coven
        366: (318, 64, 7),   # Kolkar Crag
        367: (319, 64, 6),   # Sen'jin Village
        368: (320, 64, 7),   # Echo Isles
        369: (321, 64, 9),   # Thunder Ridge
        370: (322, 64, 8),   # Drygulch Ravine
        371: (323, 64, 0),   # Dustwind Cave
        372: (324, 64, 6),   # Tiragarde Keep
        373: (325, 64, 0),   # Scuttle Coast
        374: (326, 64, 0),   # Bladefist Bay
        375: (327, 64, 0),   # Deadeye Shore
        377: (328, 64, 9),   # Southfury River
        378: (329, 64, 10),  # Camp Taurajo
        379: (330, 64, 10),  # Far Watch Post
        380: (331, 64, 15),  # The Crossroads
        381: (332, 64, 17),  # Boulder Load Mine
        382: (333, 64, 15),  # The Sludge Fen
        383: (334, 64, 14),  # The Dry Hills
        384: (335, 64, 11),  # Dreadmist Peak
        385: (336, 64, 15),  # Northwatch Hold
        386: (337, 64, 12),  # The Forgotten Pools
        387: (338, 64, 12),  # Lushwater Oasis
        388: (339, 64, 15),  # The Stagnant Oasis
        390: (340, 64, 20),  # Field of Giants
        391: (341, 64, 12),  # The Merchant Coast
        392: (342, 64, 15),  # Ratchet
        393: (343, 64, 0),   # Darkspear Strand
        394: (344, 64, 0),   # Darrowmere Lake
        395: (345, 64, 0),   # Caer Darrow
        396: (346, 64, 6),   # Winterhoof Water Well
        397: (347, 64, 7),   # Thunderhorn Water Well
        398: (348, 64, 8),   # Wildmane Water Well
        399: (349, 64, 6),   # Skyline Ridge
        400: (350, 64, 0),   # Thousand Needles
        401: (351, 64, 0),   # The Tidus Stair
        403: (352, 64, 0),   # Shady Rest Inn
        404: (353, 64, 8),   # Bael'Dun Digsite
        405: (354, 64, 0),   # Desolace
        406: (355, 64, 0),   # Stonetalon Mountains
        407: (356, 64, 10),  # Orgrimmar
        408: (357, 64, 0),   # Gillijim's Isle
        409: (358, 64, 0),   # Island of Doctor Lapidis
        410: (359, 64, 8),   # Razorwind Canyon
        411: (360, 64, 0),   # Bathran's Haunt
        412: (361, 64, 0),   # The Ruins of Ordil'Aran
        413: (362, 64, 19),  # Maestra's Post
        414: (363, 64, 20),  # The Zoram Strand
        415: (364, 64, 20),  # Astranaar
        416: (365, 64, 23),  # The Shrine of Aessina
        417: (366, 64, 25),  # Fire Scar Shrine
        418: (367, 64, 23),  # The Ruins of Stardust
        419: (368, 64, 28),  # The Howling Vale
        420: (369, 64, 25),  # Silverwind Refuge
        421: (370, 64, 25),  # Mystral Lake
        422: (371, 64, 26),  # Fallen Sky Lake
        424: (372, 64, 22),  # Iris Lake
        425: (373, 64, 0),   # Moonwell
        426: (374, 64, 24),  # Raynewood Retreat
        427: (375, 64, 0),   # The Shady Nook
        428: (376, 64, 25),  # Night Run
        429: (377, 64, 0),   # Xavian
        430: (378, 64, 28),  # Satyrnaar
        431: (379, 64, 25),  # Solace Glade
        432: (380, 64, 30),  # The Dor'danil Barrow Den
        433: (381, 64, 0),   # Falfarren River
        434: (382, 64, 29),  # Felfire Hill
        435: (383, 64, 0),   # Demon Fall Canyon
        436: (384, 64, 0),   # Demon Fall Ridge
        437: (385, 64, 22),  # Kargathia Outpost
        438: (386, 64, 20),  # Bough Shadow
        439: (387, 64, 35),  # The Shimmering Flats
        440: (388, 64, 0),   # Tanaris
        441: (389, 64, 20),  # Lake Falathim
        442: (390, 64, 12),  # Auberdine
        443: (391, 64, 19),  # Ruins of Mathystra
        444: (392, 64, 16),  # Tower of Althalaxx
        445: (393, 64, 14),  # Cliffspring Falls
        446: (394, 64, 11),  # Bashal'Aran
        447: (395, 64, 11),  # Ameth'Aran
        448: (396, 64, 15),  # Grove of the Ancients
        449: (397, 64, 16),  # The Master's Glaive
        450: (398, 64, 19),  # Remtravel's Excavation
        452: (399, 64, 0),   # Mist's Edge
        453: (400, 64, 0),   # The Long Wash
        454: (401, 64, 0),   # Wildbend River
        455: (402, 64, 0),   # Blackwood Den
        456: (403, 64, 14),  # Cliffspring River
        457: (404, 64, 0),   # The Veiled Sea
        458: (405, 64, 0),   # Gold Road
        459: (406, 64, 10),  # Scarlet Watch Post
        460: (407, 64, 20),  # Sun Rock Retreat
        461: (408, 64, 20),  # Windshear Crag
        463: (409, 64, 0),   # Cragpool Lake
        464: (410, 64, 21),  # Mirkfallon Lake
        465: (411, 64, 25),  # The Charred Vale
        466: (412, 64, 0),   # Valley of the Bloodfuries
        467: (413, 64, 25),  # Stonetalon Peak
        468: (414, 64, 0),   # The Talon Den
        469: (415, 64, 0),   # Greatwood Vale
        470: (416, 64, 10),  # Thunder Bluff
        471: (417, 64, 0),   # Brave Wind Mesa
        472: (418, 64, 0),   # Fire Stone Mesa
        473: (419, 64, 0),   # Mantle Rock
        474: (420, 64, 0),   # Hunter Rise
        475: (421, 64, 0),   # Spirit Rise
        476: (422, 64, 0),   # Elder Rise
        477: (423, 64, 43),  # Ruins of Jubuwal
        478: (424, 64, 8),   # Pools of Arlithrien
        479: (425, 64, 0),   # The Rustmaul Dig Site
        480: (426, 64, 30),  # Camp E'thok
        481: (427, 64, 24),  # Galak Crag
        482: (428, 64, 29),  # Highperch
        483: (429, 64, 30),  # The Screeching Canyon
        484: (430, 64, 26),  # Freewind Post
        485: (431, 64, 25),  # The Great Lift
        486: (432, 64, 0),   # Galak Hold
        487: (433, 64, 0),   # Roguefeather Den
        488: (434, 64, 0),   # The Weathered Nook
        489: (435, 64, 0),   # Thalanaar
        490: (436, 64, 0),   # Ungoro Crater
        491: (437, 0, 0),    # Razorfen Kraul
        492: (438, 64, 26),  # Raven Hill Cemetery
        493: (439, 64, 0),   # Moonglade
        495: (440, 64, 0),   # Twilight Grove
        496: (441, 64, 36),  # Brackenwall Village
        497: (442, 64, 0),   # Swamplight Manor
        498: (443, 64, 0),   # Bloodfen Burrow
        499: (444, 64, 0),   # Darkmist Cavern
        500: (445, 64, 0),   # Moggle Point
        501: (446, 64, 0),   # Beezil's Wreck
        502: (447, 64, 36),  # Witch Hill
        503: (448, 64, 0),   # Sentry Point
        504: (449, 64, 0),   # North Point Tower
        505: (450, 64, 0),   # West Point Tower
        506: (451, 64, 0),   # Lost Point
        507: (452, 64, 36),  # Bluefen
        508: (453, 64, 0),   # Stonemaul Ruins
        509: (454, 64, 38),  # The Den of Flame
        510: (455, 64, 0),   # The Dragonmurk
        511: (456, 64, 43),  # Wyrmbog
        512: (457, 64, 0),   # Onyxia's Lair
        513: (458, 64, 36),  # Theramore Isle
        514: (459, 64, 0),   # Foothold Citadel
        515: (460, 64, 0),   # Ironclad Prison
        516: (461, 64, 0),   # Dustwallow Bay
        517: (462, 64, 0),   # Tidefury Cove
        518: (463, 64, 36),  # Dreadmurk Shore
        536: (464, 64, 24),  # Addle's Stead
        537: (465, 64, 55),  # Fire Plume Ridge
        538: (466, 64, 49),  # Lik'ash Tar Pits
        539: (467, 64, 53),  # Terror Run
        540: (468, 64, 51),  # The Slithering Scar
        541: (469, 64, 0),   # Marshal's Refuge
        542: (470, 64, 0),   # Fungal Rock
        543: (471, 64, 53),  # Golakka Hot Springs
        556: (472, 64, 12),  # The Loch
        576: (473, 64, 25),  # Beggar's Haunt
        596: (474, 64, 35),  # Kodo Graveyard
        597: (475, 64, 0),   # Ghost Walker Post
        598: (476, 64, 0),   # Sar'theris Strand
        599: (477, 64, 30),  # Thunder Axe Fortress
        600: (478, 64, 0),   # Bolgan's Hole
        602: (479, 64, 39),  # Mannoroc Coven
        603: (480, 64, 31),  # Sargeron
        604: (481, 64, 36),  # Magram Village
        606: (482, 64, 34),  # Gelkis Village
        607: (483, 64, 37),  # Valley of Spears
        608: (484, 64, 30),  # Nijel's Point
        609: (485, 64, 32),  # Kolkar Village
        616: (486, 64, 0),   # Hyjal
        618: (487, 65, 0),   # Winterspring
    }
