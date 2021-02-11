delimiter $
begin not atomic
    -- 11/02/2021 1
    if (select count(*) from applied_updates where id='110220211') = 0 then
        update spawns_gameobjects set ignored = 1 where spawn_entry in (176753, 175566);
        update spawns_creatures set ignored = 1 where spawn_entry1 in (10665, 10666);
        update quest_template set ignored = 1 where entry in (5481, 5482);

        insert into applied_updates values ('110220211');
    end if;
end $
delimiter ;