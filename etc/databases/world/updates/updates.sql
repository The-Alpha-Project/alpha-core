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
        update spawns_gameobjects set ignored = 1 where spawn_entry in (152614, 80022);

        insert into applied_updates values ('230320212');
    end if;
end $
delimiter ;
