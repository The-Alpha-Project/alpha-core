delimiter $
begin not atomic

    -- 30/10/2025 1
    if (select count(*) from applied_updates where id='301020251') = 0 then
        -- Remove account foreign key from `tickets`
        ALTER TABLE `tickets` DROP FOREIGN KEY `tickets_ibfk_1`;
        -- Remove account foreign key from `characters`
        ALTER TABLE `characters` DROP FOREIGN KEY `char_acc`;

        -- Clear indexes.
        ALTER TABLE `tickets` DROP KEY `account_id`;
        ALTER TABLE `characters` DROP KEY `idx_account`;

        -- account -> account_id
        ALTER TABLE `characters`
          CHANGE COLUMN `account` `account_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Account Identifier';

        insert into applied_updates values ('301020251');
    end if;

end $
delimiter ;
