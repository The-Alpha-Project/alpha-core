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

        insert into applied_updates values ('031120251');
    end if;

end $
delimiter ;
