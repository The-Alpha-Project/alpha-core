delimiter $
begin not atomic

    -- 25/09/2021 1
    if (select count(*) from applied_updates where id='250920211') = 0 then
        ALTER TABLE `creature_template` DROP COLUMN `inhabit_type`;
        
        insert into applied_updates values ('250920211');
    end if;  

end $
delimiter ;