CREATE TABLE IF NOT EXISTS `applied_updates` (`id` varchar(9) NOT NULL DEFAULT '000000000', PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

delimiter $
begin not atomic

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
    
    -- 09/06/2022 1
    if (select count(*) from applied_updates where id='090620221') = 0 then
        DROP TABLE IF EXISTS SpellVisualKit;
        CREATE TABLE SpellVisualKit(
        `ID` INT NOT NULL DEFAULT '0',
        `KitType` INT NOT NULL DEFAULT '0',
        `Anim` INT NOT NULL DEFAULT '0',
        PRIMARY KEY (`ID`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (1,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (2,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (3,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (4,3,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (5,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (6,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (7,0,110);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (8,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (9,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (10,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (11,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (12,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (13,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (14,1,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (15,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (16,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (17,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (18,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (19,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (20,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (21,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (22,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (23,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (24,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (25,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (26,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (27,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (28,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (30,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (31,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (32,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (33,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (34,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (35,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (36,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (37,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (38,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (39,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (40,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (41,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (42,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (43,0,54);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (44,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (45,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (46,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (47,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (48,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (49,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (50,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (51,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (52,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (53,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (54,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (55,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (56,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (57,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (58,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (59,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (60,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (61,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (62,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (63,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (64,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (65,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (66,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (67,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (68,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (69,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (70,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (71,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (72,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (73,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (74,0,58);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (75,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (76,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (77,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (78,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (79,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (80,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (81,0,117);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (82,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (83,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (84,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (85,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (86,0,57);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (87,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (88,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (89,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (90,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (91,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (92,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (93,0,57);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (94,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (95,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (96,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (97,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (98,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (99,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (100,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (101,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (102,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (103,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (104,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (105,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (106,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (107,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (108,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (109,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (110,0,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (111,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (112,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (113,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (114,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (115,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (116,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (117,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (118,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (119,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (120,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (121,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (122,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (123,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (124,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (125,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (126,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (127,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (128,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (129,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (130,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (131,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (132,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (133,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (134,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (135,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (136,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (137,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (138,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (139,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (140,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (141,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (142,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (143,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (144,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (145,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (146,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (147,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (148,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (149,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (150,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (151,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (152,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (153,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (154,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (155,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (156,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (157,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (158,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (159,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (160,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (161,0,111);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (162,0,100);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (163,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (164,0,42);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (165,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (166,0,60);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (167,0,48);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (168,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (169,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (170,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (171,0,212);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (172,0,112);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (173,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (174,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (175,0,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (176,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (177,0,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (178,0,188);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (179,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (180,0,181);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (181,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (182,0,131);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (183,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (184,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (185,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (186,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (187,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (188,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (189,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (190,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (191,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (192,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (193,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (194,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (195,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (196,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (197,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (198,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (199,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (200,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (201,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (202,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (203,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (204,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (205,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (206,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (207,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (208,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (209,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (211,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (212,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (213,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (214,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (215,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (216,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (217,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (218,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (219,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (220,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (221,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (222,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (223,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (224,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (225,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (226,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (227,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (228,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (229,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (230,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (231,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (232,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (233,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (234,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (235,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (237,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (238,0,113);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (239,0,112);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (240,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (241,0,114);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (242,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (243,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (244,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (245,2,220);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (246,0,117);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (247,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (248,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (249,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (250,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (251,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (252,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (253,0,191);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (254,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (255,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (256,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (257,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (258,0,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (259,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (260,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (261,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (262,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (263,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (264,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (265,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (266,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (267,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (268,0,131);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (269,0,213);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (270,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (271,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (272,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (273,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (274,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (275,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (276,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (277,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (278,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (279,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (280,0,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (281,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (282,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (283,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (284,2,224);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (285,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (286,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (287,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (288,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (289,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (290,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (291,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (292,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (293,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (294,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (295,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (296,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (297,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (298,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (299,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (300,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (301,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (302,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (303,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (304,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (305,0,217);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (306,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (307,0,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (308,0,188);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (309,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (310,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (311,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (312,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (313,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (314,1,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (315,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (316,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (317,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (318,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (319,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (320,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (321,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (322,2,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (323,2,131);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (324,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (325,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (326,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (327,0,190);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (328,1,176);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (329,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (330,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (331,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (332,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (333,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (334,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (335,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (336,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (337,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (338,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (339,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (340,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (341,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (342,2,224);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (343,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (344,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (345,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (346,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (347,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (348,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (349,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (350,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (351,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (352,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (353,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (354,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (355,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (356,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (357,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (358,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (359,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (360,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (361,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (362,1,345);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (363,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (364,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (365,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (366,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (367,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (368,0,168);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (369,0,226);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (370,2,226);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (371,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (372,0,211);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (373,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (378,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (379,0,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (380,0,217);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (381,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (382,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (383,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (384,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (385,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (386,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (387,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (388,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (389,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (390,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (391,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (392,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (393,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (394,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (395,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (396,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (397,0,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (398,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (399,0,214);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (400,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (401,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (402,2,224);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (403,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (404,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (405,0,220);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (406,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (407,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (408,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (409,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (410,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (411,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (412,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (413,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (414,0,112);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (415,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (416,0,57);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (417,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (418,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (419,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (420,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (421,1,345);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (422,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (423,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (424,0,112);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (425,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (426,2,148);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (427,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (428,1,168);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (429,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (430,2,224);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (431,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (432,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (433,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (434,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (435,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (436,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (437,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (438,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (439,0,133);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (440,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (441,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (442,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (443,0,216);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (444,0,218);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (445,2,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (446,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (447,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (448,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (449,0,133);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (450,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (451,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (452,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (453,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (454,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (455,1,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (456,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (457,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (458,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (459,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (460,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (461,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (462,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (463,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (464,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (465,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (466,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (467,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (468,0,58);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (469,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (470,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (471,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (472,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (473,2,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (474,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (475,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (476,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (477,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (478,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (479,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (480,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (481,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (482,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (483,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (484,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (485,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (486,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (487,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (488,2,117);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (489,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (490,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (491,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (492,0,57);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (493,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (494,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (495,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (496,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (497,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (498,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (499,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (500,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (501,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (502,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (503,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (504,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (505,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (506,0,214);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (507,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (508,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (509,1,138);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (510,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (511,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (512,0,190);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (513,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (514,2,184);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (515,1,172);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (516,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (517,0,131);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (518,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (519,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (520,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (521,0,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (522,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (523,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (524,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (525,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (526,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (527,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (528,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (529,0,181);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (530,2,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (531,1,169);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (532,2,131);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (533,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (534,2,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (535,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (536,0,135);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (537,0,173);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (538,0,133);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (539,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (540,1,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (541,2,152);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (542,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (543,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (544,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (545,0,60);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (546,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (547,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (548,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (549,1,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (550,1,125);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (551,1,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (552,0,168);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (553,1,176);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (554,0,170);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (555,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (556,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (557,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (558,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (559,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (560,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (561,0,187);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (562,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (563,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (564,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (565,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (566,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (586,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (587,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (588,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (589,0,51);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (606,1,124);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (607,2,216);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (608,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (609,3,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (626,0,201);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (646,0,57);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (647,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (648,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (649,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (650,0,190);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (651,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (652,0,190);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (653,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (654,0,190);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (655,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (656,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (657,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (658,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (659,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (660,2,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (661,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (662,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (663,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (664,2,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (665,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (666,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (667,0,131);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (668,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (686,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (687,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (688,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (689,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (690,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (691,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (692,3,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (693,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (694,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (695,3,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (696,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (697,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (698,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (699,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (700,3,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (701,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (702,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (703,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (704,0,59);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (705,0,125);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (716,2,225);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (717,2,225);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (718,2,225);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (719,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (720,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (721,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (722,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (723,0,185);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (724,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (725,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (726,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (727,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (728,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (729,2,224);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (730,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (731,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (732,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (733,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (734,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (735,0,113);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (736,3,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (737,1,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (738,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (739,2,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (740,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (741,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (742,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (743,0,230);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (744,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (745,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (746,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (747,0,57);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (748,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (749,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (750,0,227);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (751,0,227);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (752,0,227);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (753,0,227);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (764,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (765,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (766,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (767,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (768,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (769,2,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (770,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (771,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (772,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (773,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (774,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (775,0,176);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (776,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (777,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (778,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (779,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (780,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (781,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (782,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (783,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (784,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (785,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (786,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (787,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (788,0,112);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (789,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (790,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (791,2,231);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (792,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (793,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (794,0,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (795,1,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (796,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (797,0,227);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (798,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (799,0,50);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (800,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (801,0,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (802,0,230);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (803,0,111);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (804,0,48);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (805,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (806,1,215);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (807,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (808,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (809,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (810,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (811,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (812,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (813,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (814,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (815,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (816,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (817,0,31);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (818,2,223);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (819,0,231);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (820,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (821,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (822,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (823,0,56);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (824,2,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (825,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (826,0,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (827,0,52);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (828,1,125);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (829,0,346);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (830,2,347);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (831,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (832,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (833,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (834,2,129);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (835,1,188);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (836,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (837,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (838,0,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (839,1,170);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (840,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (841,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (842,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (843,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (844,0,55);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (845,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (846,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (847,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (848,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (849,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (850,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (851,1,220);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (852,2,220);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (853,0,180);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (854,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (855,0,132);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (856,1,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (857,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (858,2,0);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (859,0,53);
        INSERT INTO SpellVisualKit(ID,KitType,Anim) VALUES (860,1,0);

        INSERT INTO applied_updates VALUES ('090620221');
    end if;

    -- 21/08/2022 1
    if (select count(*) from applied_updates where id='210820221') = 0 then
        DROP TABLE IF EXISTS `SpellIcon`;
        CREATE TABLE `SpellIcon` ( `ID` INT NOT NULL DEFAULT '0', `TextureFilename` TEXT NULL, PRIMARY KEY (`ID`)) ENGINE=MyISAM DEFAULT CHARSET=utf8;
        INSERT INTO `SpellIcon` VALUES (1,"Interface\\Icons\\Temp");
        INSERT INTO `SpellIcon` VALUES (9,"Interface\\Icons\\Spell_Shadow_BlackPlague");
        INSERT INTO `SpellIcon` VALUES (10,"Interface\\Icons\\Spell_Nature_NaturesBlessing");
        INSERT INTO `SpellIcon` VALUES (11,"Interface\\Icons\\Spell_Fire_Fire");
        INSERT INTO `SpellIcon` VALUES (12,"Interface\\Icons\\Spell_Fire_Fireball");
        INSERT INTO `SpellIcon` VALUES (13,"Interface\\Icons\\Spell_Nature_MagicImmunity");
        INSERT INTO `SpellIcon` VALUES (14,"Interface\\Icons\\Spell_Frost_Frost");
        INSERT INTO `SpellIcon` VALUES (15,"Interface\\Icons\\Spell_Frost_Stun");
        INSERT INTO `SpellIcon` VALUES (16,"Interface\\Icons\\Spell_Fire_FireArmor");
        INSERT INTO `SpellIcon` VALUES (17,"Interface\\Icons\\Spell_Frost_IceShock");
        INSERT INTO `SpellIcon` VALUES (18,"Interface\\Icons\\Spell_Fire_FireBolt");
        INSERT INTO `SpellIcon` VALUES (19,"Interface\\Icons\\Spell_Nature_LightningShield");
        INSERT INTO `SpellIcon` VALUES (20,"Interface\\Icons\\Spell_Nature_StrangleVines");
        INSERT INTO `SpellIcon` VALUES (21,"Interface\\Icons\\Spell_Nature_FarSight");
        INSERT INTO `SpellIcon` VALUES (22,"Interface\\Icons\\Spell_Shadow_ShadeTrueSight");
        INSERT INTO `SpellIcon` VALUES (23,"Interface\\Icons\\Ability_ShockWave");
        INSERT INTO `SpellIcon` VALUES (24,"Interface\\Icons\\Spell_Nature_Reincarnation");
        INSERT INTO `SpellIcon` VALUES (25,"Interface\\Icons\\Ability_ThunderBolt");
        INSERT INTO `SpellIcon` VALUES (26,"Interface\\Icons\\Ability_MeleeDamage");
        INSERT INTO `SpellIcon` VALUES (27,"Interface\\Icons\\Spell_Nature_Slow");
        INSERT INTO `SpellIcon` VALUES (28,"Interface\\Icons\\Ability_Defend");
        INSERT INTO `SpellIcon` VALUES (29,"Interface\\Icons\\Ability_Seal");
        INSERT INTO `SpellIcon` VALUES (30,"Interface\\Icons\\Spell_Nature_Invisibilty");
        INSERT INTO `SpellIcon` VALUES (31,"Interface\\Icons\\Spell_Fire_Immolation");
        INSERT INTO `SpellIcon` VALUES (32,"Interface\\Icons\\Spell_Ice_Lament");
        INSERT INTO `SpellIcon` VALUES (33,"Interface\\Icons\\Spell_Fire_SealOfFire");
        INSERT INTO `SpellIcon` VALUES (34,"Interface\\Icons\\Spell_Fire_FlameBlades");
        INSERT INTO `SpellIcon` VALUES (35,"Interface\\Icons\\Spell_Frost_Glacier");
        INSERT INTO `SpellIcon` VALUES (36,"Interface\\Icons\\Spell_Frost_ManaRecharge");
        INSERT INTO `SpellIcon` VALUES (37,"Interface\\Icons\\Spell_Fire_SelfDestruct");
        INSERT INTO `SpellIcon` VALUES (38,"Interface\\Icons\\Spell_Nature_BloodLust");
        INSERT INTO `SpellIcon` VALUES (39,"Interface\\Icons\\Spell_Nature_NatureTouchGrow");
        INSERT INTO `SpellIcon` VALUES (40,"Interface\\Icons\\Spell_Nature_NatureTouchDecay");
        INSERT INTO `SpellIcon` VALUES (41,"Interface\\Icons\\Spell_Nature_DryadDispelMagic");
        INSERT INTO `SpellIcon` VALUES (42,"Interface\\Icons\\Ability_ThunderClap");
        INSERT INTO `SpellIcon` VALUES (43,"Interface\\Icons\\Ability_Temp");
        INSERT INTO `SpellIcon` VALUES (44,"Interface\\Icons\\Spell_Nature_Sleep");
        INSERT INTO `SpellIcon` VALUES (45,"Interface\\Icons\\Spell_Fire_MeteorStorm");
        INSERT INTO `SpellIcon` VALUES (46,"Interface\\Icons\\Spell_Nature_MoonGlow");
        INSERT INTO `SpellIcon` VALUES (47,"Interface\\Icons\\Spell_Nature_Purge");
        INSERT INTO `SpellIcon` VALUES (48,"Interface\\Icons\\Spell_Shadow_MindSteal");
        INSERT INTO `SpellIcon` VALUES (49,"Interface\\Icons\\Ability_EyeOfTheOwl");
        INSERT INTO `SpellIcon` VALUES (50,"Interface\\Icons\\Ability_BullRush");
        INSERT INTO `SpellIcon` VALUES (51,"Interface\\Icons\\Spell_Holy_InnerFire");
        INSERT INTO `SpellIcon` VALUES (52,"Interface\\Icons\\Spell_Holy_Devotion");
        INSERT INTO `SpellIcon` VALUES (53,"Interface\\Icons\\Spell_Nature_Thorns");
        INSERT INTO `SpellIcon` VALUES (54,"Interface\\Icons\\Spell_Nature_Brilliance");
        INSERT INTO `SpellIcon` VALUES (55,"Interface\\Icons\\Spell_Shadow_ChillTouch");
        INSERT INTO `SpellIcon` VALUES (56,"Interface\\Icons\\Spell_Frost_FreezingBreath");
        INSERT INTO `SpellIcon` VALUES (57,"Interface\\Icons\\Spell_Fire_EnchantWeapon");
        INSERT INTO `SpellIcon` VALUES (58,"Interface\\Icons\\Spell_Nature_TimeStop");
        INSERT INTO `SpellIcon` VALUES (59,"Interface\\Icons\\Spell_Misc_Food");
        INSERT INTO `SpellIcon` VALUES (60,"Interface\\Icons\\Spell_Misc_Drink");
        INSERT INTO `SpellIcon` VALUES (61,"Interface\\Icons\\Spell_Shadow_RaiseDead");
        INSERT INTO `SpellIcon` VALUES (62,"Interface\\Icons\\Spell_Nature_Lightning");
        INSERT INTO `SpellIcon` VALUES (63,"Interface\\Icons\\Spell_Nature_Strength");
        INSERT INTO `SpellIcon` VALUES (64,"Interface\\Icons\\Spell_Nature_Rejuvenation");
        INSERT INTO `SpellIcon` VALUES (65,"Interface\\Icons\\Spell_Nature_NullWard");
        INSERT INTO `SpellIcon` VALUES (66,"Interface\\Icons\\Spell_Nature_Earthquake");
        INSERT INTO `SpellIcon` VALUES (67,"Interface\\Icons\\Spell_Nature_SpiritWolf");
        INSERT INTO `SpellIcon` VALUES (68,"Interface\\Icons\\Spell_Nature_CorrosiveBreath");
        INSERT INTO `SpellIcon` VALUES (69,"Interface\\Icons\\Ability_Ensnare");
        INSERT INTO `SpellIcon` VALUES (70,"Interface\\Icons\\Spell_Holy_HolyBolt");
        INSERT INTO `SpellIcon` VALUES (71,"Interface\\Icons\\Spell_Shadow_Charm");
        INSERT INTO `SpellIcon` VALUES (72,"Interface\\Icons\\Spell_Nature_GuardianWard");
        INSERT INTO `SpellIcon` VALUES (73,"Interface\\Icons\\Spell_Holy_Restoration");
        INSERT INTO `SpellIcon` VALUES (74,"Interface\\Icons\\Spell_Holy_DispelMagic");
        INSERT INTO `SpellIcon` VALUES (75,"Interface\\Icons\\Spell_Shadow_SpectralSight");
        INSERT INTO `SpellIcon` VALUES (76,"Interface\\Icons\\Spell_Shadow_FingerOfDeath");
        INSERT INTO `SpellIcon` VALUES (77,"Interface\\Icons\\Spell_Shadow_MindRot");
        INSERT INTO `SpellIcon` VALUES (78,"Interface\\Icons\\Spell_Holy_Invulnerable");
        INSERT INTO `SpellIcon` VALUES (79,"Interface\\Icons\\Spell_Holy_LayOnHands");
        INSERT INTO `SpellIcon` VALUES (80,"Interface\\Icons\\Spell_Holy_SealOfValor");
        INSERT INTO `SpellIcon` VALUES (81,"Interface\\Icons\\Spell_Holy_DivineIntervention");
        INSERT INTO `SpellIcon` VALUES (82,"Interface\\Icons\\Spell_Nature_Polymorph");
        INSERT INTO `SpellIcon` VALUES (83,"Interface\\Icons\\Ability_Whirlwind");
        INSERT INTO `SpellIcon` VALUES (84,"Interface\\Icons\\Ability_Racial_Avatar");
        INSERT INTO `SpellIcon` VALUES (85,"Interface\\Icons\\Ability_UpgradeMoonGlaive");
        INSERT INTO `SpellIcon` VALUES (86,"Interface\\Icons\\Ability_Racial_BloodRage");
        INSERT INTO `SpellIcon` VALUES (87,"Interface\\Icons\\Spell_Shadow_Teleport");
        INSERT INTO `SpellIcon` VALUES (88,"Interface\\Icons\\Spell_Shadow_DeathCoil");
        INSERT INTO `SpellIcon` VALUES (89,"Interface\\Icons\\Spell_Shadow_RagingScream");
        INSERT INTO `SpellIcon` VALUES (90,"Interface\\Icons\\Spell_Shadow_Metamorphosis");
        INSERT INTO `SpellIcon` VALUES (91,"Interface\\Icons\\Spell_Shadow_AuraOfDarkness");
        INSERT INTO `SpellIcon` VALUES (92,"Interface\\Icons\\Spell_Shadow_SoulGem");
        INSERT INTO `SpellIcon` VALUES (93,"Interface\\Icons\\Spell_Shadow_UnholyStrength");
        INSERT INTO `SpellIcon` VALUES (94,"Interface\\Icons\\Spell_Frost_SummonWaterElemental");
        INSERT INTO `SpellIcon` VALUES (95,"Interface\\Icons\\Spell_Shadow_UnholyFrenzy");
        INSERT INTO `SpellIcon` VALUES (96,"Interface\\Icons\\Spell_Shadow_Cripple");
        INSERT INTO `SpellIcon` VALUES (97,"Interface\\Icons\\Spell_Shadow_PlagueCloud");
        INSERT INTO `SpellIcon` VALUES (98,"Interface\\Icons\\Spell_Shadow_Possession");
        INSERT INTO `SpellIcon` VALUES (99,"Interface\\Icons\\Spell_Shadow_AntiMagicShell");
        INSERT INTO `SpellIcon` VALUES (100,"Interface\\Icons\\Spell_Nature_Tranquility");
        INSERT INTO `SpellIcon` VALUES (101,"Interface\\Icons\\Spell_Frost_WindWalkOn");
        INSERT INTO `SpellIcon` VALUES (102,"Interface\\Icons\\Ability_Smash");
        INSERT INTO `SpellIcon` VALUES (103,"Interface\\Icons\\Ability_Ambush");
        INSERT INTO `SpellIcon` VALUES (104,"Interface\\Icons\\Spell_Holy_Heal");
        INSERT INTO `SpellIcon` VALUES (105,"Interface\\Icons\\Ability_SearingArrow");
        INSERT INTO `SpellIcon` VALUES (106,"Interface\\Icons\\Spell_Nature_MoonKey");
        INSERT INTO `SpellIcon` VALUES (107,"Interface\\Icons\\Ability_Racial_BearForm");
        INSERT INTO `SpellIcon` VALUES (108,"Interface\\Icons\\Ability_GhoulFrenzy");
        INSERT INTO `SpellIcon` VALUES (109,"Interface\\Icons\\Spell_Nature_FaerieFire");
        INSERT INTO `SpellIcon` VALUES (110,"Interface\\Icons\\Spell_Nature_SlowPoison");
        INSERT INTO `SpellIcon` VALUES (111,"Interface\\Icons\\Spell_Nature_ForceOfNature");
        INSERT INTO `SpellIcon` VALUES (112,"Interface\\Icons\\Spell_Nature_RavenForm");
        INSERT INTO `SpellIcon` VALUES (113,"Interface\\Icons\\Spell_Shadow_Haunting");
        INSERT INTO `SpellIcon` VALUES (114,"Interface\\Icons\\Spell_Shadow_ShadowPact");
        INSERT INTO `SpellIcon` VALUES (115,"Interface\\Icons\\Spell_Nature_Swiftness");
        INSERT INTO `SpellIcon` VALUES (116,"Interface\\Icons\\Spell_Shadow_CarrionSwarm");
        INSERT INTO `SpellIcon` VALUES (117,"Interface\\Icons\\Spell_Nature_WispHeal");
        INSERT INTO `SpellIcon` VALUES (118,"Interface\\Icons\\Spell_Shadow_DeathAndDecay");
        INSERT INTO `SpellIcon` VALUES (119,"Interface\\Icons\\Spell_Frost_FrostArmor");
        INSERT INTO `SpellIcon` VALUES (120,"Interface\\Icons\\Spell_Totem_WardOfDraining");
        INSERT INTO `SpellIcon` VALUES (121,"Interface\\Icons\\Spell_Holy_Resurrection");
        INSERT INTO `SpellIcon` VALUES (122,"Interface\\Icons\\Spell_Nature_WispSplode");
        INSERT INTO `SpellIcon` VALUES (123,"Interface\\Icons\\Spell_Nature_Regeneration");
        INSERT INTO `SpellIcon` VALUES (124,"Interface\\Icons\\Spell_Nature_ResistMagic");
        INSERT INTO `SpellIcon` VALUES (125,"Interface\\Icons\\Spell_Holy_MagicalSentry");
        INSERT INTO `SpellIcon` VALUES (126,"Interface\\Icons\\Ability_Marksmanship");
        INSERT INTO `SpellIcon` VALUES (127,"Interface\\Icons\\Ability_TheBlackArrow");
        INSERT INTO `SpellIcon` VALUES (128,"Interface\\Icons\\Ability_TrueShot");
        INSERT INTO `SpellIcon` VALUES (129,"Interface\\Icons\\Ability_WarStomp");
        INSERT INTO `SpellIcon` VALUES (130,"Interface\\Icons\\Spell_Shadow_RitualOfSacrifice");
        INSERT INTO `SpellIcon` VALUES (131,"Interface\\Icons\\Ability_Racial_ShadowMeld");
        INSERT INTO `SpellIcon` VALUES (132,"Interface\\Icons\\Ability_GolemStormBolt");
        INSERT INTO `SpellIcon` VALUES (133,"Interface\\Icons\\Spell_Frost_WizardMark");
        INSERT INTO `SpellIcon` VALUES (134,"Interface\\Icons\\Spell_Shadow_DeathScream");
        INSERT INTO `SpellIcon` VALUES (135,"Interface\\Icons\\Spell_Shadow_EvilEye");
        INSERT INTO `SpellIcon` VALUES (136,"Interface\\Icons\\Spell_Fire_Flare");
        INSERT INTO `SpellIcon` VALUES (137,"Interface\\Icons\\Spell_Shadow_MindBomb");
        INSERT INTO `SpellIcon` VALUES (138,"Interface\\Icons\\Ability_CriticalStrike");
        INSERT INTO `SpellIcon` VALUES (139,"Interface\\Icons\\Spell_Nature_EnchantArmor");
        INSERT INTO `SpellIcon` VALUES (140,"Interface\\Icons\\Spell_Shadow_SealOfKings");
        INSERT INTO `SpellIcon` VALUES (141,"Interface\\Icons\\Spell_Nature_CallStorm");
        INSERT INTO `SpellIcon` VALUES (142,"Interface\\Icons\\Spell_Frost_IceClaw");
        INSERT INTO `SpellIcon` VALUES (143,"Interface\\Icons\\Spell_Frost_Wisp");
        INSERT INTO `SpellIcon` VALUES (144,"Interface\\Icons\\Frostbolt_test");
        INSERT INTO `SpellIcon` VALUES (145,"Interface\\Icons\\Spell_Frost_ManaBurn");
        INSERT INTO `SpellIcon` VALUES (146,"Interface\\Icons\\Ability_Racial_Cannibalize");
        INSERT INTO `SpellIcon` VALUES (147,"Interface\\Icons\\Spell_Shadow_VampiricAura");
        INSERT INTO `SpellIcon` VALUES (148,"Interface\\Icons\\Ability_GolemThunderClap");
        INSERT INTO `SpellIcon` VALUES (149,"Interface\\Icons\\Spell_Nature_Regenerate");
        INSERT INTO `SpellIcon` VALUES (150,"Interface\\Icons\\Spell_Shadow_UnsummonBuilding");
        INSERT INTO `SpellIcon` VALUES (151,"Interface\\Icons\\Ability_SteelMelee");
        INSERT INTO `SpellIcon` VALUES (152,"Interface\\Icons\\Spell_Shadow_Requiem");
        INSERT INTO `SpellIcon` VALUES (153,"Interface\\Icons\\Spell_Shadow_LifeDrain");
        INSERT INTO `SpellIcon` VALUES (154,"Interface\\Icons\\Spell_Shadow_DarkRitual");
        INSERT INTO `SpellIcon` VALUES (155,"Interface\\Icons\\Spell_Nature_Drowsy");
        INSERT INTO `SpellIcon` VALUES (156,"Interface\\Icons\\Spell_Holy_SearingLight");
        INSERT INTO `SpellIcon` VALUES (157,"Interface\\Icons\\Ability_Hibernation");
        INSERT INTO `SpellIcon` VALUES (158,"Interface\\Icons\\Spell_Holy_Excorcism");
        INSERT INTO `SpellIcon` VALUES (159,"Interface\\Icons\\Spell_Holy_Retribution");
        INSERT INTO `SpellIcon` VALUES (160,"Interface\\Icons\\Spell_Shadow_CorpseExplode");
        INSERT INTO `SpellIcon` VALUES (161,"Interface\\Icons\\Ability_TownWatch");
        INSERT INTO `SpellIcon` VALUES (162,"Interface\\Icons\\Ability_Repair");
        INSERT INTO `SpellIcon` VALUES (163,"Interface\\Icons\\Ability_PoisonSting");
        INSERT INTO `SpellIcon` VALUES (164,"Interface\\Icons\\Spell_Shadow_Twilight");
        INSERT INTO `SpellIcon` VALUES (165,"Interface\\Icons\\Spell_Nature_ChainLightning");
        INSERT INTO `SpellIcon` VALUES (166,"Interface\\Icons\\Ability_Devour");
        INSERT INTO `SpellIcon` VALUES (167,"Interface\\Icons\\Spell_Holy_Dizzy");
        INSERT INTO `SpellIcon` VALUES (168,"Interface\\Icons\\Spell_Nature_NaturesWrath");
        INSERT INTO `SpellIcon` VALUES (169,"Interface\\Icons\\Spell_Shadow_DeathPact");
        INSERT INTO `SpellIcon` VALUES (170,"Interface\\Icons\\Spell_Shadow_DarkSummoning");
        INSERT INTO `SpellIcon` VALUES (171,"Interface\\Icons\\Ability_Spy");
        INSERT INTO `SpellIcon` VALUES (172,"Interface\\Icons\\Spell_Ice_MagicDamage");
        INSERT INTO `SpellIcon` VALUES (173,"Interface\\Icons\\Spell_Shadow_GatherShadows");
        INSERT INTO `SpellIcon` VALUES (174,"Interface\\Icons\\Spell_Nature_EarthBind");
        INSERT INTO `SpellIcon` VALUES (175,"Interface\\Icons\\Spell_Shadow_GhostKey");
        INSERT INTO `SpellIcon` VALUES (176,"Interface\\Icons\\Spell_Frost_Frostbolt");
        INSERT INTO `SpellIcon` VALUES (177,"Interface\\Icons\\Spell_Holy_AshesToAshes");
        INSERT INTO `SpellIcon` VALUES (178,"Interface\\Icons\\Spell_Shadow_ShadowWard");
        INSERT INTO `SpellIcon` VALUES (179,"Interface\\Icons\\Ability_Tracking");
        INSERT INTO `SpellIcon` VALUES (180,"Interface\\Icons\\Spell_Frost_ChainsOfIce");
        INSERT INTO `SpellIcon` VALUES (181,"Interface\\Icons\\Spell_Frost_FrostArmor02");
        INSERT INTO `SpellIcon` VALUES (182,"Interface\\Icons\\Spell_Frost_ChillingArmor");
        INSERT INTO `SpellIcon` VALUES (183,"Interface\\Icons\\Spell_Fire_FireBolt02");
        INSERT INTO `SpellIcon` VALUES (184,"Interface\\Icons\\Spell_Fire_Fireball02");
        INSERT INTO `SpellIcon` VALUES (185,"Interface\\Icons\\Spell_Fire_FlameBolt");
        INSERT INTO `SpellIcon` VALUES (186,"Interface\\Icons\\Spell_Frost_FrostBlast");
        INSERT INTO `SpellIcon` VALUES (187,"Interface\\Icons\\Spell_Frost_ChillingBlast");
        INSERT INTO `SpellIcon` VALUES (188,"Interface\\Icons\\Spell_Frost_FrostBolt02");
        INSERT INTO `SpellIcon` VALUES (189,"Interface\\Icons\\Spell_Frost_ChillingBolt");
        INSERT INTO `SpellIcon` VALUES (190,"Interface\\Icons\\Spell_Misc_Food_08");
        INSERT INTO `SpellIcon` VALUES (191,"Interface\\Icons\\Spell_Misc_ConjureManaJewel");
        INSERT INTO `SpellIcon` VALUES (192,"Interface\\Icons\\Spell_Fire_SunKey");
        INSERT INTO `SpellIcon` VALUES (193,"Interface\\Icons\\Spell_Frost_FrostNova");
        INSERT INTO `SpellIcon` VALUES (194,"Interface\\Icons\\Spell_Nature_NullifyPoison");
        INSERT INTO `SpellIcon` VALUES (195,"Interface\\Icons\\Spell_Nature_RemoveCurse");
        INSERT INTO `SpellIcon` VALUES (196,"Interface\\Icons\\Spell_Nature_RemoveDisease");
        INSERT INTO `SpellIcon` VALUES (197,"Interface\\Icons\\Spell_Nature_ResistNature");
        INSERT INTO `SpellIcon` VALUES (198,"Interface\\Icons\\Spell_Nature_SpiritArmor");
        INSERT INTO `SpellIcon` VALUES (199,"Interface\\Icons\\Spell_Nature_ThunderClap");
        INSERT INTO `SpellIcon` VALUES (200,"Interface\\Icons\\Spell_Nature_UndyingStrength");
        INSERT INTO `SpellIcon` VALUES (201,"Interface\\Icons\\Ability_Physical_Taunt");
        INSERT INTO `SpellIcon` VALUES (202,"Interface\\Icons\\Racial_Dwarf_FindTreasure");
        INSERT INTO `SpellIcon` VALUES (203,"Interface\\Icons\\Spell_Holy_HarmUndeadAura");
        INSERT INTO `SpellIcon` VALUES (204,"Interface\\Icons\\Spell_Holy_RetributionAura");
        INSERT INTO `SpellIcon` VALUES (205,"Interface\\Icons\\Spell_Holy_RighteousFury");
        INSERT INTO `SpellIcon` VALUES (206,"Interface\\Icons\\Spell_Holy_RighteousnessAura");
        INSERT INTO `SpellIcon` VALUES (207,"Interface\\Icons\\Spell_Shadow_AntiShadow");
        INSERT INTO `SpellIcon` VALUES (208,"Interface\\Icons\\Spell_Shadow_BurningSpirit");
        INSERT INTO `SpellIcon` VALUES (209,"Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility");
        INSERT INTO `SpellIcon` VALUES (210,"Interface\\Icons\\Spell_Shadow_DetectInvisibility");
        INSERT INTO `SpellIcon` VALUES (211,"Interface\\Icons\\Spell_Shadow_ImpPhaseShift");
        INSERT INTO `SpellIcon` VALUES (212,"Interface\\Icons\\Spell_Shadow_ManaBurn");
        INSERT INTO `SpellIcon` VALUES (213,"Interface\\Icons\\Spell_Shadow_ShadowBolt");
        INSERT INTO `SpellIcon` VALUES (214,"Interface\\Icons\\Spell_Shadow_SummonFelHunter");
        INSERT INTO `SpellIcon` VALUES (215,"Interface\\Icons\\Spell_Shadow_SummonImp");
        INSERT INTO `SpellIcon` VALUES (216,"Interface\\Icons\\Spell_Shadow_SummonSuccubus");
        INSERT INTO `SpellIcon` VALUES (217,"Interface\\Icons\\Spell_Shadow_SummonVoidWalker");
        INSERT INTO `SpellIcon` VALUES (218,"Interface\\Icons\\Ability_ImpalingBolt");
        INSERT INTO `SpellIcon` VALUES (219,"Interface\\Icons\\Ability_PierceDamage");
        INSERT INTO `SpellIcon` VALUES (220,"Interface\\Icons\\Spell_Nature_Cyclone");
        INSERT INTO `SpellIcon` VALUES (221,"Interface\\Icons\\Spell_Shadow_AnimateDead");
        INSERT INTO `SpellIcon` VALUES (222,"Interface\\Icons\\Spell_Shadow_NightOfTheDead");
        INSERT INTO `SpellIcon` VALUES (223,"Interface\\Icons\\Spell_Orc_Omniscience");
        INSERT INTO `SpellIcon` VALUES (224,"Spells\\Icon\\Spell_Fire_Fire");
        INSERT INTO `SpellIcon` VALUES (225,"Interface\\Icons\\Spell_Nature_StarFall");
        INSERT INTO `SpellIcon` VALUES (226,"Interface\\Icons\\INV_Potion_19");
        INSERT INTO `SpellIcon` VALUES (227,"Interface\\Icons\\INV_Misc_Bag_11");
        INSERT INTO `SpellIcon` VALUES (228,"Interface\\Icons\\Spell_Shadow_GrimWard");
        INSERT INTO `SpellIcon` VALUES (229,"Interface\\Icons\\Spell_Nature_MirrorImage");
        INSERT INTO `SpellIcon` VALUES (230,"Interface\\Icons\\INV_Boots_03");
        INSERT INTO `SpellIcon` VALUES (231,"Interface\\Icons\\INV_Misc_Food_24");
        INSERT INTO `SpellIcon` VALUES (232,"Interface\\Icons\\Spell_Holy_Silence");
        INSERT INTO `SpellIcon` VALUES (233,"Interface\\Icons\\Spell_Shadow_Fumble");
        INSERT INTO `SpellIcon` VALUES (234,"Interface\\Icons\\Spell_Shadow_ShadowWordPain");
        INSERT INTO `SpellIcon` VALUES (235,"Interface\\Icons\\Spell_Shadow_ShadowWordDominate");
        INSERT INTO `SpellIcon` VALUES (236,"Interface\\Icons\\Spell_Holy_RemoveCurse");
        INSERT INTO `SpellIcon` VALUES (237,"Interface\\Icons\\Spell_Holy_HolySmite");
        INSERT INTO `SpellIcon` VALUES (238,"Interface\\Icons\\Spell_Holy_BlessingOfStamina");
        INSERT INTO `SpellIcon` VALUES (239,"Interface\\Icons\\Spell_Holy_BlessingOfStrength");
        INSERT INTO `SpellIcon` VALUES (240,"Interface\\Icons\\Spell_Holy_BlessingOfAgility");
        INSERT INTO `SpellIcon` VALUES (241,"Interface\\Icons\\Spell_Holy_GreaterHeal");
        INSERT INTO `SpellIcon` VALUES (242,"Interface\\Icons\\Spell_Holy_FlashHeal");
        INSERT INTO `SpellIcon` VALUES (243,"Interface\\Icons\\Ability_BackStab");
        INSERT INTO `SpellIcon` VALUES (244,"Interface\\Icons\\Ability_CheapShot");
        INSERT INTO `SpellIcon` VALUES (245,"Interface\\Icons\\Ability_Gouge");
        INSERT INTO `SpellIcon` VALUES (246,"Interface\\Icons\\Ability_Kick");
        INSERT INTO `SpellIcon` VALUES (247,"Interface\\Icons\\Ability_Poisons");
        INSERT INTO `SpellIcon` VALUES (248,"Interface\\Icons\\INV_Potion_12");
        INSERT INTO `SpellIcon` VALUES (249,"Interface\\Icons\\Ability_Sap");
        INSERT INTO `SpellIcon` VALUES (250,"Interface\\Icons\\Ability_Stealth");
        INSERT INTO `SpellIcon` VALUES (251,"Interface\\Icons\\Ability_Throw");
        INSERT INTO `SpellIcon` VALUES (252,"Interface\\Icons\\Ability_Vanish");
        INSERT INTO `SpellIcon` VALUES (253,"Interface\\Icons\\Ability_Hunter_AimedShot");
        INSERT INTO `SpellIcon` VALUES (254,"Interface\\Icons\\Ability_Hunter_BeastSooth");
        INSERT INTO `SpellIcon` VALUES (255,"Interface\\Icons\\Ability_Hunter_BeastTaming");
        INSERT INTO `SpellIcon` VALUES (256,"Interface\\Icons\\Ability_Hunter_CriticalShot");
        INSERT INTO `SpellIcon` VALUES (257,"Interface\\Icons\\Ability_Hunter_SwiftStrike");
        INSERT INTO `SpellIcon` VALUES (258,"Interface\\Icons\\INV_Misc_Food_08");
        INSERT INTO `SpellIcon` VALUES (259,"Interface\\Icons\\INV_Misc_Food_12");
        INSERT INTO `SpellIcon` VALUES (260,"Interface\\Icons\\INV_Misc_Food_11");
        INSERT INTO `SpellIcon` VALUES (261,"Interface\\Icons\\Ability_Druid_Maul");
        INSERT INTO `SpellIcon` VALUES (262,"Interface\\Icons\\Ability_Druid_Rake");
        INSERT INTO `SpellIcon` VALUES (263,"Interface\\Icons\\Spell_Nature_AbolishMagic");
        INSERT INTO `SpellIcon` VALUES (264,"Interface\\Icons\\Spell_Nature_NullifyDisease");
        INSERT INTO `SpellIcon` VALUES (265,"Interface\\Icons\\Spell_Nature_NullifyPoison_02");
        INSERT INTO `SpellIcon` VALUES (266,"Interface\\Icons\\Spell_Nature_ProtectionformNature");
        INSERT INTO `SpellIcon` VALUES (267,"Interface\\Icons\\Ability_Hunter_MendPet");
        INSERT INTO `SpellIcon` VALUES (268,"Interface\\Icons\\INV_Misc_Ale_01");
        INSERT INTO `SpellIcon` VALUES (269,"Interface\\Icons\\INV_Weapon_Crossbow_01");
        INSERT INTO `SpellIcon` VALUES (270,"Interface\\Icons\\INV_Ore_Tin_01");
        INSERT INTO `SpellIcon` VALUES (271,"Interface\\Icons\\INV_Misc_Birdbeck_02");
        INSERT INTO `SpellIcon` VALUES (272,"Interface\\Icons\\Spell_Nature_Web");
        INSERT INTO `SpellIcon` VALUES (273,"Interface\\Icons\\INV_Misc_EmptyFlask_01");
        INSERT INTO `SpellIcon` VALUES (274,"Interface\\Icons\\INV_Musket_03");
        INSERT INTO `SpellIcon` VALUES (275,"Interface\\Icons\\INV_Musket_04");
        INSERT INTO `SpellIcon` VALUES (276,"Interface\\Icons\\Ability_Warrior_DefensiveStance");
        INSERT INTO `SpellIcon` VALUES (277,"Interface\\Icons\\Ability_Warrior_Cleave");
        INSERT INTO `SpellIcon` VALUES (278,"Interface\\Icons\\Ability_Warrior_Challange");
        INSERT INTO `SpellIcon` VALUES (279,"Interface\\Icons\\Ability_Warrior_OffensiveStance");
        INSERT INTO `SpellIcon` VALUES (280,"Interface\\Icons\\Ability_Warrior_ShieldBash");
        INSERT INTO `SpellIcon` VALUES (281,"Interface\\Icons\\Ability_Warrior_ShieldWall");
        INSERT INTO `SpellIcon` VALUES (282,"Interface\\Icons\\Ability_Warrior_WarCry");
        INSERT INTO `SpellIcon` VALUES (283,"Interface\\Icons\\INV_Misc_Gem_Stone_01");
        INSERT INTO `SpellIcon` VALUES (284,"Interface\\Icons\\INV_Stone_04");
        INSERT INTO `SpellIcon` VALUES (285,"Interface\\Icons\\Spell_Frost_IceStorm");
        INSERT INTO `SpellIcon` VALUES (286,"Interface\\Icons\\INV_Staff_08");
        INSERT INTO `SpellIcon` VALUES (287,"Interface\\Icons\\INV_Misc_Orb_03");
        INSERT INTO `SpellIcon` VALUES (288,"Interface\\Icons\\INV_Ammo_Arrow_02");
        INSERT INTO `SpellIcon` VALUES (289,"Interface\\Icons\\INV_Misc_Bowl_01");
        INSERT INTO `SpellIcon` VALUES (290,"Interface\\Icons\\INV_ThrowingKnife_03");
        INSERT INTO `SpellIcon` VALUES (291,"Interface\\Icons\\Spell_Holy_DevotionAura");
        INSERT INTO `SpellIcon` VALUES (292,"Interface\\Icons\\Spell_Holy_Excorcism_02");
        INSERT INTO `SpellIcon` VALUES (293,"Interface\\Icons\\INV_Misc_Head_Tiger_01");
        INSERT INTO `SpellIcon` VALUES (294,"Interface\\Icons\\INV_Wand_01");
        INSERT INTO `SpellIcon` VALUES (295,"Interface\\Icons\\INV_Wand_02");
        INSERT INTO `SpellIcon` VALUES (296,"Interface\\Icons\\INV_Staff_03");
        INSERT INTO `SpellIcon` VALUES (297,"Interface\\Icons\\INV_Chest_Plate02");
        INSERT INTO `SpellIcon` VALUES (298,"Interface\\Icons\\Spell_Holy_FistOfJustice");
        INSERT INTO `SpellIcon` VALUES (299,"Interface\\Icons\\Spell_Holy_HealingAura");
        INSERT INTO `SpellIcon` VALUES (300,"Interface\\Icons\\Spell_Holy_Purify");
        INSERT INTO `SpellIcon` VALUES (301,"Interface\\Icons\\Spell_Holy_SealOfFury");
        INSERT INTO `SpellIcon` VALUES (302,"Interface\\Icons\\Spell_Holy_SealOfMight");
        INSERT INTO `SpellIcon` VALUES (303,"Interface\\Icons\\Spell_Holy_SealOfProtection");
        INSERT INTO `SpellIcon` VALUES (304,"Interface\\Icons\\Spell_Holy_SealOfRighteousness");
        INSERT INTO `SpellIcon` VALUES (305,"Interface\\Icons\\Spell_Holy_SealOfSalvation");
        INSERT INTO `SpellIcon` VALUES (306,"Interface\\Icons\\Spell_Holy_SealOfWisdom");
        INSERT INTO `SpellIcon` VALUES (307,"Interface\\Icons\\Spell_Holy_SealOfWrath");
        INSERT INTO `SpellIcon` VALUES (308,"Interface\\Icons\\Spell_Holy_SenseUndead");
        INSERT INTO `SpellIcon` VALUES (309,"Interface\\Icons\\Spell_Holy_TurnUndead");
        INSERT INTO `SpellIcon` VALUES (310,"Interface\\Icons\\Spell_Nature_Sentinal");
        INSERT INTO `SpellIcon` VALUES (311,"Interface\\Icons\\INV_Misc_MonsterFang_01");
        INSERT INTO `SpellIcon` VALUES (312,"Interface\\Icons\\Spell_Nature_UnyeildingStamina");
        INSERT INTO `SpellIcon` VALUES (313,"Interface\\Icons\\Spell_Shadow_AbominationExplosion");
        INSERT INTO `SpellIcon` VALUES (314,"Interface\\Icons\\INV_Gauntlets_05");
        INSERT INTO `SpellIcon` VALUES (315,"Interface\\Icons\\INV_Jewelry_Talisman_01");
        INSERT INTO `SpellIcon` VALUES (316,"Interface\\Icons\\Spell_Holy_PrayerOfHealing");
        INSERT INTO `SpellIcon` VALUES (317,"Interface\\Icons\\Spell_Magic_PolymorphPig");
        INSERT INTO `SpellIcon` VALUES (318,"Interface\\Icons\\Spell_Magic_PolymorphChicken");
        INSERT INTO `SpellIcon` VALUES (319,"Interface\\Icons\\INV_Scroll_02");
        INSERT INTO `SpellIcon` VALUES (320,"Interface\\Icons\\Spell_Lightning_LightningBolt01");
        INSERT INTO `SpellIcon` VALUES (321,"Interface\\Icons\\Spell_Holy_Renew");
        INSERT INTO `SpellIcon` VALUES (322,"Interface\\Icons\\INV_Mace_12");
        INSERT INTO `SpellIcon` VALUES (323,"Interface\\Icons\\INV_Misc_LeatherScrap_08");
        INSERT INTO `SpellIcon` VALUES (324,"Interface\\Icons\\INV_Fabric_Silk_02");
        INSERT INTO `SpellIcon` VALUES (325,"Interface\\Icons\\INV_Misc_Wrench_02");
        INSERT INTO `SpellIcon` VALUES (326,"Interface\\Icons\\INV_Misc_ArmorKit_17");
        INSERT INTO `SpellIcon` VALUES (327,"Interface\\Icons\\INV_Potion_14");
        INSERT INTO `SpellIcon` VALUES (328,"Interface\\Icons\\INV_Axe_04");
        INSERT INTO `SpellIcon` VALUES (329,"Interface\\Icons\\Spell_Holy_HolyProtection");
        INSERT INTO `SpellIcon` VALUES (330,"Interface\\Icons\\Spell_Holy_NullifyDisease");
        INSERT INTO `SpellIcon` VALUES (331,"Interface\\Icons\\Spell_Magic_LesserInvisibilty");
        INSERT INTO `SpellIcon` VALUES (332,"Interface\\Icons\\Spell_Magic_MageArmor");
        INSERT INTO `SpellIcon` VALUES (333,"Interface\\Icons\\Trade_Engineering");
        INSERT INTO `SpellIcon` VALUES (334,"Interface\\Icons\\Spell_Nature_AgitatingTotem");
        INSERT INTO `SpellIcon` VALUES (335,"Interface\\Icons\\Trade_BlackSmithing");
        INSERT INTO `SpellIcon` VALUES (336,"Interface\\Icons\\Trade_Mining");
        INSERT INTO `SpellIcon` VALUES (337,"Interface\\Icons\\Spell_Nature_InvisibilityTotem");
        INSERT INTO `SpellIcon` VALUES (338,"Interface\\Icons\\Spell_Nature_ManaRegenTotem");
        INSERT INTO `SpellIcon` VALUES (339,"Interface\\Icons\\Trade_Alchemy");
        INSERT INTO `SpellIcon` VALUES (340,"Interface\\Icons\\Spell_Nature_SlowingTotem");
        INSERT INTO `SpellIcon` VALUES (341,"Interface\\Icons\\Trade_Tailoring");
        INSERT INTO `SpellIcon` VALUES (342,"Interface\\Icons\\Trade_BrewPoison");
        INSERT INTO `SpellIcon` VALUES (343,"Interface\\Icons\\INV_Misc_Key_04");
        INSERT INTO `SpellIcon` VALUES (344,"Interface\\Icons\\INV_Misc_Gem_Sapphire_01");
        INSERT INTO `SpellIcon` VALUES (345,"Interface\\Icons\\Trade_Herbalism");
        INSERT INTO `SpellIcon` VALUES (346,"Interface\\Icons\\Trade_LeatherWorking");
        INSERT INTO `SpellIcon` VALUES (347,"Interface\\Icons\\INV_Misc_Shell_03");
        INSERT INTO `SpellIcon` VALUES (348,"Interface\\Icons\\INV_Potion_01");
        INSERT INTO `SpellIcon` VALUES (349,"Interface\\Icons\\INV_Misc_Shell_02");
        INSERT INTO `SpellIcon` VALUES (350,"Interface\\Icons\\INV_Misc_Dust_02");
        INSERT INTO `SpellIcon` VALUES (351,"Interface\\Icons\\INV_Misc_Ammo_Gunpowder_02");
        INSERT INTO `SpellIcon` VALUES (352,"Interface\\Icons\\INV_Orb_Arcanite_01");
        INSERT INTO `SpellIcon` VALUES (353,"Interface\\Icons\\INV_Misc_Gear_01");
        INSERT INTO `SpellIcon` VALUES (354,"Interface\\Icons\\INV_Cask_01");
        INSERT INTO `SpellIcon` VALUES (355,"Interface\\Icons\\INV_Misc_Bomb_05");
        INSERT INTO `SpellIcon` VALUES (356,"Interface\\Icons\\INV_Misc_StoneTablet_04");
        INSERT INTO `SpellIcon` VALUES (357,"Interface\\Icons\\INV_Scroll_05");
        INSERT INTO `SpellIcon` VALUES (358,"Interface\\Icons\\INV_Misc_Fork&Knife");
        INSERT INTO `SpellIcon` VALUES (359,"Interface\\Icons\\INV_Misc_EmptyFlask_02");
        INSERT INTO `SpellIcon` VALUES (360,"Interface\\Icons\\INV_Flask_02");
        INSERT INTO `SpellIcon` VALUES (361,"Interface\\Icons\\INV_Flask_05");
        INSERT INTO `SpellIcon` VALUES (362,"Interface\\Icons\\INV_Wine_01");
        INSERT INTO `SpellIcon` VALUES (363,"Interface\\Icons\\INV_Misc_Cape_18");
        INSERT INTO `SpellIcon` VALUES (364,"Interface\\Icons\\INV_Weapon_Bow_05");
        INSERT INTO `SpellIcon` VALUES (365,"Interface\\Icons\\INV_Weapon_Halberd_06");
        INSERT INTO `SpellIcon` VALUES (366,"Interface\\Icons\\INV_Axe_09");
        INSERT INTO `SpellIcon` VALUES (367,"Interface\\Icons\\INV_Mace_01");
        INSERT INTO `SpellIcon` VALUES (368,"Interface\\Icons\\INV_Sword_04");
        INSERT INTO `SpellIcon` VALUES (369,"Interface\\Icons\\INV_Sword_06");
        INSERT INTO `SpellIcon` VALUES (370,"Interface\\Icons\\INV_Spear_05");
        INSERT INTO `SpellIcon` VALUES (371,"Interface\\Icons\\INV_Axe_17");
        INSERT INTO `SpellIcon` VALUES (372,"Interface\\Icons\\INV_Gauntlets_06");
        INSERT INTO `SpellIcon` VALUES (373,"Interface\\Icons\\INV_Misc_Pipe_01");
        INSERT INTO `SpellIcon` VALUES (374,"Interface\\Icons\\INV_Misc_Food_09");
        INSERT INTO `SpellIcon` VALUES (393,"Interface\\Icons\\INV_Weapon_Rifle_01");
        INSERT INTO `SpellIcon` VALUES (413,"Interface\\Icons\\INV_Shield_05");
        INSERT INTO `SpellIcon` VALUES (433,"Interface\\Icons\\INV_Banner_03");
        INSERT INTO `SpellIcon` VALUES (434,"Interface\\Icons\\INV_ThrowingKnife_05");
        INSERT INTO `SpellIcon` VALUES (435,"Interface\\Icons\\INV_Mace_04");
        INSERT INTO `SpellIcon` VALUES (436,"Interface\\Icons\\INV_Weapon_Bow_02");
        INSERT INTO `SpellIcon` VALUES (437,"Interface\\Icons\\INV_Axe_13");
        INSERT INTO `SpellIcon` VALUES (438,"Interface\\Icons\\INV_Sword_26");
        INSERT INTO `SpellIcon` VALUES (439,"Interface\\Icons\\INV_Hammer_03");
        INSERT INTO `SpellIcon` VALUES (440,"Interface\\Icons\\INV_Shield_04");
        INSERT INTO `SpellIcon` VALUES (441,"Interface\\Icons\\INV_Axe_16");
        INSERT INTO `SpellIcon` VALUES (442,"Interface\\Icons\\INV_Stone_01");
        INSERT INTO `SpellIcon` VALUES (443,"Interface\\Icons\\INV_Axe_11");
        INSERT INTO `SpellIcon` VALUES (444,"Interface\\Icons\\INV_Chest_Plate01");
        INSERT INTO `SpellIcon` VALUES (453,"Interface\\Icons\\Spell_Holy_BlessingOfProtection");
        INSERT INTO `SpellIcon` VALUES (454,"Interface\\Icons\\Ability_Hunter_BeastSoothe");
        INSERT INTO `SpellIcon` VALUES (455,"Interface\\Icons\\Ability_Hunter_BeastCall");
        INSERT INTO `SpellIcon` VALUES (456,"Interface\\Icons\\Ability_Warrior_BattleShout");
        INSERT INTO `SpellIcon` VALUES (457,"Interface\\Icons\\Ability_Warrior_Charge");
        INSERT INTO `SpellIcon` VALUES (458,"Interface\\Icons\\Spell_Nature_AstralRecal");
        INSERT INTO `SpellIcon` VALUES (459,"Interface\\Icons\\Spell_Nature_AstralRecalGroup");
        INSERT INTO `SpellIcon` VALUES (460,"Interface\\Icons\\Spell_Shadow_SummonInfernal");
        INSERT INTO `SpellIcon` VALUES (473,"Interface\\Icons\\Ability_Druid_Bash");
        INSERT INTO `SpellIcon` VALUES (493,"Interface\\Icons\\Ability_Druid_CatForm");
        INSERT INTO `SpellIcon` VALUES (494,"Interface\\Icons\\Ability_Druid_Disembowel");
        INSERT INTO `SpellIcon` VALUES (495,"Interface\\Icons\\Ability_Druid_SupriseAttack");
        INSERT INTO `SpellIcon` VALUES (496,"Interface\\Icons\\Ability_Druid_Swipe");
        INSERT INTO `SpellIcon` VALUES (497,"Interface\\Icons\\Ability_Rogue_Disguise");
        INSERT INTO `SpellIcon` VALUES (498,"Interface\\Icons\\Ability_Rogue_Garrote");
        INSERT INTO `SpellIcon` VALUES (499,"Interface\\Icons\\Ability_Rogue_KidneyShot");
        INSERT INTO `SpellIcon` VALUES (500,"Interface\\Icons\\Ability_Rogue_Rupture");
        INSERT INTO `SpellIcon` VALUES (501,"Interface\\Icons\\Spell_Frost_FrostWard");
        INSERT INTO `SpellIcon` VALUES (502,"Interface\\Icons\\Spell_Holy_MindVision");
        INSERT INTO `SpellIcon` VALUES (503,"Interface\\Icons\\Spell_Holy_Redemption");
        INSERT INTO `SpellIcon` VALUES (504,"Interface\\Icons\\Spell_Holy_SealOfSacrifice");
        INSERT INTO `SpellIcon` VALUES (505,"Interface\\Icons\\Spell_Magic_FeatherFall");
        INSERT INTO `SpellIcon` VALUES (513,"Interface\\Icons\\Ability_Rogue_DualWeild");
        INSERT INTO `SpellIcon` VALUES (514,"Interface\\Icons\\Ability_Rogue_Eviscerate");
        INSERT INTO `SpellIcon` VALUES (515,"Interface\\Icons\\Ability_Rogue_SliceDice");
        INSERT INTO `SpellIcon` VALUES (516,"Interface\\Icons\\Ability_Rogue_Sprint");
        INSERT INTO `SpellIcon` VALUES (517,"Interface\\Icons\\Ability_Rogue_Trip");
        INSERT INTO `SpellIcon` VALUES (518,"Interface\\Icons\\INV_Poison_MindNumbing");
        INSERT INTO `SpellIcon` VALUES (533,"Interface\\Icons\\Ability_DualWield");
        INSERT INTO `SpellIcon` VALUES (534,"Interface\\Icons\\Ability_Hunter_BeastTraining");
        INSERT INTO `SpellIcon` VALUES (535,"Interface\\Icons\\Ability_Hunter_Pathfinding");
        INSERT INTO `SpellIcon` VALUES (536,"Interface\\Icons\\Ability_Hunter_Quickshot");
        INSERT INTO `SpellIcon` VALUES (537,"Interface\\Icons\\Ability_Hunter_RunningShot");
        INSERT INTO `SpellIcon` VALUES (538,"Interface\\Icons\\Ability_Hunter_SniperShot");
        INSERT INTO `SpellIcon` VALUES (539,"Interface\\Icons\\Ability_Rogue_Feint");
        INSERT INTO `SpellIcon` VALUES (540,"Interface\\Icons\\Spell_Holy_PrayerOfHealing02");
        INSERT INTO `SpellIcon` VALUES (541,"Interface\\Icons\\Spell_Shadow_BloodBoil");
        INSERT INTO `SpellIcon` VALUES (542,"Interface\\Icons\\Spell_Shadow_CurseOfAchimonde");
        INSERT INTO `SpellIcon` VALUES (543,"Interface\\Icons\\Spell_Shadow_CurseOfMannoroth");
        INSERT INTO `SpellIcon` VALUES (544,"Interface\\Icons\\Spell_Shadow_CurseOfSargeras");
        INSERT INTO `SpellIcon` VALUES (545,"Interface\\Icons\\Spell_Shadow_DemonBreath");
        INSERT INTO `SpellIcon` VALUES (546,"Interface\\Icons\\Spell_Shadow_LifeDrain02");
        INSERT INTO `SpellIcon` VALUES (547,"Interface\\Icons\\Spell_Shadow_RainOfFire");
        INSERT INTO `SpellIcon` VALUES (548,"Interface\\Icons\\Spell_Shadow_SiphonMana");
        INSERT INTO `SpellIcon` VALUES (553,"Interface\\Icons\\Ability_Racial_Ultravision");
        INSERT INTO `SpellIcon` VALUES (554,"Interface\\Icons\\INV_Misc_Orb_04");
        INSERT INTO `SpellIcon` VALUES (555,"Interface\\Icons\\Spell_Holy_AuraOfLight");
        INSERT INTO `SpellIcon` VALUES (556,"Interface\\Icons\\INV_Food_Egg_02");
        INSERT INTO `SpellIcon` VALUES (557,"Interface\\Icons\\INV_Wine_03");
        INSERT INTO `SpellIcon` VALUES (558,"Interface\\Icons\\Ability_Parry");
        INSERT INTO `SpellIcon` VALUES (559,"Interface\\Icons\\Ability_Warrior_DecisiveStrike");
        INSERT INTO `SpellIcon` VALUES (560,"Interface\\Icons\\Ability_Warrior_Disarm");
        INSERT INTO `SpellIcon` VALUES (561,"Interface\\Icons\\Ability_Warrior_InnerRage");
        INSERT INTO `SpellIcon` VALUES (562,"Interface\\Icons\\Ability_Warrior_Revenge");
        INSERT INTO `SpellIcon` VALUES (563,"Interface\\Icons\\Ability_Warrior_Riposte");
        INSERT INTO `SpellIcon` VALUES (564,"Interface\\Icons\\Ability_Warrior_SavageBlow");
        INSERT INTO `SpellIcon` VALUES (565,"Interface\\Icons\\Ability_Warrior_Sunder");
        INSERT INTO `SpellIcon` VALUES (566,"Interface\\Icons\\Spell_Holy_PowerWordShield");
        INSERT INTO `SpellIcon` VALUES (576,"Interface\\Icons\\INV_Misc_Fish_05");
        INSERT INTO `SpellIcon` VALUES (577,"Interface\\Icons\\INV_Misc_Fish_06");
        INSERT INTO `SpellIcon` VALUES (578,"Interface\\Icons\\Trade_Engraving");
        INSERT INTO `SpellIcon` VALUES (579,"Interface\\Icons\\INV_Staff_Goldfeathered_01");
        INSERT INTO `SpellIcon` VALUES (580,"Interface\\Icons\\Trade_Fishing");
        INSERT INTO `SpellIcon` VALUES (596,"Interface\\Icons\\Spell_Shadow_Curse");
        INSERT INTO `SpellIcon` VALUES (597,"Interface\\Icons\\INV_Misc_MonsterHead_03");
        INSERT INTO `SpellIcon` VALUES (598,"Interface\\Icons\\INV_Staff_01");
        INSERT INTO `SpellIcon` VALUES (599,"Interface\\Icons\\INV_Misc_Bone_09");
        INSERT INTO `SpellIcon` VALUES (600,"Interface\\Icons\\INV_Misc_Bone_06");

        insert into applied_updates values ('210820221');
    end if;

    -- 05/11/2022 1
    if (select count(*) from applied_updates where id='051120221') = 0 then
        -- Taken from the 0.5.5 client.
        ALTER TABLE `Spell` ADD COLUMN `custom_DispelType` INT(4) NOT NULL DEFAULT 0;

        UPDATE Spell SET custom_DispelType = 1 WHERE ID IN (11, 16, 17, 65, 89, 91, 94, 109, 113, 114, 118, 122, 130, 131, 132, 134, 139, 168, 172, 179, 184, 228, 246, 255, 302, 308, 324, 325, 339, 344, 348, 365, 379, 409, 410, 411, 424, 451, 456, 457, 467, 474, 503, 507, 509, 512, 527, 530, 543, 544, 546, 549, 550, 553, 554, 586, 588, 589, 590, 592, 593, 594, 595, 599, 600, 602, 604, 605, 606, 629, 630, 634, 636, 637, 638, 640, 641, 644, 645, 646, 648, 675, 687, 689, 696, 699, 700, 706, 707, 709, 710, 761, 762, 770, 774, 776, 778, 782, 802, 806, 835, 839, 841, 847, 849, 851, 855, 861, 863, 865, 867, 877, 901, 903, 905, 909, 911, 917, 934, 937, 945, 947, 949, 955, 957, 963, 970, 972, 974, 976, 978, 986, 992, 994, 998, 1000, 1006, 1008, 1018, 1019, 1022, 1024, 1028, 1030, 1034, 1036, 1038, 1044, 1048, 1050, 1052, 1058, 1062, 1069, 1075, 1086, 1090, 1092, 1094, 1098, 1110, 1112, 1116, 1126, 1138, 1139, 1184, 1243, 1244, 1245, 1430, 1449, 1450, 1451, 1452, 1453, 1457, 1459, 1460, 1461, 1462, 1463, 1465, 1466, 1663, 1664, 1665, 1706, 1707, 1945, 2090, 2091, 2096, 2140, 2351, 2353, 2354, 2367, 2374, 2375, 2376, 2377, 2378, 2379, 2380, 2381, 2537, 2601, 2602, 2645, 2647, 2767, 2768, 2770, 2771, 2791, 2808, 2809, 2852, 2854, 2864, 2866, 2867, 2887, 2888, 2893, 2894, 2895, 2908, 2912, 2937, 2941, 2943, 2944, 2947, 2970, 3019, 3109, 3130, 3132, 3136, 3143, 3145, 3152, 3156, 3157, 3158, 3159, 3160, 3161, 3162, 3163, 3164, 3165, 3166, 3167, 3168, 3169, 3204, 3229, 3233, 3247, 3250, 3253, 3258, 3261, 3263, 3264, 3265, 3269, 3272, 3291, 3327, 3356, 3369, 3374, 3389, 3416, 3442, 3443, 3477, 3542, 3558, 3574, 3590, 3593, 3600, 3602, 3610, 3619, 3622, 3623, 3624, 3627, 3631, 3635, 3636, 3651, 3742, 3747, 3825, 3826, 4057, 4063, 4077, 4318, 4320, 4432, 4955, 4956, 4979, 4980, 5106, 5115, 5116, 5132, 5138, 5142, 5195, 5196, 5198, 5207, 5229, 5232, 5234, 5236, 5254, 5257, 5262, 5276, 5320, 5321, 5322, 5323, 5324, 5325, 5388, 5391, 5403, 5514, 5515, 5567, 5575, 5580, 5581, 5599, 5601, 5602, 5628, 5645, 5665, 5679, 5697, 5704, 5732, 5782, 5862, 5864, 5917, 6065, 6066, 6069, 6074, 6075, 6076, 6077, 6078, 6114, 6117, 6118, 6119, 6123, 6131, 6134, 6135, 6136, 6143, 6146, 6213, 6215, 6222, 6223, 6226, 6229, 6230, 6241, 6242, 6279, 6308, 6344, 6358, 6388, 6431, 6469, 6512, 6513, 6526, 6528, 6532, 6605, 6606, 6726, 6728, 6739, 6742, 6756, 6797, 6820, 6821, 6822, 6823, 6844, 6864, 6866, 6867, 6870, 6871, 6873, 6874, 6894, 6914, 6915, 6940, 6942, 6950, 6957, 6960, 6984, 6985, 7020, 7024, 7074, 7093, 7094, 7127, 7128, 7140, 7178, 7202, 7230, 7231, 7232, 7233, 7234, 7235, 7236, 7237, 7238, 7239, 7240, 7241, 7242, 7243, 7244, 7245, 7246, 7247, 7248, 7249, 7250, 7251, 7252, 7253, 7254, 7272, 7273, 7282, 7288, 7290, 7293, 7295, 7300, 7301, 7302, 7320, 7321, 7325, 7383, 7396, 7399, 7645, 7648, 7651, 7656, 7727, 7739, 7740, 7761, 7840, 7844, 7870, 7891);
        UPDATE Spell SET custom_DispelType = 6 WHERE ID IN (66, 885, 3680, 4079);
        UPDATE Spell SET custom_DispelType = 2 WHERE ID IN (603, 702, 704, 801, 805, 980, 1010, 1014, 1108, 1490, 1714, 3105, 3236, 3237, 3360, 3387, 4060, 4974, 5137, 5261, 5271, 5737, 5884, 6205, 6217, 6767, 6909, 6912, 6922, 6946, 7038, 7039, 7040, 7041, 7042, 7043, 7044, 7045, 7046, 7047, 7048, 7049, 7050, 7051, 7052, 7053, 7054, 7057, 7068, 7098, 7099, 7124, 7289, 7298, 7299, 7621, 7646, 7658, 7659, 7713);
        UPDATE Spell SET custom_DispelType = 4 WHERE ID IN (744, 773, 1056, 2094, 2818, 2819, 3332, 3358, 3388, 3396, 3409, 3410, 3424, 3583, 3609, 3640, 3815, 4286, 4940, 5105, 5208, 5416, 5417, 5760, 6411, 6531, 6647, 6727, 6751, 6814, 6917, 7125, 7357, 7365, 7367);
        UPDATE Spell SET custom_DispelType = 3 WHERE ID IN (832, 965, 3106, 3150, 3256, 3335, 3427, 3429, 3436, 3439, 3584, 3585, 3586, 3587, 4316, 5413, 5415, 6278, 6672, 6816, 6817, 6818, 6819, 6907, 6951, 7102, 7103, 7279, 7901);
        UPDATE Spell SET custom_DispelType = 5 WHERE ID IN (1784, 1785, 1786, 1856, 5215, 5916, 6538, 6783, 7104);
        UPDATE Spell SET custom_DispelType = 8 WHERE ID IN (7084, 7657);

        INSERT INTO applied_updates VALUES ('051120221');
    end if;
	
    -- 06/11/2022 1
	-- 0.5.5: "Holy Word: Shield can now be dispelled. It is considered a Magic effect."
    if (select count(*) from applied_updates where id='061120221') = 0 then
        UPDATE `Spell` SET `custom_DispelType` = '0' WHERE ID IN (17, 592, 600, 6065, 6066, 3747);
        INSERT INTO applied_updates VALUES ('061120221');
    end if;
	
    -- 18/03/2023 1
    if (select count(*) from applied_updates where id='180320231') = 0 then
        DROP TABLE IF EXISTS `TransportAnimation`;
        CREATE TABLE IF NOT EXISTS `TransportAnimation`  (
        `ID` INT(11) UNSIGNED NOT NULL,
        `TransportID` INT(11) UNSIGNED NOT NULL,
        `TimeIndex` INT(11) UNSIGNED NOT NULL,
        `X` FLOAT NOT NULL,
        `Y` FLOAT NOT NULL,
        `Z` FLOAT NOT NULL,
        PRIMARY KEY (`ID`)
        ) COLLATE='utf8_general_ci' ENGINE = InnoDB;

        INSERT INTO `TransportAnimation` (`ID`, `TransportID`, `TimeIndex`, `X`, `Y`, `Z`) VALUES
        (86,2074,0,0.0,0.0,0.0),
        (87,2074,1033,0.0,10.087038040161133,-1.1000000085914508e-05),
        (88,2074,1767,0.0,16.7490234375,0.5287410020828247),
        (89,2074,2500,0.0,24.745222091674805,1.5653799772262573),
        (90,2074,3333,0.0,0.0,0.0),
        (135,2093,0,0.0,0.0,0.0),
        (136,2093,4400,0.0,0.0,66.7349624633789),
        (137,2093,6167,0.0,0.0,66.7349624633789),
        (138,2093,9967,0.0,0.0,0.0),
        (139,2093,11933,0.0,0.0,0.0),
        (165,2565,0,0.0,0.0,0.0),
        (166,2565,1333,-10.087038040161133,0.0,-1.1000000085914508e-05),
        (167,2565,2800,-16.7490234375,0.0,0.5287410020828247),
        (168,2565,4233,-24.745222091674805,0.0,1.5653799772262573),
        (169,2565,6633,0.0,0.0,0.0),
        (2859,4170,0,0.0,0.0,0.0),
        (2860,4170,5000,0.0,0.0,0.0),
        (2861,4170,6100,1.9999999949504854e-06,-1.9999999949504854e-06,-1.7547860145568848),
        (2862,4170,6933,4.999999873689376e-06,-4.999999873689376e-06,-5.1766557693481445),
        (2863,4170,12867,1.9999999949504854e-06,-1.9999999949504854e-06,-56.81129455566406),
        (2864,4170,13833,1.9999999949504854e-06,-1.9999999949504854e-06,-59.84600067138672),
        (2865,4170,15000,1.9999999949504854e-06,-1.9999999949504854e-06,-61.24431610107422),
        (2866,4170,20000,1.9999999949504854e-06,-1.9999999949504854e-06,-61.24431610107422),
        (2867,4170,21333,0.0,0.0,-59.83320617675781),
        (2868,4170,22233,0.0,0.0,-56.7352294921875),
        (2869,4170,28133,0.0,0.0,-5.247489929199219),
        (2870,4170,28800,0.0,0.0,-1.5850379467010498),
        (2871,4170,30033,0.0,0.0,0.0),
        (2872,4171,0,0.0,0.0,0.0),
        (2873,4171,5000,0.0,0.0,0.0),
        (2874,4171,5900,0.0,0.0,1.2011380195617676),
        (2875,4171,6667,0.0,0.0,4.690252780914307),
        (2876,4171,10567,-3.000000106112566e-06,1.9999999949504854e-06,32.55092239379883),
        (2877,4171,13100,-3.000000106112566e-06,1.9999999949504854e-06,53.4675178527832),
        (2878,4171,14067,-3.000000106112566e-06,1.9999999949504854e-06,59.58481216430664),
        (2879,4171,15000,-3.000000106112566e-06,1.9999999949504854e-06,61.49812698364258),
        (2880,4171,20000,-3.000000106112566e-06,1.9999999949504854e-06,61.49812698364258),
        (2881,4171,21000,-3.000000106112566e-06,1.9999999949504854e-06,59.54929733276367),
        (2882,4171,21800,-3.000000106112566e-06,1.9999999949504854e-06,54.273231506347656),
        (2883,4171,25267,-3.000000106112566e-06,1.9999999949504854e-06,29.10910987854004),
        (2884,4171,27933,0.0,0.0,8.591193199157715),
        (2885,4171,28967,0.0,0.0,1.9685529470443726),
        (2886,4171,30000,0.0,0.0,0.0),
        (227,4172,0,0.0,0.0,0.0),
        (228,4172,5000,0.0,0.0,0.0),
        (229,4172,6100,1.9999999949504854e-06,-1.9999999949504854e-06,-1.7547860145568848),
        (230,4172,6933,4.999999873689376e-06,-4.999999873689376e-06,-5.1766557693481445),
        (231,4172,12867,1.9999999949504854e-06,-1.9999999949504854e-06,-56.81129455566406),
        (232,4172,13833,1.9999999949504854e-06,-1.9999999949504854e-06,-59.84600067138672),
        (233,4172,15000,1.9999999949504854e-06,-1.9999999949504854e-06,-61.24431610107422),
        (234,4172,20000,1.9999999949504854e-06,-1.9999999949504854e-06,-61.24431610107422),
        (235,4172,21333,0.0,0.0,-59.83320617675781),
        (236,4172,22233,0.0,0.0,-56.7352294921875),
        (237,4172,28133,0.0,0.0,-5.247489929199219),
        (238,4172,28800,0.0,0.0,-1.5850379467010498),
        (239,4172,30033,0.0,0.0,0.0),
        (240,4173,0,0.0,0.0,0.0),
        (241,4173,5000,0.0,0.0,0.0),
        (242,4173,5900,0.0,0.0,1.2011380195617676),
        (243,4173,6667,0.0,0.0,4.690252780914307),
        (244,4173,10567,-3.000000106112566e-06,1.9999999949504854e-06,32.55092239379883),
        (245,4173,13100,-3.000000106112566e-06,1.9999999949504854e-06,53.4675178527832),
        (246,4173,14067,-3.000000106112566e-06,1.9999999949504854e-06,59.58481216430664),
        (247,4173,15000,-3.000000106112566e-06,1.9999999949504854e-06,61.49812698364258),
        (248,4173,20000,-3.000000106112566e-06,1.9999999949504854e-06,61.49812698364258),
        (249,4173,21000,-3.000000106112566e-06,1.9999999949504854e-06,59.54929733276367),
        (250,4173,21800,-3.000000106112566e-06,1.9999999949504854e-06,54.273231506347656),
        (251,4173,25267,-3.000000106112566e-06,1.9999999949504854e-06,29.10910987854004),
        (252,4173,27933,0.0,0.0,8.591193199157715),
        (253,4173,28967,0.0,0.0,1.9685529470443726),
        (254,4173,30000,0.0,0.0,0.0),
        (2887,11898,0,0.0,0.0,0.0),
        (2888,11898,5000,0.0,0.0,0.0),
        (2889,11898,6100,3.000000106112566e-06,-9.999999974752427e-07,-1.7547880411148071),
        (2890,11898,6867,6.000000212225132e-06,-1.9999999949504854e-06,-5.1766557693481445),
        (2891,11898,12867,7.000000096013537e-06,-9.999999974752427e-07,-124.86685180664062),
        (2892,11898,13833,7.000000096013537e-06,-9.999999974752427e-07,-127.90155792236328),
        (2893,11898,15000,7.000000096013537e-06,-9.999999974752427e-07,-129.2998809814453),
        (2894,11898,20000,7.000000096013537e-06,-9.999999974752427e-07,-129.2998809814453),
        (2895,11898,21333,3.999999989900971e-06,0.0,-127.88876342773438),
        (2896,11898,22233,3.999999989900971e-06,0.0,-124.79078674316406),
        (2897,11898,28133,0.0,0.0,-5.247490882873535),
        (2898,11898,28800,0.0,0.0,-1.585036039352417),
        (2899,11898,30000,0.0,0.0,0.0),
        (2900,11898,30033,3.999999989900971e-06,0.0,-68.05555725097656),
        (2901,11899,0,0.0,0.0,0.0),
        (2902,11899,5000,0.0,0.0,0.0),
        (2903,11899,5900,0.0,0.0,1.2011380195617676),
        (2904,11899,6667,0.0,0.0,4.690252780914307),
        (2905,11899,13100,-4.999999873689376e-06,-9.999999974752427e-07,121.5230712890625),
        (2906,11899,14067,-4.999999873689376e-06,-9.999999974752427e-07,127.6403579711914),
        (2907,11899,15000,-4.999999873689376e-06,-9.999999974752427e-07,129.55368041992188),
        (2908,11899,20000,-4.999999873689376e-06,-9.999999974752427e-07,129.55368041992188),
        (2909,11899,21000,-4.999999873689376e-06,-9.999999974752427e-07,127.60484313964844),
        (2910,11899,21800,-4.999999873689376e-06,-9.999999974752427e-07,122.32878875732422),
        (2911,11899,27933,0.0,0.0,8.591193199157715),
        (2912,11899,28967,0.0,0.0,1.9685529470443726),
        (2913,11899,30000,0.0,0.0,0.0),
        (9663,20649,0,0.0,0.0,0.0),
        (9664,20649,1833,0.0,0.0,-55.46577072143555),
        (9665,20649,6833,0.0,0.0,-55.46577072143555),
        (9666,20649,10333,0.0,0.0,41.035614013671875),
        (9667,20649,15167,0.0,0.0,41.035614013671875),
        (9668,20649,16667,0.0,0.0,0.0),
        (9669,20650,0,0.0,0.0,0.0),
        (9670,20650,10333,0.0,0.0,-9.999999747378752e-06),
        (9671,20650,10500,0.0,0.0,4.650018215179443),
        (9672,20650,15167,0.0,0.0,4.650018215179443),
        (9673,20650,15333,0.0,0.0,0.0),
        (9674,20650,16667,0.0,0.0,0.0),
        (9675,20651,0,0.0,0.0,0.0),
        (9676,20651,1833,0.0,0.0,0.0),
        (9677,20651,2000,0.0,0.0,8.130337715148926),
        (9678,20651,6667,0.0,0.0,8.130337715148926),
        (9679,20651,6833,0.0,0.0,0.0),
        (9680,20651,16667,0.0,0.0,0.0),
        (9681,20652,0,0.0,0.0,0.0),
        (9682,20652,167,0.0,0.0,0.0),
        (9683,20652,3667,0.0,0.0,96.50138092041016),
        (9684,20652,8500,0.0,0.0,96.50138092041016),
        (9685,20652,11833,0.0,0.0,0.0),
        (9686,20652,16667,0.0,0.0,0.0),
        (9687,20653,0,0.0,0.0,0.0),
        (9688,20653,3667,0.0,0.0,-9.999999747378752e-06),
        (9689,20653,3833,0.0,0.0,4.650018215179443),
        (9690,20653,8500,0.0,0.0,4.650018215179443),
        (9691,20653,8667,0.0,0.0,0.0),
        (9692,20653,16667,0.0,0.0,0.0),
        (9693,20654,0,0.0,0.0,0.0),
        (9694,20654,11667,0.0,0.0,0.0),
        (9695,20654,11833,0.0,0.0,8.130337715148926),
        (9696,20654,16500,0.0,0.0,8.130337715148926),
        (9697,20654,16667,0.0,0.0,0.0),
        (9698,20655,0,0.0,0.0,0.0),
        (9699,20655,167,0.0,0.0,0.0),
        (9700,20655,3500,0.0,0.0,0.0),
        (9701,20655,7000,0.0,0.0,96.50138092041016),
        (9702,20655,11833,0.0,0.0,96.50138092041016),
        (9703,20655,15167,0.0,0.0,0.0),
        (9704,20655,16667,0.0,0.0,0.0),
        (9705,20656,0,0.0,0.0,0.0),
        (9706,20656,7000,0.0,0.0,-9.999999747378752e-06),
        (9707,20656,7167,0.0,0.0,4.650018215179443),
        (9708,20656,11833,0.0,0.0,4.650018215179443),
        (9709,20656,12000,0.0,0.0,0.0),
        (9710,20656,16667,0.0,0.0,0.0),
        (9711,20657,0,0.0,0.0,0.0),
        (9712,20657,3333,0.0,0.0,0.0),
        (9713,20657,3500,0.0,0.0,-8.130337715148926),
        (9714,20657,14833,0.0,0.0,-8.130337715148926),
        (9715,20657,15000,0.0,0.0,0.0),
        (9716,20657,16667,0.0,0.0,0.0),
        (8848,21653,0,0.0,0.0,0.0),
        (8849,21653,12000,0.0,0.0,0.0),
        (8850,21653,13333,0.0,0.0,12.006388664245605),
        (8851,21653,18667,0.0,0.0,12.006388664245605),
        (8852,21653,20000,0.0,0.0,0.0),
        (8853,21653,26667,0.0,0.0,0.0),
        (8854,21654,0,0.0,0.0,0.0),
        (8855,21654,5333,0.0,0.0,0.0),
        (8856,21654,6667,-4.3000000005122274e-05,-3.999999989900971e-06,-11.985562324523926),
        (8857,21654,25333,-4.3000000005122274e-05,-3.999999989900971e-06,-11.985562324523926),
        (8858,21654,26667,0.0,0.0,0.0),
        (8859,21655,0,0.0,0.0,0.0),
        (8860,21655,5333,0.0,0.0,0.0),
        (8861,21655,6667,4.999999873689376e-06,-4.3000000005122274e-05,-11.985562324523926),
        (8862,21655,25333,4.999999873689376e-06,-4.3000000005122274e-05,-11.985562324523926),
        (8863,21655,26667,0.0,0.0,0.0),
        (8864,21656,0,0.0,0.0,0.0),
        (8865,21656,12000,0.0,0.0,0.0),
        (8866,21656,13333,0.0,0.0,12.006388664245605),
        (8867,21656,18667,0.0,0.0,12.006388664245605),
        (8868,21656,20000,0.0,0.0,0.0),
        (8869,21656,26667,0.0,0.0,0.0),
        (8843,32056,0,0.0,0.0,0.0),
        (8844,32056,6667,0.0,0.0,0.0),
        (8845,32056,13333,0.2520979940891266,0.004939999897032976,70.27203369140625),
        (8846,32056,20000,0.2520979940891266,0.004939999897032976,70.27203369140625),
        (8847,32056,26667,0.0,0.0,0.0),
        (8870,32057,0,0.0,0.0,0.0),
        (8871,32057,6667,0.0,0.0,0.0),
        (8872,32057,13333,0.2520729899406433,0.0003929999948013574,70.27315521240234),
        (8873,32057,20000,0.2520729899406433,0.0003929999948013574,70.27315521240234),
        (8874,32057,26667,0.0,0.0,0.0);
        INSERT INTO applied_updates VALUES ('180320231');
    end if;
	
end $
delimiter ;
