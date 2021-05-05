delimiter $
begin not atomic
    -- 05/05/2021 1
    if (select count(*) from applied_updates where id='050520211') = 0 then
        delete from item_template where entry = 23192;
        update item_template set display_id = 3865 where entry = 7725;
        insert into applied_updates values ('050520211');
    end if;
	
end $
delimiter ;