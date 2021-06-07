delimiter $
begin not atomic
    -- 13/05/2021 2
    if (select count(*) from applied_updates where id='130520212') = 0 then
        -- Fix damage and armor of starting mobs.
        UPDATE `creature_template` SET `dmg_min` = 1, `dmg_max` = 2, `armor` = 16 WHERE `entry` IN (6, 707, 1512, 2955, 3098);
        UPDATE `creature_template` SET `dmg_min` = 1, `dmg_max` = 2, `armor` = 15 WHERE `entry` = 1501;

        insert into applied_updates values ('130520212');
    end if;

    -- 27/05/2021 1
	if (select count(*) from applied_updates where id='270520211') = 0 then
        DROP TABLE IF EXISTS `npc_trainer`;
        CREATE TABLE IF NOT EXISTS `npc_trainer` (
            `template_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `spellcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `talentpointcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `skillpointcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `reqskill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
            `reqskillvalue` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
            `reqlevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
            UNIQUE INDEX `template_entry_spell` (`template_entry`, `spell`) USING BTREE
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB
        ;

        DROP TABLE IF EXISTS `spell_chain`;
        CREATE TABLE IF NOT EXISTS `spell_chain` (
            `spell_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `prev_spell` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
            `first_spell` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
            `rank` TINYINT(3) UNSIGNED NULL DEFAULT '0',
            `req_spell` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
            PRIMARY KEY (`spell_id`) USING BTREE
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB;

        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (10, 100, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (10, 1715, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 639, 100, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 649, 10, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 678, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 679, 10, 0, 0, 0, 0, 1);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 1022, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 3127, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (11, 5606, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 53, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 921, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 1757, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 1776, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 1784, 10, 0, 0, 0, 0, 1);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 5277, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (13, 6760, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (14, 17, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (14, 139, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (14, 589, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (14, 591, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (14, 1243, 10, 0, 0, 0, 0, 1);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (14, 2052, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (16, 324, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (16, 529, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 116, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 118, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 143, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 205, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 587, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 1459, 10, 0, 0, 0, 0, 1);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 2136, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 5143, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (17, 5504, 50, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (18, 172, 100, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (18, 980, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (20, 339, 200, 0, 0, 0, 0, 8);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (20, 467, 100, 0, 0, 0, 0, 6);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (20, 774, 80, 0, 0, 0, 0, 4);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (20, 1126, 10, 0, 0, 0, 0, 1);
        INSERT INTO `npc_trainer` (`template_entry`, `spell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (20, 5176, 100, 0, 0, 0, 0, 6);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2098, 0, 2098, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1022, 0, 1022, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5176, 0, 5176, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (980, 0, 980, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (921, 0, 921, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (774, 0, 774, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (710, 0, 710, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5504, 0, 5504, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (679, 0, 679, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5143, 0, 5143, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (3127, 0, 3127, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2812, 0, 2812, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1784, 0, 1784, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1776, 0, 1776, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2136, 0, 2136, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1752, 0, 1752, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1715, 0, 1715, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1459, 0, 1459, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1243, 0, 1243, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1126, 0, 1126, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1719, 0, 1719, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (649, 0, 649, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (17, 0, 17, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (324, 0, 324, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (589, 0, 589, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (172, 0, 172, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7384, 0, 7384, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (139, 0, 139, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (118, 0, 118, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (116, 0, 116, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (100, 0, 100, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (53, 0, 53, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (339, 0, 339, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (403, 0, 403, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (421, 0, 421, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (467, 0, 467, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (587, 0, 587, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (635, 0, 635, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5277, 0, 5277, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7887, 7384, 7384, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6760, 2098, 2098, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5606, 649, 649, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6222, 172, 172, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7372, 1715, 1715, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6178, 100, 100, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2052, 2050, 2050, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (639, 635, 635, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (591, 585, 585, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (678, 679, 679, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (782, 467, 467, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1014, 980, 980, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (205, 116, 116, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1757, 1752, 1752, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (529, 403, 403, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (143, 133, 133, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6223, 6222, 172, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7373, 7372, 1715, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1866, 678, 679, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (647, 639, 635, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5609, 5606, 649, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1075, 782, 467, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6217, 1014, 980, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (680, 1866, 679, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1026, 647, 635, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7648, 6223, 172, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2495, 680, 679, 5, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1042, 1026, 635, 5, 0);

        UPDATE `creature_template` SET `trainer_id` = 10 WHERE `entry` = 911;
        UPDATE `creature_template` SET `trainer_id` = 10 WHERE `entry` = 912;
        UPDATE `creature_template` SET `trainer_id` = 10 WHERE `entry` = 2119;
        UPDATE `creature_template` SET `trainer_id` = 10 WHERE `entry` = 3059;
        UPDATE `creature_template` SET `trainer_id` = 10 WHERE `entry` = 3153;
        UPDATE `creature_template` SET `trainer_id` = 10 WHERE `entry` = 3593;
        UPDATE `creature_template` SET `trainer_id` = 11 WHERE `entry` = 925;
        UPDATE `creature_template` SET `trainer_id` = 11 WHERE `entry` = 926;
        UPDATE `creature_template` SET `trainer_id` = 13 WHERE `entry` = 915;
        UPDATE `creature_template` SET `trainer_id` = 13 WHERE `entry` = 916;
        UPDATE `creature_template` SET `trainer_id` = 13 WHERE `entry` = 2122;
        UPDATE `creature_template` SET `trainer_id` = 13 WHERE `entry` = 3155;
        UPDATE `creature_template` SET `trainer_id` = 13 WHERE `entry` = 3594;
        UPDATE `creature_template` SET `trainer_id` = 14 WHERE `entry` = 375;
        UPDATE `creature_template` SET `trainer_id` = 14 WHERE `entry` = 837;
        UPDATE `creature_template` SET `trainer_id` = 14 WHERE `entry` = 2123;
        UPDATE `creature_template` SET `trainer_id` = 14 WHERE `entry` = 3707;
        UPDATE `creature_template` SET `trainer_id` = 17 WHERE `entry` = 198;
        UPDATE `creature_template` SET `trainer_id` = 17 WHERE `entry` = 944;
        UPDATE `creature_template` SET `trainer_id` = 17 WHERE `entry` = 2124;
        UPDATE `creature_template` SET `trainer_id` = 18 WHERE `entry` = 459;
        UPDATE `creature_template` SET `trainer_id` = 18 WHERE `entry` = 460;
        UPDATE `creature_template` SET `trainer_id` = 18 WHERE `entry` = 2126;
        UPDATE `creature_template` SET `trainer_id` = 18 WHERE `entry` = 3156;
        UPDATE `creature_template` SET `trainer_id` = 20 WHERE `entry` = 3060;
        UPDATE `creature_template` SET `trainer_id` = 20 WHERE `entry` = 3597;

		insert into applied_updates values ('270520211');
    end if;
	
end $
delimiter ;