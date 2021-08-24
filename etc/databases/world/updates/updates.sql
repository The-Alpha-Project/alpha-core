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
        UPDATE `creature_template` SET `display_id1`=213 WHERE `entry`=6740;

        -- # NPC SPAWN FIX
        -- Innkeeper Allison? https://i.imgur.com/6zNt0SK.png
        UPDATE `spawns_creatures` SET `position_y`=658.784,`position_x`=-8861.12,`position_z`=96.721, `orientation`=5.331 WHERE `spawn_id`=79841;
        -- Jail Guards Z fix
        UPDATE `spawns_creatures` SET `position_z`=99.193 WHERE `spawn_id`=79819;
        UPDATE `spawns_creatures` SET `position_z`=99.126 WHERE `spawn_id`=19272;

        -- # NPC SPAWN IGNORED
        -- White kitten
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=7386;
        -- Lil Timmy
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1`=8666;
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

    -- 23/08/2021 1
    if (select count(*) from applied_updates where id='230820211') = 0 then
        CREATE TABLE `spell_target_position` (
          `id` mediumint(8) unsigned NOT NULL DEFAULT 0,
          `target_map` smallint(5) unsigned NOT NULL DEFAULT 0,
          `target_position_x` float NOT NULL DEFAULT 0,
          `target_position_y` float NOT NULL DEFAULT 0,
          `target_position_z` float NOT NULL DEFAULT 0,
          `target_orientation` float NOT NULL DEFAULT 0,
          PRIMARY KEY (`id`,`target_map`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        INSERT INTO `spell_target_position` VALUES (442,129,2592.55,1107.5,51.29,4.74),(444,1,-4658.12,-2526.35,82.9671,0),(446,109,-319.24,99.9,-131.85,3.19),(3561,0,-9003.46,870.031,29.6206,5.28),(3562,0,-4613.62,-915.38,501.062,3.88),(3563,0,1773.47,61.121,-46.3207,0.54),(3565,1,9660.81,2513.64,1331.66,3.06),(3566,1,-964.98,283.433,111.187,3.02),(3567,1,1469.85,-4221.52,58.9939,5.98),(33,0,-10643,1052,34,0),(31,0,-9464,62,56,0),(34,0,-10368,-422,66,0),(35,0,-9104,-70,83,0),(427,189,1688.99,1053.48,18.6775,0.00117),(428,0,-11020,1436,44,0),(445,0,-10566,-1189,28,0),(4996,1,1552.5,-4420.66,8.94802,0),(4997,0,-14457,496.45,39.1392,0),(4998,0,-12415,207.618,31.5017,0.124875),(4999,1,-998.359,-3827.52,5.44507,4.16654),(6348,0,-3752.81,-851.558,10.1153,0),(6349,1,6581.05,767.5,5.78428,6.01616),(6483,1,5483.9,-749.881,334.621,0),(6719,1,-3615.49,-4467.34,24.3141,0),(447,0,16229,16265,14,3.19),(3721,0,16229,16265,14,3.19),(1936,0,16229,16265,14,0),(443,0,16229,16265,14,4.74),(6766,1,-2354.03,-1902.07,95.78,4.6),(6714,1,-4884.49,-1596.2,101.2,3.17),(7587,33,-102.933,2124.29,155.648,1.08944),(7586,33,-105.88,2154.87,156.445,5.82146),(7136,33,-85.767,2150.22,155.607,3.97629);

        insert into applied_updates values ('230820211');
    end if;

    -- 24/08/2021 1
    if (select count(*) from applied_updates where id='240820211') = 0 then

        -- # SW NPC Display Fix

        -- Riding Gryphon
        UPDATE `creature_template` SET `display_id1`=935 WHERE `entry`=541;

        -- Brother Kristoff, We already solved this but display_id was not good https://ibb.co/SXwYDRF
        UPDATE `creature_template` SET `display_id1`=190 WHERE `entry`=1444;
        -- Angus Stern https://ibb.co/vQBTGzM
        UPDATE `creature_template` SET `display_id1`=1485 WHERE `entry`=1141;
        -- Milton Sheaf https://ibb.co/Sxxhrny
        UPDATE `creature_template` SET `display_id1`=20 WHERE `entry`=1440;
        
        -- Ardwyn Cailen, It appears that the display_id 1477 is unused although it is Ardwyn Cailen's model
        UPDATE `creature_template` SET `display_id1`=1477 WHERE `entry`=1312;
        -- Wynne Larson, It appears that display_id 1483 is unused although it is Wynne Larson's model
        UPDATE `creature_template` SET `display_id1`=1483 WHERE `entry`=1309;
        -- Seoman Griffith, It appears that display_id 1517 is unused although it is Seoman's model
        UPDATE `creature_template` SET `display_id1`=1517 WHERE `entry`=1320;
        -- Elly Langston, It appears that display id 1521 is unused although it is Elly's model, she had warlock placeholder model for some reasons
        UPDATE `creature_template`SET `display_id1`=1521 WHERE `entry`=1328;
        -- Adair Gilfroy, He has same Display_id than 1.12
        UPDATE `creature_template` SET `display_id1`=1485 WHERE `entry`=1316;
        -- Bryan Cross, It appears that display_id 1510 is unused although it is Bryan's model
        UPDATE `creature_template` SET `display_id1`=1510 WHERE `entry`=1319;
        -- Jessara Cordell, It appears that display_id 1481 is unused although it is Jessara's model
        UPDATE `creature_template` SET `display_id1`=1481 WHERE `entry`=1318;
        
        -- Gaken the DarkBinder, by deduction there is a 95% chance that it is him, display 263 is warlock placeholder and this guy has no unique one yet
        -- We also already saw his model at same location https://ibb.co/kKw2Vrn
        UPDATE `creature_template` SET `display_id1`=263 WHERE `entry`=6122;
        -- Harlan Bagley, 95% chance that is him, his display id from 1.12 is a copy of old display id https://ibb.co/9T4sKhX
        UPDATE `creature_template` SET `display_id1`=19 WHERE `entry`=1427;
        -- Mazen Mac'Nadir, this guy a high mage and dont have unique model, his entry is very low, 90% sure it's mage placeholder
        UPDATE `creature_template` SET `display_id1`=198 WHERE `entry`=338;


        -- # SW NPC hide

        -- Stephanie Turner https://ibb.co/sFvw61t (Stephanie is not spawned on screenshot)
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=79680;
        -- Kelly Grant, we dispawned her sister but forgot to despawn her
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=90482;
        -- Hank the hammer, https://ibb.co/64Hr10P (Hank is not spawned)
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=43705;
        

        --#  SW NPC Spawn

        -- Riding Gryphon, near flymaster https://ibb.co/GVJ0ggq
        INSERT INTO `spawns_creatures` values(NULL, 541, 0, 0, 0, 0, 0, 0, -8844.82, 504.81, 109.609, 4.056, 300, 300, 0, 100, 0, 0, 0, 0, 0);
        INSERT INTO `spawns_creatures` values(NULL, 541, 0, 0, 0, 0, 0, 0, -8827, 484.63, 109.62, 3.766, 300, 300, 0, 100, 0, 0, 0, 0, 0);


        -- # SW NPC Spawn location Fix

        -- Guards near Jail https://ibb.co/X8LSqdt
        UPDATE `spawns_creatures` SET `position_y`=792.17,`position_z`=96.0788,`position_x`=-8838.84 WHERE `spawn_id`=19272;
        UPDATE `spawns_creatures` SET `position_y`=785.599,`position_z`=95.8423,`position_x`=-8833.54 WHERE `spawn_id`=79819;
        -- Jenn Langston https://ibb.co/sFvw61t (Jenn is in background)
        UPDATE `spawns_creatures` SET `position_x`=-8842.2,`position_y`=597.97,`position_z`=93.7,`orientation`=2.38 WHERE `spawn_id`=79746;
    

        -- # SW GameObjects location Fix
       
        -- This is left side gameobjects of SW Bank
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=626.274, `spawn_positionX`=-8908.71 WHERE `spawn_id`=26294;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=622.906,`spawn_positionX`=-8914.63 WHERE `spawn_id`=26295;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=620.87,`spawn_positionX`=-8918.31 WHERE `spawn_id`=26296;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=619.005,`spawn_positionX`=-8921.69 WHERE `spawn_id`=26310;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=615.636,`spawn_positionX`=-8927.79 WHERE `spawn_id`=26316;

        UPDATE `spawns_gameobjects` SET `spawn_positionY`=619.229,`spawn_positionX`=-8924.32 WHERE `spawn_id`=26305;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=618.096,`spawn_positionX`=-8926.74 WHERE `spawn_id`=26306;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=626.809,`spawn_positionX`=-8910.99 WHERE `spawn_id`=26307;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=625.519,`spawn_positionX`=-8913.54 WHERE `spawn_id`=26308;

        -- This is right side gameobjects of SW Bank
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8920.91,`spawn_positionY`=649.544 WHERE `spawn_id`=26670;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=645.323,`spawn_positionX`=-8924.35 WHERE `spawn_id`=26669;
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8921.88,`spawn_positionY`=646.693 WHERE `spawn_id`=26671;
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8927.12,`spawn_positionY`=646.016 WHERE `spawn_id`=26672;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=639.325,`spawn_positionX`=-8935.47 WHERE `spawn_id`=26682;
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8937.54,`spawn_positionY`=638.255 WHERE `spawn_id`=26681;
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8930.52,`spawn_positionY`=644.106 WHERE `spawn_id`=26668;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=642.105,`spawn_positionX`=-8934.08 WHERE `spawn_id`=26680;
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8940.23,`spawn_positionY`=638.654 WHERE `spawn_id`=26678;
        UPDATE `spawns_gameobjects` SET `spawn_positionY`=633.937,`spawn_positionX`=-8911.27 WHERE `spawn_id`=26298;
        UPDATE `spawns_gameobjects` SET `spawn_positionX`=-8916.1,`spawn_positionY`=642.515 WHERE `spawn_id`=26293;
        
        -- Flying chair in canal
        UPDATE `spawns_gameobjects` SET `spawn_positionZ`=96.7839 WHERE `spawn_id` IN (42809, 42810, 42811, 42812, 42852, 42923);


        -- # GameObjects Hide

        -- Flying Milk tank
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (42931, 42857);
        

        insert into applied_updates values('240820211');
    end if;
end $
delimiter ;
