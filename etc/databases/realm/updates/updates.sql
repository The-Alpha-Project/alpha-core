delimiter $
begin not atomic

    -- 30/10/2025 1
    if (select count(*) from applied_updates where id='301020251') = 0 then
        -- account -> account_id
        ALTER TABLE `characters`
          CHANGE COLUMN `account` `account_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Account Identifier';

        insert into applied_updates values ('301020251');
    end if;

    -- 24/03/2026 1
    if (select count(*) from applied_updates where id='240320261') = 0 then
        CREATE TABLE `character_addons_settings` (
          `guid` int(11) unsigned NOT NULL,
          `flags` bigint(20) unsigned NOT NULL DEFAULT 0,
          `settings` longtext DEFAULT NULL COMMENT 'Serialized per-character addon settings payload',
          `updated_at` bigint(20) unsigned NOT NULL DEFAULT 0,
          PRIMARY KEY (`guid`),
          CONSTRAINT `char_addon_settings_guid`
            FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
          COMMENT='Per-character persisted addon settings';

        insert into applied_updates values ('240320261');
    end if;

end $
delimiter ;
