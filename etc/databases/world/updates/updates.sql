delimiter $
begin not atomic

    -- 03/04/2022 1
    if (select count(*) from applied_updates where id='030420221') = 0 then
        -- Delete wrong Stratholme spawns.
        delete from spawns_creatures where spawn_entry1 > 160000;

        insert into applied_updates values ('030420221');
    end if;
	
	-- 03/04/2022 2
	if (select count(*) from applied_updates where id='030420222') = 0 then
        -- Teleport to Stormwind
        UPDATE `spell_target_position` SET `target_position_z` = '129.72' WHERE (`id` = '3561') and (`target_map` = '0');
        -- Teleport to Ironforge
        UPDATE `spell_target_position` SET `target_position_z` = '519.30' WHERE (`id` = '3562') and (`target_map` = '0');
        -- Teleport to Orgrimmar
        UPDATE `spell_target_position` SET `target_position_x` = '1552.5', `target_position_y` = '-4420.66', `target_position_z` = '8.94802' WHERE (`id` = '3567') and (`target_map` = '1');
		
        insert into applied_updates values ('030420222');
    end if;
	
    -- 03/04/2022 3
    if (select count(*) from applied_updates where id='030420223') = 0 then
        -- Dungar Longdrink, Thor, Thorgrum Borrelson, Gryth Thurden, Karos Razok, Tal, Doras, Devrak, Vesprystus, Michael Garrett, Shaethis Darkoak, Sulhasa. [4 -> 6 (2 QuestGiver + 4 FlightMaster)
        UPDATE `creature_template` SET `npc_flags` = '6' WHERE (`entry` in ('352', '523', '1572', '1573', '2226', '2995', '3310', '3615', '3838', '4551', '1233', '14242'));
		
        insert into applied_updates values ('030420223');
    end if;

    -- 04/04/2022 1
    if (select count(*) from applied_updates where id='040420221') = 0 then
        UPDATE `creature_template` SET `npc_flags` = 0 WHERE `npc_flags` = 1;
        UPDATE `creature_template` SET `npc_flags` = 1 WHERE `npc_flags` = 3;
        UPDATE `creature_template` SET `npc_flags` = 3 WHERE `npc_flags` = 5;
        UPDATE `creature_template` SET `npc_flags` = 2 WHERE `entry` = 3150;
        UPDATE `creature_template` SET `npc_flags` = 3 WHERE `entry` IN (233, 384, 491, 1243, 1261, 1460, 1694, 2357, 2393, 2670, 3362, 3413, 3489, 3685, 4200, 4241, 4256, 4730, 4731, 4885, 5520, 5594, 5749, 5750, 5753, 5815, 6027, 6301, 6328, 6373, 6374, 6376, 6382, 6548, 6568, 7564, 7683, 7772, 7775, 7854, 7952, 7955, 8125, 8403, 9087, 10118, 10216, 10618, 11038, 11056, 11057, 11536, 11555, 12031, 12384, 12807, 12919, 13018, 13418, 13429, 13431, 13433, 13434, 13435, 14322, 14437, 14738, 14739, 14847, 15011, 15012, 15197, 15199, 15471, 12384, 14450, 12776, 12776, 12944, 12944);

        insert into applied_updates values ('040420221');
    end if;

    -- 20/04/2022 1
    if (select count(*) from applied_updates where id='200420221') = 0 then
        -- Fix Grell display id.
        UPDATE `creature_template` SET `display_id1` = 3023 WHERE `entry` = 1988;

        insert into applied_updates values ('200420221');
    end if;

    -- 20/04/2022 2
    if (select count(*) from applied_updates where id='200420222') = 0 then
        -- [PH] Teleport to Auberdine
        UPDATE `spell_target_position` SET `target_position_x` = '6482.042', `target_position_y` = '614.423', `target_position_z` = '5.458', `target_orientation` = '2.893' WHERE (`id` = '6349') and (`target_map` = '1');
        insert into applied_updates values ('200420222');
    end if;

    -- 12/05/2022 1
    if (select count(*) from applied_updates where id='120520221') = 0 then
        -- Fix Duel Flag display id.
        UPDATE `gameobject_template` SET `displayId` = 327 WHERE `entry` = 21680;

        insert into applied_updates values ('120520221');
    end if;

    -- 14/05/2022 1
    if (select count(*) from applied_updates where id='140520221') = 0 then
        -- Fix Warlock Imp display id.
        UPDATE `creature_template` SET `display_id1` = 1213 WHERE `entry` = 416;

        insert into applied_updates values ('140520221');
    end if;

    -- 15/05/2022 1
    if (select count(*) from applied_updates where id='150520221') = 0 then
        -- Captain Morgan.
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3151', '797');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3151', '797');
        UPDATE `creature_template` SET `faction` = '120', `npc_flags` = '2' WHERE (`entry` = '3151');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `display_id`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400032', '3151', '0', '0', '0', '0', '1140', '0', '-14329.39', '529.05', '9.431', '0', '120', '120', '0', '100', '100', '0', '0', '0', '0');

        -- Journey to Ratchet!
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('797', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Journey to Ratchet!', '', '', 'So you\'re the adventurous type, eh? I bet you\'d like to see the distant lands of Kalimdor? I\'ll take you right over to Ratchet, on the coast of The Barrens.$B$BHang on tight! Here we go!$B$B<<Note: Our crack team of artists, programmers and shipwrights$Bare currently hard at work preparing the \"real\" boat for your sailing pleasure. In$Bthe meantime, please enjoy this free teleport instead. -- Thanks, --WoW$BTeam>>', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '4999', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

        insert into applied_updates values ('150520221');
    end if;

    -- 17/05/2022 1
    if (select count(*) from applied_updates where id='170520221') = 0 then
        DROP TABLE IF EXISTS `spell_enchant_charges`;
        CREATE TABLE IF NOT EXISTS `spell_enchant_charges` (
        `entry` INT unsigned NOT NULL,
        `charges` INT unsigned NOT NULL DEFAULT '0',
        PRIMARY KEY (`entry`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
        
        -- Poison Damage, Poison Damage II, Mind-numbing Poison
        INSERT INTO `spell_enchant_charges` (`entry`, `charges`) VALUES
        (2823, 60),
        (2824, 75),
        (5761, 50);

        insert into applied_updates values ('170520221');
    end if;

    -- 26/05/2022 1 - Item updates, from wdb files and from oldest allakhazam item history entries.
    -- This was all done with the current fresh full world dump.
    if (select count(*) from applied_updates where id='260520221') = 0 then
        
        -- Create a new table, so we keep track of which item entries have been modified, from what wdb version.
        CREATE TABLE `applied_item_updates` (
        `entry` INT NOT NULL,
        `version` INT NOT NULL DEFAULT 0,
        PRIMARY KEY (`entry`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

        -- Hammer of the Northern Wind -> 2004-08-24 15:48:53 -> spelleffect1 changed from '116' to '13439', dmg_low changed from '50' to '62', dmg_high changed from '93' to '117'
        UPDATE `item_template` SET `dmg_max1` = '93', `dmg_min1` = '50', `spellid_1` = '116' WHERE (`entry` = '810');

        -- Axe of the Deep Woods -> 2004-08-22 12:15:54 -> dmg_high changed from '117' to '146', dmg_low changed from '62' to '78'
        UPDATE `item_template` SET `dmg_max1` = '117', `dmg_min1` = '62' WHERE (`entry` = '811');

        -- Warden Staff -> 2004-08-23 15:02:37 -> displayinfo changed from '5098' to '20256', dmg_high changed from '109' to '143', dmg_low changed from '72' to '95' 
        UPDATE `item_template` SET `display_id` = '5098', `dmg_max1` = '109', `dmg_min1` = '72' WHERE (`entry` = '943');

        -- Tough Condor Meat -> 2004-10-14 12:15:49 -> displayinfo changed from '7416' to '25475'
        UPDATE `item_template` SET `display_id` = '7416' WHERE (`entry` = '1080');

        -- Skullflame Shield -> 2004-08-20 10:26:39 -> armor changed from '248' to '908'
        UPDATE `item_template` SET `armor` = '248' WHERE (`entry` = '1168');

        -- Blackskull Shield -> 2004-07-08 17:58:29 -> displayinfo changed from '6271' to '18816', armor changed from '208' to '743'
        UPDATE `item_template` SET `display_id` = '6271', `armor` = '208' WHERE (`entry` = '1169');

        -- Wall of the Dead -> 2004-10-12 18:27:21 -> armor changed from '864' to '900'
        UPDATE `item_template` SET `armor` = '864' WHERE (`entry` = '1979');

        -- Nightblade -> 2004-07-08 15:50:25 -> dmg_high changed from '133' to '117', dmg_low changed from '88' to '77', spelleffect1 changed from '0' to '13440' (Still wrong, might had no spell) 
        -- displayinfo changed from '5058' to '20191'
        UPDATE `item_template` SET `display_id` = '5058', `dmg_max1` = '133', `dmg_min1` = '88', `spellid_1` = '13440' WHERE (`entry` = '1982');

        -- Pressed Felt Robe -> 2004-05-24 19:11:41 -> armor changed from '23' to '25
        UPDATE `item_template` SET `armor` = '23' WHERE (`entry` = '1997');

        -- Hillborne Axe -> 2004-07-12 15:16:32 -> displayinfo changed from '18340' to '19400' (Still off) -> dmg_high changed from '45' to '43', dmg_low changed from '23' to '22'
        UPDATE `item_template` SET `display_id` = '18340', `dmg_max1` = '45', `dmg_min1` = '23' WHERE (`entry` = '2080');

        -- Dwarven Hand Cannon -> 2004-10-01 02:33:42 -> displayinfo changed from '6598' to '24652'
        UPDATE `item_template` SET `display_id` = '6598', `dmg_max2` = '11', `dmg_min2` = '1' WHERE (`entry` = '2099');

        -- Conjured Purified Water -> 2004-05-05 19:48:37 -> displayinfo changed from '6341' to '15849'
        UPDATE `item_template` SET `display_id` = '6341' WHERE (`entry` = '2136');

        -- ShadowBlade -> 2004-08-24 09:02:58 -> displayinfo changed from '6444' to '20291'
        UPDATE `item_template` SET `display_id` = '6444', `dmg_max1` = '61', `dmg_min1` = '32', `spellid_1` = '0' WHERE (`entry` = '2163');

        -- Staff of the Shade -> 2004-04-30 15:42:39 -> spelleffect1 changed from '2263' to '8472'
        UPDATE `item_template` SET `spellid_1` = '2263' WHERE (`entry` = '2549');

        -- Crude Flint -> 2004-06-18 19:18:14 -> displayinfo changed from '1502' to '18107', stacksize changed from '10' to '20'
        UPDATE `item_template` SET `display_id` = '1502', `stackable` = '10' WHERE (`entry` = '2611');

        -- Latched Belt -> 2004-11-08 02:46:30 -> displayinfo changed from '6963' to '28201'
        UPDATE `item_template` SET `display_id` = '6963' WHERE (`entry` = '2690');

        -- Antipodean Rod -> 2004-06-21 11:55:20 -> spelleffect1 changed from '2246' to '7684', spelleffect2 changed from '2250' to '7698'
        UPDATE `item_template` SET `spellid_1` = '2246', `spellid_2` = '2250' WHERE (`entry` = '2879');

        -- Eye of Flame -> 2004-08-20 11:50:42 -> spelleffect1 changed from '7689' to '9298'
        UPDATE `item_template` SET `spellid_1` = '7689' WHERE (`entry` = '3075');

        -- Melrache's Cape -> 2004-07-15 11:07:13 -> name1 changed from 'Scarlet Cloak' to 'Melrache's Cape'
        UPDATE `item_template` SET `name` = 'Scarlet Cloak' WHERE (`entry` = '3331');

        -- Elixir of Wisdom -> 2004-04-22 13:47:13 -> displayinfo changed from '1215' to '15745'
        UPDATE `item_template` SET `display_id` = '1215' WHERE (`entry` = '3383');

        -- Elixir of Poison Resistance -> 2004-05-28 12:19:47 -> displayinfo changed from '2345' to '15750'
        UPDATE `item_template` SET `display_id` = '2345' WHERE (`entry` = '3386');

        -- Limited Invulnerability Potion -> 2004-11-08 19:25:07 -> displayinfo changed from '2348' to '24213', level changed from '25' to '50'
        UPDATE `item_template` SET `display_id` = '2348', `required_level` = '25' WHERE (`entry` = '3387');

        -- Strong Troll's Blood Elixir -> 2004-07-02 14:58:22 -> displayinfo changed from '3664' to '15770'
        UPDATE `item_template` SET `display_id` = '3664', `required_level` = '25' WHERE (`entry` = '3388');

        -- Elixir of Defense -> 2004-07-02 14:58:22 -> displayinfo changed from '2345' to '15773'
        UPDATE `item_template` SET `display_id` = '2345' WHERE (`entry` = '3389');

        -- Gray Bear Tongue -> 2004-09-04 02:08:23 -> displayinfo changed from '3759' to '20898', stacksize changed from '10' to '20'
        UPDATE `item_template` SET `display_id` = '3759', `stackable` = '10' WHERE (`entry` = '3476');

        -- Mudsnout Blossoms -> 2004-09-04 02:08:23 -> displayinfo changed from '2793' to '17459', stacksize changed from '10' to '20'
        UPDATE `item_template` SET `display_id` = '2793', `stackable` = '10' WHERE (`entry` = '3502');

        -- Turtle Meat -> 2004-10-13 23:43:10 -> displayinfo changed from '2599' to '25472'
        UPDATE `item_template` SET `display_id` = '2599' WHERE (`entry` = '3712');

        -- Crippling Poison -> 2004-07-19 16:33:22 -> displayinfo changed from '2947' to '13708'
        UPDATE `item_template` SET `display_id` = '2947' WHERE (`entry` = '3775');

        -- Stranglekelp -> 2004-06-21 11:55:17 -> displayinfo changed from '7406' to '18089'
        UPDATE `item_template` SET `display_id` = '7406' WHERE (`entry` = '3820');

        -- Frost Oil -> 2006-03-08 02:25:21 -> displayinfo changed from '178' to '15794'
        UPDATE `item_template` SET `display_id` = '178' WHERE (`entry` = '3829');

        -- Mithril Ore -> 2004-08-20 11:50:29 -> displayinfo changed from '4691' to '20661'
        UPDATE `item_template` SET `display_id` = '4691' WHERE (`entry` = '3858');

        -- Blocking Targe -> 2004-07-17 18:13:55 -> block changed from '42' to '20', armor changed from '51' to '102'
        UPDATE `item_template` SET `armor` = '51', `block` = '42' WHERE (`entry` = '3989');

        -- Crested Buckler -> 2004-10-09 19:22:47 -> block changed from '17' to '23', armor changed from '609' to '756'
        UPDATE `item_template` SET `armor` = '609', `block` = '17' WHERE (`entry` = '3990');

        -- Coarse Gorilla Hair -> 2004-06-21 11:55:20 -> displayinfo changed from '1007' to '18096'
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '4096');

        -- Master Hunter's Bow -> 2004-08-20 10:23:59 -> displayinfo changed from '4441' to '20555', dmg_high changed from '113' to '102', dmg_low changed from '60' to '54'
        UPDATE `item_template` SET `display_id` = '4441', `dmg_max1` = '113', `dmg_min1` = '60' WHERE (`entry` = '4110');

        -- Mechanical Squirrel Box -> 2004-06-21 11:55:34 -> displayinfo changed from '7387' to '16536'
        UPDATE `item_template` SET `display_id` = '7387' WHERE (`entry` = '4401');

        -- Soft Bushy Tail -> 2004-07-29 15:49:43 -> displayinfo changed from '12862' to '1809
        UPDATE `item_template` SET `display_id` = '12862' WHERE (`entry` = '4582');

        -- Goblin Fishing Pole -> 2004-07-19 15:13:01 -> displayinfo changed from '6384' to '18063'
        UPDATE `item_template` SET `display_id` = '6384' WHERE (`entry` = '4598');

        -- Firebloom -> 2004-06-21 11:55:16 -> displayinfo changed from '7364' to '2788'
        UPDATE `item_template` SET `display_id` = '7364' WHERE (`entry` = '4625');

        -- Ceremonial Cloak -> 2004-06-22 17:08:06 -> displayinfo changed from '8760' to '15084'
        UPDATE `item_template` SET `display_id` = '8760' WHERE (`entry` = '4692');

        -- Explosive Stick of Gann -> 2004-09-04 02:08:24 -> displayinfo changed from '6384' to '18062'
        UPDATE `item_template` SET `display_id` = '6384' WHERE (`entry` = '5021');

        -- Shadow Hunter Knife -> 2004-09-28 17:19:53 -> displayinfo changed from '6444' to '20321'
        UPDATE `item_template` SET `display_id` = '6444' WHERE (`entry` = '5040');

        -- Impaling Harpoon -> 2004-09-28 17:19:53 -> displayinfo changed from '12562' to '5949'
        UPDATE `item_template` SET `display_id` = '5949' WHERE (`entry` = '5200');

        -- Raptor Punch -> 2004-06-22 17:08:06 -> displayinfo changed from '6245' to '18099'
        UPDATE `item_template` SET `display_id` = '6245' WHERE (`entry` = '5342');

        -- Key to Searing Gorge -> 2004-07-15 11:07:13 -> displayinfo changed from '7827' to '13824
        UPDATE `item_template` SET `display_id` = '7827' WHERE (`entry` = '5396');

        -- Kaldorei Spider Kabob -> 2004-09-02 19:03:38 -> name1 changed from 'Kaldorei Caviar' to 'Kaldorei Spider Kabob', displayinfo changed from '7991' to '21327
        UPDATE `item_template` SET `name` = 'Kaldorei Caviar', `display_id` = '7991' WHERE (`entry` = '5472');

        -- Clam Meat -> 2004-09-23 19:49:10 -> displayinfo changed from '6350' to '22193'
        UPDATE `item_template` SET `display_id` = '6350' WHERE (`entry` = '5503');

        -- Unrefined Ore Sample ->2004-07-19 15:54:42 -> displayinfo changed from '9142' to '18107'
        UPDATE `item_template` SET `display_id` = '9142' WHERE (`entry` = '5842');

        -- Regent's Cloak -> 2004-09-25 10:22:04 -> displayinfo changed from '15179' to '23059'
        UPDATE `item_template` SET `display_id` = '15179' WHERE (`entry` = '5969');

        -- All patterns, plans. 2004-12-22 03:54:35 -> displayinfo changed from '1102' to '15274'
        UPDATE `item_template` SET `display_id` = '1102' WHERE (`display_id` = '15274');

        -- Fire Oil -> 2004-07-02 14:58:21 -> displayinfo changed from '11461' to '15771'
        UPDATE `item_template` SET `display_id` = '11461' WHERE (`entry` = '6371');

        -- Blackforge Greaves -> 2004-11-08 07:05:03 -> displayinfo changed from '11629' to '26077'
        UPDATE `item_template` SET `display_id` = '11629' WHERE (`entry` = '6423');

        -- Imperial Leather Breastplate -> 2004-06-21 11:55:34 -> displayinfo changed from '14699' to '18471'
        UPDATE `item_template` SET `display_id` = '14699' WHERE (`entry` = '6430');

        -- Glowing Lizardscale Cloak -> 2004-04-22 13:47:13 -> displayinfo changed from '8787' to '15187', armor changed from '27' to '30'
        UPDATE `item_template` SET `display_id` = '8787', `armor` = '27' WHERE (`entry` = '6449');

        -- Dazzling Longsword -> 2004-08-20 11:51:08 -> spelleffect1 changed from '770' to '13424'
        UPDATE `item_template` SET `spellid_1` = '770' WHERE (`entry` = '869');

        -- Fiery War Axe -> 2004-08-22 12:15:45 -> spelleffect1 changed from '143' to '13438'
        UPDATE `item_template` SET `spellid_1` = '143' WHERE (`entry` = '870');

        -- Flurry Axe -> 2004-08-20 10:23:58 -> spelleffect1 changed from '8815' to '13679'
        UPDATE `item_template` SET `spellid_1` = '8815' WHERE (`entry` = '871');

        -- Freezing Band -> 2004-08-20 11:51:08 -> spelleffect1 changed from '5151' to '0'
        UPDATE `item_template` SET `spellid_1` = '5151', `spellid_2` = '0' WHERE (`entry` = '942');

        -- Night Reaver -> 2004-07-19 15:54:42 -> spelleffect1 changed from '695' to '0'
        UPDATE `item_template` SET `spellid_1` = '695' WHERE (`entry` = '1318');

        -- Ring of Healing -> 2004-08-20 10:24:00 -> spelleffect1 changed from '2053' to '14053'
        UPDATE `item_template` SET `spellid_1` = '2053' WHERE (`entry` = '1713');

        -- Tanglewood Staff -> 2004-04-19 11:36:41 -> spelleffect1 changed from '2305' to '9354'
        UPDATE `item_template` SET `spellid_1` = '2305' WHERE (`entry` = '1720');

        -- Orb of Deception -> 2004-07-08 16:22:40 -> spelleffect1 changed from '700' to '12854'
        UPDATE `item_template` SET `spellid_1` = '700' WHERE (`entry` = '1973');

        -- Bloodscalp Channeling Staff -> 2004-08-20 11:51:01 -> spelleffect1 changed from '7695' to '9357'
        UPDATE `item_template` SET `spellid_1` = '7695' WHERE (`entry` = '1998');

        -- Phytoblade -> 2004-08-20 11:50:59 -> spelleffect1 changed from '5178' to '14119'
        UPDATE `item_template` SET `spellid_1` = '5178' WHERE (`entry` = '2263');

        -- Staff of the Blessed Seer -> 2004-07-09 10:07:13 -> spelleffect1 changed from '7676' to '8475'
        UPDATE `item_template` SET `spellid_1` = '7676' WHERE (`entry` = '2289');

        -- Burning War Axe -> 2004-06-23 13:32:14 -> spelleffect1 changed from '0' to '7711'
        UPDATE `item_template` SET `spellid_1` = '7711' WHERE (`entry` = '2299');

        -- Elven Spirit Claws -> 2004-06-20 23:31:05 -> spelleffect1 changed from '2258' to '7692'
        UPDATE `item_template` SET `spellid_1` = '2258' WHERE (`entry` = '2564');

        -- Rod of Molten Fire -> 2004-06-23 13:32:16 -> spelleffect1 changed from '2267' to '7687'
        UPDATE `item_template` SET `spellid_1` = '2267' WHERE (`entry` = '2565');

        -- Blazing Emblem -> 2004-08-20 10:24:00 -> spelleffect1 changed from '2120' to '13744'
        UPDATE `item_template` SET `spellid_1` = '2120' WHERE (`entry` = '2802');

        -- Nifty Stopwatch -> 2004-08-20 10:24:00 -> spelleffect1 changed from '246' to '14530'
        UPDATE `item_template` SET `spellid_1` = '246' WHERE (`entry` = '2820');

        -- Black Malice -> 2004-07-19 15:54:39 -> spelleffect1 changed from '695' to '0'
        UPDATE `item_template` SET `spellid_1` = '695' WHERE (`entry` = '3194');

        -- Smotts' Compass -> 2004-07-08 16:09:19 -> spelleffect1 changed from '0' to '7598'
        UPDATE `item_template` SET `spellid_1` = '7598' WHERE (`entry` = '4130');

        -- Black Husk Shield -> 2004-08-20 18:08:42 -> spelleffect1 changed from '2893' to '14253'
        UPDATE `item_template` SET `spellid_1` = '2893' WHERE (`entry` = '4444');

        -- Drink IV.
        UPDATE `item_template` SET `spellid_1` = '1133' WHERE (`spellid_1` = '11009');

        -- Faintly Glowing Skull -> 2004-09-28 17:19:53 -> spelleffect1 changed from '2006' to '16375'
        UPDATE `item_template` SET `spellid_1` = '3' WHERE (`entry` = '4945');

        -- Shiver Blade -> 2004-08-25 15:17:38 -> pelleffect1 changed from '113' to '13439'
        UPDATE `item_template` SET `spellid_1` = '113' WHERE (`entry` = '5182');

        -- Cruel Barb -> 2004-06-21 16:17:35 -> spelleffect1 changed from '5258' to '7597'
        UPDATE `item_template` SET `spellid_1` = '5258' WHERE (`entry` = '5191');

        -- Everglow Lantern -> 2004-04-19 11:37:40 -> spelleffect1 changed from '635' to '647'
        UPDATE `item_template` SET `spellid_1` = '635' WHERE (`entry` = '5323');

        -- Ornate Spyglass -> 2004-08-23 11:35:19 -> spelleffect1 changed from '6197' to '12883'
        UPDATE `item_template` SET `spellid_1` = '6197' WHERE (`entry` = '5507');

        -- Stinging Viper -> 2004-08-24 15:56:48 -> spelleffect1 changed from '3396' to '13518'
        UPDATE `item_template` SET `spellid_1` = '3396' WHERE (`entry` = '6472');

       

        -- WDB 3368 missing updates.



        -- Flimsy Chain Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 2652);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2652, 3368);
        -- Worn Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 36);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (36, 3368);
        -- Ragged Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 1372);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1372, 3368);
        -- Forsaken Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3269);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3269, 3368);
        -- Worn Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 1421);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1421, 3368);
        -- Loose Chain Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 2644);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2644, 3368);
        -- Tribal Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4674);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4674, 3368);
        -- Light Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2500);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2500, 3368);
        -- Battle Chain Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4668);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4668, 3368);
        -- Billy Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4563);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4563, 3368);
        -- Bonecracker
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3440);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3440, 3368);
        -- Blacksmith's Hammer
        -- description, from Needed for Blacksmithing to Needed for Blacksmithing.
        UPDATE `item_template` SET `description` = 'Needed for Blacksmithing.' WHERE (`entry` = 5956);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5956, 3368);
        -- Round Buckler
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 2377);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2377, 3368);
        -- Bonegrinding Pestle
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3570);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3570, 3368);
        -- Worn Mail Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 1733);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1733, 3368);
        -- Sergeant's Warhammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2079);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2079, 3368);
        -- Acid Proof Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 3582);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3582, 3368);
        -- Staunch Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4569);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4569, 3368);
        -- Weak Troll's Blood Potion
        -- spellcategory_1, from 79 to 4
        -- spellcategorycooldown_1, from 3000 to 120000
        UPDATE `item_template` SET `spellcategory_1` = 4, `spellcategorycooldown_1` = 120000 WHERE (`entry` = 3382);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3382, 3368);
        -- Sturdy Flail
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 852);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (852, 3368);
        -- Cranial Thumper
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4303);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4303, 3368);
        -- Inscribed Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4701);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4701, 3368);
        -- Ornamental Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1815);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1815, 3368);
        -- Brackwater Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4680);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4680, 3368);
        -- Linked Chain Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 1749);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1749, 3368);


        
        
        -- WDB 3494 missing updates.



        -- Worn Wooden Shield
        -- buy_price, from 11 to 7
        -- sell_price, from 2 to 1
        UPDATE `item_template` SET `buy_price` = 7, `sell_price` = 1 WHERE (`entry` = 2362);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2362, 3494);
        -- Bear Shawl
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6185);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6185, 3494);
        -- Rustic Belt
        -- name, from Dwarven Chain Belt to Rustic Belt
        UPDATE `item_template` SET `name` = 'Rustic Belt' WHERE (`entry` = 2172);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2172, 3494);
        -- Tough Wolf Meat
        -- stackable, from 20 to 10
        UPDATE `item_template` SET `stackable` = 10 WHERE (`entry` = 750);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (750, 3494);
        -- Short Cudgel
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2130);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2130, 3494);
        -- Small Wooden Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2055);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2055, 3494);
        -- Ancestral Leggings
        -- quality, from 1 to 2
        -- buy_price, from 299 to 498
        -- sell_price, from 59 to 99
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 498, `sell_price` = 99 WHERE (`entry` = 3291);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3291, 3494);
        -- Ensign Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 3070);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3070, 3494);
        -- Cloak of the People's Militia
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 3511);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3511, 3494);
        -- Burnt Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4665);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4665, 3494);
        -- Militia Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 5580);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5580, 3494);
        -- Copper Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2844);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2844, 3494);
        -- Small Targe
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 1167);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1167, 3494);
        -- Light Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2492);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2492, 3494);
        -- Veteran Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4677);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4677, 3494);
        -- Heavy Bronze Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3491);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3491, 3494);
        -- Fishing Pole
        -- dmg_min1, from 1.0 to 12
        -- dmg_max1, from 1.0 to 15
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 15 WHERE (`entry` = 6256);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6256, 3494);
        -- Copper Rod
        -- class, from 2 to 7
        -- description, from Needed for an Enchanter to make his runed copper rod. to Needed by an Enchanter to make a runed copper rod.
        UPDATE `item_template` SET `class` = 7, `description` = 'Needed by an Enchanter to make a runed copper rod.' WHERE (`entry` = 6217);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6217, 3494);
        -- Mild Spices
        -- buy_price, from 4 to 10
        UPDATE `item_template` SET `buy_price` = 10 WHERE (`entry` = 2678);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2678, 3494);
        -- Hunting Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4689);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4689, 3494);
        -- Warrior's Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4658);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4658, 3494);
        -- Goat Fur Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 2905);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2905, 3494);
        -- Barbaric Linen Vest
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `stat_value1` = 3 WHERE (`entry` = 2578);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2578, 3494);
        -- Woolen Cape
        -- buy_price, from 941 to 711
        -- sell_price, from 188 to 142
        -- item_level, from 18 to 16
        -- required_level, from 8 to 6
        UPDATE `item_template` SET `buy_price` = 711, `sell_price` = 142, `item_level` = 16, `required_level` = 6 WHERE (`entry` = 2584);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2584, 3494);
        -- Flying Tiger Goggles
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4368);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4368, 3494);
        -- Mutant Scale Breastplate
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6627);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6627, 3494);
        -- Cobrahn's Grasp
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6460);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6460, 3494);
        -- Heavy Runed Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4798);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4798, 3494);
        -- Infantry Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 6508);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6508, 3494);
        -- Silverlaine's Family Seal
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6321);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6321, 3494);
        -- Taskmaster Axe
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 5194);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5194, 3494);
        -- Solid Metal Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1158);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1158, 3494);
        -- Gnoll Skull Basher
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1440);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1440, 3494);
        -- Odo's Ley Staff
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6318);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6318, 3494);
        -- Spellcrafter Wand
        -- dmg_type1, from 6 to 2
        UPDATE `item_template` SET `dmg_type1` = 2 WHERE (`entry` = 6677);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6677, 3494);
        -- Yeti Fur Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 2805);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2805, 3494);
        -- Small Shield
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 2133);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2133, 3494);
        -- Pioneer Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6520);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6520, 3494);
        -- Kobold Mining Shovel
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1195);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1195, 3494);
        -- Beatstick
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3190);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3190, 3494);
        -- Kobold Mining Mallet
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1389);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1389, 3494);
        -- Privateer's Cape
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 6179);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6179, 3494);
        -- Battleforge Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 6593);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6593, 3494);
        -- Seer's Belt
        -- name, from Seer's Sash to Seer's Belt
        -- buy_price, from 2186 to 1934
        -- sell_price, from 437 to 386
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        -- stat_type1, from 0 to 6
        UPDATE `item_template` SET `name` = 'Seer''s Belt', `buy_price` = 1934, `sell_price` = 386, `item_level` = 22, `required_level` = 17, `stat_type1` = 5 WHERE (`entry` = 4699);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4699, 3494);
        -- Dwarven Guard Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4504);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4504, 3494);
        -- Iridescent Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 5541);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5541, 3494);
        -- Commander's Crest
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6320);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6320, 3494);
        -- Glowing Wax Stick
        -- spellid_1, from 13424 to 6950
        UPDATE `item_template` SET `spellid_1` = 6950 WHERE (`entry` = 1434);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1434, 3494);
        -- Rusty Warhammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1514);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1514, 3494);
        -- Dark Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 2316);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2316, 3494);
        -- Embossed Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 2310);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2310, 3494);
        -- Antipodean Rod
        -- sheath, from 7 to 3
        UPDATE `item_template` SET `sheath` = 3 WHERE (`entry` = 2879);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2879, 3494);



        -- WDB 3596 missing updates.



        -- Worn Shortsword
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 10.0 to 4
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 4 WHERE (`entry` = 25);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (25, 3596);
        -- Blackened Leather Belt
        -- buy_price, from 20 to 21
        UPDATE `item_template` SET `buy_price` = 21 WHERE (`entry` = 6058);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6058, 3596);
        -- Patchwork Belt
        -- name, from Patchwork Cloth Belt to Patchwork Belt
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `name` = 'Patchwork Belt', `required_level` = 3 WHERE (`entry` = 3370);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3370, 3596);
        -- Long Bo Staff
        -- required_level, from 1 to 5
        -- dmg_min1, from 15.0 to 9
        -- dmg_max1, from 21.0 to 15
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 9, `dmg_max1` = 15 WHERE (`entry` = 767);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (767, 3596);
        -- Worn Dagger
        -- dmg_min1, from 5.0 to 1
        -- dmg_max1, from 8.0 to 3
        UPDATE `item_template` SET `dmg_min1` = 1, `dmg_max1` = 3 WHERE (`entry` = 2092);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2092, 3596);
        -- Thistlewood Dagger
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 10.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 5392);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5392, 3596);
        -- Thistlewood Staff
        -- dmg_min1, from 13.0 to 7
        -- dmg_max1, from 19.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 12 WHERE (`entry` = 5393);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5393, 3596);
        -- Ironheart Chain
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 10 WHERE (`entry` = 3166);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3166, 3596);
        -- Chainmail Belt
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1845);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1845, 3596);
        -- Hunting Pants
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 1 WHERE (`entry` = 2974);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2974, 3596);
        -- Chainmail Boots
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 849);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (849, 3596);
        -- Chainmail Bracers
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1846);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1846, 3596);
        -- Chainmail Gloves
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 850);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (850, 3596);
        -- Scouting Cloak
        -- buy_price, from 2926 to 3212
        -- sell_price, from 585 to 642
        -- required_level, from 11 to 16
        -- material, from 7 to 8
        UPDATE `item_template` SET `buy_price` = 3212, `sell_price` = 642, `required_level` = 16, `material` = 8 WHERE (`entry` = 6585);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6585, 3596);
        -- Giant Club
        -- dmg_min1, from 35.0 to 22
        -- dmg_max1, from 48.0 to 34
        UPDATE `item_template` SET `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 1197);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1197, 3596);
        -- Chainmail Pants
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 848);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (848, 3596);
        -- Smite's Mighty Hammer
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7230);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7230, 3596);
        -- Flanged Mace
        -- required_level, from 1 to 4
        -- dmg_min1, from 10.0 to 4
        -- dmg_max1, from 15.0 to 9
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 4, `dmg_max1` = 9, `material` = 1 WHERE (`entry` = 766);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (766, 3596);
        -- Worn Shortbow
        -- dmg_min1, from 4.0 to 3
        UPDATE `item_template` SET `dmg_min1` = 3 WHERE (`entry` = 2504);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2504, 3596);
        -- Hornwood Recurve Bow
        -- dmg_min1, from 6.0 to 7
        -- dmg_max1, from 10.0 to 13
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 13 WHERE (`entry` = 2506);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2506, 3596);
        -- Laminated Recurve Bow
        -- dmg_min1, from 13.0 to 15
        -- dmg_max1, from 21.0 to 29
        UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 29 WHERE (`entry` = 2507);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2507, 3596);
        -- Reinforced Bow
        -- dmg_min1, from 13.0 to 17
        -- dmg_max1, from 21.0 to 32
        UPDATE `item_template` SET `dmg_min1` = 17, `dmg_max1` = 32 WHERE (`entry` = 3026);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3026, 3596);
        -- Rough Arrow
        -- item_level, from 1 to 5
        -- dmg_min1, from 1.0 to 2
        -- dmg_max1, from 2.0 to 3
        UPDATE `item_template` SET `item_level` = 5, `dmg_min1` = 2, `dmg_max1` = 3 WHERE (`entry` = 2512);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2512, 3596);
        -- Sharp Arrow
        -- dmg_min1, from 4.0 to 5
        -- dmg_max1, from 4.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 6 WHERE (`entry` = 2515);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2515, 3596);
        -- Razor Arrow
        -- dmg_min1, from 6.0 to 12
        -- dmg_max1, from 7.0 to 13
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 13 WHERE (`entry` = 3030);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3030, 3596);
        -- Peasant Sword
        -- dmg_min1, from 9.0 to 3
        -- dmg_max1, from 14.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 2131);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2131, 3596);
        -- Damaged Claymore
        -- dmg_min1, from 13.0 to 7
        -- dmg_max1, from 18.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 1194);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1194, 3596);
        -- Old Hand Axe
        -- dmg_min1, from 7.0 to 3
        -- dmg_max1, from 12.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 6 WHERE (`entry` = 2134);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2134, 3596);
        -- Dull Broad Axe
        -- dmg_min1, from 13.0 to 7
        -- dmg_max1, from 19.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 12 WHERE (`entry` = 2479);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2479, 3596);
        -- Large Crooked Club
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 18.0 to 10
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 2480);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2480, 3596);
        -- Simple Dagger
        -- dmg_min1, from 5.0 to 2
        -- dmg_max1, from 9.0 to 4
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 4 WHERE (`entry` = 2139);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2139, 3596);
        -- Initiate Staff
        -- dmg_min1, from 14.0 to 8
        -- dmg_max1, from 19.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 8, `dmg_max1` = 12 WHERE (`entry` = 2132);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2132, 3596);
        -- Light Shot
        -- item_level, from 1 to 5
        -- dmg_min1, from 1.0 to 2
        -- dmg_max1, from 2.0 to 3
        UPDATE `item_template` SET `item_level` = 5, `dmg_min1` = 2, `dmg_max1` = 3 WHERE (`entry` = 2516);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2516, 3596);
        -- Crude Throwing Axe
        -- dmg_min1, from 4.0 to 1
        -- dmg_max1, from 6.0 to 3
        UPDATE `item_template` SET `dmg_min1` = 1, `dmg_max1` = 3 WHERE (`entry` = 3111);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3111, 3596);
        -- Small Throwing Knife
        -- dmg_min1, from 4.0 to 1
        -- dmg_max1, from 6.0 to 3
        UPDATE `item_template` SET `dmg_min1` = 1, `dmg_max1` = 3 WHERE (`entry` = 2947);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2947, 3596);
        -- Infantry Tunic
        -- quality, from 2 to 1
        -- buy_price, from 1526 to 732
        -- sell_price, from 305 to 146
        -- item_level, from 13 to 12
        -- required_level, from 3 to 7
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 732, `sell_price` = 146, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 6336);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6336, 3596);
        -- Warrior's Girdle
        -- buy_price, from 442 to 282
        -- sell_price, from 88 to 56
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `buy_price` = 282, `sell_price` = 56, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 4659);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4659, 3596);
        -- Pioneer Trousers
        -- quality, from 2 to 1
        -- buy_price, from 1208 to 463
        -- sell_price, from 241 to 92
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 463, `sell_price` = 92, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 6269);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6269, 3596);
        -- Burnt Leather Boots
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2963);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2963, 3596);
        -- Warrior's Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3214);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3214, 3596);
        -- Moss-covered Gauntlets
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 5589);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5589, 3596);
        -- Defender Axe
        -- required_level, from 3 to 8
        -- dmg_min1, from 20.0 to 9
        -- dmg_max1, from 31.0 to 18
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 9, `dmg_max1` = 18, `bonding` = 2 WHERE (`entry` = 5459);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5459, 3596);
        -- Infantry Leggings
        -- quality, from 2 to 1
        -- buy_price, from 1686 to 587
        -- sell_price, from 337 to 117
        -- item_level, from 14 to 11
        -- required_level, from 4 to 6
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 587, `sell_price` = 117, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 6337);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6337, 3596);
        -- Shimmering Mantle
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6566);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6566, 3596);
        -- Inscribed Leather Breastplate
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 2985);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2985, 3596);
        -- Hunting Belt
        -- required_level, from 5 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 4690);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4690, 3596);
        -- Embossed Leather Boots
        -- required_level, from 3 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 2309);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2309, 3596);
        -- Bard's Bracers
        -- buy_price, from 581 to 602
        -- sell_price, from 116 to 120
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `buy_price` = 602, `sell_price` = 120, `required_level` = 11 WHERE (`entry` = 6556);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6556, 3596);
        -- Scouting Gloves
        -- buy_price, from 1695 to 1690
        -- sell_price, from 339 to 338
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `buy_price` = 1690, `sell_price` = 338, `required_level` = 15 WHERE (`entry` = 6586);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6586, 3596);
        -- Blade of Cunning
        -- allowable_class, from 8 to 32767
        UPDATE `item_template` SET `allowable_class` = 32767 WHERE (`entry` = 7298);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7298, 3596);
        -- Sharpened Knife
        -- dmg_min1, from 12.0 to 6
        -- dmg_max1, from 19.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 11 WHERE (`entry` = 2207);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2207, 3596);
        -- Handstitched Leather Boots
        -- buy_price, from 147 to 70
        -- sell_price, from 29 to 14
        -- item_level, from 8 to 6
        UPDATE `item_template` SET `buy_price` = 70, `sell_price` = 14, `item_level` = 6 WHERE (`entry` = 2302);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2302, 3596);
        -- Gardening Gloves
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 5606);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5606, 3596);
        -- Handstitched Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 7276);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7276, 3596);
        -- Withered Staff
        -- required_level, from 1 to 5
        -- dmg_min1, from 13.0 to 8
        -- dmg_max1, from 18.0 to 12
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 8, `dmg_max1` = 12 WHERE (`entry` = 1411);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1411, 3596);
        -- Rough Leather Boots
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 796);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (796, 3596);
        -- Knitted Tunic
        -- name, from Knitted Vest to Knitted Tunic
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `name` = 'Knitted Tunic', `required_level` = 5 WHERE (`entry` = 795);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (795, 3596);
        -- Knitted Belt
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3602);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3602, 3596);
        -- Knitted Pants
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 794);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (794, 3596);
        -- Knitted Sandals
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 792);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (792, 3596);
        -- Knitted Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3603);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3603, 3596);
        -- Knitted Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 793);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (793, 3596);
        -- Patchwork Cloak
        -- name, from Patchwork Cloth Cloak to Patchwork Cloak
        UPDATE `item_template` SET `name` = 'Patchwork Cloak' WHERE (`entry` = 1429);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1429, 3596);
        -- Worn Leather Boots
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 1419);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1419, 3596);
        -- Nicked Blade
        -- dmg_min1, from 7.0 to 3
        -- dmg_max1, from 12.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 2494);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2494, 3596);
        -- Rough Leather Vest
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 799);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (799, 3596);
        -- Tribal Belt
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 4675);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4675, 3596);
        -- Burnt Leather Pants
        -- buy_price, from 1221 to 781
        -- sell_price, from 244 to 156
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 781, `sell_price` = 156, `item_level` = 11, `required_level` = 6, `stat_type1` = 1, `stat_value1` = 3 WHERE (`entry` = 2962);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2962, 3596);
        -- Pioneer Gloves
        -- buy_price, from 280 to 295
        -- sell_price, from 56 to 59
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `buy_price` = 295, `sell_price` = 59, `required_level` = 7 WHERE (`entry` = 6521);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6521, 3596);
        -- Sharpened Letter Opener
        -- required_level, from 1 to 4
        -- dmg_min1, from 5.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 2138);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2138, 3596);
        -- Bard's Buckler
        -- name, from Soldier's Buckler to Bard's Buckler
        -- buy_price, from 2017 to 2168
        -- sell_price, from 403 to 433
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `name` = 'Bard''s Buckler', `buy_price` = 2168, `sell_price` = 433, `required_level` = 11 WHERE (`entry` = 6559);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6559, 3596);
        -- Weighted Throwing Axe
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 3131);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3131, 3596);
        -- Rough Leather Belt
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1839);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1839, 3596);
        -- Rough Leather Pants
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 798);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (798, 3596);
        -- Feral Bracers
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 5419);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5419, 3596);
        -- Burnt Leather Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2964);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2964, 3596);
        -- Pruning Knife
        -- required_level, from 1 to 6
        -- dmg_min1, from 8.0 to 4
        -- dmg_max1, from 13.0 to 9
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 5605);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5605, 3596);
        -- Warrior's Buckler
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 3648);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3648, 3596);
        -- Carving Knife
        -- required_level, from 1 to 6
        -- dmg_min1, from 8.0 to 4
        -- dmg_max1, from 13.0 to 9
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 2140);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2140, 3596);
        -- Burnt Leather Vest
        -- buy_price, from 1217 to 779
        -- sell_price, from 243 to 155
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 779, `sell_price` = 155, `item_level` = 11, `required_level` = 6, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 2961);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2961, 3596);
        -- Dirtwood Belt
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 5458);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5458, 3596);
        -- Disciple's Pants
        -- quality, from 2 to 1
        -- buy_price, from 933 to 447
        -- sell_price, from 186 to 89
        -- item_level, from 13 to 12
        -- required_level, from 3 to 7
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 447, `sell_price` = 89, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 6267);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6267, 3596);
        -- Pioneer Boots
        -- buy_price, from 421 to 439
        -- sell_price, from 84 to 87
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `buy_price` = 439, `sell_price` = 87, `required_level` = 7 WHERE (`entry` = 6518);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6518, 3596);
        -- Journeyman's Robe
        -- buy_price, from 598 to 608
        -- sell_price, from 119 to 121
        -- required_level, from 1 to 6
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 608, `sell_price` = 121, `required_level` = 6, `stat_type1` = 1, `stat_value1` = 2 WHERE (`entry` = 6511);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6511, 3596);
        -- Journeyman's Belt
        -- buy_price, from 306 to 196
        -- sell_price, from 61 to 39
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `buy_price` = 196, `sell_price` = 39, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 4663);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4663, 3596);
        -- Thornroot Club
        -- required_level, from 3 to 8
        -- dmg_min1, from 18.0 to 8
        -- dmg_max1, from 28.0 to 16
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 8, `dmg_max1` = 16 WHERE (`entry` = 5587);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5587, 3596);
        -- Worn Leather Bracers
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 1420);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1420, 3596);
        -- Rain-spotted Cape
        -- required_level, from 1 to 6
        -- material, from 7 to 8
        UPDATE `item_template` SET `required_level` = 6, `material` = 8 WHERE (`entry` = 5591);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5591, 3596);
        -- Apprentice Short Staff
        -- dmg_min1, from 15.0 to 9
        -- dmg_max1, from 21.0 to 15
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 15 WHERE (`entry` = 2495);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2495, 3596);
        -- Patchwork Armor
        -- name, from Patchwork Cloth Vest to Patchwork Armor
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `name` = 'Patchwork Armor', `required_level` = 2 WHERE (`entry` = 1433);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1433, 3596);
        -- Worn Leather Belt
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 1418);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1418, 3596);
        -- Pioneer Bracers
        -- buy_price, from 132 to 180
        -- sell_price, from 26 to 36
        -- item_level, from 9 to 10
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `buy_price` = 180, `sell_price` = 36, `item_level` = 10, `required_level` = 5 WHERE (`entry` = 6519);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6519, 3596);
        -- Disciple's Cloak
        -- buy_price, from 519 to 346
        -- sell_price, from 103 to 69
        -- item_level, from 14 to 12
        -- required_level, from 4 to 7
        UPDATE `item_template` SET `buy_price` = 346, `sell_price` = 69, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 6514);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6514, 3596);
        -- Pioneer Belt
        -- buy_price, from 350 to 233
        -- sell_price, from 70 to 46
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `buy_price` = 233, `sell_price` = 46, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 6517);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6517, 3596);
        -- Worn Leather Pants
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 1423);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1423, 3596);
        -- Light Mail Armor
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2392);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2392, 3596);
        -- Light Mail Belt
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2393);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2393, 3596);
        -- Light Mail Leggings
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2394);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2394, 3596);
        -- Light Mail Boots
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2395);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2395, 3596);
        -- Light Mail Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2396);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2396, 3596);
        -- Light Mail Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2397);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2397, 3596);
        -- Dull Heater Shield
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1201);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1201, 3596);
        -- Worn Leather Vest
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 1425);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1425, 3596);
        -- Journeyman's Boots
        -- name, from Cozy Moccasins to Journeyman's Boots
        -- buy_price, from 434 to 213
        -- sell_price, from 86 to 42
        -- item_level, from 13 to 10
        -- required_level, from 3 to 5
        UPDATE `item_template` SET `name` = 'Journeyman''s Boots', `buy_price` = 213, `sell_price` = 42, `item_level` = 10, `required_level` = 5 WHERE (`entry` = 2959);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2959, 3596);
        -- Rough Leather Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1840);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1840, 3596);
        -- Journeyman's Cloak
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 4662);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4662, 3596);
        -- Embossed Leather Vest
        -- required_level, from 2 to 7
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 1, `stat_value1` = 3 WHERE (`entry` = 2300);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2300, 3596);
        -- Disciple's Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 6515);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6515, 3596);
        -- Infantry Gauntlets
        -- buy_price, from 421 to 209
        -- sell_price, from 84 to 41
        -- item_level, from 13 to 10
        -- required_level, from 3 to 5
        UPDATE `item_template` SET `buy_price` = 209, `sell_price` = 41, `item_level` = 10, `required_level` = 5 WHERE (`entry` = 6510);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6510, 3596);
        -- Lumberjack Axe
        -- required_level, from 1 to 4
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 20.0 to 11
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 6, `dmg_max1` = 11 WHERE (`entry` = 768);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (768, 3596);
        -- Handstitched Leather Pants
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 2303);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2303, 3596);
        -- Balanced Throwing Dagger
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 2946);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2946, 3596);
        -- Small Leather Collar
        -- name, from Discolored Fang to Small Leather Collar
        UPDATE `item_template` SET `name` = 'Small Leather Collar' WHERE (`entry` = 4813);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4813, 3596);
        -- Rough Leather Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 797);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (797, 3596);
        -- Burnt Leather Bracers
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 3200);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3200, 3596);
        -- Patchwork Pants
        -- name, from Patchwork Cloth Pants to Patchwork Pants
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `name` = 'Patchwork Pants', `required_level` = 3 WHERE (`entry` = 1431);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1431, 3596);
        -- Journeyman's Bracers
        -- name, from Strapped Bracers to Journeyman's Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `name` = 'Journeyman''s Bracers', `required_level` = 5 WHERE (`entry` = 3641);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3641, 3596);
        -- Footman Sword
        -- dmg_min1, from 11.0 to 6
        -- dmg_max1, from 17.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 11 WHERE (`entry` = 2488);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2488, 3596);
        -- Tarnished Claymore
        -- dmg_min1, from 17.0 to 10
        -- dmg_max1, from 23.0 to 15
        UPDATE `item_template` SET `dmg_min1` = 10, `dmg_max1` = 15 WHERE (`entry` = 2489);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2489, 3596);
        -- Small Hand Axe
        -- dmg_min1, from 9.0 to 4
        -- dmg_max1, from 14.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 2490);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2490, 3596);
        -- Twin-bladed War Axe
        -- dmg_min1, from 17.0 to 11
        -- dmg_max1, from 24.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 2491);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2491, 3596);
        -- Wooden Mallet
        -- dmg_min1, from 16.0 to 11
        -- dmg_max1, from 23.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 2493);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2493, 3596);
        -- Journeyman's Pants
        -- buy_price, from 473 to 770
        -- sell_price, from 94 to 154
        -- item_level, from 10 to 12
        -- required_level, from 1 to 7
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 770, `sell_price` = 154, `item_level` = 12, `required_level` = 7, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 2958);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2958, 3596);
        -- Patchwork Gloves
        -- name, from Patchwork Cloth Gloves to Patchwork Gloves
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `name` = 'Patchwork Gloves', `required_level` = 2 WHERE (`entry` = 1430);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1430, 3596);
        -- Warrior's Tunic
        -- buy_price, from 1481 to 1185
        -- sell_price, from 296 to 237
        -- item_level, from 13 to 12
        -- required_level, from 3 to 7
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 1185, `sell_price` = 237, `item_level` = 12, `required_level` = 7, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 2965);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2965, 3596);
        -- Warrior's Pants
        -- required_level, from 1 to 6
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 2966);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2966, 3596);
        -- Warrior's Boots
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 2967);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2967, 3596);
        -- Graystone Bracers
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 6061);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6061, 3596);
        -- Warrior's Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2968);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2968, 3596);
        -- Notched Shortsword
        -- required_level, from 1 to 6
        -- dmg_min1, from 11.0 to 6
        -- dmg_max1, from 17.0 to 11
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 6, `dmg_max1` = 11 WHERE (`entry` = 727);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (727, 3596);
        -- Pioneer Tunic
        -- quality, from 2 to 1
        -- buy_price, from 1405 to 449
        -- sell_price, from 281 to 89
        -- item_level, from 14 to 11
        -- required_level, from 4 to 6
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 449, `sell_price` = 89, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 6268);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6268, 3596);
        -- Burnt Leather Belt
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 4666);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4666, 3596);
        -- Double-stitched Robes
        -- required_level, from 3 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 2613);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2613, 3596);
        -- Patchwork Bracers
        -- name, from Patchwork Cloth Bracers to Patchwork Bracers
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `name` = 'Patchwork Bracers', `required_level` = 4 WHERE (`entry` = 3373);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3373, 3596);
        -- White Linen Robe
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 6241);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6241, 3596);
        -- Disciple's Belt
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6513);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6513, 3596);
        -- Journeyman's Gloves
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 2960);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2960, 3596);
        -- Loose Chain Vest
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2648);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2648, 3596);
        -- Infantry Bracers
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6507);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6507, 3596);
        -- Feeble Sword
        -- name, from Commoner's Sword to Feeble Sword
        -- required_level, from 1 to 5
        -- dmg_min1, from 7.0 to 3
        -- dmg_max1, from 11.0 to 7
        UPDATE `item_template` SET `name` = 'Feeble Sword', `required_level` = 5, `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 1413);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1413, 3596);
        -- Strong Fishing Pole
        -- buy_price, from 901 to 22
        -- sell_price, from 180 to 4
        -- item_level, from 10 to 1
        -- dmg_min1, from 1.0 to 3
        -- dmg_max1, from 1.0 to 7
        UPDATE `item_template` SET `buy_price` = 22, `sell_price` = 4, `item_level` = 1, `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 6365);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6365, 3596);
        -- Mantle of Honor
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 3560);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3560, 3596);
        -- Wise Man's Belt
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 10 WHERE (`entry` = 4786);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4786, 3596);
        -- Night Watch Pantaloons
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 4
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 4, `stat_type2` = 4, `stat_value2` = 1 WHERE (`entry` = 2954);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2954, 3596);
        -- Cavalier's Boots
        -- required_level, from 1 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 860);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (860, 3596);
        -- Bracers of the People's Militia
        -- required_level, from 4 to 9
        UPDATE `item_template` SET `required_level` = 9 WHERE (`entry` = 710);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (710, 3596);
        -- Insulated Sage Gloves
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 20
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 20, `stat_value2` = 10 WHERE (`entry` = 3759);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3759, 3596);
        -- Ring of Forlorn Spirits
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 4 WHERE (`entry` = 2043);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2043, 3596);
        -- Uther's Strength
        -- required_level, from 25 to 30
        UPDATE `item_template` SET `required_level` = 30 WHERE (`entry` = 6757);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6757, 3596);
        -- Cloak of the Faith
        -- required_level, from 20 to 25
        UPDATE `item_template` SET `required_level` = 25 WHERE (`entry` = 2902);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2902, 3596);
        -- Twisted Chanter's Staff
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        -- dmg_min1, from 52.0 to 38
        -- dmg_max1, from 71.0 to 58
        UPDATE `item_template` SET `stat_value1` = 1, `stat_value2` = 10, `dmg_min1` = 38, `dmg_max1` = 58 WHERE (`entry` = 890);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (890, 3596);
        -- Excavation Rod
        -- required_level, from 20 to 25
        -- dmg_min1, from 38.0 to 29
        -- dmg_max1, from 57.0 to 54
        -- delay, from 3400 to 1900
        UPDATE `item_template` SET `required_level` = 25, `dmg_min1` = 29, `dmg_max1` = 54, `delay` = 1900 WHERE (`entry` = 5246);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5246, 3596);
        -- Discolored Fang
        -- name, from Mouse Tail to Discolored Fang
        UPDATE `item_template` SET `name` = 'Discolored Fang' WHERE (`entry` = 4814);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4814, 3596);
        -- Shackled Girdle
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 5592);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5592, 3596);
        -- Worn Large Shield
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 2213);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2213, 3596);
        -- Loose Chain Boots
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 2642);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2642, 3596);
        -- Ashwood Bow
        -- required_level, from 1 to 8
        -- dmg_min1, from 8.0 to 9
        -- dmg_max1, from 12.0 to 17
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 9, `dmg_max1` = 17 WHERE (`entry` = 5596);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5596, 3596);
        -- Hunting Tunic
        -- name, from Hunting Vest to Hunting Tunic
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `name` = 'Hunting Tunic', `required_level` = 10, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2973);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2973, 3596);
        -- Harvester's Pants
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 1 WHERE (`entry` = 3578);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3578, 3596);
        -- Bard's Boots
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 6557);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6557, 3596);
        -- Tanned Leather Bracers
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1844);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1844, 3596);
        -- Tanned Leather Gloves
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 844);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (844, 3596);
        -- Dwarven Magestaff
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 5
        -- dmg_min1, from 31.0 to 19
        -- dmg_max1, from 43.0 to 30
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 5, `dmg_min1` = 19, `dmg_max1` = 30 WHERE (`entry` = 2072);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2072, 3596);
        -- Warrior's Shield
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 1438);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1438, 3596);
        -- Disciple's Robe
        -- quality, from 2 to 1
        -- buy_price, from 1147 to 366
        -- sell_price, from 229 to 73
        -- item_level, from 14 to 11
        -- required_level, from 4 to 6
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 366, `sell_price` = 73, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 6512);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6512, 3596);
        -- Patchwork Shoes
        -- name, from Patchwork Cloth Boots to Patchwork Shoes
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `name` = 'Patchwork Shoes', `required_level` = 5 WHERE (`entry` = 1427);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1427, 3596);
        -- Tanned Leather Jerkin
        -- name, from Tanned Leather Vest to Tanned Leather Jerkin
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `name` = 'Tanned Leather Jerkin', `required_level` = 12 WHERE (`entry` = 846);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (846, 3596);
        -- Tanned Leather Belt
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1843);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1843, 3596);
        -- Vagabond Leggings
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 5617);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5617, 3596);
        -- Tanned Leather Boots
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 843);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (843, 3596);
        -- Bard's Gloves
        -- buy_price, from 1317 to 1145
        -- sell_price, from 263 to 229
        -- item_level, from 18 to 17
        -- required_level, from 8 to 12
        UPDATE `item_template` SET `buy_price` = 1145, `sell_price` = 229, `item_level` = 17, `required_level` = 12 WHERE (`entry` = 6554);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6554, 3596);
        -- Disciple's Vest
        -- quality, from 2 to 1
        -- buy_price, from 1234 to 394
        -- sell_price, from 246 to 78
        -- item_level, from 14 to 11
        -- required_level, from 4 to 6
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 394, `sell_price` = 78, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 6266);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6266, 3596);
        -- Willow Pants
        -- buy_price, from 2156 to 1630
        -- sell_price, from 431 to 326
        -- item_level, from 18 to 16
        -- required_level, from 8 to 11
        UPDATE `item_template` SET `buy_price` = 1630, `sell_price` = 326, `item_level` = 16, `required_level` = 11 WHERE (`entry` = 6540);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6540, 3596);
        -- Magister's Bracers
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 3643);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3643, 3596);
        -- Gustweald Cloak
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 3 WHERE (`entry` = 5610);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5610, 3596);
        -- Infantry Boots
        -- buy_price, from 240 to 335
        -- sell_price, from 48 to 67
        -- item_level, from 9 to 10
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `buy_price` = 335, `sell_price` = 67, `item_level` = 10, `required_level` = 5 WHERE (`entry` = 6506);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6506, 3596);
        -- Loose Chain Gloves
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 2645);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2645, 3596);
        -- Red Defias Mask
        -- class, from 15 to 4
        -- buy_price, from 434 to 417
        -- sell_price, from 86 to 83
        -- item_level, from 13 to 15
        UPDATE `item_template` SET `class` = 4, `buy_price` = 417, `sell_price` = 83, `item_level` = 15 WHERE (`entry` = 5106);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5106, 3596);
        -- Soldier's Girdle
        -- quality, from 2 to 1
        -- buy_price, from 1545 to 701
        -- sell_price, from 309 to 140
        -- item_level, from 18 to 16
        -- required_level, from 8 to 11
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 701, `sell_price` = 140, `item_level` = 16, `required_level` = 11 WHERE (`entry` = 6548);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6548, 3596);
        -- Runed Copper Pants
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 3473);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3473, 3596);
        -- Dwarven Hatchet
        -- required_level, from 3 to 8
        -- dmg_min1, from 17.0 to 8
        -- dmg_max1, from 27.0 to 15
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 8, `dmg_max1` = 15 WHERE (`entry` = 2073);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2073, 3596);
        -- Wooden Shield
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 2215);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2215, 3596);
        -- Handstitched Leather Belt
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 4237);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4237, 3596);
        -- Embossed Leather Pants
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 4242);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4242, 3596);
        -- Curved Dagger
        -- required_level, from 2 to 7
        -- dmg_min1, from 12.0 to 6
        -- dmg_max1, from 19.0 to 12
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 2632);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2632, 3596);
        -- Rust-covered Blunderbuss
        -- required_level, from 1 to 4
        -- dmg_min1, from 4.0 to 5
        -- dmg_max1, from 7.0 to 10
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 5, `dmg_max1` = 10 WHERE (`entry` = 2774);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2774, 3596);
        -- Carpenter's Mallet
        -- required_level, from 1 to 6
        -- dmg_min1, from 6.0 to 3
        -- dmg_max1, from 10.0 to 6
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 3, `dmg_max1` = 6 WHERE (`entry` = 1415);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1415, 3596);
        -- Tribal Bracers
        -- buy_price, from 371 to 296
        -- sell_price, from 74 to 59
        -- item_level, from 13 to 12
        -- required_level, from 3 to 7
        UPDATE `item_template` SET `buy_price` = 296, `sell_price` = 59, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 3285);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3285, 3596);
        -- Loose Chain Belt
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 2635);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2635, 3596);
        -- Embossed Leather Gloves
        -- required_level, from 3 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 4239);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4239, 3596);
        -- Bard's Tunic
        -- buy_price, from 1686 to 1720
        -- sell_price, from 337 to 344
        -- required_level, from 5 to 10
        UPDATE `item_template` SET `buy_price` = 1720, `sell_price` = 344, `required_level` = 10 WHERE (`entry` = 6552);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6552, 3596);
        -- Bard's Trousers
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6553);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6553, 3596);
        -- Willow Gloves
        -- buy_price, from 1081 to 817
        -- sell_price, from 216 to 163
        -- item_level, from 18 to 16
        -- required_level, from 8 to 11
        UPDATE `item_template` SET `buy_price` = 817, `sell_price` = 163, `item_level` = 16, `required_level` = 11 WHERE (`entry` = 6541);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6541, 3596);
        -- Chopping Axe
        -- dmg_min1, from 22.0 to 11
        -- dmg_max1, from 34.0 to 20
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 20 WHERE (`entry` = 853);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (853, 3596);
        -- Bard's Belt
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 6558);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6558, 3596);
        -- Dusty Mining Gloves
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 1 WHERE (`entry` = 2036);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2036, 3596);
        -- Brown Linen Robe
        -- required_level, from 1 to 5
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 1, `stat_value1` = 3 WHERE (`entry` = 6238);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6238, 3596);
        -- Heavy Weave Shoes
        -- name, from Heavy Weave Boots to Heavy Weave Shoes
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `name` = 'Heavy Weave Shoes', `required_level` = 12 WHERE (`entry` = 840);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (840, 3596);
        -- Heavy Weave Bracers
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 3590);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3590, 3596);
        -- Heavy Linen Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 4307);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4307, 3596);
        -- Rough Wooden Staff
        -- required_level, from 2 to 9
        -- dmg_min1, from 19.0 to 12
        -- dmg_max1, from 27.0 to 19
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 1515);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1515, 3596);
        -- Warped Leather Belt
        -- name, from Patched Leather Belt to Warped Leather Belt
        -- required_level, from 4 to 9
        UPDATE `item_template` SET `name` = 'Warped Leather Belt', `required_level` = 9 WHERE (`entry` = 1502);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1502, 3596);
        -- Frontier Britches
        -- required_level, from 7 to 12
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 1 WHERE (`entry` = 1436);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1436, 3596);
        -- Scouting Bracers
        -- buy_price, from 1520 to 1275
        -- sell_price, from 304 to 255
        -- item_level, from 23 to 21
        -- required_level, from 13 to 16
        UPDATE `item_template` SET `buy_price` = 1275, `sell_price` = 255, `item_level` = 21, `required_level` = 16 WHERE (`entry` = 6583);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6583, 3596);
        -- Hammerfist Gloves
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1 WHERE (`entry` = 5629);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5629, 3596);
        -- Scroll of Protection
        -- name, from Scroll of Spirit Armor to Scroll of Protection
        -- buy_price, from 10 to 100
        -- sell_price, from 2 to 25
        -- item_level, from 1 to 10
        UPDATE `item_template` SET `name` = 'Scroll of Protection', `buy_price` = 100, `sell_price` = 25, `item_level` = 10 WHERE (`entry` = 3013);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3013, 3596);
        -- Cracked Sledge
        -- required_level, from 1 to 6
        -- dmg_min1, from 14.0 to 10
        -- dmg_max1, from 20.0 to 15
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 10, `dmg_max1` = 15 WHERE (`entry` = 1414);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1414, 3596);
        -- Journeyman's Vest
        -- required_level, from 1 to 6
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 1, `stat_value1` = 2 WHERE (`entry` = 2957);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2957, 3596);
        -- Mageroyal
        -- name, from Common Magebloom to Mageroyal
        UPDATE `item_template` SET `name` = 'Mageroyal' WHERE (`entry` = 785);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (785, 3596);
        -- Skinning Knife
        -- buy_price, from 54 to 82
        -- sell_price, from 10 to 16
        -- item_level, from 3 to 4
        -- dmg_min1, from 5.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `buy_price` = 82, `sell_price` = 16, `item_level` = 4, `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 7005);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7005, 3596);
        -- Mining Pick
        -- buy_price, from 121 to 81
        -- sell_price, from 24 to 16
        -- item_level, from 5 to 4
        -- required_level, from 2 to 1
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 7.0 to 4
        UPDATE `item_template` SET `buy_price` = 81, `sell_price` = 16, `item_level` = 4, `required_level` = 1, `dmg_min1` = 2, `dmg_max1` = 4 WHERE (`entry` = 2901);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2901, 3596);
        -- Double Link Mail Tunic
        -- stat_value2, from 0 to 6
        UPDATE `item_template` SET `stat_value2` = 6 WHERE (`entry` = 1717);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1717, 3596);
        -- Crusader Belt
        -- required_level, from 23 to 28
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 28, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 3758);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3758, 3596);
        -- Stromgarde Cavalry Leggings
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 1
        -- stat_value3, from 0 to 30
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 1, `stat_value3` = 30 WHERE (`entry` = 4741);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4741, 3596);
        -- Golden Scale Bracers
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 20
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 20 WHERE (`entry` = 6040);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6040, 3596);
        -- Ring of Pure Silver
        -- required_level, from 21 to 26
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 26, `stat_value2` = 10 WHERE (`entry` = 1116);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1116, 3596);
        -- Captain's Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 7492);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7492, 3596);
        -- Olmann Sewar
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 4116);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4116, 3596);
        -- Aegis of the Scarlet Commander
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7726);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7726, 3596);
        -- Cracked Shortbow
        -- required_level, from 1 to 5
        -- dmg_min1, from 4.0 to 5
        -- dmg_max1, from 7.0 to 10
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 5, `dmg_max1` = 10 WHERE (`entry` = 2773);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2773, 3596);
        -- Inscribed Leather Spaulders
        -- buy_price, from 2468 to 2184
        -- sell_price, from 493 to 436
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        UPDATE `item_template` SET `buy_price` = 2184, `sell_price` = 436, `item_level` = 22, `required_level` = 17 WHERE (`entry` = 4700);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4700, 3596);
        -- Toughened Leather Armor
        -- required_level, from 14 to 19
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 2 WHERE (`entry` = 2314);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2314, 3596);
        -- Dark Leather Belt
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1 WHERE (`entry` = 4249);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4249, 3596);
        -- Dervish Bracers
        -- buy_price, from 3657 to 3972
        -- sell_price, from 731 to 794
        -- required_level, from 16 to 21
        UPDATE `item_template` SET `buy_price` = 3972, `sell_price` = 794, `required_level` = 21 WHERE (`entry` = 6602);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6602, 3596);
        -- Windsong Gloves
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 5630);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5630, 3596);
        -- Loose Chain Pants
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 2646);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2646, 3596);
        -- Loose Chain Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2643);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2643, 3596);
        -- Berserker Helm
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7719);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7719, 3596);
        -- Mail Combat Armor
        -- required_level, from 25 to 30
        -- stat_value3, from 0 to 2
        UPDATE `item_template` SET `required_level` = 30, `stat_value3` = 2 WHERE (`entry` = 4074);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4074, 3596);
        -- Green Iron Leggings
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 2 WHERE (`entry` = 3842);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3842, 3596);
        -- Augmented Chain Boots
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 2 WHERE (`entry` = 2420);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2420, 3596);
        -- Augmented Chain Bracers
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 15
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 15 WHERE (`entry` = 2421);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2421, 3596);
        -- Green Iron Gauntlets
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3 WHERE (`entry` = 3485);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3485, 3596);
        -- Ring of Iron Will
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 1319);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1319, 3596);
        -- Knight's Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 7460);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7460, 3596);
        -- Gold Lion Shield
        -- required_level, from 24 to 29
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- stat_value3, from 0 to 1
        UPDATE `item_template` SET `required_level` = 29, `stat_type1` = 5, `stat_value1` = 1, `stat_value3` = 1 WHERE (`entry` = 2916);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2916, 3596);
        -- Pendant of Myzrael
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 4 WHERE (`entry` = 4614);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4614, 3596);
        -- Silk Mantle of Gamn
        -- required_level, from 18 to 23
        UPDATE `item_template` SET `required_level` = 23 WHERE (`entry` = 2913);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2913, 3596);
        -- Flameweave Boots
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 6
        -- stat_type2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 6, `stat_type2` = 1 WHERE (`entry` = 3065);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3065, 3596);
        -- Frostweave Bracers
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 8
        -- stat_value2, from 0 to 9
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 8, `stat_value2` = 9 WHERE (`entry` = 4036);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4036, 3596);
        -- Darkweave Gloves
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 31, `stat_value1` = 4 WHERE (`entry` = 4040);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4040, 3596);
        -- Hand of Righteousness
        -- bonding, from 1 to 2
        -- material, from 2 to 1
        UPDATE `item_template` SET `bonding` = 2, `material` = 1 WHERE (`entry` = 7721);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7721, 3596);
        -- Eye of Paleth
        -- required_level, from 21 to 26
        UPDATE `item_template` SET `required_level` = 26 WHERE (`entry` = 2943);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2943, 3596);
        -- Consecrated Wand
        -- required_level, from 20 to 25
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 42.0 to 34
        -- dmg_type1, from 3 to 1
        -- delay, from 2500 to 1200
        UPDATE `item_template` SET `required_level` = 25, `dmg_min1` = 18, `dmg_max1` = 34, `dmg_type1` = 1, `delay` = 1200 WHERE (`entry` = 5244);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5244, 3596);
        -- Simple Dress
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 6786);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6786, 3596);
        -- Wood Chopper
        -- required_level, from 1 to 4
        -- dmg_min1, from 19.0 to 11
        -- dmg_max1, from 26.0 to 18
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 11, `dmg_max1` = 18 WHERE (`entry` = 3189);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3189, 3596);
        -- Haggard's Mace
        -- required_level, from 5 to 10
        -- dmg_min1, from 22.0 to 10
        -- dmg_max1, from 33.0 to 20
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 10, `dmg_max1` = 20, `material` = 1 WHERE (`entry` = 6983);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6983, 3596);
        -- Belt of the People's Militia
        -- required_level, from 4 to 9
        UPDATE `item_template` SET `required_level` = 9 WHERE (`entry` = 1154);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1154, 3596);
        -- Blackrock Boots
        -- name, from Blackrock Chain Boots to Blackrock Boots
        -- required_level, from 9 to 14
        UPDATE `item_template` SET `name` = 'Blackrock Boots', `required_level` = 14 WHERE (`entry` = 1446);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1446, 3596);
        -- Veteran Bracers
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 3213);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3213, 3596);
        -- Bridgeworker's Gloves
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1 WHERE (`entry` = 1303);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1303, 3596);
        -- Fighter Broadsword
        -- dmg_min1, from 23.0 to 11
        -- dmg_max1, from 35.0 to 22
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 22 WHERE (`entry` = 2027);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2027, 3596);
        -- Glowing Green Talisman
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3, `stat_value2` = 3 WHERE (`entry` = 5002);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5002, 3596);
        -- Bone-studded Leather
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- stat_value3, from 0 to 10
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1, `stat_value2` = 1, `stat_value3` = 10 WHERE (`entry` = 3431);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3431, 3596);
        -- Captain Sander's Sash
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 3344);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3344, 3596);
        -- Smelting Pants
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 10 WHERE (`entry` = 5199);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5199, 3596);
        -- Black Whelp Boots
        -- required_level, from 8 to 13
        -- stat_type1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 6 WHERE (`entry` = 6092);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6092, 3596);
        -- Ivy Cuffs
        -- buy_price, from 523 to 363
        -- sell_price, from 104 to 72
        -- item_level, from 15 to 13
        -- required_level, from 5 to 8
        UPDATE `item_template` SET `buy_price` = 363, `sell_price` = 72, `item_level` = 13, `required_level` = 8 WHERE (`entry` = 5612);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5612, 3596);
        -- Woodworking Gloves
        -- required_level, from 8 to 13
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 1945);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1945, 3596);
        -- Minor Channeling Ring
        -- buy_price, from 500 to 7500
        -- sell_price, from 125 to 1875
        -- required_level, from 14 to 19
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 7500, `sell_price` = 1875, `required_level` = 19, `stat_value1` = 1 WHERE (`entry` = 1449);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1449, 3596);
        -- Cape of the Brotherhood
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- material, from 7 to 8
        UPDATE `item_template` SET `stat_value1` = 1, `stat_value2` = 1, `material` = 8 WHERE (`entry` = 5193);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5193, 3596);
        -- Staff of Horrors
        -- required_level, from 13 to 18
        -- dmg_min1, from 49.0 to 37
        -- dmg_max1, from 68.0 to 56
        UPDATE `item_template` SET `required_level` = 18, `dmg_min1` = 37, `dmg_max1` = 56 WHERE (`entry` = 880);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (880, 3596);
        -- Magister's Robe
        -- buy_price, from 1348 to 1355
        -- sell_price, from 269 to 271
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 1355, `sell_price` = 271, `required_level` = 10, `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 6528);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6528, 3596);
        -- Magister's Boots
        -- name, from Magister's Shoes to Magister's Boots
        -- required_level, from 5 to 10
        UPDATE `item_template` SET `name` = 'Magister''s Boots', `required_level` = 10 WHERE (`entry` = 2971);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2971, 3596);
        -- Patched Leather Shoulderpads
        -- name, from Rawhide Shoulderpads to Patched Leather Shoulderpads
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `name` = 'Patched Leather Shoulderpads', `required_level` = 15 WHERE (`entry` = 1793);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1793, 3596);
        -- Cured Leather Boots
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 238);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (238, 3596);
        -- Magician Staff
        -- dmg_min1, from 35.0 to 24
        -- dmg_max1, from 48.0 to 36
        UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 36 WHERE (`entry` = 2030);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2030, 3596);
        -- Stormwind Guard Leggings
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 6 WHERE (`entry` = 6084);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6084, 3596);
        -- Stormwind Chain Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1360);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1360, 3596);
        -- Well-used Sword
        -- required_level, from 1 to 7
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 20.0 to 12
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 1008);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1008, 3596);
        -- Red Linen Sash
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 983);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (983, 3596);
        -- Stone Buckler
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2900);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2900, 3596);
        -- Reinforced Chain Shoulderpads
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `required_level` = 22 WHERE (`entry` = 1760);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1760, 3596);
        -- Glinting Scale Breastplate
        -- buy_price, from 11654 to 9631
        -- sell_price, from 2330 to 1926
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 20
        UPDATE `item_template` SET `buy_price` = 9631, `sell_price` = 1926, `item_level` = 26, `required_level` = 21, `stat_value1` = 2, `stat_type2` = 1, `stat_value2` = 20 WHERE (`entry` = 3049);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3049, 3596);
        -- Veteran Girdle
        -- required_level, from 7 to 12
        -- stat_value1, from 0 to 7
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 7 WHERE (`entry` = 4678);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4678, 3596);
        -- Mighty Chain Pants
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 3 WHERE (`entry` = 4800);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4800, 3596);
        -- Burnished Chain Boots
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 1, `stat_value1` = 10 WHERE (`entry` = 2991);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2991, 3596);
        -- Defender Bracers
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6574);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6574, 3596);
        -- Night Watch Gauntlets
        -- required_level, from 12 to 17
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `required_level` = 17, `stat_type1` = 1, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 3559);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3559, 3596);
        -- Glinting Scale Cloak
        -- buy_price, from 8004 to 6615
        -- sell_price, from 1600 to 1323
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        -- stat_value2, from 0 to 5
        -- material, from 7 to 5
        UPDATE `item_template` SET `buy_price` = 6615, `sell_price` = 1323, `item_level` = 26, `required_level` = 21, `stat_value2` = 5, `material` = 5 WHERE (`entry` = 4706);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4706, 3596);
        -- Burning War Axe
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 5
        -- dmg_min1, from 58.0 to 50
        -- dmg_max1, from 79.0 to 75
        UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 5, `dmg_min1` = 50, `dmg_max1` = 75 WHERE (`entry` = 2299);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2299, 3596);
        -- Scouting Tunic
        -- buy_price, from 4486 to 4908
        -- sell_price, from 897 to 981
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `buy_price` = 4908, `sell_price` = 981, `required_level` = 17 WHERE (`entry` = 6584);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6584, 3596);
        -- Smith's Trousers
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 3, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 1310);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1310, 3596);
        -- Agile Boots
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1 WHERE (`entry` = 4788);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4788, 3596);
        -- Hunting Bracers
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 3207);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3207, 3596);
        -- Pearl-handled Dagger
        -- name, from Pearl Handled Dagger to Pearl-handled Dagger
        -- required_level, from 12 to 17
        -- dmg_min1, from 21.0 to 11
        -- dmg_max1, from 32.0 to 21
        UPDATE `item_template` SET `name` = 'Pearl-handled Dagger', `required_level` = 17, `dmg_min1` = 11, `dmg_max1` = 21 WHERE (`entry` = 5540);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5540, 3596);
        -- Hook Dagger
        -- name, from Wavy Blladed Knife to Hook Dagger
        -- display_id, from 6469 to 6468
        -- required_level, from 8 to 13
        -- dmg_min1, from 16.0 to 8
        -- dmg_max1, from 24.0 to 15
        UPDATE `item_template` SET `name` = 'Hook Dagger', `display_id` = 6468, `required_level` = 13, `dmg_min1` = 8, `dmg_max1` = 15 WHERE (`entry` = 3184);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3184, 3596);
        -- Hillman's Shoulders
        -- required_level, from 16 to 21
        UPDATE `item_template` SET `required_level` = 21 WHERE (`entry` = 4251);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4251, 3596);
        -- Snapbrook Armor
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 4
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 4, `stat_type2` = 4, `stat_value2` = 2 WHERE (`entry` = 5814);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5814, 3596);
        -- Stalking Pants
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3 WHERE (`entry` = 4831);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4831, 3596);
        -- Mariner Boots
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1 WHERE (`entry` = 2949);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2949, 3596);
        -- Cuirboulli Bracers
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `required_level` = 22 WHERE (`entry` = 2144);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2144, 3596);
        -- Viridian Band
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        UPDATE `item_template` SET `item_level` = 26, `required_level` = 21 WHERE (`entry` = 6589);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6589, 3596);
        -- Fenrus' Hide
        -- buy_price, from 3291 to 3280
        -- sell_price, from 658 to 656
        -- required_level, from 16 to 21
        -- material, from 7 to 8
        UPDATE `item_template` SET `buy_price` = 3280, `sell_price` = 656, `required_level` = 21, `material` = 8 WHERE (`entry` = 6340);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6340, 3596);
        -- Deadly Bronze Poniard
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 23.0 to 14
        -- dmg_max1, from 36.0 to 26
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1, `dmg_min1` = 14, `dmg_max1` = 26 WHERE (`entry` = 3490);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3490, 3596);
        -- Haggard's Sword
        -- required_level, from 5 to 10
        -- dmg_min1, from 20.0 to 9
        -- dmg_max1, from 30.0 to 18
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 9, `dmg_max1` = 18 WHERE (`entry` = 6985);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6985, 3596);
        -- Stinging Viper
        -- dmg_min1, from 36.0 to 19
        -- dmg_max1, from 54.0 to 36
        -- material, from 2 to 1
        UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 36, `material` = 1 WHERE (`entry` = 6472);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6472, 3596);
        -- Inscribed Leather Belt
        -- required_level, from 12 to 17
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 10 WHERE (`entry` = 6379);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6379, 3596);
        -- Dark Leather Pants
        -- required_level, from 13 to 18
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 18, `stat_type1` = 3, `stat_value1` = 2, `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 5961);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5961, 3596);
        -- Hillman's Leather Gloves
        -- required_level, from 19 to 24
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3 WHERE (`entry` = 4247);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4247, 3596);
        -- Black Whelp Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 7283);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7283, 3596);
        -- Staff of Westfall
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 3
        -- dmg_min1, from 46.0 to 36
        -- dmg_max1, from 62.0 to 55
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 3, `dmg_min1` = 36, `dmg_max1` = 55 WHERE (`entry` = 2042);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2042, 3596);
        -- Brass-studded Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1182);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1182, 3596);
        -- Bent Staff
        -- dmg_min1, from 11.0 to 5
        -- dmg_max1, from 16.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 8 WHERE (`entry` = 35);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (35, 3596);
        -- Infantry Belt
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 6509);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6509, 3596);
        -- Militia Dagger
        -- dmg_min1, from 5.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 2224);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2224, 3596);
        -- Ivy-weave Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2326);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2326, 3596);
        -- Gnarled Short Staff
        -- required_level, from 1 to 5
        -- dmg_min1, from 17.0 to 11
        -- dmg_max1, from 24.0 to 17
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 1010);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1010, 3596);
        -- Militia Quarterstaff
        -- dmg_min1, from 12.0 to 7
        -- dmg_max1, from 17.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 1159);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1159, 3596);
        -- Durable Chain Shoulders
        -- buy_price, from 2433 to 3122
        -- sell_price, from 486 to 624
        -- item_level, from 22 to 24
        -- required_level, from 12 to 19
        UPDATE `item_template` SET `buy_price` = 3122, `sell_price` = 624, `item_level` = 24, `required_level` = 19 WHERE (`entry` = 6189);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6189, 3596);
        -- Veteran Armor
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 1 WHERE (`entry` = 2977);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2977, 3596);
        -- Burnished Chain Leggings
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 2990);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2990, 3596);
        -- Soldier's Boots
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6551);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6551, 3596);
        -- Ironwrought Bracers
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6177);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6177, 3596);
        -- Timberland Cape
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 7739);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7739, 3596);
        -- Shortsword of Vengeance
        -- dmg_min1, from 39.0 to 22
        -- dmg_max1, from 48.0 to 42
        -- spellid_1, from 13519 to 598
        UPDATE `item_template` SET `dmg_min1` = 22, `dmg_max1` = 42, `spellid_1` = 598 WHERE (`entry` = 754);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (754, 3596);
        -- Soldier's Leggings
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6546);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6546, 3596);
        -- Burnt Hide Bracers
        -- required_level, from 1 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 3158);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3158, 3596);
        -- Oak Mallet
        -- required_level, from 3 to 8
        -- dmg_min1, from 36.0 to 22
        -- dmg_max1, from 49.0 to 33
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 22, `dmg_max1` = 33 WHERE (`entry` = 3193);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3193, 3596);
        -- Herod's Shoulder
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7718);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7718, 3596);
        -- Green Iron Hauberk
        -- stat_value1, from 0 to 8
        UPDATE `item_template` SET `stat_value1` = 8 WHERE (`entry` = 3844);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3844, 3596);
        -- Inscribed Gold Ring
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 5 WHERE (`entry` = 5010);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5010, 3596);
        -- Deadly Throwing Axe
        -- dmg_min1, from 14.0 to 7
        -- dmg_max1, from 22.0 to 15
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 15 WHERE (`entry` = 3137);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3137, 3596);
        -- Everglow Lantern
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 10
        -- spellid_1, from 635 to 647
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 1, `stat_value1` = 10, `spellid_1` = 647 WHERE (`entry` = 5323);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5323, 3596);
        -- Mark of the Kirin Tor
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 7
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 7 WHERE (`entry` = 5004);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5004, 3596);
        -- Frostweave Sash
        -- required_level, from 21 to 26
        UPDATE `item_template` SET `required_level` = 26 WHERE (`entry` = 4714);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4714, 3596);
        -- Spidersilk Boots
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 1
        -- bonding, from 2 to 1
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 1, `bonding` = 1 WHERE (`entry` = 4320);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4320, 3596);
        -- Arcane Runed Bracers
        -- required_level, from 29 to 34
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 34, `stat_value2` = 10 WHERE (`entry` = 4744);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4744, 3596);
        -- Stout Battlehammer
        -- required_level, from 13 to 18
        -- dmg_min1, from 28.0 to 16
        -- dmg_max1, from 43.0 to 30
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 18, `dmg_min1` = 16, `dmg_max1` = 30, `material` = 1 WHERE (`entry` = 789);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (789, 3596);
        -- Strength of Will
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3 WHERE (`entry` = 4837);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4837, 3596);
        -- Wand of Eventide
        -- required_level, from 22 to 27
        -- dmg_min1, from 30.0 to 21
        -- dmg_max1, from 46.0 to 40
        -- dmg_type1, from 6 to 5
        -- delay, from 2600 to 1300
        UPDATE `item_template` SET `required_level` = 27, `dmg_min1` = 21, `dmg_max1` = 40, `dmg_type1` = 5, `delay` = 1300 WHERE (`entry` = 5214);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5214, 3596);
        -- Copper Chain Pants
        -- required_level, from 1 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 2852);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2852, 3596);
        -- Well-stitched Robe
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1171);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1171, 3596);
        -- Long Bayonet
        -- required_level, from 1 to 7
        -- dmg_min1, from 10.0 to 5
        -- dmg_max1, from 16.0 to 10
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 5, `dmg_max1` = 10 WHERE (`entry` = 4840);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4840, 3596);
        -- Polished Jazeraint Armor
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 3
        -- stat_value4, from 0 to 30
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 3, `stat_value4` = 30 WHERE (`entry` = 1715);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1715, 3596);
        -- Chief Brigadier Bracers
        -- required_level, from 30 to 35
        UPDATE `item_template` SET `required_level` = 35 WHERE (`entry` = 6413);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6413, 3596);
        -- Divine Gauntlets
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7724);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7724, 3596);
        -- Crest of Darkshire
        -- buy_price, from 22081 to 23986
        -- sell_price, from 4416 to 4797
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 23986, `sell_price` = 4797, `required_level` = 30, `stat_value1` = 4 WHERE (`entry` = 6223);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6223, 3596);
        -- Soldier Cap
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 3, `stat_value2` = 4 WHERE (`entry` = 1282);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1282, 3596);
        -- Burnished Chain Spaulders
        -- buy_price, from 2911 to 2576
        -- sell_price, from 582 to 515
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        UPDATE `item_template` SET `buy_price` = 2576, `sell_price` = 515, `item_level` = 22, `required_level` = 17 WHERE (`entry` = 4694);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4694, 3596);
        -- Malleable Chain Leggings
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 2
        -- stat_value3, from 0 to 10
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 1, `stat_value2` = 2, `stat_value3` = 10 WHERE (`entry` = 2545);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2545, 3596);
        -- Gold Militia Boots
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1 WHERE (`entry` = 2910);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2910, 3596);
        -- Sentry Cloak
        -- stat_value1, from 0 to 1
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 1
        -- material, from 7 to 5
        UPDATE `item_template` SET `stat_value1` = 1, `stat_type2` = 4, `stat_value2` = 1, `material` = 5 WHERE (`entry` = 2059);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2059, 3596);
        -- Barreling Reaper
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 29.0 to 19
        -- dmg_max1, from 45.0 to 37
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `dmg_min1` = 19, `dmg_max1` = 37 WHERE (`entry` = 6194);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6194, 3596);
        -- Battleforge Shield
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 6599);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6599, 3596);
        -- Laced Mail Shoulderpads
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 1744);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1744, 3596);
        -- Defender Tunic
        -- required_level, from 11 to 16
        UPDATE `item_template` SET `required_level` = 16 WHERE (`entry` = 6580);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6580, 3596);
        -- Tunneler's Boots
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 1 WHERE (`entry` = 2037);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2037, 3596);
        -- Stonemason Cloak
        -- required_level, from 8 to 13
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 7
        -- material, from 7 to 8
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 1, `stat_value1` = 7, `material` = 8 WHERE (`entry` = 1930);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1930, 3596);
        -- Lucine Longsword
        -- required_level, from 15 to 20
        -- dmg_min1, from 33.0 to 19
        -- dmg_max1, from 50.0 to 36
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 19, `dmg_max1` = 36, `bonding` = 2 WHERE (`entry` = 3400);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3400, 3596);
        -- Dwarven Defender
        -- buy_price, from 2854 to 3066
        -- sell_price, from 570 to 613
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 8
        UPDATE `item_template` SET `buy_price` = 3066, `sell_price` = 613, `required_level` = 12, `stat_type1` = 1, `stat_value1` = 8 WHERE (`entry` = 6187);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6187, 3596);
        -- Dwarven Fishing Pole
        -- required_level, from 9 to 14
        -- dmg_min1, from 12.0 to 14
        -- dmg_max1, from 18.0 to 27
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 14, `dmg_max1` = 27 WHERE (`entry` = 3567);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3567, 3596);
        -- Lion-stamped Gloves
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 1359);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1359, 3596);
        -- Weather-worn Boots
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1173);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1173, 3596);
        -- Urchin's Pants
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2238);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2238, 3596);
        -- Old Blanchy's Blanket
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2165);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2165, 3596);
        -- Necklace of Calisea
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 3
        -- stat_value3, from 0 to 4
        UPDATE `item_template` SET `stat_value1` = 4, `stat_value2` = 3, `stat_value3` = 4 WHERE (`entry` = 1714);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1714, 3596);
        -- Augmented Chain Belt
        -- required_level, from 27 to 32
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 32, `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2419);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2419, 3596);
        -- Mail Combat Boots
        -- required_level, from 25 to 30
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 30, `stat_type1` = 7, `stat_value1` = 4 WHERE (`entry` = 4076);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4076, 3596);
        -- Chief Brigadier Shield
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 5 WHERE (`entry` = 4068);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4068, 3596);
        -- Blackrock Pauldrons
        -- name, from Blackrock Chain Pauldrons to Blackrock Pauldrons
        -- required_level, from 13 to 18
        UPDATE `item_template` SET `name` = 'Blackrock Pauldrons', `required_level` = 18 WHERE (`entry` = 1445);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1445, 3596);
        -- Chestplate of Kor
        -- buy_price, from 6874 to 7094
        -- sell_price, from 1374 to 1418
        -- required_level, from 14 to 19
        -- stat_value1, from 0 to 1
        -- stat_value3, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 7094, `sell_price` = 1418, `required_level` = 19, `stat_value1` = 1, `stat_value3` = 1 WHERE (`entry` = 6721);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6721, 3596);
        -- Silver Defias Belt
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 832);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (832, 3596);
        -- Blackrock Gauntlets
        -- name, from Blackrock Chain Gauntlets to Blackrock Gauntlets
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `name` = 'Blackrock Gauntlets', `required_level` = 15, `stat_value1` = 1 WHERE (`entry` = 1448);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1448, 3596);
        -- Clergy Ring
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 5622);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5622, 3596);
        -- Curve-bladed Ripper
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 43.0 to 34
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 34 WHERE (`entry` = 2815);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2815, 3596);
        -- Furen's Favor
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 6970);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6970, 3596);
        -- Soft Leather Tunic
        -- required_level, from 2 to 7
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 2817);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2817, 3596);
        -- Craftsman's Dagger
        -- required_level, from 3 to 8
        -- dmg_min1, from 15.0 to 7
        -- dmg_max1, from 23.0 to 13
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 7, `dmg_max1` = 13 WHERE (`entry` = 2218);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2218, 3596);
        -- Harvester's Robe
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 1561);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1561, 3596);
        -- Foreman Belt
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 3217);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3217, 3596);
        -- Seer's Pants
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 2982);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2982, 3596);
        -- Seer's Gloves
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 11
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 11 WHERE (`entry` = 2984);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2984, 3596);
        -- Seer's Cape
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6378);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6378, 3596);
        -- Archer's Longbow
        -- required_level, from 14 to 19
        -- dmg_min1, from 14.0 to 19
        -- dmg_max1, from 21.0 to 36
        UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 19, `dmg_max1` = 36 WHERE (`entry` = 3039);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3039, 3596);
        -- Brass Collar
        -- description, from Princess - First Prize to "Princess - First Prize"
        UPDATE `item_template` SET `description` = 'Princess - First Prize' WHERE (`entry` = 1006);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1006, 3596);
        -- Bishop's Miter
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7720);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7720, 3596);
        -- Triune Amulet
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7722);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7722, 3596);
        -- Flameweave Bracers
        -- required_level, from 16 to 21
        UPDATE `item_template` SET `required_level` = 21 WHERE (`entry` = 3647);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3647, 3596);
        -- Long Silken Cloak
        -- required_level, from 27 to 32
        UPDATE `item_template` SET `required_level` = 32 WHERE (`entry` = 4326);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4326, 3596);
        -- Rod of Sorrow
        -- required_level, from 29 to 34
        -- dmg_min1, from 54.0 to 38
        -- dmg_max1, from 82.0 to 72
        -- delay, from 3400 to 1900
        UPDATE `item_template` SET `required_level` = 34, `dmg_min1` = 38, `dmg_max1` = 72, `delay` = 1900 WHERE (`entry` = 5247);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5247, 3596);
        -- Darktide Cape
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4114);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4114, 3596);
        -- Black Whelp Gloves
        -- required_level, from 8 to 13
        UPDATE `item_template` SET `required_level` = 13 WHERE (`entry` = 1302);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1302, 3596);
        -- Daryl's Hunting Rifle
        -- buy_price, from 3424 to 2977
        -- sell_price, from 684 to 595
        -- item_level, from 17 to 16
        -- required_level, from 7 to 11
        -- dmg_min1, from 15.0 to 16
        -- dmg_max1, from 23.0 to 30
        UPDATE `item_template` SET `buy_price` = 2977, `sell_price` = 595, `item_level` = 16, `required_level` = 11, `dmg_min1` = 16, `dmg_max1` = 30 WHERE (`entry` = 2904);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2904, 3596);
        -- Stone Gnoll Hammer
        -- required_level, from 1 to 6
        -- dmg_min1, from 11.0 to 6
        -- dmg_max1, from 17.0 to 11
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 6, `dmg_max1` = 11, `material` = 1 WHERE (`entry` = 781);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (781, 3596);
        -- Priest's Mace
        -- required_level, from 2 to 7
        -- dmg_min1, from 16.0 to 7
        -- dmg_max1, from 24.0 to 15
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 7, `dmg_max1` = 15, `material` = 1 WHERE (`entry` = 2075);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2075, 3596);
        -- Balanced Fighting Stick
        -- buy_price, from 2928 to 3009
        -- sell_price, from 585 to 601
        -- required_level, from 3 to 8
        -- dmg_min1, from 22.0 to 14
        -- dmg_max1, from 31.0 to 21
        UPDATE `item_template` SET `buy_price` = 3009, `sell_price` = 601, `required_level` = 8, `dmg_min1` = 14, `dmg_max1` = 21 WHERE (`entry` = 6215);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6215, 3596);
        -- Rough Bronze Shoulders
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 3480);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3480, 3596);
        -- Ironforge Breastplate
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 6731);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6731, 3596);
        -- Soldier's Cloak
        -- quality, from 2 to 1
        -- buy_price, from 2033 to 1219
        -- sell_price, from 406 to 243
        -- required_level, from 7 to 12
        -- material, from 7 to 5
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 1219, `sell_price` = 243, `required_level` = 12, `material` = 5 WHERE (`entry` = 6549);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6549, 3596);
        -- Burnished Shield
        -- required_level, from 11 to 16
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 16, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 3655);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3655, 3596);
        -- Battleforge Pauldrons
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `required_level` = 22 WHERE (`entry` = 6597);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6597, 3596);
        -- Battleforge Armor
        -- required_level, from 16 to 21
        UPDATE `item_template` SET `required_level` = 21 WHERE (`entry` = 6592);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6592, 3596);
        -- Polished Scale Belt
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `required_level` = 22 WHERE (`entry` = 2148);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2148, 3596);
        -- Silvered Bronze Boots
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2 WHERE (`entry` = 3482);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3482, 3596);
        -- Patterned Bronze Bracers
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 2868);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2868, 3596);
        -- Silvered Bronze Gauntlets
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 2 WHERE (`entry` = 3483);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3483, 3596);
        -- Rusty Hatchet
        -- required_level, from 1 to 6
        -- dmg_min1, from 8.0 to 4
        -- dmg_max1, from 12.0 to 8
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 4, `dmg_max1` = 8 WHERE (`entry` = 1416);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1416, 3596);
        -- Militia Buckler
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2249);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2249, 3596);
        -- Sage's Mantle
        -- buy_price, from 5664 to 4682
        -- sell_price, from 1132 to 936
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        UPDATE `item_template` SET `buy_price` = 4682, `sell_price` = 936, `item_level` = 26, `required_level` = 21 WHERE (`entry` = 6617);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6617, 3596);
        -- Seer's Padded Armor
        -- buy_price, from 4055 to 3885
        -- sell_price, from 811 to 777
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 3885, `sell_price` = 777, `item_level` = 22, `required_level` = 17, `stat_value1` = 2 WHERE (`entry` = 6561);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6561, 3596);
        -- Flameweave Belt
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 6 WHERE (`entry` = 4708);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4708, 3596);
        -- Bluegill Sandals
        -- required_level, from 11 to 16
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `required_level` = 16, `stat_value2` = 5 WHERE (`entry` = 1560);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1560, 3596);
        -- Sage's Bracers
        -- buy_price, from 3540 to 3384
        -- sell_price, from 708 to 676
        -- item_level, from 28 to 27
        -- required_level, from 18 to 22
        UPDATE `item_template` SET `buy_price` = 3384, `sell_price` = 676, `item_level` = 27, `required_level` = 22 WHERE (`entry` = 6613);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6613, 3596);
        -- Flameweave Gloves
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2 WHERE (`entry` = 3066);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3066, 3596);
        -- Phytoblade
        -- required_level, from 15 to 20
        -- dmg_min1, from 36.0 to 21
        -- dmg_max1, from 55.0 to 41
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 21, `dmg_max1` = 41 WHERE (`entry` = 2263);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2263, 3596);
        -- Red Linen Robe
        -- required_level, from 1 to 5
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 3 WHERE (`entry` = 2572);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2572, 3596);
        -- Linen Boots
        -- required_level, from 1 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 2569);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2569, 3596);
        -- Green Linen Bracers
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 4308);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4308, 3596);
        -- Reinforced Linen Cape
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 2580);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2580, 3596);
        -- Canvas Shoulderpads
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 1769);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1769, 3596);
        -- Chainmail Armor
        -- name, from Chainmail Vest to Chainmail Armor
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `name` = 'Chainmail Armor', `required_level` = 12 WHERE (`entry` = 847);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (847, 3596);
        -- Scouting Belt
        -- buy_price, from 2535 to 2111
        -- sell_price, from 507 to 422
        -- item_level, from 23 to 21
        -- required_level, from 13 to 16
        UPDATE `item_template` SET `buy_price` = 2111, `sell_price` = 422, `item_level` = 21, `required_level` = 16 WHERE (`entry` = 6581);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6581, 3596);
        -- Greaves of the People's Militia
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 5944);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5944, 3596);
        -- Flameweave Robe
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3 WHERE (`entry` = 3069);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3069, 3596);
        -- Lucky Trousers
        -- required_level, from 7 to 12
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 10 WHERE (`entry` = 1832);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1832, 3596);
        -- Seer's Boots
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1 WHERE (`entry` = 2983);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2983, 3596);
        -- Willow Bracers
        -- buy_price, from 535 to 583
        -- sell_price, from 107 to 116
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `buy_price` = 583, `sell_price` = 116, `required_level` = 12 WHERE (`entry` = 6543);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6543, 3596);
        -- Icicle Rod
        -- required_level, from 15 to 20
        -- dmg_min1, from 37.0 to 46
        -- dmg_max1, from 50.0 to 69
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 46, `dmg_max1` = 69 WHERE (`entry` = 2950);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2950, 3596);
        -- Opaque Wand
        -- name, from Twilight Wand to Opaque Wand
        -- required_level, from 9 to 14
        -- dmg_min1, from 22.0 to 13
        -- dmg_max1, from 34.0 to 24
        -- delay, from 2700 to 1400
        UPDATE `item_template` SET `name` = 'Opaque Wand', `required_level` = 14, `dmg_min1` = 13, `dmg_max1` = 24, `delay` = 1400 WHERE (`entry` = 5207);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5207, 3596);
        -- Magister's Pants
        -- required_level, from 6 to 11
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 1 WHERE (`entry` = 2970);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2970, 3596);
        -- Cookie's Stirring Rod
        -- dmg_min1, from 20.0 to 13
        -- dmg_max1, from 31.0 to 25
        -- dmg_type1, from 6 to 2
        -- delay, from 2300 to 1300
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 25, `dmg_type1` = 2, `delay` = 1300, `bonding` = 2 WHERE (`entry` = 5198);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5198, 3596);
        -- Footman Tunic
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 6085);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6085, 3596);
        -- Forest Leather Chestpiece
        -- name, from Forest Leather Breastplate to Forest Leather Chestpiece
        -- display_id, from 11579 to 9056
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `name` = 'Forest Leather Chestpiece', `display_id` = 9056, `required_level` = 20, `stat_value1` = 1, `stat_value2` = 2 WHERE (`entry` = 3055);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3055, 3596);
        -- Dervish Leggings
        -- buy_price, from 6474 to 6656
        -- sell_price, from 1294 to 1331
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `buy_price` = 6656, `sell_price` = 1331, `required_level` = 20 WHERE (`entry` = 6607);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6607, 3596);
        -- Forest Leather Bracers
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `required_level` = 22 WHERE (`entry` = 3202);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3202, 3596);
        -- Dervish Cape
        -- buy_price, from 6639 to 6601
        -- sell_price, from 1327 to 1320
        -- item_level, from 28 to 27
        -- required_level, from 18 to 22
        -- material, from 7 to 8
        UPDATE `item_template` SET `buy_price` = 6601, `sell_price` = 1320, `item_level` = 27, `required_level` = 22, `material` = 8 WHERE (`entry` = 6604);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6604, 3596);
        -- Cross Dagger
        -- required_level, from 18 to 23
        -- dmg_min1, from 18.0 to 11
        -- dmg_max1, from 28.0 to 22
        UPDATE `item_template` SET `required_level` = 23, `dmg_min1` = 11, `dmg_max1` = 22 WHERE (`entry` = 2819);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2819, 3596);
        -- Heavy Throwing Dagger
        -- dmg_min1, from 14.0 to 7
        -- dmg_max1, from 22.0 to 15
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 15 WHERE (`entry` = 3108);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3108, 3596);
        -- Militia Warhammer
        -- dmg_min1, from 12.0 to 7
        -- dmg_max1, from 17.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 5579);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5579, 3596);
        -- Frostweave Mantle
        -- required_level, from 20 to 25
        UPDATE `item_template` SET `required_level` = 25 WHERE (`entry` = 6395);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6395, 3596);
        -- Shimmering Armor
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6567);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6567, 3596);
        -- Flameweave Pants
        -- display_id, from 11506 to 7781
        -- buy_price, from 7715 to 7013
        -- sell_price, from 1543 to 1402
        -- item_level, from 28 to 27
        -- required_level, from 18 to 22
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 15
        UPDATE `item_template` SET `display_id` = 7781, `buy_price` = 7013, `sell_price` = 1402, `item_level` = 27, `required_level` = 22, `stat_value1` = 2, `stat_type2` = 1, `stat_value2` = 15 WHERE (`entry` = 3067);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3067, 3596);
        -- Willow Boots
        -- required_level, from 6 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 6537);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6537, 3596);
        -- Sage's Gloves
        -- buy_price, from 2589 to 2742
        -- sell_price, from 517 to 548
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `buy_price` = 2742, `sell_price` = 548, `required_level` = 20 WHERE (`entry` = 6615);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6615, 3596);
        -- Shimmering Cloak
        -- buy_price, from 2691 to 2944
        -- sell_price, from 538 to 588
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `buy_price` = 2944, `sell_price` = 588, `required_level` = 17 WHERE (`entry` = 6564);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6564, 3596);
        -- Studded Hat
        -- name, from Studded Leather Cap to Studded Hat
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `name` = 'Studded Hat', `required_level` = 32, `stat_value1` = 4 WHERE (`entry` = 3890);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3890, 3596);
        -- Barbaric Shoulders
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 2 WHERE (`entry` = 5964);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5964, 3596);
        -- Guardian Pants
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 6 WHERE (`entry` = 5962);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5962, 3596);
        -- Forest Leather Boots
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2 WHERE (`entry` = 3057);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3057, 3596);
        -- Inscribed Leather Bracers
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 3205);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3205, 3596);
        -- Hillman's Cloak
        -- required_level, from 20 to 25
        -- material, from 7 to 8
        UPDATE `item_template` SET `required_level` = 25, `material` = 8 WHERE (`entry` = 3719);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3719, 3596);
        -- Patched Pants
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2237);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2237, 3596);
        -- Sturdy Leather Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2327);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2327, 3596);
        -- Seer's Mantle
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 4698);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4698, 3596);
        -- Magister's Belt
        -- name, from Magister's Sash to Magister's Belt
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `name` = 'Magister''s Belt', `required_level` = 10, `stat_value1` = 4 WHERE (`entry` = 4684);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4684, 3596);
        -- Riding Gloves
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 4 WHERE (`entry` = 1304);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1304, 3596);
        -- Finely Woven Cloak
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 1270);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1270, 3596);
        -- Trouncing Boots
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 1
        -- stat_value3, from 0 to 5
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 1, `stat_value3` = 5 WHERE (`entry` = 4464);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4464, 3596);
        -- Insignia Boots
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 2, `stat_type2` = 4, `stat_value2` = 1 WHERE (`entry` = 4055);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4055, 3596);
        -- Salma's Oven Mitts
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 1479);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1479, 3596);
        -- Wicked Blackjack
        -- required_level, from 7 to 12
        -- dmg_min1, from 23.0 to 11
        -- dmg_max1, from 36.0 to 22
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 11, `dmg_max1` = 22, `material` = 1 WHERE (`entry` = 827);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (827, 3596);
        -- Tear of Grief
        -- required_level, from 6 to 11
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 1 WHERE (`entry` = 5611);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5611, 3596);
        -- Defender Spaulders
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6579);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6579, 3596);
        -- Burnished Chain Tunic
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2989);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2989, 3596);
        -- Glinting Scale Boots
        -- buy_price, from 5602 to 6331
        -- sell_price, from 1120 to 1266
        -- item_level, from 24 to 25
        -- required_level, from 14 to 20
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 6331, `sell_price` = 1266, `item_level` = 25, `required_level` = 20, `stat_value1` = 2 WHERE (`entry` = 3045);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3045, 3596);
        -- Burnished Chain Bracers
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 3211);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3211, 3596);
        -- Algae Fists
        -- buy_price, from 5266 to 5270
        -- sell_price, from 1053 to 1054
        -- stat_value2, from 0 to 2
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `buy_price` = 5270, `sell_price` = 1054, `stat_value2` = 2, `bonding` = 2 WHERE (`entry` = 6906);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6906, 3596);
        -- Defender Shield
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6572);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6572, 3596);
        -- Slarkskin
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 6 WHERE (`entry` = 6180);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6180, 3596);
        -- Magister's Gloves
        -- buy_price, from 1108 to 964
        -- sell_price, from 221 to 192
        -- item_level, from 18 to 17
        -- required_level, from 8 to 12
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 964, `sell_price` = 192, `item_level` = 17, `required_level` = 12, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 2972);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2972, 3596);
        -- Beastwalker Robe
        -- required_level, from 24 to 29
        -- stat_value2, from 0 to 3
        -- stat_value3, from 0 to 3
        UPDATE `item_template` SET `required_level` = 29, `stat_value2` = 3, `stat_value3` = 3 WHERE (`entry` = 4476);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4476, 3596);
        -- Swampland Trousers
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 4 WHERE (`entry` = 4505);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4505, 3596);
        -- Darkweave Cuffs
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 6407);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6407, 3596);
        -- Darkweave Cloak
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 2 WHERE (`entry` = 4719);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4719, 3596);
        -- Hypnotic Blade
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7714);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7714, 3596);
        -- Orb of the Forgotten Seer
        -- bonding, from 1 to 3
        UPDATE `item_template` SET `bonding` = 3 WHERE (`entry` = 7685);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7685, 3596);
        -- Defender Girdle
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 6576);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6576, 3596);
        -- Glinting Scale Pants
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 3048);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3048, 3596);
        -- Rawhide Shoulderpads
        -- name, from Tough Leather Shoulderpads to Rawhide Shoulderpads
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `name` = 'Rawhide Shoulderpads', `required_level` = 20 WHERE (`entry` = 1801);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1801, 3596);
        -- Robes of Antiquity
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        -- stat_value3, from 0 to 10
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1, `stat_value2` = 10, `stat_value3` = 10 WHERE (`entry` = 5812);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5812, 3596);
        -- Inscribed Leather Gloves
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1 WHERE (`entry` = 2988);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2988, 3596);
        -- Webwing Cloak
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 10 WHERE (`entry` = 5751);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5751, 3596);
        -- Dwarven War Staff
        -- required_level, from 8 to 13
        -- dmg_min1, from 40.0 to 26
        -- dmg_max1, from 55.0 to 40
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 26, `dmg_max1` = 40 WHERE (`entry` = 2077);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2077, 3596);
        -- Dread Mage Hat
        -- required_level, from 20 to 25
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 20
        UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 1, `stat_value1` = 20 WHERE (`entry` = 3556);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3556, 3596);
        -- Black Velvet Robes
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value2` = 2 WHERE (`entry` = 2800);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2800, 3596);
        -- Shimmering Sash
        -- required_level, from 11 to 16
        UPDATE `item_template` SET `required_level` = 16 WHERE (`entry` = 6570);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6570, 3596);
        -- Necromancer Leggings
        -- buy_price, from 9290 to 10219
        -- sell_price, from 1858 to 2043
        -- item_level, from 28 to 29
        -- required_level, from 18 to 19
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 10219, `sell_price` = 2043, `item_level` = 29, `required_level` = 19, `stat_value2` = 4 WHERE (`entry` = 2277);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2277, 3596);
        -- Woolen Boots
        -- required_level, from 9 to 14
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 14, `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2583);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2583, 3596);
        -- Seer's Bracers
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 3645);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3645, 3596);
        -- Tranquil Ring
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 15
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 2, `stat_value2` = 15, `bonding` = 2 WHERE (`entry` = 2917);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2917, 3596);
        -- Corsair's Overshirt
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 2
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 2, `stat_type2` = 7, `stat_value2` = 2, `bonding` = 2 WHERE (`entry` = 5202);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5202, 3596);
        -- Magister's Cloak
        -- required_level, from 5 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 4683);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4683, 3596);
        -- Dwarven Flamestick
        -- required_level, from 8 to 13
        -- dmg_min1, from 26.0 to 16
        -- dmg_max1, from 40.0 to 30
        -- delay, from 3300 to 1800
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 16, `dmg_max1` = 30, `delay` = 1800 WHERE (`entry` = 5241);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5241, 3596);
        -- Doomsayer's Robe
        -- required_level, from 30 to 35
        UPDATE `item_template` SET `required_level` = 35 WHERE (`entry` = 4746);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4746, 3596);
        -- Scalemail Vest
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 285);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (285, 3596);
        -- Veteran Leggings
        -- buy_price, from 3162 to 2749
        -- sell_price, from 632 to 549
        -- item_level, from 18 to 17
        -- required_level, from 8 to 12
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 2749, `sell_price` = 549, `item_level` = 17, `required_level` = 12, `stat_value1` = 1 WHERE (`entry` = 2978);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2978, 3596);
        -- Veteran Boots
        -- buy_price, from 2391 to 1571
        -- sell_price, from 478 to 314
        -- item_level, from 18 to 15
        -- required_level, from 8 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 1571, `sell_price` = 314, `item_level` = 15, `required_level` = 10, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 2979);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2979, 3596);
        -- Scalemail Gloves
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 718);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (718, 3596);
        -- Enormous Rock Hammer
        -- dmg_min1, from 46.0 to 32
        -- dmg_max1, from 63.0 to 49
        UPDATE `item_template` SET `dmg_min1` = 32, `dmg_max1` = 49 WHERE (`entry` = 2026);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2026, 3596);
        -- Shimmering Silk Robes
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 1 WHERE (`entry` = 2616);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2616, 3596);
        -- Tarantula Silk Belt
        -- required_level, from 13 to 18
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 18, `stat_type1` = 4, `stat_value1` = 1 WHERE (`entry` = 3229);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3229, 3596);
        -- Northern Shortsword
        -- required_level, from 9 to 14
        -- dmg_min1, from 27.0 to 12
        -- dmg_max1, from 34.0 to 23
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 12, `dmg_max1` = 23 WHERE (`entry` = 2078);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2078, 3596);
        -- Arcane Orb
        -- spellcooldown_1, from 1800000 to 3600000
        UPDATE `item_template` SET `spellcooldown_1` = 3600000 WHERE (`entry` = 7507);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7507, 3596);
        -- Torchlight Wand
        -- required_level, from 11 to 16
        -- dmg_min1, from 23.0 to 13
        -- dmg_max1, from 35.0 to 25
        -- delay, from 2600 to 1300
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 13, `dmg_max1` = 25, `delay` = 1300 WHERE (`entry` = 5240);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5240, 3596);
        -- Flameweave Mantle
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 1 WHERE (`entry` = 4661);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4661, 3596);
        -- Lesser Wizard's Robe
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3 WHERE (`entry` = 5766);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5766, 3596);
        -- Thick Cloth Bracers
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 3598);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3598, 3596);
        -- Resilient Poncho
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 5 WHERE (`entry` = 3561);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3561, 3596);
        -- Acrobatic Staff
        -- required_level, from 17 to 22
        -- stat_value2, from 0 to 2
        -- dmg_min1, from 36.0 to 29
        -- dmg_max1, from 49.0 to 44
        UPDATE `item_template` SET `required_level` = 22, `stat_value2` = 2, `dmg_min1` = 29, `dmg_max1` = 44 WHERE (`entry` = 3185);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3185, 3596);
        -- Oil-stained Cloak
        -- required_level, from 1 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 3153);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3153, 3596);
        -- Copper Chain Vest
        -- required_level, from 1 to 5
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 1, `stat_value1` = 4 WHERE (`entry` = 3471);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3471, 3596);
        -- Runed Copper Belt
        -- required_level, from 8 to 13
        UPDATE `item_template` SET `required_level` = 13 WHERE (`entry` = 2857);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2857, 3596);
        -- Militia Shortsword
        -- dmg_min1, from 9.0 to 4
        -- dmg_max1, from 14.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 8 WHERE (`entry` = 1161);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1161, 3596);
        -- Copper Chain Belt
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 2851);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2851, 3596);
        -- Worn Mail Boots
        -- required_level, from 3 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 1731);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1731, 3596);
        -- Runed Copper Gauntlets
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 3472);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3472, 3596);
        -- Elastic Wristguards
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 1183);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1183, 3596);
        -- Fine Leather Tunic
        -- required_level, from 7 to 12
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 1 WHERE (`entry` = 4243);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4243, 3596);
        -- Russet Hat
        -- required_level, from 27 to 32
        UPDATE `item_template` SET `required_level` = 32 WHERE (`entry` = 3889);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3889, 3596);
        -- Enchanted Gold Bloodrobe
        -- allowable_class, from 256 to 32767
        UPDATE `item_template` SET `allowable_class` = 32767 WHERE (`entry` = 6900);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6900, 3596);
        -- Dreamer's Belt
        -- required_level, from 19 to 24
        UPDATE `item_template` SET `required_level` = 24 WHERE (`entry` = 4829);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4829, 3596);
        -- Kimbra Boots
        -- buy_price, from 2691 to 3079
        -- sell_price, from 538 to 615
        -- item_level, from 22 to 23
        -- required_level, from 12 to 18
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 3079, `sell_price` = 615, `item_level` = 23, `required_level` = 18, `stat_value1` = 1 WHERE (`entry` = 6191);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6191, 3596);
        -- Quicksilver Ring
        -- required_level, from 26 to 31
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 31, `stat_value2` = 2 WHERE (`entry` = 5008);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5008, 3596);
        -- Crimson Silk Cloak
        -- fire_res, from 7 to 20
        UPDATE `item_template` SET `fire_res` = 20 WHERE (`entry` = 7056);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7056, 3596);
        -- Bouquet of Scarlet Begonias
        -- required_level, from 13 to 18
        UPDATE `item_template` SET `required_level` = 18 WHERE (`entry` = 2562);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2562, 3596);
        -- Mail Combat Helm
        -- buy_price, from 21554 to 19957
        -- sell_price, from 4310 to 3991
        -- item_level, from 38 to 37
        -- required_level, from 28 to 32
        -- stat_value1, from 0 to 8
        UPDATE `item_template` SET `buy_price` = 19957, `sell_price` = 3991, `item_level` = 37, `required_level` = 32, `stat_value1` = 8 WHERE (`entry` = 4077);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4077, 3596);
        -- War Rider Bracers
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 3 WHERE (`entry` = 4745);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4745, 3596);
        -- Bonefist Gauntlets
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 20
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `stat_value2` = 20 WHERE (`entry` = 4465);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4465, 3596);
        -- Cape of the Crusader
        -- required_level, from 23 to 28
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 1
        -- material, from 7 to 5
        UPDATE `item_template` SET `required_level` = 28, `stat_type1` = 5, `stat_value1` = 1, `stat_type2` = 6, `stat_value2` = 1, `material` = 5 WHERE (`entry` = 4643);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4643, 3596);
        -- Mograine's Might
        -- bonding, from 1 to 2
        -- material, from 2 to 1
        UPDATE `item_template` SET `bonding` = 2, `material` = 1 WHERE (`entry` = 7723);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7723, 3596);
        -- Forest Leather Pants
        -- required_level, from 14 to 19
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 3 WHERE (`entry` = 3056);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3056, 3596);
        -- Chief Brigadier Gauntlets
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 1988);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1988, 3596);
        -- Tiger Band
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 2, `stat_value2` = 10 WHERE (`entry` = 6749);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6749, 3596);
        -- Chief Brigadier Cloak
        -- required_level, from 30 to 35
        -- material, from 7 to 5
        UPDATE `item_template` SET `required_level` = 35, `material` = 5 WHERE (`entry` = 4726);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4726, 3596);
        -- Mindbender Loop
        -- item_level, from 38 to 37
        -- required_level, from 28 to 32
        -- stat_value1, from 0 to 50
        UPDATE `item_template` SET `item_level` = 37, `required_level` = 32, `stat_value1` = 50 WHERE (`entry` = 5009);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5009, 3596);
        -- Illusionary Rod
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7713);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7713, 3596);
        -- Mark of Kern
        -- spellid_1, from 9331 to 2022
        UPDATE `item_template` SET `spellid_1` = 2022 WHERE (`entry` = 2262);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2262, 3596);
        -- Golden Scale Cuirass
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 9 WHERE (`entry` = 3845);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3845, 3596);
        -- Polished Steel Boots
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 2 WHERE (`entry` = 3846);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3846, 3596);
        -- Two-handed Cavalier Sword
        -- required_level, from 19 to 24
        -- stat_value1, from 0 to 3
        -- dmg_min1, from 44.0 to 37
        -- dmg_max1, from 60.0 to 57
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3, `dmg_min1` = 37, `dmg_max1` = 57 WHERE (`entry` = 3206);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3206, 3596);
        -- Azora's Will
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 5 WHERE (`entry` = 4999);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4999, 3596);
        -- Enduring Cap
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `stat_value1` = 6 WHERE (`entry` = 3020);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3020, 3596);
        -- Insignia Mantle
        -- buy_price, from 18357 to 16997
        -- sell_price, from 3671 to 3399
        -- item_level, from 38 to 37
        -- required_level, from 28 to 32
        UPDATE `item_template` SET `buy_price` = 16997, `sell_price` = 3399, `item_level` = 37, `required_level` = 32 WHERE (`entry` = 4721);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4721, 3596);
        -- Double-stitched Woolen Shoulders
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 4314);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4314, 3596);
        -- Azure Silk Vest
        -- name, from Wispy Silk Boots to Azure Silk Vest
        -- buy_price, from 7030 to 9373
        -- sell_price, from 1406 to 1874
        -- inventory_type, from 8 to 5
        -- required_level, from 20 to 25
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `name` = 'Azure Silk Vest', `buy_price` = 9373, `sell_price` = 1874, `inventory_type` = 5, `required_level` = 25, `stat_type1` = 6, `stat_value1` = 5 WHERE (`entry` = 4324);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4324, 3596);
        -- Dark Runner Boots
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 1 WHERE (`entry` = 2232);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2232, 3596);
        -- Shimmering Gloves
        -- buy_price, from 2226 to 1713
        -- sell_price, from 445 to 342
        -- item_level, from 23 to 21
        -- required_level, from 13 to 16
        UPDATE `item_template` SET `buy_price` = 1713, `sell_price` = 342, `item_level` = 21, `required_level` = 16 WHERE (`entry` = 6565);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6565, 3596);
        -- Defias Renegade Ring
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 1076);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1076, 3596);
        -- Sage's Cloak
        -- buy_price, from 3883 to 4098
        -- sell_price, from 776 to 819
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `buy_price` = 4098, `sell_price` = 819, `required_level` = 20 WHERE (`entry` = 6614);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6614, 3596);
        -- Totem of Infliction
        -- required_level, from 15 to 20
        -- spellid_1, from 7617 to 7614
        UPDATE `item_template` SET `required_level` = 20, `spellid_1` = 7614 WHERE (`entry` = 1131);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1131, 3596);
        -- Enchanter's Cowl
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 5 WHERE (`entry` = 4322);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4322, 3596);
        -- Fen Keeper Robe
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 3 WHERE (`entry` = 3558);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3558, 3596);
        -- Ryedol's Hammer
        -- required_level, from 26 to 31
        -- dmg_min1, from 47.0 to 31
        -- dmg_max1, from 71.0 to 58
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 31, `dmg_min1` = 31, `dmg_max1` = 58, `material` = 1 WHERE (`entry` = 4978);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4978, 3596);
        -- Moss Cinch
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6911);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6911, 3596);
        -- Inscribed Leather Boots
        -- display_id, from 11581 to 6715
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 4
        UPDATE `item_template` SET `display_id` = 6715, `required_level` = 15, `stat_type1` = 4 WHERE (`entry` = 2987);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2987, 3596);
        -- Owl Bracers
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 4796);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4796, 3596);
        -- Lavishly Jeweled Ring
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `stat_value1` = 1, `stat_value2` = 1, `bonding` = 2 WHERE (`entry` = 1156);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1156, 3596);
        -- Glinting Scale Girdle
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 1 WHERE (`entry` = 4707);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4707, 3596);
        -- Dragonmaw Chain Boots
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 2 WHERE (`entry` = 1955);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1955, 3596);
        -- Scalemail Bracers
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 1852);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1852, 3596);
        -- Tunic of Westfall
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 2041);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2041, 3596);
        -- Emblazoned Pants
        -- buy_price, from 14368 to 13062
        -- sell_price, from 2873 to 2612
        -- item_level, from 33 to 32
        -- required_level, from 23 to 27
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 13062, `sell_price` = 2612, `item_level` = 32, `required_level` = 27, `stat_value1` = 4, `stat_value2` = 3 WHERE (`entry` = 4050);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4050, 3596);
        -- Feet of the Lynx
        -- name, from Thick-soled Boots to Feet of the Lynx
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `name` = 'Feet of the Lynx', `stat_value1` = 3 WHERE (`entry` = 1121);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1121, 3596);
        -- Silver-plated Shotgun
        -- required_level, from 16 to 21
        -- dmg_min1, from 21.0 to 30
        -- dmg_max1, from 32.0 to 56
        UPDATE `item_template` SET `required_level` = 21, `dmg_min1` = 30, `dmg_max1` = 56 WHERE (`entry` = 4379);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4379, 3596);
        -- Elite Shoulders
        -- required_level, from 20 to 25
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 25, `stat_value2` = 10 WHERE (`entry` = 4835);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4835, 3596);
        -- Bear Bracers
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 4795);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4795, 3596);
        -- Dreamslayer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 7752);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7752, 3596);
        -- Glinting Shield
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 3656);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3656, 3596);
        -- Runed Copper Bracers
        -- required_level, from 9 to 14
        UPDATE `item_template` SET `required_level` = 14 WHERE (`entry` = 2854);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2854, 3596);
        -- Darkwood Fishing Pole
        -- dmg_min1, from 12.0 to 3
        -- dmg_max1, from 15.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 6366);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6366, 3596);
        -- Double-barreled Shotgun
        -- dmg_min1, from 18.0 to 24
        -- dmg_max1, from 27.0 to 45
        UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 45 WHERE (`entry` = 2098);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2098, 3596);
        -- Dusty Chain Armor
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3 WHERE (`entry` = 2016);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2016, 3596);
        -- Glimmering Mail Girdle
        -- required_level, from 20 to 25
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 4712);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4712, 3596);
        -- Chausses of Westfall
        -- buy_price, from 7768 to 8135
        -- sell_price, from 1553 to 1627
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 8135, `sell_price` = 1627, `required_level` = 20, `stat_value1` = 2 WHERE (`entry` = 6087);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6087, 3596);
        -- Defender Cloak
        -- buy_price, from 3066 to 3248
        -- sell_price, from 613 to 649
        -- required_level, from 10 to 15
        -- material, from 7 to 5
        UPDATE `item_template` SET `buy_price` = 3248, `sell_price` = 649, `required_level` = 15, `material` = 5 WHERE (`entry` = 6575);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6575, 3596);
        -- Ancient War Sword
        -- required_level, from 22 to 27
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 3
        -- dmg_min1, from 60.0 to 53
        -- dmg_max1, from 82.0 to 80
        UPDATE `item_template` SET `required_level` = 27, `stat_type1` = 7, `stat_value1` = 4, `stat_value2` = 3, `dmg_min1` = 53, `dmg_max1` = 80 WHERE (`entry` = 3209);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3209, 3596);
        -- Mail Combat Cloak
        -- required_level, from 27 to 32
        -- material, from 7 to 5
        UPDATE `item_template` SET `required_level` = 32, `material` = 5 WHERE (`entry` = 4716);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4716, 3596);
        -- Servomechanic Sledgehammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4548);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4548, 3596);
        -- Green Leather Armor
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 3
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 3, `stat_type2` = 3, `stat_value2` = 3 WHERE (`entry` = 4255);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4255, 3596);
        -- Dervish Belt
        -- buy_price, from 3237 to 3490
        -- sell_price, from 647 to 698
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `buy_price` = 3490, `sell_price` = 698, `required_level` = 20 WHERE (`entry` = 6600);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6600, 3596);
        -- Toughened Leather Gloves
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 4253);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4253, 3596);
        -- Band of Elven Grace
        -- required_level, from 13 to 18
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 18, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 6678);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6678, 3596);
        -- Crescent of Forlorn Spirits
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 29.0 to 18
        -- dmg_max1, from 44.0 to 35
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 2, `dmg_min1` = 18, `dmg_max1` = 35 WHERE (`entry` = 2044);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2044, 3596);
        -- Nightscape Belt
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `required_level` = 22 WHERE (`entry` = 4828);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4828, 3596);
        -- Thornblade
        -- required_level, from 10 to 15
        -- dmg_min1, from 18.0 to 9
        -- dmg_max1, from 28.0 to 18
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 9, `dmg_max1` = 18 WHERE (`entry` = 2908);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2908, 3596);
        -- Murloc Scale Bracers
        -- required_level, from 28 to 33
        UPDATE `item_template` SET `required_level` = 33 WHERE (`entry` = 5783);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5783, 3596);
        -- Ranger Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 7483);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7483, 3596);
        -- Silver Scale Breastplate
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 2870);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2870, 3596);
        -- Mithril Warhammer
        -- stat_value1, from 0 to 4
        -- dmg_min1, from 45.0 to 29
        -- dmg_max1, from 68.0 to 55
        -- material, from 2 to 1
        UPDATE `item_template` SET `stat_value1` = 4, `dmg_min1` = 29, `dmg_max1` = 55, `material` = 1 WHERE (`entry` = 1721);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1721, 3596);
        -- Soldier's Bracers
        -- required_level, from 5 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 6550);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6550, 3596);
        -- Dwarven Tree Chopper
        -- required_level, from 10 to 15
        -- dmg_min1, from 44.0 to 30
        -- dmg_max1, from 60.0 to 46
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 30, `dmg_max1` = 46 WHERE (`entry` = 2907);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2907, 3596);
        -- Ardent Custodian
        -- spellid_1, from 7518 to 5008
        -- spelltrigger_1, from 1 to 2
        -- material, from 2 to 1
        UPDATE `item_template` SET `spellid_1` = 5008, `spelltrigger_1` = 2, `material` = 1 WHERE (`entry` = 868);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (868, 3596);
        -- Hunting Boots
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 2975);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2975, 3596);
        -- Big Bronze Knife
        -- required_level, from 11 to 16
        -- dmg_min1, from 22.0 to 11
        -- dmg_max1, from 34.0 to 22
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 11, `dmg_max1` = 22 WHERE (`entry` = 3848);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3848, 3596);
        -- Sharp Throwing Axe
        -- dmg_min1, from 10.0 to 4
        -- dmg_max1, from 16.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 8 WHERE (`entry` = 3135);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3135, 3596);
        -- Raptor Hide Belt
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 2 WHERE (`entry` = 4456);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4456, 3596);
        -- Dervish Boots
        -- buy_price, from 6639 to 6531
        -- sell_price, from 1327 to 1306
        -- item_level, from 28 to 27
        -- required_level, from 18 to 22
        UPDATE `item_template` SET `buy_price` = 6531, `sell_price` = 1306, `item_level` = 27, `required_level` = 22 WHERE (`entry` = 6601);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6601, 3596);
        -- Ring of the Underwood
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `stat_value1` = 3 WHERE (`entry` = 2951);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2951, 3596);
        -- Heraldic Cloak
        -- required_level, from 23 to 28
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        -- material, from 7 to 8
        UPDATE `item_template` SET `required_level` = 28, `stat_type1` = 7, `stat_value1` = 2, `material` = 8 WHERE (`entry` = 2953);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2953, 3596);
        -- Razor Main Gauche
        -- dmg_min1, from 24.0 to 16
        -- dmg_max1, from 37.0 to 31
        UPDATE `item_template` SET `dmg_min1` = 16, `dmg_max1` = 31 WHERE (`entry` = 2526);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2526, 3596);
        -- Sage's Robe
        -- buy_price, from 6438 to 6693
        -- sell_price, from 1287 to 1338
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `buy_price` = 6693, `sell_price` = 1338, `required_level` = 22 WHERE (`entry` = 6610);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6610, 3596);
        -- Pearl-clasped Cloak
        -- required_level, from 8 to 13
        UPDATE `item_template` SET `required_level` = 13 WHERE (`entry` = 5542);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5542, 3596);
        -- Emberstone Staff
        -- dmg_min1, from 43.0 to 30
        -- dmg_max1, from 59.0 to 46
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `dmg_min1` = 30, `dmg_max1` = 46, `bonding` = 2 WHERE (`entry` = 5201);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5201, 3596);
        -- Flameweave Cloak
        -- buy_price, from 3883 to 3993
        -- sell_price, from 776 to 798
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `buy_price` = 3993, `sell_price` = 798, `required_level` = 20, `stat_value1` = 10 WHERE (`entry` = 6381);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6381, 3596);
        -- Insignia Cap
        -- name, from Insignia Helm to Insignia Cap
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 2
        -- stat_value3, from 0 to 10
        UPDATE `item_template` SET `name` = 'Insignia Cap', `required_level` = 31, `stat_value1` = 2, `stat_value3` = 10 WHERE (`entry` = 4052);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4052, 3596);
        -- Insignia Gloves
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 6408);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6408, 3596);
        -- Sage's Boots
        -- buy_price, from 3883 to 4067
        -- sell_price, from 776 to 813
        -- required_level, from 15 to 20
        UPDATE `item_template` SET `buy_price` = 4067, `sell_price` = 813, `required_level` = 20 WHERE (`entry` = 6612);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6612, 3596);
        -- Coral Band
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        -- stat_value1, from 0 to 10
        -- stat_value2, from 0 to 15
        UPDATE `item_template` SET `item_level` = 26, `required_level` = 21, `stat_value1` = 10, `stat_value2` = 15 WHERE (`entry` = 5000);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5000, 3596);
        -- Blackrock Mace
        -- required_level, from 11 to 16
        -- dmg_min1, from 29.0 to 15
        -- dmg_max1, from 45.0 to 29
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 15, `dmg_max1` = 29, `material` = 1 WHERE (`entry` = 1296);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1296, 3596);
        -- Raptorbane Tunic
        -- required_level, from 19 to 24
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3, `stat_value2` = 2 WHERE (`entry` = 3566);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3566, 3596);
        -- Basilisk Hide Pants
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 1718);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1718, 3596);
        -- Ambassador's Boots
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 2033);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2033, 3596);
        -- Insignia Cloak
        -- required_level, from 27 to 32
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 2
        -- material, from 7 to 8
        UPDATE `item_template` SET `required_level` = 32, `stat_type2` = 4, `stat_value2` = 2, `material` = 8 WHERE (`entry` = 4722);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4722, 3596);
        -- Jade Serpentblade
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 47.0 to 30
        -- dmg_max1, from 71.0 to 57
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 2, `dmg_min1` = 30, `dmg_max1` = 57 WHERE (`entry` = 3850);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3850, 3596);
        -- Naraxis' Fang
        -- required_level, from 17 to 22
        -- dmg_min1, from 22.0 to 13
        -- dmg_max1, from 34.0 to 26
        UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 13, `dmg_max1` = 26 WHERE (`entry` = 4449);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4449, 3596);
        -- Raptor's End
        -- required_level, from 20 to 25
        -- dmg_min1, from 25.0 to 38
        -- dmg_max1, from 38.0 to 71
        UPDATE `item_template` SET `required_level` = 25, `dmg_min1` = 38, `dmg_max1` = 71 WHERE (`entry` = 3493);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3493, 3596);
        -- Scalemail Pants
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 286);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (286, 3596);
        -- Defender Gauntlets
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 6577);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6577, 3596);
        -- Brown Linen Pants
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 4343);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4343, 3596);
        -- Willow Cape
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6542);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6542, 3596);
        -- Blazing Wand
        -- required_level, from 7 to 12
        -- dmg_min1, from 21.0 to 12
        -- dmg_max1, from 33.0 to 24
        -- delay, from 2800 to 1500
        UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 12, `dmg_max1` = 24, `delay` = 1500 WHERE (`entry` = 5212);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5212, 3596);
        -- Belt of Vindication
        -- required_level, from 17 to 22
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `required_level` = 22, `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 3562);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3562, 3596);
        -- Panther Hunter Leggings
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 10 WHERE (`entry` = 4108);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4108, 3596);
        -- Madwolf Bracers
        -- required_level, from 19 to 24
        UPDATE `item_template` SET `required_level` = 24 WHERE (`entry` = 897);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (897, 3596);
        -- Tiger Hunter Gloves
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 4 WHERE (`entry` = 4107);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4107, 3596);
        -- Tigerbane
        -- required_level, from 29 to 34
        -- dmg_min1, from 40.0 to 27
        -- dmg_max1, from 61.0 to 52
        UPDATE `item_template` SET `required_level` = 34, `dmg_min1` = 27, `dmg_max1` = 52 WHERE (`entry` = 1465);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1465, 3596);
        -- Burnished Chain Girdle
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 10 WHERE (`entry` = 4697);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4697, 3596);
        -- Cruel Barb
        -- dmg_min1, from 34.0 to 18
        -- dmg_max1, from 52.0 to 35
        -- spellid_1, from 5258 to 7597
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 35, `spellid_1` = 7597, `bonding` = 2 WHERE (`entry` = 5191);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5191, 3596);
        -- Veteran Shield
        -- required_level, from 6 to 11
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 1, `stat_value1` = 3 WHERE (`entry` = 3651);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3651, 3596);
        -- Embalmed Shroud
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7691);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7691, 3596);
        -- Death Speaker Robes
        -- buy_price, from 8568 to 8640
        -- sell_price, from 1713 to 1728
        -- required_level, from 20 to 25
        -- stat_value2, from 0 to 2
        -- stat_value3, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 8640, `sell_price` = 1728, `required_level` = 25, `stat_value2` = 2, `stat_value3` = 5 WHERE (`entry` = 6682);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6682, 3596);
        -- Padded Gloves
        -- name, from Padded Cloth Gloves to Padded Gloves
        -- required_level, from 17 to 22
        UPDATE `item_template` SET `name` = 'Padded Gloves', `required_level` = 22 WHERE (`entry` = 2158);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2158, 3596);
        -- Defender Leggings
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 6578);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6578, 3596);
        -- Defender Boots
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 6573);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6573, 3596);
        -- Edged Bastard Sword
        -- required_level, from 8 to 13
        -- dmg_min1, from 39.0 to 25
        -- dmg_max1, from 53.0 to 39
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 3196);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3196, 3596);
        -- Ranger Bow
        -- dmg_min1, from 23.0 to 35
        -- dmg_max1, from 35.0 to 67
        UPDATE `item_template` SET `dmg_min1` = 35, `dmg_max1` = 67 WHERE (`entry` = 3021);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3021, 3596);
        -- Wicked Spiked Mace
        -- required_level, from 15 to 20
        -- dmg_min1, from 33.0 to 19
        -- dmg_max1, from 50.0 to 36
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 19, `dmg_max1` = 36, `material` = 1 WHERE (`entry` = 920);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (920, 3596);
        -- Green Iron Helm
        -- required_level, from 24 to 29
        UPDATE `item_template` SET `required_level` = 29 WHERE (`entry` = 3836);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3836, 3596);
        -- Glimmering Mail Chestpiece
        -- buy_price, from 17780 to 16164
        -- sell_price, from 3556 to 3232
        -- item_level, from 33 to 32
        -- required_level, from 23 to 27
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 16164, `sell_price` = 3232, `item_level` = 32, `required_level` = 27, `stat_value1` = 4, `stat_value2` = 3 WHERE (`entry` = 4071);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4071, 3596);
        -- Golden Scale Leggings
        -- required_level, from 24 to 29
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `required_level` = 29, `stat_value1` = 3, `stat_value2` = 4 WHERE (`entry` = 3843);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3843, 3596);
        -- Blood Ring
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 4998);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4998, 3596);
        -- Moonglow Vest
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 1 WHERE (`entry` = 6709);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6709, 3596);
        -- Scouting Boots
        -- buy_price, from 2543 to 2763
        -- sell_price, from 508 to 552
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `buy_price` = 2763, `sell_price` = 552, `required_level` = 15 WHERE (`entry` = 6582);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6582, 3596);
        -- Forest Leather Cloak
        -- buy_price, from 6927 to 5724
        -- sell_price, from 1385 to 1144
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        -- material, from 7 to 8
        UPDATE `item_template` SET `buy_price` = 5724, `sell_price` = 1144, `item_level` = 26, `required_level` = 21, `stat_type1` = 1, `stat_value1` = 5, `stat_value2` = 5, `material` = 8 WHERE (`entry` = 4710);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4710, 3596);
        -- Thief's Blade
        -- quality, from 3 to 2
        -- buy_price, from 10818 to 9015
        -- sell_price, from 2163 to 1803
        -- dmg_min1, from 22.0 to 11
        -- dmg_max1, from 33.0 to 21
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 9015, `sell_price` = 1803, `dmg_min1` = 11, `dmg_max1` = 21 WHERE (`entry` = 5192);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5192, 3596);
        -- Weighted Sap
        -- required_level, from 5 to 10
        -- dmg_min1, from 21.0 to 10
        -- dmg_max1, from 32.0 to 19
        -- material, from 2 to 1
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 10, `dmg_max1` = 19, `material` = 1 WHERE (`entry` = 1926);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1926, 3596);
        -- Keller's Girdle
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2911);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2911, 3596);
        -- Trogg Slicer
        -- required_level, from 8 to 13
        -- dmg_min1, from 43.0 to 28
        -- dmg_max1, from 58.0 to 42
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 28, `dmg_max1` = 42 WHERE (`entry` = 6186);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6186, 3596);
        -- Battleworn Leather Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4920);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4920, 3596);
        -- Primitive Kilt
        -- material, from 8 to 7
        UPDATE `item_template` SET `material` = 7 WHERE (`entry` = 6135);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6135, 3596);
        -- Primitive Kilt
        -- material, from 8 to 7
        UPDATE `item_template` SET `material` = 7 WHERE (`entry` = 153);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (153, 3596);
        -- Vile Familiar Head
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6487);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6487, 3596);
        -- Tattered Cloth Boots
        -- name, from Tattered Cloth Shoes to Tattered Cloth Boots
        UPDATE `item_template` SET `name` = 'Tattered Cloth Boots' WHERE (`entry` = 195);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (195, 3596);
        -- Peon Sword
        -- dmg_min1, from 9.0 to 3
        -- dmg_max1, from 14.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 2481);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2481, 3596);
        -- Battle Chain Tunic
        -- quality, from 1 to 2
        -- buy_price, from 708 to 1181
        -- sell_price, from 141 to 236
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1181, `sell_price` = 236, `required_level` = 7 WHERE (`entry` = 3283);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3283, 3596);
        -- Battle Chain Pants
        -- quality, from 1 to 2
        -- buy_price, from 882 to 1177
        -- sell_price, from 176 to 235
        -- item_level, from 13 to 12
        -- required_level, from 3 to 7
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1177, `sell_price` = 235, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 3282);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3282, 3596);
        -- Battle Chain Boots
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 3279);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3279, 3596);
        -- Battle Chain Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3281);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3281, 3596);
        -- Seasoned Fighter's Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4933);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4933, 3596);
        -- Dented Buckler
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 1166);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1166, 3596);
        -- Battleworn Hammer
        -- dmg_min1, from 11.0 to 5
        -- dmg_max1, from 16.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 8 WHERE (`entry` = 2361);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2361, 3596);
        -- Rigid Shoulderpads
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 5404);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5404, 3596);
        -- Ceremonial Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4692);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4692, 3596);
        -- Keen Throwing Knife
        -- dmg_min1, from 10.0 to 4
        -- dmg_max1, from 16.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 8 WHERE (`entry` = 3107);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3107, 3596);
        -- Scratched Claymore
        -- dmg_min1, from 12.0 to 7
        -- dmg_max1, from 17.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 2128);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2128, 3596);
        -- Inferior Tomahawk
        -- dmg_min1, from 7.0 to 2
        -- dmg_max1, from 11.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 2482);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2482, 3596);
        -- Rough Broad Axe
        -- dmg_min1, from 11.0 to 6
        -- dmg_max1, from 16.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 9 WHERE (`entry` = 2483);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2483, 3596);
        -- Splintered Board
        -- dmg_min1, from 7.0 to 2
        -- dmg_max1, from 11.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 2485);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2485, 3596);
        -- Large Stone Mace
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 18.0 to 10
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 2486);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2486, 3596);
        -- Small Knife
        -- name, from Jagged Knife to Small Knife
        -- dmg_min1, from 5.0 to 2
        -- dmg_max1, from 8.0 to 4
        UPDATE `item_template` SET `name` = 'Small Knife', `dmg_min1` = 2, `dmg_max1` = 4 WHERE (`entry` = 2484);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2484, 3596);
        -- Acolyte Staff
        -- dmg_min1, from 10.0 to 6
        -- dmg_max1, from 14.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 9 WHERE (`entry` = 2487);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2487, 3596);
        -- Ancestral Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3642);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3642, 3596);
        -- Ancestral Tunic
        -- quality, from 1 to 2
        -- buy_price, from 609 to 813
        -- sell_price, from 121 to 162
        -- item_level, from 13 to 12
        -- required_level, from 3 to 7
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 813, `sell_price` = 162, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 3292);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3292, 3596);
        -- Battle Knife
        -- required_level, from 1 to 4
        -- dmg_min1, from 9.0 to 4
        -- dmg_max1, from 14.0 to 8
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 4, `dmg_max1` = 8 WHERE (`entry` = 4565);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4565, 3596);
        -- Sunblaze Coif
        -- fire_res, from 10 to 48
        UPDATE `item_template` SET `fire_res` = 48 WHERE (`entry` = 5819);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5819, 3596);
        -- Burnished Chain Cloak
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 7
        -- material, from 7 to 5
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 7, `material` = 5 WHERE (`entry` = 4695);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4695, 3596);
        -- Adept Short Staff
        -- dmg_min1, from 14.0 to 9
        -- dmg_max1, from 20.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2503);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2503, 3596);
        -- Raider Shortsword
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 20.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 2496);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2496, 3596);
        -- Battle Shield
        -- buy_price, from 903 to 444
        -- sell_price, from 180 to 88
        -- item_level, from 13 to 10
        -- required_level, from 3 to 5
        UPDATE `item_template` SET `buy_price` = 444, `sell_price` = 88, `item_level` = 10, `required_level` = 5 WHERE (`entry` = 3650);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3650, 3596);
        -- Insignia Armor
        -- buy_price, from 23954 to 22180
        -- sell_price, from 4790 to 4436
        -- item_level, from 38 to 37
        -- required_level, from 28 to 32
        -- stat_value1, from 0 to 6
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 22180, `sell_price` = 4436, `item_level` = 37, `required_level` = 32, `stat_value1` = 6, `stat_value2` = 3 WHERE (`entry` = 4057);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4057, 3596);
        -- Snake Hoop
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 6
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 2, `stat_value2` = 6 WHERE (`entry` = 6750);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6750, 3596);
        -- Severing Axe
        -- required_level, from 1 to 5
        -- dmg_min1, from 19.0 to 12
        -- dmg_max1, from 27.0 to 19
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 4562);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4562, 3596);
        -- Battle Chain Girdle
        -- buy_price, from 426 to 272
        -- sell_price, from 85 to 54
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `buy_price` = 272, `sell_price` = 54, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 4669);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4669, 3596);
        -- Light Chain Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2402);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2402, 3596);
        -- Feral Blade
        -- required_level, from 10 to 8
        -- dmg_min1, from 23.0 to 10
        -- dmg_max1, from 35.0 to 20
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 10, `dmg_max1` = 20 WHERE (`entry` = 4766);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4766, 3596);
        -- Brackwater Shield
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 1, `stat_value1` = 6 WHERE (`entry` = 3654);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3654, 3596);
        -- Scalping Tomahawk
        -- required_level, from 1 to 5
        -- dmg_min1, from 9.0 to 4
        -- dmg_max1, from 14.0 to 9
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 4561);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4561, 3596);
        -- Fine Scimitar
        -- required_level, from 1 to 4
        -- dmg_min1, from 9.0 to 4
        -- dmg_max1, from 14.0 to 8
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 4, `dmg_max1` = 8 WHERE (`entry` = 4560);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4560, 3596);
        -- Tribal Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3286);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3286, 3596);
        -- Runic Cloth Gloves
        -- required_level, from 6 to 11
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 4 WHERE (`entry` = 3308);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3308, 3596);
        -- Thunderhorn Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4963);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4963, 3596);
        -- Battle Buckler
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 3649);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3649, 3596);
        -- Rusted Claymore
        -- dmg_min1, from 20.0 to 13
        -- dmg_max1, from 27.0 to 20
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 2497);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2497, 3596);
        -- Battered Chest
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6356);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6356, 3596);
        -- Glinting Scale Pauldrons
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 10 WHERE (`entry` = 4705);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4705, 3596);
        -- Glimmering Mail Leggings
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 5 WHERE (`entry` = 6386);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6386, 3596);
        -- Runic Darkblade
        -- spellid_1, from 16409 to 695
        UPDATE `item_template` SET `spellid_1` = 695 WHERE (`entry` = 3822);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3822, 3596);
        -- BKP 2700 "Enforcer"
        -- dmg_min1, from 19.0 to 27
        -- dmg_max1, from 29.0 to 51
        UPDATE `item_template` SET `dmg_min1` = 27, `dmg_max1` = 51 WHERE (`entry` = 3024);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3024, 3596);
        -- Ancestral Belt
        -- name, from Ancestral Sash to Ancestral Belt
        -- buy_price, from 229 to 183
        -- sell_price, from 45 to 36
        -- item_level, from 12 to 11
        -- required_level, from 2 to 6
        UPDATE `item_template` SET `name` = 'Ancestral Belt', `buy_price` = 183, `sell_price` = 36, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 4672);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4672, 3596);
        -- Ancestral Gloves
        -- buy_price, from 302 to 193
        -- sell_price, from 60 to 38
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `buy_price` = 193, `sell_price` = 38, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 3290);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3290, 3596);
        -- Deepwood Bracers
        -- required_level, from 16 to 21
        UPDATE `item_template` SET `required_level` = 21 WHERE (`entry` = 3204);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3204, 3596);
        -- Heart of Agammagan
        -- buy_price, from 19571 to 21182
        -- sell_price, from 3914 to 4236
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `buy_price` = 21182, `sell_price` = 4236, `stat_value1` = 3, `stat_value2` = 3, `bonding` = 2 WHERE (`entry` = 6694);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6694, 3596);
        -- Scuffed Dagger
        -- dmg_min1, from 7.0 to 3
        -- dmg_max1, from 11.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 2502);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2502, 3596);
        -- Worn Heater Shield
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2376);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2376, 3596);
        -- Farmer's Broom
        -- required_level, from 1 to 3
        -- dmg_min1, from 17.0 to 11
        -- dmg_max1, from 24.0 to 17
        UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 3335);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3335, 3596);
        -- Boar Hunter's Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 5314);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5314, 3596);
        -- Night Watch Shortsword
        -- dmg_min1, from 38.0 to 19
        -- dmg_max1, from 47.0 to 36
        UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 36 WHERE (`entry` = 935);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (935, 3596);
        -- Tribal Pants
        -- quality, from 1 to 2
        -- buy_price, from 599 to 998
        -- sell_price, from 119 to 199
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 998, `sell_price` = 199, `required_level` = 7 WHERE (`entry` = 3287);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3287, 3596);
        -- Tribal Vest
        -- quality, from 1 to 2
        -- buy_price, from 751 to 802
        -- sell_price, from 150 to 160
        -- item_level, from 13 to 11
        -- required_level, from 3 to 6
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 802, `sell_price` = 160, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 3288);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3288, 3596);
        -- Ancestral Boots
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 3289);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3289, 3596);
        -- Ancestral Cloak
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 4671);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4671, 3596);
        -- Light Chain Armor
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2398);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2398, 3596);
        -- Light Chain Gloves
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 2403);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2403, 3596);
        -- Willow Belt
        -- name, from Willow Sash to Willow Belt
        -- quality, from 2 to 1
        -- buy_price, from 933 to 560
        -- sell_price, from 186 to 112
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `name` = 'Willow Belt', `quality` = 1, `buy_price` = 560, `sell_price` = 112, `required_level` = 12 WHERE (`entry` = 6539);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6539, 3596);
        -- Ley Orb
        -- spellcooldown_1, from 1800000 to 3600000
        UPDATE `item_template` SET `spellcooldown_1` = 3600000 WHERE (`entry` = 7508);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7508, 3596);
        -- Willow Robe
        -- buy_price, from 1348 to 1407
        -- sell_price, from 269 to 281
        -- required_level, from 5 to 10
        UPDATE `item_template` SET `buy_price` = 1407, `sell_price` = 281, `required_level` = 10 WHERE (`entry` = 6538);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6538, 3596);
        -- Apprentice Sash
        -- buy_price, from 178 to 223
        -- sell_price, from 35 to 44
        -- item_level, from 11 to 12
        -- required_level, from 1 to 7
        UPDATE `item_template` SET `buy_price` = 223, `sell_price` = 44, `item_level` = 12, `required_level` = 7 WHERE (`entry` = 3442);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3442, 3596);
        -- Soft-soled Linen Boots
        -- required_level, from 6 to 11
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 4312);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4312, 3596);
        -- Heavy Woolen Gloves
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 4310);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4310, 3596);
        -- Adept's Cloak
        -- required_level, from 1 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 3833);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3833, 3596);
        -- Anvilmar Knife
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 2195);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2195, 3596);
        -- Anvilmar Sledge
        -- dmg_min1, from 13.0 to 7
        -- dmg_max1, from 19.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 12 WHERE (`entry` = 5761);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5761, 3596);
        -- Warm Winter Robe
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 3216);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3216, 3596);     



        -- WDB 3925 missing updates.



        -- Woodland Robes
        -- display_id, from 28178 to 16612
        -- buy_price, from 52 to 47
        -- sell_price, from 10 to 9
        UPDATE `item_template` SET `display_id` = 16612, `buy_price` = 47, `sell_price` = 9 WHERE (`entry` = 11189);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11189, 3925);
        -- Stemleaf Bracers
        -- display_id, from 25939 to 16588
        UPDATE `item_template` SET `display_id` = 16588 WHERE (`entry` = 11187);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11187, 3925);
        -- Viny Gloves
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 11190);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11190, 3925);
        -- Thistlewood Maul
        -- buy_price, from 127 to 85
        -- sell_price, from 25 to 17
        -- item_level, from 5 to 4
        -- dmg_max1, from 5.0 to 4.0
        -- material, from 2 to 1
        UPDATE `item_template` SET `buy_price` = 85, `sell_price` = 17, `item_level` = 4, `dmg_max1` = 4.0, `material` = 1 WHERE (`entry` = 10544);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10544, 3925);
        -- Archery Training Gloves
        -- buy_price, from 14 to 31
        -- sell_price, from 2 to 6
        -- item_level, from 3 to 5
        UPDATE `item_template` SET `buy_price` = 31, `sell_price` = 6, `item_level` = 5 WHERE (`entry` = 5394);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5394, 3925);
        -- Handcrafted Staff
        -- dmg_min1, from 5.0 to 3.0
        -- dmg_max1, from 8.0 to 5.0
        UPDATE `item_template` SET `dmg_min1` = 3.0, `dmg_max1` = 5.0 WHERE (`entry` = 3661);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3661, 3925);
        -- Canopy Leggings
        -- buy_price, from 43 to 65
        -- sell_price, from 8 to 13
        -- item_level, from 4 to 5
        UPDATE `item_template` SET `buy_price` = 65, `sell_price` = 13, `item_level` = 5 WHERE (`entry` = 5398);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5398, 3925);
        -- Tracking Boots
        -- buy_price, from 39 to 59
        -- sell_price, from 7 to 11
        -- item_level, from 4 to 5
        UPDATE `item_template` SET `buy_price` = 59, `sell_price` = 11, `item_level` = 5 WHERE (`entry` = 5399);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5399, 3925);
        -- Battered Buckler
        -- subclass, from 5 to 6
        -- buy_price, from 11 to 15
        -- sell_price, from 2 to 3
        UPDATE `item_template` SET `subclass` = 6, `buy_price` = 15, `sell_price` = 3 WHERE (`entry` = 2210);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2210, 3925);
        -- Draped Cloak
        -- buy_price, from 24 to 36
        -- sell_price, from 4 to 7
        -- item_level, from 4 to 5
        UPDATE `item_template` SET `buy_price` = 36, `sell_price` = 7, `item_level` = 5 WHERE (`entry` = 5405);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5405, 3925);
        -- Thistlewood Axe
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        -- dmg_min1, from 8.0 to 6.0
        -- dmg_max1, from 13.0 to 9.0
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511, `dmg_min1` = 6.0, `dmg_max1` = 9.0 WHERE (`entry` = 1386);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1386, 3925);
        -- Thistlewood Blade
        -- dmg_min1, from 3.0 to 2.0
        -- dmg_max1, from 7.0 to 5.0
        UPDATE `item_template` SET `dmg_min1` = 2.0, `dmg_max1` = 5.0 WHERE (`entry` = 5586);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5586, 3925);
        -- Thistlewood Bow
        -- buy_price, from 96 to 64
        -- sell_price, from 19 to 12
        -- item_level, from 5 to 4
        -- dmg_max1, from 7.0 to 6.0
        UPDATE `item_template` SET `buy_price` = 64, `sell_price` = 12, `item_level` = 4, `dmg_max1` = 6.0 WHERE (`entry` = 12447);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (12447, 3925);
        -- Barkmail Vest
        -- display_id, from 28069 to 3315
        UPDATE `item_template` SET `display_id` = 3315 WHERE (`entry` = 10656);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10656, 3925);
        -- Goldenbark Apple
        -- buy_price, from 1250 to 1000
        -- sell_price, from 62 to 50
        UPDATE `item_template` SET `buy_price` = 1000, `sell_price` = 50 WHERE (`entry` = 4539);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4539, 3925);
        -- Webwood Venom Sac
        -- display_id, from 6427 to 4045
        UPDATE `item_template` SET `display_id` = 4045 WHERE (`entry` = 5166);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5166, 3925);
        -- Cadet's Bow
        -- buy_price, from 144 to 216
        -- sell_price, from 28 to 43
        -- item_level, from 6 to 7
        -- dmg_min1, from 3.0 to 4.0
        -- dmg_max1, from 6.0 to 8.0
        -- delay, from 2000 to 2500
        UPDATE `item_template` SET `buy_price` = 216, `sell_price` = 43, `item_level` = 7, `dmg_min1` = 4.0, `dmg_max1` = 8.0, `delay` = 2500 WHERE (`entry` = 8179);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (8179, 3925);
        -- Cracked Bill
        -- buy_price, from 45 to 115
        -- sell_price, from 11 to 28
        UPDATE `item_template` SET `buy_price` = 115, `sell_price` = 28 WHERE (`entry` = 4775);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4775, 3925);
        -- Hearthstone
        -- class, from 14 to 15
        UPDATE `item_template` SET `class` = 15 WHERE (`entry` = 6948);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6948, 3925);
        -- Viny Wrappings
        -- display_id, from 8293 to 2486
        UPDATE `item_template` SET `display_id` = 2486 WHERE (`entry` = 2571);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2571, 3925);
        -- Poignard
        -- dmg_min1, from 13.0 to 7.0
        -- dmg_max1, from 20.0 to 15.0
        UPDATE `item_template` SET `dmg_min1` = 7.0, `dmg_max1` = 15.0 WHERE (`entry` = 2208);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2208, 3925);
        -- Disciple's Boots
        -- buy_price, from 223 to 290
        -- sell_price, from 44 to 58
        -- item_level, from 10 to 11
        UPDATE `item_template` SET `buy_price` = 290, `sell_price` = 58, `item_level` = 11 WHERE (`entry` = 7351);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7351, 3925);
        -- Earthroot
        -- buy_price, from 8 to 80
        -- sell_price, from 2 to 20
        UPDATE `item_template` SET `buy_price` = 80, `sell_price` = 20 WHERE (`entry` = 2449);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2449, 3925);
        -- Barkmail Leggings
        -- display_id, from 26948 to 19575
        UPDATE `item_template` SET `display_id` = 19575 WHERE (`entry` = 9599);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9599, 3925);
        -- Blue Linen Robe
        -- stat_type1, from 0 to 6
        UPDATE `item_template` SET `stat_type1` = 6 WHERE (`entry` = 6242);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6242, 3925);
        -- Cushioned Boots
        -- display_id, from 28142 to 6777
        UPDATE `item_template` SET `display_id` = 6777 WHERE (`entry` = 9601);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9601, 3925);
        -- Quarter Staff
        -- dmg_min1, from 28.0 to 20.0
        -- dmg_max1, from 39.0 to 31.0
        UPDATE `item_template` SET `dmg_min1` = 20.0, `dmg_max1` = 31.0 WHERE (`entry` = 854);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (854, 3925);
        -- Small Spider Leg
        -- display_id, from 7986 to 7345
        UPDATE `item_template` SET `display_id` = 7345 WHERE (`entry` = 5465);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5465, 3925);
        -- Raider's Cloak
        -- display_id, from 25978 to 15229
        -- buy_price, from 1173 to 1768
        -- sell_price, from 234 to 353
        -- material, from 7 to 5
        UPDATE `item_template` SET `display_id` = 15229, `buy_price` = 1768, `sell_price` = 353, `material` = 5 WHERE (`entry` = 9786);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9786, 3925);
        -- Heavy Shortbow
        -- buy_price, from 1432 to 2578
        -- sell_price, from 286 to 515
        -- item_level, from 12 to 15
        -- dmg_min1, from 13.0 to 10.0
        -- dmg_max1, from 24.0 to 20.0
        UPDATE `item_template` SET `buy_price` = 2578, `sell_price` = 515, `item_level` = 15, `dmg_min1` = 10.0, `dmg_max1` = 20.0 WHERE (`entry` = 3036);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3036, 3925);
        -- Hunting Gloves
        -- buy_price, from 988 to 859
        -- sell_price, from 197 to 171
        -- item_level, from 16 to 15
        -- stat_type1, from 0 to 7
        UPDATE `item_template` SET `buy_price` = 859, `sell_price` = 171, `item_level` = 15, `stat_type1` = 7 WHERE (`entry` = 2976);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2976, 3925);
        -- Cleaver
        -- dmg_min1, from 23.0 to 14.0
        -- dmg_max1, from 35.0 to 26.0
        UPDATE `item_template` SET `dmg_min1` = 14.0, `dmg_max1` = 26.0 WHERE (`entry` = 2029);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2029, 3925);
        -- Double Axe
        -- dmg_min1, from 29.0 to 19.0
        -- dmg_max1, from 44.0 to 36.0
        UPDATE `item_template` SET `dmg_min1` = 19.0, `dmg_max1` = 36.0 WHERE (`entry` = 927);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (927, 3925);
        -- Tabar
        -- dmg_min1, from 30.0 to 21.0
        -- dmg_max1, from 42.0 to 32.0
        UPDATE `item_template` SET `dmg_min1` = 21.0, `dmg_max1` = 32.0 WHERE (`entry` = 1196);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1196, 3925);
        -- Bearded Axe
        -- dmg_min1, from 40.0 to 31.0
        -- dmg_max1, from 55.0 to 47.0
        UPDATE `item_template` SET `dmg_min1` = 31.0, `dmg_max1` = 47.0 WHERE (`entry` = 2025);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2025, 3925);
        -- Battle Axe
        -- dmg_min1, from 53.0 to 46.0
        -- dmg_max1, from 72.0 to 70.0
        UPDATE `item_template` SET `dmg_min1` = 46.0, `dmg_max1` = 70.0 WHERE (`entry` = 926);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (926, 3925);
        -- Cutlass
        -- dmg_min1, from 19.0 to 10.0
        -- dmg_max1, from 29.0 to 20.0
        UPDATE `item_template` SET `dmg_min1` = 10.0, `dmg_max1` = 20.0 WHERE (`entry` = 851);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (851, 3925);
        -- Longsword
        -- dmg_min1, from 28.0 to 19.0
        -- dmg_max1, from 43.0 to 37.0
        UPDATE `item_template` SET `dmg_min1` = 19.0, `dmg_max1` = 37.0 WHERE (`entry` = 923);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (923, 3925);
        -- Claymore
        -- dmg_min1, from 32.0 to 23.0
        -- dmg_max1, from 44.0 to 35.0
        UPDATE `item_template` SET `dmg_min1` = 23.0, `dmg_max1` = 35.0 WHERE (`entry` = 1198);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1198, 3925);
        -- Espadon
        -- dmg_min1, from 36.0 to 29.0
        -- dmg_max1, from 49.0 to 44.0
        UPDATE `item_template` SET `dmg_min1` = 29.0, `dmg_max1` = 44.0 WHERE (`entry` = 2024);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2024, 3925);
        -- Dacian Falx
        -- dmg_min1, from 44.0 to 39.0
        -- dmg_max1, from 61.0 to 60.0
        UPDATE `item_template` SET `dmg_min1` = 39.0, `dmg_max1` = 60.0 WHERE (`entry` = 922);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (922, 3925);
        -- Kris
        -- dmg_min1, from 18.0 to 12.0
        -- dmg_max1, from 28.0 to 23.0
        UPDATE `item_template` SET `dmg_min1` = 12.0, `dmg_max1` = 23.0 WHERE (`entry` = 2209);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2209, 3925);
        -- Broadsword
        -- dmg_min1, from 39.0 to 28.0
        -- dmg_max1, from 59.0 to 53.0
        UPDATE `item_template` SET `dmg_min1` = 28.0, `dmg_max1` = 53.0 WHERE (`entry` = 2520);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2520, 3925);
        -- Falchion
        -- dmg_min1, from 56.0 to 39.0
        -- dmg_max1, from 84.0 to 74.0
        UPDATE `item_template` SET `dmg_min1` = 39.0, `dmg_max1` = 74.0 WHERE (`entry` = 2528);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2528, 3925);
        -- Sturdy Quarterstaff
        -- quality, from 1 to 2
        -- buy_price, from 512 to 3157
        -- sell_price, from 102 to 631
        -- item_level, from 8 to 13
        -- dmg_min1, from 17.0 to 20.0
        -- dmg_max1, from 24.0 to 30.0
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 3157, `sell_price` = 631, `item_level` = 13, `dmg_min1` = 20.0, `dmg_max1` = 30.0 WHERE (`entry` = 4566);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4566, 3925);
        -- Gnarlpine Necklace
        -- description, from The glowing emerald just needs to be pulled out... to Emits a strange green glow...
        UPDATE `item_template` SET `description` = 'Emits a strange green glow...' WHERE (`entry` = 8049);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (8049, 3925);
        -- Brushwood Blade
        -- buy_price, from 1505 to 1504
        -- sell_price, from 301 to 300
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `buy_price` = 1504, `sell_price` = 300, `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 9602);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9602, 3925);
        -- Silvery Spinnerets
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 8344);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (8344, 3925);
        -- Amethyst Phial
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5623);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5623, 3925);
        -- Legionnaire's Leggings
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 5
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 5, `stat_type2` = 6, `stat_value2` = 5 WHERE (`entry` = 4816);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4816, 3925);
        -- Steel-clasped Bracers
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 6 WHERE (`entry` = 4534);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4534, 3925);
        -- Riveted Gauntlets
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 4 WHERE (`entry` = 5312);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5312, 3925);
        -- Ring of Scorn
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `stat_value2` = 4 WHERE (`entry` = 3235);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3235, 3925);
        -- Decapitating Sword
        -- display_id, from 22226 to 20115
        -- dmg_min1, from 33.0 to 22.0
        -- dmg_max1, from 51.0 to 42.0
        UPDATE `item_template` SET `display_id` = 20115, `dmg_min1` = 22.0, `dmg_max1` = 42.0 WHERE (`entry` = 3740);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3740, 3925);
        -- Shadowgem
        -- buy_price, from 600 to 1000
        -- sell_price, from 150 to 250
        UPDATE `item_template` SET `buy_price` = 1000, `sell_price` = 250 WHERE (`entry` = 1210);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1210, 3925);
        -- Blood Shard
        -- stackable, from 20 to 10
        UPDATE `item_template` SET `stackable` = 10 WHERE (`entry` = 5075);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5075, 3925);
        -- Briarthorn
        -- buy_price, from 12 to 100
        -- sell_price, from 3 to 25
        UPDATE `item_template` SET `buy_price` = 100, `sell_price` = 25 WHERE (`entry` = 2450);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2450, 3925);
        -- Blue Leather Bag
        -- item_level, from 10 to 15
        UPDATE `item_template` SET `item_level` = 15 WHERE (`entry` = 856);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (856, 3925);
        -- Arced War Axe
        -- buy_price, from 17070 to 19289
        -- sell_price, from 3414 to 3857
        -- item_level, from 25 to 26
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 6
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 6
        -- dmg_min1, from 50.0 to 46.0
        -- dmg_max1, from 69.0 to 70.0
        UPDATE `item_template` SET `buy_price` = 19289, `sell_price` = 3857, `item_level` = 26, `stat_type1` = 4, `stat_value1` = 6, `stat_type2` = 7, `stat_value2` = 6, `dmg_min1` = 46.0, `dmg_max1` = 70.0 WHERE (`entry` = 3191);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3191, 3925);
        -- Glowing Shard
        -- start_quest, from 6981 to 3366
        UPDATE `item_template` SET `start_quest` = 3366 WHERE (`entry` = 10441);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10441, 3925);
        -- Wand of Decay
        -- dmg_min1, from 15.0 to 16.0
        -- dmg_max1, from 29.0 to 31.0
        UPDATE `item_template` SET `dmg_min1` = 16.0, `dmg_max1` = 31.0 WHERE (`entry` = 5252);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5252, 3925);
        -- Recipe: Discolored Healing Potion
        -- quality, from 2 to 1
        UPDATE `item_template` SET `quality` = 1 WHERE (`entry` = 4597);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4597, 3925);
        -- Soldier's Gauntlets
        -- buy_price, from 1164 to 1339
        -- sell_price, from 232 to 267
        -- item_level, from 16 to 17
        UPDATE `item_template` SET `buy_price` = 1339, `sell_price` = 267, `item_level` = 17 WHERE (`entry` = 6547);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6547, 3925);
        -- Soldier's Armor
        -- buy_price, from 2023 to 3379
        -- sell_price, from 404 to 675
        -- item_level, from 15 to 18
        UPDATE `item_template` SET `buy_price` = 3379, `sell_price` = 675, `item_level` = 18 WHERE (`entry` = 6545);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6545, 3925);
        -- Cinched Belt
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 5328);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5328, 3925);
        -- Settler's Leggings
        -- display_id, from 28250 to 2228
        UPDATE `item_template` SET `display_id` = 2228 WHERE (`entry` = 2694);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2694, 3925);
        -- Padded Lamellar Boots
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 2 WHERE (`entry` = 5320);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5320, 3925);
        -- Bounty Hunter's Ring
        -- stat_type1, from 0 to 7
        UPDATE `item_template` SET `stat_type1` = 7 WHERE (`entry` = 5351);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5351, 3925);
        -- Privateer Musket
        -- dmg_min1, from 18.0 to 12.0
        -- dmg_max1, from 34.0 to 24.0
        UPDATE `item_template` SET `dmg_min1` = 12.0, `dmg_max1` = 24.0 WHERE (`entry` = 5309);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5309, 3925);
        -- High Robe of the Adjudicator
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 7
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 7 WHERE (`entry` = 3461);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3461, 3925);
        -- Talonstrike
        -- dmg_min1, from 11.0 to 13.0
        -- dmg_max1, from 22.0 to 26.0
        UPDATE `item_template` SET `dmg_min1` = 13.0, `dmg_max1` = 26.0 WHERE (`entry` = 3462);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3462, 3925);
        -- Copper Bracers
        -- buy_price, from 37 to 85
        -- sell_price, from 7 to 17
        -- item_level, from 5 to 7
        UPDATE `item_template` SET `buy_price` = 85, `sell_price` = 17, `item_level` = 7 WHERE (`entry` = 2853);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2853, 3925);
        -- Copper Dagger
        -- dmg_max1, from 9.0 to 10.0
        UPDATE `item_template` SET `dmg_max1` = 10.0 WHERE (`entry` = 7166);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7166, 3925);
        -- Copper Axe
        -- dmg_min1, from 10.0 to 5.0
        -- dmg_max1, from 16.0 to 10.0
        UPDATE `item_template` SET `dmg_min1` = 5.0, `dmg_max1` = 10.0 WHERE (`entry` = 2845);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2845, 3925);
        -- Copper Battle Axe
        -- dmg_min1, from 33.0 to 23.0
        -- dmg_max1, from 45.0 to 35.0
        UPDATE `item_template` SET `dmg_min1` = 23.0, `dmg_max1` = 35.0 WHERE (`entry` = 3488);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3488, 3925);
        -- Copper Chain Boots
        -- buy_price, from 124 to 245
        -- sell_price, from 24 to 49
        -- item_level, from 7 to 9
        UPDATE `item_template` SET `buy_price` = 245, `sell_price` = 49, `item_level` = 9 WHERE (`entry` = 3469);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3469, 3925);
        -- Copper Shortsword
        -- dmg_min1, from 11.0 to 5.0
        -- dmg_max1, from 17.0 to 11.0
        UPDATE `item_template` SET `dmg_min1` = 5.0, `dmg_max1` = 11.0 WHERE (`entry` = 2847);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2847, 3925);
        -- Heavy Copper Maul
        -- dmg_min1, from 29.0 to 21.0
        -- dmg_max1, from 40.0 to 32.0
        UPDATE `item_template` SET `dmg_min1` = 21.0, `dmg_max1` = 32.0 WHERE (`entry` = 6214);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6214, 3925);
      
        insert into applied_updates values ('260520221');
    end if;
    
    -- 28/05/2022 1
    if (select count(*) from applied_updates where id='280520221') = 0 then
        DROP TABLE IF EXISTS `skill_fishing_base_level`;
        CREATE TABLE IF NOT EXISTS `skill_fishing_base_level` (
        `entry` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Area identifier',
        `skill` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Base skill level requirement',
        PRIMARY KEY (`entry`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Fishing system';

        INSERT INTO `skill_fishing_base_level` (`entry`, `skill`) VALUES
	        (1, -70),
	        (12, -70),
	        (14, -70),
	        (85, -70),
	        (141, -70),
	        (215, -70),
	        (17, -20),
	        (38, -20),
	        (40, -20),
	        (130, -20),
	        (148, -20),
	        (718, -20),
	        (719, -20),
	        (1519, -20),
	        (1537, -20),
	        (1581, -20),
	        (1637, -20),
	        (1638, -20),
	        (1657, -20),
	        (10, 55),
	        (11, 55),
	        (44, 55),
	        (267, 55),
	        (331, 55),
	        (406, 55),
	        (8, 130),
	        (15, 130),
	        (33, 130),
	        (36, 130),
	        (45, 130),
	        (400, 130),
	        (405, 130),
	        (796, 130),
	        (16, 205),
	        (28, 205),
	        (47, 205),
	        (357, 205),
	        (361, 205),
	        (440, 205),
	        (490, 205),
	        (493, 205),
	        (1417, 205),
	        (2100, 205),
	        (41, 330),
	        (46, 330),
	        (139, 330),
	        (618, 330),
	        (1377, 330),
	        (1977, 330),
	        (2017, 330),
	        (2057, 330),
	        (297, 205),
	        (1112, 330),
	        (1222, 330),
	        (1227, 330),
	        (3140, 330);

        insert into applied_updates values ('280520221');
    end if;
    
    -- 13/06/2022 1
    if (select count(*) from applied_updates where id='131620221') = 0 then
        -- Invalid Faction 1094 -> 32 (Beast)
        UPDATE `creature_template` SET `faction` = '32' WHERE (`entry` = '330');
        UPDATE `creature_template` SET `faction` = '32' WHERE (`entry` = '390');
        UPDATE `creature_template` SET `faction` = '32' WHERE (`entry` = '708');
        UPDATE `creature_template` SET `faction` = '32' WHERE (`entry` = '1190');
        insert into applied_updates values ('131620221');
    end if;

    -- 19/06/2022 1 - 3810 ItemUpdates
    if (select count(*) from applied_updates where id='190620221') = 0 then
        -- Cold Steel Gauntlets
        -- buy_price, from 113 to 117
        -- sell_price, from 22 to 23
        UPDATE `item_template` SET `buy_price` = 117, `sell_price` = 23 WHERE (`entry` = 6063);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6063, 3810);
        -- Jackseed Belt
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `stat_value1` = 10 WHERE (`entry` = 10820);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10820, 3810);
        -- Veteran Gloves
        -- quality, from 2 to 1
        -- buy_price, from 1385 to 627
        -- sell_price, from 277 to 125
        -- item_level, from 17 to 15
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 627, `sell_price` = 125, `item_level` = 15 WHERE (`entry` = 2980);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2980, 3810);
        -- Raw Brilliant Smallfish
        -- buy_price, from 25 to 20
        UPDATE `item_template` SET `buy_price` = 20 WHERE (`entry` = 6291);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6291, 3810);
        -- Cadet Cloak
        -- subclass, from 1 to 3
        -- display_id, from 25960 to 15041
        -- buy_price, from 294 to 444
        -- sell_price, from 58 to 88
        -- material, from 7 to 5
        UPDATE `item_template` SET `subclass` = 3, `display_id` = 15041, `buy_price` = 444, `sell_price` = 88, `material` = 5 WHERE (`entry` = 9761);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9761, 3810);
        -- Scout's Cloak
        -- buy_price, from 672 to 430
        -- sell_price, from 134 to 86
        -- item_level, from 13 to 11
        -- material, from 7 to 5
        UPDATE `item_template` SET `buy_price` = 430, `sell_price` = 86, `item_level` = 11, `material` = 5 WHERE (`entry` = 5618);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5618, 3810);
        -- Soft Wool Boots
        -- buy_price, from 15 to 35
        -- sell_price, from 3 to 7
        UPDATE `item_template` SET `buy_price` = 35, `sell_price` = 7 WHERE (`entry` = 4915);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4915, 3810);
        -- Linen Belt
        -- buy_price, from 105 to 111
        -- sell_price, from 21 to 22
        UPDATE `item_template` SET `buy_price` = 111, `sell_price` = 22 WHERE (`entry` = 7026);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (7026, 3810);
        -- Jester's Shoes
        -- display_id, from 27532 to 16563
        UPDATE `item_template` SET `display_id` = 16563 WHERE (`entry` = 9743);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9743, 3810);
        -- Stinging Mace
        -- display_id, from 5410 to 5009
        -- dmg_max1, from 16.0 to 15
        -- material, from 2 to 1
        UPDATE `item_template` SET `display_id` = 5009, `dmg_max1` = 15, `material` = 1 WHERE (`entry` = 4948);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4948, 3810);
        -- Nomadic Belt
        -- buy_price, from 13 to 30
        -- sell_price, from 2 to 6
        UPDATE `item_template` SET `buy_price` = 30, `sell_price` = 6 WHERE (`entry` = 4954);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4954, 3810);
        -- Demon Scarred Cloak
        -- item_level, from 12 to 11
        UPDATE `item_template` SET `item_level` = 11 WHERE (`entry` = 4854);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4854, 3810);
        -- Painted Chain Belt
        -- buy_price, from 23 to 35
        -- sell_price, from 4 to 7
        UPDATE `item_template` SET `buy_price` = 35, `sell_price` = 7 WHERE (`entry` = 4913);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4913, 3810);
        -- Painted Chain Gloves
        -- buy_price, from 16 to 38
        -- sell_price, from 3 to 7
        UPDATE `item_template` SET `buy_price` = 38, `sell_price` = 7 WHERE (`entry` = 4910);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4910, 3810);
        -- Kodo Hunter's Leggings
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 4 WHERE (`entry` = 4909);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4909, 3810);
        -- Cadet Gauntlets
        -- display_id, from 22686 to 12299
        UPDATE `item_template` SET `display_id` = 12299 WHERE (`entry` = 9762);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9762, 3810);
        -- Nomadic Gloves
        -- display_id, from 12415 to 7823
        -- buy_price, from 30 to 29
        -- sell_price, from 6 to 5
        UPDATE `item_template` SET `display_id` = 7823, `buy_price` = 29, `sell_price` = 5 WHERE (`entry` = 10636);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10636, 3810);
        -- Small Tomahawk
        -- dmg_min1, from 9.0 to 3
        -- dmg_max1, from 14.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 2498);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2498, 3810);
        -- Ornate Blunderbuss
        -- dmg_min1, from 7.0 to 4
        -- dmg_max1, from 11.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 2509);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2509, 3810);
        -- Ceremonial Tomahawk
        -- dmg_min1, from 5.0 to 4
        -- dmg_max1, from 10.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 3443);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3443, 3810);
        -- Dreamwatcher Staff
        -- dmg_min1, from 15.0 to 12
        -- dmg_max1, from 23.0 to 18
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 18 WHERE (`entry` = 4961);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4961, 3810);
        -- Nomadic Vest
        -- buy_price, from 43 to 65
        -- sell_price, from 8 to 13
        UPDATE `item_template` SET `buy_price` = 65, `sell_price` = 13 WHERE (`entry` = 6059);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6059, 3810);
        -- Nomadic Bracers
        -- buy_price, from 21 to 32
        -- sell_price, from 4 to 6
        UPDATE `item_template` SET `buy_price` = 32, `sell_price` = 6 WHERE (`entry` = 4908);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4908, 3810);
        -- Cane of Elders
        -- dmg_min1, from 8.0 to 5
        -- dmg_max1, from 13.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 8 WHERE (`entry` = 5776);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5776, 3810);
        -- Painted Chain Leggings
        -- display_id, from 28230 to 5337
        -- buy_price, from 73 to 71
        UPDATE `item_template` SET `display_id` = 5337, `buy_price` = 71 WHERE (`entry` = 10635);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10635, 3810);
        -- Sun-beaten Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4958);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4958, 3810);
        -- Stone Tomahawk
        -- dmg_min1, from 3.0 to 2
        -- dmg_max1, from 6.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 1383);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1383, 3810);
        -- Sleek Feathered Tunic
        -- quality, from 1 to 2
        -- buy_price, from 275 to 596
        -- sell_price, from 55 to 119
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 596, `sell_price` = 119 WHERE (`entry` = 4861);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4861, 3810);
        -- Rambling Boots
        -- display_id, from 28241 to 21849
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 10
        UPDATE `item_template` SET `display_id` = 21849, `stat_type1` = 3, `stat_value1` = 3, `stat_type2` = 1, `stat_value2` = 10 WHERE (`entry` = 11853);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11853, 3810);
        -- Bounty Hunter's Ring
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `stat_value1` = 4 WHERE (`entry` = 5351);
        UPDATE `applied_item_updates` SET `entry` = 5351, `version` = 3810 WHERE (`entry` = 5351);
        -- Barkeeper's Cloak
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 15
        -- material, from 7 to 5
        UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 15, `material` = 5 WHERE (`entry` = 5343);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5343, 3810);
        -- Short Bastard Sword
        -- buy_price, from 3168 to 5247
        -- sell_price, from 633 to 1049
        -- dmg_min1, from 17.0 to 20
        -- dmg_max1, from 27.0 to 31
        UPDATE `item_template` SET `buy_price` = 5247, `sell_price` = 1049, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 4567);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4567, 3810);
        -- Dwarven Mild
        -- display_id, from 6372 to 6352
        UPDATE `item_template` SET `display_id` = 6352 WHERE (`entry` = 422);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (422, 3810);
        -- Stormwind Brie
        -- buy_price, from 1250 to 1000
        UPDATE `item_template` SET `buy_price` = 1000 WHERE (`entry` = 1707);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1707, 3810);
        -- Rugged Mail Vest
        -- buy_price, from 51 to 77
        -- sell_price, from 10 to 15
        UPDATE `item_template` SET `buy_price` = 77, `sell_price` = 15 WHERE (`entry` = 3273);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3273, 3810);
        -- Rustmetal Bracers
        -- buy_price, from 38 to 35
        -- armor, from 29 to 12
        -- material, from 5 to 7
        UPDATE `item_template` SET `buy_price` = 35, `armor` = 12, `material` = 7 WHERE (`entry` = 11849);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11849, 3810);
        -- Bandit Shoulders
        -- buy_price, from 2045 to 2019
        -- sell_price, from 409 to 403
        UPDATE `item_template` SET `buy_price` = 2019, `sell_price` = 403 WHERE (`entry` = 10405);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10405, 3810);
        -- Stretched Leather Trousers
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 3 WHERE (`entry` = 2818);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2818, 3810);
        -- Talonstrike
        -- dmg_max1, from 22.0 to 21
        UPDATE `item_template` SET `dmg_max1` = 21 WHERE (`entry` = 3462);
        UPDATE `applied_item_updates` SET `entry` = 3462, `version` = 3810 WHERE (`entry` = 3462);
        -- Cadet Bracers
        -- display_id, from 22685 to 6894
        -- buy_price, from 367 to 336
        -- sell_price, from 73 to 67
        UPDATE `item_template` SET `display_id` = 6894, `buy_price` = 336, `sell_price` = 67 WHERE (`entry` = 9760);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (9760, 3810);
        -- Whispering Vest
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `stat_value1` = 9 WHERE (`entry` = 4781);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4781, 3810);
        -- Apothecary Gloves
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `stat_value1` = 4 WHERE (`entry` = 10919);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (10919, 3810);
        -- Guardian Buckler
        -- buy_price, from 6760 to 8320
        -- sell_price, from 1352 to 1664
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `subclass` = 6, `buy_price` = 8320, `sell_price` = 1664, `stat_type1` = 6, `stat_value1` = 5 WHERE (`entry` = 4820);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (4820, 3810);
        -- Seer's Robe
        -- buy_price, from 4213 to 3242
        -- sell_price, from 842 to 648
        -- item_level, from 23 to 21
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `buy_price` = 3242, `sell_price` = 648, `item_level` = 21, `stat_type1` = 6, `stat_value1` = 9 WHERE (`entry` = 2981);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2981, 3810);
        -- Canvas Pants
        -- armor, from 9 to 36
        UPDATE `item_template` SET `armor` = 36 WHERE (`entry` = 1768);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1768, 3810);
        -- Flax Vest
        -- buy_price, from 33 to 51
        -- sell_price, from 6 to 10
        UPDATE `item_template` SET `buy_price` = 51, `sell_price` = 10 WHERE (`entry` = 3270);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (3270, 3810);
        -- Flax Bracers
        -- buy_price, from 15 to 24
        -- sell_price, from 3 to 4
        UPDATE `item_template` SET `buy_price` = 24, `sell_price` = 4 WHERE (`entry` = 6060);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (6060, 3810);
        -- Scavenger Tunic
        -- display_id, from 28249 to 8701
        UPDATE `item_template` SET `display_id` = 8701 WHERE (`entry` = 11851);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11851, 3810);
        -- Flax Belt
        -- display_id, from 28170 to 16799
        -- buy_price, from 26 to 23
        -- sell_price, from 5 to 4
        -- armor, from 6 to 4
        UPDATE `item_template` SET `display_id` = 16799, `buy_price` = 23, `sell_price` = 4, `armor` = 4 WHERE (`entry` = 11848);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (11848, 3810);
        -- Blue Linen Robe
        -- stat_type1, from 0 to 6
        UPDATE `item_template` SET `stat_type1` = 6 WHERE (`entry` = 6242);
        UPDATE `applied_item_updates` SET `entry` = 6242, `version` = 3810 WHERE (`entry` = 6242);

        -- Creatures display ids from 3810 sniffs which are lower than current display ids.
        UPDATE `creature_template` SET `display_id1` = '969' WHERE (`entry` = '3116');
        UPDATE `creature_template` SET `display_id1` = '970' WHERE (`entry` = '3118');
        UPDATE `creature_template` SET `display_id1` = '1027' WHERE (`entry` = '3150');
        UPDATE `creature_template` SET `display_id1` = '1057' WHERE (`entry` = '3243');
        UPDATE `creature_template` SET `display_id1` = '3805' WHERE (`entry` = '3079');
        UPDATE `creature_template` SET `display_id1` = '1904' WHERE (`entry` = '3224');
        UPDATE `creature_template` SET `display_id1` = '2572' WHERE (`entry` = '4200');
        UPDATE `creature_template` SET `display_id1` = '3029' WHERE (`entry` = '2033');
        UPDATE `creature_template` SET `display_id1` = '6805' WHERE (`entry` = '2043');
        UPDATE `creature_template` SET `display_id1` = '7630' WHERE (`entry` = '8398');

        -- Invalid Faction 514 -> 60 (Monster)
        UPDATE `creature_template` SET `faction` = '60' WHERE (`faction` = '514');
        -- Invalid Faction 413 -> 60 (Monster)
        UPDATE `creature_template` SET `faction` = '60' WHERE (`faction` = '413');
        -- Invalid Faction 554 -> 60 (Monster)
        UPDATE `creature_template` SET `faction` = '60' WHERE (`faction` = '554');
        

        -- 1.2 display ids not touching updates from WDB files.

        -- Brawler Gloves
        -- DisplayID from 3143 to 2368
        UPDATE `item_template` SET `display_id` = 2368 WHERE (`entry` = 720);
        -- Vendetta
        -- DisplayID from 6476 to 6452
        UPDATE `item_template` SET `display_id` = 6452 WHERE (`entry` = 776);
        -- Spiked Star
        -- DisplayID from 5199 to 4351
        UPDATE `item_template` SET `display_id` = 4351 WHERE (`entry` = 925);
        -- Scroll of Stamina
        -- DisplayID from 6270 to 1093
        UPDATE `item_template` SET `display_id` = 1093 WHERE (`entry` = 1180);
        -- Butcher's Cleaver
        -- DisplayID from 10808 to 8466
        UPDATE `item_template` SET `display_id` = 8466 WHERE (`entry` = 1292);
        -- Gloomshroud Armor
        -- DisplayID from 9123 to 8676
        UPDATE `item_template` SET `display_id` = 8676 WHERE (`entry` = 1489);
        -- Rawhide Gloves
        -- DisplayID from 3848 to 972
        UPDATE `item_template` SET `display_id` = 972 WHERE (`entry` = 1791);
        -- Stonemason Trousers
        -- DisplayID from 6780 to 6774
        UPDATE `item_template` SET `display_id` = 6774 WHERE (`entry` = 1934);
        -- Petrified Shinbone
        -- DisplayID from 2836 to 1515
        UPDATE `item_template` SET `display_id` = 1515 WHERE (`entry` = 1958);
        -- Anvilmar Hand Axe
        -- DisplayID from 8475 to 8473
        UPDATE `item_template` SET `display_id` = 8473 WHERE (`entry` = 2047);
        -- Russet Boots
        -- DisplayID from 3750 to 1861
        UPDATE `item_template` SET `display_id` = 1861 WHERE (`entry` = 2432);
        -- Minor Rejuvenation Potion
        -- DisplayID from 2350 to 2345
        UPDATE `item_template` SET `display_id` = 2345 WHERE (`entry` = 2456);
        -- Ravager's Skull
        -- DisplayID from 23527 to 1504
        UPDATE `item_template` SET `display_id` = 1504 WHERE (`entry` = 2477);
        -- Recipe: Elixir of Minor Agility
        -- DisplayID from 6270 to 1301
        UPDATE `item_template` SET `display_id` = 1301 WHERE (`entry` = 2553);
        -- Rough Bronze Leggings
        -- DisplayID from 9391 to 4333
        UPDATE `item_template` SET `display_id` = 4333 WHERE (`entry` = 2865);
        -- Inscribed Leather Pants
        -- DisplayID from 11584 to 11369
        UPDATE `item_template` SET `display_id` = 11369 WHERE (`entry` = 2986);
        -- Scroll of Agility
        -- DisplayID from 6409 to 3331
        UPDATE `item_template` SET `display_id` = 3331 WHERE (`entry` = 3012);
        -- Shadowgem Shard
        -- DisplayID from 6689 to 3307
        UPDATE `item_template` SET `display_id` = 3307 WHERE (`entry` = 3176);
        -- Tiny Fang
        -- DisplayID from 6688 to 6651
        UPDATE `item_template` SET `display_id` = 6651 WHERE (`entry` = 3177);
        -- Dense Triangle Mace
        -- DisplayID from 5528 to 5228
        UPDATE `item_template` SET `display_id` = 5228 WHERE (`entry` = 3203);
        -- Khadgar's Whisker
        -- DisplayID from 7378 to 6661
        UPDATE `item_template` SET `display_id` = 6661 WHERE (`entry` = 3358);
        -- Daryl's Shortsword
        -- DisplayID from 8277 to 5151
        UPDATE `item_template` SET `display_id` = 5151 WHERE (`entry` = 3572);
        -- Padded Cloth Bracers
        -- DisplayID from 3895 to 3645
        UPDATE `item_template` SET `display_id` = 3645 WHERE (`entry` = 3592);
        -- Russet Bracers
        -- DisplayID from 3896 to 3740
        UPDATE `item_template` SET `display_id` = 3740 WHERE (`entry` = 3594);
        -- Blackforge Leggings
        -- DisplayID from 11631 to 3409
        UPDATE `item_template` SET `display_id` = 3409 WHERE (`entry` = 4084);
        -- Cured Light Hide
        -- DisplayID from 6655 to 5086
        UPDATE `item_template` SET `display_id` = 5086 WHERE (`entry` = 4231);
        -- Cured Medium Hide
        -- DisplayID from 7348 to 7112
        UPDATE `item_template` SET `display_id` = 7112 WHERE (`entry` = 4233);
        -- Cured Heavy Hide
        -- DisplayID from 7347 to 3164
        UPDATE `item_template` SET `display_id` = 3164 WHERE (`entry` = 4236);
        -- Pattern: Rich Purple Silk Shirt
        -- DisplayID from 6270 to 1102
        UPDATE `item_template` SET `display_id` = 1102 WHERE (`entry` = 4354);
        -- Heavy Blasting Powder
        -- DisplayID from 7372 to 1297
        UPDATE `item_template` SET `display_id` = 1297 WHERE (`entry` = 4377);
        -- Big Iron Bomb
        -- DisplayID from 7627 to 7624
        UPDATE `item_template` SET `display_id` = 7624 WHERE (`entry` = 4394);
        -- Brittle Dragon Bone
        -- DisplayID from 18072 to 6663
        UPDATE `item_template` SET `display_id` = 6663 WHERE (`entry` = 4459);
        -- Corroded Black Box
        -- DisplayID from 20913 to 7074
        UPDATE `item_template` SET `display_id` = 7074 WHERE (`entry` = 4613);
        -- Throwing Tomahawk
        -- DisplayID from 16760 to 5416
        UPDATE `item_template` SET `display_id` = 5416 WHERE (`entry` = 4959);
        -- Compact Fighting Knife
        -- DisplayID from 6432 to 3006
        UPDATE `item_template` SET `display_id` = 3006 WHERE (`entry` = 4974);
        -- Scarlet Kris
        -- DisplayID from 6249 to 3363
        UPDATE `item_template` SET `display_id` = 3363 WHERE (`entry` = 5267);
        -- Sillithid Ichor
        -- DisplayID from 3325 to 2885
        UPDATE `item_template` SET `display_id` = 2885 WHERE (`entry` = 5269);
        -- Elven Cup Relic
        -- DisplayID from 18061 to 13989
        UPDATE `item_template` SET `display_id` = 13989 WHERE (`entry` = 5330);
        -- Small Barnacled Clam
        -- DisplayID from 8047 to 7177
        UPDATE `item_template` SET `display_id` = 7177 WHERE (`entry` = 5523);
        -- Goblin Deviled Clams
        -- DisplayID from 8050 to 7177
        UPDATE `item_template` SET `display_id` = 7177 WHERE (`entry` = 5527);
        -- Steadfast Cinch
        -- DisplayID from 8419 to 6755
        UPDATE `item_template` SET `display_id` = 6755 WHERE (`entry` = 5609);
        -- Primitive Walking Stick
        -- DisplayID from 8904 to 5404
        UPDATE `item_template` SET `display_id` = 5404 WHERE (`entry` = 5778);
        -- Dwarven Kite Shield
        -- DisplayID from 10366 to 3725
        UPDATE `item_template` SET `display_id` = 3725 WHERE (`entry` = 6176);
        -- Loch Croc Hide Vest
        -- DisplayID from 10528 to 2644
        UPDATE `item_template` SET `display_id` = 2644 WHERE (`entry` = 6197);
        -- Arclight Spanner
        -- DisplayID from 10657 to 7494
        UPDATE `item_template` SET `display_id` = 7494 WHERE (`entry` = 6219);
        -- Sickly Looking Fish
        -- DisplayID from 24696 to 11210
        UPDATE `item_template` SET `display_id` = 11210 WHERE (`entry` = 6299);
        -- Rough Bronze Boots
        -- DisplayID from 7003 to 6885
        UPDATE `item_template` SET `display_id` = 6885 WHERE (`entry` = 6350);
        -- Oily Blackmouth
        -- DisplayID from 11450 to 9150
        UPDATE `item_template` SET `display_id` = 9150 WHERE (`entry` = 6358);
        -- Bloated Mud Snapper
        -- DisplayID from 24694 to 4809
        UPDATE `item_template` SET `display_id` = 4809 WHERE (`entry` = 6645);
        -- Broken Wine Bottle
        -- DisplayID from 18652 to 12710
        UPDATE `item_template` SET `display_id` = 12710 WHERE (`entry` = 6651);
        -- Crimson Silk Shoulders
        -- DisplayID from 13673 to 13672
        UPDATE `item_template` SET `display_id` = 13672 WHERE (`entry` = 7059);
        -- Infiltrator Shoulders
        -- DisplayID from 11578 to 11270
        UPDATE `item_template` SET `display_id` = 11270 WHERE (`entry` = 7408);
        -- Sentinel Shoulders
        -- DisplayID from 15002 to 5414
        UPDATE `item_template` SET `display_id` = 5414 WHERE (`entry` = 7445);
        -- Regal Star
        -- DisplayID from 15425 to 6098
        UPDATE `item_template` SET `display_id` = 6098 WHERE (`entry` = 7555);
        -- Light Plate Boots
        -- DisplayID from 28404 to 6947
        UPDATE `item_template` SET `display_id` = 6947 WHERE (`entry` = 8082);
        -- Light Plate Bracers
        -- DisplayID from 9388 to 6948
        UPDATE `item_template` SET `display_id` = 6948 WHERE (`entry` = 8083);
        -- Mercurial Breastplate
        -- DisplayID from 26123 to 11624
        UPDATE `item_template` SET `display_id` = 11624 WHERE (`entry` = 10157);
        -- Solid Blasting Powder
        -- DisplayID from 31324 to 6412
        UPDATE `item_template` SET `display_id` = 6412 WHERE (`entry` = 10505);
        -- Cragwood Maul
        -- DisplayID from 28629 to 4791
        UPDATE `item_template` SET `display_id` = 4791 WHERE (`entry` = 11265);
        -- Lar'korwi's Head
        -- DisplayID from 30111 to 9150
        UPDATE `item_template` SET `display_id` = 9150 WHERE (`entry` = 11510);
        -- Boulderskin Breastplate
        -- DisplayID from 28089 to 8638
        UPDATE `item_template` SET `display_id` = 8638 WHERE (`entry` = 12106);
        -- Tender Wolf Meat
        -- DisplayID from 6680 to 2599
        UPDATE `item_template` SET `display_id` = 2599 WHERE (`entry` = 12208);
        -- Horizon Choker
        -- DisplayID from 9858 to 9657
        UPDATE `item_template` SET `display_id` = 9657 WHERE (`entry` = 13085);
        -- Diablo Stone
        -- DisplayID from 34364 to 6689
        UPDATE `item_template` SET `display_id` = 6689 WHERE (`entry` = 13584);
        -- Pattern: Living Leggings
        -- DisplayID from 6270 to 1102
        UPDATE `item_template` SET `display_id` = 1102 WHERE (`entry` = 15752);
        -- Pattern: Devilsaur Leggings
        -- DisplayID from 6270 to 1102
        UPDATE `item_template` SET `display_id` = 1102 WHERE (`entry` = 15772);

        -- 1.2 Creatures display ids, these fix many cubes.
        -- Condition to update (new model do not exist on displayid1,2,3,4 and is lower than current)

        -- Mine Spider
        -- DisplayID from 711 to 368
        UPDATE `creature_template` SET `display_id1` = 368 WHERE (`entry` = 43);
        -- Murloc Forager
        -- DisplayID from 504 to 441
        UPDATE `creature_template` SET `display_id1` = 441 WHERE (`entry` = 46);
        -- Kobold Laborer
        -- DisplayID from 373 to 365
        UPDATE `creature_template` SET `display_id1` = 365 WHERE (`entry` = 80);
        -- Venom Web Spider
        -- DisplayID from 959 to 955
        UPDATE `creature_template` SET `display_id1` = 955 WHERE (`entry` = 217);
        -- Brown Horse
        -- DisplayID from 2404 to 229
        UPDATE `creature_template` SET `display_id1` = 229 WHERE (`entry` = 284);
        -- Porcine Entourage
        -- DisplayID from 477 to 377
        UPDATE `creature_template` SET `display_id1` = 377 WHERE (`entry` = 390);
        -- Black Dragon Whelp
        -- DisplayID from 497 to 387
        UPDATE `creature_template` SET `display_id1` = 387 WHERE (`entry` = 441);
        -- Tarantula
        -- DisplayID from 2542 to 366
        UPDATE `creature_template` SET `display_id1` = 366 WHERE (`entry` = 442);
        -- Hogger
        -- DisplayID from 501 to 384
        UPDATE `creature_template` SET `display_id1` = 384 WHERE (`entry` = 448);
        -- Murloc Minor Oracle
        -- DisplayID from 504 to 486
        UPDATE `creature_template` SET `display_id1` = 486 WHERE (`entry` = 456);
        -- Murloc Raider
        -- DisplayID from 527 to 441
        UPDATE `creature_template` SET `display_id1` = 441 WHERE (`entry` = 515);
        -- Yowler
        -- DisplayID from 609 to 488
        UPDATE `creature_template` SET `display_id1` = 488 WHERE (`entry` = 518);
        -- Undead Dynamiter
        -- DisplayID from 4020 to 829
        UPDATE `creature_template` SET `display_id1` = 829 WHERE (`entry` = 625);
        -- Black Ravager
        -- DisplayID from 780 to 741
        UPDATE `creature_template` SET `display_id1` = 741 WHERE (`entry` = 628);
        -- Sand Crawler
        -- DisplayID from 641 to 342
        UPDATE `creature_template` SET `display_id1` = 342 WHERE (`entry` = 830);
        -- Coyote Packleader
        -- DisplayID from 643 to 161
        UPDATE `creature_template` SET `display_id1` = 161 WHERE (`entry` = 833);
        -- Young Black Ravager
        -- DisplayID from 781 to 246
        UPDATE `creature_template` SET `display_id1` = 246 WHERE (`entry` = 923);
        -- Black Widow Hatchling
        -- DisplayID from 418 to 368
        UPDATE `creature_template` SET `display_id1` = 368 WHERE (`entry` = 930);
        -- Winter Wolf
        -- DisplayID from 801 to 785
        UPDATE `creature_template` SET `display_id1` = 785 WHERE (`entry` = 1131);
        -- Wendigo
        -- DisplayID from 1077 to 950
        UPDATE `creature_template` SET `display_id1` = 950 WHERE (`entry` = 1135);
        -- Stonesplinter Skullthumper
        -- DisplayID from 764 to 160
        UPDATE `creature_template` SET `display_id1` = 160 WHERE (`entry` = 1163);
        -- Stonesplinter Bonesnapper
        -- DisplayID from 764 to 722
        UPDATE `creature_template` SET `display_id1` = 722 WHERE (`entry` = 1164);
        -- Stonesplinter Geomancer
        -- DisplayID from 764 to 160
        UPDATE `creature_template` SET `display_id1` = 160 WHERE (`entry` = 1165);
        -- Stonesplinter Digger
        -- DisplayID from 765 to 722
        UPDATE `creature_template` SET `display_id1` = 722 WHERE (`entry` = 1167);
        -- Mo'grosh Ogre
        -- DisplayID from 1122 to 740
        UPDATE `creature_template` SET `display_id1` = 740 WHERE (`entry` = 1178);
        -- Mo'grosh Enforcer
        -- DisplayID from 1051 to 645
        UPDATE `creature_template` SET `display_id1` = 645 WHERE (`entry` = 1179);
        -- Cliff Lurker
        -- DisplayID from 909 to 827
        UPDATE `creature_template` SET `display_id1` = 827 WHERE (`entry` = 1184);
        -- Wood Lurker
        -- DisplayID from 910 to 520
        UPDATE `creature_template` SET `display_id1` = 520 WHERE (`entry` = 1185);
        -- Elder Black Bear
        -- DisplayID from 762 to 707
        UPDATE `creature_template` SET `display_id1` = 707 WHERE (`entry` = 1186);
        -- Forest Lurker
        -- DisplayID from 909 to 827
        UPDATE `creature_template` SET `display_id1` = 827 WHERE (`entry` = 1195);
        -- Stonesplinter Shaman
        -- DisplayID from 764 to 763
        UPDATE `creature_template` SET `display_id1` = 763 WHERE (`entry` = 1197);
        -- Gnasher
        -- DisplayID from 765 to 721
        UPDATE `creature_template` SET `display_id1` = 721 WHERE (`entry` = 1206);
        -- Brawler
        -- DisplayID from 765 to 721
        UPDATE `creature_template` SET `display_id1` = 721 WHERE (`entry` = 1207);
        -- Ol' Sooty
        -- DisplayID from 739 to 706
        UPDATE `creature_template` SET `display_id1` = 706 WHERE (`entry` = 1225);
        -- White Ram
        -- DisplayID from 10003 to 2786
        UPDATE `creature_template` SET `display_id1` = 2786 WHERE (`entry` = 1262);
        -- Goli Krumn
        -- DisplayID from 14092 to 2584
        UPDATE `creature_template` SET `display_id1` = 2584 WHERE (`entry` = 1365);
        -- Berserk Trogg
        -- DisplayID from 765 to 721
        UPDATE `creature_template` SET `display_id1` = 721 WHERE (`entry` = 1393);
        -- Scarred Crag Boar
        -- DisplayID from 744 to 193
        UPDATE `creature_template` SET `display_id1` = 193 WHERE (`entry` = 1689);
        -- Elder Shadowmaw Panther
        -- DisplayID from 11452 to 613
        UPDATE `creature_template` SET `display_id1` = 613 WHERE (`entry` = 1713);
        -- Ferocious Grizzled Bear
        -- DisplayID from 1006 to 902
        UPDATE `creature_template` SET `display_id1` = 902 WHERE (`entry` = 1778);
        -- Lake Creeper
        -- DisplayID from 2567 to 1549
        UPDATE `creature_template` SET `display_id1` = 1549 WHERE (`entry` = 1955);
        -- Webwood Spider
        -- DisplayID from 760 to 709
        UPDATE `creature_template` SET `display_id1` = 709 WHERE (`entry` = 1986);
        -- Githyiss the Vile
        -- DisplayID from 760 to 759
        UPDATE `creature_template` SET `display_id1` = 759 WHERE (`entry` = 1994);
        -- Webwood Venomfang
        -- DisplayID from 760 to 759
        UPDATE `creature_template` SET `display_id1` = 759 WHERE (`entry` = 1999);
        -- Feral Nightsaber
        -- DisplayID from 3030 to 3029
        UPDATE `creature_template` SET `display_id1` = 3029 WHERE (`entry` = 2034);
        -- Nightsaber Stalker
        -- DisplayID from 6805 to 3030
        UPDATE `creature_template` SET `display_id1` = 3030 WHERE (`entry` = 2043);
        -- Grizzled Thistle Bear
        -- DisplayID from 14316 to 982
        UPDATE `creature_template` SET `display_id1` = 982 WHERE (`entry` = 2165);
        -- Crushridge Plunderer
        -- DisplayID from 415 to 154
        UPDATE `creature_template` SET `display_id1` = 154 WHERE (`entry` = 2416);
        -- Geomancer Flintdagger
        -- DisplayID from 10911 to 511
        UPDATE `creature_template` SET `display_id1` = 511 WHERE (`entry` = 2609);
        -- Buzzard
        -- DisplayID from 1105 to 388
        UPDATE `creature_template` SET `display_id1` = 388 WHERE (`entry` = 2830);
        -- Palemane Skinner
        -- DisplayID from 1887 to 1216
        UPDATE `creature_template` SET `display_id1` = 1216 WHERE (`entry` = 2950);
        -- Dark Strand Enforcer
        -- DisplayID from 4225 to 1643
        UPDATE `creature_template` SET `display_id1` = 1643 WHERE (`entry` = 3727);
        -- Giant Ashenvale Bear
        -- DisplayID from 14315 to 1990
        UPDATE `creature_template` SET `display_id1` = 1990 WHERE (`entry` = 3811);
        -- Shadowfang Ragetooth
        -- DisplayID from 736 to 412
        UPDATE `creature_template` SET `display_id1` = 412 WHERE (`entry` = 3859);
        -- Deepmoss Venomspitter
        -- DisplayID from 760 to 759
        UPDATE `creature_template` SET `display_id1` = 759 WHERE (`entry` = 4007);
        -- Galak Pack Runner
        -- DisplayID from 9413 to 2292
        UPDATE `creature_template` SET `display_id1` = 2292 WHERE (`entry` = 4098);
        -- Chestnut Mare
        -- DisplayID from 2405 to 215
        UPDATE `creature_template` SET `display_id1` = 215 WHERE (`entry` = 4269);
        -- Odo the Blindwatcher
        -- DisplayID from 522 to 412
        UPDATE `creature_template` SET `display_id1` = 412 WHERE (`entry` = 4279);
        -- Drywallow Snapper
        -- DisplayID from 814 to 807
        UPDATE `creature_template` SET `display_id1` = 807 WHERE (`entry` = 4343);
        -- Bloodfen Lashtail
        -- DisplayID from 2574 to 2573
        UPDATE `creature_template` SET `display_id1` = 2573 WHERE (`entry` = 4357);
        -- Mazzer Stripscrew
        -- DisplayID from 10982 to 2581
        UPDATE `creature_template` SET `display_id1` = 2581 WHERE (`entry` = 4446);
        -- Sandstrider
        -- DisplayID from 6076 to 2741
        UPDATE `creature_template` SET `display_id1` = 2741 WHERE (`entry` = 4724);
        -- Stockade Archer
        -- DisplayID from 2992 to 2989
        UPDATE `creature_template` SET `display_id1` = 2989 WHERE (`entry` = 6237);
        -- Crawler
        -- DisplayID from 1249 to 641
        UPDATE `creature_template` SET `display_id1` = 641 WHERE (`entry` = 6250);
        -- Black Nightsaber
        -- DisplayID from 9991 to 613
        UPDATE `creature_template` SET `display_id1` = 613 WHERE (`entry` = 7322);
        -- Soaring Razorbeak
        -- DisplayID from 1279 to 1149
        UPDATE `creature_template` SET `display_id1` = 1149 WHERE (`entry` = 8276);
        -- Scald
        -- DisplayID from 1551 to 1204
        UPDATE `creature_template` SET `display_id1` = 1204 WHERE (`entry` = 8281);
        -- Nightmare Whelp
        -- DisplayID from 3440 to 621
        UPDATE `creature_template` SET `display_id1` = 621 WHERE (`entry` = 8319);
        -- Scarshield Worg
        -- DisplayID from 11420 to 741
        UPDATE `creature_template` SET `display_id1` = 741 WHERE (`entry` = 9416);
        -- Demon Portal Guardian
        -- DisplayID from 9017 to 1912
        UPDATE `creature_template` SET `display_id1` = 1912 WHERE (`entry` = 11937);
        -- Sickly Gazelle
        -- DisplayID from 14951 to 1547
        UPDATE `creature_template` SET `display_id1` = 1547 WHERE (`entry` = 12296);
        -- Thamarian
        -- DisplayID from 14954 to 1701
        UPDATE `creature_template` SET `display_id1` = 1701 WHERE (`entry` = 12656);
        -- Hraug
        -- DisplayID from 14371 to 3755
        UPDATE `creature_template` SET `display_id1` = 3755 WHERE (`entry` = 12776);
        -- Willow
        -- DisplayID from 13909 to 2874
        UPDATE `creature_template` SET `display_id1` = 2874 WHERE (`entry` = 13656);
        -- Wolf Master Nandos
        -- DisplayID from 11179 to 522
        UPDATE `creature_template` SET `display_id1` = 522 WHERE (`entry` = 3927);

        insert into applied_updates values ('190620221');
    end if;
    
    -- 25/06/2022 1
    if (select count(*) from applied_updates where id='250620221') = 0 then
        DROP TABLE IF EXISTS `areatrigger_involvedrelation`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!40101 SET character_set_client = utf8 */;
        CREATE TABLE `areatrigger_involvedrelation` (
          `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
          `quest` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
          PRIMARY KEY (`id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Trigger System';
        /*!40101 SET character_set_client = @saved_cs_client */;

        /*!40000 ALTER TABLE `areatrigger_involvedrelation` DISABLE KEYS */;
        INSERT INTO `areatrigger_involvedrelation` VALUES (362,1448),(231,984),(230,954),(223,944),(216,870),(196,578),(97,287),(98,201),(78,155),(178,503),(87,76),(88,62),(175,455),(246,1149),(232,984),(235,984),(197,62),(342,76),(173,437),(224,944),(225,944);
        /*!40000 ALTER TABLE `areatrigger_involvedrelation` ENABLE KEYS */;

        insert into applied_updates values ('250620221');
    end if;

    -- 06/07/2022 1
    if (select count(*) from applied_updates where id='060720221') = 0 then

        -- Creatures Faction, Scale, MinLevel, BaseAttackTime and RangedAttackTime.
        -- 3810 Sniffs.
        
        -- Entry: 416
        -- Name: Imp
        -- Scale, from 1 to 0.5
        UPDATE `creature_template` SET `scale` = '0.5' WHERE (`entry` = '516');
        -- Entry: 1571
        -- Name: Shellei Brondir
        -- Faction, from 11 to 12.       
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '1571');
        -- Entry: 3178
        -- Name: Stuart Fleming
        -- Faction, from 11 to 12.    
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '3178');
        -- Entry: 3179
        -- Name: Harold Riggs
        -- Faction, from 11 to 12.    
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '3179');
        -- Entry: 1481
        -- Name: Bart Tidewater
        -- Faction, from 11 to 12.    
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '1481');
        -- Entry: 1242
        -- Name: Karl Boran
        -- Faction, from 11 to 12.    
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '1242');
        -- Entry: 1451
        -- Name: Camerick Jongleur
        -- Faction, from 11 to 12.    
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '1451');
        -- Entry: 2094
        -- Name: James Halloran
        -- Faction, from 11 to 12.    
        UPDATE `creature_template` SET `faction` = '12' WHERE (`entry` = '2094');
        -- Entry: 1453
        -- Name: Dewin Shimmerdawn
        -- Faction, from 57 to 55.    
        UPDATE `creature_template` SET `faction` = '55' WHERE (`entry` = '1453');
        -- Entry: 3098
        -- Name: Mottled Boar
        -- Scale, from 0.0 to 0.6.
        -- RangedAttackTime, from 2200 to 2000.
        UPDATE `creature_template` SET `scale` = 0.6, `ranged_attack_time` = 2000 WHERE (`entry` = 3098);
        -- Entry: 5952
        -- Name: Den Grunt
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 1562 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 5952);
        -- Entry: 3144
        -- Name: Eitrigg
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 1991 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3144);
        -- Entry: 3143
        -- Name: Gornek
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2156 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3143);
        -- Entry: 3145
        -- Name: Zureetha Fargaze
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2079 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3145);
        -- Entry: 5887
        -- Name: Canaga Earthcaller
        -- Faction, from 125 to 29.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2123 to 2000.
        UPDATE `creature_template` SET `faction` = 29, `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 5887);
        -- Entry: 5765
        -- Name: Ruzan
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2101 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 5765);
        -- Entry: 9796
        -- Name: Galgar
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2123 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 9796);
        -- Entry: 3158
        -- Name: Duokna
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2101 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3158);
        -- Entry: 3153
        -- Name: Frang
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2090 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3153);
        -- Entry: 3154
        -- Name: Jen'shan
        -- Faction, from 125 to 29.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2123 to 2000.
        UPDATE `creature_template` SET `faction` = 29, `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3154);
        -- Entry: 3707
        -- Name: Ken'jai
        -- Faction, from 125 to 29.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2101 to 2000.
        UPDATE `creature_template` SET `faction` = 29, `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3707);
        -- Entry: 3157
        -- Name: Shikrik
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2101 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3157);
        -- Entry: 5884
        -- Name: Mai'ah
        -- Faction, from 125 to 29.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2101 to 2000.
        UPDATE `creature_template` SET `faction` = 29, `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 5884);
        -- Entry: 3882
        -- Name: Zlagk
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2112 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 3882);
        -- Entry: 2185
        -- Name: Darkshore Thresher
        -- Scale, from 0.0 to 1.05.
        UPDATE `creature_template` SET `scale` = 1.05 WHERE (`entry` = 2185);
        -- Entry: 6145
        -- Name: School of Fish
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 6145);
        -- Entry: 2231
        -- Name: Pygmy Tide Crawler
        -- Scale, from 0.0 to 0.75.
        UPDATE `creature_template` SET `scale` = 0.75 WHERE (`entry` = 2231);
        -- Entry: 6887
        -- Name: [PH] Haleh
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 6887);
        -- Entry: 4190
        -- Name: Kyndri
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4190);
        -- Entry: 4192
        -- Name: Taldan
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4192);
        -- Entry: 6737
        -- Name: Innkeeper Shaussiy
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 6737);
        -- Entry: 3841
        -- Name: Caylais Moonfeather
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        -- BaseAttackTime, from 1216 to 2000.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0, `base_attack_time` = 2000 WHERE (`entry` = 3841);
        -- Entry: 4200
        -- Name: Laird
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4200);
        -- Entry: 6086
        -- Name: Auberdine Sentinel
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 6086);
        -- Entry: 2163
        -- Name: Thistle Bear
        -- Scale, from 0.0 to 0.75.
        UPDATE `creature_template` SET `scale` = 0.75 WHERE (`entry` = 2163);
        -- Entry: 10085
        -- Name: Jaelysia
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 10085);
        -- Entry: 4191
        -- Name: Allyndia
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4191);
        -- Entry: 2033
        -- Name: Elder Nightsaber
        -- Scale, from 1.33 to 1.2.
        -- RangedAttackTime, from 2000 to 1400.
        UPDATE `creature_template` SET `scale` = 1.2, `ranged_attack_time` = 1400 WHERE (`entry` = 2033);
        -- Entry: 2043
        -- Name: Nightsaber Stalker
        -- Scale, from 0.0 to 0.9.
        -- RangedAttackTime, from 2000 to 1400.
        UPDATE `creature_template` SET `scale` = 0.9, `ranged_attack_time` = 1400 WHERE (`entry` = 2043);
        -- Entry: 2913
        -- Name: Archaeologist Hollee
        -- Faction, from 57 to 55.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 55, `scale` = 1.0 WHERE (`entry` = 2913);
        -- Entry: 4187
        -- Name: Harlon Thornguard
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4187);
        -- Entry: 2070
        -- Name: Moonstalker Runt
        -- Scale, from 0.0 to 0.65.
        -- RangedAttackTime, from 2000 to 1300.
        UPDATE `creature_template` SET `scale` = 0.65, `ranged_attack_time` = 1300 WHERE (`entry` = 2070);
        -- Entry: 3895
        -- Name: Captain Eo
        -- Faction, from 12 to 80.
        -- BaseAttackTime, from 0 to 2000.
        -- RangedAttackTime, from 0 to 2000.
        UPDATE `creature_template` SET `faction` = 80, `base_attack_time` = 2000, `ranged_attack_time` = 2000 WHERE (`entry` = 3895);
        -- Entry: 3583
        -- Name: Barithras Moonshade
        -- Faction, from 79 to 84.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 84, `scale` = 1.0 WHERE (`entry` = 3583);
        -- Entry: 3644
        -- Name: Cerellean Whiteclaw
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 3644);
        -- Entry: 3649
        -- Name: Thundris Windweaver
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 3649);
        -- Entry: 4186
        -- Name: Mavralyn
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4186);
        -- Entry: 2234
        -- Name: Young Reef Crawler
        -- Scale, from 0.0 to 0.75.
        -- DisplayID, from 999 to 997.
        UPDATE `creature_template` SET `scale` = 0.75, `display_id1` = 997 WHERE (`entry` = 2234);
        -- Entry: 3571
        -- Name: Teldrassil Sentinel
        -- Min Level, from 55 to 20.
        -- Max Level, from 55 to 20.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `level_min` = 20, `level_max` = 20, `scale` = 1.0 WHERE (`entry` = 3571);
        -- Entry: 3838
        -- Name: Vesprystus
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        -- BaseAttackTime, from 1216 to 2000.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0, `base_attack_time` = 2000 WHERE (`entry` = 3838);
        -- Entry: 2948
        -- Name: Mull Thunderhorn
        -- Faction, from 105 to 83.
        UPDATE `creature_template` SET `faction` = 83 WHERE (`entry` = 2948);
        -- Entry: 3064
        -- Name: Gennia Runetotem
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3064);
        -- Entry: 3066
        -- Name: Narm Skychaser
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3066);
        -- Entry: 3054
        -- Name: Zarlman Two-Moons
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3054);
        -- Entry: 2983
        -- Name: The Plains Vision
        -- Scale, from 0.0 to 0.8.
        UPDATE `creature_template` SET `scale` = 0.8 WHERE (`entry` = 2983);
        -- Entry: 2993
        -- Name: Baine Bloodhoof
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2993);
        -- Entry: 3052
        -- Name: Skorn Whitecloud
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3052);
        -- Entry: 10050
        -- Name: Seikwa
        -- Faction, from 85 to 29.
        UPDATE `creature_template` SET `faction` = 29 WHERE (`entry` = 10050);
        -- Entry: 3055
        -- Name: Maur Raincaller
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3055);
        -- Entry: 2620
        -- Name: Prairie Dog
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 2620);
        -- Entry: 3063
        -- Name: Krang Stonehoof
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3063);
        -- Entry: 2985
        -- Name: Ruul Eagletalon
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2985);
        -- Entry: 6776
        -- Name: Magrin Rivermane
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 6776);
        -- Entry: 3079
        -- Name: Varg Windwhisper
        -- Faction, from 105 to 104.
        -- Scale, from 1.35 to 1.25.
        UPDATE `creature_template` SET `faction` = 104, `scale` = 1.25 WHERE (`entry` = 3079);
        -- Entry: 5939
        -- Name: Vira Younghoof
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 5939);
        -- Entry: 3077
        -- Name: Mahnott Roughwound
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3077);
        -- Entry: 3080
        -- Name: Harant Ironbrace
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3080);
        -- Entry: 3884
        -- Name: Jhawna Oatwind
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3884);
        -- Entry: 3065
        -- Name: Yaw Sharpmane
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3065);
        -- Entry: 5940
        -- Name: Harn Longcast
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 5940);
        -- Entry: 3448
        -- Name: Tonga Runetotem
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3448);
        -- Entry: 3487
        -- Name: Kalyimah Stormcloud
        -- Faction, from 125 to 29.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 29, `scale` = 1.0 WHERE (`entry` = 3487);
        -- Entry: 3123
        -- Name: Bloodtalon Scythemaw
        -- Faction, from 48 to 14.
        -- Scale, from 0.0 to 0.65.
        UPDATE `creature_template` SET `faction` = 14, `scale` = 0.65 WHERE (`entry` = 3123);
        -- Entry: 4166
        -- Name: Gazelle
        -- Scale, from 0.0 to 0.9.
        UPDATE `creature_template` SET `scale` = 0.9 WHERE (`entry` = 4166);
        -- Entry: 3338
        -- Name: Sergra Darkthorn
        -- Min Level, from 60 to 34.
        -- Max Level, from 60 to 34.
        -- Faction, from 85 to 83.
        -- Scale, from 0.0 to 1.0.
        -- BaseAttackTime, from 1391 to 2000.
        UPDATE `creature_template` SET `level_min` = 34, `level_max` = 34, `faction` = 83, `scale` = 1.0, `base_attack_time` = 2000 WHERE (`entry` = 3338);
        -- Entry: 3501
        -- Name: Horde Guard
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3501);
        -- Entry: 3484
        -- Name: Kil'hala
        -- Min Level, from 25 to 15.
        -- Max Level, from 25 to 15.
        -- Faction, from 125 to 29.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `level_min` = 15, `level_max` = 15, `faction` = 29, `scale` = 1.0 WHERE (`entry` = 3484);
        -- Entry: 3485
        -- Name: Wrahk
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3485);
        -- Entry: 3244
        -- Name: Greater Plainstrider
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3244);
        -- Entry: 1860
        -- Name: Voidwalker
        -- Min Level, from 17 to 12.
        -- Max Level, from 17 to 12.
        -- Scale, from 0.0 to 0.8.
        UPDATE `creature_template` SET `level_min` = 12, `level_max` = 12, `scale` = 0.8 WHERE (`entry` = 1860);
        -- Entry: 3035
        -- Name: Flatland Cougar
        -- Scale, from 0.0 to 1.1.
        UPDATE `creature_template` SET `scale` = 1.1 WHERE (`entry` = 3035);
        -- Entry: 3433
        -- Name: Tatternack Steelforge
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3433);
        -- Entry: 3243
        -- Name: Savannah Highmane
        -- Scale, from 0.0 to 1.1.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 1.1, `ranged_attack_time` = 1500 WHERE (`entry` = 3243);
        -- Entry: 1934
        -- Name: Tirisfal Farmer
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 3200.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 3200 WHERE (`entry` = 1934);
        -- Entry: 1547
        -- Name: Decrepit Darkhound
        -- Scale, from 0.0 to 0.75.
        UPDATE `creature_template` SET `scale` = 0.75 WHERE (`entry` = 1547);
        -- Entry: 1553
        -- Name: Greater Duskbat
        -- Scale, from 0.42 to 0.55.
        UPDATE `creature_template` SET `scale` = 0.55 WHERE (`entry` = 1553);
        -- Entry: 1935
        -- Name: Tirisfal Farmhand
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 3200.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 3200 WHERE (`entry` = 1935);
        -- Entry: 620
        -- Name: Chicken
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 620);
        -- Entry: 1535
        -- Name: Scarlet Warrior
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1535);
        -- Entry: 1548
        -- Name: Cursed Darkhound
        -- Scale, from 0.0 to 0.9.
        UPDATE `creature_template` SET `scale` = 0.9 WHERE (`entry` = 1548);
        -- Entry: 1742
        -- Name: Deathguard Bartholomew
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1742);
        -- Entry: 1496
        -- Name: Deathguard Dillinger
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 1496);
        -- Entry: 4075
        -- Name: Rat
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 4075);
        -- Entry: 2314
        -- Name: Sahvan Bloodshadow
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 2314);
        -- Entry: 8398
        -- Name: Ohanko
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8398);
        -- Entry: 3021
        -- Name: Kard Ragetotem
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3021);
        -- Entry: 3023
        -- Name: Sura Wildmane
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3023);
        -- Entry: 3020
        -- Name: Etu Ragetotem
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3020);
        -- Entry: 5189
        -- Name: Thrumn
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 5189);
        -- Entry: 2996
        -- Name: Torn
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2996);
        -- Entry: 3003
        -- Name: Fyr Mistrunner
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 3003);
        -- Entry: 8356
        -- Name: Chesmu
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8356);
        -- Entry: 8364
        -- Name: Pakwa
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8364);
        -- Entry: 8360
        -- Name: Elki
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8360);
        -- Entry: 8363
        -- Name: Shadi Mistrunner
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8363);
        -- Entry: 3084
        -- Name: Bluffwatcher
        -- BaseAttackTime, from 1600 to 2000.
        UPDATE `creature_template` SET `base_attack_time` = 2000 WHERE (`entry` = 3084);
        -- Entry: 8359
        -- Name: Ahanu
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8359);
        -- Entry: 8358
        -- Name: Hewa
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8358);
        -- Entry: 8362
        -- Name: Kuruk
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8362);
        -- Entry: 2999
        -- Name: Taur Stonehoof
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2999);
        -- Entry: 8357
        -- Name: Atepa
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 8357);
        -- Entry: 2997
        -- Name: Jyn Stonehoof
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2997);
        -- Entry: 10054
        -- Name: Bulrug
        -- Scale, from 1.48 to 1.49.
        UPDATE `creature_template` SET `scale` = 1.49 WHERE (`entry` = 10054);
        -- Entry: 5054
        -- Name: Krumn
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 5054);
        -- Entry: 2998
        -- Name: Karn Stonehoof
        -- Faction, from 105 to 104.
        UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2998);
        -- Entry: 4455
        -- Name: Red Jack Flint
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 4455);
        -- Entry: 1571
        -- Name: Shellei Brondir
        -- Scale, from 0.0 to 1.0.
        -- BaseAttackTime, from 1216 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `base_attack_time` = 2000 WHERE (`entry` = 1571);
        -- Entry: 3178
        -- Name: Stuart Fleming
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 3178);
        -- Entry: 2099
        -- Name: Maiden's Virtue Crewman
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 2099);
        -- Entry: 3179
        -- Name: Harold Riggs
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 3179);
        -- Entry: 1481
        -- Name: Bart Tidewater
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1481);
        -- Entry: 1242
        -- Name: Karl Boran
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1242);
        -- Entry: 1434
        -- Name: Menethil Sentry
        -- Min Level, from 41 to 38.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `level_min` = 38, `scale` = 1.0 WHERE (`entry` = 1434);
        -- Entry: 1483
        -- Name: Murphy West
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1483);
        -- Entry: 1451
        -- Name: Camerick Jongleur
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 1451);
        -- Entry: 2094
        -- Name: James Halloran
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 2094);
        -- Entry: 1420
        -- Name: Toad
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1420);
        -- Entry: 1453
        -- Name: Dewin Shimmerdawn
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 1453);
        -- Entry: 1454
        -- Name: Jennabink Powerseam
        -- Faction, from 64 to 12.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `faction` = 12, `ranged_attack_time` = 1500 WHERE (`entry` = 1454);
        -- Entry: 2104
        -- Name: Captain Stoutfist
        -- Faction, from 57 to 55.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 55, `scale` = 1.0 WHERE (`entry` = 2104);
        -- Entry: 1463
        -- Name: Falkan Armonis
        -- Faction, from 11 to 12.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `faction` = 12, `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 1463);
        -- Entry: 1458
        -- Name: Telurinon Moonshadow
        -- Faction, from 57 to 55.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `faction` = 55, `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 1458);
        -- Entry: 1482
        -- Name: Andrea Halloran
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1482);
        -- Entry: 2052
        -- Name: Nag
        -- Faction, from 0 to 35.
        -- BaseAttackTime, from 0 to 2000.
        -- RangedAttackTime, from 0 to 2000.
        UPDATE `creature_template` SET `faction` = 35, `base_attack_time` = 2000, `ranged_attack_time` = 2000 WHERE (`entry` = 2052);
        -- Entry: 1437
        -- Name: Thomas Booker
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1437);
        -- Entry: 1445
        -- Name: Jesse Halloran
        -- Faction, from 11 to 12.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 12, `scale` = 1.0 WHERE (`entry` = 1445);
        -- Entry: 5186
        -- Name: Basking Shark
        -- Min Level, from 41 to 38.
        -- Max Level, from 41 to 38.
        -- Scale, from 0.0 to 1.0.
        -- BaseAttackTime, from 1333 to 2000.
        UPDATE `creature_template` SET `level_min` = 38, `level_max` = 38, `scale` = 1.0, `base_attack_time` = 2000 WHERE (`entry` = 5186);
        -- Entry: 3681
        -- Name: Wisp
        -- Faction, from 79 to 84.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 84, `scale` = 1.0 WHERE (`entry` = 3681);
        -- Entry: 1412
        -- Name: Squirrel
        -- Scale, from 0.0 to 1.3.
        UPDATE `creature_template` SET `scale` = 1.3 WHERE (`entry` = 1412);
        -- Entry: 7316
        -- Name: Sister Aquinne
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 7316);
        -- Entry: 4262
        -- Name: Darnassus Sentinel
        -- Scale, from 0.0 to 1.0.
        -- BaseAttackTime, from 1600 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `base_attack_time` = 2000 WHERE (`entry` = 4262);
        -- Entry: 883
        -- Name: Deer
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 883);
        -- Entry: 7916
        -- Name: Erelas Ambersky
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 7916);
        -- Entry: 7907
        -- Name: Daryn Lightwind
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 80, `scale` = 1.0 WHERE (`entry` = 7907);
        -- Entry: 4208
        -- Name: Lairn
        -- Min Level, from 45 to 35.
        -- Max Level, from 45 to 35.
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `level_min` = 35, `level_max` = 35, `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4208);
        -- Entry: 4155
        -- Name: Idriana
        -- Min Level, from 45 to 35.
        -- Max Level, from 45 to 35.
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `level_min` = 35, `level_max` = 35, `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4155);
        -- Entry: 4209
        -- Name: Garryeth
        -- Min Level, from 45 to 35.
        -- Max Level, from 45 to 35.
        -- Faction, from 79 to 80.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `level_min` = 35, `level_max` = 35, `faction` = 80, `scale` = 1.0 WHERE (`entry` = 4209);
        -- Entry: 3116
        -- Name: Dustwind Pillager
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3116);
        -- Entry: 3126
        -- Name: Armored Scorpid
        -- Faction, from 60 to 16.
        -- Scale, from 0.0 to 0.9.
        UPDATE `creature_template` SET `faction` = 16, `scale` = 0.9 WHERE (`entry` = 3126);
        -- Entry: 3118
        -- Name: Dustwind Storm Witch
         -- Scale, from 0.0 to 1.1.
        -- RangedAttackTime, from 2046 to 2000.
        UPDATE `creature_template` SET `scale` = 1.1, `ranged_attack_time` = 2000 WHERE (`entry` = 3118);
        -- Entry: 3122
        -- Name: Bloodtalon Taillasher
        -- Faction, from 48 to 14.
        -- Scale, from 0.0 to 0.55.
        UPDATE `creature_template` SET `faction` = 14, `scale` = 0.55 WHERE (`entry` = 3122);
        -- Entry: 3127
        -- Name: Venomtail Scorpid
        -- Faction, from 60 to 16.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 16, `scale` = 1.0 WHERE (`entry` = 3127);
        -- Entry: 3100
        -- Name: Elder Mottled Boar
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3100);
        -- Entry: 3099
        -- Name: Dire Mottled Boar
        -- Scale, from 0.0 to 0.75.
        -- RangedAttackTime, from 2101 to 2000.
        UPDATE `creature_template` SET `scale` = 0.75, `ranged_attack_time` = 2000 WHERE (`entry` = 3099);
        -- Entry: 3226
        -- Name: Corrupted Scorpid
        -- Faction, from 60 to 14.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 14, `scale` = 1.0 WHERE (`entry` = 3226);
        -- Entry: 3300
        -- Name: Adder
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 3300);
        -- Entry: 9564
        -- Name: Frezza
        -- Faction, from 29 to 69.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 1716 to 1000.
        UPDATE `creature_template` SET `faction` = 69, `scale` = 1.0, `ranged_attack_time` = 1000 WHERE (`entry` = 9564);
        -- Entry: 5953
        -- Name: Razor Hill Grunt
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 1782 to 2000.
        UPDATE `creature_template` SET `scale` = 1.0, `ranged_attack_time` = 2000 WHERE (`entry` = 5953);
        -- Entry: 5951
        -- Name: Hare
        -- Scale, from 0.0 to 0.75.
        UPDATE `creature_template` SET `scale` = 0.75 WHERE (`entry` = 5951);
        -- Entry: 3110
        -- Name: Dreadmaw Crocolisk
        -- Scale, from 0.0 to 0.5.
        UPDATE `creature_template` SET `scale` = 0.5 WHERE (`entry` = 3110);
        -- Entry: 2959
        -- Name: Prairie Stalker
        -- Scale, from 0.0 to 0.9.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `scale` = 0.9, `ranged_attack_time` = 1500 WHERE (`entry` = 2959);
        -- Entry: 1554
        -- Name: Vampiric Duskbat
        -- Scale, from 0.44 to 0.57.
        UPDATE `creature_template` SET `scale` = 0.57 WHERE (`entry` = 1554);
        -- Entry: 3150
        -- Name: Hin Denburg
        -- Faction, from 29 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 3150);
        -- Entry: 9566
        -- Name: Zapetta
        -- Faction, from 29 to 69.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1000.
        UPDATE `creature_template` SET `faction` = 69, `scale` = 1.0, `ranged_attack_time` = 1000 WHERE (`entry` = 9566);
        -- Entry: 721
        -- Name: Rabbit
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 721);
        -- Entry: 5724
        -- Name: Ageron Kargal
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 5724);
        -- Entry: 1521
        -- Name: Gretchen Dedmar
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 1521);
        -- Entry: 1560
        -- Name: Yvette Farthing
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        -- RangedAttackTime, from 2000 to 1500.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0, `ranged_attack_time` = 1500 WHERE (`entry` = 1560);
        -- Entry: 2131
        -- Name: Austil de Mon
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 2131);
        -- Entry: 2127
        -- Name: Rupert Boch
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 2127);
        -- Entry: 5759
        -- Name: Nurse Neela
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 5759);
        -- Entry: 5750
        -- Name: Gina Lang
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 5750);
        -- Entry: 2128
        -- Name: Cain Firesong
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 2128);
        -- Entry: 1744
        -- Name: Deathguard Mort
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `scale` = 1.0 WHERE (`entry` = 1744);
        -- Entry: 3547
        -- Name: Hamlin Atkins
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 3547);
        -- Entry: 2134
        -- Name: Mrs. Winters
        -- Faction, from 71 to 68.
        -- Scale, from 0.0 to 1.0.
        UPDATE `creature_template` SET `faction` = 68, `scale` = 1.0 WHERE (`entry` = 2134);

        
        -- Reversed Creature Item display Id's from UNIT_VIRTUAL_ITEM_SLOT_DISPLAY field.


        -- Item Entry: 1907
        -- Name: Monster - Staff, Basic
        -- DisplayID, from 10654 to 1599
        UPDATE `item_template` SET `display_id` = 1599 WHERE (`entry` = 1907);
        -- Item Entry: 12297
        -- Name: Monster - Sword, Horde Jagged Brown
        -- DisplayID, from 22366 to 7483
        UPDATE `item_template` SET `display_id` = 7483 WHERE (`entry` = 12297);
        -- Item Entry: 12285
        -- Name: Monster - Axe, 2H Rev. Bearded Single Bladed - Red
        -- DisplayID, from 18607 to 5128
        UPDATE `item_template` SET `display_id` = 5128 WHERE (`entry` = 12285);
        -- Item Entry: 12889
        -- Name: Monster - Sword2H, Horde Curved Black
        -- DisplayID, from 23379 to 7490
        UPDATE `item_template` SET `display_id` = 7490 WHERE (`entry` = 12889);
        -- Item Entry: 10878
        -- Name: Monster - Sword, Horde Jagged Green
        -- DisplayID, from 20036 to 5176
        UPDATE `item_template` SET `display_id` = 5176 WHERE (`entry` = 10878);
        -- Item Entry: 9659
        -- Name: Monster - Mace, Tauren Spiked
        -- DisplayID, from 18583 to 7477
        UPDATE `item_template` SET `display_id` = 7477 WHERE (`entry` = 9659);
        -- Item Entry: 12754
        -- Name: Monster - Axe, 2H War Green - Mulgore Protector
        -- DisplayID, from 23198 to 3797
        UPDATE `item_template` SET `display_id` = 3797 WHERE (`entry` = 12754);
        -- Item Entry: 11343
        -- Name: Monster - Staff, Jeweled Red Staff
        -- DisplayID, from 21251 to 1599
        UPDATE `item_template` SET `display_id` = 1599 WHERE (`entry` = 11343);
        -- Item Entry: 5277
        -- Name: Monster - Staff, Metal /w Spike Crystal
        -- DisplayID, from 5542 to 1599
        UPDATE `item_template` SET `display_id` = 1599 WHERE (`entry` = 5277);

        insert into applied_updates values ('060720221');
    end if;

    -- 09/07/2022 1
    if (select count(*) from applied_updates where id='090720221') = 0 then
        DROP TABLE IF EXISTS `creature_onkill_reputation`;
        CREATE TABLE `creature_onkill_reputation` (
        `creature_id` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Creature Identifier',
        `RewOnKillRepFaction1` smallint(6) NOT NULL DEFAULT 0,
        `RewOnKillRepFaction2` smallint(6) NOT NULL DEFAULT 0,
        `MaxStanding1` tinyint(4) NOT NULL DEFAULT 0,
        `IsTeamAward1` tinyint(4) NOT NULL DEFAULT 0,
        `RewOnKillRepValue1` mediumint(9) NOT NULL DEFAULT 0,
        `MaxStanding2` tinyint(4) NOT NULL DEFAULT 0,
        `IsTeamAward2` tinyint(4) NOT NULL DEFAULT 0,
        `RewOnKillRepValue2` mediumint(9) NOT NULL DEFAULT 0,
        `TeamDependent` tinyint(3) unsigned NOT NULL DEFAULT 0,
        PRIMARY KEY (`creature_id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
        
        INSERT INTO `creature_onkill_reputation`
        VALUES (674,21,0,5,0,25,0,0,0,0),
        (675,21,0,5,0,25,0,0,0,0),
        (677,21,0,5,0,25,0,0,0,0),
        (737,87,21,5,0,5,7,0,-125,0),
        (773,87,21,5,0,5,7,0,-125,0),
        (1094,21,0,5,0,25,0,0,0,0),
        (1095,21,0,5,0,25,0,0,0,0),
        (1096,21,0,5,0,25,0,0,0,0),
        (1097,21,0,5,0,25,0,0,0,0),
        (1411,87,21,5,0,5,7,0,-125,0),
        (1561,21,87,3,0,5,7,0,-25,0),
        (1562,21,87,3,0,5,7,0,-25,0),
        (1563,21,87,3,0,5,7,0,-25,0),
        (1564,21,87,3,0,5,7,0,-25,0),
        (1565,21,87,3,0,5,7,0,-25,0),
        (1653,21,87,3,0,5,7,0,-25,0),
        (10398,529,0,5,0,5,0,0,0,0),
        (10400,529,0,5,0,5,0,0,0,0),
        (10399,529,0,5,0,5,0,0,0,0),
        (10470,529,0,5,0,5,0,0,0,0),
        (10477,529,0,5,0,5,0,0,0,0),
        (10476,529,0,5,0,5,0,0,0,0),
        (11257,529,0,5,0,5,0,0,0,0),
        (11582,529,0,5,0,5,0,0,0,0),
        (10469,529,0,5,0,5,0,0,0,0),
        (10471,529,0,5,0,5,0,0,0,0),
        (10438,529,0,7,0,25,0,0,0,0),
        (14861,529,0,5,0,5,0,0,0,0),
        (11261,529,0,7,0,25,0,0,0,0),
        (10821,529,0,4,0,15,0,0,0,0),
        (2482,87,21,5,0,5,7,0,-125,0),
        (2487,87,21,5,0,5,7,0,-125,0),
        (2488,87,21,5,0,5,7,0,-125,0),
        (2490,87,21,5,0,5,7,0,-125,0),
        (2491,87,21,5,0,5,7,0,-125,0),
        (2493,87,21,5,0,5,7,0,-125,0),
        (2494,87,21,5,0,5,7,0,-125,0),
        (2495,87,21,5,0,5,7,0,-125,0),
        (2496,87,21,5,0,5,7,0,-125,0),
        (2498,87,21,5,0,5,7,0,-125,0),
        (2499,87,21,5,0,5,7,0,-125,0),
        (2500,87,21,5,0,5,7,0,-125,0),
        (2501,87,21,5,0,5,7,0,-125,0),
        (2502,87,21,5,0,5,7,0,-125,0),
        (2542,87,21,5,0,5,7,0,-125,0),
        (2545,21,87,5,0,25,7,0,-125,0),
        (2546,21,87,5,0,25,7,0,-125,0),
        (2547,21,87,5,0,25,7,0,-125,0),
        (2548,21,87,5,0,25,7,0,-125,0),
        (2549,21,87,5,0,25,7,0,-125,0),
        (2550,21,87,5,0,25,7,0,-125,0),
        (2551,21,87,5,0,25,7,0,-125,0),
        (2594,87,21,5,0,5,7,0,-125,0),
        (2610,87,21,5,0,5,7,0,-125,0),
        (2622,87,21,5,0,5,7,0,-125,0),
        (2625,87,21,5,0,5,7,0,-125,0),
        (2627,87,21,5,0,5,7,0,-125,0),
        (2636,87,21,5,0,5,7,0,-125,0),
        (2663,87,21,5,0,5,7,0,-125,0),
        (2664,87,21,5,0,5,7,0,-125,0),
        (2670,87,21,5,0,5,7,0,-125,0),
        (2685,87,21,5,0,5,7,0,-125,0),
        (2699,87,21,5,0,5,7,0,-125,0),
        (2774,87,21,5,0,5,7,0,-125,0),
        (2778,87,21,5,0,5,7,0,-125,0),
        (2817,87,21,5,0,5,7,0,-125,0),
        (2832,87,21,5,0,5,7,0,-125,0),
        (2834,87,21,5,0,5,7,0,-125,0),
        (2836,87,21,5,0,5,7,0,-125,0),
        (2837,87,21,5,0,5,7,0,-125,0),
        (2838,87,21,5,0,5,7,0,-125,0),
        (2839,87,21,5,0,5,7,0,-125,0),
        (2840,87,21,5,0,5,7,0,-125,0),
        (2842,87,21,5,0,5,7,0,-125,0),
        (2843,87,21,5,0,5,7,0,-125,0),
        (2844,87,21,5,0,5,7,0,-125,0),
        (2845,87,21,5,0,5,7,0,-125,0),
        (2846,87,21,5,0,5,7,0,-125,0),
        (2847,87,21,5,0,5,7,0,-125,0),
        (2848,87,21,5,0,5,7,0,-125,0),
        (2849,87,21,5,0,5,7,0,-125,0),
        (3381,470,0,5,0,5,0,0,0,0),
        (3382,470,0,5,0,5,0,0,0,0),
        (3383,470,0,5,0,5,0,0,0,0),
        (3384,470,0,5,0,5,0,0,0,0),
        (3467,470,0,6,0,25,0,0,0,0),
        (3537,169,0,7,0,-125,0,0,0,0),
        (3538,169,0,7,0,-125,0,0,0,0),
        (3945,87,21,5,0,5,7,0,-125,0),
        (4260,21,0,5,0,25,0,0,0,0),
        (10505,529,0,7,0,25,0,0,0,0),
        (1847,529,0,4,0,15,0,0,0,0),
        (10825,529,0,4,0,15,0,0,0,0),
        (4505,21,87,3,0,5,7,0,-25,0),
        (4506,21,87,3,0,5,7,0,-25,0),
        (4624,87,21,5,0,25,5,0,-125,0),
        (4631,87,21,5,0,5,7,0,-125,0),
        (4638,92,93,4,0,20,4,0,-100,0),
        (4639,92,93,4,0,20,4,0,-100,0),
        (4640,92,93,4,0,20,4,0,-100,0),
        (4641,92,93,4,0,20,4,0,-100,0),
        (4642,92,93,4,0,20,4,0,-100,0),
        (4643,92,93,4,0,20,4,0,-100,0),
        (4644,92,93,4,0,20,4,0,-100,0),
        (4645,92,93,4,0,20,4,0,-100,0),
        (4646,93,92,4,0,20,4,0,-100,0),
        (4647,93,92,4,0,20,4,0,-100,0),
        (4648,93,92,4,0,20,4,0,-100,0),
        (4649,93,92,4,0,20,4,0,-100,0),
        (4651,93,92,4,0,20,4,0,-100,0),
        (4652,93,92,4,0,20,4,0,-100,0),
        (4653,93,92,4,0,20,4,0,-100,0),
        (4661,93,92,4,0,20,4,0,-100,0),
        (4662,92,93,4,0,100,4,0,-500,0),
        (4723,21,0,5,0,25,0,0,0,0),
        (5601,92,93,4,0,100,4,0,-500,0),
        (6068,92,93,4,0,100,4,0,-500,0),
        (6707,70,349,3,0,5,3,0,-25,0),
        (6766,70,349,3,0,5,3,0,-25,0),
        (6768,70,349,3,0,5,3,0,-25,0),
        (6771,70,349,3,0,5,3,0,-25,0),
        (6777,70,349,3,0,5,3,0,-25,0),
        (6779,70,349,3,0,5,3,0,-25,0),
        (7032,749,0,4,0,5,0,0,0,0),
        (10826,529,0,4,0,15,0,0,0,0),
        (16184,529,0,7,0,15,0,0,0,0),
        (10809,529,0,7,0,25,0,0,0,0),
        (10558,529,0,7,0,25,0,0,0,0),
        (7323,70,349,3,0,5,3,0,-25,0),
        (7324,70,349,3,0,5,3,0,-25,0),
        (7325,70,349,3,0,5,3,0,-25,0),
        (7406,87,21,5,0,5,7,0,-125,0),
        (12263,529,0,4,0,5,0,0,0,0),
        (12262,529,0,4,0,5,0,0,0,0),
        (7794,87,21,5,0,5,7,0,-125,0),
        (7853,87,21,5,0,5,7,0,-125,0),
        (8123,87,21,5,0,5,7,0,-125,0),
        (8305,169,0,7,0,-125,0,0,0,0),
        (8309,70,349,3,0,5,3,0,-25,0),
        (8320,87,21,5,0,5,7,0,-125,0),
        (11622,529,0,7,0,25,0,0,0,0),
        (11551,529,0,5,0,5,0,0,0,0),
        (11082,529,0,5,0,5,0,0,0,0),
        (10901,529,0,7,0,25,0,0,0,0),
        (10508,529,0,7,0,50,0,0,0,0),
        (10507,529,0,7,0,25,0,0,0,0),
        (10504,529,0,7,0,25,0,0,0,0),
        (10503,529,0,7,0,25,0,0,0,0),
        (10502,529,0,7,0,25,0,0,0,0),
        (10500,529,0,5,0,5,0,0,0,0),
        (10499,529,0,5,0,5,0,0,0,0),
        (10498,529,0,5,0,5,0,0,0,0),
        (10495,529,0,5,0,5,0,0,0,0),
        (10491,529,0,5,0,5,0,0,0,0),
        (9017,749,0,5,0,15,0,0,0,0),
        (9179,87,21,6,0,5,7,0,-125,0),
        (10489,529,0,5,0,5,0,0,0,0),
        (10488,529,0,5,0,5,0,0,0,0),
        (9536,169,0,7,0,-125,0,0,0,0),
        (9559,87,21,5,0,25,7,0,-125,0),
        (9816,749,0,5,0,50,0,0,0,0),
        (10060,87,21,5,0,25,7,0,-125,0),
        (10487,529,0,5,0,5,0,0,0,0),
        (10267,169,0,7,0,-125,0,0,0,0),
        (10486,529,0,5,0,5,0,0,0,0),
        (10478,529,0,5,0,5,0,0,0,0),
        (10464,529,0,5,0,5,0,0,0,0),
        (10463,529,0,5,0,5,0,0,0,0),
        (10440,529,0,7,0,50,0,0,0,0),
        (10437,529,0,7,0,25,0,0,0,0),
        (10436,529,0,7,0,25,0,0,0,0),
        (10435,529,0,7,0,25,0,0,0,0),
        (10433,529,0,7,0,25,0,0,0,0),
        (10432,529,0,7,0,25,0,0,0,0),
        (10417,529,0,5,0,5,0,0,0,0),
        (10416,529,0,5,0,5,0,0,0,0),
        (10414,529,0,5,0,5,0,0,0,0),
        (10413,529,0,5,0,5,0,0,0,0),
        (10412,529,0,5,0,5,0,0,0,0),
        (10409,529,0,5,0,5,0,0,0,0),
        (10408,529,0,5,0,5,0,0,0,0),
        (10407,529,0,5,0,5,0,0,0,0),
        (10406,529,0,5,0,5,0,0,0,0),
        (10405,529,0,5,0,5,0,0,0,0),
        (10385,529,0,5,0,5,0,0,0,0),
        (10384,529,0,5,0,5,0,0,0,0),
        (10382,529,0,5,0,5,0,0,0,0),
        (10381,529,0,5,0,5,0,0,0,0),
        (1852,529,0,7,0,15,0,0,0,0),
        (1805,529,0,4,0,5,0,0,0,0),
        (1788,529,0,4,0,5,0,0,0,0),
        (8548,529,0,4,0,5,0,0,0,0),
        (8550,529,0,4,0,5,0,0,0,0),
        (8553,529,0,4,0,5,0,0,0,0),
        (10827,529,0,4,0,5,0,0,0,0),
        (8547,529,0,4,0,5,0,0,0,0),
        (8551,529,0,4,0,5,0,0,0,0),
        (8546,529,0,4,0,5,0,0,0,0),
        (11873,529,0,4,0,5,0,0,0,0),
        (10816,529,0,4,0,5,0,0,0,0),
        (10801,529,0,4,0,5,0,0,0,0),
        (10698,529,0,4,0,5,0,0,0,0),
        (10580,529,0,4,0,5,0,0,0,0),
        (10485,529,0,5,0,5,0,0,0,0),
        (10482,529,0,5,0,5,0,0,0,0),
        (10481,529,0,5,0,5,0,0,0,0),
        (10480,529,0,5,0,5,0,0,0,0),
        (10391,529,0,5,0,5,0,0,0,0),
        (10390,529,0,5,0,5,0,0,0,0),
        (8558,529,0,4,0,5,0,0,0,0),
        (8557,529,0,4,0,5,0,0,0,0),
        (8556,529,0,4,0,5,0,0,0,0),
        (8555,529,0,4,0,5,0,0,0,0),
        (8545,529,0,4,0,5,0,0,0,0),
        (8544,529,0,4,0,5,0,0,0,0),
        (8543,529,0,4,0,5,0,0,0,0),
        (11658,749,0,5,0,20,0,0,0,0),
        (11659,749,0,5,0,40,0,0,0,0),
        (11666,749,0,5,0,40,0,0,0,0),
        (11667,749,0,5,0,40,0,0,0,0),
        (11668,749,0,5,0,20,0,0,0,0),
        (11673,749,0,5,0,20,0,0,0,0),
        (11744,749,0,4,0,5,0,0,0,0),
        (11746,749,0,4,0,5,0,0,0,0),
        (15308,609,0,7,0,5,0,0,0,0),
        (14479,609,0,7,0,5,0,0,0,0),
        (8542,529,0,4,0,5,0,0,0,0),
        (15202,609,0,5,0,1,0,0,0,0),
        (11804,609,0,5,0,1,0,0,0,0),
        (11803,609,0,5,0,1,0,0,0,0),
        (15201,609,0,5,0,1,0,0,0,0),
        (11982,749,0,6,0,100,0,0,0,0),
        (11988,749,0,7,0,150,0,0,0,0),
        (12056,749,0,6,0,100,0,0,0,0),
        (12057,749,0,6,0,100,0,0,0,0),
        (12076,749,0,5,0,40,0,0,0,0),
        (12098,749,0,6,0,100,0,0,0,0),
        (12100,749,0,5,0,40,0,0,0,0),
        (12101,749,0,5,0,20,0,0,0,0),
        (12118,749,0,6,0,100,0,0,0,0),
        (12136,169,0,7,0,-125,0,0,0,0),
        (12259,749,0,6,0,100,0,0,0,0),
        (8541,529,0,4,0,5,0,0,0,0),
        (8540,529,0,4,0,5,0,0,0,0),
        (12264,749,0,6,0,100,0,0,0,0),
        (13085,70,349,3,0,25,3,0,-125,0),
        (8539,529,0,4,0,5,0,0,0,0),
        (14478,749,0,5,0,25,0,0,0,0),
        (15200,609,0,5,0,1,0,0,0,0),
        (8538,529,0,4,0,5,0,0,0,0),
        (8535,529,0,4,0,5,0,0,0,0),
        (8534,529,0,4,0,5,0,0,0,0),
        (8532,529,0,4,0,5,0,0,0,0),
        (8531,529,0,4,0,5,0,0,0,0),
        (8530,529,0,4,0,5,0,0,0,0),
        (8529,529,0,4,0,5,0,0,0,0),
        (8528,529,0,4,0,5,0,0,0,0),
        (8527,529,0,4,0,5,0,0,0,0),
        (8526,529,0,4,0,5,0,0,0,0),
        (8525,529,0,4,0,5,0,0,0,0),
        (8524,529,0,4,0,5,0,0,0,0),
        (15213,609,0,4,0,1,0,0,0,0),
        (11883,609,0,4,0,1,0,0,0,0),
        (11882,609,0,4,0,1,0,0,0,0),
        (11881,609,0,4,0,1,0,0,0,0),
        (15229,910,609,3,0,100,7,0,0,0),
        (15230,910,609,3,0,100,7,0,0,0),
        (15235,910,609,3,0,100,7,0,0,0),
        (15236,910,609,3,0,100,7,0,0,0),
        (15240,910,609,3,0,100,7,0,0,0),
        (15249,910,609,3,0,100,7,0,0,0),
        (15262,910,609,3,0,100,7,0,0,0),
        (15264,910,609,3,0,100,7,0,0,0),
        (15277,910,609,3,0,100,7,0,0,0),
        (11880,609,0,4,0,1,0,0,0,0),
        (15339,910,609,7,0,100,7,0,300,0),
        (15340,910,609,7,0,50,7,0,150,0),
        (15341,910,609,7,0,34,7,0,100,0),
        (15348,910,609,7,0,50,7,0,150,0),
        (15369,910,609,7,0,50,7,0,150,0),
        (15370,910,609,7,0,50,7,0,150,0),
        (15541,609,0,5,0,5,0,0,0,0),
        (15542,609,0,5,0,1,0,0,0,0),
        (8523,529,0,4,0,5,0,0,0,0),
        (4475,529,0,4,0,5,0,0,0,0),
        (4474,529,0,4,0,5,0,0,0,0),
        (4472,529,0,4,0,5,0,0,0,0),
        (1804,529,0,4,0,5,0,0,0,0),
        (1802,529,0,4,0,5,0,0,0,0),
        (7883,369,0,5,1,25,0,0,0,0),
        (14750,270,0,5,0,1,0,0,0,0),
        (1796,529,0,4,0,5,0,0,0,0),
        (11382,270,0,7,0,200,0,0,0,0),
        (7847,369,0,5,1,25,0,0,0,0),
        (14515,270,0,7,0,100,0,0,0,0),
        (1795,529,0,4,0,5,0,0,0,0),
        (1794,529,0,4,0,5,0,0,0,0),
        (1793,529,0,4,0,5,0,0,0,0),
        (1791,529,0,4,0,5,0,0,0,0),
        (11502,749,0,7,0,200,0,0,0,0),
        (1789,529,0,4,0,5,0,0,0,0),
        (1787,529,0,4,0,5,0,0,0,0),
        (15043,270,0,5,0,1,0,0,0,0),
        (11352,270,0,5,0,1,0,0,0,0),
        (14821,270,0,5,0,3,0,0,0,0),
        (11373,270,0,5,0,3,0,0,0,0),
        (14834,270,0,7,0,400,0,0,0,0),
        (11371,270,0,5,0,3,0,0,0,0),
        (11338,270,0,5,0,3,0,0,0,0),
        (11831,270,0,5,0,3,0,0,0,0),
        (11339,270,0,5,0,3,0,0,0,0),
        (14509,270,0,7,0,100,0,0,0,0),
        (14507,270,0,7,0,100,0,0,0,0),
        (14517,270,0,7,0,100,0,0,0,0),
        (14510,270,0,7,0,100,0,0,0,0),
        (11374,270,0,5,0,1,0,0,0,0),
        (1785,529,0,4,0,5,0,0,0,0),
        (11380,270,0,7,0,200,0,0,0,0),
        (1784,529,0,4,0,5,0,0,0,0),
        (11353,270,0,5,0,3,0,0,0,0),
        (1783,529,0,4,0,5,0,0,0,0),
        (10199,576,0,7,0,25,0,0,0,0),
        (14342,576,0,7,0,5,0,0,0,0),
        (9464,576,0,7,0,25,0,0,0,0),
        (11372,270,0,5,0,3,0,0,0,0),
        (15111,270,0,5,0,3,0,0,0,0),
        (2552,471,0,7,0,5,0,0,0,1),
        (11351,270,0,5,0,3,0,0,0,0),
        (11387,270,0,7,0,15,0,0,0,0),
        (15461,609,0,6,0,3,0,0,0,0),
        (9462,576,0,7,0,5,0,0,0,0),
        (10738,576,0,7,0,25,0,0,0,0),
        (10916,576,0,5,0,5,0,0,0,0),
        (7441,576,0,5,0,5,0,0,0,0),
        (7440,576,0,5,0,5,0,0,0,0),
        (15333,609,0,6,0,3,0,0,0,0),
        (11370,270,0,5,0,3,0,0,0,0),
        (7856,369,0,5,0,5,0,0,0,0),
        (7857,369,0,5,0,5,0,0,0,0),
        (15462,609,0,6,0,3,0,0,0,0),
        (14284,729,0,6,0,5,0,0,0,0),
        (7439,576,0,5,0,5,0,0,0,0),
        (7438,576,0,5,0,5,0,0,0,0),
        (7157,576,0,5,0,5,0,0,0,0),
        (7156,576,0,5,0,5,0,0,0,0),
        (921,21,0,6,0,5,0,0,0,0),
        (15168,609,0,6,0,3,0,0,0,0),
        (7155,576,0,5,0,5,0,0,0,0),
        (11391,270,0,7,0,15,0,0,0,0),
        (11356,270,0,5,0,3,0,0,0,0),
        (5623,369,0,3,1,10,0,0,0,0),
        (5618,369,0,3,1,10,0,0,0,0),
        (7154,576,0,5,0,5,0,0,0,0),
        (11388,270,0,7,0,15,0,0,0,0),
        (11340,270,0,5,0,3,0,0,0,0),
        (7153,576,0,5,0,5,0,0,0,0),
        (14882,270,0,5,0,1,0,0,0,0),
        (11350,270,0,5,0,1,0,0,0,0),
        (5615,369,0,3,1,10,0,0,0,0),
        (5617,369,0,3,1,10,0,0,0,0),
        (5616,369,0,3,1,10,0,0,0,0),
        (7855,369,0,5,0,5,0,0,0,0),
        (7858,369,0,5,0,5,0,0,0,0),
        (2769,87,21,5,0,25,7,0,-125,0),
        (2767,87,21,5,0,5,7,0,-125,0),
        (15275,910,0,3,0,210,0,0,0,0),
        (15276,910,0,3,0,210,0,0,0,0),
        (6651,576,0,7,0,-125,0,0,0,0),
        (11557,576,0,7,0,-75,0,0,0,0),
        (11555,576,0,7,0,-75,0,0,0,0),
        (11558,576,0,7,0,-75,0,0,0,0),
        (11516,576,0,7,0,-25,0,0,0,0),
        (11553,576,0,7,0,-25,0,0,0,0),
        (6184,576,0,7,0,-25,0,0,0,0),
        (6188,576,0,7,0,-25,0,0,0,0),
        (6189,576,0,7,0,-25,0,0,0,0),
        (6185,576,0,7,0,-25,0,0,0,0),
        (7158,576,0,5,0,5,0,0,0,0),
        (10618,589,0,7,0,-250,0,0,0,0),
        (15623,576,0,7,0,25,0,0,0,0),
        (15082,270,0,7,0,25,0,0,0,0),
        (15085,270,0,7,0,25,0,0,0,0),
        (15084,270,0,7,0,25,0,0,0,0),
        (15083,270,0,7,0,25,0,0,0,0),
        (15211,609,0,5,0,5,0,0,0,0),
        (15209,609,0,5,0,5,0,0,0,0),
        (15307,609,0,5,0,5,0,0,0,0),
        (15212,609,0,5,0,5,0,0,0,0),
        (15206,609,0,7,0,25,0,0,0,0),
        (15207,609,0,7,0,25,0,0,0,0),
        (15208,609,0,7,0,25,0,0,0,0),
        (15220,609,0,7,0,25,0,0,0,0),
        (15203,609,0,7,0,50,0,0,0,0),
        (15305,609,0,7,0,50,0,0,0,0),
        (15204,609,0,7,0,50,0,0,0,0),
        (15205,609,0,7,0,50,0,0,0,0),
        (1853,529,0,7,0,50,0,0,0,0),
        (15740,910,0,2,0,2000,0,0,0,0),
        (15741,910,0,2,0,2000,0,0,0,0),
        (15742,910,0,2,0,2000,0,0,0,0),
        (15743,910,0,3,0,250,0,0,0,0),
        (15744,910,0,2,0,200,0,0,0,0),
        (15747,910,0,2,0,50,0,0,0,0),
        (15748,910,0,2,0,10,0,0,0,0),
        (15749,910,0,2,0,1,0,0,0,0),
        (15750,910,0,2,0,50,0,0,0,0),
        (15751,910,0,2,0,10,0,0,0,0),
        (15752,910,0,2,0,1,0,0,0,0),
        (15753,910,0,2,0,50,0,0,0,0),
        (15754,910,0,2,0,10,0,0,0,0),
        (15756,910,0,2,0,1,0,0,0,0),
        (15757,910,0,2,0,50,0,0,0,0),
        (15758,910,0,2,0,10,0,0,0,0),
        (15759,910,0,2,0,1,0,0,0,0),
        (15806,910,0,2,0,50,0,0,0,0),
        (15807,910,0,2,0,10,0,0,0,0),
        (15808,910,0,2,0,1,0,0,0,0),
        (15810,910,0,2,0,10,0,0,0,0),
        (15811,910,0,2,0,1,0,0,0,0),
        (15812,910,0,2,0,50,0,0,0,0),
        (15813,910,0,2,0,75,0,0,0,0),
        (15814,910,0,2,0,75,0,0,0,0),
        (15815,910,0,2,0,75,0,0,0,0),
        (15816,910,0,2,0,75,0,0,0,0),
        (15817,910,0,2,0,75,0,0,0,0),
        (15818,910,0,2,0,150,0,0,0,0),
        (15324,609,0,6,0,3,0,0,0,0),
        (15318,609,0,6,0,3,0,0,0,0),
        (15319,609,0,6,0,3,0,0,0,0),
        (15320,609,0,6,0,3,0,0,0,0),
        (15323,609,0,6,0,3,0,0,0,0),
        (15325,609,0,6,0,3,0,0,0,0),
        (15327,609,0,6,0,3,0,0,0,0),
        (15335,609,0,6,0,3,0,0,0,0),
        (15336,609,0,6,0,3,0,0,0,0),
        (15338,609,0,6,0,3,0,0,0,0),
        (15355,609,0,6,0,3,0,0,0,0),
        (15505,609,0,6,0,3,0,0,0,0),
        (15521,609,0,6,0,3,0,0,0,0),
        (15537,609,0,6,0,3,0,0,0,0),
        (15538,609,0,6,0,3,0,0,0,0),
        (15555,609,0,6,0,3,0,0,0,0),
        (15934,609,0,6,0,3,0,0,0,0),
        (15547,609,0,7,0,500,0,0,0,0),
        (16141,529,0,4,0,5,0,0,0,0),
        (16298,529,0,4,0,5,0,0,0,0),
        (16299,529,0,4,0,5,0,0,0,0),
        (16383,529,0,4,0,5,0,0,0,0),
        (16379,529,0,5,0,10,0,0,0,0),
        (16380,529,0,5,0,10,0,0,0,0),
        (14697,529,0,5,0,10,0,0,0,0),
        (16143,529,0,7,0,50,0,0,0,0),
        (16394,529,0,7,0,50,0,0,0,0),
        (16382,529,0,7,0,50,0,0,0,0),
        (14684,529,0,7,0,25,0,0,0,0),
        (14690,529,0,7,0,25,0,0,0,0),
        (14693,529,0,7,0,25,0,0,0,0),
        (14682,529,0,7,0,25,0,0,0,0),
        (14686,529,0,7,0,25,0,0,0,0),
        (14695,529,0,7,0,25,0,0,0,0),
        (15184,609,0,7,0,-250,0,0,0,0),
        (15545,609,0,7,0,-250,0,0,0,0),
        (15498,609,0,7,0,-125,0,0,0,0),
        (15282,609,0,7,0,-125,0,0,0,0),
        (15174,609,0,7,0,-125,0,0,0,0),
        (16091,609,0,7,0,-125,0,0,0,0),
        (15500,609,0,7,0,-125,0,0,0,0),
        (15419,609,0,7,0,-125,0,0,0,0),
        (15499,609,0,7,0,-125,0,0,0,0),
        (15176,609,0,7,0,-125,0,0,0,0),
        (15540,609,0,7,0,-125,0,0,0,0),
        (15179,609,0,7,0,-125,0,0,0,0),
        (15181,609,0,7,0,-125,0,0,0,0),
        (15180,609,0,7,0,-125,0,0,0,0),
        (15722,609,0,7,0,-125,0,0,0,0),
        (15175,609,0,7,0,-125,0,0,0,0),
        (15306,609,0,7,0,-125,0,0,0,0),
        (15270,609,0,7,0,-125,0,0,0,0),
        (15183,609,0,7,0,-125,0,0,0,0),
        (6186,576,0,7,0,-25,0,0,0,0),
        (6187,576,0,7,0,-25,0,0,0,0),
        (11552,576,0,7,0,-25,0,0,0,0),
        (15727,910,609,7,0,2500,7,0,500,0),
        (15088,87,21,5,0,25,7,0,-125,0),
        (3149,169,0,7,0,-125,0,0,0,0),
        (9564,169,0,7,0,-125,0,0,0,0),
        (9566,169,0,7,0,-125,0,0,0,0),
        (12137,169,0,7,0,-125,0,0,0,0),
        (16861,529,0,7,0,50,0,0,0,0),
        (16451,529,0,7,0,50,0,0,0,0),
        (16018,529,0,7,0,50,0,0,0,0),
        (16025,529,0,7,0,50,0,0,0,0),
        (16029,529,0,7,0,50,0,0,0,0),
        (16163,529,0,7,0,50,0,0,0,0),
        (16368,529,0,7,0,25,0,0,0,0),
        (16452,529,0,7,0,25,0,0,0,0),
        (16168,529,0,7,0,25,0,0,0,0),
        (16021,529,0,7,0,25,0,0,0,0),
        (16145,529,0,7,0,25,0,0,0,0),
        (15978,529,0,7,0,25,0,0,0,0),
        (16446,529,0,7,0,25,0,0,0,0),
        (16165,529,0,7,0,25,0,0,0,0),
        (16448,529,0,7,0,25,0,0,0,0),
        (15976,529,0,7,0,25,0,0,0,0),
        (16453,529,0,7,0,25,0,0,0,0),
        (16449,529,0,7,0,25,0,0,0,0),
        (16164,529,0,7,0,25,0,0,0,0),
        (16146,529,0,7,0,0,0,0,0,0),
        (16154,529,0,7,0,0,0,0,0,0),
        (16156,529,0,7,0,0,0,0,0,0),
        (16157,529,0,7,0,0,0,0,0,0),
        (16158,529,0,7,0,0,0,0,0,0),
        (16167,529,0,7,0,0,0,0,0,0),
        (16193,529,0,7,0,0,0,0,0,0),
        (16067,529,0,7,0,0,0,0,0,0),
        (16022,529,0,7,0,0,0,0,0,0),
        (16020,529,0,7,0,0,0,0,0,0),
        (15974,529,0,7,0,0,0,0,0,0),
        (15975,529,0,7,0,0,0,0,0,0),
        (15977,529,0,7,0,0,0,0,0,0),
        (15980,529,0,7,0,0,0,0,0,0),
        (15981,529,0,7,0,0,0,0,0,0),
        (16447,529,0,7,0,0,0,0,0,0),
        (16243,529,0,7,0,0,0,0,0,0),
        (16244,529,0,7,0,0,0,0,0,0),
        (16194,529,0,7,0,0,0,0,0,0),
        (16215,529,0,7,0,0,0,0,0,0),
        (16216,529,0,7,0,0,0,0,0,0),
        (15928,529,0,7,0,100,0,0,0,0),
        (15929,529,0,7,0,100,0,0,0,0),
        (15930,529,0,7,0,100,0,0,0,0),
        (15931,529,0,7,0,100,0,0,0,0),
        (15932,529,0,7,0,100,0,0,0,0),
        (15936,529,0,7,0,100,0,0,0,0),
        (15952,529,0,7,0,100,0,0,0,0),
        (15953,529,0,7,0,100,0,0,0,0),
        (15954,529,0,7,0,100,0,0,0,0),
        (15956,529,0,7,0,100,0,0,0,0),
        (15989,529,0,7,0,100,0,0,0,0),
        (15990,529,0,7,0,100,0,0,0,0),
        (16011,529,0,7,0,100,0,0,0,0),
        (16028,529,0,7,0,100,0,0,0,0),
        (16060,529,0,7,0,100,0,0,0,0),
        (16061,529,0,7,0,100,0,0,0,0),
        (5602,93,92,4,0,20,4,0,-100,0),
        (11365,270,0,5,0,1,0,0,0,0),
        (11361,270,0,5,0,1,0,0,0,0),
        (14880,270,0,5,0,3,0,0,0,0),
        (14532,270,0,5,0,3,0,0,0,0),
        (11359,270,0,5,0,3,0,0,0,0),
        (14883,270,0,5,0,3,0,0,0,0),
        (14825,270,0,5,0,3,0,0,0,0),
        (11830,270,0,5,0,5,0,0,0,0),
        (2553,471,0,7,0,5,0,0,0,1),
        (2554,471,0,7,0,5,0,0,0,1),
        (2555,471,0,7,0,5,0,0,0,1),
        (2556,471,0,7,0,5,0,0,0,1),
        (2557,471,0,7,0,5,0,0,0,1),
        (2558,471,0,7,0,5,0,0,0,1),
        (2639,471,0,7,0,5,0,0,0,1),
        (2640,471,0,7,0,5,0,0,0,1),
        (2641,471,0,7,0,5,0,0,0,1),
        (2642,471,0,7,0,5,0,0,0,1),
        (2643,471,0,7,0,5,0,0,0,1),
        (2644,471,0,7,0,5,0,0,0,1),
        (2645,471,0,7,0,5,0,0,0,1),
        (2646,471,0,7,0,5,0,0,0,1),
        (2647,471,0,7,0,5,0,0,0,1),
        (2648,471,0,7,0,5,0,0,0,1),
        (2649,471,0,7,0,5,0,0,0,1),
        (2650,471,0,7,0,5,0,0,0,1),
        (2651,471,0,7,0,5,0,0,0,1),
        (2652,471,0,7,0,5,0,0,0,1),
        (2653,471,0,7,0,5,0,0,0,1),
        (2654,471,0,7,0,5,0,0,0,1),
        (4465,471,0,7,0,5,0,0,0,1),
        (4466,471,0,7,0,5,0,0,0,1),
        (4467,471,0,7,0,5,0,0,0,1),
        (7809,471,0,7,0,5,0,0,0,1),
        (2606,471,0,7,0,25,0,0,0,1);

        insert into applied_updates values ('090720221');
    end if;

    -- 09/06/2022 1
    if (select count(*) from applied_updates where id='090620221') = 0 then
        -- William pestle
        -- --------------
        -- update display_id
        UPDATE `creature_template` SET `display_id1` = '1689' WHERE (`entry` = '253');

        -- Innkeeper Farley
        -- ----------------
        -- add broom
        INSERT INTO `creature_equip_template` (`entry`, `equipentry1`) VALUES ('295', '3362');
        UPDATE `creature_template` SET `equipment_id` = '295' WHERE (entry = '295');

        -- update position
        UPDATE `spawns_creatures` SET `position_x` = '-9459.490', `position_y` = '27.452', `position_z` = '56.339', `orientation` = '3.081' WHERE (`spawn_id` = '80346');

        insert into applied_updates values ('090620221');
    end if;

    -- 15/07/2022 1
    if (select count(*) from applied_updates where id='150720221') = 0 then
        -- Zardeth of the Black Claw
        -- -------------------------
        -- add dagger
        UPDATE `creature_equip_template` SET `equipentry1` = '2235' WHERE (entry = '1435');

        -- Goldshire Inn
        -- ------------
        -- update wooden chair
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-9461.616', `spawn_positionY` = '27.120', `spawn_positionZ` = '56.339' , `spawn_orientation` = '3.542', `ignored` = '0', `spawn_rotation2` = '0', `spawn_rotation3` = '0' WHERE (`spawn_id` = '26800');

        -- Innkeeper Farley
        -- ----------------
        -- update position
        UPDATE `spawns_creatures` SET `position_x` = '-9459.692', `position_y` = '28.115', `position_z` = '56.339', `orientation` = '2.975' WHERE (`spawn_id` = '80346');

        insert into applied_updates values ('150720221');
    end if;
 
    -- 17/07/2022 1
    if (select count(*) from applied_updates where id='170720221') = 0 then
        DROP TABLE IF EXISTS `quest_greeting`;
        CREATE TABLE `quest_greeting` (
        `entry` mediumint(8) unsigned NOT NULL DEFAULT 0,
        `type` tinyint(3) unsigned NOT NULL DEFAULT 0,
        `content_default` text NOT NULL,
        `content_loc1` text DEFAULT NULL,
        `content_loc2` text DEFAULT NULL,
        `content_loc3` text DEFAULT NULL,
        `content_loc4` text DEFAULT NULL,
        `content_loc5` text DEFAULT NULL,
        `content_loc6` text DEFAULT NULL,
        `content_loc7` text DEFAULT NULL,
        `content_loc8` text DEFAULT NULL,
        `emote_id` smallint(5) unsigned NOT NULL DEFAULT 0,
        `emote_delay` int(10) unsigned NOT NULL DEFAULT 0,
        PRIMARY KEY (`entry`,`type`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

        INSERT INTO `quest_greeting` VALUES (823,0,'Hello there, $c.  Normally I\'d be out on the beat looking after the folk of Stormwind, but a lot of the Stormwind guards are fighting in the other lands.  So here I am, deputized and offering bounties when I\'d rather be on patrol...',NULL,NULL,'Guten Tag, $C. Normalerweise würde ich jetzt meine Runde machen und die Leute von Sturmwind beschützen, doch viele der Wachen von Sturmwind kämpfen in fremden Landen. Daher mache ich jetzt hier Vertretung und setze Kopfgelder aus, wo ich doch eigentlich lieber auf Patrouille sein würde...',NULL,NULL,NULL,NULL,'Приветствую тебя, $c. Обычно я присматриваю за народом Штормграда, но в это тяжелое время, многие наши стражники ушли на сражения в другие края. И вот теперь, вместо того чтобы вести патруль, я как заместитель, предлагаю вознаграждение за оказанную помощь...',1,0),(241,0,'Hey there, friend.  My name\'s Remy.$BI\'m from Redridge to the east, and came here looking for business, looking for business.  You got any...got any??',NULL,NULL,'He, mein Freund. Man nennt mich Remy. Ich komme aus dem Rotkammgebirge im Osten und bin auf der Suche nach interessanten... Geschäften. Interessanten... Geschäften. Habt Ihr vielleicht welche... vielleicht welche?',NULL,NULL,NULL,NULL,'Послушай $gприятель:приятельница;. Меня зовут Реми.$BЯ с востока Красногорья, а сюда пришел за делом, да, за делом. У тебя не найдется дела? Не найдется?',0,0),(261,0,'Hello, citizen.  You look like a $g man : woman; with a purpose - do you have business with the Stormwind Army?',NULL,NULL,'Seid gegrüßt. Ihr seht aus wie ein $g Mann : Frau;, der weiß, was er will... habt ihr mit der Armee von Sturmwind zu tun?',NULL,NULL,NULL,NULL,'Приветствую, $gгражданин:гражданка;. Ты не выглядишь $gпраздным:праздной; зевакой. Что за дело привело тебя в армию Штормграда?',0,0),(237,0,'Nothing but trouble in these parts.  I tried to tell that fool Saldean to get out while he still could but he won\'t hear of it.  But I ain\'t no fool.  Verna and I are gonna mosey on out as soon as we get this wagon fixed.',NULL,NULL,'In dieser Gegend gibt es wirklich nichts als Arger. Ich habe versucht, den Dummkopf Saldean dazu zu bringen, sich aus dem Staub zu machen, solange das noch geht, aber er will einfach nicht hören. Aber ich bin kein Dummkopf. Verna und ich hauen ab, sobald wir diesen Wagen repariert haben.',NULL,NULL,NULL,NULL,'В этих краях нет ничего кроме неприятностей. Я пытался сказать этому глупцу Сальдену чтобы он уходил пока может, но он не хотел и слышать об этом. Но я не глупец, как только мы с Верной починим эту повозку, сразу уедем отсюда.',0,0),(234,0,'A foul corruption has crept into Westfall.  While I was upholding my duty on the battlefields of Lordaeron these honest farms were overrun and made into hide-outs for thugs and murderers. The People\'s Militia needs your help.',NULL,NULL,'In Westfall hat sich üble Verderbnis eingeschlichen. Während ich auf dem Schlachtfeld von Lordaeron meine Pflicht tat, wurden diese anstandig geführten Höfe überfallen und zu Schlupfwinkeln für Schläger und Mörder umfunktioniert. Die Volksmiliz ist auf Eure Hilfe angewiesen.',NULL,NULL,NULL,NULL,'Скверна проникла в Западный Край. Пока я сражался в боях за Лордерон, эти прекрасные фермы превратились в заброшенные руины, и в них поселились головорезы и убийцы. Народному ополчению нужна твоя помощь.',1,0),(6171,0,'You will be tested many times by the darkness that surrounds our lands, $N. But to ensure you are always prepared, we will often ask tasks of you so you are at the height of your own power.$B$BGo with the Light, and remain virtuous.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ты не однократно будешь проходить испытания во тьме, окружающей наши земли, $n. Но чтобы ты всегда $gбыл:была; наготове и сила твоя не ослабла, мы будем часто поручать тебе задания.$B$BСтупай со Светом и оставайся $gдобродетельным:добродетельной;.',1,0),(714,0,'Greetings, $c! Fine day for hunting, wouldn\'t you say? I\'ve been having more than a little luck with boars, myself. Perhaps you\'d like a shot?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую, $c! Прекрасный день для охоты, не правда ли? У меня не большие проблемы с кабанами. Не желаешь поохотиться?',0,0),(2930,0,'Corruption sneaks into nature\'s grove. The forest must be protected at all costs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Порча пробирается в рощу природы. Лес должен быть защищен любой ценой.',0,0),(3649,0,'Dark forces encroach upon our borders, ancient taints resurface, and new evils emerge to topple the delicate balance of the land. In times of such darkness, we all must be vigilant.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Темные силы посягают на наши границы, возрождается древняя зараза, появляется новое зло желающее разрушить тонкий баланс земли. В эти темные времена мы все должны быть бдительны.',1,0),(3616,0,'The wind whispers to those who listen...$B$BDo you hear it?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ветер шепчет тем, кто слушает...$B$BТы слышишь его?',0,0),(3845,0,'We elves have a long history.  Let us hope this history does not return to haunt us.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У нас эльфов большая история. Будем надеяться, что она никогда не повторится, и не будет преследовать нас.',0,0),(4077,0,'If I can get the proper ingredients, we can create some explosives that will not only allow me to damage the Venture\'s Co.\'s operations, but also cause a distraction.$B$BI know you\'re impressed, but it gets better... I\'ll tell you more soon enough.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Если я заполучу все необходимые ингредиенты, я смогу создать взрывчатку, которая не только нанесет урон Торговой Компании, но еще и отвлечет ее.$B$BЯ знаю что тебя это впечатлило, но еще лучше... обо всем остальном я расскажу тебе позже.',0,0),(3419,0,'For our people to survive, we must study the ways of nature and learn its secrets.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ðºÐéð¥ð▒Ðï ð▓ÐïðÂð©ÐéÐî, ð╝Ðï ð┤ð¥ð╗ðÂð¢Ðï Ðüð╗ðÁð┤ð¥ð▓ð░ÐéÐî ð┐ÐâÐéÐÅð╝ ð┐ÐÇð©ÐÇð¥ð┤Ðï ð© ð┐ð¥ÐüÐéð©ð│ð░ÐéÐî ðÁðÁ Ðéð░ð╣ð¢Ðï.',1,0),(238,0,'Sometimes I think there\'s a big gray cloud in the sky, just raining down bad luck upon us. First, we\'re driven off our land, and now we can\'t even get out of Westfall. Everything\'s a mess. Something needs to be done.',NULL,NULL,'Manchmal denke ich, eine große dunkle Wolke schwebt über uns, aus der Unglück auf uns herabregnet. Erst werden wir von unserem Land vertrieben und jetzt kommen wir noch nicht einmal aus Westfall weg. Alles liegt im Argen. Es muss etwas geschehen.',NULL,NULL,NULL,NULL,'Иногда мне кажется, что в небе есть огромное серое облако, которое льет на нас дождем невезенья. Сперва у нас отобрали нашу землю, а теперь мы даже не можем выбраться из Западного Края. Все это неправильно и с этим нужно что-то делать.',0,0),(235,0,'Welcome to our humble abode! It\'s always nice to see a friendly face. And what strong arms you have. My husband and I are always looking for help around the farm. Now that most the good folk have left, it\'s hard to find an able body to help out.',NULL,NULL,'Willkommen in unserer bescheidenen Hüttel Wir freuen uns über jedes freundliche Gesicht. Und ihr habt so starke Arme. Mein Mann und ich sind ständig auf der Suche nach jemandem, der uns auf dem Hof häft. Jetzt, wo die ganzen guten Leute weg sind, ist es nicht einfach, kräftige Helfer zu bekommen.',NULL,NULL,NULL,NULL,'Добро пожаловать в наш скромный обитель! Всегда приятно видеть дружелюбное лицо. Какое у тебя крепкое оружие, а нам с мужем всегда нужна помощь в округе нашей фермы, ведь теперь, когда большинство людей ушло, сложно найти кого-то, кто способен помочь.',0,0),(1518,0,'The Dark Lady has put forth the challenge. It is up to us to meet it.',NULL,NULL,'Die dunkle Fürstin hat die Herausforderung gestellt. Es liegt an uns, sie anzunehmen.',NULL,NULL,NULL,NULL,'Темная Госпожа поставила нам задачу, и мы должны решить ее.',0,0),(1500,0,'I hope you\'re well, all things considered.\r\n\r\nSit for a spell, and hear my tale. It\'s a tragedy, of course, but one I hope will end in revenge!',NULL,NULL,'Ich hoffe, Ihr seid den Umständen entsprechend wohlauf.\r\n\r\nNehmt doch hier Platz und lauscht meiner Geschichte. Natürlich ist es eine Tragödie, aber hoffentlich eine, die am Ende gerächt wird!',NULL,NULL,NULL,NULL,'Учитывая все обстоятельства, надеюсь, ты хорошо себя чувствуешь.$B$BПрисаживайся и выслушай мой рассказ, трагедию, которая я надеюсь закончиться местью!',0,0),(1515,0,'The Scarlet Crusade is encroaching on our homeland. The foolish zealots do not realize that the loyal servants of The Dark Lady shall see to their demise.',NULL,NULL,'Der Scharlachrote Kreuzzug rückt unserer Heimat näher. Die törichten Eiferer erkennen nicht, dass die treuen Diener der dunklen Fürstin alles tun werden, um sie zu töten.',NULL,NULL,NULL,NULL,'Алый орден вторгся в наши земли. Эти глупые фанатики еще не понимают, что верные слуги Темной Госпожи увидят их кончину.',0,0),(1499,0,'Ah, you there! I have tasks to give, and I need not waste time explaining their crucial nature. Listen close.',NULL,NULL,'He, Ihr da! Ich hätte da ein paar Aufgaben zu vergeben und muss unbedingt kurz erklären, wie außerordentlich wichtig sie sind. Hört gut zu.',NULL,NULL,NULL,NULL,'А вот и ты! У меня есть для тебя несколько задач, но нет времени на их разъяснение. Так что слушай внимательно.',0,0),(1495,0,'Greetings, $C. Be wary as you travel east toward The Bulwark. Recent surveillance reports indicate increased Scourge activity in that area, so exercise caution.',NULL,NULL,'Seid gegrüßt, $C. Seid wachsam, wenn Ihr nach Osten zum Bollwerk reist. Aktuellen Spähermeldungen zufolge ist in dem Bereich eine erhöhte Aktivität der Greißel zu verzeichnen. Hier ist also Vorsicht geboten.',NULL,NULL,NULL,NULL,'Приветствую тебя, $c. Если ты направишься в Бастион, то будь $gосторожен:осторожна;. Недавние отчеты разведки указывают на увеличение активности Плети в этом районе.',0,0),(3188,0,'There is something you wish to discuss, $c... come, sit by me.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Есть кое-что, что нужно обсудить, $c... проходи, присаживайся.',0,0),(5887,0,'I welcome you back, $n.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую тебя, $n.',0,0),(3139,0,'Throm\'ka, $c. There is little time for talk and much work to be done.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тром\'ка, $c! Так мало времени для разговоров и так много работы предстоит сделать.',0,0),(2519,0,'Hello! The spirits say you here to aid my chief. Say it loud, they do.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Привет! Духи говорят что ты $gпришел:пришла; чтобы оказать помощь.',0,0),(3338,0,'The land, the water and the sky are all as one. It is your eyes that deceive you with such separation. The Earthmother is all those things and more.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Земля, вода и небо едины. Разделение существует только в твоих глазах. Мать-Земля заключает в себя все, и даже более этого.',0,0),(1343,0,'Well, if it isn\'t a young, bristling $c, no doubt drawn here by talk of my exploits in fields of battle!$B$BNo time for stories now, for there are great, important deeds that need doing!  So if you\'re looking for glory, then luck shines on you today...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ну, кто это, как не $c, что рвется на поле брани со всем юным пылом? Несомненно, тебя привлекли сюда слухи о моих подвигах.$B$BСейчас не время для замшелых историй, но время для великих и доблестных свершений! Если ты ищешь славы, то сегодня удача улыбнулась тебе.',1,0),(3446,0,'Yes yes yes! You\'re just the $r I\'m looking for!\r\n\r\nSit! We have much to discuss!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Да, да, да! Именно тебя мне и нужно, $r!$B$BПрисаживайся! Нам нужно многое обсудить!',0,0),(3453,0,'Something I can help you with, $n? There\'s a shipment I\'ve got to see to otherwise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я чем-то могу помочь тебе, $n? А то меня ждет партия товара.',0,0),(253,0,'Aha! Good day, good day, Master $C! Come, sit down and have a drink. You have an enterprising look in your eye, and I think you\'ll find speaking to me worth your time...',NULL,NULL,'Aha! Guten Tag, guten Tag, Meister $C! Kommt, setzt Euch und trinkt etwas. Ihr habt so ein Leuchten in den Augen, als wolltet ihr gern etwas tun. Ich denke, Ihr solltet ein paar Wörtchen mit mir wechseln, es lohnt sich bestimmt...',NULL,NULL,NULL,NULL,'Ага! Добрый день, добрый день, мастер $c! Пойдем, присядем и выпьем. У тебя предприимчивый взгляд, и я думаю, что ты не зря потратишь время на разговор со мной...',0,0),(737,0,'Well, hello there. You seem like you wouldn\'t be opposed to making some coin, hm? I can tell from the look in your eyes. I am Mogul Kebok, overseer of operations in Azeroth, and if it is riches you seek, perhaps I can make arrangements.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ну, привет. Судя по твоим глазам, ты не откажешься от лишних звенящих монет, а? Я Могул Кебок, контролирую все операции в Азероте, и если ты ищешь богатства, возможно, мы сможем договориться.',0,0),(773,0,'$C, eh? I am Krazek, Baron Revilgaz\'s secretary. I know everything about the goings on in this jungle and beyond. Perhaps you\'d be interested in knowing the going price on oil in Ratchet? No? Looking for work, maybe? I can help you there.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'$c, а? Я Кразек, секретарь барона Ревилгаза. Я знаю все, что происходит в этих джунглях и за их пределами. Возможно, тебе будет интересно узнать цену на нефть в Кабестане? Нет? Может быть, ты ищешь работу? Я могу помочь тебе здесь.',0,0),(786,0,'Greetings, $G lad : lass;. I\'m Grelin Whitebeard. I\'m here to examine the threat posed by the growing numbers of trolls in Coldridge Valley. What have I found? It\'s a bit troubling...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Привет. Я Грелин Белобород. Здесь я изучаю угрозу, исходящую от растущего числа троллей в Холодной долине. Что я нашел? Это и беспокоит...',0,0),(1374,0,'Curse that Brewers\' League! They have access to all the best ingredients, while we\'re stuck here grubbing for grain and hops!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Проклятая лига пивоваров! У них есть все лучшие ингредиенты, в то время как мы застряли здесь с зерном и шишками хмеля!',0,0),(1937,0,'The Dark Lady has put the challenge forth.  Now it is up to the Royal Apothecary Society to develop a new plague.  We shall bring Arthas and his wretched army to their knees.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Темная Госпожа поручила Королевскому фармацевтическому обществу разработать новую чуму. Мы поставим Артаса и его мерзкую армию на колени.',0,0),(2076,1,'This cauldron churns with thick, green bubbles.  Skulls, bones and organs of unknown creatures swim within its viscous broth...$B$BAnd rising lazily to the surface are the skulls of two, once mighty trolls:$B$BGan\'zulah and Nezzliok.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Котел бурлит большими зелеными пузырями. Черепа, кости, органы неизвестных существ плавают внутри этого вязкого бульона...$B$BНа поверхность лениво всплывают черепа двух некогда могучих троллей, Ган\'зулаха и Неззилока.',0,0),(2121,0,'Information... With our scouts and agents, we control the flow of information in Lordaeron. Scourge movements, their holdings, all underneath our watchful eyes...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Информация... Благодаря нашим разведчикам и агентам мы контролируем поток информации в Лордероне. Передвижение Плети, их запасы, все под нашим бдительным оком...',0,0),(2285,0,'My family boasts the finest collection of jewelry and objects of fine art among all the nobles of Stormwind!$B$BAnd we are always wishing to increase the size our collection...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Моя семья может похвастаться лучшей коллекцией ювелирных изделий и предметами искусства среди всех дворян Штормграда!$B$BИ мы всегда жаждем расширить свою коллекцию...',0,0),(2498,0,'What what?!?  We all have profit to make... and we won\'t do it by standing idle.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Что-что?! Мы все получаем прибыль, занимаясь... и останься мы без дела, у нас ничего этого не будет.',0,0),(2921,0,'How perfect of you to come by, $c.$B$BMy name is Lotwil Veriatus, founding member of the Enlightened Assembly of Arcanology, Alchemy, and Engineering Sciences: we seek to blend the intelligent sciences of Azeroth together into one comprehensive school.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Как хорошо, что ты здесь, $c.$B$BМеня зовут Лотвиль Вериатус и я состою в Просвещенной Ассамблее Чародейства, Алхимии и Технических Наук. Мы стремимся объединить интеллектуальные науки Азерота в одну общеобразовательную школу.',0,0),(3391,0,'Thrall paid me and my boys well for helping out with the construction of Orgrimmar, so I decided to set up a port here. We do most of our business through Booty Bay and Baron Revilgaz.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тралл заплатил мне и моим ребятам за помощь в строительстве Оргриммара, так что я решил основать здесь порт. В основном мы обделываем делишки в Пиратской Бухте, через барона Ревилгаза.',0,0),(4791,0,'We may not be in open war with the Alliance, but blood is still shed between us.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Может мы и не в открытой войне с Альянсом, но между нами все еще льется кровь.',1,0),(5204,0,'If we are to make our place in this world, then we will do so through study, and through the will to ignore our fading human instincts.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Если мы хотим занять свое место в этом мире, мы должны заниматься исследованиями, а также игнорировать наши угасающие человеческие инстинкты.',0,0),(5394,0,'Don\'t let the heat bother you.  In the Badlands, heat is the least of your worries.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не позволяй жаре беспокоить себя. В Бесплодных землях она наименьшая из проблем.',1,0),(5591,0,'This sty\'s a little shy of comfy, but it has history, so Stonard must be important to someone. I\'d gamble that\'s why we stay here. It sure ain\'t for the view--it don\'t even look like home.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Этот свинарник не очень-то удобен, но у него есть своя история, и для кого-то Каменор, наверное, важен. Мне еще повезло, что мы тут застряли. Конечно, не из-за его красот, - это место трудно назвать даже подобием дома.',1,0),(7407,0,'The name\'s Bilgewhizzle, and I am the chief engineer of the Gadgetzan Water Company.  What can I assist you with?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Меня зовут Чепухастер и я главный инженер компании \"Воды Прибамбасска\". Чем я могу помочь тебе?',0,0),(7876,0,'Some people wonder what we\'re doing out here in the desert.  Well... if I told you, then you\'d stay and try to make our profits!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Некоторые задаются вопросом, чем мы занимаемся здесь, в пустыне. Что ж... если я расскажу тебе, тогда ты останешься здесь и попытаешься получить от этого нашу прибыль!',1,0),(7882,0,'We\'re here to make a profit.  And having our goods stolen is no way to make a profit.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы здесь ради прибыли, а украденные товары этому не способствуют.',1,0),(7900,0,'Hello, $N. Perhaps you have some time to chat?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Привет, $n. У тебя не найдется времени поговорить?',0,0),(9078,0,'Dear $g boy:girl;, you have arrived just in time to assist the Kargath Expeditionary Force.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'$gДорогой друг:Дорогая подруга;, вы прибыли как раз вовремя, чтобы оказать помощь экспедиционному корпусу Каргата.',1,0),(10926,0,'I never feel warm anymore...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я больше никогда не почувствую тепла...',0,0),(11039,0,'Greetings, $N. I am Duke Nicholas Zverenhoff of the Argent Dawn.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(342,0,'Hail, $n. Welcome to my humble garden. The weather has been perfect lately. Let us hope it holds steady for a ripe harvest.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую, $n! Добро пожаловать в мой скромный сад. В эти дни погода прекрасна. Будем надеяться, что она останется такой же до созревания урожая.',0,0),(240,0,'Ach, it\'s hard enough keeping order around here without all these new troubles popping up!  I hope you have good news, $n...','어이쿠, 이렇게 자꾸 새로운 문제가 발생해서는 이곳 주위의 질서를 바로잡기가 어렵습니다! $n, 당신이 좋은 소식을 가져왔으면 좋겠군요...','Ha, c\'est déjà pas facile de maintenir l\'ordre par ici sans rajouter tous ces nouveaux problèmes ! J\'espère que vous apportez de bonnes nouvelles, $n...','Ach, es ist schon schwierig, hier Ordnung zu wahren, auch ohne die ganzen neu aufgetretenen Probleme! Ihr habt hoffentlich gute Neuigkeiten, $n...','啊，就算没有这些新麻烦不断的冒出来，维持这儿的秩序就已经够让人头痛的了！希望你有好消息，$n……','唉，光要管好這邊的秩序已經很不容易了，更何況還有這麼多的新問題一直冒出來。我希望你帶來的是好消息，$n...','¡Ay, ya es difícil mantener el orden por aquí sin que aparezcan de repente todos esos nuevos problemas! ¡Espero que traigas buenas noticias, $n...','¡Ay, ya es difícil mantener el orden por aquí sin que aparezcan de repente todos esos nuevos problemas! ¡Espero que traigas buenas noticias, $n...','Ох, и без этих новых проблем было довольно сложно поддерживать здесь порядок! Надеюсь, у тебя хорошие новости, $n...',0,0),(2215,0,'In order to serve the Dark Lady and Varimathras we need to advance the front on the Human Infestation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(2216,0,'We are but so close to developing the New Plague that our Dark Lady desires with such fervor.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы так близки к созданию Новой Чумы, которую с таким нетерпением ждет наша Темная Госпожа.',0,0),(264,0,'At ease, $c. If you are just passing though I suggest you stick to the roads and only travel by day. If your business is here in Darkshire, consider lending your abilities to the Night Watch. Our Skill is unquestionable but our numbers are small.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Если ты просто прогуливаешься, $c, то лучше держаться дороги и делать это только днем. Если дела ждут тебя здесь в Темнолесье, то стоит заглянуть к Ночному Дозору. Наши навыки неоспоримы, но ряды наши малы.',0,0),(344,0,'Redridge is awash in chaos!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Красногорье погружено в хаос!',5,0),(392,0,'Do not be alarmed, $r.  I have long since passed from this land but I intend no harm to your kind.  I have witnessed too much death in my time.  My only wish now is for peace.  Perhaps you can help my cause.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Не бойся, $r. Меня уже давно нет в этом мире, и я не желаю тебе зла. В свое время мне пришлось повидать слишком много смертей и моим единственным желанием сейчас является достижение мира. Возможно, ты сможешь помочь моему делу.',0,0),(900,0,'What business brings you before the Court of Lakeshire and the Honorable Magistrate Solomon?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Какие дела привели тебя к ратуше Приозерья и уважаемому мировому судье Соломону?',6,0),(2080,0,'The creation of Teldrassil was a grand achievement, but now the world must shift to regain its balance.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Создание Тельдрассила было огромным достижением, но теперь, чтобы восстановить равновесия, мир должен измениться.',1,0),(3337,0,'The heft of an axe, the battlecry of your allies, the spray of blood in your face. These are the things a warrior craves, $n. I will carve out The Barrens with my sword in the name of the Horde.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Лезвие топора оставит брызги крови врага на твоем лице. Это то, чего жаждет каждый воин, $n. Я очищу Степи, своим мечем, во имя Орды.',0,0),(3339,0,'This had better be good...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Это было бы лучше...',0,0),(3390,0,'The Barrens holds a variety of substances for which we, the apothecaries of Lordaeron may find use.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'В Степях находятся различные материалы, которым мы – аптекари Лордерона можем найти применение.',1,1),(3519,0,'I, Arynia Cloudsbreak, have been tasked with protecting the sanctity of the Oracle Grove.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я Арания Проблеск Солнца, моя задача охранять Поляну Оракула.',0,0),(3567,0,'Well met, $n. It is good to see that $cs like yourself are taking an active part in protecting the groves.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приятно встретить вас, $n. Хорошо, что такой $c как вы, принимает активное участие в защите рощ.',1,0),(3847,0,'Ashenvale is a lush forest, brimming with life. It is a pleasure to walk down its secret paths in search of herbs, but one must take care. The forest is not without its dangers.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ясеневый лес – пышный, наполненный жизнью лес. Очень приятно ходить по тайным тропам в поиске трав. Но этот лес не лишен опасностей.',0,0),(3995,0,'The spirits are restless!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Духи обеспокоены!',5,0),(4049,0,'The spirit of Stonetalon weeps... It weeps from its mountain peaks, to its rivers, to its severed, dying trees.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Дух Когтистых гор плачет... Он плачет от своих горных вершин до рек, срезанных и мертвых деревьев.',0,0),(5767,0,'Our only hope is to create something good from an already bad situation.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нашей единственной надеждой является появление чего-то хорошего в ужасной ситуации.',1,0),(2706,0,'Thanks to the Warchief, even here in the ruins of our former prison some hope remains, and the Horde rises anew.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Благодаря Вождю, даже здесь, в руинах нашей некогда тюрьмы, остается надежда, что однажды Орда вновь возродится.',0,0),(2817,0,'You must be hard up to be wandering this Badlands, $c. A hard up like me.$B$BOr maybe you\'re here because you\'re crazy. Crazy, like me.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Должно быть, тебе сложно бродить по этим Бесплодным землям, $c. Сложно, как и мне.$B$BИли может, ты здесь лишь потому что $gтакой же сумасшедший:такая же сумасшедшая; как и я.',0,0),(4046,0,'You must listen, young $c.  Listen to the whisperings in the darkness, for they offer guidance in these troubled times.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Тебе стоит прислушаться, юный $c. Прислушайся к шепотам во тьме, они дадут совет в эти темные времена.',1,0),(4452,0,'Come a little closer.  We have important matters to discuss, you and I.$B$BAnd some of them we don\'t want everyone to hear...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Подойди поближе. Есть важные вопросы, которые нам следует обсудить.$B$BНо и есть то, чего не следует тебе слышать...',0,0),(4498,0,'Greetings, $c.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую вас, $c.',0,0),(5412,0,'The centaur clans rule the wastes of Desolace. If united, they would be a terrible force. It is then good that the centaur clans are not united but instead bicker and war amongst themselves.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Кланы кентавров управляют участками Пустошей. Если бы они объединились, то они бы стали ужасной силой. Очень хорошо, что кланы вместо объединения выбрали путь сражения друг с другом.',0,0),(5641,0,'The main threat Thrall wishes dealt with is the Burning Blade---members of the Horde that have given their loyalty to the demons. They seek to practice their dark magic and care little for Thrall\'s visions of the Horde\'s future here in Kalimdor.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Главная угроза, с которой Тралл хочет расправиться, это Пылающий Клинок – члены Орды, которые дали клятву своей верности демонам. Они стремятся к тому, чтобы улучшать свои навыки темной магии, и их мало заботят видения Тралла о будущем Орды здесь в Калимдоре.',1,0),(10537,0,'We cannot take care of all the threats in this area alone. We could use another fighting hand, $n.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы не можем разобраться со всеми угрозами, находящимися в этой местности. И мы бы не отказались воспользоваться рукой помощи, $n.',0,0),(1776,0,'We spent so much of our lives in fight, memories of peaceful times grow evermore distant.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Большую часть нашей жизни мы провели, сражаясь, а воспоминания о мирных временах уже стерлись из памяти.',0,0),(1950,0,'My brother and I are on a scouting mission, but we are holed up in this farmhouse. The Deathstalkers need your help!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы с братом выполняем разведывательную миссию, но застряли в этом доме. Ловчим смерти нужна ваша помощь!',0,0),(3441,0,'To hunt a beast, one must know that beast.  One must learn and respect its ways.$B$BTo do otherwise is not to hunt.  To do otherwise is merely to kill.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Чтобы охотится на зверя, нужно знать этого зверя. Нужно изучать и уважать его пути.$B$BИначе это не охота, а просто убийство.',0,0),(4485,0,'The days grow long, and still no end to the conflicts of these lands can be seen. It takes no spell caster to know that much. Take up a blade while you can, $c. War can come to our doors at any time, and if I\'m not mistaken, you look to be one who revels in it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Дни длятся очень долго, а конфликтам на этих землях нет конца. Возьми свое оружие, $c. Война может придти в любое время, и если я не ошибаюсь, ты выглядишь как $gодин:одна; из тех, кто упивается ею.',1,0),(4500,0,'Overlord Mok\'Morokk boss. You do what I say.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Властитель Мок\'Морокк здесь босс, и ты будешь делать то, что я скажу.',0,0),(6986,0,'My name is Dran Droffers, and this over here is my dummy son Malton.  If you need salvage, or are looking to sell salvage, then we\'re who you need to be talking to!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Меня зовут, Дран Дрофферс, а это мой глупый сын, Мальтон. Если вам нужна помощь или вы хотите продать некоторые из своих вещей, тогда мы именно те, кто вам нужен!',1,0),(9536,0,'The quest for wealth is the only goal for a respectable goblin.$B$BWell, maybe wealth... and a big, loud death!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Поиск сокровища – единственная значимая цель для гоблина.$B$BНу, может, сокровища... и большая, громкая смерть!',0,0),(2497,0,'Eh?  You have business with Nimboya?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'А? Какие дела привели тебя к Нимбойе?',0,0),(715,0,'Another fine day in the jungle!  It\'s going to be quite a hunt,  I can feel it.  Once Barnil is done cleaning the guns, I\'m taking the hunting party deep into the twisting vines.  Not such a bad way for an old war vet to spend his retirement, eh?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Еще один прекрасный день в джунглях! Сегодня будет отличная охота, я чувствую это. Как только Барнил завершит с чисткой моего оружия, я отправлюсь на охоту. Не так уж и плохо для ветерана войны, а?',0,0),(2501,0,'Oy!  You here for a game of knuckles?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Йоу! Хочешь сыграть?',0,0),(5598,0,'What do you ask of me?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'О чем ты хочешь спросить меня?',6,0),(4453,0,'Be careful where you put that foot of yours, $g sir : ma\'am;. We\'re not all blessed with the lofty height of a $R.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(2546,0,'Yarrr... ye best not be trifling with my time, matey!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(5770,0,'If we are to protect nature, then we must embrace its strengths.  And we must show this strength to those who would harm the land.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(265,0,'I have sensed your coming for quite some time, $n.  It was written in the pattern of the stars.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я знал, что ты придешь, $n. Звезды рассказали мне об этом.',0,0),(273,0,'Keep the door closed, $c. Never know when the Dark Riders will be passing through again.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Держи дверь закрытой, $c. Никогда не знаешь, когда Темные всадники пройдут здесь снова.',0,0),(733,0,'You watch where you step around here, $Glad:lass;.  You might not be a part of our outfit, but that doesn\'t mean I won\'t take a cane to you if you fall out of line!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Смотри куда ступаешь, $gпарень:девушка;. Возможно, ты и не являешься частью нашей группы, но это не означает что я не подам тебе трость, если ты упадешь.',0,0),(1071,0,'If there\'s one thing that Rhag taught me it\'s that no assignment is a dull one. Protecting the Thandol Span should have been an easy task. But with the brunt of the army fighting alongside the Alliance, we were overwhelmed here and Dun Modr has fallen.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Защита моста Тандола была не простой задачей. Мы сконцентрировали свои здесь, сражаясь за это место, но Дун Модр пал.',0,0),(2263,0,'I hope you\'re here to work, $C. We have a lot to do and the Horde, the Syndicate and the Ogres aren\'t going to help us.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Надеюсь, $c, вы здесь для того чтобы поработать. Нам необходимо многое сделать, а Орда, Синдикат и Огры не помогут нам.',0,0),(2276,0,'When I was first offered the title of Southshore Magistrate I was exalted to have earned such a commission so early in my career.$B$BBut now that I\'m here, I wonder if I\'d have been better off shuffling papers in Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Когда мне впервые предложили звание судьи Южнобережья, я был очень рад, что получил такой титул в самом начале своей карьеры.$B$BНо теперь, когда я здесь, я задаюсь вопросом, что было бы лучше, если бы я остался перебирать бумаги в Штормграде.',0,0),(2700,0,'We at Refuge Pointe hold one of the few remaining patches of Stromgarde territory in the Arathi Highlands. And we\'re losing ground...$B$BIf you have words for me, then I hope they are good doings.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Опорный Пункт одно из немногих мест оставшееся от былого величия Стромграда, здесь в Нагорье Арати. Но мы теряем эти земли...$B$BЕсли у вас есть вести для меня, то я надеюсь что они хорошие.',0,0),(2713,1,'This wooden board holds roughly made wanted posters.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'На этой деревянной доске размещены различные объявления о розыске.',0,0),(2981,0,'Hail, $c. In my years I have seen many eager tauren who wish to prove their worth to the tribe. It should not be forgotten that eagerness is no substitute for wisdom and experience.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую, $c. В свои годы мне доводилось видеть множество нетерпеливых тауренов, которые хотят доказать свою ценность племени. Но не следует забывать, что стремление не заменит мудрость и опыт.',0,0),(2988,0,'The Outrunners\' duty is to ensure the safety of those who travel across the plains of Mulgore. Those that would threaten the safety of the tauren homeland risk punishment at our hands.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(2993,0,'The land has been good to our people, $c. We must be thankful for our good fortune.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Эта земля благосклонна к нашему народу, $c. Мы должны быть благодарны за нашу удачу.',0,0),(4794,0,'Researching in Theramore is an interesting job, but it\'s sure hard to find a soft bed in this town!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(186420,1,'This collection of scrolls contains various logistic and strategic information, as well as coded correspondences.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(239,0,'Adventure from lands far and near $bMeeting with folks both odd and queer $bBut if of me a question you ask $bYou must first complete a simple task!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приключения в ближних и дальних землях$BВстреча со странными и не странными людьми$BНо если у тебя есть, на который ты хочешь знать ответ$BСперва нужно решить простую задачу!',0,0),(267,0,'Welcome to the town of Darkshire.  Clerk Daltry at your service.  Can I be of some assistance?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Добро пожаловать в Темнолесье. Клерк Далтри к вашим услугам. Могу ли я чем-то помочь?',0,0),(272,0,'Hello, hello!  Welcome to my kitchen, $g sir : m\'lady;!  This is where all of the Scarlet Raven Tavern\'s finest delicacies are made.  Ah, just smell the wonderful aroma!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Привет, привет! Добро пожаловать на мою кухню, $gсэр:миледи;! Здесь вы найдете самые лучшие деликатесы таверны \"Алый ворон\". Ах, какой прекрасный аромат!',0,0),(278,0,'Hello, good $gsir:lady;.  Have a seat, and a meal if you\'re hungry.  Don\'t fret if I look busy with my needlework - I\'m listening to you...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Здравствуйте, $gсэр:леди;. Присаживайтесь и если вы голодны, угощайтесь. Не обращайте внимания на мою занятость, я вас внимательно слушаю...',0,0),(288,0,'Huh?!?  Oh.  You don\'t look like a Defias thief...or a member of the Night Watch.  Take pity on a poor soul, will ya?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'А?!? Ох, вы не похожи на одного из членов Братства Справедливости... или Ночного Дозора. Не пощадите ли бедную душу?',0,0),(289,0,'Eh?  Greetings, young $C.  You\'re a brave one to find your way here with all those wandering creatures about!$B$BWell now that you are here, maybe you can help an old hermit...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'А? Приветствую вас, молодой $c. Вы очень смелы, раз пришли сюда мимо всех этих существ!$B$BХорошо, раз вы здесь, может, поможете старому отшельнику...',0,0),(294,0,'Hail, traveler.  My eyesight may be poor but I can sense the footsteps of a $c from a mile away.  For years I defended Stormwind with pride but once my eyes failed me, I was forced to retire.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую тебя, искатель приключений. Мое зрение уже не так хорошо, как было раньше, но я могу за милю услышать шаги $c. В течение долго времени я стоял на страже Штормграда, но как мое зрение подвело меня, я был вынужден уйти в отставку.',0,0),(313,0,'Welcome to the Tower of Azora, young $C.  I am Theocritus.$B$BDo you have business with me?  Or...do I have business with you, perhaps?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Добро пожаловать в Башню Азоры, молодой $c. Я Теокрит.$B$BУ тебя есть ко мне какие-то вопросы? Или... у тебя есть вопросы к себе?',0,0),(341,0,'I don\'t have much time for idle talk, $N.  I\'ve got to get this bridge rebuilt before the rains come.  I\'ve finished every project on-time and under budget and I\'m not about to start slipping now.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У меня нет времени на разговоры, $n. Мне нужно разобраться с этим мостом до того как пойдет дождь. Я каждый проект заканчивал вовремя, и не собираюсь прокалываться сейчас.',0,0),(381,0,'Well met, $C.  If you\'re here for business, then get yourself a brew and we\'ll have ourselves a talk.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую, $c. Если вы здесь по делам, тогда берите себе настойку и обсудим ваши дела.',0,0),(382,0,'I don\'t have time to chat, citizen, but if you\'re willing to give us a hand against the orcs, then I\'ll find a use for you.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У меня нет времени на болтовню. Но если ты $Gготов:готова; протянуть нам руку помощи в сражении против орков, тогда я найду тебе применение.',0,0),(415,0,'Hey $Gbuddy:ma\'am;, do you think you could give me a hand with something?  I\'m really in dire straits here...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Эй $gприятель:мэм;, думаете, вы сможете мне что-то дать? Я и вправду в ужасном положении здесь...',0,0),(464,0,'Hail, $C.  Ill times these are, my friend, for our town is besieged!  The Blackrock Orcs attack from Stonewatch Keep, the Shadowhides loom over the Tower of Ilgalar, and the Redridge Gnoll Pack gathers strength.  I hope you\'re not here for a holiday...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую тебя, $c. Сейчас настали плохие времена для нашего города, друг мой. Орки ведут свои атаки со стороны крепости Каменной Стражи, Темношкуры маячат у башни Илгалара, а гноллы Красногорья собираются с силами. Надеюсь, ты здесь не для отдыха...',0,0),(469,0,'Greetings, $c.  If you\'re a friend of Colonel Kurzen then I\'ll have you cut down where you stand! but if you\'ve come to aid us, then lend an ear...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую, $c. Если ты $Gодин:одна; из приспешников полковника Курцена, тогда стой где стоишь! Но если ты здесь чтобы помочь нам, тогда я слушаю...',0,0),(633,0,'It\'s dark times that have come, $c... All too soon will we lose everything... When the Light will forsake all but those who truly walk under the Light.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Пришли темные времена, $c... Скоро мы все потеряем... Свет покинет всех.',0,0),(656,0,'There were thieves everywhere! $b$bIt was horrible.  The cave came down on us.  I think the mining company is all dead, including my brother, the Foreman.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Бандиты были всюду!$B$BЭто было ужасно. Пещера обвалилась на нас. Думаю, вся добывающая компания мертва, включая моего брата, Штейгера.',0,0),(663,0,'The Carevin family fights for victory under the Light. My duty under the Light is to give my life in their battle against against the undead. Master Carevin has tasked me with the extermination of the vile worgen in Duskwood. Perhaps you would assit me?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Семья Карвин сражается во имя Света. Моя служба Свету дает мне сил в сражении против нежити. Мастер Карвин поручил мне уничтожить мерзких воргенов в Сумеречном лесу. Может, ты мне поможешь?',0,0),(1105,0,'You know, I always wanted to be a Prospector, but I was born with a head for numbers and the Guild decided I would be best suited to keep the books! Studying, studying, every day of my youth...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Знаешь, мне всегда хотелось стать геологом, но моя голова с рождения все очень хорошо запоминала и Гильдия решила повесить на меня ответственность за книги! Изучение, изучение, каждый день изучение...',0,0),(1139,0,'Well hello there, citizen. The name\'s Bluntnose, Magistrate Bluntnose, to be precise. I\'m charged with overseeing the well-being of Thelsamar, and believe you me, we could always use another strong set of arms around here!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Привет. Меня зовут Тупонос, мировой судья Тупонос, если быть точнее. Мне поручено следить за благополучием Телсамара.',0,0),(1141,0,'If you\'re here for the food, then welcome!  You won\'t find finer dining in all of Stormwind...or Azeroth!$B$BIf you\'re here on other matters, then please be brief.  I have a dozen dishes in preparation, and must care for each.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Если вы здесь ради еды, тогда добро пожаловать! Вы не найдете еду лучше во всем Штормграде... или Азероте!$B$BЕсли вы здесь по другим вопросам, тогда, пожалуйста, давайте быстрее. У меня готовится очень много блюд и мне нужно позаботиться о каждом из них.',0,0),(1239,0,'If you\'re willing to endure tales that will shiver your timbers and sog your skivvies, then get yourself a drink and sit for a spell...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Если вы готовы выслушать дюжину рассказов, тогда присаживайтесь перед заклинением...',1,0),(1254,0,'Troggs! I swear the gods put them in this land only to torment me! Four inches deeper into the mines, then two feet back from the troggs!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Трогги! Клянусь, сами боги разместили их здесь, чтобы досаждать мне!',0,0),(1267,0,'Welcome to the Thunderbrew Distillery, founded by dear ol\' pappy, Arkilus Thunderbrew.  I\'ve been keeping the place running ever since my older brother, Grimbooze, disappeared in a drunken haze a few harvests ago.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Добро пожаловать в нашу таверну! Я управляю этим местом с тех пор, как мой брат Мрачнобух исчез в пьяном кураже несколько урожаев назад.',0,0),(1344,0,'Although we\'re trudging through a slow period at these ruins, I\'m confident it won\'t last long.  But in the meantime, I could use someone like you.  Would you like to aid the Dwarven Explorers\' Guild?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Мы уже долго возимся с этими руинами, но, надеюсь, это не продлится долго. Тем временем, можно было бы использовать кого-то вроде тебя. Не желаешь помочь Лиге исследователей?',0,0),(1356,0,'I\'m in the middle of a very important task.  Prospector business.  Unless you have something equally important to say, which I doubt, then you\'ll have to excuse me.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У меня сейчас очень важное задание. Если у вас есть что-то очень срочное для меня, о чем я очень сомневаюсь, тогда, давайте поговорим.',0,0),(1440,0,'You\'ll not find a greater cache of knowledge than in the Royal Library of Stormwind!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Вы нигде не найдете знаний больше, чем в Королевской библиотеке!',1,0),(1646,0,'Greetings, I am Baros Alexston, City Architect of Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую. Я Барос Алекстон, городской архитектор Штормграда.',0,0),(1719,0,'Over here, you worthless...! If you want to do something useful, listen quick!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Здесь ты $Gбесполезен:бесполезна;... ! Если ты действительно хочешь сделать что-то полезное, тогда слушай внимательно!',0,0),(1748,0,'I am Bolvar Fordragon, Highlord of Stormwind.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я Болвар Фордрагон, верховный лорд Штормграда.',66,0),(1977,0,'I was bred and educated for public service. A representative of the people. My skill was not in arms or crafts, but in words and persuasion.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Меня обучали служить обществу. Быть представителем народа. Мои навыки это не умение обращаться с оружием или в ремесле, а иметь подходящие слова и умение убеждать.',0,0),(2092,0,'Siege engines are the pride of every pilot!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Осадные машины – гордость каждого пилота!',0,0),(2094,0,'Greetings, $c. I\'m in a bit of a pinch right now, running very low on hides.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую вас, $c. Мы сейчас находимся в затруднительном положении, у нас очень мало шкур.',0,0),(2785,0,'Back away!  Stay back!  I have a pack full of blastpowder and I\'m not afraid to use it!  I\'ll blow us all away!$B$BOh, never mind.  I thought you were someone else....',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Назад! У меня в руках взрывчатка наполненная порохом, и я не побоюсь ее использовать! Я убью нас всех!$B$BОх, не обращай внимания. Я думал, что это кто-то другой...',0,0),(2786,0,'Welcome to Bonegrip\'s Runes and Dooms, $c.  You may look, but do not touch.$B$BSome of the knowledge here is not meant for the...uninitiated.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Добро пожаловать в лавку Костохвата, $c. Вы можете смотреть, но ничего не трогайте.$B$BНекоторые из знаний, не предназначены для... непосвященных.',0,0),(2860,0,'It was quite a departure, let me tell you, $c. We were grabbing whatever wasn\'t nailed down or could be removed quickly. We\'re a little spare on supplies because of it.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Это было довольно неплохое отступление я вам скажу, $c. Мы хватали все, что можно было унести, и от этого наши запасы не так велики.',0,0),(2910,0,'Bastards came right at us at night, after we\'d gotten a few drinks in us. Otherwise, we could\'ve taken \'em, count on it.$B$BEveryone\'s dead now... except a few of us.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Они пришли ночью, как раз после того, как мы употребили несколько крепких напитков. В противном случае, мы бы схватили их.$B$BТеперь все мертвы... кроме нескольких из нас.',1,0),(2920,0,'Hey there, $N.$B$BLotwil\'s not the most perceptive boss I\'ve had. He actually gets really involved with his work. So much so that sometimes his servants don\'t eat, or get paid.$B$B$B$BBut that doesn\'t mean you should suffer.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Привет, $n.$B$BЛотвитль не самый лучший босс, который у меня когда-то был. Он очень погружен в свою работу, настолько, что иногда его прислужники остаются голодными или без оплаты.$B$B$B$B*Люсьен хмуро смотрит на Лотвитля.*',1,0),(3663,0,'Good day, $glad:lass;! Perhaps you could help me with some things that need to be taken care of.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Доброго дня! Возможно, вы бы смогли мне помощь с некоторыми вещами, о которых необходимо позаботиться.',0,0),(3666,0,'Hmm... I can plug this wire in here and that will power the fizzletan gear, but then the hydrophlange will need an alternate power source... Maybe I can... Oh, hello! Hey, want to help me try a new invention?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Хм... я могу подключить этот провод сюда, и тогда механизм придет в действие, но тогда для гиро потребуется альтернативный источник питания... Возможно, я могу... О, привет! Не хочешь помочь мне с новым изобретением?',0,0),(4078,0,'Hello, friend. What can I do for you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую, $gдруг:подруга;. Что я могу сделать для вас?',6,0),(4456,0,'No, Longears isn\'t my real name.  And I\'m not going to tell you what it is, so don\'t ask.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Нет, Длинноушка не мое настоящее имя. И я не сообщу тебе, что это означает, даже не спрашивай.',0,0),(4792,0,'Some people think the swamp\'s no good... no good, they say.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Некоторые говорят, что болота это не хорошо... ничего хорошего, говорят они.',0,0),(5396,0,'The Alliance has many stakes in Desolace, and our hold here is unstable.$B$BWill you help us?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Альянс имеет много ставок здесь в Пустошах, и наша позиция здесь неустойчива.$B$BПоможете ли вы нам?',0,0),(5638,0,'I\'ve got a lot going on out here in Desolace, $N. Roetten wants us to pick up some reagents for one of our clients as well as fetch some of these lost items.$B$BSeein\' as you\'re here to help out, why don\'t we get started?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'У меня много дел здесь в Пустошах, $n. Ройттен хочет, чтобы мы забрали некоторые реагенты для одного из наших клиентов, а также доставили несколько утраченных предметов.$B$BПохоже, что ты здесь чтобы помочь нам, так почему бы нам не начать?',1,0),(6031,0,'Some can\'t stand the heat of the Great Forge, but I think the heat is just right.  And it\'s the best place to do some serious smithwork.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Некоторые не могут выдержать тот жар, исходящий от Великой Кузни, но я считаю, что с этим здесь все в порядке. Это лучшее место для того, чтобы в серьез заняться кузнечным делом.',1,0),(6179,0,'Many tests await a paladin of the Light, $N. Be assured, our paths will cross many times in the future if you remain passionate and hold to those virtues that we praise.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Многие испытания ждут паладина Света, $n. Будьте уверены, в будущем, наши пути еще много раз пересекутся, если же вы все также останетесь верны своей страсти и не отбросите те качества, которые мы возвышаем.',1,0),(6569,0,'Where Troggs and Leper Gnomes roam stands our home - Gnomeregan.$B$BOur families lost, our homes displaced. Scattered.$B$BOh how I long for the days of carefree Gnomeregan life, but those days are no more. We must make our stand! We must save Gnomeregan!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Там где обитают Трогги и лепрогномы, наш дом – Гномреган.$B$BНаши семьи потеряны, наш дом теперь теперь другой.$B$BОх, как хочется вернуться в те беззаботные дни жизни в Гномрегане, но этих дней больше нет. Мы должны укрепить нашу позицию! Мы должны вернуть Гномреган!',0,0),(6579,0,'For Gnomeregan!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'За Гномреган!',0,0),(9081,0,'I never miss...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Я никогда не промахиваюсь...',25,0),(9177,0,'Stand at attention, soldier!$B$BWINKY! SOUND OFF!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Будь начеку, солдат!$B$BТИХО!',5,0),(9562,0,'Greetings, $R.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Приветствую вас, $r.',2,0),(10260,0,'Welcome to Kibler\'s Exotic Pets! How can you help me today??',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Добро пожаловать в экзотический питомник Киблера! Чем вы можете мне сегодня помочь?',5,0),(3848,0,'The balance of nature is a delicate one, and easily tipped.  Are you brave enough to make things right?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Природный баланс очень хрупок. Но достаточно ли вы храбры, чтобы все исправить?',1,0),(1952,0,'Hello, $C.  If you\'re here, then you must know that Silverpine is saturated with our enemies.  To survive, the Forsaken must drive them back!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(10321,0,'<Emberstrife acknowledges your presence.>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(11596,0,'My business plan never accounted for housing giant kodos... maybe I should have gone into the underwater basket weaving business instead.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(7777,0,'The Gordunni Ogres encroach upon our lands.  We send as many as are willing to face them in the desecrated ruins of Feralas.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(16361,0,'The Lich King has brought war against us from the frozen north, and only we of the Argent Dawn stand in his way.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(16478,0,'Good day to you, citizen. Have you come to aid us against the Scourge?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(16786,0,'Greetings, $n. If you bring me necrotic stones from the undead invaders, I can give you access to the stores of the Argent Dawn.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,66,0),(16788,0,'Greetings, $c. I am the Flamekeeper. During the Midsummer Fire Festival, it is my duty to keep this fire beside me burning brightly. It is an honor to be selected for such a task; I fill it gladly.$b$b How can I help you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(1938,0,'The Kirin Tor did not heed my warnings!  The Alliance is a sham.  Arugal is a wreckless fool.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(2055,0,'The Royal Apothecary Society shall heed The Dark Lady\'s call to uncover the New Plague and drive Arthas and his heathen Scourge Army from the world once and for all.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(2229,0,'To think, the place the Warchief was born and raised lies so close.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(4454,0,'Aha!  Did you see that!  I think this new auto-spanner is going to do just the trick for my new influx manifold design.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(11259,0,'Desolace is not such a bad place, if you don\'t mind the constant harassments from the centaurs.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(16281,0,'The Argent Dawn will turn away none who are willing to sacrifice for our cause.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0),(16787,0,'Greetings, $n. If you bring me necrotic stones from the undead invaders, I can give you access to the stores of the Argent Dawn.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,66,0),(16494,0,'Good day to you, citizen. Have you come to aid us against the Scourge?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0);
        
        insert into applied_updates values ('170720221');
    end if;

    -- 19/07/2022 1
    if (select count(*) from applied_updates where id='190720221') = 0 then
        ALTER TABLE `creature_onkill_reputation` DROP COLUMN `IsTeamAward1`;
        ALTER TABLE `creature_onkill_reputation` DROP COLUMN `IsTeamAward2`;
        UPDATE `creature_onkill_reputation` SET `rewonkillrepfaction1` = 0, maxstanding1 = 0, rewonkillrepvalue1 = 0 WHERE `rewonkillrepfaction1` > 209;
        UPDATE `creature_onkill_reputation` SET `rewonkillrepfaction2` = 0, maxstanding2 = 0, rewonkillrepvalue2 = 0 WHERE `rewonkillrepfaction2` > 209;
        DELETE FROM `creature_onkill_reputation` WHERE `rewonkillrepfaction1` = 0 and `rewonkillrepfaction2` = 0;

        insert into applied_updates values ('190720221');
    end if;
    
    -- 25/07/2022 1
    if (select count(*) from applied_updates where id='250720221') = 0 then

        -- Torc the Orc
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `display_id`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400033', '3148', '0', '0', '0', '1', '2576', '400001', '1666.364', '-4345.279', '61.246', '0.764', '120', '120', '0', '100', '100', '0', '0', '0', '0');
        UPDATE `creature_template` SET `name` = 'Torc the Orc', `faction` = '29', `npc_flags` = '2' WHERE (`entry` = '3148');

        -- Journey to Grom'gol
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('801', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Journey to Grom\'gol!', '', '', 'The Warchief has established a base camp in Stranglethorn Vale. Perhaps$Byou would like to visit it? Just say the$Bword and I\'ll take you to Grom\'gol.$B$B<<Note: Our crack team of artists, programmers and aviation engineers$Bare currently hard at work preparing the \"real\" zeppelin for your flying$Bpleasure. In the meantime, please$Benjoy this free teleport instead. --$BThanks, --WoW Team>>', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '4998', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3148', '801');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3148', '801');

        -- Journey to Undercity - Fix text. (Grom'gol to Undercity)
        UPDATE `quest_template` SET `OfferRewardText` = 'So you\'re the adventurous type, eh? I\'ll take you right over to Undercity, on Trisfal Glades.$B$BHang on tight! Here we go!$B$B<<Note: Our crack team of artists, programmers and aviation engineers$Bare currently hard at work preparing the \"real\" zeppelin for your flying pleasure. In the meantime, please$Benjoy this free teleport instead. --$BThanks, --WoW Team>>' WHERE (`entry` = '798');

        -- Journey to Undercity (Orgrimmar to Undercity)
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('802', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Journey to Undercity!', '', '', 'So you\'re the adventurous type, eh? I\'ll take you right over to Undercity, on Trisfal Glades.$B$BHang on tight! Here we go!$B$B<<Note: Our crack team of artists, programmers and aviation engineers$Bare currently hard at work preparing the \"real\" zeppelin for your flying pleasure. In the meantime, please$Benjoy this free teleport instead. --$BThanks, --WoW$BTeam>>', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5000', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3148', '802');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3148', '802');

        -- Journey to Orgrimmar (Grom'gol to Orgrimmar) - Fix text.
        UPDATE `quest_template` SET `OfferRewardText` = 'So you\'re the adventurous type, eh? I\'ll take you right over to Orgrimmar, on Durotar.$B$BHang on tight! Here we go!$B$B<<Note: Our crack team of artists, programmers and aviation engineers$Bare currently hard at work preparing the \\\"real\\\" zeppelin for your flying pleasure. In the meantime, please$Benjoy this free teleport instead. --$BThanks, --WoW Team>>' WHERE (`entry` = '799');

        -- Hin Denburg
        UPDATE `spawns_creatures` SET `position_x` = '1899.657', `position_y` = '222.214', `position_z` = '55.368', `orientation` = '1.282' WHERE (`spawn_id` = '32037');

        -- Journey to Grom'gol (Undercity to Grom'gol)
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('803', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', 'Journey to Grom\'gol!', '', '', 'The Warchief has established a base camp in Stranglethorn Vale. Perhaps$Byou would like to visit it? Just say the$Bword and I\'ll take you to Grom\'gol.$B$B<<Note: Our crack team of artists, programmers and aviation engineers$Bare currently hard at work preparing the \"real\" zeppelin for your flying$Bpleasure. In the meantime, please$Benjoy this free teleport instead. --$BThanks, --WoW Team>>', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '4998', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3150', '803');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3150', '803');

        -- Fix floating brazzier outside Grom'gol
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.24' WHERE (`spawn_id` = '10109');
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.24' WHERE (`spawn_id` = '10100');

        -- Fix direction signs placement right outside Undercity.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1993.64', `spawn_positionY` = '235.239', `spawn_positionZ` = '35.7705' WHERE (`spawn_id` = '44783');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1992.1', `spawn_positionY` = '235.836', `spawn_positionZ` = '35.8608' WHERE (`spawn_id` = '44785');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1991.63', `spawn_positionY` = '234.187', `spawn_positionZ` = '35.8391' WHERE (`spawn_id` = '44786');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1993.24', `spawn_positionY` = '233.745', `spawn_positionZ` = '35.7923' WHERE (`spawn_id` = '44790');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1993.36', `spawn_positionY` = '233.759', `spawn_positionZ` = '34.3948' WHERE (`spawn_id` = '44797');

        -- Ignore Zeppeling Landing sign, it was clearly added later.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '44783');
        
        insert into applied_updates values ('250720221');
    end if;

    -- 26/07/2022 1
    if (select count(*) from applied_updates where id='260720221') = 0 then
        -- Add yellow flower to Torc the Orc.
        INSERT INTO `creature_equip_template` (`entry`, `equipentry1`) VALUES ('3148', '2707');
        UPDATE `creature_template` SET `rank` = 0, `equipment_id` = '3148' WHERE (entry = '3148');
		
        -- Barg (General Supplies - Crossroads) https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Barrens/auctionhousebeta.jpg
        UPDATE `spawns_creatures` SET `position_x` = '-411.519', `position_y` = '-2635.225', `position_z` = '97.37', `orientation` = '4.586' WHERE (`spawn_id` = '15092');

        -- Tari'qa (Trade Supplies - Crossroads) https://archive.thealphaproject.eu/media/Alpha-Project-Archive/Images/Azeroth/Kalimdor/Barrens/auctionhousebeta.jpg
        UPDATE `spawns_creatures` SET `position_x` = '-405.287', `position_y` = '-2634.90', `position_z` = '97.37', `orientation` = '3.829' WHERE (`spawn_id` = '15093');
        
        insert into applied_updates values ('260720221');
    end if;
    
    -- 26/07/2022 2
    if (select count(*) from applied_updates where id='260720222') = 0 then
    
        -- Crossroads braziers.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-416.900', `spawn_positionY` = '-2634.74', `spawn_positionZ` = '97.37' WHERE (`spawn_id` = '13364');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-396.841', `spawn_positionY` = '-2639.795', `spawn_positionZ` = '97.37' WHERE (`spawn_id` = '13387');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-410.054', `spawn_positionY` = '-2651.269', `spawn_positionZ` = '97.37' WHERE (`spawn_id` = '13361');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-399.898', `spawn_positionY` = '-2648.639', `spawn_positionZ` = '97.37' WHERE (`spawn_id` = '13386');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-413.885', `spawn_positionY` = '-2634.58', `spawn_positionZ` = '97.37' WHERE (`spawn_id` = '13364');
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '97.37' WHERE (`spawn_id` = '13359');

        -- Worldports. Mostly Z fixes.
        UPDATE `worldports` SET `z` = '87.944' WHERE (`entry` = '1557');
        UPDATE `worldports` SET `z` = '54.066' WHERE (`entry` = '7');
        UPDATE `worldports` SET `z` = '3.12' WHERE (`entry` = '15');
        UPDATE `worldports` SET `z` = '43.6006' WHERE (`entry` = '34');
        UPDATE `worldports` SET `x` = '-338.282', `y` = '-195.726', `z` = '2.377', `o` = '3.084' WHERE (`entry` = '35');
        UPDATE `worldports` SET `x` = '2076.995', `y` = '-4808.518', `z` = '43.392', `o` = '3.90' WHERE (`entry` = '57');
        UPDATE `worldports` SET `z` = '109.334' WHERE (`entry` = '63');
        UPDATE `worldports` SET `z` = '85.026' WHERE (`entry` = '67');
        UPDATE `worldports` SET `z` = '93.256' WHERE (`entry` = '81');
        UPDATE `worldports` SET `z` = '91.72' WHERE (`entry` = '90');
        UPDATE `worldports` SET `x` = '-4827.84', `y` = '-1250.747', `z` = '498.276' WHERE (`entry` = '104');
        UPDATE `worldports` SET `x` = '-7320.239', `y` = '-1078.782', `z` = '277.069' WHERE (`entry` = '106');
        UPDATE `worldports` SET `z` = '418.997' WHERE (`entry` = '111');
        UPDATE `worldports` SET `o` = '290.311' WHERE (`entry` = '114');
        UPDATE `worldports` SET `z` = '12.057' WHERE (`entry` = '115');
        UPDATE `worldports` SET `z` = '17.185' WHERE (`entry` = '116');
        UPDATE `worldports` SET `z` = '150.65' WHERE (`entry` = '118');
        UPDATE `worldports` SET `z` = '464.295' WHERE (`entry` = '119');
        UPDATE `worldports` SET `z` = '149.6276' WHERE (`entry` = '121');
        UPDATE `worldports` SET `z` = '156.686' WHERE (`entry` = '122');
        UPDATE `worldports` SET `x` = '-7822.04', `y` = '-1135.43', `z` = '144.086' WHERE (`entry` = '123');
        UPDATE `worldports` SET `z` = '73.224' WHERE (`entry` = '132');
        UPDATE `worldports` SET `x` = '-7793.850', `y` = '-1162.556', `z` = '176.560' WHERE (`entry` = '133');
        UPDATE `worldports` SET `z` = '138.95' WHERE (`entry` = '134');
        UPDATE `worldports` SET `z` = '65.161' WHERE (`entry` = '142');
        UPDATE `worldports` SET `x` = '-2287.804', `y` = '2494.326', `z` = '73.774' WHERE (`entry` = '154');
        UPDATE `worldports` SET `z` = '47.716' WHERE (`entry` = '170');
        UPDATE `worldports` SET `z` = '91.672' WHERE (`entry` = '177');
        UPDATE `worldports` SET `y` = '-4749.331', `z` = '54.697' WHERE (`entry` = '181');
        UPDATE `worldports` SET `x` = '-1181.252', `y` = '2867.726', `z` = '134.623' WHERE (`entry` = '190');
        UPDATE `worldports` SET `z` = '77.894' WHERE (`entry` = '198');
        UPDATE `worldports` SET `z` = '520.165' WHERE (`entry` = '199');
        UPDATE `worldports` SET `z` = '46.285' WHERE (`entry` = '202');
        UPDATE `worldports` SET `z` = '-0.199' WHERE (`entry` = '206');

        -- Ignore gos.
        -- Some doors in the ocean.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '7635');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '7636');
        -- Flying chairs Azshara
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48445');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48441');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48442');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48443');
        -- Boat to Theramore / Boat to Auberdine floating signs.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13771');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13779');
        
        insert into applied_updates values ('260720222');
    end if;

    -- 28/07/2022 1
    if (select count(*) from applied_updates where id='280720221') = 0 then
        -- Despawn NPCs not present in 0.5.3. https://github.com/The-Alpha-Project/alpha-core/issues/313
        UPDATE `spawns_creatures` SET `ignored` = 1 WHERE `spawn_entry1` > 5759;

        insert into applied_updates values ('280720221');
    end if;
    
    -- 28/07/2022 2
    if (select count(*) from applied_updates where id='280720222') = 0 then
        UPDATE `worldports` SET `z` = '69.701' WHERE (`entry` = '207');
        UPDATE `worldports` SET `z` = '-38.813' WHERE (`entry` = '209');
        UPDATE `worldports` SET `z` = '0' WHERE (`entry` = '237');
        UPDATE `worldports` SET `z` = '111.83' WHERE (`entry` = '242');
        UPDATE `worldports` SET `z` = '111.047' WHERE (`entry` = '245');
        UPDATE `worldports` SET `z` = '144.136' WHERE (`entry` = '265');
        UPDATE `worldports` SET `z` = '523.508' WHERE (`entry` = '266');
        UPDATE `worldports` SET `z` = '387.117' WHERE (`entry` = '268');
        UPDATE `worldports` SET `z` = '387.117' WHERE (`entry` = '269');
        UPDATE `worldports` SET `z` = '387.117' WHERE (`entry` = '270');
        UPDATE `worldports` SET `z` = '121.260' WHERE (`entry` = '271');
        UPDATE `worldports` SET `z` = '97.370' WHERE (`entry` = '272');
        UPDATE `worldports` SET `z` = '118.906' WHERE (`entry` = '296');
        UPDATE `worldports` SET `z` = '853.825' WHERE (`entry` = '309');
        UPDATE `worldports` SET `z` = '859.260' WHERE (`entry` = '310');
        UPDATE `worldports` SET `z` = '1327.391' WHERE (`entry` = '316');
        UPDATE `worldports` SET `y` = '190.767', `z` = '34.668' WHERE (`entry` = '321');
        UPDATE `worldports` SET `x` = '-11181.018', `y` = '-1851.852', `z` = '98.672' WHERE (`entry` = '326');
        UPDATE `worldports` SET `z` = '96.429' WHERE (`entry` = '328');
        UPDATE `worldports` SET `z` = '28.639' WHERE (`entry` = '329');
        UPDATE `worldports` SET `z` = '8.221' WHERE (`entry` = '333');
        UPDATE `worldports` SET `z` = '113.920' WHERE (`entry` = '336');
        UPDATE `worldports` SET `z` = '70.794' WHERE (`entry` = '337');
        UPDATE `worldports` SET `z` = '66.910' WHERE (`entry` = '338');
        UPDATE `worldports` SET `z` = '148.081' WHERE (`entry` = '342');
        UPDATE `worldports` SET `x` = '-4591.057', `y` = '-1124.197', `z` = '383.377' WHERE (`entry` = '354');
        UPDATE `worldports` SET `z` = '98.823' WHERE (`entry` = '364');
        UPDATE `worldports` SET `z` = '41.145' WHERE (`entry` = '389');
        UPDATE `worldports` SET `z` = '32.044' WHERE (`entry` = '406');
        UPDATE `worldports` SET `z` = '31.006' WHERE (`entry` = '408');
        UPDATE `worldports` SET `z` = '55.646' WHERE (`entry` = '411');
        UPDATE `worldports` SET `z` = '136.463' WHERE (`entry` = '442');
        UPDATE `worldports` SET `z` = '3.376' WHERE (`entry` = '451');
        UPDATE `worldports` SET `x` = '-7650.926', `y` = '-1294.159', `z` = '201.667' WHERE (`entry` = '456');
        UPDATE `worldports` SET `z` = '17.418' WHERE (`entry` = '467');
        UPDATE `worldports` SET `z` = '53.82' WHERE (`entry` = '501');
        UPDATE `worldports` SET `z` = '527.072' WHERE (`entry` = '519');
        UPDATE `worldports` SET `z` = '501.663' WHERE (`entry` = '540');
        UPDATE `worldports` SET `z` = '66.234' WHERE (`entry` = '568');
        UPDATE `worldports` SET `z` = '91.111' WHERE (`entry` = '573');
        UPDATE `worldports` SET `z` = '502.195' WHERE (`entry` = '585');
        UPDATE `worldports` SET `z` = '488.906' WHERE (`entry` = '602');
        UPDATE `worldports` SET `x` = '-4790.640', `y` = '-1013.007', `z` = '487.942' WHERE (`entry` = '606');
        UPDATE `worldports` SET `x` = '-4815.03', `y` = '-1038.72', `z` = '482.537' WHERE (`entry` = '610');
        UPDATE `worldports` SET `z` = '167.699' WHERE (`entry` = '621');
        UPDATE `worldports` SET `z` = '78.698' WHERE (`entry` = '639');

        -- Braziers, Barrens.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13313');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13326');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13308');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13475');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13466');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13471');
        
        -- Braziers, Feralas.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '50051');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '50045');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '50048');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '50061');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '50063');
        
        -- Chairs, Barrens.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13394');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13397');
        
        -- Forge, Barrens.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2288.750', `spawn_positionY` = '-1952.756', `spawn_positionZ` = '95.93' WHERE (`spawn_id` = '13306');
        -- Anvil, Barrens.
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2291.904', `spawn_positionY` = '-1943.914', `spawn_positionZ` = '95.472' WHERE (`spawn_id` = '13301');
    
        insert into applied_updates values ('280720222');
    end if;

    -- 31/07/2022 1
    if (select count(*) from applied_updates where id='310720221') = 0 then
        -- Elaine Trias display id
        UPDATE `creature_template` SET 
        display_id1=285
        WHERE entry=483;

        -- Elaine Trias location
        UPDATE `spawns_creatures` SET 
        `position_x`=-8847.16796875,
        `position_y`=564.8961791992188,
        `position_z`=94.68733978271484
        WHERE `spawn_id`=79665;

        -- Corbett Schneider display id
        UPDATE `creature_template` SET 
        `display_id1`=88
        WHERE `entry`=1433;

        insert into applied_updates values ('310720221');
    end if;

    -- 31/07/2022 2
    if (select count(*) from applied_updates where id='310720222') = 0 then
        -- Fix Osric Strang not being a quest giver.
        UPDATE `creature_template` SET `npc_flags` = 3 WHERE `entry` = 1323;

        insert into applied_updates values ('310720222');

    end if;

    -- 01/08/2022 1
    if (select count(*) from applied_updates where id='010820221') = 0 then
        -- THUNDERBLUFF

        -- Ignore unused game objects : flying signs, shop signs with no display id
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (18208, 18204, 18198, 18187, 18292, 20831, 20828, 18283, 18281, 18278, 18296, 18294, 18618, 18230, 18226, 18219, 18191, 18184, 18710, 18708, 18684, 20834, 20465, 20391, 20437, 18628, 18630, 18627, 18666, 20380, 20378, 20356, 20442, 20351, 20338, 18681, 22025, 18171, 18440, 18438, 18437, 18177, 18168, 18459, 18458, 18456, 18160, 18152, 18436, 18299, 18474, 18164, 18156, 20427, 20428, 18623, 20383, 18166, 18155, 18170, 18159, 18716, 18175, 18615, 18614, 18559, 20471, 20335, 30334, 20472, 20386, 20334, 18616, 20381);

        -- Bluffwatcher, display id 3784 is already use for Brave Rainchaser but it is identical to Bluffwatcher screenshots (see alpha archives, thunderbluff)
        UPDATE `creature_template`
        SET `display_id1`=2141, `display_id2`=3784, `display_id3`=0, `display_id4`=0
        WHERE `entry`=3084;

        -- Cairne Bloodhoof, fix display id, we have screenshot that show Cairne with this display id (see alpha archives, thunderbluff)
        UPDATE `creature_template` SET 
        `display_id1`=59
        WHERE `entry`=3057;

        -- Kendur Binder, we have a screenshot that show Kendur as ThunderBluff Binder (see alpha archives, thunderbluff)
        UPDATE `creature_template`
        SET `name`='Kendur', `subname`='Binder', `faction`=35, `npc_flags`=16, level_min=45, level_max=45, health_min=2972, health_max=2972, scale=1.35
        WHERE `entry`=3427;

        -- Kendur Binder spawn (he was not spawned because he's not part of 1.12)
        INSERT INTO `spawns_creatures` VALUES (NULL, 3427, 0, 0, 0, 1, 0, 0, -1260.245849609375, 69.53073120117188, 126.65142059326172, 2.0436079502105713, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Update scale of Tauren Binders.
        UPDATE `creature_template` SET `scale` = 1.35 WHERE `entry` = 3302;
        UPDATE `creature_template` SET `scale` = 1.25 WHERE `entry` = 3303;

        -- Marna, old binder, we ignore her
        UPDATE `spawns_creatures` SET `ignored`=1
        WHERE `spawn_id`=400014;


        -- ORGRIMMAR

        -- Missing brazier in thrall room, we need to spawn it, this room does not exist in 1.12
        INSERT INTO `spawns_gameobjects` VALUES (NULL, 173137, 1, 1907.69091796875, -4041.87548828125, 40.93000030517578, 0.04390503838658333, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- Missing brazier in thrall room, we need to spawn it, this room does not exist in 1.12
        INSERT INTO `spawns_gameobjects` VALUES (NULL, 173152, 1, 1921.5054931640625, -4105.3994140625, 41.93682861328125, 5.1151533126831055, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- Ignore unused game objects : shop signs with no display ID
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (10641, 10002, 4570, 11142, 11591, 11580, 11798, 11601, 11731, 10221, 11098, 10680, 11600, 10212, 10172, 9909, 11572);

        -- Ignore unused game objects : unused mighty blaze, forge, anvil
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_id` IN (3998687, 3998688, 3998689, 3998690, 3998702, 3998694, 3998695, 3998691, 3998699, 3998682, 3998692);

        -- Thrall, fix display id, display id is a guess but no unique Thrall display id is present in 0.5.3
        -- Untextured tauren is placeholder for Cairne, we assume Untextured orc is placeholder for Thrall
        UPDATE `creature_template` SET 
        `display_id1`=51
        WHERE `entry`=4949;

        insert into applied_updates values ('010820221');
    end if;

    -- 03/08/2022 2
    if (select count(*) from applied_updates where id='030820222') = 0 then
        -- # MULGORE

        -- Windfury matriarch, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1223
        WHERE `entry`=2965;

        -- # DUROTAR

        -- Razormane Dustrunner, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3113;

        -- Kolkar drudge,  this one already got a display_id, but screenshot show another
        UPDATE `creature_template`
        SET `display_id1`=1258
        WHERE `entry`=3119;

        -- Kolkar outrunner
        UPDATE `creature_template`
        SET `display_id1`=1258
        WHERE `entry`=3120;

        -- # BARRENS

        -- Razormane Nak (a named with no display id)
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3434;

        -- Razormane warfury
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3459;

        -- Razormane seer
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3458;

        -- Razormane hunter, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3265;

        -- Razormane mystic
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3271;

        -- Razormane geomancer, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3269;

        -- Razormane thornweaver, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3268;

        -- Razormane water seeker, this one already got a display_id, but screenshot show another
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3267;

        -- Razormane defender, this one already got a display_id, but screenshot show another
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3266;

        -- Razormane stalker, this one already got a display_id, but screenshot show another
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3457;
        

        --

        -- Bristleback thornweaver, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3261;

        -- Bristleback geomancer
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3263;

        -- Bristleback hunter, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3258;

        -- Bristleback water seeker, this one already got a display_id, but screenshot show another
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3260;

        -- Bristleback defender, this one already got a display_id, but screenshot show another
        UPDATE `creature_template`
        SET `display_id1`=1341
        WHERE `entry`=3259;

        --

        -- Kolkar pack runner
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=3274;

        -- Kolkar marauder, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=3275;

        -- Kolkar bloodcharger
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=3397;

        -- Kolkar stormer
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=3273;

        --

        -- Lost Barrens Kodo, we scale it, a screenshot show how big he is
        UPDATE `creature_template`
        SET `display_id1`=1451, `scale`=1.3
        WHERE `entry`=3234;

        -- Sunscale scytheclaw, same display_id as 1.12 and all others raptors in barrens
        UPDATE `creature_template`
        SET `display_id1`=1747
        WHERE `entry`=3256;

        -- Wizzlecrank's shredder, screenshot
        UPDATE `creature_template`
        SET `display_id1`=1303
        WHERE `entry`=3439;

        -- Horde Guards, see issue discussion #332
        UPDATE `creature_template`
        SET `display_id1`=1908, `display_id2`=1909, `display_id3`=3772, `display_id4`=3773
        WHERE `entry`=3501;

        insert into applied_updates values ('030820222');
    end if;
    
    -- 02/08/2022 1
    if (select count(*) from applied_updates where id='020820221') = 0 then

        -- TELDRASSILL

        -- Bloodfeather Matriarch
        UPDATE `creature_template`
        SET `display_id1`=3021
        WHERE `entry`=2021;

        -- Bloodfeather Rogue
        UPDATE `creature_template`
        SET `display_id1`=3021
        WHERE `entry`=2017;

        -- Bloodfeather Wind Witch
        UPDATE `creature_template`
        SET `display_id1`=3021
        WHERE `entry`=2020;

        -- Bloodfeather Sorceress (this mob already has a display id, but we have screenshot that show a different one)
        UPDATE `creature_template`
        SET `display_id1`=3021
        WHERE `entry`=2018;

        -- Mangy Nightsaber -Nightsaber - Same display id as all others Teldrassil Nightsaber
        UPDATE `creature_template`
        SET `display_id1`=3029
        WHERE `entry`=2032;

        -- Nightsaber - Same display id as all others Teldrassil Nightsaber
        UPDATE `creature_template`
        SET `display_id1`=3029
        WHERE `entry`=2042;

        -- Zenn Foulhoof (we have screenshot of him, see alpha archives, Teldrassil)
        UPDATE `creature_template`
        SET `display_id1`=2018
        WHERE `entry`=2150;

        -- Teldrassil Sentinel (There is only one display id of NE guard that is not used by a named NPC, same as Darnassus/Ashenvale guards)
        UPDATE `creature_template`
        SET `display_id1`=2306, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=3571;

        -- Gnarlpine Warrior
        UPDATE `creature_template`
        SET `display_id1`=2001
        WHERE `entry`=2008;

        -- Gnarlpine Pathfinder
        UPDATE `creature_template`
        SET `display_id1`=2001
        WHERE `entry`=2012;

        -- Gnarlpine Defender
        UPDATE `creature_template`
        SET `display_id1`=2001
        WHERE `entry`=2010;

        -- Gnarlpine Ursa
        UPDATE `creature_template`
        SET `display_id1`=2001
        WHERE `entry`=2006;

        -- Gnarlpine Gardener
        UPDATE `creature_template`
        SET `display_id1`=2001
        WHERE `entry`=2007;

        -- Gnarlpine Avenger
        UPDATE `creature_template`
        SET `display_id1`=2001
        WHERE `entry`=2013;

        -- Timberling Bark Ripper (we have screenshot of him, see alpha archives, Teldrassil)
        UPDATE `creature_template`
        SET `display_id1`=3034
        WHERE `entry`=2025;

        -- Yound Thistle Boar, screenshot
        UPDATE `creature_template`
        SET `display_id1`=3027
        WHERE `entry`=1984;

        -- Aelyssa binder spawn, screenshot
        INSERT INTO `spawns_creatures` VALUES (NULL, 3777, 0, 0, 0, 1, 0, 0, 10382.2294921875, 799.4705810546875, 1318.2911376953125, 4.3283305168151855, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        insert into applied_updates values ('020820221');
    end if;


    -- 02/08/2022 2
    if (select count(*) from applied_updates where id='020820222') = 0 then
        -- DARNASSUS BINDER

        -- We ignore Mirallia, old binder
        UPDATE `spawns_creatures`
        SET `ignored`=1
        WHERE `spawn_id`=400025;

        -- We convert Syurana to a binder
        UPDATE `creature_template`
        SET `subname`='Binder', `faction`=35, `npc_flags`=16
        WHERE `entry`=3779;

        -- We delete npc_vendor information for Syurana
        DELETE FROM `npc_vendor`
        WHERE `entry` = 3779;

        -- We update Syruana spawn location and reset ignored
        UPDATE `spawns_creatures`
        SET `ignored`=0, `position_x`=9940.15, `position_y`=2206.46, `position_z`=1328.96, `orientation`=5.911
        WHERE `spawn_id`=42302;

        insert into applied_updates values ('020820222');
        
    end if;
    
    -- 03/08/2022 1
    if (select count(*) from applied_updates where id='030820221') = 0 then
        -- Linen/Heavy Linen/Wool/Heavy Wool Bandage.
        UPDATE `item_template` SET `SpellCharges_1` = 0 WHERE `entry` IN (1251, 2581, 3530, 3531);

        insert into applied_updates values ('030820221');

    end if;

    -- 05/08/2022 3
    if (select count(*) from applied_updates where id='050820223') = 0 then

        -- Barkeep Hann
        UPDATE `creature_template`
        SET `display_id1`=191
        WHERE `entry`=274;

        -- Commandant Althea Ebonlocke 
        UPDATE `creature_template`
        SET `display_id1`=224
        WHERE `entry`=264;

        -- Madame Eva
        UPDATE `creature_template`
        SET `display_id1`=225
        WHERE `entry`=265;

        -- Morg Gnarltree
        UPDATE `creature_template`
        SET `display_id1`=242
        WHERE `entry`=226;

        -- Felicia Maline (gryphon master)
        UPDATE `creature_template`
        SET `display_id1`=186
        WHERE `entry`=2409;

        -- Watcher Fraizer
        UPDATE `creature_template`
        SET `display_id1`=166
        WHERE `entry`=2470;

        -- Watcher Mocarski
        UPDATE `creature_template`
        SET `display_id1`=166
        WHERE `entry`=827;

        -- Nefaru (rare named worgen), same display as other worgen around him
        UPDATE `creature_template`
        SET `display_id1`=522
        WHERE `entry`=534;

        -- Fenros (named worgen), same display as other worgen around him
        UPDATE `creature_template`
        SET `display_id1`=736
        WHERE `entry`=507;

        -- Skeletal healer
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=787;

        -- Skeletal fiend
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=531;

        -- Skeletal horror
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=202;

        -- Skeletal mage
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=203;

        -- Town crier
        UPDATE `creature_template`
        SET `display_id1`=227
        WHERE `entry`=468;

        -- Defias night blade
        UPDATE `creature_template`
        SET `display_id1`=231, `display_id2`=0
        WHERE `entry`=909;

        -- Defias night runner
        UPDATE `creature_template`
        SET `display_id1`=208,`display_id2`=0
        WHERE `entry`=215;

        -- Defias enchanter
        UPDATE `creature_template`
        SET `display_id1`=263, `display_id2`=0
        WHERE `entry`=910;

        -- Binder spawn, we move him a bit
        UPDATE `spawns_creatures`
        SET `position_x`=-10572.599609375, `position_y`=-1149.62841796875, `position_z`=26.46806526184082, `orientation`=5.387844562530518
        WHERE `spawn_id`=400015;

        -- Bartender spawn, we move him a bit
        UPDATE `spawns_creatures`
        SET `position_x`=-10509.090, `position_y`=-1159.387
        WHERE `spawn_id`=4191;

        insert into applied_updates values ('050820223');
    end if;
    
    -- 04/08/2022 1
    if (select count(*) from applied_updates where id='040820221') = 0 then
        -- Foulweald Warrior
        UPDATE `creature_template`
        SET `display_id1`=937
        WHERE `entry`=3743;

        -- Foulweald Totemic
        UPDATE `creature_template`
        SET `display_id1`=1996
        WHERE `entry`=3750;

        -- Foulweald Shaman
        UPDATE `creature_template`
        SET `display_id1`=1996
        WHERE `entry`=3748;

        -- Foulweald Den Watcher
        UPDATE `creature_template`
        SET `display_id1`=937
        WHERE `entry`=3746;

        -- Shandethicket Stone Mover
        UPDATE `creature_template`
        SET `display_id1`=2023
        WHERE `entry`=3782;

        -- Xiavian Felsworn
        UPDATE `creature_template`
        SET `display_id1`=2880
        WHERE `entry`=3755;

        -- Xiavian Betrayer
        UPDATE `creature_template`
        SET `display_id1`=2878
        WHERE `entry`=3754;

        -- Xiavian Rogue
        UPDATE `creature_template`
        SET `display_id1`=2878
        WHERE `entry`=3752;

        -- Xiavian Hellcaller
        UPDATE `creature_template`
        SET `display_id1`=2880
        WHERE `entry`=3757;

        -- Felmusk Shadowstalker
        UPDATE `creature_template`
        SET `display_id1`=2875
        WHERE `entry`=3763;

        -- Felmusk Satyr
        UPDATE `creature_template`
        SET `display_id1`=2010
        WHERE `entry`=3758;

        -- Felmusk Felsworn
        UPDATE `creature_template`
        SET `display_id1`=2687
        WHERE `entry`=3762;

        -- Withered ancient
        UPDATE `creature_template`
        SET `display_id1`=2079
        WHERE `entry`=3919;

        -- Thistlefur Shaman
        UPDATE `creature_template`
        SET `display_id1`=2004
        WHERE `entry`=3924;

        -- Thistlefur Avenger
        UPDATE `creature_template`
        SET `display_id1`=2004
        WHERE `entry`=3925;

        -- Thistlefur Pathfinder
        UPDATE `creature_template`
        SET `display_id1`=2004
        WHERE `entry`=3926;

        -- Thistlefur Totemic
        UPDATE `creature_template`
        SET `display_id1`=2004
        WHERE `entry`=3922;

        -- Dark Strand Excavator
        UPDATE `creature_template`
        SET `display_id1`=1643, `display_id2`=0, `display_id3`=0
        WHERE `entry`=3730;

        -- Dark Strand Cultist
        UPDATE `creature_template`
        SET `display_id1`=1642, `display_id2`=0, `display_id3`=0
        WHERE `entry`=3725;

        -- Dark Strand Adept
        UPDATE `creature_template`
        SET `display_id1`=1643, `display_id2`=0
        WHERE `entry`=3728;

        -- Dark Strand Enforcer
        UPDATE `creature_template`
        SET `display_id1`=1643, `display_id2`=1478, `display_id3`=0
        WHERE `entry`=3727;

        -- Wrathtail Wave Rider
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3713;

        -- Wrathtail Sorceress
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3717;

        -- Wrathtail Sea Witch
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3715;

        -- Wrathtail Myrmidon
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3711;

        -- Wrathtail Razortail
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3712;

        -- Wrathtail Priestess
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3944;

        -- Ruuzel, named naga
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=3943;

        -- Clattering Crawler
        UPDATE `creature_template`
        SET `display_id1`=2239
        WHERE `entry`=3812;

        -- Felslayer
        UPDATE `creature_template`
        SET `display_id1`=850
        WHERE `entry`=3774;

        -- Lesser Felguard (probably Burning Legionnaire)
        UPDATE `creature_template`
        SET `display_id1`=2727, `name`='Burning Legionnaire'
        WHERE `entry`=3772;

        -- Mystlash hydra
        UPDATE `creature_template`
        SET `display_id1`=1993
        WHERE `entry`=3721;

        insert into applied_updates values ('040820221');
    end if;
    
    -- 05/08/2022 1
    if (select count(*) from applied_updates where id='050820221') = 0 then
        -- Fireball Rank 3 -> Rank 1
        UPDATE `creature_spells` SET `spellId_1` = 133 WHERE `entry` IN (15070, 4760, 8810, 20180);
        -- Fireball Rank 3 -> Rank 2
        UPDATE `creature_spells` SET `spellId_1` = 143 WHERE `entry` IN (85030, 32690, 5890, 6190, 4410, 21920, 21600);

        -- Fire Blast Rank 3 -> Rank 2
        UPDATE `creature_spells` SET `spellId_1` = 2137 WHERE `entry` = 17320;

        -- Frost Nova Rank 2 -> Rank 1
        UPDATE `creature_spells` SET `spellId_1` = 122 WHERE `entry` IN (17680, 32600, 19580, 1270, 37170, 34360);

        -- Frostbolt Rank 2 -> Rank 1
        UPDATE `creature_spells` SET `spellId_1` = 116 WHERE `entry` IN (15220, 4740, 29640, 15390, 18670);

        -- Lightning Bolt Rank 3 -> Rank 1
        UPDATE `creature_spells` SET `spellId_1` = 403 WHERE `entry` IN (29530, 13970, 20120);
        -- Lightning Bolt Rank 3 -> Rank 2
        UPDATE `creature_spells` SET `spellId_1` = 529 WHERE `entry` IN (31180, 11660, 32730);

        -- ZZOldKick Rank 1 -> Kick Rank 2
        UPDATE `creature_spells` SET `spellId_1` = 6554 WHERE `entry` = 65540;

        -- Shadow Bolt Rank 4 -> Rank 1
        UPDATE `creature_spells` SET `spellId_1` = 686 WHERE `entry` = 20030;
        -- Shadow Bolt Rank 4 -> Rank 2
        UPDATE `creature_spells` SET `spellId_1` = 695 WHERE `entry` IN (31980, 58220);
        -- Shadow Bolt Rank 4 -> Rank 3
        UPDATE `creature_spells` SET `spellId_1` = 705 WHERE `entry` IN (32030, 113240, 19150, 37280);

        insert into applied_updates values ('050820221');

    end if;

    -- 05/08/2022 2
    if (select count(*) from applied_updates where id='050820222') = 0 then
        -- Fireball Rank 3 -> Rank 2
        UPDATE `creature_spells` SET `spellId_2` = 143 WHERE `entry` IN (21910, 17260, 119170, 39910);
        UPDATE `creature_spells` SET `spellId_3` = 143 WHERE `entry` IN (19140, 119170, 44180, 4500, 5990, 5990, 32630);

        -- Lightning Bolt Rank 3 -> Rank 1
        UPDATE `creature_spells` SET `spellId_2` = 403 WHERE `entry` IN (15440, 29630);
        -- Lightning Bolt Rank 3 -> Rank 2
        UPDATE `creature_spells` SET `spellId_2` = 529 WHERE `entry` IN (15440, 29630, 29650, 20210, 57850, 4560, 19110, 10650, 113190, 95230, 119130);

        -- Shadow Bolt Rank 4 -> Rank 2
        UPDATE `creature_spells` SET `spellId_2` = 695 WHERE `entry` = 11240;
        -- Shadow Bolt Rank 4 -> Rank 3
        UPDATE `creature_spells` SET `spellId_2` = 705 WHERE `entry` = 32040;

        -- zzOLDArcane Missiles Effect -> Arcane Missiles Effect Rank 1
        UPDATE `creature_spells` SET `spellId_2` = 7268, `spellId_3` = 7268 WHERE `entry` = 103580;

        insert into applied_updates values ('050820222');

    end if;

    -- 06/08/2022 1
    if (select count(*) from applied_updates where id='060820221') = 0 then
        -- Vesprystus location.
        UPDATE `spawns_creatures` SET `position_x` = 9938.881, `position_y` = 2640.370, `position_z` = 1318.052, `orientation` = 4.787 WHERE (`spawn_id` = 49938);

        insert into applied_updates values ('060820221');
        
    end if;
    
    -- 06/08/2022 2
    if (select count(*) from applied_updates where id='060820222') = 0 then
        -- Fix Attack Plan: Valley of Trials interaction.
        UPDATE `gameobject_template` SET `flags` = '4' WHERE (`entry` = '3189');
        -- Fix Attack Plan: Sen'jin Village interaction.
        UPDATE `gameobject_template` SET `flags` = '4' WHERE (`entry` = '3190');
        -- Fix Attack Plan: Orgrimmar interaction.
        UPDATE `gameobject_template` SET `flags` = '4' WHERE (`entry` = '3192');
        -- Fix Guarded Thunderbrew ale barrel interaction. (Kharanos)
        UPDATE `gameobject_template` SET `flags` = '4' WHERE (`entry` = '269');

        insert into applied_updates values ('060820222');
        
    end if;

    -- 06/08/2022 3
     if (select count(*) from applied_updates where id='060820223') = 0 then
        -- Gilbin fix, #341
        UPDATE `creature_template` SET `npc_flags` = 1 WHERE `entry` = 5105;
        UPDATE `creature_template` SET `faction` = 57 WHERE `entry` = 5105;
        UPDATE `creature_template` SET `level_min` = 30, `level_max` = 30, `health_max` = 1003, `health_min` = 1003,
        `armor` = 1200, `dmg_min` = 47, `dmg_max` = 63, `ranged_dmg_min` = 33, `ranged_dmg_max` = 49, `attack_power`=122,
        `base_attack_time` = 2000, `ranged_attack_time` = 2000 WHERE `entry` = 5105;
        
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '837', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '838', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '839', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '840', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '843', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '844', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '845', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '846', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '1843', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '1844', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '3428', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '3589', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5105', '3590', '0', '0', '0');

        -- Laene Thundershot fix, #341
        UPDATE `creature_template` SET `npc_flags` = 1 WHERE `entry` = 5104;
        UPDATE `creature_template` SET `faction` = 57 WHERE `entry` = 5104;
        UPDATE `creature_template` SET `level_min` = 40, `level_max` = 40, `health_max` = 1753, `health_min` = 1753,
        `armor` = 1964, `dmg_min` = 63, `dmg_max` = 85, `ranged_dmg_min` = 46, `ranged_dmg_max` = 68, `attack_power`=122,
        `base_attack_time` = 2000, `ranged_attack_time` = 2000 WHERE `entry` = 5104;

        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '2509', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '2511', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '2516', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '2519', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '3023', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '3024', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '3025', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '3033', '0', '0', '0');
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`) VALUES ('5104', '5441', '0', '0', '0');

        -- Caledra Dawnbreeze display fix, #362 
        UPDATE `creature_template` SET `display_id1` = 1643 WHERE  `entry`= 1752;

        insert into applied_updates values ('060820223');
    end if;

    -- 07/08/2022 2
    if (select count(*) from applied_updates where id='070820222') = 0 then
        -- despawn warlock quests
        UPDATE `quest_template` SET `ignored` = '1' WHERE `RequiredClasses` = 256 AND `entry` != 397;

        -- despawn Paladin quests 
        UPDATE `quest_template` SET `ignored` = '1' WHERE `RequiredClasses` = 2;

        -- despawn warrior quests 
        UPDATE `quest_template` SET `ignored` = '1' WHERE `RequiredClasses` = 1;

        insert into applied_updates values ('070820222');
    end if;
    
    -- 07/08/2022 1
    if (select count(*) from applied_updates where id='070820221') = 0 then

        -- DARKSHORE

        -- Moonstalker
        UPDATE `creature_template`
        SET `display_id1`=1043
        WHERE `entry`=2069;

        -- Moonstalker runt
        UPDATE `creature_template`
        SET `display_id1`=1008
        WHERE `entry`=2070;

        -- Moonstalker sire
        UPDATE `creature_template`
        SET `display_id1`=1055
        WHERE `entry`=2237;

        -- Blackwood totemic
        UPDATE `creature_template`
        SET `display_id1`=1011
        WHERE `entry`=2169;

        -- Blackwood ursa
        UPDATE `creature_template`
        SET `display_id1`=1011
        WHERE `entry`=2170;

        -- Blackwood shaman
        UPDATE `creature_template`
        SET `display_id1`=1011
        WHERE `entry`=2171;

        -- Blackwood windtalker
        UPDATE `creature_template`
        SET `display_id1`=1011
        WHERE `entry`=2324;

        -- Carnivous the breaker, named blackwood
        UPDATE `creature_template`
        SET `display_id1`=1012
        WHERE `entry`=2186;

        -- Stormscale Sorceress
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=2182;

        -- Stormscale Warrior
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=2183;

        -- Encrusted Tide Crawler
        UPDATE `creature_template`
        SET `display_id1`=999
        WHERE `entry`=2233;

        -- Rabid Thistle bear
        UPDATE `creature_template`
        SET `display_id1`=1006
        WHERE `entry`=2164;

        -- Licillin, named imp
        UPDATE `creature_template`
        SET `display_id1`=1017
        WHERE `entry`=2191;

        -- Cracked Golem
        UPDATE `creature_template`
        SET `display_id1`=975
        WHERE `entry`=2156;

        -- Writhing Highborne
        UPDATE `creature_template`
        SET `display_id1`=146
        WHERE `entry`=2177;

        -- Wailing Highborne
        UPDATE `creature_template`
        SET `display_id1`=984
        WHERE `entry`=2178;

        insert into applied_updates values ('070820221');

    end if;

    -- 07/08/2022 3
    if (select count(*) from applied_updates where id='070820223') = 0 then

        -- THOUSAND NEEDLES

        -- Pesterhide Snarler
        UPDATE `creature_template`
        SET `display_id1`=1534
        WHERE `entry`=4249;

        -- Venomous Cloud Serpent
        UPDATE `creature_template`
        SET `display_id1`=2700
        WHERE `entry`=4118;

        -- Thundering Boulderkin
        UPDATE `creature_template`
        SET `display_id1`=2302
        WHERE `entry`=4120;

        -- Rok'Alim the pounder
        UPDATE `creature_template`
        SET `display_id1`=2302
        WHERE `entry`=4499;

        -- Sparkleshell Tortoise
        UPDATE `creature_template`
        SET `display_id1`=2307
        WHERE `entry`=4142;

        -- Saltstone Crystalhide
        UPDATE `creature_template`
        SET `display_id1`=2310
        WHERE `entry`=4151;

        -- Saltstone Basilik
        UPDATE `creature_template`
        SET `display_id1`=2309
        WHERE `entry`=4147;

        -- Saltstone Gazer
        UPDATE `creature_template`
        SET `display_id1`=2235
        WHERE `entry`=4150;

        -- Salt Flats Vulture
        UPDATE `creature_template`
        SET `display_id1`=2305
        WHERE `entry`=4158;

        -- Silithid Hive Drone
        UPDATE `creature_template`
        SET `display_id1`=2303
        WHERE `entry`=4133;
        
        -- Silithid searcher
        UPDATE `creature_template`
        SET `display_id1`=2304
        WHERE `entry`=4130;

        -- Silithid invader
        UPDATE `creature_template`
        SET `display_id1`=2304
        WHERE `entry`=4131;

        -- Highperch Patriarch
        UPDATE `creature_template`
        SET `display_id1`=2298
        WHERE `entry`=4110;

        -- Galak centaur : Mauler, Marauder
        UPDATE `creature_template`
        SET `display_id1`=2290
        WHERE `entry` IN ( 4095, 4099 );

        -- Galak centaur : Stormer, Wrangler (caster)
        UPDATE `creature_template`
        SET `display_id1`=2290
        WHERE `entry` IN ( 4097, 4093);

        -- Galak Windchaser
        UPDATE `creature_template`
        SET `display_id1`=2291
        WHERE `entry`=4096;

        -- Galak Scout
        UPDATE `creature_template`
        SET `display_id1`=2292
        WHERE `entry`=4094;

        -- Gnome NPC placeholder
        UPDATE `creature_template`
        SET `display_id1`=2456, `display_id2`=0, `display_id3`=0
        WHERE `entry` IN ( 4720, 4454, 4453, 4430, 4452, 4495 );   

        -- Screeching Windcaller
        UPDATE `creature_template`
        SET `display_id1`=1351
        WHERE `entry`=4104;

        -- Globin Racer -> Goblin Car
        UPDATE `creature_template`
        SET `display_id1`=2280, `name`='Goblin Car',  `subname`='Placeholder for Rocket Car'
        WHERE `entry`=4251;

        -- Globin Drag Car
        UPDATE `creature_template`
        SET `display_id1`=2280,  `subname`='Placeholder for Rocket Car'
        WHERE `entry`=4945;

        -- Zuzubee
        UPDATE `creature_template`
        SET `display_id1`=458
        WHERE `entry`=4707;

        -- Forbee
        UPDATE `creature_template`
        SET `display_id1`=458
        WHERE `entry`=4620;

        -- Gnome Racer -> Gnome Car
        UPDATE `creature_template`
        SET `display_id1`=378, `scale`=4, `name`='Gnome Car',  `subname`='Placeholder for Rocket Car'
        WHERE `entry`=4252;

        -- Gnome Drag Car
        UPDATE `creature_template`
        SET `display_id1`=378, `scale`=4, `subname`='Placeholder for Rocket Car'
        WHERE `entry`=4946;

        insert into applied_updates values ('070820223');

    end if;

    -- 08/08/2022 2
    if (select count(*) from applied_updates where id='080820222') = 0 then

        -- FIX #390

        UPDATE `gameobject_template`
        SET `data0`=57
        WHERE `type`=3 AND `data0`=259;

        insert into applied_updates values ('080820222');

    end if;
end $
delimiter ;
