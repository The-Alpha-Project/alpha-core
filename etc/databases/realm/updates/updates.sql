delimiter $
begin not atomic
    -- 13/02/2020 1
    if (select count(*) from applied_updates where id='13022021') = 0 then
        set foreign_key_checks = 0;
        alter table characters modify guid int(11) unsigned auto_increment;
        set foreign_key_checks = 1;

        insert into applied_updates values('13022021');
    end if;

end $
delimiter ;