delimiter $
begin not atomic
    -- 11/02/2021 1
    if (select count(*) from applied_updates where id='110220211') = 0 then
        update spawns_gameobjects set ignored = 1 where spawn_entry in (176753, 175566);
        update spawns_creatures set ignored = 1 where spawn_entry1 in (10665, 10666);
        update quest_template set ignored = 1 where entry in (5481, 5482);

        /* Main Hall Chair */
        update spawns_gameobjects set spawn_entry = 37069 where spawn_id = 44837;
        update spawns_gameobjects set spawn_entry = 37066 where spawn_id = 44838;
        update spawns_gameobjects set spawn_entry = 37057 where spawn_id = 44826;
        update spawns_gameobjects set spawn_entry = 37058 where spawn_id = 44832;
        update spawns_gameobjects set spawn_entry = 37059 where spawn_id = 44830;
        update spawns_gameobjects set spawn_entry = 37062 where spawn_id = 44820;
        update spawns_gameobjects set spawn_entry = 37063 where spawn_id = 44819;
        update spawns_gameobjects set spawn_entry = 37064 where spawn_id = 44817;
        update spawns_gameobjects set spawn_entry = 37065 where spawn_id = 44823;
        update spawns_gameobjects set spawn_entry = 37067 where spawn_id = 44824;
        update spawns_gameobjects set spawn_entry = 37068 where spawn_id = 44825;
        update spawns_gameobjects set spawn_entry = 37060 where spawn_id = 44818;
        update spawns_gameobjects set spawn_entry = 37061 where spawn_id = 44828;

        /* Elegant Chair */
        replace into spawns_gameobjects (spawn_entry, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values
        (37070, 2302.332734, 265.124669, 38.669846, 1.317196);

        /* Old Pew */
        replace into spawns_gameobjects (spawn_entry, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values
        (37053, 2309.762451, 276.017761, 37.310703, 4.458355),
        (37054, 2308.682861, 272.583588, 37.310661, 4.426939),

        (37052, 2306.001465, 270.191498, 37.310383, 1.312838),

        (37055, 2317.793359, 279.477142, 37.310703, 2.869500),
        (37056, 2305.555420, 282.496826, 37.310570, 6.015017);

        update spawns_gameobjects set spawn_positionX = 2263.089150, spawn_positionY = 249.919006, spawn_positionZ = 41.114769,
                                      spawn_orientation = 6.084185, spawn_rotation2 = 0, spawn_rotation3 = 0 where spawn_id = 44866;

        update spawns_gameobjects set spawn_positionX = -9459.416992, spawn_positionY = 20.861105, spawn_positionZ = 63.820412,
                                      spawn_orientation = 4.596528, spawn_rotation2 = 0, spawn_rotation3 = 0, ignored = 0 where spawn_id = 26243;

        update spawns_gameobjects set ignored = 1 where spawn_id in (44827, 44829, 44834, 44822, 44836, 44833,
                                                                    44839, 44821, 44835, 44831);

        alter table gameobject_template drop column data10;
        alter table gameobject_template drop column data11;
        alter table gameobject_template drop column data12;
        alter table gameobject_template drop column data13;
        alter table gameobject_template drop column data14;
        alter table gameobject_template drop column data15;
        alter table gameobject_template drop column data16;
        alter table gameobject_template drop column data17;
        alter table gameobject_template drop column data18;
        alter table gameobject_template drop column data19;
        alter table gameobject_template drop column data20;
        alter table gameobject_template drop column data21;
        alter table gameobject_template drop column data22;
        alter table gameobject_template drop column data23;

        update spawns_gameobjects set ignored = 1 where spawn_id in (10772, 10820, 10768, 10771, 10770, 10805, 10803,
                                                                     10804, 10815, 10817, 10819, 10793, 10800, 10802,
                                                                     10761, 10762, 10794, 10780, 10779, 10795, 10796,
                                                                     10799, 10811, 10801, 10797, 10798, 10763, 10729,
                                                                     11011, 11010, 10806, 10781, 10816, 10785, 10728,
                                                                     10759, 10818, 10814, 10727);

        update item_template set name = 'Peacebloom Flower' where entry = 2447;

        update spawns_gameobjects set ignored = 1 where spawn_id in (45002);

        insert into applied_updates values ('110220211');
    end if;

    -- 12/02/2021 1
    if (select count(*) from applied_updates where id='120220211') = 0 then
        update player_classlevelstats set basemana = 0 where class = 3;
    end if;

    -- 18/02/2021 1
    if (select count(*) from applied_updates where id='180220211') = 0 then
        update spawns_creatures set ignored = 1 where spawn_entry1 = 14223;
        update creature_template set display_id1 = 2296 where display_id1 = 10877;
    end if;

    -- 20/02/2021 1
    if (select count(*) from applied_updates where id='200220211') = 0 then
        update areatrigger_teleport set required_level = 10 where id = 257;

    end if;

    -- 20/02/2021 1
    if (select count(*) from applied_updates where id='200220211') = 0 then
        update areatrigger_teleport set name = 'Scarlet Monastery', target_map = 44, target_position_x = 34.0377, target_position_y = -0.8574,
                                        target_position_z = 9.6747, target_orientation = 6.2816 where id = 45;
        replace into areatrigger_teleport (id, target_map, target_position_x, target_position_y, target_position_z,
                                           target_orientation) values (240, 0, 2853.6733, -717.3836, 147.9484, 1.8916);

    end if;

    -- 26/02/2021 1
    if (select count(*) from applied_updates where id='260220211') = 0 then
        drop table playercreateinfo_skill;
        replace into playercreateinfo_spell (race, class, Spell, Note) values
                                                                              (5, 1, 668, 'Language Common'),
                                                                              (5, 4, 668, 'Language Common'),
                                                                              (5, 5, 668, 'Language Common'),
                                                                              (5, 8, 668, 'Language Common'),
                                                                              (5, 9, 668, 'Language Common');

        insert into applied_updates values ('260220211');
    end if;

    -- 28/02/2021 1
    if (select count(*) from applied_updates where id='280220211') = 0 then
        update creature_template set unit_flags = 768 where entry in (247,392,395,582,664,795,796,797,804,805,806,807,810,811,847,848,849,850,851,8400,1366,1367,1368,1370,1371,1429,1445,1446,1447,1669,1672,1673,1747,1776,8400,2150,2155,2317,2331,2532,2533,2616,2634,2672,2684,2687,2688,2766,2785,2852,2853,2888,2920,2921,2922,2994,3073,3096,3180,3209,3465,3504,3505,3507,3508,3510,3511,3512,3513,3534,3536,3679,3888,3891,3892,3915,4072,4085,4086,4201,4251,4252,4419,4429,4430,4452,4453,4454,4495,4496,4503,4507,4618,4620,4629,4630,4706,4707,4709,4720,4792,4901,4945,4946,4980,4982,5353,5397,5398,5416,5523,5568,5598,5607,5608,5726,5729,5730,5735,5736,5738,5739,5767,5768,5783,5784,5792,5891,6176,6236,6247,6248,6251,6252,6253,6254,6266,6495,6496,6546,6548,6728,6730,7207,7363,7381,7382,7384,7385,7386,7389,7390,7395,7505,7506,7553,7555,7572,7770,7774,7783,7784,7801,7802,7806,7807,7826,7850,7897,8023,8391,8421,8439,8509,8666,8678,8679,8816,8962,8963,8965,9836,10116,10117,10262,10637,10658,10918,11016,11020,11033,11140,11198,11378,11710,11834,11872,11874,11940,11942,11943,11944,11996,12034,12383,12957,12958,13277,13445,13636,14305,14467,14496,14499,14504,14508,14567,14624,14625,14626,14627,14628,14634,14822,14823,14827,14828,14829,14832,14833,14841,14844,14845,14846,14847,14849,14850,14857,14860,14864,14866,14868,14869,14871,14872,14873,14874,14892,14908,15078,15079,15185,15303,15309,10668,2943,7951,10445,15624,15664,16070,16076,16225,8887,15553,9256,16701,6491,12776,12776,12944,12944,13697,13697,14567);
        -- Omusa Thunderhorn <Wind Rider Master> should only be spawned in 1.6+
        update spawns_creatures set ignored = 1 where spawn_entry1 = 10378;

        -- Morbent Fel, Stalvan Mistmantle and Zzarc' Vul level fixes
        update creature_template set level_min = 35, level_max = 35 where entry in (1200, 315);
        update creature_template set level_min = 33, level_max = 33 where entry = 300;

        insert into applied_updates values ('280220211');
    end if;

    -- 01/03/2021 1
    if (select count(*) from applied_updates where id='010320211') = 0 then
        update spawns_creatures set ignored = 1 where spawn_entry1 in (12480, 12481);
        update creature_template set display_id = 17 where entry = 352;

        insert into applied_updates values ('010320211');
    end if;
end $
delimiter ;