delimiter $
begin not atomic
    -- 20/08/2021 1
    if (select count(*) from applied_updates where id='200820211') = 0 then
        DROP TABLE `reference_loot`;

        insert into applied_updates values ('200820211');
    end if;

    -- 21/08/2021 1
    if (select count(*) from applied_updates where id='210820211') = 0 then
        delete from spawns_creatures where spawn_id in (400021, 4571, 34255, 2087, 2088);
        update creature_template set subname = 'Binder', npc_flags = 16, faction = 35 where entry in (2299, 4320);
        update creature_template set level_min = 25, level_max = 25, rank = 0, display_id1 = 100 where entry = 1571;
        insert into spawns_creatures (spawn_id, spawn_entry1, map, display_id, position_x, position_y, position_z, orientation, wander_distance, spawntimesecsmin, spawntimesecsmax)
        values (4571, 2299, 0, 1626, -3755.786, -769.870, 9.663, 3.670, 0, 300, 300),
               (34255, 4320, 1, 2416, -4509.453, -766.072, -37.654, 4.638, 0, 300, 300),
               (2087, 1274, 0, 1655, -4619.843, -1050.162, 438.099, 3.609, 0, 430, 430),
               (2088, 2784, 0, 3597, -4592.550, -1095.895, 449.043, 2.362, 0, 86400, 86400);

        insert into applied_updates values ('210820211');
    end if;
end $
delimiter ;
