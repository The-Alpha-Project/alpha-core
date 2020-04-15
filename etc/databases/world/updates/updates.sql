delimiter $
begin not atomic

    -- 15/04/2020 1
    if (select count(*) from applied_updates where id='150420201') = 0 then
        update gameobjects set entry = 4171 where entry = 47296;
        update gameobjects set entry = 4172 where entry = 47297;

        insert into applied_updates values('150420201');
    end if;

end $
delimiter ;