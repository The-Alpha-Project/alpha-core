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
        CREATE TABLE `alpha_world`.`applied_item_updates` (
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
        UPDATE `item_template` SET `description` = `Needed for Blacksmithing.` WHERE (`entry` = 5956);
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
        UPDATE `item_template` SET `name` = `Rustic Belt` WHERE (`entry` = 2172);
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
        UPDATE `item_template` SET `class` = 7, `description` = `Needed by an Enchanter to make a runed copper rod.` WHERE (`entry` = 6217);
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
        UPDATE `item_template` SET `name` = `Patchwork Belt`, `required_level` = 3 WHERE (`entry` = 3370);
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
        UPDATE `item_template` SET `name` = `Knitted Tunic`, `required_level` = 5 WHERE (`entry` = 795);
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
        UPDATE `item_template` SET `name` = `Patchwork Cloak` WHERE (`entry` = 1429);
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
        UPDATE `item_template` SET `name` = `Bard''s Buckler`, `buy_price` = 2168, `sell_price` = 433, `required_level` = 11 WHERE (`entry` = 6559);
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
        UPDATE `item_template` SET `name` = `Patchwork Armor`, `required_level` = 2 WHERE (`entry` = 1433);
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
        UPDATE `item_template` SET `name` = `Journeyman''s Boots`, `buy_price` = 213, `sell_price` = 42, `item_level` = 10, `required_level` = 5 WHERE (`entry` = 2959);
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
        UPDATE `item_template` SET `name` = `Small Leather Collar` WHERE (`entry` = 4813);
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
        UPDATE `item_template` SET `name` = `Patchwork Pants`, `required_level` = 3 WHERE (`entry` = 1431);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1431, 3596);
        -- Journeyman's Bracers
        -- name, from Strapped Bracers to Journeyman's Bracers
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `name` = `Journeyman''s Bracers`, `required_level` = 5 WHERE (`entry` = 3641);
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
        UPDATE `item_template` SET `name` = `Patchwork Gloves`, `required_level` = 2 WHERE (`entry` = 1430);
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
        UPDATE `item_template` SET `name` = `Patchwork Bracers`, `required_level` = 4 WHERE (`entry` = 3373);
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
        UPDATE `item_template` SET `name` = `Feeble Sword`, `required_level` = 5, `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 1413);
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
        UPDATE `item_template` SET `name` = `Discolored Fang` WHERE (`entry` = 4814);
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
        UPDATE `item_template` SET `name` = `Hunting Tunic`, `required_level` = 10, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2973);
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
        UPDATE `item_template` SET `name` = `Patchwork Shoes`, `required_level` = 5 WHERE (`entry` = 1427);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (1427, 3596);
        -- Tanned Leather Jerkin
        -- name, from Tanned Leather Vest to Tanned Leather Jerkin
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `name` = `Tanned Leather Jerkin`, `required_level` = 12 WHERE (`entry` = 846);
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
        UPDATE `item_template` SET `name` = `Heavy Weave Shoes`, `required_level` = 12 WHERE (`entry` = 840);
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
        UPDATE `item_template` SET `name` = `Warped Leather Belt`, `required_level` = 9 WHERE (`entry` = 1502);
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
        UPDATE `item_template` SET `name` = `Scroll of Protection`, `buy_price` = 100, `sell_price` = 25, `item_level` = 10 WHERE (`entry` = 3013);
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
        UPDATE `item_template` SET `name` = `Mageroyal` WHERE (`entry` = 785);
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
        UPDATE `item_template` SET `name` = `Blackrock Boots`, `required_level` = 14 WHERE (`entry` = 1446);
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
        UPDATE `item_template` SET `name` = `Magister''s Boots`, `required_level` = 10 WHERE (`entry` = 2971);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (2971, 3596);
        -- Patched Leather Shoulderpads
        -- name, from Rawhide Shoulderpads to Patched Leather Shoulderpads
        -- required_level, from 10 to 15
        UPDATE `item_template` SET `name` = `Patched Leather Shoulderpads`, `required_level` = 15 WHERE (`entry` = 1793);
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
        UPDATE `item_template` SET `name` = `Pearl-handled Dagger`, `required_level` = 17, `dmg_min1` = 11, `dmg_max1` = 21 WHERE (`entry` = 5540);
        INSERT INTO `applied_item_updates` (`entry`, `version`) VALUES (5540, 3596);
        -- Hook Dagger
        -- name, from Wavy Blladed Knife to Hook Dagger
        -- display_id, from 6469 to 6468
        -- required_level, from 8 to 13
        -- dmg_min1, from 16.0 to 8
        -- dmg_max1, from 24.0 to 15
        UPDATE `item_template` SET `name` = `Hook Dagger`, `display_id` = 6468, `required_level` = 13, `dmg_min1` = 8, `dmg_max1` = 15 WHERE (`entry` = 3184);
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
        UPDATE `item_template` SET `name` = `Blackrock Pauldrons`, `required_level` = 18 WHERE (`entry` = 1445);
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
        UPDATE `item_template` SET `name` = `Blackrock Gauntlets`, `required_level` = 15, `stat_value1` = 1 WHERE (`entry` = 1448);
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
        UPDATE `item_template` SET `description` = `"Princess - First Prize"` WHERE (`entry` = 1006);
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
        UPDATE `item_template` SET `name` = `Chainmail Armor`, `required_level` = 12 WHERE (`entry` = 847);
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
        UPDATE `item_template` SET `name` = `Opaque Wand`, `required_level` = 14, `dmg_min1` = 13, `dmg_max1` = 24, `delay` = 1400 WHERE (`entry` = 5207);
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
        UPDATE `item_template` SET `name` = `Forest Leather Chestpiece`, `display_id` = 9056, `required_level` = 20, `stat_value1` = 1, `stat_value2` = 2 WHERE (`entry` = 3055);
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
        UPDATE `item_template` SET `name` = `Studded Hat`, `required_level` = 32, `stat_value1` = 4 WHERE (`entry` = 3890);
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
        UPDATE `item_template` SET `name` = `Magister''s Belt`, `required_level` = 10, `stat_value1` = 4 WHERE (`entry` = 4684);
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
        UPDATE `item_template` SET `name` = `Rawhide Shoulderpads`, `required_level` = 20 WHERE (`entry` = 1801);
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
        UPDATE `item_template` SET `name` = `Azure Silk Vest`, `buy_price` = 9373, `sell_price` = 1874, `inventory_type` = 5, `required_level` = 25, `stat_type1` = 6, `stat_value1` = 5 WHERE (`entry` = 4324);
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
        UPDATE `item_template` SET `name` = `Feet of the Lynx`, `stat_value1` = 3 WHERE (`entry` = 1121);
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
        UPDATE `item_template` SET `name` = `Insignia Cap`, `required_level` = 31, `stat_value1` = 2, `stat_value3` = 10 WHERE (`entry` = 4052);
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
        UPDATE `item_template` SET `name` = `Padded Gloves`, `required_level` = 22 WHERE (`entry` = 2158);
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
        UPDATE `item_template` SET `name` = `Tattered Cloth Boots` WHERE (`entry` = 195);
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
        UPDATE `item_template` SET `name` = `Small Knife`, `dmg_min1` = 2, `dmg_max1` = 4 WHERE (`entry` = 2484);
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
        UPDATE `item_template` SET `name` = `Ancestral Belt`, `buy_price` = 183, `sell_price` = 36, `item_level` = 11, `required_level` = 6 WHERE (`entry` = 4672);
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
        UPDATE `item_template` SET `name` = `Willow Belt`, `quality` = 1, `buy_price` = 560, `sell_price` = 112, `required_level` = 12 WHERE (`entry` = 6539);
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
        UPDATE `item_template` SET `description` = `Emits a strange green glow...` WHERE (`entry` = 8049);
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
end $
delimiter ;
