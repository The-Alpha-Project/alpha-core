delimiter $
begin not atomic

    -- 01/09/2024 1
    if (select count(*) from applied_updates where id='010920241') = 0 then
        -- Apprentice Physician  
        UPDATE `trainer_template` SET `skillpointcost` = '2' WHERE (`template_entry` = '500') and (`spell` = '3279');
        -- Journeyman Physician
        UPDATE `trainer_template` SET `skillpointcost` = '4' WHERE (`template_entry` = '500') and (`spell` = '3280');
        -- Leatherworking
        UPDATE `trainer_template` SET `skillpointcost` = '4' WHERE (`template_entry` = '509') and (`spell` = '2155');
        UPDATE `trainer_template` SET `skillpointcost` = '7' WHERE (`template_entry` = '509') and (`spell` = '2154');
        UPDATE `trainer_template` SET `skillpointcost` = '10' WHERE (`template_entry` = '509') and (`spell` = '3812');
        -- Cooking
        UPDATE `trainer_template` SET `skillpointcost` = '2' WHERE (`template_entry` = '501') and (`spell` = '2551');
        UPDATE `trainer_template` SET `skillpointcost` = '3' WHERE (`template_entry` = '501') and (`spell` = '3412');
        UPDATE `trainer_template` SET `skillpointcost` = '4' WHERE (`template_entry` = '501') and (`spell` = '2552');
        -- Tailoring
        UPDATE `trainer_template` SET `skillpointcost` = '4' WHERE (`template_entry` = '507') and (`spell` = '3911');
        UPDATE `trainer_template` SET `skillpointcost` = '7' WHERE (`template_entry` = '507') and (`spell` = '3912');
        UPDATE `trainer_template` SET `skillpointcost` = '10' WHERE (`template_entry` = '507') and (`spell` = '3913');

        -- Lockpicking
        -- From 0.9 patch notes. 'Now only rogues may train in Lock Picking, which they will do from their Rogue class trainers.'
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('25', '6480', '1804', '0', '0', '5', '0', '0', '16', '0', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('25', '6481', '6461', '0', '0', '5', '0', '75', '20', '1804', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('25', '6482', '6463', '0', '0', '5', '0', '150', '24', '6461', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('26', '6480', '1804', '0', '0', '5', '0', '0', '16', '0', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('26', '6481', '6461', '0', '0', '5', '0', '75', '20', '1804', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('26', '6482', '6463', '0', '0', '5', '0', '150', '24', '6461', '0', '0');
        
        -- Use secondary profession (181 Lockpicking) isntead of class skill (242)
        UPDATE `trainer_template` SET `spell` = '1809' WHERE (`template_entry` = '25') and (`spell` = '6480');
        UPDATE `trainer_template` SET `spell` = '1809' WHERE (`template_entry` = '26') and (`spell` = '6480');
        UPDATE `trainer_template` SET `spell` = '1810', `reqskill` = '181' WHERE (`template_entry` = '25') and (`spell` = '6481');
        UPDATE `trainer_template` SET `spell` = '1810', `reqskill` = '181' WHERE (`template_entry` = '26') and (`spell` = '6481');
        UPDATE `trainer_template` SET `spell` = '6460', `reqskill` = '181' WHERE (`template_entry` = '25') and (`spell` = '6482');
        UPDATE `trainer_template` SET `spell` = '6460', `reqskill` = '181' WHERE (`template_entry` = '26') and (`spell` = '6482');

        -- Lockpicking Trainers template.
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('27', '1809', '1804', '0', '0', '5', '0', '0', '16', '0', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('27', '1810', '6461', '0', '0', '5', '181', '75', '20', '1804', '0', '0');
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`, `req_spell_1`, `req_spell_2`, `req_spell_3`) VALUES ('27', '6460', '6463', '0', '0', '5', '181', '150', '24', '6461', '0', '0');

        UPDATE `creature_template` SET `trainer_id` = '27' WHERE (`entry` = '2737');
        UPDATE `creature_template` SET `trainer_id` = '27' WHERE (`entry` = '2795');
        UPDATE `creature_template` SET `trainer_id` = '27' WHERE (`entry` = '2796');
        UPDATE `creature_template` SET `trainer_id` = '27' WHERE (`entry` = '3182');
        UPDATE `creature_template` SET `trainer_id` = '27' WHERE (`entry` = '3402');
        UPDATE `creature_template` SET `trainer_id` = '27' WHERE (`entry` = '5027');
        
        -- Lucian Fenner -> Lockpicking Trainer.
        UPDATE `creature_template` SET `subname` = 'Lockpicking Trainer', `npc_flags` = '8', `trainer_id` = '27' WHERE (`entry` = '2799');
        
        -- Tynnus Venomsprout <Shady Dealer> -> Poison Vendor
        UPDATE `creature_template` SET `subname` = 'Poison Vendor' WHERE (`entry` = '5169');
        
        -- Sewa Mistrunner - Placement
        UPDATE `spawns_creatures` SET `position_x` = '-1176.36', `position_y` = '-66.7109', `position_z` = '162.231' WHERE (`spawn_id` = '26653');
        -- Aska Mistrunner - Placement
        UPDATE `spawns_creatures` SET `position_x` = '-1222.345', `position_y` = '-13.229', `position_z` = '165.890', `orientation` = '5.32' WHERE (`spawn_id` = '26649');

        insert into applied_updates values ('010920241');
    end if;

    -- 04/09/2024 1
    if (select count(*) from applied_updates where id='040920241') = 0 then
        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (185203);

        -- Events list for Araj the Summoner
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1852;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (185201, 1852, 0, 9, 0, 100, 1, 0, 8, 14000, 20000, 185201, 0, 0, 'Araj the Summoner - Cast Frost Nova');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (185202, 1852, 0, 1, 0, 100, 0, 1000, 1000, 0, 0, 185202, 0, 0, 'Araj the Summoner - Cast Frost Armor on Spawn');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (185204, 1852, 0, 7, 0, 100, 0, 0, 0, 0, 0, 185204, 0, 0, 'Araj the Summoner - Remove Guardians on Evade');

        DELETE FROM `creature_ai_scripts` WHERE `id`=185401;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (185401, 0, 0, 15, 1006, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'High Priest Thel danis - Cast Spell Inner Fire');

        DELETE FROM `creature_ai_scripts` WHERE `id`=185202;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (185202, 0, 0, 15, 7301, 3, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Araj the Summoner - Cast Spell Frost Armor');

        DELETE FROM `creature_ai_scripts` WHERE `id`=185201;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (185201, 0, 0, 15, 6131, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Araj the Summoner - Cast Spell Frost Nova');


        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (183101);

        -- Events list for Scarlet Hunter
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1831;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (183102, 1831, 0, 2, 0, 100, 0, 15, 0, 0, 0, 183102, 0, 0, 'Scarlet Hunter - Flee at 15% HP');

        DELETE FROM `creature_ai_scripts` WHERE `id`=178701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (178701, 0, 0, 15, 1608, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Executioner - Cast Spell Strike');

        -- Removing unused script actions.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (120003, 120004);

        -- Events list for Morbent Fel
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1200;

        insert into applied_updates values ('040920241');
    end if;
    
    -- 04/09/2024 2
    if (select count(*) from applied_updates where id='040920242') = 0 then
        -- Grave Robber
        UPDATE `creature_template` SET `display_id1` = '1287', `display_id2` = '1289' WHERE (`entry` = '218');     
        -- Report to Orgnil (805) should be turned in to Orgnil (3188)
        UPDATE `creature_quest_finisher` SET `entry` = '3142' WHERE (`entry` = '3188') and (`quest` = '805');
        -- XP 440
        UPDATE `quest_template` SET `RewXP` = '440' WHERE (`entry` = '805');
        -- Orgnil should start quest 823. (Master Gadrin)
        UPDATE `creature_quest_starter` SET `entry` = '3142' WHERE (`entry` = '3188') and (`quest` = '823');
        -- Should be turned in to Master Gadrin (3188)
        UPDATE `creature_quest_finisher` SET `entry` = '3188' WHERE (`entry` = '3142') and (`quest` = '823');
        -- Chain quests, and modify xp to 210.
        UPDATE `quest_template` SET `NextQuestId` = '823' WHERE (`entry` = '805');
        UPDATE `quest_template` SET `PrevQuestId` = '805', `RewXP` = '210' WHERE (`entry` = '823');
        UPDATE `quest_template` SET `PrevQuestId` = '792', `NextQuestId` = '805' WHERE (`entry` = '794');
        UPDATE `quest_template` SET `NextQuestInChain` = '823' WHERE (`entry` = '805');
        
        -- 421 Prove Your Worth, 422 Arugal's Folly, 423 Arugal's Folly, 424 Arugal's Folly, 99 Arugal's Folly, 1014 Arugal Must Die
        UPDATE `quest_template` SET `NextQuestInChain` = '1014' WHERE (`entry` = '99');
        UPDATE `quest_template` SET `PrevQuestId` = '99' WHERE (`entry` = '1014');
        
        -- Chest placement.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5603.735', `spawn_positionY` = '646.926', `spawn_positionZ` = '393.223' WHERE (`spawn_id` = '9940');
        
        -- Gennia Runetotem - Placement.
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Mulgore/561843-534914_20040426_057.jpg
        UPDATE `spawns_creatures` SET `position_x` = '-2291.692', `position_y` = '-457.035', `position_z` = '-5.927', `orientation` = '0.087' WHERE (`spawn_id` = '26903');
        -- Narm Skychaser - Placement.
        UPDATE `spawns_creatures` SET `position_x` = '-2278.957', `position_y` = '-448.956', `position_z` = '-5.027', `orientation` = '3.88' WHERE (`spawn_id` = '26906');
        -- Harken Windtotem - Placement.
        UPDATE `spawns_creatures` SET `position_x` = '-2278.524', `position_y` = '-464.750', `position_z` = '-5.92', `orientation` = '2.035' WHERE (`spawn_id` = '24798');
        -- Burning Embers - Ignore
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '20439');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '20468');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '20445');
        -- Fix waypoints for Brave Wildrunner
        UPDATE `creature_movement_template` SET `position_z` = '-9.811' WHERE (`entry` = '3222') and (`point` = '4');
        UPDATE `creature_movement_template` SET `position_x` = '-2229.903', `position_y` = '-459.384', `position_z` = '-8.333' WHERE (`entry` = '3222') and (`point` = '34');
        UPDATE `creature_movement_template` SET `position_x` = '-2244.761', `position_y` = '-485.080', `position_z` = '-6.249' WHERE (`entry` = '3222') and (`point` = '35');
        UPDATE `creature_movement_template` SET `position_x` = '-2272.884', `position_y` = '-497.443', `position_z` = '-8.947' WHERE (`entry` = '3222') and (`point` = '36');
        UPDATE `creature_movement_template` SET `position_x` = '-2318.375', `position_y` = '-509.266', `position_z` = '-9.314' WHERE (`entry` = '3222') and (`point` = '37');
        UPDATE `creature_movement_template` SET `position_x` = '-2294.070', `position_y` = '-434.362', `position_z` = '-5.496' WHERE (`entry` = '3222') and (`point` = '40');
        UPDATE `creature_movement_template` SET `position_x` = '-2306.613', `position_y` = '-417.435', `position_z` = '-8.294' WHERE (`entry` = '3222') and (`point` = '41');
        UPDATE `creature_movement_template` SET `position_x` = '-2306.613', `position_y` = '-417.435', `position_z` = '-8.294' WHERE (`entry` = '3222') and (`point` = '42');
        UPDATE `creature_movement_template` SET `position_x` = '-2306.613', `position_y` = '-417.435', `position_z` = '-8.294' WHERE (`entry` = '3222') and (`point` = '43');
        
        -- Ignore quest A Lesson to Learn (Aquatic Form chain)
        UPDATE `quest_template` SET `ignored` = '1' WHERE (`entry` = '27');
        -- Ignore quest Finding the Source, invalid items, invalid spells.
        UPDATE `quest_template` SET `ignored` = '1' WHERE (`entry` = '974');
        -- Enable 'The Great Lift' elevators.
        UPDATE `spawns_gameobjects` SET `ignored` = '0' WHERE (`spawn_id` = '16876');
        UPDATE `spawns_gameobjects` SET `ignored` = '0' WHERE (`spawn_id` = '16874');
        -- Food Crate Z.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-6.55' WHERE (`spawn_id` = '43044');
        -- Fix chest state.
        UPDATE `spawns_gameobjects` SET `spawn_state` = '1' WHERE (`spawn_id` = '60099');
        
        -- Missing gold for chests.
        UPDATE `gameobject_template` SET `mingold` = 267, `maxgold` = 267 WHERE `entry` IN (3714, 4095);
        UPDATE `gameobject_template` SET `mingold` = 242, `maxgold` = 242 WHERE `entry` IN (3715, 105579);
        UPDATE `gameobject_template` SET `mingold` = 30, `maxgold` = 75 WHERE `entry` IN (106318);
        UPDATE `gameobject_template` SET `mingold` = 1879, `maxgold` = 1879 WHERE `entry` IN (131978, 153468);
        UPDATE `gameobject_template` SET `mingold` = 401, `maxgold` = 791 WHERE `entry` IN (153451);
        UPDATE `gameobject_template` SET `mingold` = 1628, `maxgold` = 2366 WHERE `entry` IN (153462, 153463);

        -- Defias Traitor - Spawn time 7-9 minutes. (From 30 seconds)
        -- Remove run flag, double the event time limit to 20 minutes.
        -- https://crawler.thealphaproject.eu/mnt/crawler/media/Patch-Note/unofficial_beta_patchnotes.txt
        UPDATE `spawns_creatures` SET `spawntimesecsmin` = '420', `spawntimesecsmax` = '540' WHERE (`spawn_id` = '90214');
        DELETE FROM `quest_start_scripts` WHERE `id`=155;
        INSERT INTO `quest_start_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (155, 0, 0, 61, 155, 1200, 0, 0, 0, 0, 0, 8, 0, 15502, 1019, 15501, 0, 0, 0, 0, 0, 'The Defias Brotherhood: Start Scripted Map Event'),
        (155, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Say Text'),
        (155, 0, 2, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Remove Questgiver Flag'),
        (155, 3, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Start Waypoints');
        
        -- Chest placement.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10720.001', `spawn_positionY` = '758.654', `spawn_positionZ` = '1322.234' WHERE (`spawn_id` = '49528');

        -- Down the Scarlet Path (ID 261) https://github.com/The-Alpha-Project/alpha-core/issues/1438
        UPDATE `quest_template` SET `ZoneOrSort` = '10', `MinLevel` = '23', `QuestLevel` = '28', `Details` = 'I will be frank.  We are at war with the Scourge.  It is an evil that corrupts our people and infects our land.  It must be stopped before it washes over our last bastions and drags our world into shadow.  We of the Scarlet Crusade have sworn to fight the Scourge with body and soul.$B$BIf you would take this same oath, then gather your courage and prove your allegiance - wage war with the Undead of Duskwood, and return to me with proof of your deeds. $B$BDo this, and the Crusade will embrace you.', `Objectives` = 'Bring 12 Shriveled Eyes to Brother Anton in Stormwind.', `ReqCreatureOrGOId1` = '2477', `ReqCreatureOrGOCount1` = '12', `RewXP` = '2050', `RewOrReqMoney` = '2000' WHERE (`entry` = '261');
        
        -- Down the Scarlet Path (ID 1052) https://github.com/The-Alpha-Project/alpha-core/issues/1438
        UPDATE `quest_template` SET `ZoneOrSort` = '10', `MinLevel` = '23', `QuestLevel` = '28', `Details` = 'We of the Scarlet Crusade lay claim to strongholds from Hearthglen to Tirisfal Glades. We are quite proud of our bastions of cleansing throughout Lordaeron.$b$bYou have proven yourself against the undead in southern Azeroth. But the true threat of the plague lies in the northern lands of Lordaeron.$b$bTravel to the town of Southshore, in the Eastern Kingdoms. Seek out a crusader named Raleigh the Devout. Give him this letter of commendation bearing my seal and he will escort you to a place of honor in our Scarlet Monastery.', `RewXP` = '1200' WHERE (`entry` = '1052');

        -- In the Name of the Light (ID 1053) https://github.com/The-Alpha-Project/alpha-core/issues/1438
        UPDATE `quest_template` SET `ZoneOrSort` = '271',  `MinLevel` = '23', `QuestLevel` = '35', `RewItemId1` = '1217', `RewItemCount1` = '1', `RewXP` = '8650' WHERE (`entry` = '1053');

        -- Brother Anton, no equipment and level.
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50', `equipment_id` = '0' WHERE (`entry` = '1182');
        
        -- Fix Raleigh the Devout Hammer, remove offhand non existent book.
        UPDATE `creature_equip_template` SET `equipentry1` = '2524', `equipentry2` = '0' WHERE (`entry` = '3980');
        
        -- Ravager's Skull (ID 2477) should be renamed to "Shriveled Eye"
        UPDATE `item_template` SET `name` = 'Shriveled Eye' WHERE (`entry` = '2477');

        -- Ravager's Skull (ID 2477) drop. Brain Eaters, Plague Spreaders, Bone Chewers, Fetid Corpses and Rotted Ones.
        DELETE FROM `creature_loot_template` WHERE (`item` = '2477');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('570', '2477', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('604', '2477', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('210', '2477', '-40', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('127', '2477', '-15', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('948', '2477', '-15', '0', '1', '1', '0');
    
        -- Fix Raleigh the Devout timing for Respawn Gobject, should appear right when 'Raleigh the Devout throws Anton's letter down on the table.' happens.
        DELETE FROM `quest_end_scripts` WHERE `id`=1052;
        INSERT INTO `quest_end_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (1052, 0, 0, 1, 69, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Emote'),
        (1052, 0, 0, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Modify Flags'),
        (1052, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1377, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Talk'),
        (1052, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1378, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Talk'),
        (1052, 7, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Emote'),
        (1052, 8, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -848.237, -577.427, 18.546, 0, 0, 'Raleigh the Devout - Move'),
        (1052, 14, 0, 1, 61, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Emote'),
        (1052, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1379, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Talk'),
        (1052, 15, 0, 9, 133, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Respawn Gobject'),
        (1052, 20, 0, 19, 0, 0, 0, 0, 0, 0, 0, 0, 1906, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Set Equipment'),
        (1052, 23, 0, 1, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Emote'),
        (1052, 24, 0, 13, 0, 0, 0, 0, 133, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Activate Gobject'),
        (1052, 26, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -844.878, -580.284, 18.5459, 2.391, 0, 'Raleigh the Devout - Move'),
        (1052, 28, 0, 19, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Set Equipment'),
        (1052, 31, 0, 4, 147, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raleigh the Devout - Modify Flags');

        -- Anton's Letter of Commendation
        UPDATE `gameobject_template` SET `flags` = '4' WHERE (`entry` = '19534');

        -- Missing Goldshire guard.
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400464', '1423', '0', '0', '0', '0', '-9497.842', '67.635', '56.367', '6.131', '300', '300', '0', '100', '100', '0', '0', '0', '0');

        -- Addon - Equipment id.
        INSERT INTO `creature_addon` (`guid`, `display_id`, `mount_display_id`, `equipment_id`, `stand_state`, `sheath_state`, `emote_state`) VALUES ('400464', '0', '0', '400464', '0', '1', '0');
        INSERT INTO `creature_equip_template` (`entry`, `equipentry1`, `equipentry2`, `equipentry3`) VALUES ('400464', '2714', '143', '1899');

        insert into applied_updates values ('040920242');
    end if;
    
    -- 25/09/2024 1
    if (select count(*) from applied_updates where id='250920241') = 0 then
        -- Resupplying the Excavation (273), partial fix for https://github.com/The-Alpha-Project/alpha-core/issues/1400
        -- Missing script for ambush event but quest is now completable.
        INSERT INTO `areatrigger_quest_relation` (`id`, `quest`) VALUES ('171', '273');
        
        -- Relocate Kor'ghan to Sen'jin Village.
        -- https://crawler.thealphaproject.eu/mnt/crawler/media/Website/warcry.com/Atlas-May-June-2004/WoW%20Warcry%20-%20Content%20-%20Atlas%20-%20Durotar.php.html
        -- https://warcraft.wiki.gg/wiki/Kor%27ghan
        UPDATE `spawns_creatures` SET `position_x` = '-839.403', `position_y` = '-4941.380', `position_z` = '20.992', `orientation` = '1.237' WHERE (`spawn_id` = '6458');
        
        -- Bring back 2 beta quests for Kor'ghan, 810 and 811.
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('810', '2', '367', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '811', '0', '811', '0', '0', '0', 'Clattering Scorpids', 'You would do well to learn how dangerous this land can be, $C.$B$BThe wildlife here can teach us such things... if we are wise and observant.$B$BThe scorpids are a perfect example of survival in Durotar. If you are to survive, it would be wise to take on some of their characteristics as your own. Their hardened carapaces can protect you from the harshness of the sun, or even a deadly weapon.$B$BBring me 6 Small Scorpid Carapaces from the Clattering Scorpids, $N, and I shall see about rewarding you justly.', 'Bring 6 Small Scorpid Carapaces to Kor\'ghan in Sen\'jin Village.', '', 'Did you get my 6 Small Scorpid Carapaces, $N?', '', '', '', '', '', '4884', '0', '0', '0', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '200', '55', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');
        
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('811', '2', '367', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '810', '0', '0', '0', '0', '0', '0', 'Armored Scorpids', 'One of the other traits of the scorpids is their fierce loyalty. They will protect one another if they are in danger--you\'ve probably already seen this behavior in your first scorpid hunt.$B$BYou would do well to heed that lesson and adapt it for yourself: we are stronger as one; we are weak when we are divided into many.$B$BBring me 8 Large Scorpid Carapaces from the Armored Scorpids and I shall reward you for learning this wisdom.', 'Bring 8 Large Scorpid Carapaces to Kor\'ghan in Sen\'jin Village.', '', 'Did you get my 8 Large Scorpid Carapaces, $N?', '', '', '', '', '', '4885', '0', '0', '0', '8', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '350', '110', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');
        
        -- Kor'ghan starter/finisher.
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3189', '810');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3189', '811');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3189', '810');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3189', '811');
        
        --  Small/Large Scorpid Carapace, no longer deprecated.
        UPDATE `item_template` SET `name` = 'Small Scorpid Carapace' WHERE (`entry` = '4884');
        UPDATE `item_template` SET `name` = 'Large Scorpid Carapace' WHERE (`entry` = '4885');

        -- Armored Scorpid, drop Large Scorpid Carapace.
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3126', '4885', '-80', '0', '1', '1', '0');
        -- Clattering Scorpid, drop Small Scorpid Carapace.
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3125', '4884', '-80', '0', '1', '1', '0');

        -- Update Need for a cure quest (812), Orgrimmar -> Sen\'jin Village
        UPDATE `quest_template` SET `Details` = '$N... your timing is perfect. I just hope I can compliment your haste as well.$B$BI was careless while fighting a few of the venomtails nearby, and one of them stung me deeply. I can feel its poison weakening me even as we speak. At this rate, I got maybe an hour left to live. But I\'ll need your help if I\'m to do so...$B$BKor\'ghan in Sen\'jin Village knows how to make the antidote. Find him... and hurry, $N. I won\'t be able to last much longer.', `Objectives` = 'Find Kor\'ghan in Sen\'jin Village and get the Venomtail Antidote. Then bring the antidote to Rhinag near the northwestern border of Durotar.' WHERE (`entry` = '812');
        
        -- Update Finding the antidote quest (813), Orgrimmar -> Sen\'jin Village
        UPDATE `quest_template` SET `Objectives` = 'Bring 4 Venomtail Poison Sacs to Kor\'ghan in Sen\'jin Village.' WHERE (`entry` = '813');

        insert into applied_updates values ('250920241');
    end if;
  
    -- 26/09/2024 1
    if (select count(*) from applied_updates where id='260920241') = 0 then
    
        -- Capo the Mean, exact location is unknown but given 3494 wdb, we known he is inside DM cave, unknown loot.
        -- Also, his abilities were already available on alpha, Frenzied Capo the Mean spell 5220 and Spinning Slash 7394.
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400465', '601', '0', '0', '0', '0', '-11188.385', '1468.725', '15.050', '1.963', '300', '300', '0', '100', '100', '0', '0', '0', '0');

        UPDATE `creature_template` SET `level_min` = '19', `level_max` = '19', `faction` = '17', `equipment_id` = '594', `spell_list_id` = '601' WHERE (`entry` = '601');
        
        -- New creature spell lists.
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (601, 'Capo the mean', 7394, 100, 1, 0, 0, 0, 10, 18, 24, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        
        -- Frenzy below 15%.
        -- Events list for 
        DELETE FROM `creature_ai_events` WHERE `creature_id`=601;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (60101, 601, 0, 2, 0, 100, 0, 15, 0, 0, 0, 60101, 0, 0, 'Capo the mean, franzy when health below 15%.');

        DELETE FROM `creature_ai_scripts` WHERE `id`=60101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (60101, 0, 0, 15, 5220, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Capo the mean cast Frenzied Capo the Mean');
        
        -- Fix Delicate Feather display id. https://crawler.thealphaproject.eu/mnt/crawler/media/Database/Ogaming/ogaming_item_wdb.htm
        UPDATE `item_template` SET `display_id` = '11205' WHERE (`entry` = '5636');
        
        -- Add Corrupted Scorpids from sniffs.
        -- Note: We are missing a lot of spawns for all 'Corrupted' types: Surf Crawlers, Scorpids, Mottled Boars, Dreadmaw Crocilisks and Bloodtalon Scythemaw.
        -- Maybe normal mobs had two spawn entries? Either normal or corrupted.
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('12410', '3226', '0', '0', '0', '1', '1293.653', '-4576.758', '21.45764', '3.23245', '300', '300', '5', '100', '0', '1', '0', '0', '0');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('12411', '3226', '0', '0', '0', '1', '1233.18', '-4670.237', '16.61242', '4.85345', '300', '300', '5', '100', '0', '1', '0', '0', '0');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('12412', '3226', '0', '0', '0', '1', '1265.554', '-4562.387', '19.00636', '1.36241', '300', '300', '5', '100', '0', '1', '0', '0', '0');
        
        -- Durotar corrupted mobs, drop Scorched Heart.
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3227', '4868', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3231', '4868', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3225', '4868', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3226', '4868', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3228', '4868', '-80', '0', '1', '1', '0');

        -- Scorched Heart no longer deprecated.
        UPDATE `item_template` SET `name` = 'Scorched Heart', `flags` = '0' WHERE (`entry` = '4868');

        -- Bring back quest 807. https://www.wowhead.com/classic/quest=807/unused
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('807', '2', '367', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Corrupted Wildlife', 'My scouts report that some of the Durotar wildlife have become infected with a demonic taint. They were seen to the north and west.$B$BThey wander among their brethren as normal beasts, but evil powers flow through them, and burning within each one is a heart scorched by black magic.$B$BThese beasts must be destroyed!$B$BIf you find such an animal while you explore Durotar, kill it and collect its Scorched Heart. Bring the hearts to me and I will have them studied, then destroyed.', 'Bring 5 Scorched Hearts to Orgnil Soulscar in Razor Hill.', '', 'Did you get my 5 Scorched Hearts, $N?', '', '', '', '', '', '4868', '0', '0', '0', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '150', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');
       
        -- Orgnil Soulscar, starter/finisher for restored quest 807.
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3142', '807');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3142', '807');
        
        -- Update Dark Storms quest (806) no longer requires 823.
        UPDATE `quest_template` SET `PrevQuestId` = '0', `NextQuestInChain` = '0' WHERE (`entry` = '806');

        -- Bring back quest 462 Maruk Wyrmscale.
        -- https://warcraft.wiki.gg/wiki/Ma%27ruk_Wyrmscale
        -- https://www.wowhead.com/classic/quest=462/unused
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('462', '2', '150', '20', '0', '23', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Maruk Wyrmscale', 'Other than you, we sent two scouts through Algaz. Only one returned. Here\'s what he discovered:$B$BThe Dragonmaws sent one of their Lieutenants, Maruk Wyrmscale, to organize a crew of orcs in Algaz and cut off the land route to Menethil Harbor!$B$BWe have to stop this, now. Take out Maruk, and then report to Valstag Ironjaw in Menethil Harbor.$B$BMaruk is headquartered in a small cave, across a pond between the second and third tunnels of Algaz. Menethil is through Algaz, then west along the road.', 'Kill Maruk Wyrmscale and report to Valstag Ironjaw in Menethil Harbor.', '', 'Have you killed Maruk Wyrmscale, $N?', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2090', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2750', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');
        
        -- Valstag Ironjaw starter/finisher. 
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('2086', '462');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('2086', '462');
        
        -- Bring back removed quest 820 'What Do You Rely On?'.
        -- https://www.wowhead.com/classic/quest=820/unused
        -- https://database.turtle-wow.org/?quest=820
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('820', '2', '367', '5', '0', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'What do you rely on?', 'Truly a spirit of strength resides in your body, willing to help an old man brew his potions.$B$BThe generosity found in our new home and the strength of relying on our allies is what sets us apart from others, $c.$B$BI need one more thing to begin brewing a batch of my potion, eight shimmerweed.$B$BYou can find the herbs northwest of Razor Hill in Thunder Ridge, and be careful, $n.', 'Bring 8 Shimmerweed to Master Vornal in Sen\'jin Village.', 'You\'ve done me a great kindness this day, $n.$B$BWith my vision restored, I will be able to help out more around the village.$B$BMore than strength, you\'ve a spirit of honor.', 'Have you retrieved the herbs?', '', '', '', '', '', '2676', '0', '0', '0', '8', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '450', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');

        -- Master Vornal starter/finisher.
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3304', '820');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3304', '820');
        
        -- Add Shimmerweed Bush
        INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `mingold`, `maxgold`, `script_name`) VALUES ('4000000', '3', '28', 'Shimmerweed Bush', '0', '4', '1', '43', '797', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '');
        
        -- Spawns in Thunder Ridge.
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000000', '4000000', '1', '853.423', '-4209.097', '-11.083', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000001', '4000000', '1', '847.923', '-4203.996', '-10.910', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000002', '4000000', '1', '856.671', '-4171.845', '-14.110', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000003', '4000000', '1', '926.438', '-4190.888', '-6.040', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000004', '4000000', '1', '926.063', '-4197.030', '-6.050', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000005', '4000000', '1', '925.511', '-4128.280', '-9.090', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000006', '4000000', '1', '986.987', '-4059.055', '-10.979', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000007', '4000000', '1', '883.882', '-4048.109', '-8.366', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000008', '4000000', '1', '880.123', '-4048.973', '-6.754', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        INSERT INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`, `spawn_map`, `spawn_positionX`, `spawn_positionY`, `spawn_positionZ`, `spawn_orientation`, `spawn_rotation0`, `spawn_rotation1`, `spawn_rotation2`, `spawn_rotation3`, `spawn_spawntimemin`, `spawn_spawntimemax`, `spawn_animprogress`, `spawn_state`, `spawn_flags`, `spawn_visibility_mod`, `ignored`) VALUES ('4000009', '4000000', '1', '754.667', '-4020.691', '-6.072', '0', '0', '0', '0', '1', '300', '300', '100', '1', '0', '0', '0');
        
        -- Bring back quest 814, Work for food.
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('814', '2', '362', '4', '0', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Work for Food', 'Cook and clean--that\'s all I do!$B$BYou want to eat, you get me some more meat! I don\'t have all day to hunt and prepare food for all these louses. You got to learn to pull your own weight around here if you wanna be treated equal.$B$BGet me some Chunks of Boar Meat if you want to make yourself useful... or you don\'t want to starve to death.', 'Bring 10 Chunks of Boar Meat to Cook Torka in Razor Hill.', 'Get me some Chunks of Boar Meat if you want to make yourself useful...', 'You want to eat, you get me some more meat!', '', '', '', '', '', '769', '0', '0', '0', '10', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '540', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');
        
        -- Reward item. Beer Basted Boar Ribs
        UPDATE `quest_template` SET `RewItemId1` = '2888', `RewItemCount1` = '10' WHERE (`entry` = '814');
        
        -- Torka starter/finisher.
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3191', '814');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3191', '814');
        
        -- Fix Razor Hill Torka coocking table.
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Durotar/images_6584.jpg
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '336.859', `spawn_positionY` = '-4713.270', `spawn_positionZ` = '12.583' WHERE (`spawn_id` = '399');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '99805');
        -- Tall Brazier.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1658');
        -- Smoking Rack.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '329.005', `spawn_positionY` = '-4709.503', `spawn_positionZ` = '13.138' WHERE (`spawn_id` = '1365');
        -- Cauldron.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '331.229', `spawn_positionY` = '-4707.580', `spawn_positionZ` = '13.714' WHERE (`spawn_id` = '1733');
        -- Food Crate.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.11' WHERE (`spawn_id` = '44078');
        -- Barrel of Milk.
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.2856' WHERE (`spawn_id` = '44051');
        -- Campfire.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '401');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '402');
        -- Torka
        UPDATE `spawns_creatures` SET `position_x` = '333.661', `position_y` = '-4710.038', `position_z` = '13.193', `orientation` = '4.26' WHERE (`spawn_id` = '6460');
        -- Grimtak <Butcher>
        UPDATE `spawns_creatures` SET `position_x` = '326.98', `position_y` = '-4712.133', `position_z` = '12.731', `orientation` = '5.054' WHERE (`spawn_id` = '10425');
        -- Braziers.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '11978');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '11979');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '11980');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '11981');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '11985');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12065');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12066');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '1591');
        -- Wuark.
        UPDATE `spawns_creatures` SET `position_x` = '353.706', `position_y` = '-4702.942', `position_z` = '14.566', `orientation` = '3.49' WHERE (`spawn_id` = '7289');
        -- Krunn
        -- https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Durotar/23%20april%2004%20-%20148.jpg
        UPDATE `spawns_creatures` SET `position_x` = '364.366', `position_y` = '-4705.106', `position_z` = '16.181', `orientation` = '3.35' WHERE (`spawn_id` = '7674');
        -- Ghrawt
        UPDATE `spawns_creatures` SET `position_x` = '330.364', `position_y` = '-4827.328', `position_z` = '10.524', `orientation` = '2.85' WHERE (`spawn_id` = '7667');
        -- Cutac
        UPDATE `spawns_creatures` SET `position_x` = '339.667', `position_y` = '-4767.068', `position_z` = '12.634', `orientation` = '2.038' WHERE (`spawn_id` = '7672');
        
        -- Bring back quest 490.
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`, `parse_timestamp`) VALUES ('490', '2', '141', '5', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Gnarlpine Bounty', 'By strict orders from the Council of Darnassus, I am commissioning a bounty on the Gnarlpine Tribe. They are no longer friends of the forest. Their corruption has left them mindless threats to our people and the creatures of the glade.$B$BAs decreed by the Council, you shall be rewarded for removing the furbolg menaces from Kalidar. Bring to me their fangs as proof of your deeds.', 'Bring 20 Gnarlpine Fangs to Shayla Nightbreeze.', '', 'Have you collected the Gnarlpine Fangs? $N', '', '', '', '', '', '5220', '0', '0', '0', '20', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '630', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '2004-05-04');
        
        -- Sentinel Shayla Nightbreeze starter/finisher.
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('2155', '490');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('2155', '490');

        -- Gnarlpine's, drop Gnarlpine Fang.
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2152', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2011', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2013', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2010', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2007', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2012', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2009', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2014', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2006', '5220', '-80', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('2008', '5220', '-80', '0', '1', '1', '0');
        
        -- Fix item count req for 459.
        UPDATE `quest_template` SET `Objectives` = 'Collect 6 Fel Moss and bring them to Tarindrella.', `RequestItemsText` = 'Satisfy my suspicions, $N.  Bring to me 6 Fel Moss.' WHERE (`entry` = '459');
        
        -- Master Tailor <Cheesy Test Tailor>
        UPDATE `creature_template` SET `trainer_type` = '2', `trainer_id` = '507', `faction` = '150', `npc_flags` = '8' WHERE (`entry` = '996');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400466', '996', '0', '0', '0', '1', '-3847.802', '-4449.579', '17.245', '6.203', '300', '300', '0', '100', '100', '0', '0', '0', '0');

        insert into applied_updates values ('260920241');
    end if;
    
    -- 29/09/2024 1
    if (select count(*) from applied_updates where id='290920241') = 0 then
        -- Invalid script spells for Son of Cenarius 4057
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (405701);
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4057;

        -- Vendor items, Kiro <War Harness Maker> and Sura Wildmane <War Harness Vendor>
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3023', '6523', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3023', '6524', '0', '0', '0', '1');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3023', '6525', '0', '0', '0', '2');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3023', '6526', '0', '0', '0', '3');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3359', '6523', '0', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3359', '6524', '0', '0', '0', '1');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3359', '6525', '0', '0', '0', '2');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('3359', '6526', '0', '0', '0', '3');
        
        -- Enable Battle Harness, Buckled Harness, Grunt's Harness and Studded Leather Harness
        UPDATE `item_template` SET `display_id` = '9040', `ignored` = '0' WHERE (`entry` = '6523');
        UPDATE `item_template` SET `display_id` = '9536', `ignored` = '0' WHERE (`entry` = '6524');
        UPDATE `item_template` SET `display_id` = '9548', `ignored` = '0' WHERE (`entry` = '6525');
        UPDATE `item_template` SET `display_id` = '9995', `ignored` = '0' WHERE (`entry` = '6526');
        
        -- Marez Cowl - Invalid spell.
        DELETE FROM `creature_ai_scripts` WHERE `id` IN (278301);
        DELETE FROM `creature_ai_events` WHERE `creature_id`=2783;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (278302, 2783, 0, 2, 0, 100, 0, 15, 0, 0, 0, 278302, 0, 0, 'Marez Cowl - Flee at 15% HP');

        -- Darbel Montrose - Summon Succubus on Spawn
        DELETE FROM `creature_ai_scripts` WHERE `id`=259802;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (259802, 0, 0, 15, 712, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darbel Montrose - Cast Spell Summon Succubus');
        
        -- Dylan Bissel - Wolf Trainer - Level 50.
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50' WHERE (`entry` = '2942');
        -- Whladak - Spider Trainer - Level 50
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50' WHERE (`entry` = '2872');
        -- Aldric - Bear Trainer - Level 50
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50' WHERE (`entry` = '2938');
        -- Talar - Bear Trainer - Level 50
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50' WHERE (`entry` = '4206');
        -- Kyln Longclaw - Boar Trainer - Level 30
        UPDATE `creature_template` SET `level_min` = '30', `level_max` = '30' WHERE (`entry` = '3697');
        -- Kysandia - Cat Trainer - Level 30
        UPDATE `creature_template` SET `level_min` = '30', `level_max` = '30' WHERE (`entry` = '4153');
        -- Nerra - Cat Trainer - Level 30
        UPDATE `creature_template` SET `level_min` = '30', `level_max` = '30' WHERE (`entry` = '3699');
        -- Kenna - Crocilisk Pet Trainer - Level 37
        UPDATE `creature_template` SET `level_min` = '37', `level_max` = '37' WHERE (`entry` = '4901');
        
        -- Fixes to quests poi's from wdb.
        UPDATE `quest_template` SET `PointOpt` = '1' WHERE (`entry` = '61');
        UPDATE `quest_template` SET `PointX` = '-9663.55', `PointY` = '688.122', `PointOpt` = '1' WHERE (`entry` = '239');
        UPDATE `quest_template` SET `PointX` = '-10509', `PointY` = '1047', `PointOpt` = '1' WHERE (`entry` = '109');
        UPDATE `quest_template` SET `PointOpt` = '1' WHERE (`entry` = '333');
        UPDATE `quest_template` SET `PointOpt` = '1' WHERE (`entry` = '353');
        -- Brock Stoneseeker <Cartography Trainer> - Remove mining template.
        UPDATE `creature_template` SET `trainer_id` = '0' WHERE (`entry` = '1681');
        -- Karm Ironquill <Cartography Supplies> - Remove mining vendor entries.
        DELETE FROM `npc_vendor` WHERE (`entry` = '372') and (`item` = '2880');
        DELETE FROM `npc_vendor` WHERE (`entry` = '372') and (`item` = '2901');
        DELETE FROM `npc_vendor` WHERE (`entry` = '372') and (`item` = '3466');
        DELETE FROM `npc_vendor` WHERE (`entry` = '372') and (`item` = '3857');
        
        insert into applied_updates values ('290920241');
    end if;

    -- 06/10/2024 1
    if (select count(*) from applied_updates where id='061020241') = 0 then
    
        -- Item Deprecated Dwarven Novice's Robe
        UPDATE `item_template` SET `display_id` = 8288 WHERE `entry` = 97;

        -- Item Leather Helmet D (Test)
        UPDATE `item_template` SET `display_id` = 3086 WHERE `entry` = 1020;

        -- Item Leather Helmet A (test)
        UPDATE `item_template` SET `display_id` = 1124 WHERE `entry` = 1021;

        -- Item Mail Helmet D (test)
        UPDATE `item_template` SET `display_id` = 4180 WHERE `entry` = 1022;

        -- Item Mail Helmet C (test)
        UPDATE `item_template` SET `display_id` = 3135 WHERE `entry` = 1023;

        -- Item Plate Helmet D2 (test)
        UPDATE `item_template` SET `display_id` = 2995 WHERE `entry` = 1024;

        -- Item Plate Helmet D3 (test)
        UPDATE `item_template` SET `display_id` = 4145 WHERE `entry` = 1026;

        -- Item Mail Helmet A (Test)
        UPDATE `item_template` SET `display_id` = 3044 WHERE `entry` = 1027;

        -- Item Deprecated Dented Skullcap
        UPDATE `item_template` SET `display_id` = 3044 WHERE `entry` = 1028;

        -- Item Rod of the Sleepwalker
        UPDATE `item_template` SET `display_id` = 11251 WHERE `entry` = 1155;

        -- Item Pirates Patch (Test)
        UPDATE `item_template` SET `display_id` = 3047 WHERE `entry` = 1162;

        -- Item Dwarven Explorer's Monocle (Test)
        UPDATE `item_template` SET `display_id` = 3215 WHERE `entry` = 1163;

        -- Item Deprecated Overseer's Helm
        UPDATE `item_template` SET `display_id` = 3044 WHERE `entry` = 1192;

        -- Item Deprecated Soft Leather Hood
        UPDATE `item_template` SET `display_id` = 3086 WHERE `entry` = 1279;

        -- Item Shadowhide Scalper
        UPDATE `item_template` SET `display_id` = 3398 WHERE `entry` = 1459;

        -- Item Robe of the Magi
        UPDATE `item_template` SET `display_id` = 10469 WHERE `entry` = 1716;

        -- Item Fighter Broadsword
        UPDATE `item_template` SET `display_id` = 9444 WHERE `entry` = 2027;

        -- Item Deprecated Cougar Head Cap
        UPDATE `item_template` SET `display_id` = 1124 WHERE `entry` = 2038;

        -- Item Deprecated Cowl of Forlorn Spirits
        UPDATE `item_template` SET `display_id` = 3869 WHERE `entry` = 2045;

        -- Item Deprecated Sentinel Coif
        UPDATE `item_template` SET `display_id` = 3128 WHERE `entry` = 2275;

        -- Item Battered Leather Harness
        UPDATE `item_template` SET `display_id` = 9182 WHERE `entry` = 2370;

        -- Item Battered Leather Pants
        UPDATE `item_template` SET `display_id` = 9988 WHERE `entry` = 2372;

        -- Item Battered Leather Boots
        UPDATE `item_template` SET `display_id` = 9992 WHERE `entry` = 2373;

        -- Item Smoky Torch
        UPDATE `item_template` SET `display_id` = 2998 WHERE `entry` = 2410;

        -- Item Studded Doublet
        UPDATE `item_template` SET `display_id` = 9545 WHERE `entry` = 2463;

        -- Item Reinforced Leather Boots
        UPDATE `item_template` SET `display_id` = 4484 WHERE `entry` = 2473;

        -- Item Death Speaker Sceptre
        UPDATE `item_template` SET `display_id` = 3191 WHERE `entry` = 2816;

        -- Item Deprecated Coif of Inner Strength
        UPDATE `item_template` SET `display_id` = 3044 WHERE `entry` = 2918;

        -- Item (OLD)Medium Throwing Knife
        UPDATE `item_template` SET `display_id` = 3274 WHERE `entry` = 2945;

        -- Item Magister's Vest
        UPDATE `item_template` SET `display_id` = 2472 WHERE `entry` = 2969;

        -- Item Seer's Robe
        UPDATE `item_template` SET `display_id` = 11471 WHERE `entry` = 2981;

        -- Item Deprecated Inscribed Leather Helm
        UPDATE `item_template` SET `display_id` = 3086 WHERE `entry` = 2993;

        -- Item Deprecated Seer's Monocle
        UPDATE `item_template` SET `display_id` = 3087 WHERE `entry` = 2994;

        -- Item Deprecated Burnished Chain Coif
        UPDATE `item_template` SET `display_id` = 3128 WHERE `entry` = 2995;

        -- Item Deprecated Glinting Scale Crown
        UPDATE `item_template` SET `display_id` = 3128 WHERE `entry` = 3046;

        -- Item Deprecated Winter Mail Coif
        UPDATE `item_template` SET `display_id` = 3044 WHERE `entry` = 3052;

        -- Item Deprecated Forest Leather Helm
        UPDATE `item_template` SET `display_id` = 3086 WHERE `entry` = 3059;

        -- Item Deprecated Deepwood Helm
        UPDATE `item_template` SET `display_id` = 4386 WHERE `entry` = 3063;

        -- Item Frostweave Cowl
        UPDATE `item_template` SET `display_id` = 11544 WHERE `entry` = 3068;

        -- Item Flameweave Robe
        UPDATE `item_template` SET `display_id` = 5882 WHERE `entry` = 3069;

        -- Item Smoldering Robe
        UPDATE `item_template` SET `display_id` = 10620 WHERE `entry` = 3072;

        -- Item Deprecated Stonecloth Cowl
        UPDATE `item_template` SET `display_id` = 3356 WHERE `entry` = 3077;

        -- Item (OLD)Wicked Throwing Dagger
        UPDATE `item_template` SET `display_id` = 3276 WHERE `entry` = 3109;

        -- Item (OLD)Medium Throwing Axe
        UPDATE `item_template` SET `display_id` = 3281 WHERE `entry` = 3128;

        -- Item (OLD)Heavy Throwing Axe
        UPDATE `item_template` SET `display_id` = 3284 WHERE `entry` = 3136;

        -- Item Copper Chain Boots
        UPDATE `item_template` SET `display_id` = 4330 WHERE `entry` = 3469;

        -- Item Black Night Elf Helm
        UPDATE `item_template` SET `display_id` = 3135 WHERE `entry` = 3529;

        -- Item Demon Hunter Blindfold
        UPDATE `item_template` SET `display_id` = 3830 WHERE `entry` = 3536;

        -- Item Robe of Solomon
        UPDATE `item_template` SET `display_id` = 8853 WHERE `entry` = 3555;

        -- Item Interlaced Pants
        UPDATE `item_template` SET `display_id` = 9945 WHERE `entry` = 3797;

        -- Item Interlaced Shoulderpads
        UPDATE `item_template` SET `display_id` = 8374 WHERE `entry` = 3798;

        -- Item Hardened Leather Belt
        UPDATE `item_template` SET `display_id` = 4599 WHERE `entry` = 3800;

        -- Item Hardened Leather Vest
        UPDATE `item_template` SET `display_id` = 3278 WHERE `entry` = 3807;

        -- Item Golden Scale Coif
        UPDATE `item_template` SET `display_id` = 9070 WHERE `entry` = 3837;

        -- Item Deprecated Thick Cloth Hat
        UPDATE `item_template` SET `display_id` = 3960 WHERE `entry` = 3883;

        -- Item Deprecated Cured Leather Cap
        UPDATE `item_template` SET `display_id` = 4176 WHERE `entry` = 3884;

        -- Item Deprecated Scalemail Cap
        UPDATE `item_template` SET `display_id` = 3589 WHERE `entry` = 3885;

        -- Item Deprecated Padded Cloth Hat
        UPDATE `item_template` SET `display_id` = 3960 WHERE `entry` = 3886;

        -- Item Deprecated Cuirboulli Cap
        UPDATE `item_template` SET `display_id` = 4176 WHERE `entry` = 3887;

        -- Item Deprecated Polished Scale Cap
        UPDATE `item_template` SET `display_id` = 3589 WHERE `entry` = 3888;

        -- Item Embroidered Hat
        UPDATE `item_template` SET `display_id` = 3960 WHERE `entry` = 3892;

        -- Item Crochet Boots
        UPDATE `item_template` SET `display_id` = 9672 WHERE `entry` = 3937;

        -- Item Crochet Vest
        UPDATE `item_template` SET `display_id` = 10113 WHERE `entry` = 3943;

        -- Item Twill Belt
        UPDATE `item_template` SET `display_id` = 8375 WHERE `entry` = 3944;

        -- Item Twill Boots
        UPDATE `item_template` SET `display_id` = 9788 WHERE `entry` = 3945;

        -- Item Twill Pants
        UPDATE `item_template` SET `display_id` = 7587 WHERE `entry` = 3949;

        -- Item Mesh Belt
        UPDATE `item_template` SET `display_id` = 9888 WHERE `entry` = 3952;

        -- Item Mesh Boots
        UPDATE `item_template` SET `display_id` = 1911 WHERE `entry` = 3953;

        -- Item Mesh Gloves
        UPDATE `item_template` SET `display_id` = 10508 WHERE `entry` = 3956;

        -- Item Thick Leather Shoulderpads
        UPDATE `item_template` SET `display_id` = 4968 WHERE `entry` = 3967;

        -- Item Smooth Leather Belt
        UPDATE `item_template` SET `display_id` = 5827 WHERE `entry` = 3969;

        -- Item Smooth Leather Bracers
        UPDATE `item_template` SET `display_id` = 3381 WHERE `entry` = 3971;

        -- Item Smooth Leather Gloves
        UPDATE `item_template` SET `display_id` = 3081 WHERE `entry` = 3973;

        -- Item Smooth Leather Pants
        UPDATE `item_template` SET `display_id` = 3078 WHERE `entry` = 3974;

        -- Item Strapped Pants
        UPDATE `item_template` SET `display_id` = 5947 WHERE `entry` = 3982;

        -- Item Overlinked Chain Shoulderpads
        UPDATE `item_template` SET `display_id` = 10166 WHERE `entry` = 4006;

        -- Item Sterling Chain Armor
        UPDATE `item_template` SET `display_id` = 4412 WHERE `entry` = 4015;

        -- Item Frostweave Robe
        UPDATE `item_template` SET `display_id` = 3734 WHERE `entry` = 4035;

        -- Item Mistscape Boots
        UPDATE `item_template` SET `display_id` = 9771 WHERE `entry` = 4047;

        -- Item Emblazoned Helm
        UPDATE `item_template` SET `display_id` = 4381 WHERE `entry` = 4048;

        -- Item Insignia Helm
        UPDATE `item_template` SET `display_id` = 3589 WHERE `entry` = 4052;

        -- Item Imperial Leather Bracers
        UPDATE `item_template` SET `display_id` = 11655 WHERE `entry` = 4061;

        -- Item Imperial Leather Pants
        UPDATE `item_template` SET `display_id` = 11661 WHERE `entry` = 4062;

        -- Item Imperial Leather Gloves
        UPDATE `item_template` SET `display_id` = 11656 WHERE `entry` = 4063;

        -- Item Mail Combat Helm
        UPDATE `item_template` SET `display_id` = 3044 WHERE `entry` = 4077;

        -- Item Blackforge Gauntlets
        UPDATE `item_template` SET `display_id` = 2951 WHERE `entry` = 4083;

        -- Item Robe of Crystal Waters
        UPDATE `item_template` SET `display_id` = 11635 WHERE `entry` = 4120;

        -- Item Cap of Harmony
        UPDATE `item_template` SET `display_id` = 4386 WHERE `entry` = 4124;

        -- Item Deprecated Feathered Helm
        UPDATE `item_template` SET `display_id` = 3135 WHERE `entry` = 4193;

        -- Item Dark Leather Shoulders
        UPDATE `item_template` SET `display_id` = 9528 WHERE `entry` = 4252;

        -- Item Heavy Woolen Gloves
        UPDATE `item_template` SET `display_id` = 11036 WHERE `entry` = 4310;

        -- Item TEST QUEST HELM
        UPDATE `item_template` SET `display_id` = 5084 WHERE `entry` = 4853;

        -- Item Razormane Backstabber
        UPDATE `item_template` SET `display_id` = 5069 WHERE `entry` = 5093;

        -- Item Empty Greater Bloodstone
        UPDATE `item_template` SET `display_id` = 5333 WHERE `entry` = 5229;

        -- Item Deprecated Skipper's Hat
        UPDATE `item_template` SET `display_id` = 7529 WHERE `entry` = 5307;

        -- Item Deprecated Whisperwind Headdress
        UPDATE `item_template` SET `display_id` = 7670 WHERE `entry` = 5358;

        -- Item Shane Test (DELETE ME)
        UPDATE `item_template` SET `display_id` = 7712 WHERE `entry` = 5378;

        -- Item Fast Test Thrown
        UPDATE `item_template` SET `display_id` = 8124 WHERE `entry` = 5559;

        -- Item Deprecated Band of the Order
        UPDATE `item_template` SET `display_id` = 8446 WHERE `entry` = 5625;

        -- Item Snow Boots
        UPDATE `item_template` SET `display_id` = 10935 WHERE `entry` = 6173;

        -- Item Twain Random Sword
        UPDATE `item_template` SET `display_id` = 10356 WHERE `entry` = 6174;

        -- Item 15 Pound Mud Snapper
        UPDATE `item_template` SET `display_id` = 10816 WHERE `entry` = 6295;

        -- Item 22 Pound Catfish
        UPDATE `item_template` SET `display_id` = 3572 WHERE `entry` = 6311;

        -- Item 26 Pound Catfish
        UPDATE `item_template` SET `display_id` = 3572 WHERE `entry` = 6363;

        -- Item 32 Pound Catfish
        UPDATE `item_template` SET `display_id` = 3572 WHERE `entry` = 6364;

        insert into applied_updates values ('061020241');
    end if;
     
    -- 10/10/2024 1
    if (select count(*) from applied_updates where id='101020241') = 0 then
        -- Waypoints for Creature Miran (Entry: 1379 Guid: 68)
        DELETE FROM creature_movement_template WHERE entry = 1379;
        INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, orientation, waittime, wander_distance, script_id) VALUES
        (1379, 1, -5764.81, -3433.93, 305.89, 0, 0, 0, 0),
        (1379, 2, -5754.81, -3445.92, 303.189, 0, 0, 0, 0),
        (1379, 3, -5738.74, -3483.18, 302.208, 0, 0, 0, 0),
        (1379, 4, -5731.07, -3496.83, 302.508, 0, 0, 0, 0),
        (1379, 5, -5718.45, -3517.26, 302.915, 0, 0, 0, 0),
        (1379, 6, -5714.55, -3524.18, 303.876, 0, 0, 0, 0),
        (1379, 7, -5699.35, -3557.07, 306.828, 0, 0, 0, 0),
        (1379, 8, -5691.3, -3570.81, 308.974, 0, 0, 0, 0),
        (1379, 9, -5683.69, -3580.33, 309.811, 0, 0, 0, 0),
        (1379, 10, -5676.5, -3598.45, 312.262, 0, 0, 0, 0),
        (1379, 11, -5672.3, -3622.29, 311.37, 0, 0, 0, 0),
        (1379, 12, -5676.67, -3641.2, 313.65, 0, 0, 0, 0),
        (1379, 13, -5681.06, -3647.38, 315.143, 0, 0, 0, 0),
        (1379, 14, -5689.83, -3664.69, 312.214, 0, 0, 0, 0),
        (1379, 15, -5698.71, -3695.64, 314.55, 0, 0, 0, 0),
        (1379, 16, -5698.75, -3729.51, 318.328, 0, 0, 0, 137901),
        (1379, 17, -5701.32, -3752.99, 321.503, 0, 0, 0, 0),
        (1379, 18, -5694.12, -3766.42, 324.254, 0, 0, 0, 0),
        (1379, 19, -5688.71, -3781.44, 322.824, 0, 0, 0, 0),
        (1379, 20, -5689.67, -3784.97, 322.740, 0, 0, 0, 0),
        (1379, 21, -5698.17, -3791.22, 322.410, 0, 0, 0, 0),
        (1379, 22, -5699.12, -3792.01, 322.410, 0, 0, 0, 137902);

        DELETE FROM `creature_movement_scripts` WHERE `id`=137901;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (137901, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 510, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment - Miran - Say Text'),
        (137901, 0, 0, 10, 2149, 180000, 0, 0, 1379, 20, 8, 0, 0, 0, -1, 9, -5696.19, -3736.78, 318.581, 2.40855, 0, 'Protecting the Shipment - Spawn Dark Iron Raider'),
        (137901, 0, 0, 10, 2149, 180000, 0, 0, 1379, 20, 8, 0, 0, 0, -1, 9, -5705.01, -3736.66, 318.567, 0.575959, 0, 'Protecting the Shipment - Spawn Dark Iron Raider');

        DELETE FROM `creature_movement_scripts` WHERE `id`=137902;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (137902, 0, 0, 20, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Miran - Move Idle'),
        (137902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 498, 0, 0, 0, 0, 0, 0, 0, 0, 'Miran - Say Text'),
        (137902, 1, 0, 62, 309, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Miran - End Scripted Map Event'),
        (137902, 10, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Miran - Despawn');

        DELETE FROM `quest_start_scripts` WHERE `id`=309;
        INSERT INTO `quest_start_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (309, 0, 0, 61, 309, 600, 0, 0, 0, 0, 0, 0, 0, 30901, 1019, 30902, 0, 0, 0, 0, 0, 'Protecting the Shipment: Start Scripted Map Event'),
        (309, 0, 0, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment: Miran - Remove Questgiver Flag'),
        (309, 0, 0, 22, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment: Miran - Set Faction Escortee'),
        (309, 1, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment: Miran - Start Waypoints');

        DELETE FROM `generic_scripts` WHERE `id`=30901;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (30901, 0, 0, 7, 309, 80, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment Success: Player - Complete Quest Protecting the Shipment');

        DELETE FROM `generic_scripts` WHERE `id`=30902;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (30902, 0, 0, 70, 309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment Failed: Player - Fail Quest'),
        (30902, 1, 0, 71, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Protecting the Shipment Failed: Miran - Respawn ');

        -- Remove mount from Dark Iron Riders.
        UPDATE `creature_template` SET `mount_display_id` = '0' WHERE (`entry` = '2149');
        
        insert into applied_updates values ('101020241');
    end if;

    -- 22/10/2024 1
    if (select count(*) from applied_updates where id='221020241') = 0 then

        -- TODO: Adjust Tharil'zun quest #1452
        UPDATE `quest_template` SET `Details` = 'Blackrock Outrunners and Renegades are running ambushes between here and Stonewatch Keep. The leader of the Outrunners is an orc named Tharil\'zun--we want this orc and his subordinates neutralized.$b$bKill the Blackrock outrunners and bring me the head of Tharil\'zun.', `Objectives` = 'Kill 12 Blackrock Outrunners, and bring the head of their leader Tharil\'zun back to Marshal Marris in Redridge.', `RequestItemsText` = 'Orc pressure from Blackrock is still tense. But have you at least rid us of Tharil\'zun and his Outrunners?', `ReqCreatureOrGOId1` = 485, `ReqCreatureOrGOCount1` = 12, `RewChoiceItemId1` = 0, `RewChoiceItemId2` = 0, `RewChoiceItemCount2` = 0, `RewOrReqMoney` = 1600, `parse_timestamp` = '1970-01-01' WHERE (`entry` = 19);

        -- TODO: Move rewards from Thrali'zun quest to Shadow Magic quest. #1451 AND Adjust Shadow Magic quests's objective #1450
        UPDATE `quest_template` SET `ReqItemCount1` = 4, `RewItemId1` = 1276, `RewItemId2` = 6093, `RewItemCount1` = 1, `RewItemCount2` = 1, `RewOrReqMoney` = 300, `parse_timestamp` = '1970-01-01' WHERE (`entry` = 115);
        
        -- TODO: Update Jawn Highmesa location #1394
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 4876) AND (`spawn_id` IN (21144));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (21144, 4876, 0, 0, 0, 1, -5466.456, -2419.391, 89.3, 5.658, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- PARTIAL Kitari Farseeker Cartography TODO: Investigate on these Darnassus NPCs #1304
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (0, 4157, 0, 0, 0, 1, 10129.023, 2425.787, 1331.881, 4.22, 300, 300, 0, 1, 0, 0, 0, 0, 0);

        -- Update Kitari flags #1304
        UPDATE `creature_template` SET `npc_flags` = 10, `flags_extra` = 524298 WHERE (`entry` = 4157);

        -- Ally Binder Plains #1457
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (0, 2281, 0, 0, 0, 37, -445.944, -1023.479, 430.9, 0.937, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Horde Binder Plains #1457
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (0, 2282, 0, 0, 0, 37, -663.799, -487.706, 385.853, 5.782, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Nerra #1456
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 3699) AND (`spawn_id` IN (400079));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (400079, 3699, 0, 0, 0, 1, 10687.85, 1922.595, 1336.384, 4.457, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Nadyia #1456
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 3605) AND (`spawn_id` IN (46193));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (46193, 3605, 0, 0, 0, 1, 10662.588, 1852.964, 1323.54, 2.926, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Alanna #1456
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 3606) AND (`spawn_id` IN (46194));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (46194, 3606, 0, 0, 0, 1, 10279.62, 1198.137, 1456.751, 0, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Thisleheart #1454
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 5171) AND (`spawn_id` IN (1804));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (1804, 5171, 0, 0, 0, 0, -4749.271, -1032.367, 499.107, 3.773, 540, 540, 0, 100, 100, 0, 0, 0, 0);

        -- Rhahk'zor #1430
        UPDATE `creature_template` SET `level_min` = 20, `level_max` = 20 WHERE (`entry` = 644);

        -- Sneed #1430
        UPDATE `creature_template` SET `level_min` = 21, `level_max` = 21 WHERE (`entry` = 643);

        -- Van Cleef #1430
        UPDATE `creature_template` SET `level_min` = 22, `level_max` = 22 WHERE (`entry` = 639);

        -- Defias Miner #1430
        UPDATE `creature_template` SET `rank` = 1 WHERE (`entry` = 598);

        -- Defias Strip Miner #1430
        UPDATE `creature_template` SET `rank` = 1 WHERE (`entry` = 4416);

        -- Defias Worker #1430
        UPDATE `creature_template` SET `rank` = 1 WHERE (`entry` = 1727);

        -- Adjust Shaia spawn #1163
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 4178) AND (`spawn_id` IN (400118));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (400118, 4178, 0, 0, 0, 1, 9700.307, 2337.542, 1331.97, 0.6, 120, 120, 5, 100, 100, 0, 0, 0, 0);

        -- Shaia flags #1163
        UPDATE `creature_template` SET `npc_flags` = 131, `type_flags` = 102, `flags_extra` = 524298 WHERE (`entry` = 4178);

        -- Shaia Mail vendor items based on Melea #1163
        INSERT INTO npc_vendor (entry, item, maxcount, incrtime, itemflags, slot)
        SELECT 4178, item, maxcount, incrtime, itemflags, slot
        FROM npc_vendor
        WHERE entry = 4177;

        -- Lewin flags #1163
        UPDATE `creature_template` SET `npc_flags` = 131, `type_flags` = 102, `flags_extra` = 524298 WHERE (`entry` = 4239);

        -- Lewin Leather vendor items based on Cyridan #1163
        INSERT INTO npc_vendor (entry, item, maxcount, incrtime, itemflags, slot)
        SELECT 4239, item, maxcount, incrtime, itemflags, slot
        FROM npc_vendor
        WHERE entry = 4236;

        -- Maginor, from screenshot
        DELETE FROM `spawns_creatures` WHERE (`spawn_entry1` = 331) AND (`spawn_id` IN (26835));
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES
        (26835, 331, 0, 0, 0, 0, -9018.157, 866.797, 148.618, 0.583, 490, 490, 0, 100, 100, 0, 0, 0, 0);

        -- Myrmidon Signet #1449
        UPDATE `item_template` SET `display_id` = 896, `item_level` = 40, `required_level` = 35, `stat_value1` = 5, `stat_value2` = 6, `stat_type3` = 0, `stat_value3` = 0 WHERE (`entry` = 2246);
        insert into applied_updates values ('221020241');
    end if;
end $
delimiter ;