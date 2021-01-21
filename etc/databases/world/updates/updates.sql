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

        update item_template set display_id = 7947, armor = 3 where entry = 209;
        update item_template set display_id = 7973, armor = 2 where entry = 210;

        insert into applied_updates values ('221120201');
    end if;

    -- 22/11/2020 2
    if (select count(*) from applied_updates where id='221120202') = 0 then
        replace into playercreateinfo_spell (race, class, Spell, Note) values
        (2, 3, 107, 'Block'),
        (3, 3, 107, 'Block'),
        (4, 3, 107, 'Block'),
        (6, 3, 107, 'Block'),
        (8, 3, 107, 'Block'),

        (1, 4, 107, 'Block'),
        (2, 4, 107, 'Block'),
        (3, 4, 107, 'Block'),
        (4, 4, 107, 'Block'),
        (5, 4, 107, 'Block'),
        (7, 4, 107, 'Block'),
        (8, 4, 107, 'Block');

        insert into applied_updates values ('221120202');
    end if;

    -- 23/11/2020 2
    if (select count(*) from applied_updates where id='231120202') = 0 then
        update creature_template set display_id1 = 499 where entry = 547;
        update creature_template set display_id1 = 193 where entry = 157;
        update creature_template set display_id1 = 377 where entry = 1984;

        update spawns_gameobjects set ignored = 1 where spawn_entry = 175756;

        update spawns_creatures set ignored = 1 where spawn_entry1 = 8119;
        update spawns_creatures set position_x = -915.369934, position_y = -3724.15, position_z = 10.244946 where spawn_entry1 = 3496;

        insert into applied_updates values ('231120202');
    end if;

    -- 12/12/2020 1
    if (select count(*) from applied_updates where id='121220201') = 0 then
        /* Captain Placeholder */
        replace into spawns_creatures (spawn_entry1, map, display_id, position_x, position_y, position_z, orientation) values
        (3896, 0, 1466, -3764.68530273438, -705.55419921875, 8.03029537200928, 0.13962633907795);
        update creature_template set health_min = 100, health_max = 100, mana_min = 204, mana_max = 204, level_min = 40, level_max = 40, faction = 12, unit_flags = 4608, npc_flags = 2, base_attack_time = 2000, ranged_attack_time = 2000 where entry = 3896;

        /* Captain Quirk */
        replace into spawns_creatures (spawn_entry1, map, display_id, position_x, position_y, position_z, orientation) values
        (4497, 1, 1740, -3975.79516601563, -4749.50439453125, 10.2699127197266, 1.20427715778351);
        update creature_template set health_min = 100, health_max = 100, mana_min = 340, mana_max = 340, level_min = 60, level_max = 60, faction = 12, unit_flags = 4608, npc_flags = 2, base_attack_time = 2000, ranged_attack_time = 2000 where entry = 4497;

        insert into applied_updates values ('121220201');
    end if;

    -- 18/01/2021 1
    if (select count(*) from applied_updates where id='180120211') = 0 then
        update creature_template set name = 'Marrek Stromnur', display_id1 = 3403, faction = 53 where entry = 944;
        update quest_template set Details = 'Long ago high elves taught us the secrets of magic along with our human allies. They preached to us about rules and how magic can make ya go mad! But don''t believe it. We''re not like the elves; we don''t have the same weaknesses. Just keep yourself on the right path and you''ll find magic is as powerful a tool as it is a weapon.$B$BWhen you''re ready, come find me inside Anvilmar. I''ll be waiting for ya!$B$B- Marrek Stromnur, Mage Trainer', Objectives = 'Speak to Marrek Stromnur inside Anvilmar.' where entry = 3111;

        insert into applied_updates values ('180120211');
    end if;

    -- 21/01/2021 1
    if (select count(*) from applied_updates where id='210120211') = 0 then
        update item_template set name = 'Crownroyal', sell_price = 5, buy_price = 20 where entry = 3356;
        update gameobject_template set name = 'Crownroyal' where entry = 1624;

        insert into applied_updates values ('210120211');
    end if;

end $
delimiter ;