delimiter $
begin not atomic
    -- 20/05/2020 1
    if (select count(*) from applied_updates where id='200520201') = 0 then
        alter table character_inventory add column item_flags int(11) not null default 0;

        insert into applied_updates values ('200520201');
    end if;
end $
delimiter ;