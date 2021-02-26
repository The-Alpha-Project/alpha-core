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
end $
delimiter ;