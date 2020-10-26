delimiter $
begin not atomic
    -- 26/10/2020 1
    if (select count(*) from applied_updates where id='261020201') = 0 then
        UPDATE `creature_template` SET `speed_run`=1.14286 WHERE `entry`=2713;

        insert into applied_updates values ('261020201');
    end if;

end $
delimiter ;