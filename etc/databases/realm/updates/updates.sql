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

    -- 12/11/2026 1
    if (select count(*) from applied_updates where id='121120261') = 0 then
        -- Auras saved on logout (World.Gameplay.persist_auras).
        CREATE TABLE `character_auras` (
          `guid` int(11) unsigned NOT NULL DEFAULT 0,
          `spell` int(11) unsigned NOT NULL DEFAULT 0,
          `stacks` int(11) unsigned NOT NULL DEFAULT 1,
          `duration` int(11) NOT NULL DEFAULT -1 COMMENT 'Remaining milliseconds, -1 infinite',
          `effect_mask` tinyint(3) unsigned NOT NULL DEFAULT 0,
          `points_1` int(11) NOT NULL DEFAULT 0,
          `points_2` int(11) NOT NULL DEFAULT 0,
          `points_3` int(11) NOT NULL DEFAULT 0,
          PRIMARY KEY (`guid`,`spell`),
          CONSTRAINT `char_aura_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
          COMMENT='Auras restored on login when World.Gameplay.persist_auras is enabled';

        insert into applied_updates values ('121120261');
    end if;

end $
delimiter ;
