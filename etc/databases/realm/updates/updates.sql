delimiter $
begin not atomic
    -- 20/05/2020 1
    if (select count(*) from applied_updates where id='200520201') = 0 then
        alter table character_inventory add column item_flags int(11) not null default 0;

        insert into applied_updates values ('200520201');
    end if;

    -- 25/02/2021 1
    if (select count(*) from applied_updates where id='250220211') = 0 then
        CREATE TABLE IF NOT EXISTS `character_skills` (
          `guid` int(11) unsigned NOT NULL DEFAULT 0,
          `skill` mediumint(9) unsigned NOT NULL DEFAULT 0,
          `value` mediumint(9) unsigned NOT NULL DEFAULT 0,
          `max` mediumint(9) unsigned NOT NULL DEFAULT 0,
          PRIMARY KEY (`guid`,`skill`),
          KEY `idx_guid2` (`guid`),
          CONSTRAINT `skill_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        CREATE TABLE IF NOT EXISTS `character_spells` (
          `guid` int(11) unsigned NOT NULL DEFAULT 0,
          `spell` int(11) unsigned NOT NULL DEFAULT 0,
          `active` tinyint(3) unsigned NOT NULL DEFAULT 1,
          `disabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
          PRIMARY KEY (`guid`,`spell`),
          KEY `idx_spell` (`spell`),
          KEY `idx_guid3` (`guid`),
          CONSTRAINT `spell_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        CREATE TABLE IF NOT EXISTS `character_spell_cooldown` (
          `guid` int(11) unsigned NOT NULL DEFAULT 0,
          `spell` int(11) unsigned NOT NULL DEFAULT 0,
          `item` int(11) unsigned NOT NULL DEFAULT 0,
          `time` bigint(20) unsigned NOT NULL DEFAULT 0,
          `category_time` bigint(20) unsigned NOT NULL DEFAULT 0,
          PRIMARY KEY (`guid`,`spell`),
          KEY `idx_guid4` (`guid`),
          CONSTRAINT `spell_cd_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        insert into applied_updates values ('250220211');
    end if;

    -- 25/03/2021 1
    if (select count(*) from applied_updates where id='250320211') = 0 then
        alter table characters modify column `talentpoints` int(11) unsigned NOT NULL DEFAULT 0;
        alter table characters modify column `skillpoints` int(11) unsigned NOT NULL DEFAULT 0;
        alter table characters modify column `money` int(11) unsigned NOT NULL DEFAULT 0;
        alter table characters modify column `xp` int(11) unsigned NOT NULL DEFAULT 0;

        insert into applied_updates values ('250320211');
    end if;

    -- 20/04/2021 1
    if (select count(*) from applied_updates where id='200420211') = 0 then
        CREATE TABLE IF NOT EXISTS `guild` (
          `guild_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
          `name` VARCHAR(255) NOT NULL DEFAULT '',
          `leader_guid` INT(11) UNSIGNED NOT NULL DEFAULT 0,
          `motd` VARCHAR(255) NOT NULL DEFAULT '',
          `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
          `emblem_style` INT(5) NOT NULL DEFAULT -1,
          `emblem_color` INT(5) NOT NULL DEFAULT -1,
          `border_style` INT(5) NOT NULL DEFAULT -1,
          `border_color` INT(5) NOT NULL DEFAULT -1,
          `background_color` INT(5) NOT NULL DEFAULT -1,
          PRIMARY KEY (`guild_id`),
          CONSTRAINT `leader_guid_fk` FOREIGN KEY (`leader_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        CREATE TABLE IF NOT EXISTS `guild_member` (
          `guild_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
          `guid` INT(11) UNSIGNED NOT NULL DEFAULT 0,
          `rank` TINYINT(2) UNSIGNED NOT NULL DEFAULT 0,
          PRIMARY KEY (`guild_id`, `guid`),
          CONSTRAINT `guild_member_guid_fk` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE,
          CONSTRAINT `guild_id_fk` FOREIGN KEY (`guild_id`) REFERENCES `guild` (`guild_id`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        insert into applied_updates values ('200420211');
    end if;

    -- 27/04/2021 1
    if (select count(*) from applied_updates where id='270420211') = 0 then
        CREATE TABLE `character_quest_status` (
          `guid` int(11) unsigned NOT NULL DEFAULT 0,
          `quest` int(11) unsigned NOT NULL DEFAULT 0,
          `status` int(11) unsigned NOT NULL DEFAULT 0,
          `rewarded` tinyint(1) unsigned NOT NULL DEFAULT 0,
          `explored` tinyint(1) unsigned NOT NULL DEFAULT 0,
          `timer` bigint(20) unsigned NOT NULL DEFAULT 0,
          `mobcount1` int(11) unsigned NOT NULL DEFAULT 0,
          `mobcount2` int(11) unsigned NOT NULL DEFAULT 0,
          `mobcount3` int(11) unsigned NOT NULL DEFAULT 0,
          `mobcount4` int(11) unsigned NOT NULL DEFAULT 0,
          `itemcount1` int(11) unsigned NOT NULL DEFAULT 0,
          `itemcount2` int(11) unsigned NOT NULL DEFAULT 0,
          `itemcount3` int(11) unsigned NOT NULL DEFAULT 0,
          `itemcount4` int(11) unsigned NOT NULL DEFAULT 0,
          `reward_choice` int(11) unsigned NOT NULL DEFAULT 0,
          PRIMARY KEY (`guid`,`quest`),
          CONSTRAINT `char_guid_quest_fk` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

        insert into applied_updates values ('270420211');
    end if;
	
	-- 30/04/2021 1
	if (select count(*) from applied_updates where id='300420211') = 0 then
		ALTER TABLE guild DROP FOREIGN KEY leader_guid_fk;
		ALTER TABLE guild DROP COLUMN leader_guid;
		insert into applied_updates values ('300420211');
	end if;
	
end $
delimiter ;