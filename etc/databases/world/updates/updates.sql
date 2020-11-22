delimiter $
begin not atomic
    -- 21/11/2020 1
    if (select count(*) from applied_updates where id='211120201') = 0 then
        update spawns_gameobjects set ignored = 1 where spawn_entry in (177905, 178264, 178265, 181431);

        replace into gameobject_template VALUES (47296,11,360,'Mesa Elevator',0,40,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(47297,11,360,'Mesa Elevator',0,40,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'');

        update gameobject_template set entry = 4173 where entry = 4171;
        update gameobject_template set entry = 4171 where entry = 47296;
        update gameobject_template set entry = 4172 where entry = 47297;

        update spawns_gameobjects set spawn_entry = 4173 where spawn_entry = 47296;
        update spawns_gameobjects set spawn_entry = 4172 where spawn_entry = 47297;

        replace into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values (32056, 0, -4681.400, -1093.650, 422.477, 3.08);
        replace into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values (32057, 0, -4831.182, -1217.200, 422.477, 1.45);

        delete from spawns_gameobjects where spawn_entry in (21653, 21654, 21655, 21656);
        replace into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values (21654, 0, -4674.700, -1094.04, 441.45, 3.08);
        replace into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values (21653, 0, -4687.700, -1093.125, 499.65, 3.08);
        replace into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values (21656, 0, -4830.25, -1210.75, 499.65, 1.45);
        replace into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY, spawn_positionZ, spawn_orientation) values (21655, 0, -4831.85, -1223.55, 441.45, 1.45);

        update gameobject_template set name = 'Ironforge Elevator Lower Door' where entry in (21654, 21655);
        update gameobject_template set name = 'Ironforge Elevator Upper Door' where entry in (21653, 21656);

        update gameobject_template set displayid = 176 where entry = 2146;
        update gameobject_template set displayid = 173 where entry = 2139;
        update gameobject_template set displayid = 172 where entry = 2138;
        update spawns_gameobjects set ignored = 1 where spawn_entry = 66780;

        insert into applied_updates values ('211120201');
    end if;

    -- 22/11/2020 1
    if (select count(*) from applied_updates where id='221120201') = 0 then
        update creature_template set display_id1 = 1396 where entry = 1354;

        insert into applied_updates values ('221120201');
    end if;

end $
delimiter ;