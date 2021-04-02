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

        insert into applied_updates values ('020420211');
    end if;
end $
delimiter ;
