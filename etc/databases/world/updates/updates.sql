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

    -- 20/08/2021 2
    if (select count(*) from applied_updates where id='200820212') = 0 then
        UPDATE `creature_template` SET `display_id1`=23 WHERE `entry`=4981;
        UPDATE `creature_template` SET `display_id1`=2438 WHERE `entry`=1432;
        UPDATE `creature_template` SET `display_id1`=20 WHERE `entry`=279;
        UPDATE `creature_template` SET `display_id1`=190 WHERE `entry`=1212;
        UPDATE `creature_template` SET `display_id1`=190 WHERE `entry`=1284;
        UPDATE `creature_template` SET `display_id1`=1499 WHERE `entry`=928;
        UPDATE `creature_template` SET `display_id1`=3445 WHERE `entry`=5566;
        UPDATE `creature_template` SET `display_id1`=1573 WHERE `entry`=1444;
        UPDATE `creature_template` SET `display_id1`=1541 WHERE `entry`=3516;
        UPDATE `creature_template` SET `display_id1`=1480 WHERE `entry`=1307;
        UPDATE `creature_template` SET `display_id1`=328 WHERE `entry`=1419;
        UPDATE `creature_template` SET `display_id1`=4449 WHERE `entry`=173;
        UPDATE `creature_template` SET `display_id1`=580 WHERE `entry`=1733;
        UPDATE `creature_template` SET `display_id1`=213 WHERE `entry`=483;

        -- # NPC SPAWN FIX
        -- Elaine Trias was not present in the shop in 0.5.3, and Innkeeper Alliston didn't exist in 0.5.3, so because of
        -- this screenshot: https://i.imgur.com/6zNt0SK.png we can *guess* that NPC might be Elaine Trias.
        UPDATE `spawns_creatures` SET `position_y`=658.784,`position_x`=-8861.12,`position_z`=96.721, `orientation`=5.331 WHERE `spawn_id`=79665;
        -- Jail Guards Z fix
        UPDATE `spawns_creatures` SET `position_z`=99.193 WHERE `spawn_id`=79819;
        UPDATE `spawns_creatures` SET `position_z`=99.126 WHERE `spawn_id`=19272;

        -- # NPC SPAWN IGNORED
        -- White kitten
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=7386;
        -- Lil Timmy
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=8666;
        -- Innkeepr Allison
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=79841;
        -- Lil Timmy
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11867;
        -- Woo Ping
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11068;
        -- Betty Quin
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11068;
        -- Kimberly Grant
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11827;
        -- Nara Meideros
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11397;
        -- Sprite Jumpsprocket
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11026;
        -- Randal Worth
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=11096;
        -- Royal Factor Barthrillor
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=10782;
        -- Jalane Ayrole
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=9584;

        -- # GAMEOBJECTS DISPLAY FIX
        -- Books from SW Keep library
        UPDATE `gameobject_template` SET `displayId`=558 WHERE `entry`=175735;

        -- # GAMEOBJECTS SPAWNS IGNORED
        -- Those gameobjects spawns are not part of 0.5.3, so we hide or delete
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_entry` IN (140911, 103795, 2123, 2190, 160444, 164908, 179731, 179728, 24469, 24470, 160442, 24653, 24654, 24686, 160443, 179730, 179733, 179727,179729, 179726, 179734, 179735, 176576, 179737, 179738);

        insert into applied_updates values ('200820212');
    end if;
end $
delimiter ;
