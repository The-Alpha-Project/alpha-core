delimiter $
begin not atomic
    -- 12/07/2024 1
    if (select count(*) from `applied_updates` where id='120720241') = 0 then
        -- The Defias Brotherhood: The Defias Traitor should have a delay before starting to run.
        DELETE FROM `quest_start_scripts` WHERE `id`=155;
        INSERT INTO `quest_start_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (155, 0, 0, 61, 155, 600, 0, 0, 0, 0, 0, 8, 0, 15502, 1019, 15501, 0, 0, 0, 0, 0, 'The Defias Brotherhood: Start Scripted Map Event'),
        (155, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Say Text'),
        (155, 0, 2, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Remove Questgiver Flag'),
        (155, 3, 3, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Set Run'),
        (155, 3, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Start Waypoints');

        insert into applied_updates values ('120720241');
    end if;

    -- 12/07/2024 2
    if (select count(*) from applied_updates where id='120720242') = 0 then
        -- Green Tea Leaf
        UPDATE `item_template` SET `display_id` = 2336 WHERE (`entry` = 1401);

        -- Scroll of Strength
        UPDATE `item_template` SET `spellid_1` = 365 WHERE (`entry` = 954);

        -- Scroll of Intellect
        UPDATE `item_template` SET `spellid_1` = 1459 WHERE (`entry` = 955);

        -- Scroll of Stamina
        UPDATE `item_template` SET `spellid_1` = 344 WHERE (`entry` = 1180);

        -- Scroll of Stamina II
        UPDATE `item_template` SET `spellid_1` = 554 WHERE (`entry` = 1711);

        -- Scroll of Strength II
        UPDATE `item_template` SET `spellid_1` = 549 WHERE (`entry` = 2289);

        -- Scroll of Intellect II
        UPDATE `item_template` SET `spellid_1` = 1460 WHERE (`entry` = 2290);

        -- Scroll of Intellect III
        UPDATE `item_template` SET `spellid_1` = 1461 WHERE (`entry` = 4419);

        -- Scroll of Stamina III
        UPDATE `item_template` SET `spellid_1` = 909 WHERE (`entry` = 4422);

        -- Conjured Fresh Water
        UPDATE `item_template` SET `display_id` = 1484 WHERE (`entry` = 2288);

        -- Inferno Robe
        UPDATE `item_template` SET `display_id` = 4498, `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2231);

        -- Elixir of Fortitude
        UPDATE `item_template` SET `display_id` = 2221 WHERE (`entry` = 2458);

        -- Crocilisk Steak
        UPDATE `item_template` SET `display_id` = 1117 WHERE (`entry` = 3662);

        -- Mind Numbing Poison
        UPDATE `item_template` SET `display_id` = 9731 WHERE (`entry` = 5237);

        -- Forget to update name for Magebane Staff
        UPDATE `item_template` SET `name` = 'Magebane Staff' WHERE (`entry` = 944);

        -- Brilliant Smallfish
        UPDATE `item_template` SET `display_id` = 7988 WHERE (`entry` = 6290);

        -- Coyote Meat
        UPDATE `item_template` SET `display_id` = 1762 WHERE (`entry` = 2684);

        -- Dry Pork Ribs
        UPDATE `item_template` SET `display_id` = 1118 WHERE (`entry` = 2687);

        -- Deadly Poison
        UPDATE `item_template` SET `display_id` = 2533 WHERE (`entry` = 2892);

        -- Deadly Poison II
        UPDATE `item_template` SET `display_id` = 2533 WHERE (`entry` = 2893);

        -- Crocilisk Meat
        UPDATE `item_template` SET `display_id` = 2603 WHERE (`entry` = 2924);

        -- Curiously Tasty Omelet
        UPDATE `item_template` SET `display_id` = 3967 WHERE (`entry` = 3665);

        -- Southshore Stout
        UPDATE `item_template` SET `display_id` = 9304 WHERE (`entry` = 3703);

        -- Big Bear Steak
        UPDATE `item_template` SET `display_id` = 7998 WHERE (`entry` = 3726);

        -- Shadow Oil
        UPDATE `item_template` SET `display_id` = 2533 WHERE (`entry` = 3824);

        -- Junglewine
        UPDATE `item_template` SET `display_id` = 2754 WHERE (`entry` = 4595);

        -- Poisonious Mushroom
        UPDATE `item_template` SET `display_id` = 6624 WHERE (`entry` = 5823);

        -- Holy Protection Potion
        UPDATE `item_template` SET `display_id` = 6326 WHERE (`entry` = 6051);

        -- Raw Bristle Whisker Catfish
        UPDATE `item_template` SET `display_id` = 1208 WHERE (`entry` = 4593);

        -- Rune Sword, only one katana model available
        UPDATE `item_template` SET `display_id` = 5181 WHERE (`entry` = 864);

        -- Kazon's Maul
        UPDATE `item_template` SET `display_id` = 1206 WHERE (`entry` = 2058);

        -- Monster - Mace2H, Kazon's Maul
        UPDATE `item_template` SET `display_id` = 1206 WHERE (`entry` = 10685);

        -- Hillborne Axe
        UPDATE `item_template` SET `display_id` = 1390 WHERE (`entry` = 2080);

        -- Prison Shank
        UPDATE `item_template` SET `display_id` = 9344 WHERE (`entry` = 2941);

        -- Dreadblade
        UPDATE `item_template` SET `display_id` = 8755 WHERE (`entry` = 4088);

        -- Captain's armor
        UPDATE `item_template` SET `display_id` = 3082 WHERE (`entry` = 1488);

        -- Rawhides Gloves
        UPDATE `item_template` SET `display_id` = 3848 WHERE (`entry` = 1791);

        -- Tough Leather Armor
        UPDATE `item_template` SET `display_id` = 684 WHERE (`entry` = 1810);

        -- Dirty Leather Belt
        UPDATE `item_template` SET `display_id` = 7746 WHERE (`entry` = 1835);

        -- Dirty Leather Bracer
        UPDATE `item_template` SET `display_id` = 10016 WHERE (`entry` = 1836);

        -- Cozzy Moccasins
        UPDATE `item_template` SET `display_id` = 6190 WHERE (`entry` = 2959);

        -- Mantle of Thieves
        UPDATE `item_template` SET `display_id` = 8807 WHERE (`entry` = 2264);

        -- Reinforced Leather Vest
        UPDATE `item_template` SET `display_id` = 8331 WHERE (`entry` = 2470);

        -- Reinforced Leather Belt
        UPDATE `item_template` SET `display_id` = 9551 WHERE (`entry` = 2471);

        -- Reinforced Leather Cap
        UPDATE `item_template` SET `display_id` = 1124 WHERE (`entry` = 3893);

        -- Woolen Boots
        UPDATE `item_template` SET `display_id` = 4296 WHERE (`entry` = 2583);

        -- Holy Diadem
        UPDATE `item_template` SET `display_id` = 6491 WHERE (`entry` = 2623);

        -- Silken Thread
        UPDATE `item_template` SET `display_id` = 4750 WHERE (`entry` = 4291);

        -- Studded Leather Cap
        UPDATE `item_template` SET `display_id` = 3785 WHERE (`entry` = 3890);

        insert into applied_updates values ('120720242');
    end if;
    
        -- 12/07/2024 3
    if (select count(*) from `applied_updates` where id='120720243') = 0 then
        -- Death's Head Acolyte - Cast Mana Burn
        DELETE FROM `creature_ai_scripts` WHERE `id`=451501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (451501, 0, 0, 15, 2691, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death s Head Acolyte - Cast Spell Mana Burn');

        -- Death's Head Acolyte - Cast Renew on Friendlies
        DELETE FROM `creature_ai_scripts` WHERE `id`=451502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (451502, 0, 0, 15, 6076, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death s Head Acolyte - Cast Spell Renew');

        -- Events list for Razorfen Earthbreaker
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4525;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (452501, 4525, 0, 9, 0, 100, 1, 0, 25, 13000, 18000, 452501, 0, 0, 'Razorfen Earthbreaker - Cast Earth Shock');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (452502, 4525, 0, 9, 0, 100, 1, 0, 10, 9000, 12000, 452502, 0, 0, 'Razorfen Earthbreaker -  Cast Ground Tremor');

        -- Razorfen Earthbreaker -  Cast Ground Tremor
        DELETE FROM `creature_ai_scripts` WHERE `id`=452502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (452502, 0, 0, 15, 6524, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Earthbreaker - Cast Spell Ground Tremor');

        -- Scarlet Monk - Cast Spell Kick
        DELETE FROM `creature_ai_scripts` WHERE `id`=454003;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (454003, 0, 0, 15, 6554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monk - Cast Spell Kick');

        -- Events list for Quilguard Champion
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4623;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462301, 4623, 0, 11, 0, 100, 0, 0, 0, 0, 0, 462301, 0, 0, 'Quilguard Champion - Cast Defensive Stance on Spawn');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462302, 4623, 0, 4, 0, 100, 0, 0, 0, 0, 0, 462302, 0, 0, 'Quilguard Champion - Set Phase 1 on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462303, 4623, 0, 9, 5, 100, 1, 0, 5, 5000, 9000, 462303, 0, 0, 'Quilguard Champion - Cast Sundering Strike (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462304, 4623, 0, 24, 5, 100, 1, 7386, 5, 5000, 5000, 462304, 0, 0, 'Quilguard Champion - Set Phase 2 on Target Max Sundering Strike Aura Stack (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462305, 4623, 0, 28, 3, 100, 1, 7386, 1, 5000, 5000, 462305, 0, 0, 'Quilguard Champion - Set Phase 1 on Target Missing Sundering Strike Aura Stack (Phase 2)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462306, 4623, 0, 0, 0, 100, 1, 1000, 3000, 240000, 240000, 462306, 0, 0, 'Quilguard Champion - Cast Devotion Aura');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (462307, 4623, 0, 7, 0, 100, 0, 0, 0, 0, 0, 462307, 0, 0, 'Quilguard Champion - Set Phase to 0 on Evade');

        -- Quilguard Champion - Cast Spell Sundering Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=462303;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (462303, 0, 0, 15, 7386, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quilguard Champion - Cast Spell Sundering Strike');

        -- Quilguard Champion - Cast Spell Devotion Aura
        DELETE FROM `creature_ai_scripts` WHERE `id`=462306;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (462306, 0, 0, 15, 643, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quilguard Champion - Cast Spell Devotion Aura');

        -- Events list for Kolkar Battle Lord
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4636;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (463601, 4636, 0, 11, 0, 100, 0, 0, 0, 0, 0, 463601, 0, 0, 'Kolkar Battle Lord - Cast Battle Stance on Spawn');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (463603, 4636, 0, 9, 0, 100, 1, 0, 5, 8000, 12000, 463603, 0, 0, 'Kolkar Battle Lord - Cast Strike');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (463604, 4636, 0, 2, 0, 100, 0, 20, 0, 0, 0, 463604, 0, 0, 'Kolkar Battle Lord - Call for Help at 20% HP');

        -- Kolkar Battle Lord - Cast Spell Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=463603;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (463603, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Battle Lord - Cast Spell Strike');

        -- Kolkar Destroyer - Cast Spell Shock
        DELETE FROM `creature_ai_scripts` WHERE `id`=463701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (463701, 0, 0, 15, 2608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kolkar Destroyer - Cast Spell Shock');

        -- Events list for Magram Stormer
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4642;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (464201, 4642, 0, 1, 0, 100, 1, 1000, 1000, 600000, 600000, 464201, 0, 0, 'Magram Stormer - Cast Lightning Shield on Spawn');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (464203, 4642, 0, 27, 0, 100, 1, 905, 1, 15000, 30000, 464203, 0, 0, 'Magram Stormer - Cast Lightning Shield on Missing Buff');

        -- Magram Stormer - Cast Spell Lightning Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=464201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (464201, 0, 0, 15, 905, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magram Stormer - Cast Spell Lightning Shield');
        DELETE FROM `creature_ai_scripts` WHERE `id`=464203;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (464203, 0, 0, 15, 905, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magram Stormer - Cast Spell Lightning Shield');

        -- Magram Marauder - Cast Spell Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=464402;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (464402, 0, 0, 15, 6723, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magram Marauder - Cast Spell Cleave');

        -- Gelkis Marauder - Cast Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=465302;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (465302, 0, 0, 15, 6723, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gelkis Marauder - Cast Spell Cleave');

        -- Maraudine Wrangler - Cast Spell Disarm
        DELETE FROM `creature_ai_scripts` WHERE `id`=465502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (465502, 0, 0, 15, 6713, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Wrangler - Cast Spell Disarm');

        -- Events list for Maraudine Stormer
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4658;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (465801, 4658, 0, 1, 0, 100, 1, 1000, 1000, 600000, 600000, 465801, 0, 0, 'Maraudine Stormer - Cast Lightning Shield on Spawn');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (465803, 4658, 0, 9, 0, 100, 1, 0, 40, 11000, 15000, 465803, 0, 0, 'Maraudine Stormer - Cast Jumping Lightning');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (465804, 4658, 0, 27, 0, 100, 1, 945, 1, 15000, 30000, 465804, 0, 0, 'Maraudine Stormer - Cast Lightning Shield on Missing Buff');

        -- Maraudine Stormer - Cast Spell Lightning Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=465801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (465801, 0, 0, 15, 945, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Stormer - Cast Spell Lightning Shield');
        DELETE FROM `creature_ai_scripts` WHERE `id`=465804;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (465804, 0, 0, 15, 945, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Stormer - Cast Spell Lightning Shield');

        -- Maraudine Marauder - Cast Spell Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=465902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (465902, 0, 0, 15, 6723, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Maraudine Marauder - Cast Spell Cleave');

        -- Burning Blade Summoner - Cast Spell Summon Imp
        DELETE FROM `creature_ai_scripts` WHERE `id`=466802;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (466802, 0, 0, 15, 688, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Burning Blade Summoner - Cast Spell Summon Imp');

        -- Nether Sorceress - Cast Spell Frost Nova
        DELETE FROM `creature_ai_scripts` WHERE `id`=468401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (468401, 0, 0, 15, 865, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nether Sorceress - Cast Spell Frost Nova');

        -- Ley Hunter - Cast Spell Mana Burn
        DELETE FROM `creature_ai_scripts` WHERE `id`=468501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (468501, 0, 0, 15, 2691, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ley Hunter - Cast Spell Mana Burn');

        -- Slitherblade Naga - Cast Spell Corrosive Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=471101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (471101, 0, 0, 15, 3396, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Naga - Cast Spell Corrosive Poison');

        -- Slitherblade Warrior - Cast Spell Hamstring
        DELETE FROM `creature_ai_scripts` WHERE `id`=471302;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (471302, 0, 0, 15, 7372, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Warrior - Cast Spell Hamstring');

        -- Slitherblade Myrmidon - Cast Spell Corrosive Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=471401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (471401, 0, 0, 15, 3396, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Myrmidon - Cast Spell Corrosive Poison');

        -- Slitherblade Razortail - Cast Spell Corrosive Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=471501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (471501, 0, 0, 15, 3396, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Slitherblade Razortail - Cast Spell Corrosive Poison');

        -- Fallenroot Rogue - Cast Spell Stealth
        DELETE FROM `creature_ai_scripts` WHERE `id`=478901;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (478901, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Rogue - Cast Spell Stealth');
        DELETE FROM `creature_ai_scripts` WHERE `id`=478902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (478902, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fallenroot Rogue - Cast Spell Stealth Evade');

        -- Twilight Acolyte - Cast Spell Renew
        DELETE FROM `creature_ai_scripts` WHERE `id`=480901;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (480901, 0, 0, 15, 6075, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Acolyte - Cast Spell Renew');
        DELETE FROM `creature_ai_scripts` WHERE `id`=480902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (480902, 0, 0, 15, 6074, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Acolyte - Cast Spell Renew');

        -- Twilight Shadowmage - Cast Spell Summon Voidwalker
        DELETE FROM `creature_ai_scripts` WHERE `id`=481302;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (481302, 0, 0, 15, 697, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Shadowmage - Cast Spell Summon Voidwalker');

        -- Blindlight Muckdweller - Cast Spell Leech Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=481901;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (481901, 0, 0, 15, 3388, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blindlight Muckdweller - Cast Spell Leech Poison');

        -- Twilight Lord Kelris - Cast Spell Sleep
        DELETE FROM `creature_ai_scripts` WHERE `id`=483203;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (483203, 0, 0, 15, 1090, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - Cast Spell Sleep'),
        (483203, 0, 0, 16, 5804, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Lord Kelris - Play Sound 5804');

        -- Theramore Infiltrator - Cast Spell Stealth
        DELETE FROM `creature_ai_scripts` WHERE `id`=483401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (483401, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Infiltrator - Cast Spell Stealth');
        DELETE FROM `creature_ai_scripts` WHERE `id`=483403;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (483403, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Infiltrator - Cast Spell Stealth');

        -- Events list for Shadowforge Digger
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4846;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (484601, 4846, 0, 4, 0, 100, 0, 0, 0, 0, 0, 484601, 0, 0, 'Shadowforge Digger - Set Phase 1 on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (484602, 4846, 0, 9, 5, 100, 1, 0, 5, 5900, 11200, 484602, 0, 0, 'Shadowforge Digger - Cast Sundering Strike (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (484603, 4846, 0, 24, 5, 100, 1, 7386, 5, 5000, 5000, 484603, 0, 0, 'Shadowforge Digger - Set Phase 2 on Target Max Sundering Strike Aura Stack (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (484604, 4846, 0, 28, 3, 100, 1, 7386, 1, 5000, 5000, 484604, 0, 0, 'Shadowforge Digger - Set Phase 1 on Target Missing Sundering Strike Aura Stack (Phase 2)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (484605, 4846, 0, 2, 0, 100, 0, 15, 0, 0, 0, 484605, 0, 0, 'Shadowforge Digger - Flee at 15% HP');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (484606, 4846, 0, 7, 0, 100, 0, 0, 0, 0, 0, 484606, 0, 0, 'Shadowforge Digger - Set Phase to 0 on Evade');

        -- Shadowforge Digger - Cast Spell Sundering Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=484602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (484602, 0, 0, 15, 7386, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Digger - Cast Spell Sundering Strike');

        -- Shadowforge Archaeologist - Cast Spell Shield Bash
        DELETE FROM `creature_ai_scripts` WHERE `id`=484902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (484902, 0, 0, 15, 7377, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Archaeologist - Cast Spell Shield Bash');

        -- Stonevault Cave Lurker - Cast Spell Stealth
        -- Stonevault Cave Lurker - Cast Spell Deadly Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=485001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485001, 0, 0, 15, 1784, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Cast Spell Stealth'),
        (485001, 0, 0, 15, 3583, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Cast Spell Deadly Poison');

        -- Stonevault Cave Lurker - Cast Spell Backstab
        DELETE FROM `creature_ai_scripts` WHERE `id`=485002;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485002, 0, 0, 15, 2590, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Cast Spell Backstab');

        -- Stonevault Cave Lurker - Cast Spell Stealth (Evade)
        DELETE FROM `creature_ai_scripts` WHERE `id`=485004;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485004, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Cave Lurker - Cast Spell Stealth');

        -- Stonevault Oracle - Cast Spell Serpent Totem
        DELETE FROM `creature_ai_scripts` WHERE `id`=485203;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485203, 0, 0, 15, 6364, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Oracle - Cast Spell Serpent Totem'),
        (485203, 0, 0, 44, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Oracle - Increment Phase');
        DELETE FROM `creature_ai_scripts` WHERE `id`=485204;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485204, 0, 0, 15, 6364, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Oracle - Cast Spell Serpent Totem');

        -- Guard Byron - Cast Spell Strike
         DELETE FROM `creature_ai_scripts` WHERE `id`=492102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (492102, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guard Byron - Cast Spell Strike');

        -- Theramore Guard - Cast Spell Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=497902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (497902, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Guard - Cast Spell Strike');

        -- Wren Darkspring - Summon Imp on Spawn
        DELETE FROM `creature_ai_scripts` WHERE `id`=637601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (637601, 0, 0, 15, 688, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wren Darkspring - Summon Imp on Spawn');

        -- Events list for Gordunni Shaman
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5236;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (523601, 5236, 0, 1, 0, 100, 1, 1000, 1000, 600000, 600000, 523601, 0, 0, 'Gordunni Shaman - Cast Lightning Shield');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (523602, 5236, 0, 27, 0, 100, 1, 945, 1, 15000, 30000, 523602, 0, 0, 'Gordunni Shaman - Cast Lightning Shield on Missing Buff');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (523603, 5236, 0, 14, 0, 100, 1, 1200, 40, 14000, 18000, 523603, 0, 0, 'Gordunni Shaman - Cast Healing Wave on Friendlies');

        -- Gordunni Shaman - Cast Spell Lightning Shield
        DELETE FROM `creature_ai_scripts` WHERE `id`=523601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (523601, 0, 0, 15, 945, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Shaman - Cast Spell Lightning Shield');
        DELETE FROM `creature_ai_scripts` WHERE `id`=523602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (523602, 0, 0, 15, 945, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Shaman - Cast Spell Lightning Shield');

        -- Gordunni Shaman - Cast Spell Renew
        DELETE FROM `creature_ai_scripts` WHERE `id`=523603;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (523603, 0, 0, 15, 6077, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Shaman - Cast Spell Renew');

        -- Cursed Atal ai - Cast Spell Call of the Grave
        DELETE FROM `creature_ai_scripts` WHERE `id`=524301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (524301, 0, 0, 15, 5137, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cursed Atal ai - Cast Spell Call of the Grave');

        -- Groddoc Thunderer - Cast Spell Thunderclap
        DELETE FROM `creature_ai_scripts` WHERE `id`=526201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (526201, 0, 0, 15, 6344, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Groddoc Thunderer - Cast Spell Thunderclap');

        -- Ironfur Patriarch - Cast Spell Demoralizing Shout
        DELETE FROM `creature_ai_scripts` WHERE `id`=527401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (527401, 0, 0, 15, 6190, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironfur Patriarch - Cast Spell Demoralizing Shout');

        -- Sprite Dragon - Cast Spell Mana Burn
        DELETE FROM `creature_ai_scripts` WHERE `id`=527601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (527601, 0, 0, 15, 2691, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sprite Dragon - Cast Spell Mana Burn');

        -- Sprite Darter - Cast Spell Mana Burn
        DELETE FROM `creature_ai_scripts` WHERE `id`=527801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (527801, 0, 0, 15, 2691, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sprite Darter - Cast Spell Mana Burn');

        -- Nightmare Wanderer - Cast Spell Pierce Armor
        DELETE FROM `creature_ai_scripts` WHERE `id`=528302;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (528302, 0, 0, 15, 6016, 33, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nightmare Wanderer - Cast Spell Pierce Armor');

        -- Lethlas - Cast Spell Corrosive Acid Breath
        DELETE FROM `creature_ai_scripts` WHERE `id`=531201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (531201, 0, 0, 15, 3396, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Lethlas - Cast Spell Corrosive Acid Breath');

        -- Jademir Oracle - Cast Spell Rejuvenation
        DELETE FROM `creature_ai_scripts` WHERE `id`=531701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (531701, 0, 0, 15, 2090, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jademir Oracle - Cast Spell Rejuvenation');

        -- Jademir Oracle - Cast Spell Faerie Fire
        DELETE FROM `creature_ai_scripts` WHERE `id`=531702;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (531702, 0, 0, 15, 6076, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jademir Oracle - Cast Spell Faerie Fire');

        -- Jademir Tree Warder - Cast Spell Faerie Fire
        DELETE FROM `creature_ai_scripts` WHERE `id`=531902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (531902, 0, 0, 15, 6950, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Jademir Tree Warder - Cast Spell Faerie Fire');

        -- Antilus the Soarer - Cast Spell Rend
        DELETE FROM `creature_ai_scripts` WHERE `id`=534701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (534701, 0, 0, 15, 6548, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Antilus the Soarer - Cast Spell Rend');

        -- Gnarl Leafbrother - Cast Spell Entangling Roots
        DELETE FROM `creature_ai_scripts` WHERE `id`=535401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (535401, 0, 0, 15, 5195, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gnarl Leafbrother - Cast Spell Entangling Roots');

        -- Khan Hratha - Cast Spell Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=540202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (540202, 0, 0, 15, 7371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Khan Hratha - Cast Spell Cleave');

        -- Scorpid Hunter - Cast Spell Slowing Poison
        DELETE FROM `creature_ai_scripts` WHERE `id`=542201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (542201, 0, 0, 15, 3332, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scorpid Hunter - Cast Spell Slowing Poison');

        -- Searing Roc - Cast Spell Immolate
        DELETE FROM `creature_ai_scripts` WHERE `id`=543001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (543001, 0, 0, 15, 1094, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Searing Roc - Cast Spell Immolate');

        -- Centipaar Swarmer - Cast Spell Silithid Swarm
        DELETE FROM `creature_ai_scripts` WHERE `id`=545702;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (545702, 0, 0, 15, 6589, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Centipaar Swarmer - Cast Spell Silithid Swarm');

        -- Razorfen Handler - Cast Spell Summon Tamed Battleboar
        DELETE FROM `creature_ai_scripts` WHERE `id`=453001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (453001, 0, 0, 15, 7905, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Razorfen Handler - Cast Spell Summon Tamed Battleboar');

        -- Events list for Dunemaul Ogre
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5471;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (547101, 5471, 0, 27, 0, 100, 1, 2457, 1, 1000, 1000, 547101, 0, 0, 'Dunemaul Ogre - Cast Battle Stance (passive) ');

        -- Dunemaul Ogre - Cast Spell Battle Stance
        DELETE FROM `creature_ai_scripts` WHERE `id`=547101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (547101, 0, 0, 15, 7165, 7, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dunemaul Ogre - Cast Spell Battle Stance');

        -- Events list for Khan Jehn
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5601;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (560101, 5601, 0, 4, 0, 100, 0, 0, 0, 0, 0, 560101, 0, 0, 'Khan Jehn - Set Phase 1 on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (560102, 5601, 0, 9, 5, 100, 1, 0, 5, 5000, 9000, 560102, 0, 0, 'Khan Jehn - Cast Sundering Strike (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (560103, 5601, 0, 24, 5, 100, 1, 7386, 5, 5000, 5000, 560103, 0, 0, 'Khan Jehn - Set Phase 2 on Target Max Sundering Strike Aura Stack (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (560104, 5601, 0, 28, 3, 100, 1, 7386, 1, 5000, 5000, 560104, 0, 0, 'Khan Jehn - Set Phase 1 on Target Missing Sundering Strike Aura Stack (Phase 2)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (560105, 5601, 0, 0, 0, 100, 1, 1000, 3000, 180000, 190000, 560105, 0, 0, 'Khan Jehn - Cast Defensive Stance');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (560107, 5601, 0, 7, 0, 100, 0, 0, 0, 0, 0, 560107, 0, 0, 'Khan Jehn - Set Phase to 0 on Evade');

        -- Khan Jehn - Cast Spell Sundering Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=560102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (560102, 0, 0, 15, 7386, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Khan Jehn - Cast Spell Sundering Strike');

        -- Khan Shaka - Cast Spell Hamstring
        DELETE FROM `creature_ai_scripts` WHERE `id`=560202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (560202, 0, 0, 15, 7372, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Khan Shaka - Cast Spell Hamstring');

        -- Events list for Wastewander Rogue
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5615;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (561501, 5615, 0, 11, 0, 100, 0, 0, 0, 0, 0, 561501, 0, 0, 'Wastewander Rogue - Cast Stealth on Spawn');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (561502, 5615, 0, 9, 0, 100, 1, 7800, 14600, 11500, 18900, 561502, 0, 0, 'Wastewander Rogue - Cast Backstab');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (561503, 5615, 0, 2, 0, 100, 0, 15, 0, 0, 0, 561503, 0, 0, 'Wastewander Rogue - Flee at 15% HP');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (561504, 5615, 0, 21, 0, 100, 0, 0, 0, 0, 0, 561504, 0, 0, 'Wastewander Rogue - Cast Stealth on Return Home');

        -- Wastewander Rogue - Cast Spell Stealth
        DELETE FROM `creature_ai_scripts` WHERE `id`=561501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (561501, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewander Rogue - Cast Spell Sneak');

        -- Wastewander Rogue - Cast Spell Backstab
        DELETE FROM `creature_ai_scripts` WHERE `id`=561502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (561502, 0, 0, 15, 2591, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewander Rogue - Cast Spell Backstab');

        -- Wastewander Rogue - Cast Spell Stealth
        DELETE FROM `creature_ai_scripts` WHERE `id`=561504;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (561504, 0, 0, 15, 1784, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewander Rogue - Cast Spell Stealth');

        -- Wastewander Shadow Mage - Cast Spell Summon Voidwalker
        DELETE FROM `creature_ai_scripts` WHERE `id`=561702;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (561702, 0, 0, 15, 697, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wastewander Shadow Mage - Cast Spell Summon Voidwalker');

        -- Sandfury Hideskinner - Cast Spell Backstab
        DELETE FROM `creature_ai_scripts` WHERE `id`=564502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (564502, 0, 0, 15, 2591, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Hideskinner - Cast Spell Backstab');

        -- Sandfury Shadowcaster - Cast Spell Demon Skin
        DELETE FROM `creature_ai_scripts` WHERE `id`=564802;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (564802, 0, 0, 15, 696, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sandfury Shadowcaster - Cast Spell Demon Skin');

        -- Shade of Eranikus - Cast Spell War Stomp
        DELETE FROM `creature_ai_scripts` WHERE `id`=570902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (570902, 0, 0, 15, 45, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shade of Eranikus - Cast Spell War Stomp');

        insert into applied_updates values ('120720243');
    end if;
end $
delimiter ;