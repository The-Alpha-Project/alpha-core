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
        CREATE TABLE `npc_trainer_alpha` (
            `template_entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `spellcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `spellpointcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `reqskill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
            `reqskillvalue` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
            `reqlevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
            UNIQUE INDEX `entry_spell` (`template_entry`, `spell`) USING BTREE,
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB;

        CREATE TABLE `spell_chain` (
            `spell_id` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `prev_spell` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
            `first_spell` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
            `rank` TINYINT(3) UNSIGNED NULL DEFAULT '0',
            `req_spell` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
            PRIMARY KEY (`spell_id`) USING BTREE
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB;

        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 100, 50, 0, 0, 0, 4);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 1715, 200, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 6178, 9000, 0, 0, 0, 26);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 7372, 11000, 0, 0, 0, 32);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 7373, 44000, 0, 0, 0, 54);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 7384, 800, 0, 0, 0, 12);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (1, 7887, 11000, 0, 0, 0, 28);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 639, 100, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 647, 1200, 0, 0, 0, 14);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 649, 10, 0, 0, 0, 4);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 678, 200, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 679, 10, 0, 0, 0, 1);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 680, 7100, 0, 0, 0, 24);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 1026, 4200, 0, 0, 0, 22);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 1042, 7800, 0, 0, 0, 30);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 1866, 1800, 0, 0, 0, 16);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 2495, 15000, 0, 0, 0, 32);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 2812, 16000, 0, 0, 0, 40);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 5606, 200, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (2, 5609, 7100, 0, 0, 0, 16);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 172, 100, 0, 0, 0, 4);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 710, 5000, 0, 0, 0, 28);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 980, 200, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 1014, 2900, 0, 0, 0, 18);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 6217, 5000, 0, 0, 0, 28);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 6222, 900, 0, 0, 0, 14);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 6223, 5000, 0, 0, 0, 24);
        INSERT INTO `npc_trainer_alpha` (`template_entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (3, 7648, 1100, 0, 0, 0, 34);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (100, 0, 100, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7384, 0, 7384, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2812, 0, 2812, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1719, 0, 1719, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1715, 0, 1715, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (980, 0, 980, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (710, 0, 710, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (679, 0, 679, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (421, 0, 421, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (172, 0, 172, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (649, 0, 649, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (635, 0, 635, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7372, 1715, 1715, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6222, 172, 172, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6178, 0, 100, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5606, 649, 649, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (678, 679, 679, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7887, 7384, 7384, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1014, 980, 980, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (639, 635, 635, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1866, 678, 679, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7373, 7372, 1715, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (647, 639, 635, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6223, 6222, 172, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6217, 1014, 980, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5609, 5606, 649, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1026, 647, 635, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (680, 1866, 679, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (7648, 6223, 172, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2495, 680, 679, 5, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1042, 1026, 635, 5, 0);

        UPDATE `creature_template` SET `trainer_id` = 1 WHERE `entry` = 911
        UPDATE `creature_template` SET `trainer_id` = 2 WHERE `entry` = 925
        UPDATE `creature_template` SET `trainer_id` = 3 WHERE `entry` = 459

		insert into applied_updates values ('270520211');
    end if;
	
end $
delimiter ;