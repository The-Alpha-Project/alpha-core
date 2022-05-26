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

    -- 26/05/2022 1 - Item updates, mostly display_id and spell1.
    if (select count(*) from applied_updates where id='260520221') = 0 then
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


        insert into applied_updates values ('260520221');
    end if;
end $
delimiter ;
