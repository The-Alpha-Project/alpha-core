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
        ALTER TABLE `taxinodes` 
        ADD COLUMN `Team` INT NOT NULL DEFAULT '0' AFTER `Name_Mask`;

        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '1');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '2');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '3');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '4');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '5');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '6');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '7');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '8');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '9');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '10');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '11');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '12');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '13');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '14');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '15');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '16');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '17');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '18');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '19');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '20');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '21');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '22');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '23');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '24');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '25');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '26');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '27');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '28');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '29');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '67' WHERE (`ID` = '30');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '31');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '32');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '469' WHERE (`ID` = '33');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '36');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '35');
        UPDATE `alpha_dbc`.`taxinodes` SET `Team` = '-1' WHERE (`ID` = '34');
		
        insert into applied_updates values ('040720211');
    end if;

end $
delimiter ;
