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

    -- 17/07/2024 1
    if (select count(*) from `applied_updates` where id='170720241') = 0 then
        -- Mosshide Mistweaver - Cast Spell Summon Treasure Horde
        DELETE FROM `creature_ai_scripts` WHERE `id`=100902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (100902, 0, 0, 15, 7301, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mosshide Mistweaver - Cast Frost Armor');

        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (105701);

        -- Events list for Dragonmaw Bonewarder
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1057;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (105703, 1057, 0, 2, 0, 100, 0, 15, 0, 0, 0, 105703, 0, 0, 'Dragonmaw Bonewarder - Flee at 15% HP');

        -- Events list for Shadowhide Brute
        DELETE FROM `creature_ai_events` WHERE `creature_id`=432;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43201, 432, 0, 4, 0, 10, 0, 0, 0, 0, 0, 43201, 0, 0, 'Shadowhide Brute - Random Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43202, 432, 0, 2, 0, 100, 0, 30, 0, 0, 0, 43202, 0, 0, 'Shadowhide Brute - Cast Berserk at 30% HP');

        -- Shadowhide Brute - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=43202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (43202, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowhide Brute - Cast Spell Berserk'),
        (43202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowhide Brute - Say Text');

        -- Events list for Blackrock Champion
        DELETE FROM `creature_ai_events` WHERE `creature_id`=435;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43501, 435, 0, 4, 0, 10, 0, 0, 0, 0, 0, 43501, 0, 0, 'Blackrock Champion - Random Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43502, 435, 0, 0, 0, 100, 0, 1400, 5900, 0, 0, 43502, 0, 0, 'Blackrock Champion - Cast Devotion Aura');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43503, 435, 0, 0, 0, 85, 1, 5800, 10100, 15400, 18700, 43503, 0, 0, 'Blackrock Champion - Cast Berserk');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43504, 435, 0, 0, 0, 100, 1, 4700, 13800, 30500, 30500, 43504, 0, 0, 'Blackrock Champion - Cast Demoralizing Shout');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43505, 435, 0, 2, 0, 100, 0, 15, 0, 0, 0, 43505, 0, 0, 'Blackrock Champion - Flee at 15% HP');

        -- Blackrock Champion - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=43503;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (43503, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackrock Champion - Cast Spell Berserk'),
        (43503, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackrock Champion - Say Text');

        -- Events list for Blackrock Renegade
        DELETE FROM `creature_ai_events` WHERE `creature_id`=437;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43701, 437, 0, 4, 0, 10, 0, 0, 0, 0, 0, 43701, 0, 0, 'Blackrock Renegade - Random Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43702, 437, 0, 0, 0, 100, 1, 9600, 11100, 18100, 37600, 43702, 0, 0, 'Blackrock Renegade - Cast Berserk');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (43704, 437, 0, 2, 0, 100, 0, 15, 0, 0, 0, 43704, 0, 0, 'Blackrock Renegade - Flee at 15% HP');

        -- Events list for Blackrock Grunt
        DELETE FROM `creature_ai_events` WHERE `creature_id`=440;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (44001, 440, 0, 4, 0, 10, 0, 0, 0, 0, 0, 44001, 0, 0, 'Blackrock Grunt - Random Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (44002, 440, 0, 0, 0, 100, 1, 9600, 14000, 18100, 37600, 44002, 0, 0, 'Blackrock Grunt - Cast Berserk');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (44003, 440, 0, 2, 0, 100, 0, 15, 0, 0, 0, 44003, 0, 0, 'Blackrock Grunt - Flee at 15% HP');

        -- Blackrock Grunt - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=44002;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (44002, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackrock Grunt - Cast Spell Berserk'),
        (44002, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackrock Grunt - Say Text');

        -- Events list for Blackrock Outrunner
        DELETE FROM `creature_ai_events` WHERE `creature_id`=485;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (48501, 485, 0, 4, 0, 10, 0, 0, 0, 0, 0, 48501, 0, 0, 'Blackrock Outrunner - Random Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (48503, 485, 0, 0, 0, 100, 1, 9800, 9800, 23100, 35800, 48503, 0, 0, 'Blackrock Outrunner - Cast Berserk');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (48504, 485, 0, 2, 0, 100, 0, 15, 0, 0, 0, 48504, 0, 0, 'Blackrock Outrunner - Flee at 15% HP');

        -- Blackrock Outrunner - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=48503;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (48503, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackrock Outrunner - Cast Spell Berserk'),
        (48503, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackrock Outrunner - Say Text');

        -- Bloodscalp Warrior - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=58703;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (58703, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Warrior - Cast Spell Berserk'),
        (58703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Warrior - Say Text');

        -- Bloodscalp Berserker - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=59701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (59701, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Berserker - Cast Spell Berserk'),
        (59701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Berserker - Say Text');

        -- Bloodscalp Axe Thrower - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=69401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (69401, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Axe Thrower - Cast Spell Berserk'),
        (69401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Axe Thrower - Say Text');

        -- Bloodscalp Shaman - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=69704;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (69704, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Shaman - Cast Spell Berserk'),
        (69704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Shaman - Say Text');

        -- Bloodscalp Mystic - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=70101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (70101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Mystic - Say Text'),
        (70101, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Mystic - Cast Spell Berserk');

        -- Marsh Flesheater - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=75101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (75101, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Marsh Flesheater - Cast Spell Berserk'),
        (75101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Marsh Flesheater - Say Text');

        -- Bloodscalp Scavenger - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=70201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (70201, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Scavenger - Cast Spell Berserk'),
        (70201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2384, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Scavenger - Say Text');

        -- Rockjaw Backbreaker - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=111801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (111801, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rockjaw Backbreaker - Cast Spell Berserk'),
        (111801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Rockjaw Backbreaker - Say Text');

        -- Events list for Hammerspine
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1119;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (111901, 1119, 0, 4, 0, 100, 0, 0, 0, 0, 0, 111901, 0, 0, 'Hammerspine - Chance Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (111902, 1119, 0, 2, 0, 100, 0, 15, 0, 0, 0, 111902, 0, 0, 'Hammerspine - Flee at 15% HP');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (111903, 1119, 0, 2, 0, 100, 0, 20, 0, 0, 0, 111902, 0, 0, 'Hammerspine - Cast Spell Berserk at 20%');

        -- Hammerspine - Cast Spell Enrage
        DELETE FROM `creature_ai_scripts` WHERE `id`=111902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (111902, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammerspine - Cast Spell Enrage');

        -- Enraged Silverback Gorilla - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=151101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (151101, 0, 0, 15, 3019, 34, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Silverback Gorilla - Cast Spell Berserk');

        -- Mokk the Savage - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=151401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (151401, 0, 0, 15, 3019, 34, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Mokk the Savage - Cast Spell Berserk');

        -- Konda - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=151601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (151601, 0, 0, 15, 3019, 34, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Konda - Cast Spell Berserk');

        -- Targorr the Dread - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=169603;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (169603, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Targorr the Dread - Cast Spell Berserk'),
        (169603, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Targorr the Dread - Say Text');

        -- Moonrage Darksoul - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=178201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (178201, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Darksoul - Cast Spell Berserk'),
        (178201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Moonrage Darksoul - Say Text');

        -- Hungering Wraith - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=180202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (180202, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hungering Wraith - Cast Spell Berserk'),
        (180202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Hungering Wraith - Say Text');

        -- Hungering Wraith - Cast Spell Demoralizing Shout
        DELETE FROM `creature_ai_scripts` WHERE `id`=180201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (180201, 0, 0, 15, 6190, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hungering Wraith - Cast Spell Demoralizing Shout');

        -- Scarlet Executioner - Cast Spell Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=184102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (184102, 0, 0, 15, 1608, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - Cast Spell Strike');

        -- Scarlet Executioner - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=184103;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (184103, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - Cast Spell Berserk'),
        (184103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Executioner - Say Text');

        -- Ferocious Yeti - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=224901;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (224901, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ferocious Yeti - Cast Spell Berserk'),
        (224901, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Ferocious Yeti - Say Text');

        -- Crushridge Warmonger - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=228703;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (228703, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Warmonger - Cast Spell Berserk'),
        (228703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1151, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Warmonger - Say Text'),
        (228703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1064, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Warmonger - Say Text');

        -- Commander Aggro gosh - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=246404;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (246404, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Aggro gosh - Cast Spell Berserk'),
        (246404, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Aggro gosh - Say Text');

        -- Kovork - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=260301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (260301, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kovork - Cast Spell Berserk');

        -- Vilebranch Berserker - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=264301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (264301, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Berserker - Cast Spell Berserk'),
        (264301, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Vilebranch Berserker - Say Text');

        -- Witherbark Zealot - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=265001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (265001, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Witherbark Zealot - Cast Spell Berserk'),
        (265001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Witherbark Zealot - Say Text');

        -- Enraged Rock Elemental - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=279101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (279101, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Rock Elemental - Cast Spell Berserk'),
        (279101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Rock Elemental - Say Text');

        -- Dark Strand Enforcer - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=372701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (372701, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Strand Enforcer - Cast Spell Berserk'),
        (372701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Dark Strand Enforcer - Say Text');

        -- General Rajaxx - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=1534103;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (1534103, 0, 0, 15, 3019, 2, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'General Rajaxx - Cast Spell Berserk'),
        (1534103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2384, 0, 0, 0, 0, 0, 0, 0, 0, 'General Rajaxx - Say Emoted Text');

        -- Ghostpaw Alpha - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=382501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (382501, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostpaw Alpha - Cast Spell Berserk'),
        (382501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostpaw Alpha - Say Text');

        -- Bloodtooth Guard - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=393201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (393201, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodtooth Guard - Cast Spell Berserk'),
        (393201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodtooth Guard - Say Text');

        -- Scarlet Myrmidon - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=429502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (429502, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - Cast Spell Berserk'),
        (429502, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Myrmidon - Say Text');

        -- Scarlet Abbot - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=430306;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (430306, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Cast Spell Berserk'),
        (430306, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Abbot - Say Text');

        -- Withervine Rager - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=438501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (438501, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Withervine Rager - Cast Spell Berserk'),
        (438501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Withervine Rager - Say Text');

        -- Agathelos the Raging - Cast Spell Rushing Charge
        DELETE FROM `creature_ai_scripts` WHERE `id`=442201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (442201, 0, 0, 15, 6268, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - Cast Spell Rushing Charge'),
        (442201, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 'Agathelos the Raging - Call for Help');

        -- Agathelos the Raging - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=442204;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (442204, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - Cast Spell Berserk');

        -- Agathelos the Raging - Cast Spell Berserk (2)
        DELETE FROM `creature_ai_scripts` WHERE `id`=442205;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (442205, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Agathelos the Raging - Cast Spell Berserk');

        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (442203);

        -- Events list for Agathelos the Raging
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4422;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (442201, 4422, 0, 4, 0, 100, 0, 0, 0, 0, 0, 442201, 0, 0, 'Agathelos the Raging - Cast Rushing Charge and Call For Help on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (442204, 4422, 0, 2, 0, 100, 0, 60, 0, 0, 0, 442204, 0, 0, 'Agathelos the Raging - Cast Frenzy at 60% HP');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (442205, 4422, 0, 2, 0, 100, 0, 40, 0, 0, 0, 442205, 0, 0, 'Agathelos the Raging - Cast Frenzy at 40% HP');

        -- Bloodscalp Tiger - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=69801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (69801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Tiger - Say Text'),
        (69801, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Tiger - Cast Spell Berserk');

        -- Raging Agam ar - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=451401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (451401, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Agam ar - Cast Spell Berserk'),
        (451401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Agam ar - Say Text');

        -- Hatefury Rogue - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=467002;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (467002, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Rogue - Cast Spell Berserk'),
        (467002, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Rogue - Say Text');

        -- Hatefury Trickster - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=467102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (467102, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Trickster - Cast Spell Berserk'),
        (467102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Trickster - Say Text');

        -- Hatefury Felsworn - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=467201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (467201, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Felsworn - Cast Spell Berserk'),
        (467201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Felsworn - Say Text');

        -- Hatefury Betrayer - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=467301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (467301, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Betrayer - Cast Spell Berserk'),
        (467301, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Betrayer - Say Text');

        -- Hatefury Shadowstalker - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=467403;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (467403, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Shadowstalker - Cast Spell Berserk'),
        (467403, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Shadowstalker - Say Text');

        -- Hatefury Hellcaller - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=467504;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (467504, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Hellcaller - Cast Spell Berserk'),
        (467504, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Hatefury Hellcaller - Say Text');

        -- Raging Thunder Lizard - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=472602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (472602, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Thunder Lizard - Cast Spell Berserk'),
        (472602, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Thunder Lizard - Say Text');

        -- Stonevault Rockchewer - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=485101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485101, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - Cast Spell Berserk'),
        (485101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Rockchewer - Say Text');

        -- Stonevault Brawler - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=485502;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (485502, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Cast Spell Berserk'),
        (485502, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonevault Brawler - Say Text');

        -- Woodpaw Alpha - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=525802;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (525802, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Alpha - Cast Spell Berserk'),
        (525802, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Woodpaw Alpha - Say Text');

        -- Unliving Atal ai - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=526702;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (526702, 0, 0, 15, 3019, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal ai - Cast Spell Berserk'),
        (526702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Unliving Atal ai - Say Text');

        -- Enraged Feral Scar - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=529501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (529501, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Feral Scar - Cast Spell Berserk'),
        (529501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Enraged Feral Scar - Say Text');

        -- Rage Scar Yeti - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=529601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (529601, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Scar Yeti - Cast Spell Berserk'),
        (529601, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Rage Scar Yeti - Say Text');

        -- Bloodroar the Stalker - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=534602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (534602, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodroar the Stalker - Cast Spell Berserk'),
        (534602, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodroar the Stalker - Say Text');

        -- Land Rager - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=546501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (546501, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Land Rager - Cast Spell Berserk'),
        (546501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Land Rager - Say Text');

        -- Raging Dune Smasher - Cast Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=547001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (547001, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Dune Smasher - Cast Berserk'),
        (547001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1191, 0, 0, 0, 0, 0, 0, 0, 0, 'Raging Dune Smasher - Say Text');

        -- Events list for
        DELETE FROM `creature_ai_events` WHERE `creature_id`=6990;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (699001, 6990, 0, 11, 0, 100, 0, 0, 0, 0, 0, 69901, 0, 0, 'Bloodscalp Beastmaster - Cast Spell Bloodscalp Pet');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (699002, 6990, 0, 2, 0, 100, 0, 30, 0, 0, 0, 69902, 0, 0, 'Bloodscalp Beastmaster - Say Emoted Text and Berserk');

        -- Bloodscalp Beastmaster - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=69902;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (69902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2384, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Beastmaster - Say Emoted Text'),
        (69902, 0, 0, 15, 3019, 2, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Beastmaster - Cast Spell Berserk');

        -- Bloodscalp Witch Doctor - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=66003;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (66003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Witch Doctor - Say Text'),
        (66003, 0, 0, 15, 3019, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Witch Doctor - Cast Spell Berserk');

        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (66002);

        -- Events list for Bloodscalp Witch Doctor
        DELETE FROM `creature_ai_events` WHERE `creature_id`=660;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (66001, 660, 0, 0, 0, 100, 1, 6500, 15300, 13300, 21700, 66001, 0, 0, 'Bloodscalp Witch Doctor - Cast Healing Ward');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (66002, 660, 0, 2, 0, 100, 0, 20, 0, 0, 0, 66003, 0, 0, 'Bloodscalp Witch Doctor - Cast Enrage at 20% HP');

        -- Un Goro Stomper - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=651301;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (651301, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Un Goro Stomper - Cast Spell Berserk'),
        (651301, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Un Goro Stomper - Say Text');

        -- Bloodscalp Scout - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=58801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (58801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Scout - Say Text'),
        (58801, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Scout - Cast Spell Berserk');

        -- Bloodscalp Headhunter - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=67102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (67102, 0, 0, 15, 3019, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Headhunter - Cast Spell Berserk'),
        (67102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7798, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Headhunter - Say Text');

        -- Bloodscalp Hunter - Cast Spell Berserk
        DELETE FROM `creature_ai_scripts` WHERE `id`=59501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (59501, 0, 0, 15, 3019, 2, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Hunter - Cast Spell Berserk'),
        (59501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2384, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscalp Hunter - Say Emoted Text');

        -- Kam Deepfury - Cast Spell Kick
        DELETE FROM `creature_ai_scripts` WHERE `id`=166602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (166602, 0, 0, 15, 6554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kam Deepfury - Cast Spell Kick');

        -- Scarlet Knight - Cast Spell Kick
        DELETE FROM `creature_ai_scripts` WHERE `id`=183302;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (183302, 0, 0, 15, 6554, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Knight - Cast Spell Kick');

        -- Dragonmaw Grunt - Cast Spell Kick
        DELETE FROM `creature_ai_scripts` WHERE `id`=210202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (210202, 0, 0, 15, 6554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Grunt - Cast Spell Kick');

        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (571401, 571403, 571404, 571405);

        -- Events list for Loro
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5714;

        -- Olaf - Cast Spell Kick
        DELETE FROM `creature_ai_scripts` WHERE `id`=690801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (690801, 0, 0, 15, 6554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Olaf - Cast Spell Kick');

        -- Scourge Guard - Cast Spell Kick
        DELETE FROM `creature_ai_scripts` WHERE `id`=852701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (852701, 0, 0, 15, 6554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Guard - Cast Spell Kick');

        -- Freezing Ghoul - Cast Spell Chains of Ice
        DELETE FROM `creature_ai_scripts` WHERE `id`=179602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (179602, 0, 0, 15, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Freezing Ghoul - Cast Spell Chains of Ice');

        -- Events list for Jademir Tree Warder
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5319;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (531902, 5319, 0, 28, 0, 100, 1, 6950, 1, 5000, 9000, 531902, 0, 0, 'Jademir Tree Warder - Cast Faerie Fire');

        -- Rocklance - Cast Spell Sundering Strike
        DELETE FROM `creature_ai_scripts` WHERE `id`=584102;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (584102, 0, 0, 15, 7386, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocklance - Cast Spell Sundering Strike');

        -- Rocklance - Cast Spell Cleave
        DELETE FROM `creature_ai_scripts` WHERE `id`=584106;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (584106, 0, 0, 15, 6723, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocklance - Cast Spell Cleave');

        -- Events list for Rocklance
        DELETE FROM `creature_ai_events` WHERE `creature_id`=5841;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584101, 5841, 0, 4, 0, 100, 0, 0, 0, 0, 0, 584101, 0, 0, 'Rocklance - Set Phase 1 on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584102, 5841, 0, 9, 5, 100, 1, 0, 5, 5000, 9000, 584102, 0, 0, 'Rocklance - Cast Sundering Strike (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584103, 5841, 0, 24, 5, 100, 1, 7386, 5, 5000, 5000, 584103, 0, 0, 'Rocklance - Set Phase 2 on Target Max Sundering Strike Aura Stack (Phase 1)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584104, 5841, 0, 28, 3, 100, 1, 7386, 1, 5000, 5000, 584104, 0, 0, 'Rocklance - Set Phase 1 on Target Missing Sundering Strike Aura Stack (Phase 2)');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584105, 5841, 0, 0, 0, 100, 1, 1000, 3000, 180000, 190000, 584105, 0, 0, 'Rocklance - Cast Defensive Stance on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584106, 5841, 0, 0, 0, 100, 1, 12000, 17000, 12000, 17000, 584106, 0, 0, 'Rocklance - Cast Cleave');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (584107, 5841, 0, 7, 0, 100, 0, 0, 0, 0, 0, 584107, 0, 0, 'Rocklance - Set Phase to 0 on Evade');

        -- Murloc Hunter - Summon Crab
        DELETE FROM `creature_ai_scripts` WHERE `id`=45802;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (45802, 0, 0, 15, 7907, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Murloc Hunter - Cast Spell Summon Crab');

        -- Survival Trainer Template
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('511', '1290', '818', '0', '0', '2', '0', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('511', '7361', '7359', '0', '0', '3', '0', '0', '0');

        -- Survival Trainers
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '4579');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '5029');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '5501');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '3411');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '2806');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '2803');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '2802');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '2801');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '2756');
        UPDATE `creature_template` SET `trainer_id` = '511' WHERE (`entry` = '1649');

         -- Survival Trainers
        UPDATE `creature_template` SET `trainer_type` = '2' WHERE (`entry` = '1649');
        UPDATE `creature_template` SET `base_attack_time` = '2000', `ranged_attack_time` = '0', `trainer_type` = '2' WHERE (`entry` = '2756');
        UPDATE `creature_template` SET `scale` = '1', `trainer_type` = '2' WHERE (`entry` = '2803');
        UPDATE `creature_template` SET `scale` = '1', `trainer_type` = '2' WHERE (`entry` = '3411');
        UPDATE `creature_template` SET `level_min` = '35', `level_max` = '35', `trainer_type` = '2' WHERE (`entry` = '4579');
        UPDATE `creature_template` SET `level_min` = '35', `level_max` = '35', `trainer_type` = '2' WHERE (`entry` = '5029');
        UPDATE `creature_template` SET `scale` = '1', `trainer_type` = '2' WHERE (`entry` = '5501');
        UPDATE `creature_template` SET `scale` = '1' WHERE (`entry` = '2801');
        UPDATE `creature_template` SET `scale` = '1' WHERE (`entry` = '2802');
        UPDATE `creature_template` SET `scale` = '1' WHERE (`entry` = '2806');
        UPDATE `creature_template` SET `trainer_class` = '0' WHERE (`entry` = '5501');

        -- Brog Hamfist <General Supplies> - Unlit Poor Torch - https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Elwynn%20Forest/images_WoWScrnShot_032304_003948.jpg
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('151', '6183', '0', '0', '0', '0');

        -- Unlit Poor Torch - Vendor Template 66 (General Trade & Supplies) - https://crawler.thealphaproject.eu/mnt/crawler/media/Database/NuRRis/blizzlike_creatures.txt
        INSERT INTO `npc_vendor_template` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `condition_id`, `slot`) VALUES ('66', '6183', '0', '0', '0', '0', '0');

        -- Unlit Poor Torch - Thurman Mullby <General Goods Vendor> - https://crawler.thealphaproject.eu/mnt/crawler/media/Database/NuRRis/blizzlike_creatures.txt
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('1285', '6183', '0', '0', '0', '0');

        -- Fix IF guard pathing.
        UPDATE `spawns_creatures` SET `position_x` = '-4920.602', `position_y` = '-1044.766', `position_z` = '492.197' WHERE (`spawn_id` = '1748');
        UPDATE `creature_movement` SET `position_x` = '-4920.6', `position_y` = '-1044.77', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '1');
        UPDATE `creature_movement` SET `position_x` = '-4907.292', `position_y` = '-1018.646', `position_z` = '492.182' WHERE (`id` = '1748') and (`point` = '2');
        UPDATE `creature_movement` SET `position_x` = '-4884.366', `position_y` = '-1000.426', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '3');
        UPDATE `creature_movement` SET `position_x` = '-4890.622', `position_y` = '-992.326', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '4');
        UPDATE `creature_movement` SET `position_x` = '-4896.254', `position_y` = '-985.086', `position_z` = '488.814', `orientation` = '5.42' WHERE (`id` = '1748') and (`point` = '5');
        UPDATE `creature_movement` SET `position_x` = '-4890.622', `position_y` = '-992.326', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '6');
        UPDATE `creature_movement` SET `position_x` = '-4884.366', `position_y` = '-1000.426', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '7');
        UPDATE `creature_movement` SET `position_x` = '-4861.852', `position_y` = '-981.855', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '8');
        UPDATE `creature_movement` SET `position_x` = '-4911.36', `position_y` = '-1022.72', `position_z` = '492.186', `orientation` = '0', `waittime` = '0' WHERE (`id` = '1748') and (`point` = '9');

        -- Ginny Longberry - Reagents Vendor
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('5151', '5024', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('5151', '5026', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('5151', '5105', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('5151', '5517', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('5151', '5518', '0', '0', '0', '0');

        -- Bogrum Firebrew - Bartender - https://crawler.thealphaproject.eu/mnt/crawler/media/Website/worldofwar.net/web.archive.org/web/20040607091020/http:/www.worldofwar.net/cartography/cities/ironforge-print-text.htm
        UPDATE `creature_template` SET `subname` = 'Bartender', `vendor_id` = '0' WHERE (`entry` = '5111');
        -- Barkeep Belm - Burly Bartender
        UPDATE `creature_template` SET `subname` = 'Burly Bartender' WHERE (`entry` = '1247');
        -- Svalbrad Farmountain - Cartography Supplier - Remove vendor flag.
        UPDATE `creature_template` SET `npc_flags` = '0' WHERE (`entry` = '5135');
        -- Narkk - Pirate Supplies - Remove vendor flag, items not yet in alpha.
        UPDATE `creature_template` SET `npc_flags` = '0' WHERE (`entry` = '2663');
        -- Zachariah Post	Animal Handler - Black Stallion Bridle - https://archive.thealphaproject.eu/media/Alpha-Project-Archive/UNSORTED/wow_pimpbunnies_com/531.jpg
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('4731', '2411', '0', '0', '0', '0');
        -- Lelanai	Tiger Handler -> Animal Handler - https://archive.thealphaproject.eu/media/Alpha-Project-Archive/UNSORTED/mobs_from_allakhazam/Lelanai_Animal_Handler_Darnassus.jpg
        -- The skill exists, but no rideable mounts where available for NE. https://db.thealphaproject.eu/index.php?action=show_skill&id=150&filter=riding&sort_order=DisplayName_enUS&pos=4&max=5
        UPDATE `creature_template` SET `npc_flags` = '0', `subname` = 'Animal Handler' WHERE (`entry` = '4730');
        -- Black Stallion Bridle Display ID. Geo
        UPDATE `item_template` SET `display_id` = '3673' WHERE (`entry` = '2411');
        -- Add missing Steed near Zachariah Post.
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400456', '5689', '0', '0', '0', '0', '2249.927', '322.416', '35.189', '5.32', '300', '300', '0', '100', '100', '0', '0', '0', '0');
        UPDATE `spawns_creatures` SET `wander_distance` = '0' WHERE (`spawn_id` = '400442');
        UPDATE `spawns_creatures` SET `wander_distance` = '0' WHERE (`spawn_id` = '400441');
        -- Ignore Steed to the right of Zachariah Post.
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '31906');
        -- Gina Lang - Summon Imp on Spawn
        DELETE FROM `creature_ai_scripts` WHERE `id`=575001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (575001, 0, 0, 15, 688, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gina Lang - Summon Imp on Spawn');
        -- Velma Warnam - Horse Riding.
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('512', '6743', '824', '0', '0', '0', '0', '0', '40');
        UPDATE `creature_template` SET `trainer_type` = '0', `trainer_id` = '512' WHERE (`entry` = '4773');
        -- Randal Huntetr - Horse Riding.
        UPDATE `creature_template` SET `trainer_type` = '0', `trainer_id` = '512' WHERE (`entry` = '4732');
        -- Katie Hunter - Horse Breeder
        DELETE FROM `npc_vendor` WHERE `entry`=384;
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('384', '5656', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('384', '2411', '0', '0', '0', '1');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('384', '2414', '0', '0', '0', '2');
        -- Horse Bridle item icons. Default to net icon. Geo
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '5656');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '5655');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '2413');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '2414');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '2415');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '12353');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '12354');
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '2411');
        -- Unger Statforth - Horse Breeder
        DELETE FROM `npc_vendor` WHERE (`entry` = '1460') and (`item` = '2411');
        UPDATE `npc_vendor` SET `slot` = '1' WHERE (`entry` = '1460') and (`item` = '5655');
        UPDATE `npc_vendor` SET `slot` = '2' WHERE (`entry` = '1460') and (`item` = '2414');
        -- Wetlands Pinto Horse orientation.
        UPDATE `spawns_creatures` SET `orientation` = '4.32' WHERE (`spawn_id` = '9530');
        -- Wetlands missing horse.
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400457', '5405', '0', '0', '0', '0', '-3644.89', '-754.985', '9.97506', '3.57897', '300', '300', '300', '100', '100', '0', '0', '0', '0');
        -- Thomas Books and Horse group.
        INSERT INTO `creature_groups` (`leader_guid`, `member_guid`, `dist`, `angle`, `flags`) VALUES ('9468', '9468', '0', '0', '0');
        INSERT INTO `creature_groups` (`leader_guid`, `member_guid`, `dist`, `angle`, `flags`) VALUES ('9468', '400457', '2', '2', '0');
        UPDATE `creature_groups` SET `dist` = '1.5', `angle` = '1', `flags` = '1' WHERE (`member_guid` = '400457');
        UPDATE `creature_groups` SET `flags` = '1' WHERE (`member_guid` = '9468');
        DELETE FROM `creature_groups` WHERE (`member_guid` = '9469');
        -- Kildar <Wolf Rider> - Fix Z, trainer template.
        UPDATE `spawns_creatures` SET `position_z` = '73.37' WHERE (`spawn_id` = '4677');
        UPDATE `creature_template` SET `trainer_type` = '0', `trainer_id` = '513' WHERE (`entry` = '4752');
        -- Wolf Riding Trainer Template.
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('513', '6746', '825', '0', '0', '0', '0', '0', '40');
        -- Ram Riding Trainer Template.
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('514', '6744', '826', '0', '0', '0', '0', '0', '40');
        -- Ultham Ironhorn <Ram Riding Instructor>
        UPDATE `creature_template` SET `trainer_type` = '0', `trainer_id` = '514' WHERE (`entry` = '4772');
        -- Tiger Riding template, set others req level to 25.
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('515', '6745', '828', '0', '0', '0', '0', '0', '25');
        UPDATE `trainer_template` SET `reqlevel` = '25' WHERE (`template_entry` = '512') and (`spell` = '6743');
        UPDATE `trainer_template` SET `reqlevel` = '25' WHERE (`template_entry` = '513') and (`spell` = '6746');
        UPDATE `trainer_template` SET `reqlevel` = '25' WHERE (`template_entry` = '514') and (`spell` = '6744');
        -- Jartsam <Nightsaber Riding Instructor> - Tiger Riding, Fix Z
        UPDATE `spawns_creatures` SET `position_z` = '1318.800' WHERE (`spawn_id` = '46722');
        UPDATE `creature_template` SET `trainer_type` = '0', `trainer_id` = '515' WHERE (`entry` = '4753');
        -- 'Survivalist' should also be trainers. - https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Eastern%20Kingdoms/Elwynn%20Forest/elwynn_forest_017.jpg
        UPDATE `creature_template` SET `npc_flags` = '8' WHERE (`entry` = '1649');
        UPDATE `creature_template` SET `npc_flags` = '8' WHERE (`entry` = '2756');
        UPDATE `creature_template` SET `npc_flags` = '8' WHERE (`entry` = '5029');
        --  Shards of Myzrael, Fix Z.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '62.921' WHERE (`spawn_id` = '15475');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-942.842', `spawn_positionY` = '-3116.75', `spawn_positionZ` = '60' WHERE (`spawn_id` = '99848');

        insert into applied_updates values ('170720241');
    end if;
    
    -- 22/07/2024 1
    if (select count(*) from applied_updates where id='220720241') = 0 then
        DROP TABLE IF EXISTS `event_scripts`;
        CREATE TABLE `event_scripts` (
          `id` int(10) unsigned NOT NULL DEFAULT '0',
          `delay` int(10) unsigned NOT NULL DEFAULT '0',
          `priority` tinyint(3) unsigned NOT NULL DEFAULT '0',
          `command` tinyint(3) unsigned NOT NULL DEFAULT '0',
          `datalong` int(10) unsigned NOT NULL DEFAULT '0',
          `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
          `datalong3` int(10) unsigned NOT NULL DEFAULT '0',
          `datalong4` int(10) unsigned NOT NULL DEFAULT '0',
          `target_param1` int(10) unsigned NOT NULL DEFAULT '0',
          `target_param2` int(10) unsigned NOT NULL DEFAULT '0',
          `target_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
          `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
          `dataint` int(11) NOT NULL DEFAULT '0',
          `dataint2` int(11) NOT NULL DEFAULT '0',
          `dataint3` int(11) NOT NULL DEFAULT '0',
          `dataint4` int(11) NOT NULL DEFAULT '0',
          `x` float NOT NULL DEFAULT '0',
          `y` float NOT NULL DEFAULT '0',
          `z` float NOT NULL DEFAULT '0',
          `o` float NOT NULL DEFAULT '0',
          `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
          `comments` varchar(255) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

        INSERT INTO `event_scripts` VALUES (364,5,0,10,2624,900000,1,100,0,0,0,0,8,0,-1,1,-12167.9,630.3,-63.78,3.65,0,'Summon Gazban From Altar of the Tides'),(415,3,0,10,2569,120000,3,0,0,0,0,0,8,0,-1,1,-1777.64,-1513.58,75.51,5.28,0,''),(415,3,0,10,2570,120000,3,0,0,0,0,0,8,0,-1,1,-1778.46,-1510.57,75.17,5.22,0,''),(416,3,0,10,2569,120000,3,0,0,0,0,0,8,0,-1,1,-1797.32,-1504.7,99.39,5.14,0,''),(416,3,0,10,2570,120000,3,0,0,0,0,0,8,0,-1,1,-1789.8,-1499.9,99.38,4.6,0,''),(417,3,0,10,2569,120000,3,0,0,0,0,0,8,0,-1,1,-1772.93,-1505.9,91.87,5.7,0,''),(417,3,0,10,2570,120000,3,0,0,0,0,0,8,0,-1,1,-1774.76,-1495.07,90.6,5.27,0,''),(420,0,0,10,2755,3000000,0,0,0,0,0,0,0,0,-1,1,-931.73,-3111.81,48.517,3.27404,0,'Summoning the Princess - Myzrael: Spawn for quest 656'),(452,0,0,10,2937,300000,0,0,0,0,0,0,0,0,-1,1,-2405.19,-4172.46,-7.05522,0.977384,0,'Enchanted Sea Kelp - Summon Creature Dagun the Ravenous'),(498,3,0,10,3129,300000,0,0,0,0,0,0,0,0,-1,1,-228.09,-5115.08,49.32,1.28,0,''),(619,3,0,10,634,300000,0,0,0,0,0,0,0,0,-1,1,-18.44,-617.46,14.12,0.08,0,''),(664,9,0,0,0,0,0,0,3946,10,8,2,1360,0,0,0,0,0,0,0,0,'The Scythe of Elune: Velinde Starsong - Say Text'),(727,0,0,10,4504,0,1,0,0,0,0,0,8,0,-1,7,234.227,-239.227,141.325,2.84489,0,'Frostmaw: Summon Creature Frostmaw'),(1033,100,0,10,5402,3000000,0,0,0,0,0,0,0,0,-1,1,-1129.9,2896.08,195.91,3.15,0,''),(1033,100,0,10,6070,3000000,0,0,0,0,0,0,0,0,-1,1,-1130.26,2894.02,196.27,3.15,0,''),(1033,100,0,10,6069,3000000,0,0,0,0,0,0,0,0,-1,1,-1134.43,2902.35,196.56,3.85,0,''),(1033,100,0,10,6069,3000000,0,0,0,0,0,0,0,0,-1,1,-1131.98,2886.77,197.59,2.55,0,''),(1033,40,0,10,6070,3000000,0,0,0,0,0,0,0,0,-1,1,-1129.04,2895.67,195.7,3.11,0,''),(1033,40,0,10,6069,3000000,0,0,0,0,0,0,0,0,-1,1,-1130.01,2901.11,195.35,3.35,0,''),(1033,40,0,10,6069,3000000,0,0,0,0,0,0,0,0,-1,1,-1125.46,2890.14,195.27,2.9,0,''),(1033,0,0,10,6069,3000000,0,0,0,0,0,0,0,0,-1,1,-1126.97,2901.03,194.33,3.45,0,''),(1033,0,0,10,6069,3000000,0,0,0,0,0,0,0,0,-1,1,-1123.14,2892.65,194.96,3.11,0,''),(1131,0,0,10,5676,180000,0,0,0,0,0,0,0,0,-1,1,-8973.05,1043.72,52.8631,2,0,''),(1134,0,0,10,5677,180000,0,0,0,0,0,0,0,0,-1,1,-8973.05,1043.72,52.8631,2,0,''),(1370,0,0,10,6239,300000,0,0,0,0,0,0,0,0,-1,1,332.821,-1473.05,42.2658,3.99963,0,''),(1449,0,0,10,6268,120000,0,0,0,0,0,0,0,17952,-1,1,-768.601,-3721.96,42.4778,2.79253,0,'The Binding: Summon Creature Summoned Felhunter'),(1785,0,0,10,5676,180000,0,0,0,0,0,0,0,0,-1,1,1704.61,41.9147,-63.8433,0.435896,0,''),(1786,0,0,10,5677,180000,0,0,0,0,0,0,0,0,-1,1,1704.61,41.9147,-63.8433,0.435896,0,''),(1787,0,0,10,5676,180000,0,0,0,0,0,0,0,0,-1,1,1806.13,-4372.67,-17.4888,4.41785,0,''),(1788,0,0,10,5677,180000,0,0,0,0,0,0,0,0,-1,1,1806.13,-4372.67,-17.4888,4.41785,0,''),(2048,0,0,10,3456,3000000,0,0,0,0,0,0,0,0,-1,1,-3592.45,-1872.06,91.62,0.19,0,''),(2313,0,0,10,7411,30000,0,0,0,0,0,0,0,0,-1,1,9641.96,2521.98,1331.73,1.6194,0,''),(2489,2,0,3,0,1000,0,0,0,0,0,0,0,0,0,0,1681.74,1204.13,5.67395,0.765837,0,'Gahz\'rilla move'),(2609,0,0,11,27089,9000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(2609,0,0,11,27090,9000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(2609,0,0,11,27091,9000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(2609,0,0,11,27092,9000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(2609,0,0,11,27093,9000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(2648,0,0,10,2707,9000000,0,0,0,0,0,0,0,0,-1,1,-407,-2862,77.31,5.87,0,''),(2980,0,0,10,3475,180000,0,0,0,0,0,0,0,0,-1,1,436.258,-3058,92.434,3.952,0,''),(2998,0,0,10,3257,180000,0,0,0,0,0,0,0,0,-1,1,-435,-3428,91.75,5.323,0,''),(3084,0,0,10,8446,300000,1,100,0,0,0,4,8,8446,-1,1,2233,-7296.54,23.6021,0.477321,0,'Standard Issue Flare Gun: Summon Creature Xiggs Fuselighter\'s Flyingmachine'),(3201,2,0,9,16736,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3201,2,0,9,16741,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3202,2,0,9,16737,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3202,2,0,9,16742,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3203,2,0,9,16738,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3203,2,0,9,16743,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3204,2,0,9,16735,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3204,2,0,9,16740,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3241,5,0,10,8581,600000,0,0,0,0,0,0,0,0,-1,1,4279.11,-6295.57,95.56,0.05,0,''),(3241,20,0,10,8578,900000,0,0,0,0,0,0,0,0,-1,1,4279.11,-6295.57,95.56,0.05,0,''),(3301,2,0,10,7664,900000,0,0,0,0,0,0,0,0,-1,1,-11234.4,-2842.68,157.92,1.42,0,''),(3708,3,0,10,9453,45000,0,0,0,0,0,0,1,9453,-1,1,-8179.46,-5169.84,3.99278,1.3439,0,'Aquementas - Summon Aquementas'),(3718,0,0,39,9467,0,0,0,9467,50,8,3,100,0,0,0,0,0,0,0,0,'The Videre Elixir: Miblon Snarltooth - Start Script'),(3839,0,0,10,9598,3000000,0,0,0,0,0,0,4,0,-1,1,5998.7,-1208,377.75,0.36,0,''),(3938,0,0,61,3938,105,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'The Blackwood Corrupted: Start Scripted Map Event'),(3973,0,0,10,8075,9000000,0,0,0,0,0,0,0,0,-1,1,-2764.68,2623.21,70.4204,2.33578,0,''),(3980,0,0,9,27142,180,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(3981,0,0,10,9684,3000000,0,0,0,0,0,0,0,968401,-1,1,-7201.95,-2354.85,-225.152,4.84672,0,'The Bait for Lar\'korwi: Summon Creature'),(4338,0,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7968.53,-1097.05,-327.09,3.3,0,''),(4338,0,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7979.87,-1095.38,-327.55,5.94,0,''),(4338,40,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7976.31,-1101.03,-328.11,6.1,0,''),(4338,40,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7969.05,-1102.24,-329.02,3.36,0,''),(4338,40,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7987.08,-1096.74,-329.16,5.55,0,''),(4338,90,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7977.93,-1079.71,-329.1,4.5,0,''),(4338,90,0,10,10040,3000000,0,0,0,0,0,0,0,0,-1,1,-7963.49,-1081.18,-328.64,4.32,0,''),(4338,90,0,10,10041,3000000,0,0,0,0,0,0,0,0,-1,1,-7969.74,-1077.94,-328.73,4.54,0,''),(4884,0,0,61,4884,1200,0,0,0,0,0,0,0,48841,239,48842,0,0,0,0,0,'Emberseer Start - Start Map Event'),(4975,0,0,10,10737,3000000,0,0,0,0,0,0,0,0,-1,1,8072.38,-3833.81,690.03,4.56,0,''),(5225,5,0,10,11058,900000,0,0,0,0,0,0,0,0,-1,1,3487.05,-3289.75,131.79,4.69,0,''),(5301,5,0,10,11121,900000,0,0,0,0,0,0,0,0,-1,1,3820.95,-3695.15,143.87,1.825,0,'Summon Black Guard Swordsmith'),(5759,1,0,10,11887,600000,3,0,0,0,0,0,8,1188702,-1,1,1570.57,-3254.73,86.7141,4.50295,0,'Of Forgotten Memories - Summon Creature'),(5759,1,0,10,11887,600000,3,0,0,0,0,0,8,1188701,-1,1,1573.96,-3256.98,86.7919,4.03171,0,'Of Forgotten Memories - Summon Creature'),(5991,0,0,10,12138,180000,0,0,0,0,0,0,0,0,-1,1,6331.9,93.3575,21.4216,1.1349,0,''),(6028,0,0,10,12138,180000,0,0,0,0,0,0,0,0,-1,1,-2500.89,-1628.45,91.7042,6.01041,0,''),(6138,0,0,10,2179,3000000,0,0,0,0,0,0,0,0,-1,1,6873.65,-659.95,84.16,0.76,0,''),(6138,0,0,10,12321,3000000,0,0,0,0,0,0,0,0,-1,1,6881.62,-651.81,84.59,1.05,0,''),(6721,180,0,10,12918,180000,0,0,0,0,0,0,0,0,-1,1,2208.93,-1567.59,87.2283,0,0,''),(6721,155,0,10,3743,180000,0,0,0,0,0,0,0,0,-1,1,2202.16,-1544.48,87.796,0,0,''),(6721,155,0,10,3749,180000,0,0,0,0,0,0,0,0,-1,1,2237.48,-1524.45,89.7827,0,0,''),(6721,125,0,10,3750,180000,0,0,0,0,0,0,0,0,-1,1,2260.9,-1547.91,89.1733,0,0,''),(6721,125,0,10,3743,180000,0,0,0,0,0,0,0,0,-1,1,2235.44,-1578.43,86.4944,0,0,''),(6721,125,0,10,3749,180000,0,0,0,0,0,0,0,0,-1,1,2208.93,-1567.59,87.2283,0,0,''),(6721,105,0,10,3750,180000,0,0,0,0,0,0,0,0,-1,1,2202.16,-1544.48,87.796,0,0,''),(6721,105,0,10,3743,180000,0,0,0,0,0,0,0,0,-1,1,2237.48,-1524.45,89.7827,0,0,''),(6721,75,0,10,3749,180000,0,0,0,0,0,0,0,0,-1,1,2260.9,-1547.91,89.1733,0,0,''),(6721,75,0,10,3750,180000,0,0,0,0,0,0,0,0,-1,1,2235.44,-1578.43,86.4944,0,0,''),(6721,75,0,10,3743,180000,0,0,0,0,0,0,0,0,-1,1,2208.93,-1567.59,87.2283,0,0,''),(6721,55,0,10,3749,180000,0,0,0,0,0,0,0,0,-1,1,2202.16,-1544.48,87.796,0,0,''),(6721,55,0,10,3750,180000,0,0,0,0,0,0,0,0,-1,1,2237.48,-1524.45,89.7827,0,0,''),(6721,25,0,10,3743,180000,0,0,0,0,0,0,0,0,-1,1,2260.9,-1547.91,89.1733,0,0,''),(6721,25,0,10,3749,180000,0,0,0,0,0,0,0,0,-1,1,2235.44,-1578.43,86.4944,0,0,''),(6721,25,0,10,3750,180000,0,0,0,0,0,0,0,0,-1,1,2208.93,-1567.59,87.2283,0,0,''),(6721,5,0,10,3743,180000,0,0,0,0,0,0,0,0,-1,1,2202.16,-1544.48,87.796,0,0,''),(6721,5,0,10,3749,180000,0,0,0,0,0,0,0,0,-1,1,2237.48,-1524.45,89.7827,0,0,''),(8328,0,0,9,157008,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Kroshius - Respawn Gameobject'),(8428,0,0,9,99783,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''),(8428,10,0,10,14502,9000000,0,0,0,0,0,0,0,0,-1,1,-35.712,796.486,-29.5359,1.90495,0,''),(5759,1,0,10,11886,600000,1,0,0,0,0,0,8,0,-1,1,1571.65,-3257.46,86.8517,4.38078,0,'Of Forgotten Memories - Summon Creature'),(8328,10,0,18,1200000,0,0,0,39715,0,9,2,0,0,0,0,0,0,0,0,0,'Kroshius - Despawn'),(8328,10,0,4,46,768,2,0,39715,0,9,2,0,0,0,0,0,0,0,0,0,'Kroshius - Remove Unit Flag'),(8328,10,0,22,14,1,0,0,39715,0,9,2,0,0,0,0,0,0,0,0,0,'Kroshius - Set Faction'),(8328,5,0,1,15,0,0,0,39715,0,9,2,0,0,0,0,0,0,0,0,0,'Kroshius - Emote'),(8328,5,0,35,0,0,0,0,39715,0,9,2,0,0,0,0,0,0,0,0,0,'Kroshius - Orientation'),(8328,5,0,0,0,0,0,0,39715,0,9,2,9633,0,0,0,0,0,0,0,0,'Kroshius - Talk'),(8328,3,0,28,0,0,0,0,39715,0,9,2,0,0,0,0,0,0,0,0,0,'Kroshius - Set Stand State'),(8436,0,0,39,843601,0,0,0,0,0,0,0,100,0,0,0,0,0,0,0,571,'Divination Scryer - Start Script'),(8438,0,0,10,14500,180000,0,0,0,0,0,0,0,0,-1,1,38.62,161.78,83.5456,4.69993,0,''),(9066,10,0,10,14515,900000,0,0,0,0,0,0,0,0,-1,1,-11540.7,-1627.71,41.27,0.1,0,''),(9208,0,0,61,9208,7200,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Glyphs of Calling: Start Scripted Map Event'),(9571,0,0,10,15623,3000000,0,0,0,0,0,0,0,0,-1,1,6724.96,-5275.13,778.23,1.82,0,''),(10015,0,0,10,16387,9000000,0,0,0,0,0,0,0,0,-1,1,3644,-3473.77,138.56,4.47,0,''),(2153,5,0,10,7167,900000,0,0,0,0,0,0,0,0,-1,1,-1456.55,-3959.53,0.24,1.99,0,'Summon Polly for quest 2381'),(2489,6,0,3,0,1000,0,0,0,0,0,0,0,0,0,0,1702.58,1224.19,8.87684,3.89565,0,'Gahz\'rilla move'),(2489,5,0,3,0,1000,0,0,0,0,0,0,0,0,0,0,1692.57,1213.66,8.87684,0.809034,0,'Gahz\'rilla move'),(8448,10,0,0,0,0,0,0,14353,10,8,3,9411,0,0,0,0,0,0,0,0,'Mizzle The Crafty : say text1'),(8446,1,0,20,2,0,0,0,14325,10,8,3,0,0,0,0,0,0,0,0,0,'Captain Kromcrush : movement WayPoint'),(8446,1,0,0,6,0,0,0,14325,10,8,3,9416,0,0,0,0,0,0,0,0,'Captain Kromcrush : yell text'),(8446,1,0,25,1,0,0,0,14325,10,8,3,0,0,0,0,0,0,0,0,0,'Captain Kromcrush : set run'),(8446,24,0,0,6,0,0,0,14325,10,8,3,9424,0,0,0,0,0,0,0,0,'Captain Kromcrush : yell text2'),(8446,25,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Captain Kromcrush : despawn'),(8446,26,0,10,14325,3000000,0,0,0,0,0,0,0,0,-1,1,384.64,253.52,11.44,1.49,0,'Captain Kromcrush : Summon Kromcrush'),(694,0,0,76,19601,60000,0,0,0,0,0,0,0,0,0,0,1168.44,51.1277,0.0603573,5.48173,0,'Set NG-5 Charge (Blue) - Respawn NG-5 Explosives (Blue)'),(2489,4,0,3,0,1000,0,0,0,0,0,0,0,0,0,0,1690.54,1211.53,10.178,0.734421,0,'Gahz\'rilla move'),(2489,3,0,3,0,1000,0,0,0,0,0,0,0,0,0,0,1686.09,1207.3,9.75179,0.730494,0,'Gahz\'rilla move'),(2489,1,0,3,0,1000,0,0,0,0,0,0,0,0,0,0,1672.66,1195.93,0.956351,0.734422,0,'Gahz\'rilla move'),(8448,7,0,3,1,2000,0,0,0,0,0,0,0,0,0,0,808.27,482.88,37.318,0.076,0,'Mizzle The Crafty : deplacement'),(8448,6,0,3,1,1000,0,0,0,0,0,0,0,0,0,0,777.96,482.13,34.84,6.27,0,'Mizzle The Crafty : deplacement'),(8450,0,0,9,396410,7200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Knot Thimblejack : respawn coffre'),(9527,33,0,0,0,0,0,0,15552,50,8,3,11106,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Say Text'),(2488,0,0,9,209001,3600000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Respawn autre gong'),(2488,2,0,10,7273,3600000,0,0,0,0,0,0,0,0,-1,1,1664.65,1187.67,-2.88755,0.812962,0,'Gahz\'rilla spawn'),(9530,0,0,0,6,0,0,0,0,0,0,0,9730,0,0,0,0,0,0,0,0,'Short John Mithril - Say Text 1'),(8448,2,0,3,1,4000,0,0,0,0,0,0,0,0,0,0,756.96,482.62,28.18,6.259,0,'Mizzle The Crafty : deplacement'),(9547,4,0,3,1,6000,0,0,0,0,0,0,0,0,0,0,262.6,-459.471,-119.962,4.869,0,'Alzzin\'s Minion move'),(8448,1,0,0,6,0,0,0,14353,10,8,3,9348,0,0,0,0,0,0,0,0,'Mizzle The Crafty : yell text'),(3938,1,0,10,2168,90000,0,0,0,0,0,0,0,3938,-1,1,6887.17,-482.53,40.2585,3.45575,0,'The Blackwood Corrupted: Summon Creature Blackwood Warrior'),(3938,1,0,10,2168,90000,0,0,0,0,0,0,0,0,-1,1,6868.93,-525.996,40.2464,1.48353,0,'The Blackwood Corrupted: Summon Creature Blackwood Warrior'),(3938,1,0,10,2168,90000,0,0,0,0,0,0,0,0,-1,1,6850.23,-476.544,40.3891,0.418879,0,'The Blackwood Corrupted: Summon Creature Blackwood Warrior'),(9542,1,0,10,15571,9000000,0,0,0,0,0,0,0,0,-1,1,3564.83,-6723.55,-10.8831,0.395452,0,'Place Arcanite Buoy: Summon Creature Maws'),(9527,16,0,10,15552,44000,0,0,0,0,0,0,16,9528,-1,1,5088.21,-5087.08,922.385,4.89885,0,'Decoy!: Summon Doctor Weavil'),(9527,5,0,10,15553,61000,0,0,0,0,0,0,0,9529,-1,1,5166.07,-5196.86,938.6,2.125,0,'Decoy!: Summon Doctor Weavil\'s Flying Machine'),(9527,0,0,9,181756,31,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Decoy!: Respawn Stillpine Grain'),(9542,0,0,76,180670,9000,0,0,0,0,0,0,0,0,0,0,3477.38,-6565.47,-20.0101,1.79769,0,'Place Arcanite Buoy: Summon GameObject Bay of Storms Lightning Storm'),(9533,1,0,0,6,0,0,0,0,0,0,0,9503,0,0,0,0,0,0,0,0,'Grininlix the spectator yell Razza'),(9544,5,0,11,397147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Mur Alzzin'),(9543,1,0,3,0,10000,0,0,0,0,0,0,0,0,0,0,3511.51,-6617.96,-1.52992,4.2058,0,'Maws move'),(9532,1,0,0,6,0,0,0,0,0,0,0,9506,0,0,0,0,0,0,0,0,'Grininlix the spectator yell Skarr'),(9531,1,0,0,6,0,0,0,0,0,0,0,9501,0,0,0,0,0,0,0,0,'Grininlix the spectator yell Mushgog'),(9546,1,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,251.711,-397.293,-117.194,4.896,0,'Alzzin\'s Minion spawn 2'),(9546,1,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,250.475,-397.176,-117.194,4.896,0,'Alzzin\'s Minion spawn 2'),(9545,6,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,251.711,-397.293,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,6,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,250.475,-397.176,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,5,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,251.711,-397.293,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,5,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,250.475,-397.176,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,4,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,251.711,-397.293,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,4,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,250.475,-397.176,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,3,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,251.711,-397.293,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,3,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,250.475,-397.176,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,2,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,251.711,-397.293,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9545,2,0,10,11460,60000,0,0,0,0,0,0,0,0,-1,1,250.475,-397.176,-117.194,4.896,0,'Alzzin\'s Minion spawn'),(9548,2,0,9,44726,60000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Alzzin Felvine'),(9548,2,0,9,44727,60000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Alzzin Felvine'),(9548,2,0,9,44728,60000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Alzzin Felvine'),(9548,2,0,9,44729,60000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Alzzin Felvine'),(9548,2,0,9,44730,60000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Alzzin Felvine'),(8446,0,0,22,35,0,0,0,14325,30,8,3,0,0,0,0,0,0,0,0,0,'Captain Kromcrush : amical'),(5300,5,0,10,11120,900000,0,0,0,0,0,0,0,0,-1,1,3584.41,-2998.57,125,1.892,0,'Summon Crimson Hammersmith'),(8502,0,0,10,8440,1200000,1,100,0,0,0,0,8,850200,-1,1,-466.868,272.312,-90.7441,3.52557,8502,'Avatar of Hakkar Fight: Summon Creature Shade of Hakkar'),(9530,0,0,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Short John Mithril - Emote Yell'),(9530,0,0,4,147,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Short John Mithril - Remove Gossip Flag'),(9530,0,0,4,147,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Short John Mithril - Remove Quest Giver Flag'),(9530,3,0,20,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Short John Mithril - Start Waypoint Movement'),(663,15,0,0,0,0,0,0,3946,30,8,2,1358,0,0,0,0,0,0,0,0,'Tome of Mel\'Thandris: Velinde Starsong - Say Text'),(663,8,0,0,0,0,0,0,3946,30,8,2,1357,0,0,0,0,0,0,0,0,'Tome of Mel\'Thandris: Velinde Starsong - Say Text'),(663,5,0,0,0,0,0,0,3946,30,8,2,1356,0,0,0,0,0,0,0,0,'Tome of Mel\'Thandris: Velinde Starsong - Say Text'),(663,2,0,28,8,0,0,0,3946,30,8,2,0,0,0,0,0,0,0,0,0,'Tome of Mel\'Thandris: Velinde Starsong - Set Stand State'),(663,1,0,10,3946,17000,1,30,0,0,0,0,8,0,-1,1,3169.08,-1211.59,217.201,4.43314,0,'Tome of Mel\'Thandris: Velinde Starsong - Summon Creature Velinde Starsong'),(664,5,0,0,0,0,0,0,3946,10,8,2,1359,0,0,0,0,0,0,0,0,'The Scythe of Elune: Velinde Starsong - Say Text'),(664,1,0,35,0,0,0,0,3946,10,8,2,0,0,0,0,0,0,0,0,0,'The Scythe of Elune: Velinde Starsong - Set Orientation'),(664,0,0,10,3946,13000,1,10,0,0,0,0,8,0,-1,1,-11141.1,-1152.68,43.5816,4.7822,0,'The Scythe of Elune: Mound of Dirt - Summon Creature Velinde Starsong'),(420,2,0,0,0,0,0,0,2755,50,8,2,842,0,0,0,0,0,0,0,0,'Summoning the Princess - Myzrael: Say text 1'),(420,5,0,0,0,0,0,0,2755,50,8,2,843,0,0,0,0,0,0,0,0,'Summoning the Princess - Myzrael: Say text 2'),(420,10,0,0,0,0,0,0,2755,50,8,2,844,0,0,0,0,0,0,0,0,'Summoning the Princess - Myzrael: Say text 3'),(420,11,0,26,0,0,0,0,2755,50,8,2,0,0,0,0,0,0,0,0,0,'Summoning the Princess - Myzrael: Attack'),(8175,1,0,10,14351,900000,0,0,0,0,0,0,0,0,-1,1,539.868,535.142,27.9186,0.0017457,0,'Ogre Tannin Looted - Spawn Gordok Bushwacker'),(8175,0,0,37,13,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Ogre Tannin Looted - Set Instance Data'),(259,0,0,10,1770,90000,1,10,0,0,0,1,8,1770,0,1,875.38,1232.43,52.6,3.16,0,'Dusty Spellbooks: Summon Moonrage Darkrunner'),(264,0,0,10,2044,300000,0,0,0,0,0,1,0,0,0,1,-9552.67,-1431.93,62.3,5.03,0,'Marshal Haggard\'s Chest: Summon Forlorn Spirit'),(4845,0,0,76,175584,0,0,0,0,0,0,0,0,0,0,0,-13.8113,-396.202,48.536,3.0208,0,'Challenge to Urok - Summon GameObject Challenge to Urok'),(3561,0,0,9,98643,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Soft Dirt Mound - Respawn Gor\'tesh\'s Lopped Off Head'),(3561,0,0,68,13488,2,7033,100,0,0,0,0,0,0,0,0,0,0,0,0,0,'Soft Dirt Mound - Start Script for All Firegut Ogres'),(3561,0,0,68,13488,2,7034,100,0,0,0,0,0,0,0,0,0,0,0,0,0,'Soft Dirt Mound - Start Script for All Firegut Ogre Mages'),(3561,0,0,68,13488,2,7035,100,0,0,0,0,0,0,0,0,0,0,0,0,0,'Soft Dirt Mound - Start Script for All Firegut Brutes'),(693,0,0,76,19592,60000,0,0,0,0,0,0,0,0,0,0,1048.82,-442.209,4.7429,2.17129,0,'Set NG-5 Charge (Red) - Respawn NG-5 Explosives (Red)'),(691,0,0,13,0,0,0,0,20899,50,11,10,0,0,0,0,0,0,0,0,0,'Remote Detonate Red - Activate Venture Co. Explosives Wagon'),(691,0,0,41,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,'Remote Detonate Red - Despawn NG-5 Explosives (Red)'),(691,3,0,68,20899,2,3988,100,20899,50,11,14,0,0,0,0,0,0,0,0,0,'Remote Detonate Red - Start Script on All Venture Co. Operators'),(691,3,0,68,20899,2,3991,100,20899,50,11,14,0,0,0,0,0,0,0,0,0,'Remote Detonate Red - Start Script on All Venture Co. Deforesters'),(691,3,0,68,20899,2,3989,100,20899,50,11,14,0,0,0,0,0,0,0,0,0,'Remote Detonate Red - Start Script on All Venture Co. Loggers'),(692,0,0,13,0,0,0,0,19547,50,11,10,0,0,0,0,0,0,0,0,0,'Remote Detonate Blue - Activate Venture Co. Explosives Wagon'),(692,0,0,41,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,'Remote Detonate Blue - Despawn NG-5 Explosives (Blue)'),(692,3,0,68,20899,2,3988,100,19547,50,11,14,0,0,0,0,0,0,0,0,0,'Remote Detonate Blue - Start Script on All Venture Co. Operators'),(692,3,0,68,20899,2,3991,100,19547,50,11,14,0,0,0,0,0,0,0,0,0,'Remote Detonate Blue - Start Script on All Venture Co. Deforesters'),(692,3,0,68,20899,2,3989,100,19547,50,11,14,0,0,0,0,0,0,0,0,0,'Remote Detonate Blue - Start Script on All Venture Co. Loggers'),(601,0,0,0,0,0,0,0,9688,0,9,2,1235,0,0,0,0,0,0,0,0,'Flagongut\'s Fossil: Prospector Whelgar - Say Text'),(3361,0,0,39,336101,336102,0,0,0,0,0,1,50,50,0,0,0,0,0,0,0,'Thaurissan Relic - Start Script'),(9527,33,0,1,1,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Talk'),(9527,37,0,1,1,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Talk'),(9527,39,0,0,2,0,0,0,15552,50,8,3,11107,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Say Emoted Text'),(9527,39,0,1,25,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Point'),(9527,42,0,0,0,0,0,0,15552,50,8,3,11108,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Say Text'),(9527,42,0,1,1,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Talk'),(9527,46,0,1,1,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Talk'),(9527,50,0,0,0,0,0,0,15552,50,8,2,11109,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Say Text'),(9527,50,0,1,5,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Exclamation'),(9527,52,0,1,5,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Exclamation'),(9527,55,0,1,5,0,0,0,15552,50,8,3,0,0,0,0,0,0,0,0,0,'Decoy!: Doctor Weavil - Emote Exclamation'),(9527,59,0,10,15554,3000000,0,0,0,0,0,0,0,0,-1,1,5096.82,-5089.7,923.05,4.0144,0,'Decoy!: Summon Number Two'),(3718,5,0,81,17428,180,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Videre Elixir: Miblon\'s Door - Despawn'),(1653,0,0,9,28294,200,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Mana Surges - Respawn Mana Rift'),(1653,10,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,10,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,40,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,40,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,70,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,70,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,70,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,100,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,100,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,100,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,130,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,130,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,130,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,130,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,160,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,160,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,160,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,160,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,190,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,190,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,190,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,190,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(1653,190,0,10,6550,60000,0,0,0,0,0,0,0,6550,-1,2,-4019.22,-3383.91,38.2265,0,0,'Mana Surges - Summon Creature Mana Surge'),(9417,0,0,83,0,0,0,0,15415,100,8,0,0,0,0,0,0,0,0,0,0,'Toss Stink Bomb - Quest Credit for Stinking Up Southshore'),(8608,0,0,0,0,0,0,0,92849,0,9,2,10009,0,0,0,0,0,0,0,0,'Placing Message to the Wildhammer: Falstad Wildhammer - Say Text'),(8608,0,0,86,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Placing Message to the Wildhammer: Player - Set PvP'),(5618,0,0,61,5618,300,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Shadow Portal Polkelt: Start Scripted Map Event'),(5618,1,0,80,1,0,0,0,43196,0,12,2,0,0,0,0,0,0,0,0,0,'Shadow Portal Polkelt: Door - Close'),(5618,2,0,10,11598,300000,0,0,0,0,0,0,0,5618,-1,1,256.289,0.652,84.924,4.765,0,'Shadow Portal Polkelt: Summon Risen Guardian'),(5618,2,0,10,11598,300000,0,0,0,0,0,0,0,5618,-1,1,241.345,4.231,84.924,5.062,0,'Shadow Portal Polkelt: Summon Risen Guardian'),(5618,2,0,10,11598,300000,0,0,0,0,0,0,0,5618,-1,1,249.715,-5.978,85.106,3.177,0,'Shadow Portal Polkelt: Summon Risen Guardian'),(5618,2,0,10,11598,300000,0,0,0,0,0,0,0,5618,-1,1,230.05,-9.946,85.317,5.847,0,'Shadow Portal Polkelt: Summon Risen Guardian'),(5618,3,0,69,5618,0,0,0,0,0,0,0,0,0,5608,5608,0,0,0,0,0,'Shadow Portal Polkelt: Edit Map Event'),(5619,0,0,61,5619,300,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Shadow Portal Krastinov: Start Scripted Map Event'),(5619,1,0,80,1,0,0,0,43203,0,12,2,0,0,0,0,0,0,0,0,0,'Shadow Portal Krastinov: Door - Close'),(5619,2,0,10,11598,300000,0,0,0,0,0,0,0,5619,-1,1,180.707,-75.818,84.925,1.396,0,'Shadow Portal Krastinov: Summon Risen Guardian'),(5619,2,0,10,11598,300000,0,0,0,0,0,0,0,5619,-1,1,185.689,-64.627,84.925,5.55,0,'Shadow Portal Krastinov: Summon Risen Guardian'),(5619,2,0,10,11598,300000,0,0,0,0,0,0,0,5619,-1,1,175.7,-55.238,85.229,4.772,0,'Shadow Portal Krastinov: Summon Risen Guardian'),(5619,3,0,69,5619,0,0,0,0,0,0,0,0,0,5609,5609,0,0,0,0,0,'Shadow Portal Krastinov: Edit Map Event'),(5620,0,0,61,5620,300,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Shadow Portal Malicia: Start Scripted Map Event'),(5620,1,0,80,1,0,0,0,43184,0,12,2,0,0,0,0,0,0,0,0,0,'Shadow Portal Malicia: Door - Close'),(5620,2,0,10,11598,300000,0,0,0,0,0,0,0,5620,-1,1,123.306,3.933,85.312,6.056,0,'Shadow Portal Malicia: Summon Risen Guardian'),(5620,2,0,10,11598,300000,0,0,0,0,0,0,0,5620,-1,1,110.892,-6.463,85.312,0.436,0,'Shadow Portal Malicia: Summon Risen Guardian'),(5620,2,0,10,11598,300000,0,0,0,0,0,0,0,5620,-1,1,102.454,4.374,85.312,2.182,0,'Shadow Portal Malicia: Summon Risen Guardian'),(5620,3,0,69,5620,0,0,0,0,0,0,0,0,0,5610,5610,0,0,0,0,0,'Shadow Portal Malicia: Edit Map Event'),(5621,0,0,61,5621,300,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Shadow Portal Illucia: Start Scripted Map Event'),(5621,1,0,80,1,0,0,0,35798,0,12,2,0,0,0,0,0,0,0,0,0,'Shadow Portal Illucia: Door - Close'),(5621,2,0,10,11598,300000,0,0,0,0,0,0,0,5621,-1,1,239.556,-4.945,72.674,1.4525,0,'Shadow Portal Illucia: Summon Risen Guardian'),(5621,2,0,10,11598,300000,0,0,0,0,0,0,0,5621,-1,1,226.854,0.262,72.673,3.161,0,'Shadow Portal Illucia: Summon Risen Guardian'),(5621,2,0,10,11598,300000,0,0,0,0,0,0,0,5621,-1,1,248.115,2.809,72.669,4.668,0,'Shadow Portal Illucia: Summon Risen Guardian'),(5621,3,0,69,5621,0,0,0,0,0,0,0,0,0,5611,5611,0,0,0,0,0,'Shadow Portal Illucia: Edit Map Event'),(5622,0,0,61,5622,300,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Shadow Portal Alexei: Start Scripted Map Event'),(5622,1,0,80,1,0,0,0,43188,0,12,2,0,0,0,0,0,0,0,0,0,'Shadow Portal Alexei: Door - Close'),(5622,2,0,10,11598,300000,0,0,0,0,0,0,0,5622,-1,1,185.616,-42.912,75.4812,4.45059,0,'Shadow Portal Alexei: Summon Risen Guardian'),(5622,2,0,10,11598,300000,0,0,0,0,0,0,0,5622,-1,1,177.746,-42.7475,75.4812,4.88692,0,'Shadow Portal Alexei: Summon Risen Guardian'),(5622,2,0,10,11598,300000,0,0,0,0,0,0,0,5622,-1,1,181.825,-42.5812,75.4812,4.66003,0,'Shadow Portal Alexei: Summon Risen Guardian'),(5622,3,0,69,5622,0,0,0,0,0,0,0,0,0,5612,5612,0,0,0,0,0,'Shadow Portal Alexei: Edit Map Event'),(5623,0,0,61,5623,300,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,'Shadow Portal Ravenian: Start Scripted Map Event'),(5623,1,0,80,1,0,0,0,43187,0,12,2,0,0,0,0,0,0,0,0,0,'Shadow Portal Ravenian: Door - Close'),(5623,2,0,10,11598,300000,0,0,0,0,0,0,0,5623,-1,1,128.806,-7.874,75.482,5.62,0,'Shadow Portal Ravenian: Summon Risen Guardian'),(5623,2,0,10,11598,300000,0,0,0,0,0,0,0,5623,-1,1,130.415,-1.113,75.482,2.688,0,'Shadow Portal Ravenian: Summon Risen Guardian'),(5623,2,0,10,11598,300000,0,0,0,0,0,0,0,5623,-1,1,124.162,5.816,75.482,5.061,0,'Shadow Portal Ravenian: Summon Risen Guardian'),(5623,3,0,69,5623,0,0,0,0,0,0,0,0,0,5613,5613,0,0,0,0,0,'Shadow Portal Ravenian: Edit Map Event'),(510,1,0,13,0,0,0,0,3524,30,11,0,0,0,0,0,0,0,0,0,0,'Activate Demon Seed'),(510,2,0,81,15128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn Circle of Flame'),(466,0,0,9,332887,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Winterhoof Cleansing - Respawn Water Well Cleansing Aura (GUID: 332887)'),(467,0,0,9,332888,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Thunderhorn Cleansing - Respawn Water Well Cleansing Aura (GUID: 332888)'),(468,0,0,9,332889,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Wildmane Cleansing - Respawn Water Well Cleansing Aura (GUID: 332889)'),(525,0,0,9,332890,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Stagnant Oasis - Respawn Fissure Plant (GUID: 332890)'),(525,0,0,9,332891,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Stagnant Oasis - Respawn Fissure Plant (GUID: 332891)'),(525,0,0,9,332892,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Stagnant Oasis - Respawn Fissure Plant (GUID: 332892)'),(525,0,0,9,332893,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Stagnant Oasis - Respawn Fissure Plant (GUID: 332893)'),(525,0,0,9,332894,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Stagnant Oasis - Respawn Fissure Plant (GUID: 332894)'),(452,0,0,9,14199,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Enchanted Sea Kelp - Respawn GameObject Enchanted Sea Kelp (Guid: 14199)'),(452,0,0,9,14200,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Enchanted Sea Kelp - Respawn GameObject Enchanted Sea Kelp (Guid: 14200)'),(452,0,0,9,14201,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Enchanted Sea Kelp - Respawn GameObject Enchanted Sea Kelp (Guid: 14201)'),(452,0,0,9,14202,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Enchanted Sea Kelp - Respawn GameObject Enchanted Sea Kelp (Guid: 14202)'),(452,0,0,9,14203,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Enchanted Sea Kelp - Respawn GameObject Blue Aura (Guid: 14203)'),(1428,0,0,76,92252,120,0,0,0,0,0,0,0,0,0,0,-768.659,-3721.86,42.3966,4.55531,0,'The Binding: Summon GameObject Strahad\'s Summoning Circle'),(1428,2,0,1,2,0,0,0,6253,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Fenrick - Emote OneShotBow'),(1428,2,0,1,2,0,0,0,6254,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Wytula - Emote OneShotBow'),(1428,2,0,1,2,0,0,0,6252,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Magaz - Emote OneShotBow'),(1428,2,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Binding: Strahad Farsan - Emote OneShotTalk'),(1428,2,0,0,0,0,0,0,0,0,0,0,2374,0,0,0,0,0,0,0,0,'The Binding: Strahad Farsan - Say Text'),(1428,2,0,4,147,2,2,0,6252,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Magaz - Remove Npc Flags'),(1428,2,0,4,147,2,2,0,6254,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Wytula - Remove Npc Flags'),(1428,5,0,3,0,2534,1,2,0,0,0,0,0,0,0,0,-763.195,-3720.34,42.2333,3.15487,0,'The Binding: Strahad Farsan - Move'),(1428,5,0,15,8675,0,0,0,6252,30,8,6,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Magaz - Cast Spell Warlock Channeling'),(1428,5,0,15,8675,0,0,0,6254,30,8,6,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Wytula - Cast Spell Warlock Channeling'),(1428,5,0,15,8675,0,0,0,6253,30,8,6,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Fenrick - Cast Spell Warlock Channeling'),(1428,14,0,76,92388,106,0,0,0,0,0,0,0,0,0,0,-768.692,-3721.9,42.3976,2.68781,0,'The Binding: Summon GameObject Summoning Circle'),(1449,1,0,1,34,0,0,0,6253,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Fenrick - Emote OneShotWoundCritical'),(1449,1,0,1,34,0,0,0,6254,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Wytula - Emote OneShotWoundCritical'),(1449,1,0,1,34,0,0,0,6252,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Magaz - Emote OneShotWoundCritical'),(1449,1,0,4,147,2,1,0,6254,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Wytula - Add Npc Flags'),(1449,1,0,4,147,2,1,0,6252,30,8,2,0,0,0,0,0,0,0,0,0,'The Binding: Acolyte Magaz - Add Npc Flags'),(1449,3,0,41,0,0,0,0,92252,30,11,2,0,0,0,0,0,0,0,0,0,'The Binding: Strahad\'s Summoning Circle - Despawn'),(1449,3,0,41,0,0,0,0,92388,30,11,2,0,0,0,0,0,0,0,0,0,'The Binding: Summoning Circle - Despawn'),(6206,0,0,1,4,0,0,0,42333,0,9,2,0,0,0,0,0,0,0,0,0,'Spell Use Bauble: Tajarri - Emote'),(6206,1,0,0,0,0,0,0,42333,0,9,2,7611,0,0,0,0,0,0,0,0,'Spell Use Bauble: Tajarri - Talk'),(5759,1,0,10,11887,600000,3,0,0,0,0,0,8,1188703,-1,1,1573.05,-3253.93,86.7212,4.34587,0,'Of Forgotten Memories - Summon Creature'),(3094,0,0,38,148830,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Atal\'ai Statue - process secret circle'),(3095,0,0,38,148831,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Atal\'ai Statue - process secret circle'),(3097,0,0,38,148832,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Atal\'ai Statue - process secret circle'),(3098,0,0,38,148833,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Atal\'ai Statue - process secret circle'),(3099,0,0,38,148834,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Atal\'ai Statue - process secret circle'),(3100,0,0,38,148835,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Atal\'ai Statue - process secret circle'),(413,0,0,31,2794,100,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Runed Pedestal: Terminate Script if Summoned Guardian is found'),(413,1,0,10,2570,300000,0,0,0,0,0,0,0,2718,-1,1,-1777.91,-1501.28,65.0042,4.66003,0,'Runed Pedestal: Summon Creature Boulderfist Shaman'),(413,1,1,10,2569,300000,0,0,0,0,0,0,0,2717,-1,1,-1729.03,-1574.77,53.9953,3.59538,0,'Runed Pedestal: Summon Creature Boulderfist Mauler'),(413,1,2,10,2569,300000,0,0,0,0,0,0,0,2716,-1,1,-1742.55,-1594.43,52.7884,1.97222,0,'Runed Pedestal: Summon Creature Boulderfist Mauler'),(413,1,3,10,2569,300000,0,0,0,0,0,0,0,2715,-1,1,-1764.01,-1591,53.1026,1.309,0,'Runed Pedestal: Summon Creature Boulderfist Mauler'),(413,1,4,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1776.35,-1523.46,65.0042,1.5708,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(413,1,5,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1782.63,-1508.94,99.3345,3.08923,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(413,1,6,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1777.76,-1516.91,99.3345,4.29351,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(413,1,7,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1770.32,-1510.47,90.5951,0.890118,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(413,1,8,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1772.38,-1522.57,75.3211,2.1293,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(413,1,9,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1758.89,-1555.83,58.6428,5.11381,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(413,1,10,10,2794,300000,0,0,0,0,0,0,0,0,-1,1,-1748.81,-1555.65,58.5205,4.38078,0,'Runed Pedestal: Summon Creature Summoned Guardian'),(3938,2,0,68,3940,2,2168,40,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Blackwood Corrupted: Start Script on All Blackwood Warriors'),(3938,2,1,68,3940,2,2169,40,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Blackwood Corrupted: Start Script on All Blackwood Totemics'),(3938,18,0,10,10373,90000,0,0,0,0,0,0,1,3939,-1,1,6891.92,-477.762,44.3988,3.80459,0,'The Blackwood Corrupted: Summon Creature Xabraxxis'),(4884,0,0,80,1,0,0,0,260283,0,12,0,0,0,0,0,0,0,0,0,0,'Emberseer Start - Close Emberseer In'),(4884,0,0,80,1,0,0,0,260284,0,12,0,0,0,0,0,0,0,0,0,0,'Emberseer Start - Close Doors'),(4884,0,0,68,103162,2,10316,50,0,0,0,0,0,0,0,0,0,0,0,0,0,'Emberseer Start - Start Script on Incarcerators'),(4884,0,0,44,2,0,0,0,9816,30,8,2,100,0,0,0,0,0,0,0,0,'Emberseer Start - Start Phase 2 on Pyroguard Emberseer'),(9208,3,0,10,15286,7200000,0,0,0,0,0,0,0,920801,-1,1,-7258.49,828.158,3.21053,4.29351,0,'Glyphs of Calling: Summon Creature Xil\'xix'),(9208,3,0,10,15288,7200000,0,0,0,0,0,0,0,920801,-1,1,-7223.8,820.815,4.89979,0.0872665,0,'Glyphs of Calling: Summon Creature Aluntir'),(9208,3,0,10,15290,7200000,0,0,0,0,0,0,0,920801,-1,1,-7268.27,878.263,1.88339,1.85005,0,'Glyphs of Calling: Summon Creature Arakis'),(9208,4,0,69,9208,0,0,0,0,0,0,0,9208,920802,0,0,0,0,0,0,0,'Glyphs of Calling: Edit Scripted Map Event'),(4622,0,0,39,4622,0,0,0,0,0,0,0,100,0,0,0,0,0,0,0,4624,'Call of Vaelastrasz: Summon Vaelstrasz during Stadium Event in UBRS'),(727,0,0,9,3114,180,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Frostmaw: Respawn GameObject Fresh Lion Carcass'),(727,0,0,9,3115,180,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Frostmaw: Respawn GameObject Black Smoke - scale 2');
        
        -- New creature spell lists. Vile Familiar (Fireball)
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (31010, 'Vile Familiar ', 133, 50, 1, 0, 0, 0, 5, 15, 5, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        UPDATE `creature_template` SET `spell_list_id` = '31010' WHERE (`entry` = '3101');

        insert into applied_updates values ('220720241');
    end if;
end $
delimiter ;