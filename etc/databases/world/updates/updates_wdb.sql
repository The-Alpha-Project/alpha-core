-- 3925

-- Acolyte's Shoes
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 59);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (59, 3925);
-- Tainted Scroll
-- page_text, from 2452 to 0
-- page_material, from 1 to 0
-- start_quest, from 0 to 3099
UPDATE `item_template` SET `page_text` = 0, `page_material` = 0, `start_quest` = 3099 WHERE (`entry` = 9578);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9578, 3925);
-- Recruit's Boots
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 6122);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6122, 3925);
-- Simple Sigil
-- page_text, from 2444 to 0
-- page_material, from 1 to 0
-- start_quest, from 0 to 3116
UPDATE `item_template` SET `page_text` = 0, `page_material` = 0, `start_quest` = 3116 WHERE (`entry` = 9545);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9545, 3925);
-- Woodland Robes
-- required_level, from 0 to 1
-- armor, from 10 to 15
UPDATE `item_template` SET `required_level` = 1, `armor` = 15 WHERE (`entry` = 11189);
UPDATE `applied_item_updates` SET `entry` = 11189, `version` = 3925 WHERE (`entry` = 11189);
-- Stemleaf Bracers
-- armor, from 4 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 11187);
UPDATE `applied_item_updates` SET `entry` = 11187, `version` = 3925 WHERE (`entry` = 11187);
-- Viny Gloves
-- armor, from 6 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 11190);
UPDATE `applied_item_updates` SET `entry` = 11190, `version` = 3925 WHERE (`entry` = 11190);
-- Neophyte's Boots
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 51);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (51, 3925);
-- Woodland Tunic
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 4907);
UPDATE `applied_item_updates` SET `entry` = 4907, `version` = 3925 WHERE (`entry` = 4907);
-- Footpad's Shoes
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 47);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (47, 3925);
-- Woodland Shield
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 5395);
UPDATE `applied_item_updates` SET `entry` = 5395, `version` = 3925 WHERE (`entry` = 5395);
-- Thistlewood Bow
-- required_level, from 0 to 1
UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 12447);
UPDATE `applied_item_updates` SET `entry` = 12447, `version` = 3925 WHERE (`entry` = 12447);
-- Barkmail Vest
-- armor, from 67 to 47
UPDATE `item_template` SET `armor` = 47 WHERE (`entry` = 10656);
UPDATE `applied_item_updates` SET `entry` = 10656, `version` = 3925 WHERE (`entry` = 10656);
-- Healing Herb
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 961);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (961, 3925);
-- Cadet's Bow
-- required_level, from 1 to 2
UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 8179);
UPDATE `applied_item_updates` SET `entry` = 8179, `version` = 3925 WHERE (`entry` = 8179);
-- Snapped Spider Limb
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 1476);
UPDATE `applied_item_updates` SET `entry` = 1476, `version` = 3925 WHERE (`entry` = 1476);
-- Dolanaar Delivery
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 7627);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7627, 3925);
-- Severed Voodoo Claw
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 5457);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5457, 3925);
-- Rare Earth
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 5391);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5391, 3925);
-- Recipe: Kaldorei Spider Kabob
-- subclass, from 5 to 0
UPDATE `item_template` SET `subclass` = 0 WHERE (`entry` = 5482);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5482, 3925);
-- Linen Bandage
-- flags, from 0 to 64
-- required_skill, from 0 to 129
-- required_skill_rank, from 0 to 1
UPDATE `item_template` SET `flags` = 64, `required_skill` = 129, `required_skill_rank` = 1 WHERE (`entry` = 1251);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1251, 3925);
-- Barkmail Leggings
-- armor, from 94 to 85
UPDATE `item_template` SET `armor` = 85 WHERE (`entry` = 9599);
UPDATE `applied_item_updates` SET `entry` = 9599, `version` = 3925 WHERE (`entry` = 9599);
-- Cushioned Boots
-- armor, from 40 to 47
UPDATE `item_template` SET `armor` = 47 WHERE (`entry` = 9601);
UPDATE `applied_item_updates` SET `entry` = 9601, `version` = 3925 WHERE (`entry` = 9601);
-- Tallonkai's Jewel
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 8050);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (8050, 3925);
-- Raider's Cloak
-- armor, from 15 to 23
UPDATE `item_template` SET `armor` = 23 WHERE (`entry` = 9786);
UPDATE `applied_item_updates` SET `entry` = 9786, `version` = 3925 WHERE (`entry` = 9786);
-- Brushwood Blade
-- flags, from 16 to 0
UPDATE `item_template` SET `flags` = 0 WHERE (`entry` = 9602);
UPDATE `applied_item_updates` SET `entry` = 9602, `version` = 3925 WHERE (`entry` = 9602);
-- Ring of the Moon
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 12052);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (12052, 3925);
-- Decapitating Sword
-- required_level, from 14 to 19
-- stat_type1, from 0 to 3
-- stat_value1, from 0 to 2
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `required_level` = 19, `stat_type1` = 3, `stat_value1` = 2, `stat_type2` = 4, `stat_value2` = 2 WHERE (`entry` = 3740);
UPDATE `applied_item_updates` SET `entry` = 3740, `version` = 3925 WHERE (`entry` = 3740);
-- Blood Shard
-- buy_price, from 0 to 100
-- sell_price, from 0 to 25
UPDATE `item_template` SET `buy_price` = 100, `sell_price` = 25 WHERE (`entry` = 5075);
UPDATE `applied_item_updates` SET `entry` = 5075, `version` = 3925 WHERE (`entry` = 5075);
-- Heavy Linen Bandage
-- flags, from 0 to 64
UPDATE `item_template` SET `flags` = 64 WHERE (`entry` = 2581);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2581, 3925);
-- Wool Bandage
-- required_skill_rank, from 30 to 50
UPDATE `item_template` SET `required_skill_rank` = 50 WHERE (`entry` = 3530);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3530, 3925);
-- Recipe: Discolored Healing Potion
-- subclass, from 6 to 0
UPDATE `item_template` SET `subclass` = 0 WHERE (`entry` = 4597);
UPDATE `applied_item_updates` SET `entry` = 4597, `version` = 3925 WHERE (`entry` = 4597);
-- Settler's Leggings
-- armor, from 139 to 142
UPDATE `item_template` SET `armor` = 142 WHERE (`entry` = 2694);
UPDATE `applied_item_updates` SET `entry` = 2694, `version` = 3925 WHERE (`entry` = 2694);
-- Fire Wand
-- required_skill, from 8 to 0
-- required_skill_rank, from 1 to 0
UPDATE `item_template` SET `required_skill` = 0, `required_skill_rank` = 0 WHERE (`entry` = 5069);
UPDATE `applied_item_updates` SET `entry` = 5069, `version` = 3925 WHERE (`entry` = 5069);
-- Evergreen Gloves
-- required_level, from 13 to 0
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `required_level` = 0, `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 7738);
UPDATE `applied_item_updates` SET `entry` = 7738, `version` = 3925 WHERE (`entry` = 7738);
-- Elven Wand
-- flags, from 0 to 256
UPDATE `item_template` SET `flags` = 256 WHERE (`entry` = 5604);
UPDATE `applied_item_updates` SET `entry` = 5604, `version` = 3925 WHERE (`entry` = 5604);
-- Explorer's Vest
-- required_level, from 8 to 0
-- stat_type2, from 0 to 5
UPDATE `item_template` SET `required_level` = 0, `stat_type2` = 5 WHERE (`entry` = 7229);
UPDATE `applied_item_updates` SET `entry` = 7229, `version` = 3925 WHERE (`entry` = 7229);
-- Lead Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 11981);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (11981, 3925);
-- Quartz Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 11965);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (11965, 3925);
-- War Knife
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 2
UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 4571);
UPDATE `applied_item_updates` SET `entry` = 4571, `version` = 3925 WHERE (`entry` = 4571);
-- Small Leather Ammo Pouch
-- required_level, from 0 to 1
UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 7279);
UPDATE `applied_item_updates` SET `entry` = 7279, `version` = 3925 WHERE (`entry` = 7279);
-- Light Leather Quiver
-- required_level, from 0 to 1
UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 7278);
UPDATE `applied_item_updates` SET `entry` = 7278, `version` = 3925 WHERE (`entry` = 7278);
-- Farmer's Boots
-- required_level, from 0 to 5
UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 11191);
UPDATE `applied_item_updates` SET `entry` = 11191, `version` = 3925 WHERE (`entry` = 11191);
-- Tender Crocolisk Meat
-- name, from Tender Crocilisk Meat to Tender Crocolisk Meat
UPDATE `item_template` SET `name` = 'Tender Crocolisk Meat' WHERE (`entry` = 3667);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3667, 3925);
-- Wolf Handler Gloves
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 6171);
UPDATE `applied_item_updates` SET `entry` = 6171, `version` = 3925 WHERE (`entry` = 6171);
-- Cadet Shield
-- stat_type1, from 0 to 4
-- stat_value1, from 0 to 2
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 2 WHERE (`entry` = 9764);
UPDATE `applied_item_updates` SET `entry` = 9764, `version` = 3925 WHERE (`entry` = 9764);
-- Prelacy Cape
-- required_level, from 22 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 7004);
UPDATE `applied_item_updates` SET `entry` = 7004, `version` = 3925 WHERE (`entry` = 7004);
-- Elunite Dagger
-- required_level, from 10 to 0
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `required_level` = 0, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 6969);
UPDATE `applied_item_updates` SET `entry` = 6969, `version` = 3925 WHERE (`entry` = 6969);
-- Light Leather Pants
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 3 WHERE (`entry` = 7282);
UPDATE `applied_item_updates` SET `entry` = 7282, `version` = 3925 WHERE (`entry` = 7282);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4344, 3925);
-- Sharp Kitchen Knife
-- required_level, from 8 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 2225);
UPDATE `applied_item_updates` SET `entry` = 2225, `version` = 3925 WHERE (`entry` = 2225);
-- Volcanic Rock Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 12053);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (12053, 3925);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3342, 3925);
-- Beetle Clasps
-- required_level, from 22 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 7003);
UPDATE `applied_item_updates` SET `entry` = 7003, `version` = 3925 WHERE (`entry` = 7003);
-- Fire Hardened Coif
-- required_level, from 26 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 6971);
UPDATE `applied_item_updates` SET `entry` = 6971, `version` = 3925 WHERE (`entry` = 6971);
-- Fire Hardened Hauberk
-- required_level, from 20 to 0
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `required_level` = 0, `stat_type2` = 4, `stat_value2` = 5 WHERE (`entry` = 6972);
UPDATE `applied_item_updates` SET `entry` = 6972, `version` = 3925 WHERE (`entry` = 6972);
-- Viridian Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 11982);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (11982, 3925);
-- Woodsman Sword
-- required_level, from 10 to 0
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 5
-- stat_type2, from 0 to 3
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `required_level` = 0, `stat_type1` = 7, `stat_value1` = 5, `stat_type2` = 3, `stat_value2` = 2 WHERE (`entry` = 5615);
UPDATE `applied_item_updates` SET `entry` = 5615, `version` = 3925 WHERE (`entry` = 5615);
-- Daryl's Hunting Bow
-- required_level, from 10 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 2903);
UPDATE `applied_item_updates` SET `entry` = 2903, `version` = 3925 WHERE (`entry` = 2903);
-- 3596

-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3596 WHERE (`entry` = 4496);
-- Fractured Canine
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3299);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3299, 3596);
-- Azure Silk Pants
-- frost_res, from 0 to 1
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7046);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7046, 3596);
-- Cerulean Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7426);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7426, 3596);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
UPDATE `applied_item_updates` SET `entry` = 3342, `version` = 3596 WHERE (`entry` = 3342);
-- Cracked Leather Belt
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2122);
UPDATE `applied_item_updates` SET `entry` = 2122, `version` = 3596 WHERE (`entry` = 2122);
-- Berserker Helm
-- fire_res, from 0 to 1
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7719);
UPDATE `applied_item_updates` SET `entry` = 7719, `version` = 3596 WHERE (`entry` = 7719);
-- Explorers' League Commendation
-- nature_res, from 0 to 2
-- spellid_1, from 0 to 5102
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `nature_res` = 2, `spellid_1` = 5102, `spelltrigger_1` = 1 WHERE (`entry` = 7746);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7746, 3596);
-- Divine Gauntlets
-- spellid_1, from 15807 to 9408
UPDATE `item_template` SET `spellid_1` = 9408 WHERE (`entry` = 7724);
UPDATE `applied_item_updates` SET `entry` = 7724, `version` = 3596 WHERE (`entry` = 7724);
-- Sword of Serenity
-- spellid_1, from 0 to 370
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `spellid_1` = 370, `spelltrigger_1` = 2 WHERE (`entry` = 6829);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6829, 3596);
-- Twilight Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7432);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7432, 3596);
-- Elder's Sash
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7370);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7370, 3596);
-- Welken Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5011);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5011, 3596);
-- Orb of the Forgotten Seer
-- spellid_1, from 9417 to 0
-- spelltrigger_1, from 1 to 0
-- sheath, from 7 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0, `sheath` = 0 WHERE (`entry` = 7685);
UPDATE `applied_item_updates` SET `entry` = 7685, `version` = 3596 WHERE (`entry` = 7685);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3596 WHERE (`entry` = 3363);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3596 WHERE (`entry` = 1377);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3596 WHERE (`entry` = 4344);
-- Sustaining Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6743);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6743, 3596);
-- Rod of the Sleepwalker
-- frost_res, from 0 to 2
UPDATE `item_template` SET `frost_res` = 2 WHERE (`entry` = 1155);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1155, 3596);
-- Gravestone Sceptre
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 7001);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7001, 3596);
-- Bishop's Miter
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7720);
UPDATE `applied_item_updates` SET `entry` = 7720, `version` = 3596 WHERE (`entry` = 7720);
-- Regal Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7469);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7469, 3596);
-- Regal Cuffs
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7475);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7475, 3596);
-- Ivory Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7497);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7497, 3596);
-- Mechanical Dragonling
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 4396);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4396, 3596);
-- Cold Basilisk Eye
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 5079);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5079, 3596);
-- Brightweave Pants
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4044);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4044, 3596);
-- Pioneer Buckler
-- subclass, from 6 to 5
-- buy_price, from 984 to 639
-- sell_price, from 196 to 127
-- item_level, from 13 to 12
-- required_level, from 8 to 7
-- armor, from 176 to 28
UPDATE `item_template` SET `subclass` = 5, `buy_price` = 639, `sell_price` = 127, `item_level` = 12, `required_level` = 7, `armor` = 28 WHERE (`entry` = 7109);
UPDATE `applied_item_updates` SET `entry` = 7109, `version` = 3596 WHERE (`entry` = 7109);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3596 WHERE (`entry` = 1366);
-- Vermilion Necklace
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7467);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7467, 3596);
-- Twilight Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7436);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7436, 3596);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3596 WHERE (`entry` = 3600);
-- Light Leather Pants
-- buy_price, from 2998 to 2950
-- sell_price, from 599 to 590
-- stat_value1, from 5 to 1
-- armor, from 95 to 31
UPDATE `item_template` SET `buy_price` = 2950, `sell_price` = 590, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 7282);
UPDATE `applied_item_updates` SET `entry` = 7282, `version` = 3596 WHERE (`entry` = 7282);
-- Mud Stompers
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3596 WHERE (`entry` = 6188);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3596 WHERE (`entry` = 2119);
-- Phalanx Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7423);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7423, 3596);
-- Cerulean Talisman
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7427);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7427, 3596);
-- Shadow Claw
-- spellid_1, from 16409 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2912);
UPDATE `applied_item_updates` SET `entry` = 2912, `version` = 3596 WHERE (`entry` = 2912);
-- Polished Scale Vest
-- stat_type1, from 0 to 4
-- stat_value1, from 0 to 1
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3596 WHERE (`entry` = 2153);
-- Chieftain Girdle
-- stat_value2, from 15 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5750);
UPDATE `applied_item_updates` SET `entry` = 5750, `version` = 3596 WHERE (`entry` = 5750);
-- Scorpion Sting
-- spellid_1, from 18208 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1265);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1265, 3596);
-- Kite Shield
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2446);
UPDATE `applied_item_updates` SET `entry` = 2446, `version` = 3596 WHERE (`entry` = 2446);
-- Rose Mantle
-- stat_value2, from 5 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5274);
UPDATE `applied_item_updates` SET `entry` = 5274, `version` = 3596 WHERE (`entry` = 5274);
-- Flameweave Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3596 WHERE (`entry` = 6608);
-- Wandering Boots
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3596 WHERE (`entry` = 6095);
-- Gold-flecked Gloves
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3596 WHERE (`entry` = 5195);
-- Silver Steel Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6966);
UPDATE `applied_item_updates` SET `entry` = 6966, `version` = 3596 WHERE (`entry` = 6966);
-- Disciple's Bracers
-- display_id, from 16566 to 14705
-- buy_price, from 148 to 240
-- sell_price, from 29 to 48
-- item_level, from 10 to 12
-- required_level, from 5 to 7
-- armor, from 13 to 6
UPDATE `item_template` SET `display_id` = 14705, `buy_price` = 240, `sell_price` = 48, `item_level` = 12, `required_level` = 7, `armor` = 6 WHERE (`entry` = 7350);
UPDATE `applied_item_updates` SET `entry` = 7350, `version` = 3596 WHERE (`entry` = 7350);
-- Grayson's Torch
-- armor, from 0 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3596 WHERE (`entry` = 1172);
-- Explorer's Vest
-- stat_type1, from 7 to 1
-- stat_value1, from 2 to 5
-- armor, from 125 to 44
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `armor` = 44 WHERE (`entry` = 7229);
UPDATE `applied_item_updates` SET `entry` = 7229, `version` = 3596 WHERE (`entry` = 7229);
-- Haggard's Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3596 WHERE (`entry` = 6979);
-- Thick Cloth Pants
-- stat_type1, from 0 to 1
-- stat_value1, from 0 to 8
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 8 WHERE (`entry` = 201);
UPDATE `applied_item_updates` SET `entry` = 201, `version` = 3596 WHERE (`entry` = 201);
-- Handstitched Leather Bracers
-- armor, from 18 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 7277);
UPDATE `applied_item_updates` SET `entry` = 7277, `version` = 3596 WHERE (`entry` = 7277);
-- Regal Wizard Hat
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7470);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7470, 3596);
-- Regal Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7468);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7468, 3596);
-- Green Carapace Shield
-- nature_res, from 4 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 2021);
UPDATE `applied_item_updates` SET `entry` = 2021, `version` = 3596 WHERE (`entry` = 2021);
-- Neophyte's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 52);
UPDATE `applied_item_updates` SET `entry` = 52, `version` = 3596 WHERE (`entry` = 52);
-- Glorious Shoulders
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3596 WHERE (`entry` = 4833);
-- Polar Gauntlets
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7606);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7606, 3596);
-- Dark Leather Tunic
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3596 WHERE (`entry` = 2317);
-- Phalanx Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7419);
UPDATE `applied_item_updates` SET `entry` = 7419, `version` = 3596 WHERE (`entry` = 7419);
-- Frayed Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1378);
UPDATE `applied_item_updates` SET `entry` = 1378, `version` = 3596 WHERE (`entry` = 1378);
-- Rabbit's Foot
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3300);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3300, 3596);
-- Bottle of Pinot Noir (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2723);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2723, 3596);
-- Flask of Port (needs effect)
-- spellid_1, from 11008 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2593);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2593, 3596);
-- Skin of Dwarven Stout (needs effect)
-- spellid_1, from 11008 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2596);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2596, 3596);
-- Flagon of Mead (needs effect)
-- spellid_1, from 1133 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2594);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2594, 3596);
-- Jug of Bourbon (needs effect)
-- spellid_1, from 1133 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2595);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2595, 3596);
-- Glimmering Mail Pauldrons
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 6388);
UPDATE `applied_item_updates` SET `entry` = 6388, `version` = 3596 WHERE (`entry` = 6388);
-- Phalanx Breastplate
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7418);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7418, 3596);
-- Cobalt Crusher
-- dmg_min2, from 5.0 to 0
-- dmg_max2, from 5.0 to 0
-- dmg_type2, from 4 to 0
-- spellid_1, from 18204 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7730);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7730, 3596);
-- Fine Leather Gloves
-- stat_value1, from 0 to 5
UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 2312);
UPDATE `applied_item_updates` SET `entry` = 2312, `version` = 3596 WHERE (`entry` = 2312);
-- Black Whelp Cloak
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 7283);
UPDATE `applied_item_updates` SET `entry` = 7283, `version` = 3596 WHERE (`entry` = 7283);
-- Scorching Sash
-- spellid_1, from 9400 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4117);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4117, 3596);
-- Brightweave Bracers
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4043);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4043, 3596);
-- Sage's Pants
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6616);
UPDATE `applied_item_updates` SET `entry` = 6616, `version` = 3596 WHERE (`entry` = 6616);
-- Fire Hardened Leggings
-- max_count, from 1 to 0
-- stat_value3, from 40 to 0
UPDATE `item_template` SET `max_count` = 0, `stat_value3` = 0 WHERE (`entry` = 6973);
UPDATE `applied_item_updates` SET `entry` = 6973, `version` = 3596 WHERE (`entry` = 6973);
-- Forest Chain
-- stat_value2, from 10 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3596 WHERE (`entry` = 1273);
-- Stalvan's Reaper
-- spellid_1, from 13524 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 934);
UPDATE `applied_item_updates` SET `entry` = 934, `version` = 3596 WHERE (`entry` = 934);
-- Leech Pants
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 6910);
UPDATE `applied_item_updates` SET `entry` = 6910, `version` = 3596 WHERE (`entry` = 6910);
-- Blackfang
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 2236);
UPDATE `applied_item_updates` SET `entry` = 2236, `version` = 3596 WHERE (`entry` = 2236);
-- Willow Branch
-- item_level, from 19 to 16
-- required_level, from 14 to 11
UPDATE `item_template` SET `item_level` = 16, `required_level` = 11 WHERE (`entry` = 7554);
UPDATE `applied_item_updates` SET `entry` = 7554, `version` = 3596 WHERE (`entry` = 7554);
-- Chief Brigadier Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4078);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4078, 3596);
-- Heart Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5001);
UPDATE `applied_item_updates` SET `entry` = 5001, `version` = 3596 WHERE (`entry` = 5001);
-- Elder's Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7355);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7355, 3596);
-- Ogremind Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 1993);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1993, 3596);
-- Belt of Arugal
-- stat_type1, from 6 to 0
-- stat_value2, from 35 to 0
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `stat_type1` = 0, `stat_value2` = 0, `shadow_res` = 4 WHERE (`entry` = 6392);
UPDATE `applied_item_updates` SET `entry` = 6392, `version` = 3596 WHERE (`entry` = 6392);
-- Darkweave Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3596 WHERE (`entry` = 4039);
-- Regal Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7332);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7332, 3596);
-- Tempered Bracers
-- stat_type2, from 7 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 6675);
UPDATE `applied_item_updates` SET `entry` = 6675, `version` = 3596 WHERE (`entry` = 6675);
-- Black Menace
-- spellid_1, from 13440 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6831);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6831, 3596);
-- Gauntlets of Ogre Strength
-- spellid_1, from 9329 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3341);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3341, 3596);
-- Thornstone Sledgehammer
-- nature_res, from 10 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 1722);
UPDATE `applied_item_updates` SET `entry` = 1722, `version` = 3596 WHERE (`entry` = 1722);
-- Holy Shroud
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3596 WHERE (`entry` = 2721);
-- Forest Tracker Epaulets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3596 WHERE (`entry` = 2278);
-- Shadow Weaver Leggings
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3596 WHERE (`entry` = 2233);
-- Twilight Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7430);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7430, 3596);
-- Silvered Bronze Breastplate
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3596 WHERE (`entry` = 2869);
-- Darkshire Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3596 WHERE (`entry` = 2906);
-- Captain's Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7488);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7488, 3596);
-- Goblin Nutcracker
-- spellid_1, from 13496 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4090);
UPDATE `applied_item_updates` SET `entry` = 4090, `version` = 3596 WHERE (`entry` = 4090);
-- Aegis of the Scarlet Commander
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 7726);
UPDATE `applied_item_updates` SET `entry` = 7726, `version` = 3596 WHERE (`entry` = 7726);
-- Vermilion Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7466);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7466, 3596);
-- Band of Thorns
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5007);
UPDATE `applied_item_updates` SET `entry` = 5007, `version` = 3596 WHERE (`entry` = 5007);
-- Ironforge Memorial Ring
-- max_count, from 1 to 0
-- spellid_1, from 0 to 4314
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `spellid_1` = 4314, `spelltrigger_1` = 1 WHERE (`entry` = 4535);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4535, 3596);
-- Sentinel Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 7443);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7443, 3596);
-- Brightweave Cowl
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 2
-- holy_res, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 2, `holy_res` = 1 WHERE (`entry` = 4041);
UPDATE `applied_item_updates` SET `entry` = 4041, `version` = 3596 WHERE (`entry` = 4041);
-- Regal Cloak
-- frost_res, from 0 to 6
UPDATE `item_template` SET `frost_res` = 6 WHERE (`entry` = 7474);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7474, 3596);
-- Cuirboulli Belt
-- stat_type1, from 0 to 1
-- stat_value1, from 0 to 5
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 2142);
UPDATE `applied_item_updates` SET `entry` = 2142, `version` = 3596 WHERE (`entry` = 2142);
-- Blazing Emblem
-- fire_res, from 15 to 0
UPDATE `item_template` SET `fire_res` = 0 WHERE (`entry` = 2802);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2802, 3596);
-- Buzzer Blade
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 2169);
UPDATE `applied_item_updates` SET `entry` = 2169, `version` = 3596 WHERE (`entry` = 2169);
-- Embalmed Shroud
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7691);
UPDATE `applied_item_updates` SET `entry` = 7691, `version` = 3596 WHERE (`entry` = 7691);
-- Blighted Leggings
-- holy_res, from 0 to 1
-- spellid_1, from 7709 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7709);
UPDATE `applied_item_updates` SET `entry` = 7709, `version` = 3596 WHERE (`entry` = 7709);
-- Sunblaze Coif
-- fire_res, from 48 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 5819);
UPDATE `applied_item_updates` SET `entry` = 5819, `version` = 3596 WHERE (`entry` = 5819);
-- Resplendent Guardian
-- spellid_1, from 13674 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7787);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7787, 3596);
-- Wolfpack Medallion
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3596 WHERE (`entry` = 5754);
-- Darkweave Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4038);
UPDATE `applied_item_updates` SET `entry` = 4038, `version` = 3596 WHERE (`entry` = 4038);
-- Darkweave Mantle
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3596 WHERE (`entry` = 4718);
-- Light Leather Bracers
-- armor, from 34 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 7281);
UPDATE `applied_item_updates` SET `entry` = 7281, `version` = 3596 WHERE (`entry` = 7281);
-- Aurora Buckler
-- frost_res, from 5 to 0
UPDATE `item_template` SET `frost_res` = 0 WHERE (`entry` = 7002);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7002, 3596);
-- Rock Pulverizer
-- spellid_1, from 15806 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4983);
UPDATE `applied_item_updates` SET `entry` = 4983, `version` = 3596 WHERE (`entry` = 4983);
-- Journeyman Quarterstaff
-- dmg_min1, from 28.0 to 18
-- dmg_max1, from 39.0 to 27
UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 854);
UPDATE `applied_item_updates` SET `entry` = 854, `version` = 3596 WHERE (`entry` = 854);
-- Artisan's Trousers
-- stat_value2, from 3 to 0
-- stat_value3, from 48 to 0
UPDATE `item_template` SET `stat_value2` = 0, `stat_value3` = 0 WHERE (`entry` = 5016);
UPDATE `applied_item_updates` SET `entry` = 5016, `version` = 3596 WHERE (`entry` = 5016);
-- Thick Cloth Vest
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 200);
UPDATE `applied_item_updates` SET `entry` = 200, `version` = 3596 WHERE (`entry` = 200);
-- Elder's Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7356);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7356, 3596);
-- Black Duskwood Staff
-- spellid_1, from 18138 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 937);
UPDATE `applied_item_updates` SET `entry` = 937, `version` = 3596 WHERE (`entry` = 937);
-- Brightweave Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6415);
UPDATE `applied_item_updates` SET `entry` = 6415, `version` = 3596 WHERE (`entry` = 6415);
-- Scarab Trousers
-- stat_value3, from 1 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3596 WHERE (`entry` = 6659);
-- Frostweave Robe
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4035);
UPDATE `applied_item_updates` SET `entry` = 4035, `version` = 3596 WHERE (`entry` = 4035);
-- Evergreen Gloves
-- display_id, from 16815 to 15865
-- stat_value1, from 3 to 1
-- armor, from 32 to 10
UPDATE `item_template` SET `display_id` = 15865, `stat_value1` = 1, `armor` = 10 WHERE (`entry` = 7738);
UPDATE `applied_item_updates` SET `entry` = 7738, `version` = 3596 WHERE (`entry` = 7738);
-- Lesser Staff of the Spire
-- stat_value2, from 3 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1300);
UPDATE `applied_item_updates` SET `entry` = 1300, `version` = 3596 WHERE (`entry` = 1300);
-- Coal
-- buy_price, from 500 to 1500
-- sell_price, from 125 to 375
UPDATE `item_template` SET `buy_price` = 1500, `sell_price` = 375 WHERE (`entry` = 3857);
UPDATE `applied_item_updates` SET `entry` = 3857, `version` = 3596 WHERE (`entry` = 3857);
-- Flesh Piercer
-- spellid_1, from 18078 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3336);
UPDATE `applied_item_updates` SET `entry` = 3336, `version` = 3596 WHERE (`entry` = 3336);
-- Frostweave Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4713);
UPDATE `applied_item_updates` SET `entry` = 4713, `version` = 3596 WHERE (`entry` = 4713);
-- Fire Hardened Hauberk
-- display_id, from 22480 to 13011
-- stat_value1, from 14 to 5
-- armor, from 226 to 71
UPDATE `item_template` SET `display_id` = 13011, `stat_value1` = 5, `armor` = 71 WHERE (`entry` = 6972);
UPDATE `applied_item_updates` SET `entry` = 6972, `version` = 3596 WHERE (`entry` = 6972);
-- Beetle Clasps
-- stat_type1, from 7 to 4
-- stat_value1, from 5 to 1
-- stat_type2, from 3 to 1
-- stat_value2, from 2 to 5
-- armor, from 95 to 32
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5, `armor` = 32 WHERE (`entry` = 7003);
UPDATE `applied_item_updates` SET `entry` = 7003, `version` = 3596 WHERE (`entry` = 7003);
-- Torturing Poker
-- dmg_min2, from 5.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 2 to 0
-- spellid_1, from 0 to 7711
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 7711, `spelltrigger_1` = 1 WHERE (`entry` = 7682);
UPDATE `applied_item_updates` SET `entry` = 7682, `version` = 3596 WHERE (`entry` = 7682);
-- Seal of Wrynn
-- max_count, from 1 to 0
-- fire_res, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `fire_res` = 1 WHERE (`entry` = 2933);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2933, 3596);
-- Murloc Scale Breastplate
-- stat_value3, from 25 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 5781);
UPDATE `applied_item_updates` SET `entry` = 5781, `version` = 3596 WHERE (`entry` = 5781);
-- Wyvern Tailspike
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5752);
UPDATE `applied_item_updates` SET `entry` = 5752, `version` = 3596 WHERE (`entry` = 5752);
-- Darkweave Sash
-- stat_value3, from 0 to 5
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value3` = 5, `shadow_res` = 1 WHERE (`entry` = 4720);
UPDATE `applied_item_updates` SET `entry` = 4720, `version` = 3596 WHERE (`entry` = 4720);
-- Polished Scale Leggings
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
-- stat_value2, from 0 to 10
UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2152);
UPDATE `applied_item_updates` SET `entry` = 2152, `version` = 3596 WHERE (`entry` = 2152);
-- Polished Scale Boots
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3596 WHERE (`entry` = 2149);
-- Polished Scale Gloves
-- stat_type1, from 0 to 3
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3596 WHERE (`entry` = 2151);
-- Reinforced Targe
-- stat_value1, from 0 to 10
UPDATE `item_template` SET `stat_value1` = 10 WHERE (`entry` = 2442);
UPDATE `applied_item_updates` SET `entry` = 2442, `version` = 3596 WHERE (`entry` = 2442);
-- Mail Combat Gauntlets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 1 WHERE (`entry` = 4075);
UPDATE `applied_item_updates` SET `entry` = 4075, `version` = 3596 WHERE (`entry` = 4075);
-- Ogremage Staff
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 4
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 4 WHERE (`entry` = 2226);
UPDATE `applied_item_updates` SET `entry` = 2226, `version` = 3596 WHERE (`entry` = 2226);
-- Astral Knot Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7511);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7511, 3596);
-- Howling Blade
-- spellid_1, from 13490 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6331);
UPDATE `applied_item_updates` SET `entry` = 6331, `version` = 3596 WHERE (`entry` = 6331);
-- Captain's Breastplate
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7486);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7486, 3596);
-- Flash Rifle
-- stat_value1, from 2 to 0
UPDATE `item_template` SET `stat_value1` = 0 WHERE (`entry` = 4086);
UPDATE `applied_item_updates` SET `entry` = 4086, `version` = 3596 WHERE (`entry` = 4086);
-- Zephyr Belt
-- stat_value2, from 40 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6719);
UPDATE `applied_item_updates` SET `entry` = 6719, `version` = 3596 WHERE (`entry` = 6719);
-- Gloves of Holy Might
-- spellid_2, from 9331 to 0
-- spelltrigger_2, from 1 to 0
-- spellid_3, from 18074 to 0
-- spelltrigger_3, from 1 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0, `spellid_3` = 0, `spelltrigger_3` = 0 WHERE (`entry` = 867);
UPDATE `applied_item_updates` SET `entry` = 867, `version` = 3596 WHERE (`entry` = 867);
-- Frostweave Pants
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3596 WHERE (`entry` = 4037);
-- Gutrender
-- spellid_1, from 18090 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1986);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1986, 3596);
-- Blackvenom Blade
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 5 to 0
-- spellid_1, from 13518 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4446);
UPDATE `applied_item_updates` SET `entry` = 4446, `version` = 3596 WHERE (`entry` = 4446);
-- Recruit's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6121);
UPDATE `applied_item_updates` SET `entry` = 6121, `version` = 3596 WHERE (`entry` = 6121);
-- Novice's Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6123);
UPDATE `applied_item_updates` SET `entry` = 6123, `version` = 3596 WHERE (`entry` = 6123);
-- Woodland Tunic
-- armor, from 30 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 4907);
UPDATE `applied_item_updates` SET `entry` = 4907, `version` = 3596 WHERE (`entry` = 4907);
-- Novice's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6124);
UPDATE `applied_item_updates` SET `entry` = 6124, `version` = 3596 WHERE (`entry` = 6124);
-- Ruined Pelt
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 4865);
UPDATE `applied_item_updates` SET `entry` = 4865, `version` = 3596 WHERE (`entry` = 4865);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3596 WHERE (`entry` = 3600);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3596 WHERE (`entry` = 2119);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3596 WHERE (`entry` = 48);
-- Woodland Shield
-- armor, from 38 to 19
UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 5395);
UPDATE `applied_item_updates` SET `entry` = 5395, `version` = 3596 WHERE (`entry` = 5395);
-- Cracked Leather Belt
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2122);
UPDATE `applied_item_updates` SET `entry` = 2122, `version` = 3596 WHERE (`entry` = 2122);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3596 WHERE (`entry` = 3363);
-- Neophyte's Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6119);
UPDATE `applied_item_updates` SET `entry` = 6119, `version` = 3596 WHERE (`entry` = 6119);
-- Neophyte's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 52);
UPDATE `applied_item_updates` SET `entry` = 52, `version` = 3596 WHERE (`entry` = 52);
-- Heavy Recurve Bow
-- required_level, from 20 to 22
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 29.0 to 43
UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 23, `dmg_max1` = 43 WHERE (`entry` = 3027);
UPDATE `applied_item_updates` SET `entry` = 3027, `version` = 3596 WHERE (`entry` = 3027);
-- Pioneer Buckler
-- subclass, from 6 to 5
-- buy_price, from 984 to 639
-- sell_price, from 196 to 127
-- item_level, from 13 to 12
-- required_level, from 8 to 7
-- armor, from 176 to 28
UPDATE `item_template` SET `subclass` = 5, `buy_price` = 639, `sell_price` = 127, `item_level` = 12, `required_level` = 7, `armor` = 28 WHERE (`entry` = 7109);
UPDATE `applied_item_updates` SET `entry` = 7109, `version` = 3596 WHERE (`entry` = 7109);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3596 WHERE (`entry` = 4496);
-- Handstitched Leather Bracers
-- armor, from 18 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 7277);
UPDATE `applied_item_updates` SET `entry` = 7277, `version` = 3596 WHERE (`entry` = 7277);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3596 WHERE (`entry` = 4344);
-- Disciple's Bracers
-- display_id, from 16566 to 14705
-- buy_price, from 148 to 240
-- sell_price, from 29 to 48
-- item_level, from 10 to 12
-- required_level, from 5 to 7
-- armor, from 13 to 6
UPDATE `item_template` SET `display_id` = 14705, `buy_price` = 240, `sell_price` = 48, `item_level` = 12, `required_level` = 7, `armor` = 6 WHERE (`entry` = 7350);
UPDATE `applied_item_updates` SET `entry` = 7350, `version` = 3596 WHERE (`entry` = 7350);
-- Small Egg
-- display_id, from 18046 to 13211
UPDATE `item_template` SET `display_id` = 13211 WHERE (`entry` = 6889);
UPDATE `applied_item_updates` SET `entry` = 6889, `version` = 3596 WHERE (`entry` = 6889);
-- Frayed Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1378);
UPDATE `applied_item_updates` SET `entry` = 1378, `version` = 3596 WHERE (`entry` = 1378);
-- Small Spider Limb
-- name, from Snapped Spider Limb to Small Spider Limb
-- quality, from 1 to 0
UPDATE `item_template` SET `name` = 'Small Spider Limb', `quality` = 0 WHERE (`entry` = 1476);
UPDATE `applied_item_updates` SET `entry` = 1476, `version` = 3596 WHERE (`entry` = 1476);
-- Ruffled Feather
-- buy_price, from 165 to 215
-- sell_price, from 41 to 53
UPDATE `item_template` SET `buy_price` = 215, `sell_price` = 53 WHERE (`entry` = 4776);
UPDATE `applied_item_updates` SET `entry` = 4776, `version` = 3596 WHERE (`entry` = 4776);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3596 WHERE (`entry` = 1366);
-- Cerulean Talisman
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7427);
UPDATE `applied_item_updates` SET `entry` = 7427, `version` = 3596 WHERE (`entry` = 7427);
-- Astral Knot Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7511);
UPDATE `applied_item_updates` SET `entry` = 7511, `version` = 3596 WHERE (`entry` = 7511);
-- Evergreen Gloves
-- display_id, from 16815 to 15865
-- stat_value1, from 3 to 1
-- armor, from 32 to 10
UPDATE `item_template` SET `display_id` = 15865, `stat_value1` = 1, `armor` = 10 WHERE (`entry` = 7738);
UPDATE `applied_item_updates` SET `entry` = 7738, `version` = 3596 WHERE (`entry` = 7738);
-- Light Leather Bracers
-- armor, from 34 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 7281);
UPDATE `applied_item_updates` SET `entry` = 7281, `version` = 3596 WHERE (`entry` = 7281);
-- Rugged Leather Pants
-- buy_price, from 814 to 749
-- sell_price, from 162 to 149
-- stat_type1, from 7 to 1
-- stat_value1, from 1 to 4
-- armor, from 58 to 23
UPDATE `item_template` SET `buy_price` = 749, `sell_price` = 149, `stat_type1` = 1, `stat_value1` = 4, `armor` = 23 WHERE (`entry` = 7280);
UPDATE `applied_item_updates` SET `entry` = 7280, `version` = 3596 WHERE (`entry` = 7280);
-- Ivory Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7497);
UPDATE `applied_item_updates` SET `entry` = 7497, `version` = 3596 WHERE (`entry` = 7497);
-- Aegis of the Scarlet Commander
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 7726);
UPDATE `applied_item_updates` SET `entry` = 7726, `version` = 3596 WHERE (`entry` = 7726);
-- Berserker Helm
-- fire_res, from 0 to 1
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7719);
UPDATE `applied_item_updates` SET `entry` = 7719, `version` = 3596 WHERE (`entry` = 7719);
-- Explorers' League Commendation
-- nature_res, from 0 to 2
-- spellid_1, from 0 to 5102
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `nature_res` = 2, `spellid_1` = 5102, `spelltrigger_1` = 1 WHERE (`entry` = 7746);
UPDATE `applied_item_updates` SET `entry` = 7746, `version` = 3596 WHERE (`entry` = 7746);
-- Twilight Belt
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7438);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7438, 3596);
-- Elder's Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7356);
UPDATE `applied_item_updates` SET `entry` = 7356, `version` = 3596 WHERE (`entry` = 7356);
-- Frostweave Pants
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3596 WHERE (`entry` = 4037);
-- Scorpion Sting
-- spellid_1, from 18208 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1265);
UPDATE `applied_item_updates` SET `entry` = 1265, `version` = 3596 WHERE (`entry` = 1265);
-- Elder's Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7355);
UPDATE `applied_item_updates` SET `entry` = 7355, `version` = 3596 WHERE (`entry` = 7355);
-- Wolfpack Medallion
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3596 WHERE (`entry` = 5754);
-- Forest Tracker Epaulets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3596 WHERE (`entry` = 2278);
-- Fine Leather Gloves
-- stat_value1, from 0 to 5
UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 2312);
UPDATE `applied_item_updates` SET `entry` = 2312, `version` = 3596 WHERE (`entry` = 2312);
-- Light Leather Pants
-- buy_price, from 2998 to 2950
-- sell_price, from 599 to 590
-- stat_value1, from 5 to 1
-- armor, from 95 to 31
UPDATE `item_template` SET `buy_price` = 2950, `sell_price` = 590, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 7282);
UPDATE `applied_item_updates` SET `entry` = 7282, `version` = 3596 WHERE (`entry` = 7282);
-- Bounty Hunter's Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5351);
UPDATE `applied_item_updates` SET `entry` = 5351, `version` = 3596 WHERE (`entry` = 5351);
-- Journeyman Quarterstaff
-- dmg_min1, from 28.0 to 18
-- dmg_max1, from 39.0 to 27
UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 854);
UPDATE `applied_item_updates` SET `entry` = 854, `version` = 3596 WHERE (`entry` = 854);
-- Silver Steel Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6966);
UPDATE `applied_item_updates` SET `entry` = 6966, `version` = 3596 WHERE (`entry` = 6966);
-- Husk of Naraxis
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4448);
UPDATE `applied_item_updates` SET `entry` = 4448, `version` = 3596 WHERE (`entry` = 4448);
-- Polished Scale Vest
-- stat_type1, from 0 to 4
-- stat_value1, from 0 to 1
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3596 WHERE (`entry` = 2153);
-- Polished Scale Leggings
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
-- stat_value2, from 0 to 10
UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2152);
UPDATE `applied_item_updates` SET `entry` = 2152, `version` = 3596 WHERE (`entry` = 2152);
-- Polished Scale Boots
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3596 WHERE (`entry` = 2149);
-- Polished Scale Gloves
-- stat_type1, from 0 to 3
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3596 WHERE (`entry` = 2151);
-- Reinforced Targe
-- stat_value1, from 0 to 10
UPDATE `item_template` SET `stat_value1` = 10 WHERE (`entry` = 2442);
UPDATE `applied_item_updates` SET `entry` = 2442, `version` = 3596 WHERE (`entry` = 2442);
-- Kite Shield
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2446);
UPDATE `applied_item_updates` SET `entry` = 2446, `version` = 3596 WHERE (`entry` = 2446);
-- Glorious Shoulders
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3596 WHERE (`entry` = 4833);
-- Silver Steel Sword
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6967);
UPDATE `applied_item_updates` SET `entry` = 6967, `version` = 3596 WHERE (`entry` = 6967);
-- Scarab Trousers
-- stat_value3, from 1 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3596 WHERE (`entry` = 6659);
-- Explorer's Vest
-- stat_type1, from 7 to 1
-- stat_value1, from 2 to 5
-- armor, from 125 to 44
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `armor` = 44 WHERE (`entry` = 7229);
UPDATE `applied_item_updates` SET `entry` = 7229, `version` = 3596 WHERE (`entry` = 7229);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
UPDATE `applied_item_updates` SET `entry` = 3342, `version` = 3596 WHERE (`entry` = 3342);
-- Dark Leather Tunic
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3596 WHERE (`entry` = 2317);
-- Sustaining Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6743);
UPDATE `applied_item_updates` SET `entry` = 6743, `version` = 3596 WHERE (`entry` = 6743);
-- Enchanted Moonstalker Cloak
-- buy_price, from 2115 to 0
-- sell_price, from 423 to 0
UPDATE `item_template` SET `buy_price` = 0, `sell_price` = 0 WHERE (`entry` = 5387);
UPDATE `applied_item_updates` SET `entry` = 5387, `version` = 3596 WHERE (`entry` = 5387);
-- Grayson's Torch
-- armor, from 0 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3596 WHERE (`entry` = 1172);
-- Willow Branch
-- item_level, from 19 to 16
-- required_level, from 14 to 11
UPDATE `item_template` SET `item_level` = 16, `required_level` = 11 WHERE (`entry` = 7554);
UPDATE `applied_item_updates` SET `entry` = 7554, `version` = 3596 WHERE (`entry` = 7554);
-- Vermilion Necklace
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7467);
UPDATE `applied_item_updates` SET `entry` = 7467, `version` = 3596 WHERE (`entry` = 7467);
-- Rod of the Sleepwalker
-- frost_res, from 0 to 2
UPDATE `item_template` SET `frost_res` = 2 WHERE (`entry` = 1155);
UPDATE `applied_item_updates` SET `entry` = 1155, `version` = 3596 WHERE (`entry` = 1155);
-- Shadow Weaver Leggings
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3596 WHERE (`entry` = 2233);
-- Flameweave Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3596 WHERE (`entry` = 6608);
-- Regal Wizard Hat
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7470);
UPDATE `applied_item_updates` SET `entry` = 7470, `version` = 3596 WHERE (`entry` = 7470);
-- Silvered Bronze Breastplate
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3596 WHERE (`entry` = 2869);
-- Polar Gauntlets
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7606);
UPDATE `applied_item_updates` SET `entry` = 7606, `version` = 3596 WHERE (`entry` = 7606);
-- Scaber Stalk
-- display_id, from 19488 to 15857
UPDATE `item_template` SET `display_id` = 15857 WHERE (`entry` = 5271);
UPDATE `applied_item_updates` SET `entry` = 5271, `version` = 3596 WHERE (`entry` = 5271);
-- Cured Leather Pants
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 237);
UPDATE `applied_item_updates` SET `entry` = 237, `version` = 3596 WHERE (`entry` = 237);
-- Forest Chain
-- stat_value2, from 10 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3596 WHERE (`entry` = 1273);
-- Mud Stompers
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3596 WHERE (`entry` = 6188);
-- Holy Shroud
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3596 WHERE (`entry` = 2721);
-- Sentinel Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 7443);
UPDATE `applied_item_updates` SET `entry` = 7443, `version` = 3596 WHERE (`entry` = 7443);
-- Seal of Wrynn
-- max_count, from 1 to 0
-- fire_res, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `fire_res` = 1 WHERE (`entry` = 2933);
UPDATE `applied_item_updates` SET `entry` = 2933, `version` = 3596 WHERE (`entry` = 2933);
-- Small Quiver
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5439);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5439, 3596);
-- Gold-flecked Gloves
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3596 WHERE (`entry` = 5195);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3596 WHERE (`entry` = 1377);
-- Haggard's Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3596 WHERE (`entry` = 6979);
-- Wolf Handler Gloves
-- buy_price, from 32 to 21
-- sell_price, from 6 to 4
-- item_level, from 5 to 4
-- armor, from 19 to 5
UPDATE `item_template` SET `buy_price` = 21, `sell_price` = 4, `item_level` = 4, `armor` = 5 WHERE (`entry` = 6171);
UPDATE `applied_item_updates` SET `entry` = 6171, `version` = 3596 WHERE (`entry` = 6171);
-- Haggard's Dagger
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6980);
UPDATE `applied_item_updates` SET `entry` = 6980, `version` = 3596 WHERE (`entry` = 6980);
-- Umbral Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3596 WHERE (`entry` = 6978);
-- Sage's Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3596 WHERE (`entry` = 6609);
-- Azure Silk Pants
-- frost_res, from 0 to 1
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7046);
UPDATE `applied_item_updates` SET `entry` = 7046, `version` = 3596 WHERE (`entry` = 7046);
-- Fire Hardened Hauberk
-- display_id, from 22480 to 13011
-- stat_value1, from 14 to 5
-- armor, from 226 to 71
UPDATE `item_template` SET `display_id` = 13011, `stat_value1` = 5, `armor` = 71 WHERE (`entry` = 6972);
UPDATE `applied_item_updates` SET `entry` = 6972, `version` = 3596 WHERE (`entry` = 6972);
-- Divine Gauntlets
-- spellid_1, from 15807 to 9408
UPDATE `item_template` SET `spellid_1` = 9408 WHERE (`entry` = 7724);
UPDATE `applied_item_updates` SET `entry` = 7724, `version` = 3596 WHERE (`entry` = 7724);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3596 WHERE (`entry` = 4496);
-- Fractured Canine
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3299);
UPDATE `applied_item_updates` SET `entry` = 3299, `version` = 3596 WHERE (`entry` = 3299);
-- Disciple's Bracers
-- display_id, from 16566 to 14705
-- buy_price, from 148 to 240
-- sell_price, from 29 to 48
-- item_level, from 10 to 12
-- required_level, from 5 to 7
-- armor, from 13 to 6
UPDATE `item_template` SET `display_id` = 14705, `buy_price` = 240, `sell_price` = 48, `item_level` = 12, `required_level` = 7, `armor` = 6 WHERE (`entry` = 7350);
UPDATE `applied_item_updates` SET `entry` = 7350, `version` = 3596 WHERE (`entry` = 7350);
-- Heavy Recurve Bow
-- required_level, from 20 to 22
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 29.0 to 43
UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 23, `dmg_max1` = 43 WHERE (`entry` = 3027);
UPDATE `applied_item_updates` SET `entry` = 3027, `version` = 3596 WHERE (`entry` = 3027);
-- Black Whelp Cloak
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 7283);
UPDATE `applied_item_updates` SET `entry` = 7283, `version` = 3596 WHERE (`entry` = 7283);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3596 WHERE (`entry` = 1366);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3596 WHERE (`entry` = 1377);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3596 WHERE (`entry` = 2119);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3596 WHERE (`entry` = 3600);
-- Laced Mail Belt
-- armor, from 91 to 15
UPDATE `item_template` SET `armor` = 15 WHERE (`entry` = 1738);
UPDATE `applied_item_updates` SET `entry` = 1738, `version` = 3596 WHERE (`entry` = 1738);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3596 WHERE (`entry` = 3363);
-- Captain's Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7488);
UPDATE `applied_item_updates` SET `entry` = 7488, `version` = 3596 WHERE (`entry` = 7488);
-- Explorers' League Commendation
-- nature_res, from 0 to 2
-- spellid_1, from 0 to 5102
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `nature_res` = 2, `spellid_1` = 5102, `spelltrigger_1` = 1 WHERE (`entry` = 7746);
UPDATE `applied_item_updates` SET `entry` = 7746, `version` = 3596 WHERE (`entry` = 7746);
-- Ivory Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7497);
UPDATE `applied_item_updates` SET `entry` = 7497, `version` = 3596 WHERE (`entry` = 7497);
-- Sword of Serenity
-- spellid_1, from 0 to 370
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `spellid_1` = 370, `spelltrigger_1` = 2 WHERE (`entry` = 6829);
UPDATE `applied_item_updates` SET `entry` = 6829, `version` = 3596 WHERE (`entry` = 6829);
-- Aegis of the Scarlet Commander
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 7726);
UPDATE `applied_item_updates` SET `entry` = 7726, `version` = 3596 WHERE (`entry` = 7726);
-- Acolyte's Pants
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1396);
UPDATE `applied_item_updates` SET `entry` = 1396, `version` = 3596 WHERE (`entry` = 1396);
-- Regal Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7468);
UPDATE `applied_item_updates` SET `entry` = 7468, `version` = 3596 WHERE (`entry` = 7468);
-- Berserker Helm
-- fire_res, from 0 to 1
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7719);
UPDATE `applied_item_updates` SET `entry` = 7719, `version` = 3596 WHERE (`entry` = 7719);
-- Divine Gauntlets
-- spellid_1, from 15807 to 9408
UPDATE `item_template` SET `spellid_1` = 9408 WHERE (`entry` = 7724);
UPDATE `applied_item_updates` SET `entry` = 7724, `version` = 3596 WHERE (`entry` = 7724);
-- Mechanical Dragonling
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 4396);
UPDATE `applied_item_updates` SET `entry` = 4396, `version` = 3596 WHERE (`entry` = 4396);
-- Polar Gauntlets
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7606);
UPDATE `applied_item_updates` SET `entry` = 7606, `version` = 3596 WHERE (`entry` = 7606);
-- Light Leather Bracers
-- armor, from 34 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 7281);
UPDATE `applied_item_updates` SET `entry` = 7281, `version` = 3596 WHERE (`entry` = 7281);
-- Bishop's Miter
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7720);
UPDATE `applied_item_updates` SET `entry` = 7720, `version` = 3596 WHERE (`entry` = 7720);
-- Scorching Sash
-- spellid_1, from 9400 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4117);
UPDATE `applied_item_updates` SET `entry` = 4117, `version` = 3596 WHERE (`entry` = 4117);
-- Regal Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7469);
UPDATE `applied_item_updates` SET `entry` = 7469, `version` = 3596 WHERE (`entry` = 7469);
-- Vermilion Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7466);
UPDATE `applied_item_updates` SET `entry` = 7466, `version` = 3596 WHERE (`entry` = 7466);
-- Large Bear Tooth
-- buy_price, from 190 to 290
-- sell_price, from 47 to 72
UPDATE `item_template` SET `buy_price` = 290, `sell_price` = 72 WHERE (`entry` = 3170);
UPDATE `applied_item_updates` SET `entry` = 3170, `version` = 3596 WHERE (`entry` = 3170);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3596 WHERE (`entry` = 48);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3596 WHERE (`entry` = 4344);
-- Wandering Boots
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3596 WHERE (`entry` = 6095);
-- Sustaining Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6743);
UPDATE `applied_item_updates` SET `entry` = 6743, `version` = 3596 WHERE (`entry` = 6743);
-- Gravestone Sceptre
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 7001);
UPDATE `applied_item_updates` SET `entry` = 7001, `version` = 3596 WHERE (`entry` = 7001);
-- Twilight Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7430);
UPDATE `applied_item_updates` SET `entry` = 7430, `version` = 3596 WHERE (`entry` = 7430);
-- Azure Silk Pants
-- frost_res, from 0 to 1
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7046);
UPDATE `applied_item_updates` SET `entry` = 7046, `version` = 3596 WHERE (`entry` = 7046);
-- Band of Thorns
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5007);
UPDATE `applied_item_updates` SET `entry` = 5007, `version` = 3596 WHERE (`entry` = 5007);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
UPDATE `applied_item_updates` SET `entry` = 3342, `version` = 3596 WHERE (`entry` = 3342);
-- Darkshire Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3596 WHERE (`entry` = 2906);
-- Thornstone Sledgehammer
-- nature_res, from 10 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 1722);
UPDATE `applied_item_updates` SET `entry` = 1722, `version` = 3596 WHERE (`entry` = 1722);
-- Black Menace
-- spellid_1, from 13440 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6831);
UPDATE `applied_item_updates` SET `entry` = 6831, `version` = 3596 WHERE (`entry` = 6831);
-- Rose Mantle
-- stat_value2, from 5 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5274);
UPDATE `applied_item_updates` SET `entry` = 5274, `version` = 3596 WHERE (`entry` = 5274);
-- Sage's Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3596 WHERE (`entry` = 6609);
-- Pioneer Buckler
-- subclass, from 6 to 5
-- buy_price, from 984 to 639
-- sell_price, from 196 to 127
-- item_level, from 13 to 12
-- required_level, from 8 to 7
-- armor, from 176 to 28
UPDATE `item_template` SET `subclass` = 5, `buy_price` = 639, `sell_price` = 127, `item_level` = 12, `required_level` = 7, `armor` = 28 WHERE (`entry` = 7109);
UPDATE `applied_item_updates` SET `entry` = 7109, `version` = 3596 WHERE (`entry` = 7109);
-- Embalmed Shroud
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7691);
UPDATE `applied_item_updates` SET `entry` = 7691, `version` = 3596 WHERE (`entry` = 7691);
-- Silver Steel Sword
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6967);
UPDATE `applied_item_updates` SET `entry` = 6967, `version` = 3596 WHERE (`entry` = 6967);
-- Mud Stompers
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3596 WHERE (`entry` = 6188);
-- Twilight Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7432);
UPDATE `applied_item_updates` SET `entry` = 7432, `version` = 3596 WHERE (`entry` = 7432);
-- Darkweave Mantle
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3596 WHERE (`entry` = 4718);
-- Elder's Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7355);
UPDATE `applied_item_updates` SET `entry` = 7355, `version` = 3596 WHERE (`entry` = 7355);
-- Cerulean Talisman
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7427);
UPDATE `applied_item_updates` SET `entry` = 7427, `version` = 3596 WHERE (`entry` = 7427);
-- Cerulean Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7426);
UPDATE `applied_item_updates` SET `entry` = 7426, `version` = 3596 WHERE (`entry` = 7426);
-- Umbral Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3596 WHERE (`entry` = 6978);
-- Black Metal Shortsword
-- shadow_res, from 4 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 886);
UPDATE `applied_item_updates` SET `entry` = 886, `version` = 3596 WHERE (`entry` = 886);
-- Darkweave Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3596 WHERE (`entry` = 4039);
-- Darkweave Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4038);
UPDATE `applied_item_updates` SET `entry` = 4038, `version` = 3596 WHERE (`entry` = 4038);
-- Belt of Arugal
-- stat_type1, from 6 to 0
-- stat_value2, from 35 to 0
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `stat_type1` = 0, `stat_value2` = 0, `shadow_res` = 4 WHERE (`entry` = 6392);
UPDATE `applied_item_updates` SET `entry` = 6392, `version` = 3596 WHERE (`entry` = 6392);
-- Dark Leather Tunic
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3596 WHERE (`entry` = 2317);
-- Forest Tracker Epaulets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3596 WHERE (`entry` = 2278);
-- Wolfpack Medallion
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3596 WHERE (`entry` = 5754);
-- Acolyte's Pants
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1396);
UPDATE `applied_item_updates` SET `entry` = 1396, `version` = 3596 WHERE (`entry` = 1396);
-- Neophyte's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 52);
UPDATE `applied_item_updates` SET `entry` = 52, `version` = 3596 WHERE (`entry` = 52);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3596 WHERE (`entry` = 1377);
-- Ruined Pelt
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 4865);
UPDATE `applied_item_updates` SET `entry` = 4865, `version` = 3596 WHERE (`entry` = 4865);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3596 WHERE (`entry` = 1366);
-- Dirty Leather Boots
-- armor, from 10 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 210);
UPDATE `applied_item_updates` SET `entry` = 210, `version` = 3596 WHERE (`entry` = 210);
-- Dirty Leather Pants
-- armor, from 13 to 10
UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 209);
UPDATE `applied_item_updates` SET `entry` = 209, `version` = 3596 WHERE (`entry` = 209);
-- Deckhand's Shirt
-- required_level, from 4 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 5107);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5107, 3596);
-- Light Leather Pants
-- buy_price, from 2998 to 2950
-- sell_price, from 599 to 590
-- stat_value1, from 5 to 1
-- armor, from 95 to 31
UPDATE `item_template` SET `buy_price` = 2950, `sell_price` = 590, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 7282);
UPDATE `applied_item_updates` SET `entry` = 7282, `version` = 3596 WHERE (`entry` = 7282);
-- Light Leather Bracers
-- armor, from 34 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 7281);
UPDATE `applied_item_updates` SET `entry` = 7281, `version` = 3596 WHERE (`entry` = 7281);
-- War Knife
-- buy_price, from 4896 to 2571
-- sell_price, from 979 to 514
-- item_level, from 17 to 13
-- required_level, from 12 to 8
-- dmg_min1, from 10.0 to 7
-- dmg_max1, from 19.0 to 13
UPDATE `item_template` SET `buy_price` = 2571, `sell_price` = 514, `item_level` = 13, `required_level` = 8, `dmg_min1` = 7, `dmg_max1` = 13 WHERE (`entry` = 4571);
UPDATE `applied_item_updates` SET `entry` = 4571, `version` = 3596 WHERE (`entry` = 4571);
-- Handstitched Leather Bracers
-- armor, from 18 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 7277);
UPDATE `applied_item_updates` SET `entry` = 7277, `version` = 3596 WHERE (`entry` = 7277);
-- Frayed Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1378);
UPDATE `applied_item_updates` SET `entry` = 1378, `version` = 3596 WHERE (`entry` = 1378);
-- Sunblaze Coif
-- fire_res, from 48 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 5819);
UPDATE `applied_item_updates` SET `entry` = 5819, `version` = 3596 WHERE (`entry` = 5819);
-- Skull Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3739);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3739, 3596);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3596 WHERE (`entry` = 4496);
-- Band of the Undercity
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3760);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3760, 3596);
-- Battered Leather Belt
-- display_id, from 17114 to 14460
-- armor, from 16 to 10
UPDATE `item_template` SET `display_id` = 14460, `armor` = 10 WHERE (`entry` = 2371);
UPDATE `applied_item_updates` SET `entry` = 2371, `version` = 3596 WHERE (`entry` = 2371);
-- Battered Leather Boots
-- display_id, from 17158 to 14461
-- armor, from 25 to 15
UPDATE `item_template` SET `display_id` = 14461, `armor` = 15 WHERE (`entry` = 2373);
UPDATE `applied_item_updates` SET `entry` = 2373, `version` = 3596 WHERE (`entry` = 2373);
-- Battered Leather Bracers
-- display_id, from 17002 to 14462
-- armor, from 18 to 11
UPDATE `item_template` SET `display_id` = 14462, `armor` = 11 WHERE (`entry` = 2374);
UPDATE `applied_item_updates` SET `entry` = 2374, `version` = 3596 WHERE (`entry` = 2374);
-- Pioneer Buckler
-- subclass, from 6 to 5
-- buy_price, from 984 to 639
-- sell_price, from 196 to 127
-- item_level, from 13 to 12
-- required_level, from 8 to 7
-- armor, from 176 to 28
UPDATE `item_template` SET `subclass` = 5, `buy_price` = 639, `sell_price` = 127, `item_level` = 12, `required_level` = 7, `armor` = 28 WHERE (`entry` = 7109);
UPDATE `applied_item_updates` SET `entry` = 7109, `version` = 3596 WHERE (`entry` = 7109);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3596 WHERE (`entry` = 3363);
-- Heavy Cord Bracers
-- armor, from 9 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 6062);
UPDATE `applied_item_updates` SET `entry` = 6062, `version` = 3596 WHERE (`entry` = 6062);
-- Rainwalker Boots
-- armor, from 16 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 4906);
UPDATE `applied_item_updates` SET `entry` = 4906, `version` = 3596 WHERE (`entry` = 4906);
-- Plains Hunter Wristguards
-- armor, from 18 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 4973);
UPDATE `applied_item_updates` SET `entry` = 4973, `version` = 3596 WHERE (`entry` = 4973);
-- Bounty Hunter's Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5351);
UPDATE `applied_item_updates` SET `entry` = 5351, `version` = 3596 WHERE (`entry` = 5351);
-- Ring of Scorn
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3235);
UPDATE `applied_item_updates` SET `entry` = 3235, `version` = 3596 WHERE (`entry` = 3235);
-- Battered Leather Gloves
-- display_id, from 17051 to 14463
-- armor, from 20 to 12
UPDATE `item_template` SET `display_id` = 14463, `armor` = 12 WHERE (`entry` = 2375);
UPDATE `applied_item_updates` SET `entry` = 2375, `version` = 3596 WHERE (`entry` = 2375);
-- Wolf Handler Gloves
-- buy_price, from 32 to 21
-- sell_price, from 6 to 4
-- item_level, from 5 to 4
-- armor, from 19 to 5
UPDATE `item_template` SET `buy_price` = 21, `sell_price` = 4, `item_level` = 4, `armor` = 5 WHERE (`entry` = 6171);
UPDATE `applied_item_updates` SET `entry` = 6171, `version` = 3596 WHERE (`entry` = 6171);
-- Novice's Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6123);
UPDATE `applied_item_updates` SET `entry` = 6123, `version` = 3596 WHERE (`entry` = 6123);
-- Novice's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6124);
UPDATE `applied_item_updates` SET `entry` = 6124, `version` = 3596 WHERE (`entry` = 6124);
-- Recruit's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6121);
UPDATE `applied_item_updates` SET `entry` = 6121, `version` = 3596 WHERE (`entry` = 6121);
-- Woodland Shield
-- armor, from 38 to 19
UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 5395);
UPDATE `applied_item_updates` SET `entry` = 5395, `version` = 3596 WHERE (`entry` = 5395);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3596 WHERE (`entry` = 48);
-- Neophyte's Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6119);
UPDATE `applied_item_updates` SET `entry` = 6119, `version` = 3596 WHERE (`entry` = 6119);
-- Woodland Tunic
-- armor, from 30 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 4907);
UPDATE `applied_item_updates` SET `entry` = 4907, `version` = 3596 WHERE (`entry` = 4907);
-- Handsewn Cloak
-- armor, from 18 to 10
UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 4944);
UPDATE `applied_item_updates` SET `entry` = 4944, `version` = 3596 WHERE (`entry` = 4944);
-- Reconnaissance Boots
-- stat_value1, from 12 to 0
-- stat_value2, from 13 to 0
UPDATE `item_template` SET `stat_value1` = 0, `stat_value2` = 0 WHERE (`entry` = 3454);
UPDATE `applied_item_updates` SET `entry` = 3454, `version` = 3596 WHERE (`entry` = 3454);
-- Disciple's Bracers
-- display_id, from 16566 to 14705
-- buy_price, from 148 to 240
-- sell_price, from 29 to 48
-- item_level, from 10 to 12
-- required_level, from 5 to 7
-- armor, from 13 to 6
UPDATE `item_template` SET `display_id` = 14705, `buy_price` = 240, `sell_price` = 48, `item_level` = 12, `required_level` = 7, `armor` = 6 WHERE (`entry` = 7350);
UPDATE `applied_item_updates` SET `entry` = 7350, `version` = 3596 WHERE (`entry` = 7350);
-- Dalaran Wizard's Robe
-- shadow_res, from 0 to 2
UPDATE `item_template` SET `shadow_res` = 2 WHERE (`entry` = 5110);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5110, 3596);
-- Ivory Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7497);
UPDATE `applied_item_updates` SET `entry` = 7497, `version` = 3596 WHERE (`entry` = 7497);
-- Mechanical Dragonling
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 4396);
UPDATE `applied_item_updates` SET `entry` = 4396, `version` = 3596 WHERE (`entry` = 4396);
-- Willow Branch
-- item_level, from 19 to 16
-- required_level, from 14 to 11
UPDATE `item_template` SET `item_level` = 16, `required_level` = 11 WHERE (`entry` = 7554);
UPDATE `applied_item_updates` SET `entry` = 7554, `version` = 3596 WHERE (`entry` = 7554);
-- Ceremonial Leather Gloves
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 3314);
UPDATE `applied_item_updates` SET `entry` = 3314, `version` = 3596 WHERE (`entry` = 3314);
-- Cerulean Talisman
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7427);
UPDATE `applied_item_updates` SET `entry` = 7427, `version` = 3596 WHERE (`entry` = 7427);
-- Regal Wizard Hat
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7470);
UPDATE `applied_item_updates` SET `entry` = 7470, `version` = 3596 WHERE (`entry` = 7470);
-- Regal Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7468);
UPDATE `applied_item_updates` SET `entry` = 7468, `version` = 3596 WHERE (`entry` = 7468);
-- Regal Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7469);
UPDATE `applied_item_updates` SET `entry` = 7469, `version` = 3596 WHERE (`entry` = 7469);
-- Regal Cuffs
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7475);
UPDATE `applied_item_updates` SET `entry` = 7475, `version` = 3596 WHERE (`entry` = 7475);
-- Bloodbone Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 4135);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4135, 3596);
-- Regal Cloak
-- frost_res, from 0 to 6
UPDATE `item_template` SET `frost_res` = 6 WHERE (`entry` = 7474);
UPDATE `applied_item_updates` SET `entry` = 7474, `version` = 3596 WHERE (`entry` = 7474);
-- Dancing Flame
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 6806);
UPDATE `applied_item_updates` SET `entry` = 6806, `version` = 3596 WHERE (`entry` = 6806);
-- Slime Encrusted Pads
-- spellid_1, from 18764 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6461);
UPDATE `applied_item_updates` SET `entry` = 6461, `version` = 3596 WHERE (`entry` = 6461);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3596 WHERE (`entry` = 4344);
-- Stamped Trousers
-- stat_type2, from 7 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 3457);
UPDATE `applied_item_updates` SET `entry` = 3457, `version` = 3596 WHERE (`entry` = 3457);
-- Mercenary Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 3751);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3751, 3596);
-- Mail Combat Gauntlets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 1 WHERE (`entry` = 4075);
UPDATE `applied_item_updates` SET `entry` = 4075, `version` = 3596 WHERE (`entry` = 4075);
-- Belt of Arugal
-- stat_type1, from 6 to 0
-- stat_value2, from 35 to 0
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `stat_type1` = 0, `stat_value2` = 0, `shadow_res` = 4 WHERE (`entry` = 6392);
UPDATE `applied_item_updates` SET `entry` = 6392, `version` = 3596 WHERE (`entry` = 6392);
-- Sacred Burial Trousers
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 6282);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6282, 3596);
-- Dog Training Gloves
-- spellid_1, from 14565 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7756);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7756, 3596);
-- Twilight Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7436);
UPDATE `applied_item_updates` SET `entry` = 7436, `version` = 3596 WHERE (`entry` = 7436);
-- Twilight Belt
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7438);
UPDATE `applied_item_updates` SET `entry` = 7438, `version` = 3596 WHERE (`entry` = 7438);
-- Dryleaf Pants
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 6737);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6737, 3596);
-- Sage's Pants
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6616);
UPDATE `applied_item_updates` SET `entry` = 6616, `version` = 3596 WHERE (`entry` = 6616);
-- Crescent Staff
-- stat_value4, from 2 to 0
UPDATE `item_template` SET `stat_value4` = 0 WHERE (`entry` = 6505);
UPDATE `applied_item_updates` SET `entry` = 6505, `version` = 3596 WHERE (`entry` = 6505);
-- Vermilion Necklace
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7467);
UPDATE `applied_item_updates` SET `entry` = 7467, `version` = 3596 WHERE (`entry` = 7467);
-- Nether-Lace Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7512);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7512, 3596);
-- Azure Silk Pants
-- frost_res, from 0 to 1
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7046);
UPDATE `applied_item_updates` SET `entry` = 7046, `version` = 3596 WHERE (`entry` = 7046);
-- Elder's Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7355);
UPDATE `applied_item_updates` SET `entry` = 7355, `version` = 3596 WHERE (`entry` = 7355);
-- Seal of Sylvanas
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6414);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6414, 3596);
-- Ceremonial Leather Harness
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 3313);
UPDATE `applied_item_updates` SET `entry` = 3313, `version` = 3596 WHERE (`entry` = 3313);
-- Buckled Boots
-- armor, from 62 to 26
UPDATE `item_template` SET `armor` = 26 WHERE (`entry` = 5311);
UPDATE `applied_item_updates` SET `entry` = 5311, `version` = 3596 WHERE (`entry` = 5311);
-- Forest Tracker Epaulets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3596 WHERE (`entry` = 2278);
-- Frostweave Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4713);
UPDATE `applied_item_updates` SET `entry` = 4713, `version` = 3596 WHERE (`entry` = 4713);
-- Totemic Clan Ring
-- display_id, from 6655 to 7544
-- max_count, from 1 to 0
UPDATE `item_template` SET `display_id` = 7544, `max_count` = 0 WHERE (`entry` = 5313);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5313, 3596);
-- Tribal Warrior's Shield
-- armor, from 131 to 54
UPDATE `item_template` SET `armor` = 54 WHERE (`entry` = 4967);
UPDATE `applied_item_updates` SET `entry` = 4967, `version` = 3596 WHERE (`entry` = 4967);
-- Mistspray Breeches
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4976);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4976, 3596);
-- Violet Scale Armor
-- stat_value3, from 20 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 6502);
UPDATE `applied_item_updates` SET `entry` = 6502, `version` = 3596 WHERE (`entry` = 6502);
-- Tribal Headdress
-- stat_type3, from 0 to 7
-- stat_value3, from 0 to 2
-- nature_res, from 0 to 1
UPDATE `item_template` SET `stat_type3` = 7, `stat_value3` = 2, `nature_res` = 1 WHERE (`entry` = 2622);
UPDATE `applied_item_updates` SET `entry` = 2622, `version` = 3596 WHERE (`entry` = 2622);
-- Darkweave Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4038);
UPDATE `applied_item_updates` SET `entry` = 4038, `version` = 3596 WHERE (`entry` = 4038);
-- Brightweave Pants
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4044);
UPDATE `applied_item_updates` SET `entry` = 4044, `version` = 3596 WHERE (`entry` = 4044);
-- Voodoo Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 1996);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1996, 3596);
-- Nightglow Concoction
-- max_count, from 1 to 0
-- stat_type1, from 6 to 0
-- stat_value2, from 20 to 0
UPDATE `item_template` SET `max_count` = 0, `stat_type1` = 0, `stat_value2` = 0 WHERE (`entry` = 3451);
UPDATE `applied_item_updates` SET `entry` = 3451, `version` = 3596 WHERE (`entry` = 3451);
-- Glimmering Buckler
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 4064);
UPDATE `applied_item_updates` SET `entry` = 4064, `version` = 3596 WHERE (`entry` = 4064);
-- Elder's Sash
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7370);
UPDATE `applied_item_updates` SET `entry` = 7370, `version` = 3596 WHERE (`entry` = 7370);
-- Bishop's Miter
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7720);
UPDATE `applied_item_updates` SET `entry` = 7720, `version` = 3596 WHERE (`entry` = 7720);
-- Dark Leather Tunic
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3596 WHERE (`entry` = 2317);
-- Flesh Piercer
-- spellid_1, from 18078 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3336);
UPDATE `applied_item_updates` SET `entry` = 3336, `version` = 3596 WHERE (`entry` = 3336);
-- Serpent Gloves
-- stat_type2, from 1 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 5970);
UPDATE `applied_item_updates` SET `entry` = 5970, `version` = 3596 WHERE (`entry` = 5970);
-- Holy Shroud
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3596 WHERE (`entry` = 2721);
-- Engineer's Cloak
-- stat_value2, from 1 to 0
-- stat_value3, from 5 to 0
UPDATE `item_template` SET `stat_value2` = 0, `stat_value3` = 0 WHERE (`entry` = 6667);
UPDATE `applied_item_updates` SET `entry` = 6667, `version` = 3596 WHERE (`entry` = 6667);
-- Berserker Helm
-- fire_res, from 0 to 1
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7719);
UPDATE `applied_item_updates` SET `entry` = 7719, `version` = 3596 WHERE (`entry` = 7719);
-- Vermilion Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7466);
UPDATE `applied_item_updates` SET `entry` = 7466, `version` = 3596 WHERE (`entry` = 7466);
-- Twilight Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7432);
UPDATE `applied_item_updates` SET `entry` = 7432, `version` = 3596 WHERE (`entry` = 7432);
-- Sacred Band
-- sell_price, from 2757 to 1378
-- max_count, from 1 to 0
UPDATE `item_template` SET `sell_price` = 1378, `max_count` = 0 WHERE (`entry` = 6669);
UPDATE `applied_item_updates` SET `entry` = 6669, `version` = 3596 WHERE (`entry` = 6669);
-- Humbert's Chestpiece
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 3053);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3053, 3596);
-- Choker of the High Shaman
-- spellid_1, from 0 to 5236
-- spellcategory_1, from 0 to 28
UPDATE `item_template` SET `spellid_1` = 5236, `spellcategory_1` = 28 WHERE (`entry` = 4112);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4112, 3596);
-- Scorching Sash
-- spellid_1, from 9400 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4117);
UPDATE `applied_item_updates` SET `entry` = 4117, `version` = 3596 WHERE (`entry` = 4117);
-- Monkey Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6748);
UPDATE `applied_item_updates` SET `entry` = 6748, `version` = 3596 WHERE (`entry` = 6748);
-- Girdle of the Blindwatcher
-- stat_value2, from 5 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6319);
UPDATE `applied_item_updates` SET `entry` = 6319, `version` = 3596 WHERE (`entry` = 6319);
-- Aegis of the Scarlet Commander
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 7726);
UPDATE `applied_item_updates` SET `entry` = 7726, `version` = 3596 WHERE (`entry` = 7726);
-- Flash Rifle
-- stat_value1, from 2 to 0
UPDATE `item_template` SET `stat_value1` = 0 WHERE (`entry` = 4086);
UPDATE `applied_item_updates` SET `entry` = 4086, `version` = 3596 WHERE (`entry` = 4086);
-- Ward of the Vale
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 5357);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5357, 3596);
-- Scorpion Sting
-- spellid_1, from 18208 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1265);
UPDATE `applied_item_updates` SET `entry` = 1265, `version` = 3596 WHERE (`entry` = 1265);
-- Leech Pants
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 6910);
UPDATE `applied_item_updates` SET `entry` = 6910, `version` = 3596 WHERE (`entry` = 6910);
-- Glorious Shoulders
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3596 WHERE (`entry` = 4833);
-- Phalanx Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7419);
UPDATE `applied_item_updates` SET `entry` = 7419, `version` = 3596 WHERE (`entry` = 7419);
-- Elder's Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7356);
UPDATE `applied_item_updates` SET `entry` = 7356, `version` = 3596 WHERE (`entry` = 7356);
-- Ogremind Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 1993);
UPDATE `applied_item_updates` SET `entry` = 1993, `version` = 3596 WHERE (`entry` = 1993);
-- Animal Skin Belt
-- armor, from 12 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 5936);
UPDATE `applied_item_updates` SET `entry` = 5936, `version` = 3596 WHERE (`entry` = 5936);
-- Brackwater Leggings
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 3305);
UPDATE `applied_item_updates` SET `entry` = 3305, `version` = 3596 WHERE (`entry` = 3305);
-- Cliff Runner Boots
-- armor, from 40 to 23
UPDATE `item_template` SET `armor` = 23 WHERE (`entry` = 4972);
UPDATE `applied_item_updates` SET `entry` = 4972, `version` = 3596 WHERE (`entry` = 4972);
-- Thick Parchment
-- start_quest, from 1 to 0
UPDATE `item_template` SET `start_quest` = 0 WHERE (`entry` = 6497);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6497, 3596);
-- Captain's Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7488);
UPDATE `applied_item_updates` SET `entry` = 7488, `version` = 3596 WHERE (`entry` = 7488);
-- Ruffled Feather
-- buy_price, from 165 to 215
-- sell_price, from 41 to 53
UPDATE `item_template` SET `buy_price` = 215, `sell_price` = 53 WHERE (`entry` = 4776);
UPDATE `applied_item_updates` SET `entry` = 4776, `version` = 3596 WHERE (`entry` = 4776);
-- Silvered Bronze Breastplate
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3596 WHERE (`entry` = 2869);
-- Venomstrike
-- dmg_min2, from 3.0 to 0
-- dmg_max2, from 6.0 to 0
-- dmg_type2, from 3 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0 WHERE (`entry` = 6469);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6469, 3596);
-- Raw Rainbow Fin Albacore
-- buy_price, from 100 to 125
-- sell_price, from 5 to 6
UPDATE `item_template` SET `buy_price` = 125, `sell_price` = 6 WHERE (`entry` = 6361);
UPDATE `applied_item_updates` SET `entry` = 6361, `version` = 3596 WHERE (`entry` = 6361);
-- Darkweave Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3596 WHERE (`entry` = 4039);
-- Insignia Bracers
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6410);
UPDATE `applied_item_updates` SET `entry` = 6410, `version` = 3596 WHERE (`entry` = 6410);
-- Heart Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5001);
UPDATE `applied_item_updates` SET `entry` = 5001, `version` = 3596 WHERE (`entry` = 5001);
-- Black Duskwood Staff
-- spellid_1, from 18138 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 937);
UPDATE `applied_item_updates` SET `entry` = 937, `version` = 3596 WHERE (`entry` = 937);
-- Fractured Canine
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3299);
UPDATE `applied_item_updates` SET `entry` = 3299, `version` = 3596 WHERE (`entry` = 3299);
-- Sentinel Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 7443);
UPDATE `applied_item_updates` SET `entry` = 7443, `version` = 3596 WHERE (`entry` = 7443);
-- Sylvan Cloak
-- stat_value2, from 18 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 4793);
UPDATE `applied_item_updates` SET `entry` = 4793, `version` = 3596 WHERE (`entry` = 4793);
-- Ceremonial Leather Ankleguards
-- stat_type1, from 5 to 0
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_type1` = 0, `stat_value2` = 0 WHERE (`entry` = 3311);
UPDATE `applied_item_updates` SET `entry` = 3311, `version` = 3596 WHERE (`entry` = 3311);
-- Seedcloud Buckler
-- stat_value2, from 4 to 0
-- nature_res, from 0 to 1
UPDATE `item_template` SET `stat_value2` = 0, `nature_res` = 1 WHERE (`entry` = 6630);
UPDATE `applied_item_updates` SET `entry` = 6630, `version` = 3596 WHERE (`entry` = 6630);
-- Adept's Gloves
-- flags, from 16 to 0
UPDATE `item_template` SET `flags` = 0 WHERE (`entry` = 4768);
UPDATE `applied_item_updates` SET `entry` = 4768, `version` = 3596 WHERE (`entry` = 4768);
-- Fine Leather Pants
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 1 WHERE (`entry` = 5958);
UPDATE `applied_item_updates` SET `entry` = 5958, `version` = 3596 WHERE (`entry` = 5958);
-- Gauntlets of Ogre Strength
-- spellid_1, from 9329 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3341);
UPDATE `applied_item_updates` SET `entry` = 3341, `version` = 3596 WHERE (`entry` = 3341);
-- Cerulean Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7426);
UPDATE `applied_item_updates` SET `entry` = 7426, `version` = 3596 WHERE (`entry` = 7426);
-- Stalvan's Reaper
-- spellid_1, from 13524 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 934);
UPDATE `applied_item_updates` SET `entry` = 934, `version` = 3596 WHERE (`entry` = 934);
-- Flameweave Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3596 WHERE (`entry` = 6608);
-- Buckled Harness
-- armor, from 67 to 30
UPDATE `item_template` SET `armor` = 30 WHERE (`entry` = 6523);
UPDATE `applied_item_updates` SET `entry` = 6523, `version` = 3596 WHERE (`entry` = 6523);
-- Journeyman Quarterstaff
-- dmg_min1, from 28.0 to 18
-- dmg_max1, from 39.0 to 27
UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 854);
UPDATE `applied_item_updates` SET `entry` = 854, `version` = 3596 WHERE (`entry` = 854);
-- Fine Leather Gloves
-- stat_value1, from 0 to 5
UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 2312);
UPDATE `applied_item_updates` SET `entry` = 2312, `version` = 3596 WHERE (`entry` = 2312);
-- Blackfang
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 2236);
UPDATE `applied_item_updates` SET `entry` = 2236, `version` = 3596 WHERE (`entry` = 2236);
-- Burnished Buckler
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6380);
UPDATE `applied_item_updates` SET `entry` = 6380, `version` = 3596 WHERE (`entry` = 6380);
-- Recipe: Elixir of Giant Growth
-- sell_price, from 300 to 150
UPDATE `item_template` SET `sell_price` = 150 WHERE (`entry` = 6663);
UPDATE `applied_item_updates` SET `entry` = 6663, `version` = 3596 WHERE (`entry` = 6663);
-- Light Bow
-- buy_price, from 5922 to 1777
-- sell_price, from 1184 to 355
-- item_level, from 21 to 13
-- required_level, from 16 to 8
UPDATE `item_template` SET `buy_price` = 1777, `sell_price` = 355, `item_level` = 13, `required_level` = 8 WHERE (`entry` = 4576);
UPDATE `applied_item_updates` SET `entry` = 4576, `version` = 3596 WHERE (`entry` = 4576);
-- Inferno Robe
-- fire_res, from 0 to 1
-- spellid_1, from 17747 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2231);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2231, 3596);
-- Murloc Scale Breastplate
-- stat_value3, from 25 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 5781);
UPDATE `applied_item_updates` SET `entry` = 5781, `version` = 3596 WHERE (`entry` = 5781);
-- Explorers' League Commendation
-- nature_res, from 0 to 2
-- spellid_1, from 0 to 5102
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `nature_res` = 2, `spellid_1` = 5102, `spelltrigger_1` = 1 WHERE (`entry` = 7746);
UPDATE `applied_item_updates` SET `entry` = 7746, `version` = 3596 WHERE (`entry` = 7746);
-- Divine Gauntlets
-- spellid_1, from 15807 to 9408
UPDATE `item_template` SET `spellid_1` = 9408 WHERE (`entry` = 7724);
UPDATE `applied_item_updates` SET `entry` = 7724, `version` = 3596 WHERE (`entry` = 7724);
-- Sword of Serenity
-- spellid_1, from 0 to 370
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `spellid_1` = 370, `spelltrigger_1` = 2 WHERE (`entry` = 6829);
UPDATE `applied_item_updates` SET `entry` = 6829, `version` = 3596 WHERE (`entry` = 6829);
-- Orb of the Forgotten Seer
-- spellid_1, from 9417 to 0
-- spelltrigger_1, from 1 to 0
-- sheath, from 7 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0, `sheath` = 0 WHERE (`entry` = 7685);
UPDATE `applied_item_updates` SET `entry` = 7685, `version` = 3596 WHERE (`entry` = 7685);
-- Turtle Shell Shield
-- stat_value1, from 1 to 0
UPDATE `item_template` SET `stat_value1` = 0 WHERE (`entry` = 6447);
UPDATE `applied_item_updates` SET `entry` = 6447, `version` = 3596 WHERE (`entry` = 6447);
-- Sage's Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3596 WHERE (`entry` = 6609);
-- Bleeding Crescent
-- spellid_1, from 16403 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6738);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6738, 3596);
-- Glimmering Mail Pauldrons
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 6388);
UPDATE `applied_item_updates` SET `entry` = 6388, `version` = 3596 WHERE (`entry` = 6388);
-- Polished Scale Vest
-- stat_type1, from 0 to 4
-- stat_value1, from 0 to 1
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3596 WHERE (`entry` = 2153);
-- Polished Scale Leggings
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
-- stat_value2, from 0 to 10
UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2152);
UPDATE `applied_item_updates` SET `entry` = 2152, `version` = 3596 WHERE (`entry` = 2152);
-- Polished Scale Gloves
-- stat_type1, from 0 to 3
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3596 WHERE (`entry` = 2151);
-- Minor Healthstone
-- spellid_1, from 6262 to 0
-- spellcategory_1, from 30 to 0
-- spellcategorycooldown_1, from 180000 to 0
-- spellid_2, from 0 to 6262
-- spellcategory_2, from 0 to 30
-- spellcategorycooldown_2, from 0 to 180000
UPDATE `item_template` SET `spellid_1` = 0, `spellcategory_1` = 0, `spellcategorycooldown_1` = 0, `spellid_2` = 6262, `spellcategory_2` = 30, `spellcategorycooldown_2` = 180000 WHERE (`entry` = 5512);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5512, 3596);
-- Darkweave Sash
-- stat_value3, from 0 to 5
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value3` = 5, `shadow_res` = 1 WHERE (`entry` = 4720);
UPDATE `applied_item_updates` SET `entry` = 4720, `version` = 3596 WHERE (`entry` = 4720);
-- Blighted Leggings
-- holy_res, from 0 to 1
-- spellid_1, from 7709 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7709);
UPDATE `applied_item_updates` SET `entry` = 7709, `version` = 3596 WHERE (`entry` = 7709);
-- Green Woolen Vest
-- stat_value1, from 2 to 0
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value1` = 0, `stat_value2` = 0 WHERE (`entry` = 2582);
UPDATE `applied_item_updates` SET `entry` = 2582, `version` = 3596 WHERE (`entry` = 2582);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3596 WHERE (`entry` = 3600);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3596 WHERE (`entry` = 2119);
-- Sharp Kitchen Knife
-- dmg_max1, from 10.0 to 9
UPDATE `item_template` SET `dmg_max1` = 9 WHERE (`entry` = 2225);
UPDATE `applied_item_updates` SET `entry` = 2225, `version` = 3596 WHERE (`entry` = 2225);
-- Regal Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7332);
UPDATE `applied_item_updates` SET `entry` = 7332, `version` = 3596 WHERE (`entry` = 7332);
-- Ring of Calm
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6790);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6790, 3596);
-- Umbral Sword
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6984);
UPDATE `applied_item_updates` SET `entry` = 6984, `version` = 3596 WHERE (`entry` = 6984);
-- Brightweave Bracers
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4043);
UPDATE `applied_item_updates` SET `entry` = 4043, `version` = 3596 WHERE (`entry` = 4043);
-- Cold Basilisk Eye
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 5079);
UPDATE `applied_item_updates` SET `entry` = 5079, `version` = 3596 WHERE (`entry` = 5079);
-- Black Whelp Cloak
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 7283);
UPDATE `applied_item_updates` SET `entry` = 7283, `version` = 3596 WHERE (`entry` = 7283);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
UPDATE `applied_item_updates` SET `entry` = 3342, `version` = 3596 WHERE (`entry` = 3342);
-- Rose Mantle
-- stat_value2, from 5 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5274);
UPDATE `applied_item_updates` SET `entry` = 5274, `version` = 3596 WHERE (`entry` = 5274);
-- Gold-flecked Gloves
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3596 WHERE (`entry` = 5195);
-- Cracked Leather Belt
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2122);
UPDATE `applied_item_updates` SET `entry` = 2122, `version` = 3596 WHERE (`entry` = 2122);
-- Buckler of the Seas
-- stat_value2, from 22 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1557);
UPDATE `applied_item_updates` SET `entry` = 1557, `version` = 3596 WHERE (`entry` = 1557);
-- Black Menace
-- spellid_1, from 13440 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6831);
UPDATE `applied_item_updates` SET `entry` = 6831, `version` = 3596 WHERE (`entry` = 6831);
-- Phalanx Breastplate
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7418);
UPDATE `applied_item_updates` SET `entry` = 7418, `version` = 3596 WHERE (`entry` = 7418);
-- Fire Hardened Coif
-- stat_type1, from 7 to 6
-- stat_value1, from 8 to 3
-- stat_type2, from 3 to 7
-- stat_value2, from 7 to 3
-- armor, from 173 to 44
UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 3, `stat_type2` = 7, `stat_value2` = 3, `armor` = 44 WHERE (`entry` = 6971);
UPDATE `applied_item_updates` SET `entry` = 6971, `version` = 3596 WHERE (`entry` = 6971);
-- Fire Hardened Hauberk
-- display_id, from 22480 to 13011
-- stat_value1, from 14 to 5
-- armor, from 226 to 71
UPDATE `item_template` SET `display_id` = 13011, `stat_value1` = 5, `armor` = 71 WHERE (`entry` = 6972);
UPDATE `applied_item_updates` SET `entry` = 6972, `version` = 3596 WHERE (`entry` = 6972);
-- Darkshire Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3596 WHERE (`entry` = 2906);
-- Haggard's Dagger
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6980);
UPDATE `applied_item_updates` SET `entry` = 6980, `version` = 3596 WHERE (`entry` = 6980);
-- Astral Knot Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7511);
UPDATE `applied_item_updates` SET `entry` = 7511, `version` = 3596 WHERE (`entry` = 7511);
-- Polar Gauntlets
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7606);
UPDATE `applied_item_updates` SET `entry` = 7606, `version` = 3596 WHERE (`entry` = 7606);
-- Wandering Boots
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3596 WHERE (`entry` = 6095);
-- Rod of the Sleepwalker
-- frost_res, from 0 to 2
UPDATE `item_template` SET `frost_res` = 2 WHERE (`entry` = 1155);
UPDATE `applied_item_updates` SET `entry` = 1155, `version` = 3596 WHERE (`entry` = 1155);
-- Shadow Claw
-- spellid_1, from 16409 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2912);
UPDATE `applied_item_updates` SET `entry` = 2912, `version` = 3596 WHERE (`entry` = 2912);
-- Seal of Wrynn
-- max_count, from 1 to 0
-- fire_res, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `fire_res` = 1 WHERE (`entry` = 2933);
UPDATE `applied_item_updates` SET `entry` = 2933, `version` = 3596 WHERE (`entry` = 2933);
-- Walking Boots
-- stat_type1, from 3 to 0
UPDATE `item_template` SET `stat_type1` = 0 WHERE (`entry` = 4660);
UPDATE `applied_item_updates` SET `entry` = 4660, `version` = 3596 WHERE (`entry` = 4660);
-- Prospector Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4980);
UPDATE `applied_item_updates` SET `entry` = 4980, `version` = 3596 WHERE (`entry` = 4980);
-- Sustaining Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6743);
UPDATE `applied_item_updates` SET `entry` = 6743, `version` = 3596 WHERE (`entry` = 6743);
-- Mantle of Thieves
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2264);
UPDATE `applied_item_updates` SET `entry` = 2264, `version` = 3596 WHERE (`entry` = 2264);
-- Chief Brigadier Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4078);
UPDATE `applied_item_updates` SET `entry` = 4078, `version` = 3596 WHERE (`entry` = 4078);
-- Grayson's Torch
-- armor, from 0 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3596 WHERE (`entry` = 1172);
-- Mud Stompers
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3596 WHERE (`entry` = 6188);
-- Bottle of Pinot Noir (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2723);
UPDATE `applied_item_updates` SET `entry` = 2723, `version` = 3596 WHERE (`entry` = 2723);
-- Gravestone Sceptre
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 7001);
UPDATE `applied_item_updates` SET `entry` = 7001, `version` = 3596 WHERE (`entry` = 7001);
-- Venom Web Fang
-- spellid_1, from 18077 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 899);
UPDATE `applied_item_updates` SET `entry` = 899, `version` = 3596 WHERE (`entry` = 899);
-- Chieftain Girdle
-- stat_value2, from 15 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5750);
UPDATE `applied_item_updates` SET `entry` = 5750, `version` = 3596 WHERE (`entry` = 5750);
-- Evergreen Gloves
-- display_id, from 16815 to 15865
-- stat_value1, from 3 to 1
-- armor, from 32 to 10
UPDATE `item_template` SET `display_id` = 15865, `stat_value1` = 1, `armor` = 10 WHERE (`entry` = 7738);
UPDATE `applied_item_updates` SET `entry` = 7738, `version` = 3596 WHERE (`entry` = 7738);
-- Beetle Clasps
-- stat_type1, from 7 to 4
-- stat_value1, from 5 to 1
-- stat_type2, from 3 to 1
-- stat_value2, from 2 to 5
-- armor, from 95 to 32
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5, `armor` = 32 WHERE (`entry` = 7003);
UPDATE `applied_item_updates` SET `entry` = 7003, `version` = 3596 WHERE (`entry` = 7003);
-- Black Husk Shield
-- stat_value2, from 0 to 5
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value2` = 5, `shadow_res` = 1 WHERE (`entry` = 4444);
UPDATE `applied_item_updates` SET `entry` = 4444, `version` = 3596 WHERE (`entry` = 4444);
-- Artisan's Trousers
-- stat_value2, from 3 to 0
-- stat_value3, from 48 to 0
UPDATE `item_template` SET `stat_value2` = 0, `stat_value3` = 0 WHERE (`entry` = 5016);
UPDATE `applied_item_updates` SET `entry` = 5016, `version` = 3596 WHERE (`entry` = 5016);
-- Darkweave Mantle
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3596 WHERE (`entry` = 4718);
-- Thornstone Sledgehammer
-- nature_res, from 10 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 1722);
UPDATE `applied_item_updates` SET `entry` = 1722, `version` = 3596 WHERE (`entry` = 1722);
-- Husk of Naraxis
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4448);
UPDATE `applied_item_updates` SET `entry` = 4448, `version` = 3596 WHERE (`entry` = 4448);
-- Shadow Weaver Leggings
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3596 WHERE (`entry` = 2233);
-- Elder's Robe
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7369);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7369, 3596);
-- Elder's Pants
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7368);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7368, 3596);
-- Silver Steel Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6966);
UPDATE `applied_item_updates` SET `entry` = 6966, `version` = 3596 WHERE (`entry` = 6966);
-- Green Carapace Shield
-- nature_res, from 4 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 2021);
UPDATE `applied_item_updates` SET `entry` = 2021, `version` = 3596 WHERE (`entry` = 2021);
-- Firebelcher
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 5243);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5243, 3596);
-- Grimclaw
-- spellid_1, from 13440 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 1481);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1481, 3596);
-- Welken Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5011);
UPDATE `applied_item_updates` SET `entry` = 5011, `version` = 3596 WHERE (`entry` = 5011);
-- Rabbit's Foot
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3300);
UPDATE `applied_item_updates` SET `entry` = 3300, `version` = 3596 WHERE (`entry` = 3300);
-- Threshadon Ambergris
-- item_level, from 10 to 1
UPDATE `item_template` SET `item_level` = 1 WHERE (`entry` = 2608);
UPDATE `applied_item_updates` SET `entry` = 2608, `version` = 3596 WHERE (`entry` = 2608);
-- Callous Axe
-- spellid_1, from 9139 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4825);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4825, 3596);
-- Heavy Club
-- name, from Heavy Hammer to Heavy Club
-- required_level, from 7 to 9
-- dmg_min1, from 6.0 to 5
-- dmg_max1, from 12.0 to 11
UPDATE `item_template` SET `name` = 'Heavy Club', `required_level` = 9, `dmg_min1` = 5, `dmg_max1` = 11 WHERE (`entry` = 1510);
UPDATE `applied_item_updates` SET `entry` = 1510, `version` = 3596 WHERE (`entry` = 1510);
-- Enchanted Stonecloth Bracers
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4979);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4979, 3596);
-- Frostweave Gloves
-- name, from Silver-thread Gloves to Frostweave Gloves
-- quality, from 2 to 1
-- buy_price, from 3803 to 3037
-- sell_price, from 760 to 607
-- item_level, from 28 to 31
-- required_level, from 23 to 26
-- stat_type1, from 3 to 6
-- stat_value1, from 5 to 1
-- stat_type2, from 5 to 4
-- stat_value2, from 5 to 1
-- armor, from 43 to 12
UPDATE `item_template` SET `name` = 'Frostweave Gloves', `quality` = 1, `buy_price` = 3037, `sell_price` = 607, `item_level` = 31, `required_level` = 26, `stat_type1` = 6, `stat_value1` = 1, `stat_type2` = 4, `stat_value2` = 1, `armor` = 12 WHERE (`entry` = 6393);
UPDATE `applied_item_updates` SET `entry` = 6393, `version` = 3596 WHERE (`entry` = 6393);
-- Black Malice
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 6.0 to 0
-- dmg_type2, from 5 to 0
-- spellid_1, from 695 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3194);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3194, 3596);
-- Juggernaut Leggings
-- sell_price, from 5170 to 2068
-- armor, from 165 to 56
-- holy_res, from 0 to 1
UPDATE `item_template` SET `sell_price` = 2068, `armor` = 56, `holy_res` = 1 WHERE (`entry` = 6671);
UPDATE `applied_item_updates` SET `entry` = 6671, `version` = 3596 WHERE (`entry` = 6671);
-- Band of Thorns
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5007);
UPDATE `applied_item_updates` SET `entry` = 5007, `version` = 3596 WHERE (`entry` = 5007);
-- Brightweave Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6415);
UPDATE `applied_item_updates` SET `entry` = 6415, `version` = 3596 WHERE (`entry` = 6415);
-- Chief Brigadier Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6411);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6411, 3596);
-- Twilight Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7430);
UPDATE `applied_item_updates` SET `entry` = 7430, `version` = 3596 WHERE (`entry` = 7430);
-- Sliverblade
-- spellid_1, from 18398 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5756);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5756, 3596);
-- Dried Seeds
-- spellid_1, from 5206 to 0
-- spellid_2, from 0 to 5206
UPDATE `item_template` SET `spellid_1` = 0, `spellid_2` = 5206 WHERE (`entry` = 5068);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5068, 3596);
-- Night Reaver
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 5.0 to 0
-- dmg_type2, from 5 to 0
-- spellid_1, from 695 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 1318);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1318, 3596);
-- Embalmed Shroud
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7691);
UPDATE `applied_item_updates` SET `entry` = 7691, `version` = 3596 WHERE (`entry` = 7691);
-- Elixir of Fortitude
-- name, from Elixir of Minor Fortitude to Elixir of Fortitude
UPDATE `item_template` SET `name` = 'Elixir of Fortitude' WHERE (`entry` = 2458);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2458, 3596);
-- Red Leather Bag
-- item_level, from 15 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 2657);
UPDATE `applied_item_updates` SET `entry` = 2657, `version` = 3596 WHERE (`entry` = 2657);
-- Sillithid Egg
-- name, from Silithid Egg to Sillithid Egg
UPDATE `item_template` SET `name` = 'Sillithid Egg' WHERE (`entry` = 5058);
UPDATE `applied_item_updates` SET `entry` = 5058, `version` = 3596 WHERE (`entry` = 5058);
-- Phalanx Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7423);
UPDATE `applied_item_updates` SET `entry` = 7423, `version` = 3596 WHERE (`entry` = 7423);
-- Morbid Dawn
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7689);
UPDATE `applied_item_updates` SET `entry` = 7689, `version` = 3596 WHERE (`entry` = 7689);
-- Servomechanic Sledgehammer
-- spellid_1, from 7560 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4548);
UPDATE `applied_item_updates` SET `entry` = 4548, `version` = 3596 WHERE (`entry` = 4548);
-- Beguiler Robes
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7728);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7728, 3596);
-- Captain's Breastplate
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7486);
UPDATE `applied_item_updates` SET `entry` = 7486, `version` = 3596 WHERE (`entry` = 7486);
-- Thick Cloth Pants
-- stat_type1, from 0 to 1
-- stat_value1, from 0 to 8
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 8 WHERE (`entry` = 201);
UPDATE `applied_item_updates` SET `entry` = 201, `version` = 3596 WHERE (`entry` = 201);
-- Frostweave Robe
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4035);
UPDATE `applied_item_updates` SET `entry` = 4035, `version` = 3596 WHERE (`entry` = 4035);
-- Cured Leather Pants
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 237);
UPDATE `applied_item_updates` SET `entry` = 237, `version` = 3596 WHERE (`entry` = 237);
-- Small Spider Limb
-- name, from Snapped Spider Limb to Small Spider Limb
-- quality, from 1 to 0
UPDATE `item_template` SET `name` = 'Small Spider Limb', `quality` = 0 WHERE (`entry` = 1476);
UPDATE `applied_item_updates` SET `entry` = 1476, `version` = 3596 WHERE (`entry` = 1476);
-- Sevren's Orders
-- page_language, from 0 to 7
UPDATE `item_template` SET `page_language` = 7 WHERE (`entry` = 3017);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3017, 3596);
-- Phoenix Pants
-- fire_res, from 0 to 2
-- spellid_1, from 7689 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 2, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4317);
UPDATE `applied_item_updates` SET `entry` = 4317, `version` = 3596 WHERE (`entry` = 4317);
-- Laced Mail Belt
-- armor, from 91 to 15
UPDATE `item_template` SET `armor` = 15 WHERE (`entry` = 1738);
UPDATE `applied_item_updates` SET `entry` = 1738, `version` = 3596 WHERE (`entry` = 1738);
-- Patched Leather Pants
-- armor, from 81 to 19
UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 1792);
UPDATE `applied_item_updates` SET `entry` = 1792, `version` = 3596 WHERE (`entry` = 1792);
-- Torturing Poker
-- dmg_min2, from 5.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 2 to 0
-- spellid_1, from 0 to 7711
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 7711, `spelltrigger_1` = 1 WHERE (`entry` = 7682);
UPDATE `applied_item_updates` SET `entry` = 7682, `version` = 3596 WHERE (`entry` = 7682);
-- Reinforced Targe
-- stat_value1, from 0 to 10
UPDATE `item_template` SET `stat_value1` = 10 WHERE (`entry` = 2442);
UPDATE `applied_item_updates` SET `entry` = 2442, `version` = 3596 WHERE (`entry` = 2442);
-- Rough-hewn Kodo Leggings
-- armor, from 28 to 17
UPDATE `item_template` SET `armor` = 17 WHERE (`entry` = 4970);
UPDATE `applied_item_updates` SET `entry` = 4970, `version` = 3596 WHERE (`entry` = 4970);
-- Polished Scale Boots
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3596 WHERE (`entry` = 2149);
-- Black Metal Shortsword
-- shadow_res, from 4 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 886);
UPDATE `applied_item_updates` SET `entry` = 886, `version` = 3596 WHERE (`entry` = 886);
-- Kite Shield
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2446);
UPDATE `applied_item_updates` SET `entry` = 2446, `version` = 3596 WHERE (`entry` = 2446);
-- Bloodspiller
-- spellid_1, from 18200 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 7753);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7753, 3596);
-- Rugged Leather Pants
-- buy_price, from 814 to 749
-- sell_price, from 162 to 149
-- stat_type1, from 7 to 1
-- stat_value1, from 1 to 4
-- armor, from 58 to 23
UPDATE `item_template` SET `buy_price` = 749, `sell_price` = 149, `stat_type1` = 1, `stat_value1` = 4, `armor` = 23 WHERE (`entry` = 7280);
UPDATE `applied_item_updates` SET `entry` = 7280, `version` = 3596 WHERE (`entry` = 7280);
-- Sporid Cape
-- stat_value2, from 20 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6629);
UPDATE `applied_item_updates` SET `entry` = 6629, `version` = 3596 WHERE (`entry` = 6629);
-- Brightweave Cowl
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 2
-- holy_res, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 2, `holy_res` = 1 WHERE (`entry` = 4041);
UPDATE `applied_item_updates` SET `entry` = 4041, `version` = 3596 WHERE (`entry` = 4041);
-- Frostweave Pants
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3596 WHERE (`entry` = 4037);
-- Explorer's Vest
-- stat_type1, from 7 to 1
-- stat_value1, from 2 to 5
-- armor, from 125 to 44
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `armor` = 44 WHERE (`entry` = 7229);
UPDATE `applied_item_updates` SET `entry` = 7229, `version` = 3596 WHERE (`entry` = 7229);
-- Haggard's Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3596 WHERE (`entry` = 6979);
-- Hard Crawler Carapace
-- stat_type2, from 7 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 2087);
UPDATE `applied_item_updates` SET `entry` = 2087, `version` = 3596 WHERE (`entry` = 2087);
-- Brightweave Cloak
-- frost_res, from 0 to 6
UPDATE `item_template` SET `frost_res` = 6 WHERE (`entry` = 6417);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6417, 3596);
-- Wyvern Tailspike
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5752);
UPDATE `applied_item_updates` SET `entry` = 5752, `version` = 3596 WHERE (`entry` = 5752);
-- Studded Boots
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 1 WHERE (`entry` = 2467);
UPDATE `applied_item_updates` SET `entry` = 2467, `version` = 3596 WHERE (`entry` = 2467);
-- Feeble Shortbow
-- required_level, from 8 to 10
-- dmg_min1, from 4.0 to 6
-- dmg_max1, from 8.0 to 12
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 2777);
UPDATE `applied_item_updates` SET `entry` = 2777, `version` = 3596 WHERE (`entry` = 2777);
-- Tempered Bracers
-- stat_type2, from 7 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 6675);
UPDATE `applied_item_updates` SET `entry` = 6675, `version` = 3596 WHERE (`entry` = 6675);
-- Resplendent Guardian
-- spellid_1, from 13674 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7787);
UPDATE `applied_item_updates` SET `entry` = 7787, `version` = 3596 WHERE (`entry` = 7787);
-- Huge Brown Sack
-- sell_price, from 50000 to 25000
UPDATE `item_template` SET `sell_price` = 25000 WHERE (`entry` = 4499);
UPDATE `applied_item_updates` SET `entry` = 4499, `version` = 3596 WHERE (`entry` = 4499);
-- Duskbringer
-- holy_res, from 0 to 1
-- spellid_1, from 18217 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2205);
UPDATE `applied_item_updates` SET `entry` = 2205, `version` = 3596 WHERE (`entry` = 2205);
-- Orb of Soran'ruk
-- spellid_2, from 7706 to 0
-- spelltrigger_2, from 1 to 0
-- spellid_3, from 18956 to 0
-- spellcategory_3, from 30 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0, `spellid_3` = 0, `spellcategory_3` = 0 WHERE (`entry` = 6898);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6898, 3596);
-- Heavy Recurve Bow
-- required_level, from 20 to 22
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 29.0 to 43
UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 23, `dmg_max1` = 43 WHERE (`entry` = 3027);
UPDATE `applied_item_updates` SET `entry` = 3027, `version` = 3596 WHERE (`entry` = 3027);
-- Beastial Manacles
-- stat_value2, from 30 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6722);
UPDATE `applied_item_updates` SET `entry` = 6722, `version` = 3596 WHERE (`entry` = 6722);
-- Buzzer Blade
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 2169);
UPDATE `applied_item_updates` SET `entry` = 2169, `version` = 3596 WHERE (`entry` = 2169);
-- Whirlwind Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6975);
UPDATE `applied_item_updates` SET `entry` = 6975, `version` = 3596 WHERE (`entry` = 6975);
-- Umbral Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3596 WHERE (`entry` = 6978);
-- Crimson Silk Cloak
-- fire_res, from 20 to 6
UPDATE `item_template` SET `fire_res` = 6 WHERE (`entry` = 7056);
UPDATE `applied_item_updates` SET `entry` = 7056, `version` = 3596 WHERE (`entry` = 7056);
-- Bite of Serra'kis
-- spellid_1, from 8313 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6904);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6904, 3596);
-- Fire Hardened Gauntlets
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6974);
UPDATE `applied_item_updates` SET `entry` = 6974, `version` = 3596 WHERE (`entry` = 6974);
-- Silver Steel Sword
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6967);
UPDATE `applied_item_updates` SET `entry` = 6967, `version` = 3596 WHERE (`entry` = 6967);
-- Spider Belt
-- spellid_1, from 9774 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 4328);
UPDATE `applied_item_updates` SET `entry` = 4328, `version` = 3596 WHERE (`entry` = 4328);
-- Fire Hardened Buckler
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 1276);
UPDATE `applied_item_updates` SET `entry` = 1276, `version` = 3596 WHERE (`entry` = 1276);
-- Fire Hardened Leggings
-- max_count, from 1 to 0
-- stat_value3, from 40 to 0
UPDATE `item_template` SET `max_count` = 0, `stat_value3` = 0 WHERE (`entry` = 6973);
UPDATE `applied_item_updates` SET `entry` = 6973, `version` = 3596 WHERE (`entry` = 6973);
-- Azure Silk Cloak
-- frost_res, from 0 to 6
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 6, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7053);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7053, 3596);
-- Scarab Trousers
-- stat_value3, from 1 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3596 WHERE (`entry` = 6659);
-- Webwood Egg
-- display_id, from 18047 to 13663
UPDATE `item_template` SET `display_id` = 13663 WHERE (`entry` = 5167);
UPDATE `applied_item_updates` SET `entry` = 5167, `version` = 3596 WHERE (`entry` = 5167);
-- Small Egg
-- display_id, from 18046 to 13211
UPDATE `item_template` SET `display_id` = 13211 WHERE (`entry` = 6889);
UPDATE `applied_item_updates` SET `entry` = 6889, `version` = 3596 WHERE (`entry` = 6889);
-- Forest Chain
-- stat_value2, from 10 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3596 WHERE (`entry` = 1273);
-- Serpent's Kiss
-- spellid_1, from 18197 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5426);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5426, 3596);
-- Swampchill Fetish
-- frost_res, from 5 to 0
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `frost_res` = 0, `shadow_res` = 0 WHERE (`entry` = 1992);
UPDATE `applied_item_updates` SET `entry` = 1992, `version` = 3596 WHERE (`entry` = 1992);
-- Cuirboulli Belt
-- stat_type1, from 0 to 1
-- stat_value1, from 0 to 5
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 2142);
UPDATE `applied_item_updates` SET `entry` = 2142, `version` = 3596 WHERE (`entry` = 2142);
-- Blackvenom Blade
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 5 to 0
-- spellid_1, from 13518 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4446);
UPDATE `applied_item_updates` SET `entry` = 4446, `version` = 3596 WHERE (`entry` = 4446);
-- Blood-tinged Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4508);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4508, 3596);
-- Guardian Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 5965);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5965, 3596);
-- Ghoulfang
-- spellid_1, from 16409 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 1387);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1387, 3596);
-- Ring of Precision
-- spellid_1, from 0 to 7598
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `spellid_1` = 7598, `spelltrigger_1` = 1 WHERE (`entry` = 1491);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1491, 3596);
-- Wolfpack Medallion
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3596 WHERE (`entry` = 5754);
-- Message in a Bottle
-- start_quest, from 0 to 594
UPDATE `item_template` SET `start_quest` = 594 WHERE (`entry` = 6307);
UPDATE `applied_item_updates` SET `entry` = 6307, `version` = 3596 WHERE (`entry` = 6307);
-- Kingsblood
-- name, from Crownroyal to Kingsblood
UPDATE `item_template` SET `name` = 'Kingsblood' WHERE (`entry` = 3356);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3356, 3596);
-- Bolt of Wool Cloth
-- name, from Bolt of Woolen Cloth to Bolt of Wool Cloth
UPDATE `item_template` SET `name` = 'Bolt of Wool Cloth' WHERE (`entry` = 2997);
UPDATE `applied_item_updates` SET `entry` = 2997, `version` = 3596 WHERE (`entry` = 2997);
-- Syndicate Missive
-- page_language, from 0 to 7
UPDATE `item_template` SET `page_language` = 7 WHERE (`entry` = 3601);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3601, 3596);
-- Headchopper
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 1680);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1680, 3596);
-- Rock Pulverizer
-- spellid_1, from 15806 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4983);
UPDATE `applied_item_updates` SET `entry` = 4983, `version` = 3596 WHERE (`entry` = 4983);
-- Cloak of Blight
-- shadow_res, from 0 to 2
UPDATE `item_template` SET `shadow_res` = 2 WHERE (`entry` = 6832);
UPDATE `applied_item_updates` SET `entry` = 6832, `version` = 3596 WHERE (`entry` = 6832);
-- Silver Steel Dagger
-- name, from Elunite Dagger to Silver Steel Dagger
-- dmg_min1, from 9.0 to 7
-- dmg_max1, from 17.0 to 15
UPDATE `item_template` SET `name` = 'Silver Steel Dagger', `dmg_min1` = 7, `dmg_max1` = 15 WHERE (`entry` = 6969);
UPDATE `applied_item_updates` SET `entry` = 6969, `version` = 3596 WHERE (`entry` = 6969);
-- Gut Ripper
-- spellid_1, from 18107 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2164);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2164, 3596);
-- Barbaric Belt
-- stat_value1, from 2 to 0
-- stat_value2, from 40 to 0
UPDATE `item_template` SET `stat_value1` = 0, `stat_value2` = 0 WHERE (`entry` = 4264);
UPDATE `applied_item_updates` SET `entry` = 4264, `version` = 3596 WHERE (`entry` = 4264);
-- Windweaver Staff
-- spellid_1, from 13599 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7757);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7757, 3596);
-- Heavy Linen Bandage
-- flags, from 0 to 64
UPDATE `item_template` SET `flags` = 64 WHERE (`entry` = 2581);
UPDATE `applied_item_updates` SET `entry` = 2581, `version` = 3596 WHERE (`entry` = 2581);
-- Noble's Robe
-- stat_value2, from 20 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 3019);
UPDATE `applied_item_updates` SET `entry` = 3019, `version` = 3596 WHERE (`entry` = 3019);
-- Frost Tiger Blade
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
-- spellid_2, from 13439 to 0
-- spelltrigger_2, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0, `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 3854);
UPDATE `applied_item_updates` SET `entry` = 3854, `version` = 3596 WHERE (`entry` = 3854);
-- Prelacy Cape
-- stat_value1, from 5 to 1
-- armor, from 33 to 16
UPDATE `item_template` SET `stat_value1` = 1, `armor` = 16 WHERE (`entry` = 7004);
UPDATE `applied_item_updates` SET `entry` = 7004, `version` = 3596 WHERE (`entry` = 7004);
-- Embroidered Hat
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 4
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 4 WHERE (`entry` = 3892);
UPDATE `applied_item_updates` SET `entry` = 3892, `version` = 3596 WHERE (`entry` = 3892);
-- Light Leather Quiver
-- item_level, from 5 to 1
-- container_slots, from 8 to 4
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `item_level` = 1, `container_slots` = 4, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7278);
UPDATE `applied_item_updates` SET `entry` = 7278, `version` = 3596 WHERE (`entry` = 7278);
-- Small Leather Ammo Pouch
-- item_level, from 5 to 1
-- container_slots, from 8 to 4
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `item_level` = 1, `container_slots` = 4, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7279);
UPDATE `applied_item_updates` SET `entry` = 7279, `version` = 3596 WHERE (`entry` = 7279);
-- Fletcher's Gloves
-- spellid_2, from 21352 to 0
-- spelltrigger_2, from 1 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 7348);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7348, 3596);
-- Heavy Leather Ammo Pouch
-- spellid_1, from 14826 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7372);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7372, 3596);
-- Heavy Quiver
-- spellid_1, from 14826 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7371);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7371, 3596);
-- Staff of the Shade
-- stat_value1, from 3 to 0
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value1` = 0, `shadow_res` = 1 WHERE (`entry` = 2549);
UPDATE `applied_item_updates` SET `entry` = 2549, `version` = 3596 WHERE (`entry` = 2549);
-- Bear Buckler
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 4821);
UPDATE `applied_item_updates` SET `entry` = 4821, `version` = 3596 WHERE (`entry` = 4821);
-- Green Silken Shoulders
-- nature_res, from 0 to 6
UPDATE `item_template` SET `nature_res` = 6 WHERE (`entry` = 7057);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7057, 3596);
-- Recruit's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6121);
UPDATE `applied_item_updates` SET `entry` = 6121, `version` = 3596 WHERE (`entry` = 6121);
-- Novice's Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6123);
UPDATE `applied_item_updates` SET `entry` = 6123, `version` = 3596 WHERE (`entry` = 6123);
-- Woodland Tunic
-- armor, from 30 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 4907);
UPDATE `applied_item_updates` SET `entry` = 4907, `version` = 3596 WHERE (`entry` = 4907);
-- Novice's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6124);
UPDATE `applied_item_updates` SET `entry` = 6124, `version` = 3596 WHERE (`entry` = 6124);
-- Ruined Pelt
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 4865);
UPDATE `applied_item_updates` SET `entry` = 4865, `version` = 3596 WHERE (`entry` = 4865);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3596 WHERE (`entry` = 3600);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3596 WHERE (`entry` = 2119);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3596 WHERE (`entry` = 48);
-- Woodland Shield
-- armor, from 38 to 19
UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 5395);
UPDATE `applied_item_updates` SET `entry` = 5395, `version` = 3596 WHERE (`entry` = 5395);
-- Cracked Leather Belt
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2122);
UPDATE `applied_item_updates` SET `entry` = 2122, `version` = 3596 WHERE (`entry` = 2122);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3596 WHERE (`entry` = 3363);
-- Neophyte's Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 6119);
UPDATE `applied_item_updates` SET `entry` = 6119, `version` = 3596 WHERE (`entry` = 6119);
-- Neophyte's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 52);
UPDATE `applied_item_updates` SET `entry` = 52, `version` = 3596 WHERE (`entry` = 52);
-- Heavy Recurve Bow
-- required_level, from 20 to 22
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 29.0 to 43
UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 23, `dmg_max1` = 43 WHERE (`entry` = 3027);
UPDATE `applied_item_updates` SET `entry` = 3027, `version` = 3596 WHERE (`entry` = 3027);
-- Pioneer Buckler
-- subclass, from 6 to 5
-- buy_price, from 984 to 639
-- sell_price, from 196 to 127
-- item_level, from 13 to 12
-- required_level, from 8 to 7
-- armor, from 176 to 28
UPDATE `item_template` SET `subclass` = 5, `buy_price` = 639, `sell_price` = 127, `item_level` = 12, `required_level` = 7, `armor` = 28 WHERE (`entry` = 7109);
UPDATE `applied_item_updates` SET `entry` = 7109, `version` = 3596 WHERE (`entry` = 7109);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3596 WHERE (`entry` = 4496);
-- Handstitched Leather Bracers
-- armor, from 18 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 7277);
UPDATE `applied_item_updates` SET `entry` = 7277, `version` = 3596 WHERE (`entry` = 7277);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3596 WHERE (`entry` = 4344);
-- Disciple's Bracers
-- display_id, from 16566 to 14705
-- buy_price, from 148 to 240
-- sell_price, from 29 to 48
-- item_level, from 10 to 12
-- required_level, from 5 to 7
-- armor, from 13 to 6
UPDATE `item_template` SET `display_id` = 14705, `buy_price` = 240, `sell_price` = 48, `item_level` = 12, `required_level` = 7, `armor` = 6 WHERE (`entry` = 7350);
UPDATE `applied_item_updates` SET `entry` = 7350, `version` = 3596 WHERE (`entry` = 7350);
-- Small Egg
-- display_id, from 18046 to 13211
UPDATE `item_template` SET `display_id` = 13211 WHERE (`entry` = 6889);
UPDATE `applied_item_updates` SET `entry` = 6889, `version` = 3596 WHERE (`entry` = 6889);
-- Frayed Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1378);
UPDATE `applied_item_updates` SET `entry` = 1378, `version` = 3596 WHERE (`entry` = 1378);
-- Small Spider Limb
-- name, from Snapped Spider Limb to Small Spider Limb
-- quality, from 1 to 0
UPDATE `item_template` SET `name` = 'Small Spider Limb', `quality` = 0 WHERE (`entry` = 1476);
UPDATE `applied_item_updates` SET `entry` = 1476, `version` = 3596 WHERE (`entry` = 1476);
-- Ruffled Feather
-- buy_price, from 165 to 215
-- sell_price, from 41 to 53
UPDATE `item_template` SET `buy_price` = 215, `sell_price` = 53 WHERE (`entry` = 4776);
UPDATE `applied_item_updates` SET `entry` = 4776, `version` = 3596 WHERE (`entry` = 4776);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3596 WHERE (`entry` = 1366);
-- Cerulean Talisman
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7427);
UPDATE `applied_item_updates` SET `entry` = 7427, `version` = 3596 WHERE (`entry` = 7427);
-- Astral Knot Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7511);
UPDATE `applied_item_updates` SET `entry` = 7511, `version` = 3596 WHERE (`entry` = 7511);
-- Evergreen Gloves
-- display_id, from 16815 to 15865
-- stat_value1, from 3 to 1
-- armor, from 32 to 10
UPDATE `item_template` SET `display_id` = 15865, `stat_value1` = 1, `armor` = 10 WHERE (`entry` = 7738);
UPDATE `applied_item_updates` SET `entry` = 7738, `version` = 3596 WHERE (`entry` = 7738);
-- Light Leather Bracers
-- armor, from 34 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 7281);
UPDATE `applied_item_updates` SET `entry` = 7281, `version` = 3596 WHERE (`entry` = 7281);
-- Rugged Leather Pants
-- buy_price, from 814 to 749
-- sell_price, from 162 to 149
-- stat_type1, from 7 to 1
-- stat_value1, from 1 to 4
-- armor, from 58 to 23
UPDATE `item_template` SET `buy_price` = 749, `sell_price` = 149, `stat_type1` = 1, `stat_value1` = 4, `armor` = 23 WHERE (`entry` = 7280);
UPDATE `applied_item_updates` SET `entry` = 7280, `version` = 3596 WHERE (`entry` = 7280);
-- Ivory Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7497);
UPDATE `applied_item_updates` SET `entry` = 7497, `version` = 3596 WHERE (`entry` = 7497);
-- Aegis of the Scarlet Commander
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 7726);
UPDATE `applied_item_updates` SET `entry` = 7726, `version` = 3596 WHERE (`entry` = 7726);
-- Berserker Helm
-- fire_res, from 0 to 1
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7719);
UPDATE `applied_item_updates` SET `entry` = 7719, `version` = 3596 WHERE (`entry` = 7719);
-- Explorers' League Commendation
-- nature_res, from 0 to 2
-- spellid_1, from 0 to 5102
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `nature_res` = 2, `spellid_1` = 5102, `spelltrigger_1` = 1 WHERE (`entry` = 7746);
UPDATE `applied_item_updates` SET `entry` = 7746, `version` = 3596 WHERE (`entry` = 7746);
-- Twilight Belt
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7438);
UPDATE `applied_item_updates` SET `entry` = 7438, `version` = 3596 WHERE (`entry` = 7438);
-- Elder's Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7356);
UPDATE `applied_item_updates` SET `entry` = 7356, `version` = 3596 WHERE (`entry` = 7356);
-- Frostweave Pants
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3596 WHERE (`entry` = 4037);
-- Scorpion Sting
-- spellid_1, from 18208 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1265);
UPDATE `applied_item_updates` SET `entry` = 1265, `version` = 3596 WHERE (`entry` = 1265);
-- Elder's Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7355);
UPDATE `applied_item_updates` SET `entry` = 7355, `version` = 3596 WHERE (`entry` = 7355);
-- Wolfpack Medallion
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3596 WHERE (`entry` = 5754);
-- Forest Tracker Epaulets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3596 WHERE (`entry` = 2278);
-- Fine Leather Gloves
-- stat_value1, from 0 to 5
UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 2312);
UPDATE `applied_item_updates` SET `entry` = 2312, `version` = 3596 WHERE (`entry` = 2312);
-- Light Leather Pants
-- buy_price, from 2998 to 2950
-- sell_price, from 599 to 590
-- stat_value1, from 5 to 1
-- armor, from 95 to 31
UPDATE `item_template` SET `buy_price` = 2950, `sell_price` = 590, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 7282);
UPDATE `applied_item_updates` SET `entry` = 7282, `version` = 3596 WHERE (`entry` = 7282);
-- Bounty Hunter's Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5351);
UPDATE `applied_item_updates` SET `entry` = 5351, `version` = 3596 WHERE (`entry` = 5351);
-- Journeyman Quarterstaff
-- dmg_min1, from 28.0 to 18
-- dmg_max1, from 39.0 to 27
UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 854);
UPDATE `applied_item_updates` SET `entry` = 854, `version` = 3596 WHERE (`entry` = 854);
-- Silver Steel Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6966);
UPDATE `applied_item_updates` SET `entry` = 6966, `version` = 3596 WHERE (`entry` = 6966);
-- Husk of Naraxis
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4448);
UPDATE `applied_item_updates` SET `entry` = 4448, `version` = 3596 WHERE (`entry` = 4448);
-- Polished Scale Vest
-- stat_type1, from 0 to 4
-- stat_value1, from 0 to 1
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3596 WHERE (`entry` = 2153);
-- Polished Scale Leggings
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
-- stat_value2, from 0 to 10
UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2152);
UPDATE `applied_item_updates` SET `entry` = 2152, `version` = 3596 WHERE (`entry` = 2152);
-- Polished Scale Boots
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3596 WHERE (`entry` = 2149);
-- Polished Scale Gloves
-- stat_type1, from 0 to 3
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3596 WHERE (`entry` = 2151);
-- Reinforced Targe
-- stat_value1, from 0 to 10
UPDATE `item_template` SET `stat_value1` = 10 WHERE (`entry` = 2442);
UPDATE `applied_item_updates` SET `entry` = 2442, `version` = 3596 WHERE (`entry` = 2442);
-- Kite Shield
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2446);
UPDATE `applied_item_updates` SET `entry` = 2446, `version` = 3596 WHERE (`entry` = 2446);
-- Glorious Shoulders
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3596 WHERE (`entry` = 4833);
-- Silver Steel Sword
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6967);
UPDATE `applied_item_updates` SET `entry` = 6967, `version` = 3596 WHERE (`entry` = 6967);
-- Scarab Trousers
-- stat_value3, from 1 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3596 WHERE (`entry` = 6659);
-- Explorer's Vest
-- stat_type1, from 7 to 1
-- stat_value1, from 2 to 5
-- armor, from 125 to 44
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `armor` = 44 WHERE (`entry` = 7229);
UPDATE `applied_item_updates` SET `entry` = 7229, `version` = 3596 WHERE (`entry` = 7229);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
UPDATE `applied_item_updates` SET `entry` = 3342, `version` = 3596 WHERE (`entry` = 3342);
-- Dark Leather Tunic
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3596 WHERE (`entry` = 2317);
-- Sustaining Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6743);
UPDATE `applied_item_updates` SET `entry` = 6743, `version` = 3596 WHERE (`entry` = 6743);
-- Enchanted Moonstalker Cloak
-- buy_price, from 2115 to 0
-- sell_price, from 423 to 0
UPDATE `item_template` SET `buy_price` = 0, `sell_price` = 0 WHERE (`entry` = 5387);
UPDATE `applied_item_updates` SET `entry` = 5387, `version` = 3596 WHERE (`entry` = 5387);
-- Grayson's Torch
-- armor, from 0 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3596 WHERE (`entry` = 1172);
-- Willow Branch
-- item_level, from 19 to 16
-- required_level, from 14 to 11
UPDATE `item_template` SET `item_level` = 16, `required_level` = 11 WHERE (`entry` = 7554);
UPDATE `applied_item_updates` SET `entry` = 7554, `version` = 3596 WHERE (`entry` = 7554);
-- Vermilion Necklace
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7467);
UPDATE `applied_item_updates` SET `entry` = 7467, `version` = 3596 WHERE (`entry` = 7467);
-- Rod of the Sleepwalker
-- frost_res, from 0 to 2
UPDATE `item_template` SET `frost_res` = 2 WHERE (`entry` = 1155);
UPDATE `applied_item_updates` SET `entry` = 1155, `version` = 3596 WHERE (`entry` = 1155);
-- Shadow Weaver Leggings
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3596 WHERE (`entry` = 2233);
-- Flameweave Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3596 WHERE (`entry` = 6608);
-- Regal Wizard Hat
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7470);
UPDATE `applied_item_updates` SET `entry` = 7470, `version` = 3596 WHERE (`entry` = 7470);
-- Silvered Bronze Breastplate
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3596 WHERE (`entry` = 2869);
-- Polar Gauntlets
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7606);
UPDATE `applied_item_updates` SET `entry` = 7606, `version` = 3596 WHERE (`entry` = 7606);
-- Scaber Stalk
-- display_id, from 19488 to 15857
UPDATE `item_template` SET `display_id` = 15857 WHERE (`entry` = 5271);
UPDATE `applied_item_updates` SET `entry` = 5271, `version` = 3596 WHERE (`entry` = 5271);
-- Cured Leather Pants
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 237);
UPDATE `applied_item_updates` SET `entry` = 237, `version` = 3596 WHERE (`entry` = 237);
-- Forest Chain
-- stat_value2, from 10 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3596 WHERE (`entry` = 1273);
-- Mud Stompers
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3596 WHERE (`entry` = 6188);
-- Holy Shroud
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3596 WHERE (`entry` = 2721);
-- Sentinel Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 7443);
UPDATE `applied_item_updates` SET `entry` = 7443, `version` = 3596 WHERE (`entry` = 7443);
-- Seal of Wrynn
-- max_count, from 1 to 0
-- fire_res, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `fire_res` = 1 WHERE (`entry` = 2933);
UPDATE `applied_item_updates` SET `entry` = 2933, `version` = 3596 WHERE (`entry` = 2933);
-- Small Quiver
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5439);
UPDATE `applied_item_updates` SET `entry` = 5439, `version` = 3596 WHERE (`entry` = 5439);
-- Gold-flecked Gloves
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3596 WHERE (`entry` = 5195);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3596 WHERE (`entry` = 1377);
-- Haggard's Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3596 WHERE (`entry` = 6979);
-- Wolf Handler Gloves
-- buy_price, from 32 to 21
-- sell_price, from 6 to 4
-- item_level, from 5 to 4
-- armor, from 19 to 5
UPDATE `item_template` SET `buy_price` = 21, `sell_price` = 4, `item_level` = 4, `armor` = 5 WHERE (`entry` = 6171);
UPDATE `applied_item_updates` SET `entry` = 6171, `version` = 3596 WHERE (`entry` = 6171);
-- Haggard's Dagger
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6980);
UPDATE `applied_item_updates` SET `entry` = 6980, `version` = 3596 WHERE (`entry` = 6980);
-- Umbral Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3596 WHERE (`entry` = 6978);
-- Sage's Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3596 WHERE (`entry` = 6609);
-- Azure Silk Pants
-- frost_res, from 0 to 1
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7046);
UPDATE `applied_item_updates` SET `entry` = 7046, `version` = 3596 WHERE (`entry` = 7046);
-- Fire Hardened Hauberk
-- display_id, from 22480 to 13011
-- stat_value1, from 14 to 5
-- armor, from 226 to 71
UPDATE `item_template` SET `display_id` = 13011, `stat_value1` = 5, `armor` = 71 WHERE (`entry` = 6972);
UPDATE `applied_item_updates` SET `entry` = 6972, `version` = 3596 WHERE (`entry` = 6972);
-- Divine Gauntlets
-- spellid_1, from 15807 to 9408
UPDATE `item_template` SET `spellid_1` = 9408 WHERE (`entry` = 7724);
UPDATE `applied_item_updates` SET `entry` = 7724, `version` = 3596 WHERE (`entry` = 7724);
-- Lesser Staff of the Spire
-- stat_value2, from 3 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1300);
UPDATE `applied_item_updates` SET `entry` = 1300, `version` = 3596 WHERE (`entry` = 1300);
-- Rabbit's Foot
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3300);
UPDATE `applied_item_updates` SET `entry` = 3300, `version` = 3596 WHERE (`entry` = 3300);
-- Buckler of the Seas
-- stat_value2, from 22 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1557);
UPDATE `applied_item_updates` SET `entry` = 1557, `version` = 3596 WHERE (`entry` = 1557);
-- Regal Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7468);
UPDATE `applied_item_updates` SET `entry` = 7468, `version` = 3596 WHERE (`entry` = 7468);
-- Darkweave Sash
-- stat_value3, from 0 to 5
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value3` = 5, `shadow_res` = 1 WHERE (`entry` = 4720);
UPDATE `applied_item_updates` SET `entry` = 4720, `version` = 3596 WHERE (`entry` = 4720);
-- Regal Cloak
-- frost_res, from 0 to 6
UPDATE `item_template` SET `frost_res` = 6 WHERE (`entry` = 7474);
UPDATE `applied_item_updates` SET `entry` = 7474, `version` = 3596 WHERE (`entry` = 7474);
-- Sword of Serenity
-- spellid_1, from 0 to 370
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `spellid_1` = 370, `spelltrigger_1` = 2 WHERE (`entry` = 6829);
UPDATE `applied_item_updates` SET `entry` = 6829, `version` = 3596 WHERE (`entry` = 6829);
-- Orb of the Forgotten Seer
-- spellid_1, from 9417 to 0
-- spelltrigger_1, from 1 to 0
-- sheath, from 7 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0, `sheath` = 0 WHERE (`entry` = 7685);
UPDATE `applied_item_updates` SET `entry` = 7685, `version` = 3596 WHERE (`entry` = 7685);
-- Fractured Canine
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3299);
UPDATE `applied_item_updates` SET `entry` = 3299, `version` = 3596 WHERE (`entry` = 3299);
-- Phalanx Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7419);
UPDATE `applied_item_updates` SET `entry` = 7419, `version` = 3596 WHERE (`entry` = 7419);
-- Small Bear Tooth
-- name, from Chipped Bear Tooth to Small Bear Tooth
-- buy_price, from 75 to 135
-- sell_price, from 18 to 33
UPDATE `item_template` SET `name` = 'Small Bear Tooth', `buy_price` = 135, `sell_price` = 33 WHERE (`entry` = 3169);
UPDATE `applied_item_updates` SET `entry` = 3169, `version` = 3596 WHERE (`entry` = 3169);
-- Bishop's Miter
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7720);
UPDATE `applied_item_updates` SET `entry` = 7720, `version` = 3596 WHERE (`entry` = 7720);
-- Frostweave Robe
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4035);
UPDATE `applied_item_updates` SET `entry` = 4035, `version` = 3596 WHERE (`entry` = 4035);
-- Twilight Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7436);
UPDATE `applied_item_updates` SET `entry` = 7436, `version` = 3596 WHERE (`entry` = 7436);
-- Darkweave Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3596 WHERE (`entry` = 4039);
-- Ogremind Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 1993);
UPDATE `applied_item_updates` SET `entry` = 1993, `version` = 3596 WHERE (`entry` = 1993);
-- Message in a Bottle
-- start_quest, from 0 to 594
UPDATE `item_template` SET `start_quest` = 594 WHERE (`entry` = 6307);
UPDATE `applied_item_updates` SET `entry` = 6307, `version` = 3596 WHERE (`entry` = 6307);
-- Thornstone Sledgehammer
-- nature_res, from 10 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 1722);
UPDATE `applied_item_updates` SET `entry` = 1722, `version` = 3596 WHERE (`entry` = 1722);
-- Heart Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5001);
UPDATE `applied_item_updates` SET `entry` = 5001, `version` = 3596 WHERE (`entry` = 5001);
-- Torturing Poker
-- dmg_min2, from 5.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 2 to 0
-- spellid_1, from 0 to 7711
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 7711, `spelltrigger_1` = 1 WHERE (`entry` = 7682);
UPDATE `applied_item_updates` SET `entry` = 7682, `version` = 3596 WHERE (`entry` = 7682);
-- Phalanx Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7423);
UPDATE `applied_item_updates` SET `entry` = 7423, `version` = 3596 WHERE (`entry` = 7423);
-- Acolyte's Pants
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1396);
UPDATE `applied_item_updates` SET `entry` = 1396, `version` = 3596 WHERE (`entry` = 1396);
-- Sliverblade
-- spellid_1, from 18398 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5756);
UPDATE `applied_item_updates` SET `entry` = 5756, `version` = 3596 WHERE (`entry` = 5756);
-- Cold Basilisk Eye
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 5079);
UPDATE `applied_item_updates` SET `entry` = 5079, `version` = 3596 WHERE (`entry` = 5079);
-- Blazing Emblem
-- fire_res, from 15 to 0
UPDATE `item_template` SET `fire_res` = 0 WHERE (`entry` = 2802);
UPDATE `applied_item_updates` SET `entry` = 2802, `version` = 3596 WHERE (`entry` = 2802);
-- Wandering Boots
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3596 WHERE (`entry` = 6095);
-- Slime Encrusted Pads
-- spellid_1, from 18764 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6461);
UPDATE `applied_item_updates` SET `entry` = 6461, `version` = 3596 WHERE (`entry` = 6461);
-- Black Menace
-- spellid_1, from 13440 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6831);
UPDATE `applied_item_updates` SET `entry` = 6831, `version` = 3596 WHERE (`entry` = 6831);
-- Regal Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7332);
UPDATE `applied_item_updates` SET `entry` = 7332, `version` = 3596 WHERE (`entry` = 7332);
-- Scorching Sash
-- spellid_1, from 9400 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4117);
UPDATE `applied_item_updates` SET `entry` = 4117, `version` = 3596 WHERE (`entry` = 4117);
-- Regal Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7469);
UPDATE `applied_item_updates` SET `entry` = 7469, `version` = 3596 WHERE (`entry` = 7469);
-- Brightweave Bracers
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4043);
UPDATE `applied_item_updates` SET `entry` = 4043, `version` = 3596 WHERE (`entry` = 4043);
-- Glimmering Mail Pauldrons
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 6388);
UPDATE `applied_item_updates` SET `entry` = 6388, `version` = 3596 WHERE (`entry` = 6388);
-- Darkshire Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3596 WHERE (`entry` = 2906);
-- Black Metal Shortsword
-- shadow_res, from 4 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 886);
UPDATE `applied_item_updates` SET `entry` = 886, `version` = 3596 WHERE (`entry` = 886);
-- Black Husk Shield
-- stat_value2, from 0 to 5
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value2` = 5, `shadow_res` = 1 WHERE (`entry` = 4444);
UPDATE `applied_item_updates` SET `entry` = 4444, `version` = 3596 WHERE (`entry` = 4444);
-- Walking Boots
-- stat_type1, from 3 to 0
UPDATE `item_template` SET `stat_type1` = 0 WHERE (`entry` = 4660);
UPDATE `applied_item_updates` SET `entry` = 4660, `version` = 3596 WHERE (`entry` = 4660);
-- Welken Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5011);
UPDATE `applied_item_updates` SET `entry` = 5011, `version` = 3596 WHERE (`entry` = 5011);
-- Frostweave Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4713);
UPDATE `applied_item_updates` SET `entry` = 4713, `version` = 3596 WHERE (`entry` = 4713);
-- Resplendent Guardian
-- spellid_1, from 13674 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7787);
UPDATE `applied_item_updates` SET `entry` = 7787, `version` = 3596 WHERE (`entry` = 7787);
-- Gravestone Sceptre
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 7001);
UPDATE `applied_item_updates` SET `entry` = 7001, `version` = 3596 WHERE (`entry` = 7001);
-- Regal Cuffs
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7475);
UPDATE `applied_item_updates` SET `entry` = 7475, `version` = 3596 WHERE (`entry` = 7475);
-- Mechanical Dragonling
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 4396);
UPDATE `applied_item_updates` SET `entry` = 4396, `version` = 3596 WHERE (`entry` = 4396);
-- Captain's Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7488);
UPDATE `applied_item_updates` SET `entry` = 7488, `version` = 3596 WHERE (`entry` = 7488);
-- Goblin Nutcracker
-- spellid_1, from 13496 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4090);
UPDATE `applied_item_updates` SET `entry` = 4090, `version` = 3596 WHERE (`entry` = 4090);
-- Fire Hardened Gauntlets
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6974);
UPDATE `applied_item_updates` SET `entry` = 6974, `version` = 3596 WHERE (`entry` = 6974);
-- Gutrender
-- spellid_1, from 18090 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1986);
UPDATE `applied_item_updates` SET `entry` = 1986, `version` = 3596 WHERE (`entry` = 1986);
-- Phalanx Breastplate
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7418);
UPDATE `applied_item_updates` SET `entry` = 7418, `version` = 3596 WHERE (`entry` = 7418);
-- Captain's Breastplate
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7486);
UPDATE `applied_item_updates` SET `entry` = 7486, `version` = 3596 WHERE (`entry` = 7486);
-- Howling Blade
-- spellid_1, from 13490 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6331);
UPDATE `applied_item_updates` SET `entry` = 6331, `version` = 3596 WHERE (`entry` = 6331);
-- Bloodspiller
-- spellid_1, from 18200 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 7753);
UPDATE `applied_item_updates` SET `entry` = 7753, `version` = 3596 WHERE (`entry` = 7753);
-- Sage's Pants
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6616);
UPDATE `applied_item_updates` SET `entry` = 6616, `version` = 3596 WHERE (`entry` = 6616);
-- Mail Combat Gauntlets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 1 WHERE (`entry` = 4075);
UPDATE `applied_item_updates` SET `entry` = 4075, `version` = 3596 WHERE (`entry` = 4075);
-- Black Whelp Cloak
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 7283);
UPDATE `applied_item_updates` SET `entry` = 7283, `version` = 3596 WHERE (`entry` = 7283);
-- Thick Cloth Pants
-- stat_type1, from 0 to 1
-- stat_value1, from 0 to 8
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 8 WHERE (`entry` = 201);
UPDATE `applied_item_updates` SET `entry` = 201, `version` = 3596 WHERE (`entry` = 201);
-- Serpent Gloves
-- stat_type2, from 1 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 5970);
UPDATE `applied_item_updates` SET `entry` = 5970, `version` = 3596 WHERE (`entry` = 5970);
-- Tribal Headdress
-- stat_type3, from 0 to 7
-- stat_value3, from 0 to 2
-- nature_res, from 0 to 1
UPDATE `item_template` SET `stat_type3` = 7, `stat_value3` = 2, `nature_res` = 1 WHERE (`entry` = 2622);
UPDATE `applied_item_updates` SET `entry` = 2622, `version` = 3596 WHERE (`entry` = 2622);
-- Twilight Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7430);
UPDATE `applied_item_updates` SET `entry` = 7430, `version` = 3596 WHERE (`entry` = 7430);
-- Embalmed Shroud
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7691);
UPDATE `applied_item_updates` SET `entry` = 7691, `version` = 3596 WHERE (`entry` = 7691);
-- Blighted Leggings
-- holy_res, from 0 to 1
-- spellid_1, from 7709 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7709);
UPDATE `applied_item_updates` SET `entry` = 7709, `version` = 3596 WHERE (`entry` = 7709);
-- Green Carapace Shield
-- nature_res, from 4 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 2021);
UPDATE `applied_item_updates` SET `entry` = 2021, `version` = 3596 WHERE (`entry` = 2021);
-- Bite of Serra'kis
-- spellid_1, from 8313 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6904);
UPDATE `applied_item_updates` SET `entry` = 6904, `version` = 3596 WHERE (`entry` = 6904);
-- Blackfang
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 2236);
UPDATE `applied_item_updates` SET `entry` = 2236, `version` = 3596 WHERE (`entry` = 2236);
-- Beastial Manacles
-- stat_value2, from 30 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6722);
UPDATE `applied_item_updates` SET `entry` = 6722, `version` = 3596 WHERE (`entry` = 6722);
-- Gauntlets of Ogre Strength
-- spellid_1, from 9329 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3341);
UPDATE `applied_item_updates` SET `entry` = 3341, `version` = 3596 WHERE (`entry` = 3341);
-- Elder's Sash
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7370);
UPDATE `applied_item_updates` SET `entry` = 7370, `version` = 3596 WHERE (`entry` = 7370);
-- Darkweave Mantle
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3596 WHERE (`entry` = 4718);
-- Studded Boots
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 1 WHERE (`entry` = 2467);
UPDATE `applied_item_updates` SET `entry` = 2467, `version` = 3596 WHERE (`entry` = 2467);
-- Fire Hardened Buckler
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 1276);
UPDATE `applied_item_updates` SET `entry` = 1276, `version` = 3596 WHERE (`entry` = 1276);
-- Beetle Clasps
-- stat_type1, from 7 to 4
-- stat_value1, from 5 to 1
-- stat_type2, from 3 to 1
-- stat_value2, from 2 to 5
-- armor, from 95 to 32
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5, `armor` = 32 WHERE (`entry` = 7003);
UPDATE `applied_item_updates` SET `entry` = 7003, `version` = 3596 WHERE (`entry` = 7003);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3596 WHERE (`entry` = 4496);
-- Captain's Helm
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7488);
UPDATE `applied_item_updates` SET `entry` = 7488, `version` = 3596 WHERE (`entry` = 7488);
-- Explorers' League Commendation
-- nature_res, from 0 to 2
-- spellid_1, from 0 to 5102
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `nature_res` = 2, `spellid_1` = 5102, `spelltrigger_1` = 1 WHERE (`entry` = 7746);
UPDATE `applied_item_updates` SET `entry` = 7746, `version` = 3596 WHERE (`entry` = 7746);
-- Ivory Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7497);
UPDATE `applied_item_updates` SET `entry` = 7497, `version` = 3596 WHERE (`entry` = 7497);
-- Gutrender
-- spellid_1, from 18090 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1986);
UPDATE `applied_item_updates` SET `entry` = 1986, `version` = 3596 WHERE (`entry` = 1986);
-- Regal Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7469);
UPDATE `applied_item_updates` SET `entry` = 7469, `version` = 3596 WHERE (`entry` = 7469);
-- Mechanical Dragonling
-- max_count, from 0 to 1
UPDATE `item_template` SET `max_count` = 1 WHERE (`entry` = 4396);
UPDATE `applied_item_updates` SET `entry` = 4396, `version` = 3596 WHERE (`entry` = 4396);
-- Crimson Silk Cloak
-- fire_res, from 20 to 6
UPDATE `item_template` SET `fire_res` = 6 WHERE (`entry` = 7056);
UPDATE `applied_item_updates` SET `entry` = 7056, `version` = 3596 WHERE (`entry` = 7056);
-- Cerulean Talisman
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7427);
UPDATE `applied_item_updates` SET `entry` = 7427, `version` = 3596 WHERE (`entry` = 7427);
-- Light Leather Bracers
-- armor, from 34 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 7281);
UPDATE `applied_item_updates` SET `entry` = 7281, `version` = 3596 WHERE (`entry` = 7281);
-- Berserker Helm
-- fire_res, from 0 to 1
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7719);
UPDATE `applied_item_updates` SET `entry` = 7719, `version` = 3596 WHERE (`entry` = 7719);
-- Sword of Serenity
-- spellid_1, from 0 to 370
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `spellid_1` = 370, `spelltrigger_1` = 2 WHERE (`entry` = 6829);
UPDATE `applied_item_updates` SET `entry` = 6829, `version` = 3596 WHERE (`entry` = 6829);
-- Regal Wizard Hat
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7470);
UPDATE `applied_item_updates` SET `entry` = 7470, `version` = 3596 WHERE (`entry` = 7470);
-- Regal Cuffs
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7475);
UPDATE `applied_item_updates` SET `entry` = 7475, `version` = 3596 WHERE (`entry` = 7475);
-- Divine Gauntlets
-- spellid_1, from 15807 to 9408
UPDATE `item_template` SET `spellid_1` = 9408 WHERE (`entry` = 7724);
UPDATE `applied_item_updates` SET `entry` = 7724, `version` = 3596 WHERE (`entry` = 7724);
-- Vermilion Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7466);
UPDATE `applied_item_updates` SET `entry` = 7466, `version` = 3596 WHERE (`entry` = 7466);
-- Bishop's Miter
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7720);
UPDATE `applied_item_updates` SET `entry` = 7720, `version` = 3596 WHERE (`entry` = 7720);
-- Azure Silk Pants
-- frost_res, from 0 to 1
-- spellid_1, from 7703 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `frost_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7046);
UPDATE `applied_item_updates` SET `entry` = 7046, `version` = 3596 WHERE (`entry` = 7046);
-- Twilight Belt
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7438);
UPDATE `applied_item_updates` SET `entry` = 7438, `version` = 3596 WHERE (`entry` = 7438);
-- Cerulean Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 7426);
UPDATE `applied_item_updates` SET `entry` = 7426, `version` = 3596 WHERE (`entry` = 7426);
-- Black Whelp Cloak
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 7283);
UPDATE `applied_item_updates` SET `entry` = 7283, `version` = 3596 WHERE (`entry` = 7283);
-- Seal of Wrynn
-- max_count, from 1 to 0
-- fire_res, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `fire_res` = 1 WHERE (`entry` = 2933);
UPDATE `applied_item_updates` SET `entry` = 2933, `version` = 3596 WHERE (`entry` = 2933);
-- Servomechanic Sledgehammer
-- spellid_1, from 7560 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4548);
UPDATE `applied_item_updates` SET `entry` = 4548, `version` = 3596 WHERE (`entry` = 4548);
-- Cold Basilisk Eye
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 5079);
UPDATE `applied_item_updates` SET `entry` = 5079, `version` = 3596 WHERE (`entry` = 5079);
-- Black Menace
-- spellid_1, from 13440 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6831);
UPDATE `applied_item_updates` SET `entry` = 6831, `version` = 3596 WHERE (`entry` = 6831);
-- Twilight Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7430);
UPDATE `applied_item_updates` SET `entry` = 7430, `version` = 3596 WHERE (`entry` = 7430);
-- Orb of the Forgotten Seer
-- spellid_1, from 9417 to 0
-- spelltrigger_1, from 1 to 0
-- sheath, from 7 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0, `sheath` = 0 WHERE (`entry` = 7685);
UPDATE `applied_item_updates` SET `entry` = 7685, `version` = 3596 WHERE (`entry` = 7685);
-- Captain Sander's Shirt
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 3342);
UPDATE `applied_item_updates` SET `entry` = 3342, `version` = 3596 WHERE (`entry` = 3342);
-- Sentinel Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 7443);
UPDATE `applied_item_updates` SET `entry` = 7443, `version` = 3596 WHERE (`entry` = 7443);
-- Scorching Sash
-- spellid_1, from 9400 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4117);
UPDATE `applied_item_updates` SET `entry` = 4117, `version` = 3596 WHERE (`entry` = 4117);
-- Brightweave Pants
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4044);
UPDATE `applied_item_updates` SET `entry` = 4044, `version` = 3596 WHERE (`entry` = 4044);
-- Embalmed Shroud
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7691);
UPDATE `applied_item_updates` SET `entry` = 7691, `version` = 3596 WHERE (`entry` = 7691);
-- Polar Gauntlets
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7606);
UPDATE `applied_item_updates` SET `entry` = 7606, `version` = 3596 WHERE (`entry` = 7606);
-- Fletcher's Gloves
-- spellid_2, from 21352 to 0
-- spelltrigger_2, from 1 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 7348);
UPDATE `applied_item_updates` SET `entry` = 7348, `version` = 3596 WHERE (`entry` = 7348);
-- Sustaining Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6743);
UPDATE `applied_item_updates` SET `entry` = 6743, `version` = 3596 WHERE (`entry` = 6743);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3596 WHERE (`entry` = 4344);
-- Scorpion Sting
-- spellid_1, from 18208 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 1265);
UPDATE `applied_item_updates` SET `entry` = 1265, `version` = 3596 WHERE (`entry` = 1265);
-- Brightweave Bracers
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4043);
UPDATE `applied_item_updates` SET `entry` = 4043, `version` = 3596 WHERE (`entry` = 4043);
-- Gold-flecked Gloves
-- stat_value2, from 1 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3596 WHERE (`entry` = 5195);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3596 WHERE (`entry` = 48);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3596 WHERE (`entry` = 3363);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3596 WHERE (`entry` = 1377);
-- Mud Stompers
-- stat_value2, from 0 to 3
UPDATE `item_template` SET `stat_value2` = 3 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3596 WHERE (`entry` = 6188);
-- Small Spider Limb
-- name, from Snapped Spider Limb to Small Spider Limb
-- quality, from 1 to 0
UPDATE `item_template` SET `name` = 'Small Spider Limb', `quality` = 0 WHERE (`entry` = 1476);
UPDATE `applied_item_updates` SET `entry` = 1476, `version` = 3596 WHERE (`entry` = 1476);
-- Disciple's Bracers
-- display_id, from 16566 to 14705
-- buy_price, from 148 to 240
-- sell_price, from 29 to 48
-- item_level, from 10 to 12
-- required_level, from 5 to 7
-- armor, from 13 to 6
UPDATE `item_template` SET `display_id` = 14705, `buy_price` = 240, `sell_price` = 48, `item_level` = 12, `required_level` = 7, `armor` = 6 WHERE (`entry` = 7350);
UPDATE `applied_item_updates` SET `entry` = 7350, `version` = 3596 WHERE (`entry` = 7350);
-- Pioneer Buckler
-- subclass, from 6 to 5
-- buy_price, from 984 to 639
-- sell_price, from 196 to 127
-- item_level, from 13 to 12
-- required_level, from 8 to 7
-- armor, from 176 to 28
UPDATE `item_template` SET `subclass` = 5, `buy_price` = 639, `sell_price` = 127, `item_level` = 12, `required_level` = 7, `armor` = 28 WHERE (`entry` = 7109);
UPDATE `applied_item_updates` SET `entry` = 7109, `version` = 3596 WHERE (`entry` = 7109);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3596 WHERE (`entry` = 1366);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3596 WHERE (`entry` = 2119);
-- Handstitched Leather Bracers
-- armor, from 18 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 7277);
UPDATE `applied_item_updates` SET `entry` = 7277, `version` = 3596 WHERE (`entry` = 7277);
-- Ember Buckler
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 2 WHERE (`entry` = 4477);
UPDATE `applied_item_updates` SET `entry` = 4477, `version` = 3596 WHERE (`entry` = 4477);
-- Ruffled Feather
-- buy_price, from 165 to 215
-- sell_price, from 41 to 53
UPDATE `item_template` SET `buy_price` = 215, `sell_price` = 53 WHERE (`entry` = 4776);
UPDATE `applied_item_updates` SET `entry` = 4776, `version` = 3596 WHERE (`entry` = 4776);
-- Silver Steel Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6966);
UPDATE `applied_item_updates` SET `entry` = 6966, `version` = 3596 WHERE (`entry` = 6966);
-- Feeble Shortbow
-- required_level, from 8 to 10
-- dmg_min1, from 4.0 to 6
-- dmg_max1, from 8.0 to 12
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 2777);
UPDATE `applied_item_updates` SET `entry` = 2777, `version` = 3596 WHERE (`entry` = 2777);
-- Willow Branch
-- item_level, from 19 to 16
-- required_level, from 14 to 11
UPDATE `item_template` SET `item_level` = 16, `required_level` = 11 WHERE (`entry` = 7554);
UPDATE `applied_item_updates` SET `entry` = 7554, `version` = 3596 WHERE (`entry` = 7554);
-- Haggard's Dagger
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6980);
UPDATE `applied_item_updates` SET `entry` = 6980, `version` = 3596 WHERE (`entry` = 6980);
-- Regal Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7468);
UPDATE `applied_item_updates` SET `entry` = 7468, `version` = 3596 WHERE (`entry` = 7468);
-- Frayed Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1378);
UPDATE `applied_item_updates` SET `entry` = 1378, `version` = 3596 WHERE (`entry` = 1378);
-- Evergreen Gloves
-- display_id, from 16815 to 15865
-- stat_value1, from 3 to 1
-- armor, from 32 to 10
UPDATE `item_template` SET `display_id` = 15865, `stat_value1` = 1, `armor` = 10 WHERE (`entry` = 7738);
UPDATE `applied_item_updates` SET `entry` = 7738, `version` = 3596 WHERE (`entry` = 7738);
-- Grayson's Torch
-- armor, from 0 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3596 WHERE (`entry` = 1172);
-- Sharp Kitchen Knife
-- dmg_max1, from 10.0 to 9
UPDATE `item_template` SET `dmg_max1` = 9 WHERE (`entry` = 2225);
UPDATE `applied_item_updates` SET `entry` = 2225, `version` = 3596 WHERE (`entry` = 2225);
-- Stalvan's Reaper
-- spellid_1, from 13524 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 934);
UPDATE `applied_item_updates` SET `entry` = 934, `version` = 3596 WHERE (`entry` = 934);
-- Darkweave Sash
-- stat_value3, from 0 to 5
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value3` = 5, `shadow_res` = 1 WHERE (`entry` = 4720);
UPDATE `applied_item_updates` SET `entry` = 4720, `version` = 3596 WHERE (`entry` = 4720);
-- Prospector Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4980);
UPDATE `applied_item_updates` SET `entry` = 4980, `version` = 3596 WHERE (`entry` = 4980);
-- Dark Leather Tunic
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3596 WHERE (`entry` = 2317);
-- Light Leather Pants
-- buy_price, from 2998 to 2950
-- sell_price, from 599 to 590
-- stat_value1, from 5 to 1
-- armor, from 95 to 31
UPDATE `item_template` SET `buy_price` = 2950, `sell_price` = 590, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 7282);
UPDATE `applied_item_updates` SET `entry` = 7282, `version` = 3596 WHERE (`entry` = 7282);
-- Elder's Sash
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7370);
UPDATE `applied_item_updates` SET `entry` = 7370, `version` = 3596 WHERE (`entry` = 7370);
-- Frostweave Gloves
-- name, from Silver-thread Gloves to Frostweave Gloves
-- quality, from 2 to 1
-- buy_price, from 3803 to 3037
-- sell_price, from 760 to 607
-- item_level, from 28 to 31
-- required_level, from 23 to 26
-- stat_type1, from 3 to 6
-- stat_value1, from 5 to 1
-- stat_type2, from 5 to 4
-- stat_value2, from 5 to 1
-- armor, from 43 to 12
UPDATE `item_template` SET `name` = 'Frostweave Gloves', `quality` = 1, `buy_price` = 3037, `sell_price` = 607, `item_level` = 31, `required_level` = 26, `stat_type1` = 6, `stat_value1` = 1, `stat_type2` = 4, `stat_value2` = 1, `armor` = 12 WHERE (`entry` = 6393);
UPDATE `applied_item_updates` SET `entry` = 6393, `version` = 3596 WHERE (`entry` = 6393);
-- Phalanx Breastplate
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7418);
UPDATE `applied_item_updates` SET `entry` = 7418, `version` = 3596 WHERE (`entry` = 7418);
-- Smoldering Boots
-- stat_value2, from 28 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 3076);
UPDATE `applied_item_updates` SET `entry` = 3076, `version` = 3596 WHERE (`entry` = 3076);
-- Rod of the Sleepwalker
-- frost_res, from 0 to 2
UPDATE `item_template` SET `frost_res` = 2 WHERE (`entry` = 1155);
UPDATE `applied_item_updates` SET `entry` = 1155, `version` = 3596 WHERE (`entry` = 1155);
-- Cuirboulli Belt
-- stat_type1, from 0 to 1
-- stat_value1, from 0 to 5
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 2142);
UPDATE `applied_item_updates` SET `entry` = 2142, `version` = 3596 WHERE (`entry` = 2142);
-- Welken Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5011);
UPDATE `applied_item_updates` SET `entry` = 5011, `version` = 3596 WHERE (`entry` = 5011);
-- Darkweave Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4038);
UPDATE `applied_item_updates` SET `entry` = 4038, `version` = 3596 WHERE (`entry` = 4038);
-- Enchanted Stonecloth Bracers
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4979);
UPDATE `applied_item_updates` SET `entry` = 4979, `version` = 3596 WHERE (`entry` = 4979);
-- Regal Cloak
-- frost_res, from 0 to 6
UPDATE `item_template` SET `frost_res` = 6 WHERE (`entry` = 7474);
UPDATE `applied_item_updates` SET `entry` = 7474, `version` = 3596 WHERE (`entry` = 7474);
-- Blighted Leggings
-- holy_res, from 0 to 1
-- spellid_1, from 7709 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7709);
UPDATE `applied_item_updates` SET `entry` = 7709, `version` = 3596 WHERE (`entry` = 7709);
-- Journeyman Quarterstaff
-- dmg_min1, from 28.0 to 18
-- dmg_max1, from 39.0 to 27
UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 854);
UPDATE `applied_item_updates` SET `entry` = 854, `version` = 3596 WHERE (`entry` = 854);
-- Small Quiver
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5439);
UPDATE `applied_item_updates` SET `entry` = 5439, `version` = 3596 WHERE (`entry` = 5439);
-- Forest Chain
-- stat_value2, from 10 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3596 WHERE (`entry` = 1273);
-- Explorer's Vest
-- stat_type1, from 7 to 1
-- stat_value1, from 2 to 5
-- armor, from 125 to 44
UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5, `armor` = 44 WHERE (`entry` = 7229);
UPDATE `applied_item_updates` SET `entry` = 7229, `version` = 3596 WHERE (`entry` = 7229);
-- Flameweave Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3596 WHERE (`entry` = 6608);
-- Haggard's Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3596 WHERE (`entry` = 6979);
-- Glorious Shoulders
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3596 WHERE (`entry` = 4833);
-- Polished Scale Vest
-- stat_type1, from 0 to 4
-- stat_value1, from 0 to 1
-- stat_type2, from 0 to 1
-- stat_value2, from 0 to 5
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3596 WHERE (`entry` = 2153);
-- Rabbit's Foot
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3300);
UPDATE `applied_item_updates` SET `entry` = 3300, `version` = 3596 WHERE (`entry` = 3300);
-- Woodland Tunic
-- armor, from 30 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 4907);
UPDATE `applied_item_updates` SET `entry` = 4907, `version` = 3596 WHERE (`entry` = 4907);
-- Heavy Recurve Bow
-- required_level, from 20 to 22
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 29.0 to 43
UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 23, `dmg_max1` = 43 WHERE (`entry` = 3027);
UPDATE `applied_item_updates` SET `entry` = 3027, `version` = 3596 WHERE (`entry` = 3027);
-- Black Duskwood Staff
-- spellid_1, from 18138 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 937);
UPDATE `applied_item_updates` SET `entry` = 937, `version` = 3596 WHERE (`entry` = 937);
-- Blazing Emblem
-- fire_res, from 15 to 0
UPDATE `item_template` SET `fire_res` = 0 WHERE (`entry` = 2802);
UPDATE `applied_item_updates` SET `entry` = 2802, `version` = 3596 WHERE (`entry` = 2802);
-- Gauntlets of Ogre Strength
-- spellid_1, from 9329 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3341);
UPDATE `applied_item_updates` SET `entry` = 3341, `version` = 3596 WHERE (`entry` = 3341);
-- Wandering Boots
-- stat_value2, from 2 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3596 WHERE (`entry` = 6095);
-- Holy Shroud
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3596 WHERE (`entry` = 2721);
-- Regal Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7332);
UPDATE `applied_item_updates` SET `entry` = 7332, `version` = 3596 WHERE (`entry` = 7332);
-- Forest Tracker Epaulets
-- stat_type2, from 0 to 6
-- stat_value2, from 0 to 2
UPDATE `item_template` SET `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3596 WHERE (`entry` = 2278);
-- Scarab Trousers
-- stat_value3, from 1 to 0
UPDATE `item_template` SET `stat_value3` = 0 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3596 WHERE (`entry` = 6659);
-- Sage's Pants
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6616);
UPDATE `applied_item_updates` SET `entry` = 6616, `version` = 3596 WHERE (`entry` = 6616);
-- Captain's Breastplate
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7486);
UPDATE `applied_item_updates` SET `entry` = 7486, `version` = 3596 WHERE (`entry` = 7486);
-- Darkshire Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3596 WHERE (`entry` = 2906);
-- Gloves of Holy Might
-- spellid_2, from 9331 to 0
-- spelltrigger_2, from 1 to 0
-- spellid_3, from 18074 to 0
-- spelltrigger_3, from 1 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0, `spellid_3` = 0, `spelltrigger_3` = 0 WHERE (`entry` = 867);
UPDATE `applied_item_updates` SET `entry` = 867, `version` = 3596 WHERE (`entry` = 867);
-- Heart Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5001);
UPDATE `applied_item_updates` SET `entry` = 5001, `version` = 3596 WHERE (`entry` = 5001);
-- Aegis of the Scarlet Commander
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 7726);
UPDATE `applied_item_updates` SET `entry` = 7726, `version` = 3596 WHERE (`entry` = 7726);
-- Cobalt Crusher
-- dmg_min2, from 5.0 to 0
-- dmg_max2, from 5.0 to 0
-- dmg_type2, from 4 to 0
-- spellid_1, from 18204 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7730);
UPDATE `applied_item_updates` SET `entry` = 7730, `version` = 3596 WHERE (`entry` = 7730);
-- Goblin Nutcracker
-- spellid_1, from 13496 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4090);
UPDATE `applied_item_updates` SET `entry` = 4090, `version` = 3596 WHERE (`entry` = 4090);
-- Shadow Weaver Leggings
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3596 WHERE (`entry` = 2233);
-- Shadow Claw
-- spellid_1, from 16409 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2912);
UPDATE `applied_item_updates` SET `entry` = 2912, `version` = 3596 WHERE (`entry` = 2912);
-- Phalanx Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7419);
UPDATE `applied_item_updates` SET `entry` = 7419, `version` = 3596 WHERE (`entry` = 7419);
-- Ring of Calm
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6790);
UPDATE `applied_item_updates` SET `entry` = 6790, `version` = 3596 WHERE (`entry` = 6790);
-- Elder's Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7356);
UPDATE `applied_item_updates` SET `entry` = 7356, `version` = 3596 WHERE (`entry` = 7356);
-- Mantle of Thieves
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2264);
UPDATE `applied_item_updates` SET `entry` = 2264, `version` = 3596 WHERE (`entry` = 2264);
-- Vermilion Necklace
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 7467);
UPDATE `applied_item_updates` SET `entry` = 7467, `version` = 3596 WHERE (`entry` = 7467);
-- Rose Mantle
-- stat_value2, from 5 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5274);
UPDATE `applied_item_updates` SET `entry` = 5274, `version` = 3596 WHERE (`entry` = 5274);
-- Twilight Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7436);
UPDATE `applied_item_updates` SET `entry` = 7436, `version` = 3596 WHERE (`entry` = 7436);
-- Artisan's Trousers
-- stat_value2, from 3 to 0
-- stat_value3, from 48 to 0
UPDATE `item_template` SET `stat_value2` = 0, `stat_value3` = 0 WHERE (`entry` = 5016);
UPDATE `applied_item_updates` SET `entry` = 5016, `version` = 3596 WHERE (`entry` = 5016);
-- Gravestone Sceptre
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 7001);
UPDATE `applied_item_updates` SET `entry` = 7001, `version` = 3596 WHERE (`entry` = 7001);
-- Polished Scale Leggings
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
-- stat_value2, from 0 to 10
UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1, `stat_value2` = 10 WHERE (`entry` = 2152);
UPDATE `applied_item_updates` SET `entry` = 2152, `version` = 3596 WHERE (`entry` = 2152);
-- Polished Scale Boots
-- stat_type1, from 0 to 5
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3596 WHERE (`entry` = 2149);
-- Polished Scale Gloves
-- stat_type1, from 0 to 3
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3596 WHERE (`entry` = 2151);
-- Reinforced Targe
-- stat_value1, from 0 to 10
UPDATE `item_template` SET `stat_value1` = 10 WHERE (`entry` = 2442);
UPDATE `applied_item_updates` SET `entry` = 2442, `version` = 3596 WHERE (`entry` = 2442);
-- Kite Shield
-- stat_type1, from 0 to 7
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2446);
UPDATE `applied_item_updates` SET `entry` = 2446, `version` = 3596 WHERE (`entry` = 2446);
-- Wyvern Tailspike
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5752);
UPDATE `applied_item_updates` SET `entry` = 5752, `version` = 3596 WHERE (`entry` = 5752);
-- Twilight Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 7432);
UPDATE `applied_item_updates` SET `entry` = 7432, `version` = 3596 WHERE (`entry` = 7432);
-- Frostweave Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4713);
UPDATE `applied_item_updates` SET `entry` = 4713, `version` = 3596 WHERE (`entry` = 4713);
-- Zephyr Belt
-- stat_value2, from 40 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 6719);
UPDATE `applied_item_updates` SET `entry` = 6719, `version` = 3596 WHERE (`entry` = 6719);
-- Frostweave Robe
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4035);
UPDATE `applied_item_updates` SET `entry` = 4035, `version` = 3596 WHERE (`entry` = 4035);
-- Fire Hardened Hauberk
-- display_id, from 22480 to 13011
-- stat_value1, from 14 to 5
-- armor, from 226 to 71
UPDATE `item_template` SET `display_id` = 13011, `stat_value1` = 5, `armor` = 71 WHERE (`entry` = 6972);
UPDATE `applied_item_updates` SET `entry` = 6972, `version` = 3596 WHERE (`entry` = 6972);
-- Astral Knot Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 7511);
UPDATE `applied_item_updates` SET `entry` = 7511, `version` = 3596 WHERE (`entry` = 7511);
-- Elder's Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 7355);
UPDATE `applied_item_updates` SET `entry` = 7355, `version` = 3596 WHERE (`entry` = 7355);
-- Chieftain Girdle
-- stat_value2, from 15 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 5750);
UPDATE `applied_item_updates` SET `entry` = 5750, `version` = 3596 WHERE (`entry` = 5750);
-- Darkweave Cowl
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3596 WHERE (`entry` = 4039);
-- Darkweave Mantle
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3596 WHERE (`entry` = 4718);
-- Belt of Arugal
-- stat_type1, from 6 to 0
-- stat_value2, from 35 to 0
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `stat_type1` = 0, `stat_value2` = 0, `shadow_res` = 4 WHERE (`entry` = 6392);
UPDATE `applied_item_updates` SET `entry` = 6392, `version` = 3596 WHERE (`entry` = 6392);
-- Brightweave Cowl
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 2
-- holy_res, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 2, `holy_res` = 1 WHERE (`entry` = 4041);
UPDATE `applied_item_updates` SET `entry` = 4041, `version` = 3596 WHERE (`entry` = 4041);
-- Enchanted Moonstalker Cloak
-- buy_price, from 2115 to 0
-- sell_price, from 423 to 0
UPDATE `item_template` SET `buy_price` = 0, `sell_price` = 0 WHERE (`entry` = 5387);
UPDATE `applied_item_updates` SET `entry` = 5387, `version` = 3596 WHERE (`entry` = 5387);
-- Phalanx Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 7423);
UPDATE `applied_item_updates` SET `entry` = 7423, `version` = 3596 WHERE (`entry` = 7423);
-- Tempered Bracers
-- stat_type2, from 7 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 6675);
UPDATE `applied_item_updates` SET `entry` = 6675, `version` = 3596 WHERE (`entry` = 6675);
-- Frostweave Pants
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3596 WHERE (`entry` = 4037);
-- Glimmering Mail Pauldrons
-- stat_type2, from 0 to 7
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 6388);
UPDATE `applied_item_updates` SET `entry` = 6388, `version` = 3596 WHERE (`entry` = 6388);
-- Bottle of Pinot Noir (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2723);
UPDATE `applied_item_updates` SET `entry` = 2723, `version` = 3596 WHERE (`entry` = 2723);
-- Thornstone Sledgehammer
-- nature_res, from 10 to 0
UPDATE `item_template` SET `nature_res` = 0 WHERE (`entry` = 1722);
UPDATE `applied_item_updates` SET `entry` = 1722, `version` = 3596 WHERE (`entry` = 1722);
-- Umbral Axe
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3596 WHERE (`entry` = 6978);
-- Buckler of the Seas
-- stat_value2, from 22 to 0
UPDATE `item_template` SET `stat_value2` = 0 WHERE (`entry` = 1557);
UPDATE `applied_item_updates` SET `entry` = 1557, `version` = 3596 WHERE (`entry` = 1557);
-- Silver Steel Sword
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6967);
UPDATE `applied_item_updates` SET `entry` = 6967, `version` = 3596 WHERE (`entry` = 6967);
-- Hard Crawler Carapace
-- stat_type2, from 7 to 0
UPDATE `item_template` SET `stat_type2` = 0 WHERE (`entry` = 2087);
UPDATE `applied_item_updates` SET `entry` = 2087, `version` = 3596 WHERE (`entry` = 2087);
-- Band of Thorns
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5007);
UPDATE `applied_item_updates` SET `entry` = 5007, `version` = 3596 WHERE (`entry` = 5007);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3596 WHERE (`entry` = 3600);
-- Ogremage Staff
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 4
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 4 WHERE (`entry` = 2226);
UPDATE `applied_item_updates` SET `entry` = 2226, `version` = 3596 WHERE (`entry` = 2226);
-- Silvered Bronze Breastplate
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3596 WHERE (`entry` = 2869);
-- Black Metal Shortsword
-- shadow_res, from 4 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 886);
UPDATE `applied_item_updates` SET `entry` = 886, `version` = 3596 WHERE (`entry` = 886);
-- Beetle Clasps
-- stat_type1, from 7 to 4
-- stat_value1, from 5 to 1
-- stat_type2, from 3 to 1
-- stat_value2, from 2 to 5
-- armor, from 95 to 32
UPDATE `item_template` SET `stat_type1` = 4, `stat_value1` = 1, `stat_type2` = 1, `stat_value2` = 5, `armor` = 32 WHERE (`entry` = 7003);
UPDATE `applied_item_updates` SET `entry` = 7003, `version` = 3596 WHERE (`entry` = 7003);
-- Blackfang
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 2236);
UPDATE `applied_item_updates` SET `entry` = 2236, `version` = 3596 WHERE (`entry` = 2236);
-- Brightweave Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6415);
UPDATE `applied_item_updates` SET `entry` = 6415, `version` = 3596 WHERE (`entry` = 6415);
-- Brightweave Cloak
-- frost_res, from 0 to 6
UPDATE `item_template` SET `frost_res` = 6 WHERE (`entry` = 6417);
UPDATE `applied_item_updates` SET `entry` = 6417, `version` = 3596 WHERE (`entry` = 6417);
-- Ironforge Memorial Ring
-- max_count, from 1 to 0
-- spellid_1, from 0 to 4314
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `max_count` = 0, `spellid_1` = 4314, `spelltrigger_1` = 1 WHERE (`entry` = 4535);
UPDATE `applied_item_updates` SET `entry` = 4535, `version` = 3596 WHERE (`entry` = 4535);
-- Sunblaze Coif
-- fire_res, from 48 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 5819);
UPDATE `applied_item_updates` SET `entry` = 5819, `version` = 3596 WHERE (`entry` = 5819);
-- Voodoo Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 1996);
UPDATE `applied_item_updates` SET `entry` = 1996, `version` = 3596 WHERE (`entry` = 1996);
-- Sage's Armor
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3596 WHERE (`entry` = 6609);
-- Windweaver Staff
-- spellid_1, from 13599 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 7757);
UPDATE `applied_item_updates` SET `entry` = 7757, `version` = 3596 WHERE (`entry` = 7757);
-- Studded Boots
-- stat_type2, from 0 to 4
-- stat_value2, from 0 to 1
UPDATE `item_template` SET `stat_type2` = 4, `stat_value2` = 1 WHERE (`entry` = 2467);
UPDATE `applied_item_updates` SET `entry` = 2467, `version` = 3596 WHERE (`entry` = 2467);
-- Neophyte's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 52);
UPDATE `applied_item_updates` SET `entry` = 52, `version` = 3596 WHERE (`entry` = 52);
-- Rock Pulverizer
-- spellid_1, from 15806 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4983);
UPDATE `applied_item_updates` SET `entry` = 4983, `version` = 3596 WHERE (`entry` = 4983);
-- 3368

-- Ragged Leather Belt
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1369);
UPDATE `applied_item_updates` SET `entry` = 1369, `version` = 3368 WHERE (`entry` = 1369);
-- Ragged Leather Pants
-- armor, from 10 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1366);
UPDATE `applied_item_updates` SET `entry` = 1366, `version` = 3368 WHERE (`entry` = 1366);
-- Flax Boots
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3274);
UPDATE `applied_item_updates` SET `entry` = 3274, `version` = 3368 WHERE (`entry` = 3274);
-- Flax Gloves
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3275);
UPDATE `applied_item_updates` SET `entry` = 3275, `version` = 3368 WHERE (`entry` = 3275);
-- Acolyte's Pants
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1396);
UPDATE `applied_item_updates` SET `entry` = 1396, `version` = 3368 WHERE (`entry` = 1396);
-- Frayed Cloak
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1376);
UPDATE `applied_item_updates` SET `entry` = 1376, `version` = 3368 WHERE (`entry` = 1376);
-- Frayed Belt
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3363);
UPDATE `applied_item_updates` SET `entry` = 3363, `version` = 3368 WHERE (`entry` = 3363);
-- Flimsy Chain Pants
-- armor, from 4 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2654);
UPDATE `applied_item_updates` SET `entry` = 2654, `version` = 3368 WHERE (`entry` = 2654);
-- Rusted Chain Boots
-- armor, from 12 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2389);
UPDATE `applied_item_updates` SET `entry` = 2389, `version` = 3368 WHERE (`entry` = 2389);
-- Flimsy Chain Gloves
-- armor, from 5 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2653);
UPDATE `applied_item_updates` SET `entry` = 2653, `version` = 3368 WHERE (`entry` = 2653);
-- Neophyte's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 52);
UPDATE `applied_item_updates` SET `entry` = 52, `version` = 3368 WHERE (`entry` = 52);
-- Frayed Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1377);
UPDATE `applied_item_updates` SET `entry` = 1377, `version` = 3368 WHERE (`entry` = 1377);
-- Frayed Robe
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1380);
UPDATE `applied_item_updates` SET `entry` = 1380, `version` = 3368 WHERE (`entry` = 1380);
-- Frayed Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1378);
UPDATE `applied_item_updates` SET `entry` = 1378, `version` = 3368 WHERE (`entry` = 1378);
-- Forsaken Dagger
-- dmg_min1, from 2.0 to 6
-- dmg_max1, from 5.0 to 9
UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 9 WHERE (`entry` = 3268);
UPDATE `applied_item_updates` SET `entry` = 3268, `version` = 3368 WHERE (`entry` = 3268);
-- Forsaken Shortsword
-- dmg_min1, from 3.0 to 8
-- dmg_max1, from 6.0 to 12
UPDATE `item_template` SET `dmg_min1` = 8, `dmg_max1` = 12 WHERE (`entry` = 3267);
UPDATE `applied_item_updates` SET `entry` = 3267, `version` = 3368 WHERE (`entry` = 3267);
-- Flimsy Chain Vest
-- armor, from 11 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2656);
UPDATE `applied_item_updates` SET `entry` = 2656, `version` = 3368 WHERE (`entry` = 2656);
-- Ragged Leather Boots
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1367);
UPDATE `applied_item_updates` SET `entry` = 1367, `version` = 3368 WHERE (`entry` = 1367);
-- Ragged Leather Bracers
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1370);
UPDATE `applied_item_updates` SET `entry` = 1370, `version` = 3368 WHERE (`entry` = 1370);
-- Large Wooden Shield
-- armor, from 19 to 4
UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 1200);
UPDATE `applied_item_updates` SET `entry` = 1200, `version` = 3368 WHERE (`entry` = 1200);
-- Rusted Chain Leggings
-- armor, from 15 to 4
UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 2388);
UPDATE `applied_item_updates` SET `entry` = 2388, `version` = 3368 WHERE (`entry` = 2388);
-- Ruined Pelt
-- display_id, from 7086 to 6686
UPDATE `item_template` SET `display_id` = 6686 WHERE (`entry` = 4865);
UPDATE `applied_item_updates` SET `entry` = 4865, `version` = 3368 WHERE (`entry` = 4865);
-- Frayed Bracers
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3365);
UPDATE `applied_item_updates` SET `entry` = 3365, `version` = 3368 WHERE (`entry` = 3365);
-- Zombie Skin Leggings
-- armor, from 8 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3272);
UPDATE `applied_item_updates` SET `entry` = 3272, `version` = 3368 WHERE (`entry` = 3272);
-- Flimsy Chain Belt
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 2649);
UPDATE `applied_item_updates` SET `entry` = 2649, `version` = 3368 WHERE (`entry` = 2649);
-- Flimsy Chain Boots
-- armor, from 4 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2650);
UPDATE `applied_item_updates` SET `entry` = 2650, `version` = 3368 WHERE (`entry` = 2650);
-- Flimsy Chain Bracers
-- armor, from 4 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2651);
UPDATE `applied_item_updates` SET `entry` = 2651, `version` = 3368 WHERE (`entry` = 2651);
-- Linen Cloak
-- armor, from 5 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2570);
UPDATE `applied_item_updates` SET `entry` = 2570, `version` = 3368 WHERE (`entry` = 2570);
-- Sturdy Cloth Trousers
-- required_level, from 3 to 1
-- armor, from 8 to 2
UPDATE `item_template` SET `required_level` = 1, `armor` = 2 WHERE (`entry` = 3834);
UPDATE `applied_item_updates` SET `entry` = 3834, `version` = 3368 WHERE (`entry` = 3834);
-- Ragged Leather Vest
-- armor, from 7 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1364);
UPDATE `applied_item_updates` SET `entry` = 1364, `version` = 3368 WHERE (`entry` = 1364);
-- Rusted Chain Belt
-- armor, from 8 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2387);
UPDATE `applied_item_updates` SET `entry` = 2387, `version` = 3368 WHERE (`entry` = 2387);
-- Rusted Chain Bracers
-- armor, from 9 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2390);
UPDATE `applied_item_updates` SET `entry` = 2390, `version` = 3368 WHERE (`entry` = 2390);
-- Rusted Chain Gloves
-- armor, from 10 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2391);
UPDATE `applied_item_updates` SET `entry` = 2391, `version` = 3368 WHERE (`entry` = 2391);
-- Frayed Shoes
-- armor, from 2 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1374);
UPDATE `applied_item_updates` SET `entry` = 1374, `version` = 3368 WHERE (`entry` = 1374);
-- Deathguard Buckler
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3276);
UPDATE `applied_item_updates` SET `entry` = 3276, `version` = 3368 WHERE (`entry` = 3276);
-- Small Spider Limb
-- name, from Snapped Spider Limb to Small Spider Limb
UPDATE `item_template` SET `name` = 'Small Spider Limb' WHERE (`entry` = 1476);
UPDATE `applied_item_updates` SET `entry` = 1476, `version` = 3368 WHERE (`entry` = 1476);
-- Forsaken Broadsword
-- name, from Forsaken Bastard Sword to Forsaken Broadsword
-- dmg_min1, from 8.0 to 14
-- dmg_max1, from 13.0 to 20
UPDATE `item_template` SET `name` = 'Forsaken Broadsword', `dmg_min1` = 14, `dmg_max1` = 20 WHERE (`entry` = 5779);
UPDATE `applied_item_updates` SET `entry` = 5779, `version` = 3368 WHERE (`entry` = 5779);
-- Cryptwalker Boots
-- required_level, from 3 to 1
-- armor, from 18 to 4
UPDATE `item_template` SET `required_level` = 1, `armor` = 4 WHERE (`entry` = 3447);
UPDATE `applied_item_updates` SET `entry` = 3447, `version` = 3368 WHERE (`entry` = 3447);
-- Tattered Cloth Pants
-- armor, from 5 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 194);
UPDATE `applied_item_updates` SET `entry` = 194, `version` = 3368 WHERE (`entry` = 194);
-- Ragged Leather Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1368);
UPDATE `applied_item_updates` SET `entry` = 1368, `version` = 3368 WHERE (`entry` = 1368);
-- Webbed Pants
-- armor, from 3 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3263);
UPDATE `applied_item_updates` SET `entry` = 3263, `version` = 3368 WHERE (`entry` = 3263);
-- Tattered Cloth Belt
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3595);
UPDATE `applied_item_updates` SET `entry` = 3595, `version` = 3368 WHERE (`entry` = 3595);
-- Tattered Cloth Bracers
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 3596);
UPDATE `applied_item_updates` SET `entry` = 3596, `version` = 3368 WHERE (`entry` = 3596);
-- Clasped Belt
-- required_level, from 3 to 1
-- armor, from 12 to 3
UPDATE `item_template` SET `required_level` = 1, `armor` = 3 WHERE (`entry` = 3437);
UPDATE `applied_item_updates` SET `entry` = 3437, `version` = 3368 WHERE (`entry` = 3437);
-- Woven Belt
-- required_level, from 5 to 1
-- armor, from 5 to 1
UPDATE `item_template` SET `required_level` = 1, `armor` = 1 WHERE (`entry` = 3606);
UPDATE `applied_item_updates` SET `entry` = 3606, `version` = 3368 WHERE (`entry` = 3606);
-- Woven Bracers
-- required_level, from 5 to 1
-- armor, from 6 to 2
UPDATE `item_template` SET `required_level` = 1, `armor` = 2 WHERE (`entry` = 3607);
UPDATE `applied_item_updates` SET `entry` = 3607, `version` = 3368 WHERE (`entry` = 3607);
-- Woven Gloves
-- required_level, from 5 to 1
-- armor, from 6 to 2
UPDATE `item_template` SET `required_level` = 1, `armor` = 2 WHERE (`entry` = 2369);
UPDATE `applied_item_updates` SET `entry` = 2369, `version` = 3368 WHERE (`entry` = 2369);
-- Woven Pants
-- required_level, from 5 to 1
-- armor, from 10 to 3
UPDATE `item_template` SET `required_level` = 1, `armor` = 3 WHERE (`entry` = 2366);
UPDATE `applied_item_updates` SET `entry` = 2366, `version` = 3368 WHERE (`entry` = 2366);
-- Heavy Weave Armor
-- armor, from 14 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 837);
UPDATE `applied_item_updates` SET `entry` = 837, `version` = 3368 WHERE (`entry` = 837);
-- Heavy Weave Belt
-- armor, from 6 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3589);
UPDATE `applied_item_updates` SET `entry` = 3589, `version` = 3368 WHERE (`entry` = 3589);
-- Heavy Weave Pants
-- armor, from 12 to 4
UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 838);
UPDATE `applied_item_updates` SET `entry` = 838, `version` = 3368 WHERE (`entry` = 838);
-- Tattered Cloth Gloves
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 711);
UPDATE `applied_item_updates` SET `entry` = 711, `version` = 3368 WHERE (`entry` = 711);
-- Runic Cloth Cloak
-- required_level, from 10 to 5
-- armor, from 11 to 3
UPDATE `item_template` SET `required_level` = 5, `armor` = 3 WHERE (`entry` = 4686);
UPDATE `applied_item_updates` SET `entry` = 4686, `version` = 3368 WHERE (`entry` = 4686);
-- Brass Scale Pants
-- required_level, from 6 to 1
-- armor, from 31 to 7
UPDATE `item_template` SET `required_level` = 1, `armor` = 7 WHERE (`entry` = 5941);
UPDATE `applied_item_updates` SET `entry` = 5941, `version` = 3368 WHERE (`entry` = 5941);
-- Ghostly Bracers
-- required_level, from 3 to 1
-- armor, from 4 to 1
UPDATE `item_template` SET `required_level` = 1, `armor` = 1 WHERE (`entry` = 3323);
UPDATE `applied_item_updates` SET `entry` = 3323, `version` = 3368 WHERE (`entry` = 3323);
-- Light Chain Leggings
-- required_level, from 5 to 1
-- armor, from 29 to 7
UPDATE `item_template` SET `required_level` = 1, `armor` = 7 WHERE (`entry` = 2400);
UPDATE `applied_item_updates` SET `entry` = 2400, `version` = 3368 WHERE (`entry` = 2400);
-- Light Chain Boots
-- required_level, from 5 to 1
-- armor, from 23 to 5
UPDATE `item_template` SET `required_level` = 1, `armor` = 5 WHERE (`entry` = 2401);
UPDATE `applied_item_updates` SET `entry` = 2401, `version` = 3368 WHERE (`entry` = 2401);
-- Bone Buckler
-- required_level, from 7 to 2
-- armor, from 28 to 6
UPDATE `item_template` SET `required_level` = 2, `armor` = 6 WHERE (`entry` = 5940);
UPDATE `applied_item_updates` SET `entry` = 5940, `version` = 3368 WHERE (`entry` = 5940);
-- Ceremonial Knife
-- required_level, from 9 to 2
-- dmg_min1, from 4.0 to 10
-- dmg_max1, from 9.0 to 15
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 10, `dmg_max1` = 15 WHERE (`entry` = 3445);
UPDATE `applied_item_updates` SET `entry` = 3445, `version` = 3368 WHERE (`entry` = 3445);
-- Brown Linen Vest
-- armor, from 8 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2568);
UPDATE `applied_item_updates` SET `entry` = 2568, `version` = 3368 WHERE (`entry` = 2568);
-- Woven Vest
-- required_level, from 5 to 1
-- armor, from 11 to 3
UPDATE `item_template` SET `required_level` = 1, `armor` = 3 WHERE (`entry` = 2364);
UPDATE `applied_item_updates` SET `entry` = 2364, `version` = 3368 WHERE (`entry` = 2364);
-- Woven Boots
-- required_level, from 5 to 1
-- armor, from 8 to 2
UPDATE `item_template` SET `required_level` = 1, `armor` = 2 WHERE (`entry` = 2367);
UPDATE `applied_item_updates` SET `entry` = 2367, `version` = 3368 WHERE (`entry` = 2367);
-- Battle Chain Bracers
-- required_level, from 5 to 1
-- armor, from 16 to 4
UPDATE `item_template` SET `required_level` = 1, `armor` = 4 WHERE (`entry` = 3280);
UPDATE `applied_item_updates` SET `entry` = 3280, `version` = 3368 WHERE (`entry` = 3280);
-- Brackwater Bracers
-- required_level, from 10 to 5
-- armor, from 21 to 5
UPDATE `item_template` SET `required_level` = 5, `armor` = 5 WHERE (`entry` = 3303);
UPDATE `applied_item_updates` SET `entry` = 3303, `version` = 3368 WHERE (`entry` = 3303);
-- Double-bladed Axe
-- dmg_min1, from 13.0 to 20
-- dmg_max1, from 21.0 to 28
UPDATE `item_template` SET `dmg_min1` = 20, `dmg_max1` = 28 WHERE (`entry` = 2499);
UPDATE `applied_item_updates` SET `entry` = 2499, `version` = 3368 WHERE (`entry` = 2499);
-- Tiller's Vest
-- required_level, from 6 to 1
-- armor, from 24 to 6
UPDATE `item_template` SET `required_level` = 1, `armor` = 6 WHERE (`entry` = 3444);
UPDATE `applied_item_updates` SET `entry` = 3444, `version` = 3368 WHERE (`entry` = 3444);
-- Ceremonial Leather Gloves
-- required_level, from 11 to 6
-- stat_type1, from 1 to 7
-- stat_value1, from 3 to 1
-- armor, from 18 to 5
UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 7, `stat_value1` = 1, `armor` = 5 WHERE (`entry` = 3314);
UPDATE `applied_item_updates` SET `entry` = 3314, `version` = 3368 WHERE (`entry` = 3314);
-- Deathstalker Shortsword
-- required_level, from 8 to 1
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 13.0 to 19
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 15, `dmg_max1` = 19 WHERE (`entry` = 3455);
UPDATE `applied_item_updates` SET `entry` = 3455, `version` = 3368 WHERE (`entry` = 3455);
-- Zombie Skin Bracers
-- required_level, from 4 to 1
-- armor, from 10 to 2
UPDATE `item_template` SET `required_level` = 1, `armor` = 2 WHERE (`entry` = 3435);
UPDATE `applied_item_updates` SET `entry` = 3435, `version` = 3368 WHERE (`entry` = 3435);
-- Wispy Cloak
-- armor, from 5 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3322);
UPDATE `applied_item_updates` SET `entry` = 3322, `version` = 3368 WHERE (`entry` = 3322);
-- Blue Linen Vest
-- required_level, from 7 to 2
-- stat_type1, from 1 to 5
-- stat_value1, from 3 to 2
-- armor, from 14 to 4
UPDATE `item_template` SET `required_level` = 2, `stat_type1` = 5, `stat_value1` = 2, `armor` = 4 WHERE (`entry` = 6240);
UPDATE `applied_item_updates` SET `entry` = 6240, `version` = 3368 WHERE (`entry` = 6240);
-- Ceremonial Leather Boots
-- name, from Ceremonial Leather Ankleguards to Ceremonial Leather Boots
-- buy_price, from 1460 to 1932
-- sell_price, from 292 to 386
-- item_level, from 16 to 18
-- required_level, from 11 to 8
-- stat_value1, from 5 to 1
-- armor, from 22 to 6
UPDATE `item_template` SET `name` = 'Ceremonial Leather Boots', `buy_price` = 1932, `sell_price` = 386, `item_level` = 18, `required_level` = 8, `stat_value1` = 1, `armor` = 6 WHERE (`entry` = 3311);
UPDATE `applied_item_updates` SET `entry` = 3311, `version` = 3368 WHERE (`entry` = 3311);
-- Sewing Gloves
-- required_level, from 3 to 1
-- armor, from 10 to 3
UPDATE `item_template` SET `required_level` = 1, `armor` = 3 WHERE (`entry` = 5939);
UPDATE `applied_item_updates` SET `entry` = 5939, `version` = 3368 WHERE (`entry` = 5939);
-- Zombie Skin Boots
-- required_level, from 3 to 1
-- armor, from 12 to 3
UPDATE `item_template` SET `required_level` = 1, `armor` = 3 WHERE (`entry` = 3439);
UPDATE `applied_item_updates` SET `entry` = 3439, `version` = 3368 WHERE (`entry` = 3439);
-- Handstitched Linen Britches
-- armor, from 12 to 4
UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 4309);
UPDATE `applied_item_updates` SET `entry` = 4309, `version` = 3368 WHERE (`entry` = 4309);
-- Blacksmith's Hammer
-- sheath, from 0 to 5
UPDATE `item_template` SET `sheath` = 5 WHERE (`entry` = 5956);
UPDATE `applied_item_updates` SET `entry` = 5956, `version` = 3368 WHERE (`entry` = 5956);
-- Mining Pick
-- sheath, from 0 to 5
UPDATE `item_template` SET `sheath` = 5 WHERE (`entry` = 2901);
UPDATE `applied_item_updates` SET `entry` = 2901, `version` = 3368 WHERE (`entry` = 2901);
-- Tribal Boots
-- required_level, from 5 to 1
-- armor, from 15 to 4
UPDATE `item_template` SET `required_level` = 1, `armor` = 4 WHERE (`entry` = 3284);
UPDATE `applied_item_updates` SET `entry` = 3284, `version` = 3368 WHERE (`entry` = 3284);
-- Wooden Warhammer
-- dmg_min1, from 13.0 to 19
-- dmg_max1, from 20.0 to 26
UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 26 WHERE (`entry` = 2501);
UPDATE `applied_item_updates` SET `entry` = 2501, `version` = 3368 WHERE (`entry` = 2501);
-- Light Chain Belt
-- required_level, from 5 to 1
-- armor, from 14 to 3
UPDATE `item_template` SET `required_level` = 1, `armor` = 3 WHERE (`entry` = 2399);
UPDATE `applied_item_updates` SET `entry` = 2399, `version` = 3368 WHERE (`entry` = 2399);
-- Heavy Linen Bandage
-- required_skill, from 129 to 0
-- required_skill_rank, from 20 to 0
-- spellid_1, from 1159 to 0
-- spellcategory_1, from 150 to 0
UPDATE `item_template` SET `required_skill` = 0, `required_skill_rank` = 0, `spellid_1` = 0, `spellcategory_1` = 0 WHERE (`entry` = 2581);
UPDATE `applied_item_updates` SET `entry` = 2581, `version` = 3368 WHERE (`entry` = 2581);
-- Pattern: Blue Linen Vest
-- quality, from 2 to 1
UPDATE `item_template` SET `quality` = 1 WHERE (`entry` = 6270);
UPDATE `applied_item_updates` SET `entry` = 6270, `version` = 3368 WHERE (`entry` = 6270);
-- Linen Bandage
-- spellid_1, from 746 to 0
-- spellcategory_1, from 150 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spellcategory_1` = 0 WHERE (`entry` = 1251);
UPDATE `applied_item_updates` SET `entry` = 1251, `version` = 3368 WHERE (`entry` = 1251);
-- Worn Mail Vest
-- armor, from 26 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 1737);
UPDATE `applied_item_updates` SET `entry` = 1737, `version` = 3368 WHERE (`entry` = 1737);
-- Brackwater Girdle
-- buy_price, from 1263 to 1670
-- sell_price, from 252 to 334
-- item_level, from 16 to 18
-- required_level, from 11 to 8
-- stat_value1, from 6 to 20
-- armor, from 21 to 6
UPDATE `item_template` SET `buy_price` = 1670, `sell_price` = 334, `item_level` = 18, `required_level` = 8, `stat_value1` = 20, `armor` = 6 WHERE (`entry` = 4681);
UPDATE `applied_item_updates` SET `entry` = 4681, `version` = 3368 WHERE (`entry` = 4681);
-- Stable Boots
-- armor, from 22 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 4789);
UPDATE `applied_item_updates` SET `entry` = 4789, `version` = 3368 WHERE (`entry` = 4789);
-- Crochet Bracers
-- name, from Quilted Bracers to Crochet Bracers
-- required_level, from 7 to 1
-- armor, from 6 to 2
UPDATE `item_template` SET `name` = 'Crochet Bracers', `required_level` = 1, `armor` = 2 WHERE (`entry` = 3453);
UPDATE `applied_item_updates` SET `entry` = 3453, `version` = 3368 WHERE (`entry` = 3453);
-- Fisherman Knife
-- required_level, from 11 to 4
-- dmg_min1, from 3.0 to 8
-- dmg_max1, from 7.0 to 12
UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 8, `dmg_max1` = 12 WHERE (`entry` = 2763);
UPDATE `applied_item_updates` SET `entry` = 2763, `version` = 3368 WHERE (`entry` = 2763);
-- Solliden's Trousers
-- required_level, from 3 to 1
-- armor, from 8 to 2
UPDATE `item_template` SET `required_level` = 1, `armor` = 2 WHERE (`entry` = 4261);
UPDATE `applied_item_updates` SET `entry` = 4261, `version` = 3368 WHERE (`entry` = 4261);
-- Vile Fin Oracle Staff
-- required_level, from 6 to 1
-- dmg_min1, from 12.0 to 18
-- dmg_max1, from 19.0 to 25
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 18, `dmg_max1` = 25 WHERE (`entry` = 3327);
UPDATE `applied_item_updates` SET `entry` = 3327, `version` = 3368 WHERE (`entry` = 3327);
-- Runic Cloth Belt
-- armor, from 6 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 4687);
UPDATE `applied_item_updates` SET `entry` = 4687, `version` = 3368 WHERE (`entry` = 4687);
-- Scouting Boots
-- name, from Reconnaissance Boots to Scouting Boots
-- quality, from 1 to 2
-- buy_price, from 527 to 585
-- sell_price, from 105 to 117
-- item_level, from 14 to 12
-- required_level, from 9 to 2
-- armor, from 10 to 3
UPDATE `item_template` SET `name` = 'Scouting Boots', `quality` = 2, `buy_price` = 585, `sell_price` = 117, `item_level` = 12, `required_level` = 2, `armor` = 3 WHERE (`entry` = 3454);
UPDATE `applied_item_updates` SET `entry` = 3454, `version` = 3368 WHERE (`entry` = 3454);
-- Nightglow Concoction
-- required_level, from 13 to 8
-- stat_value1, from 10 to 1
-- sheath, from 7 to 0
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 1, `sheath` = 0 WHERE (`entry` = 3451);
UPDATE `applied_item_updates` SET `entry` = 3451, `version` = 3368 WHERE (`entry` = 3451);
-- Weathered Belt
-- required_level, from 7 to 2
-- armor, from 11 to 3
UPDATE `item_template` SET `required_level` = 2, `armor` = 3 WHERE (`entry` = 3583);
UPDATE `applied_item_updates` SET `entry` = 3583, `version` = 3368 WHERE (`entry` = 3583);
-- Rusted Chain Vest
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2386);
UPDATE `applied_item_updates` SET `entry` = 2386, `version` = 3368 WHERE (`entry` = 2386);
-- Darkwood Staff
-- required_level, from 8 to 3
-- dmg_min1, from 20.0 to 33
-- dmg_max1, from 31.0 to 45
UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 33, `dmg_max1` = 45 WHERE (`entry` = 3446);
UPDATE `applied_item_updates` SET `entry` = 3446, `version` = 3368 WHERE (`entry` = 3446);
-- Tattered Cloth Vest
-- armor, from 6 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 193);
UPDATE `applied_item_updates` SET `entry` = 193, `version` = 3368 WHERE (`entry` = 193);
-- Buckled Cloth Trousers
-- name, from Stamped Trousers to Buckled Cloth Trousers
-- required_level, from 13 to 7
-- stat_type1, from 1 to 5
-- stat_value1, from 5 to 2
-- stat_value2, from 5 to 2
-- armor, from 15 to 5
UPDATE `item_template` SET `name` = 'Buckled Cloth Trousers', `required_level` = 7, `stat_type1` = 5, `stat_value1` = 2, `stat_value2` = 2, `armor` = 5 WHERE (`entry` = 3457);
UPDATE `applied_item_updates` SET `entry` = 3457, `version` = 3368 WHERE (`entry` = 3457);
-- Solstice Robe
-- stat_value3, from 5 to 0
-- armor, from 16 to 5
UPDATE `item_template` SET `stat_value3` = 0, `armor` = 5 WHERE (`entry` = 4782);
UPDATE `applied_item_updates` SET `entry` = 4782, `version` = 3368 WHERE (`entry` = 4782);
-- Dim Torch
-- required_level, from 5 to 1
UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 6182);
UPDATE `applied_item_updates` SET `entry` = 6182, `version` = 3368 WHERE (`entry` = 6182);
-- Brackwater Vest
-- required_level, from 10 to 5
-- stat_value1, from 1 to 3
-- armor, from 47 to 11
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 3, `armor` = 11 WHERE (`entry` = 3306);
UPDATE `applied_item_updates` SET `entry` = 3306, `version` = 3368 WHERE (`entry` = 3306);
-- Brackwater Buckler
-- required_level, from 10 to 5
-- stat_value1, from 3 to 8
-- armor, from 40 to 7
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 8, `armor` = 7 WHERE (`entry` = 3653);
UPDATE `applied_item_updates` SET `entry` = 3653, `version` = 3368 WHERE (`entry` = 3653);
-- Calico Boots
-- armor, from 6 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1495);
UPDATE `applied_item_updates` SET `entry` = 1495, `version` = 3368 WHERE (`entry` = 1495);
-- Logsplitter
-- required_level, from 11 to 6
-- dmg_min1, from 26.0 to 42
-- dmg_max1, from 40.0 to 57
UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 42, `dmg_max1` = 57 WHERE (`entry` = 3586);
UPDATE `applied_item_updates` SET `entry` = 3586, `version` = 3368 WHERE (`entry` = 3586);
-- Ceremonial Leather Pants
-- name, from Ceremonial Leather Loin Cloth to Ceremonial Leather Pants
-- required_level, from 12 to 7
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 3
-- armor, from 29 to 8
UPDATE `item_template` SET `name` = 'Ceremonial Leather Pants', `required_level` = 7, `stat_type1` = 6, `stat_value1` = 3, `armor` = 8 WHERE (`entry` = 3315);
UPDATE `applied_item_updates` SET `entry` = 3315, `version` = 3368 WHERE (`entry` = 3315);
-- Wall Shield
-- armor, from 43 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 1202);
UPDATE `applied_item_updates` SET `entry` = 1202, `version` = 3368 WHERE (`entry` = 1202);
-- Short Sabre
-- required_level, from 6 to 1
-- dmg_min1, from 5.0 to 10
-- dmg_max1, from 10.0 to 16
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 3319);
UPDATE `applied_item_updates` SET `entry` = 3319, `version` = 3368 WHERE (`entry` = 3319);
-- Brackwater Gauntlets
-- armor, from 25 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 3304);
UPDATE `applied_item_updates` SET `entry` = 3304, `version` = 3368 WHERE (`entry` = 3304);
-- Robe of Apprenticeship
-- armor, from 14 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2614);
UPDATE `applied_item_updates` SET `entry` = 2614, `version` = 3368 WHERE (`entry` = 2614);
-- Burnished Chain Gloves
-- armor, from 28 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2992);
UPDATE `applied_item_updates` SET `entry` = 2992, `version` = 3368 WHERE (`entry` = 2992);
-- Plain Robe
-- armor, from 8 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2612);
UPDATE `applied_item_updates` SET `entry` = 2612, `version` = 3368 WHERE (`entry` = 2612);
-- Heavy Weave Gloves
-- armor, from 8 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 839);
UPDATE `applied_item_updates` SET `entry` = 839, `version` = 3368 WHERE (`entry` = 839);
-- Runic Cloth Bracers
-- buy_price, from 566 to 651
-- sell_price, from 113 to 130
-- item_level, from 17 to 18
-- required_level, from 12 to 8
-- armor, from 8 to 2
UPDATE `item_template` SET `buy_price` = 651, `sell_price` = 130, `item_level` = 18, `required_level` = 8, `armor` = 2 WHERE (`entry` = 3644);
UPDATE `applied_item_updates` SET `entry` = 3644, `version` = 3368 WHERE (`entry` = 3644);
-- Runic Cloth Vest
-- required_level, from 10 to 5
-- stat_value1, from 1 to 3
-- armor, from 16 to 5
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 3, `armor` = 5 WHERE (`entry` = 3310);
UPDATE `applied_item_updates` SET `entry` = 3310, `version` = 3368 WHERE (`entry` = 3310);
-- Medicine Staff
-- required_level, from 7 to 2
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 23.0 to 32
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 23, `dmg_max1` = 32 WHERE (`entry` = 4575);
UPDATE `applied_item_updates` SET `entry` = 4575, `version` = 3368 WHERE (`entry` = 4575);
-- Old Greatsword
-- required_level, from 11 to 4
-- dmg_min1, from 15.0 to 24
-- dmg_max1, from 23.0 to 33
UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 24, `dmg_max1` = 33 WHERE (`entry` = 1513);
UPDATE `applied_item_updates` SET `entry` = 1513, `version` = 3368 WHERE (`entry` = 1513);
-- Ceremonial Leather Tunic
-- name, from Ceremonial Leather Harness to Ceremonial Leather Tunic
-- required_level, from 10 to 5
-- stat_value1, from 1 to 2
-- armor, from 31 to 8
UPDATE `item_template` SET `name` = 'Ceremonial Leather Tunic', `required_level` = 5, `stat_value1` = 2, `armor` = 8 WHERE (`entry` = 3313);
UPDATE `applied_item_updates` SET `entry` = 3313, `version` = 3368 WHERE (`entry` = 3313);
-- Brackwater Boots
-- armor, from 32 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 3302);
UPDATE `applied_item_updates` SET `entry` = 3302, `version` = 3368 WHERE (`entry` = 3302);
-- Dirty Leather Gloves
-- armor, from 7 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 714);
UPDATE `applied_item_updates` SET `entry` = 714, `version` = 3368 WHERE (`entry` = 714);
-- Grunt Axe
-- required_level, from 9 to 4
-- dmg_min1, from 10.0 to 20
-- dmg_max1, from 19.0 to 31
UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 4568);
UPDATE `applied_item_updates` SET `entry` = 4568, `version` = 3368 WHERE (`entry` = 4568);
-- Dirty Leather Vest
-- display_id, from 8717 to 8654
-- armor, from 12 to 3
UPDATE `item_template` SET `display_id` = 8654, `armor` = 3 WHERE (`entry` = 85);
UPDATE `applied_item_updates` SET `entry` = 85, `version` = 3368 WHERE (`entry` = 85);
-- Worn Leather Gloves
-- armor, from 5 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 1422);
UPDATE `applied_item_updates` SET `entry` = 1422, `version` = 3368 WHERE (`entry` = 1422);
-- Rugged Spaulders
-- armor, from 24 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 5254);
UPDATE `applied_item_updates` SET `entry` = 5254, `version` = 3368 WHERE (`entry` = 5254);
-- Brackwater Leggings
-- required_level, from 12 to 7
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 2
-- armor, from 44 to 11
UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 6, `stat_value1` = 2, `armor` = 11 WHERE (`entry` = 3305);
UPDATE `applied_item_updates` SET `entry` = 3305, `version` = 3368 WHERE (`entry` = 3305);
-- Crude Bastard Sword
-- required_level, from 4 to 1
-- dmg_min1, from 7.0 to 13
-- dmg_max1, from 12.0 to 18
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 1412);
UPDATE `applied_item_updates` SET `entry` = 1412, `version` = 3368 WHERE (`entry` = 1412);
-- 3494

-- Boar Handler Gloves
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2547);
UPDATE `applied_item_updates` SET `entry` = 2547, `version` = 3494 WHERE (`entry` = 2547);
-- Rabbit Handler Gloves
-- armor, from 3 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 719);
UPDATE `applied_item_updates` SET `entry` = 719, `version` = 3494 WHERE (`entry` = 719);
-- Dwarven Leather Pants
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 61);
UPDATE `applied_item_updates` SET `entry` = 61, `version` = 3494 WHERE (`entry` = 61);
-- Tarnished Chain Bracers
-- armor, from 9 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2384);
UPDATE `applied_item_updates` SET `entry` = 2384, `version` = 3494 WHERE (`entry` = 2384);
-- Wolf Handler Gloves
-- buy_price, from 32 to 21
-- sell_price, from 6 to 4
-- item_level, from 5 to 4
-- armor, from 19 to 5
UPDATE `item_template` SET `buy_price` = 21, `sell_price` = 4, `item_level` = 4, `armor` = 5 WHERE (`entry` = 6171);
UPDATE `applied_item_updates` SET `entry` = 6171, `version` = 3494 WHERE (`entry` = 6171);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3494 WHERE (`entry` = 48);
-- Thin Cloth Shoes
-- display_id, from 4143 to 3757
UPDATE `item_template` SET `display_id` = 3757 WHERE (`entry` = 2117);
UPDATE `applied_item_updates` SET `entry` = 2117, `version` = 3494 WHERE (`entry` = 2117);
-- Thin Cloth Armor
-- armor, from 6 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2121);
UPDATE `applied_item_updates` SET `entry` = 2121, `version` = 3494 WHERE (`entry` = 2121);
-- Thin Cloth Pants
-- display_id, from 9974 to 2185
UPDATE `item_template` SET `display_id` = 2185 WHERE (`entry` = 2120);
UPDATE `applied_item_updates` SET `entry` = 2120, `version` = 3494 WHERE (`entry` = 2120);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3494 WHERE (`entry` = 2119);
-- Layered Vest
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 60);
UPDATE `applied_item_updates` SET `entry` = 60, `version` = 3494 WHERE (`entry` = 60);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3494 WHERE (`entry` = 3600);
-- Shimmering Robe
-- display_id, from 15221 to 12471
-- required_level, from 17 to 12
-- armor, from 19 to 17
UPDATE `item_template` SET `display_id` = 12471, `required_level` = 12, `armor` = 17 WHERE (`entry` = 6569);
UPDATE `applied_item_updates` SET `entry` = 6569, `version` = 3494 WHERE (`entry` = 6569);
-- Shimmering Boots
-- display_id, from 14749 to 12466
-- buy_price, from 2923 to 3304
-- sell_price, from 584 to 660
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- armor, from 13 to 12
UPDATE `item_template` SET `display_id` = 12466, `buy_price` = 3304, `sell_price` = 660, `item_level` = 23, `required_level` = 13, `armor` = 12 WHERE (`entry` = 6562);
UPDATE `applied_item_updates` SET `entry` = 6562, `version` = 3494 WHERE (`entry` = 6562);
-- Shimmering Cloak
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6564);
UPDATE `applied_item_updates` SET `entry` = 6564, `version` = 3494 WHERE (`entry` = 6564);
-- Fist of the People's Militia
-- required_level, from 12 to 7
-- dmg_min1, from 8.0 to 16
-- dmg_max1, from 15.0 to 25
UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 16, `dmg_max1` = 25 WHERE (`entry` = 1480);
UPDATE `applied_item_updates` SET `entry` = 1480, `version` = 3494 WHERE (`entry` = 1480);
-- Soldier's Shield
-- required_level, from 12 to 7
-- armor, from 87 to 60
UPDATE `item_template` SET `required_level` = 7, `armor` = 60 WHERE (`entry` = 6560);
UPDATE `applied_item_updates` SET `entry` = 6560, `version` = 3494 WHERE (`entry` = 6560);
-- Outfitter Boots
-- armor, from 10 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2691);
UPDATE `applied_item_updates` SET `entry` = 2691, `version` = 3494 WHERE (`entry` = 2691);
-- Pikeman Shield
-- armor, from 19 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 6078);
UPDATE `applied_item_updates` SET `entry` = 6078, `version` = 3494 WHERE (`entry` = 6078);
-- White Leather Jerkin
-- required_level, from 8 to 3
-- armor, from 27 to 24
UPDATE `item_template` SET `required_level` = 3, `armor` = 24 WHERE (`entry` = 2311);
UPDATE `applied_item_updates` SET `entry` = 2311, `version` = 3494 WHERE (`entry` = 2311);
-- Tarnished Chain Vest
-- armor, from 17 to 16
UPDATE `item_template` SET `armor` = 16 WHERE (`entry` = 2379);
UPDATE `applied_item_updates` SET `entry` = 2379, `version` = 3494 WHERE (`entry` = 2379);
-- Tarnished Chain Belt
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2380);
UPDATE `applied_item_updates` SET `entry` = 2380, `version` = 3494 WHERE (`entry` = 2380);
-- Cracked Leather Gloves
-- armor, from 7 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2125);
UPDATE `applied_item_updates` SET `entry` = 2125, `version` = 3494 WHERE (`entry` = 2125);
-- Large Round Shield
-- armor, from 19 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 2129);
UPDATE `applied_item_updates` SET `entry` = 2129, `version` = 3494 WHERE (`entry` = 2129);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3494 WHERE (`entry` = 4344);
-- Violet Scale Armor
-- buy_price, from 5701 to 6442
-- sell_price, from 1140 to 1288
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- stat_value1, from 1 to 3
-- stat_value2, from 1 to 2
-- armor, from 57 to 53
UPDATE `item_template` SET `buy_price` = 6442, `sell_price` = 1288, `item_level` = 23, `required_level` = 13, `stat_value1` = 3, `stat_value2` = 2, `armor` = 53 WHERE (`entry` = 6502);
UPDATE `applied_item_updates` SET `entry` = 6502, `version` = 3494 WHERE (`entry` = 6502);
-- Polished Scale Boots
-- required_level, from 22 to 17
-- armor, from 40 to 36
UPDATE `item_template` SET `required_level` = 17, `armor` = 36 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3494 WHERE (`entry` = 2149);
-- Buckler of the Seas
-- required_level, from 15 to 10
-- armor, from 49 to 39
UPDATE `item_template` SET `required_level` = 10, `armor` = 39 WHERE (`entry` = 1557);
UPDATE `applied_item_updates` SET `entry` = 1557, `version` = 3494 WHERE (`entry` = 1557);
-- Fine Leather Belt
-- required_level, from 11 to 6
-- armor, from 13 to 12
UPDATE `item_template` SET `required_level` = 6, `armor` = 12 WHERE (`entry` = 4246);
UPDATE `applied_item_updates` SET `entry` = 4246, `version` = 3494 WHERE (`entry` = 4246);
-- Fine Leather Gloves
-- quality, from 2 to 1
-- buy_price, from 905 to 542
-- sell_price, from 181 to 108
-- required_level, from 10 to 5
-- armor, from 18 to 14
UPDATE `item_template` SET `quality` = 1, `buy_price` = 542, `sell_price` = 108, `required_level` = 5, `armor` = 14 WHERE (`entry` = 2312);
UPDATE `applied_item_updates` SET `entry` = 2312, `version` = 3494 WHERE (`entry` = 2312);
-- Tarnished Chain Leggings
-- armor, from 15 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 2381);
UPDATE `applied_item_updates` SET `entry` = 2381, `version` = 3494 WHERE (`entry` = 2381);
-- Tarnished Chain Boots
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 2383);
UPDATE `applied_item_updates` SET `entry` = 2383, `version` = 3494 WHERE (`entry` = 2383);
-- Tarnished Chain Gloves
-- armor, from 10 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2385);
UPDATE `applied_item_updates` SET `entry` = 2385, `version` = 3494 WHERE (`entry` = 2385);
-- Calico Gloves
-- required_level, from 10 to 5
-- armor, from 6 to 5
UPDATE `item_template` SET `required_level` = 5, `armor` = 5 WHERE (`entry` = 1498);
UPDATE `applied_item_updates` SET `entry` = 1498, `version` = 3494 WHERE (`entry` = 1498);
-- Thin Cloth Belt
-- armor, from 3 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3599);
UPDATE `applied_item_updates` SET `entry` = 3599, `version` = 3494 WHERE (`entry` = 3599);
-- Sharp Axe
-- display_id, from 5012 to 1383
-- required_level, from 5 to 1
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 13.0 to 21
UPDATE `item_template` SET `display_id` = 1383, `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 21 WHERE (`entry` = 1011);
UPDATE `applied_item_updates` SET `entry` = 1011, `version` = 3494 WHERE (`entry` = 1011);
-- Robe of the Keeper
-- required_level, from 10 to 5
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 3
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 3161);
UPDATE `applied_item_updates` SET `entry` = 3161, `version` = 3494 WHERE (`entry` = 3161);
-- Calico Belt
-- required_level, from 9 to 4
UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 3374);
UPDATE `applied_item_updates` SET `entry` = 3374, `version` = 3494 WHERE (`entry` = 3374);
-- Large Bear Tooth
-- buy_price, from 190 to 290
-- sell_price, from 47 to 72
UPDATE `item_template` SET `buy_price` = 290, `sell_price` = 72 WHERE (`entry` = 3170);
UPDATE `applied_item_updates` SET `entry` = 3170, `version` = 3494 WHERE (`entry` = 3170);
-- Berserker Pauldrons
-- name, from Cutthroat Pauldrons to Berserker Pauldrons
-- required_level, from 20 to 15
-- armor, from 49 to 45
UPDATE `item_template` SET `name` = 'Berserker Pauldrons', `required_level` = 15, `armor` = 45 WHERE (`entry` = 3231);
UPDATE `applied_item_updates` SET `entry` = 3231, `version` = 3494 WHERE (`entry` = 3231);
-- Darkshire Mail Leggings
-- required_level, from 21 to 16
-- stat_value1, from 3 to 6
-- armor, from 54 to 49
-- holy_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 6, `armor` = 49, `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3494 WHERE (`entry` = 2906);
-- Battleforge Boots
-- required_level, from 20 to 15
-- armor, from 42 to 38
UPDATE `item_template` SET `required_level` = 15, `armor` = 38 WHERE (`entry` = 6590);
UPDATE `applied_item_updates` SET `entry` = 6590, `version` = 3494 WHERE (`entry` = 6590);
-- Silvered Bronze Gauntlets
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 3483);
UPDATE `applied_item_updates` SET `entry` = 3483, `version` = 3494 WHERE (`entry` = 3483);
-- Fen Keeper Robe
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 3558);
UPDATE `applied_item_updates` SET `entry` = 3558, `version` = 3494 WHERE (`entry` = 3558);
-- Lesser Belt of the Spire
-- required_level, from 17 to 12
UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1299);
UPDATE `applied_item_updates` SET `entry` = 1299, `version` = 3494 WHERE (`entry` = 1299);
-- Phoenix Pants
-- required_level, from 20 to 15
-- stat_type1, from 5 to 6
-- stat_value1, from 2 to 3
-- stat_value2, from 1 to 2
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 6, `stat_value1` = 3, `stat_value2` = 2, `armor` = 16 WHERE (`entry` = 4317);
UPDATE `applied_item_updates` SET `entry` = 4317, `version` = 3494 WHERE (`entry` = 4317);
-- Wandering Boots
-- buy_price, from 3440 to 3437
-- sell_price, from 688 to 687
-- required_level, from 19 to 14
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 2
-- armor, from 14 to 13
UPDATE `item_template` SET `buy_price` = 3437, `sell_price` = 687, `required_level` = 14, `stat_type1` = 6, `stat_value1` = 2, `armor` = 13 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3494 WHERE (`entry` = 6095);
-- Shimmering Bracers
-- display_id, from 14750 to 12467
-- required_level, from 16 to 11
UPDATE `item_template` SET `display_id` = 12467, `required_level` = 11 WHERE (`entry` = 6563);
UPDATE `applied_item_updates` SET `entry` = 6563, `version` = 3494 WHERE (`entry` = 6563);
-- Phoenix Gloves
-- required_level, from 20 to 15
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 15, `armor` = 10 WHERE (`entry` = 4331);
UPDATE `applied_item_updates` SET `entry` = 4331, `version` = 3494 WHERE (`entry` = 4331);
-- Hardened Root Staff
-- required_level, from 20 to 15
-- stat_value1, from 2 to 4
-- dmg_min1, from 40.0 to 50
-- dmg_max1, from 60.0 to 69
UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 4, `dmg_min1` = 50, `dmg_max1` = 69 WHERE (`entry` = 1317);
UPDATE `applied_item_updates` SET `entry` = 1317, `version` = 3494 WHERE (`entry` = 1317);
-- Scalemail Boots
-- required_level, from 17 to 12
-- armor, from 36 to 33
UPDATE `item_template` SET `required_level` = 12, `armor` = 33 WHERE (`entry` = 287);
UPDATE `applied_item_updates` SET `entry` = 287, `version` = 3494 WHERE (`entry` = 287);
-- Large Metal Shield
-- required_level, from 17 to 12
-- armor, from 83 to 52
UPDATE `item_template` SET `required_level` = 12, `armor` = 52 WHERE (`entry` = 2445);
UPDATE `applied_item_updates` SET `entry` = 2445, `version` = 3494 WHERE (`entry` = 2445);
-- Cracked Leather Vest
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 2127);
UPDATE `applied_item_updates` SET `entry` = 2127, `version` = 3494 WHERE (`entry` = 2127);
-- Polished Scale Gloves
-- required_level, from 22 to 17
-- armor, from 32 to 30
UPDATE `item_template` SET `required_level` = 17, `armor` = 30 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3494 WHERE (`entry` = 2151);
-- Thelsamar Axe
-- required_level, from 13 to 8
-- dmg_min1, from 11.0 to 22
-- dmg_max1, from 21.0 to 34
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 3154);
UPDATE `applied_item_updates` SET `entry` = 3154, `version` = 3494 WHERE (`entry` = 3154);
-- Tusken Helm
-- display_id, from 15492 to 13289
-- required_level, from 27 to 22
-- stat_value2, from 5 to 7
-- armor, from 45 to 41
UPDATE `item_template` SET `display_id` = 13289, `required_level` = 22, `stat_value2` = 7, `armor` = 41 WHERE (`entry` = 6686);
UPDATE `applied_item_updates` SET `entry` = 6686, `version` = 3494 WHERE (`entry` = 6686);
-- Green Iron Shoulders
-- required_level, from 27 to 22
-- stat_value1, from 2 to 3
-- armor, from 58 to 53
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `armor` = 53 WHERE (`entry` = 3840);
UPDATE `applied_item_updates` SET `entry` = 3840, `version` = 3494 WHERE (`entry` = 3840);
-- Battleforge Girdle
-- buy_price, from 4631 to 5310
-- sell_price, from 926 to 1062
-- item_level, from 26 to 28
-- required_level, from 21 to 18
-- armor, from 27 to 26
UPDATE `item_template` SET `buy_price` = 5310, `sell_price` = 1062, `item_level` = 28, `required_level` = 18, `armor` = 26 WHERE (`entry` = 6594);
UPDATE `applied_item_updates` SET `entry` = 6594, `version` = 3494 WHERE (`entry` = 6594);
-- Green Iron Boots
-- required_level, from 24 to 19
-- stat_value1, from 3 to 4
-- armor, from 46 to 42
UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 4, `armor` = 42 WHERE (`entry` = 3484);
UPDATE `applied_item_updates` SET `entry` = 3484, `version` = 3494 WHERE (`entry` = 3484);
-- Linked Chain Shoulderpads
-- required_level, from 16 to 11
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 11, `armor` = 26 WHERE (`entry` = 1752);
UPDATE `applied_item_updates` SET `entry` = 1752, `version` = 3494 WHERE (`entry` = 1752);
-- Cured Leather Belt
-- required_level, from 17 to 12
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 12, `armor` = 14 WHERE (`entry` = 1849);
UPDATE `applied_item_updates` SET `entry` = 1849, `version` = 3494 WHERE (`entry` = 1849);
-- Cured Leather Bracers
-- required_level, from 17 to 12
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 12, `armor` = 16 WHERE (`entry` = 1850);
UPDATE `applied_item_updates` SET `entry` = 1850, `version` = 3494 WHERE (`entry` = 1850);
-- Thick Cloth Boots
-- name, from Thick Cloth Shoes to Thick Cloth Boots
-- display_id, from 3757 to 2301
-- required_level, from 17 to 12
-- armor, from 12 to 11
UPDATE `item_template` SET `name` = 'Thick Cloth Boots', `display_id` = 2301, `required_level` = 12, `armor` = 11 WHERE (`entry` = 202);
UPDATE `applied_item_updates` SET `entry` = 202, `version` = 3494 WHERE (`entry` = 202);
-- Chipped Quarterstaff
-- required_level, from 15 to 8
-- dmg_min1, from 16.0 to 25
-- dmg_max1, from 25.0 to 34
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 25, `dmg_max1` = 34 WHERE (`entry` = 1813);
UPDATE `applied_item_updates` SET `entry` = 1813, `version` = 3494 WHERE (`entry` = 1813);
-- Wizard's Belt
-- required_level, from 23 to 18
-- stat_value1, from 12 to 37
-- armor, from 10 to 9
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 37, `armor` = 9 WHERE (`entry` = 4827);
UPDATE `applied_item_updates` SET `entry` = 4827, `version` = 3494 WHERE (`entry` = 4827);
-- Scarab Trousers
-- buy_price, from 2705 to 2713
-- sell_price, from 541 to 542
-- required_level, from 15 to 10
-- stat_type1, from 6 to 5
-- stat_value1, from 1 to 2
-- stat_type2, from 7 to 6
-- stat_value2, from 1 to 2
-- armor, from 16 to 14
UPDATE `item_template` SET `buy_price` = 2713, `sell_price` = 542, `required_level` = 10, `stat_type1` = 5, `stat_value1` = 2, `stat_type2` = 6, `stat_value2` = 2, `armor` = 14 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3494 WHERE (`entry` = 6659);
-- Sage's Bracers
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6613);
UPDATE `applied_item_updates` SET `entry` = 6613, `version` = 3494 WHERE (`entry` = 6613);
-- Gold-flecked Gloves
-- required_level, from 16 to 11
-- stat_type1, from 5 to 6
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 6, `armor` = 10 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3494 WHERE (`entry` = 5195);
-- Sage's Cloak
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6614);
UPDATE `applied_item_updates` SET `entry` = 6614, `version` = 3494 WHERE (`entry` = 6614);
-- Tear of Grief
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 5611);
UPDATE `applied_item_updates` SET `entry` = 5611, `version` = 3494 WHERE (`entry` = 5611);
-- Frostweave Robe
-- required_level, from 27 to 22
-- stat_value1, from 2 to 4
-- stat_value2, from 4 to 5
-- armor, from 24 to 22
-- frost_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `stat_value2` = 5, `armor` = 22, `frost_res` = 1 WHERE (`entry` = 4035);
UPDATE `applied_item_updates` SET `entry` = 4035, `version` = 3494 WHERE (`entry` = 4035);
-- Flameweave Pants
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3067);
UPDATE `applied_item_updates` SET `entry` = 3067, `version` = 3494 WHERE (`entry` = 3067);
-- Flameweave Bracers
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3647);
UPDATE `applied_item_updates` SET `entry` = 3647, `version` = 3494 WHERE (`entry` = 3647);
-- Coral Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5000);
UPDATE `applied_item_updates` SET `entry` = 5000, `version` = 3494 WHERE (`entry` = 5000);
-- Flameweave Cloak
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6381);
UPDATE `applied_item_updates` SET `entry` = 6381, `version` = 3494 WHERE (`entry` = 6381);
-- Raptorbane Tunic
-- spellid_1, from 14565 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3566);
UPDATE `applied_item_updates` SET `entry` = 3566, `version` = 3494 WHERE (`entry` = 3566);
-- Studded Leather Belt
-- name, from Studded Belt to Studded Leather Belt
-- required_level, from 32 to 27
-- stat_value1, from 15 to 30
-- armor, from 21 to 19
UPDATE `item_template` SET `name` = 'Studded Leather Belt', `required_level` = 27, `stat_value1` = 30, `armor` = 19 WHERE (`entry` = 2464);
UPDATE `applied_item_updates` SET `entry` = 2464, `version` = 3494 WHERE (`entry` = 2464);
-- Swampwalker Boots
-- stat_value1, from 3 to 5
-- stat_type2, from 7 to 6
-- stat_value2, from 2 to 3
-- armor, from 33 to 30
UPDATE `item_template` SET `stat_value1` = 5, `stat_type2` = 6, `stat_value2` = 3, `armor` = 30 WHERE (`entry` = 2276);
UPDATE `applied_item_updates` SET `entry` = 2276, `version` = 3494 WHERE (`entry` = 2276);
-- Wolfclaw Gloves
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 4
-- armor, from 25 to 23
UPDATE `item_template` SET `stat_value1` = 3, `stat_value2` = 4, `armor` = 23 WHERE (`entry` = 1978);
UPDATE `applied_item_updates` SET `entry` = 1978, `version` = 3494 WHERE (`entry` = 1978);
-- Blackvenom Blade
-- dmg_min1, from 15.0 to 25
-- dmg_max1, from 29.0 to 38
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 5 to 0
-- spellid_1, from 13518 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min1` = 25, `dmg_max1` = 38, `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4446);
UPDATE `applied_item_updates` SET `entry` = 4446, `version` = 3494 WHERE (`entry` = 4446);
-- Sage's Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6610);
UPDATE `applied_item_updates` SET `entry` = 6610, `version` = 3494 WHERE (`entry` = 6610);
-- Sage's Belt
-- name, from Sage's Sash to Sage's Belt
-- display_id, from 14762 to 12510
-- required_level, from 20 to 15
-- armor, from 9 to 8
UPDATE `item_template` SET `name` = 'Sage\'s Belt', `display_id` = 12510, `required_level` = 15, `armor` = 8 WHERE (`entry` = 6611);
UPDATE `applied_item_updates` SET `entry` = 6611, `version` = 3494 WHERE (`entry` = 6611);
-- Heavy Woolen Pants
-- required_level, from 17 to 12
-- stat_value1, from 2 to 5
-- armor, from 17 to 15
UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 5, `armor` = 15 WHERE (`entry` = 4316);
UPDATE `applied_item_updates` SET `entry` = 4316, `version` = 3494 WHERE (`entry` = 4316);
-- Resilient Poncho
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3561);
UPDATE `applied_item_updates` SET `entry` = 3561, `version` = 3494 WHERE (`entry` = 3561);
-- Dervish Tunic
-- display_id, from 14773 to 12499
-- buy_price, from 7056 to 6474
-- sell_price, from 1411 to 1294
-- required_level, from 20 to 15
-- armor, from 41 to 37
UPDATE `item_template` SET `display_id` = 12499, `buy_price` = 6474, `sell_price` = 1294, `required_level` = 15, `armor` = 37 WHERE (`entry` = 6603);
UPDATE `applied_item_updates` SET `entry` = 6603, `version` = 3494 WHERE (`entry` = 6603);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3494 WHERE (`entry` = 4496);
-- Silvered Bronze Breastplate
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 3
-- armor, from 62 to 56
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `stat_value2` = 3, `armor` = 56, `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3494 WHERE (`entry` = 2869);
-- Small Dagger
-- required_level, from 15 to 8
-- dmg_min1, from 4.0 to 9
-- dmg_max1, from 9.0 to 14
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2764);
UPDATE `applied_item_updates` SET `entry` = 2764, `version` = 3494 WHERE (`entry` = 2764);
-- Dark Leather Shoulders
-- required_level, from 23 to 18
-- stat_type1, from 3 to 1
-- stat_value1, from 2 to 35
-- armor, from 35 to 32
UPDATE `item_template` SET `required_level` = 18, `stat_type1` = 1, `stat_value1` = 35, `armor` = 32 WHERE (`entry` = 4252);
UPDATE `applied_item_updates` SET `entry` = 4252, `version` = 3494 WHERE (`entry` = 4252);
-- Toughened Leather Armor
-- display_id, from 1819 to 9531
UPDATE `item_template` SET `display_id` = 9531 WHERE (`entry` = 2314);
UPDATE `applied_item_updates` SET `entry` = 2314, `version` = 3494 WHERE (`entry` = 2314);
-- Cloak of Night
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4447);
UPDATE `applied_item_updates` SET `entry` = 4447, `version` = 3494 WHERE (`entry` = 4447);
-- Wyvern Tailspike
-- required_level, from 21 to 16
-- dmg_min1, from 14.0 to 24
-- dmg_max1, from 27.0 to 37
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 24, `dmg_max1` = 37, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5752);
UPDATE `applied_item_updates` SET `entry` = 5752, `version` = 3494 WHERE (`entry` = 5752);
-- Grey Iron Sword
-- name, from Umbral Sword to Grey Iron Sword
-- required_level, from 10 to 5
-- dmg_min1, from 9.0 to 20
-- dmg_max1, from 18.0 to 30
UPDATE `item_template` SET `name` = 'Grey Iron Sword', `required_level` = 5, `dmg_min1` = 20, `dmg_max1` = 30 WHERE (`entry` = 6984);
UPDATE `applied_item_updates` SET `entry` = 6984, `version` = 3494 WHERE (`entry` = 6984);
-- Polished Scale Bracers
-- required_level, from 22 to 17
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 17, `armor` = 26 WHERE (`entry` = 2150);
UPDATE `applied_item_updates` SET `entry` = 2150, `version` = 3494 WHERE (`entry` = 2150);
-- Hardened Iron Shortsword
-- required_level, from 27 to 22
-- stat_value1, from 20 to 42
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 35.0 to 42
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 42, `dmg_min1` = 28, `dmg_max1` = 42 WHERE (`entry` = 3849);
UPDATE `applied_item_updates` SET `entry` = 3849, `version` = 3494 WHERE (`entry` = 3849);
-- Coldridge Hammer
-- required_level, from 7 to 2
-- dmg_min1, from 16.0 to 25
-- dmg_max1, from 24.0 to 34
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 25, `dmg_max1` = 34 WHERE (`entry` = 3103);
UPDATE `applied_item_updates` SET `entry` = 3103, `version` = 3494 WHERE (`entry` = 3103);
-- Seer's Cape
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6378);
UPDATE `applied_item_updates` SET `entry` = 6378, `version` = 3494 WHERE (`entry` = 6378);
-- Seafarer's Pantaloons
-- required_level, from 15 to 10
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2, `stat_value2` = 2, `armor` = 14 WHERE (`entry` = 3563);
UPDATE `applied_item_updates` SET `entry` = 3563, `version` = 3494 WHERE (`entry` = 3563);
-- Staff of Nobles
-- required_level, from 13 to 8
-- stat_value1, from 1 to 2
-- dmg_min1, from 26.0 to 40
-- dmg_max1, from 40.0 to 55
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 2, `dmg_min1` = 40, `dmg_max1` = 55 WHERE (`entry` = 3902);
UPDATE `applied_item_updates` SET `entry` = 3902, `version` = 3494 WHERE (`entry` = 3902);
-- Cracked Leather Boots
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2123);
UPDATE `applied_item_updates` SET `entry` = 2123, `version` = 3494 WHERE (`entry` = 2123);
-- Cracked Leather Bracers
-- armor, from 6 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2124);
UPDATE `applied_item_updates` SET `entry` = 2124, `version` = 3494 WHERE (`entry` = 2124);
-- Giant Tarantula Fang
-- required_level, from 10 to 5
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 12.0 to 20
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 1287);
UPDATE `applied_item_updates` SET `entry` = 1287, `version` = 3494 WHERE (`entry` = 1287);
-- Grayson's Torch
-- required_level, from 16 to 11
-- stat_value1, from 1 to 2
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 2 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3494 WHERE (`entry` = 1172);
-- Bloody Apron
-- required_level, from 17 to 12
-- stat_value1, from 2 to 5
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 5, `armor` = 17 WHERE (`entry` = 6226);
UPDATE `applied_item_updates` SET `entry` = 6226, `version` = 3494 WHERE (`entry` = 6226);
-- Seer's Sash
-- name, from Seer's Belt to Seer's Sash
-- buy_price, from 1934 to 2186
-- sell_price, from 386 to 437
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- stat_type1, from 5 to 6
UPDATE `item_template` SET `name` = 'Seer\'s Sash', `buy_price` = 2186, `sell_price` = 437, `item_level` = 23, `required_level` = 13, `stat_type1` = 6 WHERE (`entry` = 4699);
UPDATE `applied_item_updates` SET `entry` = 4699, `version` = 3494 WHERE (`entry` = 4699);
-- Fractured Canine
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3299);
UPDATE `applied_item_updates` SET `entry` = 3299, `version` = 3494 WHERE (`entry` = 3299);
-- Metalworking Gloves
-- required_level, from 13 to 8
-- stat_type1, from 1 to 7
-- stat_value1, from 10 to 2
-- armor, from 19 to 18
UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 7, `stat_value1` = 2, `armor` = 18 WHERE (`entry` = 1944);
UPDATE `applied_item_updates` SET `entry` = 1944, `version` = 3494 WHERE (`entry` = 1944);
-- Sword of the Night Sky
-- required_level, from 19 to 14
-- dmg_min1, from 12.0 to 22
-- dmg_max1, from 23.0 to 33
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 22, `dmg_max1` = 33 WHERE (`entry` = 2035);
UPDATE `applied_item_updates` SET `entry` = 2035, `version` = 3494 WHERE (`entry` = 2035);
-- Runed Copper Breastplate
-- required_level, from 13 to 8
-- stat_value1, from 1 to 4
-- armor, from 52 to 47
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 4, `armor` = 47 WHERE (`entry` = 2864);
UPDATE `applied_item_updates` SET `entry` = 2864, `version` = 3494 WHERE (`entry` = 2864);
-- Edge of the People's Militia
-- required_level, from 12 to 7
-- dmg_min1, from 22.0 to 35
-- dmg_max1, from 34.0 to 48
UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 35, `dmg_max1` = 48 WHERE (`entry` = 1566);
UPDATE `applied_item_updates` SET `entry` = 1566, `version` = 3494 WHERE (`entry` = 1566);
-- Haggard's Axe
-- required_level, from 10 to 5
-- dmg_min1, from 12.0 to 25
-- dmg_max1, from 23.0 to 39
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3494 WHERE (`entry` = 6979);
-- Rose Mantle
-- required_level, from 22 to 17
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 17, `armor` = 16 WHERE (`entry` = 5274);
UPDATE `applied_item_updates` SET `entry` = 5274, `version` = 3494 WHERE (`entry` = 5274);
-- Harlequin Robes
-- buy_price, from 3814 to 4310
-- sell_price, from 762 to 862
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- stat_value1, from 1 to 4
-- stat_value2, from 1 to 2
-- armor, from 19 to 18
UPDATE `item_template` SET `buy_price` = 4310, `sell_price` = 862, `item_level` = 23, `required_level` = 13, `stat_value1` = 4, `stat_value2` = 2, `armor` = 18 WHERE (`entry` = 6503);
UPDATE `applied_item_updates` SET `entry` = 6503, `version` = 3494 WHERE (`entry` = 6503);
-- Emberstone Staff
-- spellid_1, from 0 to 2229
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `spellid_1` = 2229, `spelltrigger_1` = 1 WHERE (`entry` = 5201);
UPDATE `applied_item_updates` SET `entry` = 5201, `version` = 3494 WHERE (`entry` = 5201);
-- Bent Large Shield
-- armor, from 10 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2211);
UPDATE `applied_item_updates` SET `entry` = 2211, `version` = 3494 WHERE (`entry` = 2211);
-- Greater Adept's Robe
-- required_level, from 18 to 13
-- stat_value1, from 2 to 5
-- armor, from 20 to 18
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 5, `armor` = 18 WHERE (`entry` = 6264);
UPDATE `applied_item_updates` SET `entry` = 6264, `version` = 3494 WHERE (`entry` = 6264);
-- Gloves of Meditation
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `armor` = 11 WHERE (`entry` = 4318);
UPDATE `applied_item_updates` SET `entry` = 4318, `version` = 3494 WHERE (`entry` = 4318);
-- Web-covered Boots
-- required_level, from 5 to 1
-- armor, from 8 to 7
UPDATE `item_template` SET `required_level` = 1, `armor` = 7 WHERE (`entry` = 6148);
UPDATE `applied_item_updates` SET `entry` = 6148, `version` = 3494 WHERE (`entry` = 6148);
-- Girdle of the Blindwatcher
-- required_level, from 19 to 14
-- stat_type1, from 5 to 3
-- stat_value1, from 1 to 2
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 14, `stat_type1` = 3, `stat_value1` = 2, `armor` = 16 WHERE (`entry` = 6319);
UPDATE `applied_item_updates` SET `entry` = 6319, `version` = 3494 WHERE (`entry` = 6319);
-- Bluegill Breeches
-- required_level, from 18 to 13
-- stat_value1, from 2 to 5
-- armor, from 34 to 31
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 5, `armor` = 31 WHERE (`entry` = 3022);
UPDATE `applied_item_updates` SET `entry` = 3022, `version` = 3494 WHERE (`entry` = 3022);
-- Wolf Bracers
-- required_level, from 20 to 15
-- stat_type1, from 3 to 7
-- armor, from 20 to 18
UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 7, `armor` = 18 WHERE (`entry` = 4794);
UPDATE `applied_item_updates` SET `entry` = 4794, `version` = 3494 WHERE (`entry` = 4794);
-- Webwing Cloak
-- nature_res, from 0 to 2
-- frost_res, from 0 to 2
UPDATE `item_template` SET `nature_res` = 2, `frost_res` = 2 WHERE (`entry` = 5751);
UPDATE `applied_item_updates` SET `entry` = 5751, `version` = 3494 WHERE (`entry` = 5751);
-- Scouting Trousers
-- display_id, from 14757 to 12484
-- buy_price, from 4489 to 5070
-- sell_price, from 897 to 1014
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- armor, from 33 to 31
UPDATE `item_template` SET `display_id` = 12484, `buy_price` = 5070, `sell_price` = 1014, `item_level` = 23, `required_level` = 13, `armor` = 31 WHERE (`entry` = 6587);
UPDATE `applied_item_updates` SET `entry` = 6587, `version` = 3494 WHERE (`entry` = 6587);
-- Deputy Chain Coat
-- required_level, from 20 to 15
-- stat_value2, from 2 to 4
-- armor, from 61 to 55
UPDATE `item_template` SET `required_level` = 15, `stat_value2` = 4, `armor` = 55 WHERE (`entry` = 1275);
UPDATE `applied_item_updates` SET `entry` = 1275, `version` = 3494 WHERE (`entry` = 1275);
-- Black Metal Shortsword
-- required_level, from 21 to 16
-- dmg_min1, from 13.0 to 23
-- dmg_max1, from 26.0 to 35
-- shadow_res, from 4 to 0
UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 23, `dmg_max1` = 35, `shadow_res` = 0 WHERE (`entry` = 886);
UPDATE `applied_item_updates` SET `entry` = 886, `version` = 3494 WHERE (`entry` = 886);
-- Girdle of Nobility
-- required_level, from 13 to 8
-- stat_value1, from 7 to 20
-- armor, from 8 to 7
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 20, `armor` = 7 WHERE (`entry` = 5967);
UPDATE `applied_item_updates` SET `entry` = 5967, `version` = 3494 WHERE (`entry` = 5967);
-- Gnarled Ash Staff
-- stat_value1, from 4 to 5
-- stat_value2, from 10 to 30
-- dmg_min1, from 40.0 to 51
-- dmg_max1, from 61.0 to 70
UPDATE `item_template` SET `stat_value1` = 5, `stat_value2` = 30, `dmg_min1` = 51, `dmg_max1` = 70 WHERE (`entry` = 791);
UPDATE `applied_item_updates` SET `entry` = 791, `version` = 3494 WHERE (`entry` = 791);
-- Silvered Bronze Shoulders
-- required_level, from 20 to 15
-- armor, from 49 to 45
UPDATE `item_template` SET `required_level` = 15, `armor` = 45 WHERE (`entry` = 3481);
UPDATE `applied_item_updates` SET `entry` = 3481, `version` = 3494 WHERE (`entry` = 3481);
-- Skeletal Gauntlets
-- required_level, from 12 to 7
-- armor, from 28 to 26
UPDATE `item_template` SET `required_level` = 7, `armor` = 26 WHERE (`entry` = 4676);
UPDATE `applied_item_updates` SET `entry` = 4676, `version` = 3494 WHERE (`entry` = 4676);
-- Spider Silk Slippers
-- required_level, from 23 to 18
-- stat_value1, from 1 to 2
-- stat_value2, from 10 to 37
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `stat_value2` = 37, `armor` = 14 WHERE (`entry` = 4321);
UPDATE `applied_item_updates` SET `entry` = 4321, `version` = 3494 WHERE (`entry` = 4321);
-- Scouting Spaulders
-- display_id, from 14756 to 12485
-- buy_price, from 2027 to 2019
-- sell_price, from 405 to 403
-- required_level, from 17 to 13
-- armor, from 28 to 26
UPDATE `item_template` SET `display_id` = 12485, `buy_price` = 2019, `sell_price` = 403, `required_level` = 13, `armor` = 26 WHERE (`entry` = 6588);
UPDATE `applied_item_updates` SET `entry` = 6588, `version` = 3494 WHERE (`entry` = 6588);
-- Shadow Weaver Leggings
-- buy_price, from 8452 to 6800
-- sell_price, from 1690 to 1360
-- item_level, from 27 to 25
-- required_level, from 22 to 15
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 3
-- armor, from 37 to 32
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `buy_price` = 6800, `sell_price` = 1360, `item_level` = 25, `required_level` = 15, `stat_value1` = 3, `stat_value2` = 3, `armor` = 32, `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3494 WHERE (`entry` = 2233);
-- Robes of Antiquity
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 5812);
UPDATE `applied_item_updates` SET `entry` = 5812, `version` = 3494 WHERE (`entry` = 5812);
-- Mud Stompers
-- required_level, from 10 to 5
-- stat_type1, from 1 to 7
-- stat_value1, from 3 to 1
-- armor, from 32 to 29
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 7, `stat_value1` = 1, `armor` = 29 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3494 WHERE (`entry` = 6188);
-- Tempered Bracers
-- buy_price, from 5244 to 4828
-- sell_price, from 1048 to 965
-- required_level, from 22 to 17
-- stat_value2, from 5 to 1
-- armor, from 32 to 29
UPDATE `item_template` SET `buy_price` = 4828, `sell_price` = 965, `required_level` = 17, `stat_value2` = 1, `armor` = 29 WHERE (`entry` = 6675);
UPDATE `applied_item_updates` SET `entry` = 6675, `version` = 3494 WHERE (`entry` = 6675);
-- Ritual Blade
-- required_level, from 10 to 5
-- dmg_min1, from 6.0 to 12
-- dmg_max1, from 12.0 to 18
-- spellid_1, from 0 to 686
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 12, `dmg_max1` = 18, `spellid_1` = 686, `spelltrigger_1` = 2 WHERE (`entry` = 5112);
UPDATE `applied_item_updates` SET `entry` = 5112, `version` = 3494 WHERE (`entry` = 5112);
-- Blood Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 4998);
UPDATE `applied_item_updates` SET `entry` = 4998, `version` = 3494 WHERE (`entry` = 4998);
-- Smooth Walking Staff
-- required_level, from 2 to 1
-- dmg_min1, from 9.0 to 15
-- dmg_max1, from 14.0 to 21
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 15, `dmg_max1` = 21 WHERE (`entry` = 5581);
UPDATE `applied_item_updates` SET `entry` = 5581, `version` = 3494 WHERE (`entry` = 5581);
-- Cured Leather Vest
-- name, from Cured Leather Armor to Cured Leather Vest
-- required_level, from 17 to 12
-- armor, from 35 to 32
UPDATE `item_template` SET `name` = 'Cured Leather Vest', `required_level` = 12, `armor` = 32 WHERE (`entry` = 236);
UPDATE `applied_item_updates` SET `entry` = 236, `version` = 3494 WHERE (`entry` = 236);
-- Cured Leather Gloves
-- required_level, from 17 to 12
-- armor, from 20 to 18
UPDATE `item_template` SET `required_level` = 12, `armor` = 18 WHERE (`entry` = 239);
UPDATE `applied_item_updates` SET `entry` = 239, `version` = 3494 WHERE (`entry` = 239);
-- Solid Shortblade
-- required_level, from 13 to 8
-- dmg_min1, from 13.0 to 30
-- dmg_max1, from 25.0 to 37
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 30, `dmg_max1` = 37 WHERE (`entry` = 2074);
UPDATE `applied_item_updates` SET `entry` = 2074, `version` = 3494 WHERE (`entry` = 2074);
-- Armor of the Fang
-- buy_price, from 4471 to 4486
-- sell_price, from 894 to 897
-- required_level, from 17 to 12
-- stat_value1, from 1 to 2
-- stat_type2, from 4 to 6
-- stat_value2, from 1 to 2
-- stat_type3, from 1 to 7
-- stat_value3, from 5 to 3
-- armor, from 38 to 35
UPDATE `item_template` SET `buy_price` = 4486, `sell_price` = 897, `required_level` = 12, `stat_value1` = 2, `stat_type2` = 6, `stat_value2` = 2, `stat_type3` = 7, `stat_value3` = 3, `armor` = 35 WHERE (`entry` = 6473);
UPDATE `applied_item_updates` SET `entry` = 6473, `version` = 3494 WHERE (`entry` = 6473);
-- Band of Vitality
-- name, from Heart Ring to Band of Vitality
-- display_id, from 9834 to 9833
-- required_level, from 25 to 20
-- max_count, from 1 to 0
-- stat_value1, from 3 to 4
UPDATE `item_template` SET `name` = 'Band of Vitality', `display_id` = 9833, `required_level` = 20, `max_count` = 0, `stat_value1` = 4 WHERE (`entry` = 5001);
UPDATE `applied_item_updates` SET `entry` = 5001, `version` = 3494 WHERE (`entry` = 5001);
-- Forest Tracker Epaulets
-- stat_value1, from 2 to 4
-- armor, from 39 to 35
UPDATE `item_template` SET `stat_value1` = 4, `armor` = 35 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3494 WHERE (`entry` = 2278);
-- Sage's Armor
-- display_id, from 14761 to 12508
-- buy_price, from 6669 to 6438
-- sell_price, from 1333 to 1287
-- required_level, from 22 to 17
-- armor, from 21 to 19
-- fire_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12508, `buy_price` = 6438, `sell_price` = 1287, `required_level` = 17, `armor` = 19, `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3494 WHERE (`entry` = 6609);
-- Silk-threaded Trousers
-- required_level, from 13 to 8
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 4
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 6, `stat_value1` = 4, `armor` = 14 WHERE (`entry` = 1929);
UPDATE `applied_item_updates` SET `entry` = 1929, `version` = 3494 WHERE (`entry` = 1929);
-- Calico Cloak
-- required_level, from 9 to 4
UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 1497);
UPDATE `applied_item_updates` SET `entry` = 1497, `version` = 3494 WHERE (`entry` = 1497);
-- Worn Mail Belt
-- required_level, from 7 to 2
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 2, `armor` = 11 WHERE (`entry` = 1730);
UPDATE `applied_item_updates` SET `entry` = 1730, `version` = 3494 WHERE (`entry` = 1730);
-- Rabbit's Foot
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3300);
UPDATE `applied_item_updates` SET `entry` = 3300, `version` = 3494 WHERE (`entry` = 3300);
-- Gemmed Copper Gauntlets
-- required_level, from 10 to 5
-- armor, from 26 to 24
UPDATE `item_template` SET `required_level` = 5, `armor` = 24 WHERE (`entry` = 3474);
UPDATE `applied_item_updates` SET `entry` = 3474, `version` = 3494 WHERE (`entry` = 3474);
-- Defender Buckler
-- name, from Scouting Buckler to Defender Buckler
-- buy_price, from 3584 to 3528
-- sell_price, from 716 to 705
-- required_level, from 15 to 10
-- armor, from 49 to 39
UPDATE `item_template` SET `name` = 'Defender Buckler', `buy_price` = 3528, `sell_price` = 705, `required_level` = 10, `armor` = 39 WHERE (`entry` = 6571);
UPDATE `applied_item_updates` SET `entry` = 6571, `version` = 3494 WHERE (`entry` = 6571);
-- Spiked Axe
-- name, from Smite's Reaver to Spiked Axe
-- required_level, from 17 to 12
-- dmg_min1, from 12.0 to 23
-- dmg_max1, from 24.0 to 35
UPDATE `item_template` SET `name` = 'Spiked Axe', `required_level` = 12, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 5196);
UPDATE `applied_item_updates` SET `entry` = 5196, `version` = 3494 WHERE (`entry` = 5196);
-- Snapbrook Armor
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 5814);
UPDATE `applied_item_updates` SET `entry` = 5814, `version` = 3494 WHERE (`entry` = 5814);
-- Red Woolen Boots
-- required_level, from 15 to 10
-- stat_value1, from 1 to 2
-- armor, from 13 to 11
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2, `armor` = 11 WHERE (`entry` = 4313);
UPDATE `applied_item_updates` SET `entry` = 4313, `version` = 3494 WHERE (`entry` = 4313);
-- Lancer Boots
-- required_level, from 25 to 20
-- stat_value1, from 1 to 2
-- stat_value2, from 20 to 35
-- armor, from 31 to 29
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `stat_value2` = 35, `armor` = 29 WHERE (`entry` = 6752);
UPDATE `applied_item_updates` SET `entry` = 6752, `version` = 3494 WHERE (`entry` = 6752);
-- Ebon Scimitar
-- required_level, from 24 to 19
-- dmg_min1, from 26.0 to 40
-- dmg_max1, from 49.0 to 61
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 40, `dmg_max1` = 61 WHERE (`entry` = 3186);
UPDATE `applied_item_updates` SET `entry` = 3186, `version` = 3494 WHERE (`entry` = 3186);
-- Patched Leather Pants
-- name, from Warped Leather Pants to Patched Leather Pants
-- required_level, from 9 to 4
-- armor, from 17 to 15
UPDATE `item_template` SET `name` = 'Patched Leather Pants', `required_level` = 4, `armor` = 15 WHERE (`entry` = 1507);
UPDATE `applied_item_updates` SET `entry` = 1507, `version` = 3494 WHERE (`entry` = 1507);
-- Bottle of Pinot Noir (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2723);
UPDATE `applied_item_updates` SET `entry` = 2723, `version` = 3494 WHERE (`entry` = 2723);
-- Flask of Port (needs effect)
-- spellid_1, from 11008 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2593);
UPDATE `applied_item_updates` SET `entry` = 2593, `version` = 3494 WHERE (`entry` = 2593);
-- Skin of Dwarven Stout (needs effect)
-- spellid_1, from 11008 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2596);
UPDATE `applied_item_updates` SET `entry` = 2596, `version` = 3494 WHERE (`entry` = 2596);
-- Flagon of Mead (needs effect)
-- spellid_1, from 1133 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2594);
UPDATE `applied_item_updates` SET `entry` = 2594, `version` = 3494 WHERE (`entry` = 2594);
-- Jug of Bourbon (needs effect)
-- spellid_1, from 1133 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2595);
UPDATE `applied_item_updates` SET `entry` = 2595, `version` = 3494 WHERE (`entry` = 2595);
-- Flameweave Belt
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4708);
UPDATE `applied_item_updates` SET `entry` = 4708, `version` = 3494 WHERE (`entry` = 4708);
-- Frostweave Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4036);
UPDATE `applied_item_updates` SET `entry` = 4036, `version` = 3494 WHERE (`entry` = 4036);
-- Hardwood Cudgel
-- required_level, from 15 to 10
-- dmg_min1, from 15.0 to 29
-- dmg_max1, from 29.0 to 45
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 29, `dmg_max1` = 45 WHERE (`entry` = 5757);
UPDATE `applied_item_updates` SET `entry` = 5757, `version` = 3494 WHERE (`entry` = 5757);
-- Holy Shroud
-- stat_value1, from 5 to 7
-- stat_value2, from 3 to 2
-- armor, from 15 to 14
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `stat_value1` = 7, `stat_value2` = 2, `armor` = 14, `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3494 WHERE (`entry` = 2721);
-- Palm Frond Mantle
-- required_level, from 29 to 24
-- stat_value1, from 18 to 50
-- armor, from 20 to 19
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 50, `armor` = 19 WHERE (`entry` = 4140);
UPDATE `applied_item_updates` SET `entry` = 4140, `version` = 3494 WHERE (`entry` = 4140);
-- Ring of Forlorn Spirits
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 2043);
UPDATE `applied_item_updates` SET `entry` = 2043, `version` = 3494 WHERE (`entry` = 2043);
-- Battering Hammer
-- required_level, from 17 to 12
-- dmg_min1, from 31.0 to 45
-- dmg_max1, from 48.0 to 61
UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 45, `dmg_max1` = 61 WHERE (`entry` = 3198);
UPDATE `applied_item_updates` SET `entry` = 3198, `version` = 3494 WHERE (`entry` = 3198);
-- Chieftain Girdle
-- required_level, from 18 to 13
-- armor, from 26 to 23
UPDATE `item_template` SET `required_level` = 13, `armor` = 23 WHERE (`entry` = 5750);
UPDATE `applied_item_updates` SET `entry` = 5750, `version` = 3494 WHERE (`entry` = 5750);
-- Green Iron Bracers
-- required_level, from 28 to 23
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 23, `armor` = 30 WHERE (`entry` = 3835);
UPDATE `applied_item_updates` SET `entry` = 3835, `version` = 3494 WHERE (`entry` = 3835);
-- Moonsight Rifle
-- required_level, from 24 to 19
-- dmg_min1, from 21.0 to 14
-- dmg_max1, from 40.0 to 21
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 14, `dmg_max1` = 21 WHERE (`entry` = 4383);
UPDATE `applied_item_updates` SET `entry` = 4383, `version` = 3494 WHERE (`entry` = 4383);
-- Darkweave Mantle
-- buy_price, from 12230 to 14529
-- sell_price, from 2446 to 2905
-- item_level, from 36 to 38
-- required_level, from 31 to 28
-- stat_value1, from 2 to 3
-- armor, from 21 to 20
UPDATE `item_template` SET `buy_price` = 14529, `sell_price` = 2905, `item_level` = 38, `required_level` = 28, `stat_value1` = 3, `armor` = 20 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3494 WHERE (`entry` = 4718);
-- Brightweave Robe
-- required_level, from 35 to 30
-- stat_value1, from 8 to 10
-- stat_value2, from 15 to 10
-- armor, from 29 to 26
-- fire_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 10, `stat_value2` = 10, `armor` = 26, `fire_res` = 1 WHERE (`entry` = 6415);
UPDATE `applied_item_updates` SET `entry` = 6415, `version` = 3494 WHERE (`entry` = 6415);
-- Belt of Arugal
-- buy_price, from 4135 to 3862
-- sell_price, from 827 to 772
-- stat_value1, from 25 to 2
-- armor, from 10 to 9
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `buy_price` = 3862, `sell_price` = 772, `stat_value1` = 2, `armor` = 9, `shadow_res` = 4 WHERE (`entry` = 6392);
UPDATE `applied_item_updates` SET `entry` = 6392, `version` = 3494 WHERE (`entry` = 6392);
-- Swampland Trousers
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4505);
UPDATE `applied_item_updates` SET `entry` = 4505, `version` = 3494 WHERE (`entry` = 4505);
-- Orb of Power
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- sheath, from 7 to 0
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `sheath` = 0 WHERE (`entry` = 4838);
UPDATE `applied_item_updates` SET `entry` = 4838, `version` = 3494 WHERE (`entry` = 4838);
-- Sage's Pants
-- display_id, from 14767 to 12514
-- buy_price, from 6220 to 5852
-- sell_price, from 1244 to 1170
-- required_level, from 21 to 16
-- armor, from 18 to 17
-- fire_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12514, `buy_price` = 5852, `sell_price` = 1170, `required_level` = 16, `armor` = 17, `fire_res` = 1 WHERE (`entry` = 6616);
UPDATE `applied_item_updates` SET `entry` = 6616, `version` = 3494 WHERE (`entry` = 6616);
-- Wispy Silk Boots
-- spellid_1, from 7701 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4324);
UPDATE `applied_item_updates` SET `entry` = 4324, `version` = 3494 WHERE (`entry` = 4324);
-- Forest Leather Mantle
-- required_level, from 20 to 15
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 15, `armor` = 27 WHERE (`entry` = 4709);
UPDATE `applied_item_updates` SET `entry` = 4709, `version` = 3494 WHERE (`entry` = 4709);
-- Death Speaker Mantle
-- required_level, from 25 to 20
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 20, `armor` = 17 WHERE (`entry` = 6685);
UPDATE `applied_item_updates` SET `entry` = 6685, `version` = 3494 WHERE (`entry` = 6685);
-- Shimmering Pants
-- display_id, from 14746 to 12470
-- buy_price, from 2725 to 2713
-- sell_price, from 545 to 542
-- required_level, from 15 to 10
-- armor, from 16 to 14
UPDATE `item_template` SET `display_id` = 12470, `buy_price` = 2713, `sell_price` = 542, `required_level` = 10, `armor` = 14 WHERE (`entry` = 6568);
UPDATE `applied_item_updates` SET `entry` = 6568, `version` = 3494 WHERE (`entry` = 6568);
-- Ogremage Staff
-- required_level, from 22 to 17
-- dmg_min1, from 45.0 to 55
-- dmg_max1, from 68.0 to 75
UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 55, `dmg_max1` = 75 WHERE (`entry` = 2226);
UPDATE `applied_item_updates` SET `entry` = 2226, `version` = 3494 WHERE (`entry` = 2226);
-- Frostweave Cowl
-- display_id, from 15331 to 13546
-- required_level, from 27 to 22
-- armor, from 14 to 12
UPDATE `item_template` SET `display_id` = 13546, `required_level` = 22, `armor` = 12 WHERE (`entry` = 3068);
UPDATE `applied_item_updates` SET `entry` = 3068, `version` = 3494 WHERE (`entry` = 3068);
-- Silver-lined Bracers
-- required_level, from 5 to 1
-- armor, from 6 to 5
UPDATE `item_template` SET `required_level` = 1, `armor` = 5 WHERE (`entry` = 3224);
UPDATE `applied_item_updates` SET `entry` = 3224, `version` = 3494 WHERE (`entry` = 3224);
-- Driving Gloves
-- required_level, from 4 to 1
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 1, `armor` = 10 WHERE (`entry` = 3152);
UPDATE `applied_item_updates` SET `entry` = 3152, `version` = 3494 WHERE (`entry` = 3152);
-- Sentry Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2059);
UPDATE `applied_item_updates` SET `entry` = 2059, `version` = 3494 WHERE (`entry` = 2059);
-- Laced Mail Boots
-- required_level, from 15 to 10
-- armor, from 24 to 22
UPDATE `item_template` SET `required_level` = 10, `armor` = 22 WHERE (`entry` = 1739);
UPDATE `applied_item_updates` SET `entry` = 1739, `version` = 3494 WHERE (`entry` = 1739);
-- Frost Metal Pauldrons
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4123);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4123, 3494);
-- Ironforge Breastplate
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6731);
UPDATE `applied_item_updates` SET `entry` = 6731, `version` = 3494 WHERE (`entry` = 6731);
-- Mail Combat Belt
-- required_level, from 32 to 27
-- armor, from 35 to 32
UPDATE `item_template` SET `required_level` = 27, `armor` = 32 WHERE (`entry` = 4717);
UPDATE `applied_item_updates` SET `entry` = 4717, `version` = 3494 WHERE (`entry` = 4717);
-- Mail Combat Leggings
-- required_level, from 31 to 26
-- stat_value2, from 10 to 50
-- armor, from 63 to 57
UPDATE `item_template` SET `required_level` = 26, `stat_value2` = 50, `armor` = 57 WHERE (`entry` = 6402);
UPDATE `applied_item_updates` SET `entry` = 6402, `version` = 3494 WHERE (`entry` = 6402);
-- Mail Combat Armguards
-- buy_price, from 11792 to 14009
-- sell_price, from 2358 to 2801
-- item_level, from 36 to 38
-- required_level, from 31 to 28
-- armor, from 39 to 37
UPDATE `item_template` SET `buy_price` = 14009, `sell_price` = 2801, `item_level` = 38, `required_level` = 28, `armor` = 37 WHERE (`entry` = 6403);
UPDATE `applied_item_updates` SET `entry` = 6403, `version` = 3494 WHERE (`entry` = 6403);
-- Inscribed Gold Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5010);
UPDATE `applied_item_updates` SET `entry` = 5010, `version` = 3494 WHERE (`entry` = 5010);
-- Slaghammer
-- stat_value1, from 3 to 4
-- stat_value2, from 5 to 4
-- dmg_min1, from 42.0 to 49
-- dmg_max1, from 64.0 to 67
UPDATE `item_template` SET `stat_value1` = 4, `stat_value2` = 4, `dmg_min1` = 49, `dmg_max1` = 67 WHERE (`entry` = 1976);
UPDATE `applied_item_updates` SET `entry` = 1976, `version` = 3494 WHERE (`entry` = 1976);
-- Glimmering Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 6386);
UPDATE `applied_item_updates` SET `entry` = 6386, `version` = 3494 WHERE (`entry` = 6386);
-- Studded Leather Bracers
-- name, from Studded Bracers to Studded Leather Bracers
-- required_level, from 32 to 27
-- stat_value1, from 1 to 2
-- armor, from 24 to 22
UPDATE `item_template` SET `name` = 'Studded Leather Bracers', `required_level` = 27, `stat_value1` = 2, `armor` = 22 WHERE (`entry` = 2468);
UPDATE `applied_item_updates` SET `entry` = 2468, `version` = 3494 WHERE (`entry` = 2468);
-- Buzzer Blade
-- required_level, from 17 to 10
-- dmg_min1, from 8.0 to 15
-- dmg_max1, from 15.0 to 24
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 15, `dmg_max1` = 24 WHERE (`entry` = 2169);
UPDATE `applied_item_updates` SET `entry` = 2169, `version` = 3494 WHERE (`entry` = 2169);
-- Emblazoned Bracers
-- required_level, from 25 to 20
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 20, `armor` = 21 WHERE (`entry` = 4049);
UPDATE `applied_item_updates` SET `entry` = 4049, `version` = 3494 WHERE (`entry` = 4049);
-- Augmented Chain Helm
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 46 to 42
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 42 WHERE (`entry` = 3891);
UPDATE `applied_item_updates` SET `entry` = 3891, `version` = 3494 WHERE (`entry` = 3891);
-- Band of Thorns
-- required_level, from 31 to 26
-- max_count, from 1 to 0
-- stat_value1, from 1 to 2
-- stat_value2, from 2 to 3
UPDATE `item_template` SET `required_level` = 26, `max_count` = 0, `stat_value1` = 2, `stat_value2` = 3 WHERE (`entry` = 5007);
UPDATE `applied_item_updates` SET `entry` = 5007, `version` = 3494 WHERE (`entry` = 5007);
-- Tigerbane
-- spellid_1, from 19691 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 1465);
UPDATE `applied_item_updates` SET `entry` = 1465, `version` = 3494 WHERE (`entry` = 1465);
-- BKP "Sparrow" Smallbore
-- required_level, from 28 to 23
-- dmg_min1, from 25.0 to 16
-- dmg_max1, from 47.0 to 24
UPDATE `item_template` SET `required_level` = 23, `dmg_min1` = 16, `dmg_max1` = 24 WHERE (`entry` = 3042);
UPDATE `applied_item_updates` SET `entry` = 3042, `version` = 3494 WHERE (`entry` = 3042);
-- Darkweave Cowl
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- stat_value2, from 4 to 6
-- armor, from 17 to 15
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `stat_value2` = 6, `armor` = 15, `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3494 WHERE (`entry` = 4039);
-- Doomsayer's Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4746);
UPDATE `applied_item_updates` SET `entry` = 4746, `version` = 3494 WHERE (`entry` = 4746);
-- Frostweave Cloak
-- buy_price, from 8203 to 9023
-- sell_price, from 1640 to 1804
-- item_level, from 32 to 33
-- required_level, from 27 to 23
-- stat_type1, from 7 to 5
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 18 to 17
-- frost_res, from 0 to 1
UPDATE `item_template` SET `buy_price` = 9023, `sell_price` = 1804, `item_level` = 33, `required_level` = 23, `stat_type1` = 5, `stat_value1` = 2, `stat_value2` = 2, `armor` = 17, `frost_res` = 1 WHERE (`entry` = 4713);
UPDATE `applied_item_updates` SET `entry` = 4713, `version` = 3494 WHERE (`entry` = 4713);
-- Blackwater Cutlass
-- required_level, from 14 to 9
-- dmg_min1, from 10.0 to 23
-- dmg_max1, from 20.0 to 29
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 23, `dmg_max1` = 29 WHERE (`entry` = 1951);
UPDATE `applied_item_updates` SET `entry` = 1951, `version` = 3494 WHERE (`entry` = 1951);
-- Burnished Buckler
-- required_level, from 15 to 10
-- stat_type1, from 3 to 6
-- armor, from 49 to 39
UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 6, `armor` = 39 WHERE (`entry` = 6380);
UPDATE `applied_item_updates` SET `entry` = 6380, `version` = 3494 WHERE (`entry` = 6380);
-- Chromatic Robe
-- required_level, from 24 to 19
-- stat_value1, from 3 to 4
-- armor, from 20 to 19
UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 4, `armor` = 19 WHERE (`entry` = 2615);
UPDATE `applied_item_updates` SET `entry` = 2615, `version` = 3494 WHERE (`entry` = 2615);
-- Garneg's War Belt
-- required_level, from 24 to 19
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 19, `armor` = 27 WHERE (`entry` = 6200);
UPDATE `applied_item_updates` SET `entry` = 6200, `version` = 3494 WHERE (`entry` = 6200);
-- Glimmering Mail Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4711);
UPDATE `applied_item_updates` SET `entry` = 4711, `version` = 3494 WHERE (`entry` = 4711);
-- Frost Tiger Blade
-- required_level, from 35 to 30
-- stat_value1, from 9 to 11
-- dmg_min1, from 80.0 to 88
-- dmg_max1, from 121.0 to 120
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
-- spellid_2, from 13439 to 0
-- spelltrigger_2, from 2 to 0
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 11, `dmg_min1` = 88, `dmg_max1` = 120, `spellid_1` = 0, `spelltrigger_1` = 0, `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 3854);
UPDATE `applied_item_updates` SET `entry` = 3854, `version` = 3494 WHERE (`entry` = 3854);
-- Ruffled Chaplet
-- required_level, from 26 to 21
-- stat_value1, from 4 to 6
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 6, `armor` = 27 WHERE (`entry` = 5753);
UPDATE `applied_item_updates` SET `entry` = 5753, `version` = 3494 WHERE (`entry` = 5753);
-- Guardian Armor
-- required_level, from 30 to 25
-- stat_type1, from 6 to 3
-- stat_value1, from 7 to 9
-- armor, from 51 to 47
UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 3, `stat_value1` = 9, `armor` = 47 WHERE (`entry` = 4256);
UPDATE `applied_item_updates` SET `entry` = 4256, `version` = 3494 WHERE (`entry` = 4256);
-- Panther Hunter Leggings
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4108);
UPDATE `applied_item_updates` SET `entry` = 4108, `version` = 3494 WHERE (`entry` = 4108);
-- Emblazoned Boots
-- required_level, from 27 to 22
-- stat_value1, from 2 to 4
-- stat_type2, from 6 to 7
-- stat_value2, from 1 to 2
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `stat_type2` = 7, `stat_value2` = 2, `armor` = 30 WHERE (`entry` = 4051);
UPDATE `applied_item_updates` SET `entry` = 4051, `version` = 3494 WHERE (`entry` = 4051);
-- Monkey Ring
-- required_level, from 26 to 21
-- stat_value1, from 2 to 3
-- stat_value2, from 8 to 18
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3, `stat_value2` = 18 WHERE (`entry` = 6748);
UPDATE `applied_item_updates` SET `entry` = 6748, `version` = 3494 WHERE (`entry` = 6748);
-- Viridian Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6589);
UPDATE `applied_item_updates` SET `entry` = 6589, `version` = 3494 WHERE (`entry` = 6589);
-- Crystal Starfire Medallion
-- item_level, from 31 to 33
-- required_level, from 26 to 23
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 3
-- stat_value3, from 2 to 5
UPDATE `item_template` SET `item_level` = 33, `required_level` = 23, `stat_value1` = 3, `stat_value2` = 3, `stat_value3` = 5 WHERE (`entry` = 5003);
UPDATE `applied_item_updates` SET `entry` = 5003, `version` = 3494 WHERE (`entry` = 5003);
-- Dervish Cape
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 6604);
UPDATE `applied_item_updates` SET `entry` = 6604, `version` = 3494 WHERE (`entry` = 6604);
-- Golden Scale Shoulders
-- required_level, from 30 to 25
-- stat_value2, from 1 to 2
-- armor, from 63 to 57
UPDATE `item_template` SET `required_level` = 25, `stat_value2` = 2, `armor` = 57 WHERE (`entry` = 3841);
UPDATE `applied_item_updates` SET `entry` = 3841, `version` = 3494 WHERE (`entry` = 3841);
-- Glimmering Mail Boots
-- required_level, from 27 to 22
-- stat_value1, from 1 to 3
-- stat_value2, from 10 to 25
-- stat_value3, from 10 to 25
-- armor, from 49 to 45
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value2` = 25, `stat_value3` = 25, `armor` = 45 WHERE (`entry` = 4073);
UPDATE `applied_item_updates` SET `entry` = 4073, `version` = 3494 WHERE (`entry` = 4073);
-- Pugilist Bracers
-- stat_value1, from 3 to 4
-- armor, from 36 to 32
UPDATE `item_template` SET `stat_value1` = 4, `armor` = 32 WHERE (`entry` = 4438);
UPDATE `applied_item_updates` SET `entry` = 4438, `version` = 3494 WHERE (`entry` = 4438);
-- Mail Combat Gauntlets
-- required_level, from 30 to 25
-- stat_value1, from 3 to 5
-- armor, from 43 to 39
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 5, `armor` = 39 WHERE (`entry` = 4075);
UPDATE `applied_item_updates` SET `entry` = 4075, `version` = 3494 WHERE (`entry` = 4075);
-- Cured Leather Pants
-- required_level, from 17 to 12
-- armor, from 30 to 28
UPDATE `item_template` SET `required_level` = 12, `armor` = 28 WHERE (`entry` = 237);
UPDATE `applied_item_updates` SET `entry` = 237, `version` = 3494 WHERE (`entry` = 237);
-- Crescent Staff
-- buy_price, from 17328 to 16185
-- sell_price, from 3465 to 3237
-- required_level, from 20 to 15
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- stat_value3, from 1 to 2
-- dmg_min1, from 35.0 to 44
-- dmg_max1, from 53.0 to 60
UPDATE `item_template` SET `buy_price` = 16185, `sell_price` = 3237, `required_level` = 15, `stat_value1` = 2, `stat_value2` = 2, `stat_value3` = 2, `dmg_min1` = 44, `dmg_max1` = 60 WHERE (`entry` = 6505);
UPDATE `applied_item_updates` SET `entry` = 6505, `version` = 3494 WHERE (`entry` = 6505);
-- Heavy Copper Broadsword
-- required_level, from 16 to 9
-- dmg_min1, from 21.0 to 31
-- dmg_max1, from 32.0 to 43
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 31, `dmg_max1` = 43 WHERE (`entry` = 3487);
UPDATE `applied_item_updates` SET `entry` = 3487, `version` = 3494 WHERE (`entry` = 3487);
-- Scholarly Robes
-- buy_price, from 5179 to 4583
-- sell_price, from 1035 to 916
-- item_level, from 25 to 24
-- required_level, from 20 to 14
-- stat_value1, from 3 to 5
-- armor, from 20 to 18
UPDATE `item_template` SET `buy_price` = 4583, `sell_price` = 916, `item_level` = 24, `required_level` = 14, `stat_value1` = 5, `armor` = 18 WHERE (`entry` = 2034);
UPDATE `applied_item_updates` SET `entry` = 2034, `version` = 3494 WHERE (`entry` = 2034);
-- Flameweave Armor
-- display_id, from 14563 to 12507
-- required_level, from 21 to 16
-- stat_value1, from 3 to 6
-- armor, from 21 to 19
-- fire_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12507, `required_level` = 16, `stat_value1` = 6, `armor` = 19, `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3494 WHERE (`entry` = 6608);
-- Skeletal Longsword
-- required_level, from 22 to 17
-- dmg_min1, from 18.0 to 30
-- dmg_max1, from 35.0 to 46
UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 30, `dmg_max1` = 46 WHERE (`entry` = 2018);
UPDATE `applied_item_updates` SET `entry` = 2018, `version` = 3494 WHERE (`entry` = 2018);
-- Magister's Vest
-- display_id, from 14524 to 12379
-- required_level, from 10 to 5
-- stat_type1, from 6 to 7
-- stat_value1, from 1 to 3
-- armor, from 16 to 14
UPDATE `item_template` SET `display_id` = 12379, `required_level` = 5, `stat_type1` = 7, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 2969);
UPDATE `applied_item_updates` SET `entry` = 2969, `version` = 3494 WHERE (`entry` = 2969);
-- Rat Cloth Cloak
-- required_level, from 10 to 5
-- stat_type1, from 1 to 7
-- stat_value1, from 4 to 1
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 7, `stat_value1` = 1, `armor` = 11 WHERE (`entry` = 2284);
UPDATE `applied_item_updates` SET `entry` = 2284, `version` = 3494 WHERE (`entry` = 2284);
-- Hillman's Leather Vest
-- required_level, from 15 to 10
-- stat_value1, from 2 to 4
-- armor, from 36 to 33
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4, `armor` = 33 WHERE (`entry` = 4244);
UPDATE `applied_item_updates` SET `entry` = 4244, `version` = 3494 WHERE (`entry` = 4244);
-- Flameweave Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3069);
UPDATE `applied_item_updates` SET `entry` = 3069, `version` = 3494 WHERE (`entry` = 3069);
-- Engineer's Cloak
-- buy_price, from 4962 to 4828
-- sell_price, from 992 to 965
-- required_level, from 22 to 17
-- stat_type1, from 5 to 6
-- armor, from 16 to 15
UPDATE `item_template` SET `buy_price` = 4828, `sell_price` = 965, `required_level` = 17, `stat_type1` = 6, `armor` = 15 WHERE (`entry` = 6667);
UPDATE `applied_item_updates` SET `entry` = 6667, `version` = 3494 WHERE (`entry` = 6667);
-- Gnoll War Harness
-- required_level, from 10 to 5
-- stat_type1, from 4 to 7
-- stat_value1, from 1 to 3
-- armor, from 31 to 28
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 7, `stat_value1` = 3, `armor` = 28 WHERE (`entry` = 1211);
UPDATE `applied_item_updates` SET `entry` = 1211, `version` = 3494 WHERE (`entry` = 1211);
-- Glimmering Mail Pauldrons
-- required_level, from 25 to 20
-- stat_value1, from 1 to 2
-- armor, from 56 to 51
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `armor` = 51 WHERE (`entry` = 6388);
UPDATE `applied_item_updates` SET `entry` = 6388, `version` = 3494 WHERE (`entry` = 6388);
-- Glimmering Mail Gauntlets
-- required_level, from 26 to 21
-- stat_value1, from 3 to 4
-- armor, from 39 to 36
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 4, `armor` = 36 WHERE (`entry` = 4072);
UPDATE `applied_item_updates` SET `entry` = 4072, `version` = 3494 WHERE (`entry` = 4072);
-- Torch of Holy Flame
-- spellid_1, from 8913 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2808);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2808, 3494);
-- Glimmering Mail Chestpiece
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4071);
UPDATE `applied_item_updates` SET `entry` = 4071, `version` = 3494 WHERE (`entry` = 4071);
-- Totem of Infliction
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 1131);
UPDATE `applied_item_updates` SET `entry` = 1131, `version` = 3494 WHERE (`entry` = 1131);
-- Necklace of Harmony
-- required_level, from 29 to 24
-- stat_value1, from 6 to 9
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 9 WHERE (`entry` = 5180);
UPDATE `applied_item_updates` SET `entry` = 5180, `version` = 3494 WHERE (`entry` = 5180);
-- Ring of Healing
-- buy_price, from 21400 to 1400
-- sell_price, from 5350 to 350
UPDATE `item_template` SET `buy_price` = 1400, `sell_price` = 350 WHERE (`entry` = 1713);
UPDATE `applied_item_updates` SET `entry` = 1713, `version` = 3494 WHERE (`entry` = 1713);
-- Vibrant Silk Cape
-- required_level, from 28 to 23
-- stat_value1, from 1 to 2
-- stat_value2, from 10 to 30
-- armor, from 18 to 17
UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 2, `stat_value2` = 30, `armor` = 17 WHERE (`entry` = 5181);
UPDATE `applied_item_updates` SET `entry` = 5181, `version` = 3494 WHERE (`entry` = 5181);
-- Whisperwind Headdress
-- required_level, from 27 to 22
-- stat_value1, from 2 to 3
-- stat_value2, from 3 to 4
-- stat_value3, from 10 to 15
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value2` = 4, `stat_value3` = 15, `armor` = 27 WHERE (`entry` = 6688);
UPDATE `applied_item_updates` SET `entry` = 6688, `version` = 3494 WHERE (`entry` = 6688);
-- Frostweave Pants
-- required_level, from 26 to 21
-- stat_value1, from 5 to 7
-- armor, from 21 to 19
-- frost_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 7, `armor` = 19, `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3494 WHERE (`entry` = 4037);
-- Heavy Shot
-- dmg_min1, from 5.0 to 4
-- dmg_max1, from 6.0 to 4
UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 4 WHERE (`entry` = 2519);
UPDATE `applied_item_updates` SET `entry` = 2519, `version` = 3494 WHERE (`entry` = 2519);
-- Solid Shot
-- dmg_min1, from 12.0 to 6
-- dmg_max1, from 13.0 to 7
UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 7 WHERE (`entry` = 3033);
UPDATE `applied_item_updates` SET `entry` = 3033, `version` = 3494 WHERE (`entry` = 3033);
-- Glorious Shoulders
-- required_level, from 23 to 18
-- stat_value1, from 1 to 2
-- armor, from 53 to 48
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `armor` = 48 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3494 WHERE (`entry` = 4833);
-- Moonsteel Broadsword
-- required_level, from 31 to 26
-- stat_value1, from 6 to 7
-- stat_value2, from 25 to 35
-- dmg_min1, from 54.0 to 61
-- dmg_max1, from 81.0 to 83
UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 7, `stat_value2` = 35, `dmg_min1` = 61, `dmg_max1` = 83 WHERE (`entry` = 3853);
UPDATE `applied_item_updates` SET `entry` = 3853, `version` = 3494 WHERE (`entry` = 3853);
-- Emblazoned Helm
-- name, from Emblazoned Hat to Emblazoned Helm
-- display_id, from 15904 to 13257
-- required_level, from 26 to 21
-- stat_value2, from 2 to 4
-- stat_value3, from 15 to 40
-- armor, from 29 to 27
UPDATE `item_template` SET `name` = 'Emblazoned Helm', `display_id` = 13257, `required_level` = 21, `stat_value2` = 4, `stat_value3` = 40, `armor` = 27 WHERE (`entry` = 4048);
UPDATE `applied_item_updates` SET `entry` = 4048, `version` = 3494 WHERE (`entry` = 4048);
-- Guardian Gloves
-- required_level, from 33 to 28
-- armor, from 28 to 25
UPDATE `item_template` SET `required_level` = 28, `armor` = 25 WHERE (`entry` = 5966);
UPDATE `applied_item_updates` SET `entry` = 5966, `version` = 3494 WHERE (`entry` = 5966);
-- Blackfang
-- dmg_min1, from 12.0 to 20
-- dmg_max1, from 23.0 to 31
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `dmg_min1` = 20, `dmg_max1` = 31, `shadow_res` = 0 WHERE (`entry` = 2236);
UPDATE `applied_item_updates` SET `entry` = 2236, `version` = 3494 WHERE (`entry` = 2236);
-- Stout Maul
-- dmg_min1, from 33.0 to 41
-- dmg_max1, from 50.0 to 57
UPDATE `item_template` SET `dmg_min1` = 41, `dmg_max1` = 57 WHERE (`entry` = 924);
UPDATE `applied_item_updates` SET `entry` = 924, `version` = 3494 WHERE (`entry` = 924);
-- Dark Leather Tunic
-- required_level, from 15 to 10
-- armor, from 36 to 33
UPDATE `item_template` SET `required_level` = 10, `armor` = 33 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3494 WHERE (`entry` = 2317);
-- Rawhide Bracers
-- name, from Patched Leather Bracers to Rawhide Bracers
-- required_level, from 15 to 10
-- armor, from 12 to 10
UPDATE `item_template` SET `name` = 'Rawhide Bracers', `required_level` = 10, `armor` = 10 WHERE (`entry` = 1789);
UPDATE `applied_item_updates` SET `entry` = 1789, `version` = 3494 WHERE (`entry` = 1789);
-- Forest Leather Cloak
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4710);
UPDATE `applied_item_updates` SET `entry` = 4710, `version` = 3494 WHERE (`entry` = 4710);
-- Diviner Long Staff
-- dmg_min1, from 33.0 to 42
-- dmg_max1, from 50.0 to 57
UPDATE `item_template` SET `dmg_min1` = 42, `dmg_max1` = 57 WHERE (`entry` = 928);
UPDATE `applied_item_updates` SET `entry` = 928, `version` = 3494 WHERE (`entry` = 928);
-- Huge Ogre Sword
-- required_level, from 24 to 19
-- stat_value1, from 5 to 7
-- dmg_min1, from 55.0 to 64
-- dmg_max1, from 83.0 to 87
UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 7, `dmg_min1` = 64, `dmg_max1` = 87 WHERE (`entry` = 913);
UPDATE `applied_item_updates` SET `entry` = 913, `version` = 3494 WHERE (`entry` = 913);
-- Large Bore Blunderbuss
-- dmg_min1, from 19.0 to 15
-- dmg_max1, from 36.0 to 23
UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 3023);
UPDATE `applied_item_updates` SET `entry` = 3023, `version` = 3494 WHERE (`entry` = 3023);
-- Necromancer Leggings
-- holy_res, from 0 to 1
-- spellid_1, from 7709 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2277);
UPDATE `applied_item_updates` SET `entry` = 2277, `version` = 3494 WHERE (`entry` = 2277);
-- Captain's Armor
-- name, from Avenger's Armor to Captain's Armor
-- stat_value1, from 4 to 7
-- stat_value2, from 30 to 35
-- armor, from 70 to 64
UPDATE `item_template` SET `name` = 'Captain\'s Armor', `stat_value1` = 7, `stat_value2` = 35, `armor` = 64 WHERE (`entry` = 1488);
UPDATE `applied_item_updates` SET `entry` = 1488, `version` = 3494 WHERE (`entry` = 1488);
-- Reinforced Belt
-- name, from Support Girdle to Reinforced Belt
-- required_level, from 17 to 12
-- armor, from 17 to 15
UPDATE `item_template` SET `name` = 'Reinforced Belt', `required_level` = 12, `armor` = 15 WHERE (`entry` = 1215);
UPDATE `applied_item_updates` SET `entry` = 1215, `version` = 3494 WHERE (`entry` = 1215);
-- Feathered Headdress
-- required_level, from 31 to 26
-- stat_value1, from 4 to 5
-- stat_value2, from 4 to 5
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 5, `stat_value2` = 5, `armor` = 30 WHERE (`entry` = 3011);
UPDATE `applied_item_updates` SET `entry` = 3011, `version` = 3494 WHERE (`entry` = 3011);
-- Beastial Manacles
-- buy_price, from 5001 to 4828
-- sell_price, from 1000 to 965
-- required_level, from 22 to 17
-- stat_type1, from 1 to 6
-- stat_value1, from 10 to 1
-- armor, from 32 to 29
UPDATE `item_template` SET `buy_price` = 4828, `sell_price` = 965, `required_level` = 17, `stat_type1` = 6, `stat_value1` = 1, `armor` = 29 WHERE (`entry` = 6722);
UPDATE `applied_item_updates` SET `entry` = 6722, `version` = 3494 WHERE (`entry` = 6722);
-- Green Carapace Shield
-- required_level, from 16 to 11
-- stat_value1, from 1 to 2
-- armor, from 100 to 70
-- nature_res, from 4 to 0
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 2, `armor` = 70, `nature_res` = 0 WHERE (`entry` = 2021);
UPDATE `applied_item_updates` SET `entry` = 2021, `version` = 3494 WHERE (`entry` = 2021);
-- Ferine Swine Leggings
-- name, from Ferine Leggings to Ferine Swine Leggings
-- required_level, from 28 to 23
-- stat_value1, from 3 to 4
-- stat_value2, from 4 to 5
-- armor, from 43 to 39
UPDATE `item_template` SET `name` = 'Ferine Swine Leggings', `required_level` = 23, `stat_value1` = 4, `stat_value2` = 5, `armor` = 39 WHERE (`entry` = 6690);
UPDATE `applied_item_updates` SET `entry` = 6690, `version` = 3494 WHERE (`entry` = 6690);
-- Glimmering Buckler
-- required_level, from 27 to 22
-- stat_value1, from 3 to 4
-- armor, from 69 to 55
-- frost_res, from 0 to 4
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `armor` = 55, `frost_res` = 4 WHERE (`entry` = 4064);
UPDATE `applied_item_updates` SET `entry` = 4064, `version` = 3494 WHERE (`entry` = 4064);
-- Stonesplinter Rags
-- required_level, from 12 to 7
-- armor, from 47 to 14
UPDATE `item_template` SET `required_level` = 7, `armor` = 14 WHERE (`entry` = 5109);
UPDATE `applied_item_updates` SET `entry` = 5109, `version` = 3494 WHERE (`entry` = 5109);
-- Scarecrow Trousers
-- required_level, from 15 to 10
-- stat_value1, from 2 to 4
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4, `armor` = 14 WHERE (`entry` = 4434);
UPDATE `applied_item_updates` SET `entry` = 4434, `version` = 3494 WHERE (`entry` = 4434);
-- Nightbane Staff
-- shadow_res, from 7 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 3227);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3227, 3494);
-- Frostmane Leather Vest
-- armor, from 9 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2108);
UPDATE `applied_item_updates` SET `entry` = 2108, `version` = 3494 WHERE (`entry` = 2108);
-- Shadowhide Two-handed Sword
-- required_level, from 15 to 10
-- stat_value1, from 1 to 5
-- dmg_min1, from 26.0 to 38
-- dmg_max1, from 40.0 to 53
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 5, `dmg_min1` = 38, `dmg_max1` = 53 WHERE (`entry` = 1460);
UPDATE `applied_item_updates` SET `entry` = 1460, `version` = 3494 WHERE (`entry` = 1460);
-- Aegis of Westfall
-- spellid_1, from 13675 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2040);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2040, 3494);
-- Training Sword
-- required_level, from 7 to 2
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 27.0 to 38
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 28, `dmg_max1` = 38 WHERE (`entry` = 3192);
UPDATE `applied_item_updates` SET `entry` = 3192, `version` = 3494 WHERE (`entry` = 3192);
-- Double Link Mail Tunic
-- spellid_2, from 18369 to 0
-- spelltrigger_2, from 1 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 1717);
UPDATE `applied_item_updates` SET `entry` = 1717, `version` = 3494 WHERE (`entry` = 1717);
-- Augmented Chain Gloves
-- required_level, from 32 to 27
-- stat_value1, from 2 to 3
-- armor, from 41 to 37
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 3, `armor` = 37 WHERE (`entry` = 2422);
UPDATE `applied_item_updates` SET `entry` = 2422, `version` = 3494 WHERE (`entry` = 2422);
-- Combat Shield
-- buy_price, from 26558 to 31551
-- sell_price, from 5311 to 6310
-- item_level, from 36 to 38
-- required_level, from 31 to 28
-- stat_value1, from 3 to 4
-- stat_value2, from 2 to 3
-- armor, from 150 to 109
UPDATE `item_template` SET `buy_price` = 31551, `sell_price` = 6310, `item_level` = 38, `required_level` = 28, `stat_value1` = 4, `stat_value2` = 3, `armor` = 109 WHERE (`entry` = 4065);
UPDATE `applied_item_updates` SET `entry` = 4065, `version` = 3494 WHERE (`entry` = 4065);
-- Ironplate Buckler
-- required_level, from 10 to 5
-- stat_type1, from 1 to 6
-- stat_value1, from 3 to 2
-- armor, from 40 to 32
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 2, `armor` = 32 WHERE (`entry` = 3160);
UPDATE `applied_item_updates` SET `entry` = 3160, `version` = 3494 WHERE (`entry` = 3160);
-- Robe of Solomon
-- required_level, from 20 to 15
-- stat_value1, from 2 to 4
-- stat_value2, from 10 to 15
-- armor, from 20 to 19
UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 4, `stat_value2` = 15, `armor` = 19 WHERE (`entry` = 3555);
UPDATE `applied_item_updates` SET `entry` = 3555, `version` = 3494 WHERE (`entry` = 3555);
-- Rat Cloth Belt
-- required_level, from 10 to 5
-- stat_value1, from 5 to 15
-- armor, from 7 to 6
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 15, `armor` = 6 WHERE (`entry` = 2283);
UPDATE `applied_item_updates` SET `entry` = 2283, `version` = 3494 WHERE (`entry` = 2283);
-- Tribal Worg Helm
-- required_level, from 27 to 22
-- stat_value1, from 2 to 3
-- stat_value3, from 2 to 4
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value3` = 4, `armor` = 27 WHERE (`entry` = 6204);
UPDATE `applied_item_updates` SET `entry` = 6204, `version` = 3494 WHERE (`entry` = 6204);
-- Wolfpack Medallion
-- required_level, from 26 to 21
-- stat_value1, from 5 to 7
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 7, `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3494 WHERE (`entry` = 5754);
-- Shadow Claw
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 34.0 to 43
-- spellid_1, from 16409 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min1` = 28, `dmg_max1` = 43, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2912);
UPDATE `applied_item_updates` SET `entry` = 2912, `version` = 3494 WHERE (`entry` = 2912);
-- Black Wolf Bracers
-- required_level, from 21 to 16
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 16, `armor` = 19 WHERE (`entry` = 3230);
UPDATE `applied_item_updates` SET `entry` = 3230, `version` = 3494 WHERE (`entry` = 3230);
-- Naraxis' Fang
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4449);
UPDATE `applied_item_updates` SET `entry` = 4449, `version` = 3494 WHERE (`entry` = 4449);
-- Deadly Stiletto
-- dmg_min1, from 26.0 to 37
-- dmg_max1, from 49.0 to 57
UPDATE `item_template` SET `dmg_min1` = 37, `dmg_max1` = 57 WHERE (`entry` = 2534);
UPDATE `applied_item_updates` SET `entry` = 2534, `version` = 3494 WHERE (`entry` = 2534);
-- Polished Scale Vest
-- required_level, from 22 to 17
-- armor, from 58 to 52
UPDATE `item_template` SET `required_level` = 17, `armor` = 52 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3494 WHERE (`entry` = 2153);
-- Scalemail Belt
-- required_level, from 17 to 12
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 12, `armor` = 21 WHERE (`entry` = 1853);
UPDATE `applied_item_updates` SET `entry` = 1853, `version` = 3494 WHERE (`entry` = 1853);
-- Insignia Leggings
-- required_level, from 30 to 25
-- stat_value1, from 7 to 9
-- armor, from 45 to 41
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 9, `armor` = 41 WHERE (`entry` = 4054);
UPDATE `applied_item_updates` SET `entry` = 4054, `version` = 3494 WHERE (`entry` = 4054);
-- Howling Blade
-- buy_price, from 47333 to 45542
-- sell_price, from 9466 to 9108
-- stat_value1, from 4 to 3
-- dmg_min1, from 18.0 to 27
-- dmg_max1, from 34.0 to 41
-- spellid_1, from 13490 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `buy_price` = 45542, `sell_price` = 9108, `stat_value1` = 3, `dmg_min1` = 27, `dmg_max1` = 41, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6331);
UPDATE `applied_item_updates` SET `entry` = 6331, `version` = 3494 WHERE (`entry` = 6331);
-- Spirit Cloak
-- required_level, from 18 to 13
-- stat_value1, from 1 to 2
-- armor, from 15 to 13
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 2, `armor` = 13 WHERE (`entry` = 4792);
UPDATE `applied_item_updates` SET `entry` = 4792, `version` = 3494 WHERE (`entry` = 4792);
-- Dervish Gloves
-- display_id, from 14775 to 12500
-- buy_price, from 2408 to 2194
-- sell_price, from 481 to 438
-- required_level, from 21 to 16
-- armor, from 21 to 19
UPDATE `item_template` SET `display_id` = 12500, `buy_price` = 2194, `sell_price` = 438, `required_level` = 16, `armor` = 19 WHERE (`entry` = 6605);
UPDATE `applied_item_updates` SET `entry` = 6605, `version` = 3494 WHERE (`entry` = 6605);
-- Canvas Boots
-- name, from Canvas Shoes to Canvas Boots
-- display_id, from 4143 to 1861
-- required_level, from 12 to 7
UPDATE `item_template` SET `name` = 'Canvas Boots', `display_id` = 1861, `required_level` = 7 WHERE (`entry` = 1764);
UPDATE `applied_item_updates` SET `entry` = 1764, `version` = 3494 WHERE (`entry` = 1764);
-- Relic Blade
-- required_level, from 15 to 10
-- dmg_min1, from 10.0 to 20
-- dmg_max1, from 20.0 to 31
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 5627);
UPDATE `applied_item_updates` SET `entry` = 5627, `version` = 3494 WHERE (`entry` = 5627);
-- Death Speaker Robes
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 6682);
UPDATE `applied_item_updates` SET `entry` = 6682, `version` = 3494 WHERE (`entry` = 6682);
-- Redridge Machete
-- required_level, from 11 to 6
-- dmg_min1, from 11.0 to 23
-- dmg_max1, from 21.0 to 35
UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 1219);
UPDATE `applied_item_updates` SET `entry` = 1219, `version` = 3494 WHERE (`entry` = 1219);
-- Forest Chain
-- required_level, from 20 to 15
-- stat_value1, from 3 to 5
-- armor, from 61 to 55
UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 5, `armor` = 55 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3494 WHERE (`entry` = 1273);
-- Glinting Scale Bracers
-- required_level, from 20 to 15
-- armor, from 28 to 25
UPDATE `item_template` SET `required_level` = 15, `armor` = 25 WHERE (`entry` = 3212);
UPDATE `applied_item_updates` SET `entry` = 3212, `version` = 3494 WHERE (`entry` = 3212);
-- Dagmire Gauntlets
-- buy_price, from 3209 to 3041
-- sell_price, from 641 to 608
-- required_level, from 18 to 13
-- stat_value1, from 1 to 3
-- armor, from 33 to 30
UPDATE `item_template` SET `buy_price` = 3041, `sell_price` = 608, `required_level` = 13, `stat_value1` = 3, `armor` = 30 WHERE (`entry` = 6481);
UPDATE `applied_item_updates` SET `entry` = 6481, `version` = 3494 WHERE (`entry` = 6481);
-- Robes of Arcana
-- required_level, from 25 to 20
-- stat_value1, from 3 to 4
-- stat_value2, from 3 to 4
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 4, `stat_value2` = 4, `armor` = 21 WHERE (`entry` = 5770);
UPDATE `applied_item_updates` SET `entry` = 5770, `version` = 3494 WHERE (`entry` = 5770);
-- Gray Woolen Robe
-- required_level, from 16 to 11
-- stat_value1, from 2 to 4
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 4, `armor` = 17 WHERE (`entry` = 2585);
UPDATE `applied_item_updates` SET `entry` = 2585, `version` = 3494 WHERE (`entry` = 2585);
-- Calico Bracers
-- required_level, from 7 to 2
UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 3375);
UPDATE `applied_item_updates` SET `entry` = 3375, `version` = 3494 WHERE (`entry` = 3375);
-- Heavy Woolen Cloak
-- required_level, from 15 to 10
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 10, `armor` = 12 WHERE (`entry` = 4311);
UPDATE `applied_item_updates` SET `entry` = 4311, `version` = 3494 WHERE (`entry` = 4311);
-- Frostweave Sash
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4714);
UPDATE `applied_item_updates` SET `entry` = 4714, `version` = 3494 WHERE (`entry` = 4714);
-- Cloak of Rot
-- required_level, from 26 to 21
-- stat_value1, from 10 to 25
-- stat_value2, from 10 to 25
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 25, `stat_value2` = 25, `armor` = 16 WHERE (`entry` = 4462);
UPDATE `applied_item_updates` SET `entry` = 4462, `version` = 3494 WHERE (`entry` = 4462);
-- Dusk Wand
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 34.0 to 43
-- delay, from 1700 to 3200
UPDATE `item_template` SET `dmg_min1` = 28, `dmg_max1` = 43, `delay` = 3200 WHERE (`entry` = 5211);
UPDATE `applied_item_updates` SET `entry` = 5211, `version` = 3494 WHERE (`entry` = 5211);
-- Husk of Naraxis
-- required_level, from 22 to 17
-- stat_value1, from 3 to 6
-- armor, from 63 to 58
-- nature_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 6, `armor` = 58, `nature_res` = 1 WHERE (`entry` = 4448);
UPDATE `applied_item_updates` SET `entry` = 4448, `version` = 3494 WHERE (`entry` = 4448);
-- Rune Sword
-- required_level, from 33 to 28
-- dmg_min1, from 20.0 to 30
-- dmg_max1, from 39.0 to 46
UPDATE `item_template` SET `required_level` = 28, `dmg_min1` = 30, `dmg_max1` = 46 WHERE (`entry` = 864);
UPDATE `applied_item_updates` SET `entry` = 864, `version` = 3494 WHERE (`entry` = 864);
-- Azora's Will
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 4999);
UPDATE `applied_item_updates` SET `entry` = 4999, `version` = 3494 WHERE (`entry` = 4999);
-- Darkweave Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4719);
UPDATE `applied_item_updates` SET `entry` = 4719, `version` = 3494 WHERE (`entry` = 4719);
-- Guardsman Belt
-- required_level, from 19 to 14
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 14, `armor` = 16 WHERE (`entry` = 3429);
UPDATE `applied_item_updates` SET `entry` = 3429, `version` = 3494 WHERE (`entry` = 3429);
-- Ember Buckler
-- required_level, from 29 to 24
-- stat_value1, from 2 to 5
-- armor, from 72 to 57
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 5, `armor` = 57 WHERE (`entry` = 4477);
UPDATE `applied_item_updates` SET `entry` = 4477, `version` = 3494 WHERE (`entry` = 4477);
-- Forester's Axe
-- required_level, from 18 to 13
-- dmg_min1, from 16.0 to 30
-- dmg_max1, from 31.0 to 45
UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 30, `dmg_max1` = 45 WHERE (`entry` = 790);
UPDATE `applied_item_updates` SET `entry` = 790, `version` = 3494 WHERE (`entry` = 790);
-- Barbaric Harness
-- required_level, from 33 to 28
-- stat_value1, from 5 to 6
-- armor, from 50 to 45
UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 6, `armor` = 45 WHERE (`entry` = 5739);
UPDATE `applied_item_updates` SET `entry` = 5739, `version` = 3494 WHERE (`entry` = 5739);
-- Emblazoned Gloves
-- buy_price, from 6561 to 7217
-- sell_price, from 1312 to 1443
-- item_level, from 32 to 33
-- required_level, from 27 to 23
-- armor, from 27 to 25
UPDATE `item_template` SET `buy_price` = 7217, `sell_price` = 1443, `item_level` = 33, `required_level` = 23, `armor` = 25 WHERE (`entry` = 6397);
UPDATE `applied_item_updates` SET `entry` = 6397, `version` = 3494 WHERE (`entry` = 6397);
-- Bronze Shortsword
-- required_level, from 21 to 14
-- dmg_min1, from 14.0 to 24
-- dmg_max1, from 26.0 to 37
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 2850);
UPDATE `applied_item_updates` SET `entry` = 2850, `version` = 3494 WHERE (`entry` = 2850);
-- Twisted Sabre
-- dmg_min1, from 13.0 to 24
-- dmg_max1, from 26.0 to 37
UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 2011);
UPDATE `applied_item_updates` SET `entry` = 2011, `version` = 3494 WHERE (`entry` = 2011);
-- Warped Shortsword
-- name, from Commoner's Sword to Warped Shortsword
-- required_level, from 10 to 3
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 11.0 to 20
UPDATE `item_template` SET `name` = 'Warped Shortsword', `required_level` = 3, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 1511);
UPDATE `applied_item_updates` SET `entry` = 1511, `version` = 3494 WHERE (`entry` = 1511);
-- Brightweave Cowl
-- required_level, from 35 to 30
-- stat_value1, from 8 to 11
-- armor, from 18 to 16
-- holy_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 11, `armor` = 16, `holy_res` = 1 WHERE (`entry` = 4041);
UPDATE `applied_item_updates` SET `entry` = 4041, `version` = 3494 WHERE (`entry` = 4041);
-- Darkweave Robe
-- display_id, from 14606 to 12659
-- required_level, from 32 to 27
-- stat_value1, from 2 to 3
-- stat_value3, from 1 to 2
-- armor, from 27 to 24
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12659, `required_level` = 27, `stat_value1` = 3, `stat_value3` = 2, `armor` = 24, `shadow_res` = 1 WHERE (`entry` = 4038);
UPDATE `applied_item_updates` SET `entry` = 4038, `version` = 3494 WHERE (`entry` = 4038);
-- Darkweave Boots
-- required_level, from 30 to 25
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 2
-- stat_value2, from 10 to 30
-- armor, from 16 to 15
UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 6, `stat_value1` = 2, `stat_value2` = 30, `armor` = 15 WHERE (`entry` = 6406);
UPDATE `applied_item_updates` SET `entry` = 6406, `version` = 3494 WHERE (`entry` = 6406);
-- Glimmering Mail Coif
-- required_level, from 27 to 22
-- stat_value1, from 2 to 4
-- stat_value3, from 2 to 3
-- armor, from 45 to 41
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `stat_value3` = 3, `armor` = 41 WHERE (`entry` = 6389);
UPDATE `applied_item_updates` SET `entry` = 6389, `version` = 3494 WHERE (`entry` = 6389);
-- Heart of Agammagan
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 6694);
UPDATE `applied_item_updates` SET `entry` = 6694, `version` = 3494 WHERE (`entry` = 6694);
-- Shrapnel Blaster
-- required_level, from 35 to 30
-- dmg_min1, from 39.0 to 24
-- dmg_max1, from 74.0 to 37
UPDATE `item_template` SET `required_level` = 30, `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 4127);
UPDATE `applied_item_updates` SET `entry` = 4127, `version` = 3494 WHERE (`entry` = 4127);
-- Mantle of Thieves
-- stat_value1, from 3 to 4
-- armor, from 39 to 35
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value1` = 4, `armor` = 35, `shadow_res` = 1 WHERE (`entry` = 2264);
UPDATE `applied_item_updates` SET `entry` = 2264, `version` = 3494 WHERE (`entry` = 2264);
-- Zephyr Belt
-- buy_price, from 5485 to 5355
-- sell_price, from 1097 to 1071
-- required_level, from 25 to 20
-- stat_value1, from 2 to 1
-- armor, from 20 to 18
UPDATE `item_template` SET `buy_price` = 5355, `sell_price` = 1071, `required_level` = 20, `stat_value1` = 1, `armor` = 18 WHERE (`entry` = 6719);
UPDATE `applied_item_updates` SET `entry` = 6719, `version` = 3494 WHERE (`entry` = 6719);
-- Insignia Bracers
-- required_level, from 31 to 26
-- armor, from 24 to 22
UPDATE `item_template` SET `required_level` = 26, `armor` = 22 WHERE (`entry` = 6410);
UPDATE `applied_item_updates` SET `entry` = 6410, `version` = 3494 WHERE (`entry` = 6410);
-- Glimmering Mail Bracers
-- required_level, from 26 to 21
-- armor, from 32 to 29
UPDATE `item_template` SET `required_level` = 21, `armor` = 29 WHERE (`entry` = 6387);
UPDATE `applied_item_updates` SET `entry` = 6387, `version` = 3494 WHERE (`entry` = 6387);
-- Gloom Reaper
-- required_level, from 32 to 27
-- dmg_min1, from 35.0 to 53
-- dmg_max1, from 66.0 to 80
UPDATE `item_template` SET `required_level` = 27, `dmg_min1` = 53, `dmg_max1` = 80 WHERE (`entry` = 863);
UPDATE `applied_item_updates` SET `entry` = 863, `version` = 3494 WHERE (`entry` = 863);
-- Black Husk Shield
-- required_level, from 19 to 14
-- stat_value1, from 1 to 3
-- armor, from 110 to 77
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 14, `stat_value1` = 3, `armor` = 77, `shadow_res` = 1 WHERE (`entry` = 4444);
UPDATE `applied_item_updates` SET `entry` = 4444, `version` = 3494 WHERE (`entry` = 4444);
-- Arcane Runed Bracers
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 4744);
UPDATE `applied_item_updates` SET `entry` = 4744, `version` = 3494 WHERE (`entry` = 4744);
-- Massive Iron Axe
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- stat_value2, from 5 to 6
-- dmg_min1, from 71.0 to 80
-- dmg_max1, from 107.0 to 109
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `stat_value2` = 6, `dmg_min1` = 80, `dmg_max1` = 109 WHERE (`entry` = 3855);
UPDATE `applied_item_updates` SET `entry` = 3855, `version` = 3494 WHERE (`entry` = 3855);
-- Calico Pants
-- required_level, from 6 to 1
UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1499);
UPDATE `applied_item_updates` SET `entry` = 1499, `version` = 3494 WHERE (`entry` = 1499);
-- Nightscape Belt
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 4828);
UPDATE `applied_item_updates` SET `entry` = 4828, `version` = 3494 WHERE (`entry` = 4828);
-- Darkweave Trousers
-- required_level, from 30 to 25
-- stat_value1, from 3 to 4
-- stat_value2, from 5 to 6
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 4, `stat_value2` = 6, `armor` = 21 WHERE (`entry` = 6405);
UPDATE `applied_item_updates` SET `entry` = 6405, `version` = 3494 WHERE (`entry` = 6405);
-- Butcher's Slicer
-- required_level, from 16 to 11
-- dmg_min1, from 18.0 to 38
-- dmg_max1, from 34.0 to 48
UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 38, `dmg_max1` = 48 WHERE (`entry` = 6633);
UPDATE `applied_item_updates` SET `entry` = 6633, `version` = 3494 WHERE (`entry` = 6633);
-- Black Metal Axe
-- required_level, from 19 to 14
-- dmg_min1, from 15.0 to 27
-- dmg_max1, from 29.0 to 41
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 27, `dmg_max1` = 41 WHERE (`entry` = 885);
UPDATE `applied_item_updates` SET `entry` = 885, `version` = 3494 WHERE (`entry` = 885);
-- Prospector Gloves
-- required_level, from 32 to 27
-- stat_value2, from 2 to 3
-- armor, from 30 to 27
-- nature_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 27, `stat_value2` = 3, `armor` = 27, `nature_res` = 1 WHERE (`entry` = 4980);
UPDATE `applied_item_updates` SET `entry` = 4980, `version` = 3494 WHERE (`entry` = 4980);
-- Shiver Blade
-- required_level, from 15 to 10
-- dmg_min1, from 26.0 to 38
-- dmg_max1, from 40.0 to 53
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 38, `dmg_max1` = 53 WHERE (`entry` = 5182);
UPDATE `applied_item_updates` SET `entry` = 5182, `version` = 3494 WHERE (`entry` = 5182);
-- Battleforge Bracers
-- required_level, from 22 to 17
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 17, `armor` = 26 WHERE (`entry` = 6591);
UPDATE `applied_item_updates` SET `entry` = 6591, `version` = 3494 WHERE (`entry` = 6591);
-- Shadowfang
-- dmg_min2, from 4.0 to 0
-- dmg_max2, from 8.0 to 0
-- dmg_type2, from 5 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0 WHERE (`entry` = 1482);
UPDATE `applied_item_updates` SET `entry` = 1482, `version` = 3494 WHERE (`entry` = 1482);
-- Small Bear Tooth
-- name, from Chipped Bear Tooth to Small Bear Tooth
-- buy_price, from 75 to 135
-- sell_price, from 18 to 33
UPDATE `item_template` SET `name` = 'Small Bear Tooth', `buy_price` = 135, `sell_price` = 33 WHERE (`entry` = 3169);
UPDATE `applied_item_updates` SET `entry` = 3169, `version` = 3494 WHERE (`entry` = 3169);
-- Murloc Scale Breastplate
-- required_level, from 14 to 9
-- stat_type1, from 3 to 7
-- stat_value1, from 1 to 3
-- stat_type2, from 5 to 1
-- stat_value2, from 1 to 24
-- armor, from 35 to 32
UPDATE `item_template` SET `required_level` = 9, `stat_type1` = 7, `stat_value1` = 3, `stat_type2` = 1, `stat_value2` = 24, `armor` = 32 WHERE (`entry` = 5781);
UPDATE `applied_item_updates` SET `entry` = 5781, `version` = 3494 WHERE (`entry` = 5781);
-- Enamelled Broadsword
-- required_level, from 9 to 11
-- dmg_min1, from 10.0 to 21
-- dmg_max1, from 19.0 to 33
UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 21, `dmg_max1` = 33 WHERE (`entry` = 4765);
UPDATE `applied_item_updates` SET `entry` = 4765, `version` = 3494 WHERE (`entry` = 4765);
-- Beaten Battle Axe
-- required_level, from 5 to 1
-- dmg_min1, from 8.0 to 13
-- dmg_max1, from 13.0 to 18
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 1417);
UPDATE `applied_item_updates` SET `entry` = 1417, `version` = 3494 WHERE (`entry` = 1417);
-- Glimmering Shield
-- required_level, from 26 to 21
-- armor, from 107 to 67
UPDATE `item_template` SET `required_level` = 21, `armor` = 67 WHERE (`entry` = 6400);
UPDATE `applied_item_updates` SET `entry` = 6400, `version` = 3494 WHERE (`entry` = 6400);
-- Green Woolen Vest
-- required_level, from 12 to 7
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 7, `armor` = 14 WHERE (`entry` = 2582);
UPDATE `applied_item_updates` SET `entry` = 2582, `version` = 3494 WHERE (`entry` = 2582);
-- Cookie's Tenderizer
-- required_level, from 15 to 10
-- dmg_min1, from 16.0 to 32
-- dmg_max1, from 31.0 to 48
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 32, `dmg_max1` = 48 WHERE (`entry` = 5197);
UPDATE `applied_item_updates` SET `entry` = 5197, `version` = 3494 WHERE (`entry` = 5197);
-- Cracked Leather Pants
-- armor, from 10 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2126);
UPDATE `applied_item_updates` SET `entry` = 2126, `version` = 3494 WHERE (`entry` = 2126);
-- Thick War Axe
-- required_level, from 12 to 7
-- dmg_min1, from 12.0 to 26
-- dmg_max1, from 24.0 to 39
UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 26, `dmg_max1` = 39 WHERE (`entry` = 3489);
UPDATE `applied_item_updates` SET `entry` = 3489, `version` = 3494 WHERE (`entry` = 3489);
-- Hollowfang Blade
-- required_level, from 13 to 8
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 14.0 to 23
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 2020);
UPDATE `applied_item_updates` SET `entry` = 2020, `version` = 3494 WHERE (`entry` = 2020);
-- Ratty Old Belt
-- required_level, from 5 to 1
-- armor, from 10 to 9
UPDATE `item_template` SET `required_level` = 1, `armor` = 9 WHERE (`entry` = 6147);
UPDATE `applied_item_updates` SET `entry` = 6147, `version` = 3494 WHERE (`entry` = 6147);
-- Goblin Screwdriver
-- required_level, from 13 to 8
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 14.0 to 23
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 1936);
UPDATE `applied_item_updates` SET `entry` = 1936, `version` = 3494 WHERE (`entry` = 1936);
-- Cape of the Crusader
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4643);
UPDATE `applied_item_updates` SET `entry` = 4643, `version` = 3494 WHERE (`entry` = 4643);
-- Kobold Excavation Pick
-- required_level, from 4 to 1
-- dmg_min1, from 5.0 to 12
-- dmg_max1, from 11.0 to 18
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 12, `dmg_max1` = 18 WHERE (`entry` = 778);
UPDATE `applied_item_updates` SET `entry` = 778, `version` = 3494 WHERE (`entry` = 778);
-- Welding Shield
-- required_level, from 11 to 6
-- stat_type1, from 1 to 6
-- stat_value1, from 5 to 2
-- armor, from 84 to 58
UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 6, `stat_value1` = 2, `armor` = 58 WHERE (`entry` = 5325);
UPDATE `applied_item_updates` SET `entry` = 5325, `version` = 3494 WHERE (`entry` = 5325);
-- Handstitched Leather Vest
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 5957);
UPDATE `applied_item_updates` SET `entry` = 5957, `version` = 3494 WHERE (`entry` = 5957);
-- Riverpaw Leather Vest
-- required_level, from 8 to 3
-- stat_type1, from 1 to 3
-- stat_value1, from 6 to 2
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 3, `stat_value1` = 2, `armor` = 27 WHERE (`entry` = 821);
UPDATE `applied_item_updates` SET `entry` = 821, `version` = 3494 WHERE (`entry` = 821);
-- Duskbringer
-- stat_value1, from 1 to 2
-- stat_value2, from 3 to 5
-- dmg_min1, from 43.0 to 54
-- dmg_max1, from 65.0 to 74
-- holy_res, from 0 to 1
-- spellid_1, from 18217 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 5, `dmg_min1` = 54, `dmg_max1` = 74, `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2205);
UPDATE `applied_item_updates` SET `entry` = 2205, `version` = 3494 WHERE (`entry` = 2205);
-- Scimitar of Atun
-- required_level, from 14 to 9
-- dmg_min1, from 14.0 to 28
-- dmg_max1, from 27.0 to 43
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 28, `dmg_max1` = 43 WHERE (`entry` = 1469);
UPDATE `applied_item_updates` SET `entry` = 1469, `version` = 3494 WHERE (`entry` = 1469);
-- Worn Mail Gloves
-- required_level, from 6 to 1
-- armor, from 14 to 13
UPDATE `item_template` SET `required_level` = 1, `armor` = 13 WHERE (`entry` = 1734);
UPDATE `applied_item_updates` SET `entry` = 1734, `version` = 3494 WHERE (`entry` = 1734);
-- Bear Buckler
-- required_level, from 18 to 13
-- stat_type1, from 4 to 7
-- stat_value1, from 1 to 2
-- armor, from 54 to 43
UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 7, `stat_value1` = 2, `armor` = 43 WHERE (`entry` = 4821);
UPDATE `applied_item_updates` SET `entry` = 4821, `version` = 3494 WHERE (`entry` = 4821);
-- Dark Hooded Cape
-- spellid_1, from 0 to 5258
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `spellid_1` = 5258, `spelltrigger_1` = 1 WHERE (`entry` = 5257);
UPDATE `applied_item_updates` SET `entry` = 5257, `version` = 3494 WHERE (`entry` = 5257);
-- Crude Battle Axe
-- required_level, from 9 to 2
-- dmg_min1, from 11.0 to 18
-- dmg_max1, from 17.0 to 24
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 18, `dmg_max1` = 24 WHERE (`entry` = 1512);
UPDATE `applied_item_updates` SET `entry` = 1512, `version` = 3494 WHERE (`entry` = 1512);
-- Fine Leather Pants
-- required_level, from 16 to 11
-- stat_value1, from 1 to 4
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 4, `armor` = 30 WHERE (`entry` = 5958);
UPDATE `applied_item_updates` SET `entry` = 5958, `version` = 3494 WHERE (`entry` = 5958);
-- Dark Leather Boots
-- required_level, from 15 to 10
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 10, `armor` = 21 WHERE (`entry` = 2315);
UPDATE `applied_item_updates` SET `entry` = 2315, `version` = 3494 WHERE (`entry` = 2315);
-- Small Quiver
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5439);
UPDATE `applied_item_updates` SET `entry` = 5439, `version` = 3494 WHERE (`entry` = 5439);
-- Canvas Bracers
-- required_level, from 14 to 9
-- armor, from 6 to 5
UPDATE `item_template` SET `required_level` = 9, `armor` = 5 WHERE (`entry` = 3377);
UPDATE `applied_item_updates` SET `entry` = 3377, `version` = 3494 WHERE (`entry` = 3377);
-- Forest Leather Belt
-- required_level, from 20 to 15
-- stat_type1, from 6 to 3
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 3, `armor` = 16 WHERE (`entry` = 6382);
UPDATE `applied_item_updates` SET `entry` = 6382, `version` = 3494 WHERE (`entry` = 6382);
-- Midnight Mace
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 10.0 to 0
-- dmg_type2, from 5 to 0
-- shadow_res, from 10 to 0
-- spellid_1, from 0 to 705
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `shadow_res` = 0, `spellid_1` = 705, `spelltrigger_1` = 2 WHERE (`entry` = 936);
UPDATE `applied_item_updates` SET `entry` = 936, `version` = 3494 WHERE (`entry` = 936);
-- Adept's Gloves
-- required_level, from 10 to 5
-- stat_value1, from 3 to 20
-- armor, from 9 to 8
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 20, `armor` = 8 WHERE (`entry` = 4768);
UPDATE `applied_item_updates` SET `entry` = 4768, `version` = 3494 WHERE (`entry` = 4768);
-- Grey Iron Axe
-- name, from Umbral Axe to Grey Iron Axe
-- required_level, from 10 to 5
-- dmg_min1, from 12.0 to 25
-- dmg_max1, from 23.0 to 39
UPDATE `item_template` SET `name` = 'Grey Iron Axe', `required_level` = 5, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3494 WHERE (`entry` = 6978);
-- Brocade Cloth Shoulderpads
-- name, from Brocade Shoulderpads to Brocade Cloth Shoulderpads
-- required_level, from 17 to 12
-- armor, from 10 to 9
UPDATE `item_template` SET `name` = 'Brocade Cloth Shoulderpads', `required_level` = 12, `armor` = 9 WHERE (`entry` = 1777);
UPDATE `applied_item_updates` SET `entry` = 1777, `version` = 3494 WHERE (`entry` = 1777);
-- Rough Bronze Cuirass
-- required_level, from 18 to 13
-- armor, from 53 to 49
UPDATE `item_template` SET `required_level` = 13, `armor` = 49 WHERE (`entry` = 2866);
UPDATE `applied_item_updates` SET `entry` = 2866, `version` = 3494 WHERE (`entry` = 2866);
-- Dirty Blunderbuss
-- required_level, from 15 to 8
-- dmg_min1, from 10.0 to 8
-- dmg_max1, from 19.0 to 13
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 2781);
UPDATE `applied_item_updates` SET `entry` = 2781, `version` = 3494 WHERE (`entry` = 2781);
-- Cross-stitched Bracers
-- required_level, from 23 to 18
-- armor, from 7 to 6
UPDATE `item_template` SET `required_level` = 18, `armor` = 6 WHERE (`entry` = 3381);
UPDATE `applied_item_updates` SET `entry` = 3381, `version` = 3494 WHERE (`entry` = 3381);
-- Flesh Piercer
-- required_level, from 24 to 19
-- dmg_min1, from 18.0 to 29
-- dmg_max1, from 35.0 to 44
-- spellid_1, from 18078 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 29, `dmg_max1` = 44, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3336);
UPDATE `applied_item_updates` SET `entry` = 3336, `version` = 3494 WHERE (`entry` = 3336);
-- Scorching Wand
-- required_level, from 28 to 23
-- dmg_min1, from 22.0 to 32
-- dmg_max1, from 41.0 to 48
-- delay, from 1300 to 2600
UPDATE `item_template` SET `required_level` = 23, `dmg_min1` = 32, `dmg_max1` = 48, `delay` = 2600 WHERE (`entry` = 5213);
UPDATE `applied_item_updates` SET `entry` = 5213, `version` = 3494 WHERE (`entry` = 5213);
-- Barbaric Belt
-- required_level, from 35 to 30
-- armor, from 25 to 23
-- spellid_1, from 9174 to 0
-- spellcategory_1, from 28 to 0
UPDATE `item_template` SET `required_level` = 30, `armor` = 23, `spellid_1` = 0, `spellcategory_1` = 0 WHERE (`entry` = 4264);
UPDATE `applied_item_updates` SET `entry` = 4264, `version` = 3494 WHERE (`entry` = 4264);
-- Assassin's Blade
-- dmg_min1, from 14.0 to 25
-- dmg_max1, from 27.0 to 39
UPDATE `item_template` SET `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 1935);
UPDATE `applied_item_updates` SET `entry` = 1935, `version` = 3494 WHERE (`entry` = 1935);
-- Brackclaw
-- required_level, from 14 to 9
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 15.0 to 23
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 2235);
UPDATE `applied_item_updates` SET `entry` = 2235, `version` = 3494 WHERE (`entry` = 2235);
-- Reinforced Woolen Shoulders
-- required_level, from 19 to 14
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 14, `armor` = 14 WHERE (`entry` = 4315);
UPDATE `applied_item_updates` SET `entry` = 4315, `version` = 3494 WHERE (`entry` = 4315);
-- Studded Leather Boots
-- name, from Studded Boots to Studded Leather Boots
-- required_level, from 32 to 27
-- stat_type1, from 5 to 3
-- stat_value1, from 2 to 3
-- armor, from 34 to 31
UPDATE `item_template` SET `name` = 'Studded Leather Boots', `required_level` = 27, `stat_type1` = 3, `stat_value1` = 3, `armor` = 31 WHERE (`entry` = 2467);
UPDATE `applied_item_updates` SET `entry` = 2467, `version` = 3494 WHERE (`entry` = 2467);
-- Augmented Chain Leggings
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 64 to 58
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 58 WHERE (`entry` = 2418);
UPDATE `applied_item_updates` SET `entry` = 2418, `version` = 3494 WHERE (`entry` = 2418);
-- Glowing Leather Bracers
-- required_level, from 23 to 18
-- stat_value1, from 1 to 2
-- armor, from 22 to 20
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `armor` = 20 WHERE (`entry` = 2017);
UPDATE `applied_item_updates` SET `entry` = 2017, `version` = 3494 WHERE (`entry` = 2017);
-- Thornspike
-- required_level, from 27 to 20
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 28.0 to 35
UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 6681);
UPDATE `applied_item_updates` SET `entry` = 6681, `version` = 3494 WHERE (`entry` = 6681);
-- Guardian Buckler
-- holy_res, from 0 to 4
UPDATE `item_template` SET `holy_res` = 4 WHERE (`entry` = 4820);
UPDATE `applied_item_updates` SET `entry` = 4820, `version` = 3494 WHERE (`entry` = 4820);
-- Staff of the Shade
-- dmg_min1, from 36.0 to 44
-- dmg_max1, from 55.0 to 60
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `dmg_min1` = 44, `dmg_max1` = 60, `shadow_res` = 1 WHERE (`entry` = 2549);
UPDATE `applied_item_updates` SET `entry` = 2549, `version` = 3494 WHERE (`entry` = 2549);
-- Oiled Blunderbuss
-- required_level, from 26 to 19
-- dmg_min1, from 16.0 to 10
-- dmg_max1, from 30.0 to 16
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 2786);
UPDATE `applied_item_updates` SET `entry` = 2786, `version` = 3494 WHERE (`entry` = 2786);
-- Deepwood Bracers
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 3204);
UPDATE `applied_item_updates` SET `entry` = 3204, `version` = 3494 WHERE (`entry` = 3204);
-- Emblazoned Belt
-- required_level, from 26 to 21
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 21, `armor` = 17 WHERE (`entry` = 6398);
UPDATE `applied_item_updates` SET `entry` = 6398, `version` = 3494 WHERE (`entry` = 6398);
-- Shadow Hood
-- required_level, from 29 to 24
-- stat_value1, from 2 to 3
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 4323);
UPDATE `applied_item_updates` SET `entry` = 4323, `version` = 3494 WHERE (`entry` = 4323);
-- Russet Belt
-- required_level, from 32 to 27
-- stat_value1, from 1 to 2
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `armor` = 10 WHERE (`entry` = 3593);
UPDATE `applied_item_updates` SET `entry` = 3593, `version` = 3494 WHERE (`entry` = 3593);
-- Stonesplinter Dagger
-- required_level, from 8 to 3
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 12.0 to 20
UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 2266);
UPDATE `applied_item_updates` SET `entry` = 2266, `version` = 3494 WHERE (`entry` = 2266);
-- Augmented Chain Vest
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 73 to 67
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 67 WHERE (`entry` = 2417);
UPDATE `applied_item_updates` SET `entry` = 2417, `version` = 3494 WHERE (`entry` = 2417);
-- Glyphed Helm
-- required_level, from 35 to 30
-- stat_value1, from 4 to 5
-- stat_type2, from 7 to 6
-- stat_value2, from 4 to 2
-- stat_type3, from 4 to 7
-- stat_value3, from 2 to 5
-- armor, from 36 to 32
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 5, `stat_type2` = 6, `stat_value2` = 2, `stat_type3` = 7, `stat_value3` = 5, `armor` = 32 WHERE (`entry` = 6422);
UPDATE `applied_item_updates` SET `entry` = 6422, `version` = 3494 WHERE (`entry` = 6422);
-- Tribal Headdress
-- required_level, from 32 to 27
-- stat_value1, from 3 to 5
-- stat_value2, from 4 to 5
-- armor, from 17 to 15
-- nature_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `stat_value2` = 5, `armor` = 15, `nature_res` = 1 WHERE (`entry` = 2622);
UPDATE `applied_item_updates` SET `entry` = 2622, `version` = 3494 WHERE (`entry` = 2622);
-- Darkweave Sash
-- required_level, from 30 to 25
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 11 to 10
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 2, `stat_value2` = 2, `armor` = 10, `shadow_res` = 1 WHERE (`entry` = 4720);
UPDATE `applied_item_updates` SET `entry` = 4720, `version` = 3494 WHERE (`entry` = 4720);
-- Artisan's Trousers
-- required_level, from 28 to 23
-- stat_value1, from 6 to 5
-- armor, from 22 to 20
UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 5, `armor` = 20 WHERE (`entry` = 5016);
UPDATE `applied_item_updates` SET `entry` = 5016, `version` = 3494 WHERE (`entry` = 5016);
-- Owl's Disk
-- required_level, from 18 to 13
-- stat_value1, from 1 to 3
-- armor, from 54 to 43
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 3, `armor` = 43 WHERE (`entry` = 4822);
UPDATE `applied_item_updates` SET `entry` = 4822, `version` = 3494 WHERE (`entry` = 4822);
-- Thick Cloth Vest
-- required_level, from 17 to 12
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 12, `armor` = 16 WHERE (`entry` = 200);
UPDATE `applied_item_updates` SET `entry` = 200, `version` = 3494 WHERE (`entry` = 200);
-- Thick Cloth Belt
-- required_level, from 17 to 12
-- armor, from 8 to 7
UPDATE `item_template` SET `required_level` = 12, `armor` = 7 WHERE (`entry` = 3597);
UPDATE `applied_item_updates` SET `entry` = 3597, `version` = 3494 WHERE (`entry` = 3597);
-- White Woolen Dress
-- armor, from 17 to 16
UPDATE `item_template` SET `armor` = 16 WHERE (`entry` = 6787);
UPDATE `applied_item_updates` SET `entry` = 6787, `version` = 3494 WHERE (`entry` = 6787);
-- Sylvan Cloak
-- required_level, from 19 to 14
-- stat_type1, from 1 to 7
-- stat_value1, from 8 to 1
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 14, `stat_type1` = 7, `stat_value1` = 1, `armor` = 14 WHERE (`entry` = 4793);
UPDATE `applied_item_updates` SET `entry` = 4793, `version` = 3494 WHERE (`entry` = 4793);
-- Rawhide Belt
-- name, from Patched Leather Belt to Rawhide Belt
-- required_level, from 13 to 8
-- armor, from 10 to 9
UPDATE `item_template` SET `name` = 'Rawhide Belt', `required_level` = 8, `armor` = 9 WHERE (`entry` = 1787);
UPDATE `applied_item_updates` SET `entry` = 1787, `version` = 3494 WHERE (`entry` = 1787);
-- Whirlwind Axe
-- stat_value2, from 30 to 40
-- dmg_min1, from 89.0 to 98
-- dmg_max1, from 134.0 to 133
UPDATE `item_template` SET `stat_value2` = 40, `dmg_min1` = 98, `dmg_max1` = 133 WHERE (`entry` = 6975);
UPDATE `applied_item_updates` SET `entry` = 6975, `version` = 3494 WHERE (`entry` = 6975);
-- Walking Boots
-- required_level, from 13 to 8
-- stat_value1, from 7 to 2
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 2, `armor` = 11 WHERE (`entry` = 4660);
UPDATE `applied_item_updates` SET `entry` = 4660, `version` = 3494 WHERE (`entry` = 4660);
-- Battleforge Gauntlets
-- required_level, from 22 to 17
-- armor, from 32 to 30
UPDATE `item_template` SET `required_level` = 17, `armor` = 30 WHERE (`entry` = 6595);
UPDATE `applied_item_updates` SET `entry` = 6595, `version` = 3494 WHERE (`entry` = 6595);
-- Deviate Scale Gloves
-- required_level, from 16 to 11
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 2
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 6, `stat_value1` = 2, `armor` = 19 WHERE (`entry` = 6467);
UPDATE `applied_item_updates` SET `entry` = 6467, `version` = 3494 WHERE (`entry` = 6467);
-- Burning War Axe
-- spellid_1, from 7711 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2299);
UPDATE `applied_item_updates` SET `entry` = 2299, `version` = 3494 WHERE (`entry` = 2299);
-- Firewalker Boots
-- required_level, from 18 to 13
-- stat_value1, from 6 to 30
-- stat_value2, from 7 to 30
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 30, `stat_value2` = 30, `armor` = 12 WHERE (`entry` = 6482);
UPDATE `applied_item_updates` SET `entry` = 6482, `version` = 3494 WHERE (`entry` = 6482);
-- Ringed Helm
-- required_level, from 25 to 20
-- stat_value1, from 3 to 5
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 5, `armor` = 26 WHERE (`entry` = 3392);
UPDATE `applied_item_updates` SET `entry` = 3392, `version` = 3494 WHERE (`entry` = 3392);
-- Venom Web Fang
-- required_level, from 14 to 9
-- dmg_min1, from 8.0 to 16
-- dmg_max1, from 16.0 to 25
-- spellid_1, from 18077 to 0
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 16, `dmg_max1` = 25, `spellid_1` = 0 WHERE (`entry` = 899);
UPDATE `applied_item_updates` SET `entry` = 899, `version` = 3494 WHERE (`entry` = 899);
-- Studded Leather Pants
-- name, from Studded Pants to Studded Leather Pants
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 43 to 39
UPDATE `item_template` SET `name` = 'Studded Leather Pants', `required_level` = 27, `stat_value1` = 5, `armor` = 39 WHERE (`entry` = 2465);
UPDATE `applied_item_updates` SET `entry` = 2465, `version` = 3494 WHERE (`entry` = 2465);
-- Studded Leather Gloves
-- name, from Studded Gloves to Studded Leather Gloves
-- required_level, from 32 to 27
-- armor, from 27 to 25
UPDATE `item_template` SET `name` = 'Studded Leather Gloves', `required_level` = 27, `armor` = 25 WHERE (`entry` = 2469);
UPDATE `applied_item_updates` SET `entry` = 2469, `version` = 3494 WHERE (`entry` = 2469);
-- Hardened Leather Shoulderpads
-- name, from Tough Leather Shoulderpads to Hardened Leather Shoulderpads
-- required_level, from 21 to 16
-- armor, from 21 to 19
UPDATE `item_template` SET `name` = 'Hardened Leather Shoulderpads', `required_level` = 16, `armor` = 19 WHERE (`entry` = 1809);
UPDATE `applied_item_updates` SET `entry` = 1809, `version` = 3494 WHERE (`entry` = 1809);
-- Battleforge Leggings
-- required_level, from 20 to 15
-- armor, from 53 to 48
UPDATE `item_template` SET `required_level` = 15, `armor` = 48 WHERE (`entry` = 6596);
UPDATE `applied_item_updates` SET `entry` = 6596, `version` = 3494 WHERE (`entry` = 6596);
-- Patched Leather Boots
-- name, from Warped Leather Boots to Patched Leather Boots
-- required_level, from 10 to 5
-- armor, from 14 to 12
UPDATE `item_template` SET `name` = 'Patched Leather Boots', `required_level` = 5, `armor` = 12 WHERE (`entry` = 1503);
UPDATE `applied_item_updates` SET `entry` = 1503, `version` = 3494 WHERE (`entry` = 1503);
-- Siege Brigade Vest
-- required_level, from 5 to 1
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 1, `armor` = 30 WHERE (`entry` = 3151);
UPDATE `applied_item_updates` SET `entry` = 3151, `version` = 3494 WHERE (`entry` = 3151);
-- Cracked Leather Belt
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2122);
UPDATE `applied_item_updates` SET `entry` = 2122, `version` = 3494 WHERE (`entry` = 2122);
-- Canvas Cloak
-- required_level, from 13 to 8
UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 1766);
UPDATE `applied_item_updates` SET `entry` = 1766, `version` = 3494 WHERE (`entry` = 1766);
-- Veteran Buckler
-- required_level, from 12 to 7
-- stat_type1, from 1 to 3
-- stat_value1, from 4 to 2
-- armor, from 44 to 35
UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 3, `stat_value1` = 2, `armor` = 35 WHERE (`entry` = 3652);
UPDATE `applied_item_updates` SET `entry` = 3652, `version` = 3494 WHERE (`entry` = 3652);
-- Gloom Wand
-- dmg_min1, from 16.0 to 26
-- dmg_max1, from 31.0 to 40
-- delay, from 1800 to 3300
UPDATE `item_template` SET `dmg_min1` = 26, `dmg_max1` = 40, `delay` = 3300 WHERE (`entry` = 5209);
UPDATE `applied_item_updates` SET `entry` = 5209, `version` = 3494 WHERE (`entry` = 5209);
-- Fish Gutter
-- required_level, from 27 to 22
-- dmg_min1, from 21.0 to 32
-- dmg_max1, from 41.0 to 49
UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 32, `dmg_max1` = 49 WHERE (`entry` = 3755);
UPDATE `applied_item_updates` SET `entry` = 3755, `version` = 3494 WHERE (`entry` = 3755);
-- Robe of the Moccasin
-- required_level, from 16 to 11
-- stat_value1, from 1 to 3
-- stat_value2, from 1 to 2
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 3, `stat_value2` = 2, `armor` = 17 WHERE (`entry` = 6465);
UPDATE `applied_item_updates` SET `entry` = 6465, `version` = 3494 WHERE (`entry` = 6465);
-- Big Iron Fishing Pole
-- dmg_min1, from 3.0 to 12
-- dmg_max1, from 7.0 to 15
UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 15 WHERE (`entry` = 6367);
UPDATE `applied_item_updates` SET `entry` = 6367, `version` = 3494 WHERE (`entry` = 6367);
-- Fire Hardened Buckler
-- required_level, from 22 to 17
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 60 to 48
-- fire_res, from 0 to 4
UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2, `stat_value2` = 2, `armor` = 48, `fire_res` = 4 WHERE (`entry` = 1276);
UPDATE `applied_item_updates` SET `entry` = 1276, `version` = 3494 WHERE (`entry` = 1276);
-- Claymore of the Martyr
-- stat_value1, from 3 to 5
-- dmg_min1, from 34.0 to 46
-- dmg_max1, from 52.0 to 62
UPDATE `item_template` SET `stat_value1` = 5, `dmg_min1` = 46, `dmg_max1` = 62 WHERE (`entry` = 2877);
UPDATE `applied_item_updates` SET `entry` = 2877, `version` = 3494 WHERE (`entry` = 2877);
-- Runic Loin Cloth
-- required_level, from 12 to 7
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 3
-- armor, from 15 to 13
UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 6, `stat_value1` = 3, `armor` = 13 WHERE (`entry` = 3309);
UPDATE `applied_item_updates` SET `entry` = 3309, `version` = 3494 WHERE (`entry` = 3309);
-- Quicksilver Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5008);
UPDATE `applied_item_updates` SET `entry` = 5008, `version` = 3494 WHERE (`entry` = 5008);
-- Burning Wand
-- dmg_min1, from 15.0 to 24
-- dmg_max1, from 28.0 to 36
-- delay, from 1400 to 2700
UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 36, `delay` = 2700 WHERE (`entry` = 5210);
UPDATE `applied_item_updates` SET `entry` = 5210, `version` = 3494 WHERE (`entry` = 5210);
-- Mail Combat Spaulders
-- required_level, from 31 to 26
-- armor, from 58 to 53
UPDATE `item_template` SET `required_level` = 26, `armor` = 53 WHERE (`entry` = 6404);
UPDATE `applied_item_updates` SET `entry` = 6404, `version` = 3494 WHERE (`entry` = 6404);
-- Defias Mage Staff
-- required_level, from 11 to 6
-- stat_value1, from 1 to 2
-- dmg_min1, from 20.0 to 32
-- dmg_max1, from 31.0 to 44
UPDATE `item_template` SET `required_level` = 6, `stat_value1` = 2, `dmg_min1` = 32, `dmg_max1` = 44 WHERE (`entry` = 1928);
UPDATE `applied_item_updates` SET `entry` = 1928, `version` = 3494 WHERE (`entry` = 1928);
-- Executioner's Sword
-- required_level, from 19 to 21
-- stat_value2, from 2 to 4
-- dmg_min1, from 39.0 to 51
-- dmg_max1, from 59.0 to 70
UPDATE `item_template` SET `required_level` = 21, `stat_value2` = 4, `dmg_min1` = 51, `dmg_max1` = 70 WHERE (`entry` = 4818);
UPDATE `applied_item_updates` SET `entry` = 4818, `version` = 3494 WHERE (`entry` = 4818);
-- Thick Murloc Armor
-- required_level, from 29 to 24
-- stat_value1, from 3 to 11
-- stat_type2, from 7 to 3
-- stat_value2, from 3 to 6
-- armor, from 50 to 46
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 11, `stat_type2` = 3, `stat_value2` = 6, `armor` = 46 WHERE (`entry` = 5782);
UPDATE `applied_item_updates` SET `entry` = 5782, `version` = 3494 WHERE (`entry` = 5782);
-- Laced Mail Gloves
-- required_level, from 13 to 8
-- armor, from 18 to 17
UPDATE `item_template` SET `required_level` = 8, `armor` = 17 WHERE (`entry` = 1742);
UPDATE `applied_item_updates` SET `entry` = 1742, `version` = 3494 WHERE (`entry` = 1742);
-- Strapped Leather Armor
-- name, from Bound Harness to Strapped Leather Armor
-- required_level, from 6 to 1
-- armor, from 24 to 22
UPDATE `item_template` SET `name` = 'Strapped Leather Armor', `required_level` = 1, `armor` = 22 WHERE (`entry` = 4968);
UPDATE `applied_item_updates` SET `entry` = 4968, `version` = 3494 WHERE (`entry` = 4968);
-- Pulsating Hydra Heart
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 5183);
UPDATE `applied_item_updates` SET `entry` = 5183, `version` = 3494 WHERE (`entry` = 5183);
-- Small Egg
-- display_id, from 18046 to 13211
UPDATE `item_template` SET `display_id` = 13211 WHERE (`entry` = 6889);
UPDATE `applied_item_updates` SET `entry` = 6889, `version` = 3494 WHERE (`entry` = 6889);
-- Brightweave Gloves
-- required_level, from 35 to 30
-- stat_value2, from 35 to 40
-- armor, from 16 to 15
UPDATE `item_template` SET `required_level` = 30, `stat_value2` = 40, `armor` = 15 WHERE (`entry` = 4042);
UPDATE `applied_item_updates` SET `entry` = 4042, `version` = 3494 WHERE (`entry` = 4042);
-- Worn Mail Pants
-- required_level, from 7 to 2
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 2, `armor` = 21 WHERE (`entry` = 1735);
UPDATE `applied_item_updates` SET `entry` = 1735, `version` = 3494 WHERE (`entry` = 1735);
-- Worn Mail Bracers
-- required_level, from 9 to 4
-- armor, from 14 to 13
UPDATE `item_template` SET `required_level` = 4, `armor` = 13 WHERE (`entry` = 1732);
UPDATE `applied_item_updates` SET `entry` = 1732, `version` = 3494 WHERE (`entry` = 1732);
-- Sporid Cape
-- display_id, from 15236 to 12597
-- required_level, from 17 to 12
-- stat_type1, from 7 to 5
-- armor, from 14 to 13
UPDATE `item_template` SET `display_id` = 12597, `required_level` = 12, `stat_type1` = 5, `armor` = 13 WHERE (`entry` = 6629);
UPDATE `applied_item_updates` SET `entry` = 6629, `version` = 3494 WHERE (`entry` = 6629);
-- Canvas Belt
-- required_level, from 13 to 8
-- armor, from 5 to 4
UPDATE `item_template` SET `required_level` = 8, `armor` = 4 WHERE (`entry` = 3376);
UPDATE `applied_item_updates` SET `entry` = 3376, `version` = 3494 WHERE (`entry` = 3376);
-- Calico Vest
-- name, from Calico Tunic to Calico Vest
-- required_level, from 8 to 3
-- armor, from 9 to 8
UPDATE `item_template` SET `name` = 'Calico Vest', `required_level` = 3, `armor` = 8 WHERE (`entry` = 1501);
UPDATE `applied_item_updates` SET `entry` = 1501, `version` = 3494 WHERE (`entry` = 1501);
-- Ruffled Feather
-- buy_price, from 165 to 215
-- sell_price, from 41 to 53
UPDATE `item_template` SET `buy_price` = 215, `sell_price` = 53 WHERE (`entry` = 4776);
UPDATE `applied_item_updates` SET `entry` = 4776, `version` = 3494 WHERE (`entry` = 4776);
-- Cheap Blunderbuss
-- required_level, from 10 to 3
-- dmg_max1, from 15.0 to 11
UPDATE `item_template` SET `required_level` = 3, `dmg_max1` = 11 WHERE (`entry` = 2778);
UPDATE `applied_item_updates` SET `entry` = 2778, `version` = 3494 WHERE (`entry` = 2778);
-- Combat Buckler
-- required_level, from 30 to 25
-- stat_type2, from 7 to 6
-- stat_value2, from 2 to 4
-- armor, from 74 to 59
UPDATE `item_template` SET `required_level` = 25, `stat_type2` = 6, `stat_value2` = 4, `armor` = 59 WHERE (`entry` = 4066);
UPDATE `applied_item_updates` SET `entry` = 4066, `version` = 3494 WHERE (`entry` = 4066);
-- Patched Leather Gloves
-- name, from Warped Leather Gloves to Patched Leather Gloves
-- required_level, from 8 to 3
-- armor, from 10 to 9
UPDATE `item_template` SET `name` = 'Patched Leather Gloves', `required_level` = 3, `armor` = 9 WHERE (`entry` = 1506);
UPDATE `applied_item_updates` SET `entry` = 1506, `version` = 3494 WHERE (`entry` = 1506);
-- Nightbane Staff
-- shadow_res, from 7 to 0
UPDATE `item_template` SET `shadow_res` = 0 WHERE (`entry` = 3227);
UPDATE `applied_item_updates` SET `entry` = 3227, `version` = 3494 WHERE (`entry` = 3227);
-- Footpad's Pants
-- armor, from 3 to 1
UPDATE `item_template` SET `armor` = 1 WHERE (`entry` = 48);
UPDATE `applied_item_updates` SET `entry` = 48, `version` = 3494 WHERE (`entry` = 48);
-- Thin Cloth Armor
-- armor, from 6 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2121);
UPDATE `applied_item_updates` SET `entry` = 2121, `version` = 3494 WHERE (`entry` = 2121);
-- Thin Cloth Pants
-- display_id, from 9974 to 2185
UPDATE `item_template` SET `display_id` = 2185 WHERE (`entry` = 2120);
UPDATE `applied_item_updates` SET `entry` = 2120, `version` = 3494 WHERE (`entry` = 2120);
-- Outfitter Boots
-- armor, from 10 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2691);
UPDATE `applied_item_updates` SET `entry` = 2691, `version` = 3494 WHERE (`entry` = 2691);
-- Tarnished Chain Gloves
-- armor, from 10 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2385);
UPDATE `applied_item_updates` SET `entry` = 2385, `version` = 3494 WHERE (`entry` = 2385);
-- Tarnished Chain Vest
-- armor, from 17 to 16
UPDATE `item_template` SET `armor` = 16 WHERE (`entry` = 2379);
UPDATE `applied_item_updates` SET `entry` = 2379, `version` = 3494 WHERE (`entry` = 2379);
-- Tarnished Chain Belt
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2380);
UPDATE `applied_item_updates` SET `entry` = 2380, `version` = 3494 WHERE (`entry` = 2380);
-- Tarnished Chain Leggings
-- armor, from 15 to 14
UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 2381);
UPDATE `applied_item_updates` SET `entry` = 2381, `version` = 3494 WHERE (`entry` = 2381);
-- Tarnished Chain Boots
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 2383);
UPDATE `applied_item_updates` SET `entry` = 2383, `version` = 3494 WHERE (`entry` = 2383);
-- Tarnished Chain Bracers
-- armor, from 9 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2384);
UPDATE `applied_item_updates` SET `entry` = 2384, `version` = 3494 WHERE (`entry` = 2384);
-- Large Round Shield
-- armor, from 19 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 2129);
UPDATE `applied_item_updates` SET `entry` = 2129, `version` = 3494 WHERE (`entry` = 2129);
-- Thin Cloth Belt
-- armor, from 3 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3599);
UPDATE `applied_item_updates` SET `entry` = 3599, `version` = 3494 WHERE (`entry` = 3599);
-- Thin Cloth Gloves
-- armor, from 9 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 2119);
UPDATE `applied_item_updates` SET `entry` = 2119, `version` = 3494 WHERE (`entry` = 2119);
-- Thin Cloth Bracers
-- armor, from 6 to 3
UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3600);
UPDATE `applied_item_updates` SET `entry` = 3600, `version` = 3494 WHERE (`entry` = 3600);
-- Thin Cloth Shoes
-- display_id, from 4143 to 3757
UPDATE `item_template` SET `display_id` = 3757 WHERE (`entry` = 2117);
UPDATE `applied_item_updates` SET `entry` = 2117, `version` = 3494 WHERE (`entry` = 2117);
-- Cracked Leather Vest
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 2127);
UPDATE `applied_item_updates` SET `entry` = 2127, `version` = 3494 WHERE (`entry` = 2127);
-- Cracked Leather Belt
-- armor, from 17 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2122);
UPDATE `applied_item_updates` SET `entry` = 2122, `version` = 3494 WHERE (`entry` = 2122);
-- Cracked Leather Boots
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2123);
UPDATE `applied_item_updates` SET `entry` = 2123, `version` = 3494 WHERE (`entry` = 2123);
-- Cracked Leather Gloves
-- armor, from 7 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2125);
UPDATE `applied_item_updates` SET `entry` = 2125, `version` = 3494 WHERE (`entry` = 2125);
-- Cracked Leather Pants
-- armor, from 10 to 9
UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2126);
UPDATE `applied_item_updates` SET `entry` = 2126, `version` = 3494 WHERE (`entry` = 2126);
-- Layered Vest
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 60);
UPDATE `applied_item_updates` SET `entry` = 60, `version` = 3494 WHERE (`entry` = 60);
-- Skeletal Gauntlets
-- required_level, from 12 to 7
-- armor, from 28 to 26
UPDATE `item_template` SET `required_level` = 7, `armor` = 26 WHERE (`entry` = 4676);
UPDATE `applied_item_updates` SET `entry` = 4676, `version` = 3494 WHERE (`entry` = 4676);
-- Gladiator War Axe
-- required_level, from 24 to 19
-- dmg_min1, from 44.0 to 52
-- dmg_max1, from 67.0 to 71
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 52, `dmg_max1` = 71 WHERE (`entry` = 3201);
UPDATE `applied_item_updates` SET `entry` = 3201, `version` = 3494 WHERE (`entry` = 3201);
-- Small Bear Tooth
-- name, from Chipped Bear Tooth to Small Bear Tooth
-- buy_price, from 75 to 135
-- sell_price, from 18 to 33
UPDATE `item_template` SET `name` = 'Small Bear Tooth', `buy_price` = 135, `sell_price` = 33 WHERE (`entry` = 3169);
UPDATE `applied_item_updates` SET `entry` = 3169, `version` = 3494 WHERE (`entry` = 3169);
-- Large Bear Tooth
-- buy_price, from 190 to 290
-- sell_price, from 47 to 72
UPDATE `item_template` SET `buy_price` = 290, `sell_price` = 72 WHERE (`entry` = 3170);
UPDATE `applied_item_updates` SET `entry` = 3170, `version` = 3494 WHERE (`entry` = 3170);
-- Rat Cloth Cloak
-- required_level, from 10 to 5
-- stat_type1, from 1 to 7
-- stat_value1, from 4 to 1
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 7, `stat_value1` = 1, `armor` = 11 WHERE (`entry` = 2284);
UPDATE `applied_item_updates` SET `entry` = 2284, `version` = 3494 WHERE (`entry` = 2284);
-- Pikeman Shield
-- armor, from 19 to 12
UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 6078);
UPDATE `applied_item_updates` SET `entry` = 6078, `version` = 3494 WHERE (`entry` = 6078);
-- Rabbit Handler Gloves
-- armor, from 3 to 2
UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 719);
UPDATE `applied_item_updates` SET `entry` = 719, `version` = 3494 WHERE (`entry` = 719);
-- Smooth Walking Staff
-- required_level, from 2 to 1
-- dmg_min1, from 9.0 to 15
-- dmg_max1, from 14.0 to 21
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 15, `dmg_max1` = 21 WHERE (`entry` = 5581);
UPDATE `applied_item_updates` SET `entry` = 5581, `version` = 3494 WHERE (`entry` = 5581);
-- Laced Mail Vest
-- required_level, from 11 to 6
-- armor, from 31 to 28
UPDATE `item_template` SET `required_level` = 6, `armor` = 28 WHERE (`entry` = 1745);
UPDATE `applied_item_updates` SET `entry` = 1745, `version` = 3494 WHERE (`entry` = 1745);
-- Boar Handler Gloves
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2547);
UPDATE `applied_item_updates` SET `entry` = 2547, `version` = 3494 WHERE (`entry` = 2547);
-- Warped Shortsword
-- name, from Commoner's Sword to Warped Shortsword
-- required_level, from 10 to 3
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 11.0 to 20
UPDATE `item_template` SET `name` = 'Warped Shortsword', `required_level` = 3, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 1511);
UPDATE `applied_item_updates` SET `entry` = 1511, `version` = 3494 WHERE (`entry` = 1511);
-- Fist of the People's Militia
-- required_level, from 12 to 7
-- dmg_min1, from 8.0 to 16
-- dmg_max1, from 15.0 to 25
UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 16, `dmg_max1` = 25 WHERE (`entry` = 1480);
UPDATE `applied_item_updates` SET `entry` = 1480, `version` = 3494 WHERE (`entry` = 1480);
-- Robe of the Keeper
-- required_level, from 10 to 5
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 3
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 3161);
UPDATE `applied_item_updates` SET `entry` = 3161, `version` = 3494 WHERE (`entry` = 3161);
-- Cracked Leather Bracers
-- armor, from 6 to 5
UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2124);
UPDATE `applied_item_updates` SET `entry` = 2124, `version` = 3494 WHERE (`entry` = 2124);
-- Wolf Handler Gloves
-- buy_price, from 32 to 21
-- sell_price, from 6 to 4
-- item_level, from 5 to 4
-- armor, from 19 to 5
UPDATE `item_template` SET `buy_price` = 21, `sell_price` = 4, `item_level` = 4, `armor` = 5 WHERE (`entry` = 6171);
UPDATE `applied_item_updates` SET `entry` = 6171, `version` = 3494 WHERE (`entry` = 6171);
-- Ironforge Breastplate
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6731);
UPDATE `applied_item_updates` SET `entry` = 6731, `version` = 3494 WHERE (`entry` = 6731);
-- Bottle of Pinot Noir (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2723);
UPDATE `applied_item_updates` SET `entry` = 2723, `version` = 3494 WHERE (`entry` = 2723);
-- Flask of Port (needs effect)
-- spellid_1, from 11008 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2593);
UPDATE `applied_item_updates` SET `entry` = 2593, `version` = 3494 WHERE (`entry` = 2593);
-- Skin of Dwarven Stout (needs effect)
-- spellid_1, from 11008 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2596);
UPDATE `applied_item_updates` SET `entry` = 2596, `version` = 3494 WHERE (`entry` = 2596);
-- Flagon of Mead (needs effect)
-- spellid_1, from 1133 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2594);
UPDATE `applied_item_updates` SET `entry` = 2594, `version` = 3494 WHERE (`entry` = 2594);
-- Jug of Bourbon (needs effect)
-- spellid_1, from 1133 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2595);
UPDATE `applied_item_updates` SET `entry` = 2595, `version` = 3494 WHERE (`entry` = 2595);
-- Small Brown Pouch
-- item_level, from 5 to 10
UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 4496);
UPDATE `applied_item_updates` SET `entry` = 4496, `version` = 3494 WHERE (`entry` = 4496);
-- Scalemail Belt
-- required_level, from 17 to 12
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 12, `armor` = 21 WHERE (`entry` = 1853);
UPDATE `applied_item_updates` SET `entry` = 1853, `version` = 3494 WHERE (`entry` = 1853);
-- Solid Shortblade
-- required_level, from 13 to 8
-- dmg_min1, from 13.0 to 30
-- dmg_max1, from 25.0 to 37
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 30, `dmg_max1` = 37 WHERE (`entry` = 2074);
UPDATE `applied_item_updates` SET `entry` = 2074, `version` = 3494 WHERE (`entry` = 2074);
-- Aegis of Westfall
-- spellid_1, from 13675 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2040);
UPDATE `applied_item_updates` SET `entry` = 2040, `version` = 3494 WHERE (`entry` = 2040);
-- Seer's Sash
-- name, from Seer's Belt to Seer's Sash
-- buy_price, from 1934 to 2186
-- sell_price, from 386 to 437
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- stat_type1, from 5 to 6
UPDATE `item_template` SET `name` = 'Seer\'s Sash', `buy_price` = 2186, `sell_price` = 437, `item_level` = 23, `required_level` = 13, `stat_type1` = 6 WHERE (`entry` = 4699);
UPDATE `applied_item_updates` SET `entry` = 4699, `version` = 3494 WHERE (`entry` = 4699);
-- Gloves of Meditation
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `armor` = 11 WHERE (`entry` = 4318);
UPDATE `applied_item_updates` SET `entry` = 4318, `version` = 3494 WHERE (`entry` = 4318);
-- Ruffled Chaplet
-- required_level, from 26 to 21
-- stat_value1, from 4 to 6
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 6, `armor` = 27 WHERE (`entry` = 5753);
UPDATE `applied_item_updates` SET `entry` = 5753, `version` = 3494 WHERE (`entry` = 5753);
-- Raptorbane Tunic
-- spellid_1, from 14565 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3566);
UPDATE `applied_item_updates` SET `entry` = 3566, `version` = 3494 WHERE (`entry` = 3566);
-- Wolf Bracers
-- required_level, from 20 to 15
-- stat_type1, from 3 to 7
-- armor, from 20 to 18
UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 7, `armor` = 18 WHERE (`entry` = 4794);
UPDATE `applied_item_updates` SET `entry` = 4794, `version` = 3494 WHERE (`entry` = 4794);
-- Webwing Cloak
-- nature_res, from 0 to 2
-- frost_res, from 0 to 2
UPDATE `item_template` SET `nature_res` = 2, `frost_res` = 2 WHERE (`entry` = 5751);
UPDATE `applied_item_updates` SET `entry` = 5751, `version` = 3494 WHERE (`entry` = 5751);
-- Glorious Shoulders
-- required_level, from 23 to 18
-- stat_value1, from 1 to 2
-- armor, from 53 to 48
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `armor` = 48 WHERE (`entry` = 4833);
UPDATE `applied_item_updates` SET `entry` = 4833, `version` = 3494 WHERE (`entry` = 4833);
-- Chieftain Girdle
-- required_level, from 18 to 13
-- armor, from 26 to 23
UPDATE `item_template` SET `required_level` = 13, `armor` = 23 WHERE (`entry` = 5750);
UPDATE `applied_item_updates` SET `entry` = 5750, `version` = 3494 WHERE (`entry` = 5750);
-- Green Iron Boots
-- required_level, from 24 to 19
-- stat_value1, from 3 to 4
-- armor, from 46 to 42
UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 4, `armor` = 42 WHERE (`entry` = 3484);
UPDATE `applied_item_updates` SET `entry` = 3484, `version` = 3494 WHERE (`entry` = 3484);
-- Glinting Scale Bracers
-- required_level, from 20 to 15
-- armor, from 28 to 25
UPDATE `item_template` SET `required_level` = 15, `armor` = 25 WHERE (`entry` = 3212);
UPDATE `applied_item_updates` SET `entry` = 3212, `version` = 3494 WHERE (`entry` = 3212);
-- Silvered Bronze Gauntlets
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 3483);
UPDATE `applied_item_updates` SET `entry` = 3483, `version` = 3494 WHERE (`entry` = 3483);
-- Blood Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 4998);
UPDATE `applied_item_updates` SET `entry` = 4998, `version` = 3494 WHERE (`entry` = 4998);
-- Worn Mail Bracers
-- required_level, from 9 to 4
-- armor, from 14 to 13
UPDATE `item_template` SET `required_level` = 4, `armor` = 13 WHERE (`entry` = 1732);
UPDATE `applied_item_updates` SET `entry` = 1732, `version` = 3494 WHERE (`entry` = 1732);
-- Patched Leather Gloves
-- name, from Warped Leather Gloves to Patched Leather Gloves
-- required_level, from 8 to 3
-- armor, from 10 to 9
UPDATE `item_template` SET `name` = 'Patched Leather Gloves', `required_level` = 3, `armor` = 9 WHERE (`entry` = 1506);
UPDATE `applied_item_updates` SET `entry` = 1506, `version` = 3494 WHERE (`entry` = 1506);
-- Dwarven Leather Pants
-- armor, from 8 to 7
UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 61);
UPDATE `applied_item_updates` SET `entry` = 61, `version` = 3494 WHERE (`entry` = 61);
-- Calico Belt
-- required_level, from 9 to 4
UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 3374);
UPDATE `applied_item_updates` SET `entry` = 3374, `version` = 3494 WHERE (`entry` = 3374);
-- Augmented Chain Vest
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 73 to 67
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 67 WHERE (`entry` = 2417);
UPDATE `applied_item_updates` SET `entry` = 2417, `version` = 3494 WHERE (`entry` = 2417);
-- Hardened Iron Shortsword
-- required_level, from 27 to 22
-- stat_value1, from 20 to 42
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 35.0 to 42
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 42, `dmg_min1` = 28, `dmg_max1` = 42 WHERE (`entry` = 3849);
UPDATE `applied_item_updates` SET `entry` = 3849, `version` = 3494 WHERE (`entry` = 3849);
-- Shimmering Robe
-- display_id, from 15221 to 12471
-- required_level, from 17 to 12
-- armor, from 19 to 17
UPDATE `item_template` SET `display_id` = 12471, `required_level` = 12, `armor` = 17 WHERE (`entry` = 6569);
UPDATE `applied_item_updates` SET `entry` = 6569, `version` = 3494 WHERE (`entry` = 6569);
-- Flameweave Belt
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 4708);
UPDATE `applied_item_updates` SET `entry` = 4708, `version` = 3494 WHERE (`entry` = 4708);
-- Chipped Quarterstaff
-- required_level, from 15 to 8
-- dmg_min1, from 16.0 to 25
-- dmg_max1, from 25.0 to 34
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 25, `dmg_max1` = 34 WHERE (`entry` = 1813);
UPDATE `applied_item_updates` SET `entry` = 1813, `version` = 3494 WHERE (`entry` = 1813);
-- Dervish Tunic
-- display_id, from 14773 to 12499
-- buy_price, from 7056 to 6474
-- sell_price, from 1411 to 1294
-- required_level, from 20 to 15
-- armor, from 41 to 37
UPDATE `item_template` SET `display_id` = 12499, `buy_price` = 6474, `sell_price` = 1294, `required_level` = 15, `armor` = 37 WHERE (`entry` = 6603);
UPDATE `applied_item_updates` SET `entry` = 6603, `version` = 3494 WHERE (`entry` = 6603);
-- Crystal Starfire Medallion
-- item_level, from 31 to 33
-- required_level, from 26 to 23
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 3
-- stat_value3, from 2 to 5
UPDATE `item_template` SET `item_level` = 33, `required_level` = 23, `stat_value1` = 3, `stat_value2` = 3, `stat_value3` = 5 WHERE (`entry` = 5003);
UPDATE `applied_item_updates` SET `entry` = 5003, `version` = 3494 WHERE (`entry` = 5003);
-- Slime Encrusted Pads
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 17 to 16
-- spellid_1, from 18764 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 2, `armor` = 16, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6461);
UPDATE `applied_item_updates` SET `entry` = 6461, `version` = 3494 WHERE (`entry` = 6461);
-- Robes of Antiquity
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 5812);
UPDATE `applied_item_updates` SET `entry` = 5812, `version` = 3494 WHERE (`entry` = 5812);
-- Belt of Arugal
-- buy_price, from 4135 to 3862
-- sell_price, from 827 to 772
-- stat_value1, from 25 to 2
-- armor, from 10 to 9
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `buy_price` = 3862, `sell_price` = 772, `stat_value1` = 2, `armor` = 9, `shadow_res` = 4 WHERE (`entry` = 6392);
UPDATE `applied_item_updates` SET `entry` = 6392, `version` = 3494 WHERE (`entry` = 6392);
-- Scarab Trousers
-- buy_price, from 2705 to 2713
-- sell_price, from 541 to 542
-- required_level, from 15 to 10
-- stat_type1, from 6 to 5
-- stat_value1, from 1 to 2
-- stat_type2, from 7 to 6
-- stat_value2, from 1 to 2
-- armor, from 16 to 14
UPDATE `item_template` SET `buy_price` = 2713, `sell_price` = 542, `required_level` = 10, `stat_type1` = 5, `stat_value1` = 2, `stat_type2` = 6, `stat_value2` = 2, `armor` = 14 WHERE (`entry` = 6659);
UPDATE `applied_item_updates` SET `entry` = 6659, `version` = 3494 WHERE (`entry` = 6659);
-- Shimmering Boots
-- display_id, from 14749 to 12466
-- buy_price, from 2923 to 3304
-- sell_price, from 584 to 660
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- armor, from 13 to 12
UPDATE `item_template` SET `display_id` = 12466, `buy_price` = 3304, `sell_price` = 660, `item_level` = 23, `required_level` = 13, `armor` = 12 WHERE (`entry` = 6562);
UPDATE `applied_item_updates` SET `entry` = 6562, `version` = 3494 WHERE (`entry` = 6562);
-- Sage's Bracers
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6613);
UPDATE `applied_item_updates` SET `entry` = 6613, `version` = 3494 WHERE (`entry` = 6613);
-- Serpent Gloves
-- required_level, from 17 to 12
-- stat_value1, from 1 to 3
-- stat_value2, from 5 to 29
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 3, `stat_value2` = 29, `armor` = 10 WHERE (`entry` = 5970);
UPDATE `applied_item_updates` SET `entry` = 5970, `version` = 3494 WHERE (`entry` = 5970);
-- Flameweave Cloak
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6381);
UPDATE `applied_item_updates` SET `entry` = 6381, `version` = 3494 WHERE (`entry` = 6381);
-- Driving Gloves
-- required_level, from 4 to 1
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 1, `armor` = 10 WHERE (`entry` = 3152);
UPDATE `applied_item_updates` SET `entry` = 3152, `version` = 3494 WHERE (`entry` = 3152);
-- Handstitched Leather Vest
-- armor, from 12 to 11
UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 5957);
UPDATE `applied_item_updates` SET `entry` = 5957, `version` = 3494 WHERE (`entry` = 5957);
-- Silvered Bronze Shoulders
-- required_level, from 20 to 15
-- armor, from 49 to 45
UPDATE `item_template` SET `required_level` = 15, `armor` = 45 WHERE (`entry` = 3481);
UPDATE `applied_item_updates` SET `entry` = 3481, `version` = 3494 WHERE (`entry` = 3481);
-- Silvered Bronze Breastplate
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 3
-- armor, from 62 to 56
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `stat_value2` = 3, `armor` = 56, `shadow_res` = 1 WHERE (`entry` = 2869);
UPDATE `applied_item_updates` SET `entry` = 2869, `version` = 3494 WHERE (`entry` = 2869);
-- Reinforced Woolen Shoulders
-- required_level, from 19 to 14
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 14, `armor` = 14 WHERE (`entry` = 4315);
UPDATE `applied_item_updates` SET `entry` = 4315, `version` = 3494 WHERE (`entry` = 4315);
-- Sage's Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 6610);
UPDATE `applied_item_updates` SET `entry` = 6610, `version` = 3494 WHERE (`entry` = 6610);
-- Heavy Woolen Pants
-- required_level, from 17 to 12
-- stat_value1, from 2 to 5
-- armor, from 17 to 15
UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 5, `armor` = 15 WHERE (`entry` = 4316);
UPDATE `applied_item_updates` SET `entry` = 4316, `version` = 3494 WHERE (`entry` = 4316);
-- Wispy Silk Boots
-- spellid_1, from 7701 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4324);
UPDATE `applied_item_updates` SET `entry` = 4324, `version` = 3494 WHERE (`entry` = 4324);
-- Berserker Pauldrons
-- name, from Cutthroat Pauldrons to Berserker Pauldrons
-- required_level, from 20 to 15
-- armor, from 49 to 45
UPDATE `item_template` SET `name` = 'Berserker Pauldrons', `required_level` = 15, `armor` = 45 WHERE (`entry` = 3231);
UPDATE `applied_item_updates` SET `entry` = 3231, `version` = 3494 WHERE (`entry` = 3231);
-- Dagmire Gauntlets
-- buy_price, from 3209 to 3041
-- sell_price, from 641 to 608
-- required_level, from 18 to 13
-- stat_value1, from 1 to 3
-- armor, from 33 to 30
UPDATE `item_template` SET `buy_price` = 3041, `sell_price` = 608, `required_level` = 13, `stat_value1` = 3, `armor` = 30 WHERE (`entry` = 6481);
UPDATE `applied_item_updates` SET `entry` = 6481, `version` = 3494 WHERE (`entry` = 6481);
-- Bent Large Shield
-- armor, from 10 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2211);
UPDATE `applied_item_updates` SET `entry` = 2211, `version` = 3494 WHERE (`entry` = 2211);
-- Glimmering Mail Leggings
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 6386);
UPDATE `applied_item_updates` SET `entry` = 6386, `version` = 3494 WHERE (`entry` = 6386);
-- Cookie's Tenderizer
-- required_level, from 15 to 10
-- dmg_min1, from 16.0 to 32
-- dmg_max1, from 31.0 to 48
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 32, `dmg_max1` = 48 WHERE (`entry` = 5197);
UPDATE `applied_item_updates` SET `entry` = 5197, `version` = 3494 WHERE (`entry` = 5197);
-- Brown Linen Shirt
-- subclass, from 1 to 0
-- required_level, from 1 to 0
-- armor, from 1 to 0
UPDATE `item_template` SET `subclass` = 0, `required_level` = 0, `armor` = 0 WHERE (`entry` = 4344);
UPDATE `applied_item_updates` SET `entry` = 4344, `version` = 3494 WHERE (`entry` = 4344);
-- Spirit Cloak
-- required_level, from 18 to 13
-- stat_value1, from 1 to 2
-- armor, from 15 to 13
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 2, `armor` = 13 WHERE (`entry` = 4792);
UPDATE `applied_item_updates` SET `entry` = 4792, `version` = 3494 WHERE (`entry` = 4792);
-- Giant Tarantula Fang
-- required_level, from 10 to 5
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 12.0 to 20
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 1287);
UPDATE `applied_item_updates` SET `entry` = 1287, `version` = 3494 WHERE (`entry` = 1287);
-- Harlequin Robes
-- buy_price, from 3814 to 4310
-- sell_price, from 762 to 862
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- stat_value1, from 1 to 4
-- stat_value2, from 1 to 2
-- armor, from 19 to 18
UPDATE `item_template` SET `buy_price` = 4310, `sell_price` = 862, `item_level` = 23, `required_level` = 13, `stat_value1` = 4, `stat_value2` = 2, `armor` = 18 WHERE (`entry` = 6503);
UPDATE `applied_item_updates` SET `entry` = 6503, `version` = 3494 WHERE (`entry` = 6503);
-- Shimmering Bracers
-- display_id, from 14750 to 12467
-- required_level, from 16 to 11
UPDATE `item_template` SET `display_id` = 12467, `required_level` = 11 WHERE (`entry` = 6563);
UPDATE `applied_item_updates` SET `entry` = 6563, `version` = 3494 WHERE (`entry` = 6563);
-- Grayson's Torch
-- required_level, from 16 to 11
-- stat_value1, from 1 to 2
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 2 WHERE (`entry` = 1172);
UPDATE `applied_item_updates` SET `entry` = 1172, `version` = 3494 WHERE (`entry` = 1172);
-- Seer's Cape
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6378);
UPDATE `applied_item_updates` SET `entry` = 6378, `version` = 3494 WHERE (`entry` = 6378);
-- Scouting Spaulders
-- display_id, from 14756 to 12485
-- buy_price, from 2027 to 2019
-- sell_price, from 405 to 403
-- required_level, from 17 to 13
-- armor, from 28 to 26
UPDATE `item_template` SET `display_id` = 12485, `buy_price` = 2019, `sell_price` = 403, `required_level` = 13, `armor` = 26 WHERE (`entry` = 6588);
UPDATE `applied_item_updates` SET `entry` = 6588, `version` = 3494 WHERE (`entry` = 6588);
-- Wandering Boots
-- buy_price, from 3440 to 3437
-- sell_price, from 688 to 687
-- required_level, from 19 to 14
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 2
-- armor, from 14 to 13
UPDATE `item_template` SET `buy_price` = 3437, `sell_price` = 687, `required_level` = 14, `stat_type1` = 6, `stat_value1` = 2, `armor` = 13 WHERE (`entry` = 6095);
UPDATE `applied_item_updates` SET `entry` = 6095, `version` = 3494 WHERE (`entry` = 6095);
-- Wendigo Collar
-- required_level, from 10 to 5
-- stat_type1, from 1 to 3
-- stat_value1, from 5 to 1
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 3, `stat_value1` = 1, `armor` = 12 WHERE (`entry` = 2899);
UPDATE `applied_item_updates` SET `entry` = 2899, `version` = 3494 WHERE (`entry` = 2899);
-- Bluegill Breeches
-- required_level, from 18 to 13
-- stat_value1, from 2 to 5
-- armor, from 34 to 31
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 5, `armor` = 31 WHERE (`entry` = 3022);
UPDATE `applied_item_updates` SET `entry` = 3022, `version` = 3494 WHERE (`entry` = 3022);
-- Lancer Boots
-- required_level, from 25 to 20
-- stat_value1, from 1 to 2
-- stat_value2, from 20 to 35
-- armor, from 31 to 29
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `stat_value2` = 35, `armor` = 29 WHERE (`entry` = 6752);
UPDATE `applied_item_updates` SET `entry` = 6752, `version` = 3494 WHERE (`entry` = 6752);
-- Violet Scale Armor
-- buy_price, from 5701 to 6442
-- sell_price, from 1140 to 1288
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- stat_value1, from 1 to 3
-- stat_value2, from 1 to 2
-- armor, from 57 to 53
UPDATE `item_template` SET `buy_price` = 6442, `sell_price` = 1288, `item_level` = 23, `required_level` = 13, `stat_value1` = 3, `stat_value2` = 2, `armor` = 53 WHERE (`entry` = 6502);
UPDATE `applied_item_updates` SET `entry` = 6502, `version` = 3494 WHERE (`entry` = 6502);
-- Shimmering Cloak
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6564);
UPDATE `applied_item_updates` SET `entry` = 6564, `version` = 3494 WHERE (`entry` = 6564);
-- Scalemail Boots
-- required_level, from 17 to 12
-- armor, from 36 to 33
UPDATE `item_template` SET `required_level` = 12, `armor` = 33 WHERE (`entry` = 287);
UPDATE `applied_item_updates` SET `entry` = 287, `version` = 3494 WHERE (`entry` = 287);
-- Woodsman Sword
-- dmg_min1, from 34.0 to 44
-- dmg_max1, from 52.0 to 60
UPDATE `item_template` SET `dmg_min1` = 44, `dmg_max1` = 60 WHERE (`entry` = 5615);
UPDATE `applied_item_updates` SET `entry` = 5615, `version` = 3494 WHERE (`entry` = 5615);
-- Flameweave Pants
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3067);
UPDATE `applied_item_updates` SET `entry` = 3067, `version` = 3494 WHERE (`entry` = 3067);
-- Firewalker Boots
-- required_level, from 18 to 13
-- stat_value1, from 6 to 30
-- stat_value2, from 7 to 30
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 30, `stat_value2` = 30, `armor` = 12 WHERE (`entry` = 6482);
UPDATE `applied_item_updates` SET `entry` = 6482, `version` = 3494 WHERE (`entry` = 6482);
-- Tear of Grief
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 5611);
UPDATE `applied_item_updates` SET `entry` = 5611, `version` = 3494 WHERE (`entry` = 5611);
-- Tribal Worg Helm
-- required_level, from 27 to 22
-- stat_value1, from 2 to 3
-- stat_value3, from 2 to 4
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value3` = 4, `armor` = 27 WHERE (`entry` = 6204);
UPDATE `applied_item_updates` SET `entry` = 6204, `version` = 3494 WHERE (`entry` = 6204);
-- Wolfpack Medallion
-- required_level, from 26 to 21
-- stat_value1, from 5 to 7
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 7, `shadow_res` = 4 WHERE (`entry` = 5754);
UPDATE `applied_item_updates` SET `entry` = 5754, `version` = 3494 WHERE (`entry` = 5754);
-- Mantle of Thieves
-- stat_value1, from 3 to 4
-- armor, from 39 to 35
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `stat_value1` = 4, `armor` = 35, `shadow_res` = 1 WHERE (`entry` = 2264);
UPDATE `applied_item_updates` SET `entry` = 2264, `version` = 3494 WHERE (`entry` = 2264);
-- Girdle of the Blindwatcher
-- required_level, from 19 to 14
-- stat_type1, from 5 to 3
-- stat_value1, from 1 to 2
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 14, `stat_type1` = 3, `stat_value1` = 2, `armor` = 16 WHERE (`entry` = 6319);
UPDATE `applied_item_updates` SET `entry` = 6319, `version` = 3494 WHERE (`entry` = 6319);
-- Insignia Leggings
-- required_level, from 30 to 25
-- stat_value1, from 7 to 9
-- armor, from 45 to 41
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 9, `armor` = 41 WHERE (`entry` = 4054);
UPDATE `applied_item_updates` SET `entry` = 4054, `version` = 3494 WHERE (`entry` = 4054);
-- Emblazoned Boots
-- required_level, from 27 to 22
-- stat_value1, from 2 to 4
-- stat_type2, from 6 to 7
-- stat_value2, from 1 to 2
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `stat_type2` = 7, `stat_value2` = 2, `armor` = 30 WHERE (`entry` = 4051);
UPDATE `applied_item_updates` SET `entry` = 4051, `version` = 3494 WHERE (`entry` = 4051);
-- Insignia Bracers
-- required_level, from 31 to 26
-- armor, from 24 to 22
UPDATE `item_template` SET `required_level` = 26, `armor` = 22 WHERE (`entry` = 6410);
UPDATE `applied_item_updates` SET `entry` = 6410, `version` = 3494 WHERE (`entry` = 6410);
-- Prospector Gloves
-- required_level, from 32 to 27
-- stat_value2, from 2 to 3
-- armor, from 30 to 27
-- nature_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 27, `stat_value2` = 3, `armor` = 27, `nature_res` = 1 WHERE (`entry` = 4980);
UPDATE `applied_item_updates` SET `entry` = 4980, `version` = 3494 WHERE (`entry` = 4980);
-- Dark Hooded Cape
-- spellid_1, from 0 to 5258
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `spellid_1` = 5258, `spelltrigger_1` = 1 WHERE (`entry` = 5257);
UPDATE `applied_item_updates` SET `entry` = 5257, `version` = 3494 WHERE (`entry` = 5257);
-- Tusken Helm
-- display_id, from 15492 to 13289
-- required_level, from 27 to 22
-- stat_value2, from 5 to 7
-- armor, from 45 to 41
UPDATE `item_template` SET `display_id` = 13289, `required_level` = 22, `stat_value2` = 7, `armor` = 41 WHERE (`entry` = 6686);
UPDATE `applied_item_updates` SET `entry` = 6686, `version` = 3494 WHERE (`entry` = 6686);
-- Battleforge Girdle
-- buy_price, from 4631 to 5310
-- sell_price, from 926 to 1062
-- item_level, from 26 to 28
-- required_level, from 21 to 18
-- armor, from 27 to 26
UPDATE `item_template` SET `buy_price` = 5310, `sell_price` = 1062, `item_level` = 28, `required_level` = 18, `armor` = 26 WHERE (`entry` = 6594);
UPDATE `applied_item_updates` SET `entry` = 6594, `version` = 3494 WHERE (`entry` = 6594);
-- Battleforge Boots
-- required_level, from 20 to 15
-- armor, from 42 to 38
UPDATE `item_template` SET `required_level` = 15, `armor` = 38 WHERE (`entry` = 6590);
UPDATE `applied_item_updates` SET `entry` = 6590, `version` = 3494 WHERE (`entry` = 6590);
-- Sentry Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2059);
UPDATE `applied_item_updates` SET `entry` = 2059, `version` = 3494 WHERE (`entry` = 2059);
-- Mud Stompers
-- required_level, from 10 to 5
-- stat_type1, from 1 to 7
-- stat_value1, from 3 to 1
-- armor, from 32 to 29
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 7, `stat_value1` = 1, `armor` = 29 WHERE (`entry` = 6188);
UPDATE `applied_item_updates` SET `entry` = 6188, `version` = 3494 WHERE (`entry` = 6188);
-- Tribal Headdress
-- required_level, from 32 to 27
-- stat_value1, from 3 to 5
-- stat_value2, from 4 to 5
-- armor, from 17 to 15
-- nature_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `stat_value2` = 5, `armor` = 15, `nature_res` = 1 WHERE (`entry` = 2622);
UPDATE `applied_item_updates` SET `entry` = 2622, `version` = 3494 WHERE (`entry` = 2622);
-- Necklace of Harmony
-- required_level, from 29 to 24
-- stat_value1, from 6 to 9
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 9 WHERE (`entry` = 5180);
UPDATE `applied_item_updates` SET `entry` = 5180, `version` = 3494 WHERE (`entry` = 5180);
-- Palm Frond Mantle
-- required_level, from 29 to 24
-- stat_value1, from 18 to 50
-- armor, from 20 to 19
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 50, `armor` = 19 WHERE (`entry` = 4140);
UPDATE `applied_item_updates` SET `entry` = 4140, `version` = 3494 WHERE (`entry` = 4140);
-- Doomsayer's Robe
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4746);
UPDATE `applied_item_updates` SET `entry` = 4746, `version` = 3494 WHERE (`entry` = 4746);
-- Swampland Trousers
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4505);
UPDATE `applied_item_updates` SET `entry` = 4505, `version` = 3494 WHERE (`entry` = 4505);
-- Phoenix Gloves
-- required_level, from 20 to 15
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 15, `armor` = 10 WHERE (`entry` = 4331);
UPDATE `applied_item_updates` SET `entry` = 4331, `version` = 3494 WHERE (`entry` = 4331);
-- Vibrant Silk Cape
-- required_level, from 28 to 23
-- stat_value1, from 1 to 2
-- stat_value2, from 10 to 30
-- armor, from 18 to 17
UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 2, `stat_value2` = 30, `armor` = 17 WHERE (`entry` = 5181);
UPDATE `applied_item_updates` SET `entry` = 5181, `version` = 3494 WHERE (`entry` = 5181);
-- Emberstone Staff
-- spellid_1, from 0 to 2229
-- spelltrigger_1, from 0 to 1
UPDATE `item_template` SET `spellid_1` = 2229, `spelltrigger_1` = 1 WHERE (`entry` = 5201);
UPDATE `applied_item_updates` SET `entry` = 5201, `version` = 3494 WHERE (`entry` = 5201);
-- Scorching Wand
-- required_level, from 28 to 23
-- dmg_min1, from 22.0 to 32
-- dmg_max1, from 41.0 to 48
-- delay, from 1300 to 2600
UPDATE `item_template` SET `required_level` = 23, `dmg_min1` = 32, `dmg_max1` = 48, `delay` = 2600 WHERE (`entry` = 5213);
UPDATE `applied_item_updates` SET `entry` = 5213, `version` = 3494 WHERE (`entry` = 5213);
-- Barbaric Harness
-- required_level, from 33 to 28
-- stat_value1, from 5 to 6
-- armor, from 50 to 45
UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 6, `armor` = 45 WHERE (`entry` = 5739);
UPDATE `applied_item_updates` SET `entry` = 5739, `version` = 3494 WHERE (`entry` = 5739);
-- Ferine Swine Leggings
-- name, from Ferine Leggings to Ferine Swine Leggings
-- required_level, from 28 to 23
-- stat_value1, from 3 to 4
-- stat_value2, from 4 to 5
-- armor, from 43 to 39
UPDATE `item_template` SET `name` = 'Ferine Swine Leggings', `required_level` = 23, `stat_value1` = 4, `stat_value2` = 5, `armor` = 39 WHERE (`entry` = 6690);
UPDATE `applied_item_updates` SET `entry` = 6690, `version` = 3494 WHERE (`entry` = 6690);
-- Naraxis' Fang
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4449);
UPDATE `applied_item_updates` SET `entry` = 4449, `version` = 3494 WHERE (`entry` = 4449);
-- Zephyr Belt
-- buy_price, from 5485 to 5355
-- sell_price, from 1097 to 1071
-- required_level, from 25 to 20
-- stat_value1, from 2 to 1
-- armor, from 20 to 18
UPDATE `item_template` SET `buy_price` = 5355, `sell_price` = 1071, `required_level` = 20, `stat_value1` = 1, `armor` = 18 WHERE (`entry` = 6719);
UPDATE `applied_item_updates` SET `entry` = 6719, `version` = 3494 WHERE (`entry` = 6719);
-- Monkey Ring
-- required_level, from 26 to 21
-- stat_value1, from 2 to 3
-- stat_value2, from 8 to 18
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3, `stat_value2` = 18 WHERE (`entry` = 6748);
UPDATE `applied_item_updates` SET `entry` = 6748, `version` = 3494 WHERE (`entry` = 6748);
-- Tigerbane
-- spellid_1, from 19691 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 1465);
UPDATE `applied_item_updates` SET `entry` = 1465, `version` = 3494 WHERE (`entry` = 1465);
-- Darkweave Mantle
-- buy_price, from 12230 to 14529
-- sell_price, from 2446 to 2905
-- item_level, from 36 to 38
-- required_level, from 31 to 28
-- stat_value1, from 2 to 3
-- armor, from 21 to 20
UPDATE `item_template` SET `buy_price` = 14529, `sell_price` = 2905, `item_level` = 38, `required_level` = 28, `stat_value1` = 3, `armor` = 20 WHERE (`entry` = 4718);
UPDATE `applied_item_updates` SET `entry` = 4718, `version` = 3494 WHERE (`entry` = 4718);
-- Frostweave Sash
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4714);
UPDATE `applied_item_updates` SET `entry` = 4714, `version` = 3494 WHERE (`entry` = 4714);
-- Necromancer Leggings
-- holy_res, from 0 to 1
-- spellid_1, from 7709 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `holy_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2277);
UPDATE `applied_item_updates` SET `entry` = 2277, `version` = 3494 WHERE (`entry` = 2277);
-- Flameweave Bracers
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3647);
UPDATE `applied_item_updates` SET `entry` = 3647, `version` = 3494 WHERE (`entry` = 3647);
-- Ring of Forlorn Spirits
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 2043);
UPDATE `applied_item_updates` SET `entry` = 2043, `version` = 3494 WHERE (`entry` = 2043);
-- Darkweave Cloak
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4719);
UPDATE `applied_item_updates` SET `entry` = 4719, `version` = 3494 WHERE (`entry` = 4719);
-- Heavy Shot
-- dmg_min1, from 5.0 to 4
-- dmg_max1, from 6.0 to 4
UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 4 WHERE (`entry` = 2519);
UPDATE `applied_item_updates` SET `entry` = 2519, `version` = 3494 WHERE (`entry` = 2519);
-- Solid Shot
-- dmg_min1, from 12.0 to 6
-- dmg_max1, from 13.0 to 7
UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 7 WHERE (`entry` = 3033);
UPDATE `applied_item_updates` SET `entry` = 3033, `version` = 3494 WHERE (`entry` = 3033);
-- Edge of the People's Militia
-- required_level, from 12 to 7
-- dmg_min1, from 22.0 to 35
-- dmg_max1, from 34.0 to 48
UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 35, `dmg_max1` = 48 WHERE (`entry` = 1566);
UPDATE `applied_item_updates` SET `entry` = 1566, `version` = 3494 WHERE (`entry` = 1566);
-- Dark Leather Shoulders
-- required_level, from 23 to 18
-- stat_type1, from 3 to 1
-- stat_value1, from 2 to 35
-- armor, from 35 to 32
UPDATE `item_template` SET `required_level` = 18, `stat_type1` = 1, `stat_value1` = 35, `armor` = 32 WHERE (`entry` = 4252);
UPDATE `applied_item_updates` SET `entry` = 4252, `version` = 3494 WHERE (`entry` = 4252);
-- Murloc Scale Breastplate
-- required_level, from 14 to 9
-- stat_type1, from 3 to 7
-- stat_value1, from 1 to 3
-- stat_type2, from 5 to 1
-- stat_value2, from 1 to 24
-- armor, from 35 to 32
UPDATE `item_template` SET `required_level` = 9, `stat_type1` = 7, `stat_value1` = 3, `stat_type2` = 1, `stat_value2` = 24, `armor` = 32 WHERE (`entry` = 5781);
UPDATE `applied_item_updates` SET `entry` = 5781, `version` = 3494 WHERE (`entry` = 5781);
-- Dark Leather Boots
-- required_level, from 15 to 10
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 10, `armor` = 21 WHERE (`entry` = 2315);
UPDATE `applied_item_updates` SET `entry` = 2315, `version` = 3494 WHERE (`entry` = 2315);
-- Walking Boots
-- required_level, from 13 to 8
-- stat_value1, from 7 to 2
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 2, `armor` = 11 WHERE (`entry` = 4660);
UPDATE `applied_item_updates` SET `entry` = 4660, `version` = 3494 WHERE (`entry` = 4660);
-- Death Speaker Mantle
-- required_level, from 25 to 20
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 20, `armor` = 17 WHERE (`entry` = 6685);
UPDATE `applied_item_updates` SET `entry` = 6685, `version` = 3494 WHERE (`entry` = 6685);
-- Frostweave Robe
-- required_level, from 27 to 22
-- stat_value1, from 2 to 4
-- stat_value2, from 4 to 5
-- armor, from 24 to 22
-- frost_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `stat_value2` = 5, `armor` = 22, `frost_res` = 1 WHERE (`entry` = 4035);
UPDATE `applied_item_updates` SET `entry` = 4035, `version` = 3494 WHERE (`entry` = 4035);
-- Phoenix Pants
-- required_level, from 20 to 15
-- stat_type1, from 5 to 6
-- stat_value1, from 2 to 3
-- stat_value2, from 1 to 2
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 6, `stat_value1` = 3, `stat_value2` = 2, `armor` = 16 WHERE (`entry` = 4317);
UPDATE `applied_item_updates` SET `entry` = 4317, `version` = 3494 WHERE (`entry` = 4317);
-- Coral Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5000);
UPDATE `applied_item_updates` SET `entry` = 5000, `version` = 3494 WHERE (`entry` = 5000);
-- Brightweave Cowl
-- required_level, from 35 to 30
-- stat_value1, from 8 to 11
-- armor, from 18 to 16
-- holy_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 11, `armor` = 16, `holy_res` = 1 WHERE (`entry` = 4041);
UPDATE `applied_item_updates` SET `entry` = 4041, `version` = 3494 WHERE (`entry` = 4041);
-- Flameweave Robe
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3069);
UPDATE `applied_item_updates` SET `entry` = 3069, `version` = 3494 WHERE (`entry` = 3069);
-- Dervish Cape
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 6604);
UPDATE `applied_item_updates` SET `entry` = 6604, `version` = 3494 WHERE (`entry` = 6604);
-- Snapbrook Armor
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 5814);
UPDATE `applied_item_updates` SET `entry` = 5814, `version` = 3494 WHERE (`entry` = 5814);
-- Swampwalker Boots
-- stat_value1, from 3 to 5
-- stat_type2, from 7 to 6
-- stat_value2, from 2 to 3
-- armor, from 33 to 30
UPDATE `item_template` SET `stat_value1` = 5, `stat_type2` = 6, `stat_value2` = 3, `armor` = 30 WHERE (`entry` = 2276);
UPDATE `applied_item_updates` SET `entry` = 2276, `version` = 3494 WHERE (`entry` = 2276);
-- Blackvenom Blade
-- dmg_min1, from 15.0 to 25
-- dmg_max1, from 29.0 to 38
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 7.0 to 0
-- dmg_type2, from 5 to 0
-- spellid_1, from 13518 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min1` = 25, `dmg_max1` = 38, `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 4446);
UPDATE `applied_item_updates` SET `entry` = 4446, `version` = 3494 WHERE (`entry` = 4446);
-- Glimmering Mail Chestpiece
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 4071);
UPDATE `applied_item_updates` SET `entry` = 4071, `version` = 3494 WHERE (`entry` = 4071);
-- Tempered Bracers
-- buy_price, from 5244 to 4828
-- sell_price, from 1048 to 965
-- required_level, from 22 to 17
-- stat_value2, from 5 to 1
-- armor, from 32 to 29
UPDATE `item_template` SET `buy_price` = 4828, `sell_price` = 965, `required_level` = 17, `stat_value2` = 1, `armor` = 29 WHERE (`entry` = 6675);
UPDATE `applied_item_updates` SET `entry` = 6675, `version` = 3494 WHERE (`entry` = 6675);
-- Shadow Weaver Leggings
-- buy_price, from 8452 to 6800
-- sell_price, from 1690 to 1360
-- item_level, from 27 to 25
-- required_level, from 22 to 15
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 3
-- armor, from 37 to 32
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `buy_price` = 6800, `sell_price` = 1360, `item_level` = 25, `required_level` = 15, `stat_value1` = 3, `stat_value2` = 3, `armor` = 32, `shadow_res` = 1 WHERE (`entry` = 2233);
UPDATE `applied_item_updates` SET `entry` = 2233, `version` = 3494 WHERE (`entry` = 2233);
-- Linked Chain Shoulderpads
-- required_level, from 16 to 11
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 11, `armor` = 26 WHERE (`entry` = 1752);
UPDATE `applied_item_updates` SET `entry` = 1752, `version` = 3494 WHERE (`entry` = 1752);
-- Twisted Sabre
-- dmg_min1, from 13.0 to 24
-- dmg_max1, from 26.0 to 37
UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 2011);
UPDATE `applied_item_updates` SET `entry` = 2011, `version` = 3494 WHERE (`entry` = 2011);
-- Feathered Headdress
-- required_level, from 31 to 26
-- stat_value1, from 4 to 5
-- stat_value2, from 4 to 5
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 5, `stat_value2` = 5, `armor` = 30 WHERE (`entry` = 3011);
UPDATE `applied_item_updates` SET `entry` = 3011, `version` = 3494 WHERE (`entry` = 3011);
-- Forest Tracker Epaulets
-- stat_value1, from 2 to 4
-- armor, from 39 to 35
UPDATE `item_template` SET `stat_value1` = 4, `armor` = 35 WHERE (`entry` = 2278);
UPDATE `applied_item_updates` SET `entry` = 2278, `version` = 3494 WHERE (`entry` = 2278);
-- Guardian Armor
-- required_level, from 30 to 25
-- stat_type1, from 6 to 3
-- stat_value1, from 7 to 9
-- armor, from 51 to 47
UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 3, `stat_value1` = 9, `armor` = 47 WHERE (`entry` = 4256);
UPDATE `applied_item_updates` SET `entry` = 4256, `version` = 3494 WHERE (`entry` = 4256);
-- Panther Hunter Leggings
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4108);
UPDATE `applied_item_updates` SET `entry` = 4108, `version` = 3494 WHERE (`entry` = 4108);
-- Lesser Belt of the Spire
-- required_level, from 17 to 12
UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1299);
UPDATE `applied_item_updates` SET `entry` = 1299, `version` = 3494 WHERE (`entry` = 1299);
-- Sage's Pants
-- display_id, from 14767 to 12514
-- buy_price, from 6220 to 5852
-- sell_price, from 1244 to 1170
-- required_level, from 21 to 16
-- armor, from 18 to 17
-- fire_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12514, `buy_price` = 5852, `sell_price` = 1170, `required_level` = 16, `armor` = 17, `fire_res` = 1 WHERE (`entry` = 6616);
UPDATE `applied_item_updates` SET `entry` = 6616, `version` = 3494 WHERE (`entry` = 6616);
-- Spider Silk Slippers
-- required_level, from 23 to 18
-- stat_value1, from 1 to 2
-- stat_value2, from 10 to 37
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `stat_value2` = 37, `armor` = 14 WHERE (`entry` = 4321);
UPDATE `applied_item_updates` SET `entry` = 4321, `version` = 3494 WHERE (`entry` = 4321);
-- Strength of Will
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 4837);
UPDATE `applied_item_updates` SET `entry` = 4837, `version` = 3494 WHERE (`entry` = 4837);
-- Emblazoned Bracers
-- required_level, from 25 to 20
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 20, `armor` = 21 WHERE (`entry` = 4049);
UPDATE `applied_item_updates` SET `entry` = 4049, `version` = 3494 WHERE (`entry` = 4049);
-- Husk of Naraxis
-- required_level, from 22 to 17
-- stat_value1, from 3 to 6
-- armor, from 63 to 58
-- nature_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 6, `armor` = 58, `nature_res` = 1 WHERE (`entry` = 4448);
UPDATE `applied_item_updates` SET `entry` = 4448, `version` = 3494 WHERE (`entry` = 4448);
-- Battleforge Leggings
-- required_level, from 20 to 15
-- armor, from 53 to 48
UPDATE `item_template` SET `required_level` = 15, `armor` = 48 WHERE (`entry` = 6596);
UPDATE `applied_item_updates` SET `entry` = 6596, `version` = 3494 WHERE (`entry` = 6596);
-- Shimmering Pants
-- display_id, from 14746 to 12470
-- buy_price, from 2725 to 2713
-- sell_price, from 545 to 542
-- required_level, from 15 to 10
-- armor, from 16 to 14
UPDATE `item_template` SET `display_id` = 12470, `buy_price` = 2713, `sell_price` = 542, `required_level` = 10, `armor` = 14 WHERE (`entry` = 6568);
UPDATE `applied_item_updates` SET `entry` = 6568, `version` = 3494 WHERE (`entry` = 6568);
-- Resilient Poncho
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 3561);
UPDATE `applied_item_updates` SET `entry` = 3561, `version` = 3494 WHERE (`entry` = 3561);
-- Ebon Scimitar
-- required_level, from 24 to 19
-- dmg_min1, from 26.0 to 40
-- dmg_max1, from 49.0 to 61
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 40, `dmg_max1` = 61 WHERE (`entry` = 3186);
UPDATE `applied_item_updates` SET `entry` = 3186, `version` = 3494 WHERE (`entry` = 3186);
-- Forest Chain
-- required_level, from 20 to 15
-- stat_value1, from 3 to 5
-- armor, from 61 to 55
UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 5, `armor` = 55 WHERE (`entry` = 1273);
UPDATE `applied_item_updates` SET `entry` = 1273, `version` = 3494 WHERE (`entry` = 1273);
-- Thick Cloth Vest
-- required_level, from 17 to 12
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 12, `armor` = 16 WHERE (`entry` = 200);
UPDATE `applied_item_updates` SET `entry` = 200, `version` = 3494 WHERE (`entry` = 200);
-- Thick Cloth Belt
-- required_level, from 17 to 12
-- armor, from 8 to 7
UPDATE `item_template` SET `required_level` = 12, `armor` = 7 WHERE (`entry` = 3597);
UPDATE `applied_item_updates` SET `entry` = 3597, `version` = 3494 WHERE (`entry` = 3597);
-- Russet Vest
-- required_level, from 32 to 27
-- stat_type1, from 6 to 5
-- stat_value1, from 4 to 5
-- armor, from 24 to 22
UPDATE `item_template` SET `required_level` = 27, `stat_type1` = 5, `stat_value1` = 5, `armor` = 22 WHERE (`entry` = 2429);
UPDATE `applied_item_updates` SET `entry` = 2429, `version` = 3494 WHERE (`entry` = 2429);
-- Russet Belt
-- required_level, from 32 to 27
-- stat_value1, from 1 to 2
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `armor` = 10 WHERE (`entry` = 3593);
UPDATE `applied_item_updates` SET `entry` = 3593, `version` = 3494 WHERE (`entry` = 3593);
-- Russet Pants
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 19 WHERE (`entry` = 2431);
UPDATE `applied_item_updates` SET `entry` = 2431, `version` = 3494 WHERE (`entry` = 2431);
-- Russet Gloves
-- required_level, from 32 to 27
-- armor, from 14 to 13
UPDATE `item_template` SET `required_level` = 27, `armor` = 13 WHERE (`entry` = 2434);
UPDATE `applied_item_updates` SET `entry` = 2434, `version` = 3494 WHERE (`entry` = 2434);
-- Embroidered Hat
-- display_id, from 15908 to 13228
-- required_level, from 45 to 40
-- stat_type1, from 6 to 5
-- stat_value1, from 4 to 9
-- armor, from 19 to 17
UPDATE `item_template` SET `display_id` = 13228, `required_level` = 40, `stat_type1` = 5, `stat_value1` = 9, `armor` = 17 WHERE (`entry` = 3892);
UPDATE `applied_item_updates` SET `entry` = 3892, `version` = 3494 WHERE (`entry` = 3892);
-- Frostweave Cloak
-- buy_price, from 8203 to 9023
-- sell_price, from 1640 to 1804
-- item_level, from 32 to 33
-- required_level, from 27 to 23
-- stat_type1, from 7 to 5
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 18 to 17
-- frost_res, from 0 to 1
UPDATE `item_template` SET `buy_price` = 9023, `sell_price` = 1804, `item_level` = 33, `required_level` = 23, `stat_type1` = 5, `stat_value1` = 2, `stat_value2` = 2, `armor` = 17, `frost_res` = 1 WHERE (`entry` = 4713);
UPDATE `applied_item_updates` SET `entry` = 4713, `version` = 3494 WHERE (`entry` = 4713);
-- Gnarled Ash Staff
-- stat_value1, from 4 to 5
-- stat_value2, from 10 to 30
-- dmg_min1, from 40.0 to 51
-- dmg_max1, from 61.0 to 70
UPDATE `item_template` SET `stat_value1` = 5, `stat_value2` = 30, `dmg_min1` = 51, `dmg_max1` = 70 WHERE (`entry` = 791);
UPDATE `applied_item_updates` SET `entry` = 791, `version` = 3494 WHERE (`entry` = 791);
-- Glimmering Mail Coif
-- required_level, from 27 to 22
-- stat_value1, from 2 to 4
-- stat_value3, from 2 to 3
-- armor, from 45 to 41
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 4, `stat_value3` = 3, `armor` = 41 WHERE (`entry` = 6389);
UPDATE `applied_item_updates` SET `entry` = 6389, `version` = 3494 WHERE (`entry` = 6389);
-- Golden Scale Shoulders
-- required_level, from 30 to 25
-- stat_value2, from 1 to 2
-- armor, from 63 to 57
UPDATE `item_template` SET `required_level` = 25, `stat_value2` = 2, `armor` = 57 WHERE (`entry` = 3841);
UPDATE `applied_item_updates` SET `entry` = 3841, `version` = 3494 WHERE (`entry` = 3841);
-- Double Link Mail Tunic
-- spellid_2, from 18369 to 0
-- spelltrigger_2, from 1 to 0
UPDATE `item_template` SET `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 1717);
UPDATE `applied_item_updates` SET `entry` = 1717, `version` = 3494 WHERE (`entry` = 1717);
-- Garneg's War Belt
-- required_level, from 24 to 19
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 19, `armor` = 27 WHERE (`entry` = 6200);
UPDATE `applied_item_updates` SET `entry` = 6200, `version` = 3494 WHERE (`entry` = 6200);
-- Glimmering Mail Cloak
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4711);
UPDATE `applied_item_updates` SET `entry` = 4711, `version` = 3494 WHERE (`entry` = 4711);
-- Death Speaker Robes
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 6682);
UPDATE `applied_item_updates` SET `entry` = 6682, `version` = 3494 WHERE (`entry` = 6682);
-- Wizard's Belt
-- required_level, from 23 to 18
-- stat_value1, from 12 to 37
-- armor, from 10 to 9
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 37, `armor` = 9 WHERE (`entry` = 4827);
UPDATE `applied_item_updates` SET `entry` = 4827, `version` = 3494 WHERE (`entry` = 4827);
-- Frostweave Bracers
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4036);
UPDATE `applied_item_updates` SET `entry` = 4036, `version` = 3494 WHERE (`entry` = 4036);
-- Orb of Power
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- sheath, from 7 to 0
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `sheath` = 0 WHERE (`entry` = 4838);
UPDATE `applied_item_updates` SET `entry` = 4838, `version` = 3494 WHERE (`entry` = 4838);
-- Green Iron Bracers
-- required_level, from 28 to 23
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 23, `armor` = 30 WHERE (`entry` = 3835);
UPDATE `applied_item_updates` SET `entry` = 3835, `version` = 3494 WHERE (`entry` = 3835);
-- Sage's Armor
-- display_id, from 14761 to 12508
-- buy_price, from 6669 to 6438
-- sell_price, from 1333 to 1287
-- required_level, from 22 to 17
-- armor, from 21 to 19
-- fire_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12508, `buy_price` = 6438, `sell_price` = 1287, `required_level` = 17, `armor` = 19, `fire_res` = 1 WHERE (`entry` = 6609);
UPDATE `applied_item_updates` SET `entry` = 6609, `version` = 3494 WHERE (`entry` = 6609);
-- Sage's Belt
-- name, from Sage's Sash to Sage's Belt
-- display_id, from 14762 to 12510
-- required_level, from 20 to 15
-- armor, from 9 to 8
UPDATE `item_template` SET `name` = 'Sage\'s Belt', `display_id` = 12510, `required_level` = 15, `armor` = 8 WHERE (`entry` = 6611);
UPDATE `applied_item_updates` SET `entry` = 6611, `version` = 3494 WHERE (`entry` = 6611);
-- Band of Thorns
-- required_level, from 31 to 26
-- max_count, from 1 to 0
-- stat_value1, from 1 to 2
-- stat_value2, from 2 to 3
UPDATE `item_template` SET `required_level` = 26, `max_count` = 0, `stat_value1` = 2, `stat_value2` = 3 WHERE (`entry` = 5007);
UPDATE `applied_item_updates` SET `entry` = 5007, `version` = 3494 WHERE (`entry` = 5007);
-- Dervish Gloves
-- display_id, from 14775 to 12500
-- buy_price, from 2408 to 2194
-- sell_price, from 481 to 438
-- required_level, from 21 to 16
-- armor, from 21 to 19
UPDATE `item_template` SET `display_id` = 12500, `buy_price` = 2194, `sell_price` = 438, `required_level` = 16, `armor` = 19 WHERE (`entry` = 6605);
UPDATE `applied_item_updates` SET `entry` = 6605, `version` = 3494 WHERE (`entry` = 6605);
-- Skeletal Longsword
-- required_level, from 22 to 17
-- dmg_min1, from 18.0 to 30
-- dmg_max1, from 35.0 to 46
UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 30, `dmg_max1` = 46 WHERE (`entry` = 2018);
UPDATE `applied_item_updates` SET `entry` = 2018, `version` = 3494 WHERE (`entry` = 2018);
-- Studded Leather Boots
-- name, from Studded Boots to Studded Leather Boots
-- required_level, from 32 to 27
-- stat_type1, from 5 to 3
-- stat_value1, from 2 to 3
-- armor, from 34 to 31
UPDATE `item_template` SET `name` = 'Studded Leather Boots', `required_level` = 27, `stat_type1` = 3, `stat_value1` = 3, `armor` = 31 WHERE (`entry` = 2467);
UPDATE `applied_item_updates` SET `entry` = 2467, `version` = 3494 WHERE (`entry` = 2467);
-- Relic Blade
-- required_level, from 15 to 10
-- dmg_min1, from 10.0 to 20
-- dmg_max1, from 20.0 to 31
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 5627);
UPDATE `applied_item_updates` SET `entry` = 5627, `version` = 3494 WHERE (`entry` = 5627);
-- Ironplate Buckler
-- required_level, from 10 to 5
-- stat_type1, from 1 to 6
-- stat_value1, from 3 to 2
-- armor, from 40 to 32
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 2, `armor` = 32 WHERE (`entry` = 3160);
UPDATE `applied_item_updates` SET `entry` = 3160, `version` = 3494 WHERE (`entry` = 3160);
-- Polished Scale Vest
-- required_level, from 22 to 17
-- armor, from 58 to 52
UPDATE `item_template` SET `required_level` = 17, `armor` = 52 WHERE (`entry` = 2153);
UPDATE `applied_item_updates` SET `entry` = 2153, `version` = 3494 WHERE (`entry` = 2153);
-- Forester's Axe
-- required_level, from 18 to 13
-- dmg_min1, from 16.0 to 30
-- dmg_max1, from 31.0 to 45
UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 30, `dmg_max1` = 45 WHERE (`entry` = 790);
UPDATE `applied_item_updates` SET `entry` = 790, `version` = 3494 WHERE (`entry` = 790);
-- Glimmering Shield
-- required_level, from 26 to 21
-- armor, from 107 to 67
UPDATE `item_template` SET `required_level` = 21, `armor` = 67 WHERE (`entry` = 6400);
UPDATE `applied_item_updates` SET `entry` = 6400, `version` = 3494 WHERE (`entry` = 6400);
-- Deadly Blunderbuss
-- required_level, from 16 to 11
-- dmg_min1, from 22.0 to 17
-- dmg_max1, from 41.0 to 27
UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 17, `dmg_max1` = 27 WHERE (`entry` = 4369);
UPDATE `applied_item_updates` SET `entry` = 4369, `version` = 3494 WHERE (`entry` = 4369);
-- Fractured Canine
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3299);
UPDATE `applied_item_updates` SET `entry` = 3299, `version` = 3494 WHERE (`entry` = 3299);
-- Dark Leather Tunic
-- required_level, from 15 to 10
-- armor, from 36 to 33
UPDATE `item_template` SET `required_level` = 10, `armor` = 33 WHERE (`entry` = 2317);
UPDATE `applied_item_updates` SET `entry` = 2317, `version` = 3494 WHERE (`entry` = 2317);
-- Hollowfang Blade
-- required_level, from 13 to 8
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 14.0 to 23
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 2020);
UPDATE `applied_item_updates` SET `entry` = 2020, `version` = 3494 WHERE (`entry` = 2020);
-- Shadow Claw
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 34.0 to 43
-- spellid_1, from 16409 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min1` = 28, `dmg_max1` = 43, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2912);
UPDATE `applied_item_updates` SET `entry` = 2912, `version` = 3494 WHERE (`entry` = 2912);
-- Butcher's Slicer
-- required_level, from 16 to 11
-- dmg_min1, from 18.0 to 38
-- dmg_max1, from 34.0 to 48
UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 38, `dmg_max1` = 48 WHERE (`entry` = 6633);
UPDATE `applied_item_updates` SET `entry` = 6633, `version` = 3494 WHERE (`entry` = 6633);
-- Calico Gloves
-- required_level, from 10 to 5
-- armor, from 6 to 5
UPDATE `item_template` SET `required_level` = 5, `armor` = 5 WHERE (`entry` = 1498);
UPDATE `applied_item_updates` SET `entry` = 1498, `version` = 3494 WHERE (`entry` = 1498);
-- Rabbit's Foot
-- quality, from 1 to 0
UPDATE `item_template` SET `quality` = 0 WHERE (`entry` = 3300);
UPDATE `applied_item_updates` SET `entry` = 3300, `version` = 3494 WHERE (`entry` = 3300);
-- Darkshire Mail Leggings
-- required_level, from 21 to 16
-- stat_value1, from 3 to 6
-- armor, from 54 to 49
-- holy_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 6, `armor` = 49, `holy_res` = 1 WHERE (`entry` = 2906);
UPDATE `applied_item_updates` SET `entry` = 2906, `version` = 3494 WHERE (`entry` = 2906);
-- Cuirboulli Belt
-- required_level, from 22 to 17
-- armor, from 17 to 15
UPDATE `item_template` SET `required_level` = 17, `armor` = 15 WHERE (`entry` = 2142);
UPDATE `applied_item_updates` SET `entry` = 2142, `version` = 3494 WHERE (`entry` = 2142);
-- Toughened Leather Armor
-- display_id, from 1819 to 9531
UPDATE `item_template` SET `display_id` = 9531 WHERE (`entry` = 2314);
UPDATE `applied_item_updates` SET `entry` = 2314, `version` = 3494 WHERE (`entry` = 2314);
-- Goblin Screwdriver
-- required_level, from 13 to 8
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 14.0 to 23
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 1936);
UPDATE `applied_item_updates` SET `entry` = 1936, `version` = 3494 WHERE (`entry` = 1936);
-- Ratty Old Belt
-- required_level, from 5 to 1
-- armor, from 10 to 9
UPDATE `item_template` SET `required_level` = 1, `armor` = 9 WHERE (`entry` = 6147);
UPDATE `applied_item_updates` SET `entry` = 6147, `version` = 3494 WHERE (`entry` = 6147);
-- Flameweave Armor
-- display_id, from 14563 to 12507
-- required_level, from 21 to 16
-- stat_value1, from 3 to 6
-- armor, from 21 to 19
-- fire_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12507, `required_level` = 16, `stat_value1` = 6, `armor` = 19, `fire_res` = 1 WHERE (`entry` = 6608);
UPDATE `applied_item_updates` SET `entry` = 6608, `version` = 3494 WHERE (`entry` = 6608);
-- Stonesplinter Dagger
-- required_level, from 8 to 3
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 12.0 to 20
UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 2266);
UPDATE `applied_item_updates` SET `entry` = 2266, `version` = 3494 WHERE (`entry` = 2266);
-- Beaten Battle Axe
-- required_level, from 5 to 1
-- dmg_min1, from 8.0 to 13
-- dmg_max1, from 13.0 to 18
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 1417);
UPDATE `applied_item_updates` SET `entry` = 1417, `version` = 3494 WHERE (`entry` = 1417);
-- Noble's Robe
-- required_level, from 13 to 8
-- stat_value1, from 1 to 3
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 3, `armor` = 16 WHERE (`entry` = 3019);
UPDATE `applied_item_updates` SET `entry` = 3019, `version` = 3494 WHERE (`entry` = 3019);
-- Red Woolen Boots
-- required_level, from 15 to 10
-- stat_value1, from 1 to 2
-- armor, from 13 to 11
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2, `armor` = 11 WHERE (`entry` = 4313);
UPDATE `applied_item_updates` SET `entry` = 4313, `version` = 3494 WHERE (`entry` = 4313);
-- Redridge Machete
-- required_level, from 11 to 6
-- dmg_min1, from 11.0 to 23
-- dmg_max1, from 21.0 to 35
UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 1219);
UPDATE `applied_item_updates` SET `entry` = 1219, `version` = 3494 WHERE (`entry` = 1219);
-- Haggard's Axe
-- required_level, from 10 to 5
-- dmg_min1, from 12.0 to 25
-- dmg_max1, from 23.0 to 39
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 6979);
UPDATE `applied_item_updates` SET `entry` = 6979, `version` = 3494 WHERE (`entry` = 6979);
-- Forest Leather Cloak
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 4710);
UPDATE `applied_item_updates` SET `entry` = 4710, `version` = 3494 WHERE (`entry` = 4710);
-- Dredge Boots
-- buy_price, from 4152 to 4055
-- sell_price, from 830 to 811
-- required_level, from 17 to 12
-- stat_value2, from 5 to 25
-- armor, from 39 to 36
UPDATE `item_template` SET `buy_price` = 4055, `sell_price` = 811, `required_level` = 12, `stat_value2` = 25, `armor` = 36 WHERE (`entry` = 6666);
UPDATE `applied_item_updates` SET `entry` = 6666, `version` = 3494 WHERE (`entry` = 6666);
-- Algae Fists
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 6906);
UPDATE `applied_item_updates` SET `entry` = 6906, `version` = 3494 WHERE (`entry` = 6906);
-- Reinforced Targe
-- required_level, from 22 to 17
-- armor, from 48 to 36
UPDATE `item_template` SET `required_level` = 17, `armor` = 36 WHERE (`entry` = 2442);
UPDATE `applied_item_updates` SET `entry` = 2442, `version` = 3494 WHERE (`entry` = 2442);
-- Venom Web Fang
-- required_level, from 14 to 9
-- dmg_min1, from 8.0 to 16
-- dmg_max1, from 16.0 to 25
-- spellid_1, from 18077 to 0
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 16, `dmg_max1` = 25, `spellid_1` = 0 WHERE (`entry` = 899);
UPDATE `applied_item_updates` SET `entry` = 899, `version` = 3494 WHERE (`entry` = 899);
-- Metalworking Gloves
-- required_level, from 13 to 8
-- stat_type1, from 1 to 7
-- stat_value1, from 10 to 2
-- armor, from 19 to 18
UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 7, `stat_value1` = 2, `armor` = 18 WHERE (`entry` = 1944);
UPDATE `applied_item_updates` SET `entry` = 1944, `version` = 3494 WHERE (`entry` = 1944);
-- Scholarly Robes
-- buy_price, from 5179 to 4583
-- sell_price, from 1035 to 916
-- item_level, from 25 to 24
-- required_level, from 20 to 14
-- stat_value1, from 3 to 5
-- armor, from 20 to 18
UPDATE `item_template` SET `buy_price` = 4583, `sell_price` = 916, `item_level` = 24, `required_level` = 14, `stat_value1` = 5, `armor` = 18 WHERE (`entry` = 2034);
UPDATE `applied_item_updates` SET `entry` = 2034, `version` = 3494 WHERE (`entry` = 2034);
-- Torch of Holy Flame
-- spellid_1, from 8913 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2808);
UPDATE `applied_item_updates` SET `entry` = 2808, `version` = 3494 WHERE (`entry` = 2808);
-- Glimmering Mail Boots
-- required_level, from 27 to 22
-- stat_value1, from 1 to 3
-- stat_value2, from 10 to 25
-- stat_value3, from 10 to 25
-- armor, from 49 to 45
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value2` = 25, `stat_value3` = 25, `armor` = 45 WHERE (`entry` = 4073);
UPDATE `applied_item_updates` SET `entry` = 4073, `version` = 3494 WHERE (`entry` = 4073);
-- Blackfang
-- dmg_min1, from 12.0 to 20
-- dmg_max1, from 23.0 to 31
-- shadow_res, from 5 to 0
UPDATE `item_template` SET `dmg_min1` = 20, `dmg_max1` = 31, `shadow_res` = 0 WHERE (`entry` = 2236);
UPDATE `applied_item_updates` SET `entry` = 2236, `version` = 3494 WHERE (`entry` = 2236);
-- Emblazoned Helm
-- name, from Emblazoned Hat to Emblazoned Helm
-- display_id, from 15904 to 13257
-- required_level, from 26 to 21
-- stat_value2, from 2 to 4
-- stat_value3, from 15 to 40
-- armor, from 29 to 27
UPDATE `item_template` SET `name` = 'Emblazoned Helm', `display_id` = 13257, `required_level` = 21, `stat_value2` = 4, `stat_value3` = 40, `armor` = 27 WHERE (`entry` = 4048);
UPDATE `applied_item_updates` SET `entry` = 4048, `version` = 3494 WHERE (`entry` = 4048);
-- Viridian Band
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 6589);
UPDATE `applied_item_updates` SET `entry` = 6589, `version` = 3494 WHERE (`entry` = 6589);
-- Robe of Solomon
-- required_level, from 20 to 15
-- stat_value1, from 2 to 4
-- stat_value2, from 10 to 15
-- armor, from 20 to 19
UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 4, `stat_value2` = 15, `armor` = 19 WHERE (`entry` = 3555);
UPDATE `applied_item_updates` SET `entry` = 3555, `version` = 3494 WHERE (`entry` = 3555);
-- Hardened Root Staff
-- required_level, from 20 to 15
-- stat_value1, from 2 to 4
-- dmg_min1, from 40.0 to 50
-- dmg_max1, from 60.0 to 69
UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 4, `dmg_min1` = 50, `dmg_max1` = 69 WHERE (`entry` = 1317);
UPDATE `applied_item_updates` SET `entry` = 1317, `version` = 3494 WHERE (`entry` = 1317);
-- Gemmed Copper Gauntlets
-- required_level, from 10 to 5
-- armor, from 26 to 24
UPDATE `item_template` SET `required_level` = 5, `armor` = 24 WHERE (`entry` = 3474);
UPDATE `applied_item_updates` SET `entry` = 3474, `version` = 3494 WHERE (`entry` = 3474);
-- Heavy Woolen Cloak
-- required_level, from 15 to 10
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 10, `armor` = 12 WHERE (`entry` = 4311);
UPDATE `applied_item_updates` SET `entry` = 4311, `version` = 3494 WHERE (`entry` = 4311);
-- Studded Leather Bracers
-- name, from Studded Bracers to Studded Leather Bracers
-- required_level, from 32 to 27
-- stat_value1, from 1 to 2
-- armor, from 24 to 22
UPDATE `item_template` SET `name` = 'Studded Leather Bracers', `required_level` = 27, `stat_value1` = 2, `armor` = 22 WHERE (`entry` = 2468);
UPDATE `applied_item_updates` SET `entry` = 2468, `version` = 3494 WHERE (`entry` = 2468);
-- BKP "Sparrow" Smallbore
-- required_level, from 28 to 23
-- dmg_min1, from 25.0 to 16
-- dmg_max1, from 47.0 to 24
UPDATE `item_template` SET `required_level` = 23, `dmg_min1` = 16, `dmg_max1` = 24 WHERE (`entry` = 3042);
UPDATE `applied_item_updates` SET `entry` = 3042, `version` = 3494 WHERE (`entry` = 3042);
-- Greater Adept's Robe
-- required_level, from 18 to 13
-- stat_value1, from 2 to 5
-- armor, from 20 to 18
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 5, `armor` = 18 WHERE (`entry` = 6264);
UPDATE `applied_item_updates` SET `entry` = 6264, `version` = 3494 WHERE (`entry` = 6264);
-- Totem of Infliction
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 1131);
UPDATE `applied_item_updates` SET `entry` = 1131, `version` = 3494 WHERE (`entry` = 1131);
-- Laced Mail Bracers
-- required_level, from 11 to 6
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 6, `armor` = 14 WHERE (`entry` = 1740);
UPDATE `applied_item_updates` SET `entry` = 1740, `version` = 3494 WHERE (`entry` = 1740);
-- Augmented Chain Helm
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 46 to 42
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 42 WHERE (`entry` = 3891);
UPDATE `applied_item_updates` SET `entry` = 3891, `version` = 3494 WHERE (`entry` = 3891);
-- Mail Combat Armguards
-- buy_price, from 11792 to 14009
-- sell_price, from 2358 to 2801
-- item_level, from 36 to 38
-- required_level, from 31 to 28
-- armor, from 39 to 37
UPDATE `item_template` SET `buy_price` = 14009, `sell_price` = 2801, `item_level` = 38, `required_level` = 28, `armor` = 37 WHERE (`entry` = 6403);
UPDATE `applied_item_updates` SET `entry` = 6403, `version` = 3494 WHERE (`entry` = 6403);
-- Augmented Chain Gloves
-- required_level, from 32 to 27
-- stat_value1, from 2 to 3
-- armor, from 41 to 37
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 3, `armor` = 37 WHERE (`entry` = 2422);
UPDATE `applied_item_updates` SET `entry` = 2422, `version` = 3494 WHERE (`entry` = 2422);
-- Reinforced Chain Bracers
-- required_level, from 23 to 18
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 18, `armor` = 19 WHERE (`entry` = 1756);
UPDATE `applied_item_updates` SET `entry` = 1756, `version` = 3494 WHERE (`entry` = 1756);
-- Cloak of Rot
-- required_level, from 26 to 21
-- stat_value1, from 10 to 25
-- stat_value2, from 10 to 25
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 25, `stat_value2` = 25, `armor` = 16 WHERE (`entry` = 4462);
UPDATE `applied_item_updates` SET `entry` = 4462, `version` = 3494 WHERE (`entry` = 4462);
-- Holy Shroud
-- stat_value1, from 5 to 7
-- stat_value2, from 3 to 2
-- armor, from 15 to 14
-- shadow_res, from 0 to 1
-- spellid_1, from 9318 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `stat_value1` = 7, `stat_value2` = 2, `armor` = 14, `shadow_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2721);
UPDATE `applied_item_updates` SET `entry` = 2721, `version` = 3494 WHERE (`entry` = 2721);
-- Robe of the Magi
-- spellid_2, from 0 to 2293
-- spelltrigger_2, from 0 to 1
UPDATE `item_template` SET `spellid_2` = 2293, `spelltrigger_2` = 1 WHERE (`entry` = 1716);
UPDATE `applied_item_updates` SET `entry` = 1716, `version` = 3494 WHERE (`entry` = 1716);
-- Brightweave Sash
-- required_level, from 35 to 30
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 30, `armor` = 10 WHERE (`entry` = 6418);
UPDATE `applied_item_updates` SET `entry` = 6418, `version` = 3494 WHERE (`entry` = 6418);
-- Arcane Runed Bracers
-- fire_res, from 0 to 2
UPDATE `item_template` SET `fire_res` = 2 WHERE (`entry` = 4744);
UPDATE `applied_item_updates` SET `entry` = 4744, `version` = 3494 WHERE (`entry` = 4744);
-- Howling Blade
-- buy_price, from 47333 to 45542
-- sell_price, from 9466 to 9108
-- stat_value1, from 4 to 3
-- dmg_min1, from 18.0 to 27
-- dmg_max1, from 34.0 to 41
-- spellid_1, from 13490 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `buy_price` = 45542, `sell_price` = 9108, `stat_value1` = 3, `dmg_min1` = 27, `dmg_max1` = 41, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 6331);
UPDATE `applied_item_updates` SET `entry` = 6331, `version` = 3494 WHERE (`entry` = 6331);
-- Slick Deviate Leggings
-- required_level, from 15 to 10
-- stat_value1, from 2 to 4
-- armor, from 32 to 29
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4, `armor` = 29 WHERE (`entry` = 6480);
UPDATE `applied_item_updates` SET `entry` = 6480, `version` = 3494 WHERE (`entry` = 6480);
-- Tough Leather Bracers
-- name, from Rawhide Bracers to Tough Leather Bracers
-- required_level, from 16 to 11
-- armor, from 40 to 11
UPDATE `item_template` SET `name` = 'Tough Leather Bracers', `required_level` = 11, `armor` = 11 WHERE (`entry` = 1797);
UPDATE `applied_item_updates` SET `entry` = 1797, `version` = 3494 WHERE (`entry` = 1797);
-- Black Wolf Bracers
-- required_level, from 21 to 16
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 16, `armor` = 19 WHERE (`entry` = 3230);
UPDATE `applied_item_updates` SET `entry` = 3230, `version` = 3494 WHERE (`entry` = 3230);
-- Emblazoned Gloves
-- buy_price, from 6561 to 7217
-- sell_price, from 1312 to 1443
-- item_level, from 32 to 33
-- required_level, from 27 to 23
-- armor, from 27 to 25
UPDATE `item_template` SET `buy_price` = 7217, `sell_price` = 1443, `item_level` = 33, `required_level` = 23, `armor` = 25 WHERE (`entry` = 6397);
UPDATE `applied_item_updates` SET `entry` = 6397, `version` = 3494 WHERE (`entry` = 6397);
-- Welding Shield
-- required_level, from 11 to 6
-- stat_type1, from 1 to 6
-- stat_value1, from 5 to 2
-- armor, from 84 to 58
UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 6, `stat_value1` = 2, `armor` = 58 WHERE (`entry` = 5325);
UPDATE `applied_item_updates` SET `entry` = 5325, `version` = 3494 WHERE (`entry` = 5325);
-- Band of Vitality
-- name, from Heart Ring to Band of Vitality
-- display_id, from 9834 to 9833
-- required_level, from 25 to 20
-- max_count, from 1 to 0
-- stat_value1, from 3 to 4
UPDATE `item_template` SET `name` = 'Band of Vitality', `display_id` = 9833, `required_level` = 20, `max_count` = 0, `stat_value1` = 4 WHERE (`entry` = 5001);
UPDATE `applied_item_updates` SET `entry` = 5001, `version` = 3494 WHERE (`entry` = 5001);
-- Thornspike
-- required_level, from 27 to 20
-- dmg_min1, from 15.0 to 23
-- dmg_max1, from 28.0 to 35
UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 6681);
UPDATE `applied_item_updates` SET `entry` = 6681, `version` = 3494 WHERE (`entry` = 6681);
-- Frostweave Cowl
-- display_id, from 15331 to 13546
-- required_level, from 27 to 22
-- armor, from 14 to 12
UPDATE `item_template` SET `display_id` = 13546, `required_level` = 22, `armor` = 12 WHERE (`entry` = 3068);
UPDATE `applied_item_updates` SET `entry` = 3068, `version` = 3494 WHERE (`entry` = 3068);
-- Green Iron Shoulders
-- required_level, from 27 to 22
-- stat_value1, from 2 to 3
-- armor, from 58 to 53
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `armor` = 53 WHERE (`entry` = 3840);
UPDATE `applied_item_updates` SET `entry` = 3840, `version` = 3494 WHERE (`entry` = 3840);
-- Forest Leather Mantle
-- required_level, from 20 to 15
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 15, `armor` = 27 WHERE (`entry` = 4709);
UPDATE `applied_item_updates` SET `entry` = 4709, `version` = 3494 WHERE (`entry` = 4709);
-- Rawhide Bracers
-- name, from Patched Leather Bracers to Rawhide Bracers
-- required_level, from 15 to 10
-- armor, from 12 to 10
UPDATE `item_template` SET `name` = 'Rawhide Bracers', `required_level` = 10, `armor` = 10 WHERE (`entry` = 1789);
UPDATE `applied_item_updates` SET `entry` = 1789, `version` = 3494 WHERE (`entry` = 1789);
-- Fen Keeper Robe
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 3558);
UPDATE `applied_item_updates` SET `entry` = 3558, `version` = 3494 WHERE (`entry` = 3558);
-- Flesh Piercer
-- required_level, from 24 to 19
-- dmg_min1, from 18.0 to 29
-- dmg_max1, from 35.0 to 44
-- spellid_1, from 18078 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 29, `dmg_max1` = 44, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 3336);
UPDATE `applied_item_updates` SET `entry` = 3336, `version` = 3494 WHERE (`entry` = 3336);
-- Darkweave Cowl
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- stat_value2, from 4 to 6
-- armor, from 17 to 15
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `stat_value2` = 6, `armor` = 15, `shadow_res` = 1 WHERE (`entry` = 4039);
UPDATE `applied_item_updates` SET `entry` = 4039, `version` = 3494 WHERE (`entry` = 4039);
-- Shadowfang
-- dmg_min2, from 4.0 to 0
-- dmg_max2, from 8.0 to 0
-- dmg_type2, from 5 to 0
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0 WHERE (`entry` = 1482);
UPDATE `applied_item_updates` SET `entry` = 1482, `version` = 3494 WHERE (`entry` = 1482);
-- Nightscape Belt
-- shadow_res, from 0 to 4
UPDATE `item_template` SET `shadow_res` = 4 WHERE (`entry` = 4828);
UPDATE `applied_item_updates` SET `entry` = 4828, `version` = 3494 WHERE (`entry` = 4828);
-- Darkweave Trousers
-- required_level, from 30 to 25
-- stat_value1, from 3 to 4
-- stat_value2, from 5 to 6
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 4, `stat_value2` = 6, `armor` = 21 WHERE (`entry` = 6405);
UPDATE `applied_item_updates` SET `entry` = 6405, `version` = 3494 WHERE (`entry` = 6405);
-- Pulsating Hydra Heart
-- sheath, from 7 to 0
UPDATE `item_template` SET `sheath` = 0 WHERE (`entry` = 5183);
UPDATE `applied_item_updates` SET `entry` = 5183, `version` = 3494 WHERE (`entry` = 5183);
-- Bloody Apron
-- required_level, from 17 to 12
-- stat_value1, from 2 to 5
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 5, `armor` = 17 WHERE (`entry` = 6226);
UPDATE `applied_item_updates` SET `entry` = 6226, `version` = 3494 WHERE (`entry` = 6226);
-- Gold-flecked Gloves
-- required_level, from 16 to 11
-- stat_type1, from 5 to 6
-- armor, from 11 to 10
UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 6, `armor` = 10 WHERE (`entry` = 5195);
UPDATE `applied_item_updates` SET `entry` = 5195, `version` = 3494 WHERE (`entry` = 5195);
-- Deputy Chain Coat
-- required_level, from 20 to 15
-- stat_value2, from 2 to 4
-- armor, from 61 to 55
UPDATE `item_template` SET `required_level` = 15, `stat_value2` = 4, `armor` = 55 WHERE (`entry` = 1275);
UPDATE `applied_item_updates` SET `entry` = 1275, `version` = 3494 WHERE (`entry` = 1275);
-- Sage's Cloak
-- fire_res, from 0 to 4
UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 6614);
UPDATE `applied_item_updates` SET `entry` = 6614, `version` = 3494 WHERE (`entry` = 6614);
-- Lesser Staff of the Spire
-- required_level, from 15 to 10
-- stat_value1, from 1 to 2
-- dmg_min1, from 31.0 to 45
-- dmg_max1, from 47.0 to 62
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2, `dmg_min1` = 45, `dmg_max1` = 62 WHERE (`entry` = 1300);
UPDATE `applied_item_updates` SET `entry` = 1300, `version` = 3494 WHERE (`entry` = 1300);
-- Blurred Axe
-- required_level, from 22 to 24
-- dmg_min1, from 14.0 to 23
-- dmg_max1, from 27.0 to 36
UPDATE `item_template` SET `required_level` = 24, `dmg_min1` = 23, `dmg_max1` = 36 WHERE (`entry` = 4824);
UPDATE `applied_item_updates` SET `entry` = 4824, `version` = 3494 WHERE (`entry` = 4824);
-- Coldridge Hammer
-- required_level, from 7 to 2
-- dmg_min1, from 16.0 to 25
-- dmg_max1, from 24.0 to 34
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 25, `dmg_max1` = 34 WHERE (`entry` = 3103);
UPDATE `applied_item_updates` SET `entry` = 3103, `version` = 3494 WHERE (`entry` = 3103);
-- Rat Cloth Belt
-- required_level, from 10 to 5
-- stat_value1, from 5 to 15
-- armor, from 7 to 6
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 15, `armor` = 6 WHERE (`entry` = 2283);
UPDATE `applied_item_updates` SET `entry` = 2283, `version` = 3494 WHERE (`entry` = 2283);
-- Mindbender Loop
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5009);
UPDATE `applied_item_updates` SET `entry` = 5009, `version` = 3494 WHERE (`entry` = 5009);
-- Rune Sword
-- required_level, from 33 to 28
-- dmg_min1, from 20.0 to 30
-- dmg_max1, from 39.0 to 46
UPDATE `item_template` SET `required_level` = 28, `dmg_min1` = 30, `dmg_max1` = 46 WHERE (`entry` = 864);
UPDATE `applied_item_updates` SET `entry` = 864, `version` = 3494 WHERE (`entry` = 864);
-- Girdle of Nobility
-- required_level, from 13 to 8
-- stat_value1, from 7 to 20
-- armor, from 8 to 7
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 20, `armor` = 7 WHERE (`entry` = 5967);
UPDATE `applied_item_updates` SET `entry` = 5967, `version` = 3494 WHERE (`entry` = 5967);
-- Thaumaturgist Staff
-- dmg_min1, from 59.0 to 67
-- dmg_max1, from 90.0 to 92
UPDATE `item_template` SET `dmg_min1` = 67, `dmg_max1` = 92 WHERE (`entry` = 2527);
UPDATE `applied_item_updates` SET `entry` = 2527, `version` = 3494 WHERE (`entry` = 2527);
-- Magus Long Staff
-- dmg_min1, from 86.0 to 95
-- dmg_max1, from 130.0 to 129
UPDATE `item_template` SET `dmg_min1` = 95, `dmg_max1` = 129 WHERE (`entry` = 2535);
UPDATE `applied_item_updates` SET `entry` = 2535, `version` = 3494 WHERE (`entry` = 2535);
-- Polished Scale Bracers
-- required_level, from 22 to 17
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 17, `armor` = 26 WHERE (`entry` = 2150);
UPDATE `applied_item_updates` SET `entry` = 2150, `version` = 3494 WHERE (`entry` = 2150);
-- Smoldering Wand
-- dmg_min1, from 14.0 to 23
-- dmg_max1, from 27.0 to 35
-- delay, from 1600 to 3000
UPDATE `item_template` SET `dmg_min1` = 23, `dmg_max1` = 35, `delay` = 3000 WHERE (`entry` = 5208);
UPDATE `applied_item_updates` SET `entry` = 5208, `version` = 3494 WHERE (`entry` = 5208);
-- Gloom Wand
-- dmg_min1, from 16.0 to 26
-- dmg_max1, from 31.0 to 40
-- delay, from 1800 to 3300
UPDATE `item_template` SET `dmg_min1` = 26, `dmg_max1` = 40, `delay` = 3300 WHERE (`entry` = 5209);
UPDATE `applied_item_updates` SET `entry` = 5209, `version` = 3494 WHERE (`entry` = 5209);
-- Burning Wand
-- dmg_min1, from 15.0 to 24
-- dmg_max1, from 28.0 to 36
-- delay, from 1400 to 2700
UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 36, `delay` = 2700 WHERE (`entry` = 5210);
UPDATE `applied_item_updates` SET `entry` = 5210, `version` = 3494 WHERE (`entry` = 5210);
-- Dusk Wand
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 34.0 to 43
-- delay, from 1700 to 3200
UPDATE `item_template` SET `dmg_min1` = 28, `dmg_max1` = 43, `delay` = 3200 WHERE (`entry` = 5211);
UPDATE `applied_item_updates` SET `entry` = 5211, `version` = 3494 WHERE (`entry` = 5211);
-- Combustible Wand
-- dmg_min1, from 25.0 to 36
-- dmg_max1, from 48.0 to 54
-- delay, from 1600 to 3100
UPDATE `item_template` SET `dmg_min1` = 36, `dmg_max1` = 54, `delay` = 3100 WHERE (`entry` = 5236);
UPDATE `applied_item_updates` SET `entry` = 5236, `version` = 3494 WHERE (`entry` = 5236);
-- Pitchwood Wand
-- dmg_min1, from 36.0 to 59
-- dmg_max1, from 68.0 to 89
-- delay, from 1700 to 3200
UPDATE `item_template` SET `dmg_min1` = 59, `dmg_max1` = 89, `delay` = 3200 WHERE (`entry` = 5238);
UPDATE `applied_item_updates` SET `entry` = 5238, `version` = 3494 WHERE (`entry` = 5238);
-- Blackbone Wand
-- dmg_min1, from 35.0 to 59
-- dmg_max1, from 66.0 to 89
-- delay, from 1600 to 3100
UPDATE `item_template` SET `dmg_min1` = 59, `dmg_max1` = 89, `delay` = 3100 WHERE (`entry` = 5239);
UPDATE `applied_item_updates` SET `entry` = 5239, `version` = 3494 WHERE (`entry` = 5239);
-- Rose Mantle
-- required_level, from 22 to 17
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 17, `armor` = 16 WHERE (`entry` = 5274);
UPDATE `applied_item_updates` SET `entry` = 5274, `version` = 3494 WHERE (`entry` = 5274);
-- Azora's Will
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 4999);
UPDATE `applied_item_updates` SET `entry` = 4999, `version` = 3494 WHERE (`entry` = 4999);
-- Battleforge Bracers
-- required_level, from 22 to 17
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 17, `armor` = 26 WHERE (`entry` = 6591);
UPDATE `applied_item_updates` SET `entry` = 6591, `version` = 3494 WHERE (`entry` = 6591);
-- Stonesplinter Rags
-- required_level, from 12 to 7
-- armor, from 47 to 14
UPDATE `item_template` SET `required_level` = 7, `armor` = 14 WHERE (`entry` = 5109);
UPDATE `applied_item_updates` SET `entry` = 5109, `version` = 3494 WHERE (`entry` = 5109);
-- Black Duskwood Staff
-- dmg_min1, from 42.0 to 49
-- dmg_max1, from 64.0 to 67
-- spellid_1, from 18138 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min1` = 49, `dmg_max1` = 67, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 937);
UPDATE `applied_item_updates` SET `entry` = 937, `version` = 3494 WHERE (`entry` = 937);
-- Cured Leather Belt
-- required_level, from 17 to 12
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 12, `armor` = 14 WHERE (`entry` = 1849);
UPDATE `applied_item_updates` SET `entry` = 1849, `version` = 3494 WHERE (`entry` = 1849);
-- Fine Leather Boots
-- required_level, from 13 to 8
-- armor, from 22 to 20
UPDATE `item_template` SET `required_level` = 8, `armor` = 20 WHERE (`entry` = 2307);
UPDATE `applied_item_updates` SET `entry` = 2307, `version` = 3494 WHERE (`entry` = 2307);
-- Grey Iron Sword
-- name, from Umbral Sword to Grey Iron Sword
-- required_level, from 10 to 5
-- dmg_min1, from 9.0 to 20
-- dmg_max1, from 18.0 to 30
UPDATE `item_template` SET `name` = 'Grey Iron Sword', `required_level` = 5, `dmg_min1` = 20, `dmg_max1` = 30 WHERE (`entry` = 6984);
UPDATE `applied_item_updates` SET `entry` = 6984, `version` = 3494 WHERE (`entry` = 6984);
-- Glimmering Mail Pauldrons
-- required_level, from 25 to 20
-- stat_value1, from 1 to 2
-- armor, from 56 to 51
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `armor` = 51 WHERE (`entry` = 6388);
UPDATE `applied_item_updates` SET `entry` = 6388, `version` = 3494 WHERE (`entry` = 6388);
-- Saber Leggings
-- required_level, from 23 to 18
-- stat_value1, from 2 to 5
-- stat_value2, from 1 to 2
-- stat_value3, from 20 to 35
-- armor, from 38 to 35
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 5, `stat_value2` = 2, `stat_value3` = 35, `armor` = 35 WHERE (`entry` = 4830);
UPDATE `applied_item_updates` SET `entry` = 4830, `version` = 3494 WHERE (`entry` = 4830);
-- Cracked Buckler
-- armor, from 9 to 6
UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2212);
UPDATE `applied_item_updates` SET `entry` = 2212, `version` = 3494 WHERE (`entry` = 2212);
-- White Woolen Dress
-- armor, from 17 to 16
UPDATE `item_template` SET `armor` = 16 WHERE (`entry` = 6787);
UPDATE `applied_item_updates` SET `entry` = 6787, `version` = 3494 WHERE (`entry` = 6787);
-- Magister's Vest
-- display_id, from 14524 to 12379
-- required_level, from 10 to 5
-- stat_type1, from 6 to 7
-- stat_value1, from 1 to 3
-- armor, from 16 to 14
UPDATE `item_template` SET `display_id` = 12379, `required_level` = 5, `stat_type1` = 7, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 2969);
UPDATE `applied_item_updates` SET `entry` = 2969, `version` = 3494 WHERE (`entry` = 2969);
-- Seafarer's Pantaloons
-- required_level, from 15 to 10
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2, `stat_value2` = 2, `armor` = 14 WHERE (`entry` = 3563);
UPDATE `applied_item_updates` SET `entry` = 3563, `version` = 3494 WHERE (`entry` = 3563);
-- Cured Leather Vest
-- name, from Cured Leather Armor to Cured Leather Vest
-- required_level, from 17 to 12
-- armor, from 35 to 32
UPDATE `item_template` SET `name` = 'Cured Leather Vest', `required_level` = 12, `armor` = 32 WHERE (`entry` = 236);
UPDATE `applied_item_updates` SET `entry` = 236, `version` = 3494 WHERE (`entry` = 236);
-- Veteran Buckler
-- required_level, from 12 to 7
-- stat_type1, from 1 to 3
-- stat_value1, from 4 to 2
-- armor, from 44 to 35
UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 3, `stat_value1` = 2, `armor` = 35 WHERE (`entry` = 3652);
UPDATE `applied_item_updates` SET `entry` = 3652, `version` = 3494 WHERE (`entry` = 3652);
-- Sharp Axe
-- display_id, from 5012 to 1383
-- required_level, from 5 to 1
-- dmg_min1, from 6.0 to 13
-- dmg_max1, from 13.0 to 21
UPDATE `item_template` SET `display_id` = 1383, `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 21 WHERE (`entry` = 1011);
UPDATE `applied_item_updates` SET `entry` = 1011, `version` = 3494 WHERE (`entry` = 1011);
-- Scimitar of Atun
-- required_level, from 14 to 9
-- dmg_min1, from 14.0 to 28
-- dmg_max1, from 27.0 to 43
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 28, `dmg_max1` = 43 WHERE (`entry` = 1469);
UPDATE `applied_item_updates` SET `entry` = 1469, `version` = 3494 WHERE (`entry` = 1469);
-- Short Cutlass
-- name, from Stock Shortsword to Short Cutlass
-- display_id, from 5150 to 5068
-- required_level, from 16 to 9
-- dmg_min1, from 6.0 to 12
-- dmg_max1, from 12.0 to 19
UPDATE `item_template` SET `name` = 'Short Cutlass', `display_id` = 5068, `required_level` = 9, `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 1817);
UPDATE `applied_item_updates` SET `entry` = 1817, `version` = 3494 WHERE (`entry` = 1817);
-- Insignia Belt
-- required_level, from 31 to 26
-- stat_value1, from 1 to 2
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 2, `armor` = 19 WHERE (`entry` = 6409);
UPDATE `applied_item_updates` SET `entry` = 6409, `version` = 3494 WHERE (`entry` = 6409);
-- Mail Combat Leggings
-- required_level, from 31 to 26
-- stat_value2, from 10 to 50
-- armor, from 63 to 57
UPDATE `item_template` SET `required_level` = 26, `stat_value2` = 50, `armor` = 57 WHERE (`entry` = 6402);
UPDATE `applied_item_updates` SET `entry` = 6402, `version` = 3494 WHERE (`entry` = 6402);
-- Scouting Trousers
-- display_id, from 14757 to 12484
-- buy_price, from 4489 to 5070
-- sell_price, from 897 to 1014
-- item_level, from 22 to 23
-- required_level, from 17 to 13
-- armor, from 33 to 31
UPDATE `item_template` SET `display_id` = 12484, `buy_price` = 5070, `sell_price` = 1014, `item_level` = 23, `required_level` = 13, `armor` = 31 WHERE (`entry` = 6587);
UPDATE `applied_item_updates` SET `entry` = 6587, `version` = 3494 WHERE (`entry` = 6587);
-- Defender Buckler
-- name, from Scouting Buckler to Defender Buckler
-- buy_price, from 3584 to 3528
-- sell_price, from 716 to 705
-- required_level, from 15 to 10
-- armor, from 49 to 39
UPDATE `item_template` SET `name` = 'Defender Buckler', `buy_price` = 3528, `sell_price` = 705, `required_level` = 10, `armor` = 39 WHERE (`entry` = 6571);
UPDATE `applied_item_updates` SET `entry` = 6571, `version` = 3494 WHERE (`entry` = 6571);
-- Hard Crawler Carapace
-- required_level, from 8 to 3
-- stat_type1, from 1 to 3
-- stat_value1, from 3 to 1
-- stat_value2, from 3 to 1
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 3, `stat_value1` = 1, `stat_value2` = 1, `armor` = 27 WHERE (`entry` = 2087);
UPDATE `applied_item_updates` SET `entry` = 2087, `version` = 3494 WHERE (`entry` = 2087);
-- Polished Scale Boots
-- required_level, from 22 to 17
-- armor, from 40 to 36
UPDATE `item_template` SET `required_level` = 17, `armor` = 36 WHERE (`entry` = 2149);
UPDATE `applied_item_updates` SET `entry` = 2149, `version` = 3494 WHERE (`entry` = 2149);
-- Canvas Cloak
-- required_level, from 13 to 8
UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 1766);
UPDATE `applied_item_updates` SET `entry` = 1766, `version` = 3494 WHERE (`entry` = 1766);
-- Cloak of Night
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 4447);
UPDATE `applied_item_updates` SET `entry` = 4447, `version` = 3494 WHERE (`entry` = 4447);
-- Canvas Boots
-- name, from Canvas Shoes to Canvas Boots
-- display_id, from 4143 to 1861
-- required_level, from 12 to 7
UPDATE `item_template` SET `name` = 'Canvas Boots', `display_id` = 1861, `required_level` = 7 WHERE (`entry` = 1764);
UPDATE `applied_item_updates` SET `entry` = 1764, `version` = 3494 WHERE (`entry` = 1764);
-- Large Metal Shield
-- required_level, from 17 to 12
-- armor, from 83 to 52
UPDATE `item_template` SET `required_level` = 12, `armor` = 52 WHERE (`entry` = 2445);
UPDATE `applied_item_updates` SET `entry` = 2445, `version` = 3494 WHERE (`entry` = 2445);
-- Hillman's Leather Vest
-- required_level, from 15 to 10
-- stat_value1, from 2 to 4
-- armor, from 36 to 33
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4, `armor` = 33 WHERE (`entry` = 4244);
UPDATE `applied_item_updates` SET `entry` = 4244, `version` = 3494 WHERE (`entry` = 4244);
-- Fine Leather Pants
-- required_level, from 16 to 11
-- stat_value1, from 1 to 4
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 4, `armor` = 30 WHERE (`entry` = 5958);
UPDATE `applied_item_updates` SET `entry` = 5958, `version` = 3494 WHERE (`entry` = 5958);
-- Studded Leather Pants
-- name, from Studded Pants to Studded Leather Pants
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 43 to 39
UPDATE `item_template` SET `name` = 'Studded Leather Pants', `required_level` = 27, `stat_value1` = 5, `armor` = 39 WHERE (`entry` = 2465);
UPDATE `applied_item_updates` SET `entry` = 2465, `version` = 3494 WHERE (`entry` = 2465);
-- Guardian Gloves
-- required_level, from 33 to 28
-- armor, from 28 to 25
UPDATE `item_template` SET `required_level` = 28, `armor` = 25 WHERE (`entry` = 5966);
UPDATE `applied_item_updates` SET `entry` = 5966, `version` = 3494 WHERE (`entry` = 5966);
-- Silk-threaded Trousers
-- required_level, from 13 to 8
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 4
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 6, `stat_value1` = 4, `armor` = 14 WHERE (`entry` = 1929);
UPDATE `applied_item_updates` SET `entry` = 1929, `version` = 3494 WHERE (`entry` = 1929);
-- Green Leather Bracers
-- required_level, from 31 to 26
-- armor, from 26 to 24
UPDATE `item_template` SET `required_level` = 26, `armor` = 24 WHERE (`entry` = 4259);
UPDATE `applied_item_updates` SET `entry` = 4259, `version` = 3494 WHERE (`entry` = 4259);
-- Reinforced Belt
-- name, from Support Girdle to Reinforced Belt
-- required_level, from 17 to 12
-- armor, from 17 to 15
UPDATE `item_template` SET `name` = 'Reinforced Belt', `required_level` = 12, `armor` = 15 WHERE (`entry` = 1215);
UPDATE `applied_item_updates` SET `entry` = 1215, `version` = 3494 WHERE (`entry` = 1215);
-- Black Metal Shortsword
-- required_level, from 21 to 16
-- dmg_min1, from 13.0 to 23
-- dmg_max1, from 26.0 to 35
-- shadow_res, from 4 to 0
UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 23, `dmg_max1` = 35, `shadow_res` = 0 WHERE (`entry` = 886);
UPDATE `applied_item_updates` SET `entry` = 886, `version` = 3494 WHERE (`entry` = 886);
-- Siege Brigade Vest
-- required_level, from 5 to 1
-- armor, from 33 to 30
UPDATE `item_template` SET `required_level` = 1, `armor` = 30 WHERE (`entry` = 3151);
UPDATE `applied_item_updates` SET `entry` = 3151, `version` = 3494 WHERE (`entry` = 3151);
-- Web-covered Boots
-- required_level, from 5 to 1
-- armor, from 8 to 7
UPDATE `item_template` SET `required_level` = 1, `armor` = 7 WHERE (`entry` = 6148);
UPDATE `applied_item_updates` SET `entry` = 6148, `version` = 3494 WHERE (`entry` = 6148);
-- Gnoll War Harness
-- required_level, from 10 to 5
-- stat_type1, from 4 to 7
-- stat_value1, from 1 to 3
-- armor, from 31 to 28
UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 7, `stat_value1` = 3, `armor` = 28 WHERE (`entry` = 1211);
UPDATE `applied_item_updates` SET `entry` = 1211, `version` = 3494 WHERE (`entry` = 1211);
-- Worn Mail Gloves
-- required_level, from 6 to 1
-- armor, from 14 to 13
UPDATE `item_template` SET `required_level` = 1, `armor` = 13 WHERE (`entry` = 1734);
UPDATE `applied_item_updates` SET `entry` = 1734, `version` = 3494 WHERE (`entry` = 1734);
-- Riverpaw Leather Vest
-- required_level, from 8 to 3
-- stat_type1, from 1 to 3
-- stat_value1, from 6 to 2
-- armor, from 29 to 27
UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 3, `stat_value1` = 2, `armor` = 27 WHERE (`entry` = 821);
UPDATE `applied_item_updates` SET `entry` = 821, `version` = 3494 WHERE (`entry` = 821);
-- Cured Leather Bracers
-- required_level, from 17 to 12
-- armor, from 17 to 16
UPDATE `item_template` SET `required_level` = 12, `armor` = 16 WHERE (`entry` = 1850);
UPDATE `applied_item_updates` SET `entry` = 1850, `version` = 3494 WHERE (`entry` = 1850);
-- Ogremage Staff
-- required_level, from 22 to 17
-- dmg_min1, from 45.0 to 55
-- dmg_max1, from 68.0 to 75
UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 55, `dmg_max1` = 75 WHERE (`entry` = 2226);
UPDATE `applied_item_updates` SET `entry` = 2226, `version` = 3494 WHERE (`entry` = 2226);
-- Frostbit Staff
-- required_level, from 7 to 1
-- dmg_min1, from 12.0 to 19
-- dmg_max1, from 19.0 to 27
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 19, `dmg_max1` = 27 WHERE (`entry` = 2067);
UPDATE `applied_item_updates` SET `entry` = 2067, `version` = 3494 WHERE (`entry` = 2067);
-- Hardwood Cudgel
-- required_level, from 15 to 10
-- dmg_min1, from 15.0 to 29
-- dmg_max1, from 29.0 to 45
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 29, `dmg_max1` = 45 WHERE (`entry` = 5757);
UPDATE `applied_item_updates` SET `entry` = 5757, `version` = 3494 WHERE (`entry` = 5757);
-- Battering Hammer
-- required_level, from 17 to 12
-- dmg_min1, from 31.0 to 45
-- dmg_max1, from 48.0 to 61
UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 45, `dmg_max1` = 61 WHERE (`entry` = 3198);
UPDATE `applied_item_updates` SET `entry` = 3198, `version` = 3494 WHERE (`entry` = 3198);
-- Thick Cloth Boots
-- name, from Thick Cloth Shoes to Thick Cloth Boots
-- display_id, from 3757 to 2301
-- required_level, from 17 to 12
-- armor, from 12 to 11
UPDATE `item_template` SET `name` = 'Thick Cloth Boots', `display_id` = 2301, `required_level` = 12, `armor` = 11 WHERE (`entry` = 202);
UPDATE `applied_item_updates` SET `entry` = 202, `version` = 3494 WHERE (`entry` = 202);
-- Small Dagger
-- required_level, from 15 to 8
-- dmg_min1, from 4.0 to 9
-- dmg_max1, from 9.0 to 14
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2764);
UPDATE `applied_item_updates` SET `entry` = 2764, `version` = 3494 WHERE (`entry` = 2764);
-- Wyvern Tailspike
-- required_level, from 21 to 16
-- dmg_min1, from 14.0 to 24
-- dmg_max1, from 27.0 to 37
-- spellid_1, from 16400 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 24, `dmg_max1` = 37, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5752);
UPDATE `applied_item_updates` SET `entry` = 5752, `version` = 3494 WHERE (`entry` = 5752);
-- Fine Leather Belt
-- required_level, from 11 to 6
-- armor, from 13 to 12
UPDATE `item_template` SET `required_level` = 6, `armor` = 12 WHERE (`entry` = 4246);
UPDATE `applied_item_updates` SET `entry` = 4246, `version` = 3494 WHERE (`entry` = 4246);
-- Worn Mail Pants
-- required_level, from 7 to 2
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 2, `armor` = 21 WHERE (`entry` = 1735);
UPDATE `applied_item_updates` SET `entry` = 1735, `version` = 3494 WHERE (`entry` = 1735);
-- Brocade Cloth Shoulderpads
-- name, from Brocade Shoulderpads to Brocade Cloth Shoulderpads
-- required_level, from 17 to 12
-- armor, from 10 to 9
UPDATE `item_template` SET `name` = 'Brocade Cloth Shoulderpads', `required_level` = 12, `armor` = 9 WHERE (`entry` = 1777);
UPDATE `applied_item_updates` SET `entry` = 1777, `version` = 3494 WHERE (`entry` = 1777);
-- Big Iron Fishing Pole
-- dmg_min1, from 3.0 to 12
-- dmg_max1, from 7.0 to 15
UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 15 WHERE (`entry` = 6367);
UPDATE `applied_item_updates` SET `entry` = 6367, `version` = 3494 WHERE (`entry` = 6367);
-- Cured Leather Gloves
-- required_level, from 17 to 12
-- armor, from 20 to 18
UPDATE `item_template` SET `required_level` = 12, `armor` = 18 WHERE (`entry` = 239);
UPDATE `applied_item_updates` SET `entry` = 239, `version` = 3494 WHERE (`entry` = 239);
-- Buzzer Blade
-- required_level, from 17 to 10
-- dmg_min1, from 8.0 to 15
-- dmg_max1, from 15.0 to 24
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 15, `dmg_max1` = 24 WHERE (`entry` = 2169);
UPDATE `applied_item_updates` SET `entry` = 2169, `version` = 3494 WHERE (`entry` = 2169);
-- Patched Leather Boots
-- name, from Warped Leather Boots to Patched Leather Boots
-- required_level, from 10 to 5
-- armor, from 14 to 12
UPDATE `item_template` SET `name` = 'Patched Leather Boots', `required_level` = 5, `armor` = 12 WHERE (`entry` = 1503);
UPDATE `applied_item_updates` SET `entry` = 1503, `version` = 3494 WHERE (`entry` = 1503);
-- Guardian Buckler
-- holy_res, from 0 to 4
UPDATE `item_template` SET `holy_res` = 4 WHERE (`entry` = 4820);
UPDATE `applied_item_updates` SET `entry` = 4820, `version` = 3494 WHERE (`entry` = 4820);
-- Darkweave Sash
-- required_level, from 30 to 25
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 11 to 10
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 2, `stat_value2` = 2, `armor` = 10, `shadow_res` = 1 WHERE (`entry` = 4720);
UPDATE `applied_item_updates` SET `entry` = 4720, `version` = 3494 WHERE (`entry` = 4720);
-- Silver-lined Bracers
-- required_level, from 5 to 1
-- armor, from 6 to 5
UPDATE `item_template` SET `required_level` = 1, `armor` = 5 WHERE (`entry` = 3224);
UPDATE `applied_item_updates` SET `entry` = 3224, `version` = 3494 WHERE (`entry` = 3224);
-- Glyphed Helm
-- required_level, from 35 to 30
-- stat_value1, from 4 to 5
-- stat_type2, from 7 to 6
-- stat_value2, from 4 to 2
-- stat_type3, from 4 to 7
-- stat_value3, from 2 to 5
-- armor, from 36 to 32
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 5, `stat_type2` = 6, `stat_value2` = 2, `stat_type3` = 7, `stat_value3` = 5, `armor` = 32 WHERE (`entry` = 6422);
UPDATE `applied_item_updates` SET `entry` = 6422, `version` = 3494 WHERE (`entry` = 6422);
-- Forest Leather Belt
-- required_level, from 20 to 15
-- stat_type1, from 6 to 3
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 3, `armor` = 16 WHERE (`entry` = 6382);
UPDATE `applied_item_updates` SET `entry` = 6382, `version` = 3494 WHERE (`entry` = 6382);
-- Kite Shield
-- required_level, from 22 to 17
-- armor, from 96 to 60
UPDATE `item_template` SET `required_level` = 17, `armor` = 60 WHERE (`entry` = 2446);
UPDATE `applied_item_updates` SET `entry` = 2446, `version` = 3494 WHERE (`entry` = 2446);
-- Runed Copper Breastplate
-- required_level, from 13 to 8
-- stat_value1, from 1 to 4
-- armor, from 52 to 47
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 4, `armor` = 47 WHERE (`entry` = 2864);
UPDATE `applied_item_updates` SET `entry` = 2864, `version` = 3494 WHERE (`entry` = 2864);
-- Shrapnel Blaster
-- required_level, from 35 to 30
-- dmg_min1, from 39.0 to 24
-- dmg_max1, from 74.0 to 37
UPDATE `item_template` SET `required_level` = 30, `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 4127);
UPDATE `applied_item_updates` SET `entry` = 4127, `version` = 3494 WHERE (`entry` = 4127);
-- Bronze Shortsword
-- required_level, from 21 to 14
-- dmg_min1, from 14.0 to 24
-- dmg_max1, from 26.0 to 37
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 2850);
UPDATE `applied_item_updates` SET `entry` = 2850, `version` = 3494 WHERE (`entry` = 2850);
-- Gloomshroud Armor
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 1489);
UPDATE `applied_item_updates` SET `entry` = 1489, `version` = 3494 WHERE (`entry` = 1489);
-- Bear Buckler
-- required_level, from 18 to 13
-- stat_type1, from 4 to 7
-- stat_value1, from 1 to 2
-- armor, from 54 to 43
UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 7, `stat_value1` = 2, `armor` = 43 WHERE (`entry` = 4821);
UPDATE `applied_item_updates` SET `entry` = 4821, `version` = 3494 WHERE (`entry` = 4821);
-- Fire Hardened Buckler
-- required_level, from 22 to 17
-- stat_value1, from 1 to 2
-- stat_value2, from 1 to 2
-- armor, from 60 to 48
-- fire_res, from 0 to 4
UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2, `stat_value2` = 2, `armor` = 48, `fire_res` = 4 WHERE (`entry` = 1276);
UPDATE `applied_item_updates` SET `entry` = 1276, `version` = 3494 WHERE (`entry` = 1276);
-- Glimmering Mail Gauntlets
-- required_level, from 26 to 21
-- stat_value1, from 3 to 4
-- armor, from 39 to 36
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 4, `armor` = 36 WHERE (`entry` = 4072);
UPDATE `applied_item_updates` SET `entry` = 4072, `version` = 3494 WHERE (`entry` = 4072);
-- Glimmering Mail Bracers
-- required_level, from 26 to 21
-- armor, from 32 to 29
UPDATE `item_template` SET `required_level` = 21, `armor` = 29 WHERE (`entry` = 6387);
UPDATE `applied_item_updates` SET `entry` = 6387, `version` = 3494 WHERE (`entry` = 6387);
-- Gloom Reaper
-- required_level, from 32 to 27
-- dmg_min1, from 35.0 to 53
-- dmg_max1, from 66.0 to 80
UPDATE `item_template` SET `required_level` = 27, `dmg_min1` = 53, `dmg_max1` = 80 WHERE (`entry` = 863);
UPDATE `applied_item_updates` SET `entry` = 863, `version` = 3494 WHERE (`entry` = 863);
-- Ring of Healing
-- buy_price, from 21400 to 1400
-- sell_price, from 5350 to 350
UPDATE `item_template` SET `buy_price` = 1400, `sell_price` = 350 WHERE (`entry` = 1713);
UPDATE `applied_item_updates` SET `entry` = 1713, `version` = 3494 WHERE (`entry` = 1713);
-- Frostmane Leather Vest
-- armor, from 9 to 8
UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2108);
UPDATE `applied_item_updates` SET `entry` = 2108, `version` = 3494 WHERE (`entry` = 2108);
-- Gray Woolen Robe
-- required_level, from 16 to 11
-- stat_value1, from 2 to 4
-- armor, from 19 to 17
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 4, `armor` = 17 WHERE (`entry` = 2585);
UPDATE `applied_item_updates` SET `entry` = 2585, `version` = 3494 WHERE (`entry` = 2585);
-- Huge Ogre Sword
-- required_level, from 24 to 19
-- stat_value1, from 5 to 7
-- dmg_min1, from 55.0 to 64
-- dmg_max1, from 83.0 to 87
UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 7, `dmg_min1` = 64, `dmg_max1` = 87 WHERE (`entry` = 913);
UPDATE `applied_item_updates` SET `entry` = 913, `version` = 3494 WHERE (`entry` = 913);
-- Thelsamar Axe
-- required_level, from 13 to 8
-- dmg_min1, from 11.0 to 22
-- dmg_max1, from 21.0 to 34
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 3154);
UPDATE `applied_item_updates` SET `entry` = 3154, `version` = 3494 WHERE (`entry` = 3154);
-- Sword of the Night Sky
-- required_level, from 19 to 14
-- dmg_min1, from 12.0 to 22
-- dmg_max1, from 23.0 to 33
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 22, `dmg_max1` = 33 WHERE (`entry` = 2035);
UPDATE `applied_item_updates` SET `entry` = 2035, `version` = 3494 WHERE (`entry` = 2035);
-- Bashing Pauldrons
-- armor, from 27 to 24
UPDATE `item_template` SET `armor` = 24 WHERE (`entry` = 5319);
UPDATE `applied_item_updates` SET `entry` = 5319, `version` = 3494 WHERE (`entry` = 5319);
-- Calico Bracers
-- required_level, from 7 to 2
UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 3375);
UPDATE `applied_item_updates` SET `entry` = 3375, `version` = 3494 WHERE (`entry` = 3375);
-- Laced Mail Gloves
-- required_level, from 13 to 8
-- armor, from 18 to 17
UPDATE `item_template` SET `required_level` = 8, `armor` = 17 WHERE (`entry` = 1742);
UPDATE `applied_item_updates` SET `entry` = 1742, `version` = 3494 WHERE (`entry` = 1742);
-- Hardened Leather Shoulderpads
-- name, from Tough Leather Shoulderpads to Hardened Leather Shoulderpads
-- required_level, from 21 to 16
-- armor, from 21 to 19
UPDATE `item_template` SET `name` = 'Hardened Leather Shoulderpads', `required_level` = 16, `armor` = 19 WHERE (`entry` = 1809);
UPDATE `applied_item_updates` SET `entry` = 1809, `version` = 3494 WHERE (`entry` = 1809);
-- Combat Shield
-- buy_price, from 26558 to 31551
-- sell_price, from 5311 to 6310
-- item_level, from 36 to 38
-- required_level, from 31 to 28
-- stat_value1, from 3 to 4
-- stat_value2, from 2 to 3
-- armor, from 150 to 109
UPDATE `item_template` SET `buy_price` = 31551, `sell_price` = 6310, `item_level` = 38, `required_level` = 28, `stat_value1` = 4, `stat_value2` = 3, `armor` = 109 WHERE (`entry` = 4065);
UPDATE `applied_item_updates` SET `entry` = 4065, `version` = 3494 WHERE (`entry` = 4065);
-- Linked Chain Bracers
-- required_level, from 17 to 12
-- armor, from 18 to 17
UPDATE `item_template` SET `required_level` = 12, `armor` = 17 WHERE (`entry` = 1748);
UPDATE `applied_item_updates` SET `entry` = 1748, `version` = 3494 WHERE (`entry` = 1748);
-- Turtle Shell Shield
-- buy_price, from 2810 to 2605
-- sell_price, from 562 to 521
-- required_level, from 15 to 10
-- armor, from 78 to 48
UPDATE `item_template` SET `buy_price` = 2605, `sell_price` = 521, `required_level` = 10, `armor` = 48 WHERE (`entry` = 6447);
UPDATE `applied_item_updates` SET `entry` = 6447, `version` = 3494 WHERE (`entry` = 6447);
-- White Leather Jerkin
-- required_level, from 8 to 3
-- armor, from 27 to 24
UPDATE `item_template` SET `required_level` = 3, `armor` = 24 WHERE (`entry` = 2311);
UPDATE `applied_item_updates` SET `entry` = 2311, `version` = 3494 WHERE (`entry` = 2311);
-- Canvas Gloves
-- required_level, from 14 to 9
UPDATE `item_template` SET `required_level` = 9 WHERE (`entry` = 1767);
UPDATE `applied_item_updates` SET `entry` = 1767, `version` = 3494 WHERE (`entry` = 1767);
-- Soldier's Shield
-- required_level, from 12 to 7
-- armor, from 87 to 60
UPDATE `item_template` SET `required_level` = 7, `armor` = 60 WHERE (`entry` = 6560);
UPDATE `applied_item_updates` SET `entry` = 6560, `version` = 3494 WHERE (`entry` = 6560);
-- Shiny Dirk
-- required_level, from 36 to 29
-- dmg_min1, from 14.0 to 21
-- dmg_max1, from 28.0 to 33
UPDATE `item_template` SET `required_level` = 29, `dmg_min1` = 21, `dmg_max1` = 33 WHERE (`entry` = 3786);
UPDATE `applied_item_updates` SET `entry` = 3786, `version` = 3494 WHERE (`entry` = 3786);
-- Frost Tiger Blade
-- required_level, from 35 to 30
-- stat_value1, from 9 to 11
-- dmg_min1, from 80.0 to 88
-- dmg_max1, from 121.0 to 120
-- spellid_1, from 7597 to 0
-- spelltrigger_1, from 1 to 0
-- spellid_2, from 13439 to 0
-- spelltrigger_2, from 2 to 0
UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 11, `dmg_min1` = 88, `dmg_max1` = 120, `spellid_1` = 0, `spelltrigger_1` = 0, `spellid_2` = 0, `spelltrigger_2` = 0 WHERE (`entry` = 3854);
UPDATE `applied_item_updates` SET `entry` = 3854, `version` = 3494 WHERE (`entry` = 3854);
-- Engineer's Cloak
-- buy_price, from 4962 to 4828
-- sell_price, from 992 to 965
-- required_level, from 22 to 17
-- stat_type1, from 5 to 6
-- armor, from 16 to 15
UPDATE `item_template` SET `buy_price` = 4828, `sell_price` = 965, `required_level` = 17, `stat_type1` = 6, `armor` = 15 WHERE (`entry` = 6667);
UPDATE `applied_item_updates` SET `entry` = 6667, `version` = 3494 WHERE (`entry` = 6667);
-- Pysan's Old Greatsword
-- stat_value1, from 4 to 6
-- dmg_min1, from 48.0 to 58
-- dmg_max1, from 72.0 to 79
UPDATE `item_template` SET `stat_value1` = 6, `dmg_min1` = 58, `dmg_max1` = 79 WHERE (`entry` = 1975);
UPDATE `applied_item_updates` SET `entry` = 1975, `version` = 3494 WHERE (`entry` = 1975);
-- Glinting Scale Gloves
-- required_level, from 22 to 17
-- armor, from 32 to 30
UPDATE `item_template` SET `required_level` = 17, `armor` = 30 WHERE (`entry` = 3047);
UPDATE `applied_item_updates` SET `entry` = 3047, `version` = 3494 WHERE (`entry` = 3047);
-- Stalvan's Reaper
-- dmg_min1, from 27.0 to 43
-- dmg_max1, from 51.0 to 65
-- spellid_1, from 13524 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `dmg_min1` = 43, `dmg_max1` = 65, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 934);
UPDATE `applied_item_updates` SET `entry` = 934, `version` = 3494 WHERE (`entry` = 934);
-- Runescale Girdle
-- required_level, from 15 to 10
-- armor, from 24 to 22
UPDATE `item_template` SET `required_level` = 10, `armor` = 22 WHERE (`entry` = 5425);
UPDATE `applied_item_updates` SET `entry` = 5425, `version` = 3494 WHERE (`entry` = 5425);
-- Patched Leather Bracers
-- name, from Warped Leather Bracers to Patched Leather Bracers
-- required_level, from 6 to 1
UPDATE `item_template` SET `name` = 'Patched Leather Bracers', `required_level` = 1 WHERE (`entry` = 1504);
UPDATE `applied_item_updates` SET `entry` = 1504, `version` = 3494 WHERE (`entry` = 1504);
-- Enamelled Broadsword
-- required_level, from 9 to 11
-- dmg_min1, from 10.0 to 21
-- dmg_max1, from 19.0 to 33
UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 21, `dmg_max1` = 33 WHERE (`entry` = 4765);
UPDATE `applied_item_updates` SET `entry` = 4765, `version` = 3494 WHERE (`entry` = 4765);
-- Tanned Leather Pants
-- display_id, from 9640 to 3248
-- required_level, from 12 to 7
-- armor, from 26 to 24
UPDATE `item_template` SET `display_id` = 3248, `required_level` = 7, `armor` = 24 WHERE (`entry` = 845);
UPDATE `applied_item_updates` SET `entry` = 845, `version` = 3494 WHERE (`entry` = 845);
-- Grey Iron Axe
-- name, from Umbral Axe to Grey Iron Axe
-- required_level, from 10 to 5
-- dmg_min1, from 12.0 to 25
-- dmg_max1, from 23.0 to 39
UPDATE `item_template` SET `name` = 'Grey Iron Axe', `required_level` = 5, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 6978);
UPDATE `applied_item_updates` SET `entry` = 6978, `version` = 3494 WHERE (`entry` = 6978);
-- Thick Cloth Pants
-- required_level, from 17 to 12
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 12, `armor` = 14 WHERE (`entry` = 201);
UPDATE `applied_item_updates` SET `entry` = 201, `version` = 3494 WHERE (`entry` = 201);
-- Small Egg
-- display_id, from 18046 to 13211
UPDATE `item_template` SET `display_id` = 13211 WHERE (`entry` = 6889);
UPDATE `applied_item_updates` SET `entry` = 6889, `version` = 3494 WHERE (`entry` = 6889);
-- Padded Cloth Pants
-- name, from Padded Pants to Padded Cloth Pants
-- required_level, from 22 to 17
-- armor, from 17 to 15
UPDATE `item_template` SET `name` = 'Padded Cloth Pants', `required_level` = 17, `armor` = 15 WHERE (`entry` = 2159);
UPDATE `applied_item_updates` SET `entry` = 2159, `version` = 3494 WHERE (`entry` = 2159);
-- Dwarven Tree Chopper
-- spellid_1, from 7552 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2907);
UPDATE `applied_item_updates` SET `entry` = 2907, `version` = 3494 WHERE (`entry` = 2907);
-- Wooden Buckler
-- required_level, from 10 to 5
-- armor, from 24 to 16
UPDATE `item_template` SET `required_level` = 5, `armor` = 16 WHERE (`entry` = 2214);
UPDATE `applied_item_updates` SET `entry` = 2214, `version` = 3494 WHERE (`entry` = 2214);
-- Patched Leather Vest
-- name, from Warped Leather Vest to Patched Leather Vest
-- required_level, from 6 to 1
-- armor, from 17 to 15
UPDATE `item_template` SET `name` = 'Patched Leather Vest', `required_level` = 1, `armor` = 15 WHERE (`entry` = 1509);
UPDATE `applied_item_updates` SET `entry` = 1509, `version` = 3494 WHERE (`entry` = 1509);
-- Silver Steel Sword
-- required_level, from 10 to 5
-- dmg_min1, from 9.0 to 20
-- dmg_max1, from 18.0 to 30
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 20, `dmg_max1` = 30 WHERE (`entry` = 6967);
UPDATE `applied_item_updates` SET `entry` = 6967, `version` = 3494 WHERE (`entry` = 6967);
-- Calico Pants
-- required_level, from 6 to 1
UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1499);
UPDATE `applied_item_updates` SET `entry` = 1499, `version` = 3494 WHERE (`entry` = 1499);
-- Green Carapace Shield
-- required_level, from 16 to 11
-- stat_value1, from 1 to 2
-- armor, from 100 to 70
-- nature_res, from 4 to 0
UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 2, `armor` = 70, `nature_res` = 0 WHERE (`entry` = 2021);
UPDATE `applied_item_updates` SET `entry` = 2021, `version` = 3494 WHERE (`entry` = 2021);
-- Frostweave Boots
-- required_level, from 26 to 21
-- armor, from 15 to 13
UPDATE `item_template` SET `required_level` = 21, `armor` = 13 WHERE (`entry` = 6394);
UPDATE `applied_item_updates` SET `entry` = 6394, `version` = 3494 WHERE (`entry` = 6394);
-- Frostweave Pants
-- required_level, from 26 to 21
-- stat_value1, from 5 to 7
-- armor, from 21 to 19
-- frost_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 7, `armor` = 19, `frost_res` = 1 WHERE (`entry` = 4037);
UPDATE `applied_item_updates` SET `entry` = 4037, `version` = 3494 WHERE (`entry` = 4037);
-- Darkweave Robe
-- display_id, from 14606 to 12659
-- required_level, from 32 to 27
-- stat_value1, from 2 to 3
-- stat_value3, from 1 to 2
-- armor, from 27 to 24
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `display_id` = 12659, `required_level` = 27, `stat_value1` = 3, `stat_value3` = 2, `armor` = 24, `shadow_res` = 1 WHERE (`entry` = 4038);
UPDATE `applied_item_updates` SET `entry` = 4038, `version` = 3494 WHERE (`entry` = 4038);
-- Midnight Mace
-- dmg_min2, from 1.0 to 0
-- dmg_max2, from 10.0 to 0
-- dmg_type2, from 5 to 0
-- shadow_res, from 10 to 0
-- spellid_1, from 0 to 705
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `dmg_min2` = 0, `dmg_max2` = 0, `dmg_type2` = 0, `shadow_res` = 0, `spellid_1` = 705, `spelltrigger_1` = 2 WHERE (`entry` = 936);
UPDATE `applied_item_updates` SET `entry` = 936, `version` = 3494 WHERE (`entry` = 936);
-- Shiver Blade
-- required_level, from 15 to 10
-- dmg_min1, from 26.0 to 38
-- dmg_max1, from 40.0 to 53
UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 38, `dmg_max1` = 53 WHERE (`entry` = 5182);
UPDATE `applied_item_updates` SET `entry` = 5182, `version` = 3494 WHERE (`entry` = 5182);
-- Shadowhide Two-handed Sword
-- required_level, from 15 to 10
-- stat_value1, from 1 to 5
-- dmg_min1, from 26.0 to 38
-- dmg_max1, from 40.0 to 53
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 5, `dmg_min1` = 38, `dmg_max1` = 53 WHERE (`entry` = 1460);
UPDATE `applied_item_updates` SET `entry` = 1460, `version` = 3494 WHERE (`entry` = 1460);
-- Staff of Nobles
-- required_level, from 13 to 8
-- stat_value1, from 1 to 2
-- dmg_min1, from 26.0 to 40
-- dmg_max1, from 40.0 to 55
UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 2, `dmg_min1` = 40, `dmg_max1` = 55 WHERE (`entry` = 3902);
UPDATE `applied_item_updates` SET `entry` = 3902, `version` = 3494 WHERE (`entry` = 3902);
-- Runic Loin Cloth
-- required_level, from 12 to 7
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 3
-- armor, from 15 to 13
UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 6, `stat_value1` = 3, `armor` = 13 WHERE (`entry` = 3309);
UPDATE `applied_item_updates` SET `entry` = 3309, `version` = 3494 WHERE (`entry` = 3309);
-- Chromatic Robe
-- required_level, from 24 to 19
-- stat_value1, from 3 to 4
-- armor, from 20 to 19
UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 4, `armor` = 19 WHERE (`entry` = 2615);
UPDATE `applied_item_updates` SET `entry` = 2615, `version` = 3494 WHERE (`entry` = 2615);
-- Burning Robes
-- fire_res, from 0 to 1
UPDATE `item_template` SET `fire_res` = 1 WHERE (`entry` = 2617);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2617, 3494);
-- Reinforced Leather Cap
-- display_id, from 15311 to 13264
-- required_level, from 45 to 40
-- stat_value1, from 8 to 9
-- armor, from 38 to 34
UPDATE `item_template` SET `display_id` = 13264, `required_level` = 40, `stat_value1` = 9, `armor` = 34 WHERE (`entry` = 3893);
UPDATE `applied_item_updates` SET `entry` = 3893, `version` = 3494 WHERE (`entry` = 3893);
-- Brigandine Helm
-- required_level, from 45 to 40
-- stat_value1, from 8 to 9
-- armor, from 57 to 51
UPDATE `item_template` SET `required_level` = 40, `stat_value1` = 9, `armor` = 51 WHERE (`entry` = 3894);
UPDATE `applied_item_updates` SET `entry` = 3894, `version` = 3494 WHERE (`entry` = 3894);
-- Heart of Agammagan
-- frost_res, from 0 to 4
UPDATE `item_template` SET `frost_res` = 4 WHERE (`entry` = 6694);
UPDATE `applied_item_updates` SET `entry` = 6694, `version` = 3494 WHERE (`entry` = 6694);
-- Green Woolen Vest
-- required_level, from 12 to 7
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 7, `armor` = 14 WHERE (`entry` = 2582);
UPDATE `applied_item_updates` SET `entry` = 2582, `version` = 3494 WHERE (`entry` = 2582);
-- Mail Combat Gauntlets
-- required_level, from 30 to 25
-- stat_value1, from 3 to 5
-- armor, from 43 to 39
UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 5, `armor` = 39 WHERE (`entry` = 4075);
UPDATE `applied_item_updates` SET `entry` = 4075, `version` = 3494 WHERE (`entry` = 4075);
-- Battleforge Gauntlets
-- required_level, from 22 to 17
-- armor, from 32 to 30
UPDATE `item_template` SET `required_level` = 17, `armor` = 30 WHERE (`entry` = 6595);
UPDATE `applied_item_updates` SET `entry` = 6595, `version` = 3494 WHERE (`entry` = 6595);
-- Cryptbone Staff
-- required_level, from 21 to 16
-- stat_value1, from 2 to 3
-- stat_value2, from 1 to 2
-- stat_value3, from 1 to 2
-- dmg_min1, from 37.0 to 46
-- dmg_max1, from 56.0 to 63
UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3, `stat_value2` = 2, `stat_value3` = 2, `dmg_min1` = 46, `dmg_max1` = 63 WHERE (`entry` = 2013);
UPDATE `applied_item_updates` SET `entry` = 2013, `version` = 3494 WHERE (`entry` = 2013);
-- Insignia Gloves
-- nature_res, from 0 to 1
UPDATE `item_template` SET `nature_res` = 1 WHERE (`entry` = 6408);
UPDATE `applied_item_updates` SET `entry` = 6408, `version` = 3494 WHERE (`entry` = 6408);
-- Shadow Hood
-- required_level, from 29 to 24
-- stat_value1, from 2 to 3
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 4323);
UPDATE `applied_item_updates` SET `entry` = 4323, `version` = 3494 WHERE (`entry` = 4323);
-- Cured Leather Pants
-- required_level, from 17 to 12
-- armor, from 30 to 28
UPDATE `item_template` SET `required_level` = 12, `armor` = 28 WHERE (`entry` = 237);
UPDATE `applied_item_updates` SET `entry` = 237, `version` = 3494 WHERE (`entry` = 237);
-- Burning War Axe
-- spellid_1, from 7711 to 0
-- spelltrigger_1, from 2 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2299);
UPDATE `applied_item_updates` SET `entry` = 2299, `version` = 3494 WHERE (`entry` = 2299);
-- Willow Vest
-- display_id, from 14739 to 12437
-- buy_price, from 1396 to 1348
-- sell_price, from 279 to 269
-- required_level, from 10 to 5
-- armor, from 16 to 14
UPDATE `item_template` SET `display_id` = 12437, `buy_price` = 1348, `sell_price` = 269, `required_level` = 5, `armor` = 14 WHERE (`entry` = 6536);
UPDATE `applied_item_updates` SET `entry` = 6536, `version` = 3494 WHERE (`entry` = 6536);
-- Calico Cloak
-- required_level, from 9 to 4
UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 1497);
UPDATE `applied_item_updates` SET `entry` = 1497, `version` = 3494 WHERE (`entry` = 1497);
-- Skeletal Club of Pain
-- spellid_1, from 13440 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2256);
UPDATE `applied_item_updates` SET `entry` = 2256, `version` = 3494 WHERE (`entry` = 2256);
-- Buckler of the Seas
-- required_level, from 15 to 10
-- armor, from 49 to 39
UPDATE `item_template` SET `required_level` = 10, `armor` = 39 WHERE (`entry` = 1557);
UPDATE `applied_item_updates` SET `entry` = 1557, `version` = 3494 WHERE (`entry` = 1557);
-- Bent Fire Wand
-- name, from Fire Wand to Bent Fire Wand
-- quality, from 2 to 1
-- flags, from 256 to 272
-- buy_price, from 1465 to 13
-- sell_price, from 293 to 2
-- item_level, from 12 to 1
-- required_level, from 7 to 1
-- dmg_min1, from 9.0 to 7
-- dmg_max1, from 17.0 to 11
-- delay, from 1500 to 2800
UPDATE `item_template` SET `name` = 'Bent Fire Wand', `quality` = 1, `flags` = 272, `buy_price` = 13, `sell_price` = 2, `item_level` = 1, `required_level` = 1, `dmg_min1` = 7, `dmg_max1` = 11, `delay` = 2800 WHERE (`entry` = 5069);
UPDATE `applied_item_updates` SET `entry` = 5069, `version` = 3494 WHERE (`entry` = 5069);
-- Ritual Blade
-- required_level, from 10 to 5
-- dmg_min1, from 6.0 to 12
-- dmg_max1, from 12.0 to 18
-- spellid_1, from 0 to 686
-- spelltrigger_1, from 0 to 2
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 12, `dmg_max1` = 18, `spellid_1` = 686, `spelltrigger_1` = 2 WHERE (`entry` = 5112);
UPDATE `applied_item_updates` SET `entry` = 5112, `version` = 3494 WHERE (`entry` = 5112);
-- Bearded Axe
-- dmg_min1, from 13.0 to 24
-- dmg_max1, from 26.0 to 37
UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 2878);
UPDATE `applied_item_updates` SET `entry` = 2878, `version` = 3494 WHERE (`entry` = 2878);
-- Rawhide Boots
-- name, from Patched Leather Boots to Rawhide Boots
-- display_id, from 703 to 3712
-- required_level, from 14 to 9
-- armor, from 15 to 14
UPDATE `item_template` SET `name` = 'Rawhide Boots', `display_id` = 3712, `required_level` = 9, `armor` = 14 WHERE (`entry` = 1788);
UPDATE `applied_item_updates` SET `entry` = 1788, `version` = 3494 WHERE (`entry` = 1788);
-- Scarecrow Trousers
-- required_level, from 15 to 10
-- stat_value1, from 2 to 4
-- armor, from 16 to 14
UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4, `armor` = 14 WHERE (`entry` = 4434);
UPDATE `applied_item_updates` SET `entry` = 4434, `version` = 3494 WHERE (`entry` = 4434);
-- Thick Cloth Gloves
-- required_level, from 17 to 12
-- armor, from 10 to 9
UPDATE `item_template` SET `required_level` = 12, `armor` = 9 WHERE (`entry` = 203);
UPDATE `applied_item_updates` SET `entry` = 203, `version` = 3494 WHERE (`entry` = 203);
-- Enchanted Moonstalker Cloak
-- required_level, from 15 to 10
-- stat_type1, from 7 to 6
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 6, `armor` = 12 WHERE (`entry` = 5387);
UPDATE `applied_item_updates` SET `entry` = 5387, `version` = 3494 WHERE (`entry` = 5387);
-- Artisan's Trousers
-- required_level, from 28 to 23
-- stat_value1, from 6 to 5
-- armor, from 22 to 20
UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 5, `armor` = 20 WHERE (`entry` = 5016);
UPDATE `applied_item_updates` SET `entry` = 5016, `version` = 3494 WHERE (`entry` = 5016);
-- Executioner's Sword
-- required_level, from 19 to 21
-- stat_value2, from 2 to 4
-- dmg_min1, from 39.0 to 51
-- dmg_max1, from 59.0 to 70
UPDATE `item_template` SET `required_level` = 21, `stat_value2` = 4, `dmg_min1` = 51, `dmg_max1` = 70 WHERE (`entry` = 4818);
UPDATE `applied_item_updates` SET `entry` = 4818, `version` = 3494 WHERE (`entry` = 4818);
-- Robes of Arcana
-- required_level, from 25 to 20
-- stat_value1, from 3 to 4
-- stat_value2, from 3 to 4
-- armor, from 23 to 21
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 4, `stat_value2` = 4, `armor` = 21 WHERE (`entry` = 5770);
UPDATE `applied_item_updates` SET `entry` = 5770, `version` = 3494 WHERE (`entry` = 5770);
-- Black Husk Shield
-- required_level, from 19 to 14
-- stat_value1, from 1 to 3
-- armor, from 110 to 77
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `required_level` = 14, `stat_value1` = 3, `armor` = 77, `shadow_res` = 1 WHERE (`entry` = 4444);
UPDATE `applied_item_updates` SET `entry` = 4444, `version` = 3494 WHERE (`entry` = 4444);
-- Brackclaw
-- required_level, from 14 to 9
-- dmg_min1, from 7.0 to 15
-- dmg_max1, from 15.0 to 23
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 2235);
UPDATE `applied_item_updates` SET `entry` = 2235, `version` = 3494 WHERE (`entry` = 2235);
-- Cheap Blunderbuss
-- required_level, from 10 to 3
-- dmg_max1, from 15.0 to 11
UPDATE `item_template` SET `required_level` = 3, `dmg_max1` = 11 WHERE (`entry` = 2778);
UPDATE `applied_item_updates` SET `entry` = 2778, `version` = 3494 WHERE (`entry` = 2778);
-- Savage Trodders
-- required_level, from 17 to 12
-- stat_type1, from 4 to 6
-- stat_type2, from 1 to 7
-- stat_value2, from 5 to 2
-- armor, from 39 to 36
UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 6, `stat_type2` = 7, `stat_value2` = 2, `armor` = 36 WHERE (`entry` = 6459);
UPDATE `applied_item_updates` SET `entry` = 6459, `version` = 3494 WHERE (`entry` = 6459);
-- Silver Steel Axe
-- required_level, from 10 to 5
-- dmg_min1, from 12.0 to 25
-- dmg_max1, from 23.0 to 39
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 6966);
UPDATE `applied_item_updates` SET `entry` = 6966, `version` = 3494 WHERE (`entry` = 6966);
-- Rough Bronze Cuirass
-- required_level, from 18 to 13
-- armor, from 53 to 49
UPDATE `item_template` SET `required_level` = 13, `armor` = 49 WHERE (`entry` = 2866);
UPDATE `applied_item_updates` SET `entry` = 2866, `version` = 3494 WHERE (`entry` = 2866);
-- Battle Slayer
-- required_level, from 18 to 13
-- dmg_min1, from 35.0 to 48
-- dmg_max1, from 54.0 to 66
UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 48, `dmg_max1` = 66 WHERE (`entry` = 3199);
UPDATE `applied_item_updates` SET `entry` = 3199, `version` = 3494 WHERE (`entry` = 3199);
-- Glowing Leather Bracers
-- required_level, from 23 to 18
-- stat_value1, from 1 to 2
-- armor, from 22 to 20
UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `armor` = 20 WHERE (`entry` = 2017);
UPDATE `applied_item_updates` SET `entry` = 2017, `version` = 3494 WHERE (`entry` = 2017);
-- Polished Scale Gloves
-- required_level, from 22 to 17
-- armor, from 32 to 30
UPDATE `item_template` SET `required_level` = 17, `armor` = 30 WHERE (`entry` = 2151);
UPDATE `applied_item_updates` SET `entry` = 2151, `version` = 3494 WHERE (`entry` = 2151);
-- Champion's Claymore
-- name, from Blessed Claymore to Champion's Claymore
-- required_level, from 17 to 19
-- stat_value1, from 1 to 3
-- dmg_min1, from 25.0 to 36
-- dmg_max1, from 39.0 to 49
UPDATE `item_template` SET `name` = 'Champion\'s Claymore', `required_level` = 19, `stat_value1` = 3, `dmg_min1` = 36, `dmg_max1` = 49 WHERE (`entry` = 4817);
UPDATE `applied_item_updates` SET `entry` = 4817, `version` = 3494 WHERE (`entry` = 4817);
-- Heavy Copper Broadsword
-- required_level, from 16 to 9
-- dmg_min1, from 21.0 to 31
-- dmg_max1, from 32.0 to 43
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 31, `dmg_max1` = 43 WHERE (`entry` = 3487);
UPDATE `applied_item_updates` SET `entry` = 3487, `version` = 3494 WHERE (`entry` = 3487);
-- Rectangular Shield
-- required_level, from 12 to 7
-- armor, from 52 to 30
UPDATE `item_template` SET `required_level` = 7, `armor` = 30 WHERE (`entry` = 2217);
UPDATE `applied_item_updates` SET `entry` = 2217, `version` = 3494 WHERE (`entry` = 2217);
-- Defias Mage Staff
-- required_level, from 11 to 6
-- stat_value1, from 1 to 2
-- dmg_min1, from 20.0 to 32
-- dmg_max1, from 31.0 to 44
UPDATE `item_template` SET `required_level` = 6, `stat_value1` = 2, `dmg_min1` = 32, `dmg_max1` = 44 WHERE (`entry` = 1928);
UPDATE `applied_item_updates` SET `entry` = 1928, `version` = 3494 WHERE (`entry` = 1928);
-- Haggard's Dagger
-- required_level, from 10 to 5
-- dmg_min1, from 7.0 to 16
-- dmg_max1, from 15.0 to 24
UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 16, `dmg_max1` = 24 WHERE (`entry` = 6980);
UPDATE `applied_item_updates` SET `entry` = 6980, `version` = 3494 WHERE (`entry` = 6980);
-- Cross-stitched Bracers
-- required_level, from 23 to 18
-- armor, from 7 to 6
UPDATE `item_template` SET `required_level` = 18, `armor` = 6 WHERE (`entry` = 3381);
UPDATE `applied_item_updates` SET `entry` = 3381, `version` = 3494 WHERE (`entry` = 3381);
-- Whisperwind Headdress
-- required_level, from 27 to 22
-- stat_value1, from 2 to 3
-- stat_value2, from 3 to 4
-- stat_value3, from 10 to 15
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value2` = 4, `stat_value3` = 15, `armor` = 27 WHERE (`entry` = 6688);
UPDATE `applied_item_updates` SET `entry` = 6688, `version` = 3494 WHERE (`entry` = 6688);
-- Adept's Gloves
-- required_level, from 10 to 5
-- stat_value1, from 3 to 20
-- armor, from 9 to 8
UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 20, `armor` = 8 WHERE (`entry` = 4768);
UPDATE `applied_item_updates` SET `entry` = 4768, `version` = 3494 WHERE (`entry` = 4768);
-- Oiled Blunderbuss
-- required_level, from 26 to 19
-- dmg_min1, from 16.0 to 10
-- dmg_max1, from 30.0 to 16
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 2786);
UPDATE `applied_item_updates` SET `entry` = 2786, `version` = 3494 WHERE (`entry` = 2786);
-- Fire Hardened Gauntlets
-- required_level, from 26 to 21
-- stat_value1, from 2 to 3
-- stat_value2, from 15 to 25
-- armor, from 39 to 36
UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3, `stat_value2` = 25, `armor` = 36 WHERE (`entry` = 6974);
UPDATE `applied_item_updates` SET `entry` = 6974, `version` = 3494 WHERE (`entry` = 6974);
-- Studded Leather Gloves
-- name, from Studded Gloves to Studded Leather Gloves
-- required_level, from 32 to 27
-- armor, from 27 to 25
UPDATE `item_template` SET `name` = 'Studded Leather Gloves', `required_level` = 27, `armor` = 25 WHERE (`entry` = 2469);
UPDATE `applied_item_updates` SET `entry` = 2469, `version` = 3494 WHERE (`entry` = 2469);
-- Fire Hardened Leggings
-- required_level, from 24 to 19
-- stat_type1, from 4 to 6
-- stat_value1, from 3 to 2
-- stat_type2, from 1 to 4
-- stat_value2, from 20 to 4
-- armor, from 58 to 53
UPDATE `item_template` SET `required_level` = 19, `stat_type1` = 6, `stat_value1` = 2, `stat_type2` = 4, `stat_value2` = 4, `armor` = 53 WHERE (`entry` = 6973);
UPDATE `applied_item_updates` SET `entry` = 6973, `version` = 3494 WHERE (`entry` = 6973);
-- Pugilist Bracers
-- stat_value1, from 3 to 4
-- armor, from 36 to 32
UPDATE `item_template` SET `stat_value1` = 4, `armor` = 32 WHERE (`entry` = 4438);
UPDATE `applied_item_updates` SET `entry` = 4438, `version` = 3494 WHERE (`entry` = 4438);
-- Quicksilver Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5008);
UPDATE `applied_item_updates` SET `entry` = 5008, `version` = 3494 WHERE (`entry` = 5008);
-- Guillotine Axe
-- dmg_min1, from 19.0 to 35
-- dmg_max1, from 37.0 to 53
UPDATE `item_template` SET `dmg_min1` = 35, `dmg_max1` = 53 WHERE (`entry` = 2807);
UPDATE `applied_item_updates` SET `entry` = 2807, `version` = 3494 WHERE (`entry` = 2807);
-- Polished Scale Leggings
-- required_level, from 22 to 17
-- armor, from 50 to 46
UPDATE `item_template` SET `required_level` = 17, `armor` = 46 WHERE (`entry` = 2152);
UPDATE `applied_item_updates` SET `entry` = 2152, `version` = 3494 WHERE (`entry` = 2152);
-- Small Shot Pouch
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5441);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5441, 3494);
-- Moonsight Rifle
-- required_level, from 24 to 19
-- dmg_min1, from 21.0 to 14
-- dmg_max1, from 40.0 to 21
UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 14, `dmg_max1` = 21 WHERE (`entry` = 4383);
UPDATE `applied_item_updates` SET `entry` = 4383, `version` = 3494 WHERE (`entry` = 4383);
-- Moonsteel Broadsword
-- required_level, from 31 to 26
-- stat_value1, from 6 to 7
-- stat_value2, from 25 to 35
-- dmg_min1, from 54.0 to 61
-- dmg_max1, from 81.0 to 83
UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 7, `stat_value2` = 35, `dmg_min1` = 61, `dmg_max1` = 83 WHERE (`entry` = 3853);
UPDATE `applied_item_updates` SET `entry` = 3853, `version` = 3494 WHERE (`entry` = 3853);
-- Thunder Ale (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2686);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2686, 3494);
-- Rhapsody Malt (needs effect)
-- spellid_1, from 11007 to 0
UPDATE `item_template` SET `spellid_1` = 0 WHERE (`entry` = 2894);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2894, 3494);
-- Black Bear Hide Vest
-- required_level, from 7 to 2
-- armor, from 25 to 23
UPDATE `item_template` SET `required_level` = 2, `armor` = 23 WHERE (`entry` = 2069);
UPDATE `applied_item_updates` SET `entry` = 2069, `version` = 3494 WHERE (`entry` = 2069);
-- Guardsman Belt
-- required_level, from 19 to 14
-- armor, from 18 to 16
UPDATE `item_template` SET `required_level` = 14, `armor` = 16 WHERE (`entry` = 3429);
UPDATE `applied_item_updates` SET `entry` = 3429, `version` = 3494 WHERE (`entry` = 3429);
-- Rockjaw Blade
-- required_level, from 6 to 1
-- dmg_min1, from 6.0 to 11
-- dmg_max1, from 11.0 to 17
UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 2065);
UPDATE `applied_item_updates` SET `entry` = 2065, `version` = 3494 WHERE (`entry` = 2065);
-- Stout Maul
-- dmg_min1, from 33.0 to 41
-- dmg_max1, from 50.0 to 57
UPDATE `item_template` SET `dmg_min1` = 41, `dmg_max1` = 57 WHERE (`entry` = 924);
UPDATE `applied_item_updates` SET `entry` = 924, `version` = 3494 WHERE (`entry` = 924);
-- Beerstained Gloves
-- required_level, from 15 to 10
-- stat_type1, from 7 to 6
-- stat_value1, from 1 to 2
-- armor, from 10 to 9
UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 6, `stat_value1` = 2, `armor` = 9 WHERE (`entry` = 3565);
UPDATE `applied_item_updates` SET `entry` = 3565, `version` = 3494 WHERE (`entry` = 3565);
-- Canvas Bracers
-- required_level, from 14 to 9
-- armor, from 6 to 5
UPDATE `item_template` SET `required_level` = 9, `armor` = 5 WHERE (`entry` = 3377);
UPDATE `applied_item_updates` SET `entry` = 3377, `version` = 3494 WHERE (`entry` = 3377);
-- Deadly Stiletto
-- dmg_min1, from 26.0 to 37
-- dmg_max1, from 49.0 to 57
UPDATE `item_template` SET `dmg_min1` = 37, `dmg_max1` = 57 WHERE (`entry` = 2534);
UPDATE `applied_item_updates` SET `entry` = 2534, `version` = 3494 WHERE (`entry` = 2534);
-- Flash Rifle
-- required_level, from 32 to 27
-- dmg_min1, from 32.0 to 20
-- dmg_max1, from 60.0 to 31
UPDATE `item_template` SET `required_level` = 27, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 4086);
UPDATE `applied_item_updates` SET `entry` = 4086, `version` = 3494 WHERE (`entry` = 4086);
-- Deepwood Bracers
-- holy_res, from 0 to 1
UPDATE `item_template` SET `holy_res` = 1 WHERE (`entry` = 3204);
UPDATE `applied_item_updates` SET `entry` = 3204, `version` = 3494 WHERE (`entry` = 3204);
-- Thick War Axe
-- required_level, from 12 to 7
-- dmg_min1, from 12.0 to 26
-- dmg_max1, from 24.0 to 39
UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 26, `dmg_max1` = 39 WHERE (`entry` = 3489);
UPDATE `applied_item_updates` SET `entry` = 3489, `version` = 3494 WHERE (`entry` = 3489);
-- Frost Metal Pauldrons
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4123);
UPDATE `applied_item_updates` SET `entry` = 4123, `version` = 3494 WHERE (`entry` = 4123);
-- Shadowhide Maul
-- required_level, from 18 to 13
-- stat_value1, from 1 to 3
-- dmg_min1, from 32.0 to 44
-- dmg_max1, from 49.0 to 60
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 3, `dmg_min1` = 44, `dmg_max1` = 60 WHERE (`entry` = 1458);
UPDATE `applied_item_updates` SET `entry` = 1458, `version` = 3494 WHERE (`entry` = 1458);
-- Guardian Belt
-- required_level, from 29 to 24
-- stat_type1, from 5 to 3
-- stat_value1, from 2 to 3
-- armor, from 22 to 20
UPDATE `item_template` SET `required_level` = 24, `stat_type1` = 3, `stat_value1` = 3, `armor` = 20 WHERE (`entry` = 4258);
UPDATE `applied_item_updates` SET `entry` = 4258, `version` = 3494 WHERE (`entry` = 4258);
-- Spider Belt
-- required_level, from 31 to 26
-- stat_value1, from 25 to 55
-- armor, from 12 to 10
-- spellid_1, from 9774 to 0
UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 55, `armor` = 10, `spellid_1` = 0 WHERE (`entry` = 4328);
UPDATE `applied_item_updates` SET `entry` = 4328, `version` = 3494 WHERE (`entry` = 4328);
-- Small Quiver
-- spellid_1, from 14824 to 0
-- spelltrigger_1, from 1 to 0
UPDATE `item_template` SET `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 5439);
UPDATE `applied_item_updates` SET `entry` = 5439, `version` = 3494 WHERE (`entry` = 5439);
-- Bronze Axe
-- display_id, from 8496 to 8474
-- required_level, from 20 to 13
-- dmg_min1, from 13.0 to 24
-- dmg_max1, from 25.0 to 36
UPDATE `item_template` SET `display_id` = 8474, `required_level` = 13, `dmg_min1` = 24, `dmg_max1` = 36 WHERE (`entry` = 2849);
UPDATE `applied_item_updates` SET `entry` = 2849, `version` = 3494 WHERE (`entry` = 2849);
-- Training Sword
-- required_level, from 7 to 2
-- dmg_min1, from 18.0 to 28
-- dmg_max1, from 27.0 to 38
UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 28, `dmg_max1` = 38 WHERE (`entry` = 3192);
UPDATE `applied_item_updates` SET `entry` = 3192, `version` = 3494 WHERE (`entry` = 3192);
-- Worn Mail Belt
-- required_level, from 7 to 2
-- armor, from 12 to 11
UPDATE `item_template` SET `required_level` = 2, `armor` = 11 WHERE (`entry` = 1730);
UPDATE `applied_item_updates` SET `entry` = 1730, `version` = 3494 WHERE (`entry` = 1730);
-- Blackwater Cutlass
-- required_level, from 14 to 9
-- dmg_min1, from 10.0 to 23
-- dmg_max1, from 20.0 to 29
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 23, `dmg_max1` = 29 WHERE (`entry` = 1951);
UPDATE `applied_item_updates` SET `entry` = 1951, `version` = 3494 WHERE (`entry` = 1951);
-- Burnished Buckler
-- required_level, from 15 to 10
-- stat_type1, from 3 to 6
-- armor, from 49 to 39
UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 6, `armor` = 39 WHERE (`entry` = 6380);
UPDATE `applied_item_updates` SET `entry` = 6380, `version` = 3494 WHERE (`entry` = 6380);
-- Seedcloud Buckler
-- stat_type1, from 6 to 3
-- armor, from 62 to 52
-- nature_res, from 0 to 1
UPDATE `item_template` SET `stat_type1` = 3, `armor` = 52, `nature_res` = 1 WHERE (`entry` = 6630);
UPDATE `applied_item_updates` SET `entry` = 6630, `version` = 3494 WHERE (`entry` = 6630);
-- Darkweave Boots
-- required_level, from 30 to 25
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 2
-- stat_value2, from 10 to 30
-- armor, from 16 to 15
UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 6, `stat_value1` = 2, `stat_value2` = 30, `armor` = 15 WHERE (`entry` = 6406);
UPDATE `applied_item_updates` SET `entry` = 6406, `version` = 3494 WHERE (`entry` = 6406);
-- Smoldering Boots
-- required_level, from 18 to 13
-- stat_value1, from 1 to 2
-- armor, from 14 to 12
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 2, `armor` = 12 WHERE (`entry` = 3076);
UPDATE `applied_item_updates` SET `entry` = 3076, `version` = 3494 WHERE (`entry` = 3076);
-- Inscribed Gold Ring
-- max_count, from 1 to 0
UPDATE `item_template` SET `max_count` = 0 WHERE (`entry` = 5010);
UPDATE `applied_item_updates` SET `entry` = 5010, `version` = 3494 WHERE (`entry` = 5010);
-- Augmented Chain Leggings
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- armor, from 64 to 58
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `armor` = 58 WHERE (`entry` = 2418);
UPDATE `applied_item_updates` SET `entry` = 2418, `version` = 3494 WHERE (`entry` = 2418);
-- Mail Combat Belt
-- required_level, from 32 to 27
-- armor, from 35 to 32
UPDATE `item_template` SET `required_level` = 27, `armor` = 32 WHERE (`entry` = 4717);
UPDATE `applied_item_updates` SET `entry` = 4717, `version` = 3494 WHERE (`entry` = 4717);
-- Cape of the Crusader
-- frost_res, from 0 to 1
UPDATE `item_template` SET `frost_res` = 1 WHERE (`entry` = 4643);
UPDATE `applied_item_updates` SET `entry` = 4643, `version` = 3494 WHERE (`entry` = 4643);
-- Sylvan Cloak
-- required_level, from 19 to 14
-- stat_type1, from 1 to 7
-- stat_value1, from 8 to 1
-- armor, from 15 to 14
UPDATE `item_template` SET `required_level` = 14, `stat_type1` = 7, `stat_value1` = 1, `armor` = 14 WHERE (`entry` = 4793);
UPDATE `applied_item_updates` SET `entry` = 4793, `version` = 3494 WHERE (`entry` = 4793);
-- Massive Iron Axe
-- required_level, from 32 to 27
-- stat_value1, from 4 to 5
-- stat_value2, from 5 to 6
-- dmg_min1, from 71.0 to 80
-- dmg_max1, from 107.0 to 109
UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5, `stat_value2` = 6, `dmg_min1` = 80, `dmg_max1` = 109 WHERE (`entry` = 3855);
UPDATE `applied_item_updates` SET `entry` = 3855, `version` = 3494 WHERE (`entry` = 3855);
-- Beastial Manacles
-- buy_price, from 5001 to 4828
-- sell_price, from 1000 to 965
-- required_level, from 22 to 17
-- stat_type1, from 1 to 6
-- stat_value1, from 10 to 1
-- armor, from 32 to 29
UPDATE `item_template` SET `buy_price` = 4828, `sell_price` = 965, `required_level` = 17, `stat_type1` = 6, `stat_value1` = 1, `armor` = 29 WHERE (`entry` = 6722);
UPDATE `applied_item_updates` SET `entry` = 6722, `version` = 3494 WHERE (`entry` = 6722);
-- Studded Leather Belt
-- name, from Studded Belt to Studded Leather Belt
-- required_level, from 32 to 27
-- stat_value1, from 15 to 30
-- armor, from 21 to 19
UPDATE `item_template` SET `name` = 'Studded Leather Belt', `required_level` = 27, `stat_value1` = 30, `armor` = 19 WHERE (`entry` = 2464);
UPDATE `applied_item_updates` SET `entry` = 2464, `version` = 3494 WHERE (`entry` = 2464);
-- Mo'grosh Toothpick
-- required_level, from 13 to 8
-- dmg_min1, from 23.0 to 35
-- dmg_max1, from 35.0 to 48
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 35, `dmg_max1` = 48 WHERE (`entry` = 2822);
UPDATE `applied_item_updates` SET `entry` = 2822, `version` = 3494 WHERE (`entry` = 2822);
-- Captain's Armor
-- name, from Avenger's Armor to Captain's Armor
-- stat_value1, from 4 to 7
-- stat_value2, from 30 to 35
-- armor, from 70 to 64
UPDATE `item_template` SET `name` = 'Captain\'s Armor', `stat_value1` = 7, `stat_value2` = 35, `armor` = 64 WHERE (`entry` = 1488);
UPDATE `applied_item_updates` SET `entry` = 1488, `version` = 3494 WHERE (`entry` = 1488);
-- Black Metal Axe
-- required_level, from 19 to 14
-- dmg_min1, from 15.0 to 27
-- dmg_max1, from 29.0 to 41
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 27, `dmg_max1` = 41 WHERE (`entry` = 885);
UPDATE `applied_item_updates` SET `entry` = 885, `version` = 3494 WHERE (`entry` = 885);
-- Slaghammer
-- stat_value1, from 3 to 4
-- stat_value2, from 5 to 4
-- dmg_min1, from 42.0 to 49
-- dmg_max1, from 64.0 to 67
UPDATE `item_template` SET `stat_value1` = 4, `stat_value2` = 4, `dmg_min1` = 49, `dmg_max1` = 67 WHERE (`entry` = 1976);
UPDATE `applied_item_updates` SET `entry` = 1976, `version` = 3494 WHERE (`entry` = 1976);
-- Bolt of Wool Cloth
-- name, from Bolt of Woolen Cloth to Bolt of Wool Cloth
UPDATE `item_template` SET `name` = 'Bolt of Wool Cloth' WHERE (`entry` = 2997);
UPDATE `applied_item_updates` SET `entry` = 2997, `version` = 3494 WHERE (`entry` = 2997);
-- Assassin's Blade
-- dmg_min1, from 14.0 to 25
-- dmg_max1, from 27.0 to 39
UPDATE `item_template` SET `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 1935);
UPDATE `applied_item_updates` SET `entry` = 1935, `version` = 3494 WHERE (`entry` = 1935);
-- Foamspittle Staff
-- required_level, from 12 to 7
-- stat_value1, from 1 to 2
-- dmg_min1, from 25.0 to 38
-- dmg_max1, from 38.0 to 53
UPDATE `item_template` SET `required_level` = 7, `stat_value1` = 2, `dmg_min1` = 38, `dmg_max1` = 53 WHERE (`entry` = 1405);
UPDATE `applied_item_updates` SET `entry` = 1405, `version` = 3494 WHERE (`entry` = 1405);
-- Tough Leather Belt
-- name, from Rawhide Belt to Tough Leather Belt
-- required_level, from 19 to 14
-- armor, from 11 to 10
UPDATE `item_template` SET `name` = 'Tough Leather Belt', `required_level` = 14, `armor` = 10 WHERE (`entry` = 1795);
UPDATE `applied_item_updates` SET `entry` = 1795, `version` = 3494 WHERE (`entry` = 1795);
-- Laced Mail Pants
-- required_level, from 14 to 9
-- armor, from 30 to 27
UPDATE `item_template` SET `required_level` = 9, `armor` = 27 WHERE (`entry` = 1743);
UPDATE `applied_item_updates` SET `entry` = 1743, `version` = 3494 WHERE (`entry` = 1743);
-- Rawhide Belt
-- name, from Patched Leather Belt to Rawhide Belt
-- required_level, from 13 to 8
-- armor, from 10 to 9
UPDATE `item_template` SET `name` = 'Rawhide Belt', `required_level` = 8, `armor` = 9 WHERE (`entry` = 1787);
UPDATE `applied_item_updates` SET `entry` = 1787, `version` = 3494 WHERE (`entry` = 1787);
-- Owl's Disk
-- required_level, from 18 to 13
-- stat_value1, from 1 to 3
-- armor, from 54 to 43
UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 3, `armor` = 43 WHERE (`entry` = 4822);
UPDATE `applied_item_updates` SET `entry` = 4822, `version` = 3494 WHERE (`entry` = 4822);
-- Large Bore Blunderbuss
-- dmg_min1, from 19.0 to 15
-- dmg_max1, from 36.0 to 23
UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 3023);
UPDATE `applied_item_updates` SET `entry` = 3023, `version` = 3494 WHERE (`entry` = 3023);
-- Staff of the Shade
-- dmg_min1, from 36.0 to 44
-- dmg_max1, from 55.0 to 60
-- shadow_res, from 0 to 1
UPDATE `item_template` SET `dmg_min1` = 44, `dmg_max1` = 60, `shadow_res` = 1 WHERE (`entry` = 2549);
UPDATE `applied_item_updates` SET `entry` = 2549, `version` = 3494 WHERE (`entry` = 2549);
-- Barbaric Belt
-- required_level, from 35 to 30
-- armor, from 25 to 23
-- spellid_1, from 9174 to 0
-- spellcategory_1, from 28 to 0
UPDATE `item_template` SET `required_level` = 30, `armor` = 23, `spellid_1` = 0, `spellcategory_1` = 0 WHERE (`entry` = 4264);
UPDATE `applied_item_updates` SET `entry` = 4264, `version` = 3494 WHERE (`entry` = 4264);
-- Dirty Blunderbuss
-- required_level, from 15 to 8
-- dmg_min1, from 10.0 to 8
-- dmg_max1, from 19.0 to 13
UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 2781);
UPDATE `applied_item_updates` SET `entry` = 2781, `version` = 3494 WHERE (`entry` = 2781);
-- Claymore of the Martyr
-- stat_value1, from 3 to 5
-- dmg_min1, from 34.0 to 46
-- dmg_max1, from 52.0 to 62
UPDATE `item_template` SET `stat_value1` = 5, `dmg_min1` = 46, `dmg_max1` = 62 WHERE (`entry` = 2877);
UPDATE `applied_item_updates` SET `entry` = 2877, `version` = 3494 WHERE (`entry` = 2877);
-- Whirlwind Axe
-- stat_value2, from 30 to 40
-- dmg_min1, from 89.0 to 98
-- dmg_max1, from 134.0 to 133
UPDATE `item_template` SET `stat_value2` = 40, `dmg_min1` = 98, `dmg_max1` = 133 WHERE (`entry` = 6975);
UPDATE `applied_item_updates` SET `entry` = 6975, `version` = 3494 WHERE (`entry` = 6975);
-- Mail Combat Spaulders
-- required_level, from 31 to 26
-- armor, from 58 to 53
UPDATE `item_template` SET `required_level` = 26, `armor` = 53 WHERE (`entry` = 6404);
UPDATE `applied_item_updates` SET `entry` = 6404, `version` = 3494 WHERE (`entry` = 6404);
-- Light Hunting Bow
-- required_level, from 16 to 9
-- dmg_min1, from 8.0 to 6
-- dmg_max1, from 15.0 to 10
UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 2780);
UPDATE `applied_item_updates` SET `entry` = 2780, `version` = 3494 WHERE (`entry` = 2780);
-- Ringed Helm
-- required_level, from 25 to 20
-- stat_value1, from 3 to 5
-- armor, from 29 to 26
UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 5, `armor` = 26 WHERE (`entry` = 3392);
UPDATE `applied_item_updates` SET `entry` = 3392, `version` = 3494 WHERE (`entry` = 3392);
-- Deviate Scale Gloves
-- required_level, from 16 to 11
-- stat_type1, from 5 to 6
-- stat_value1, from 1 to 2
-- armor, from 21 to 19
UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 6, `stat_value1` = 2, `armor` = 19 WHERE (`entry` = 6467);
UPDATE `applied_item_updates` SET `entry` = 6467, `version` = 3494 WHERE (`entry` = 6467);
-- Wolfclaw Gloves
-- stat_value1, from 2 to 3
-- stat_value2, from 2 to 4
-- armor, from 25 to 23
UPDATE `item_template` SET `stat_value1` = 3, `stat_value2` = 4, `armor` = 23 WHERE (`entry` = 1978);
UPDATE `applied_item_updates` SET `entry` = 1978, `version` = 3494 WHERE (`entry` = 1978);
-- Brightweave Gloves
-- required_level, from 35 to 30
-- stat_value2, from 35 to 40
-- armor, from 16 to 15
UPDATE `item_template` SET `required_level` = 30, `stat_value2` = 40, `armor` = 15 WHERE (`entry` = 4042);
UPDATE `applied_item_updates` SET `entry` = 4042, `version` = 3494 WHERE (`entry` = 4042);
-- Bluegill Kukri
-- required_level, from 19 to 14
-- dmg_min1, from 20.0 to 36
-- dmg_max1, from 39.0 to 55
UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 36, `dmg_max1` = 55 WHERE (`entry` = 2046);
UPDATE `applied_item_updates` SET `entry` = 2046, `version` = 3494 WHERE (`entry` = 2046);
-- Brashclaw's Zweihander
-- required_level, from 12 to 7
-- stat_value1, from 1 to 2
-- dmg_min1, from 25.0 to 38
-- dmg_max1, from 38.0 to 53
UPDATE `item_template` SET `required_level` = 7, `stat_value1` = 2, `dmg_min1` = 38, `dmg_max1` = 53 WHERE (`entry` = 2204);
UPDATE `applied_item_updates` SET `entry` = 2204, `version` = 3494 WHERE (`entry` = 2204);
-- 3810

-- Jackseed Belt
-- stat_type1, from 5 to 0
-- armor, from 16 to 14
-- max_durability, from 18 to 0
UPDATE `item_template` SET `stat_type1` = 0, `armor` = 14, `max_durability` = 0 WHERE (`entry` = 10820);
UPDATE `applied_item_updates` SET `entry` = 10820, `version` = 3810 WHERE (`entry` = 10820);
-- Cadet Cloak
-- armor, from 10 to 49
UPDATE `item_template` SET `armor` = 49 WHERE (`entry` = 9761);
UPDATE `applied_item_updates` SET `entry` = 9761, `version` = 3810 WHERE (`entry` = 9761);
-- Cauldron Stirrer
-- required_level, from 10 to 0
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `required_level` = 0, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 5340);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5340, 3810);
-- Jester's Shoes
-- name, from Simple Shoes to Jester's Shoes
-- armor, from 15 to 16
-- max_durability, from 25 to 0
UPDATE `item_template` SET `name` = 'Jester\'s Shoes', `armor` = 16, `max_durability` = 0 WHERE (`entry` = 9743);
UPDATE `applied_item_updates` SET `entry` = 9743, `version` = 3810 WHERE (`entry` = 9743);
-- Cadet Gauntlets
-- armor, from 77 to 45
-- max_durability, from 20 to 0
UPDATE `item_template` SET `armor` = 45, `max_durability` = 0 WHERE (`entry` = 9762);
UPDATE `applied_item_updates` SET `entry` = 9762, `version` = 3810 WHERE (`entry` = 9762);
-- Nomadic Gloves
-- armor, from 21 to 8
-- max_durability, from 16 to 0
UPDATE `item_template` SET `armor` = 8, `max_durability` = 0 WHERE (`entry` = 10636);
UPDATE `applied_item_updates` SET `entry` = 10636, `version` = 3810 WHERE (`entry` = 10636);
-- Really Sticky Glue
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 4941);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4941, 3810);
-- Painted Chain Leggings
-- armor, from 58 to 21
-- max_durability, from 40 to 0
UPDATE `item_template` SET `armor` = 21, `max_durability` = 0 WHERE (`entry` = 10635);
UPDATE `applied_item_updates` SET `entry` = 10635, `version` = 3810 WHERE (`entry` = 10635);
-- Sun-beaten Cloak
-- required_level, from 3 to 0
-- armor, from 20 to 33
UPDATE `item_template` SET `required_level` = 0, `armor` = 33 WHERE (`entry` = 4958);
UPDATE `applied_item_updates` SET `entry` = 4958, `version` = 3810 WHERE (`entry` = 4958);
-- Cauldron Stirrer
-- required_level, from 10 to 0
-- stat_type1, from 0 to 6
-- stat_value1, from 0 to 1
UPDATE `item_template` SET `required_level` = 0, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 5340);
UPDATE `applied_item_updates` SET `entry` = 5340, `version` = 3810 WHERE (`entry` = 5340);
-- Rambling Boots
-- armor, from 51 to 52
-- max_durability, from 35 to 0
UPDATE `item_template` SET `armor` = 52, `max_durability` = 0 WHERE (`entry` = 11853);
UPDATE `applied_item_updates` SET `entry` = 11853, `version` = 3810 WHERE (`entry` = 11853);
-- Trapper's Shirt
-- flags, from 16 to 0
UPDATE `item_template` SET `flags` = 0 WHERE (`entry` = 6130);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6130, 3810);
-- Trapper's Pants
-- flags, from 16 to 0
-- max_durability, from 25 to 0
UPDATE `item_template` SET `flags` = 0, `max_durability` = 0 WHERE (`entry` = 6131);
UPDATE `applied_item_updates` SET `entry` = 6131, `version` = 3810 WHERE (`entry` = 6131);
-- Roamer's Leggings
-- max_durability, from 40 to 0
UPDATE `item_template` SET `max_durability` = 0 WHERE (`entry` = 11852);
UPDATE `applied_item_updates` SET `entry` = 11852, `version` = 3810 WHERE (`entry` = 11852);
-- Rustmetal Bracers
-- max_durability, from 18 to 0
UPDATE `item_template` SET `max_durability` = 0 WHERE (`entry` = 11849);
UPDATE `applied_item_updates` SET `entry` = 11849, `version` = 3810 WHERE (`entry` = 11849);
-- Bandit Shoulders
-- armor, from 58 to 73
-- max_durability, from 45 to 0
UPDATE `item_template` SET `armor` = 73, `max_durability` = 0 WHERE (`entry` = 10405);
UPDATE `applied_item_updates` SET `entry` = 10405, `version` = 3810 WHERE (`entry` = 10405);
-- Cadet Bracers
-- armor, from 51 to 37
-- max_durability, from 20 to 0
UPDATE `item_template` SET `armor` = 37, `max_durability` = 0 WHERE (`entry` = 9760);
UPDATE `applied_item_updates` SET `entry` = 9760, `version` = 3810 WHERE (`entry` = 9760);
-- Hunting Rifle
-- max_durability, from 30 to 0
UPDATE `item_template` SET `max_durability` = 0 WHERE (`entry` = 8181);
REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (8181, 3810);
-- Apothecary Gloves
-- stat_value2, from 2 to 0
-- armor, from 20 to 23
-- max_durability, from 20 to 0
UPDATE `item_template` SET `stat_value2` = 0, `armor` = 23, `max_durability` = 0 WHERE (`entry` = 10919);
UPDATE `applied_item_updates` SET `entry` = 10919, `version` = 3810 WHERE (`entry` = 10919);
-- Acolyte's Shoes
-- required_level, from 1 to 0
UPDATE `item_template` SET `required_level` = 0 WHERE (`entry` = 59);
UPDATE `applied_item_updates` SET `entry` = 59, `version` = 3810 WHERE (`entry` = 59);
-- Scavenger Tunic
-- armor, from 33 to 15
-- max_durability, from 45 to 0
UPDATE `item_template` SET `armor` = 15, `max_durability` = 0 WHERE (`entry` = 11851);
UPDATE `applied_item_updates` SET `entry` = 11851, `version` = 3810 WHERE (`entry` = 11851);
-- Flax Belt
-- max_durability, from 14 to 0
UPDATE `item_template` SET `max_durability` = 0 WHERE (`entry` = 11848);
UPDATE `applied_item_updates` SET `entry` = 11848, `version` = 3810 WHERE (`entry` = 11848);
-- Scarlet Initiate Robes
-- max_durability, from 35 to 0
UPDATE `item_template` SET `max_durability` = 0 WHERE (`entry` = 3260);
UPDATE `applied_item_updates` SET `entry` = 3260, `version` = 3810 WHERE (`entry` = 3260);

-- Set all rings to unique. https://github.com/The-Alpha-Project/alpha-core/pull/1345
UPDATE `item_template` set `max_count` = 1 where `inventory_type` = 11;