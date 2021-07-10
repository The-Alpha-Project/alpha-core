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
	
	-- 04/07/2021 1
	if (select count(*) from applied_updates where id='040720211') = 0 then
        ALTER TABLE `TaxiNodes`
        ADD COLUMN `custom_Team` INT(3) NOT NULL DEFAULT -1 AFTER `Name_Mask`;

        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 1);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 2);
        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 3);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 4);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 5);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 6);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 7);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 8);
        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 9);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 10);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 11);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 12);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 13);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 14);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 15);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 16);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 17);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 18);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 19);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 20);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 21);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 22);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 23);
        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 24);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 25);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 26);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 27);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 28);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 29);
        UPDATE `TaxiNodes` SET `custom_team` = 67 WHERE (`ID` = 30);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 31);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 32);
        UPDATE `TaxiNodes` SET `custom_team` = 469 WHERE (`ID` = 33);
        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 36);
        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 35);
        UPDATE `TaxiNodes` SET `custom_team` = -1 WHERE (`ID` = 34);
		
        insert into applied_updates values ('040720211');
    end if;

end $
delimiter ;
