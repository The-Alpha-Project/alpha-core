delimiter $
begin not atomic
	-- 15/05/2021 1
	if (select count(*) from applied_updates where id='150520211') = 0 then
		DROP TABLE IF EXISTS `character_reputation`;
		CREATE TABLE IF NOT EXISTS `character_reputation` (
		`guid` int(11) unsigned NOT NULL DEFAULT 0,
		`faction` int(11) unsigned NOT NULL DEFAULT 0,
		`standing` int(11) NOT NULL DEFAULT 0,
		`flags` tinyint(1) unsigned NOT NULL DEFAULT 0,
		`index` int(5) NOT NULL,
		PRIMARY KEY (`guid`,`faction`),
		CONSTRAINT `fk_character_reputation_character` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;	
		insert into applied_updates values ('150520211');
    end if;

    -- 17/05/2021 1
	if (select count(*) from applied_updates where id='170520211') = 0 then
        SET FOREIGN_KEY_CHECKS = 0;
        alter table petition change petition_guid item_guid int(11) unsigned not null default 0;
        SET FOREIGN_KEY_CHECKS = 1;

		insert into applied_updates values ('170520211');
    end if;
	
	-- 23/05/2021 1
	if (select count(*) from applied_updates where id='230520211') = 0 then
        DROP TABLE IF EXISTS `character_buttons`;
		CREATE TABLE `character_buttons` (
		`owner` int(11) unsigned NOT NULL DEFAULT 0,
		`index` int(11) unsigned NOT NULL DEFAULT 0,
		`action` int(11) signed NOT NULL DEFAULT 0,
		PRIMARY KEY (`owner`, `action`),
		CONSTRAINT `owner_guid_button_fk` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		insert into applied_updates values ('230520211');
    end if;
	
	-- 29/05/2021 1
	if (select count(*) from applied_updates where id='290520211') = 0 then
		DROP TABLE IF EXISTS `character_spell_book`;
		CREATE TABLE `character_spell_book` (
		`owner` int(11) unsigned NOT NULL DEFAULT 0,
		`index` int(11) signed NOT NULL DEFAULT 0,
		`spell` int(11) unsigned NOT NULL DEFAULT 0,
		PRIMARY KEY (`owner`, `spell`),
		CONSTRAINT `owner_guid_spell_book_fk` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		insert into applied_updates values ('290520211');
    end if;
	
	-- 17/06/2021 1
	if (select count(*) from applied_updates where id='170620211') = 0 then
		ALTER TABLE `characters` 
		ADD COLUMN `explored_areas` LONGTEXT NULL DEFAULT NULL AFTER `taximask`;
		insert into applied_updates values ('170620211');
	end if;

	-- 20/06/2021 1
	if (select count(*) from applied_updates where id='200620211') = 0 then
        DROP TABLE IF EXISTS `character_buttons`;
		CREATE TABLE `character_buttons` (
		`owner` int(11) unsigned NOT NULL DEFAULT 0,
		`index` int(11) unsigned NOT NULL DEFAULT 0,
		`action` int(11) signed NOT NULL DEFAULT 0,
		PRIMARY KEY (`owner`, `index`, `action`),
		CONSTRAINT `owner_guid_button_fk` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		insert into applied_updates values ('200620211');
    end if;

    -- 18/05/2022 1
	if (select count(*) from applied_updates where id='180520221') = 0 then
        ALTER TABLE `character_inventory` 
        ADD COLUMN `duration` INT(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `item_flags`,
        ADD COLUMN `enchantments` MEDIUMTEXT NOT NULL AFTER `duration`;
		insert into applied_updates values ('180520221');
    end if;

    -- 04/04/2022 1
    if (select count(*) from applied_updates where id='040620221') = 0 then
        DROP TABLE IF EXISTS `character_gifts`;
        CREATE TABLE `character_gifts` (
        `guid` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `creator` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Who wrapped the gift. Shoud not cascade delete',
        `item_guid` int(11) unsigned NOT NULL DEFAULT 0,
        `entry` int(11) unsigned NOT NULL DEFAULT 0,
        `flags` int(11) unsigned NOT NULL DEFAULT 0,
        PRIMARY KEY (`guid`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        insert into applied_updates values ('040620221');
    end if;

    -- 07/08/2022 1
    if (select count(*) from applied_updates where id='070820221') = 0 then
        DROP TABLE IF EXISTS `character_pets`;
        CREATE TABLE `character_pets` (
        `pet_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
        `owner` int(11) unsigned NOT NULL DEFAULT 0,
        `creature_id` int(11) unsigned NOT NULL DEFAULT 0,
        `created_by_spell` int(11) unsigned NOT NULL DEFAULT 0,
        `level` int(11) unsigned NOT NULL DEFAULT 0,
        `xp` int(11) unsigned NOT NULL DEFAULT 0,
        `react_state` tinyint(1) unsigned NOT NULL DEFAULT 0,
        `command_state` tinyint(1) unsigned NOT NULL DEFAULT 0,
        `loyalty` int(11) unsigned NOT NULL DEFAULT 0,
        `loyalty_points` int(11) unsigned NOT NULL DEFAULT 0,
        `training_points` int(11) unsigned NOT NULL DEFAULT 0,
        `name` varchar(255) NOT NULL DEFAULT '',
        `renamed` tinyint(1) unsigned NOT NULL DEFAULT 0,
        `health` int(11) unsigned NOT NULL DEFAULT 0,
        `mana` int(11) unsigned NOT NULL DEFAULT 0,
        `happiness` int(11) unsigned NOT NULL DEFAULT 0,
        `action_bar` blob(40) NOT NULL,
        PRIMARY KEY (`pet_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        insert into applied_updates values ('070820221');
    end if;

    -- 09/08/2022 1
	if (select count(*) from applied_updates where id='090820221') = 0 then
        ALTER TABLE `character_pets` CHANGE `owner` `owner_guid` int(11) unsigned NOT NULL DEFAULT 0;
        ALTER TABLE `character_pets` ADD KEY `fk_character_pets_characters1_idx` (`owner_guid`);
        ALTER TABLE `character_pets` ADD CONSTRAINT `fk_character_pets_characters1` FOREIGN KEY (`owner_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE;

        insert into applied_updates values ('090820221');
    end if;

    -- 29/11/2022 1
    if (select count(*) from applied_updates where id='291120221') = 0 then
        DROP TABLE IF EXISTS `character_pet_spells`;
        CREATE TABLE `character_pet_spells` (
        `guid` int(11) unsigned NOT NULL DEFAULT 0,
        `pet_id` int(11) unsigned NOT NULL DEFAULT 0,
        `spell_id` int(11) unsigned NOT NULL DEFAULT 0,
         KEY `fk_character_pet_spells_characters1_idx` (`guid`),
         KEY `fk_character_pet_spells_character_pets1_idx` (`pet_id`),
         CONSTRAINT `fk_character_pet_spells_characters1_idx` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE,
         CONSTRAINT `fk_character_pet_spells_character_pets1_idx` FOREIGN KEY (`pet_id`) REFERENCES `character_pets` (`pet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
         PRIMARY KEY (`guid`,`spell_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        insert into applied_updates values ('291120221');
    end if;

    -- 04/12/2022 1
	if (select count(*) from applied_updates where id='041220221') = 0 then
        ALTER TABLE `character_pets`
            DROP COLUMN `loyalty`,
            DROP COLUMN `loyalty_points`,
            DROP COLUMN `training_points`,
            DROP COLUMN `happiness`;
	    ALTER TABLE `character_pets` CHANGE COLUMN `renamed` `rename_time` int(11) unsigned NOT NULL DEFAULT 0;
        insert into applied_updates values ('041220221');
    end if;

    -- 22/12/2022 1
    if (select count(*) from applied_updates where id='221220221') = 0 then
        DROP TABLE IF EXISTS `realmlist`;
        CREATE TABLE `realmlist` (
        `realm_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
        `realm_name` VARCHAR(255) NOT NULL DEFAULT '',
        `proxy_address` VARCHAR(15) NOT NULL DEFAULT '0.0.0.0',
        `proxy_port` INT(11) UNSIGNED NOT NULL DEFAULT 9090,
        `realm_address` VARCHAR(15) NOT NULL DEFAULT '0.0.0.0',
        `realm_port` INT(11) UNSIGNED NOT NULL DEFAULT 9100,
        PRIMARY KEY (`realm_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=1;

        INSERT INTO `realmlist` (`realm_name`) VALUES ('alpha-core');

        insert into applied_updates values ('221220221');
    end if;

    -- 12/02/2023 1
	if (select count(*) from applied_updates where id='120220231') = 0 then
        ALTER TABLE `character_pets` ADD COLUMN `is_active` TINYINT(1) unsigned NOT NULL DEFAULT 0;
        insert into applied_updates values ('120220231');
    end if;

    -- 31/03/2023 1
    if (select count(*) from `applied_updates` where id='310320231') = 0 then
        ALTER TABLE characters ADD COLUMN realm_id TINYINT(3) NOT NULL DEFAULT '1' AFTER account;
        ALTER TABLE petition ADD COLUMN realm_id TINYINT(3) NOT NULL DEFAULT '1' AFTER petition_id;
        ALTER TABLE guild ADD COLUMN realm_id TINYINT(3) NOT NULL DEFAULT '1' AFTER guild_id;
        ALTER TABLE tickets ADD COLUMN realm_id TINYINT(3) NOT NULL DEFAULT '1' AFTER account_id;

        insert into`applied_updates`values ('310320231');
    end if;

    -- 11/06/2023 1
	if (select count(*) from applied_updates where id='110620231') = 0 then
        alter table `realmlist` modify column `proxy_address` varchar(255) not null default '0.0.0.0';
        alter table `realmlist` modify column `realm_address` varchar(255) not null default '0.0.0.0';

        insert into applied_updates values ('110620231');
    end if;

end $
delimiter ;
