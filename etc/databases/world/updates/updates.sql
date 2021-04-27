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

        DELETE FROM `spawns_gameobjects` WHERE `spawn_entry` IN (23299, 23300, 23301, 24715, 24717, 24718, 24719, 24720, 24721, 25341, 25342, 25352, 25353, 25354);
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_state`, `spawn_spawntimemin`, `spawn_spawntimemax`) VALUES
        (42861, 23299, 0, -8707.29, 909.091, 102.03, 0.680677, 0, 0, 0.333806, 0.942642, 1, 120, 120),
        (42860, 23300, 0, -8897.94, 909.434, 110.7, 5.20108, 0, 0, -0.515037, 0.857168, 1, 120, 120),
        (42862, 23301, 0, -8808, 938.986, 101.841, 5.37562, 0, 0, -0.43837, 0.898795, 1, 120, 120),
        (42936, 24715, 0, -8873.65, 754.266, 96.4673, 5.46288, 0, 0, -0.398749, 0.91706, 1, 120, 120),
        (26643, 24717, 0, -8713.17, 725.943, 97.0882, 0.689404, 0, 0, 0.337916, 0.941176, 1, 120, 120),
        (42866, 24718, 0, -8706.59, 867.789, 96.7633, 0.689404, 0, 0, 0.337916, 0.941176, 1, 120, 120),
        (42867, 24719, 0, -8727.88, 894.59, 100.563, 0.689404, 0, 0, 0.337916, 0.941176, 1, 120, 120),
        (42868, 24720, 0, -8825.22, 959.159, 99.847, 5.4018, 0, 0, -0.426568, 0.904455, 1, 120, 120),
        (26610, 24721, 0, -8843.1, 924.154, 101.783, 5.20981, 0, 0, -0.511293, 0.859407, 1, 120, 120),
        (42874, 25341, 0, -8806.95, 956.342, 112.986, 3.81354, 0, 0, -0.944089, 0.329691, 1, 120, 120),
        (42873, 25342, 0, -8703.75, 904.834, 108.535, 5.38434, 0, 0, -0.434444, 0.900699, 1, 120, 120),
        (42872, 25352, 0, -8704.11, 926.336, 113.227, 5.38434, 0, 0, -0.434444, 0.900699, 1, 120, 120),
        (42876, 25353, 0, -8812.22, 935.571, 108.294, 3.81354, 0, 0, -0.944089, 0.329691, 1, 120, 120),
        (42875, 25354, 0, -8790.71, 935.927, 112.986, 3.81354, 0, 0, -0.944089, 0.329691, 1, 120, 120);

        insert into applied_updates values ('020420211');
    end if;

    -- 14/04/2021 1
    if (select count(*) from applied_updates where id='140420211') = 0 then
        update quest_template set Details = 'I hope you strapped your belt on tight, young $c, because there is work to do here in Northshire.$B$BAnd I don''t mean farming.$B$BThe Stormwind guards are hard pressed to keep the peace here, with so many of us in distant lands and so many threats pressing close.  And so we''re enlisting the aid of anyone willing to defend their home.  And their alliance.$B$BIf you''re here to answer the call, then speak with my superior, Marshal McBride.  He''s inside the abbey behind me.' where entry = 783;

        insert into applied_updates values ('140420211');
    end if;

    -- 23/04/2021 1
    if (select count(*) from applied_updates where id='230420211') = 0 then
        UPDATE `spawns_creatures` SET `position_x` = -9290.27, `position_y` = -2941.76, `position_z` = 128.802, `movement_type` = 2 WHERE `spawn_id` = 25449;
        UPDATE `spawns_creatures` SET `position_x` = -9291.14, `position_y` = -2991.8, `position_z` = 121.398, `orientation` = 5.74213, `movement_type` = 0, `wander_distance` = 0 WHERE `spawn_id` = 18396;
        UPDATE `spawns_creatures` SET `position_x` = -9272.69, `position_y` = -2948.96, `position_z` = 128.702, `movement_type` = 2 WHERE `spawn_id` = 26171;
        DELETE FROM `spawns_creatures` WHERE `spawn_id` IN (31824, 18377, 18394, 18389);
        UPDATE `spawns_creatures` SET `position_x` = -9390.57, `position_y` = -3026.71, `position_z` = 137.051, `movement_type` = 2 WHERE `spawn_id` = 18434;
        UPDATE `spawns_creatures` SET `position_x` = -9340.59, `position_y` = -3043.07, `position_z` = 136.224 WHERE `spawn_id` = 26167;
        UPDATE `spawns_creatures` SET `position_x` = -9347.26, `position_y` = -3012.09, `position_z` = 136.79 WHERE `spawn_id` = 18379;
        UPDATE `spawns_creatures` SET `position_x` = -9439.3, `position_y` = -3080.77, `position_z` = 136.72, `movement_type` = 2 WHERE `spawn_id` = 18397;
        REPLACE INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `health_percent`, `mana_percent`) VALUES
        (31824, 436, -9435.27, -3078.54, 136.72, 2.3911, 900, 900, 100, 100),
        (18377, 4065, -9440.13, -3073.22, 136.72, 5.02655, 900, 900, 100, 0),
        (18394, 4462, -9441.58, -3077.65, 136.72, 0.436332, 900, 900, 100, 0);
        UPDATE `spawns_creatures` SET `position_x` = -9421.56, `position_y` = -3059.08, `position_z` = 136.809, `movement_type` = 2, `wander_distance` = 0 WHERE `spawn_id` = 31829;
        UPDATE `spawns_creatures` SET `position_x` = -9467.47, `position_y` = -2986.67, `position_z` = 130.932 WHERE `spawn_id` = 31823;
        UPDATE `spawns_creatures` SET `position_x` = -9524.7, `position_y` = -2876.99, `position_z` = 93.2134, `movement_type` = 2, `wander_distance` = 0 WHERE `spawn_id` = 17972;
        UPDATE `spawns_creatures` SET `position_x` = -9219.22, `position_y` = -2919.18, `position_z` = 112.948, `movement_type` = 2, `wander_distance` = 0 WHERE `spawn_id` = 10214;
        UPDATE `spawns_creatures` SET `wander_distance` = 0 WHERE `spawn_id` IN (31824, 18377, 18394);

        -- [Silver Piffeny Band] shouldn't appear in chests.
        DELETE FROM `gameobject_loot_template` WHERE `item` = 7342;

        UPDATE `quest_template` SET `StartScript` = 0 WHERE `entry` = 252;

        DELETE FROM `page_text` WHERE `entry` IN (219, 220, 221);
        INSERT INTO `page_text` VALUES
        (219,'From the hand of Baros Alexston, Office of the City Architect Stormwind Your Majesty, There are many reasons as to why I felt that a report should be compiled and presented on the recent affairs of the \"Defias Brotherhood\" and their activities throughout the kingdom. For perspective, I shall begin with a bit of history. As you may or may not know, my service to the city of Stormwind began as a member of the Stonemasons\' Guild. Through years of work, we completed the rebuilding of',220),
        (220,'Stormwind, at which time the Stonemasons\' Guild bills and fees and salaries left unpaid and unspoken for. At that time, Edwin VanCleef had been elected Guildmaster of the Stonemasons, and spoke out, demanding restitution for our works. In response, the Stormwind House of Nobles ordered the Stonemasons\' Guild disbanded, which, understandably, angered VanCleef. Leading a riot, VanCleef led the Stonemasons out of the city. Before I continue, there are some other events that took place during',221),
        (221,'this time that I should bring to your attention. First, it was at this time that I was offered the position of city architect if I did not join with VanCleef. Because of certain idealogical differences, I chose to remain in Stormwind. During the riots, VanCleef\'s lieutenant and most trusted assistant, Bazil Thredd, was captured and held in prison. Awaiting trial and questioning, Thredd was almost forgotten about in the Stockade. Returning to VanCleef, after he led the remnants of the',222);

        UPDATE `creature_template` SET `inhabit_type` = 4 WHERE `entry` = 8446;

        -- Shadowforge Commander shouldn't drop Blue Pearls (it was obviously an error since the Giant Clam gameobject has the
        -- same entry as this NPC).
        DELETE FROM `creature_loot_template` WHERE `item` = 4611 AND `entry` = 2744;

        -- Fix loot template of Giant Clam gameobject
        -- https://www.youtube.com/watch?v=iujWLpMG2s4
        -- https://classic.wowhead.com/object=2744/giant-clam#contains
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 100, `groupid` = 1 WHERE `entry` = 2264 AND `item` = 4611;
        UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 35 WHERE `entry` = 2264 AND `item` = 4655;

        UPDATE `quest_template` SET `RequestItemsText` = 'Ah, yes. Another traveler seeking something from the dwarves.$B$B$G Sir:Ma''am;, I''m truly sorry, but I''ve no time to answer meaningless questions right now.' WHERE `entry` = 724;

        insert into applied_updates values ('230420211');
    end if;

    -- 24/04/2021 1
    if (select count(*) from applied_updates where id='240420211') = 0 then
        -- Fix reward count of Kobold Camp Cleanup
        update quest_template set RewItemCount1 = 1 where entry = 7;
        -- Fix rewards of quest A New Threat
        update quest_template set RewItemId1 = 0, RewChoiceItemId1 = 2173, RewChoiceItemCount3 = 0 where entry = 170;
        -- Rustic Belt -> Dwarven Chain Belt
        update item_template set name = 'Dwarven Chain Belt' where entry = 2172;

        insert into applied_updates values ('240420211');
    end if;

    -- 25/04/2021 1
    if (select count(*) from applied_updates where id='250420211') = 0 then
        update spawns_gameobjects set ignored = 1 where spawn_entry in (149045, 149046);

        insert into applied_updates values ('250420211');
    end if;

    -- 26/04/2021 1
    if (select count(*) from applied_updates where id='260420211') = 0 then
        update item_template set name = 'Bloodstone' where entry = 5509;
        update item_template set name = 'Greater Bloodstone' where entry = 5510;
        update item_template set name = 'Lesser Bloodstone' where entry = 5511;
        update item_template set name = 'Minor Bloodstone' where entry = 5512;
        delete from item_template where entry = 9421;
        delete from item_template where entry between 19004 and 19013;

        insert into applied_updates values ('260420211');
    end if;
end $
delimiter ;
