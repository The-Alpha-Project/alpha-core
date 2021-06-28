delimiter $
begin not atomic
    -- 13/05/2021 2
    if (select count(*) from applied_updates where id='130520212') = 0 then
        -- Fix damage and armor of starting mobs.
        UPDATE `creature_template` SET `dmg_min` = 1, `dmg_max` = 2, `armor` = 16 WHERE `entry` IN (6, 707, 1512, 2955, 3098);
        UPDATE `creature_template` SET `dmg_min` = 1, `dmg_max` = 2, `armor` = 15 WHERE `entry` = 1501;

        insert into applied_updates values ('130520212');
    end if;

    -- 28/06/2021 1
    if (select count(*) from applied_updates where id='280620211') = 0 then
        -- Teebu's Blazing Longsword
        UPDATE item_template SET display_id = 4908 WHERE entry = 1728;

        insert into applied_updates values ('280620211');
    end if;
	
end $
delimiter ;