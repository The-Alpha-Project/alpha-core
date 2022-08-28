delimiter $
begin not atomic
    -- 20/08/2022 2
    if (select count(*) from applied_updates where id='200820222') = 0 then
        -- DESOLACE

        -- Hatefury Betrayer
        UPDATE `creature_template`
        SET `display_id1`=2014
        WHERE `entry`=4673;

        -- Hatefury Rogue
        UPDATE `creature_template`
        SET `display_id1`=2012
        WHERE `entry`=4670;

        -- Hatefury Shadowstalker
        UPDATE `creature_template`
        SET `display_id1`=2012
        WHERE `entry`=4674;

        -- Kolkar Windchaser
        UPDATE `creature_template`
        SET `display_id1`=1226
        WHERE `entry`=4635;

        -- Kolkar Battlelord
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=4636;

        -- Kolkar Centaur
        UPDATE `creature_template`
        SET `display_id1`=1226
        WHERE `entry`=4632;

        -- Kolkar Mauler
        UPDATE `creature_template`
        SET `display_id1`=1226
        WHERE `entry`=4634;

        -- Kolkar Destroyer
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=4637;

        -- Kolkar Scout
        UPDATE `creature_template`
        SET `display_id1`=1226
        WHERE `entry`=4633;

        -- Magram Windchaser
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4641;

        -- Magram Mauler
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4645;

        -- Magram Marauder
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4642;

        -- Magram Stormer
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4642;

        -- Magram Pack Runner
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4643;

        -- Magram Scout
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=4638;

        -- Magram Wrangler
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4640;

        -- Maraudine Wrangler
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4655;

        -- Maraudine Scout
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4654;

        -- Maraudine Windchaser
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4657;

        -- Maraudine Mauler
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4656;

        -- Gelkis Scout
        UPDATE `creature_template`
        SET `display_id1`=1347
        WHERE `entry`=4647;

        -- Gelkis Stramper
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4648;

        -- Gelkis Windchaser
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4649;

        -- Gelkis Earthcaller
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4651;

        -- Gelkis Outrunner
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4646;

        -- Gelkis Mauler
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4652;

        -- Gelkis Marauder
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4653;

        -- Uther the wise (named gelkis)
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=5397;

        -- Dread Ripper
        UPDATE `creature_template`
        SET `display_id1`=1192
        WHERE `entry`=4694;

        -- Mage Hunter
        UPDATE `creature_template`
        SET `display_id1`=1913
        WHERE `entry`=4681;

        -- Ley hunter
        UPDATE `creature_template`
        SET `display_id1`=1913
        WHERE `entry`=4685;

        -- Doomwarder
        UPDATE `creature_template`
        SET `display_id1`=1912
        WHERE `entry`=4677;

        -- Doomwarder captain
        UPDATE `creature_template`
        SET `display_id1`=1912
        WHERE `entry`=4680;

        -- Carrion Horror
        UPDATE `creature_template`
        SET `display_id1`= 2305
        WHERE `entry`=4695;

        -- Dread flyer
        UPDATE `creature_template`
        SET `display_id1`=1192
        WHERE `entry`=4693;

        -- Basilisk
        UPDATE `creature_template`
        SET `display_id1`=2744
        WHERE `entry`=4729;

        -- Rabid Bonepaw
        UPDATE `creature_template`
        SET `display_id1`=2714
        WHERE `entry`=4890;

        -- Ancient kodo
        UPDATE `creature_template`
        SET `display_id2`=0
        WHERE `entry`=4702;

        -- Aged kodo
        UPDATE `creature_template`
        SET `display_id2`=0
        WHERE `entry`=4700;

        -- Dying kodo
        UPDATE `creature_template`
        SET `display_id2`=0
        WHERE `entry`=4701;

        insert into applied_updates values ('200820222');
    end if;

    -- 20/08/2022 3
    if (select count(*) from applied_updates where id='200820223') = 0 then
        -- NE Shadowmeld.
        UPDATE `playercreateinfo_spell` SET `Spell` = '743' WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '20580') and (`id` = '627');
        UPDATE `playercreateinfo_spell` SET `Spell` = '743' WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '20580') and (`id` = '664');
        UPDATE `playercreateinfo_spell` SET `Spell` = '743' WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '20580') and (`id` = '703');
        UPDATE `playercreateinfo_spell` SET `Spell` = '743' WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '20580') and (`id` = '740');
        UPDATE `playercreateinfo_spell` SET `Spell` = '743' WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '20580') and (`id` = '776');

        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '4', '1', '74', '743', '0');
        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '4', '3', '2', '743', '0');
        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '4', '4', '4', '743', '0');
        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '4', '5', '3', '743', '0');
        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '4', '11', '3', '743', '0');
        
        -- Dwarf Find Treasure action button placement.
        UPDATE `playercreateinfo_action` SET `button` = '74' WHERE (`race` = '3') and (`class` = '1') and (`button` = '75') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '2' WHERE (`race` = '3') and (`class` = '2') and (`button` = '3') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '2' WHERE (`race` = '3') and (`class` = '3') and (`button` = '4') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '4' WHERE (`race` = '3') and (`class` = '4') and (`button` = '5') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '3' WHERE (`race` = '3') and (`class` = '5') and (`button` = '4') and (`id` = '1');
        
        -- Find Treasure for Dwarf Mages.
        INSERT INTO `playercreateinfo_spell` (`id`, `race`, `class`, `Spell`, `Note`) VALUES ('1505', '3', '8', '2481', 'Find Treasure');
        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '3', '8', '3', '2481', '0');
        
        -- Remove all invalid spells.
        DELETE FROM `playercreateinfo_spell` WHERE `Spell` > 7913;
        DELETE FROM `playercreateinfo_action` WHERE `action` > 7913 AND `type` = 0;

        insert into applied_updates values ('200820223');
    end if;

    -- 20/08/2022 4
    if (select count(*) from applied_updates where id='200820224') = 0 then
        -- Drop not needed id field in playercreateinfo_spell and playercreateinfo_action.
        ALTER TABLE `playercreateinfo_spell` DROP PRIMARY KEY, ADD PRIMARY KEY (`race`,`class`,`Spell`);
        ALTER TABLE `playercreateinfo_spell` DROP COLUMN `id`;
        ALTER TABLE `playercreateinfo_action` DROP PRIMARY KEY, ADD PRIMARY KEY (`race`,`class`, `button`);
        ALTER TABLE `playercreateinfo_action` DROP COLUMN `id`;

        -- Nature Resistance for NE.
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (4, 1, 4081, 'Nature Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (4, 4, 4081, 'Nature Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (4, 11, 4081, 'Nature Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (4, 3, 4081, 'Nature Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (4, 5, 4081, 'Nature Resistance');

        -- Frost Resistance for NE.
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (3, 1, 4080, 'Frost Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (3, 3, 4080, 'Frost Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (3, 8, 4080, 'Frost Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (3, 2, 4080, 'Frost Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (3, 5, 4080, 'Frost Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (3, 4, 4080, 'Frost Resistance');

        -- Shadow Resistance for NE.
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (5, 1, 4084, 'Shadow Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (5, 5, 4084, 'Shadow Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (5, 9, 4084, 'Shadow Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (5, 4, 4084, 'Shadow Resistance');
        INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (5, 8, 4084, 'Shadow Resistance');

        insert into applied_updates values ('200820224');
    end if;

    -- 20/08/2022 5
    if (select count(*) from applied_updates where id='200820225') = 0 then
        -- BURNING BLADE MOBS (orc)
        UPDATE `creature_template`
        SET `display_id1`=1139, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `name` LIKE "burning blade%" AND `name` NOT LIKE "burning blade nightmare" AND `entry` < 5764 AND `display_id1` > 4165;

        -- DESOLACE

        -- Magram Marauder
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=4644;

        -- Magram Outruner
        UPDATE `creature_template`
        SET `display_id1`=1348
        WHERE `entry`=4639;

        -- Rabid Bonepaw
        UPDATE `creature_template`
        SET `display_id1`=2714
        WHERE `entry`=4690;

        -- Piter Verance
        UPDATE `creature_template`
        SET `display_id1`=4833
        WHERE `entry`=4890;

        insert into applied_updates values ('200820225');
    end if;

    -- 21/08/2022 1
    if (select count(*) from applied_updates where id='210820221') = 0 then
        -- FERALAS

        -- Gordunni Ogre Mage
        UPDATE `creature_template`
        SET `display_id1`=3190
        WHERE `entry`=5237;

        -- Gordunni Brute
        UPDATE `creature_template`
        SET `display_id1`=3192
        WHERE `entry`=5232;

        -- Gordunni Warlock
        UPDATE `creature_template`
        SET `display_id1`=3191
        WHERE `entry`=5240;

        -- Gordunni Mauler
        UPDATE `creature_template`
        SET `display_id1`=3192
        WHERE `entry`=5234;

        -- Gordunni Shaman
        UPDATE `creature_template`
        SET `display_id1`=3192
        WHERE `entry`=5236;

        -- Gordunni Battlemaster
        UPDATE `creature_template`
        SET `display_id1`=3193
        WHERE `entry`=5238;

        -- Gordunni Mage Lord
        UPDATE `creature_template`
        SET `display_id1`=3191
        WHERE `entry`=5239;

        -- Gordunni Warlord
        UPDATE `creature_template`
        SET `display_id1`=3192
        WHERE `entry`=5241;

        -- Woodpaw Trapper
        UPDATE `creature_template`
        SET `display_id1`=3197
        WHERE `entry`=5251;

        -- Woodpaw Mystic
        UPDATE `creature_template`
        SET `display_id1`=3198
        WHERE `entry`=5254;

        -- Woodpaw Alpha
        UPDATE `creature_template`
        SET `display_id1`=3199
        WHERE `entry`=5258;

        -- Woodpaw Reaver
        UPDATE `creature_template`
        SET `display_id1`=3196
        WHERE `entry`=5255;

        -- Woodpaw Mongrel
        UPDATE `creature_template`
        SET `display_id1`=3196
        WHERE `entry`=5249;

        -- Glizled Ironfur Bear
        UPDATE `creature_template`
        SET `display_id1`=3201
        WHERE `entry`=5272;

        -- Frayfeather Patriarch
        UPDATE `creature_template`
        SET `display_id1`=3212
        WHERE `entry`=5306;

        -- Frayfeather Stagwing
        UPDATE `creature_template`
        SET `display_id1`=3211
        WHERE `entry`=5304;

        -- Antilus (named frayfeather)
        UPDATE `creature_template`
        SET `display_id1`=3212
        WHERE `entry`=5347;

        -- Hulking Feral Scar
        UPDATE `creature_template`
        SET `display_id1`=3209
        WHERE `entry`=5293;

        -- Enraged Feral Scar
        UPDATE `creature_template`
        SET `display_id1`=3208
        WHERE `entry`=5295;

        -- See elemental
        UPDATE `creature_template`
        SET `display_id1`=110
        WHERE `entry`=5461;

        -- See spray
        UPDATE `creature_template`
        SET `display_id1`=110
        WHERE `entry`=5462;

        -- Deep strider
        UPDATE `creature_template`
        SET `display_id1`=3217
        WHERE `entry`=5360;

        -- Wave strider
        UPDATE `creature_template`
        SET `display_id1`=3219
        WHERE `entry`=5361;

        -- Jademir Broughguard
        UPDATE `creature_template`
        SET `display_id1`=624
        WHERE `entry`=5320;

        -- Jademir Oracle
        UPDATE `creature_template`
        SET `display_id1`=623
        WHERE `entry`=5317;

        -- Hatecrest Warrior
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5331;

        -- Hatecrest Screamer
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5335;

        -- Hatecrest Siren
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5337;

        -- Hatecrest Wave rider
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5332;

        -- Hatecrest Serpent Guard
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5333;

        -- Hatecrest Myrmidon
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5334;

        -- Hatecrest Sorceress
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=5336;

        -- Sprite Dragon
        UPDATE `creature_template`
        SET `display_id1`=2158
        WHERE `entry`=5276;

        -- Land Walker
        UPDATE `creature_template`
        SET `display_id1`=3216
        WHERE `entry`=5357;

        -- Cliff Giant
        UPDATE `creature_template`
        SET `display_id1`=3216
        WHERE `entry`=5358;

        -- Northspring Roguefeather
        UPDATE `creature_template`
        SET `display_id1`=3218
        WHERE `entry`=5363;

        -- Northspring Harpy
        UPDATE `creature_template`
        SET `display_id1`=3218
        WHERE `entry`=5362;

        -- Northspring Slayer
        UPDATE `creature_template`
        SET `display_id1`=3218
        WHERE `entry`=5364;

        insert into applied_updates values ('210820221');
    end if;

    -- 21/08/2022 2
    if (select count(*) from applied_updates where id='210820222') = 0 then
        -- DUSTWALLOW MARCH
        
        -- Spider trainer
        INSERT INTO `spawns_creatures` VALUES (NULL, 4882, 0, 0, 0, 1, -3154.872, -2848.983, 34.454, 0.031, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        UPDATE `creature_template`
        SET `name`="Om'kan", `display_id1`=1120
        WHERE `entry`=4882;
        
        -- Turtle trainer
        INSERT INTO `spawns_creatures` VALUES (NULL, 4881, 0, 0, 0, 1, -3147.965, -2841.329, 34.646, 4.779, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        -- Krak
        UPDATE `creature_template`
        SET `display_id1` =1120
        WHERE `entry`=4883;

        -- Ogg'mar
        UPDATE `creature_template`
        SET `display_id1` =1120
        WHERE `entry`=4879;

        -- Zulrg
        UPDATE `creature_template`
        SET `display_id1`=1120
        WHERE `entry`=4884;

        -- Draz'lib
        UPDATE `creature_template`
        SET `display_id1`=1120
        WHERE `entry`=4501;

        -- Overlord Mok
        UPDATE `creature_template`
        SET `display_id1`=3193
        WHERE `entry`=4500;

        -- Nazeer
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=4791;

        -- Firemane Lash tail
        UPDATE `creature_template`
        SET `display_id1`=143
        WHERE `entry`=4331;

        -- Firemane Scalebane
        UPDATE `creature_template`
        SET `display_id1`=143
        WHERE `entry`=4328;

        -- Firemane Flamecaller
        UPDATE `creature_template`
        SET `display_id1`=143
        WHERE `entry`=4334;

        -- Giant Darkfang Spider
        UPDATE `creature_template`
        SET `display_id1`=2546
        WHERE `entry`=4415;

        -- Mirefin Coastrunner
        UPDATE `creature_template`
        SET `display_id1`=478
        WHERE `entry`=4362;

        -- Mirefin Oracle
        UPDATE `creature_template`
        SET `display_id1`=478
        WHERE `entry`=4363;

        -- Mirefin warrior
        UPDATE `creature_template`
        SET `display_id1`=478
        WHERE `entry`=4360;

        -- Murdrock Turtoise
        UPDATE `creature_template`
        SET `display_id1`=2307
        WHERE `entry`=4396;

        -- Murdrock Spikeshell
        UPDATE `creature_template`
        SET `display_id1`=2308
        WHERE `entry`=4397;

        -- Acidic Swamp Ooze
        UPDATE `creature_template`
        SET `display_id1`=1145
        WHERE `entry`=4393;

        insert into applied_updates values ('210820222');
    end if;
    
    -- 22/08/2022 1
    if (select count(*) from applied_updates where id='220820221') = 0 then

        -- Dustbelcher Shaman
        UPDATE `creature_template`
        SET `display_id1`=1120
        WHERE `entry`=2718;
        
        -- Dustbelcher Wyrmhunter
        UPDATE `creature_template`
        SET `display_id1`=1121
        WHERE `entry`=2716;
        
        -- Dustbelcher Ogre mage
        UPDATE `creature_template`
        SET `display_id1`=326
        WHERE `entry`=2720;
        
        -- Dustbelcher Ogre
        UPDATE `creature_template`
        SET `display_id1`=1120
        WHERE `entry`=2701;
        
        -- Dustbelcher Brute
        UPDATE `creature_template`
        SET `display_id1`=1120
        WHERE `entry`=2715;
        
        -- Anathemus
        UPDATE `creature_template`
        SET `display_id1`=3216
        WHERE `entry`=2754;
        
        -- Scorched Guardian
        UPDATE `creature_template`
        SET `display_id1`=2527
        WHERE `entry`=2726;
        
        -- Starving Buzzard
        UPDATE `creature_template`
        SET `display_id1`=1105
        WHERE `entry`=2829;
        
        -- Wargolem
        UPDATE `creature_template`
        SET `display_id1`=2695
        WHERE `entry`=2751;
        
        -- Siege Golem
        UPDATE `creature_template`
        SET `display_id1`=2695
        WHERE `entry`=2749;
        
        -- Rumbler
        UPDATE `creature_template`
        SET `display_id1`=171
        WHERE `entry`=2752;
        
        -- Greater Rock Elemental
        UPDATE `creature_template`
        SET `display_id1`=171
        WHERE `entry`=2736;
        
        -- Enraged Rock Elemental
        UPDATE `creature_template`
        SET `display_id1`=171
        WHERE `entry`=2791;
        
        -- Galek
        UPDATE `creature_template`
        SET `display_id1`=1642
        WHERE `entry`=2888;

        insert into applied_updates values ('220820221');
    end if;

    -- 22/08/2022 2
    if (select count(*) from applied_updates where id='220820222') = 0 then

        -- Scalebane Captain
        UPDATE `creature_template`
        SET `display_id1`=624
        WHERE `entry`=745;

        -- Green Scaleban
        UPDATE `creature_template`
        SET `display_id1`=623
        WHERE `entry`=744;

        -- Green Wyrmkin
        UPDATE `creature_template`
        SET `display_id1`=623
        WHERE `entry`=742;

        -- Wyrmkin dreamwalker
        UPDATE `creature_template`
        SET `display_id1`=624
        WHERE `entry`=743;

        -- Silt Crawler
        UPDATE `creature_template`
        SET `display_id1`=642
        WHERE `entry`=922;

        -- Lost One Riftseeker
        UPDATE `creature_template`
        SET `display_id1`=628
        WHERE `entry`=762;

        -- Lost One Chieftain
        UPDATE `creature_template`
        SET `display_id1`=628
        WHERE `entry`=763;

        -- Lost One Seer
        UPDATE `creature_template`
        SET `display_id1`=628
        WHERE `entry`=761;

        -- Magtoor
        UPDATE `creature_template`
        SET `display_id1`=628
        WHERE `entry`=1776;

        -- Adolescent Whelp
        UPDATE `creature_template`
        SET `display_id1`=621
        WHERE `entry`=740;

        -- Sonard Hunter
        UPDATE `creature_template`
        SET `display_id1`=1139, `display_id2`=0
        WHERE `entry`=863;

        -- Stonard Shaman
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=868;

        -- Stonard Explorer
        UPDATE `creature_template`
        SET `display_id1`=1139, `display_id2`=0
        WHERE `entry`=862;

        -- Stonard Scout
        UPDATE `creature_template`
        SET `display_id1`=1139, `display_id2`=0
        WHERE `entry`=861;

        -- Stonard Wayfinder
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=865;

        -- Stonard Cartographer
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=867;

        -- Stonard Orc
        UPDATE `creature_template`
        SET `display_id1`=1139, `display_id2`=0
        WHERE `entry`=864;

        -- Thultazor
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=983;

        -- Thultash
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=982;

        -- Thralosh
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=984;

        -- Hartash
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=981;

        -- Ogromm
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=987;

        -- Malosh
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=985;

        -- Stonard Grunt
        UPDATE `creature_template`
        SET `display_id1`=1139,`display_id2`=0
        WHERE `entry`=866;

        -- Kartosh
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=988;

        -- Banalash
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=989;

        -- Rogvar
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=1386;

        -- Helgrum
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=1442;

        -- Fel'zerul
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=1443;

        -- Zun'dartha
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=1775;

        -- Grokor
        UPDATE `creature_template`
        SET `display_id1`=3511
        WHERE `entry`=3622;

        -- Grunt Zuul
        UPDATE `creature_template`
        SET `display_id1`=3546
        WHERE `entry`=5546;

        -- Grunt Tharlak
        UPDATE `creature_template`
        SET `display_id1`=3546
        WHERE `entry`=5547;

        insert into applied_updates values ('220820222');
    end if;

    -- 22/08/2022 3
    if (select count(*) from applied_updates where id='220820223') = 0 then
        -- WEST PLAGUE

        -- Freezing Ghoul
        UPDATE `creature_template`
        SET `display_id1`=547
        WHERE `entry`=1796;

        -- Skeletal Sorcerer
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=1784;

        -- High Priest Thel'danis
        UPDATE `creature_template`
        SET `display_id1`=2192
        WHERE `entry`=1854;

        -- Skeletal Executionner
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=1787;

        -- Skeletal Acolyte
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=1789;

        -- Soulless Ghoul
        UPDATE `creature_template`
        SET `display_id1`=519
        WHERE `entry`=1794;

        -- Putridus
        UPDATE `creature_template`
        SET `display_id1`=1693
        WHERE `entry`=1850;

        -- Rotting Cadaver
        UPDATE `creature_template`
        SET `display_id1`=1197
        WHERE `entry`=4474;

        -- Blighted Zombie
        UPDATE `creature_template`
        SET `display_id1`=1198, `display_id2`=0
        WHERE `entry`=4475;

        -- Skeletal Terror
        UPDATE `creature_template`
        SET `display_id1`=200
        WHERE `entry`=1785;

        -- Hungering Wraith
        UPDATE `creature_template`
        SET `display_id1`=146
        WHERE `entry`=1802;

        -- Wailing Death
        UPDATE `creature_template`
        SET `display_id1`=915
        WHERE `entry`=1804;

        -- Rotting Behemoth
        UPDATE `creature_template`
        SET `display_id1`=631
        WHERE `entry`=1812;

        -- Devoring Hooze
        UPDATE `creature_template`
        SET `display_id1`=682
        WHERE `entry`=1808;

        insert into applied_updates values ('220820223');
    end if;

    -- 22/08/2022 4
    if (select count(*) from applied_updates where id='220820224') = 0 then
      -- Add, Tauren Bull Rush" (4083) spell to all classes
      INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (6, 1, 4083, 'Bull Rush');
      INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (6, 3, 4083, 'Bull Rush');
      INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (6, 7, 4083, 'Bull Rush');
      INSERT INTO `playercreateinfo_spell` (`race`, `class`, `Spell`, `Note`) VALUES (6, 11, 4083, 'Bull Rush');

      -- Add, Tauren Bull Rush" (4083) button to all classes
      INSERT INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`) VALUES (6, 1, 74, 4083, 0);
      INSERT INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`) VALUES (6, 3, 2, 4083, 0);
      INSERT INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`) VALUES (6, 7, 3, 4083, 0);
      INSERT INTO `playercreateinfo_action` (`race`, `class`, `button`, `action`, `type`) VALUES(6, 11, 3, 4083, 0);

      -- Removes elevators next to Freewind Post
      UPDATE `spawns_gameobjects` SET `ignored`='1' WHERE `spawn_entry`='11898';
      UPDATE `spawns_gameobjects` SET `ignored`='1' WHERE `spawn_entry`='11899';

      -- Updates Grimnal
      UPDATE `creature_template` SET `display_id1`='1139' WHERE `entry`='980';
      INSERT INTO applied_updates values ('220820224');
    end if;

    -- 23/08/2022 1
    if (select count(*) from applied_updates where id='230820221') = 0 then
        -- MISC DISPLAY ID & SPAWN FIX
        -- FIX #455 #517 #518 #519 #520 #524 #534 #543

        -- Kardris Dreamseeker
        UPDATE `spawns_creatures`
        SET `position_x`=1934.261, `position_y`=-4198.464, `position_z`=42.061, `orientation`=2.227
        WHERE `spawn_id`=4663;

        -- Grenil Steelfury
        UPDATE `spawns_creatures`
        SET `position_x`=-4933.364, `position_y`=-999.121, `position_z`=492.736, `orientation`=0.975
        WHERE `spawn_id`=112;

        -- Dolman Steelfury
        UPDATE `spawns_creatures`
        SET `position_x`=-4930.579, `position_y`=-1001.191, `position_z`=492.736, `orientation`=0.906
        WHERE `spawn_id`=110;

        -- Maeva Snowbraid
        UPDATE `spawns_creatures`
        SET `position_x`=-4660.537, `position_y`=-891.460, `position_z`=520.412, `orientation`=0.856
        WHERE `spawn_id`=1801;

        -- Ingrys Stonebrow
        UPDATE `spawns_creatures`
        SET `position_x`=-4597.981, `position_y`=-959.020, `position_z`=520.430, `orientation`=5.216
        WHERE `spawn_id`=1800;

        -- Raena Flinthammer
        UPDATE `spawns_creatures`
        SET `position_x`=-4874.195, `position_y`=-1019.104, `position_z`=492.753, `orientation`=5.422
        WHERE `spawn_id`=1755;

        -- Sovik
        UPDATE `spawns_creatures`
        SET `position_x`=2036.924, `position_y`=-4739.543, `position_z`=51.100, `orientation`=0.708
        WHERE `spawn_id`=7968;

        -- Darnassus Banker Idriana
        UPDATE `spawns_creatures`
        SET `position_x`=10038.049, `position_y`=2486.572, `position_z`=1318.426, `orientation`=1.812
        WHERE `spawn_id`=46223;

        -- Darnassus Banker Garryeth
        UPDATE `spawns_creatures`
        SET `position_x`=10044.490, `position_y`=2487.882, `position_z`=1318.426, `orientation`=1.962
        WHERE `spawn_id`=46418;

        -- Darnassus Banker Lain
        UPDATE `spawns_creatures`
        SET `position_x`=10031.436, `position_y`=2486.353, `position_z`=1318.426, `orientation`=1.667
        WHERE `spawn_id`=46417;

        -- Jorb
        UPDATE `creature_template`
        SET `display_id1`=1051
        WHERE `entry`=3659;

        -- Writhing Highborne
        UPDATE `creature_template`
        SET `display_id2`=1009
        WHERE `entry`=2177;

        -- Theramore Sentry
        UPDATE `creature_template`
        SET `display_id1`=1643, `display_id2`=2977
        WHERE `entry`=5184;

        insert into applied_updates values ('230820221');
    end if;

    -- 23/08/2022 2
    if (select count(*) from applied_updates where id='230820222') = 0 then
        -- From 0.5.4 Patch notes: H [15] Arugal's Folly: Reduced the number of Pyrewood Shackles required from 12 to 6.
        UPDATE `quest_template` SET `ReqItemCount1` = 12 WHERE `entry` = 99;

        insert into applied_updates values ('230820222');
    end if;

    -- 23/08/2022 3
    if (select count(*) from applied_updates where id='230820223') = 0 then
        -- Gavin Gnarltree #559
        UPDATE `creature_template` SET `display_id1`='191' WHERE `entry`='225';

        -- Stormscale Siren #558
        UPDATE `creature_template` SET `display_id1`='4036' WHERE `entry`='2180';

        insert into applied_updates values ('230820223');
    end if;

    -- 25/08/2022 1
    if (select count(*) from applied_updates where id='250820221') = 0 then
        -- #565 Incorrect vendor inventory
        DELETE FROM `npc_vendor` WHERE `entry`=5121;

        INSERT INTO `npc_vendor` VALUES
            (5121, 852, 0, 0, 0),
            (5121, 2028, 0, 0, 0),
            (5121, 925, 0, 0, 0),
            (5121, 1197, 0, 0, 0),
            (5121, 2026, 0, 0, 0),
            (5121, 924, 0, 0, 0),
            (5121, 854, 0, 0, 0),
            (5121, 2030, 0, 0, 0),
            (5121, 928, 0, 0, 0);

        -- #567 Incorrect item damage.
        UPDATE `item_template` SET `dmg_min1`='28', `dmg_max1`='39' WHERE `entry`='854';

        -- #572 Ruppo Zipcoil.
        UPDATE `creature_template` SET `display_id1`='352', `name`='[PH] Ruppo Zipcoil',
                                       `subname`='Superior Engineer', `level_min` = '42', `level_max` = '42'
        WHERE `entry`='2688';

        -- #573 Hill Giant.
        UPDATE `creature_template` SET `display_id1`='1163' WHERE `entry`='2689';

        -- #575 Stranglekelp gameobjects should be removed.
        UPDATE `spawns_gameobjects` SET `ignored`='1' WHERE `spawn_entry`='2045';

        insert into applied_updates values ('250820221');
    end if;

    -- 26/08/2022 1
    if (select count(*) from applied_updates where id='260820221') = 0 then
        -- FIX #583
        -- 3494

        -- Imp
        -- static_flags, from 1048576 to 1048582
        UPDATE `creature_template` SET `static_flags` = 1048582 WHERE (`entry` = 416);

        -- Gozwin Vilesprocket
        -- name, from [UNUSED] Gozwin Vilesprocket to Gozwin Vilesprocket
        UPDATE `creature_template` SET `name` = 'Gozwin Vilesprocket', `subname` = 'Warlock Trainer' WHERE (`entry` = 6046);

        -- Durnan Furcutter
        -- subname, from Cloth & Leather Armor Merchant to Cloth & Leather
        UPDATE `creature_template` SET `subname` = 'Cloth & Leather' WHERE (`entry` = 836);

        -- Tannysa
        -- subname, from Tailoring Trainer to Herbalism Trainer
        UPDATE `creature_template` SET `subname` = 'Herbalism Trainer' WHERE (`entry` = 5566);

        -- 3368

        -- Undertaker Mordo
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1568);

        -- Archibald Kava
        -- subname, from Cloth & Leather Armor Merchant to Apprentice Cloth & Leather
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `subname` = 'Apprentice Cloth & Leather', `type` = 6 WHERE (`entry` = 2113);

        -- Executor Arren
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1570);

        -- David Trias
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2122);

        -- Blacksmith Rand
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2116);

        -- Joshua Kien
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2115);

        -- Andrew Brounel
        -- name, from Andrew Brownell to Andrew Brounel
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `name` = 'Andrew Brounel', `type` = 6 WHERE (`entry` = 2308);

        -- Dannal Stern
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2119);

        -- Harold Raims
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2117);

        -- Maquell Ebonwood
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2315);

        -- Deathguard Phillip
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1739);

        -- Deathguard Bartrand
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1741);

        -- Deathguard Randolph
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1736);

        -- Shadow Priest Sarvis
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1569);

        -- Novice Elreth
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1661);

        -- Venya Marthand
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 5667);

        -- Dark Cleric Duesten
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2123);

        -- Maximillion
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2126);

        -- Kayla Smithe
        -- subname, from Demon Trainer to Demon Pet Trainer
        UPDATE `creature_template` SET `subname` = 'Demon Pet Trainer' WHERE (`entry` = 5749);

        -- Isabella
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2124);

        -- Duskbat
        -- beast_family, from 24 (Invalid) to 7 (CREATURE_FAMILY_CARRION_BIRD)
        UPDATE `creature_template` SET `beast_family` = 7 WHERE (`entry` = 1512);

        -- Deathguard Oliver
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1737);

        -- Nerrik Shoyul
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2301);

        -- Deathguard Saltain
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1740);

        -- Caretaker Caice
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2307);

        -- Mangy Duskbat
        -- beast_family, from 24 (Invalid) to 7 (CREATURE_FAMILY_CARRION_BIRD)
        UPDATE `creature_template` SET `beast_family` = 7 WHERE (`entry` = 1513);

        -- Greater Duskbat
        -- beast_family, from 24 (Invalid) to 7 (CREATURE_FAMILY_CARRION_BIRD)
        UPDATE `creature_template` SET `beast_family` = 7 WHERE (`entry` = 1553);

        -- Deathguard Simmer
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1519);

        -- Deathguard Lundmark
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 5725);

        -- Vampiric Duskbat
        -- beast_family, from 24 (Invalid) to 7 (CREATURE_FAMILY_CARRION_BIRD)
        UPDATE `creature_template` SET `beast_family` = 7 WHERE (`entry` = 1554);

        -- Constance Brisboise
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 3522);

        -- Bowen Brisboise
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 3523);

        -- Deathguard Abraham
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1735);

        -- Hamlin Atkins
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 3547);

        -- Deathguard Lawrence
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1743);

        -- Deathguard Dillinger
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1496);

        -- Apothecary Johaan
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1518);

        -- Carolai Anise
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2132);

        -- Deathguard Bartholomew
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1742);

        -- Thomas Arlento
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2309);

        -- Zachariah Post
        -- subname, from Undead Horse Merchant to Animal Handler
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `subname` = 'Animal Handler', `type` = 6 WHERE (`entry` = 4731);

        -- Velma Warnam
        -- subname, from Undead Horse Riding Instructor to Horse Riding Instructor
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `subname` = 'Horse Riding Instructor', `type` = 6 WHERE (`entry` = 4773);

        -- Faruza
        -- subname, from Herbalism Trainer to Apprentice Herbalist
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `subname` = 'Apprentice Herbalist', `type` = 6 WHERE (`entry` = 2114);

        -- Deathguard Morris
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1745);

        -- Doreen Beltis
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2311);

        -- Oliver Dwor
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2136);

        -- Eliza Callen
        -- subname, from Leather Armor Merchant to Apprentice Leathercrafter
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `subname` = 'Apprentice Leathercrafter', `type` = 6 WHERE (`entry` = 2137);

        -- Abe Winters
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2135);

        -- Executor Zygand
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1515);

        -- Cain Firesong
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2128);

        -- Rupert Boch
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2127);

        -- Dark Cleric Beryl
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2129);

        -- Yvette Farthing
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1560);

        -- Gina Lang
        -- subname, from Demon Trainer to Demon Pet Trainer
        UPDATE `creature_template` SET `subname` = 'Demon Pet Trainer' WHERE (`entry` = 5750);

        -- Deathguard Mort
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1744);

        -- Magistrate Sevren
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1499);

        -- Lyranne May
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2303);

        -- Mrs. Winters
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2134);

        -- Abigail Shiel
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2118);

        -- Sahvan Bloodshadow
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2314);

        -- Jamie Nore
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2310);

        -- Deathguard Burgess
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1652);

        -- Deathguard Cyrus
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1746);

        -- Ageron Kargal
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 5724);

        -- Coleman Farthing
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1500);

        -- Nurse Neela
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 5759);

        -- Renee Samson
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 5688);

        -- Gretchen Dedmar
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1521);

        -- Deathguard Gavin
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2209);

        -- Deathguard Royann
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2210);

        -- Austil de Mon
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2131);

        -- Marion Call
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 2130);

        -- Vance Undergloom
        -- subname, from Enchanting Trainer to Enchanter
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `subname` = 'Enchanter', `type` = 6 WHERE (`entry` = 5695);

        -- Selina Weston
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 3548);

        -- Deathguard Terrence
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1738);

        -- Martine Tramblay
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 3550);

        -- Deathguard Linnea
        -- type, from 7 (HUMANOID) to 6 (UNDEAD)
        UPDATE `creature_template` SET `type` = 6 WHERE (`entry` = 1495);

        -- More ignored Gameobjects, not accesible due quest_tmeplate ignores.

        -- Ju-Ju Heap
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12370');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12371');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12372');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12612');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12613');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12614');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12615');

        -- First Witherbark Cage, Second Witherbark Cage, Third Witherbark Cage.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46042');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46047');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46064');

        -- Sharpbeak's Cage.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46076');

        -- Highvale Records, Highvale Notes, Highvale Report.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46390');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46389');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46388');

        -- Sentry Braziers.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '7050');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6948');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '7048');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6955');

        -- Thaurissan Relic.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46076');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46076');

        -- Thaurissan Relics.
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_entry`=153556;

        -- Soft Dirt Mound.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4521');

        -- Brazier of Pain, Brazier of Malice, Brazier of Suffering, Brazier of Hatred.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48841');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48838');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48842');
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '48839');

        -- Gaea Dirt Mounds.
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_entry`=177929;

        -- Cactus Apple.
        UPDATE `spawns_gameobjects` SET `ignored`=1 WHERE `spawn_entry`=171938;

        insert into applied_updates values ('260820221');
    end if;

    -- 27/08/2022 1
    if (select count(*) from applied_updates where id='270820221') = 0 then
        -- Add slot field to npc_vendor table.
        ALTER TABLE `npc_vendor` ADD COLUMN `slot` TINYINT(3) unsigned NOT NULL DEFAULT 0;

        -- Sort Kelomir Ironhand item list.
        DELETE FROM `npc_vendor` WHERE `entry`=5121;
        INSERT INTO `npc_vendor` VALUES
            (5121, 852, 0, 0, 0, 0),
            (5121, 2028, 0, 0, 0, 1),
            (5121, 925, 0, 0, 0, 2),
            (5121, 1197, 0, 0, 0, 3),
            (5121, 2026, 0, 0, 0, 4),
            (5121, 924, 0, 0, 0, 5),
            (5121, 854, 0, 0, 0, 6),
            (5121, 2030, 0, 0, 0, 7),
            (5121, 928, 0, 0, 0, 8);

        -- Change Kelomir Ironhand subname.
        UPDATE `creature_template` SET `subname` = 'Mace Merchant' WHERE `entry` = 5121;

        insert into applied_updates values ('270820221');
    end if;

    -- 27/08/2022 2
    if (select count(*) from applied_updates where id='270820222') = 0 then
        -- Add missing creature_templates.
        INSERT INTO `creature_template` (`entry`, `display_id1`, `display_id2`, `display_id3`, `display_id4`,
                                         `mount_display_id`, `name`, `subname`, `static_flags`, `gossip_menu_id`,
                                         `level_min`, `level_max`, `health_min`, `health_max`, `mana_min`, `mana_max`,
                                         `armor`, `faction`, `npc_flags`, `speed_walk`, `speed_run`, `scale`,
                                         `detection_range`, `call_for_help_range`, `leash_range`, `rank`,
                                         `xp_multiplier`, `dmg_min`, `dmg_max`, `dmg_school`, `attack_power`,
                                         `dmg_multiplier`, `base_attack_time`, `ranged_attack_time`, `unit_class`,
                                         `unit_flags`, `dynamic_flags`, `beast_family`, `trainer_type`, `trainer_spell`,
                                         `trainer_class`, `trainer_race`, `ranged_dmg_min`, `ranged_dmg_max`,
                                         `ranged_attack_power`, `type`, `type_flags`, `loot_id`, `pickpocket_loot_id`,
                                         `skinning_loot_id`, `holy_res`, `fire_res`, `nature_res`, `frost_res`,
                                         `shadow_res`, `arcane_res`, `spell_id1`, `spell_id2`, `spell_id3`, `spell_id4`,
                                         `spell_list_id`, `pet_spell_list_id`, `auras`, `gold_min`, `gold_max`,
                                         `ai_name`, `movement_type`, `inhabit_type`, `civilian`, `racial_leader`,
                                         `regeneration`, `equipment_id`, `trainer_id`, `vendor_id`,
                                         `mechanic_immune_mask`, `school_immune_mask`, `flags_extra`,
                                         `script_name`) VALUES
        (347,15092,0,0,0,0,'Grizzle Halfmane','Alterac Valley Battlemaster',0,6466,61,61,157200,157200,0,0,4091,1214,2049,1,1.14286,1,20,5,0,1,1,544,703,0,278,1,2000,2000,1,4672,0,0,0,0,0,0,172.1,240.07,100,7,0,0,0,0,0,5,5,5,5,5,0,0,0,0,3470,0,NULL,0,0,'EventAI',0,3,0,0,3,347,0,0,0,0,524296,''),
        (857,15114,0,0,0,0,'Donal Osgood','Arathi Basin Battlemaster',0,6471,61,61,157200,157200,0,0,4091,1577,2049,1,1.14286,1,20,5,0,1,1,588,669,0,278,1,2000,2000,1,4672,0,0,0,0,0,0,172.1,240.07,100,7,0,0,0,0,0,5,5,5,5,5,0,0,0,0,0,0,NULL,0,0,'',0,3,0,0,3,857,0,0,0,0,524296,''),
        (907,15115,0,0,0,0,'Keras Wolfheart','Arathi Basin Battlemaster',0,6472,61,61,157200,157200,0,0,4091,1577,2049,1,1.14286,1,20,5,0,1,1,544,703,0,278,1,2000,2000,1,4672,0,0,0,0,0,0,172.1,240.07,100,7,0,0,0,0,0,5,5,5,5,5,0,0,0,0,0,0,NULL,0,0,'',0,3,0,0,3,907,0,0,0,0,524296,''),
        (1233,14310,0,0,0,0,'Shaethis Darkoak','Hippogryph Master',0,0,55,55,7842,7842,0,0,0,80,11,1,1.14286,1,20,5,0,1,1,298,427,0,100,1,1216,1338,1,0,0,0,0,0,0,0,58.872,80.949,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,1,774,'',0,3,1,0,3,1233,0,0,0,0,2,''),
        (2225,14781,0,0,0,0,'Zora Guthrek','Trade Goods',0,0,55,55,26140,26140,0,0,3271,1215,6,1,1.14286,1,18,5,0,0,1,138,165,0,248,1,2000,2000,1,0,0,0,0,0,0,0,69.8544,96.0498,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,1,677,'',1,3,0,0,3,2225,0,0,0,0,524290,''),
        (2302,14873,0,0,0,0,'Aethalas','Warsong Gulch Battlemaster',0,6282,61,61,157200,157200,0,0,4091,1514,2049,1,1.14286,1,20,5,0,1,1,361,467,0,278,1,2000,2000,1,4672,0,0,0,0,0,0,172.1,240.07,100,7,0,0,0,0,0,5,5,5,5,5,0,0,0,0,0,0,NULL,0,0,'',0,3,0,0,3,2302,0,0,0,0,524296,''),
        (2804,1871,0,0,0,0,'Kurden Bloodclaw','Warsong Gulch Battlemaster',0,6462,61,61,157200,157200,0,0,4091,1515,2049,1,1.14286,1,20,5,0,1,1,361,467,0,278,1,2000,2000,1,4672,0,0,0,0,0,0,172.1,240.07,100,7,0,0,0,0,0,5,5,5,5,5,0,0,0,0,28040,0,NULL,0,0,'EventAI',0,3,0,0,3,2804,0,0,0,0,524296,''),
        (3343,1359,0,0,0,0,'Grelkor','Blacksmithing Supplies',0,0,55,55,26140,26140,0,0,3271,1215,16390,1,1.14286,1,18,5,0,0,1,161,193,0,248,1,2000,2000,1,0,0,0,0,0,0,0,71.9664,98.9538,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,1,752,'',1,3,0,0,3,3343,0,0,0,0,524290,''),
        (3625,4294,0,0,0,0,'Rarck','General Goods',0,0,55,55,26140,26140,0,0,3271,1215,6,1,1.14286,1,18,5,0,0,1,141,170,0,248,1,2000,2000,1,0,0,0,0,0,0,0,70.664,97.163,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,'',1,3,0,0,3,3625,0,0,0,0,524290,''),
        (3890,15032,0,0,0,0,'Brakgul Deathbringer','Warsong Gulch Battlemaster',0,6459,61,61,157200,157200,0,0,4091,1515,2049,1,1.14286,1,20,5,0,1,1,361,467,0,278,1,2000,2000,1,4672,0,0,0,0,0,0,172.1,240.07,100,7,0,0,0,0,0,5,5,5,5,5,0,0,0,0,0,0,NULL,0,0,'',0,3,0,0,3,3890,0,0,0,0,524296,''),
        (4255,2284,0,0,0,0,'Brogus Thunderbrew','Food and Drink',0,0,55,55,13070,13070,0,0,3271,1217,6,1,1.14286,1,18,5,0,0,1,141,170,0,248,1,2000,2000,1,0,0,0,0,0,0,0,70.664,97.163,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,'',1,3,0,0,3,4255,0,0,0,0,524288,''),
        (4257,2286,0,0,0,0,'Lana Thunderbrew','Blacksmithing Supplies',0,0,55,55,26140,26140,0,0,3271,1217,16390,1,1.14286,1,18,5,0,0,1,161,193,0,248,1,2000,2000,1,0,0,0,0,0,0,0,71.9664,98.9538,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,'',1,3,0,0,3,4257,0,0,0,0,524288,''),
        (5134,3061,0,0,0,0,'Jonivera Farmountain','General Goods',0,0,55,55,26140,26140,0,0,3271,1217,6,1,1.14286,1,18,5,0,0,1,141,170,0,248,1,2000,2000,1,0,0,0,0,0,0,0,70.664,97.163,100,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,1,689,'',1,3,0,0,3,5134,0,0,0,0,524288,''),
        (5135,3083,0,0,0,0,'Svalbrad Farmountain','Trade Goods',0,0,55,55,26140,26140,0,0,3271,1217,6,1,1.14286,1,18,5,0,0,1,141,170,0,248,1,2000,2000,1,0,0,0,0,0,0,0,70.664,97.163,100,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,1,689,'',1,3,0,0,3,5135,0,0,0,0,524288,'');

        UPDATE `creature_template` SET `subname` = 'Cartography Trainer', `static_flags` = 102, `npc_flags` = 0x8 WHERE `entry` = 5134;
        UPDATE `creature_template` SET `subname` = 'Cartography Supplier', `static_flags` = 102, `npc_flags` = 0x1 WHERE `entry` = 5135;
        UPDATE `creature_template` SET `npc_flags` = 0x4 WHERE `entry` = 1233;
        UPDATE `creature_template` SET `npc_flags` = 0 WHERE `entry` IN (347, 857, 907, 2302, 2804, 3890);
        UPDATE `creature_template` SET `npc_flags` = 0x1 WHERE `entry` IN (2225, 3343, 3625, 4255, 4257);

        insert into applied_updates values ('270820222');
    end if;

    -- 27/08/2022 3
    if (select count(*) from applied_updates where id='270820223') = 0 then
        -- https://github.com/vmangos/core/commit/357ca1b1f96b4afb2e312f279a4421527a0d55a2
        -- Assign money loot to gameobjects based on sniffs.
        UPDATE `gameobject_template` SET `mingold`=5, `maxgold`=11 WHERE `entry`=19021;
        UPDATE `gameobject_template` SET `mingold`=10, `maxgold`=20 WHERE `entry`=2843;
        UPDATE `gameobject_template` SET `mingold`=14, `maxgold`=20 WHERE `entry`=179487;
        UPDATE `gameobject_template` SET `mingold`=18, `maxgold`=129 WHERE `entry`=128308;
        UPDATE `gameobject_template` SET `mingold`=20, `maxgold`=131 WHERE `entry`=128403;
        UPDATE `gameobject_template` SET `mingold`=30, `maxgold`=75 WHERE `entry`=106319;
        UPDATE `gameobject_template` SET `mingold`=60, `maxgold`=119 WHERE `entry`=2849;
        UPDATE `gameobject_template` SET `mingold`=101, `maxgold`=103 WHERE `entry`=111095;
        UPDATE `gameobject_template` SET `mingold`=121, `maxgold`=208 WHERE `entry`=2850;
        UPDATE `gameobject_template` SET `mingold`=145, `maxgold`=269 WHERE `entry`=2852;
        UPDATE `gameobject_template` SET `mingold`=162, `maxgold`=315 WHERE `entry`=2855;
        UPDATE `gameobject_template` SET `mingold`=171, `maxgold`=240 WHERE `entry`=75293;
        UPDATE `gameobject_template` SET `mingold`=205, `maxgold`=385 WHERE `entry`=2857;
        UPDATE `gameobject_template` SET `mingold`=211, `maxgold`=211 WHERE `entry`=4096;
        UPDATE `gameobject_template` SET `mingold`=242, `maxgold`=242 WHERE `entry`=105581;
        UPDATE `gameobject_template` SET `mingold`=245, `maxgold`=360 WHERE `entry`=75298;
        UPDATE `gameobject_template` SET `mingold`=267, `maxgold`=267 WHERE `entry`=105570;
        UPDATE `gameobject_template` SET `mingold`=381, `maxgold`=395 WHERE `entry`=75299;
        UPDATE `gameobject_template` SET `mingold`=388, `maxgold`=388 WHERE `entry`=74448;
        UPDATE `gameobject_template` SET `mingold`=401, `maxgold`=791 WHERE `entry`=4149;
        UPDATE `gameobject_template` SET `mingold`=568, `maxgold`=777 WHERE `entry`=75300;
        UPDATE `gameobject_template` SET `mingold`=816, `maxgold`=1594 WHERE `entry`=153454;
        UPDATE `gameobject_template` SET `mingold`=980, `maxgold`=1461 WHERE `entry`=153453;
        UPDATE `gameobject_template` SET `mingold`=1628, `maxgold`=2366 WHERE `entry`=153464;
        UPDATE `gameobject_template` SET `mingold`=1879, `maxgold`=1879 WHERE `entry`=153469;
        UPDATE `gameobject_template` SET `mingold`=8751, `maxgold`=8751 WHERE `entry`=179697;

        insert into applied_updates values ('270820223');
    end if;

    -- 28/08/2022 1
    if (select count(*) from applied_updates where id='280820221') = 0 then
        -- Remove wrong reputation rewards for 0.5.3 quests.
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=2;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=5;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=6;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=7;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=8;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=9;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=10;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=11;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=12;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=13;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=14;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=15;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=16;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=17;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=18;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=19;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=20;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=21;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=22;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=23;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=24;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=25;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=26;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=27;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=28;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=29;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=30;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=31;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=32;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=33;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=34;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=35;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=36;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=37;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=38;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=39;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=40;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=45;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=46;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=47;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=48;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=49;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=50;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=51;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=52;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=53;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=54;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=55;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=56;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=57;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=58;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=59;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=60;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=61;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=62;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=63;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=64;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=65;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=66;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=67;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=68;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=69;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=70;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=71;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=72;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=74;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=75;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=76;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=77;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=78;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=79;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=80;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=81;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=82;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=83;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=84;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=85;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=86;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=87;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=88;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=89;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=90;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=91;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=92;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=93;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=94;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=95;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=96;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=97;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=98;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=99;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=100;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=101;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=102;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=103;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=104;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=105;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=106;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=107;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=109;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=110;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=111;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=112;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=113;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=114;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=115;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=116;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=117;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=118;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=119;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=120;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=121;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=122;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=123;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=124;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=125;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=126;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=127;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=128;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=129;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=130;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=131;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=132;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=133;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=134;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=135;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=136;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=138;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=139;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=140;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=141;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=142;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=143;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=144;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=145;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=146;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=147;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=148;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=149;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=150;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=151;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=152;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=153;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=154;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=155;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=156;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=157;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=158;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=159;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=160;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=161;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=162;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=163;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=164;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=165;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=166;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=167;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=168;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=169;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=170;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=171;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=173;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=174;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=175;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=176;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=177;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=178;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=179;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=180;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=181;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=182;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=183;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=184;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=185;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=186;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=187;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=188;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=189;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=190;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=191;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=192;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=193;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=194;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=195;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=196;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=197;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=198;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=199;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=200;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=201;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=202;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=203;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=204;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=205;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=206;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=207;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=208;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=209;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=210;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=211;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=212;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=213;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=214;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=215;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=216;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=217;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=218;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=219;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=220;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=221;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=222;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=223;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=224;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=225;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=226;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=227;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=228;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=229;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=230;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=231;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=232;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=233;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=234;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=235;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=236;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=237;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=238;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=239;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=240;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=243;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=244;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=245;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=246;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=247;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=248;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=249;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=250;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=251;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=252;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=253;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=254;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=255;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=256;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=257;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=258;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=261;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=262;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=263;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=264;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=265;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=266;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=267;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=268;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=269;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=270;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=271;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=272;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=273;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=274;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=275;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=276;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=277;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=278;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=279;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=280;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=281;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=282;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=283;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=284;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=285;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=286;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=287;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=288;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=289;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=290;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=291;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=292;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=293;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=294;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=295;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=296;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=297;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=298;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=299;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=301;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=302;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=303;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=304;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=305;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=306;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=307;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=308;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=309;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=310;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=311;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=312;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=313;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=314;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=315;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=317;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=318;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=319;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=320;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=321;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=322;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=323;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=324;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=325;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=328;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=329;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=330;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=331;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=332;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=333;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=334;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=335;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=336;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=337;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=338;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=339;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=340;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=341;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=342;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=343;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=344;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=345;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=346;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=347;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=348;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=349;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=350;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=351;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=353;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=354;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=355;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=356;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=357;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=358;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=359;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=360;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=361;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=362;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=363;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=364;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=365;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=366;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=367;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=368;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=369;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=370;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=371;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=372;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=373;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=374;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=375;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=376;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=377;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=378;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=379;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=380;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=381;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=382;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=383;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=384;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=385;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=386;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=387;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=388;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=389;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=391;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=392;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=393;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=394;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=395;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=396;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=397;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=398;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=399;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=400;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=401;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=403;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=404;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=405;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=407;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=408;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=409;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=410;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=411;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=412;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=413;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=414;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=415;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=416;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=417;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=418;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=419;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=420;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=421;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=422;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=423;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=424;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=425;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=426;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=427;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=428;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=429;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=430;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=431;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=432;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=433;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=434;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=435;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=436;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=437;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=438;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=439;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=440;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=441;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=442;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=443;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=444;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=445;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=446;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=447;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=448;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=449;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=450;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=451;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=452;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=453;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=454;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=455;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=456;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=457;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=458;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=459;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=460;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=461;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=463;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=464;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=465;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=466;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=467;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=468;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=469;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=470;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=471;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=472;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=473;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=474;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=475;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=476;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=477;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=478;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=479;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=480;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=481;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=482;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=483;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=484;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=485;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=486;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=487;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=488;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=489;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=491;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=492;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=493;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=494;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=495;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=496;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=498;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=499;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=500;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=501;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=502;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=503;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=504;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=505;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=506;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=507;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=508;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=509;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=510;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=511;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=512;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=513;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=514;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=515;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=516;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=517;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=518;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=519;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=520;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=521;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=522;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=523;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=524;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=525;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=526;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=527;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=528;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=529;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=530;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=531;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=532;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=533;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=535;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=536;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=537;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=538;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=539;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=540;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=541;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=542;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=543;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=544;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=545;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=546;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=547;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=549;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=550;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=551;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=552;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=553;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=554;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=555;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=556;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=557;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=559;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=560;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=561;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=562;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=563;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=564;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=565;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=566;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=567;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=568;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=569;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=570;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=571;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=572;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=573;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=574;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=575;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=576;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=577;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=578;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=579;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=580;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=581;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=582;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=583;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=584;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=585;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=586;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=587;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=588;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=589;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=590;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=591;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=592;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=593;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=594;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=595;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=596;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=597;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=598;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=599;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=600;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=601;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=602;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=603;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=604;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=605;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=606;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=607;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=608;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=609;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=610;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=611;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=613;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=614;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=615;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=616;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=617;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=618;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=619;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=621;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=622;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=623;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=624;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=625;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=626;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=627;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=628;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=629;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=630;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=631;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=632;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=633;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=634;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=635;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=636;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=637;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=638;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=639;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=640;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=641;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=642;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=643;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=644;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=645;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=646;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=647;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=648;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=649;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=650;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=651;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=652;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=653;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=654;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=655;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=656;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=657;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=658;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=659;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=660;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=661;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=662;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=663;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=664;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=665;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=666;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=667;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=668;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=669;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=670;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=671;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=672;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=673;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=674;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=675;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=676;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=677;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=678;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=679;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=680;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=681;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=682;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=683;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=684;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=685;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=686;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=687;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=688;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=689;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=690;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=691;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=692;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=693;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=694;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=695;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=696;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=697;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=698;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=699;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=700;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=701;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=702;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=703;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=704;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=705;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=706;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=707;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=708;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=709;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=710;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=711;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=712;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=713;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=714;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=715;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=716;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=717;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=718;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=719;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=720;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=721;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=722;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=723;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=724;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=725;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=726;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=727;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=728;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=729;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=730;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=731;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=732;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=733;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=734;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=735;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=736;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=737;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=738;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=739;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=741;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=742;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=743;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=744;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=745;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=746;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=747;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=748;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=749;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=750;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=751;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=752;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=753;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=754;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=755;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=756;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=757;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=758;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=759;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=760;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=761;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=762;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=763;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=764;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=765;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=766;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=767;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=768;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=769;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=770;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=771;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=772;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=773;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=775;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=776;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=777;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=778;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=779;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=780;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=781;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=782;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=783;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=784;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=786;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=787;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=788;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=789;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=790;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=791;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=792;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=793;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=794;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=795;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=796;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=797;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=798;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=799;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=801;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=802;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=803;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=804;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=805;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=806;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=808;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=809;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=812;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=813;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=815;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=816;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=817;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=818;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=819;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=821;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=822;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=823;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=824;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=825;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=826;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=827;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=828;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=829;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=830;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=831;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=832;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=833;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=834;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=835;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=836;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=837;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=838;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=840;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=841;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=842;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=843;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=844;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=845;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=846;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=847;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=848;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=849;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=850;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=851;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=852;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=853;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=854;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=855;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=857;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=858;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=860;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=861;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=862;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=863;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=864;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=865;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=866;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=867;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=868;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=869;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=870;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=871;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=872;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=873;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=874;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=875;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=876;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=877;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=878;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=879;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=880;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=881;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=882;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=883;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=884;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=885;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=886;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=887;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=888;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=889;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=890;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=891;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=892;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=893;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=894;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=895;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=896;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=897;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=898;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=899;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=900;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=901;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=902;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=903;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=905;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=906;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=907;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=908;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=909;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=913;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=914;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=916;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=917;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=918;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=919;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=920;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=921;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=922;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=923;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=924;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=926;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=927;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=928;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=929;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=930;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=931;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=932;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=933;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=934;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=935;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=936;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=937;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=938;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=939;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=940;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=941;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=942;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=943;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=944;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=945;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=947;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=948;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=949;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=950;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=951;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=952;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=953;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=954;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=955;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=956;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=957;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=958;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=959;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=960;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=961;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=962;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=963;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=964;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=965;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=966;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=967;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=968;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=969;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=970;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=971;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=972;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=973;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=974;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=975;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=976;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=977;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=978;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=979;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=980;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=981;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=982;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=983;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=984;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=985;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=986;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=990;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=991;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=992;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=993;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=994;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=995;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=996;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=997;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=998;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1001;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1002;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1003;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1007;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1008;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1009;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1010;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1011;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1012;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1013;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1014;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1016;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1017;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1018;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1019;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1020;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1021;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1022;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1023;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1024;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1025;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1026;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1027;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1028;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1029;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1030;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1031;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1032;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1033;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1034;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1035;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1036;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1037;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1038;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1039;
        UPDATE `quest_template` SET `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1040;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1041;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1042;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1043;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1044;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1045;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1046;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1048;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1049;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1050;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1051;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1052;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1053;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1054;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1055;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1056;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1057;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1058;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1059;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1060;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1061;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1062;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1063;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1064;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1065;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1066;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1067;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1068;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1069;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1070;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1071;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1072;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1073;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1074;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1075;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1076;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1077;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1078;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1079;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1080;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1081;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1082;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1083;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1084;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1085;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1086;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1087;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1088;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1089;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1090;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1091;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1092;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1093;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1094;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1095;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1096;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1097;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1098;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1100;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1101;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1102;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1103;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1104;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1105;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1106;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1107;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1108;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1109;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1110;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1111;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1112;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1113;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1114;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1115;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1116;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1117;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1118;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1119;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1120;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1121;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1122;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1124;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1126;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1127;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1130;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1131;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1132;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1133;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1134;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1135;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1136;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1137;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1138;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1139;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1140;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1141;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1142;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1143;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1144;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1145;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1146;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1147;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1148;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1149;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1150;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1151;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1152;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1153;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1154;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1156;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1157;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1158;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1159;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1160;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1164;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1166;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1167;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1168;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1169;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1170;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1171;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1172;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1173;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1175;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1176;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1177;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1178;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1179;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1180;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1181;
        UPDATE `quest_template` SET `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1182;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1183;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1184;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1186;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1187;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1188;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1189;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1190;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1191;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1192;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1193;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1194;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1195;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1196;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1197;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1198;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1199;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1200;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1201;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1202;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1203;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1204;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1205;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1206;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1218;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1219;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1220;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1221;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1222;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1238;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1239;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1240;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1241;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1242;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1243;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1244;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1245;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1246;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1247;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1248;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1249;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1250;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1251;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1252;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1253;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1258;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1259;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1260;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1261;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1262;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1264;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1265;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1266;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1267;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1268;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1269;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1270;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1271;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1273;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1274;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1275;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1276;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1282;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1284;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1285;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1286;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1287;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1288;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1289;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1301;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1302;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1319;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1320;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1321;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1322;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1323;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1324;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1338;
        UPDATE `quest_template` SET `RewRepFaction1` = 0, `RewRepValue1` = 0, `RewRepFaction2` = 0, `RewRepValue2` = 0, `RewRepFaction3` = 0, `RewRepValue3` = 0, `RewRepFaction4` = 0, `RewRepValue4` = 0, `RewRepFaction5` = 0, `RewRepValue5` = 0 WHERE `entry`=1339;

        insert into applied_updates values ('280820221');
    end if;

    -- 29/08/2022 1
    if (select count(*) from applied_updates where id='290820221') = 0 then
        -- FIX 593 590 588 587 580 578

        -- Shore Strider
        UPDATE `creature_template`
        SET `display_id1`=3217
        WHERE `entry`=5359;
        
        -- Holgar Stormaxe
        UPDATE `creature_template`
        SET `display_id1`=1906
        WHERE `entry`=4311;
        
        -- Silithid Hive Drone
        UPDATE `creature_template`
        SET `display_id1`=2304
        WHERE `entry`=4133;
        
        -- Devlin
        UPDATE `creature_template`
        SET `display_id1`=1245
        WHERE `entry`=1657;
        
        -- Lethlas
        UPDATE `creature_template`
        SET `display_id1`=2930
        WHERE `entry`=5212;
        
        -- Phantim
        UPDATE `creature_template`
        SET `display_id1`=2930
        WHERE `entry`=5314;
        
        -- Thule Ravenclaw
        UPDATE `creature_template`
        SET `display_id1`=263
        WHERE `entry`=1947;
        
        -- Silithid Grub
        UPDATE `creature_template`
        SET `display_id1`=641
        WHERE `entry`=3251;
        
        insert into applied_updates values ('290820221');
    end if;
end $
delimiter ;
