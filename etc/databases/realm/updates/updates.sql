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
end $
delimiter ;