delimiter $
begin not atomic

    -- 31/10/2025 1
    if (select count(*) from applied_updates where id='311020251') = 0 then
        -- Fix Chickens not being melee attackable.
        UPDATE creature_template SET npc_flags = 0 WHERE entry = 620;

        insert into applied_updates values ('311020251');
    end if;

    -- 31/10/2025 2
    if (select count(*) from applied_updates where id='311020252') = 0 then
        -- Remove wrong text said at the end of Skirmish at Echo Ridge.
        -- This text should be said upon accepting Report to Goldshire.
        -- Proof: https://www.youtube.com/watch?v=SH3HhIsDZ4k&t=373s
        DELETE FROM `quest_end_scripts` WHERE `id`=21;
        UPDATE `quest_template` SET `CompleteScript`=0 WHERE `entry`=21;

        insert into applied_updates values ('311020252');
    end if;

end $
delimiter ;
