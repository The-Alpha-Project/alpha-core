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

        update item_template set name = 'Thornroot' where entry = 2450;
        update gameobject_template set name = 'Thornroot' where entry in (1621, 3729);

        insert into applied_updates values ('210120211');
    end if;

    -- 28/01/2021 1
    if (select count(*) from applied_updates where id='280120211') = 0 then
        -- Remove Hillsbrad Human Skull from pickpocketing loot table.
        DELETE FROM `pickpocketing_loot_template` WHERE item = 3692;

        UPDATE `creature_template` SET `ai_name`='' WHERE  `entry` = 7109;
        UPDATE `creature_template` SET `ai_name`='' WHERE  `entry`=7111;

        -- Add missing spawns for "The Shade of Elura".
        -- Fix https://github.com/the-hyjal-project/bugtracker/issues/234
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`, `spawn_spawntimemin`, `spawn_spawntimemax`) VALUES (48873, 86492, 1, 6426.58, 790.671, -18.493, 5.77704, 0, 0, -0.25038, 0.968148, 1, 180, 180);
        UPDATE `spawns_gameobjects` SET `spawn_orientation`=5.34071, `spawn_rotation2`=-0.45399, `spawn_rotation3`=0.891007 WHERE `spawn_id`=48793;
        UPDATE `spawns_gameobjects` SET `spawn_orientation`=0.698131, `spawn_rotation2`=0.34202, `spawn_rotation3`=0.939693 WHERE `spawn_id`=48796;
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`, `spawn_spawntimemin`, `spawn_spawntimemax`) VALUES (48874, 86492, 1, 6316.11, 754.744, -12.9295, 0.820303, 0, 0, 0.398748, 0.91706, 1, 180, 180);
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`, `spawn_spawntimemin`, `spawn_spawntimemax`) VALUES (48875, 86492, 1, 6375.59, 871.36, -36.6744, 4.86947, 0, 0, -0.649447, 0.760406, 1, 180, 180);
        UPDATE `spawns_gameobjects` SET `spawn_orientation`=-2.30383, `spawn_rotation2`=-0.913545, `spawn_rotation3`=0.406738 WHERE `spawn_id`=48639;

        -- Quest "Supplies for the Crossroads" no longer require quest "Disrupt the Attacks" to pick up.
        -- Fix https://github.com/the-hyjal-project/bugtracker/issues/197
        UPDATE `quest_template` SET `PrevQuestId`= 0 WHERE `entry` = 5041;

        -- NPC "Whip Lashers" are now immune to nature spells.
        -- Fix https://github.com/the-hyjal-project/bugtracker/issues/187
        UPDATE `creature_template` SET `school_immune_mask` = 8 WHERE `entry` = 13022;

        -- Quest "Forsaken Diseases" is no longer available without completing the prerequisite quest "Kayneth Stillwind".
        -- Fix https://github.com/the-hyjal-project/bugtracker/issues/156
        UPDATE `quest_template` SET `PrevQuestId`= 4581 WHERE `entry` = 1011;

        -- Quest "Deeprun Rat Roundup" has fixed.
        -- Fix https://github.com/the-hyjal-project/bugtracker/issues/124
        UPDATE `creature_template` SET `faction`= 35 WHERE `entry` = 13017;

        -- Inferno shouldn't drop money
        UPDATE `creature_template` SET `gold_min` = 0, `gold_max` = 0 WHERE `entry` = 89;

        -- Fix Mage quest Report to Jennea #287
        REPLACE INTO `creature_questrelation` (`entry`, `quest`) VALUES
        (328, 1919);

        -- Fix The drop rate of Crawler Leg is too high #298
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -32 WHERE `entry` = 2165 AND `item` = 5414;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -18 WHERE `entry` = 6788 AND `item` = 5414;

        -- Fix The drop rate of Ancient Moonstone Seal is too high #297
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -34 WHERE `entry` = 2212 AND `item` = 5338;

        -- Fix The drop rate of Grell Earring is too high #296
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -42 WHERE `entry` = 2190 AND `item` = 5336;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -41 WHERE `entry` = 2189 AND `item` = 5336;

        -- Fix The drop rate of Bloodfeather Belt is too high #295
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -42 WHERE `entry` = 2015 AND `item` = 5204;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -40 WHERE `entry` = 2017 AND `item` = 5204;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -40 WHERE `entry` = 2018 AND `item` = 5204;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -36 WHERE `entry` = 2019 AND `item` = 5204;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -36 WHERE `entry` = 2020 AND `item` = 5204;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -34 WHERE `entry` = 2021 AND `item` = 5204;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -28 WHERE `entry` = 14431 AND `item` = 5204;

        -- Fix Stone drop rates from mining veins are too low #289
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 45 WHERE `entry` = 1502 AND `item` = 2835;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 67 WHERE `entry` = 1735 AND `item` = 2835;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 67 WHERE `entry` = 2626 AND `item` = 2835;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 1503 AND `item` = 2836;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 65 WHERE `entry` = 1736 AND `item` = 2836;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 66 WHERE `entry` = 2627 AND `item` = 2836;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 41 WHERE `entry` = 1503 AND `item` = 2836;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 1505 AND `item` = 2838;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 1742 AND `item` = 7912;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 13961 AND `item` = 7912;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 9597 AND `item` = 12365;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 13960 AND `item` = 12365;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 40 WHERE `entry` = 12883 AND `item` = 12365;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`= 39 WHERE `entry` = 17241 AND `item` = 12365;

        -- Fix Defias Cutpurse spawned on a tree.
        UPDATE `spawns_creatures` SET `position_x` = -9472.01, `position_z` = 52.971 WHERE `spawn_id` = 80377;

        -- remove lvl 50 scrolls from wendigos
        DELETE FROM `creature_loot_template` WHERE `entry`=1135 && `item`=10306 && `groupid`=0;
        DELETE FROM `creature_loot_template` WHERE `entry`=1135 && `item`=10308 && `groupid`=0;

        -- deviate lurkers shouldn't drop crisp spider meat
        DELETE FROM `creature_loot_template` WHERE  `entry`=3641 && `item`=1081 && `groupid`=0;

        -- deviate lurkers should drop Threshadon Fang
        REPLACE INTO `creature_loot_template` VALUES (3641, 5516, 19, 0, 1, 1, 0);

        -- defias cutpurse drop stacks of 3 inen instead of 2
        UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=94 && `item`=2589;

        -- defias bandit drops 4 linen instead of 2
        UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry`=116 && `item`=2589;

        -- riverpaw gnoll shouldn't drop wool
        DELETE FROM `creature_loot_template` WHERE `entry`=117 && `item`=2592 && `groupid`=0;

        -- slightly increased drop rate of linen for riverpaw gnoll
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=45 WHERE `entry`=117 && `item`=2589;

        -- remove all loot from stratholme phantoms
        DELETE FROM `creature_loot_template` WHERE entry = 10389;
        UPDATE `creature_template` SET `loot_id`=0 WHERE `entry`=10389;
        DELETE FROM `creature_loot_template` WHERE entry = 10388;
        UPDATE `creature_template` SET `loot_id`=0 WHERE `entry`=10388;

        -- Moonkins should not be skinnable.
        UPDATE `creature_template` SET `skinning_loot_id`=0 WHERE `entry` IN (2927, 2928, 2929, 8210, 10157, 10158, 10159, 10160);

        -- Move wolf stuck in statue in Ashenvale.
        UPDATE `spawns_creatures` SET `position_x`=2719.96, `position_y`=-99.9314, `position_z`=94.7723 WHERE `spawn_id`=34977;

        -- Correct Rep and XP for old version of Crown of the Earth.
        UPDATE `quest_template` SET `RewRepValue1`=75, `RewMoneyMaxLevel`=390 WHERE `entry`=934;

        -- Correct drop chance of Thresher Eye.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-40 WHERE `item`=5412 && `entry`=2185;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE `item`=5412 && `entry`=2187;

        -- Add second Onu is meditating quest to Onu.
        REPLACE INTO `creature_questrelation` (`entry`, `quest`) VALUES (3616, 960);
        REPLACE INTO `creature_involvedrelation` (`entry`, `quest`) VALUES (3616, 960);
        UPDATE `quest_template` SET `SpecialFlags`=1, `PrevQuestId`=944, `OfferRewardText`='I am meditating on your task, $N.  Meditating on reasons why the Twilight\'s Hammer and naga are here.$B$BWhen you are ready, use the phial of scrying to create a scrying bowl.  Then, contact me through the bowl.$B$BIf you have lost your phial of scrying, then here is another.' WHERE `entry`=960;

        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (17730, 'Silverpine Forest - Rot Hide Mystic', 3237, 100, 1, 0, 0, 0, 2, 12, 30, 45, 0, 332, 100, 15, 0, 0, 0, 14, 22, 14, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        UPDATE `creature_template` SET `spell_list_id`=17730 WHERE `entry`=1773;

        -- Lady Vespia should drop Ring of Zoram.
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (10559, 5445, -100, 0, 1, 1, 0);

        -- Correct drop chance for Pridewing Venom Sac.
        DELETE FROM `creature_loot_template` WHERE `item`=5808;
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (5928, 5808, -5, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (4011, 5808, -30, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (4012, 5808, -35, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (4013, 5808, -35, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (4014, 5808, -35, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (4015, 5808, -15, 0, 1, 1, 0);
        UPDATE `creature_template` SET `loot_id`=0 WHERE `entry`=6141;

        -- Quest Supplies for the Crossroads should require completing Disrupt the Attacks first.
        UPDATE `quest_template` SET `PrevQuestId`=871 WHERE `entry`=5041;

        -- Correct unit flags for White Kitten.
        UPDATE `creature_template` SET `unit_flags`=768 WHERE `entry`=7386;

        -- Remove custom version of following gameobjects:
        -- Quilboar Watering Hole, Spring Well, Ruins of Stardust Fountain
        DELETE FROM `gameobject_template` WHERE `entry` IN (300146, 300147, 300148);
        DELETE FROM `spawns_gameobjects` WHERE `spawn_entry` IN (300146, 300147, 300148);
        REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `script_name`) VALUES (107045, 8, 299, 'Spring Well', 1, 226, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
        REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `script_name`) VALUES (107046, 8, 299, 'Quilboar Watering Hole', 1, 224, 25, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
        REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `script_name`) VALUES (107047, 8, 299, 'Ruins of Stardust Fountain', 1, 223, 5, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`) VALUES (99863, 107045, 0, -43.4367, -923.198, 55.8714, 5.75401, 0, 0, 0.261511, -0.9652, 1);
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`) VALUES (99864, 107046, 1, -3573.24, -1864.45, 82.4975, 4.13904, 0, 0, 0.878194, -0.478305, 1);
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`) VALUES (99862, 107047, 1, 2079.39, -234.624, 98.9194, 6.04, 0, 0, 0.121293, -0.992617, 1);

        -- Correct drop chances for Magic Dust.
        DELETE FROM `creature_loot_template` WHERE `item`=2091;
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (99, 2091, 2, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (5809, 2091, 2, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (1936, 2091, 5, 0, 1, 1, 0);
        REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES (832, 2091, 15, 0, 1, 1, 0);

        -- Correct drop chance for Highborne Relic.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-40 WHERE `item`=5360;

        -- Correct drop chance for Fine Crab Chunks.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-40 WHERE `item`=12237;

        -- Correct drop chance for Worn Parchment.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-45 WHERE `item`=5348;

        -- Correct drop chance for Top of Gelkak's Key.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-20 WHERE `item`=7498;

        -- Correct drop chance for Middle of Gelkak's Key.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-10 WHERE `item`=7499 && `entry` IN (2208, 2207);
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-1 WHERE `item`=7499 && `entry` NOT IN (2208, 2207);

        -- Correct drop chance for Bottom of Gelkak's Key.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-20 WHERE `item`=7500 && `entry`=2236;
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-5 WHERE `item`=7500 && `entry`=2233;

        -- Correct drop chance for Fine Moonstalker Pelt.
        UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-40 WHERE `item`=5386;

        insert into applied_updates values ('280120211');
    end if;

end $
delimiter ;