-- There's no confirmed way to obtain all items required to summon shaman totems. This update adds a repeatable quest to
-- all shaman trainers so shaman players can obtain them.


-- Earth Totem
DELETE FROM `quest_template` WHERE `entry`=10001;
INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('10001', '0', '82', '4', '0', '4', '0', '64', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1024', '1', '0', '0', '0', '0', '0', '0', '0', 'Earth Totem', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5175', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
UPDATE `quest_template` SET `RequiredCondition` = '1678804' WHERE (`entry` = '10001');

-- Fire Totem
DELETE FROM `quest_template` WHERE `entry`=10002;
INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('10002', '0', '82', '14', '0', '14', '0', '64', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1024', '1', '0', '0', '0', '0', '0', '0', '0', 'Fire Totem', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5176', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
UPDATE `quest_template` SET `RequiredCondition` = '1678805' WHERE (`entry` = '10002');

-- Water Totem
DELETE FROM `quest_template` WHERE `entry`=10003;
INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('10003', '0', '82', '28', '0', '28', '0', '64', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1024', '1', '0', '0', '0', '0', '0', '0', '0', 'Water Totem', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5177', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
UPDATE `quest_template` SET `RequiredCondition` = '1678806' WHERE (`entry` = '10003');

-- Air Totem
DELETE FROM `quest_template` WHERE `entry`=10004;
INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('10004', '0', '82', '30', '0', '30', '0', '64', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1024', '1', '0', '0', '0', '0', '0', '0', '0', 'Air Totem', '', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5178', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
UPDATE `quest_template` SET `RequiredCondition` = '1678807' WHERE (`entry` = '10004');


-- Beram Skychaser
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3032', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3032', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3032', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3032', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3032', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3032', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3032', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3032', '10004');

-- Ghok
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('1406', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('1406', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('1406', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('1406', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('1406', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('1406', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('1406', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('1406', '10004');

-- Grelkor
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3343', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3343', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3343', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3343', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3343', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3343', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3343', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3343', '10004');

-- Haromm
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('986', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('986', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('986', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('986', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('986', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('986', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('986', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('986', '10004');

-- Kardris Dreamseeker
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3344', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3344', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3344', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3344', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3344', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3344', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3344', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3344', '10004');

-- Meela Dawnstrider
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3062', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3062', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3062', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3062', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3062', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3062', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3062', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3062', '10004');

-- Murak Winterborn
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('373', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('373', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('373', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('373', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('373', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('373', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('373', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('373', '10004');

-- Narm Skychaser
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3066', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3066', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3066', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3066', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3066', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3066', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3066', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3066', '10004');

-- 	Shikrik
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3157', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3157', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3157', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3157', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3157', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3157', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3157', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3157', '10004');

-- Sian'tsu
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3403', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3403', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3403', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3403', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3403', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3403', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3403', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3403', '10004');

-- Siln Skychaser
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3030', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3030', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3030', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3030', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3030', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3030', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3030', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3030', '10004');

-- 	Swart
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3173', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3173', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3173', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3173', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3173', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3173', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3173', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3173', '10004');

-- Tigor Skychaser
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3031', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3031', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3031', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3031', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3031', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3031', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3031', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3031', '10004');

-- Undead Shaman Trainer
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('2219', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('2219', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('2219', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('2219', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('2219', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('2219', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('2219', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('2219', '10004');

-- World Shaman Trainer
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('4991', '10001');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('4991', '10002');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('4991', '10003');
INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('4991', '10004');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('4991', '10001');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('4991', '10002');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('4991', '10003');
INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('4991', '10004');
