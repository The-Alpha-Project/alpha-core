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
        -- Summoning Portal display fix.
        UPDATE `gameobject_template` SET `displayId` = 672 WHERE `entry` = 36727;

        insert into applied_updates values ('240820211');
    end if;

    -- 24/08/2021 2
    if (select count(*) from applied_updates where id='240820212') = 0 then
        -- # SW NPC Display Fix

        -- Riding Gryphon
        UPDATE `creature_template` SET `display_id1`=1149 WHERE `entry`=541;

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

        -- Harlan Bagley, 95% chance that is him, his display id from 1.12 is a copy of old display id https://ibb.co/9T4sKhX
        UPDATE `creature_template` SET `display_id1`=19 WHERE `entry`=1427;
        -- Mazen Mac'Nadir, this guy a high mage and doesn't have unique model, his entry is very low, 90% sure it's mage placeholder
        UPDATE `creature_template` SET `display_id1`=198 WHERE `entry`=338;


        -- # SW NPC hide

        -- Stephanie Turner https://ibb.co/sFvw61t (Stephanie is not spawned on screenshot)
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=79680;
        -- Kelly Grant, we dispawned her sister but forgot to despawn her
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=90482;
        -- Hank the hammer, https://ibb.co/64Hr10P (Hank is not spawned)
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=43705;
        -- Gaken the Darkbinder, entry too high and missing model.
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=90471;


        --#  SW NPC Spawn

        -- Riding Gryphon, near flight master https://ibb.co/GVJ0ggq
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


        insert into applied_updates values('240820212');
    end if;

    -- 27/08/2021 1
    if (select count(*) from applied_updates where id='270820211') = 0 then
        -- Delete Small Shield that was added later in game and use the old, proper one.
        UPDATE `npc_vendor` SET `item` = 2133 WHERE `item` = 17184;
        DELETE FROM `item_template` WHERE `entry` = 17184;

        insert into applied_updates values ('270820211');
    end if;

    -- 28/08/2021 1
    if (select count(*) from applied_updates where id='280820211') = 0 then
        -- # Fix default buttons for new characters

        -- Dwarf Racial not in game (stoneform)
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 20594;

        -- Orc Racial not in game
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 20572;

        -- Undead Racial not in game
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 20577;

        -- Elf Racial not in game
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 20580;

        -- Tauren Racial not in game
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 20549;

        -- Troll Racial not in game
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 26296;

        -- Paladin's seal not in game
        DELETE FROM `playercreateinfo_action`
        WHERE `action`= 21084;

        -- we replace button index of Holy Light for paladins all race (cause we deleted seal)
        UPDATE `playercreateinfo_action`
        SET `button`=1 WHERE `action`=635;

        -- we decrease by 1 'Find treasure' index for dwarf paladins (cause we moved holy light)
        UPDATE `playercreateinfo_action`
        SET `button`=button-1
        WHERE `action`=2481 AND `race`=3 AND `class`=2;

        -- Dwarf mage was not in 1.12, so we create buttons
        INSERT INTO `playercreateinfo_action`
        VALUES  (1,	3,	8,	0,	6603,	0), -- attack
                (1,	3,	8,	1,	133,	0), -- fireball
                (1,	3,	8,	2,	168,	0), -- frost armor
                (1,	3,	8,	10,	159,	128), -- food
                (1,	3,	8,	11,	4540,	128); -- drink

        ALTER TABLE `playercreateinfo_action` CHANGE COLUMN `action` `action` int(11) NOT NULL DEFAULT 0;
        UPDATE `playercreateinfo_action` SET `action` = `action` * -1 WHERE `type` = 128;
        UPDATE `playercreateinfo_action` SET `type` = 255 WHERE `type` = 128;

        insert into applied_updates values ('280820211');
    end if;

    -- 29/08/2021 1
    if (select count(*) from applied_updates where id='290820211') = 0 then

        -- # NPC DISPLAY FIX

        -- Grand Admiral Jes-Tereth https://ibb.co/XyvCj5C
        UPDATE `creature_template` SET `display_id1`=224, `level_min`=90, `level_max`=90 WHERE `entry`=1750;

        -- Mithras Ironhill https://ibb.co/bjVCWfj
        UPDATE `creature_template` SET `display_id1`=832, `level_min`=90, `level_max`=90 WHERE `entry`=1751;

        -- Argos Nightwhisper, the only unused night elf male model is 2192, but it's not a 100% proof
        UPDATE `creature_template` SET `display_id1`=2192 WHERE `entry`=4984;


        -- # NPC SPAWN FIX

        -- Larimaine Purdue, portal trainer https://ibb.co/5rHtY4w
        UPDATE `spawns_creatures` SET `position_z`=148.618,`position_x`=-9000.5,`position_y`=872.164,`orientation`=3.239 WHERE `spawn_id`=90441;

        -- Elsharin, mage trainer https://ibb.co/nBTt9GT
        UPDATE `spawns_creatures` SET `position_z`=148.61,`position_x`=-9010.84,`position_y`=880.065,`orientation`=4.158 WHERE `spawn_id`=90463;

        -- Tannysa Tailoring Trainer https://ibb.co/yQdwJBL
        UPDATE `spawns_creatures` SET `position_z`=104.946,`position_x`=-8776.7,`position_y`=1005.04,`orientation`=5.811 WHERE `spawn_id`=79825;
        UPDATE `creature_template` SET `subname`="Tailoring Trainer" WHERE `entry`=5566;

        -- Celmoridan Trainer https://ibb.co/41n7Z4H
        INSERT INTO `spawns_creatures` values(NULL, 5507, 0, 0, 0, 0, 0, 0, -8788.12, 1119.264, 90.75, 2.797, 300, 300, 0, 100, 0, 0, 0, 0, 0);
        UPDATE `creature_template` SET `level_min`=35, `level_max`=35 WHERE `entry`=5507;

        -- Strumner Flintheel Trainer https://ibb.co/pzpckG8
        UPDATE `spawns_creatures` SET `position_y`=645.884,`position_z`=95.129,`orientation`=0.027,`position_x`=-8398.23 WHERE `spawn_id`=2701;


        -- # NPC HIDE NOT PRESENTS IN 0.5.3 (set one by one to be more readable)

        -- ################################################
        -- #  The highest entry I have seen in Stormwind  #
        -- #    on an NPC probably present in 0.5.3 is    #
        -- #                  [ 5566 ]                    #
        -- #           (with unique display id)           #
        -- #  So all that is above entry must be despawn  #
        -- ################################################

        -- Shailiea entry 7295
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=90477;
        -- Brother Sarno entry 7917
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=44022;
        -- Duthorian Rail entry 6171
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=39536;
        -- Gazin Tenorm entry 6173
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=39538;
        -- Shoni the shilent 6579
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=41677;
        -- Borgus Steelhand 7232
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=42580;
        -- Tyrion 7766
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=43667;
        -- Tyrion's Spybot 8856
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=45707;
        -- Priestess Tyriona 7779
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=43690;
        -- Bartleby 6090 
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=79750;
        -- Harry Burlguard 6089
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=79773;
        -- High Sorcerer Andromath 5694, we can see on mage trainer screenshot, he is despawned
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_id`=90470;

        -- # GAMEOBJECTS HIDE
        -- Those chairs are not part of 0.5.3
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (26470, 26471, 26472, 26472, 26473, 26474, 26475, 26476, 26477, 26478);
        -- Those chairs in Wizard's Sanctum are not part of 0.5.3
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (42890, 42891, 42892, 42893, 42896);

        insert into applied_updates values('290820211');
    end if;

    -- 29/08/2021 2
    if (select count(*) from applied_updates where id='290820212') = 0 then
        -- Fixes for Stormwind pet trainers.
        update creature_template set faction = 11, health_min = 992, health_max = 992, mana_max = 992, mana_min = 992, armor = 751, dmg_min = 92, dmg_max = 109, attack_power = 138, base_attack_time = 2000, ranged_attack_time = 2000, ranged_dmg_min = 53.8384, ranged_dmg_max = 74.0278, ranged_attack_power = 100 where entry = 5507;
        update creature_template set trainer_type = 3, npc_flags = 8 where entry in (5507, 5508);
        delete from npc_vendor where entry = 5508;

        insert into applied_updates values ('290820212');
    end if;

    -- 09/09/2021 1
    if (select count(*) from applied_updates where id='090920211') = 0 then

        -- ## FIX FOR DARNASSUS

            -- They're no rogue/hunter dedicated houses in 0.5.3,
            -- and it seems there is a 'generic house' as placeholder.
            -- Bank is not created in 0.5.3 and NPC are probably at Auctioneer's house 
            -- There are no shop signs with dispay_id, not even the pillar to hang them
            -- All wisp and frostsaber missed display_id but models are presents in gamefile


                                -- ## GAMEOBJECTS ##

        -- shop big signs, moonwell, books, not part of 0.5.3
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (49708, 49692, 49704, 49619, 49694, 49709, 49710, 49712, 49702, 48530, 49818, 49527, 49530, 49703, 49713, 49693, 49696, 49802, 49714, 49698, 49701, 49521, 49522, 49715, 49716,49524, 49724,49730, 49732, 49728, 49729, 49731, 49726, 49727, 49705, 49707, 49806, 49738, 49831, 49801, 49723, 49523, 49717, 49720, 3996165, 3996168, 3996167);



                                -- ## NPC ##
             -- DISPLAY ID     

        -- Fandral display_id, dont know why Fandral has default 1541 (human Thomas Miller), correct display_id is 1542
        UPDATE `creature_template` SET `display_id1`=1542 WHERE `entry`=3516;

        -- We fix missing display_id of all Wisp
        UPDATE `creature_template` SET `display_id1`=1825 WHERE `entry`=3681;

        -- We fix missing display_id of all frostsaber
        UPDATE `creature_template` SET `display_id1`=616 WHERE `entry`=4242;


            -- IGNORED

        -- Entries are too high to be part of 0.5.3 (6000+)
        UPDATE `spawns_creatures` SET `ignored`=1 WHERE `spawn_entry1` IN (7555, 7553, 8665, 11709, 8026, 11050, 11070, 6735, 11083, 11042, 11081, 6392, 10089, 9047, 7322, 12359, 12360, 12358, 10322, 11866, 6142, 7315, 6292, 6034, 10878, 8723, 8669, 8396, 7740, 11401, 7999, 7313, 7316);


            -- SPAWN FIX

        -- Turian
        UPDATE spawns_creatures
            SET position_x=99772.41,position_y=2277.3,position_z=1339.65
            WHERE spawn_id=46571;

        -- Mathrengyl
        UPDATE spawns_creatures
	        SET position_y=2584.61,position_x=10171.7,position_z=1336.15
            WHERE spawn_id=46472;

        -- Cyroen
        UPDATE spawns_creatures
            SET position_y=2600.7,position_x=10165.8,position_z=1322.06
            WHERE spawn_id=46477;

        -- Fylerian
        UPDATE spawns_creatures
            SET position_z=1322.06,position_x=10173.5,position_y=2605.33
            WHERE spawn_id=46475;

        -- Denatharion
        UPDATE spawns_creatures
            SET position_z=1322.06,position_y=2592.89,position_x=10181.7
            WHERE spawn_id=46474;

        -- Syurna
        UPDATE spawns_creatures
            SET position_z=1337.48,orientation=4.236,position_x=10337.6,position_y=2472.08
            WHERE spawn_id=46312;

        -- Anishar
        UPDATE spawns_creatures
            SET position_z=1337.48,orientation=2.572,position_x=10337.7,position_y=2463.34
            WHERE spawn_id=46470;

        -- Anishar
        UPDATE spawns_creatures
            SET position_z=1337.48,orientation=5.768,position_x=10330.1,position_y=2467.15
            WHERE spawn_id=46469;

        -- Faelyssa
        UPDATE spawns_creatures
            SET position_z=1337.48,orientation=5.741,position_y=2450.86,position_x=10329.5
            WHERE spawn_id=49540;
        
        -- Kyrai
        UPDATE spawns_creatures
            SET position_x=10324.4,position_y=2457.49,orientation=5.694,position_z=1337.48
            WHERE spawn_id=49519;

        -- Dorion
        UPDATE spawns_creatures
            SET position_x=10299.8,orientation=2.515,position_z=1337.48,position_y=2401.78
            WHERE spawn_id=46415;

        -- Dorion's pet
        UPDATE spawns_creatures
            SET position_z=1337.48,orientation=2.498,position_y=2399.63,position_x=10298.5
            WHERE spawn_id=46814;

        -- Jeen'ra
        UPDATE spawns_creatures
            SET position_x=10291.4,orientation=0.971,position_z=1337.48,position_y=2396.58
            WHERE spawn_id=46217;

        -- Jeen ra's pet
        UPDATE spawns_creatures
            SET orientation=0.923,position_y=2397.79,position_x=10289.9,position_z=1337.48
            WHERE spawn_id=46811;
        
        -- Jocaste
        UPDATE spawns_creatures
            SET position_y=2406.3,orientation=5.703,position_z=1337.48,position_x=10292.6
            WHERE spawn_id=46221;

        -- Lelanai
        UPDATE spawns_creatures
            SET position_y=2537.89,position_z=1317.64,position_x=10121.5
            WHERE spawn_id=46473;

        -- Banker1
        UPDATE spawns_creatures
            SET position_x=9862.16,position_z=1321.57,orientation=4.407,position_y=2349.02
            WHERE spawn_id=46223;

        -- Banker2
        UPDATE spawns_creatures
            SET position_y=2346.53,position_x=9867.09,position_z=1321.57
            WHERE spawn_id=46418;

        -- Banker3
        UPDATE spawns_creatures
            SET position_x=9872.34,position_z=1321.57,position_y=2343.87
            WHERE spawn_id=46417;

        -- Guard Bank 1
        UPDATE spawns_creatures
            SET position_z=1321.58,position_x=9865.91,orientation=4.057,position_y=2326.78
            WHERE spawn_id=46883;

        -- Guard Bank 1
        UPDATE spawns_creatures
            SET position_z=1321.58,position_x=9852.49,orientation=4.057,position_y=2333.18
            WHERE spawn_id=46841;

        -- Fandral
        UPDATE spawns_creatures
            SET position_x=10169.7,position_y=2589.6,orientation=0.95,position_z=1363.03
            WHERE spawn_id=46903;

        -- Deer
        UPDATE spawns_creatures
            SET position_x=9974.01,position_y=2615.73,position_z=1317.36
            WHERE spawn_id=46443;


            -- SPAWN CREATION

        -- Binder
        INSERT INTO spawns_creatures
            VALUES(NULL, 4340, 0, 0, 0, 1, 0, 0, 9940.15, 2206.46, 1328.96, 5.911, 300, 300, 0, 100, 100, 0, 0, 0, 0);

        


        -- ## FIX FOR IRONFORGE

        -- We remove 2 braziers inside wall, that cause render bug at ironforge entrance
        UPDATE spawns_gameobjects
            SET ignored=1
            WHERE spawn_id IN (926, 949);

        -- Furnace SPAWN FIX
        UPDATE spawns_gameobjects 
            SET spawn_positionY=-1154.69,spawn_positionZ=499.40,spawn_positionX=-4773.8,spawn_orientation=3.671,spawn_rotation2=0.0,spawn_rotation3=0.0, ignored=0
            WHERE spawn_id=5319;

        -- We fix big shop signs (no more missing ?)

        -- Leather Goods
        UPDATE spawns_gameobjects
            SET spawn_positionY=-1204.141,spawn_positionZ=512.0,spawn_positionX=-4944.898,spawn_orientation=3.9
            WHERE spawn_id=6888;

        -- Fighting Wizard
        UPDATE spawns_gameobjects
            SET spawn_positionZ=525.0,spawn_positionY=-900.203,spawn_orientation=0.95,spawn_positionX=-4673.338
            WHERE spawn_id=2076;

        -- Craghelm's plate
        UPDATE spawns_gameobjects
            SET spawn_positionZ=526.0
            WHERE spawn_id=707;

        -- Timberline weapon
        UPDATE spawns_gameobjects
            SET spawn_positionZ=523.0
            WHERE spawn_id=621;

        -- Bruuk
        UPDATE spawns_gameobjects
            SET spawn_positionZ=524.0
            WHERE spawn_id=547;

        -- Goldfury supplies
        UPDATE spawns_gameobjects
            SET spawn_positionZ=524.0
            WHERE spawn_id=26;

        -- Ironforge Physician
        UPDATE spawns_gameobjects
            SET spawn_rotation2=0.0,spawn_rotation3=0.0,spawn_positionZ=512.661,spawn_positionX=-4904.942,spawn_positionY=-1259.135,spawn_orientation=1.18
            WHERE spawn_id=5469;

        -- Steelfury weapons
        UPDATE spawns_gameobjects
            SET spawn_positionY=-999.214,spawn_positionZ=494.0,spawn_rotation3=0.0,spawn_positionX=-4913.06,spawn_rotation2=0.0,spawn_orientation=5.58
            WHERE spawn_id=860;

        insert into applied_updates values ('090920211');
    end if;

    -- 12/09/2021 1
    if (select count(*) from applied_updates where id='120920211') = 0 then
        -- Dalaran Shield Guard non existent model.
        update creature_template set display_id2 = 0 where entry = 2271;

        insert into applied_updates values ('120920211');
    end if;

    -- 20/09/2021 1
    if (select count(*) from applied_updates where id='200920211') = 0 then

        -- IRONFORGE IMPROVEMENTS based on Davir's Screenshots 
        -- TODO : We only need to correcly spawn guards and resolve latest display_id

        -- \ / Please Grender, check those 4 creatures creation, I provide some random infos \ /
        --  v                                                                                 v

        INSERT INTO creature_template
        VALUES(5134, 3061, 0, 0, 0, "Jonivera Farmountain", "Cartography trainer", 0, 55, 55, 2940, 2940, 0, 0, 2000, 11, 
        10, 1, 1.143, 0, 18, 5, 0, 0, 1, 78, 156, 0, 200, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, "EventAI", 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, "");

        INSERT INTO creature_template
        VALUES(5135, 3083, 0, 0, 0, "Svalbrad Farmountain", "Cartography supplier", 0, 55, 55, 2940, 2940, 0, 0, 2000, 11, 
        10, 1, 1.143, 0, 18, 5, 0, 0, 1, 78, 156, 0, 200, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, "EventAI", 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, "");

        INSERT INTO creature_template
        VALUES(5139, 3084, 0, 0, 0, "Kurdrum Barleybeard", "Bartender", 0, 50, 50, 1110, 1110, 0, 0, 2000, 11, 
        10, 1, 1.143, 0, 18, 5, 0, 0, 1, 78, 156, 0, 200, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, "EventAI", 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, "");

        INSERT INTO creature_template
        VALUES(5118, 3074, 0, 0, 0, "Brogun Stoneshield", "Boar trainer", 0, 35, 35, 1420, 1420, 0, 0, 2000, 11, 
        10, 1, 1.143, 0, 18, 5, 0, 0, 1, 78, 156, 0, 200, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, "EventAI", 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, "");


        -- IGNORED spawns_creatures 1796
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=1796;

        UPDATE gameobject_template
            SET name='Ironforge Physician'
            WHERE entry=171770;

        -- FIX spawns_creatures 2015
        UPDATE spawns_creatures SET 
        position_x=-4714.19873046875,
        position_y=-952.3878784179688,
        position_z=511.9549865722656,
        orientation=4.13355016708374
        WHERE spawn_id=2015;

        -- IGNORED spawns_creatures 1763
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=1763;

        -- FIX spawns_creatures 94
        UPDATE spawns_creatures SET 
        position_x=-4938.8525390625,
        position_y=-1179.39013671875,
        position_z=503.890869140625,
        orientation=5.294369697570801
        WHERE spawn_id=94;

        UPDATE gameobject_template
            SET name='Stonebranch Herbalist'
            WHERE entry=143336;

        UPDATE gameobject_template
            SET name="Pithwick's Bags & Suppliers"
            WHERE entry=150087;

        UPDATE spawns_creatures
            SET position_x=-4702.78,orientation=3.964,position_z=505.27,position_y=-1172.28
            WHERE spawn_id=1761;

        UPDATE spawns_creatures
            SET orientation=3.297,position_y=-1208.37,position_x=-4798.53,position_z=495.9
            WHERE spawn_id=40;

        -- FIX spawns_creatures 1784
        UPDATE spawns_creatures SET 
        position_x=-4736.2177734375,
        position_y=-1116.749755859375,
        position_z=492.8209533691406,
        orientation=4.369928359985352
        WHERE spawn_id=1784;

        UPDATE spawns_creatures
            SET position_z=449.043,position_x=-4595.74,orientation=3.65,position_y=-1081.3
            WHERE spawn_id=2006;

        -- FIX spawns_creatures 1890
        UPDATE spawns_creatures SET 
        position_x=-4606.87255859375,
        position_y=-1091.2987060546875,
        position_z=449.0431823730469,
        orientation=0.669914722442627
        WHERE spawn_id=1890;

        -- FIX spawns_creatures 1805
        UPDATE spawns_creatures SET 
        position_x=-4701.7197265625,
        position_y=-1016.9811401367188,
        position_z=492.4388732910156,
        orientation=5.060286521911621
        WHERE spawn_id=1805;

        -- CREATE spawns_creatures 5105
        INSERT INTO spawns_creatures VALUES (NULL, 5105, 0, 0, 0, 0, 0, 0, -4845.44189453125, -1003.7757568359375, 494.4190673828125, 3.5146117210388184, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- FIX spawns_creatures 1755
        UPDATE spawns_creatures SET 
        position_x=-4874.59423828125,
        position_y=-1022.3235473632812,
        position_z=492.7527160644531,
        orientation=0.563086748123169
        WHERE spawn_id=1755;

        -- FIX spawns_creatures 1751
        UPDATE spawns_creatures SET 
        position_x=-4868.86572265625,
        position_y=-1015.4052734375,
        position_z=492.7527160644531,
        orientation=3.7887156009674072
        WHERE spawn_id=1751;

        UPDATE spawns_gameobjects
            SET spawn_rotation3=0.0,spawn_rotation2=0.0,spawn_positionZ=496.5,spawn_positionX=-4822.56
            WHERE spawn_id=1499;
            
        -- CREATE spawns_creatures 5104
        INSERT INTO spawns_creatures VALUES (NULL, 5104, 0, 0, 0, 0, 0, 0, -4883.3349609375, -952.1742553710938, 495.8304443359375, 3.6072885990142822, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_gameobjects 26485
        INSERT INTO spawns_gameobjects VALUES (NULL, 26485, 0, -4871.12646484375, -962.2207641601562, 492.2113342285156, 2.083615303039551, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_gameobjects 3998707
        UPDATE spawns_gameobjects SET 
        spawn_positionX=-4869.72900390625,
        spawn_positionY=-962.9651489257812,
        spawn_positionZ=496.2059326171875,
        spawn_orientation=5.5197343826293945
        WHERE spawn_id=3998707;

        -- CREATE spawns_gameobjects 26492
        INSERT INTO spawns_gameobjects VALUES (NULL, 26492, 0, -4826.89306640625, -1286.3348388671875, 501.64111328125, 1.6846309900283813, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_gameobjects 3998708
        UPDATE spawns_gameobjects SET 
        spawn_positionX=-4826.91650390625,
        spawn_positionY=-1284.3597412109375,
        spawn_positionZ=504.6433410644531,
        spawn_orientation=1.5393320322036743
        WHERE spawn_id=3998708;

        -- CREATE spawns_creatures 5134
        INSERT INTO spawns_creatures VALUES (NULL, 5134, 0, 0, 0, 0, 0, 0, -4822.9873046875, -1300.498291015625, 502.1949157714844, 4.77596378326416, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 5135
        INSERT INTO spawns_creatures VALUES (NULL, 5135, 0, 0, 0, 0, 0, 0, -4818.23095703125, -1297.5941162109375, 502.1949157714844, 0.017237097024917603, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 5139
        INSERT INTO spawns_creatures VALUES (NULL, 5139, 0, 0, 0, 0, 0, 0, -4961.50634765625, -1284.79345703125, 520.1649169921875, 0.9997727274894714, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 5118
        INSERT INTO spawns_creatures VALUES (NULL, 5118, 0, 0, 0, 0, 0, 0, -5015.90087890625, -1278.3310546875, 525.9461059570312, 2.190439462661743, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_gameobjects 143332
        INSERT INTO spawns_gameobjects VALUES (NULL, 143332, 0, -4885.02587890625, -1012.2951049804688, 492.1971740722656, 2.2909514904022217, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_gameobjects 3998709
        UPDATE spawns_gameobjects SET 
        spawn_positionX=-4872.33837890625,
        spawn_positionY=-1003.2520141601562,
        spawn_positionZ=495.1971740722656,
        spawn_orientation=2.3035149574279785
        WHERE spawn_id=3998709;

        -- FIX spawns_gameobjects 860
        UPDATE spawns_gameobjects SET 
        spawn_positionX=-4913.06,
        spawn_positionY=-999.214,
        spawn_positionZ=495.0,
        spawn_orientation=5.58
        WHERE spawn_id=860;

        -- FIX spawns_gameobjects 3998656
        UPDATE spawns_gameobjects SET 
        spawn_positionX=-4826.677734375,
        spawn_positionY=-1284.7989501953125,
        spawn_positionZ=505.6428527832031,
        spawn_orientation=1.5258102207183838
        WHERE spawn_id=3998656;

        insert into applied_updates values ('200920211');
    end if;

end $
delimiter ;
