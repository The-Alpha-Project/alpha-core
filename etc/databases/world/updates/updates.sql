delimiter $
begin not atomic
    -- 23/03/2021 1
    if (select count(*) from applied_updates where id='230320211') = 0 then
        delete from spawns_creatures where spawn_id = 2530733;
        replace into spawns_creatures (spawn_entry1, map, display_id, position_x, position_y, position_z, orientation) values
        (2298, 0, 3572, -3757.669, -767.931, 9.392, 3.334);

        update spawns_creatures set spawn_id = 400000 where spawn_id = 2530718;
        update spawns_creatures set spawn_id = 400001 where spawn_id = 2530719;
        update spawns_creatures set spawn_id = 400002 where spawn_id = 2530720;
        update spawns_creatures set spawn_id = 400003 where spawn_id = 2530721;
        update spawns_creatures set spawn_id = 400004 where spawn_id = 2530722;
        update spawns_creatures set spawn_id = 400005 where spawn_id = 2530723;
        update spawns_creatures set spawn_id = 400006 where spawn_id = 2530724;
        update spawns_creatures set spawn_id = 400007 where spawn_id = 2530725;
        update spawns_creatures set spawn_id = 400008 where spawn_id = 2530726;
        update spawns_creatures set spawn_id = 400009 where spawn_id = 2530727;
        update spawns_creatures set spawn_id = 400010 where spawn_id = 2530728;
        update spawns_creatures set spawn_id = 400011 where spawn_id = 2530729;
        update spawns_creatures set spawn_id = 400012 where spawn_id = 2530730;
        update spawns_creatures set spawn_id = 400013 where spawn_id = 2530731;
        update spawns_creatures set spawn_id = 400014 where spawn_id = 2530732;
        update spawns_creatures set spawn_id = 400015 where spawn_id = 2530734;
        update spawns_creatures set spawn_id = 400016 where spawn_id = 2530735;
        update spawns_creatures set spawn_id = 400017 where spawn_id = 2530736;
        update spawns_creatures set spawn_id = 400018 where spawn_id = 2530737;
        update spawns_creatures set spawn_id = 400019 where spawn_id = 2530738;
        update spawns_creatures set spawn_id = 400020 where spawn_id = 2530739;
        update spawns_creatures set spawn_id = 400021 where spawn_id = 2530740;

        alter table spawns_creatures auto_increment = 400022;

        insert into applied_updates values ('230320211');
    end if;

    -- 23/03/2021 2
    if (select count(*) from applied_updates where id='230320212') = 0 then
        update spawns_gameobjects set ignored = 1 where spawn_entry in (152614, 80022, 80023);

        insert into applied_updates values ('230320212');
    end if;

    -- 31/03/2021 1
    if (select count(*) from applied_updates where id='310320211') = 0 then
        UPDATE `creature_template` SET `detection_range`=10 WHERE `entry` IN (6, 38, 69, 80, 103, 257, 299, 704, 705, 706, 707, 708, 724, 808, 946, 1501, 1502, 1504, 1505, 1506, 1507, 1508, 1509, 1512, 1513, 1667, 1688, 1890, 1916, 1917, 1918, 1919, 1984, 1985, 1986, 1988, 1989, 1994, 2031, 2032, 2952, 2953, 2954, 2955, 2961, 2966, 3098, 3101, 3102, 3124, 3183, 3229, 3281, 3300, 8554);
        UPDATE `creature_template` SET `detection_range`=18 WHERE `detection_range`=16 && `rank`=0;

        insert into applied_updates values ('310320211');
    end if;

    -- 02/04/2021 1
    if (select count(*) from applied_updates where id='020420211') = 0 then
        update creature_template set name = 'Thulbek', subname = 'Gun Merchant', npc_flags = 4, gossip_menu_id = 0, vendor_id = 5814 where entry = 5814;
        update spawns_creatures set ignored = 1 where spawn_entry1 = 5814;

        DELETE FROM `spawns_gameobjects` WHERE `spawn_entry` IN (23299, 23300, 23301, 24715, 24717, 24718, 24719, 24720, 24721, 25341, 25342, 25352, 25353, 25354);
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`, `spawn_spawntimemin`, `spawn_spawntimemax`) VALUES
        (42861, 23299, 0, -8707.29, 909.091, 102.03, 0.680677, 0, 0, 0.333806, 0.942642, 1, 120, 120),
        (42860, 23300, 0, -8897.94, 909.434, 110.7, 5.20108, 0, 0, -0.515037, 0.857168, 1, 120, 120),
        (42862, 23301, 0, -8808, 938.986, 101.841, 5.37562, 0, 0, -0.43837, 0.898795, 1, 120, 120),
        (42936, 24715, 0, -8873.65, 754.266, 96.4673, 5.46288, 0, 0, -0.398749, 0.91706, 1, 120, 120),
        (26643, 24717, 0, -8713.17, 725.943, 97.0882, 0.689404, 0, 0, 0.337916, 0.941176, 1, 120, 120),
        (42866, 24718, 0, -8706.59, 867.789, 96.7633, 0.689404, 0, 0, 0.337916, 0.941176, 1, 120, 120),
        (42867, 24719, 0, -8727.88, 894.59, 100.563, 0.689404, 0, 0, 0.337916, 0.941176, 1, 120, 120),
        (42868, 24720, 0, -8825.22, 959.159, 99.847, 5.4018, 0, 0, -0.426568, 0.904455, 1, 120, 120),
        (26610, 24721, 0, -8843.1, 924.154, 101.783, 5.20981, 0, 0, -0.511293, 0.859407, 1, 120, 120),
        (42874, 25341, 0, -8806.95, 956.342, 112.986, 3.81354, 0, 0, -0.944089, 0.329691, 1, 120, 120),
        (42873, 25342, 0, -8703.75, 904.834, 108.535, 5.38434, 0, 0, -0.434444, 0.900699, 1, 120, 120),
        (42872, 25352, 0, -8704.11, 926.336, 113.227, 5.38434, 0, 0, -0.434444, 0.900699, 1, 120, 120),
        (42876, 25353, 0, -8812.22, 935.571, 108.294, 3.81354, 0, 0, -0.944089, 0.329691, 1, 120, 120),
        (42875, 25354, 0, -8790.71, 935.927, 112.986, 3.81354, 0, 0, -0.944089, 0.329691, 1, 120, 120);

        insert into applied_updates values ('020420211');
    end if;

    -- 14/04/2021 1
    if (select count(*) from applied_updates where id='140420211') = 0 then
        update quest_template set Details = 'I hope you strapped your belt on tight, young $c, because there is work to do here in Northshire.$B$BAnd I don''t mean farming.$B$BThe Stormwind guards are hard pressed to keep the peace here, with so many of us in distant lands and so many threats pressing close.  And so we''re enlisting the aid of anyone willing to defend their home.  And their alliance.$B$BIf you''re here to answer the call, then speak with my superior, Marshal McBride.  He''s inside the abbey behind me.' where entry = 783;

        insert into applied_updates values ('140420211');
    end if;
end $
delimiter ;
