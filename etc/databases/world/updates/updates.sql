delimiter $
begin not atomic
    -- 11/05/2020 1
    if (select count(*) from applied_updates where id='110520201') = 0 then
        insert into worldports (x, y, z, o, map, name) values (3167.27, -1407.15, 0, 0, 17, 'Kalidar');
        insert into worldports (x, y, z, o, map, name) values (100, 100, 200, 0, 30, 'PvPZone01');
        update worldports set name = 'pvpzone02_new' where entry = 1017;
        insert into worldports (x, y, z, o, map, name) values (277.77, -888.38, 400, 0, 37, 'PvPZone02');
        insert into worldports (x, y, z, o, map, name) values (0, 0, 0, -0.277778, 13, 'testing');
        insert into worldports (x, y, z, o, map, name) values (0, 0, 0, -0.277778, 29, 'CashTest');
        insert into worldports (x, y, z, o, map, name) values (0, 0, 0, -0.277778, 42, 'Collin');
        insert into worldports (x, y, z, o, map, name) values (0.76, -0.91, -2.32, 0, 44, 'OldScarletMonastery');
        insert into worldports (x, y, z, o, map, name) values (52, 0.6, -17.53, 6.2, 34, 'StormwindJail');
        insert into worldports (x, y, z, o, map, name) values (-1.43, 38.9, -23.6, 1.5, 35, 'StormwindPrison');

        insert into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY,
        spawn_positionZ, spawn_orientation, spawn_rotation0, spawn_rotation1, spawn_rotation2, spawn_rotation3,
        spawn_spawntime) values (2169, 0, -9036.7, 842.987, 109.076, 0.410153, 0, 0, 0.203642, 0.979046, 120);

        insert into applied_updates values ('110520201');
    end if;

    -- 11/05/2020 2
    if (select count(*) from applied_updates where id='110520202') = 0 then
        alter table spawns_gameobjects drop column displayid;

        insert into applied_updates values ('110520202');
    end if;
end $
delimiter ;