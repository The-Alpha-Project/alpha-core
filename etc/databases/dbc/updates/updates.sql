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

        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 1);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 2);
        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 3);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 4);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 5);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 6);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 7);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 8);
        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 9);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 10);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 11);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 12);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 13);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 14);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 15);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 16);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 17);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 18);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 19);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 20);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 21);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 22);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 23);
        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 24);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 25);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 26);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 27);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 28);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 29);
        UPDATE `TaxiNodes` SET `custom_Team` = 67 WHERE (`ID` = 30);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 31);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 32);
        UPDATE `TaxiNodes` SET `custom_Team` = 469 WHERE (`ID` = 33);
        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 36);
        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 35);
        UPDATE `TaxiNodes` SET `custom_Team` = -1 WHERE (`ID` = 34);
		
        insert into applied_updates values ('040720211');
    end if;

    -- 20/04/2022 1
    if (select count(*) from applied_updates where id='200420221') = 0 then
        DROP TABLE IF EXISTS `CreatureFamily`; 
        CREATE TABLE `CreatureFamily` (
          `ID` INT NOT NULL DEFAULT '0',
          `MinScale` FLOAT NOT NULL DEFAULT '0',
          `MinScaleLevel` INT NOT NULL DEFAULT '0',
          `MaxScale` FLOAT NOT NULL DEFAULT '0',
          `MaxScaleLevel` INT NOT NULL DEFAULT '0',
          `SkillLine_1` INT NOT NULL DEFAULT '0',
          `SkillLine_2` INT NOT NULL DEFAULT '0',
          PRIMARY KEY (`ID`)
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
        
        INSERT INTO `CreatureFamily` VALUES (1,0.5,1,1.2,70,208,270); 
        INSERT INTO `CreatureFamily` VALUES (2,0.5,1,1.2,70,209,270); 
        INSERT INTO `CreatureFamily` VALUES (3,0.4,1,0.8,70,203,270); 
        INSERT INTO `CreatureFamily` VALUES (4,0.5,1,1.2,70,210,270); 
        INSERT INTO `CreatureFamily` VALUES (5,0.5,1,1.2,70,211,270); 
        INSERT INTO `CreatureFamily` VALUES (6,0.3,1,0.6,70,212,270); 
        INSERT INTO `CreatureFamily` VALUES (7,0.5,1,1.1,70,213,270); 
        INSERT INTO `CreatureFamily` VALUES (8,0.5,1,1.4,70,214,270); 
        INSERT INTO `CreatureFamily` VALUES (9,0.5,1,1.2,70,215,270); 
        INSERT INTO `CreatureFamily` VALUES (10,0.5,1,1.5,70,216,270); 
        INSERT INTO `CreatureFamily` VALUES (11,0.4,1,0.8,70,217,270); 
        INSERT INTO `CreatureFamily` VALUES (12,0.3,1,0.7,70,218,270); 
        INSERT INTO `CreatureFamily` VALUES (15,0.5,1,0.8,70,189,0); 
        INSERT INTO `CreatureFamily` VALUES (16,0.5,1,1,70,204,0); 
        INSERT INTO `CreatureFamily` VALUES (17,0.5,1,1.5,70,205,0); 
        INSERT INTO `CreatureFamily` VALUES (19,0.5,1,1.5,70,207,0); 
        INSERT INTO `CreatureFamily` VALUES (20,0.5,1,1,70,236,270); 
        INSERT INTO `CreatureFamily` VALUES (21,0.5,1,1.5,70,251,270); 
        INSERT INTO `CreatureFamily` VALUES (23,0.2,1,0.4,70,188,270); 
        
        INSERT INTO applied_updates VALUES ('200420221');
    end if;

end $
delimiter ;
