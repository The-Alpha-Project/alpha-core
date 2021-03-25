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
end $
delimiter ;