delimiter $
begin not atomic

    -- 31/10/2025 1
    if (select count(*) from applied_updates where id='311020251') = 0 then
        -- Fix Chickens not being melee attackable.
        UPDATE creature_template SET npc_flags = 0 WHERE entry = 620;

        insert into applied_updates values ('311020251');
    end if;

end $
delimiter ;
