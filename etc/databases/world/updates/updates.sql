delimiter $
begin not atomic

    -- 31/10/2025 1
    if (select count(*) from applied_updates where id='311020251') = 0 then
        -- Fix Chickens not being melee attackable.
        UPDATE creature_template SET npc_flags = 0 WHERE entry = 620;

        insert into applied_updates values ('311020251');
    end if;

    -- 31/10/2025 2
    if (select count(*) from applied_updates where id='311020252') = 0 then
        -- Remove wrong text said at the end of Skirmish at Echo Ridge.
        -- This text should be said upon accepting Report to Goldshire.
        -- Proof: https://www.youtube.com/watch?v=SH3HhIsDZ4k&t=373s
        DELETE FROM `quest_end_scripts` WHERE `id`=21;
        UPDATE `quest_template` SET `CompleteScript`=0 WHERE `entry`=21;

        insert into applied_updates values ('311020252');
    end if;

    -- 02/11/2025 1
    if (select count(*) from applied_updates where id='021120251') = 0 then
        -- Fix level for Healing Wards.
        -- Closes https://github.com/The-Alpha-Project/alpha-core/issues/1531
        UPDATE `creature_template` SET `level_min` = 1, `level_max` = 1 WHERE `entry` IN (2992, 3560, 3844);

        insert into applied_updates values ('021120251');
    end if;

    -- 03/11/2025 1
    if (select count(*) from applied_updates where id='031120251') = 0 then
        -- Closes https://github.com/The-Alpha-Project/alpha-core/issues/1503
        -- Events list for Snufflenose Gopher
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4781;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (478101, 4781, 122101, 1, 0, 40, 1, 2000, 30000, 20000, 30000, 478101, 0, 0, 'Snufflenose');

        DELETE FROM `creature_ai_scripts` WHERE `id`=478101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (478101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1592, 0, 0, 0, 0, 0, 0, 0, 0, 'Snufflenose - Sniff Text'),
        (478101, 0, 0, 15, 6900, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Snufflenose - Create Tuber');

        DELETE FROM `conditions` WHERE `condition_entry` in (122101, 122102, 122103, 122104);
        -- 122101: (122102: GameObject 20920 Is Within 50 Yards Of The Target) And (122103:  Not (GameObject 20920 Is Within 5 Yards Of The Target)) And (122104: Friendly Player Within 15 Yards Of The Target)
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122101, -1, 122102, 122103, 122104, 0, 0);
        -- 122102: GameObject 20920 Is Within 50 Yards Of The Target
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122102, 21, 20920, 50, 0, 0, 0);
        -- 122103:  Not (GameObject 20920 Is Within 5 Yards Of The Target)
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122103, 21, 20920, 5, 0, 0, 1);
        -- 122104: Friendly Player Within 15 Yards Of The Target
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122104, 56, 2, 15, 0, 0, 0);
        
        -- Remove all reference to non existent Command Stick, change blueleaf -> redleaf. Must delete pagetextcache.wdb cache.
        UPDATE `quest_template` SET `Objectives` = 'Grab a Crate with Holes. Grab a Snufflenose Command Stick. Grab and read the Snufflenose Owner\'s Manual. In Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher and let him search for Tubers while he follows you. Bring 10 Redleaf Tubers and the Crate with Holes to Mebok Mizzyrix in Ratchet.' WHERE (`entry` = '1221');
        
        UPDATE `page_text` SET `text` = 'CONGRATULATIONS!\n\nYou are the proud new owner of the amazing snufflenose gopher!  Although a shy creature, we are positive you\'ll find your new pet\'s fuzzy cuteness and incredible olfactory capabilities endearing.\n\nIn the following pages, you\'ll find information on your gopher\'s:\n\n1. Feeding and care\n2. Eccentric (and adorable) behavior\n3. Finding Tubers\n\nAgain, congratulations.  You won\'t be disappounted,\n\n-Marwig Rustbolt\nOwner, Snuff Inc.\n\n' WHERE (`entry` = '467');

        UPDATE `page_text` SET `text` = 'FEEDING AND CARE:\n\nWe are committed to providing you with everything needed to care for your pet.  Our customers have come to expect this level of service from Snuff Inc, and we agree!\n\nTo that end, we have designed sturdy gopher crates with small holes, perfect for keeping your pet safe, secure and out of the light.\n\nFor your convenience, inside every crate is a food pellet receptacle, infused with the alluring scent of redleaf tubers (the snufflenose gopher\'s favorite treat)!' WHERE (`entry` = '771');

        UPDATE `page_text` SET `text` = 'WALKING YOUR GOPHER\n\nThe snufflenose gopher likes small, dark places.  And it is very shy.\n\nIf you wish to walk your gopher, then you must take it to a place that feels like home.  And you MUST take it to where your gopher can smell its favorite food: redleaf tubers!\n\nThe closest such place is the \"trench\" area of Razorfen Kraul.  If you open your crate near the trench, and your gopher can smell any nearby tubers, then he will venture out and follow you.' WHERE (`entry` = '1211');

        UPDATE `page_text` SET `text` = 'FINDING TUBERS\n\nThe snufflenose gopher is an amazing animal.  Not only does it inspire love and affection from even the most ornery plainstrider, it can smell a buried redleaf tuber from up to fifty yards away!\n\nAs your gopher follows you, it will sniff and dig for hidden reedleaf tubers; once they appear, be sure to collect them.\n', `next_page` = '0' WHERE (`entry` = '1212');
        
        -- Set all Redleaf Tubers spawn ignored, they are created by a spell.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_entry` = '20920');

        -- Bonfire Z.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.200' WHERE (`spawn_id` = '48743');
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '41.050' WHERE (`spawn_id` = '48738');
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.225' WHERE (`spawn_id` = '48705');
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '43.400' WHERE (`spawn_id` = '48701');

        -- Barrel of Milk Z.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.746' WHERE (`spawn_id` = '39055');

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1569
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE `spawn_id` in ('20458', '31619', 20459);

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1535
        UPDATE `quest_template` SET `Details` = 'Velinde Starsong was my predecessor here in Ashenvale Forest. At first it seemed she had the situation in Felwood under control, but little by little her efforts faltered. One day, she simply disappeared.\n\nI was sent here to continue her work. I\'m afraid I know nothing of the priestess, however. Perhaps Shandris Feathermoon, commander of the Sentinels, knows further details of her disappearance that I was not a party to.\n\nSurely she will understand the import of such information.', `Objectives` = 'Speak with Shandris Feathermoon at the Hall of Justice in Darnassus.' WHERE (`entry` = '1037');

        UPDATE `creature_quest_finisher` SET `entry` = '3936' WHERE (`entry` = '8026') and (`quest` = '1037');
        
        -- Healing Wards - Ignore combat. (Passive - Don't acquire targets.')
        UPDATE `creature_template` SET `static_flags` = '34655494' WHERE (`entry` = '2992');
        UPDATE `creature_template` SET `static_flags` = '34655494' WHERE (`entry` = '3560');
        UPDATE `creature_template` SET `static_flags` = '34655494' WHERE (`entry` = '3844');

        -- Report to Goldshire reward.
        UPDATE `quest_template` SET `RewItemId1` = '6078', `RewItemCount1` = '1' WHERE (`entry` = '54');
        -- Unused model for Defias Profiteer.
        UPDATE `creature_template` SET `display_id1` = '515', `equipment_id` = '598' WHERE (`entry` = '1669');
        -- Fix Aedis Brom spawn, he should start besides Christoph Faral.
        UPDATE `spawns_creatures` SET `position_x` = '-8605.97', `position_y` = '388.41', `position_z` = '102.925', `orientation` = '5.41052' WHERE (`spawn_id` = '79752');
        -- Fix Geoffrey Hartwell placement.
        UPDATE `spawns_creatures` SET `position_x` = '1657.234', `position_y` = '305.609' WHERE (`spawn_id` = '41837');
        -- Fix Benijah Fenner placement.
        UPDATE `spawns_creatures` SET `position_x` = '1659.186', `position_y` = '303.587', `position_z` = '-42.692' WHERE (`spawn_id` = '38426');
        -- Fix Francis Eliot placement.
        UPDATE `spawns_creatures` SET `position_x` = '1661.217', `position_y` = '301.482', `position_z` = '-42.688' WHERE (`spawn_id` = '38109');
        -- Fix Joanna Whitehall placement. https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Cities/Undercity/000904.jpg
        UPDATE `spawns_creatures` SET `position_x` = '1630.627', `position_y` = '331.262', `position_z` = '-45.486', `orientation` = '1.029' WHERE (`spawn_id` = '38112');
        -- Fix Leona Tharpe placement. https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Cities/Undercity/000904.jpg
        UPDATE `spawns_creatures` SET `position_x` = '1634.472', `position_y` = '331.704', `position_z` = '-45.481', `orientation` = '2.639' WHERE (`spawn_id` = '38111');
        -- Fix Father Lankester placement.
        UPDATE `spawns_creatures` SET `orientation` = '4.753' WHERE (`spawn_id` = '41835');

        -- Fix Theresa waypoints and scripts.
        DELETE FROM `generic_scripts` WHERE `id`=569602;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (569602, 1, 0, 35, 0, 0, 0, 0, 41840, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Set Orientation'),
        (569602, 2, 0, 19, 0, 0, 0, 0, 41840, 0, 9, 2, 2716, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Set Equipment (Theresa)'),
        (569602, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1995, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Say Text'),
        (569602, 3, 0, 0, 0, 0, 0, 0, 41840, 0, 9, 2, 1998, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Say Text (Theresa)'),
        (569602, 3, 0, 1, 2, 0, 0, 0, 41840, 0, 9, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Emote (Theresa)'),
        (569602, 5, 0, 35, 1, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 4.93928, 0, 'Gerard Abernathy - Set Orientation'),
        (569602, 6, 0, 60, 0, 1, 0, 0, 41840, 0, 9, 2, 0, 5697, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Start Waypoints (Theresa)'),
        (569602, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2003, 2002, 1994, 2000, 0, 0, 0, 0, 0, 'Gerard Abernathy - Say Text'),
        (569602, 32, 0, 39, 569901, 569902, 0, 0, 38111, 0, 9, 2, 50, 50, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Start Random Script (Leona Tharpe)'),
        (569602, 37, 0, 1, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Emote'),
        (569602, 41, 0, 39, 569603, 569604, 0, 0, 0, 0, 0, 0, 50, 50, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Start Random Script'),
        (569602, 44, 0, 1, 21, 0, 0, 0, 38112, 0, 9, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Emote (Joanna Whitehall)'),
        (569602, 48, 0, 39, 569801, 569802, 0, 0, 38112, 0, 9, 2, 50, 50, 0, 0, 0, 0, 0, 0, 0, 'Gerard Abernathy - Start Random Script (Joanna Whitehall)');

        DELETE FROM creature_movement_template WHERE entry = 5697;
        INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (5697, 0, 1634.04, 334.478, -45.489, 0, 0, 0, 0),
        (5697, 1, 1631.67, 322.464, -45.454, 0, 0, 0, 0),
        (5697, 2, 1650.14, 313.159, -53.675, 0, 0, 0, 0),
        (5697, 3, 1655.89, 313.231, -55.858, 0, 0, 0, 0),
        (5697, 4, 1664.89, 315.865, -59.744, 0, 0, 0, 0),
        (5697, 5, 1669.15, 316.876, -59.781, 0, 0, 0, 0),
        (5697, 6, 1680.35, 308.525, -59.781, 0, 0, 0, 0),
        (5697, 7, 1684.66, 305.521, -62.172, 0, 0, 0, 0),
        (5697, 8, 1704.87, 307.305, -62.189, 0, 0, 0, 0),
        (5697, 9, 1710.92, 308.151, -61.479, 0, 0, 0, 0),
        (5697, 10, 1714.12, 314.301, -60.484, 0, 0, 0, 0),
        (5697, 11, 1709.16, 321.078, -55.392, 0, 0, 0, 0),
        (5697, 12, 1708.59, 326.214, -55.179, 0, 0, 0, 0),
        (5697, 13, 1713.28, 329.564, -52.638, 0, 0, 0, 0),
        (5697, 14, 1720.43, 334.741, -49.161, 0, 0, 0, 0),
        (5697, 15, 1724.53, 338.031, -49.747, 0, 0, 0, 0),
        (5697, 16, 1728.15, 340.93, -52.341, 0, 0, 0, 0),
        (5697, 17, 1733.97, 345.234, -55.393, 0, 0, 0, 0),
        (5697, 18, 1737.62, 343.292, -55.394, 0, 0, 0, 0),
        (5697, 19, 1742.77, 336.882, -60.242, 0, 0, 0, 0),
        (5697, 20, 1750.69, 334.731, -60.484, 0, 0, 0, 0),
        (5697, 21, 1755.53, 334.747, -62.32, 0, 0, 0, 0),
        (5697, 22, 1770.12, 340.421, -62.307, 0, 0, 0, 0),
        (5697, 23, 1779.96, 348.428, -62.36, 0, 0, 0, 0),
        (5697, 24, 1785.56, 355.539, -62.37, 0, 0, 0, 0),
        (5697, 25, 1789.97, 362.803, -60.222, 0, 0, 0, 0),
        (5697, 26, 1793.02, 371.206, -60.159, 0, 0, 0, 0),
        (5697, 27, 1791.2, 378.762, -60.116, 0, 0, 0, 0),
        (5697, 28, 1788.47, 386.16, -57.413, 0, 0, 0, 0),
        (5697, 29, 1778.15, 397.858, -57.215, 0, 17000, 0, 569701),
        (5697, 30, 1784.1, 392.651, -57.209, 0, 0, 0, 0),
        (5697, 31, 1787.31, 387, -57.207, 0, 0, 0, 0),
        (5697, 32, 1791.56, 378.861, -60.131, 0, 0, 0, 0),
        (5697, 33, 1792.95, 370.933, -60.159, 0, 0, 0, 0),
        (5697, 34, 1789.82, 363.689, -60.159, 0, 0, 0, 0),
        (5697, 35, 1785.81, 355.755, -62.323, 0, 0, 0, 0),
        (5697, 36, 1770.4, 342.749, -62.307, 0, 0, 0, 0),
        (5697, 37, 1756.33, 338.599, -62.26, 0, 0, 0, 0),
        (5697, 38, 1752.49, 337.824, -60.484, 0, 0, 0, 0),
        (5697, 39, 1743.17, 336.952, -60.484, 0, 0, 0, 0),
        (5697, 40, 1738.07, 342.982, -55.427, 0, 0, 0, 0),
        (5697, 41, 1733.01, 344.982, -55.164, 0, 0, 0, 0),
        (5697, 42, 1728.92, 341.689, -52.85, 0, 0, 0, 0),
        (5697, 43, 1721.89, 336.424, -49.206, 0, 0, 0, 0),
        (5697, 44, 1717.12, 332.7, -49.807, 0, 0, 0, 0),
        (5697, 45, 1713.31, 329.612, -52.617, 0, 0, 0, 0),
        (5697, 46, 1708.53, 326.246, -55.19, 0, 0, 0, 0),
        (5697, 47, 1703.63, 327.763, -55.4, 0, 0, 0, 0),
        (5697, 48, 1698.68, 334.199, -60.499, 0, 0, 0, 0),
        (5697, 49, 1686.4, 331.878, -60.482, 0, 0, 0, 0),
        (5697, 50, 1678.53, 331.036, -62.152, 0, 0, 0, 0),
        (5697, 51, 1664.61, 331.803, -62.172, 0, 0, 0, 0),
        (5697, 52, 1662.33, 326.736, -61.939, 0, 0, 0, 0),
        (5697, 53, 1664.95, 323.971, -59.781, 0, 0, 0, 0),
        (5697, 54, 1664.74, 315.839, -59.703, 0, 0, 0, 0),
        (5697, 55, 1655.922, 313.054, -55.85, 0, 0, 0, 0),
        (5697, 56, 1648.88, 313.721, -53.145, 0, 0, 0, 0),
        (5697, 57, 1631.84, 322.268, -45.513, 0, 0, 0, 0),
        (5697, 58, 1634.04, 334.555, -45.477, 0, 0, 0, 569702);

        -- Fix Davitt Hickson and creature group waypoints.
        DELETE FROM creature_movement_template WHERE entry = 5706;
        INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (5706, 0, 1597.29, 103.896, -53.34, 0, 0, 0, 0),
        (5706, 1, 1591.431, 103.977, -53.373, 0, 0, 0, 0),
        (5706, 2, 1574.73, 104.075, -62.179, 0, 0, 0, 0),
        (5706, 3, 1570.562, 108.344, -62.178, 0, 0, 0, 0),
        (5706, 4, 1571.783, 117.036, -62.264, 0, 0, 0, 0),
        (5706, 5, 1575.893, 131.159, -60.899, 0, 0, 0, 0),
        (5706, 6, 1577.09, 136.603, -60.827, 0, 0, 0, 0),
        (5706, 7, 1578.517, 144.54, -59.649, 0, 0, 0, 0),
        (5706, 8, 1579.409, 149.5, -59.649, 0, 0, 0, 0),
        (5706, 9, 1579.658, 158.681, -58.398, 0, 0, 0, 0),
        (5706, 10, 1580.007, 171.556, -53.609, 0, 0, 0, 0),
        (5706, 11, 1580.144, 176.609, -53.678, 0, 0, 0, 0),
        (5706, 12, 1580.328, 183.397, -55.714, 0, 0, 0, 0),
        (5706, 13, 1577.477, 189.222, -56.872, 0, 0, 0, 0),
        (5706, 14, 1570.401, 193.038, -57.375, 0, 0, 0, 0),
        (5706, 15, 1561.836, 197.15, -60.777, 0, 0, 0, 0),
        (5706, 16, 1559.072, 204.348, -60.777, 0, 0, 0, 0),
        (5706, 17, 1567.058, 211.713, -60.504, 0, 0, 0, 0),
        (5706, 18, 1571.669, 215.965, -58.998, 0, 0, 0, 0),
        (5706, 19, 1579.975, 223.625, -61.91, 0, 0, 0, 0),
        (5706, 20, 1586.624, 228.228, -62.093, 0, 0, 0, 0),
        (5706, 21, 1604.651, 227.838, -62.099, 0, 0, 0, 0),
        (5706, 22, 1610.567, 231.911, -62.077, 0, 0, 0, 0),
        (5706, 23, 1612.858, 254.842, -61.904, 0, 0, 0, 0),
        (5706, 24, 1618.593, 262.142, -59.063, 0, 0, 0, 0),
        (5706, 25, 1625.877, 269.377, -60.695, 0, 0, 0, 0),
        (5706, 26, 1637.158, 275.89, -60.776, 0, 0, 0, 0),
        (5706, 27, 1642.601, 266.493, -57.986, 0, 0, 0, 0),
        (5706, 28, 1650.719, 255.18, -56.54, 0, 0, 0, 0),
        (5706, 29, 1660.667, 255.175, -53.587, 0, 0, 0, 0),
        (5706, 30, 1668.029, 254.336, -54.194, 0, 0, 0, 0),
        (5706, 31, 1678.11, 254.404, -58.46, 0, 0, 0, 0),
        (5706, 32, 1691.617, 255.977, -59.707, 0, 0, 0, 0),
        (5706, 33, 1705.597, 258.192, -60.957, 0, 0, 0, 0),
        (5706, 34, 1719.178, 261.914, -62.38, 0, 0, 0, 0),
        (5706, 35, 1732.281, 258.612, -62.096, 0, 0, 0, 0),
        (5706, 36, 1732.213, 247.816, -56.176, 0, 0, 0, 0),
        (5706, 37, 1732.453, 239.873, -53.141, 0, 0, 0, 0),
        (5706, 38, 1731.955, 218.663, -62.179, 0, 0, 0, 0),
        (5706, 39, 1728.427, 207.21, -61.741, 0, 0, 0, 0),
        (5706, 40, 1720.917, 187.533, -62.146, 0, 0, 0, 0),
        (5706, 41, 1719.315, 186.132, -60.762, 0, 0, 0, 0),
        (5706, 42, 1708.082, 174.777, -60.74, 0, 0, 0, 0),
        (5706, 43, 1701.164, 158.998, -60.788, 0, 0, 0, 0),
        (5706, 44, 1671.441, 129.906, -60.39, 0, 0, 0, 0),
        (5706, 45, 1668.86, 128.702, -61.483, 0, 0, 0, 0),
        (5706, 46, 1649.718, 116.468, -62.185, 0, 0, 0, 0),
        (5706, 47, 1634.239, 109.533, -62.19, 0, 0, 0, 0),
        (5706, 48, 1614.48, 104.101, -62.179, 0, 0, 0, 0),
        (5706, 49, 1603.231, 103.973, -56.174, 0, 0, 0, 0);

        insert into applied_updates values ('031120251');
    end if;

    -- 27/11/2025 1
    if (select count(*) from applied_updates where id='271120251') = 0 then
        -- Fix Edrick Killian waypoints.
        DELETE FROM creature_movement_template WHERE entry = 5670;
        INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (5670, 0, 1600.175, 376.67, -53.378, 0, 0, 0, 0),
        (5670, 1, 1616.839, 376.539, -62.179, 0, 0, 0, 0),
        (5670, 2, 1628.542, 372.819, -61.898, 0, 0, 0, 0),
        (5670, 3, 1648.155, 364.815, -62.143, 0, 0, 0, 0),
        (5670, 4, 1650.225, 363.479, -60.76, 0, 0, 0, 0),
        (5670, 5, 1661.194, 351.219, -60.729, 0, 0, 0, 0),
        (5670, 6, 1661.012, 343.889, -62.175, 0, 0, 0, 0),
        (5670, 7, 1662.2, 326.55, -61.917, 0, 0, 0, 0),
        (5670, 8, 1664.898, 323.668, -59.781, 0, 0, 0, 0),
        (5670, 9, 1680.122, 308.153, -59.781, 0, 0, 0, 0),
        (5670, 10, 1684.126, 304.744, -62.19, 0, 0, 0, 0),
        (5670, 11, 1707.36, 302.583, -62.194, 0, 0, 0, 0),
        (5670, 12, 1719.158, 301.32, -61.487, 0, 0, 0, 0),
        (5670, 13, 1728.173, 279.497, -62.176, 0, 0, 0, 0),
        (5670, 14, 1729.933, 270.735, -62.038, 0, 0, 0, 0),
        (5670, 15, 1719.813, 261.793, -62.292, 0, 0, 0, 0),
        (5670, 16, 1705.77, 258.628, -61.005, 0, 0, 0, 0),
        (5670, 17, 1690.888, 255.85, -59.707, 0, 0, 0, 0),
        (5670, 18, 1676.619, 254.997, -57.989, 0, 0, 0, 0),
        (5670, 19, 1667.219, 254.613, -53.957, 0, 0, 0, 0),
        (5670, 20, 1659.609, 254.302, -53.697, 0, 0, 0, 0),
        (5670, 21, 1651.926, 254.491, -56.008, 0, 0, 0, 0),
        (5670, 22, 1639.619, 271.967, -60.459, 0, 0, 0, 0),
        (5670, 23, 1629.786, 282.667, -60.776, 0, 0, 0, 0),
        (5670, 24, 1621.124, 288.01, -57.357, 0, 0, 0, 0),
        (5670, 25, 1612.188, 294.286, -56.885, 0, 0, 0, 0),
        (5670, 26, 1611.001, 304.979, -53.587, 0, 0, 0, 0),
        (5670, 27, 1611.105, 314.987, -55.088, 0, 0, 0, 0),
        (5670, 28, 1611.521, 321.939, -58.384, 0, 0, 0, 0),
        (5670, 29, 1613.262, 335.994, -59.649, 0, 0, 0, 0),
        (5670, 30, 1615.424, 349.095, -60.899, 0, 0, 0, 0),
        (5670, 31, 1619.357, 363.108, -62.328, 0, 0, 0, 0),
        (5670, 32, 1617.024, 376.344, -62.179, 0, 0, 0, 0),
        (5670, 33, 1608.984, 376.711, -57.661, 0, 0, 0, 0),
        (5670, 34, 1598.008, 376.784, -53.161, 0, 0, 0, 0),
        (5670, 35, 1577.52, 377.329, -62.101, 0, 0, 0, 0),
        (5670, 36, 1565.314, 373.235, -61.839, 0, 0, 0, 0),
        (5670, 37, 1537.225, 367.311, -61.936, 0, 0, 0, 0),
        (5670, 38, 1530.928, 363.897, -57.464, 0, 0, 0, 0),
        (5670, 39, 1522.859, 359.51, -57.152, 0, 0, 0, 0),
        (5670, 40, 1517.081, 356.369, -60.792, 0, 0, 0, 0),
        (5670, 41, 1514.205, 352.347, -60.782, 0, 0, 0, 0),
        (5670, 42, 1516.945, 346.966, -60.782, 0, 0, 0, 0),
        (5670, 43, 1540.0, 357.956, -61.507, 0, 0, 0, 0),
        (5670, 44, 1558.413, 371.245, -61.69, 0, 0, 0, 0),
        (5670, 45, 1565.238, 373.386, -61.822, 0, 0, 0, 0),
        (5670, 46, 1578.283, 376.003, -61.57, 0, 0, 0, 0),
        (5670, 47, 1591.355, 377.014, -54.378, 0, 0, 0, 0);

        -- Remove Invalid script.
        DELETE FROM `creature_ai_scripts` WHERE `id`=571701;
        
        -- Remove vendor flag from Karm Ironquill since there were no Cartography items.
        UPDATE `creature_template` SET `npc_flags` = '0' WHERE (`entry` = '372');

        -- Boyle, 'Slime Merchant'
        UPDATE `creature_template` SET `subname` = 'Slime Merchant' WHERE (`entry` = '4612');

        -- Fix Samantha Shackleton placement.
        UPDATE `spawns_creatures` SET `position_x` = '1658.143', `position_y` = '176.962', `position_z` = '-42.693', `orientation` = '5.453' WHERE (`spawn_id` = '31864');

        -- Fix Mary Edras placement.
        UPDATE `spawns_creatures` SET `position_x` = '1531.637', `position_y` = '176.063' WHERE (`spawn_id` = '38424');

        insert into applied_updates values ('271120251');
    end if;


end $
delimiter ;
