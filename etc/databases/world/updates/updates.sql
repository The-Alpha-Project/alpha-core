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
        UPDATE `creature_movement` SET `position_x` = '-4896.254', `position_y` = '-985.086', `position_z` = '588.814', `orientation` = '5.42' WHERE (`id` = '1748') and (`point` = '5');
        UPDATE `creature_movement` SET `position_x` = '-4890.622', `position_y` = '-992.326', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '6');
        UPDATE `creature_movement` SET `position_x` = '-4884.366', `position_y` = '-1000.426', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '7');
        UPDATE `creature_movement` SET `position_x` = '-4861.852', `position_y` = '-981.855', `position_z` = '492.197' WHERE (`id` = '1748') and (`point` = '8');
        UPDATE `creature_movement` SET `position_x` = '-4884.366', `position_y` = '-1000.426', `position_z` = '492.197', `orientation` = '0', `waittime` = '0' WHERE (`id` = '1748') and (`point` = '9');

        insert into applied_updates values ('170720241');
    end if;
end $
delimiter ;