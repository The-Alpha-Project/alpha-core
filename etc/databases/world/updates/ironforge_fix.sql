-- #################################################################################################################
-- #                                             Ironforge 0.5.3 Fix                                               #
-- #  What I've done :                                                                                             #
-- #       - Spawn fix NPCs with screenshots from Archives                                                         #
-- #       - Spawn fix NPCs in their respective houses (mining, enchanting, rogue...)                              #
-- #       - Ignored Ironforge NPCs 6000+ entries                                                                  #
-- #       - Ignores 4 guards who wheres in houses or in walls                                                     #
-- #       - Ignored all chairs and braziers who were not part of 0.5.3                                            #
-- #       - Ignored all flying plates and books who were not part of 0.5.3                                        #
-- #       - Ignored flying wrong small sign                                                                       #
-- #       - Ignored gnome side shop big signs (they dont fit 0.5.3 gnome zone and not on screenshots)             #
-- #       - Spawn fix somes big shop signs and some small direction signs                                         #
-- #       - Spawn creation Forge and Anvil (screenshots)                                                          #
-- #       - Missing display_id Fix for Bretta (we have screenshot of this npc)                                    #

-- #  TODO :                                                                                                       #
-- #       - Spawn Fix Guards                                                                                      #
-- #       - Create direction signs on pillars to help players                                                     #
-- #       - Spawn fix rest of shop big signs                                                                      #
-- #       - Resolve some missing display_id                                                                       #

-- #  Notes :                                                                                                      #
-- #       - Layout has changed but houses are basically same as 1.12, except gnomes side and Burbik shop          #
-- #       - Rogue and warlock trainer  seems to have been swapped their house  compared to 1.12 (screenshots)     #
-- #       - Alot of NPCs had only bad Z index but they were right X Y O                                           #
-- #       - Almost no display_id are missing in Ironforge, so we can be sure these NPCs are ingame                #
-- #       - Big shop signs need to have all spawn_rotationX=0 to be able to use Orientation                       #
-- #       - Clients braziers seems to be placeholder in wait of server side one, same for client chairs           #
-- #       - So some braziers are probably part of 0.5.3 and I only ignored right ones                             #
-- #                                                                                                               #
-- #                                                                                                               #
-- #################################################################################################################

delimiter $
begin not atomic
    -- 31/08/2021 1
    if (select count(*) from applied_updates where id='310820211') = 0 then

                                -- ##              ##
                                -- #   GAMEOBJECTS  #
                                -- ##              ##

        -- ### MISC ###

        -- Chair, anvil, forge, brazier IGNORED :
        UPDATE spawns_gameobjects 
            SET ignored=1
            WHERE spawn_id IN (987, 4995, 4996, 5343, 5319, 95, 503, 4994, 4997, 4998, 4999, 5000, 121, 122, 123, 124, 351, 352, 423, 431, 433, 457, 463, 464, 481, 118, 119, 120, 474, 4656, 4657, 1709, 848, 1675, 1596, 1789, 1794, 1679, 1599, 948, 920, 922, 4710, 4721, 4708, 4709, 4686, 4684, 4921, 4922, 4923, 4847, 4849, 4858, 4859, 4884, 4886, 4964, 4982, 4885, 4890, 5001, 5002, 5006, 5034, 112, 113, 110, 111, 54, 55, 47, 48, 60, 87, 56, 57, 735, 736, 737, 740, 741, 742, 762, 763, 773, 777, 794, 796, 800, 802, 803, 6831, 6834, 1821, 4730, 4731, 4839, 4840, 4828, 4833, 4817, 4819, 6999, 7000, 761, 768, 779, 815, 816, 768, 814, 746, 755, 760, 829, 833, 867, 862, 1493, 1499, 125, 461, 492, 4984, 4986, 4985, 4986, 4990, 5426, 5427, 674, 694, 701, 720, 924, 925, 49, 50, 96, 5453, 5459, 5430, 5431, 6866, 1486, 5243); 

        -- Books IGNORED
        UPDATE spawns_gameobjects 
            SET ignored=1
            WHERE spawn_id IN (5384, 5385, 5386, 5353, 5364, 5381, 5362, 5363, 5394);

        -- Plates IGNORED
        UPDATE spawns_gameobjects 
            SET ignored=1
            WHERE spawn_id IN (5352, 5141, 5205, 1883, 8256, 5203, 5382, 1887, 5396, 5398, 5405, 5424, 5423, 5425, 5422, 5193,5195);

        -- Forge SPAWN CREATION 
            INSERT INTO spawns_gameobjects 
            VALUES(NULL, 24745, 0, -4818.97, -1109.22, 477.237, 0, 0, 0, 0 ,0, 0, 0, 0, 1, 0, 0 , 0);

        -- Anvil SPAWN CREATION
            INSERT INTO spawns_gameobjects 
            VALUES(NULL, 1744, 0, -4786.69, -1085.23, 477.237, 1.5, 0, 0, 0 ,0, 0, 0, 0, 1, 0, 0 , 0);


        -- ### SMALL TRAFFIC SIGN ###

                -- TODO: We need to create sign to guide players in IF 

        -- Hide, flying sign
        UPDATE spawns_gameobjects
            SET ignored=1
        WHERE spawn_id IN (826, 837, 838, 5231, 628, 635, 636, 839, 5054, 4776);

        -- We fix sign a bit off center to pillar  
        UPDATE spawns_gameobjects
            SET spawn_positionY=-902.999,spawn_positionX=-4899.26
        WHERE spawn_id=1556;

        UPDATE spawns_gameobjects
            SET spawn_positionY=-902.177,spawn_positionX=-4897.57
        WHERE spawn_id IN (1545, 1570, 1580);

        UPDATE spawns_gameobjects
            SET spawn_positionY=-968.566,spawn_positionX=-4878.04
        WHERE spawn_id IN (826, 837, 838);

        UPDATE spawns_gameobjects
            SET spawn_positionX=-4669.98,spawn_positionY=-949.432
            WHERE spawn_id=2002;

        UPDATE spawns_gameobjects
            SET spawn_positionY=-950.595,spawn_positionX=-4668.74
            WHERE spawn_id=2013;

        UPDATE spawns_gameobjects
            SET spawn_positionX=-4670.05,spawn_positionY=-950.674
            WHERE spawn_id=2010;

        UPDATE spawns_gameobjects
            SET spawn_positionX=-4673.72,spawn_positionY=-1202.69
            WHERE spawn_id=628;

        UPDATE spawns_gameobjects
            SET spawn_positionX=-4673.75,spawn_positionY=-1201.35
            WHERE spawn_id=635;

        UPDATE spawns_gameobjects
            SET spawn_positionX=-4674.96,spawn_positionY=-1201.18
            WHERE spawn_id=636;


        -- #### BIG SHOP SIGN SPAWN FIX #####

            -- I reordered those flying in Ironforge, others are surely located in walls
            -- TODO: Reorder the rest

        -- Fizzlespinner general good
        UPDATE spawns_gameobjects
            SET spawn_positionY=-998.305,spawn_positionX=-4966.94
            WHERE spawn_id=797;

        -- Traveling Fisherman
        UPDATE spawns_gameobjects
            SET spawn_positionY=-1190.2,spawn_positionX=-4809.55,spawn_positionZ=498, spawn_orientation=1.723, spawn_rotation2=0, spawn_rotation3=0
            WHERE spawn_id=4845;

        -- Bronze Kettel
        UPDATE spawns_gameobjects
            SET spawn_positionY=-1167.94,spawn_positionX=-4766.08, spawn_positionZ=495.2, spawn_orientation=5.2, spawn_rotation2=0, spawn_rotation3=0
            WHERE spawn_id=5249;

        -- ironforge armory
        UPDATE spawns_gameobjects
            SET spawn_positionY=-984,spawn_positionX=-4849.50, spawn_positionZ=502, spawn_orientation=1.945, spawn_rotation2=0, spawn_rotation3=0
            WHERE spawn_id=921;

        -- Thitlefuzz arcanery
        UPDATE spawns_gameobjects
            SET spawn_positionY=-1008.17,spawn_positionX=-4608.99, spawn_positionZ=524.3, spawn_orientation=1.835, spawn_rotation2=0, spawn_rotation3=0
            WHERE spawn_id=480;

        -- deep mountain mining
        UPDATE spawns_gameobjects
            SET spawn_positionY=-1134.56,spawn_positionX=-4723.26, spawn_positionZ=503, spawn_orientation=2.541, spawn_rotation2=0, spawn_rotation3=0
            WHERE spawn_id=5015;

        -- burbik's supplies
        UPDATE spawns_gameobjects
            SET spawn_positionY=-1190.76,spawn_positionX=-4692.4, spawn_positionZ=507, spawn_orientation=5.57, spawn_rotation2=0, spawn_rotation3=0
            WHERE spawn_id=5018;

        -- Stonebrew's clothier
        UPDATE spawns_gameobjects
            SET spawn_positionZ=523.0,spawn_orientation=3.59,spawn_positionX=-4602.71,spawn_rotation3=0.0,spawn_rotation2=0.0,spawn_positionY=-980.07
            WHERE spawn_id=5057;

        -- Berryfizz's Potion and mixed drinks - Probably not in game, gnomes dont have their final zone and this cant fit actual gnome zone
        UPDATE spawns_gameobjects
            SET ignored=1
            WHERE spawn_id=51;

        -- Things that go boom! - Probably not in game, same reasons
        UPDATE spawns_gameobjects
            SET ignored=1
            WHERE spawn_id=53;

        -- SpringSpindle's Gadgets - Probably not in game, same reasons
        UPDATE spawns_gameobjects
            SET ignored=1
            WHERE spawn_id=27;


                                    -- ##              ##
                                    -- #       NPC      #
                                    -- ##              ##


        -- ### NOT IN GAME ###
            
        -- entry is too high to be part of 0.5.3
        UPDATE spawns_creatures
            SET ignored=1
            WHERE spawn_entry1 IN (7292, 8517, 10090, 7298, 6114, 6031, 7978, 7936, 8256, 9616, 10877, 6178, 11865, 13084, 7976, 8671, 6291, 6181, 9859, 10877, 6294, 7936, 9616, 6175, 10455, 10456, 11029, 11028, 6169, 7937, 6569, 7944, 7950, 11065, 10276, 10277, 11145, 11146, 6120, 6382);
        
        -- Guards in house or on wall location
        UPDATE spawns_creatures
            SET ignored=1
            WHERE spawn_id IN (1757, 1750, 2027, 1894);


        -- ### SPAWN FIX ###

        -- Priest Trainer
        UPDATE spawns_creatures
            SET position_z=542.916,position_x=-4614.003,position_y=-903.787,orientation=2.245
            WHERE spawn_id=1780;

        -- Valgar Highforge, paladin trainer
        UPDATE spawns_creatures
            SET position_z=542.916
            WHERE spawn_id=1778;

        -- Nittlebur Sparkfizzle, marge trainer
        UPDATE spawns_creatures
            SET position_x=-4602.559,position_y=-917.995,position_z=542.916,orientation=5.407
            WHERE spawn_id=1782;

        -- Thurgrum
        UPDATE spawns_creatures
            SET position_y=-1097.12,position_z=477.237,position_x=-4803.86,orientation=5.397
            WHERE spawn_id=2014;

        -- Pithwick
        UPDATE spawns_creatures
            SET orientation=4.002,position_x=-4698.678,position_z=505.269,position_y=-1175.132
            WHERE spawn_id=102;

        -- Bretta Goldfury
        UPDATE spawns_creatures
            SET position_z=530.158,position_y=-1281.7,position_x=-4924.56,orientation=6.197
            WHERE spawn_id=27;
        -- Bretta dont have display_id and we can see him on screenshot
        UPDATE creature_template 
            SET display_id1=3077
            WHERE entry=5123;

        -- Lissyphus finespindle
        UPDATE spawns_creatures
            SET position_z=523.508
            WHERE spawn_id=94;

        -- Dolkin craghelm
        UPDATE spawns_creatures
            SET position_z=523.508
            WHERE spawn_id=93;

        -- Olthran Craghelm
        UPDATE spawns_creatures
            SET position_z=530.175
            WHERE spawn_id=92;

        -- Kelomir Steelhand
        UPDATE spawns_creatures
            SET position_x=-5037.38,position_z=520.51,position_y=-1206.76
            WHERE spawn_id=61;

        -- Hegnar swiftaxe
        UPDATE spawns_creatures
            SET position_x=-5035.5,position_z=520.51,position_y=-1205.9
            WHERE spawn_id=62;

        -- Brenwyn
        UPDATE spawns_creatures
            SET position_x=-5034.04,position_z=520.51,position_y=-1205.02
            WHERE spawn_id=86;

        -- Bruuk
        UPDATE spawns_creatures
            SET position_z=520.165
            WHERE spawn_id=53;

        -- Tisa Martine
        UPDATE spawns_creatures
            SET position_z=520.165
            WHERE spawn_id=55;

        -- Edris 
        UPDATE spawns_creatures
            SET position_z=528.499
            WHERE spawn_id=54;

        -- Tynnus
        UPDATE spawns_creatures
            SET position_z=491.883,position_y=-1033.29,orientation=0.606,position_x=-4738.52
            WHERE spawn_id=1808;

        -- Fentwich
        UPDATE spawns_creatures
            SET position_y=-1002.16,position_x=-4710.99,orientation=5.386,position_z=495.5
            WHERE spawn_id=1805;

        -- Durtham
        UPDATE spawns_creatures
            SET orientation=5.386,position_z=495.5,position_y=-1000.91,position_x=-4709.25
            WHERE spawn_id=1809;

        -- Thistleheart
        UPDATE spawns_creatures
            SET position_z=499.107,position_x=-4741.65,orientation=0.595,position_y=-1045.09
            WHERE spawn_id=1804;

        -- Ormyr
        UPDATE spawns_creatures
            SET position_y=-1009.17,position_x=-4711.53,position_z=495.494,orientation=5.369
            WHERE spawn_id=1806;

        -- Gerrig
        UPDATE spawns_creatures
            SET orientation=2.174,position_z=495.494,position_y=-1004.13,position_x=-4708.08
            WHERE spawn_id=1802;

        -- Alexander
        UPDATE spawns_creatures
            SET orientation=0.515,position_y=-1037.2,position_x=-4743.51,position_z=492.439
            WHERE spawn_id=1803;

        -- Eglantine
        UPDATE spawns_creatures
            SET orientation=5.278,position_z=492.439,position_x=-4749.67,position_y=-1035.95
            WHERE spawn_id=1807;

        -- Engineering supplier
        UPDATE spawns_creatures
            SET orientation=4.113,position_z=429.405,position_x=-4805.79,position_y=-1237.20
            WHERE spawn_id=42;

        -- Springspindle
        UPDATE spawns_creatures
            SET orientation=3.713,position_z=429.405,position_x=-4801.41,position_y=-1244.22
            WHERE spawn_id=41;

        -- Fizzlebang
        UPDATE spawns_creatures
            SET position_x=-4815.35,position_y=-1333.9,position_z=429.405,orientation=2.179
            WHERE spawn_id=302421;

        -- Fillius
        UPDATE spawns_creatures
            SET position_z=511.928,orientation=5.576,position_x=-4953.49,position_y=-996.759
            WHERE spawn_id=98;

        -- Banker 1
        UPDATE spawns_creatures
            SET orientation=5.321,position_y=-949.419,position_z=491.314,position_x=-4910.77
            WHERE spawn_id=111;

        -- Banker 2
        UPDATE spawns_creatures
            SET position_x=-4919.76,position_y=-956.727,position_z=491.314,orientation=5.321
            WHERE spawn_id=1754;

        -- Banker 3
        UPDATE spawns_creatures
            SET position_y=-964.003,position_z=491.314,orientation=5.441,position_x=-4928.82
            WHERE spawn_id=1756;

        -- Guard Bank 1
        UPDATE spawns_creatures
            SET position_y=-980.233,position_z=488.82,orientation=5.421,position_x=-4904.64
            WHERE spawn_id=114;

        -- Guard Bank 2
        UPDATE spawns_creatures
            SET position_y=-976.166,position_z=488.82,orientation=5.421,position_x=-4899.83
            WHERE spawn_id=115;

        -- Daryl
        UPDATE spawns_creatures
            SET position_y=-1157.6,position_z=499.397,orientation=3.541,position_x=-4786.21
            WHERE spawn_id=1892;

        -- Emrul
        UPDATE spawns_creatures
            SET position_z=492.729,position_x=-4781.34,orientation=0.387,position_y=-1159.89
            WHERE spawn_id=1891;

        -- Tansy
        UPDATE spawns_creatures
            SET position_z=495.815,position_y=-1203.55,position_x=-4802.45,orientation=0.052
            WHERE spawn_id=1787;

        -- Grimnur
        UPDATE spawns_creatures
            SET position_y=-1200.55,position_z=502.483,orientation=4.823,position_x=-4801.89
            WHERE spawn_id=1794;

        -- Gretta 
        UPDATE spawns_creatures
            SET position_x=-4941.87,position_y=-1185.56,position_z=503.891,orientation=3.74
            WHERE spawn_id=1763;

        -- Bombus
        UPDATE spawns_creatures
            SET position_y=-1191.29,orientation=0.778,position_x=-4935.93,position_z=503.891
            WHERE spawn_id=2083;

        -- Fimble
        UPDATE spawns_creatures
            SET position_z=503.891,position_x=-4944.97,position_y=-1180.53,orientation=2.258
            WHERE spawn_id=2084;

        -- Kelv
        UPDATE spawns_creatures
            SET position_y=-1273.54,orientation=2.761,position_x=-5039.92,position_z=528.53
            WHERE spawn_id=2019;

        -- Poranna
        UPDATE spawns_creatures
            SET orientation=5.132,position_y=-958.282,position_z=520.43,position_x=-4596.5
            WHERE spawn_id=1798;

        -- Tilli
        UPDATE spawns_creatures
            SET position_z=523.508,orientation=0.285,position_y=-1023.99,position_x=-4594.53
            WHERE spawn_id=48;

        -- Gimble
        UPDATE spawns_creatures
            SET position_x=-4603.84,orientation=3.467,position_y=-1016.47,position_z=530.175
            WHERE spawn_id=49;

        -- Reyna
        UPDATE spawns_creatures
            SET orientation=1.206,position_z=503.874,position_x=-4903.22,position_y=-1276.85
            WHERE spawn_id=96;

        -- Gwina
        UPDATE spawns_creatures
            SET position_x=-4900.78,position_y=-1285.25,position_z=503.874,orientation=2.618
            WHERE spawn_id=95;

        -- Bryllia
        UPDATE spawns_creatures
            SET position_x=-4954.44,position_y=-1004.26,orientation=0.996,position_z=505.259
            WHERE spawn_id=99;

        -- Golnir
        UPDATE spawns_creatures
            SET position_x=-4715.49,position_z=494.44,position_y=-1159.96,orientation=0.94
            WHERE spawn_id=1812;

        -- Geofram
        UPDATE spawns_creatures
            SET position_x=-4710.23,position_y=-1149.66,orientation=4.468,position_z=494.44
            WHERE spawn_id=1811;

        -- Dolman
        UPDATE spawns_creatures
            SET position_x=-4933.49,position_y=-999.066,orientation=0.869,position_z=493
            WHERE spawn_id=110;

        -- Hjoldir
        UPDATE spawns_creatures
            SET position_x=-4932.01,position_y=-1000.22,orientation=0.869,position_z=493
            WHERE spawn_id=1786;

        -- Grenil
        UPDATE spawns_creatures
            SET position_y=-1001.27,position_z=493,orientation=0.869,position_x=-4930.66
            WHERE spawn_id=112;

        -- Raena
        UPDATE spawns_creatures
            SET position_y=-1003.93,position_z=494.419,orientation=4.057,position_x=-4845.73
            WHERE spawn_id=1755;

        -- Mangorn
        UPDATE spawns_creatures
            SET position_z=494.43,position_x=-4854.55,position_y=-1009.37,orientation=0.366
            WHERE spawn_id=1751;

        -- Harick
        UPDATE spawns_creatures
            SET position_z=521.281
            WHERE spawn_id=1761;

        -- Bingus
        UPDATE spawns_creatures
            SET position_z=527.08
            WHERE spawn_id=1762;

        -- Jormund
        UPDATE spawns_creatures
            SET position_y=-971.739,orientation=5.151,position_z=527.097,position_x=-4590.48
            WHERE spawn_id=1795;

        -- Myra
        UPDATE spawns_creatures
            SET position_x=-4989.4,position_z=501.66,position_y=-983.935
            WHERE spawn_id=122;

        -- Grumnus
        UPDATE spawns_creatures
            SET position_x=-4819.67,position_z=477.24,position_y=-1114.22,orientation=1.51
            WHERE spawn_id=2030;

        -- Soolie (she was already at this location, i just center her a bit)
        UPDATE spawns_creatures
            SET position_z=429.5,position_x=-4859.0,position_y=-1231.02,orientation=5.303
            WHERE spawn_id=28;

        -- tally (she was already at this location, i just center her a bit)
        UPDATE spawns_creatures
            SET position_x=-4867.45,orientation=5.433,position_z=429.5,position_y=-1236.5
            WHERE spawn_id=29;

        -- Hulfdan
        UPDATE spawns_creatures
            SET position_x=-4715.64,orientation=5.35,position_z=502.16,position_y=-1001.97
            WHERE spawn_id=1810;

        -- Beldruk
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1769;

        -- Brandur
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1781;

        -- Milituus
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1771;

        -- Braenna
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1770;

        -- Braenna
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1772;

        -- Bink
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1773;

        -- Juli
        UPDATE spawns_creatures
            SET position_z=521.0
            WHERE spawn_id=1779;

        -- Regnus
        UPDATE spawns_creatures
            SET position_z=526.0
            WHERE spawn_id=82;

        -- Kelstrum
        UPDATE spawns_creatures
            SET position_z=526.0
            WHERE spawn_id=83;

        -- Bilban
        UPDATE spawns_creatures
            SET position_z=526.0
            WHERE spawn_id=84;

        -- Olmin
        UPDATE spawns_creatures
            SET position_z=526.0
            WHERE spawn_id=87;

        -- Daera
        UPDATE spawns_creatures
            SET position_z=528.6
            WHERE spawn_id=2020;

        -- Longbeard Pilot
        UPDATE spawns_creatures
            SET position_z=520.2
            WHERE spawn_id=2022;

        -- Bengus
        UPDATE spawns_creatures
            SET orientation=6.23,position_z=477.3,position_y=-1079.53,position_x=-4848.66
            WHERE spawn_id=2013;

        -- Brombar
        UPDATE spawns_creatures
            SET position_z=477.24,position_x=-4813.87,orientation=4.659,position_y=-1050.88
            WHERE spawn_id=1890;

        -- Nissa
        UPDATE spawns_creatures
            SET position_x=-4909.52,position_z=504.0,orientation=4.172,position_y=-1276.35
            WHERE spawn_id=2015;
            
        -- Bromiir
        UPDATE spawns_creatures
            SET position_x=-4858.43,position_z=494.5,orientation=0.33,position_y=-1004.47
            WHERE spawn_id=1752;

        -- Skolmin
        UPDATE spawns_creatures
            SET position_x=-4913.33,position_z=523.5,position_y=-1284.92,orientation=4.318
            WHERE spawn_id=39;

        -- Burbik
        UPDATE spawns_creatures
            SET position_z=512,position_y=-1179.4,position_x=-4697.38,orientation=1
            WHERE spawn_id=1784;

        -- Ransin
        UPDATE spawns_creatures
            SET orientation=1.06,position_z=491.883,position_x=-4742.91,position_y=-1019.52
            WHERE spawn_id=1791;

        -- Ulthrar
        UPDATE spawns_creatures
            SET orientation=5.179,position_z=527.883,position_x=-4595.265,position_y=-955.457
            WHERE spawn_id=1796;

        -- Guard
        UPDATE spawns_creatures
            SET orientation=2.306,position_z=492.197,position_x=-4735.04,position_y=-1162.47
            WHERE spawn_id=1821;

        -- Guard
        UPDATE spawns_creatures
            SET orientation=2.306,position_z=492.197,position_x=-4753.14,position_y=-1177.98
            WHERE spawn_id=1893;


        insert into applied_updates values ('310820211');
    end if;
end $
delimiter ;
