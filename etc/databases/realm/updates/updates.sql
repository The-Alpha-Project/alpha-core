delimiter $
begin not atomic

    -- 30/10/2025 1
    if (select count(*) from applied_updates where id='301020251') = 0 then
        -- account -> account_id
        ALTER TABLE `characters`
          CHANGE COLUMN `account` `account_id` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Account Identifier';

        insert into applied_updates values ('301020251');
    end if;

end $
delimiter ;
