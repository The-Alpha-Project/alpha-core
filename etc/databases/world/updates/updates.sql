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
        UPDATE `quest_template` SET `MinLevel` = '30', `QuestLevel` = '35', `RewItemId1` = '1217', `RewItemCount1` = '1', `RewXP` = '8650' WHERE (`entry` = '1053');

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

        insert into applied_updates values ('040920242');
    end if;
end $
delimiter ;