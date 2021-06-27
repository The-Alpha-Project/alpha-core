CREATE TABLE IF NOT EXISTS `applied_updates` (`id` varchar(9) NOT NULL DEFAULT '000000000', PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

delimiter $
begin not atomic
    -- 09/02/2021 1
    if (select count(*) from applied_updates where id='090220211') = 0 then
        alter table SkillLineAbility add column custom_PrecededBySpell int(11) not null default 0;
        
        UPDATE SkillLineAbility t1
        INNER JOIN SkillLineAbility t2 ON t2.SupercededBySpell = t1.Spell
        SET t1.custom_PrecededBySpell = t2.Spell;

        insert into applied_updates values ('090220211');
    end if;
end $
delimiter ;
