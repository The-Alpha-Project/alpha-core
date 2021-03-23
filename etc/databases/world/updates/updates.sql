delimiter $
begin not atomic
    -- 23/03/2021 1
    if (select count(*) from applied_updates where id='230320211') = 0 then
        delete from spawns_creatures where spawn_id = 2530733;
        replace into spawns_creatures (spawn_entry1, map, display_id, position_x, position_y, position_z, orientation) values
        (2298, 0, 3572, -3757.669, -767.931, 9.392, 3.334);

        insert into applied_updates values ('230320211');
    end if;
end $
delimiter ;
