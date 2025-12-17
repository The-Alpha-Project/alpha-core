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

    -- 28/11/2025 1
    if (select count(*) from applied_updates where id='281120251') = 0 then
        -- Quest 1038, Velinde's Effects, set Shandris Feathermoon as starter/finisher.
        UPDATE `creature_quest_starter` SET `entry` = '3936' WHERE (`entry` = '8026') and (`quest` = '1038');
        UPDATE `creature_quest_finisher` SET `entry` = '3936' WHERE (`entry` = '8026') and (`quest` = '1038');

        -- Quest 1038, https://web.archive.org/web/20040711114345/http://wow.allakhazam.com/db/quest.html?wquest=1038
        UPDATE `quest_template` SET `Details` = 'The Tome of Mel\'Thandris showed you this? I suppose there would be little harm in allowing you to examine her belongings. This key will allow you to open the chest where we stored her things in the Sentinels\' bunkhouse. She kept a journal of her duties, if there is anything to be learned, it will be from that.\n\nI should tell you, the Sentinels believe that she had her own reasons for leaving, and expect that she could return at any time. The priestess has done much in the past to earn our trust.', `Objectives` = 'Search through Velinde\'s chest for her journal, then return it along with the key to Shandris Feathermoon in Darnassus.' WHERE (`entry` = '1038');

        -- Nimboya orientation.
        UPDATE `spawns_creatures` SET `orientation` = '3.51' WHERE (`spawn_id` = '630');

        -- Kobold Worker/Vermin/Laborer/Tunneler Flee.
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Elwynn%20Forest/20%20MARCH%2004%20%20%2011.jpg
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Elwynn%20Forest/20%20MARCH%2004%20%20%2006.jpg
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Elwynn%20Forest/27.jpg
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Elwynn%20Forest/20%20MARCH%2004%20%20%2013.jpg
        -- Events list for Kobold Worker
        DELETE FROM `creature_ai_events` WHERE `creature_id`=257;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (25701, 257, 0, 4, 0, 30, 0, 0, 0, 0, 0, 25701, 0, 0, 'Kobold Worker - Random Say on Aggro'),
        (25702, 257, 0, 2, 0, 30, 0, 15, 0, 0, 0, 25702, 0, 0, 'Kobold Worker - Flee at 15% HP');

        DELETE FROM `creature_ai_scripts` WHERE `id`=25702;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (25702, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kobold Worker - Flee at 15% HP');

        -- Events list for Kobold Vermin
        DELETE FROM `creature_ai_events` WHERE `creature_id`=6;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (601, 6, 0, 4, 0, 30, 0, 0, 0, 0, 0, 601, 0, 0, 'Kobold Vermin - Random Say on Aggro'),
        (602, 6, 0, 2, 0, 30, 0, 15, 0, 0, 0, 602, 0, 0, 'Kobold Vermin- Flee at 15% HP');

        DELETE FROM `creature_ai_scripts` WHERE `id`=602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (602, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kobold Vermin - Flee at 15% HP');

        -- Events list for Kobold Tunneler
        DELETE FROM `creature_ai_events` WHERE `creature_id`=475;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (47501, 475, 0, 4, 0, 30, 0, 0, 0, 0, 0, 47501, 0, 0, 'Kobold Tunneler - Chance Say on Aggro'),
        (47502, 475, 0, 2, 0, 30, 0, 15, 0, 0, 0, 47502, 0, 0, 'Kobold Tunneler - Flee at 15% HP');

        DELETE FROM `creature_ai_scripts` WHERE `id`=47502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (47502, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kobold Tunneler - Flee at 15% HP');

        -- Events list for Kobold Laborer
        DELETE FROM `creature_ai_events` WHERE `creature_id`=80;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (8001, 80, 0, 4, 0, 30, 0, 0, 0, 0, 0, 8001, 0, 0, 'Kobold Labourer - Random Say on Aggro'),
        (8002, 80, 0, 2, 0, 30, 0, 15, 0, 0, 0, 8002, 0, 0, 'Kobold Laborer - Flee at 15% HP');

        DELETE FROM `creature_ai_scripts` WHERE `id`=8002;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (8002, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kobold Laborer - Flee at 15% HP');

        -- Missing aggro text for Kobolds.
        DELETE FROM `creature_ai_scripts` WHERE `id`=25701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (25701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1868, 1864, 1863, 0, 0, 0, 0, 0, 0, 'Kobold Worker - Say Text');

        DELETE FROM `creature_ai_scripts` WHERE `id`=8001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (8001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1868, 1864, 1863, 0, 0, 0, 0, 0, 0, 'Kobold Laborer - Say Text');

        DELETE FROM `creature_ai_scripts` WHERE `id`=47501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (47501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1864, 1868, 1863, 0, 0, 0, 0, 0, 0, 'Kobold Tunneler - Say Text');

        DELETE FROM `creature_ai_scripts` WHERE `id`=601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (601, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1868, 1864, 1863, 0, 0, 0, 0, 0, 0, 'Kobold Vermin - Say Text');

        -- Riverpaw Gnoll - Missing aggro text.
        DELETE FROM `creature_ai_scripts` WHERE `id`=11701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (11701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1871, 1870, 1869, 0, 0, 0, 0, 0, 0, 'Riverpaw Gnoll - Say Text');

        insert into applied_updates values ('281120251');
    end if;

    -- 01/12/2025 1
    if (select count(*) from applied_updates where id='011220251') = 0 then
        -- Quest 1039, The Barrens Port, set Shandris Feathermoon as starter.
        UPDATE `creature_quest_starter` SET `entry` = '3936' WHERE (`entry` = '8026') and (`quest` = '1039');
        -- Argent Dawn invalid faction 814 to 35 (Friendly)
        UPDATE `creature_template` SET `faction` = '35' WHERE `faction` = '814';
        -- Kitari Farseeker <Cartography Trainer> - Friendly faction.
        UPDATE `creature_template` SET `faction` = '35' WHERE (`entry` = '4157');
        -- Wharfmaster Dizzywig, orientation.
        UPDATE `spawns_creatures` SET `orientation` = '2.931' WHERE (`spawn_id` = '14419');
        -- Remove unused table.
        DROP TABLE playercreateinfo_item;
        -- Unused model for Suzetta Gallina https://github.com/The-Alpha-Project/alpha-core/issues/1312
        UPDATE `creature_template` SET `display_id1` = '1474' WHERE (`entry` = '1431');
        -- Laird <Fish Vendor> - Holding Fish
        UPDATE `creature_equip_template` SET `equipentry1` = '6225' WHERE (`entry` = '4200');

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1458
        UPDATE `quest_template` SET `Details` = 'During the first years of Thredd\'s imprisonment, he never had any visitors. I figured that he was no longer of use to the Defias Brotherhood, so they abandoned him to die.\n\nAnyways, a few months ago, that all changed. He started to get regular visits... once or twice a week. It was a strange man, quiet type. I had my suspicions, but all his papers and clearances were clean and legitimate.\n\nHis name was Maelik, here\'s his description. It won\'t do me much good now that Thredd\'s no longer a problem.', `Objectives` = 'Perhaps Baros Alexston knows something about Bazil Thredd\'s strange visitor...' WHERE (`entry` = '392');
        UPDATE `quest_template` SET `Objectives` = 'Speak with Master Mathias Shaw in Old Town.' WHERE (`entry` = '393');
        UPDATE `quest_template` SET `NextQuestInChain` = '394' WHERE (`entry` = '350');
        UPDATE `quest_template` SET `PrevQuestId` = '350', `Details` = 'I have had my suspicions about the activities of Lord Lescovar, but have never seen or heard any proof to that effect. That Marzon would be contacting a member of the Defias Brotherhood...\n\nHaving killed VanCleef and Thredd, it would be hard to see Lescovar to justice, as your proof is certainly less without their testimony. That is not even considering the fact that Lescovar is a noble, and well connected! They are above the law, my friend.\n\nAny justice would have to be swift, final, and silent.', `Objectives` = 'Kill Lord Gregor Lescovar and bring his head to Master Matthias Shaw in Old Town.', `ReqItemId1` = '3516', `ReqItemCount1` = '1' WHERE (`entry` = '394');

        -- Events list for Lord Gregor Lescovar - Runs every 60 minutes.
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1754;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (175401, 1754, 0, 4, 0, 100, 0, 0, 0, 0, 0, 175401, 0, 0, 'Lord Gregor Lescovar - Say Text on Aggro'),
        (175402, 1754, 0, 1, 0, 100, 0, 3600000, 3600000, 0, 0, 175402, 0, 0, 'Lord Gregor Lescovar - The Head of the Beast');

        -- Waypoints Lord Gregor Lescovar
        DELETE FROM creature_movement_template WHERE entry = 1754;
        INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (1754, 0, -8333.05, 394.87, 122.274, 0, 0, 0, 0),
        (1754, 1, -8346.96, 412.712, 122.274, 0, 0, 0, 0),
        (1754, 2, -8351.2, 414.298, 122.274, 0, 0, 0, 0),
        (1754, 3, -8355.27, 411.527, 122.274, 0, 0, 0, 0),
        (1754, 4, -8360.12, 413.034, 122.274, 0, 0, 0, 0),
        (1754, 5, -8363.47, 416.025, 122.274, 0, 0, 0, 0),
        (1754, 6, -8387.32, 446.132, 122.274, 0, 0, 0, 0),
        (1754, 7, -8389.33, 448.678, 124.274, 0, 0, 0, 0),
        (1754, 8, -8392.253, 452.419, 123.76, 0, 10000, 0, 39401),
        (1754, 9, -8401.39, 464.739, 123.76, 0, 318000, 0, 39403),
        (1754, 10, -8401.39, 464.739, 123.76, 0, 0, 0, 39404);

        DELETE FROM `creature_ai_scripts` WHERE `id`=175402;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (175402, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Lord Gregor Lescovar - Start Waypoints');

        -- Waypoints Marzon the Silent Blade
        DELETE FROM creature_movement_template WHERE entry = 1755;
        INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (1755, 0, -8403.43, 485.926, 123.76, 0, 0, 0, 0),
        (1755, 1, -8406.47, 482.415, 123.76, 0, 0, 0, 0),
        (1755, 2, -8409.43, 475.775, 123.76, 0, 0, 0, 0),
        (1755, 3, -8402.33, 466.068, 123.76, 0, 300000, 0, 39402),
        (1755, 4, -8402.33, 466.068, 129.76, 0, 0, 0, 0);

        DELETE FROM `creature_movement_scripts` WHERE `id`=39401;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (39401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 322, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Lord Gregor Lescovar - Text'),
        (39401, 4, 0, 0, 0, 0, 0, 0, 10523, 0, 9, 2, 3690, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Guard 1 - Text'),
        (39401, 4, 0, 0, 0, 0, 0, 0, 10524, 0, 9, 2, 3690, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Guard 2 - Text'),
        (39401, 6, 0, 18, 0, 0, 0, 0, 10523, 0, 9, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Guard 1 - Despawn'),
        (39401, 6, 0, 18, 0, 0, 0, 0, 10524, 0, 9, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Guard 2 - Despawn');

        DELETE FROM `creature_movement_scripts` WHERE `id`=39402;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (39402, 0, 0, 0, 0, 0, 0, 0, 1754, 80, 8, 2, 323, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Lord Gregor Lescovar - Text 1'),
        (39402, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 324, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Marzon the Silent Blade - Text 1'),
        (39402, 12, 0, 0, 0, 0, 0, 0, 1754, 80, 8, 2, 326, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Lord Gregor Lescovar - Text 2'),
        (39402, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 325, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Marzon the Silent Blade - Text 2'),
        (39402, 20, 0, 22, 34, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Marzon the Silent Blade - Faction'),
        (39402, 20, 0, 22, 27, 0, 0, 0, 1754, 0, 8, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Lord Gregor Lescovar - Faction'),
        (39402, 20, 0, 78, 2, 0, 0, 0, 10502, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Marzon the Silent Blade - Join Group');

        DELETE FROM `creature_movement_scripts` WHERE `id`=39403;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (39403, 30, 0, 10, 1755, 300000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, -8403.655, 485.781, 123.76, 4.522, 0, 'The Head of the Beast - Summon Marzon the Silent Blade'),
        (39403, 31, 0, 60, 0, 0, 0, 0, 1755, 80, 8, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Marzon the Silent Blade - Start Waypoints');

        DELETE FROM `creature_movement_scripts` WHERE `id`=39404;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (39404, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Head of the Beast - Lord Gregor Lescovar - Despawn');

        -- Link Lord Gregor Lescovar & Marzon the Silent Blade Aggro.
        DELETE FROM `creature_groups` WHERE `leader_guid` = 10502;
        INSERT INTO `creature_groups` (`leader_guid`, `member_guid`, `dist`, `angle`, `flags`) VALUES ('10502', '10502', '0', '0', '2');
        
        -- Darnassus Protector - Fix wps.
        DELETE FROM creature_movement WHERE id = 46325;
        INSERT INTO creature_movement (id, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (46325, 1, 10134.6, 2556.53, 1317.02, 0, 0, 0, 0),
        (46325, 2, 10109.3, 2541.11, 1316.98, 0, 0, 0, 0),
        (46325, 3, 10093.2, 2519.62, 1317.59, 0, 0, 0, 0),
        (46325, 4, 10110.8, 2487.05, 1316.99, 0, 0, 0, 0),
        (46325, 5, 10098, 2460.93, 1317.9, 0, 0, 0, 0),
        (46325, 6, 10123.8, 2512.95, 1317.05, 0, 0, 0, 0),
        (46325, 7, 10136.4, 2514.4, 1317.77, 0, 0, 0, 0),
        (46325, 8, 10156.1, 2510.84, 1317.66, 0, 0, 0, 0),
        (46325, 9, 10152.5, 2550.9, 1317.62, 0, 0, 0, 0),
        (46325, 10, 10139.3, 2559.74, 1317.03, 0, 0, 0, 0);

        -- Missing Frostsaber for Nightsaber Riding Instructor given wdb data.
        -- Entry : 4753 | Name : Jartsam | Subname : Nightsaber Riding Instructor  | Type: 7 | Static Flags : 102 | Beast Family : 0
        -- Entry : 4242 | Name : Frostsaber | Subname :  | Type: 1 | Static Flags : 0 | Beast Family : 0
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES ('46807', '4242', '0', '0', '0', '1', '10127.701', '2526.786', '1318.587', '3.740');

        -- Fix Hegnar Rumbleshot location.
        UPDATE `spawns_creatures` SET `position_x` = '-5588.170', `position_y` = '-542.347', `position_z` = '403.541', `orientation` = '1.840' WHERE (`spawn_id` = '265');
        -- Fix Cortello's Riddle loaction.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-14976.9', `spawn_positionY` = '319.874', `spawn_positionZ` = '0.0310713' WHERE (`spawn_id` = '26043');
        -- Fix Fleet Master Firallon location.
        UPDATE `spawns_creatures` SET `position_x` = '-14976.6', `position_y` = '346.487', `position_z` = '19.5424', `orientation` = '4.803' WHERE (`spawn_id` = '846');
        -- Fix Crab Z
        UPDATE `spawns_creatures` SET `position_z` = '-12.83' WHERE (`spawn_id` = '902');
        -- Kursen Commando Z
        UPDATE `spawns_creatures` SET `position_z` = '34.581' WHERE (`spawn_id` = '1465');
        -- Kursen Subchief placement.
        UPDATE `spawns_creatures` SET `position_x` = '-11370.9', `position_y` = '-682.661', `position_z` = '17.65', `orientation` = '1.025' WHERE (`spawn_id` = '1476');
        -- Scale Belly placement.
        UPDATE `spawns_creatures` SET `position_x` = '-13029.5', `position_y` = ' -735.739', `position_z` = '55.64' WHERE (`spawn_id` = '1577');
        -- Toldren Deppiron placement.
        UPDATE `spawns_creatures` SET `position_z` = '519.289' WHERE (`spawn_id` = '1772');
        -- Lepper Gnome placement.
        UPDATE `spawns_creatures` SET `position_z` = '390.279' WHERE (`spawn_id` = '2461');
        -- Frostmane placement.
        UPDATE `spawns_creatures` SET `position_x` = '-5544.6', `position_y` = '590.261', `position_z` = '394.750' WHERE (`spawn_id` = '2926');
        -- Frostmane Z.
        UPDATE `spawns_creatures` SET `position_z` = '384.604' WHERE (`spawn_id` = '2929');
        -- Frostmane placement.
        UPDATE `spawns_creatures` SET `position_x` = '-5522', `position_y` = '617.439', `position_z` = '393.498' WHERE (`spawn_id` = '2939');
        -- Rabbit Z.
        UPDATE `spawns_creatures` SET `position_z` = '410.3' WHERE (`spawn_id` = '3611');
        -- Rockjaw Bonesnapper.
        UPDATE `spawns_creatures` SET `position_z` = '403.7' WHERE (`spawn_id` = '5104');
        -- Rabid Crag Coyote.
        UPDATE `spawns_creatures` SET `position_z` = '309.699' WHERE (`spawn_id` = '6895');
        -- Ridge Huntress.
        UPDATE `spawns_creatures` SET `position_x` = '-6635.67', `position_y` = '-3547.28', `position_z` = '256.897' WHERE (`spawn_id` = '6926');
        -- Rock Elemental.
        UPDATE `spawns_creatures` SET `position_z` = '310.600' WHERE (`spawn_id` = '7710');
        -- Rock Elemental.
        UPDATE `spawns_creatures` SET `position_z` = '296.200' WHERE (`spawn_id` = '7794');
        -- Mountaineer Haggis.
        UPDATE `spawns_creatures` SET `position_z` = '348.354' WHERE (`spawn_id` = '8241');
        -- Mountaineer Haggil.
        UPDATE `spawns_creatures` SET `position_z` = '348.600' WHERE (`spawn_id` = '8243');
        -- Nillen Andemar
        UPDATE `spawns_creatures` SET `position_z` = '348.400' WHERE (`spawn_id` = '8247');
        -- Chest.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6027.23', `spawn_positionY` = '-2792.21', `spawn_positionZ` = '386.6' WHERE (`spawn_id` = '12998');
        -- Stonesplinter Seer - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '8336');
        -- Stonesplinter Skullthumper - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '8307');
        -- Stonesplinter Seer - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '8943');
        -- Stonesplinter Skullthumper - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '8944');
        -- Stonesplinter Skullthumper - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '8942');
        -- Stonesplinter Skullthumper - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '9051');
        -- Stonesplinter Scout - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '9141');
        -- Stonesplinter Skullthumper - Ignore
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '9164');
        -- Stonesplinter Seer.
        UPDATE `spawns_creatures` SET `position_x` = '-6028.65', `position_y` = '-2787.15', `position_z` = '388.010', `orientation` = '4.85' WHERE (`spawn_id` = '9057');
        -- Stonesplinter Seer.
        UPDATE `spawns_creatures` SET `position_z` = '402' WHERE (`spawn_id` = '9118');
        -- Stonesplinter Seer.
        UPDATE `spawns_creatures` SET `position_x` = '-5956.1', `position_y` = '-2892.61', `position_z` = '373.920' WHERE (`spawn_id` = '9120');
        -- Stonesplinter Trogg.
        UPDATE `spawns_creatures` SET `position_z` = '373.920' WHERE (`spawn_id` = '9123');
        -- Stoneslpinter Scout.
        UPDATE `spawns_creatures` SET `position_x` = '-5944.95', `position_y` = '-2893.86', `position_z` = '371.52' WHERE (`spawn_id` = '9132');
        -- Stonesplinter Trogg.
        UPDATE `spawns_creatures` SET `position_z` = '374' WHERE (`spawn_id` = '9143');
        -- Stonesplinter Trogg.
        UPDATE `spawns_creatures` SET `position_z` = '368' WHERE (`spawn_id` = '9171');
        -- Stonesplinter Scout.
        UPDATE `spawns_creatures` SET `position_z` = '367.779' WHERE (`spawn_id` = '9174');
        -- Stonesplinter Scout.
        UPDATE `spawns_creatures` SET `position_z` = '368.077' WHERE (`spawn_id` = '9175');
        -- Stonesplinter Trogg.
        UPDATE `spawns_creatures` SET `position_z` = '369' WHERE (`spawn_id` = '9176');
        -- Stonesplinter Seer.
        UPDATE `spawns_creatures` SET `position_x` = '-5999.429', `position_y` = '-2974.491', `position_z` = '407.936', `orientation` = '3.276' WHERE (`spawn_id` = '9248');
        -- Stonesplinter Scout.
        UPDATE `spawns_creatures` SET `position_x` = '-5830.76', `position_y` = '-2964.22', `position_z` = '355.529', `orientation` = '2.655' WHERE (`spawn_id` = '9272');
        -- Stonesplinter Scout.
        UPDATE `spawns_creatures` SET `position_x` = '-5791.19', `position_y` = '-2874.691', `position_z` = '372.574' WHERE (`spawn_id` = '9273');
        -- Stonesplinter Trogg.
        UPDATE `spawns_creatures` SET `position_z` = '366.300' WHERE (`spawn_id` = '9282');
        -- Elder Razormaw
        UPDATE `spawns_creatures` SET `position_x` = '-2987.808', `position_y` = '-3243.703', `position_z` = '73.611', `orientation` = '6.084' WHERE (`spawn_id` = '9617');
        -- Maidens Virtue Crewman
        UPDATE `spawns_creatures` SET `position_x` = '-3766.751', `position_y` = '-686.713', `position_z` = '10.317', `orientation` = '5.58' WHERE (`spawn_id` = '9828');
        -- Reduce Maidens Virtue Crewman wandering, they are all walking towards walls or boat cliff..
        UPDATE `spawns_creatures` SET `wander_distance` = '2' WHERE (`spawn_id` = '9467');
        UPDATE `spawns_creatures` SET `wander_distance` = '2' WHERE (`spawn_id` = '9529');
        UPDATE `spawns_creatures` SET `wander_distance` = '2' WHERE (`spawn_id` = '9531');
        UPDATE `spawns_creatures` SET `wander_distance` = '2' WHERE (`spawn_id` = '9534');
        UPDATE `spawns_creatures` SET `wander_distance` = '2' WHERE (`spawn_id` = '9538');
        UPDATE `spawns_creatures` SET `wander_distance` = '2' WHERE (`spawn_id` = '9572');
        -- Redridge Rudger.
        UPDATE `spawns_creatures` SET `position_x` = '-8920.453', `position_y` = '-1984.615', `position_z` = '133.280' WHERE (`spawn_id` = '10116');
        -- Hammerfall Guardian.
        UPDATE `spawns_creatures` SET `position_x` = '-871.106', `position_y` = '-3505.56', `position_z` = '73.364', `orientation` = '4.187' WHERE (`spawn_id` = '11238');
        -- Dabyrie Laborer.
        UPDATE `spawns_creatures` SET `position_z` = '42.051' WHERE (`spawn_id` = '11352');
        -- Redridge Basher.
        UPDATE `spawns_creatures` SET `position_x` = '-8931.591', `position_y` = '-2001.674', `position_z` = '134.528' WHERE (`spawn_id` = '11677');
        -- Witherbark.
        UPDATE `spawns_creatures` SET `position_z` = '42.572' WHERE (`spawn_id` = '11705');
        -- Drywishker Digger.
        UPDATE `spawns_creatures` SET `position_x` = '-989.711', `position_y` = '-3842.9', `position_z` = '144.527', `orientation` = '2.503' WHERE (`spawn_id` = '11945');
        -- Drull.
        UPDATE `spawns_creatures` SET `position_z` = '51.142' WHERE (`spawn_id` = '15597');
        -- Food Crate.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.097' WHERE (`spawn_id` = '43642');
        -- Syndicate Rogue.
        UPDATE `spawns_creatures` SET `position_z` = '54.663' WHERE (`spawn_id` = '16026');
        -- Syndicate Thief.
        UPDATE `spawns_creatures` SET `position_z` = '152.978' WHERE (`spawn_id` = '17381');
        -- Campfire.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '151.900' WHERE (`spawn_id` = '30093');
        -- Syndicate Documents.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '152.620' WHERE (`spawn_id` = '31397');
        -- Syndicate Thief.
        UPDATE `spawns_creatures` SET `position_z` = '153.889' WHERE (`spawn_id` = '17570');
        -- Nazen Mac'Nadir
        UPDATE `spawns_creatures` SET `position_z` = '95.491' WHERE (`spawn_id` = '26836');
        -- Campfire.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '89.174' WHERE (`spawn_id` = '45295');
        -- Food Crate.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '89.174' WHERE (`spawn_id` = '45483');
        -- Diseased Grizzly.
        UPDATE `spawns_creatures` SET `position_x` = '1886.817', `position_y` = '-1929.956', `position_z` = '62.966', `orientation` = '5.380' WHERE (`spawn_id` = '47226');
        -- Mist Lurker.
        UPDATE `spawns_creatures` SET `position_z` = '60.545' WHERE (`spawn_id` = '48036');
        -- Skeletal Executioner.
        UPDATE `spawns_creatures` SET `position_x` = '1364.261', `position_y` = '-1416.66', `position_z` = '72' WHERE (`spawn_id` = '48601');
        -- Skeletal Acolyte.
        UPDATE `spawns_creatures` SET `position_x` = '1560.694', `position_y` = '-1420.220', `position_z` = '70.605', `orientation` = '6.10' WHERE (`spawn_id` = '51736');
        -- Souless Ghoul.
        UPDATE `spawns_creatures` SET `position_x` = '1574.467', `position_y` = '-1653.277', `position_z` = '72.097', `orientation` = '5.715' WHERE (`spawn_id` = '51738');
        -- Murloc.
        UPDATE `spawns_creatures` SET `position_z` = '58.650' WHERE (`spawn_id` = '79619');
        -- Acolyte Dellis.
        UPDATE `spawns_creatures` SET `position_z` = '101.871' WHERE (`spawn_id` = '90459');
        -- Silvermane Wolf.
        UPDATE `spawns_creatures` SET `position_z` = '119.512' WHERE (`spawn_id` = '92970');
        -- Silvermane Stalker.
        UPDATE `spawns_creatures` SET `position_z` = '121.938' WHERE (`spawn_id` = '92985');
        -- Villebranch Axe Thrower.
        UPDATE `spawns_creatures` SET `position_z` = '141.803' WHERE (`spawn_id` = '93006');
        -- Villebranch Wolf Pup.
        UPDATE `spawns_creatures` SET `position_z` = '126.577' WHERE (`spawn_id` = '93021');
        -- Green Sludge.
        UPDATE `spawns_creatures` SET `position_x` = '331.625', `position_y` = '-3782.91', `position_z` = '100.885' WHERE (`spawn_id` = '93064');
        -- Primitive Owlbeast.
        UPDATE `spawns_creatures` SET `position_z` = '138.327' WHERE (`spawn_id` = '93148');
        -- Campfire.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '120.087' WHERE (`spawn_id` = '46055');
        -- Silvermane Wolf.
        UPDATE `spawns_creatures` SET `position_z` = '122.236' WHERE (`spawn_id` = '93239');
        -- Silvermane Wolf.
        UPDATE `spawns_creatures` SET `position_z` = '122.938' WHERE (`spawn_id` = '93364');
        -- Silvermane Wolf.
        UPDATE `spawns_creatures` SET `position_z` = '123.684' WHERE (`spawn_id` = '93494');
        -- Villebranch Axe Thrower.
        UPDATE `spawns_creatures` SET `position_z` = '127.424' WHERE (`spawn_id` = '93496');
        -- Villebranch Scalper.
        UPDATE `spawns_creatures` SET `position_z` = '121.377' WHERE (`spawn_id` = '93544');
        -- Villebranch Soothsayer.
        UPDATE `spawns_creatures` SET `position_z` = '120.509' WHERE (`spawn_id` = '93660');
        -- Silvermane Stalker.
        UPDATE `spawns_creatures` SET `position_z` = '121.401' WHERE (`spawn_id` = '93680');
        UPDATE `spawns_creatures` SET `position_z` = '123.097' WHERE (`spawn_id` = '93707');
        -- Villebranch Guard.
        UPDATE `spawns_creatures` SET `position_z` = '235.649' WHERE (`spawn_id` = '93708');
        -- Rabbit.
        UPDATE `spawns_creatures` SET `position_z` = '478.485' WHERE (`spawn_id` = '190185');
        UPDATE `spawns_creatures` SET `position_z` = '395.337' WHERE (`spawn_id` = '190187');
        UPDATE `spawns_creatures` SET `position_z` = '407' WHERE (`spawn_id` = '190188');
        -- Bear.
        UPDATE `spawns_creatures` SET `position_z` = '399.106' WHERE (`spawn_id` = '190244');
        UPDATE `spawns_creatures` SET `position_z` = '395.104' WHERE (`spawn_id` = '190245');
        UPDATE `spawns_creatures` SET `position_z` = '395.063' WHERE (`spawn_id` = '190246');
        -- Orgrimmar Grunt.
        UPDATE `spawns_creatures` SET `position_x` = '1925.720', `position_y` = '-4377.779', `position_z` = '21.193', `orientation` = '3.160' WHERE (`spawn_id` = '6564');
        -- Hyena.
        UPDATE `spawns_creatures` SET `position_z` = '95.959' WHERE (`spawn_id` = '13433');
        UPDATE `spawns_creatures` SET `position_z` = '100.528' WHERE (`spawn_id` = '13459');
        UPDATE `spawns_creatures` SET `position_z` = '93.372' WHERE (`spawn_id` = '13467');
        -- Southsea Cutthroat.
        UPDATE `spawns_creatures` SET `position_z` = '93.693' WHERE (`spawn_id` = '13832');
        UPDATE `spawns_creatures` SET `position_z` = '96.957' WHERE (`spawn_id` = '13856');
        -- Praire Dog.
        UPDATE `spawns_creatures` SET `position_z` = '93.950' WHERE (`spawn_id` = '13978');
        -- Kolkar.
        UPDATE `spawns_creatures` SET `position_z` = '94.659' WHERE (`spawn_id` = '14001');
        -- Slime.
        UPDATE `spawns_creatures` SET `position_z` = '94.012' WHERE (`spawn_id` = '14127');
        -- Mud Thresh.
        UPDATE `spawns_creatures` SET `position_x` = '-1215.639', `position_y` = '-3003.882', `position_z` = '87.152' WHERE (`spawn_id` = '14958');
        UPDATE `spawns_creatures` SET `position_x` = '-1271.202', `position_y` = '-3038.331', `position_z` = '86.71' WHERE (`spawn_id` = '14967');
        -- Darkfang Spider.
        UPDATE `spawns_creatures` SET `position_x` = '-4110.380', `position_y` = '-3839.736', `position_z` = '56.603' WHERE (`spawn_id` = '18637');
        -- Kolkar.
        UPDATE `spawns_creatures` SET `position_z` = '95.321' WHERE (`spawn_id` = '20474');
        UPDATE `spawns_creatures` SET `position_z` = '93.326' WHERE (`spawn_id` = '20483');
        -- Venture Co Overseer.
        UPDATE `spawns_creatures` SET `position_x` = '1263.020', `position_y` = '-3605.672', `position_z` = '114.233', `orientation` = '5.94' WHERE (`spawn_id` = '20834');
        -- Toad.
        UPDATE `spawns_creatures` SET `position_z` = '-271.313' WHERE (`spawn_id` = '24215');
        UPDATE `spawns_creatures` SET `position_z` = '-270.313' WHERE (`spawn_id` = '24216');
        UPDATE `spawns_creatures` SET `position_z` = '-269.313' WHERE (`spawn_id` = '24216');
        UPDATE `spawns_creatures` SET `position_z` = '-271.169' WHERE (`spawn_id` = '24222');
        UPDATE `spawns_creatures` SET `position_z` = '-273.540' WHERE (`spawn_id` = '24223');
        UPDATE `spawns_creatures` SET `position_z` = '-272.833' WHERE (`spawn_id` = '24228');
        UPDATE `spawns_creatures` SET `position_z` = '-268.500' WHERE (`spawn_id` = '24232');
        UPDATE `spawns_creatures` SET `position_z` = '-272.254' WHERE (`spawn_id` = '24234');
        UPDATE `spawns_creatures` SET `position_z` = '-272.107' WHERE (`spawn_id` = '24236');
        UPDATE `spawns_creatures` SET `position_z` = '-271.091' WHERE (`spawn_id` = '24238');
        UPDATE `spawns_creatures` SET `position_z` = '-271.228' WHERE (`spawn_id` = '24239');
        UPDATE `spawns_creatures` SET `position_z` = '-270.953' WHERE (`spawn_id` = '24243');
        UPDATE `spawns_creatures` SET `position_z` = '-271.320' WHERE (`spawn_id` = '24244');
        UPDATE `spawns_creatures` SET `position_z` = '-272.129' WHERE (`spawn_id` = '24250');
        -- Cenarion Caretaker.
        UPDATE `spawns_creatures` SET `position_x` = '2406.894', `position_y` = '1801.729', `position_z` = '354.771', `orientation` = '3.52' WHERE (`spawn_id` = '32206');
        -- Chylina.
        UPDATE `spawns_creatures` SET `position_x` = '2653.058', `position_y` = '1463.526', `position_z` = '228.697' WHERE (`spawn_id` = '32313');
        -- Illyanie.
        UPDATE `spawns_creatures` SET `position_x` = '2671.126', `position_y` = '1459.249', `position_z` = '229.598', `orientation` = '3.938' WHERE (`spawn_id` = '29249');
        -- Thistlefur Shaman.
        UPDATE `spawns_creatures` SET `position_z` = '102.074' WHERE (`spawn_id` = '32486');
        -- Deer.
        UPDATE `spawns_creatures` SET `position_z` = '140.300' WHERE (`spawn_id` = '32673');
        -- Burning Legionaire.
        UPDATE `spawns_creatures` SET `position_x` = '2227.682', `position_y` = '192.042', `position_z` = '133.389' WHERE (`spawn_id` = '33262');
        -- Moss Eater.
        UPDATE `spawns_creatures` SET `position_z` = '198.256' WHERE (`spawn_id` = '33330');
        -- Raincaller.
        UPDATE `spawns_creatures` SET `position_z` = '99.250' WHERE (`spawn_id` = '33469');
        -- Laughing Sister.
        UPDATE `spawns_creatures` SET `position_z` = '131.240' WHERE (`spawn_id` = '34196');
        -- Bear.
        UPDATE `spawns_creatures` SET `position_x` = '2221.124', `position_y` = '-1834.689', `position_z` = '86.554' WHERE (`spawn_id` = '34360');
        -- Wildhorn Satlker.
        UPDATE `spawns_creatures` SET `position_x` = '2747.392', `position_y` = '0.238', `position_z` = '105.818' WHERE (`spawn_id` = '34801');
        UPDATE `spawns_creatures` SET `position_z` = '94.4' WHERE (`spawn_id` = '34808');
        UPDATE `spawns_creatures` SET `position_z` = '120.797' WHERE (`spawn_id` = '34812');
        UPDATE `spawns_creatures` SET `position_z` = '130.436' WHERE (`spawn_id` = '34839');
        -- Wildhorn Venomspitter.
        UPDATE `spawns_creatures` SET `position_z` = '184.640' WHERE (`spawn_id` = '34893');
        -- Ghostpaw Runner.
        UPDATE `spawns_creatures` SET `position_z` = '96.707' WHERE (`spawn_id` = '34983');
        -- Darkstrand Fanatic.
        UPDATE `spawns_creatures` SET `position_z` = '38.086' WHERE (`spawn_id` = '36983');
        -- Squirrel.
        UPDATE `spawns_creatures` SET `position_z` = '466.500' WHERE (`spawn_id` = '42670');
        UPDATE `spawns_creatures` SET `position_z` = '460.432' WHERE (`spawn_id` = '42532');
        UPDATE `spawns_creatures` SET `position_z` = '462.1' WHERE (`spawn_id` = '42517');
        UPDATE `spawns_creatures` SET `position_z` = '470.214' WHERE (`spawn_id` = '42343');
        UPDATE `spawns_creatures` SET `position_z` = '476.1' WHERE (`spawn_id` = '42433');
        UPDATE `spawns_creatures` SET `position_x` = '7617.558', `position_y` = '-2999.218', `position_z` = '462.870' WHERE (`spawn_id` = '42456');
        -- Deer.
        UPDATE `spawns_creatures` SET `position_x` = '7425.207', `position_y` = '-2465.648', `position_z` = '463.889' WHERE (`spawn_id` = '42581');
        UPDATE `spawns_creatures` SET `position_z` = '464.2' WHERE (`spawn_id` = '42543');
        UPDATE `spawns_creatures` SET `position_z` = '467.668' WHERE (`spawn_id` = '42399');
        UPDATE `spawns_creatures` SET `position_z` = '467.686' WHERE (`spawn_id` = '42405');
        UPDATE `spawns_creatures` SET `position_z` = '462' WHERE (`spawn_id` = '42428');
        UPDATE `spawns_creatures` SET `position_x` = '7658.691', `position_y` = '-2980.364', `position_z` = '466.444' WHERE (`spawn_id` = '42495');
        -- Rabbit.
        UPDATE `spawns_creatures` SET `position_z` = '467.5' WHERE (`spawn_id` = '42470');
        UPDATE `spawns_creatures` SET `position_z` = '465.187' WHERE (`spawn_id` = '42473');
        -- Sea Elemental.
        UPDATE `spawns_creatures` SET `position_z` = '-0.526' WHERE (`spawn_id` = '50107');
        -- Woodpaw Trapper.
        UPDATE `spawns_creatures` SET `position_z` = '52.40' WHERE (`spawn_id` = '50425');
        -- Sprite Darter.
        UPDATE `spawns_creatures` SET `position_z` = '64' WHERE (`spawn_id` = '50788');
        -- Yeti.
        UPDATE `spawns_creatures` SET `position_z` = '143.5' WHERE (`spawn_id` = '51038');
        -- Frayfeather.
        UPDATE `spawns_creatures` SET `position_z` = '82' WHERE (`spawn_id` = '51189');
        UPDATE `spawns_creatures` SET `position_z` = '104' WHERE (`spawn_id` = '51215');
        -- Screecher.
        UPDATE `spawns_creatures` SET `position_z` = '96.266' WHERE (`spawn_id` = '51219');
        -- Barrel.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4962.120', `spawn_positionY` = '-920.009' WHERE (`spawn_id` = '938');
        -- Dwarven Fire.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1059');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1060');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1081');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1083');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1144');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1145');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12078');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12046');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12063');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12070');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12071');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12080');
        -- Chair
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '2524');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4079');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3762');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3441');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '10867');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '10865');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '10866');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12688');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17966');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42895');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42894');
        -- Leveler.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '32378');
        -- Chests.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42897');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42914');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42915');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42916');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42917');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42918');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42919');
        -- IF Signs.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4751.300', `spawn_positionY` = '-1161.560', `spawn_positionZ` = '497' WHERE (`spawn_id` = '5090');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4751.370', `spawn_positionY` = '-1160.840', `spawn_positionZ` = '497.000' WHERE (`spawn_id` = '5095');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4751.940', `spawn_positionY` = '-1161.370', `spawn_positionZ` = '497' WHERE (`spawn_id` = '5239');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4800.480', `spawn_positionY` = '-1041.220', `spawn_positionZ` = '487.300' WHERE (`spawn_id` = '6887');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4800.770', `spawn_positionY` = '-1040.600', `spawn_positionZ` = '487.300' WHERE (`spawn_id` = '6882');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4801.460', `spawn_positionY` = '-1040.930', `spawn_positionZ` = '487.300' WHERE (`spawn_id` = '6889');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4860.020', `spawn_positionY` = '-1089.370', `spawn_positionZ` = '487.300' WHERE (`spawn_id` = '6825');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4860.480', `spawn_positionY` = '-1090.010', `spawn_positionZ` = '487.300' WHERE (`spawn_id` = '6819');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4859.870', `spawn_positionY` = '-1090.590', `spawn_positionZ` = '487.300' WHERE (`spawn_id` = '6828');
        -- Wood Box.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-14295.380', `spawn_positionY` = '529.874', `spawn_positionZ` = '8.928' WHERE (`spawn_id` = '11014');
        -- Chest.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-11372.392', `spawn_positionY` = '-683.598', `spawn_positionZ` = '17.080' WHERE (`spawn_id` = '11090');
        -- Silver Vein.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-11488.242', `spawn_positionY` = '-721.752', `spawn_positionZ` = '34.315' WHERE (`spawn_id` = '11983');
        -- Mythril Vein.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-11214.771', `spawn_positionY` = '-882.049', `spawn_positionZ` = '79.400' WHERE (`spawn_id` = '11990');
        -- Barrel.
        UPDATE `spawns_gameobjects` SET `spawn_positionY` = '-3390.197', `spawn_positionZ` = '271.787' WHERE (`spawn_id` = '12767');
        -- Blasted Lands invalid gos. (Flying chairs, camp fires, etc)
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12827');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12810');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12809');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12802');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12786');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12777');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12772');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12688');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12875');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12876');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12830');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12869');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12870');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12866');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12867');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12831');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12869');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12868');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12843');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12874');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12865');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12844');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12855');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12861');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12858');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12851');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12841');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12776');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12777');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12779');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12786');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12788');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12798');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12799');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12802');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12809');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12810');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12827');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12830');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12831');
        -- Alterac Granite.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-248.662', `spawn_positionY` = '-350.557', `spawn_positionZ` = '67.356' WHERE (`spawn_id` = '31335');
        
        -- IF Guard wps.
        DELETE FROM creature_movement WHERE id = 1760;
        INSERT INTO creature_movement (id, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (1760, 0, -4671.36, -908.789, 519.855, 0, 0, 0, 0),
        (1760, 1, -4676.429, -914.916, 519.882, 0, 0, 0, 0),
        (1760, 2, -4678.071, -916.901, 521.272, 0, 0, 0, 0),
        (1760, 3, -4711.074, -954.825, 521.272, 0, 0, 0, 0),
        (1760, 4, -4716.902, -951.049, 521.186, 0, 0, 0, 0),
        (1760, 5, -4726.616, -944.15, 512.939, 0, 0, 0, 0),
        (1760, 6, -4729.123, -939.268, 512.939, 0, 0, 0, 0),
        (1760, 7, -4706.806, -901.078, 512.939, 0, 0, 0, 0),
        (1760, 8, -4703.058, -903.82, 512.94, 0, 0, 0, 0),
        (1760, 9, -4688.033, -913.839, 501.659, 0, 0, 0, 0),
        (1760, 10, -4626.902, -988.39, 501.659, 0, 0, 0, 0),
        (1760, 11, -4618.999, -1005.044, 512.94, 0, 0, 0, 0),
        (1760, 12, -4618.37, -1009.836, 512.939, 0, 0, 0, 0),
        (1760, 13, -4658.048, -1024.187, 512.939, 0, 0, 0, 0),
        (1760, 14, -4663.137, -1020.555, 512.939, 0, 0, 0, 0),
        (1760, 15, -4668.05, -1009.673, 521.272, 0, 0, 0, 0),
        (1760, 16, -4668.954, -1002.675, 521.272, 0, 0, 0, 0),
        (1760, 17, -4627.092, -978.93, 521.272, 0, 0, 0, 0),
        (1760, 18, -4624.962, -977.476, 519.883, 0, 0, 0, 0),
        (1760, 19, -4621.117, -970.261, 519.879, 0, 0, 0, 0),
        (1760, 20, -4668.112, -914.681, 519.87, 0, 0, 0, 0);

        -- Booty Bay Bruiser wps.
        DELETE FROM creature_movement WHERE id = 598;
        INSERT INTO creature_movement (id, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (598, 0, -14392.1, 420.434, 7.54, 0, 0, 0, 0),
        (598, 1, -14380.348, 426.231, 7.37, 0, 0, 0, 0),
        (598, 2, -14357.271, 435.996, 7.37, 0, 0, 0, 0),
        (598, 3, -14341.761, 445.697, 7.499, 0, 0, 0, 0),
        (598, 4, -14331.933, 458.173, 7.877, 0, 0, 0, 0),
        (598, 5, -14321.324, 478.657, 8.568, 0, 0, 0, 0),
        (598, 6, -14304.954, 514.336, 8.768, 0, 0, 0, 0),
        (598, 7, -14303.029, 524.504, 8.82, 0, 0, 0, 0),
        (598, 8, -14297.663, 530.791, 8.846, 0, 0, 0, 0),
        (598, 9, -14302.79, 523.889, 8.816, 0, 0, 0, 0),
        (598, 10, -14312.129, 499.823, 8.693, 0, 0, 0, 0),
        (598, 11, -14331.256, 460.135, 7.942, 0, 0, 0, 0),
        (598, 12, -14345.993, 443.564, 7.467, 0, 0, 0, 0),
        (598, 13, -14356.036, 436.429, 7.371, 0, 0, 0, 0),
        (598, 14, -14390.647, 423.148, 7.429, 0, 0, 0, 0),
        (598, 15, -14401.684, 422.577, 8.224, 0, 0, 0, 0),
        (598, 16, -14423.522, 430.238, 8.972, 0, 0, 0, 0),
        (598, 17, -14434.101, 447.216, 3.71, 0, 0, 0, 0),
        (598, 18, -14447.857, 439.249, 3.933, 0, 0, 0, 0),
        (598, 19, -14431.171, 454.303, 3.694, 0, 0, 0, 0),
        (598, 20, -14432.794, 446.862, 3.711, 0, 0, 0, 0),
        (598, 21, -14424.431, 431.198, 8.681, 0, 0, 0, 0),
        (598, 22, -14404.245, 419.882, 8.335, 0, 0, 0, 0),
        (598, 23, -14391.788, 400.846, 6.432, 0, 0, 0, 0),
        (598, 24, -14355.317, 415.074, 6.63, 0, 0, 0, 0),
        (598, 25, -14361.736, 433.171, 7.365, 0, 0, 0, 0),
        (598, 26, -14397.358, 421.517, 7.809, 0, 0, 0, 0);

        insert into applied_updates values ('011220251');
    end if;

    -- 11/12/2025 1
    if (select count(*) from applied_updates where id='111220251') = 0 then

        -- Fix some virtual monster items.

        -- Defias Smuggler
        -- Blue Dragonspawn
        -- Mazen Mac'Nadir - (Texture Set)
        -- Shaethis Darkoak
        -- Dalaran Watcher
        -- Dalaran Shield Guard
        -- Muckrake
        -- Novice Thaivand
        -- Forsaken Courier
        -- Shadowforge Warrior
        -- Gabrielle Chase
        -- Olthran Craghelm
        -- Myizz Luckycatch
        -- Horde Guard

        -- Monster - Throwing Knife.
        UPDATE `item_template` SET `display_id` = '4678', `ignored` = '0' WHERE (`entry` = '6886');
        -- Monster - Orb.
        UPDATE `item_template` SET `display_id` = '5566', `ignored` = '0' WHERE (`entry` = '6618');
        -- Monster - Spear, Sharp Thin.
        UPDATE `item_template` SET `display_id` = '7978', `ignored` = '0' WHERE (`entry` = '6680');
        -- Monster - Tankards.
        UPDATE `item_template` SET `display_id` = '6586', `ignored` = '0' WHERE (`entry` = '13861');
        UPDATE `item_template` SET `display_id` = '6586', `ignored` = '0' WHERE (`entry` = '13862');
        UPDATE `item_template` SET `display_id` = '6588', `ignored` = '0' WHERE (`entry` = '13859');
        UPDATE `item_template` SET `display_id` = '6587', `ignored` = '0' WHERE (`entry` = '13855');
        UPDATE `item_template` SET `display_id` = '4861', `ignored` = '0' WHERE (`entry` = '13854');
        -- Myizz Luckycatch - Holds fish.
        UPDATE `creature_equip_template` SET `equipentry1` = '6225' WHERE (`entry` = '2834');
        -- Monster - Shield, Kite Metal Gold. Olthran Craghelm 
        UPDATE `item_template` SET `display_id` = '1705', `ignored` = '0' WHERE (`entry` = '11041');
        -- Hammerfall Grunts.
        UPDATE `creature_equip_template` SET `equipentry1` = '5289' WHERE (`entry` = '2619');
        -- Monster - Staff, Basic Red.
        UPDATE `item_template` SET `ignored` = '0' WHERE (`entry` = '12937');
        -- Monster - Staff, 3 Piece Taped Staff Green.
        UPDATE `item_template` SET `display_id` = '1201', `ignored` = '0' WHERE (`entry` = '12328');
        -- Horde Guard.
        UPDATE `creature_equip_template` SET `equipentry1` = '1905' WHERE (`entry` = '3501');


        -- Close 1587
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5891.505', `spawn_positionY` = '-2854.249', `spawn_positionZ` = '372.107' WHERE (`spawn_id` = '112667');
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '371.836' WHERE (`spawn_id` = '12819');

        -- Missing riding wolves at Crossroads. https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Barrens/images_6626.jpg
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400472', '5197', '0', '0', '0', '1', '-433.731', '-2644.658', '96.539', '0.187', '270', '270', '0', '100', '0', '0', '0', '0', '0');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400473', '5196', '0', '0', '0', '1', '-432.375', '-2650.784', '96.511', '0.139', '270', '270', '0', '100', '0', '0', '0', '0', '0');

        -- Barrel of Milk.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-6.370' WHERE (`spawn_id` = '43007');
        
        -- Monster - Gun.
        UPDATE `creature_equip_template` SET `equipentry3` = '2552' WHERE `equipentry3` = '12523' or `equipentry3` = '14642';
        
        -- Zizzek, placement.
        UPDATE `spawns_creatures` SET `position_x` = '-1020.966', `position_y` = '-3661.982', `position_z` = '22.367', `orientation` = '5.666' WHERE (`spawn_id` = '20948');
        
        -- Dun Garok Mountaneers. https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Hillsbrad%20Foothills/WoWScrnShot_052004_204918.jpg
        UPDATE `creature_equip_template` SET `equipentry1` = '2695' WHERE (`entry` = '2344');
        
        -- Kazon - Monster - Mace2H, Kazon's Maul
        UPDATE `item_template` SET `ignored` = '0' WHERE (`entry` = '10685');
        -- Kazon, faction.
        UPDATE `creature_template` SET `faction` = '40' WHERE (`entry` = '584');

        -- Campfire Z.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '155.916' WHERE (`spawn_id` = '34846');

        -- Monster - Mace, Tauren Spiked.
        UPDATE `item_template` SET `ignored` = '0' WHERE (`entry` = '9659');

        -- Monster - Dagger, Tanto Blade
        -- Monster - Sword, Horde Jagged Green
        UPDATE `item_template` SET `ignored` = '0' WHERE (`entry` = '10618');
        UPDATE `item_template` SET `ignored` = '0' WHERE (`entry` = '10878');

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1590
        UPDATE `quest_template` SET `Objectives` = 'Return to Shandris Feathermoon in Darnassus.' WHERE (`entry` = '1044');
        UPDATE `creature_quest_finisher` SET `entry` = '3936' WHERE (`entry` = '8026') and (`quest` = '1044');

        -- Empty vendor template.
        INSERT INTO `npc_vendor_template` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `condition_id`, `slot`) VALUES ('4000000', '0', '0', '0', '0', '0', '0');
        
        -- Boat Vendor and Pirate Supplies did open vendor frame, just empty. (This probably applies to Cartography vendors and others)
        UPDATE `creature_template` SET `npc_flags` = '1', `vendor_id` = '4000000' WHERE (`entry` = '2662');
        UPDATE `creature_template` SET `npc_flags` = '1', `vendor_id` = '4000000' WHERE (`entry` = '2663');

        -- Yance Kelsey <Cook>, use default model.
        UPDATE `creature_template` SET `display_id1` = '1140' WHERE (`entry` = '2664');

        -- Haren Kanmae <Superior Bower>, use default model.
        UPDATE `creature_template` SET `display_id1` = '1140' WHERE (`entry` = '2839');

        -- Black Swashbuckler's Shirt -> Swashbuckler's Shirt from spell 3873.
        UPDATE `item_template` SET `name` = 'Swashbuckler\'s Shirt', `display_id` = '7847' WHERE (`entry` = '4336');
        
        -- Ratchet burried go's.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE `spawn_id` IN ('13050', 13058, 13151, 13035, 13076, 13063);

        -- Book - Mount Hyjal and Illidan's Gift - Placement.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1003.186', `spawn_positionY` = '-3652.592', `spawn_positionZ` = '25.560' WHERE (`spawn_id` = '13461');

        -- Brewmaster Drohn - Faction.
        UPDATE `creature_template` SET `faction` = '121' WHERE (`entry` = '3292');

        -- Food Crate.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1014.084', `spawn_positionY` = '-3659.752', `spawn_positionZ` = '21.976' WHERE (`spawn_id` = '46847');
        
        -- Theramore Marine.
        UPDATE `spawns_creatures` SET `position_x` = '-2058.161', `position_y` = '-3675.024', `position_z` = '23.843', `orientation` = '2.853' WHERE (`spawn_id` = '13906');

        -- Theramore Preserver.
        UPDATE `spawns_creatures` SET `position_x` = '-2059.504', `position_y` = '-3671.873', `position_z` = '23.830', `orientation` = '3.045' WHERE (`spawn_id` = '13939');

        -- Palomino.
        UPDATE `spawns_creatures` SET `position_x` = '-2088.872', `position_y` = '-3684.154', `position_z` = '34.631', `orientation` = '1.341' WHERE (`spawn_id` = '13182');

        -- Barrel of Milk.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2074.703', `spawn_positionY` = '-3665.133', `spawn_positionZ` = '33.137' WHERE (`spawn_id` = '46915');

        -- Tin Vein.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2117.118', `spawn_positionY` = '-3654.103', `spawn_positionZ` = '45.404' WHERE (`spawn_id` = '34617');

        -- Campfire.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE `spawn_id` = '13479';

        -- Theramore Marine, placement, wps.
        UPDATE `spawns_creatures` SET `position_x` = '-2060.183', `position_y` = '-3682.365', `position_z` = '50.602', `orientation` = '2.871' WHERE (`spawn_id` = '13867');

        DELETE FROM creature_movement WHERE id = 13867;
        INSERT INTO creature_movement (id, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (13867, 0, -2060.183, -3682.365, 50.602, 0, 0, 0, 0),
        (13867, 1, -2099.041, -3670.462, 50.236, 0, 0, 0, 0),
        (13867, 2, -2098.516, -3666.592, 49.916, 0, 0, 0, 0),
        (13867, 3, -2095.103, -3656.417, 45.472, 0, 0, 0, 0),
        (13867, 4, -2086.33, -3630.918, 41.872, 0, 0, 0, 0),
        (13867, 5, -2087.715, -3625.833, 41.873, 0, 0, 0, 0),
        (13867, 6, -2082.895, -3626.759, 41.873, 0, 0, 0, 0),
        (13867, 7, -2077.09, -3633.4, 41.346, 0, 0, 0, 0),
        (13867, 8, -2053.668, -3640.878, 37.119, 0, 0, 0, 0),
        (13867, 9, -2049.473, -3638.781, 37.093, 0, 0, 0, 0),
        (13867, 10, -2042.792, -3640.042, 37.085, 0, 0, 0, 0),
        (13867, 11, -2042.234, -3642.57, 37.085, 0, 0, 0, 0),
        (13867, 12, -2043.829, -3646.621, 37.087, 0, 0, 0, 0),
        (13867, 13, -2049.074, -3650.867, 37.113, 0, 0, 0, 0),
        (13867, 14, -2056.613, -3675.836, 37.116, 0, 0, 0, 0),
        (13867, 15, -2060.093, -3686.559, 37.124, 0, 0, 0, 0),
        (13867, 16, -2058.655, -3691.364, 34.208, 0, 0, 0, 0),
        (13867, 17, -2052.444, -3692.934, 30.325, 0, 0, 0, 0),
        (13867, 18, -2049.412, -3686.353, 26.57, 0, 0, 0, 0),
        (13867, 19, -2056.609, -3681.23, 23.765, 0, 0, 0, 0),
        (13867, 20, -2067.878, -3669.678, 25.819, 0, 0, 0, 0),
        (13867, 21, -2063.224, -3648.426, 25.142, 0, 0, 0, 0),
        (13867, 22, -2072.886, -3642.437, 27.649, 0, 0, 0, 0),
        (13867, 23, -2082.779, -3644.606, 30.558, 0, 0, 0, 0),
        (13867, 24, -2088.738, -3657.479, 33.455, 0, 0, 0, 0),
        (13867, 25, -2080.013, -3670.799, 33.826, 0, 0, 0, 0),
        (13867, 26, -2078.601, -3664.799, 33.449, 0, 0, 0, 0),
        (13867, 27, -2084.94, -3660.143, 33.56, 0, 0, 0, 0),
        (13867, 28, -2082.185, -3648.152, 31.131, 0, 0, 0, 0),
        (13867, 29, -2071.48, -3642.746, 27.279, 0, 0, 0, 0),
        (13867, 30, -2063.861, -3646.44, 25.386, 0, 0, 0, 0),
        (13867, 31, -2066.813, -3673.672, 25.459, 0, 0, 0, 0),
        (13867, 32, -2054.032, -3682.396, 23.914, 0, 0, 0, 0),
        (13867, 33, -2050.184, -3685.967, 26.123, 0, 0, 0, 0),
        (13867, 34, -2050.265, -3690.838, 28.903, 0, 0, 0, 0),
        (13867, 35, -2054.181, -3693.444, 31.414, 0, 0, 0, 0),
        (13867, 36, -2057.698, -3692.621, 33.134, 0, 0, 0, 0),
        (13867, 37, -2059.927, -3688.18, 36.03, 0, 0, 0, 0),
        (13867, 38, -2059.082, -3685.584, 37.116, 0, 0, 0, 0),
        (13867, 39, -2052.125, -3683.075, 37.56, 0, 0, 0, 0),
        (13867, 40, -2049.944, -3686.467, 39.855, 0, 0, 0, 0),
        (13867, 41, -2051.048, -3690.65, 42.294, 0, 0, 0, 0),
        (13867, 42, -2054.592, -3693.056, 45.098, 0, 0, 0, 0),
        (13867, 43, -2058.164, -3691.819, 47.478, 0, 0, 0, 0),
        (13867, 44, -2059.42, -3688.809, 49.28, 0, 0, 0, 0),
        (13867, 45, -2058.688, -3683.031, 50.603, 0, 0, 0, 0);

        -- Barrel of Milk.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '46921');

        -- Fuel Control Valve, better rotation.
        UPDATE `spawns_gameobjects` SET `spawn_rotation0` = '0.3', `spawn_rotation1` = '0.1' WHERE (`spawn_id` = '15731');
    
        -- Heated Forge.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '371.867', `spawn_positionY` = '-4709.689', `spawn_positionZ` = '15.470' WHERE (`spawn_id` = '12079');

        -- Bubbling Cauldron fire dmg.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '331.229', `spawn_positionY` = '-4707.58', `spawn_positionZ` = '13.714' WHERE (`spawn_id` = '1672');

        -- Monster - Axe, Horde Badass 01 -> Monster - Axe, Metal Basic.
        UPDATE creature_equip_template SET 
        equipentry1 = REPLACE(equipentry1, '10611', '1905'),
        equipentry2 = REPLACE(equipentry2, '10611', '1905'),
        equipentry3 = REPLACE(equipentry3, '10611', '1905');

        -- Monster - Axe, Horde Badass 02 -> Monster - Axe, Metal Basic.
        UPDATE creature_equip_template SET 
        equipentry1 = REPLACE(equipentry1, '10612', '1905'),
        equipentry2 = REPLACE(equipentry2, '10612', '1905'),
        equipentry3 = REPLACE(equipentry3, '10612', '1905');

        -- Monster - Shield, Horde A02 Silver -> Monster - Shield, Small Wooden.
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Durotar/worldofwarcraft__041604_009-806500.jpg
        UPDATE creature_equip_template SET 
        equipentry1 = REPLACE(equipentry1, '12452', '1957'),
        equipentry2 = REPLACE(equipentry2, '12452', '1957'),
        equipentry3 = REPLACE(equipentry3, '12452', '1957');

        -- Monster - Dagger, Dark Pronged -> Monster - Dagger, Ornate Spikey Base.
        UPDATE creature_equip_template SET 
        equipentry1 = REPLACE(equipentry1, '12298', '5283'),
        equipentry2 = REPLACE(equipentry2, '12298', '5283'),
        equipentry3 = REPLACE(equipentry3, '12298', '5283');

        -- Barrel of Milk.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.309' WHERE (`spawn_id` = '44017');

        -- Water Barrel.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '319.268', `spawn_positionY` = '-4698.650', `spawn_positionZ` = '15.792' WHERE (`spawn_id` = '44047');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '295.741', `spawn_positionY` = '-4785.289', `spawn_positionZ` = '10.610' WHERE (`spawn_id` = '44046');
               
        -- https://github.com/The-Alpha-Project/alpha-core/issues/1591
        UPDATE `spawns_creatures` SET `position_x` = '10892.097', `position_y` = '924.519', `position_z` = '1318.714', `orientation` = '0.738' WHERE (`spawn_id` = '47350');

        -- Chest.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10917.351', `spawn_positionY` = '958.497', `spawn_positionZ` = '1321.215' WHERE (`spawn_id` = '60010');

        insert into applied_updates values ('111220251');
    end if;

    -- 15/12/2025 1
    if (select count(*) from applied_updates where id='151220251') = 0 then
        -- Set empty vendor inventory for Cartography Supplier NPCs.
        UPDATE `creature_template` SET `npc_flags` = '1', `vendor_id` = '4000000' WHERE (`entry` = '372');
        UPDATE `creature_template` SET `npc_flags` = '1', `vendor_id` = '4000000' WHERE (`entry` = '4224');
        UPDATE `creature_template` SET `npc_flags` = '1', `vendor_id` = '4000000' WHERE (`entry` = '5135');

        insert into applied_updates values ('151220251');
    end if;

    -- 16/12/2025 1
    if (select count(*) from applied_updates where id='161220251') = 0 then
        -- Grizzle Halfmane - Cast Spell Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=34701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (34701, 0, 0, 15, 7371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Grizzle Halfmane - Cast Spell Cleave');

        -- Fenros - Cast Spell Frost Armor
        DELETE FROM `creature_ai_scripts` WHERE `id`=50704;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (50704, 0, 0, 15, 7301, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fenros - Cast Spell Frost Armor');

        -- King Bangalash - Cast Spell Summon Panthers
        DELETE FROM `creature_ai_scripts` WHERE `id`=73101;

        -- Lost One Riftseeker - Cast Spell Summon Imp
        DELETE FROM `creature_ai_scripts` WHERE `id`=76202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (76202, 0, 0, 15, 688, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lost One Riftseeker - Cast Spell Summon Imp');

        -- Kurzen Commando - Cast Spell Smoke Bomb
        DELETE FROM `creature_ai_scripts` WHERE `id`=93803;

        -- Archbishop Benedictus - Cast Spell Power Word: Shield - Holy Word: Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=128403;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (128403, 0, 0, 15, 600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archbishop Benedictus - Cast Spell Holy Word: Shield'),
        (128403, 0, 0, 44, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archbishop Benedictus - Increment Phase');

        -- Archbishop Benedictus - Cast Spell Holy Smite
        DELETE FROM `creature_ai_scripts` WHERE `id`=128404;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (128404, 0, 0, 15, 6060, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archbishop Benedictus - Cast Spell Holy Smite');

        -- Archbishop Benedictus - Cast Spell Frost Nova
        DELETE FROM `creature_ai_scripts` WHERE `id`=128405;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (128405, 0, 0, 15, 6131, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archbishop Benedictus - Cast Spell Frost Nova');

        -- Archbishop Benedictus - Cast Spell Holy Word: Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=128412;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (128412, 0, 0, 15, 600, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archbishop Benedictus - Cast Spell Holy Word: Shield');

        -- Bloodsail Warlock - Summon Succubus.
        DELETE FROM `creature_ai_scripts` WHERE `id`=156406;

        -- Bloodsail Warlock - Cast Spell Summon Imp.
        DELETE FROM `creature_ai_scripts` WHERE `id`=156403;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (156403, 0, 0, 15, 688, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodsail Warlock - Cast Spell Summon Imp');

        -- Bloodsail Warlock - Summon Imp
        DELETE FROM `creature_ai_scripts` WHERE `id`=156405;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (156405, 0, 0, 15, 688, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodsail Warlock - Summon Imp');

        -- Defias Evoker - Cast Spell Frost Armor
        DELETE FROM `creature_ai_scripts` WHERE `id`=172904;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (172904, 0, 0, 15, 7300, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Evoker - Cast Spell Frost Armor');

        -- Flesh Golem - Cast Spell Uppercut
        DELETE FROM `creature_ai_scripts` WHERE `id`=180502;

        -- Devouring Ooze - Cast Spell Summon Oozeling
        DELETE FROM `creature_ai_scripts` WHERE `id`=180802;

        -- Darkmaster Gandling - Cast Shadow Portal
        DELETE FROM `creature_ai_scripts` WHERE `id`=185304;

        -- Scarlet Smith - Cast Spell Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=188501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (188501, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Smith - Cast Spell Strike');

        -- Scarlet Smith - Cast Spell Knockdown
        DELETE FROM `creature_ai_scripts` WHERE `id`=188502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (188502, 0, 0, 15, 6961, 1, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Smith - Cast Spell Knockdown');

        -- Farmer Solliden - Cast Spell Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=193601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (193601, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Farmer Solliden - Cast Spell Strike');

        -- Feral Nightsaber - Cast Spell Rend
        DELETE FROM `creature_ai_scripts` WHERE `id`=203401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (203401, 0, 0, 15, 6547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Feral Nightsaber - Cast Spell Rend');

        -- Reef Crawler - Cast Spell Rend
        DELETE FROM `creature_ai_scripts` WHERE `id`=223501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (223501, 0, 0, 15, 6547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Reef Crawler - Cast Spell Rend');

        -- Witherbark Shadowcaster - Cast Spell Summon Imp
        DELETE FROM `creature_ai_scripts` WHERE `id`=255302;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (255302, 0, 0, 15, 688, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Witherbark Shadowcaster - Cast Spell Summon Imp');

        -- Invalid.
        DELETE FROM `creature_ai_scripts` WHERE `id`=1659201;

        -- Stromgarde Vindicator - Cast Crazed Hunger
        DELETE FROM `creature_ai_scripts` WHERE `id`=258501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (258501, 0, 0, 15, 3151, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stromgarde Vindicator - Cast Crazed Hunger');

        -- Human Skull - Cast Summon Human Skull aand Event.
        DELETE FROM `creature_ai_scripts` WHERE `id`=1220201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (1220201, 0, 0, 39, 0, 0, 0, 0, 11885, 40, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Human Skull - Start Event Script');

        -- Vilebranch Soul Eater - Cast Spell Soul Drain
        DELETE FROM `creature_ai_scripts` WHERE `id`=264701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (264701, 0, 0, 15, 7295, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Soul Eater - Cast Spell Soul Drain');

        -- Vilebranch Aman zasi Guard - Cast Spell Shield Bash
        DELETE FROM `creature_ai_scripts` WHERE `id`=264801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (264801, 0, 0, 15, 1672, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Aman zasi Guard - Cast Spell Shield Bash');

        -- Witherbark Broodguard - Cast Spell Summon Witherbark Bloodlings
        DELETE FROM `creature_ai_scripts` WHERE `id`=268601;

        -- Dustbelcher Wyrmhunter - Cast Spell Throw Rock
        DELETE FROM `creature_ai_scripts` WHERE `id`=271601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (271601, 0, 0, 15, 4165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dustbelcher Wyrmhunter - Cast Spell Throw Rock');

        -- Vicious Owlbeast - Cast Spell Fatal Bite
        DELETE FROM `creature_ai_scripts` WHERE `id`=292701;

        -- Bristleback Interloper - Cast Spell Rend
        DELETE FROM `creature_ai_scripts` WHERE `id`=323201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (323201, 0, 0, 15, 772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bristleback Interloper - Cast Spell Rend');

        -- Twilight Fire Guard - Cast Spell Fire Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=586101;

        -- Deviate Slayer - Cast Spell Fatal Bite
        DELETE FROM `creature_ai_scripts` WHERE `id`=363301;

        -- Mad Magglish - Cast Spell Smoke Bomb
        DELETE FROM `creature_ai_scripts` WHERE `id`=365502;

        -- Lord Cobrahn - Cast Spell Cobrahn Serpent Form
        DELETE FROM `creature_ai_scripts` WHERE `id`=366903;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (366903, 0, 0, 39, 1, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Enable Attack and Combat Movement'),
        (366903, 0, 0, 55, 36691, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Set Spells Template'),
        (366903, 0, 0, 44, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lord Cobrahn - Set Phase to 1');

        -- Boahn - Cast Serpent Form
        DELETE FROM `creature_ai_scripts` WHERE `id`=367202;

        -- Biletoad - Cast Spell Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=383501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (383501, 0, 0, 15, 744, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Biletoad - Cast Spell Poison');

        -- Thistlefur Avenger - Cast Spell Crazed Hunger
        DELETE FROM `creature_ai_scripts` WHERE `id`=392502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (392502, 0, 0, 15, 3151, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thistlefur Avenger - Cast Spell Crazed Hunger'),
        (392502, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1151, 0, 0, 0, 0, 0, 0, 0, 0, 'Thistlefur Avenger - Say Text');

        -- Mirkfallon Keeper - Cast Spell Mirkfallon Fungus
        DELETE FROM `creature_ai_scripts` WHERE `id`=405601;

        -- Silithid Invader - Cast Spell Silithid Pox
        DELETE FROM `creature_ai_scripts` WHERE `id`=413102;

        -- Firemane Ash Tail - Cast Spell Fire Blast
        DELETE FROM `creature_ai_scripts` WHERE `id`=433102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (433102, 0, 0, 15, 2138, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Firemane Ash Tail - Cast Spell Fire Blast');

        -- Firemane Ash Tail - Cast Spell Fire Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=433103;

        -- Brimgore - Cast Spell Flame Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=433901;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (433901, 0, 0, 15, 6725, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Brimgore - Cast Spell Flame Strike');

        -- Darkmist Widow - Cast Spell CustomSpell
        DELETE FROM `creature_ai_scripts` WHERE `id`=438002;

        -- Acidic Swamp Ooze - Cast Spell Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=439301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (439301, 0, 0, 15, 744, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Acidic Swamp Ooze - Cast Spell Poison');

        -- Charlga Razorflank - Cast Spell Restore Mana
        DELETE FROM `creature_ai_scripts` WHERE `id`=442101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (442101, 0, 0, 15, 438, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Charlga Razorflank - Cast Spell Restore Mana');

        -- Rotting Agam ar - Cast Spell Cursed Blood
        DELETE FROM `creature_ai_scripts` WHERE `id`=451201;

        -- Razorfen Geomancer - Cast Spell Summon Earth Rumbler
        DELETE FROM `creature_ai_scripts` WHERE `id`=452002;

        -- Razorfen Dustweaver - Cast Spell Summon Wind Howler
        DELETE FROM `creature_ai_scripts` WHERE `id`=452201;

        -- Razorfen Groundshaker - Cast Spell Earth Shock
        DELETE FROM `creature_ai_scripts` WHERE `id`=452301;

        -- Razorfen Earthbreaker - Cast Spell Earth Shock
        DELETE FROM `creature_ai_scripts` WHERE `id`=452501;

        -- Razorfen Beast Trainer - Cast Spell Summon Tamed Boar
        DELETE FROM `creature_ai_scripts` WHERE `id`=453101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (453101, 0, 0, 15, 7905, 7, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Beast Trainer - Cast Spell Summon Tamed Boar');

        -- Razorfen Beastmaster - Cast Spell Summon Tamed Hyena
        DELETE FROM `creature_ai_scripts` WHERE `id`=453202;

        -- Greater Kraul Bat - Cast Spell Sonic Burst
        DELETE FROM `creature_ai_scripts` WHERE `id`=453901;

        -- Blood of Agamaggan - Cast Spell Curse of Blood
        DELETE FROM `creature_ai_scripts` WHERE `id`=454101;

        -- Gelkis Earthcaller - Cast Spell Summon Gelkis Rumbler
        DELETE FROM `creature_ai_scripts` WHERE `id`=465101;

        -- Maraudine Stormer - Cast Spell Chain Lightning
        DELETE FROM `creature_ai_scripts` WHERE `id`=465803;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (465803, 0, 0, 15, 421, 1, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Stormer - Cast Spell Chain Lightning');

        -- Burning Blade Reaver - Cast Spell Swipe
        DELETE FROM `creature_ai_scripts` WHERE `id`=466401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (466401, 0, 0, 15, 780, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Blade Reaver - Cast Spell Swipe');

        -- Hukku's Imp - Cast Fireball
        DELETE FROM `creature_ai_scripts` WHERE `id`=865801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (865801, 0, 0, 15, 854, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hukku''s Imp - Cast Fireball');

        -- Burning Blade Invoker - Cast Spell Flamestrike
        DELETE FROM `creature_ai_scripts` WHERE `id`=470501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (470501, 0, 0, 15, 2120, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Blade Invoker - Cast Spell Flamestrike');

        -- Twilight Aquamancer - Cast Spell Summon Water Elemental
        DELETE FROM `creature_ai_scripts` WHERE `id`=481102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (481102, 0, 0, 15, 765, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Aquamancer - Cast Spell Summon Water Elemental');

        -- Twilight Loreseeker - Cast Spell Strength of Stone
        DELETE FROM `creature_ai_scripts` WHERE `id`=481202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (481202, 0, 0, 15, 6864, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Loreseeker - Cast Spell Strength of Stone');

        -- Earthcaller Halmgar - Cast Spell Summon Earth Rumbler
        DELETE FROM `creature_ai_scripts` WHERE `id`=484202;

        -- Stone Keeper - Cast Spell Stoned
        DELETE FROM `creature_ai_scripts` WHERE `id`=485701;

        -- Stone Keeper - Cast Spell Stoned
        DELETE FROM `creature_ai_scripts` WHERE `id`=485703;

        -- Stone Keeper - Cast Spell Self Destruct
        DELETE FROM `creature_ai_scripts` WHERE `id`=485704;

        -- Saturated Ooze - Cast Spell Summon Oozeling
        DELETE FROM `creature_ai_scripts` WHERE `id`=522802;

        -- Atal ai Corpse Eater - Cast Spell Atal ai Corpse Eat
        DELETE FROM `creature_ai_scripts` WHERE `id`=527001;

        -- Atal ai Deathwalker - Cast Spell Summon Atal ai Deathwalker s Spirit
        DELETE FROM `creature_ai_scripts` WHERE `id`=527103;

        -- Atal ai High Priest - Cast Spell Shadow Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=527301;

        -- Vale Screecher - Cast Spell Sonic Burst
        DELETE FROM `creature_ai_scripts` WHERE `id`=530701;

        -- Rogue Vale Screecher - Cast Spell Sonic Burst
        DELETE FROM `creature_ai_scripts` WHERE `id`=530801;

        -- Jademir Boughguard - Cast Spell Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=532001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (532001, 0, 0, 15, 7371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jademir Boughguard - Cast Spell Cleave');

        -- Hatecrest Serpent Guard - Cast Spell Frost Shot
        DELETE FROM `creature_ai_scripts` WHERE `id`=533301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (533301, 0, 0, 15, 6985, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatecrest Serpent Guard - Cast Spell Frost Shot');

        -- Northspring Harpy - Cast Spell Flow of the Northspring
        DELETE FROM `creature_ai_scripts` WHERE `id`=536201;

        -- Northspring Roguefeather - Cast Spell Flow of the Northspring
        DELETE FROM `creature_ai_scripts` WHERE `id`=536303;

        -- Northspring Slayer - Cast Spell Flow of the Northspring
        DELETE FROM `creature_ai_scripts` WHERE `id`=536402;

        -- Hazzali Stinger - Cast Spell Summon Hazzali Parasites
        DELETE FROM `creature_ai_scripts` WHERE `id`=545002;

        -- Hazzali Swarmer - Cast Spell Summon Hazzali Parasites
        DELETE FROM `creature_ai_scripts` WHERE `id`=545102;

        -- Hazzali Worker - Cast Spell Summon Hazzali Parasites
        DELETE FROM `creature_ai_scripts` WHERE `id`=545202;

        -- Hazzali Tunneler - Cast Spell Summon Hazzali Parasites
        DELETE FROM `creature_ai_scripts` WHERE `id`=545302;

        -- Hazzali Sandreaver - Cast Spell Summon Hazzali Parasites
        DELETE FROM `creature_ai_scripts` WHERE `id`=545402;

        -- Timbermaw Ancestor - Cast Healing Wave
        DELETE FROM `creature_ai_scripts` WHERE `id`=1572001;

        -- Khan Dez hepah - Cast Spell Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=560002;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (560002, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Khan Dez hepah - Cast Spell Strike');

        -- Sandfury Witch Doctor - Totem
        DELETE FROM `creature_ai_scripts` WHERE `id`=565002;

        -- Random mobs - Cast Green Channeling
        DELETE FROM `creature_ai_scripts` WHERE `id`=571201;
        DELETE FROM `creature_ai_scripts` WHERE `id`=571301;
        DELETE FROM `creature_ai_scripts` WHERE `id`=571601;

        insert into applied_updates values ('161220251');
    end if;

    -- 16/12/2025 2
    if (select count(*) from applied_updates where id='161220252') = 0 then
        -- '[PH] Cat Figurine' (According to screenshots).
        UPDATE `item_template` SET `name` = '[PH] Cat Figurine' WHERE (`entry` = '5329');

        -- Ghost Saber Display ID.
        UPDATE `creature_template` SET `display_id1` = '748' WHERE (`entry` = '3619');

        -- Fix flying Figurine.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.105' WHERE (`spawn_id` = '399301');

        -- Cat Figurine Goobers, ignore.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399311');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399312');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399313');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399314');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399315');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399316');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399317');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399318');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399319');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '399320');

        -- Cat Figurine chests scripts.
        -- Ghost Saber has a 13% chance to spawn, and Glowing Cat Figurine has a 55.22% drop chance from him.
        DELETE FROM `gameobject_scripts` WHERE `id`=399301;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399301, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399302;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399302, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399303;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399303, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399304;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399304, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399305;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399305, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399306;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399306, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399307;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399307, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399308;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399308, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399309;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399309, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `gameobject_scripts` WHERE `id`=399310;
        INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (399310, 0, 0, 39, 1335901, 1335902, 0, 0, 0, 0, 0, 0, 13, 87, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `generic_scripts` WHERE `id`=1335901;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (1335901, 0, 0, 15, 5968, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Summon Ghost Saber');

        DELETE FROM `generic_scripts` WHERE `id`=1335902;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (1335902, 0, 0, 5, 0, 5968, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cat Figurine - Interrupt Cast - Dummy');

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1606
        UPDATE `creature_template` SET SET `level_min` = '19', `level_max` = '20', `ai_name` = '', `mechanic_immune_mask` = '0', `display_id1` = '1532', `name` = 'Deviate Thundersnout', `rank` = '1', `spell_list_id` = '5055', `scale` = '0.4', `faction` = '16' WHERE (`entry` = '5055');

        -- New creature spell lists.
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (5055, 'Deviate Lasher', 6255, 80, 1, 0, 0, 0, 4, 8, 16, 24, 0, 7342, 100, 1, 0, 0, 0, 2, 6, 14, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        -- Ghamoo-Ra - Raare Elite.
        UPDATE `creature_template` SET `rank` = '2' WHERE (`entry` = '4887');

        -- Invalid faction 350 -> 16 (Monster).
        UPDATE `creature_template` SET `faction` = '16' WHERE `faction` = 350;

        -- Pools.
        INSERT INTO `pool_template` (`pool_entry`, `max_limit`, `description`, `flags`, `instance`) VALUES ('10002', '1', 'Spawn Elite Blackfathom : Ghamoo-Ra', '0', '0');
        INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`, `flags`) VALUES ('25732', '10002', '15', 'Blackfathom Ghamoo-Ra', '0');
        -- Aku'mai Fisher.
        UPDATE `spawns_creatures` SET `spawn_entry1` = '4824', `position_x` = '-442.424', `position_y` = '211.822', `position_z` = '-52.6367' WHERE (`spawn_id` = '26109');
        INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES ('26109', '10002', '0', 'Blackfathom Akumai Fisher');

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1598
        -- Disable second spawn.
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '400410');

        -- https://github.com/The-Alpha-Project/alpha-core/issues/1599
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400470', '1000', '0', '0', '0', '0', '-10933.7', '-378.684', '39.7037', '5.45', '300', '300', '0', '100', '0', '0', '0', '0', '0');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400471', '1001', '0', '0', '0', '0', '-10926.5', '-380.11', '39.2032', '0.778', '300', '300', '0', '100', '0', '0', '0', '0', '0');
        
        -- Gringer, reduce detection range.
        UPDATE `creature_template` SET `detection_range` = '6' WHERE (`entry` = '2858');

        insert into applied_updates values ('161220252');
    end if;

end $
delimiter ;
