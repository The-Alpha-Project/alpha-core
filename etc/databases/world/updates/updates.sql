delimiter $
begin not atomic
    -- 13/05/2021 2
    if (select count(*) from applied_updates where id='130520212') = 0 then
        -- Fix damage and armor of starting mobs.
        UPDATE `creature_template` SET `dmg_min` = 1, `dmg_max` = 2, `armor` = 16 WHERE `entry` IN (6, 707, 1512, 2955, 3098);
        UPDATE `creature_template` SET `dmg_min` = 1, `dmg_max` = 2, `armor` = 15 WHERE `entry` = 1501;

        insert into applied_updates values ('130520212');
    end if;
	
end $
delimiter ;