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
            `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `spell` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
            `spellcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `spellpointcost` INT(10) UNSIGNED NOT NULL DEFAULT '0',
            `reqskill` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
            `reqskillvalue` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
            `reqlevel` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
            UNIQUE INDEX `entry_spell` (`entry`, `spell`) USING BTREE,
            CONSTRAINT `trainer_alpha_entry` FOREIGN KEY (`entry`) REFERENCES `alpha_world`.`creature_template` (`entry`) ON UPDATE CASCADE ON DELETE CASCADE
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

        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (911, 100, 50, 0, 0, 0, 4);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (911, 6178, 9000, 0, 0, 0, 26);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 639, 100, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 647, 1200, 0, 0, 0, 14);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 649, 10, 0, 0, 0, 4);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 678, 200, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 679, 10, 0, 0, 0, 1);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 680, 7100, 0, 0, 0, 24);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 1026, 4200, 0, 0, 0, 22);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 1042, 7800, 0, 0, 0, 30);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 1866, 1800, 0, 0, 0, 16);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 2495, 15000, 0, 0, 0, 32);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 2812, 16000, 0, 0, 0, 40);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 5606, 200, 0, 0, 0, 8);
        INSERT INTO `npc_trainer_alpha` (`entry`, `spell`, `spellcost`, `spellpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES (925, 5609, 7100, 0, 0, 0, 16);

        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (100, 0, 100, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (635, 0, 635, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (639, 635, 635, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (647, 639, 635, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (649, 0, 649, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (678, 679, 679, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (679, 0, 679, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (680, 1866, 679, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1026, 647, 635, 4, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1042, 1026, 635, 5, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (1866, 678, 679, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2495, 680, 679, 5, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (2812, 0, 2812, 1, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5606, 649, 649, 2, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (5609, 5606, 649, 3, 0);
        INSERT INTO `spell_chain` (`spell_id`, `prev_spell`, `first_spell`, `rank`, `req_spell`) VALUES (6178, 0, 100, 2, 0);

		insert into applied_updates values ('270520211');
    end if;
	
end $
delimiter ;