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

end $
delimiter ;