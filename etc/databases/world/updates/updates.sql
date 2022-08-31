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

    -- 29/08/2022 2
    if (select count(*) from applied_updates where id='290820222') = 0 then
        -- Allakhazam

        -- Hammer of the Northern Wind -> 2004-08-24 15:48:53 -> spelleffect1 changed from '116' to '13439', dmg_low changed from '50' to '62', dmg_high changed from '93' to '117'
        UPDATE `item_template` SET `dmg_max1` = '93', `dmg_min1` = '50', `spellid_1` = '116' WHERE (`entry` = '810');

        -- Axe of the Deep Woods -> 2004-08-22 12:15:54 -> dmg_high changed from '117' to '146', dmg_low changed from '62' to '78'
        UPDATE `item_template` SET `dmg_max1` = '117', `dmg_min1` = '62' WHERE (`entry` = '811');

        -- Warden Staff -> 2004-08-23 15:02:37 -> displayinfo changed from '5098' to '20256', dmg_high changed from '109' to '143', dmg_low changed from '72' to '95'
        UPDATE `item_template` SET `display_id` = '5098', `dmg_max1` = '109', `dmg_min1` = '72' WHERE (`entry` = '943');

        -- Tough Condor Meat -> 2004-10-14 12:15:49 -> displayinfo changed from '7416' to '25475'
        UPDATE `item_template` SET `display_id` = '7416' WHERE (`entry` = '1080');

        -- Skullflame Shield -> 2004-08-20 10:26:39 -> armor changed from '248' to '908'
        UPDATE `item_template` SET `armor` = '248' WHERE (`entry` = '1168');

        -- Blackskull Shield -> 2004-07-08 17:58:29 -> displayinfo changed from '6271' to '18816', armor changed from '208' to '743'
        UPDATE `item_template` SET `display_id` = '6271', `armor` = '208' WHERE (`entry` = '1169');

        -- Wall of the Dead -> 2004-10-12 18:27:21 -> armor changed from '864' to '900'
        UPDATE `item_template` SET `armor` = '864' WHERE (`entry` = '1979');

        -- Nightblade -> 2004-07-08 15:50:25 -> dmg_high changed from '133' to '117', dmg_low changed from '88' to '77', spelleffect1 changed from '0' to '13440' (Still wrong, might had no spell)
        -- displayinfo changed from '5058' to '20191'
        UPDATE `item_template` SET `display_id` = '5058', `dmg_max1` = '133', `dmg_min1` = '88', `spellid_1` = '13440' WHERE (`entry` = '1982');

        -- Pressed Felt Robe -> 2004-05-24 19:11:41 -> armor changed from '23' to '25
        UPDATE `item_template` SET `armor` = '23' WHERE (`entry` = '1997');

        -- Hillborne Axe -> 2004-07-12 15:16:32 -> displayinfo changed from '18340' to '19400' (Still off) -> dmg_high changed from '45' to '43', dmg_low changed from '23' to '22'
        UPDATE `item_template` SET `display_id` = '18340', `dmg_max1` = '45', `dmg_min1` = '23' WHERE (`entry` = '2080');

        -- Dwarven Hand Cannon -> 2004-10-01 02:33:42 -> displayinfo changed from '6598' to '24652'
        UPDATE `item_template` SET `display_id` = '6598', `dmg_max2` = '11', `dmg_min2` = '1' WHERE (`entry` = '2099');

        -- Conjured Purified Water -> 2004-05-05 19:48:37 -> displayinfo changed from '6341' to '15849'
        UPDATE `item_template` SET `display_id` = '6341' WHERE (`entry` = '2136');

        -- ShadowBlade -> 2004-08-24 09:02:58 -> displayinfo changed from '6444' to '20291'
        UPDATE `item_template` SET `display_id` = '6444', `dmg_max1` = '61', `dmg_min1` = '32', `spellid_1` = '0' WHERE (`entry` = '2163');

        -- Staff of the Shade -> 2004-04-30 15:42:39 -> spelleffect1 changed from '2263' to '8472'
        UPDATE `item_template` SET `spellid_1` = '2263' WHERE (`entry` = '2549');

        -- Crude Flint -> 2004-06-18 19:18:14 -> displayinfo changed from '1502' to '18107', stacksize changed from '10' to '20'
        UPDATE `item_template` SET `display_id` = '1502', `stackable` = '10' WHERE (`entry` = '2611');

        -- Latched Belt -> 2004-11-08 02:46:30 -> displayinfo changed from '6963' to '28201'
        UPDATE `item_template` SET `display_id` = '6963' WHERE (`entry` = '2690');

        -- Antipodean Rod -> 2004-06-21 11:55:20 -> spelleffect1 changed from '2246' to '7684', spelleffect2 changed from '2250' to '7698'
        UPDATE `item_template` SET `spellid_1` = '2246', `spellid_2` = '2250' WHERE (`entry` = '2879');

        -- Eye of Flame -> 2004-08-20 11:50:42 -> spelleffect1 changed from '7689' to '9298'
        UPDATE `item_template` SET `spellid_1` = '7689' WHERE (`entry` = '3075');

        -- Melrache's Cape -> 2004-07-15 11:07:13 -> name1 changed from 'Scarlet Cloak' to 'Melrache's Cape'
        UPDATE `item_template` SET `name` = 'Scarlet Cloak' WHERE (`entry` = '3331');

        -- Elixir of Wisdom -> 2004-04-22 13:47:13 -> displayinfo changed from '1215' to '15745'
        UPDATE `item_template` SET `display_id` = '1215' WHERE (`entry` = '3383');

        -- Elixir of Poison Resistance -> 2004-05-28 12:19:47 -> displayinfo changed from '2345' to '15750'
        UPDATE `item_template` SET `display_id` = '2345' WHERE (`entry` = '3386');

        -- Limited Invulnerability Potion -> 2004-11-08 19:25:07 -> displayinfo changed from '2348' to '24213', level changed from '25' to '50'
        UPDATE `item_template` SET `display_id` = '2348', `required_level` = '25' WHERE (`entry` = '3387');

        -- Strong Troll's Blood Elixir -> 2004-07-02 14:58:22 -> displayinfo changed from '3664' to '15770'
        UPDATE `item_template` SET `display_id` = '3664', `required_level` = '25' WHERE (`entry` = '3388');

        -- Elixir of Defense -> 2004-07-02 14:58:22 -> displayinfo changed from '2345' to '15773'
        UPDATE `item_template` SET `display_id` = '2345' WHERE (`entry` = '3389');

        -- Gray Bear Tongue -> 2004-09-04 02:08:23 -> displayinfo changed from '3759' to '20898', stacksize changed from '10' to '20'
        UPDATE `item_template` SET `display_id` = '3759', `stackable` = '10' WHERE (`entry` = '3476');

        -- Mudsnout Blossoms -> 2004-09-04 02:08:23 -> displayinfo changed from '2793' to '17459', stacksize changed from '10' to '20'
        UPDATE `item_template` SET `display_id` = '2793', `stackable` = '10' WHERE (`entry` = '3502');

        -- Turtle Meat -> 2004-10-13 23:43:10 -> displayinfo changed from '2599' to '25472'
        UPDATE `item_template` SET `display_id` = '2599' WHERE (`entry` = '3712');

        -- Crippling Poison -> 2004-07-19 16:33:22 -> displayinfo changed from '2947' to '13708'
        UPDATE `item_template` SET `display_id` = '2947' WHERE (`entry` = '3775');

        -- Stranglekelp -> 2004-06-21 11:55:17 -> displayinfo changed from '7406' to '18089'
        UPDATE `item_template` SET `display_id` = '7406' WHERE (`entry` = '3820');

        -- Frost Oil -> 2006-03-08 02:25:21 -> displayinfo changed from '178' to '15794'
        UPDATE `item_template` SET `display_id` = '178' WHERE (`entry` = '3829');

        -- Mithril Ore -> 2004-08-20 11:50:29 -> displayinfo changed from '4691' to '20661'
        UPDATE `item_template` SET `display_id` = '4691' WHERE (`entry` = '3858');

        -- Blocking Targe -> 2004-07-17 18:13:55 -> block changed from '42' to '20', armor changed from '51' to '102'
        UPDATE `item_template` SET `armor` = '51', `block` = '42' WHERE (`entry` = '3989');

        -- Crested Buckler -> 2004-10-09 19:22:47 -> block changed from '17' to '23', armor changed from '609' to '756'
        UPDATE `item_template` SET `armor` = '609', `block` = '17' WHERE (`entry` = '3990');

        -- Coarse Gorilla Hair -> 2004-06-21 11:55:20 -> displayinfo changed from '1007' to '18096'
        UPDATE `item_template` SET `display_id` = '1007' WHERE (`entry` = '4096');

        -- Master Hunter's Bow -> 2004-08-20 10:23:59 -> displayinfo changed from '4441' to '20555', dmg_high changed from '113' to '102', dmg_low changed from '60' to '54'
        UPDATE `item_template` SET `display_id` = '4441', `dmg_max1` = '113', `dmg_min1` = '60' WHERE (`entry` = '4110');

        -- Mechanical Squirrel Box -> 2004-06-21 11:55:34 -> displayinfo changed from '7387' to '16536'
        UPDATE `item_template` SET `display_id` = '7387' WHERE (`entry` = '4401');

        -- Soft Bushy Tail -> 2004-07-29 15:49:43 -> displayinfo changed from '12862' to '1809
        UPDATE `item_template` SET `display_id` = '12862' WHERE (`entry` = '4582');

        -- Goblin Fishing Pole -> 2004-07-19 15:13:01 -> displayinfo changed from '6384' to '18063'
        UPDATE `item_template` SET `display_id` = '6384' WHERE (`entry` = '4598');

        -- Firebloom -> 2004-06-21 11:55:16 -> displayinfo changed from '7364' to '2788'
        UPDATE `item_template` SET `display_id` = '7364' WHERE (`entry` = '4625');

        -- Ceremonial Cloak -> 2004-06-22 17:08:06 -> displayinfo changed from '8760' to '15084'
        UPDATE `item_template` SET `display_id` = '8760' WHERE (`entry` = '4692');

        -- Explosive Stick of Gann -> 2004-09-04 02:08:24 -> displayinfo changed from '6384' to '18062'
        UPDATE `item_template` SET `display_id` = '6384' WHERE (`entry` = '5021');

        -- Shadow Hunter Knife -> 2004-09-28 17:19:53 -> displayinfo changed from '6444' to '20321'
        UPDATE `item_template` SET `display_id` = '6444' WHERE (`entry` = '5040');

        -- Impaling Harpoon -> 2004-09-28 17:19:53 -> displayinfo changed from '12562' to '5949'
        UPDATE `item_template` SET `display_id` = '5949' WHERE (`entry` = '5200');

        -- Raptor Punch -> 2004-06-22 17:08:06 -> displayinfo changed from '6245' to '18099'
        UPDATE `item_template` SET `display_id` = '6245' WHERE (`entry` = '5342');

        -- Key to Searing Gorge -> 2004-07-15 11:07:13 -> displayinfo changed from '7827' to '13824
        UPDATE `item_template` SET `display_id` = '7827' WHERE (`entry` = '5396');

        -- Kaldorei Spider Kabob -> 2004-09-02 19:03:38 -> name1 changed from 'Kaldorei Caviar' to 'Kaldorei Spider Kabob', displayinfo changed from '7991' to '21327
        UPDATE `item_template` SET `name` = 'Kaldorei Caviar', `display_id` = '7991' WHERE (`entry` = '5472');

        -- Clam Meat -> 2004-09-23 19:49:10 -> displayinfo changed from '6350' to '22193'
        UPDATE `item_template` SET `display_id` = '6350' WHERE (`entry` = '5503');

        -- Unrefined Ore Sample ->2004-07-19 15:54:42 -> displayinfo changed from '9142' to '18107'
        UPDATE `item_template` SET `display_id` = '9142' WHERE (`entry` = '5842');

        -- Regent's Cloak -> 2004-09-25 10:22:04 -> displayinfo changed from '15179' to '23059'
        UPDATE `item_template` SET `display_id` = '15179' WHERE (`entry` = '5969');

        -- All patterns, plans. 2004-12-22 03:54:35 -> displayinfo changed from '1102' to '15274'
        UPDATE `item_template` SET `display_id` = '1102' WHERE (`display_id` = '15274');

        -- Fire Oil -> 2004-07-02 14:58:21 -> displayinfo changed from '11461' to '15771'
        UPDATE `item_template` SET `display_id` = '11461' WHERE (`entry` = '6371');

        -- Blackforge Greaves -> 2004-11-08 07:05:03 -> displayinfo changed from '11629' to '26077'
        UPDATE `item_template` SET `display_id` = '11629' WHERE (`entry` = '6423');

        -- Imperial Leather Breastplate -> 2004-06-21 11:55:34 -> displayinfo changed from '14699' to '18471'
        UPDATE `item_template` SET `display_id` = '14699' WHERE (`entry` = '6430');

        -- Glowing Lizardscale Cloak -> 2004-04-22 13:47:13 -> displayinfo changed from '8787' to '15187', armor changed from '27' to '30'
        UPDATE `item_template` SET `display_id` = '8787', `armor` = '27' WHERE (`entry` = '6449');

        -- Dazzling Longsword -> 2004-08-20 11:51:08 -> spelleffect1 changed from '770' to '13424'
        UPDATE `item_template` SET `spellid_1` = '770' WHERE (`entry` = '869');

        -- Fiery War Axe -> 2004-08-22 12:15:45 -> spelleffect1 changed from '143' to '13438'
        UPDATE `item_template` SET `spellid_1` = '143' WHERE (`entry` = '870');

        -- Flurry Axe -> 2004-08-20 10:23:58 -> spelleffect1 changed from '8815' to '13679'
        UPDATE `item_template` SET `spellid_1` = '8815' WHERE (`entry` = '871');

        -- Freezing Band -> 2004-08-20 11:51:08 -> spelleffect1 changed from '5151' to '0'
        UPDATE `item_template` SET `spellid_1` = '5151', `spellid_2` = '0' WHERE (`entry` = '942');

        -- Night Reaver -> 2004-07-19 15:54:42 -> spelleffect1 changed from '695' to '0'
        UPDATE `item_template` SET `spellid_1` = '695' WHERE (`entry` = '1318');

        -- Ring of Healing -> 2004-08-20 10:24:00 -> spelleffect1 changed from '2053' to '14053'
        UPDATE `item_template` SET `spellid_1` = '2053' WHERE (`entry` = '1713');

        -- Tanglewood Staff -> 2004-04-19 11:36:41 -> spelleffect1 changed from '2305' to '9354'
        UPDATE `item_template` SET `spellid_1` = '2305' WHERE (`entry` = '1720');

        -- Orb of Deception -> 2004-07-08 16:22:40 -> spelleffect1 changed from '700' to '12854'
        UPDATE `item_template` SET `spellid_1` = '700' WHERE (`entry` = '1973');

        -- Bloodscalp Channeling Staff -> 2004-08-20 11:51:01 -> spelleffect1 changed from '7695' to '9357'
        UPDATE `item_template` SET `spellid_1` = '7695' WHERE (`entry` = '1998');

        -- Phytoblade -> 2004-08-20 11:50:59 -> spelleffect1 changed from '5178' to '14119'
        UPDATE `item_template` SET `spellid_1` = '5178' WHERE (`entry` = '2263');

        -- Staff of the Blessed Seer -> 2004-07-09 10:07:13 -> spelleffect1 changed from '7676' to '8475'
        UPDATE `item_template` SET `spellid_1` = '7676' WHERE (`entry` = '2289');

        -- Burning War Axe -> 2004-06-23 13:32:14 -> spelleffect1 changed from '0' to '7711'
        UPDATE `item_template` SET `spellid_1` = '7711' WHERE (`entry` = '2299');

        -- Elven Spirit Claws -> 2004-06-20 23:31:05 -> spelleffect1 changed from '2258' to '7692'
        UPDATE `item_template` SET `spellid_1` = '2258' WHERE (`entry` = '2564');

        -- Rod of Molten Fire -> 2004-06-23 13:32:16 -> spelleffect1 changed from '2267' to '7687'
        UPDATE `item_template` SET `spellid_1` = '2267' WHERE (`entry` = '2565');

        -- Blazing Emblem -> 2004-08-20 10:24:00 -> spelleffect1 changed from '2120' to '13744'
        UPDATE `item_template` SET `spellid_1` = '2120' WHERE (`entry` = '2802');

        -- Nifty Stopwatch -> 2004-08-20 10:24:00 -> spelleffect1 changed from '246' to '14530'
        UPDATE `item_template` SET `spellid_1` = '246' WHERE (`entry` = '2820');

        -- Black Malice -> 2004-07-19 15:54:39 -> spelleffect1 changed from '695' to '0'
        UPDATE `item_template` SET `spellid_1` = '695' WHERE (`entry` = '3194');

        -- Smotts' Compass -> 2004-07-08 16:09:19 -> spelleffect1 changed from '0' to '7598'
        UPDATE `item_template` SET `spellid_1` = '7598' WHERE (`entry` = '4130');

        -- Black Husk Shield -> 2004-08-20 18:08:42 -> spelleffect1 changed from '2893' to '14253'
        UPDATE `item_template` SET `spellid_1` = '2893' WHERE (`entry` = '4444');

        -- Drink IV.
        UPDATE `item_template` SET `spellid_1` = '1133' WHERE (`spellid_1` = '11009');

        -- Faintly Glowing Skull -> 2004-09-28 17:19:53 -> spelleffect1 changed from '2006' to '16375'
        UPDATE `item_template` SET `spellid_1` = '3' WHERE (`entry` = '4945');

        -- Shiver Blade -> 2004-08-25 15:17:38 -> pelleffect1 changed from '113' to '13439'
        UPDATE `item_template` SET `spellid_1` = '113' WHERE (`entry` = '5182');

        -- Cruel Barb -> 2004-06-21 16:17:35 -> spelleffect1 changed from '5258' to '7597'
        UPDATE `item_template` SET `spellid_1` = '5258' WHERE (`entry` = '5191');

        -- Everglow Lantern -> 2004-04-19 11:37:40 -> spelleffect1 changed from '635' to '647'
        UPDATE `item_template` SET `spellid_1` = '635' WHERE (`entry` = '5323');

        -- Ornate Spyglass -> 2004-08-23 11:35:19 -> spelleffect1 changed from '6197' to '12883'
        UPDATE `item_template` SET `spellid_1` = '6197' WHERE (`entry` = '5507');

        -- Stinging Viper -> 2004-08-24 15:56:48 -> spelleffect1 changed from '3396' to '13518'
        UPDATE `item_template` SET `spellid_1` = '3396' WHERE (`entry` = '6472');

        -- 3368
        -- Bent Staff
        -- dmg_min1, from 5.0 to 11
        -- dmg_max1, from 8.0 to 16
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 16 WHERE (`entry` = 35);
        UPDATE `applied_item_updates` SET `entry` = 35, `version` = 3368 WHERE (`entry` = 35);
        -- Rugged Mail Vest
        -- buy_price, from 77 to 51
        -- sell_price, from 15 to 10
        UPDATE `item_template` SET `buy_price` = 51, `sell_price` = 10 WHERE (`entry` = 3273);
        UPDATE `applied_item_updates` SET `entry` = 3273, `version` = 3368 WHERE (`entry` = 3273);
        -- Worn Shortsword
        -- dmg_min1, from 2.0 to 6
        -- dmg_max1, from 4.0 to 10
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 25);
        UPDATE `applied_item_updates` SET `entry` = 25, `version` = 3368 WHERE (`entry` = 25);
        -- Worn Wooden Shield
        -- buy_price, from 7 to 11
        -- sell_price, from 1 to 2
        UPDATE `item_template` SET `buy_price` = 11, `sell_price` = 2 WHERE (`entry` = 2362);
        UPDATE `applied_item_updates` SET `entry` = 2362, `version` = 3368 WHERE (`entry` = 2362);
        -- Flax Vest
        -- buy_price, from 51 to 33
        -- sell_price, from 10 to 6
        UPDATE `item_template` SET `buy_price` = 33, `sell_price` = 6 WHERE (`entry` = 3270);
        UPDATE `applied_item_updates` SET `entry` = 3270, `version` = 3368 WHERE (`entry` = 3270);
        -- Flax Bracers
        -- buy_price, from 24 to 15
        -- sell_price, from 4 to 3
        UPDATE `item_template` SET `buy_price` = 15, `sell_price` = 3 WHERE (`entry` = 6060);
        UPDATE `applied_item_updates` SET `entry` = 6060, `version` = 3368 WHERE (`entry` = 6060);
        -- Worn Dagger
        -- dmg_min1, from 1.0 to 5
        -- dmg_max1, from 3.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 8 WHERE (`entry` = 2092);
        UPDATE `applied_item_updates` SET `entry` = 2092, `version` = 3368 WHERE (`entry` = 2092);
        -- Peon Sword
        -- dmg_min1, from 3.0 to 9
        -- dmg_max1, from 7.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2481);
        UPDATE `applied_item_updates` SET `entry` = 2481, `version` = 3368 WHERE (`entry` = 2481);
        -- Brawler's Pants
        -- display_id, from 9988 to 9993
        UPDATE `item_template` SET `display_id` = 9993 WHERE (`entry` = 139);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (139, 3368);
        -- Scratched Claymore
        -- dmg_min1, from 7.0 to 12
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 17 WHERE (`entry` = 2128);
        UPDATE `applied_item_updates` SET `entry` = 2128, `version` = 3368 WHERE (`entry` = 2128);
        -- Inferior Tomahawk
        -- dmg_min1, from 2.0 to 7
        -- dmg_max1, from 5.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 2482);
        UPDATE `applied_item_updates` SET `entry` = 2482, `version` = 3368 WHERE (`entry` = 2482);
        -- Rough Broad Axe
        -- dmg_min1, from 6.0 to 11
        -- dmg_max1, from 9.0 to 16
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 16 WHERE (`entry` = 2483);
        UPDATE `applied_item_updates` SET `entry` = 2483, `version` = 3368 WHERE (`entry` = 2483);
        -- Splintered Board
        -- dmg_min1, from 2.0 to 7
        -- dmg_max1, from 5.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 2485);
        UPDATE `applied_item_updates` SET `entry` = 2485, `version` = 3368 WHERE (`entry` = 2485);
        -- Large Stone Mace
        -- dmg_min1, from 6.0 to 13
        -- dmg_max1, from 10.0 to 18
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 2486);
        UPDATE `applied_item_updates` SET `entry` = 2486, `version` = 3368 WHERE (`entry` = 2486);
        -- Jagged Knife
        -- name, from Small Knife to Jagged Knife
        -- dmg_min1, from 2.0 to 5
        -- dmg_max1, from 4.0 to 8
        UPDATE `item_template` SET `name` = 'Jagged Knife', `dmg_min1` = 5, `dmg_max1` = 8 WHERE (`entry` = 2484);
        UPDATE `applied_item_updates` SET `entry` = 2484, `version` = 3368 WHERE (`entry` = 2484);
        -- Acolyte Staff
        -- dmg_min1, from 6.0 to 10
        -- dmg_max1, from 9.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 10, `dmg_max1` = 14 WHERE (`entry` = 2487);
        UPDATE `applied_item_updates` SET `entry` = 2487, `version` = 3368 WHERE (`entry` = 2487);
        -- Battle Chain Tunic
        -- quality, from 2 to 1
        -- buy_price, from 1181 to 708
        -- sell_price, from 236 to 141
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 708, `sell_price` = 141, `required_level` = 2 WHERE (`entry` = 3283);
        UPDATE `applied_item_updates` SET `entry` = 3283, `version` = 3368 WHERE (`entry` = 3283);
        -- Ancestral Tunic
        -- quality, from 2 to 1
        -- buy_price, from 813 to 609
        -- sell_price, from 162 to 121
        -- item_level, from 12 to 13
        -- required_level, from 7 to 3
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 609, `sell_price` = 121, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 3292);
        UPDATE `applied_item_updates` SET `entry` = 3292, `version` = 3368 WHERE (`entry` = 3292);
        -- Adept's Cloak
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3833);
        UPDATE `applied_item_updates` SET `entry` = 3833, `version` = 3368 WHERE (`entry` = 3833);
        -- Battle Knife
        -- required_level, from 4 to 1
        -- dmg_min1, from 4.0 to 9
        -- dmg_max1, from 8.0 to 14
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 4565);
        UPDATE `applied_item_updates` SET `entry` = 4565, `version` = 3368 WHERE (`entry` = 4565);
        -- Patchwork Cloth Gloves
        -- name, from Patchwork Gloves to Patchwork Cloth Gloves
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Gloves', `required_level` = 1 WHERE (`entry` = 1430);
        UPDATE `applied_item_updates` SET `entry` = 1430, `version` = 3368 WHERE (`entry` = 1430);
        -- Ancestral Leggings
        -- quality, from 2 to 1
        -- buy_price, from 498 to 299
        -- sell_price, from 99 to 59
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 299, `sell_price` = 59 WHERE (`entry` = 3291);
        UPDATE `applied_item_updates` SET `entry` = 3291, `version` = 3368 WHERE (`entry` = 3291);
        -- Executor Staff
        -- display_id, from 3405 to 4995
        UPDATE `item_template` SET `display_id` = 4995 WHERE (`entry` = 3277);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3277, 3368);
        -- Conjured Bread
        -- display_id, from 6342 to 6413
        UPDATE `item_template` SET `display_id` = 6413 WHERE (`entry` = 5349);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5349, 3368);
        -- Tribal Vest
        -- quality, from 2 to 1
        -- buy_price, from 802 to 751
        -- sell_price, from 160 to 150
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 751, `sell_price` = 150, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 3288);
        UPDATE `applied_item_updates` SET `entry` = 3288, `version` = 3368 WHERE (`entry` = 3288);
        -- Loose Chain Belt
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2635);
        UPDATE `applied_item_updates` SET `entry` = 2635, `version` = 3368 WHERE (`entry` = 2635);
        -- Loose Chain Gloves
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2645);
        UPDATE `applied_item_updates` SET `entry` = 2645, `version` = 3368 WHERE (`entry` = 2645);
        -- Fine Scimitar
        -- required_level, from 4 to 1
        -- dmg_min1, from 4.0 to 9
        -- dmg_max1, from 8.0 to 14
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 4560);
        UPDATE `applied_item_updates` SET `entry` = 4560, `version` = 3368 WHERE (`entry` = 4560);
        -- Tattered Cloth Shoes
        -- name, from Tattered Cloth Boots to Tattered Cloth Shoes
        UPDATE `item_template` SET `name` = 'Tattered Cloth Shoes' WHERE (`entry` = 195);
        UPDATE `applied_item_updates` SET `entry` = 195, `version` = 3368 WHERE (`entry` = 195);
        -- Loose Chain Vest
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2648);
        UPDATE `applied_item_updates` SET `entry` = 2648, `version` = 3368 WHERE (`entry` = 2648);
        -- Loose Chain Pants
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2646);
        UPDATE `applied_item_updates` SET `entry` = 2646, `version` = 3368 WHERE (`entry` = 2646);
        -- Small Tomahawk
        -- dmg_min1, from 3.0 to 9
        -- dmg_max1, from 7.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2498);
        UPDATE `applied_item_updates` SET `entry` = 2498, `version` = 3368 WHERE (`entry` = 2498);
        -- Worn Leather Bracers
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1420);
        UPDATE `applied_item_updates` SET `entry` = 1420, `version` = 3368 WHERE (`entry` = 1420);
        -- Tribal Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3286);
        UPDATE `applied_item_updates` SET `entry` = 3286, `version` = 3368 WHERE (`entry` = 3286);
        -- Raider Shortsword
        -- dmg_min1, from 6.0 to 13
        -- dmg_max1, from 12.0 to 20
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 2496);
        UPDATE `applied_item_updates` SET `entry` = 2496, `version` = 3368 WHERE (`entry` = 2496);
        -- Battle Shield
        -- display_id, from 2632 to 2633
        -- buy_price, from 444 to 903
        -- sell_price, from 88 to 180
        -- item_level, from 10 to 13
        -- required_level, from 5 to 3
        UPDATE `item_template` SET `display_id` = 2633, `buy_price` = 903, `sell_price` = 180, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 3650);
        UPDATE `applied_item_updates` SET `entry` = 3650, `version` = 3368 WHERE (`entry` = 3650);
        -- Brown Linen Robe
        -- required_level, from 5 to 1
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 1, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 6238);
        UPDATE `applied_item_updates` SET `entry` = 6238, `version` = 3368 WHERE (`entry` = 6238);
        -- Patchwork Cloth Belt
        -- name, from Patchwork Belt to Patchwork Cloth Belt
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Belt', `required_level` = 1 WHERE (`entry` = 3370);
        UPDATE `applied_item_updates` SET `entry` = 3370, `version` = 3368 WHERE (`entry` = 3370);
        -- Brown Linen Pants
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 4343);
        UPDATE `applied_item_updates` SET `entry` = 4343, `version` = 3368 WHERE (`entry` = 4343);
        -- Heavy Linen Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 4307);
        UPDATE `applied_item_updates` SET `entry` = 4307, `version` = 3368 WHERE (`entry` = 4307);
        -- Patchwork Cloth Vest
        -- name, from Patchwork Armor to Patchwork Cloth Vest
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Vest', `required_level` = 1 WHERE (`entry` = 1433);
        UPDATE `applied_item_updates` SET `entry` = 1433, `version` = 3368 WHERE (`entry` = 1433);
        -- Tribal Pants
        -- quality, from 2 to 1
        -- buy_price, from 998 to 599
        -- sell_price, from 199 to 119
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 599, `sell_price` = 119, `required_level` = 2 WHERE (`entry` = 3287);
        UPDATE `applied_item_updates` SET `entry` = 3287, `version` = 3368 WHERE (`entry` = 3287);
        -- Sharpened Letter Opener
        -- required_level, from 4 to 1
        -- dmg_min1, from 2.0 to 5
        -- dmg_max1, from 5.0 to 9
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 5, `dmg_max1` = 9 WHERE (`entry` = 2138);
        UPDATE `applied_item_updates` SET `entry` = 2138, `version` = 3368 WHERE (`entry` = 2138);
        -- Worn Large Shield
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2213);
        UPDATE `applied_item_updates` SET `entry` = 2213, `version` = 3368 WHERE (`entry` = 2213);
        -- Ancestral Sash
        -- name, from Ancestral Belt to Ancestral Sash
        -- buy_price, from 183 to 229
        -- sell_price, from 36 to 45
        -- item_level, from 11 to 12
        -- required_level, from 6 to 2
        UPDATE `item_template` SET `name` = 'Ancestral Sash', `buy_price` = 229, `sell_price` = 45, `item_level` = 12, `required_level` = 2 WHERE (`entry` = 4672);
        UPDATE `applied_item_updates` SET `entry` = 4672, `version` = 3368 WHERE (`entry` = 4672);
        -- Ancestral Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3642);
        UPDATE `applied_item_updates` SET `entry` = 3642, `version` = 3368 WHERE (`entry` = 3642);
        -- Ancestral Gloves
        -- display_id, from 11392 to 11393
        -- buy_price, from 193 to 302
        -- sell_price, from 38 to 60
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `display_id` = 11393, `buy_price` = 302, `sell_price` = 60, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 3290);
        UPDATE `applied_item_updates` SET `entry` = 3290, `version` = 3368 WHERE (`entry` = 3290);
        -- Adept Short Staff
        -- dmg_min1, from 9.0 to 14
        -- dmg_max1, from 14.0 to 20
        UPDATE `item_template` SET `dmg_min1` = 14, `dmg_max1` = 20 WHERE (`entry` = 2503);
        UPDATE `applied_item_updates` SET `entry` = 2503, `version` = 3368 WHERE (`entry` = 2503);
        -- Patchwork Cloth Boots
        -- name, from Patchwork Shoes to Patchwork Cloth Boots
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Boots', `required_level` = 1 WHERE (`entry` = 1427);
        UPDATE `applied_item_updates` SET `entry` = 1427, `version` = 3368 WHERE (`entry` = 1427);
        -- Heavy Weave Boots
        -- name, from Heavy Weave Shoes to Heavy Weave Boots
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `name` = 'Heavy Weave Boots', `required_level` = 7 WHERE (`entry` = 840);
        UPDATE `applied_item_updates` SET `entry` = 840, `version` = 3368 WHERE (`entry` = 840);
        -- Heavy Weave Bracers
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 3590);
        UPDATE `applied_item_updates` SET `entry` = 3590, `version` = 3368 WHERE (`entry` = 3590);
        -- Loose Chain Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2643);
        UPDATE `applied_item_updates` SET `entry` = 2643, `version` = 3368 WHERE (`entry` = 2643);
        -- Battle Buckler
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3649);
        UPDATE `applied_item_updates` SET `entry` = 3649, `version` = 3368 WHERE (`entry` = 3649);
        -- Red Linen Robe
        -- required_level, from 5 to 1
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 1, `stat_value1` = 1 WHERE (`entry` = 2572);
        UPDATE `applied_item_updates` SET `entry` = 2572, `version` = 3368 WHERE (`entry` = 2572);
        -- Reinforced Linen Cape
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 2580);
        UPDATE `applied_item_updates` SET `entry` = 2580, `version` = 3368 WHERE (`entry` = 2580);
        -- Cold Steel Gauntlets
        -- buy_price, from 117 to 113
        -- sell_price, from 23 to 22
        UPDATE `item_template` SET `buy_price` = 113, `sell_price` = 22 WHERE (`entry` = 6063);
        UPDATE `applied_item_updates` SET `entry` = 6063, `version` = 3368 WHERE (`entry` = 6063);
        -- Battle Chain Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3281);
        UPDATE `applied_item_updates` SET `entry` = 3281, `version` = 3368 WHERE (`entry` = 3281);
        -- Ancestral Cloak
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 4671);
        UPDATE `applied_item_updates` SET `entry` = 4671, `version` = 3368 WHERE (`entry` = 4671);
        -- Ancestral Boots
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3289);
        UPDATE `applied_item_updates` SET `entry` = 3289, `version` = 3368 WHERE (`entry` = 3289);
        -- Apprentice Sash
        -- buy_price, from 223 to 178
        -- sell_price, from 44 to 35
        -- item_level, from 12 to 11
        -- required_level, from 7 to 1
        UPDATE `item_template` SET `buy_price` = 178, `sell_price` = 35, `item_level` = 11, `required_level` = 1 WHERE (`entry` = 3442);
        UPDATE `applied_item_updates` SET `entry` = 3442, `version` = 3368 WHERE (`entry` = 3442);
        -- Green Linen Bracers
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 4308);
        UPDATE `applied_item_updates` SET `entry` = 4308, `version` = 3368 WHERE (`entry` = 4308);
        -- Scuffed Dagger
        -- dmg_min1, from 3.0 to 7
        -- dmg_max1, from 7.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 2502);
        UPDATE `applied_item_updates` SET `entry` = 2502, `version` = 3368 WHERE (`entry` = 2502);
        -- Light Chain Armor
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2398);
        UPDATE `applied_item_updates` SET `entry` = 2398, `version` = 3368 WHERE (`entry` = 2398);
        -- Light Chain Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2402);
        UPDATE `applied_item_updates` SET `entry` = 2402, `version` = 3368 WHERE (`entry` = 2402);
        -- Worn Heater Shield
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2376);
        UPDATE `applied_item_updates` SET `entry` = 2376, `version` = 3368 WHERE (`entry` = 2376);
        -- Battle Chain Girdle
        -- buy_price, from 272 to 426
        -- sell_price, from 54 to 85
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `buy_price` = 426, `sell_price` = 85, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 4669);
        UPDATE `applied_item_updates` SET `entry` = 4669, `version` = 3368 WHERE (`entry` = 4669);
        -- Copper Chain Vest
        -- required_level, from 5 to 1
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 1, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 3471);
        UPDATE `applied_item_updates` SET `entry` = 3471, `version` = 3368 WHERE (`entry` = 3471);
        -- Copper Shortsword
        -- dmg_min1, from 5.0 to 11
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 2847);
        UPDATE `applied_item_updates` SET `entry` = 2847, `version` = 3368 WHERE (`entry` = 2847);
        -- Scalping Tomahawk
        -- required_level, from 5 to 1
        -- dmg_min1, from 4.0 to 9
        -- dmg_max1, from 9.0 to 14
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 4561);
        UPDATE `applied_item_updates` SET `entry` = 4561, `version` = 3368 WHERE (`entry` = 4561);
        -- White Linen Robe
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 6241);
        UPDATE `applied_item_updates` SET `entry` = 6241, `version` = 3368 WHERE (`entry` = 6241);
        -- Sturdy Quarterstaff
        -- quality, from 2 to 1
        -- buy_price, from 3157 to 512
        -- sell_price, from 631 to 102
        -- item_level, from 13 to 8
        -- dmg_min1, from 20.0 to 17
        -- dmg_max1, from 30.0 to 24
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 512, `sell_price` = 102, `item_level` = 8, `dmg_min1` = 17, `dmg_max1` = 24 WHERE (`entry` = 4566);
        UPDATE `applied_item_updates` SET `entry` = 4566, `version` = 3368 WHERE (`entry` = 4566);
        -- Patchwork Cloth Pants
        -- name, from Patchwork Pants to Patchwork Cloth Pants
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Pants', `required_level` = 1 WHERE (`entry` = 1431);
        UPDATE `applied_item_updates` SET `entry` = 1431, `version` = 3368 WHERE (`entry` = 1431);
        -- Double-stitched Robes
        -- required_level, from 8 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 2613);
        UPDATE `applied_item_updates` SET `entry` = 2613, `version` = 3368 WHERE (`entry` = 2613);
        -- Worn Leather Pants
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1423);
        UPDATE `applied_item_updates` SET `entry` = 1423, `version` = 3368 WHERE (`entry` = 1423);
        -- Battle Chain Pants
        -- quality, from 2 to 1
        -- buy_price, from 1177 to 882
        -- sell_price, from 235 to 176
        -- item_level, from 12 to 13
        -- required_level, from 7 to 3
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 882, `sell_price` = 176, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 3282);
        UPDATE `applied_item_updates` SET `entry` = 3282, `version` = 3368 WHERE (`entry` = 3282);
        -- Battle Chain Boots
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3279);
        UPDATE `applied_item_updates` SET `entry` = 3279, `version` = 3368 WHERE (`entry` = 3279);
        -- Chainmail Vest
        -- name, from Chainmail Armor to Chainmail Vest
        -- display_id, from 1019 to 2257
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `name` = 'Chainmail Vest', `display_id` = 2257, `required_level` = 7 WHERE (`entry` = 847);
        UPDATE `applied_item_updates` SET `entry` = 847, `version` = 3368 WHERE (`entry` = 847);
        -- Runed Copper Belt
        -- required_level, from 13 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 2857);
        UPDATE `applied_item_updates` SET `entry` = 2857, `version` = 3368 WHERE (`entry` = 2857);
        -- Runed Copper Pants
        -- required_level, from 8 to 3
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 3473);
        UPDATE `applied_item_updates` SET `entry` = 3473, `version` = 3368 WHERE (`entry` = 3473);
        -- Runed Copper Gauntlets
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 3472);
        UPDATE `applied_item_updates` SET `entry` = 3472, `version` = 3368 WHERE (`entry` = 3472);
        -- Patchwork Cloth Bracers
        -- name, from Patchwork Bracers to Patchwork Cloth Bracers
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Bracers', `required_level` = 1 WHERE (`entry` = 3373);
        UPDATE `applied_item_updates` SET `entry` = 3373, `version` = 3368 WHERE (`entry` = 3373);
        -- Patchwork Cloth Cloak
        -- name, from Patchwork Cloak to Patchwork Cloth Cloak
        UPDATE `item_template` SET `name` = 'Patchwork Cloth Cloak' WHERE (`entry` = 1429);
        UPDATE `applied_item_updates` SET `entry` = 1429, `version` = 3368 WHERE (`entry` = 1429);
        -- Barbaric Linen Vest
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 2 WHERE (`entry` = 2578);
        UPDATE `applied_item_updates` SET `entry` = 2578, `version` = 3368 WHERE (`entry` = 2578);
        -- Light Chain Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2403);
        UPDATE `applied_item_updates` SET `entry` = 2403, `version` = 3368 WHERE (`entry` = 2403);
        -- Mining Pick
        -- buy_price, from 81 to 121
        -- sell_price, from 16 to 24
        -- item_level, from 4 to 5
        -- required_level, from 1 to 2
        -- dmg_min1, from 2.0 to 6
        -- dmg_max1, from 4.0 to 7
        UPDATE `item_template` SET `buy_price` = 121, `sell_price` = 24, `item_level` = 5, `required_level` = 2, `dmg_min1` = 6, `dmg_max1` = 7 WHERE (`entry` = 2901);
        UPDATE `applied_item_updates` SET `entry` = 2901, `version` = 3368 WHERE (`entry` = 2901);
        -- Fishing Pole
        -- dmg_min1, from 12.0 to 1
        -- dmg_max1, from 15.0 to 1
        UPDATE `item_template` SET `dmg_min1` = 1, `dmg_max1` = 1 WHERE (`entry` = 6256);
        UPDATE `applied_item_updates` SET `entry` = 6256, `version` = 3368 WHERE (`entry` = 6256);
        -- Copper Rod
        -- class, from 7 to 2
        -- description, from Needed by an Enchanter to make a runed copper rod. to Needed for an Enchanter to make his runed copper rod.
        UPDATE `item_template` SET `class` = 2, `description` = 'Needed for an Enchanter to make his runed copper rod.' WHERE (`entry` = 6217);
        UPDATE `applied_item_updates` SET `entry` = 6217, `version` = 3368 WHERE (`entry` = 6217);
        -- Mild Spices
        -- buy_price, from 10 to 4
        UPDATE `item_template` SET `buy_price` = 4 WHERE (`entry` = 2678);
        UPDATE `applied_item_updates` SET `entry` = 2678, `version` = 3368 WHERE (`entry` = 2678);
        -- Tribal Belt
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 4675);
        UPDATE `applied_item_updates` SET `entry` = 4675, `version` = 3368 WHERE (`entry` = 4675);
        -- Chainmail Bracers
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 1846);
        UPDATE `applied_item_updates` SET `entry` = 1846, `version` = 3368 WHERE (`entry` = 1846);
        -- Rusted Claymore
        -- dmg_min1, from 13.0 to 20
        -- dmg_max1, from 20.0 to 27
        UPDATE `item_template` SET `dmg_min1` = 20, `dmg_max1` = 27 WHERE (`entry` = 2497);
        UPDATE `applied_item_updates` SET `entry` = 2497, `version` = 3368 WHERE (`entry` = 2497);
        -- Copper Chain Belt
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2851);
        UPDATE `applied_item_updates` SET `entry` = 2851, `version` = 3368 WHERE (`entry` = 2851);
        -- Copper Chain Pants
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2852);
        UPDATE `applied_item_updates` SET `entry` = 2852, `version` = 3368 WHERE (`entry` = 2852);
        -- Linen Boots
        -- required_level, from 8 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2569);
        UPDATE `applied_item_updates` SET `entry` = 2569, `version` = 3368 WHERE (`entry` = 2569);
        -- Chainmail Pants
        -- display_id, from 697 to 1229
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `display_id` = 1229, `required_level` = 7 WHERE (`entry` = 848);
        UPDATE `applied_item_updates` SET `entry` = 848, `version` = 3368 WHERE (`entry` = 848);
        -- Whispering Vest
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `stat_value1` = 4 WHERE (`entry` = 4781);
        UPDATE `applied_item_updates` SET `entry` = 4781, `version` = 3368 WHERE (`entry` = 4781);
        -- Rough Wooden Staff
        -- required_level, from 9 to 2
        -- dmg_min1, from 12.0 to 19
        -- dmg_max1, from 19.0 to 27
        UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 19, `dmg_max1` = 27 WHERE (`entry` = 1515);
        UPDATE `applied_item_updates` SET `entry` = 1515, `version` = 3368 WHERE (`entry` = 1515);
        -- Worn Leather Boots
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1419);
        UPDATE `applied_item_updates` SET `entry` = 1419, `version` = 3368 WHERE (`entry` = 1419);
        -- Copper Battle Axe
        -- dmg_min1, from 23.0 to 33
        -- dmg_max1, from 35.0 to 45
        UPDATE `item_template` SET `dmg_min1` = 33, `dmg_max1` = 45 WHERE (`entry` = 3488);
        UPDATE `applied_item_updates` SET `entry` = 3488, `version` = 3368 WHERE (`entry` = 3488);
        -- Blue Linen Robe
        -- stat_type1, from 0 to 5
        UPDATE `item_template` SET `stat_type1` = 5 WHERE (`entry` = 6242);
        UPDATE `applied_item_updates` SET `entry` = 6242, `version` = 3368 WHERE (`entry` = 6242);
        -- High Robe of the Adjudicator
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 4, `stat_value2` = 2 WHERE (`entry` = 3461);
        UPDATE `applied_item_updates` SET `entry` = 3461, `version` = 3368 WHERE (`entry` = 3461);
        -- Runic Cloth Gloves
        -- required_level, from 11 to 6
        -- stat_value1, from 0 to 20
        UPDATE `item_template` SET `required_level` = 6, `stat_value1` = 20 WHERE (`entry` = 3308);
        UPDATE `applied_item_updates` SET `entry` = 3308, `version` = 3368 WHERE (`entry` = 3308);
        -- Copper Axe
        -- dmg_min1, from 5.0 to 10
        -- dmg_max1, from 10.0 to 16
        UPDATE `item_template` SET `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 2845);
        UPDATE `applied_item_updates` SET `entry` = 2845, `version` = 3368 WHERE (`entry` = 2845);
        -- Withered Staff
        -- required_level, from 5 to 1
        -- dmg_min1, from 8.0 to 13
        -- dmg_max1, from 12.0 to 18
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 1411);
        UPDATE `applied_item_updates` SET `entry` = 1411, `version` = 3368 WHERE (`entry` = 1411);
        -- Soft-soled Linen Boots
        -- required_level, from 11 to 6
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 4312);
        UPDATE `applied_item_updates` SET `entry` = 4312, `version` = 3368 WHERE (`entry` = 4312);
        -- Cracked Sledge
        -- required_level, from 6 to 1
        -- dmg_min1, from 10.0 to 14
        -- dmg_max1, from 15.0 to 20
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 14, `dmg_max1` = 20 WHERE (`entry` = 1414);
        UPDATE `applied_item_updates` SET `entry` = 1414, `version` = 3368 WHERE (`entry` = 1414);
        -- Woolen Cape
        -- buy_price, from 711 to 941
        -- sell_price, from 142 to 188
        -- item_level, from 16 to 18
        -- required_level, from 6 to 8
        UPDATE `item_template` SET `buy_price` = 941, `sell_price` = 188, `item_level` = 18, `required_level` = 8 WHERE (`entry` = 2584);
        UPDATE `applied_item_updates` SET `entry` = 2584, `version` = 3368 WHERE (`entry` = 2584);
        -- Loose Chain Boots
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2642);
        UPDATE `applied_item_updates` SET `entry` = 2642, `version` = 3368 WHERE (`entry` = 2642);
        -- Seer's Gloves
        -- required_level, from 16 to 11
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 2 WHERE (`entry` = 2984);
        UPDATE `applied_item_updates` SET `entry` = 2984, `version` = 3368 WHERE (`entry` = 2984);
        -- Militant Shortsword
        -- dmg_min1, from 10.0 to 19
        -- dmg_max1, from 20.0 to 29
        UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 29 WHERE (`entry` = 851);
        UPDATE `applied_item_updates` SET `entry` = 851, `version` = 3368 WHERE (`entry` = 851);
        -- Chainmail Gloves
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 850);
        UPDATE `applied_item_updates` SET `entry` = 850, `version` = 3368 WHERE (`entry` = 850);
        -- Chainmail Boots
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 849);
        UPDATE `applied_item_updates` SET `entry` = 849, `version` = 3368 WHERE (`entry` = 849);
        -- Copper Bracers
        -- buy_price, from 85 to 37
        -- sell_price, from 17 to 7
        -- item_level, from 7 to 5
        UPDATE `item_template` SET `buy_price` = 37, `sell_price` = 7, `item_level` = 5 WHERE (`entry` = 2853);
        UPDATE `applied_item_updates` SET `entry` = 2853, `version` = 3368 WHERE (`entry` = 2853);
        -- Cracked Shortbow
        -- required_level, from 5 to 1
        -- dmg_min1, from 5.0 to 4
        -- dmg_max1, from 10.0 to 7
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 4, `dmg_max1` = 7 WHERE (`entry` = 2773);
        UPDATE `applied_item_updates` SET `entry` = 2773, `version` = 3368 WHERE (`entry` = 2773);
        -- Embossed Leather Vest
        -- required_level, from 7 to 2
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 2, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 2300);
        UPDATE `applied_item_updates` SET `entry` = 2300, `version` = 3368 WHERE (`entry` = 2300);
        -- Scroll of Spirit Armor
        -- name, from Scroll of Protection to Scroll of Spirit Armor
        -- buy_price, from 100 to 10
        -- sell_price, from 25 to 2
        -- item_level, from 10 to 1
        UPDATE `item_template` SET `name` = 'Scroll of Spirit Armor', `buy_price` = 10, `sell_price` = 2, `item_level` = 1 WHERE (`entry` = 3013);
        UPDATE `applied_item_updates` SET `entry` = 3013, `version` = 3368 WHERE (`entry` = 3013);
        -- Wise Man's Belt
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 24
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 24 WHERE (`entry` = 4786);
        UPDATE `applied_item_updates` SET `entry` = 4786, `version` = 3368 WHERE (`entry` = 4786);
        -- Strong Fishing Pole
        -- buy_price, from 22 to 901
        -- sell_price, from 4 to 180
        -- item_level, from 1 to 10
        -- dmg_min1, from 3.0 to 1
        -- dmg_max1, from 7.0 to 1
        UPDATE `item_template` SET `buy_price` = 901, `sell_price` = 180, `item_level` = 10, `dmg_min1` = 1, `dmg_max1` = 1 WHERE (`entry` = 6365);
        UPDATE `applied_item_updates` SET `entry` = 6365, `version` = 3368 WHERE (`entry` = 6365);
        -- Laced Mail Shoulderpads
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 1744);
        UPDATE `applied_item_updates` SET `entry` = 1744, `version` = 3368 WHERE (`entry` = 1744);
        -- Brackwater Shield
        -- required_level, from 12 to 7
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 3654);
        UPDATE `applied_item_updates` SET `entry` = 3654, `version` = 3368 WHERE (`entry` = 3654);
        -- Severing Axe
        -- required_level, from 5 to 1
        -- dmg_min1, from 12.0 to 19
        -- dmg_max1, from 19.0 to 27
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 19, `dmg_max1` = 27 WHERE (`entry` = 4562);
        UPDATE `applied_item_updates` SET `entry` = 4562, `version` = 3368 WHERE (`entry` = 4562);
        -- Rusty Hatchet
        -- required_level, from 6 to 1
        -- dmg_min1, from 4.0 to 8
        -- dmg_max1, from 8.0 to 12
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 8, `dmg_max1` = 12 WHERE (`entry` = 1416);
        UPDATE `applied_item_updates` SET `entry` = 1416, `version` = 3368 WHERE (`entry` = 1416);
        -- Worn Mail Boots
        -- required_level, from 8 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 1731);
        UPDATE `applied_item_updates` SET `entry` = 1731, `version` = 3368 WHERE (`entry` = 1731);
        -- Double-stitched Woolen Shoulders
        -- display_id, from 9997 to 9998
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `display_id` = 9998, `required_level` = 12 WHERE (`entry` = 4314);
        UPDATE `applied_item_updates` SET `entry` = 4314, `version` = 3368 WHERE (`entry` = 4314);
        -- Farmer's Broom
        -- required_level, from 3 to 1
        -- dmg_min1, from 11.0 to 17
        -- dmg_max1, from 17.0 to 24
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 17, `dmg_max1` = 24 WHERE (`entry` = 3335);
        UPDATE `applied_item_updates` SET `entry` = 3335, `version` = 3368 WHERE (`entry` = 3335);
        -- Canvas Shoulderpads
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 1769);
        UPDATE `applied_item_updates` SET `entry` = 1769, `version` = 3368 WHERE (`entry` = 1769);
        -- Seer's Boots
        -- required_level, from 16 to 11
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 2 WHERE (`entry` = 2983);
        UPDATE `applied_item_updates` SET `entry` = 2983, `version` = 3368 WHERE (`entry` = 2983);
        -- Embossed Leather Boots
        -- required_level, from 8 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 2309);
        UPDATE `applied_item_updates` SET `entry` = 2309, `version` = 3368 WHERE (`entry` = 2309);
        -- Tribal Bracers
        -- buy_price, from 296 to 371
        -- sell_price, from 59 to 74
        -- item_level, from 12 to 13
        -- required_level, from 7 to 3
        UPDATE `item_template` SET `buy_price` = 371, `sell_price` = 74, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 3285);
        UPDATE `applied_item_updates` SET `entry` = 3285, `version` = 3368 WHERE (`entry` = 3285);
        -- Carpenter's Mallet
        -- required_level, from 6 to 1
        -- dmg_min1, from 3.0 to 6
        -- dmg_max1, from 6.0 to 10
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 1415);
        UPDATE `applied_item_updates` SET `entry` = 1415, `version` = 3368 WHERE (`entry` = 1415);
        -- Worn Leather Belt
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1418);
        UPDATE `applied_item_updates` SET `entry` = 1418, `version` = 3368 WHERE (`entry` = 1418);
        -- Wooden Shield
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2215);
        UPDATE `applied_item_updates` SET `entry` = 2215, `version` = 3368 WHERE (`entry` = 2215);
        -- Chainmail Belt
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 1845);
        UPDATE `applied_item_updates` SET `entry` = 1845, `version` = 3368 WHERE (`entry` = 1845);
        -- Large Broad Axe
        -- dmg_min1, from 21.0 to 30
        -- dmg_max1, from 32.0 to 42
        UPDATE `item_template` SET `dmg_min1` = 30, `dmg_max1` = 42 WHERE (`entry` = 1196);
        UPDATE `applied_item_updates` SET `entry` = 1196, `version` = 3368 WHERE (`entry` = 1196);
        -- 3494
        -- Magister's Gloves
        -- buy_price, from 964 to 1108
        -- sell_price, from 192 to 221
        -- item_level, from 17 to 18
        -- required_level, from 12 to 8
        -- stat_value1, from 0 to 20
        -- stat_value2, from 0 to 20
        UPDATE `item_template` SET `buy_price` = 1108, `sell_price` = 221, `item_level` = 18, `required_level` = 8, `stat_value1` = 20, `stat_value2` = 20 WHERE (`entry` = 2972);
        UPDATE `applied_item_updates` SET `entry` = 2972, `version` = 3494 WHERE (`entry` = 2972);
        -- Willow Robe
        -- buy_price, from 1407 to 1348
        -- sell_price, from 281 to 269
        -- required_level, from 10 to 5
        UPDATE `item_template` SET `buy_price` = 1348, `sell_price` = 269, `required_level` = 5 WHERE (`entry` = 6538);
        UPDATE `applied_item_updates` SET `entry` = 6538, `version` = 3494 WHERE (`entry` = 6538);
        -- Frayed Shoes
        -- armor, from 1 to 2
        UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1374);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1374, 3494);
        -- Frayed Bracers
        -- armor, from 1 to 2
        UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3365);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3365, 3494);
        -- Anvilmar Knife
        -- dmg_min1, from 2.0 to 6
        -- dmg_max1, from 5.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 9 WHERE (`entry` = 2195);
        UPDATE `applied_item_updates` SET `entry` = 2195, `version` = 3494 WHERE (`entry` = 2195);
        -- Battleworn Hammer
        -- dmg_min1, from 5.0 to 11
        -- dmg_max1, from 8.0 to 16
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 16 WHERE (`entry` = 2361);
        UPDATE `applied_item_updates` SET `entry` = 2361, `version` = 3494 WHERE (`entry` = 2361);
        -- Frayed Cloak
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1376);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1376, 3494);
        -- Flimsy Chain Vest
        -- armor, from 3 to 11
        UPDATE `item_template` SET `armor` = 11 WHERE (`entry` = 2656);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2656, 3494);
        -- Ragged Leather Belt
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1369);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1369, 3494);
        -- Flimsy Chain Boots
        -- armor, from 2 to 4
        UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 2650);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2650, 3494);
        -- Anvilmar Hand Axe
        -- display_id, from 8473 to 8475
        UPDATE `item_template` SET `display_id` = 8475 WHERE (`entry` = 2047);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2047, 3494);
        -- Dwarven Kite Shield
        -- display_id, from 3725 to 10366
        UPDATE `item_template` SET `display_id` = 10366 WHERE (`entry` = 6176);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6176, 3494);
        -- Rough Arrow
        -- item_level, from 5 to 1
        -- dmg_min1, from 2.0 to 1
        -- dmg_max1, from 3.0 to 2
        UPDATE `item_template` SET `item_level` = 1, `dmg_min1` = 1, `dmg_max1` = 2 WHERE (`entry` = 2512);
        UPDATE `applied_item_updates` SET `entry` = 2512, `version` = 3494 WHERE (`entry` = 2512);
        -- Light Shot
        -- item_level, from 5 to 1
        -- dmg_min1, from 2.0 to 1
        -- dmg_max1, from 3.0 to 2
        UPDATE `item_template` SET `item_level` = 1, `dmg_min1` = 1, `dmg_max1` = 2 WHERE (`entry` = 2516);
        UPDATE `applied_item_updates` SET `entry` = 2516, `version` = 3494 WHERE (`entry` = 2516);
        -- Crude Throwing Axe
        -- dmg_min1, from 1.0 to 4
        -- dmg_max1, from 3.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 6 WHERE (`entry` = 3111);
        UPDATE `applied_item_updates` SET `entry` = 3111, `version` = 3494 WHERE (`entry` = 3111);
        -- Small Throwing Knife
        -- dmg_min1, from 1.0 to 4
        -- dmg_max1, from 3.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 6 WHERE (`entry` = 2947);
        UPDATE `applied_item_updates` SET `entry` = 2947, `version` = 3494 WHERE (`entry` = 2947);
        -- Flimsy Chain Belt
        -- armor, from 1 to 2
        UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 2649);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2649, 3494);
        -- Ragged Leather Boots
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1367);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1367, 3494);
        -- Brass-studded Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1182);
        UPDATE `applied_item_updates` SET `entry` = 1182, `version` = 3494 WHERE (`entry` = 1182);
        -- Lion-stamped Gloves
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1359);
        UPDATE `applied_item_updates` SET `entry` = 1359, `version` = 3494 WHERE (`entry` = 1359);
        -- Ragged Leather Vest
        -- armor, from 2 to 7
        UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 1364);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1364, 3494);
        -- Frayed Robe
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1380);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1380, 3494);
        -- Flimsy Chain Gloves
        -- armor, from 2 to 5
        UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2653);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2653, 3494);
        -- Old Hand Axe
        -- dmg_min1, from 3.0 to 7
        -- dmg_max1, from 6.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 12 WHERE (`entry` = 2134);
        UPDATE `applied_item_updates` SET `entry` = 2134, `version` = 3494 WHERE (`entry` = 2134);
        -- Infantry Tunic
        -- quality, from 1 to 2
        -- buy_price, from 732 to 1526
        -- sell_price, from 146 to 305
        -- item_level, from 12 to 13
        -- required_level, from 7 to 3
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1526, `sell_price` = 305, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 6336);
        UPDATE `applied_item_updates` SET `entry` = 6336, `version` = 3494 WHERE (`entry` = 6336);
        -- Militia Dagger
        -- dmg_min1, from 2.0 to 5
        -- dmg_max1, from 5.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 9 WHERE (`entry` = 2224);
        UPDATE `applied_item_updates` SET `entry` = 2224, `version` = 3494 WHERE (`entry` = 2224);
        -- Militia Quarterstaff
        -- dmg_min1, from 7.0 to 12
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 17 WHERE (`entry` = 1159);
        UPDATE `applied_item_updates` SET `entry` = 1159, `version` = 3494 WHERE (`entry` = 1159);
        -- Simple Dagger
        -- dmg_min1, from 2.0 to 5
        -- dmg_max1, from 4.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 9 WHERE (`entry` = 2139);
        UPDATE `applied_item_updates` SET `entry` = 2139, `version` = 3494 WHERE (`entry` = 2139);
        -- Peasant Sword
        -- dmg_min1, from 3.0 to 9
        -- dmg_max1, from 7.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2131);
        UPDATE `applied_item_updates` SET `entry` = 2131, `version` = 3494 WHERE (`entry` = 2131);
        -- Damaged Claymore
        -- dmg_min1, from 7.0 to 13
        -- dmg_max1, from 11.0 to 18
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 1194);
        UPDATE `applied_item_updates` SET `entry` = 1194, `version` = 3494 WHERE (`entry` = 1194);
        -- Dull Broad Axe
        -- dmg_min1, from 7.0 to 13
        -- dmg_max1, from 12.0 to 19
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 19 WHERE (`entry` = 2479);
        UPDATE `applied_item_updates` SET `entry` = 2479, `version` = 3494 WHERE (`entry` = 2479);
        -- Large Crooked Club
        -- dmg_min1, from 6.0 to 13
        -- dmg_max1, from 10.0 to 18
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 18 WHERE (`entry` = 2480);
        UPDATE `applied_item_updates` SET `entry` = 2480, `version` = 3494 WHERE (`entry` = 2480);
        -- Initiate Staff
        -- dmg_min1, from 8.0 to 14
        -- dmg_max1, from 12.0 to 19
        UPDATE `item_template` SET `dmg_min1` = 14, `dmg_max1` = 19 WHERE (`entry` = 2132);
        UPDATE `applied_item_updates` SET `entry` = 2132, `version` = 3494 WHERE (`entry` = 2132);
        -- Shimmering Sash
        -- required_level, from 16 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 6570);
        UPDATE `applied_item_updates` SET `entry` = 6570, `version` = 3494 WHERE (`entry` = 6570);
        -- Bracers of the People's Militia
        -- required_level, from 9 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 710);
        UPDATE `applied_item_updates` SET `entry` = 710, `version` = 3494 WHERE (`entry` = 710);
        -- Shimmering Cloak
        -- buy_price, from 2944 to 2691
        -- sell_price, from 588 to 538
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `buy_price` = 2691, `sell_price` = 538, `required_level` = 12 WHERE (`entry` = 6564);
        UPDATE `applied_item_updates` SET `entry` = 6564, `version` = 3494 WHERE (`entry` = 6564);
        -- Dwarven Magestaff
        -- required_level, from 10 to 5
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 19.0 to 31
        -- dmg_max1, from 30.0 to 43
        UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 2, `dmg_min1` = 31, `dmg_max1` = 43 WHERE (`entry` = 2072);
        UPDATE `applied_item_updates` SET `entry` = 2072, `version` = 3494 WHERE (`entry` = 2072);
        -- Torchlight Wand
        -- required_level, from 16 to 11
        -- dmg_min1, from 13.0 to 23
        -- dmg_max1, from 25.0 to 35
        -- delay, from 1300 to 2600
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 23, `dmg_max1` = 35, `delay` = 2600 WHERE (`entry` = 5240);
        UPDATE `applied_item_updates` SET `entry` = 5240, `version` = 3494 WHERE (`entry` = 5240);
        -- Light Mail Armor
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2392);
        UPDATE `applied_item_updates` SET `entry` = 2392, `version` = 3494 WHERE (`entry` = 2392);
        -- Light Mail Belt
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2393);
        UPDATE `applied_item_updates` SET `entry` = 2393, `version` = 3494 WHERE (`entry` = 2393);
        -- Light Mail Leggings
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2394);
        UPDATE `applied_item_updates` SET `entry` = 2394, `version` = 3494 WHERE (`entry` = 2394);
        -- Warrior's Boots
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 2967);
        UPDATE `applied_item_updates` SET `entry` = 2967, `version` = 3494 WHERE (`entry` = 2967);
        -- Light Mail Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2396);
        UPDATE `applied_item_updates` SET `entry` = 2396, `version` = 3494 WHERE (`entry` = 2396);
        -- Light Mail Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2397);
        UPDATE `applied_item_updates` SET `entry` = 2397, `version` = 3494 WHERE (`entry` = 2397);
        -- Notched Shortsword
        -- required_level, from 6 to 1
        -- dmg_min1, from 6.0 to 11
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 727);
        UPDATE `applied_item_updates` SET `entry` = 727, `version` = 3494 WHERE (`entry` = 727);
        -- Warrior's Shield
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 1438);
        UPDATE `applied_item_updates` SET `entry` = 1438, `version` = 3494 WHERE (`entry` = 1438);
        -- Ragged Leather Gloves
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1368);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1368, 3494);
        -- Belt of the People's Militia
        -- required_level, from 9 to 4
        UPDATE `item_template` SET `required_level` = 4 WHERE (`entry` = 1154);
        UPDATE `applied_item_updates` SET `entry` = 1154, `version` = 3494 WHERE (`entry` = 1154);
        -- Infantry Leggings
        -- quality, from 1 to 2
        -- buy_price, from 587 to 1686
        -- sell_price, from 117 to 337
        -- item_level, from 11 to 14
        -- required_level, from 6 to 4
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1686, `sell_price` = 337, `item_level` = 14, `required_level` = 4 WHERE (`entry` = 6337);
        UPDATE `applied_item_updates` SET `entry` = 6337, `version` = 3494 WHERE (`entry` = 6337);
        -- Greaves of the People's Militia
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 4, `stat_value1` = 1 WHERE (`entry` = 5944);
        UPDATE `applied_item_updates` SET `entry` = 5944, `version` = 3494 WHERE (`entry` = 5944);
        -- Veteran Gloves
        -- quality, from 1 to 2
        -- buy_price, from 627 to 1385
        -- sell_price, from 125 to 277
        -- item_level, from 15 to 17
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1385, `sell_price` = 277, `item_level` = 17 WHERE (`entry` = 2980);
        UPDATE `applied_item_updates` SET `entry` = 2980, `version` = 3494 WHERE (`entry` = 2980);
        -- Flimsy Chain Bracers
        -- armor, from 2 to 4
        UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 2651);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2651, 3494);
        -- Rough Leather Belt
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1839);
        UPDATE `applied_item_updates` SET `entry` = 1839, `version` = 3494 WHERE (`entry` = 1839);
        -- Patched Pants
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2237);
        UPDATE `applied_item_updates` SET `entry` = 2237, `version` = 3494 WHERE (`entry` = 2237);
        -- Rough Leather Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1840);
        UPDATE `applied_item_updates` SET `entry` = 1840, `version` = 3494 WHERE (`entry` = 1840);
        -- Well-used Sword
        -- required_level, from 7 to 1
        -- dmg_min1, from 6.0 to 13
        -- dmg_max1, from 12.0 to 20
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 1008);
        UPDATE `applied_item_updates` SET `entry` = 1008, `version` = 3494 WHERE (`entry` = 1008);
        -- Nicked Blade
        -- dmg_min1, from 3.0 to 7
        -- dmg_max1, from 7.0 to 12
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 12 WHERE (`entry` = 2494);
        UPDATE `applied_item_updates` SET `entry` = 2494, `version` = 3494 WHERE (`entry` = 2494);
        -- Burnt Leather Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2964);
        UPDATE `applied_item_updates` SET `entry` = 2964, `version` = 3494 WHERE (`entry` = 2964);
        -- Copper Chain Boots
        -- buy_price, from 245 to 124
        -- sell_price, from 49 to 24
        -- item_level, from 9 to 7
        UPDATE `item_template` SET `buy_price` = 124, `sell_price` = 24, `item_level` = 7 WHERE (`entry` = 3469);
        UPDATE `applied_item_updates` SET `entry` = 3469, `version` = 3494 WHERE (`entry` = 3469);
        -- Disciple's Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 6515);
        UPDATE `applied_item_updates` SET `entry` = 6515, `version` = 3494 WHERE (`entry` = 6515);
        -- Warrior's Buckler
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3648);
        UPDATE `applied_item_updates` SET `entry` = 3648, `version` = 3494 WHERE (`entry` = 3648);
        -- Light Mail Boots
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2395);
        UPDATE `applied_item_updates` SET `entry` = 2395, `version` = 3494 WHERE (`entry` = 2395);
        -- Dull Heater Shield
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1201);
        UPDATE `applied_item_updates` SET `entry` = 1201, `version` = 3494 WHERE (`entry` = 1201);
        -- Plain Robe
        -- armor, from 3 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2612);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2612, 3494);
        -- Journeyman's Cloak
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 4662);
        UPDATE `applied_item_updates` SET `entry` = 4662, `version` = 3494 WHERE (`entry` = 4662);
        -- Footman Sword
        -- dmg_min1, from 6.0 to 11
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 2488);
        UPDATE `applied_item_updates` SET `entry` = 2488, `version` = 3494 WHERE (`entry` = 2488);
        -- Tarnished Claymore
        -- dmg_min1, from 10.0 to 17
        -- dmg_max1, from 15.0 to 23
        UPDATE `item_template` SET `dmg_min1` = 17, `dmg_max1` = 23 WHERE (`entry` = 2489);
        UPDATE `applied_item_updates` SET `entry` = 2489, `version` = 3494 WHERE (`entry` = 2489);
        -- Small Hand Axe
        -- dmg_min1, from 4.0 to 9
        -- dmg_max1, from 9.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 2490);
        UPDATE `applied_item_updates` SET `entry` = 2490, `version` = 3494 WHERE (`entry` = 2490);
        -- Twin-bladed War Axe
        -- dmg_min1, from 11.0 to 17
        -- dmg_max1, from 17.0 to 24
        UPDATE `item_template` SET `dmg_min1` = 17, `dmg_max1` = 24 WHERE (`entry` = 2491);
        UPDATE `applied_item_updates` SET `entry` = 2491, `version` = 3494 WHERE (`entry` = 2491);
        -- Wooden Mallet
        -- dmg_min1, from 11.0 to 16
        -- dmg_max1, from 17.0 to 23
        UPDATE `item_template` SET `dmg_min1` = 16, `dmg_max1` = 23 WHERE (`entry` = 2493);
        UPDATE `applied_item_updates` SET `entry` = 2493, `version` = 3494 WHERE (`entry` = 2493);
        -- Apprentice Short Staff
        -- dmg_min1, from 9.0 to 15
        -- dmg_max1, from 15.0 to 21
        UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 21 WHERE (`entry` = 2495);
        UPDATE `applied_item_updates` SET `entry` = 2495, `version` = 3494 WHERE (`entry` = 2495);
        -- Rough Bronze Shoulders
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 3480);
        UPDATE `applied_item_updates` SET `entry` = 3480, `version` = 3494 WHERE (`entry` = 3480);
        -- Polished Scale Belt
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 2148);
        UPDATE `applied_item_updates` SET `entry` = 2148, `version` = 3494 WHERE (`entry` = 2148);
        -- Scalemail Pants
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 286);
        UPDATE `applied_item_updates` SET `entry` = 286, `version` = 3494 WHERE (`entry` = 286);
        -- Scalemail Bracers
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 1852);
        UPDATE `applied_item_updates` SET `entry` = 1852, `version` = 3494 WHERE (`entry` = 1852);
        -- Disciple's Robe
        -- quality, from 1 to 2
        -- buy_price, from 366 to 1147
        -- sell_price, from 73 to 229
        -- item_level, from 11 to 14
        -- required_level, from 6 to 4
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1147, `sell_price` = 229, `item_level` = 14, `required_level` = 4 WHERE (`entry` = 6512);
        UPDATE `applied_item_updates` SET `entry` = 6512, `version` = 3494 WHERE (`entry` = 6512);
        -- Disciple's Belt
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 6513);
        UPDATE `applied_item_updates` SET `entry` = 6513, `version` = 3494 WHERE (`entry` = 6513);
        -- Urchin's Pants
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2238);
        UPDATE `applied_item_updates` SET `entry` = 2238, `version` = 3494 WHERE (`entry` = 2238);
        -- Knitted Sandals
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 792);
        UPDATE `applied_item_updates` SET `entry` = 792, `version` = 3494 WHERE (`entry` = 792);
        -- Knitted Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3603);
        UPDATE `applied_item_updates` SET `entry` = 3603, `version` = 3494 WHERE (`entry` = 3603);
        -- Knitted Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 793);
        UPDATE `applied_item_updates` SET `entry` = 793, `version` = 3494 WHERE (`entry` = 793);
        -- Skinning Knife
        -- buy_price, from 82 to 54
        -- sell_price, from 16 to 10
        -- item_level, from 4 to 3
        -- dmg_min1, from 2.0 to 5
        -- dmg_max1, from 5.0 to 9
        UPDATE `item_template` SET `buy_price` = 54, `sell_price` = 10, `item_level` = 3, `dmg_min1` = 5, `dmg_max1` = 9 WHERE (`entry` = 7005);
        UPDATE `applied_item_updates` SET `entry` = 7005, `version` = 3494 WHERE (`entry` = 7005);
        -- Rawhide Shoulderpads
        -- name, from Patched Leather Shoulderpads to Rawhide Shoulderpads
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `name` = 'Rawhide Shoulderpads', `required_level` = 10 WHERE (`entry` = 1793);
        UPDATE `applied_item_updates` SET `entry` = 1793, `version` = 3494 WHERE (`entry` = 1793);
        -- Footman Tunic
        -- required_level, from 8 to 3
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 6085);
        UPDATE `applied_item_updates` SET `entry` = 6085, `version` = 3494 WHERE (`entry` = 6085);
        -- Embossed Leather Pants
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 3 WHERE (`entry` = 4242);
        UPDATE `applied_item_updates` SET `entry` = 4242, `version` = 3494 WHERE (`entry` = 4242);
        -- Agile Boots
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2 WHERE (`entry` = 4788);
        UPDATE `applied_item_updates` SET `entry` = 4788, `version` = 3494 WHERE (`entry` = 4788);
        -- Hunting Bracers
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 3207);
        UPDATE `applied_item_updates` SET `entry` = 3207, `version` = 3494 WHERE (`entry` = 3207);
        -- Big Bronze Knife
        -- required_level, from 16 to 11
        -- dmg_min1, from 11.0 to 22
        -- dmg_max1, from 22.0 to 34
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 3848);
        UPDATE `applied_item_updates` SET `entry` = 3848, `version` = 3494 WHERE (`entry` = 3848);
        -- Pioneer Belt
        -- buy_price, from 233 to 350
        -- sell_price, from 46 to 70
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `buy_price` = 350, `sell_price` = 70, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 6517);
        UPDATE `applied_item_updates` SET `entry` = 6517, `version` = 3494 WHERE (`entry` = 6517);
        -- Pioneer Trousers
        -- quality, from 1 to 2
        -- buy_price, from 463 to 1208
        -- sell_price, from 92 to 241
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1208, `sell_price` = 241, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 6269);
        UPDATE `applied_item_updates` SET `entry` = 6269, `version` = 3494 WHERE (`entry` = 6269);
        -- Tanned Leather Boots
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 843);
        UPDATE `applied_item_updates` SET `entry` = 843, `version` = 3494 WHERE (`entry` = 843);
        -- Tanned Leather Bracers
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 1844);
        UPDATE `applied_item_updates` SET `entry` = 1844, `version` = 3494 WHERE (`entry` = 1844);
        -- Tanned Leather Gloves
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 844);
        UPDATE `applied_item_updates` SET `entry` = 844, `version` = 3494 WHERE (`entry` = 844);
        -- Wavy Blladed Knife
        -- name, from Hook Dagger to Wavy Blladed Knife
        -- display_id, from 6468 to 6469
        -- required_level, from 13 to 8
        -- dmg_min1, from 8.0 to 16
        -- dmg_max1, from 15.0 to 24
        UPDATE `item_template` SET `name` = 'Wavy Blladed Knife', `display_id` = 6469, `required_level` = 8, `dmg_min1` = 16, `dmg_max1` = 24 WHERE (`entry` = 3184);
        UPDATE `applied_item_updates` SET `entry` = 3184, `version` = 3494 WHERE (`entry` = 3184);
        -- Sharpened Knife
        -- dmg_min1, from 6.0 to 12
        -- dmg_max1, from 11.0 to 19
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 2207);
        UPDATE `applied_item_updates` SET `entry` = 2207, `version` = 3494 WHERE (`entry` = 2207);
        -- Keen Throwing Knife
        -- dmg_min1, from 4.0 to 10
        -- dmg_max1, from 8.0 to 16
        UPDATE `item_template` SET `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 3107);
        UPDATE `applied_item_updates` SET `entry` = 3107, `version` = 3494 WHERE (`entry` = 3107);
        -- Militia Shortsword
        -- dmg_min1, from 4.0 to 9
        -- dmg_max1, from 8.0 to 14
        UPDATE `item_template` SET `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 1161);
        UPDATE `applied_item_updates` SET `entry` = 1161, `version` = 3494 WHERE (`entry` = 1161);
        -- Scalemail Vest
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 285);
        UPDATE `applied_item_updates` SET `entry` = 285, `version` = 3494 WHERE (`entry` = 285);
        -- Heavy Copper Maul
        -- dmg_min1, from 21.0 to 29
        -- dmg_max1, from 32.0 to 40
        UPDATE `item_template` SET `dmg_min1` = 29, `dmg_max1` = 40 WHERE (`entry` = 6214);
        UPDATE `applied_item_updates` SET `entry` = 6214, `version` = 3494 WHERE (`entry` = 6214);
        -- Ragged Leather Bracers
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1370);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1370, 3494);
        -- Dwarven Hatchet
        -- required_level, from 8 to 3
        -- dmg_min1, from 8.0 to 17
        -- dmg_max1, from 15.0 to 27
        UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 17, `dmg_max1` = 27 WHERE (`entry` = 2073);
        UPDATE `applied_item_updates` SET `entry` = 2073, `version` = 3494 WHERE (`entry` = 2073);
        -- Slarkskin
        -- required_level, from 8 to 3
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 6180);
        UPDATE `applied_item_updates` SET `entry` = 6180, `version` = 3494 WHERE (`entry` = 6180);
        -- Stormwind Guard Leggings
        -- required_level, from 8 to 3
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 6084);
        UPDATE `applied_item_updates` SET `entry` = 6084, `version` = 3494 WHERE (`entry` = 6084);
        -- Ironheart Chain
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 4, `stat_value1` = 3 WHERE (`entry` = 3166);
        UPDATE `applied_item_updates` SET `entry` = 3166, `version` = 3494 WHERE (`entry` = 3166);
        -- Burnt Leather Vest
        -- buy_price, from 779 to 1217
        -- sell_price, from 155 to 243
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 1217, `sell_price` = 243, `item_level` = 13, `required_level` = 3, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2961);
        UPDATE `applied_item_updates` SET `entry` = 2961, `version` = 3494 WHERE (`entry` = 2961);
        -- Burnt Leather Pants
        -- buy_price, from 781 to 1221
        -- sell_price, from 156 to 244
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 1221, `sell_price` = 244, `item_level` = 13, `required_level` = 3, `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2962);
        UPDATE `applied_item_updates` SET `entry` = 2962, `version` = 3494 WHERE (`entry` = 2962);
        -- Rough Leather Boots
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 796);
        UPDATE `applied_item_updates` SET `entry` = 796, `version` = 3494 WHERE (`entry` = 796);
        -- Burnt Hide Bracers
        -- required_level, from 7 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3158);
        UPDATE `applied_item_updates` SET `entry` = 3158, `version` = 3494 WHERE (`entry` = 3158);
        -- Pioneer Gloves
        -- buy_price, from 295 to 280
        -- sell_price, from 59 to 56
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `buy_price` = 280, `sell_price` = 56, `required_level` = 2 WHERE (`entry` = 6521);
        UPDATE `applied_item_updates` SET `entry` = 6521, `version` = 3494 WHERE (`entry` = 6521);
        -- Craftsman's Dagger
        -- required_level, from 8 to 3
        -- dmg_min1, from 7.0 to 15
        -- dmg_max1, from 13.0 to 23
        UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 2218);
        UPDATE `applied_item_updates` SET `entry` = 2218, `version` = 3494 WHERE (`entry` = 2218);
        -- Warm Winter Robe
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3216);
        UPDATE `applied_item_updates` SET `entry` = 3216, `version` = 3494 WHERE (`entry` = 3216);
        -- Disciple's Pants
        -- quality, from 1 to 2
        -- buy_price, from 447 to 933
        -- sell_price, from 89 to 186
        -- item_level, from 12 to 13
        -- required_level, from 7 to 3
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 933, `sell_price` = 186, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 6267);
        UPDATE `applied_item_updates` SET `entry` = 6267, `version` = 3494 WHERE (`entry` = 6267);
        -- Cozy Moccasins
        -- name, from Journeyman's Boots to Cozy Moccasins
        -- buy_price, from 213 to 434
        -- sell_price, from 42 to 86
        -- item_level, from 10 to 13
        -- required_level, from 5 to 3
        UPDATE `item_template` SET `name` = 'Cozy Moccasins', `buy_price` = 434, `sell_price` = 86, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 2959);
        UPDATE `applied_item_updates` SET `entry` = 2959, `version` = 3494 WHERE (`entry` = 2959);
        -- Oil-stained Cloak
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3153);
        UPDATE `applied_item_updates` SET `entry` = 3153, `version` = 3494 WHERE (`entry` = 3153);
        -- Gnarled Short Staff
        -- required_level, from 5 to 1
        -- dmg_min1, from 11.0 to 17
        -- dmg_max1, from 17.0 to 24
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 17, `dmg_max1` = 24 WHERE (`entry` = 1010);
        UPDATE `applied_item_updates` SET `entry` = 1010, `version` = 3494 WHERE (`entry` = 1010);
        -- Journeyman's Vest
        -- required_level, from 6 to 1
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 1, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 2957);
        UPDATE `applied_item_updates` SET `entry` = 2957, `version` = 3494 WHERE (`entry` = 2957);
        -- Journeyman's Belt
        -- buy_price, from 196 to 306
        -- sell_price, from 39 to 61
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `buy_price` = 306, `sell_price` = 61, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 4663);
        UPDATE `applied_item_updates` SET `entry` = 4663, `version` = 3494 WHERE (`entry` = 4663);
        -- Strapped Bracers
        -- name, from Journeyman's Bracers to Strapped Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `name` = 'Strapped Bracers', `required_level` = 1 WHERE (`entry` = 3641);
        UPDATE `applied_item_updates` SET `entry` = 3641, `version` = 3494 WHERE (`entry` = 3641);
        -- Lumberjack Axe
        -- required_level, from 4 to 1
        -- dmg_min1, from 6.0 to 13
        -- dmg_max1, from 11.0 to 20
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 768);
        UPDATE `applied_item_updates` SET `entry` = 768, `version` = 3494 WHERE (`entry` = 768);
        -- Worn Leather Gloves
        -- armor, from 1 to 5
        UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 1422);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1422, 3494);
        -- Robe of Apprenticeship
        -- armor, from 5 to 14
        UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 2614);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2614, 3494);
        -- Elastic Wristguards
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1183);
        UPDATE `applied_item_updates` SET `entry` = 1183, `version` = 3494 WHERE (`entry` = 1183);
        -- Heavy Weave Gloves
        -- armor, from 3 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 839);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (839, 3494);
        -- Disciple's Cloak
        -- buy_price, from 346 to 519
        -- sell_price, from 69 to 103
        -- item_level, from 12 to 14
        -- required_level, from 7 to 4
        UPDATE `item_template` SET `buy_price` = 519, `sell_price` = 103, `item_level` = 14, `required_level` = 4 WHERE (`entry` = 6514);
        UPDATE `applied_item_updates` SET `entry` = 6514, `version` = 3494 WHERE (`entry` = 6514);
        -- Balanced Fighting Stick
        -- buy_price, from 3009 to 2928
        -- sell_price, from 601 to 585
        -- required_level, from 8 to 3
        -- dmg_min1, from 14.0 to 22
        -- dmg_max1, from 21.0 to 31
        UPDATE `item_template` SET `buy_price` = 2928, `sell_price` = 585, `required_level` = 3, `dmg_min1` = 22, `dmg_max1` = 31 WHERE (`entry` = 6215);
        UPDATE `applied_item_updates` SET `entry` = 6215, `version` = 3494 WHERE (`entry` = 6215);
        -- Red Linen Sash
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 983);
        UPDATE `applied_item_updates` SET `entry` = 983, `version` = 3494 WHERE (`entry` = 983);
        -- Handstitched Linen Britches
        -- armor, from 4 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 4309);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4309, 3494);
        -- Carving Knife
        -- required_level, from 6 to 1
        -- dmg_min1, from 4.0 to 8
        -- dmg_max1, from 9.0 to 13
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 2140);
        UPDATE `applied_item_updates` SET `entry` = 2140, `version` = 3494 WHERE (`entry` = 2140);
        -- Harvester's Pants
        -- required_level, from 10 to 5
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 3 WHERE (`entry` = 3578);
        UPDATE `applied_item_updates` SET `entry` = 3578, `version` = 3494 WHERE (`entry` = 3578);
        -- Soldier's Gauntlets
        -- buy_price, from 1339 to 1164
        -- sell_price, from 267 to 232
        -- item_level, from 17 to 16
        UPDATE `item_template` SET `buy_price` = 1164, `sell_price` = 232, `item_level` = 16 WHERE (`entry` = 6547);
        UPDATE `applied_item_updates` SET `entry` = 6547, `version` = 3494 WHERE (`entry` = 6547);
        -- Pioneer Boots
        -- buy_price, from 439 to 421
        -- sell_price, from 87 to 84
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `buy_price` = 421, `sell_price` = 84, `required_level` = 2 WHERE (`entry` = 6518);
        UPDATE `applied_item_updates` SET `entry` = 6518, `version` = 3494 WHERE (`entry` = 6518);
        -- Journeyman's Pants
        -- buy_price, from 770 to 473
        -- sell_price, from 154 to 94
        -- item_level, from 12 to 10
        -- required_level, from 7 to 1
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 473, `sell_price` = 94, `item_level` = 10, `required_level` = 1, `stat_type1` = 5, `stat_value1` = 1 WHERE (`entry` = 2958);
        UPDATE `applied_item_updates` SET `entry` = 2958, `version` = 3494 WHERE (`entry` = 2958);
        -- Worn Leather Vest
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1425);
        UPDATE `applied_item_updates` SET `entry` = 1425, `version` = 3494 WHERE (`entry` = 1425);
        -- Infantry Belt
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 6509);
        UPDATE `applied_item_updates` SET `entry` = 6509, `version` = 3494 WHERE (`entry` = 6509);
        -- Militia Warhammer
        -- dmg_min1, from 7.0 to 12
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 17 WHERE (`entry` = 5579);
        UPDATE `applied_item_updates` SET `entry` = 5579, `version` = 3494 WHERE (`entry` = 5579);
        -- Patterned Bronze Bracers
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 2868);
        UPDATE `applied_item_updates` SET `entry` = 2868, `version` = 3494 WHERE (`entry` = 2868);
        -- Silvered Bronze Gauntlets
        -- required_level, from 22 to 17
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 3 WHERE (`entry` = 3483);
        UPDATE `applied_item_updates` SET `entry` = 3483, `version` = 3494 WHERE (`entry` = 3483);
        -- Ring of Iron Will
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 1319);
        UPDATE `applied_item_updates` SET `entry` = 1319, `version` = 3494 WHERE (`entry` = 1319);
        -- Two-handed Cavalier Sword
        -- required_level, from 24 to 19
        -- stat_value1, from 0 to 6
        -- dmg_min1, from 37.0 to 44
        -- dmg_max1, from 57.0 to 60
        UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 6, `dmg_min1` = 44, `dmg_max1` = 60 WHERE (`entry` = 3206);
        UPDATE `applied_item_updates` SET `entry` = 3206, `version` = 3494 WHERE (`entry` = 3206);
        -- Well-stitched Robe
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1171);
        UPDATE `applied_item_updates` SET `entry` = 1171, `version` = 3494 WHERE (`entry` = 1171);
        -- Long Bo Staff
        -- required_level, from 5 to 1
        -- dmg_min1, from 9.0 to 15
        -- dmg_max1, from 15.0 to 21
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 15, `dmg_max1` = 21 WHERE (`entry` = 767);
        UPDATE `applied_item_updates` SET `entry` = 767, `version` = 3494 WHERE (`entry` = 767);
        -- Linen Cloak
        -- armor, from 2 to 5
        UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 2570);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2570, 3494);
        -- Russet Hat
        -- required_level, from 32 to 27
        UPDATE `item_template` SET `required_level` = 27 WHERE (`entry` = 3889);
        UPDATE `applied_item_updates` SET `entry` = 3889, `version` = 3494 WHERE (`entry` = 3889);
        -- Frostweave Mantle
        -- required_level, from 25 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 6395);
        UPDATE `applied_item_updates` SET `entry` = 6395, `version` = 3494 WHERE (`entry` = 6395);
        -- Fen Keeper Robe
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 5 WHERE (`entry` = 3558);
        UPDATE `applied_item_updates` SET `entry` = 3558, `version` = 3494 WHERE (`entry` = 3558);
        -- Band of Elven Grace
        -- required_level, from 18 to 13
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 6678);
        UPDATE `applied_item_updates` SET `entry` = 6678, `version` = 3494 WHERE (`entry` = 6678);
        -- Minor Channeling Ring
        -- buy_price, from 7500 to 500
        -- sell_price, from 1875 to 125
        -- required_level, from 19 to 14
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 500, `sell_price` = 125, `required_level` = 14, `stat_value1` = 3 WHERE (`entry` = 1449);
        UPDATE `applied_item_updates` SET `entry` = 1449, `version` = 3494 WHERE (`entry` = 1449);
        -- Lucky Trousers
        -- required_level, from 12 to 7
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 7, `stat_value1` = 3 WHERE (`entry` = 1832);
        UPDATE `applied_item_updates` SET `entry` = 1832, `version` = 3494 WHERE (`entry` = 1832);
        -- Battered Buckler
        -- subclass, from 6 to 5
        -- buy_price, from 15 to 11
        -- sell_price, from 3 to 2
        UPDATE `item_template` SET `subclass` = 5, `buy_price` = 11, `sell_price` = 2 WHERE (`entry` = 2210);
        UPDATE `applied_item_updates` SET `entry` = 2210, `version` = 3494 WHERE (`entry` = 2210);
        -- Tanned Leather Vest
        -- name, from Tanned Leather Jerkin to Tanned Leather Vest
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `name` = 'Tanned Leather Vest', `required_level` = 7 WHERE (`entry` = 846);
        UPDATE `applied_item_updates` SET `entry` = 846, `version` = 3494 WHERE (`entry` = 846);
        -- Infantry Boots
        -- buy_price, from 335 to 240
        -- sell_price, from 67 to 48
        -- item_level, from 10 to 9
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `buy_price` = 240, `sell_price` = 48, `item_level` = 9, `required_level` = 1 WHERE (`entry` = 6506);
        UPDATE `applied_item_updates` SET `entry` = 6506, `version` = 3494 WHERE (`entry` = 6506);
        -- Heavy Weave Belt
        -- armor, from 2 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 3589);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3589, 3494);
        -- Knitted Pants
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 794);
        UPDATE `applied_item_updates` SET `entry` = 794, `version` = 3494 WHERE (`entry` = 794);
        -- Knitted Vest
        -- name, from Knitted Tunic to Knitted Vest
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `name` = 'Knitted Vest', `required_level` = 1 WHERE (`entry` = 795);
        UPDATE `applied_item_updates` SET `entry` = 795, `version` = 3494 WHERE (`entry` = 795);
        -- Burnished Chain Tunic
        -- required_level, from 16 to 11
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 24
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 3, `stat_value2` = 24 WHERE (`entry` = 2989);
        UPDATE `applied_item_updates` SET `entry` = 2989, `version` = 3494 WHERE (`entry` = 2989);
        -- Scouting Belt
        -- buy_price, from 2111 to 2535
        -- sell_price, from 422 to 507
        -- item_level, from 21 to 23
        -- required_level, from 16 to 13
        UPDATE `item_template` SET `buy_price` = 2535, `sell_price` = 507, `item_level` = 23, `required_level` = 13 WHERE (`entry` = 6581);
        UPDATE `applied_item_updates` SET `entry` = 6581, `version` = 3494 WHERE (`entry` = 6581);
        -- Night Watch Gauntlets
        -- required_level, from 17 to 12
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 6, `stat_value1` = 1, `stat_value2` = 1 WHERE (`entry` = 3559);
        UPDATE `applied_item_updates` SET `entry` = 3559, `version` = 3494 WHERE (`entry` = 3559);
        -- Northern Shortsword
        -- required_level, from 14 to 9
        -- dmg_min1, from 12.0 to 27
        -- dmg_max1, from 23.0 to 34
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 27, `dmg_max1` = 34 WHERE (`entry` = 2078);
        UPDATE `applied_item_updates` SET `entry` = 2078, `version` = 3494 WHERE (`entry` = 2078);
        -- Handstitched Leather Boots
        -- buy_price, from 70 to 147
        -- sell_price, from 14 to 29
        -- item_level, from 6 to 8
        UPDATE `item_template` SET `buy_price` = 147, `sell_price` = 29, `item_level` = 8 WHERE (`entry` = 2302);
        UPDATE `applied_item_updates` SET `entry` = 2302, `version` = 3494 WHERE (`entry` = 2302);
        -- Burnished Chain Spaulders
        -- buy_price, from 2576 to 2911
        -- sell_price, from 515 to 582
        -- item_level, from 22 to 23
        -- required_level, from 17 to 13
        UPDATE `item_template` SET `buy_price` = 2911, `sell_price` = 582, `item_level` = 23, `required_level` = 13 WHERE (`entry` = 4694);
        UPDATE `applied_item_updates` SET `entry` = 4694, `version` = 3494 WHERE (`entry` = 4694);
        -- Veteran Armor
        -- required_level, from 10 to 5
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 3 WHERE (`entry` = 2977);
        UPDATE `applied_item_updates` SET `entry` = 2977, `version` = 3494 WHERE (`entry` = 2977);
        -- Dwarven Defender
        -- buy_price, from 3066 to 2854
        -- sell_price, from 613 to 570
        -- required_level, from 12 to 7
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 2854, `sell_price` = 570, `required_level` = 7, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 6187);
        UPDATE `applied_item_updates` SET `entry` = 6187, `version` = 3494 WHERE (`entry` = 6187);
        -- Dwarven Fishing Pole
        -- required_level, from 14 to 9
        -- dmg_min1, from 14.0 to 12
        -- dmg_max1, from 27.0 to 18
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 12, `dmg_max1` = 18 WHERE (`entry` = 3567);
        UPDATE `applied_item_updates` SET `entry` = 3567, `version` = 3494 WHERE (`entry` = 3567);
        -- Balanced Throwing Dagger
        -- dmg_min1, from 2.0 to 6
        -- dmg_max1, from 5.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 9 WHERE (`entry` = 2946);
        UPDATE `applied_item_updates` SET `entry` = 2946, `version` = 3494 WHERE (`entry` = 2946);
        -- Golden Scale Cuirass
        -- required_level, from 35 to 30
        -- stat_value1, from 0 to 11
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 11 WHERE (`entry` = 3845);
        UPDATE `applied_item_updates` SET `entry` = 3845, `version` = 3494 WHERE (`entry` = 3845);
        -- Augmented Chain Bracers
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 30
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 30 WHERE (`entry` = 2421);
        UPDATE `applied_item_updates` SET `entry` = 2421, `version` = 3494 WHERE (`entry` = 2421);
        -- Defias Renegade Ring
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 1076);
        UPDATE `applied_item_updates` SET `entry` = 1076, `version` = 3494 WHERE (`entry` = 1076);
        -- Crescent of Forlorn Spirits
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 3
        -- dmg_min1, from 18.0 to 29
        -- dmg_max1, from 35.0 to 44
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3, `dmg_min1` = 29, `dmg_max1` = 44 WHERE (`entry` = 2044);
        UPDATE `applied_item_updates` SET `entry` = 2044, `version` = 3494 WHERE (`entry` = 2044);
        -- Gold Lion Shield
        -- required_level, from 29 to 24
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        -- stat_value3, from 0 to 3
        UPDATE `item_template` SET `required_level` = 24, `stat_type1` = 6, `stat_value1` = 2, `stat_value3` = 3 WHERE (`entry` = 2916);
        UPDATE `applied_item_updates` SET `entry` = 2916, `version` = 3494 WHERE (`entry` = 2916);
        -- Blackrock Chain Boots
        -- name, from Blackrock Boots to Blackrock Chain Boots
        -- required_level, from 14 to 9
        UPDATE `item_template` SET `name` = 'Blackrock Chain Boots', `required_level` = 9 WHERE (`entry` = 1446);
        UPDATE `applied_item_updates` SET `entry` = 1446, `version` = 3494 WHERE (`entry` = 1446);
        -- Ironwrought Bracers
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 6177);
        UPDATE `applied_item_updates` SET `entry` = 6177, `version` = 3494 WHERE (`entry` = 6177);
        -- Blackrock Chain Gauntlets
        -- name, from Blackrock Gauntlets to Blackrock Chain Gauntlets
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `name` = 'Blackrock Chain Gauntlets', `required_level` = 10, `stat_value1` = 2 WHERE (`entry` = 1448);
        UPDATE `applied_item_updates` SET `entry` = 1448, `version` = 3494 WHERE (`entry` = 1448);
        -- Soldier's Girdle
        -- quality, from 1 to 2
        -- buy_price, from 701 to 1545
        -- sell_price, from 140 to 309
        -- item_level, from 16 to 18
        -- required_level, from 11 to 8
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1545, `sell_price` = 309, `item_level` = 18, `required_level` = 8 WHERE (`entry` = 6548);
        UPDATE `applied_item_updates` SET `entry` = 6548, `version` = 3494 WHERE (`entry` = 6548);
        -- Fine Leather Tunic
        -- required_level, from 12 to 7
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 7, `stat_value1` = 3 WHERE (`entry` = 4243);
        UPDATE `applied_item_updates` SET `entry` = 4243, `version` = 3494 WHERE (`entry` = 4243);
        -- Smith's Trousers
        -- required_level, from 15 to 10
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 6, `stat_value1` = 2, `stat_value2` = 3 WHERE (`entry` = 1310);
        UPDATE `applied_item_updates` SET `entry` = 1310, `version` = 3494 WHERE (`entry` = 1310);
        -- Black Whelp Gloves
        -- required_level, from 13 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 1302);
        UPDATE `applied_item_updates` SET `entry` = 1302, `version` = 3494 WHERE (`entry` = 1302);
        -- Deadly Bronze Poniard
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 14.0 to 23
        -- dmg_max1, from 26.0 to 36
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2, `dmg_min1` = 23, `dmg_max1` = 36 WHERE (`entry` = 3490);
        UPDATE `applied_item_updates` SET `entry` = 3490, `version` = 3494 WHERE (`entry` = 3490);
        -- Harvester's Robe
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 3 WHERE (`entry` = 1561);
        UPDATE `applied_item_updates` SET `entry` = 1561, `version` = 3494 WHERE (`entry` = 1561);
        -- Salma's Oven Mitts
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 1479);
        UPDATE `applied_item_updates` SET `entry` = 1479, `version` = 3494 WHERE (`entry` = 1479);
        -- Kimbra Boots
        -- buy_price, from 3079 to 2691
        -- sell_price, from 615 to 538
        -- item_level, from 23 to 22
        -- required_level, from 18 to 12
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 2691, `sell_price` = 538, `item_level` = 22, `required_level` = 12, `stat_value1` = 2 WHERE (`entry` = 6191);
        UPDATE `applied_item_updates` SET `entry` = 6191, `version` = 3494 WHERE (`entry` = 6191);
        -- Sage's Bracers
        -- buy_price, from 3384 to 3540
        -- sell_price, from 676 to 708
        -- item_level, from 27 to 28
        -- required_level, from 22 to 18
        UPDATE `item_template` SET `buy_price` = 3540, `sell_price` = 708, `item_level` = 28, `required_level` = 18 WHERE (`entry` = 6613);
        UPDATE `applied_item_updates` SET `entry` = 6613, `version` = 3494 WHERE (`entry` = 6613);
        -- Sage's Cloak
        -- buy_price, from 4098 to 3883
        -- sell_price, from 819 to 776
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `buy_price` = 3883, `sell_price` = 776, `required_level` = 15 WHERE (`entry` = 6614);
        UPDATE `applied_item_updates` SET `entry` = 6614, `version` = 3494 WHERE (`entry` = 6614);
        -- Tear of Grief
        -- required_level, from 11 to 6
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 6, `stat_value1` = 3 WHERE (`entry` = 5611);
        UPDATE `applied_item_updates` SET `entry` = 5611, `version` = 3494 WHERE (`entry` = 5611);
        -- Infantry Gauntlets
        -- buy_price, from 209 to 421
        -- sell_price, from 41 to 84
        -- item_level, from 10 to 13
        -- required_level, from 5 to 3
        UPDATE `item_template` SET `buy_price` = 421, `sell_price` = 84, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 6510);
        UPDATE `applied_item_updates` SET `entry` = 6510, `version` = 3494 WHERE (`entry` = 6510);
        -- Enchanter's Cowl
        -- required_level, from 26 to 21
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 4 WHERE (`entry` = 4322);
        UPDATE `applied_item_updates` SET `entry` = 4322, `version` = 3494 WHERE (`entry` = 4322);
        -- Silk Mantle of Gamn
        -- required_level, from 23 to 18
        UPDATE `item_template` SET `required_level` = 18 WHERE (`entry` = 2913);
        UPDATE `applied_item_updates` SET `entry` = 2913, `version` = 3494 WHERE (`entry` = 2913);
        -- Dreamer's Belt
        -- required_level, from 24 to 19
        UPDATE `item_template` SET `required_level` = 19 WHERE (`entry` = 4829);
        UPDATE `applied_item_updates` SET `entry` = 4829, `version` = 3494 WHERE (`entry` = 4829);
        -- Flameweave Pants
        -- display_id, from 7781 to 11506
        -- buy_price, from 7013 to 7715
        -- sell_price, from 1402 to 1543
        -- item_level, from 27 to 28
        -- required_level, from 22 to 18
        -- stat_value1, from 0 to 5
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `display_id` = 11506, `buy_price` = 7715, `sell_price` = 1543, `item_level` = 28, `required_level` = 18, `stat_value1` = 5, `stat_type2` = 7, `stat_value2` = 3 WHERE (`entry` = 3067);
        UPDATE `applied_item_updates` SET `entry` = 3067, `version` = 3494 WHERE (`entry` = 3067);
        -- Flameweave Bracers
        -- required_level, from 21 to 16
        UPDATE `item_template` SET `required_level` = 16 WHERE (`entry` = 3647);
        UPDATE `applied_item_updates` SET `entry` = 3647, `version` = 3494 WHERE (`entry` = 3647);
        -- Flameweave Gloves
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 3 WHERE (`entry` = 3066);
        UPDATE `applied_item_updates` SET `entry` = 3066, `version` = 3494 WHERE (`entry` = 3066);
        -- Coral Band
        -- item_level, from 26 to 28
        -- required_level, from 21 to 18
        -- stat_value1, from 0 to 35
        -- stat_value2, from 0 to 35
        UPDATE `item_template` SET `item_level` = 28, `required_level` = 18, `stat_value1` = 35, `stat_value2` = 35 WHERE (`entry` = 5000);
        UPDATE `applied_item_updates` SET `entry` = 5000, `version` = 3494 WHERE (`entry` = 5000);
        -- Flameweave Cloak
        -- buy_price, from 3993 to 3883
        -- sell_price, from 798 to 776
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 20
        UPDATE `item_template` SET `buy_price` = 3883, `sell_price` = 776, `required_level` = 15, `stat_value1` = 20 WHERE (`entry` = 6381);
        UPDATE `applied_item_updates` SET `entry` = 6381, `version` = 3494 WHERE (`entry` = 6381);
        -- Warrior's Tunic
        -- buy_price, from 1185 to 1481
        -- sell_price, from 237 to 296
        -- item_level, from 12 to 13
        -- required_level, from 7 to 3
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 1481, `sell_price` = 296, `item_level` = 13, `required_level` = 3, `stat_type1` = 4, `stat_value1` = 1 WHERE (`entry` = 2965);
        UPDATE `applied_item_updates` SET `entry` = 2965, `version` = 3494 WHERE (`entry` = 2965);
        -- Warrior's Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3214);
        UPDATE `applied_item_updates` SET `entry` = 3214, `version` = 3494 WHERE (`entry` = 3214);
        -- Studded Leather Cap
        -- name, from Studded Hat to Studded Leather Cap
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `name` = 'Studded Leather Cap', `required_level` = 27, `stat_value1` = 5 WHERE (`entry` = 3890);
        UPDATE `applied_item_updates` SET `entry` = 3890, `version` = 3494 WHERE (`entry` = 3890);
        -- Barbaric Shoulders
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3 WHERE (`entry` = 5964);
        UPDATE `applied_item_updates` SET `entry` = 5964, `version` = 3494 WHERE (`entry` = 5964);
        -- Raptorbane Tunic
        -- required_level, from 24 to 19
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 5, `stat_value2` = 3 WHERE (`entry` = 3566);
        UPDATE `applied_item_updates` SET `entry` = 3566, `version` = 3494 WHERE (`entry` = 3566);
        -- Guardian Pants
        -- required_level, from 27 to 22
        -- stat_value1, from 0 to 8
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 8 WHERE (`entry` = 5962);
        UPDATE `applied_item_updates` SET `entry` = 5962, `version` = 3494 WHERE (`entry` = 5962);
        -- Forest Leather Bracers
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 3202);
        UPDATE `applied_item_updates` SET `entry` = 3202, `version` = 3494 WHERE (`entry` = 3202);
        -- Ring of Pure Silver
        -- required_level, from 26 to 21
        -- stat_value2, from 0 to 40
        UPDATE `item_template` SET `required_level` = 21, `stat_value2` = 40 WHERE (`entry` = 1116);
        UPDATE `applied_item_updates` SET `entry` = 1116, `version` = 3494 WHERE (`entry` = 1116);
        -- Heavy Throwing Dagger
        -- dmg_min1, from 7.0 to 14
        -- dmg_max1, from 15.0 to 22
        UPDATE `item_template` SET `dmg_min1` = 14, `dmg_max1` = 22 WHERE (`entry` = 3108);
        UPDATE `applied_item_updates` SET `entry` = 3108, `version` = 3494 WHERE (`entry` = 3108);
        -- Sage's Robe
        -- buy_price, from 6693 to 6438
        -- sell_price, from 1338 to 1287
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `buy_price` = 6438, `sell_price` = 1287, `required_level` = 17 WHERE (`entry` = 6610);
        UPDATE `applied_item_updates` SET `entry` = 6610, `version` = 3494 WHERE (`entry` = 6610);
        -- Riding Gloves
        -- required_level, from 15 to 10
        -- stat_type1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 5 WHERE (`entry` = 1304);
        UPDATE `applied_item_updates` SET `entry` = 1304, `version` = 3494 WHERE (`entry` = 1304);
        -- Clergy Ring
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 5622);
        UPDATE `applied_item_updates` SET `entry` = 5622, `version` = 3494 WHERE (`entry` = 5622);
        -- Resilient Poncho
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 35
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 35 WHERE (`entry` = 3561);
        UPDATE `applied_item_updates` SET `entry` = 3561, `version` = 3494 WHERE (`entry` = 3561);
        -- Mighty Iron Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3492);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3492, 3494);
        -- Everglow Lantern
        -- required_level, from 20 to 15
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        -- sheath, from 7 to 6
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 6, `stat_value1` = 2, `sheath` = 6 WHERE (`entry` = 5323);
        UPDATE `applied_item_updates` SET `entry` = 5323, `version` = 3494 WHERE (`entry` = 5323);
        -- Hunting Belt
        -- required_level, from 10 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 4690);
        UPDATE `applied_item_updates` SET `entry` = 4690, `version` = 3494 WHERE (`entry` = 4690);
        -- Black Whelp Boots
        -- required_level, from 13 to 8
        -- stat_type1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 3 WHERE (`entry` = 6092);
        UPDATE `applied_item_updates` SET `entry` = 6092, `version` = 3494 WHERE (`entry` = 6092);
        -- Windsong Gloves
        -- required_level, from 15 to 10
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 3, `stat_value1` = 2 WHERE (`entry` = 5630);
        UPDATE `applied_item_updates` SET `entry` = 5630, `version` = 3494 WHERE (`entry` = 5630);
        -- Lucine Longsword
        -- required_level, from 20 to 15
        -- dmg_min1, from 19.0 to 33
        -- dmg_max1, from 36.0 to 50
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 33, `dmg_max1` = 50 WHERE (`entry` = 3400);
        UPDATE `applied_item_updates` SET `entry` = 3400, `version` = 3494 WHERE (`entry` = 3400);
        -- Solstice Robe
        -- armor, from 5 to 16
        UPDATE `item_template` SET `armor` = 16 WHERE (`entry` = 4782);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4782, 3494);
        -- Weighted Throwing Axe
        -- dmg_min1, from 2.0 to 6
        -- dmg_max1, from 5.0 to 9
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 9 WHERE (`entry` = 3131);
        UPDATE `applied_item_updates` SET `entry` = 3131, `version` = 3494 WHERE (`entry` = 3131);
        -- Blackrock Chain Pauldrons
        -- name, from Blackrock Pauldrons to Blackrock Chain Pauldrons
        -- required_level, from 18 to 13
        UPDATE `item_template` SET `name` = 'Blackrock Chain Pauldrons', `required_level` = 13 WHERE (`entry` = 1445);
        UPDATE `applied_item_updates` SET `entry` = 1445, `version` = 3494 WHERE (`entry` = 1445);
        -- Malleable Chain Leggings
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 3
        -- stat_value3, from 0 to 30
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 2, `stat_value2` = 3, `stat_value3` = 30 WHERE (`entry` = 2545);
        UPDATE `applied_item_updates` SET `entry` = 2545, `version` = 3494 WHERE (`entry` = 2545);
        -- Tunneler's Boots
        -- required_level, from 13 to 8
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 2 WHERE (`entry` = 2037);
        UPDATE `applied_item_updates` SET `entry` = 2037, `version` = 3494 WHERE (`entry` = 2037);
        -- Runed Copper Bracers
        -- required_level, from 14 to 9
        UPDATE `item_template` SET `required_level` = 9 WHERE (`entry` = 2854);
        UPDATE `applied_item_updates` SET `entry` = 2854, `version` = 3494 WHERE (`entry` = 2854);
        -- Burnished Chain Gloves
        -- armor, from 8 to 28
        UPDATE `item_template` SET `armor` = 28 WHERE (`entry` = 2992);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2992, 3494);
        -- Firemail Cloak
        -- fire_res, from 5 to 4
        -- material, from 7 to 5
        UPDATE `item_template` SET `fire_res` = 4, `material` = 5 WHERE (`entry` = 4797);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4797, 3494);
        -- Barreling Reaper
        -- required_level, from 27 to 22
        -- stat_value1, from 0 to 3
        -- dmg_min1, from 19.0 to 29
        -- dmg_max1, from 37.0 to 45
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `dmg_min1` = 29, `dmg_max1` = 45 WHERE (`entry` = 6194);
        UPDATE `applied_item_updates` SET `entry` = 6194, `version` = 3494 WHERE (`entry` = 6194);
        -- Defender Shield
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6572);
        UPDATE `applied_item_updates` SET `entry` = 6572, `version` = 3494 WHERE (`entry` = 6572);
        -- Sharp Throwing Axe
        -- dmg_min1, from 4.0 to 10
        -- dmg_max1, from 8.0 to 16
        UPDATE `item_template` SET `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 3135);
        UPDATE `applied_item_updates` SET `entry` = 3135, `version` = 3494 WHERE (`entry` = 3135);
        -- Glinting Scale Pauldrons
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 25
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 25 WHERE (`entry` = 4705);
        UPDATE `applied_item_updates` SET `entry` = 4705, `version` = 3494 WHERE (`entry` = 4705);
        -- Burnished Chain Girdle
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 20
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 20 WHERE (`entry` = 4697);
        UPDATE `applied_item_updates` SET `entry` = 4697, `version` = 3494 WHERE (`entry` = 4697);
        -- Silvered Bronze Boots
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3 WHERE (`entry` = 3482);
        UPDATE `applied_item_updates` SET `entry` = 3482, `version` = 3494 WHERE (`entry` = 3482);
        -- Defender Cloak
        -- buy_price, from 3248 to 3066
        -- sell_price, from 649 to 613
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `buy_price` = 3066, `sell_price` = 613, `required_level` = 10 WHERE (`entry` = 6575);
        UPDATE `applied_item_updates` SET `entry` = 6575, `version` = 3494 WHERE (`entry` = 6575);
        -- Glinting Shield
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 3656);
        UPDATE `applied_item_updates` SET `entry` = 3656, `version` = 3494 WHERE (`entry` = 3656);
        -- Knitted Belt
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 3602);
        UPDATE `applied_item_updates` SET `entry` = 3602, `version` = 3494 WHERE (`entry` = 3602);
        -- Rough Leather Vest
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 799);
        UPDATE `applied_item_updates` SET `entry` = 799, `version` = 3494 WHERE (`entry` = 799);
        -- Rough Leather Pants
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 798);
        UPDATE `applied_item_updates` SET `entry` = 798, `version` = 3494 WHERE (`entry` = 798);
        -- Rough Leather Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 797);
        UPDATE `applied_item_updates` SET `entry` = 797, `version` = 3494 WHERE (`entry` = 797);
        -- Toughened Leather Armor
        -- required_level, from 19 to 14
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 14, `stat_value1` = 5 WHERE (`entry` = 2314);
        UPDATE `applied_item_updates` SET `entry` = 2314, `version` = 3494 WHERE (`entry` = 2314);
        -- Dark Leather Belt
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 4249);
        UPDATE `applied_item_updates` SET `entry` = 4249, `version` = 3494 WHERE (`entry` = 4249);
        -- Dark Leather Pants
        -- required_level, from 18 to 13
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 7, `stat_value1` = 3, `stat_type2` = 6, `stat_value2` = 3 WHERE (`entry` = 5961);
        UPDATE `applied_item_updates` SET `entry` = 5961, `version` = 3494 WHERE (`entry` = 5961);
        -- Ambassador's Boots
        -- required_level, from 20 to 15
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 3, `stat_value1` = 3 WHERE (`entry` = 2033);
        UPDATE `applied_item_updates` SET `entry` = 2033, `version` = 3494 WHERE (`entry` = 2033);
        -- Cloak of Night
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4447);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4447, 3494);
        -- Warrior's Pants
        -- required_level, from 6 to 1
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 1, `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 2966);
        UPDATE `applied_item_updates` SET `entry` = 2966, `version` = 3494 WHERE (`entry` = 2966);
        -- Green Iron Helm
        -- required_level, from 29 to 24
        UPDATE `item_template` SET `required_level` = 24 WHERE (`entry` = 3836);
        UPDATE `applied_item_updates` SET `entry` = 3836, `version` = 3494 WHERE (`entry` = 3836);
        -- Silver Scale Breastplate
        -- stat_value1, from 0 to 7
        UPDATE `item_template` SET `stat_value1` = 7 WHERE (`entry` = 2870);
        UPDATE `applied_item_updates` SET `entry` = 2870, `version` = 3494 WHERE (`entry` = 2870);
        -- Defender Girdle
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 6576);
        UPDATE `applied_item_updates` SET `entry` = 6576, `version` = 3494 WHERE (`entry` = 6576);
        -- Mighty Chain Pants
        -- required_level, from 18 to 13
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 5 WHERE (`entry` = 4800);
        UPDATE `applied_item_updates` SET `entry` = 4800, `version` = 3494 WHERE (`entry` = 4800);
        -- Small Spider Eye
        -- display_id, from 7345 to 7986
        UPDATE `item_template` SET `display_id` = 7986 WHERE (`entry` = 5465);
        UPDATE `applied_item_updates` SET `entry` = 5465, `version` = 3494 WHERE (`entry` = 5465);
        -- Seer's Padded Armor
        -- buy_price, from 3885 to 4055
        -- sell_price, from 777 to 811
        -- item_level, from 22 to 23
        -- required_level, from 17 to 13
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 4055, `sell_price` = 811, `item_level` = 23, `required_level` = 13, `stat_value1` = 5 WHERE (`entry` = 6561);
        UPDATE `applied_item_updates` SET `entry` = 6561, `version` = 3494 WHERE (`entry` = 6561);
        -- Foreman Belt
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 3217);
        UPDATE `applied_item_updates` SET `entry` = 3217, `version` = 3494 WHERE (`entry` = 3217);
        -- Willow Pants
        -- buy_price, from 1630 to 2156
        -- sell_price, from 326 to 431
        -- item_level, from 16 to 18
        -- required_level, from 11 to 8
        UPDATE `item_template` SET `buy_price` = 2156, `sell_price` = 431, `item_level` = 18, `required_level` = 8 WHERE (`entry` = 6540);
        UPDATE `applied_item_updates` SET `entry` = 6540, `version` = 3494 WHERE (`entry` = 6540);
        -- Willow Boots
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 6537);
        UPDATE `applied_item_updates` SET `entry` = 6537, `version` = 3494 WHERE (`entry` = 6537);
        -- Journeyman's Gloves
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 2960);
        UPDATE `applied_item_updates` SET `entry` = 2960, `version` = 3494 WHERE (`entry` = 2960);
        -- Seer's Cape
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6378);
        UPDATE `applied_item_updates` SET `entry` = 6378, `version` = 3494 WHERE (`entry` = 6378);
        -- Dwarven Flamestick
        -- required_level, from 13 to 8
        -- dmg_min1, from 16.0 to 26
        -- dmg_max1, from 30.0 to 40
        -- delay, from 1800 to 3300
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 26, `dmg_max1` = 40, `delay` = 3300 WHERE (`entry` = 5241);
        UPDATE `applied_item_updates` SET `entry` = 5241, `version` = 3494 WHERE (`entry` = 5241);
        -- Disciple's Vest
        -- quality, from 1 to 2
        -- buy_price, from 394 to 1234
        -- sell_price, from 78 to 246
        -- item_level, from 11 to 14
        -- required_level, from 6 to 4
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1234, `sell_price` = 246, `item_level` = 14, `required_level` = 4 WHERE (`entry` = 6266);
        UPDATE `applied_item_updates` SET `entry` = 6266, `version` = 3494 WHERE (`entry` = 6266);
        -- Shimmering Armor
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6567);
        UPDATE `applied_item_updates` SET `entry` = 6567, `version` = 3494 WHERE (`entry` = 6567);
        -- Magister's Sash
        -- name, from Magister's Belt to Magister's Sash
        -- required_level, from 10 to 5
        -- stat_value1, from 0 to 17
        UPDATE `item_template` SET `name` = 'Magister\'s Sash', `required_level` = 5, `stat_value1` = 17 WHERE (`entry` = 4684);
        UPDATE `applied_item_updates` SET `entry` = 4684, `version` = 3494 WHERE (`entry` = 4684);
        -- Seer's Bracers
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 3645);
        UPDATE `applied_item_updates` SET `entry` = 3645, `version` = 3494 WHERE (`entry` = 3645);
        -- Inferno Cloak
        -- fire_res, from 5 to 4
        UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 4790);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4790, 3494);
        -- Soldier's Leggings
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6546);
        UPDATE `applied_item_updates` SET `entry` = 6546, `version` = 3494 WHERE (`entry` = 6546);
        -- Soldier's Boots
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6551);
        UPDATE `applied_item_updates` SET `entry` = 6551, `version` = 3494 WHERE (`entry` = 6551);
        -- Soldier's Bracers
        -- required_level, from 10 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 6550);
        UPDATE `applied_item_updates` SET `entry` = 6550, `version` = 3494 WHERE (`entry` = 6550);
        -- Stormwind Chain Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1360);
        UPDATE `applied_item_updates` SET `entry` = 1360, `version` = 3494 WHERE (`entry` = 1360);
        -- Trogg Slicer
        -- required_level, from 13 to 8
        -- dmg_min1, from 28.0 to 43
        -- dmg_max1, from 42.0 to 58
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 43, `dmg_max1` = 58 WHERE (`entry` = 6186);
        UPDATE `applied_item_updates` SET `entry` = 6186, `version` = 3494 WHERE (`entry` = 6186);
        -- Woolen Boots
        -- required_level, from 14 to 9
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 9, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 2583);
        UPDATE `applied_item_updates` SET `entry` = 2583, `version` = 3494 WHERE (`entry` = 2583);
        -- Finely Woven Cloak
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 1270);
        UPDATE `applied_item_updates` SET `entry` = 1270, `version` = 3494 WHERE (`entry` = 1270);
        -- Pearl Handled Dagger
        -- name, from Pearl-handled Dagger to Pearl Handled Dagger
        -- required_level, from 17 to 12
        -- dmg_min1, from 11.0 to 21
        -- dmg_max1, from 21.0 to 32
        UPDATE `item_template` SET `name` = 'Pearl Handled Dagger', `required_level` = 12, `dmg_min1` = 21, `dmg_max1` = 32 WHERE (`entry` = 5540);
        UPDATE `applied_item_updates` SET `entry` = 5540, `version` = 3494 WHERE (`entry` = 5540);
        -- Heavy Weave Armor
        -- armor, from 5 to 14
        UPDATE `item_template` SET `armor` = 14 WHERE (`entry` = 837);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (837, 3494);
        -- Old Blanchy's Blanket
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2165);
        UPDATE `applied_item_updates` SET `entry` = 2165, `version` = 3494 WHERE (`entry` = 2165);
        -- Hunting Vest
        -- name, from Hunting Tunic to Hunting Vest
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `name` = 'Hunting Vest', `required_level` = 5, `stat_type1` = 3, `stat_value1` = 3 WHERE (`entry` = 2973);
        UPDATE `applied_item_updates` SET `entry` = 2973, `version` = 3494 WHERE (`entry` = 2973);
        -- Veteran Boots
        -- buy_price, from 1571 to 2391
        -- sell_price, from 314 to 478
        -- item_level, from 15 to 18
        -- required_level, from 10 to 8
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 2391, `sell_price` = 478, `item_level` = 18, `required_level` = 8, `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 2979);
        UPDATE `applied_item_updates` SET `entry` = 2979, `version` = 3494 WHERE (`entry` = 2979);
        -- Magister's Pants
        -- required_level, from 11 to 6
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 6, `stat_value1` = 3 WHERE (`entry` = 2970);
        UPDATE `applied_item_updates` SET `entry` = 2970, `version` = 3494 WHERE (`entry` = 2970);
        -- Cavalier's Boots
        -- required_level, from 8 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 860);
        UPDATE `applied_item_updates` SET `entry` = 860, `version` = 3494 WHERE (`entry` = 860);
        -- Rugged Spaulders
        -- armor, from 7 to 24
        UPDATE `item_template` SET `armor` = 24 WHERE (`entry` = 5254);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5254, 3494);
        -- Veteran Leggings
        -- buy_price, from 2749 to 3162
        -- sell_price, from 549 to 632
        -- item_level, from 17 to 18
        -- required_level, from 12 to 8
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 3162, `sell_price` = 632, `item_level` = 18, `required_level` = 8, `stat_value1` = 4 WHERE (`entry` = 2978);
        UPDATE `applied_item_updates` SET `entry` = 2978, `version` = 3494 WHERE (`entry` = 2978);
        -- Fine Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 2308);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2308, 3494);
        -- Warrior's Girdle
        -- buy_price, from 282 to 442
        -- sell_price, from 56 to 88
        -- item_level, from 11 to 13
        -- required_level, from 6 to 3
        UPDATE `item_template` SET `buy_price` = 442, `sell_price` = 88, `item_level` = 13, `required_level` = 3 WHERE (`entry` = 4659);
        UPDATE `applied_item_updates` SET `entry` = 4659, `version` = 3494 WHERE (`entry` = 4659);
        -- Infantry Bracers
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 6507);
        UPDATE `applied_item_updates` SET `entry` = 6507, `version` = 3494 WHERE (`entry` = 6507);
        -- Soldier's Buckler
        -- name, from Bard's Buckler to Soldier's Buckler
        -- buy_price, from 2168 to 2017
        -- sell_price, from 433 to 403
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `name` = 'Soldier\'s Buckler', `buy_price` = 2017, `sell_price` = 403, `required_level` = 6 WHERE (`entry` = 6559);
        UPDATE `applied_item_updates` SET `entry` = 6559, `version` = 3494 WHERE (`entry` = 6559);
        -- Warrior's Gloves
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2968);
        UPDATE `applied_item_updates` SET `entry` = 2968, `version` = 3494 WHERE (`entry` = 2968);
        -- Ivy-weave Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2326);
        UPDATE `applied_item_updates` SET `entry` = 2326, `version` = 3494 WHERE (`entry` = 2326);
        -- Magister's Cloak
        -- required_level, from 10 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 4683);
        UPDATE `applied_item_updates` SET `entry` = 4683, `version` = 3494 WHERE (`entry` = 4683);
        -- Compact Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1009);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1009, 3494);
        -- Seer's Pants
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 3 WHERE (`entry` = 2982);
        UPDATE `applied_item_updates` SET `entry` = 2982, `version` = 3494 WHERE (`entry` = 2982);
        -- Emberstone Staff
        -- dmg_min1, from 30.0 to 43
        -- dmg_max1, from 46.0 to 59
        UPDATE `item_template` SET `dmg_min1` = 43, `dmg_max1` = 59 WHERE (`entry` = 5201);
        UPDATE `applied_item_updates` SET `entry` = 5201, `version` = 3494 WHERE (`entry` = 5201);
        -- Defender Leggings
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 6578);
        UPDATE `applied_item_updates` SET `entry` = 6578, `version` = 3494 WHERE (`entry` = 6578);
        -- Bard's Gloves
        -- buy_price, from 1145 to 1317
        -- sell_price, from 229 to 263
        -- item_level, from 17 to 18
        -- required_level, from 12 to 8
        UPDATE `item_template` SET `buy_price` = 1317, `sell_price` = 263, `item_level` = 18, `required_level` = 8 WHERE (`entry` = 6554);
        UPDATE `applied_item_updates` SET `entry` = 6554, `version` = 3494 WHERE (`entry` = 6554);
        -- Stone Buckler
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2900);
        UPDATE `applied_item_updates` SET `entry` = 2900, `version` = 3494 WHERE (`entry` = 2900);
        -- Moss-covered Gauntlets
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 5589);
        UPDATE `applied_item_updates` SET `entry` = 5589, `version` = 3494 WHERE (`entry` = 5589);
        -- Defender Axe
        -- required_level, from 8 to 3
        -- dmg_min1, from 9.0 to 20
        -- dmg_max1, from 18.0 to 31
        UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 5459);
        UPDATE `applied_item_updates` SET `entry` = 5459, `version` = 3494 WHERE (`entry` = 5459);
        -- Hillman's Shoulders
        -- required_level, from 21 to 16
        UPDATE `item_template` SET `required_level` = 16 WHERE (`entry` = 4251);
        UPDATE `applied_item_updates` SET `entry` = 4251, `version` = 3494 WHERE (`entry` = 4251);
        -- Inscribed Leather Gloves
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2 WHERE (`entry` = 2988);
        UPDATE `applied_item_updates` SET `entry` = 2988, `version` = 3494 WHERE (`entry` = 2988);
        -- Webwing Cloak
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 5751);
        UPDATE `applied_item_updates` SET `entry` = 5751, `version` = 3494 WHERE (`entry` = 5751);
        -- Phytoblade
        -- required_level, from 20 to 15
        -- dmg_min1, from 21.0 to 36
        -- dmg_max1, from 41.0 to 55
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 36, `dmg_max1` = 55 WHERE (`entry` = 2263);
        UPDATE `applied_item_updates` SET `entry` = 2263, `version` = 3494 WHERE (`entry` = 2263);
        -- Bone-studded Leather
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 2
        -- stat_value3, from 0 to 30
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 3, `stat_value2` = 2, `stat_value3` = 30 WHERE (`entry` = 3431);
        UPDATE `applied_item_updates` SET `entry` = 3431, `version` = 3494 WHERE (`entry` = 3431);
        -- Mariner Boots
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 2949);
        UPDATE `applied_item_updates` SET `entry` = 2949, `version` = 3494 WHERE (`entry` = 2949);
        -- Owl Bracers
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 4796);
        UPDATE `applied_item_updates` SET `entry` = 4796, `version` = 3494 WHERE (`entry` = 4796);
        -- Toughened Leather Gloves
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `stat_value1` = 3, `stat_value2` = 1 WHERE (`entry` = 4253);
        UPDATE `applied_item_updates` SET `entry` = 4253, `version` = 3494 WHERE (`entry` = 4253);
        -- Long Bayonet
        -- required_level, from 7 to 1
        -- dmg_min1, from 5.0 to 10
        -- dmg_max1, from 10.0 to 16
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 10, `dmg_max1` = 16 WHERE (`entry` = 4840);
        UPDATE `applied_item_updates` SET `entry` = 4840, `version` = 3494 WHERE (`entry` = 4840);
        -- Battleforge Shield
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 6599);
        UPDATE `applied_item_updates` SET `entry` = 6599, `version` = 3494 WHERE (`entry` = 6599);
        -- Daryl's Hunting Rifle
        -- buy_price, from 2977 to 3424
        -- sell_price, from 595 to 684
        -- item_level, from 16 to 17
        -- required_level, from 11 to 7
        -- dmg_min1, from 16.0 to 15
        -- dmg_max1, from 30.0 to 23
        UPDATE `item_template` SET `buy_price` = 3424, `sell_price` = 684, `item_level` = 17, `required_level` = 7, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 2904);
        UPDATE `applied_item_updates` SET `entry` = 2904, `version` = 3494 WHERE (`entry` = 2904);
        -- Willow Bracers
        -- buy_price, from 583 to 535
        -- sell_price, from 116 to 107
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `buy_price` = 535, `sell_price` = 107, `required_level` = 7 WHERE (`entry` = 6543);
        UPDATE `applied_item_updates` SET `entry` = 6543, `version` = 3494 WHERE (`entry` = 6543);
        -- Twilight Wand
        -- name, from Opaque Wand to Twilight Wand
        -- required_level, from 14 to 9
        -- dmg_min1, from 13.0 to 22
        -- dmg_max1, from 24.0 to 34
        -- delay, from 1400 to 2700
        UPDATE `item_template` SET `name` = 'Twilight Wand', `required_level` = 9, `dmg_min1` = 22, `dmg_max1` = 34, `delay` = 2700 WHERE (`entry` = 5207);
        UPDATE `applied_item_updates` SET `entry` = 5207, `version` = 3494 WHERE (`entry` = 5207);
        -- Glinting Scale Breastplate
        -- buy_price, from 9631 to 11654
        -- sell_price, from 1926 to 2330
        -- item_level, from 26 to 28
        -- required_level, from 21 to 18
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 11654, `sell_price` = 2330, `item_level` = 28, `required_level` = 18, `stat_value1` = 3, `stat_type2` = 4, `stat_value2` = 4 WHERE (`entry` = 3049);
        UPDATE `applied_item_updates` SET `entry` = 3049, `version` = 3494 WHERE (`entry` = 3049);
        -- Burnished Chain Leggings
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4 WHERE (`entry` = 2990);
        UPDATE `applied_item_updates` SET `entry` = 2990, `version` = 3494 WHERE (`entry` = 2990);
        -- Weather-worn Boots
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 1173);
        UPDATE `applied_item_updates` SET `entry` = 1173, `version` = 3494 WHERE (`entry` = 1173);
        -- Ashwood Bow
        -- required_level, from 8 to 1
        -- dmg_min1, from 9.0 to 8
        -- dmg_max1, from 17.0 to 12
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 8, `dmg_max1` = 12 WHERE (`entry` = 5596);
        UPDATE `applied_item_updates` SET `entry` = 5596, `version` = 3494 WHERE (`entry` = 5596);
        -- Robes of Antiquity
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 30
        -- stat_value3, from 0 to 30
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 3, `stat_value2` = 30, `stat_value3` = 30 WHERE (`entry` = 5812);
        UPDATE `applied_item_updates` SET `entry` = 5812, `version` = 3494 WHERE (`entry` = 5812);
        -- Staff of Horrors
        -- required_level, from 18 to 13
        -- dmg_min1, from 37.0 to 49
        -- dmg_max1, from 56.0 to 68
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 49, `dmg_max1` = 68 WHERE (`entry` = 880);
        UPDATE `applied_item_updates` SET `entry` = 880, `version` = 3494 WHERE (`entry` = 880);
        -- Pioneer Tunic
        -- quality, from 1 to 2
        -- buy_price, from 449 to 1405
        -- sell_price, from 89 to 281
        -- item_level, from 11 to 14
        -- required_level, from 6 to 4
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 1405, `sell_price` = 281, `item_level` = 14, `required_level` = 4 WHERE (`entry` = 6268);
        UPDATE `applied_item_updates` SET `entry` = 6268, `version` = 3494 WHERE (`entry` = 6268);
        -- Thornblade
        -- required_level, from 15 to 10
        -- dmg_min1, from 9.0 to 18
        -- dmg_max1, from 18.0 to 28
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 18, `dmg_max1` = 28 WHERE (`entry` = 2908);
        UPDATE `applied_item_updates` SET `entry` = 2908, `version` = 3494 WHERE (`entry` = 2908);
        -- Burnished Shield
        -- required_level, from 16 to 11
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 4, `stat_value1` = 2 WHERE (`entry` = 3655);
        UPDATE `applied_item_updates` SET `entry` = 3655, `version` = 3494 WHERE (`entry` = 3655);
        -- Burnt Leather Bracers
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 3200);
        UPDATE `applied_item_updates` SET `entry` = 3200, `version` = 3494 WHERE (`entry` = 3200);
        -- Pruning Knife
        -- required_level, from 6 to 1
        -- dmg_min1, from 4.0 to 8
        -- dmg_max1, from 9.0 to 13
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 5605);
        UPDATE `applied_item_updates` SET `entry` = 5605, `version` = 3494 WHERE (`entry` = 5605);
        -- Thick Cloth Bracers
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 3598);
        UPDATE `applied_item_updates` SET `entry` = 3598, `version` = 3494 WHERE (`entry` = 3598);
        -- Magician Staff
        -- dmg_min1, from 24.0 to 35
        -- dmg_max1, from 36.0 to 48
        UPDATE `item_template` SET `dmg_min1` = 35, `dmg_max1` = 48 WHERE (`entry` = 2030);
        UPDATE `applied_item_updates` SET `entry` = 2030, `version` = 3494 WHERE (`entry` = 2030);
        -- Blood Ring
        -- required_level, from 22 to 17
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 35
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2, `stat_value2` = 35 WHERE (`entry` = 4998);
        UPDATE `applied_item_updates` SET `entry` = 4998, `version` = 3494 WHERE (`entry` = 4998);
        -- Tanned Leather Belt
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 1843);
        UPDATE `applied_item_updates` SET `entry` = 1843, `version` = 3494 WHERE (`entry` = 1843);
        -- Bard's Trousers
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6553);
        UPDATE `applied_item_updates` SET `entry` = 6553, `version` = 3494 WHERE (`entry` = 6553);
        -- Bard's Boots
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 6557);
        UPDATE `applied_item_updates` SET `entry` = 6557, `version` = 3494 WHERE (`entry` = 6557);
        -- Feral Blade
        -- required_level, from 8 to 10
        -- dmg_min1, from 10.0 to 23
        -- dmg_max1, from 20.0 to 35
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 4766);
        UPDATE `applied_item_updates` SET `entry` = 4766, `version` = 3494 WHERE (`entry` = 4766);
        -- Inscribed Leather Bracers
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 3205);
        UPDATE `applied_item_updates` SET `entry` = 3205, `version` = 3494 WHERE (`entry` = 3205);
        -- Scout's Cloak
        -- buy_price, from 430 to 672
        -- sell_price, from 86 to 134
        -- item_level, from 11 to 13
        UPDATE `item_template` SET `buy_price` = 672, `sell_price` = 134, `item_level` = 13 WHERE (`entry` = 5618);
        UPDATE `applied_item_updates` SET `entry` = 5618, `version` = 3494 WHERE (`entry` = 5618);
        -- Feline Mantle
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 3748);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3748, 3494);
        -- Bard's Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6555);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6555, 3494);
        -- Commoner's Sword
        -- name, from Feeble Sword to Commoner's Sword
        -- required_level, from 5 to 1
        -- dmg_min1, from 3.0 to 7
        -- dmg_max1, from 7.0 to 11
        UPDATE `item_template` SET `name` = 'Commoner\'s Sword', `required_level` = 1, `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 1413);
        UPDATE `applied_item_updates` SET `entry` = 1413, `version` = 3494 WHERE (`entry` = 1413);
        -- Frostmane Shortsword
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 2258);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2258, 3494);
        -- Dervish Boots
        -- buy_price, from 6531 to 6639
        -- sell_price, from 1306 to 1327
        -- item_level, from 27 to 28
        -- required_level, from 22 to 18
        UPDATE `item_template` SET `buy_price` = 6639, `sell_price` = 1327, `item_level` = 28, `required_level` = 18 WHERE (`entry` = 6601);
        UPDATE `applied_item_updates` SET `entry` = 6601, `version` = 3494 WHERE (`entry` = 6601);
        -- Dervish Bracers
        -- buy_price, from 3972 to 3657
        -- sell_price, from 794 to 731
        -- required_level, from 21 to 16
        UPDATE `item_template` SET `buy_price` = 3657, `sell_price` = 731, `required_level` = 16 WHERE (`entry` = 6602);
        UPDATE `applied_item_updates` SET `entry` = 6602, `version` = 3494 WHERE (`entry` = 6602);
        -- Stalking Pants
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 6 WHERE (`entry` = 4831);
        UPDATE `applied_item_updates` SET `entry` = 4831, `version` = 3494 WHERE (`entry` = 4831);
        -- Hide of Lupos
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 3018);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3018, 3494);
        -- Magister's Bracers
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 3643);
        UPDATE `applied_item_updates` SET `entry` = 3643, `version` = 3494 WHERE (`entry` = 3643);
        -- Lavishly Jeweled Ring
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 3, `stat_value2` = 2 WHERE (`entry` = 1156);
        UPDATE `applied_item_updates` SET `entry` = 1156, `version` = 3494 WHERE (`entry` = 1156);
        -- Tiny Bronze Key
        -- allowable_class, from 128 to 32767
        UPDATE `item_template` SET `allowable_class` = 32767 WHERE (`entry` = 5517);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5517, 3494);
        -- Tiny Iron Key
        -- allowable_class, from 128 to 32767
        UPDATE `item_template` SET `allowable_class` = 32767 WHERE (`entry` = 5518);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5518, 3494);
        -- Burnt Leather Boots
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2963);
        UPDATE `applied_item_updates` SET `entry` = 2963, `version` = 3494 WHERE (`entry` = 2963);
        -- Magister's Robe
        -- buy_price, from 1355 to 1348
        -- sell_price, from 271 to 269
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 1348, `sell_price` = 269, `required_level` = 5, `stat_type1` = 7, `stat_value1` = 3 WHERE (`entry` = 6528);
        UPDATE `applied_item_updates` SET `entry` = 6528, `version` = 3494 WHERE (`entry` = 6528);
        -- Willow Gloves
        -- buy_price, from 817 to 1081
        -- sell_price, from 163 to 216
        -- item_level, from 16 to 18
        -- required_level, from 11 to 8
        UPDATE `item_template` SET `buy_price` = 1081, `sell_price` = 216, `item_level` = 18, `required_level` = 8 WHERE (`entry` = 6541);
        UPDATE `applied_item_updates` SET `entry` = 6541, `version` = 3494 WHERE (`entry` = 6541);
        -- Willow Cape
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 6542);
        UPDATE `applied_item_updates` SET `entry` = 6542, `version` = 3494 WHERE (`entry` = 6542);
        -- Soldier's Cloak
        -- quality, from 1 to 2
        -- buy_price, from 1219 to 2033
        -- sell_price, from 243 to 406
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 2033, `sell_price` = 406, `required_level` = 7 WHERE (`entry` = 6549);
        UPDATE `applied_item_updates` SET `entry` = 6549, `version` = 3494 WHERE (`entry` = 6549);
        -- Heavy Woolen Gloves
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 4310);
        UPDATE `applied_item_updates` SET `entry` = 4310, `version` = 3494 WHERE (`entry` = 4310);
        -- Militia Buckler
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2249);
        UPDATE `applied_item_updates` SET `entry` = 2249, `version` = 3494 WHERE (`entry` = 2249);
        -- Flanged Mace
        -- required_level, from 4 to 1
        -- dmg_min1, from 4.0 to 10
        -- dmg_max1, from 9.0 to 15
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 10, `dmg_max1` = 15 WHERE (`entry` = 766);
        UPDATE `applied_item_updates` SET `entry` = 766, `version` = 3494 WHERE (`entry` = 766);
        -- Defender Tunic
        -- required_level, from 16 to 11
        UPDATE `item_template` SET `required_level` = 11 WHERE (`entry` = 6580);
        UPDATE `applied_item_updates` SET `entry` = 6580, `version` = 3494 WHERE (`entry` = 6580);
        -- Captain Sander's Sash
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 3344);
        UPDATE `applied_item_updates` SET `entry` = 3344, `version` = 3494 WHERE (`entry` = 3344);
        -- Defender Boots
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 6573);
        UPDATE `applied_item_updates` SET `entry` = 6573, `version` = 3494 WHERE (`entry` = 6573);
        -- Defender Bracers
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6574);
        UPDATE `applied_item_updates` SET `entry` = 6574, `version` = 3494 WHERE (`entry` = 6574);
        -- Veteran Shield
        -- required_level, from 11 to 6
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 6, `stat_type1` = 4, `stat_value1` = 1 WHERE (`entry` = 3651);
        UPDATE `applied_item_updates` SET `entry` = 3651, `version` = 3494 WHERE (`entry` = 3651);
        -- Deviate Scale Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6466);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6466, 3494);
        -- Snapbrook Armor
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 3, `stat_type2` = 7, `stat_value2` = 5 WHERE (`entry` = 5814);
        UPDATE `applied_item_updates` SET `entry` = 5814, `version` = 3494 WHERE (`entry` = 5814);
        -- Hunting Pants
        -- required_level, from 10 to 5
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 5, `stat_value1` = 2 WHERE (`entry` = 2974);
        UPDATE `applied_item_updates` SET `entry` = 2974, `version` = 3494 WHERE (`entry` = 2974);
        -- Hunting Gloves
        -- buy_price, from 859 to 988
        -- sell_price, from 171 to 197
        -- item_level, from 15 to 16
        -- stat_type1, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 988, `sell_price` = 197, `item_level` = 16, `stat_type1` = 3 WHERE (`entry` = 2976);
        UPDATE `applied_item_updates` SET `entry` = 2976, `version` = 3494 WHERE (`entry` = 2976);
        -- Lesser Wizard's Robe
        -- required_level, from 22 to 17
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 6 WHERE (`entry` = 5766);
        UPDATE `applied_item_updates` SET `entry` = 5766, `version` = 3494 WHERE (`entry` = 5766);
        -- Willow Sash
        -- name, from Willow Belt to Willow Sash
        -- quality, from 1 to 2
        -- buy_price, from 560 to 933
        -- sell_price, from 112 to 186
        -- required_level, from 12 to 7
        UPDATE `item_template` SET `name` = 'Willow Sash', `quality` = 2, `buy_price` = 933, `sell_price` = 186, `required_level` = 7 WHERE (`entry` = 6539);
        UPDATE `applied_item_updates` SET `entry` = 6539, `version` = 3494 WHERE (`entry` = 6539);
        -- Pearl-clasped Cloak
        -- required_level, from 13 to 8
        UPDATE `item_template` SET `required_level` = 8 WHERE (`entry` = 5542);
        UPDATE `applied_item_updates` SET `entry` = 5542, `version` = 3494 WHERE (`entry` = 5542);
        -- Ivy Cuffs
        -- buy_price, from 363 to 523
        -- sell_price, from 72 to 104
        -- item_level, from 13 to 15
        -- required_level, from 8 to 5
        UPDATE `item_template` SET `buy_price` = 523, `sell_price` = 104, `item_level` = 15, `required_level` = 5 WHERE (`entry` = 5612);
        UPDATE `applied_item_updates` SET `entry` = 5612, `version` = 3494 WHERE (`entry` = 5612);
        -- Battleforge Armor
        -- required_level, from 21 to 16
        UPDATE `item_template` SET `required_level` = 16 WHERE (`entry` = 6592);
        UPDATE `applied_item_updates` SET `entry` = 6592, `version` = 3494 WHERE (`entry` = 6592);
        -- Inscribed Leather Belt
        -- required_level, from 17 to 12
        -- stat_value1, from 0 to 27
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 27 WHERE (`entry` = 6379);
        UPDATE `applied_item_updates` SET `entry` = 6379, `version` = 3494 WHERE (`entry` = 6379);
        -- Scalemail Gloves
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 718);
        UPDATE `applied_item_updates` SET `entry` = 718, `version` = 3494 WHERE (`entry` = 718);
        -- Blackrock Mace
        -- required_level, from 16 to 11
        -- dmg_min1, from 15.0 to 29
        -- dmg_max1, from 29.0 to 45
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 29, `dmg_max1` = 45 WHERE (`entry` = 1296);
        UPDATE `applied_item_updates` SET `entry` = 1296, `version` = 3494 WHERE (`entry` = 1296);
        -- Mantle of Honor
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 3560);
        UPDATE `applied_item_updates` SET `entry` = 3560, `version` = 3494 WHERE (`entry` = 3560);
        -- Flameweave Belt
        -- required_level, from 20 to 15
        -- stat_type1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 5 WHERE (`entry` = 4708);
        UPDATE `applied_item_updates` SET `entry` = 4708, `version` = 3494 WHERE (`entry` = 4708);
        -- Night Watch Pantaloons
        -- required_level, from 28 to 23
        -- stat_value1, from 0 to 7
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 25
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 7, `stat_type2` = 1, `stat_value2` = 25 WHERE (`entry` = 2954);
        UPDATE `applied_item_updates` SET `entry` = 2954, `version` = 3494 WHERE (`entry` = 2954);
        -- Frostweave Bracers
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 25
        -- stat_value2, from 0 to 25
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 25, `stat_value2` = 25 WHERE (`entry` = 4036);
        UPDATE `applied_item_updates` SET `entry` = 4036, `version` = 3494 WHERE (`entry` = 4036);
        -- Sage's Gloves
        -- buy_price, from 2742 to 2589
        -- sell_price, from 548 to 517
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `buy_price` = 2589, `sell_price` = 517, `required_level` = 15 WHERE (`entry` = 6615);
        UPDATE `applied_item_updates` SET `entry` = 6615, `version` = 3494 WHERE (`entry` = 6615);
        -- Consecrated Wand
        -- required_level, from 25 to 20
        -- dmg_min1, from 18.0 to 28
        -- dmg_max1, from 34.0 to 42
        -- delay, from 1200 to 2500
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 28, `dmg_max1` = 42, `delay` = 2500 WHERE (`entry` = 5244);
        UPDATE `applied_item_updates` SET `entry` = 5244, `version` = 3494 WHERE (`entry` = 5244);
        -- Handstitched Leather Pants
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2303);
        UPDATE `applied_item_updates` SET `entry` = 2303, `version` = 3494 WHERE (`entry` = 2303);
        -- Ring of Forlorn Spirits
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 5 WHERE (`entry` = 2043);
        UPDATE `applied_item_updates` SET `entry` = 2043, `version` = 3494 WHERE (`entry` = 2043);
        -- Cloak of the Faith
        -- required_level, from 25 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 2902);
        UPDATE `applied_item_updates` SET `entry` = 2902, `version` = 3494 WHERE (`entry` = 2902);
        -- Gold Militia Boots
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 3 WHERE (`entry` = 2910);
        UPDATE `applied_item_updates` SET `entry` = 2910, `version` = 3494 WHERE (`entry` = 2910);
        -- Bridgeworker's Gloves
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2 WHERE (`entry` = 1303);
        UPDATE `applied_item_updates` SET `entry` = 1303, `version` = 3494 WHERE (`entry` = 1303);
        -- Crest of Darkshire
        -- buy_price, from 23986 to 22081
        -- sell_price, from 4797 to 4416
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 22081, `sell_price` = 4416, `required_level` = 25, `stat_value1` = 5 WHERE (`entry` = 6223);
        UPDATE `applied_item_updates` SET `entry` = 6223, `version` = 3494 WHERE (`entry` = 6223);
        -- Dread Mage Hat
        -- required_level, from 25 to 20
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 7
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 5, `stat_value1` = 7 WHERE (`entry` = 3556);
        UPDATE `applied_item_updates` SET `entry` = 3556, `version` = 3494 WHERE (`entry` = 3556);
        -- Swampland Trousers
        -- required_level, from 26 to 21
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 6 WHERE (`entry` = 4505);
        UPDATE `applied_item_updates` SET `entry` = 4505, `version` = 3494 WHERE (`entry` = 4505);
        -- Spidersilk Boots
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `stat_value1` = 3, `stat_value2` = 3, `bonding` = 2 WHERE (`entry` = 4320);
        UPDATE `applied_item_updates` SET `entry` = 4320, `version` = 3494 WHERE (`entry` = 4320);
        -- Darkweave Gloves
        -- required_level, from 31 to 26
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 5 WHERE (`entry` = 4040);
        UPDATE `applied_item_updates` SET `entry` = 4040, `version` = 3494 WHERE (`entry` = 4040);
        -- Journeyman's Robe
        -- buy_price, from 608 to 598
        -- sell_price, from 121 to 119
        -- required_level, from 6 to 1
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `buy_price` = 598, `sell_price` = 119, `required_level` = 1, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 6511);
        UPDATE `applied_item_updates` SET `entry` = 6511, `version` = 3494 WHERE (`entry` = 6511);
        -- Magister's Shoes
        -- name, from Magister's Boots to Magister's Shoes
        -- required_level, from 10 to 5
        UPDATE `item_template` SET `name` = 'Magister\'s Shoes', `required_level` = 5 WHERE (`entry` = 2971);
        UPDATE `applied_item_updates` SET `entry` = 2971, `version` = 3494 WHERE (`entry` = 2971);
        -- Gustweald Cloak
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 5610);
        UPDATE `applied_item_updates` SET `entry` = 5610, `version` = 3494 WHERE (`entry` = 5610);
        -- Soldier Cap
        -- required_level, from 28 to 23
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 4, `stat_value2` = 5 WHERE (`entry` = 1282);
        UPDATE `applied_item_updates` SET `entry` = 1282, `version` = 3494 WHERE (`entry` = 1282);
        -- Mail Combat Armor
        -- required_level, from 30 to 25
        -- stat_value3, from 0 to 5
        UPDATE `item_template` SET `required_level` = 25, `stat_value3` = 5 WHERE (`entry` = 4074);
        UPDATE `applied_item_updates` SET `entry` = 4074, `version` = 3494 WHERE (`entry` = 4074);
        -- Green Iron Leggings
        -- required_level, from 26 to 21
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 4 WHERE (`entry` = 3842);
        UPDATE `applied_item_updates` SET `entry` = 3842, `version` = 3494 WHERE (`entry` = 3842);
        -- Trouncing Boots
        -- required_level, from 27 to 22
        -- stat_value1, from 0 to 2
        -- stat_value3, from 0 to 27
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 2, `stat_value3` = 27 WHERE (`entry` = 4464);
        UPDATE `applied_item_updates` SET `entry` = 4464, `version` = 3494 WHERE (`entry` = 4464);
        -- Burnished Chain Bracers
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 3211);
        UPDATE `applied_item_updates` SET `entry` = 3211, `version` = 3494 WHERE (`entry` = 3211);
        -- Green Iron Gauntlets
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 4 WHERE (`entry` = 3485);
        UPDATE `applied_item_updates` SET `entry` = 3485, `version` = 3494 WHERE (`entry` = 3485);
        -- Jade Serpentblade
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 3
        -- dmg_min1, from 30.0 to 47
        -- dmg_max1, from 57.0 to 71
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3, `dmg_min1` = 47, `dmg_max1` = 71 WHERE (`entry` = 3850);
        UPDATE `applied_item_updates` SET `entry` = 3850, `version` = 3494 WHERE (`entry` = 3850);
        -- Battleforge Pauldrons
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 6597);
        UPDATE `applied_item_updates` SET `entry` = 6597, `version` = 3494 WHERE (`entry` = 6597);
        -- Glinting Scale Girdle
        -- required_level, from 22 to 17
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2 WHERE (`entry` = 4707);
        UPDATE `applied_item_updates` SET `entry` = 4707, `version` = 3494 WHERE (`entry` = 4707);
        -- Glinting Scale Cloak
        -- buy_price, from 6615 to 8004
        -- sell_price, from 1323 to 1600
        -- item_level, from 26 to 28
        -- required_level, from 21 to 18
        -- stat_value2, from 0 to 20
        UPDATE `item_template` SET `buy_price` = 8004, `sell_price` = 1600, `item_level` = 28, `required_level` = 18, `stat_value2` = 20 WHERE (`entry` = 4706);
        UPDATE `applied_item_updates` SET `entry` = 4706, `version` = 3494 WHERE (`entry` = 4706);
        -- Raw Brilliant Smallfish
        -- buy_price, from 20 to 25
        UPDATE `item_template` SET `buy_price` = 25 WHERE (`entry` = 6291);
        UPDATE `applied_item_updates` SET `entry` = 6291, `version` = 3494 WHERE (`entry` = 6291);
        -- Sage's Mantle
        -- buy_price, from 4682 to 5664
        -- sell_price, from 936 to 1132
        -- item_level, from 26 to 28
        -- required_level, from 21 to 18
        UPDATE `item_template` SET `buy_price` = 5664, `sell_price` = 1132, `item_level` = 28, `required_level` = 18 WHERE (`entry` = 6617);
        UPDATE `applied_item_updates` SET `entry` = 6617, `version` = 3494 WHERE (`entry` = 6617);
        -- Wispy Silk Boots
        -- name, from Azure Silk Vest to Wispy Silk Boots
        -- buy_price, from 9373 to 7030
        -- sell_price, from 1874 to 1406
        -- inventory_type, from 5 to 8
        -- required_level, from 25 to 20
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `name` = 'Wispy Silk Boots', `buy_price` = 7030, `sell_price` = 1406, `inventory_type` = 8, `required_level` = 20, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 4324);
        UPDATE `applied_item_updates` SET `entry` = 4324, `version` = 3494 WHERE (`entry` = 4324);
        -- Scouting Tunic
        -- buy_price, from 4908 to 4486
        -- sell_price, from 981 to 897
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `buy_price` = 4486, `sell_price` = 897, `required_level` = 12 WHERE (`entry` = 6584);
        UPDATE `applied_item_updates` SET `entry` = 6584, `version` = 3494 WHERE (`entry` = 6584);
        -- Scouting Cloak
        -- buy_price, from 3212 to 2926
        -- sell_price, from 642 to 585
        -- required_level, from 16 to 11
        UPDATE `item_template` SET `buy_price` = 2926, `sell_price` = 585, `required_level` = 11 WHERE (`entry` = 6585);
        UPDATE `applied_item_updates` SET `entry` = 6585, `version` = 3494 WHERE (`entry` = 6585);
        -- Daryl's Shortsword
        -- display_id, from 5151 to 8277
        UPDATE `item_template` SET `display_id` = 8277 WHERE (`entry` = 3572);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3572, 3494);
        -- Sharp-edged Stiletto
        -- dmg_min1, from 12.0 to 18
        -- dmg_max1, from 23.0 to 28
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 28 WHERE (`entry` = 2209);
        UPDATE `applied_item_updates` SET `entry` = 2209, `version` = 3494 WHERE (`entry` = 2209);
        -- Fighter Broadsword
        -- dmg_min1, from 11.0 to 23
        -- dmg_max1, from 22.0 to 35
        UPDATE `item_template` SET `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 2027);
        UPDATE `applied_item_updates` SET `entry` = 2027, `version` = 3494 WHERE (`entry` = 2027);
        -- Beastwalker Robe
        -- required_level, from 29 to 24
        -- stat_value2, from 0 to 6
        -- stat_value3, from 0 to 4
        UPDATE `item_template` SET `required_level` = 24, `stat_value2` = 6, `stat_value3` = 4 WHERE (`entry` = 4476);
        UPDATE `applied_item_updates` SET `entry` = 4476, `version` = 3494 WHERE (`entry` = 4476);
        -- Inscribed Leather Spaulders
        -- buy_price, from 2184 to 2468
        -- sell_price, from 436 to 493
        -- item_level, from 22 to 23
        -- required_level, from 17 to 13
        UPDATE `item_template` SET `buy_price` = 2468, `sell_price` = 493, `item_level` = 23, `required_level` = 13 WHERE (`entry` = 4700);
        UPDATE `applied_item_updates` SET `entry` = 4700, `version` = 3494 WHERE (`entry` = 4700);
        -- Sturdy Leather Bracers
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 2327);
        UPDATE `applied_item_updates` SET `entry` = 2327, `version` = 3494 WHERE (`entry` = 2327);
        -- Agammagan's Clutch
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6693);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6693, 3494);
        -- Dwarven War Staff
        -- required_level, from 13 to 8
        -- dmg_min1, from 26.0 to 40
        -- dmg_max1, from 40.0 to 55
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 40, `dmg_max1` = 55 WHERE (`entry` = 2077);
        UPDATE `applied_item_updates` SET `entry` = 2077, `version` = 3494 WHERE (`entry` = 2077);
        -- Raptor Hide Belt
        -- required_level, from 28 to 23
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 3 WHERE (`entry` = 4456);
        UPDATE `applied_item_updates` SET `entry` = 4456, `version` = 3494 WHERE (`entry` = 4456);
        -- Silver-plated Shotgun
        -- required_level, from 21 to 16
        -- dmg_min1, from 30.0 to 21
        -- dmg_max1, from 56.0 to 32
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 21, `dmg_max1` = 32 WHERE (`entry` = 4379);
        UPDATE `applied_item_updates` SET `entry` = 4379, `version` = 3494 WHERE (`entry` = 4379);
        -- Burnt Leather Belt
        -- required_level, from 7 to 2
        UPDATE `item_template` SET `required_level` = 2 WHERE (`entry` = 4666);
        UPDATE `applied_item_updates` SET `entry` = 4666, `version` = 3494 WHERE (`entry` = 4666);
        -- Shimmering Gloves
        -- buy_price, from 1713 to 2226
        -- sell_price, from 342 to 445
        -- item_level, from 21 to 23
        -- required_level, from 16 to 13
        UPDATE `item_template` SET `buy_price` = 2226, `sell_price` = 445, `item_level` = 23, `required_level` = 13 WHERE (`entry` = 6565);
        UPDATE `applied_item_updates` SET `entry` = 6565, `version` = 3494 WHERE (`entry` = 6565);
        -- Anvilmar Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2048);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2048, 3494);
        -- Burnished Chain Boots
        -- required_level, from 15 to 10
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 2991);
        UPDATE `applied_item_updates` SET `entry` = 2991, `version` = 3494 WHERE (`entry` = 2991);
        -- Sentry Cloak
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 2, `stat_type2` = 6, `stat_value2` = 2 WHERE (`entry` = 2059);
        UPDATE `applied_item_updates` SET `entry` = 2059, `version` = 3494 WHERE (`entry` = 2059);
        -- Curve-bladed Ripper
        -- dmg_min1, from 18.0 to 28
        -- dmg_max1, from 34.0 to 43
        UPDATE `item_template` SET `dmg_min1` = 28, `dmg_max1` = 43 WHERE (`entry` = 2815);
        UPDATE `applied_item_updates` SET `entry` = 2815, `version` = 3494 WHERE (`entry` = 2815);
        -- Shackled Girdle
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 5592);
        UPDATE `applied_item_updates` SET `entry` = 5592, `version` = 3494 WHERE (`entry` = 5592);
        -- Stygian Bone Amulet
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6695);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6695, 3494);
        -- Ironforge Breastplate
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 4 WHERE (`entry` = 6731);
        UPDATE `applied_item_updates` SET `entry` = 6731, `version` = 3494 WHERE (`entry` = 6731);
        -- Polished Steel Boots
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 3 WHERE (`entry` = 3846);
        UPDATE `applied_item_updates` SET `entry` = 3846, `version` = 3494 WHERE (`entry` = 3846);
        -- Bonefist Gauntlets
        -- required_level, from 27 to 22
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 40
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `stat_value2` = 40 WHERE (`entry` = 4465);
        UPDATE `applied_item_updates` SET `entry` = 4465, `version` = 3494 WHERE (`entry` = 4465);
        -- Inscribed Gold Ring
        -- required_level, from 35 to 30
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 6 WHERE (`entry` = 5010);
        UPDATE `applied_item_updates` SET `entry` = 5010, `version` = 3494 WHERE (`entry` = 5010);
        -- Anvilmar Sledge
        -- dmg_min1, from 7.0 to 13
        -- dmg_max1, from 12.0 to 19
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 19 WHERE (`entry` = 5761);
        UPDATE `applied_item_updates` SET `entry` = 5761, `version` = 3494 WHERE (`entry` = 5761);
        -- Elite Shoulders
        -- required_level, from 25 to 20
        -- stat_value2, from 0 to 24
        UPDATE `item_template` SET `required_level` = 20, `stat_value2` = 24 WHERE (`entry` = 4835);
        UPDATE `applied_item_updates` SET `entry` = 4835, `version` = 3494 WHERE (`entry` = 4835);
        -- Glimmering Mail Leggings
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 7
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 7 WHERE (`entry` = 6386);
        UPDATE `applied_item_updates` SET `entry` = 6386, `version` = 3494 WHERE (`entry` = 6386);
        -- Augmented Chain Boots
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 3 WHERE (`entry` = 2420);
        UPDATE `applied_item_updates` SET `entry` = 2420, `version` = 3494 WHERE (`entry` = 2420);
        -- Bronze Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2848);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2848, 3494);
        -- Orc Crusher
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6093);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6093, 3494);
        -- Stable Boots
        -- armor, from 6 to 22
        UPDATE `item_template` SET `armor` = 22 WHERE (`entry` = 4789);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4789, 3494);
        -- Moonglow Vest
        -- required_level, from 13 to 8
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 4 WHERE (`entry` = 6709);
        UPDATE `applied_item_updates` SET `entry` = 6709, `version` = 3494 WHERE (`entry` = 6709);
        -- Handstitched Leather Belt
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 4237);
        UPDATE `applied_item_updates` SET `entry` = 4237, `version` = 3494 WHERE (`entry` = 4237);
        -- Veteran Bracers
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 3213);
        UPDATE `applied_item_updates` SET `entry` = 3213, `version` = 3494 WHERE (`entry` = 3213);
        -- Chausses of Westfall
        -- buy_price, from 8135 to 7768
        -- sell_price, from 1627 to 1553
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 7768, `sell_price` = 1553, `required_level` = 15, `stat_value1` = 4 WHERE (`entry` = 6087);
        UPDATE `applied_item_updates` SET `entry` = 6087, `version` = 3494 WHERE (`entry` = 6087);
        -- Canvas Pants
        -- armor, from 36 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 1768);
        UPDATE `applied_item_updates` SET `entry` = 1768, `version` = 3494 WHERE (`entry` = 1768);
        -- Pendant of Myzrael
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 7
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 7 WHERE (`entry` = 4614);
        UPDATE `applied_item_updates` SET `entry` = 4614, `version` = 3494 WHERE (`entry` = 4614);
        -- Green Iron Hauberk
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `stat_value1` = 9 WHERE (`entry` = 3844);
        UPDATE `applied_item_updates` SET `entry` = 3844, `version` = 3494 WHERE (`entry` = 3844);
        -- Tigerbane
        -- required_level, from 34 to 29
        -- dmg_min1, from 27.0 to 40
        -- dmg_max1, from 52.0 to 61
        UPDATE `item_template` SET `required_level` = 29, `dmg_min1` = 40, `dmg_max1` = 61 WHERE (`entry` = 1465);
        UPDATE `applied_item_updates` SET `entry` = 1465, `version` = 3494 WHERE (`entry` = 1465);
        -- Doomsayer's Robe
        -- required_level, from 35 to 30
        UPDATE `item_template` SET `required_level` = 30 WHERE (`entry` = 4746);
        UPDATE `applied_item_updates` SET `entry` = 4746, `version` = 3494 WHERE (`entry` = 4746);
        -- Darkweave Cuffs
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 6407);
        UPDATE `applied_item_updates` SET `entry` = 6407, `version` = 3494 WHERE (`entry` = 6407);
        -- Uther's Strength
        -- required_level, from 30 to 25
        UPDATE `item_template` SET `required_level` = 25 WHERE (`entry` = 6757);
        UPDATE `applied_item_updates` SET `entry` = 6757, `version` = 3494 WHERE (`entry` = 6757);
        -- Arclight Spanner
        -- display_id, from 7494 to 10657
        -- sheath, from 3 to 5
        UPDATE `item_template` SET `display_id` = 10657, `sheath` = 5 WHERE (`entry` = 6219);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6219, 3494);
        -- Cookie's Stirring Rod
        -- dmg_min1, from 13.0 to 20
        -- dmg_max1, from 25.0 to 31
        -- delay, from 1300 to 2300
        UPDATE `item_template` SET `dmg_min1` = 20, `dmg_max1` = 31, `delay` = 2300 WHERE (`entry` = 5198);
        UPDATE `applied_item_updates` SET `entry` = 5198, `version` = 3494 WHERE (`entry` = 5198);
        -- Burnished Chain Cloak
        -- required_level, from 15 to 10
        -- stat_type1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 5 WHERE (`entry` = 4695);
        UPDATE `applied_item_updates` SET `entry` = 4695, `version` = 3494 WHERE (`entry` = 4695);
        -- Golden Scale Bracers
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 33
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 33 WHERE (`entry` = 6040);
        UPDATE `applied_item_updates` SET `entry` = 6040, `version` = 3494 WHERE (`entry` = 6040);
        -- Glimmering Mail Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4711);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4711, 3494);
        -- Flameweave Mantle
        -- required_level, from 22 to 17
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2 WHERE (`entry` = 4661);
        UPDATE `applied_item_updates` SET `entry` = 4661, `version` = 3494 WHERE (`entry` = 4661);
        -- Runic Cloth Belt
        -- armor, from 2 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 4687);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4687, 3494);
        -- Hunting Boots
        -- required_level, from 12 to 7
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 2975);
        UPDATE `applied_item_updates` SET `entry` = 2975, `version` = 3494 WHERE (`entry` = 2975);
        -- Scouting Bracers
        -- buy_price, from 1275 to 1520
        -- sell_price, from 255 to 304
        -- item_level, from 21 to 23
        -- required_level, from 16 to 13
        UPDATE `item_template` SET `buy_price` = 1520, `sell_price` = 304, `item_level` = 23, `required_level` = 13 WHERE (`entry` = 6583);
        UPDATE `applied_item_updates` SET `entry` = 6583, `version` = 3494 WHERE (`entry` = 6583);
        -- Panther Hunter Leggings
        -- required_level, from 35 to 30
        -- stat_value1, from 0 to 11
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 11 WHERE (`entry` = 4108);
        UPDATE `applied_item_updates` SET `entry` = 4108, `version` = 3494 WHERE (`entry` = 4108);
        -- Tiger Hunter Gloves
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 5 WHERE (`entry` = 4107);
        UPDATE `applied_item_updates` SET `entry` = 4107, `version` = 3494 WHERE (`entry` = 4107);
        -- Viridian Band
        -- item_level, from 26 to 28
        -- required_level, from 21 to 18
        UPDATE `item_template` SET `item_level` = 28, `required_level` = 18 WHERE (`entry` = 6589);
        UPDATE `applied_item_updates` SET `entry` = 6589, `version` = 3494 WHERE (`entry` = 6589);
        -- Vendetta
        -- display_id, from 6452 to 6476
        UPDATE `item_template` SET `display_id` = 6476 WHERE (`entry` = 776);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (776, 3494);
        -- Enduring Cap
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `stat_value1` = 9 WHERE (`entry` = 3020);
        UPDATE `applied_item_updates` SET `entry` = 3020, `version` = 3494 WHERE (`entry` = 3020);
        -- Dervish Cape
        -- buy_price, from 6601 to 6639
        -- sell_price, from 1320 to 1327
        -- item_level, from 27 to 28
        -- required_level, from 22 to 18
        UPDATE `item_template` SET `buy_price` = 6639, `sell_price` = 1327, `item_level` = 28, `required_level` = 18 WHERE (`entry` = 6604);
        UPDATE `applied_item_updates` SET `entry` = 6604, `version` = 3494 WHERE (`entry` = 6604);
        -- Crusader Belt
        -- required_level, from 28 to 23
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 23, `stat_type1` = 4, `stat_value1` = 3 WHERE (`entry` = 3758);
        UPDATE `applied_item_updates` SET `entry` = 3758, `version` = 3494 WHERE (`entry` = 3758);
        -- Golden Scale Leggings
        -- required_level, from 29 to 24
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 3843);
        UPDATE `applied_item_updates` SET `entry` = 3843, `version` = 3494 WHERE (`entry` = 3843);
        -- Mail Combat Cloak
        -- required_level, from 32 to 27
        UPDATE `item_template` SET `required_level` = 27 WHERE (`entry` = 4716);
        UPDATE `applied_item_updates` SET `entry` = 4716, `version` = 3494 WHERE (`entry` = 4716);
        -- Herod's Sceptre
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4122);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4122, 3494);
        -- Shimmering Mantle
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6566);
        UPDATE `applied_item_updates` SET `entry` = 6566, `version` = 3494 WHERE (`entry` = 6566);
        -- Patched Leather Belt
        -- name, from Warped Leather Belt to Patched Leather Belt
        -- required_level, from 9 to 4
        UPDATE `item_template` SET `name` = 'Patched Leather Belt', `required_level` = 4 WHERE (`entry` = 1502);
        UPDATE `applied_item_updates` SET `entry` = 1502, `version` = 3494 WHERE (`entry` = 1502);
        -- Vagabond Leggings
        -- required_level, from 8 to 3
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 3, `stat_type1` = 7, `stat_value1` = 2 WHERE (`entry` = 5617);
        UPDATE `applied_item_updates` SET `entry` = 5617, `version` = 3494 WHERE (`entry` = 5617);
        -- Rain-spotted Cape
        -- required_level, from 6 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 5591);
        UPDATE `applied_item_updates` SET `entry` = 5591, `version` = 3494 WHERE (`entry` = 5591);
        -- Loch Croc Hide Vest
        -- display_id, from 2644 to 10528
        UPDATE `item_template` SET `display_id` = 10528 WHERE (`entry` = 6197);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6197, 3494);
        -- Inscribed Leather Boots
        -- display_id, from 6715 to 11581
        -- required_level, from 15 to 10
        -- stat_type1, from 0 to 3
        UPDATE `item_template` SET `display_id` = 11581, `required_level` = 10, `stat_type1` = 3 WHERE (`entry` = 2987);
        UPDATE `applied_item_updates` SET `entry` = 2987, `version` = 3494 WHERE (`entry` = 2987);
        -- Cured Leather Boots
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 238);
        UPDATE `applied_item_updates` SET `entry` = 238, `version` = 3494 WHERE (`entry` = 238);
        -- Seer's Robe
        -- buy_price, from 3242 to 4213
        -- sell_price, from 648 to 842
        -- item_level, from 21 to 23
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 4213, `sell_price` = 842, `item_level` = 23, `stat_type1` = 5, `stat_value1` = 5 WHERE (`entry` = 2981);
        UPDATE `applied_item_updates` SET `entry` = 2981, `version` = 3494 WHERE (`entry` = 2981);
        -- Corsair's Overshirt
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `stat_type1` = 5, `stat_value1` = 3, `stat_type2` = 6, `stat_value2` = 3 WHERE (`entry` = 5202);
        UPDATE `applied_item_updates` SET `entry` = 5202, `version` = 3494 WHERE (`entry` = 5202);
        -- Blazing Wand
        -- required_level, from 12 to 7
        -- dmg_min1, from 12.0 to 21
        -- dmg_max1, from 24.0 to 33
        -- delay, from 1500 to 2800
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 21, `dmg_max1` = 33, `delay` = 2800 WHERE (`entry` = 5212);
        UPDATE `applied_item_updates` SET `entry` = 5212, `version` = 3494 WHERE (`entry` = 5212);
        -- Tarantula Silk Belt
        -- required_level, from 18 to 13
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 3229);
        UPDATE `applied_item_updates` SET `entry` = 3229, `version` = 3494 WHERE (`entry` = 3229);
        -- Durable Chain Shoulders
        -- buy_price, from 3122 to 2433
        -- sell_price, from 624 to 486
        -- item_level, from 24 to 22
        -- required_level, from 19 to 12
        UPDATE `item_template` SET `buy_price` = 2433, `sell_price` = 486, `item_level` = 22, `required_level` = 12 WHERE (`entry` = 6189);
        UPDATE `applied_item_updates` SET `entry` = 6189, `version` = 3494 WHERE (`entry` = 6189);
        -- Mail Combat Boots
        -- required_level, from 30 to 25
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 25, `stat_type1` = 3, `stat_value1` = 2 WHERE (`entry` = 4076);
        UPDATE `applied_item_updates` SET `entry` = 4076, `version` = 3494 WHERE (`entry` = 4076);
        -- Snake Hoop
        -- required_level, from 26 to 21
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 15
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3, `stat_value2` = 15 WHERE (`entry` = 6750);
        UPDATE `applied_item_updates` SET `entry` = 6750, `version` = 3494 WHERE (`entry` = 6750);
        -- Golden Iron Destroyer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3852);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3852, 3494);
        -- Glowing Green Talisman
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 4, `stat_value2` = 4 WHERE (`entry` = 5002);
        UPDATE `applied_item_updates` SET `entry` = 5002, `version` = 3494 WHERE (`entry` = 5002);
        -- Flameweave Robe
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 6 WHERE (`entry` = 3069);
        UPDATE `applied_item_updates` SET `entry` = 3069, `version` = 3494 WHERE (`entry` = 3069);
        -- Stout Battlehammer
        -- required_level, from 18 to 13
        -- dmg_min1, from 16.0 to 28
        -- dmg_max1, from 30.0 to 43
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 28, `dmg_max1` = 43 WHERE (`entry` = 789);
        UPDATE `applied_item_updates` SET `entry` = 789, `version` = 3494 WHERE (`entry` = 789);
        -- Glimmering Mail Girdle
        -- required_level, from 25 to 20
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 4, `stat_value1` = 2 WHERE (`entry` = 4712);
        UPDATE `applied_item_updates` SET `entry` = 4712, `version` = 3494 WHERE (`entry` = 4712);
        -- Bear Bracers
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 4795);
        UPDATE `applied_item_updates` SET `entry` = 4795, `version` = 3494 WHERE (`entry` = 4795);
        -- Stonemason Trousers
        -- display_id, from 6774 to 6780
        UPDATE `item_template` SET `display_id` = 6780 WHERE (`entry` = 1934);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1934, 3494);
        -- Scouting Boots
        -- buy_price, from 2763 to 2543
        -- sell_price, from 552 to 508
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `buy_price` = 2543, `sell_price` = 508, `required_level` = 10 WHERE (`entry` = 6582);
        UPDATE `applied_item_updates` SET `entry` = 6582, `version` = 3494 WHERE (`entry` = 6582);
        -- Glimmering Mail Chestpiece
        -- buy_price, from 16164 to 17780
        -- sell_price, from 3232 to 3556
        -- item_level, from 32 to 33
        -- required_level, from 27 to 23
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 17780, `sell_price` = 3556, `item_level` = 33, `required_level` = 23, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 4071);
        UPDATE `applied_item_updates` SET `entry` = 4071, `version` = 3494 WHERE (`entry` = 4071);
        -- Totem of Infliction
        -- required_level, from 20 to 15
        -- spellid_1, from 7614 to 767
        UPDATE `item_template` SET `required_level` = 15, `spellid_1` = 767 WHERE (`entry` = 1131);
        UPDATE `applied_item_updates` SET `entry` = 1131, `version` = 3494 WHERE (`entry` = 1131);
        -- Russet Boots
        -- display_id, from 1861 to 3750
        UPDATE `item_template` SET `display_id` = 3750 WHERE (`entry` = 2432);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2432, 3494);
        -- Russet Bracers
        -- display_id, from 3740 to 3896
        UPDATE `item_template` SET `display_id` = 3896 WHERE (`entry` = 3594);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3594, 3494);
        -- Insulated Sage Gloves
        -- required_level, from 28 to 23
        -- stat_value1, from 0 to 45
        -- stat_value2, from 0 to 50
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 45, `stat_value2` = 50 WHERE (`entry` = 3759);
        UPDATE `applied_item_updates` SET `entry` = 3759, `version` = 3494 WHERE (`entry` = 3759);
        -- Ranger Bow
        -- dmg_min1, from 35.0 to 23
        -- dmg_max1, from 67.0 to 35
        UPDATE `item_template` SET `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 3021);
        UPDATE `applied_item_updates` SET `entry` = 3021, `version` = 3494 WHERE (`entry` = 3021);
        -- Insignia Mantle
        -- buy_price, from 16997 to 18357
        -- sell_price, from 3399 to 3671
        -- item_level, from 37 to 38
        -- required_level, from 32 to 28
        UPDATE `item_template` SET `buy_price` = 18357, `sell_price` = 3671, `item_level` = 38, `required_level` = 28 WHERE (`entry` = 4721);
        UPDATE `applied_item_updates` SET `entry` = 4721, `version` = 3494 WHERE (`entry` = 4721);
        -- Insignia Cloak
        -- required_level, from 32 to 27
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 35
        UPDATE `item_template` SET `required_level` = 27, `stat_type2` = 1, `stat_value2` = 35 WHERE (`entry` = 4722);
        UPDATE `applied_item_updates` SET `entry` = 4722, `version` = 3494 WHERE (`entry` = 4722);
        -- Swinetusk Shank
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6691);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6691, 3494);
        -- Deadly Throwing Axe
        -- dmg_min1, from 7.0 to 14
        -- dmg_max1, from 15.0 to 22
        UPDATE `item_template` SET `dmg_min1` = 14, `dmg_max1` = 22 WHERE (`entry` = 3137);
        UPDATE `applied_item_updates` SET `entry` = 3137, `version` = 3494 WHERE (`entry` = 3137);
        -- Staff of Westfall
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 5
        -- dmg_min1, from 36.0 to 46
        -- dmg_max1, from 55.0 to 62
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 5, `dmg_min1` = 46, `dmg_max1` = 62 WHERE (`entry` = 2042);
        UPDATE `applied_item_updates` SET `entry` = 2042, `version` = 3494 WHERE (`entry` = 2042);
        -- Sharp Arrow
        -- dmg_min1, from 5.0 to 4
        -- dmg_max1, from 6.0 to 4
        UPDATE `item_template` SET `dmg_min1` = 4, `dmg_max1` = 4 WHERE (`entry` = 2515);
        UPDATE `applied_item_updates` SET `entry` = 2515, `version` = 3494 WHERE (`entry` = 2515);
        -- Razor Arrow
        -- dmg_min1, from 12.0 to 6
        -- dmg_max1, from 13.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 7 WHERE (`entry` = 3030);
        UPDATE `applied_item_updates` SET `entry` = 3030, `version` = 3494 WHERE (`entry` = 3030);
        -- Heavy Weave Pants
        -- armor, from 4 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 838);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (838, 3494);
        -- Belt of Vindication
        -- required_level, from 22 to 17
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 17, `stat_type2` = 7, `stat_value2` = 1 WHERE (`entry` = 3562);
        UPDATE `applied_item_updates` SET `entry` = 3562, `version` = 3494 WHERE (`entry` = 3562);
        -- Murloc Scale Bracers
        -- required_level, from 33 to 28
        UPDATE `item_template` SET `required_level` = 28 WHERE (`entry` = 5783);
        UPDATE `applied_item_updates` SET `entry` = 5783, `version` = 3494 WHERE (`entry` = 5783);
        -- Cross Dagger
        -- required_level, from 23 to 18
        -- dmg_min1, from 11.0 to 18
        -- dmg_max1, from 22.0 to 28
        UPDATE `item_template` SET `required_level` = 18, `dmg_min1` = 18, `dmg_max1` = 28 WHERE (`entry` = 2819);
        UPDATE `applied_item_updates` SET `entry` = 2819, `version` = 3494 WHERE (`entry` = 2819);
        -- Fine Bastard Sword
        -- dmg_min1, from 23.0 to 32
        -- dmg_max1, from 35.0 to 44
        UPDATE `item_template` SET `dmg_min1` = 32, `dmg_max1` = 44 WHERE (`entry` = 1198);
        UPDATE `applied_item_updates` SET `entry` = 1198, `version` = 3494 WHERE (`entry` = 1198);
        -- Chopping Axe
        -- dmg_min1, from 11.0 to 22
        -- dmg_max1, from 20.0 to 34
        UPDATE `item_template` SET `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 853);
        UPDATE `applied_item_updates` SET `entry` = 853, `version` = 3494 WHERE (`entry` = 853);
        -- Giant Club
        -- dmg_min1, from 22.0 to 35
        -- dmg_max1, from 34.0 to 48
        UPDATE `item_template` SET `dmg_min1` = 35, `dmg_max1` = 48 WHERE (`entry` = 1197);
        UPDATE `applied_item_updates` SET `entry` = 1197, `version` = 3494 WHERE (`entry` = 1197);
        -- Mercenary Blade
        -- dmg_min1, from 19.0 to 28
        -- dmg_max1, from 37.0 to 43
        UPDATE `item_template` SET `dmg_min1` = 28, `dmg_max1` = 43 WHERE (`entry` = 923);
        UPDATE `applied_item_updates` SET `entry` = 923, `version` = 3494 WHERE (`entry` = 923);
        -- Gleaming Bastard Sword
        -- dmg_min1, from 39.0 to 44
        -- dmg_max1, from 60.0 to 61
        UPDATE `item_template` SET `dmg_min1` = 44, `dmg_max1` = 61 WHERE (`entry` = 922);
        UPDATE `applied_item_updates` SET `entry` = 922, `version` = 3494 WHERE (`entry` = 922);
        -- Hacking Cleaver
        -- dmg_min1, from 19.0 to 29
        -- dmg_max1, from 36.0 to 44
        UPDATE `item_template` SET `dmg_min1` = 29, `dmg_max1` = 44 WHERE (`entry` = 927);
        UPDATE `applied_item_updates` SET `entry` = 927, `version` = 3494 WHERE (`entry` = 927);
        -- Massive Battle Axe
        -- dmg_min1, from 46.0 to 53
        -- dmg_max1, from 70.0 to 72
        UPDATE `item_template` SET `dmg_min1` = 53, `dmg_max1` = 72 WHERE (`entry` = 926);
        UPDATE `applied_item_updates` SET `entry` = 926, `version` = 3494 WHERE (`entry` = 926);
        -- Spiked Star
        -- display_id, from 4351 to 5199
        -- material, from 2 to 1
        UPDATE `item_template` SET `display_id` = 5199, `material` = 1 WHERE (`entry` = 925);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (925, 3494);
        -- Forest Leather Cloak
        -- buy_price, from 5724 to 6927
        -- sell_price, from 1144 to 1385
        -- item_level, from 26 to 28
        -- required_level, from 21 to 18
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 25
        UPDATE `item_template` SET `buy_price` = 6927, `sell_price` = 1385, `item_level` = 28, `required_level` = 18, `stat_type1` = 7, `stat_value1` = 1, `stat_value2` = 25 WHERE (`entry` = 4710);
        UPDATE `applied_item_updates` SET `entry` = 4710, `version` = 3494 WHERE (`entry` = 4710);
        -- Polished Zweihander
        -- dmg_min1, from 29.0 to 36
        -- dmg_max1, from 44.0 to 49
        UPDATE `item_template` SET `dmg_min1` = 36, `dmg_max1` = 49 WHERE (`entry` = 2024);
        UPDATE `applied_item_updates` SET `entry` = 2024, `version` = 3494 WHERE (`entry` = 2024);
        -- Sharp Cleaver
        -- dmg_min1, from 14.0 to 23
        -- dmg_max1, from 26.0 to 35
        UPDATE `item_template` SET `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 2029);
        UPDATE `applied_item_updates` SET `entry` = 2029, `version` = 3494 WHERE (`entry` = 2029);
        -- Giant Axe
        -- dmg_min1, from 31.0 to 40
        -- dmg_max1, from 47.0 to 55
        UPDATE `item_template` SET `dmg_min1` = 40, `dmg_max1` = 55 WHERE (`entry` = 2025);
        UPDATE `applied_item_updates` SET `entry` = 2025, `version` = 3494 WHERE (`entry` = 2025);
        -- Heavy Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2028);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2028, 3494);
        -- Enormous Rock Hammer
        -- dmg_min1, from 32.0 to 46
        -- dmg_max1, from 49.0 to 63
        UPDATE `item_template` SET `dmg_min1` = 46, `dmg_max1` = 63 WHERE (`entry` = 2026);
        UPDATE `applied_item_updates` SET `entry` = 2026, `version` = 3494 WHERE (`entry` = 2026);
        -- Honed Dagger
        -- dmg_min1, from 7.0 to 13
        -- dmg_max1, from 15.0 to 20
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 2208);
        UPDATE `applied_item_updates` SET `entry` = 2208, `version` = 3494 WHERE (`entry` = 2208);
        -- Silver Defias Belt
        -- required_level, from 10 to 5
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 5, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 832);
        UPDATE `applied_item_updates` SET `entry` = 832, `version` = 3494 WHERE (`entry` = 832);
        -- Haggard's Sword
        -- required_level, from 10 to 5
        -- dmg_min1, from 9.0 to 20
        -- dmg_max1, from 18.0 to 30
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 20, `dmg_max1` = 30 WHERE (`entry` = 6985);
        UPDATE `applied_item_updates` SET `entry` = 6985, `version` = 3494 WHERE (`entry` = 6985);
        -- Leaden Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 865);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (865, 3494);
        -- Necromancer Leggings
        -- buy_price, from 10219 to 9290
        -- sell_price, from 2043 to 1858
        -- item_level, from 29 to 28
        -- required_level, from 19 to 18
        -- stat_value2, from 0 to 6
        UPDATE `item_template` SET `buy_price` = 9290, `sell_price` = 1858, `item_level` = 28, `required_level` = 18, `stat_value2` = 6 WHERE (`entry` = 2277);
        UPDATE `applied_item_updates` SET `entry` = 2277, `version` = 3494 WHERE (`entry` = 2277);
        -- Legionnaire's Leggings
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 2, `stat_type2` = 4, `stat_value2` = 4 WHERE (`entry` = 4816);
        UPDATE `applied_item_updates` SET `entry` = 4816, `version` = 3494 WHERE (`entry` = 4816);
        -- Brawler Gloves
        -- display_id, from 2368 to 3143
        UPDATE `item_template` SET `display_id` = 3143 WHERE (`entry` = 720);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (720, 3494);
        -- Dervish Belt
        -- buy_price, from 3490 to 3237
        -- sell_price, from 698 to 647
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `buy_price` = 3237, `sell_price` = 647, `required_level` = 15 WHERE (`entry` = 6600);
        UPDATE `applied_item_updates` SET `entry` = 6600, `version` = 3494 WHERE (`entry` = 6600);
        -- Ancient War Sword
        -- required_level, from 27 to 22
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 4
        -- dmg_min1, from 53.0 to 60
        -- dmg_max1, from 80.0 to 82
        UPDATE `item_template` SET `required_level` = 22, `stat_type1` = 6, `stat_value1` = 5, `stat_value2` = 4, `dmg_min1` = 60, `dmg_max1` = 82 WHERE (`entry` = 3209);
        UPDATE `applied_item_updates` SET `entry` = 3209, `version` = 3494 WHERE (`entry` = 3209);
        -- Mail Combat Helm
        -- buy_price, from 19957 to 21554
        -- sell_price, from 3991 to 4310
        -- item_level, from 37 to 38
        -- required_level, from 32 to 28
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `buy_price` = 21554, `sell_price` = 4310, `item_level` = 38, `required_level` = 28, `stat_value1` = 10 WHERE (`entry` = 4077);
        UPDATE `applied_item_updates` SET `entry` = 4077, `version` = 3494 WHERE (`entry` = 4077);
        -- Chief Brigadier Gauntlets
        -- required_level, from 35 to 30
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 3, `stat_value2` = 3 WHERE (`entry` = 1988);
        UPDATE `applied_item_updates` SET `entry` = 1988, `version` = 3494 WHERE (`entry` = 1988);
        -- Emblazoned Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4715);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4715, 3494);
        -- Scouting Gloves
        -- buy_price, from 1690 to 1695
        -- sell_price, from 338 to 339
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `buy_price` = 1695, `sell_price` = 339, `required_level` = 10 WHERE (`entry` = 6586);
        UPDATE `applied_item_updates` SET `entry` = 6586, `version` = 3494 WHERE (`entry` = 6586);
        -- Inscribed Leather Pants
        -- display_id, from 11369 to 11584
        UPDATE `item_template` SET `display_id` = 11584 WHERE (`entry` = 2986);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2986, 3494);
        -- Excavation Rod
        -- required_level, from 25 to 20
        -- dmg_min1, from 29.0 to 38
        -- dmg_max1, from 54.0 to 57
        -- delay, from 1900 to 3400
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 38, `dmg_max1` = 57, `delay` = 3400 WHERE (`entry` = 5246);
        UPDATE `applied_item_updates` SET `entry` = 5246, `version` = 3494 WHERE (`entry` = 5246);
        -- Seer's Mantle
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 4698);
        UPDATE `applied_item_updates` SET `entry` = 4698, `version` = 3494 WHERE (`entry` = 4698);
        -- Block Mallet
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1938);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1938, 3494);
        -- Defender Gauntlets
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 6577);
        UPDATE `applied_item_updates` SET `entry` = 6577, `version` = 3494 WHERE (`entry` = 6577);
        -- Desperado Cape
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 2241);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2241, 3494);
        -- Soldier's Armor
        -- buy_price, from 3379 to 2023
        -- sell_price, from 675 to 404
        -- item_level, from 18 to 15
        UPDATE `item_template` SET `buy_price` = 2023, `sell_price` = 404, `item_level` = 15 WHERE (`entry` = 6545);
        UPDATE `applied_item_updates` SET `entry` = 6545, `version` = 3494 WHERE (`entry` = 6545);
        -- Veteran Girdle
        -- required_level, from 12 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 7, `stat_value1` = 1 WHERE (`entry` = 4678);
        UPDATE `applied_item_updates` SET `entry` = 4678, `version` = 3494 WHERE (`entry` = 4678);
        -- Calico Boots
        -- armor, from 2 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 1495);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1495, 3494);
        -- Stone Gnoll Hammer
        -- required_level, from 6 to 1
        -- dmg_min1, from 6.0 to 11
        -- dmg_max1, from 11.0 to 17
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 781);
        UPDATE `applied_item_updates` SET `entry` = 781, `version` = 3494 WHERE (`entry` = 781);
        -- Dusty Chain Armor
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 6 WHERE (`entry` = 2016);
        UPDATE `applied_item_updates` SET `entry` = 2016, `version` = 3494 WHERE (`entry` = 2016);
        -- Double Link Mail Tunic
        -- stat_value2, from 0 to 9
        UPDATE `item_template` SET `stat_value2` = 9 WHERE (`entry` = 1717);
        UPDATE `applied_item_updates` SET `entry` = 1717, `version` = 3494 WHERE (`entry` = 1717);
        -- Augmented Chain Belt
        -- required_level, from 32 to 27
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 27, `stat_type1` = 4, `stat_value1` = 2 WHERE (`entry` = 2419);
        UPDATE `applied_item_updates` SET `entry` = 2419, `version` = 3494 WHERE (`entry` = 2419);
        -- Dark Runner Boots
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2 WHERE (`entry` = 2232);
        UPDATE `applied_item_updates` SET `entry` = 2232, `version` = 3494 WHERE (`entry` = 2232);
        -- Ring of the Underwood
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `stat_value1` = 5 WHERE (`entry` = 2951);
        UPDATE `applied_item_updates` SET `entry` = 2951, `version` = 3494 WHERE (`entry` = 2951);
        -- Ring of the Shadow
        -- shadow_res, from 5 to 1
        UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 1462);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1462, 3494);
        -- Naraxis' Fang
        -- required_level, from 22 to 17
        -- dmg_min1, from 13.0 to 22
        -- dmg_max1, from 26.0 to 34
        UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 4449);
        UPDATE `applied_item_updates` SET `entry` = 4449, `version` = 3494 WHERE (`entry` = 4449);
        -- Sage's Boots
        -- buy_price, from 4067 to 3883
        -- sell_price, from 813 to 776
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `buy_price` = 3883, `sell_price` = 776, `required_level` = 15 WHERE (`entry` = 6612);
        UPDATE `applied_item_updates` SET `entry` = 6612, `version` = 3494 WHERE (`entry` = 6612);
        -- Knightly Longsword
        -- dmg_min1, from 28.0 to 39
        -- dmg_max1, from 53.0 to 59
        UPDATE `item_template` SET `dmg_min1` = 39, `dmg_max1` = 59 WHERE (`entry` = 2520);
        UPDATE `applied_item_updates` SET `entry` = 2520, `version` = 3494 WHERE (`entry` = 2520);
        -- Noble's Broadsword
        -- dmg_min1, from 39.0 to 56
        -- dmg_max1, from 74.0 to 84
        UPDATE `item_template` SET `dmg_min1` = 56, `dmg_max1` = 84 WHERE (`entry` = 2528);
        UPDATE `applied_item_updates` SET `entry` = 2528, `version` = 3494 WHERE (`entry` = 2528);
        -- Razor Main Gauche
        -- dmg_min1, from 16.0 to 24
        -- dmg_max1, from 31.0 to 37
        UPDATE `item_template` SET `dmg_min1` = 24, `dmg_max1` = 37 WHERE (`entry` = 2526);
        UPDATE `applied_item_updates` SET `entry` = 2526, `version` = 3494 WHERE (`entry` = 2526);
        -- Chestplate of Kor
        -- buy_price, from 7094 to 6874
        -- sell_price, from 1418 to 1374
        -- required_level, from 19 to 14
        -- stat_value1, from 0 to 3
        -- stat_value3, from 0 to 2
        UPDATE `item_template` SET `buy_price` = 6874, `sell_price` = 1374, `required_level` = 14, `stat_value1` = 3, `stat_value3` = 2 WHERE (`entry` = 6721);
        UPDATE `applied_item_updates` SET `entry` = 6721, `version` = 3494 WHERE (`entry` = 6721);
        -- Insignia Armor
        -- buy_price, from 22180 to 23954
        -- sell_price, from 4436 to 4790
        -- item_level, from 37 to 38
        -- required_level, from 32 to 28
        -- stat_value1, from 0 to 7
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 23954, `sell_price` = 4790, `item_level` = 38, `required_level` = 28, `stat_value1` = 7, `stat_value2` = 5 WHERE (`entry` = 4057);
        UPDATE `applied_item_updates` SET `entry` = 4057, `version` = 3494 WHERE (`entry` = 4057);
        -- Keller's Girdle
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 30
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 30 WHERE (`entry` = 2911);
        UPDATE `applied_item_updates` SET `entry` = 2911, `version` = 3494 WHERE (`entry` = 2911);
        -- Worn Mail Vest
        -- armor, from 7 to 26
        UPDATE `item_template` SET `armor` = 26 WHERE (`entry` = 1737);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1737, 3494);
        -- Wolfmaster Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6314);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6314, 3494);
        -- Pioneer Bracers
        -- buy_price, from 180 to 132
        -- sell_price, from 36 to 26
        -- item_level, from 10 to 9
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `buy_price` = 132, `sell_price` = 26, `item_level` = 9, `required_level` = 1 WHERE (`entry` = 6519);
        UPDATE `applied_item_updates` SET `entry` = 6519, `version` = 3494 WHERE (`entry` = 6519);
        -- Curved Dagger
        -- required_level, from 7 to 2
        -- dmg_min1, from 6.0 to 12
        -- dmg_max1, from 12.0 to 19
        UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 2632);
        UPDATE `applied_item_updates` SET `entry` = 2632, `version` = 3494 WHERE (`entry` = 2632);
        -- Death Speaker Robes
        -- buy_price, from 8640 to 8568
        -- sell_price, from 1728 to 1713
        -- required_level, from 25 to 20
        -- stat_value2, from 0 to 3
        -- stat_value3, from 0 to 40
        UPDATE `item_template` SET `buy_price` = 8568, `sell_price` = 1713, `required_level` = 20, `stat_value2` = 3, `stat_value3` = 40 WHERE (`entry` = 6682);
        UPDATE `applied_item_updates` SET `entry` = 6682, `version` = 3494 WHERE (`entry` = 6682);
        -- Flameweave Boots
        -- required_level, from 20 to 15
        -- stat_type1, from 0 to 3
        -- stat_type2, from 0 to 6
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 3, `stat_type2` = 6 WHERE (`entry` = 3065);
        UPDATE `applied_item_updates` SET `entry` = 3065, `version` = 3494 WHERE (`entry` = 3065);
        -- Cursed Eye of Paleth
        -- spellid_1, from 7709 to 2263
        UPDATE `item_template` SET `spellid_1` = 2263 WHERE (`entry` = 2944);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2944, 3494);
        -- Tranquil Ring
        -- required_level, from 28 to 23
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 45
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 3, `stat_value2` = 45 WHERE (`entry` = 2917);
        UPDATE `applied_item_updates` SET `entry` = 2917, `version` = 3494 WHERE (`entry` = 2917);
        -- Archer's Longbow
        -- required_level, from 19 to 14
        -- dmg_min1, from 19.0 to 14
        -- dmg_max1, from 36.0 to 21
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 14, `dmg_max1` = 21 WHERE (`entry` = 3039);
        UPDATE `applied_item_updates` SET `entry` = 3039, `version` = 3494 WHERE (`entry` = 3039);
        -- Death Speaker Sceptre
        -- spellid_1, from 7679 to 2254
        -- spellid_2, from 7708 to 2263
        -- bonding, from 1 to 2
        -- material, from 2 to 1
        UPDATE `item_template` SET `spellid_1` = 2254, `spellid_2` = 2263, `bonding` = 2, `material` = 1 WHERE (`entry` = 2816);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2816, 3494);
        -- Frostweave Sash
        -- required_level, from 26 to 21
        UPDATE `item_template` SET `required_level` = 21 WHERE (`entry` = 4714);
        UPDATE `applied_item_updates` SET `entry` = 4714, `version` = 3494 WHERE (`entry` = 4714);
        -- Baron's Sceptre
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6323);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6323, 3494);
        -- Azora's Will
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 4 WHERE (`entry` = 4999);
        UPDATE `applied_item_updates` SET `entry` = 4999, `version` = 3494 WHERE (`entry` = 4999);
        -- Darkweave Cloak
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3 WHERE (`entry` = 4719);
        UPDATE `applied_item_updates` SET `entry` = 4719, `version` = 3494 WHERE (`entry` = 4719);
        -- Glinting Scale Boots
        -- buy_price, from 6331 to 5602
        -- sell_price, from 1266 to 1120
        -- item_level, from 25 to 24
        -- required_level, from 20 to 14
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `buy_price` = 5602, `sell_price` = 1120, `item_level` = 24, `required_level` = 14, `stat_value1` = 3 WHERE (`entry` = 3045);
        UPDATE `applied_item_updates` SET `entry` = 3045, `version` = 3494 WHERE (`entry` = 3045);
        -- Barkeeper's Cloak
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 5343);
        UPDATE `applied_item_updates` SET `entry` = 5343, `version` = 3494 WHERE (`entry` = 5343);
        -- Furen's Favor
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 6970);
        UPDATE `applied_item_updates` SET `entry` = 6970, `version` = 3494 WHERE (`entry` = 6970);
        -- Deep Fathom Ring
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6463);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6463, 3494);
        -- Wind Spirit Staff
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6689);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6689, 3494);
        -- Emblazoned Pants
        -- buy_price, from 13062 to 14368
        -- sell_price, from 2612 to 2873
        -- item_level, from 32 to 33
        -- required_level, from 27 to 23
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 14368, `sell_price` = 2873, `item_level` = 33, `required_level` = 23, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 4050);
        UPDATE `applied_item_updates` SET `entry` = 4050, `version` = 3494 WHERE (`entry` = 4050);
        -- Shield of the Faith
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 1547);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1547, 3494);
        -- Heart of Agammagan
        -- buy_price, from 21182 to 19571
        -- sell_price, from 4236 to 3914
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `buy_price` = 19571, `sell_price` = 3914, `stat_value1` = 5, `stat_value2` = 5 WHERE (`entry` = 6694);
        UPDATE `applied_item_updates` SET `entry` = 6694, `version` = 3494 WHERE (`entry` = 6694);
        -- Meteor Shard
        -- spellid_1, from 13442 to 2120
        UPDATE `item_template` SET `spellid_1` = 2120 WHERE (`entry` = 6220);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6220, 3494);
        -- Kovork's Rattle
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 5256);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5256, 3494);
        -- Arcane Runed Bracers
        -- required_level, from 34 to 29
        -- stat_value2, from 0 to 35
        UPDATE `item_template` SET `required_level` = 29, `stat_value2` = 35 WHERE (`entry` = 4744);
        UPDATE `applied_item_updates` SET `entry` = 4744, `version` = 3494 WHERE (`entry` = 4744);
        -- BKP 2700 "Enforcer"
        -- dmg_min1, from 27.0 to 19
        -- dmg_max1, from 51.0 to 29
        UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 29 WHERE (`entry` = 3024);
        UPDATE `applied_item_updates` SET `entry` = 3024, `version` = 3494 WHERE (`entry` = 3024);
        -- Gnoll Punisher
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1214);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1214, 3494);
        -- Rough Bronze Boots
        -- display_id, from 6885 to 7003
        UPDATE `item_template` SET `display_id` = 7003 WHERE (`entry` = 6350);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6350, 3494);
        -- Dervish Leggings
        -- buy_price, from 6656 to 6474
        -- sell_price, from 1331 to 1294
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `buy_price` = 6474, `sell_price` = 1294, `required_level` = 15 WHERE (`entry` = 6607);
        UPDATE `applied_item_updates` SET `entry` = 6607, `version` = 3494 WHERE (`entry` = 6607);
        -- Nightscape Belt
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 4828);
        UPDATE `applied_item_updates` SET `entry` = 4828, `version` = 3494 WHERE (`entry` = 4828);
        -- Snakeroot
        -- buy_price, from 80 to 8
        -- sell_price, from 20 to 2
        UPDATE `item_template` SET `buy_price` = 8, `sell_price` = 2 WHERE (`entry` = 2449);
        UPDATE `applied_item_updates` SET `entry` = 2449, `version` = 3494 WHERE (`entry` = 2449);
        -- Phantom Armor
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6642);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6642, 3494);
        -- Emberspark Pendant
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5005);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5005, 3494);
        -- Acrobatic Staff
        -- required_level, from 22 to 17
        -- stat_value2, from 0 to 5
        -- dmg_min1, from 29.0 to 36
        -- dmg_max1, from 44.0 to 49
        UPDATE `item_template` SET `required_level` = 17, `stat_value2` = 5, `dmg_min1` = 36, `dmg_max1` = 49 WHERE (`entry` = 3185);
        UPDATE `applied_item_updates` SET `entry` = 3185, `version` = 3494 WHERE (`entry` = 3185);
        -- Wand of Eventide
        -- required_level, from 27 to 22
        -- dmg_min1, from 21.0 to 30
        -- dmg_max1, from 40.0 to 46
        -- delay, from 1300 to 2600
        UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 30, `dmg_max1` = 46, `delay` = 2600 WHERE (`entry` = 5214);
        UPDATE `applied_item_updates` SET `entry` = 5214, `version` = 3494 WHERE (`entry` = 5214);
        -- Peacebloom
        -- name, from Peacebloom Flower to Peacebloom
        UPDATE `item_template` SET `name` = 'Peacebloom' WHERE (`entry` = 2447);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2447, 3494);
        -- Bard's Belt
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 6558);
        UPDATE `applied_item_updates` SET `entry` = 6558, `version` = 3494 WHERE (`entry` = 6558);
        -- Defender Spaulders
        -- required_level, from 17 to 12
        UPDATE `item_template` SET `required_level` = 12 WHERE (`entry` = 6579);
        UPDATE `applied_item_updates` SET `entry` = 6579, `version` = 3494 WHERE (`entry` = 6579);
        -- Rathorian's Cape
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 5111);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5111, 3494);
        -- Wood Chopper
        -- required_level, from 4 to 1
        -- dmg_min1, from 11.0 to 19
        -- dmg_max1, from 18.0 to 26
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 19, `dmg_max1` = 26 WHERE (`entry` = 3189);
        UPDATE `applied_item_updates` SET `entry` = 3189, `version` = 3494 WHERE (`entry` = 3189);
        -- Forest Leather Breastplate
        -- name, from Forest Leather Chestpiece to Forest Leather Breastplate
        -- display_id, from 9056 to 11579
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `name` = 'Forest Leather Breastplate', `display_id` = 11579, `required_level` = 15, `stat_value1` = 3, `stat_value2` = 3 WHERE (`entry` = 3055);
        UPDATE `applied_item_updates` SET `entry` = 3055, `version` = 3494 WHERE (`entry` = 3055);
        -- Diamond Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2194);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2194, 3494);
        -- Shadowfang
        -- spellid_1, from 13440 to 686
        UPDATE `item_template` SET `spellid_1` = 686 WHERE (`entry` = 1482);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1482, 3494);
        -- Draped Cloak
        -- buy_price, from 36 to 24
        -- sell_price, from 7 to 4
        -- item_level, from 5 to 4
        UPDATE `item_template` SET `buy_price` = 24, `sell_price` = 4, `item_level` = 4 WHERE (`entry` = 5405);
        UPDATE `applied_item_updates` SET `entry` = 5405, `version` = 3494 WHERE (`entry` = 5405);
        -- Tunic of Westfall
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 3, `stat_value2` = 3 WHERE (`entry` = 2041);
        UPDATE `applied_item_updates` SET `entry` = 2041, `version` = 3494 WHERE (`entry` = 2041);
        -- Soft Leather Tunic
        -- required_level, from 7 to 2
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 2, `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 2817);
        UPDATE `applied_item_updates` SET `entry` = 2817, `version` = 3494 WHERE (`entry` = 2817);
        -- Glinting Scale Pants
        -- required_level, from 20 to 15
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 3, `stat_value2` = 3 WHERE (`entry` = 3048);
        UPDATE `applied_item_updates` SET `entry` = 3048, `version` = 3494 WHERE (`entry` = 3048);
        -- Shortsword of Vengeance
        -- dmg_min1, from 22.0 to 39
        -- dmg_max1, from 42.0 to 48
        UPDATE `item_template` SET `dmg_min1` = 39, `dmg_max1` = 48 WHERE (`entry` = 754);
        UPDATE `applied_item_updates` SET `entry` = 754, `version` = 3494 WHERE (`entry` = 754);
        -- Rust-covered Blunderbuss
        -- required_level, from 4 to 1
        -- dmg_min1, from 5.0 to 4
        -- dmg_max1, from 10.0 to 7
        UPDATE `item_template` SET `required_level` = 1, `dmg_min1` = 4, `dmg_max1` = 7 WHERE (`entry` = 2774);
        UPDATE `applied_item_updates` SET `entry` = 2774, `version` = 3494 WHERE (`entry` = 2774);
        -- Witching Stave
        -- spellid_1, from 9412 to 2263
        UPDATE `item_template` SET `spellid_1` = 2263 WHERE (`entry` = 1484);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1484, 3494);
        -- Bard's Tunic
        -- buy_price, from 1720 to 1686
        -- sell_price, from 344 to 337
        -- required_level, from 10 to 5
        UPDATE `item_template` SET `buy_price` = 1686, `sell_price` = 337, `required_level` = 5 WHERE (`entry` = 6552);
        UPDATE `applied_item_updates` SET `entry` = 6552, `version` = 3494 WHERE (`entry` = 6552);
        -- Tiger Band
        -- required_level, from 26 to 21
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 20
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3, `stat_value2` = 20 WHERE (`entry` = 6749);
        UPDATE `applied_item_updates` SET `entry` = 6749, `version` = 3494 WHERE (`entry` = 6749);
        -- Feathered Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 5971);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5971, 3494);
        -- Patched Leather Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 1505);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1505, 3494);
        -- Stonemason Cloak
        -- required_level, from 13 to 8
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 1930);
        UPDATE `applied_item_updates` SET `entry` = 1930, `version` = 3494 WHERE (`entry` = 1930);
        -- Inscribed Leather Breastplate
        -- required_level, from 16 to 11
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 3, `stat_value2` = 2 WHERE (`entry` = 2985);
        UPDATE `applied_item_updates` SET `entry` = 2985, `version` = 3494 WHERE (`entry` = 2985);
        -- Cape of the Crusader
        -- required_level, from 28 to 23
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 23, `stat_type1` = 6, `stat_value1` = 2, `stat_type2` = 7, `stat_value2` = 2 WHERE (`entry` = 4643);
        UPDATE `applied_item_updates` SET `entry` = 4643, `version` = 3494 WHERE (`entry` = 4643);
        -- Brass Collar
        -- description, from Princess - First Prize to "Princess - First Prize"
        UPDATE `item_template` SET `description` = '"Princess - First Prize"' WHERE (`entry` = 1006);
        UPDATE `applied_item_updates` SET `entry` = 1006, `version` = 3494 WHERE (`entry` = 1006);
        -- Glacial Stone
        -- spellid_1, from 20869 to 116
        -- material, from 2 to 1
        UPDATE `item_template` SET `spellid_1` = 116, `material` = 1 WHERE (`entry` = 5815);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5815, 3494);
        -- Priest's Mace
        -- required_level, from 7 to 2
        -- dmg_min1, from 7.0 to 16
        -- dmg_max1, from 15.0 to 24
        UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 16, `dmg_max1` = 24 WHERE (`entry` = 2075);
        UPDATE `applied_item_updates` SET `entry` = 2075, `version` = 3494 WHERE (`entry` = 2075);
        -- Bard's Bracers
        -- buy_price, from 602 to 581
        -- sell_price, from 120 to 116
        -- required_level, from 11 to 6
        UPDATE `item_template` SET `buy_price` = 581, `sell_price` = 116, `required_level` = 6 WHERE (`entry` = 6556);
        UPDATE `applied_item_updates` SET `entry` = 6556, `version` = 3494 WHERE (`entry` = 6556);
        -- Laminated Recurve Bow
        -- dmg_min1, from 15.0 to 13
        -- dmg_max1, from 29.0 to 21
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 21 WHERE (`entry` = 2507);
        UPDATE `applied_item_updates` SET `entry` = 2507, `version` = 3494 WHERE (`entry` = 2507);
        -- Padded Lamellar Boots
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `stat_value1` = 1 WHERE (`entry` = 5320);
        UPDATE `applied_item_updates` SET `entry` = 5320, `version` = 3494 WHERE (`entry` = 5320);
        -- Staff of the Purifier
        -- spellid_1, from 14134 to 370
        UPDATE `item_template` SET `spellid_1` = 370 WHERE (`entry` = 5613);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5613, 3494);
        -- Dark Hooded Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 5257);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5257, 3494);
        -- Frontier Britches
        -- required_level, from 12 to 7
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 7, `stat_value1` = 3 WHERE (`entry` = 1436);
        UPDATE `applied_item_updates` SET `entry` = 1436, `version` = 3494 WHERE (`entry` = 1436);
        -- Feral Bracers
        -- required_level, from 2 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 5419);
        UPDATE `applied_item_updates` SET `entry` = 5419, `version` = 3494 WHERE (`entry` = 5419);
        -- Hornwood Recurve Bow
        -- dmg_min1, from 7.0 to 6
        -- dmg_max1, from 13.0 to 10
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 2506);
        UPDATE `applied_item_updates` SET `entry` = 2506, `version` = 3494 WHERE (`entry` = 2506);
        -- Coppercloth Gloves
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 4767);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4767, 3494);
        -- Weighted Sap
        -- required_level, from 10 to 5
        -- dmg_min1, from 10.0 to 21
        -- dmg_max1, from 19.0 to 32
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 21, `dmg_max1` = 32 WHERE (`entry` = 1926);
        UPDATE `applied_item_updates` SET `entry` = 1926, `version` = 3494 WHERE (`entry` = 1926);
        -- Midnight Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 936);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (936, 3494);
        -- Woodworking Gloves
        -- required_level, from 13 to 8
        -- stat_type1, from 10 to 6
        -- stat_value1, from 10 to 2
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 1945);
        UPDATE `applied_item_updates` SET `entry` = 1945, `version` = 3494 WHERE (`entry` = 1945);
        -- Brown Horse Bridle
        -- allowable_race, from 223 to 415
        UPDATE `item_template` SET `allowable_race` = 415 WHERE (`entry` = 5656);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5656, 3494);
        -- Black Stallion Bridle
        -- allowable_race, from 223 to 415
        UPDATE `item_template` SET `allowable_race` = 415 WHERE (`entry` = 2411);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2411, 3494);
        -- Pinto Bridle
        -- allowable_race, from 223 to 415
        UPDATE `item_template` SET `allowable_race` = 415 WHERE (`entry` = 2414);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2414, 3494);
        -- Gardening Gloves
        -- required_level, from 4 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 5606);
        UPDATE `applied_item_updates` SET `entry` = 5606, `version` = 3494 WHERE (`entry` = 5606);
        -- Thistlewood Staff
        -- dmg_min1, from 7.0 to 13
        -- dmg_max1, from 12.0 to 19
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 19 WHERE (`entry` = 5393);
        UPDATE `applied_item_updates` SET `entry` = 5393, `version` = 3494 WHERE (`entry` = 5393);
        -- Twisted Chanter's Staff
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 25
        -- dmg_min1, from 38.0 to 52
        -- dmg_max1, from 58.0 to 71
        UPDATE `item_template` SET `stat_value1` = 5, `stat_value2` = 25, `dmg_min1` = 52, `dmg_max1` = 71 WHERE (`entry` = 890);
        UPDATE `applied_item_updates` SET `entry` = 890, `version` = 3494 WHERE (`entry` = 890);
        -- Rough Bronze Leggings
        -- display_id, from 4333 to 9391
        UPDATE `item_template` SET `display_id` = 9391 WHERE (`entry` = 2865);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2865, 3494);
        -- Mithril Warhammer
        -- stat_value1, from 0 to 5
        -- dmg_min1, from 29.0 to 45
        -- dmg_max1, from 55.0 to 68
        UPDATE `item_template` SET `stat_value1` = 5, `dmg_min1` = 45, `dmg_max1` = 68 WHERE (`entry` = 1721);
        UPDATE `applied_item_updates` SET `entry` = 1721, `version` = 3494 WHERE (`entry` = 1721);
        -- Stromgarde Cavalry Leggings
        -- required_level, from 32 to 27
        -- stat_value1, from 0 to 3
        -- stat_value3, from 0 to 55
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 3, `stat_value3` = 55 WHERE (`entry` = 4741);
        UPDATE `applied_item_updates` SET `entry` = 4741, `version` = 3494 WHERE (`entry` = 4741);
        -- Wicked Blackjack
        -- required_level, from 12 to 7
        -- dmg_min1, from 11.0 to 23
        -- dmg_max1, from 22.0 to 36
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 23, `dmg_max1` = 36 WHERE (`entry` = 827);
        UPDATE `applied_item_updates` SET `entry` = 827, `version` = 3494 WHERE (`entry` = 827);
        -- Raptor's End
        -- required_level, from 25 to 20
        -- dmg_min1, from 38.0 to 25
        -- dmg_max1, from 71.0 to 38
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 25, `dmg_max1` = 38 WHERE (`entry` = 3493);
        UPDATE `applied_item_updates` SET `entry` = 3493, `version` = 3494 WHERE (`entry` = 3493);
        -- Basilisk Hide Pants
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `stat_value1` = 9 WHERE (`entry` = 1718);
        UPDATE `applied_item_updates` SET `entry` = 1718, `version` = 3494 WHERE (`entry` = 1718);
        -- Black Velvet Robes
        -- stat_value2, from 0 to 5
        UPDATE `item_template` SET `stat_value2` = 5 WHERE (`entry` = 2800);
        UPDATE `applied_item_updates` SET `entry` = 2800, `version` = 3494 WHERE (`entry` = 2800);
        -- Mo'grosh Masher
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2821);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2821, 3494);
        -- Double-barreled Shotgun
        -- dmg_min1, from 24.0 to 18
        -- dmg_max1, from 45.0 to 27
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 2098);
        UPDATE `applied_item_updates` SET `entry` = 2098, `version` = 3494 WHERE (`entry` = 2098);
        -- War Rider Bracers
        -- required_level, from 35 to 30
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 4 WHERE (`entry` = 4745);
        UPDATE `applied_item_updates` SET `entry` = 4745, `version` = 3494 WHERE (`entry` = 4745);
        -- Ryedol's Hammer
        -- required_level, from 31 to 26
        -- dmg_min1, from 31.0 to 47
        -- dmg_max1, from 58.0 to 71
        UPDATE `item_template` SET `required_level` = 26, `dmg_min1` = 47, `dmg_max1` = 71 WHERE (`entry` = 4978);
        UPDATE `applied_item_updates` SET `entry` = 4978, `version` = 3494 WHERE (`entry` = 4978);
        -- Insignia Helm
        -- name, from Insignia Cap to Insignia Helm
        -- required_level, from 31 to 26
        -- stat_value1, from 0 to 3
        -- stat_value3, from 0 to 50
        UPDATE `item_template` SET `name` = 'Insignia Helm', `required_level` = 26, `stat_value1` = 3, `stat_value3` = 50 WHERE (`entry` = 4052);
        UPDATE `applied_item_updates` SET `entry` = 4052, `version` = 3494 WHERE (`entry` = 4052);
        -- Thick-soled Boots
        -- name, from Feet of the Lynx to Thick-soled Boots
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `name` = 'Thick-soled Boots', `stat_value1` = 5 WHERE (`entry` = 1121);
        UPDATE `applied_item_updates` SET `entry` = 1121, `version` = 3494 WHERE (`entry` = 1121);
        -- Fenrus' Hide
        -- buy_price, from 3280 to 3291
        -- sell_price, from 656 to 658
        -- required_level, from 21 to 16
        UPDATE `item_template` SET `buy_price` = 3291, `sell_price` = 658, `required_level` = 16 WHERE (`entry` = 6340);
        UPDATE `applied_item_updates` SET `entry` = 6340, `version` = 3494 WHERE (`entry` = 6340);
        -- Rawhide Gloves
        -- display_id, from 972 to 3848
        UPDATE `item_template` SET `display_id` = 3848 WHERE (`entry` = 1791);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1791, 3494);
        -- Shadow Goggles
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4373);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4373, 3494);
        -- Guardian Buckler
        -- subclass, from 6 to 5
        -- buy_price, from 8320 to 6760
        -- sell_price, from 1664 to 1352
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `subclass` = 5, `buy_price` = 6760, `sell_price` = 1352, `stat_type1` = 3, `stat_value1` = 3 WHERE (`entry` = 4820);
        UPDATE `applied_item_updates` SET `entry` = 4820, `version` = 3494 WHERE (`entry` = 4820);
        -- Thief's Blade
        -- quality, from 2 to 3
        -- buy_price, from 9015 to 10818
        -- sell_price, from 1803 to 2163
        -- dmg_min1, from 11.0 to 22
        -- dmg_max1, from 21.0 to 33
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `quality` = 3, `buy_price` = 10818, `sell_price` = 2163, `dmg_min1` = 22, `dmg_max1` = 33, `bonding` = 2 WHERE (`entry` = 5192);
        UPDATE `applied_item_updates` SET `entry` = 5192, `version` = 3494 WHERE (`entry` = 5192);
        -- Dragonmaw Chain Boots
        -- required_level, from 22 to 17
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 3 WHERE (`entry` = 1955);
        UPDATE `applied_item_updates` SET `entry` = 1955, `version` = 3494 WHERE (`entry` = 1955);
        -- Hillman's Leather Gloves
        -- required_level, from 24 to 19
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 4 WHERE (`entry` = 4247);
        UPDATE `applied_item_updates` SET `entry` = 4247, `version` = 3494 WHERE (`entry` = 4247);
        -- Deepwood Bracers
        -- required_level, from 21 to 16
        UPDATE `item_template` SET `required_level` = 16 WHERE (`entry` = 3204);
        UPDATE `applied_item_updates` SET `entry` = 3204, `version` = 3494 WHERE (`entry` = 3204);
        -- Madwolf Bracers
        -- required_level, from 24 to 19
        UPDATE `item_template` SET `required_level` = 19 WHERE (`entry` = 897);
        UPDATE `applied_item_updates` SET `entry` = 897, `version` = 3494 WHERE (`entry` = 897);
        -- Craftsman's Monocle
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4393);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4393, 3494);
        -- Stinging Viper
        -- dmg_min1, from 19.0 to 36
        -- dmg_max1, from 36.0 to 54
        UPDATE `item_template` SET `dmg_min1` = 36, `dmg_max1` = 54 WHERE (`entry` = 6472);
        UPDATE `applied_item_updates` SET `entry` = 6472, `version` = 3494 WHERE (`entry` = 6472);
        -- Batwing Mantle
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6697);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6697, 3494);
        -- Wicked Spiked Mace
        -- required_level, from 20 to 15
        -- dmg_min1, from 19.0 to 33
        -- dmg_max1, from 36.0 to 50
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 33, `dmg_max1` = 50 WHERE (`entry` = 920);
        UPDATE `applied_item_updates` SET `entry` = 920, `version` = 3494 WHERE (`entry` = 920);
        -- Common Magebloom
        -- name, from Mageroyal to Common Magebloom
        UPDATE `item_template` SET `name` = 'Common Magebloom' WHERE (`entry` = 785);
        UPDATE `applied_item_updates` SET `entry` = 785, `version` = 3494 WHERE (`entry` = 785);
        -- Insignia Boots
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3, `stat_type2` = 7, `stat_value2` = 3 WHERE (`entry` = 4055);
        UPDATE `applied_item_updates` SET `entry` = 4055, `version` = 3494 WHERE (`entry` = 4055);
        -- Ancient Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 4799);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4799, 3494);
        -- Shimmering Silk Robes
        -- required_level, from 18 to 13
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 3 WHERE (`entry` = 2616);
        UPDATE `applied_item_updates` SET `entry` = 2616, `version` = 3494 WHERE (`entry` = 2616);
        -- Padded Cloth Gloves
        -- name, from Padded Gloves to Padded Cloth Gloves
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `name` = 'Padded Cloth Gloves', `required_level` = 17 WHERE (`entry` = 2158);
        UPDATE `applied_item_updates` SET `entry` = 2158, `version` = 3494 WHERE (`entry` = 2158);
        -- Steadfast Cinch
        -- display_id, from 6755 to 8419
        UPDATE `item_template` SET `display_id` = 8419 WHERE (`entry` = 5609);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5609, 3494);
        -- Trogg Club
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 2064);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2064, 3494);
        -- Laced Mail Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 1741);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1741, 3494);
        -- Green Tinted Goggles
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4385);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4385, 3494);
        -- Rod of Sorrow
        -- required_level, from 34 to 29
        -- dmg_min1, from 38.0 to 54
        -- dmg_max1, from 72.0 to 82
        -- delay, from 1900 to 3400
        UPDATE `item_template` SET `required_level` = 29, `dmg_min1` = 54, `dmg_max1` = 82, `delay` = 3400 WHERE (`entry` = 5247);
        UPDATE `applied_item_updates` SET `entry` = 5247, `version` = 3494 WHERE (`entry` = 5247);
        -- Burning War Axe
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 50.0 to 58
        -- dmg_max1, from 75.0 to 79
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 2, `dmg_min1` = 58, `dmg_max1` = 79 WHERE (`entry` = 2299);
        UPDATE `applied_item_updates` SET `entry` = 2299, `version` = 3494 WHERE (`entry` = 2299);
        -- Reinforced Bow
        -- dmg_min1, from 17.0 to 13
        -- dmg_max1, from 32.0 to 21
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 21 WHERE (`entry` = 3026);
        UPDATE `applied_item_updates` SET `entry` = 3026, `version` = 3494 WHERE (`entry` = 3026);
        -- Warm Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4772);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4772, 3494);
        -- Ironwood Maul
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4777);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4777, 3494);
        -- Embossed Leather Gloves
        -- required_level, from 8 to 3
        UPDATE `item_template` SET `required_level` = 3 WHERE (`entry` = 4239);
        UPDATE `applied_item_updates` SET `entry` = 4239, `version` = 3494 WHERE (`entry` = 4239);
        -- Darkwood Fishing Pole
        -- dmg_min1, from 3.0 to 12
        -- dmg_max1, from 7.0 to 15
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 15 WHERE (`entry` = 6366);
        UPDATE `applied_item_updates` SET `entry` = 6366, `version` = 3494 WHERE (`entry` = 6366);
        -- Cuirboulli Bracers
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 2144);
        UPDATE `applied_item_updates` SET `entry` = 2144, `version` = 3494 WHERE (`entry` = 2144);
        -- Rugged Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 2240);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2240, 3494);
        -- Bluegill Sandals
        -- required_level, from 16 to 11
        -- stat_value2, from 0 to 1
        UPDATE `item_template` SET `required_level` = 11, `stat_value2` = 1 WHERE (`entry` = 1560);
        UPDATE `applied_item_updates` SET `entry` = 1560, `version` = 3494 WHERE (`entry` = 1560);
        -- Graystone Bracers
        -- required_level, from 3 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 6061);
        UPDATE `applied_item_updates` SET `entry` = 6061, `version` = 3494 WHERE (`entry` = 6061);
        -- Haggard's Mace
        -- required_level, from 10 to 5
        -- dmg_min1, from 10.0 to 22
        -- dmg_max1, from 20.0 to 33
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 22, `dmg_max1` = 33 WHERE (`entry` = 6983);
        UPDATE `applied_item_updates` SET `entry` = 6983, `version` = 3494 WHERE (`entry` = 6983);
        -- Robes of Arugal
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6324);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6324, 3494);
        -- Polished Jazeraint Armor
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 4
        -- stat_value4, from 0 to 50
        UPDATE `item_template` SET `stat_value1` = 4, `stat_value2` = 4, `stat_value4` = 50 WHERE (`entry` = 1715);
        UPDATE `applied_item_updates` SET `entry` = 1715, `version` = 3494 WHERE (`entry` = 1715);
        -- Chief Brigadier Shield
        -- required_level, from 35 to 30
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 6 WHERE (`entry` = 4068);
        UPDATE `applied_item_updates` SET `entry` = 4068, `version` = 3494 WHERE (`entry` = 4068);
        -- Dusty Mining Gloves
        -- required_level, from 13 to 8
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 8, `stat_value1` = 2 WHERE (`entry` = 2036);
        UPDATE `applied_item_updates` SET `entry` = 2036, `version` = 3494 WHERE (`entry` = 2036);
        -- Heraldic Cloak
        -- required_level, from 28 to 23
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 23, `stat_type1` = 6, `stat_value1` = 3 WHERE (`entry` = 2953);
        UPDATE `applied_item_updates` SET `entry` = 2953, `version` = 3494 WHERE (`entry` = 2953);
        -- Backbreaker
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1990);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1990, 3494);
        -- Forest Leather Boots
        -- required_level, from 21 to 16
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 3 WHERE (`entry` = 3057);
        UPDATE `applied_item_updates` SET `entry` = 3057, `version` = 3494 WHERE (`entry` = 3057);
        -- Eye of Paleth
        -- required_level, from 26 to 21
        -- spellid_1, from 7680 to 2254
        UPDATE `item_template` SET `required_level` = 21, `spellid_1` = 2254 WHERE (`entry` = 2943);
        UPDATE `applied_item_updates` SET `entry` = 2943, `version` = 3494 WHERE (`entry` = 2943);
        -- Quicksilver Ring
        -- required_level, from 31 to 26
        -- stat_value2, from 0 to 3
        UPDATE `item_template` SET `required_level` = 26, `stat_value2` = 3 WHERE (`entry` = 5008);
        UPDATE `applied_item_updates` SET `entry` = 5008, `version` = 3494 WHERE (`entry` = 5008);
        -- Necklace of Calisea
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        -- stat_value3, from 0 to 3
        UPDATE `item_template` SET `stat_value1` = 5, `stat_value2` = 5, `stat_value3` = 3 WHERE (`entry` = 1714);
        UPDATE `applied_item_updates` SET `entry` = 1714, `version` = 3494 WHERE (`entry` = 1714);
        -- Blackened Leather Belt
        -- buy_price, from 21 to 20
        UPDATE `item_template` SET `buy_price` = 20 WHERE (`entry` = 6058);
        UPDATE `applied_item_updates` SET `entry` = 6058, `version` = 3494 WHERE (`entry` = 6058);
        -- Simple Dress
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 6786);
        UPDATE `applied_item_updates` SET `entry` = 6786, `version` = 3494 WHERE (`entry` = 6786);
        -- Brown Linen Vest
        -- armor, from 3 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2568);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2568, 3494);
        -- Pulsating Hydra Heart
        -- spellid_1, from 7687 to 2238
        UPDATE `item_template` SET `spellid_1` = 2238 WHERE (`entry` = 5183);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5183, 3494);
        -- Thornroot Club
        -- required_level, from 8 to 3
        -- dmg_min1, from 8.0 to 18
        -- dmg_max1, from 16.0 to 28
        UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 18, `dmg_max1` = 28 WHERE (`entry` = 5587);
        UPDATE `applied_item_updates` SET `entry` = 5587, `version` = 3494 WHERE (`entry` = 5587);
        -- Tough Leather Shoulderpads
        -- name, from Rawhide Shoulderpads to Tough Leather Shoulderpads
        -- required_level, from 20 to 15
        UPDATE `item_template` SET `name` = 'Tough Leather Shoulderpads', `required_level` = 15 WHERE (`entry` = 1801);
        UPDATE `applied_item_updates` SET `entry` = 1801, `version` = 3494 WHERE (`entry` = 1801);
        -- Vejrek's Head
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6799);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6799, 3494);
        -- Night Watch Shortsword
        -- dmg_min1, from 19.0 to 38
        -- dmg_max1, from 36.0 to 47
        UPDATE `item_template` SET `dmg_min1` = 38, `dmg_max1` = 47 WHERE (`entry` = 935);
        UPDATE `applied_item_updates` SET `entry` = 935, `version` = 3494 WHERE (`entry` = 935);
        -- Recipe: Elixir of Minor Agility
        -- display_id, from 1301 to 6270
        UPDATE `item_template` SET `display_id` = 6270 WHERE (`entry` = 2553);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2553, 3494);
        -- Staff of Conjuring
        -- spellid_1, from 8736 to 587
        UPDATE `item_template` SET `spellid_1` = 587 WHERE (`entry` = 1933);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1933, 3494);
        -- Brackwater Boots
        -- armor, from 9 to 32
        UPDATE `item_template` SET `armor` = 32 WHERE (`entry` = 3302);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3302, 3494);
        -- Face Smasher
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1483);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1483, 3494);
        -- Cape of the Brotherhood
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 5193);
        UPDATE `applied_item_updates` SET `entry` = 5193, `version` = 3494 WHERE (`entry` = 5193);
        -- Nightstalker Bow
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6696);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6696, 3494);
        -- Necrology Robes
        -- shadow_res, from 5 to 1
        UPDATE `item_template` SET `shadow_res` = 1 WHERE (`entry` = 2292);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2292, 3494);
        -- Dwarven Mild
        -- display_id, from 6352 to 6372
        UPDATE `item_template` SET `display_id` = 6372 WHERE (`entry` = 422);
        UPDATE `applied_item_updates` SET `entry` = 422, `version` = 3494 WHERE (`entry` = 422);
        -- Stormwind Brie
        -- buy_price, from 1000 to 1250
        UPDATE `item_template` SET `buy_price` = 1250 WHERE (`entry` = 1707);
        UPDATE `applied_item_updates` SET `entry` = 1707, `version` = 3494 WHERE (`entry` = 1707);
        -- Pronged Reaver
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6692);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6692, 3494);
        -- Strength of Will
        -- required_level, from 25 to 20
        -- stat_value1, from 0 to 4
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 4 WHERE (`entry` = 4837);
        UPDATE `applied_item_updates` SET `entry` = 4837, `version` = 3494 WHERE (`entry` = 4837);
        -- Algae Fists
        -- buy_price, from 5270 to 5266
        -- sell_price, from 1054 to 1053
        -- stat_value2, from 0 to 4
        UPDATE `item_template` SET `buy_price` = 5266, `sell_price` = 1053, `stat_value2` = 4 WHERE (`entry` = 6906);
        UPDATE `applied_item_updates` SET `entry` = 6906, `version` = 3494 WHERE (`entry` = 6906);
        -- Rigid Shoulderpads
        -- required_level, from 15 to 10
        UPDATE `item_template` SET `required_level` = 10 WHERE (`entry` = 5404);
        UPDATE `applied_item_updates` SET `entry` = 5404, `version` = 3494 WHERE (`entry` = 5404);
        -- Forest Leather Pants
        -- required_level, from 19 to 14
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 14, `stat_value1` = 5 WHERE (`entry` = 3056);
        UPDATE `applied_item_updates` SET `entry` = 3056, `version` = 3494 WHERE (`entry` = 3056);
        -- Edged Bastard Sword
        -- required_level, from 13 to 8
        -- dmg_min1, from 25.0 to 39
        -- dmg_max1, from 39.0 to 53
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 39, `dmg_max1` = 53 WHERE (`entry` = 3196);
        UPDATE `applied_item_updates` SET `entry` = 3196, `version` = 3494 WHERE (`entry` = 3196);
        -- Arced War Axe
        -- buy_price, from 19289 to 17070
        -- sell_price, from 3857 to 3414
        -- item_level, from 26 to 25
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 1
        -- dmg_min1, from 46.0 to 50
        -- dmg_max1, from 70.0 to 69
        UPDATE `item_template` SET `buy_price` = 17070, `sell_price` = 3414, `item_level` = 25, `stat_type1` = 7, `stat_value1` = 2, `stat_type2` = 4, `stat_value2` = 1, `dmg_min1` = 50, `dmg_max1` = 69 WHERE (`entry` = 3191);
        UPDATE `applied_item_updates` SET `entry` = 3191, `version` = 3494 WHERE (`entry` = 3191);
        -- Robe of the Magi
        -- spellid_1, from 15714 to 2289
        UPDATE `item_template` SET `spellid_1` = 2289 WHERE (`entry` = 1716);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1716, 3494);
        -- Rod of Molten Fire
        -- fire_res, from 6 to 4
        -- sheath, from 7 to 2
        UPDATE `item_template` SET `fire_res` = 4, `sheath` = 2 WHERE (`entry` = 2565);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2565, 3494);
        -- Archeus
        -- spellid_1, from 18091 to 1004
        UPDATE `item_template` SET `spellid_1` = 1004 WHERE (`entry` = 2000);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2000, 3494);
        -- Mindbender Loop
        -- item_level, from 37 to 38
        -- required_level, from 32 to 28
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `item_level` = 38, `required_level` = 28, `stat_value1` = 3 WHERE (`entry` = 5009);
        UPDATE `applied_item_updates` SET `entry` = 5009, `version` = 3494 WHERE (`entry` = 5009);
        -- Chief Brigadier Cloak
        -- required_level, from 35 to 30
        UPDATE `item_template` SET `required_level` = 30 WHERE (`entry` = 4726);
        UPDATE `applied_item_updates` SET `entry` = 4726, `version` = 3494 WHERE (`entry` = 4726);
        -- Pestilent Wand
        -- dmg_type1, from 3 to 5
        UPDATE `item_template` SET `dmg_type1` = 5 WHERE (`entry` = 5347);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5347, 3494);
        -- Tracking Boots
        -- buy_price, from 59 to 39
        -- sell_price, from 11 to 7
        -- item_level, from 5 to 4
        UPDATE `item_template` SET `buy_price` = 39, `sell_price` = 7, `item_level` = 4 WHERE (`entry` = 5399);
        UPDATE `applied_item_updates` SET `entry` = 5399, `version` = 3494 WHERE (`entry` = 5399);
        -- Cruel Barb
        -- dmg_min1, from 18.0 to 34
        -- dmg_max1, from 35.0 to 52
        UPDATE `item_template` SET `dmg_min1` = 34, `dmg_max1` = 52 WHERE (`entry` = 5191);
        UPDATE `applied_item_updates` SET `entry` = 5191, `version` = 3494 WHERE (`entry` = 5191);
        -- Thistlewood Dagger
        -- dmg_min1, from 2.0 to 6
        -- dmg_max1, from 5.0 to 10
        UPDATE `item_template` SET `dmg_min1` = 6, `dmg_max1` = 10 WHERE (`entry` = 5392);
        UPDATE `applied_item_updates` SET `entry` = 5392, `version` = 3494 WHERE (`entry` = 5392);
        -- Smelting Pants
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2, `stat_type2` = 7, `stat_value2` = 2 WHERE (`entry` = 5199);
        UPDATE `applied_item_updates` SET `entry` = 5199, `version` = 3494 WHERE (`entry` = 5199);
        -- Bouquet of Scarlet Begonias
        -- required_level, from 18 to 13
        UPDATE `item_template` SET `required_level` = 13 WHERE (`entry` = 2562);
        UPDATE `applied_item_updates` SET `entry` = 2562, `version` = 3494 WHERE (`entry` = 2562);
        -- Oak Mallet
        -- required_level, from 8 to 3
        -- dmg_min1, from 22.0 to 36
        -- dmg_max1, from 33.0 to 49
        UPDATE `item_template` SET `required_level` = 3, `dmg_min1` = 36, `dmg_max1` = 49 WHERE (`entry` = 3193);
        UPDATE `applied_item_updates` SET `entry` = 3193, `version` = 3494 WHERE (`entry` = 3193);
        -- Dirtwood Belt
        -- required_level, from 5 to 1
        UPDATE `item_template` SET `required_level` = 1 WHERE (`entry` = 5458);
        UPDATE `applied_item_updates` SET `entry` = 5458, `version` = 3494 WHERE (`entry` = 5458);
        -- Padded Cloth Bracers
        -- display_id, from 3645 to 3895
        UPDATE `item_template` SET `display_id` = 3895 WHERE (`entry` = 3592);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3592, 3494);
        -- Hillman's Cloak
        -- required_level, from 25 to 20
        UPDATE `item_template` SET `required_level` = 20 WHERE (`entry` = 3719);
        UPDATE `applied_item_updates` SET `entry` = 3719, `version` = 3494 WHERE (`entry` = 3719);
        -- Solid Iron Maul
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3851);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3851, 3494);
        -- Spiked Buckler
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 2441);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2441, 3494);
        -- Shadowhide Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1457);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1457, 3494);
        -- Gloomshroud Armor
        -- display_id, from 8676 to 9123
        UPDATE `item_template` SET `display_id` = 9123 WHERE (`entry` = 1489);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1489, 3494);
        -- Headbasher
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1264);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1264, 3494);
        -- Chief Brigadier Bracers
        -- required_level, from 35 to 30
        UPDATE `item_template` SET `required_level` = 30 WHERE (`entry` = 6413);
        UPDATE `applied_item_updates` SET `entry` = 6413, `version` = 3494 WHERE (`entry` = 6413);
        -- Green Leather Armor
        -- required_level, from 26 to 21
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 6
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2, `stat_type2` = 6, `stat_value2` = 6 WHERE (`entry` = 4255);
        UPDATE `applied_item_updates` SET `entry` = 4255, `version` = 3494 WHERE (`entry` = 4255);
        -- Mark of the Kirin Tor
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 9
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 9 WHERE (`entry` = 5004);
        UPDATE `applied_item_updates` SET `entry` = 5004, `version` = 3494 WHERE (`entry` = 5004);
        -- Worn Shortbow
        -- dmg_min1, from 3.0 to 4
        UPDATE `item_template` SET `dmg_min1` = 4 WHERE (`entry` = 2504);
        UPDATE `applied_item_updates` SET `entry` = 2504, `version` = 3494 WHERE (`entry` = 2504);
        -- Archery Training Gloves
        -- buy_price, from 31 to 14
        -- sell_price, from 6 to 2
        -- item_level, from 5 to 3
        UPDATE `item_template` SET `buy_price` = 14, `sell_price` = 2, `item_level` = 3 WHERE (`entry` = 5394);
        UPDATE `applied_item_updates` SET `entry` = 5394, `version` = 3494 WHERE (`entry` = 5394);
        -- Dwarven Tree Chopper
        -- required_level, from 15 to 10
        -- dmg_min1, from 30.0 to 44
        -- dmg_max1, from 46.0 to 60
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 44, `dmg_max1` = 60 WHERE (`entry` = 2907);
        UPDATE `applied_item_updates` SET `entry` = 2907, `version` = 3494 WHERE (`entry` = 2907);
        -- Scroll of Stamina
        -- display_id, from 1093 to 6270
        UPDATE `item_template` SET `display_id` = 6270 WHERE (`entry` = 1180);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1180, 3494);
        -- Small Barnacled Clam
        -- display_id, from 7177 to 8047
        UPDATE `item_template` SET `display_id` = 8047 WHERE (`entry` = 5523);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5523, 3494);
        -- Shadowgem
        -- buy_price, from 1000 to 600
        -- sell_price, from 250 to 150
        UPDATE `item_template` SET `buy_price` = 600, `sell_price` = 150 WHERE (`entry` = 1210);
        UPDATE `applied_item_updates` SET `entry` = 1210, `version` = 3494 WHERE (`entry` = 1210);
        -- Insignia Gloves
        -- required_level, from 30 to 25
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 2, `stat_value2` = 2 WHERE (`entry` = 6408);
        UPDATE `applied_item_updates` SET `entry` = 6408, `version` = 3494 WHERE (`entry` = 6408);
        -- Skeletal Club of Pain
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2256);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2256, 3494);
        -- Red Defias Mask
        -- class, from 4 to 15
        -- buy_price, from 417 to 434
        -- sell_price, from 83 to 86
        -- allowable_class, from 31240 to 32767
        -- item_level, from 15 to 13
        UPDATE `item_template` SET `class` = 15, `buy_price` = 434, `sell_price` = 86, `allowable_class` = 32767, `item_level` = 13 WHERE (`entry` = 5106);
        UPDATE `applied_item_updates` SET `entry` = 5106, `version` = 3494 WHERE (`entry` = 5106);
        -- Rawhide Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 1790);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1790, 3494);
        -- Large Rope Net
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 835);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (835, 3494);
        -- Scroll of Agility
        -- display_id, from 3331 to 6409
        UPDATE `item_template` SET `display_id` = 6409 WHERE (`entry` = 3012);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3012, 3494);
        -- Murloc Scale Belt
        -- material, from 8 to 7
        UPDATE `item_template` SET `material` = 7 WHERE (`entry` = 5780);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5780, 3494);
        -- Icicle Rod
        -- required_level, from 20 to 15
        -- dmg_min1, from 46.0 to 37
        -- dmg_max1, from 69.0 to 50
        -- spellid_1, from 7703 to 2230
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 37, `dmg_max1` = 50, `spellid_1` = 2230 WHERE (`entry` = 2950);
        UPDATE `applied_item_updates` SET `entry` = 2950, `version` = 3494 WHERE (`entry` = 2950);
        -- Hammerfist Gloves
        -- required_level, from 15 to 10
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 2 WHERE (`entry` = 5629);
        UPDATE `applied_item_updates` SET `entry` = 5629, `version` = 3494 WHERE (`entry` = 5629);
        -- Wall Shield
        -- armor, from 9 to 43
        UPDATE `item_template` SET `armor` = 43 WHERE (`entry` = 1202);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1202, 3494);
        -- Ornate Blunderbuss
        -- dmg_min1, from 4.0 to 7
        -- dmg_max1, from 9.0 to 11
        UPDATE `item_template` SET `dmg_min1` = 7, `dmg_max1` = 11 WHERE (`entry` = 2509);
        UPDATE `applied_item_updates` SET `entry` = 2509, `version` = 3494 WHERE (`entry` = 2509);
        -- Mouse Tail
        -- name, from Discolored Fang to Mouse Tail
        UPDATE `item_template` SET `name` = 'Mouse Tail' WHERE (`entry` = 4814);
        UPDATE `applied_item_updates` SET `entry` = 4814, `version` = 3494 WHERE (`entry` = 4814);
        -- Discolored Fang
        -- name, from Small Leather Collar to Discolored Fang
        UPDATE `item_template` SET `name` = 'Discolored Fang' WHERE (`entry` = 4813);
        UPDATE `applied_item_updates` SET `entry` = 4813, `version` = 3494 WHERE (`entry` = 4813);
        -- Runed Copper Rod
        -- description, from  to Used to permanently enchant items.
        UPDATE `item_template` SET `description` = 'Used to permanently enchant items.' WHERE (`entry` = 6218);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6218, 3494);
        -- Butcher's Cleaver
        -- display_id, from 8466 to 10808
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `display_id` = 10808, `bonding` = 2 WHERE (`entry` = 1292);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1292, 3494);
        -- Long Silken Cloak
        -- required_level, from 32 to 27
        UPDATE `item_template` SET `required_level` = 27 WHERE (`entry` = 4326);
        UPDATE `applied_item_updates` SET `entry` = 4326, `version` = 3494 WHERE (`entry` = 4326);
        -- Brackwater Gauntlets
        -- armor, from 7 to 25
        UPDATE `item_template` SET `armor` = 25 WHERE (`entry` = 3304);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3304, 3494);
        -- Minor Rejuvenation Potion
        -- display_id, from 2345 to 2350
        UPDATE `item_template` SET `display_id` = 2350 WHERE (`entry` = 2456);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2456, 3494);
        -- Cracked Bill
        -- buy_price, from 115 to 45
        -- sell_price, from 28 to 11
        UPDATE `item_template` SET `buy_price` = 45, `sell_price` = 11 WHERE (`entry` = 4775);
        UPDATE `applied_item_updates` SET `entry` = 4775, `version` = 3494 WHERE (`entry` = 4775);
        -- Sword of Decay
        -- spellid_1, from 13528 to 6951
        UPDATE `item_template` SET `spellid_1` = 6951 WHERE (`entry` = 1727);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1727, 3494);
        -- Dense Triangle Mace
        -- display_id, from 5228 to 5528
        -- material, from 2 to 1
        UPDATE `item_template` SET `display_id` = 5528, `material` = 1 WHERE (`entry` = 3203);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3203, 3494);
        -- Stonesplinter Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2267);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2267, 3494);
        -- Reinforced Chain Shoulderpads
        -- required_level, from 22 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 1760);
        UPDATE `applied_item_updates` SET `entry` = 1760, `version` = 3494 WHERE (`entry` = 1760);
        -- Miner's Cape
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 5444);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5444, 3494);
        -- 3596
        -- Canopy Leggings
        -- buy_price, from 65 to 43
        -- sell_price, from 13 to 8
        -- item_level, from 5 to 4
        UPDATE `item_template` SET `buy_price` = 43, `sell_price` = 8, `item_level` = 4 WHERE (`entry` = 5398);
        UPDATE `applied_item_updates` SET `entry` = 5398, `version` = 3596 WHERE (`entry` = 5398);
        -- Handcrafted Staff
        -- dmg_min1, from 3.0 to 5
        -- dmg_max1, from 5.0 to 8
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 8 WHERE (`entry` = 3661);
        UPDATE `applied_item_updates` SET `entry` = 3661, `version` = 3596 WHERE (`entry` = 3661);
        -- Cracked Leather Vest
        -- armor, from 11 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 2127);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2127, 3596);
        -- Cracked Leather Pants
        -- armor, from 9 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 2126);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2126, 3596);
        -- Cracked Leather Boots
        -- armor, from 7 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2123);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2123, 3596);
        -- Cracked Leather Bracers
        -- armor, from 5 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2124);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2124, 3596);
        -- Thin Cloth Armor
        -- armor, from 5 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 2121);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2121, 3596);
        -- Thin Cloth Pants
        -- display_id, from 2185 to 9974
        UPDATE `item_template` SET `display_id` = 9974 WHERE (`entry` = 2120);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2120, 3596);
        -- Thin Cloth Shoes
        -- display_id, from 3757 to 4143
        UPDATE `item_template` SET `display_id` = 4143 WHERE (`entry` = 2117);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2117, 3596);
        -- Ruined Pelt
        -- display_id, from 6686 to 7086
        UPDATE `item_template` SET `display_id` = 7086 WHERE (`entry` = 4865);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4865, 3596);
        -- Thin Cloth Belt
        -- armor, from 2 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3599);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3599, 3596);
        -- Tarnished Chain Vest
        -- armor, from 16 to 17
        UPDATE `item_template` SET `armor` = 17 WHERE (`entry` = 2379);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2379, 3596);
        -- Tarnished Chain Leggings
        -- armor, from 14 to 15
        UPDATE `item_template` SET `armor` = 15 WHERE (`entry` = 2381);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2381, 3596);
        -- Tarnished Chain Bracers
        -- armor, from 8 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2384);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2384, 3596);
        -- Cracked Leather Gloves
        -- armor, from 6 to 7
        UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 2125);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2125, 3596);
        -- Flimsy Chain Pants
        -- armor, from 3 to 4
        UPDATE `item_template` SET `armor` = 4 WHERE (`entry` = 2654);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2654, 3596);
        -- Tarnished Chain Belt
        -- armor, from 7 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2380);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2380, 3596);
        -- Tarnished Chain Boots
        -- armor, from 11 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 2383);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2383, 3596);
        -- Tarnished Chain Gloves
        -- armor, from 9 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 2385);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2385, 3596);
        -- Large Round Shield
        -- armor, from 12 to 19
        UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 2129);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2129, 3596);
        -- Handstitched Leather Vest
        -- armor, from 11 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 5957);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5957, 3596);
        -- Viny Wrappings
        -- display_id, from 2486 to 8293
        UPDATE `item_template` SET `display_id` = 8293 WHERE (`entry` = 2571);
        UPDATE `applied_item_updates` SET `entry` = 2571, `version` = 3596 WHERE (`entry` = 2571);
        -- Thistlewood Blade
        -- dmg_min1, from 2.0 to 3
        -- dmg_max1, from 5.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 5586);
        UPDATE `applied_item_updates` SET `entry` = 5586, `version` = 3596 WHERE (`entry` = 5586);
        -- Disciple's Boots
        -- buy_price, from 290 to 223
        -- sell_price, from 58 to 44
        -- item_level, from 11 to 10
        UPDATE `item_template` SET `buy_price` = 223, `sell_price` = 44, `item_level` = 10 WHERE (`entry` = 7351);
        UPDATE `applied_item_updates` SET `entry` = 7351, `version` = 3596 WHERE (`entry` = 7351);
        -- Cracked Buckler
        -- armor, from 6 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2212);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2212, 3596);
        -- Hearthstone
        -- class, from 15 to 14
        UPDATE `item_template` SET `class` = 14 WHERE (`entry` = 6948);
        UPDATE `applied_item_updates` SET `entry` = 6948, `version` = 3596 WHERE (`entry` = 6948);
        -- Dark Leather Boots
        -- required_level, from 10 to 15
        -- armor, from 21 to 23
        UPDATE `item_template` SET `required_level` = 15, `armor` = 23 WHERE (`entry` = 2315);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2315, 3596);
        -- Goldenbark Apple
        -- buy_price, from 1000 to 1250
        -- sell_price, from 50 to 62
        UPDATE `item_template` SET `buy_price` = 1250, `sell_price` = 62 WHERE (`entry` = 4539);
        UPDATE `applied_item_updates` SET `entry` = 4539, `version` = 3596 WHERE (`entry` = 4539);
        -- Scouting Spaulders
        -- display_id, from 12485 to 14756
        -- buy_price, from 2019 to 2027
        -- sell_price, from 403 to 405
        -- required_level, from 13 to 17
        -- armor, from 26 to 28
        UPDATE `item_template` SET `display_id` = 14756, `buy_price` = 2027, `sell_price` = 405, `required_level` = 17, `armor` = 28 WHERE (`entry` = 6588);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6588, 3596);
        -- Frostweave Pants
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 5
        -- armor, from 19 to 21
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 5, `armor` = 21 WHERE (`entry` = 4037);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4037, 3596);
        -- Swampwalker Boots
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 2
        -- armor, from 30 to 33
        UPDATE `item_template` SET `stat_value1` = 3, `stat_type2` = 7, `stat_value2` = 2, `armor` = 33 WHERE (`entry` = 2276);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2276, 3596);
        -- Cured Leather Bracers
        -- required_level, from 12 to 17
        -- armor, from 16 to 17
        UPDATE `item_template` SET `required_level` = 17, `armor` = 17 WHERE (`entry` = 1850);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1850, 3596);
        -- Ruffled Chaplet
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 4
        -- armor, from 27 to 29
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 4, `armor` = 29 WHERE (`entry` = 5753);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5753, 3596);
        -- Wolfpack Medallion
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 5 WHERE (`entry` = 5754);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5754, 3596);
        -- Forest Tracker Epaulets
        -- stat_value1, from 0 to 2
        -- armor, from 35 to 39
        UPDATE `item_template` SET `stat_value1` = 2, `armor` = 39 WHERE (`entry` = 2278);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2278, 3596);
        -- Fine Leather Gloves
        -- quality, from 1 to 2
        -- buy_price, from 542 to 905
        -- sell_price, from 108 to 181
        -- required_level, from 5 to 10
        -- armor, from 14 to 18
        UPDATE `item_template` SET `quality` = 2, `buy_price` = 905, `sell_price` = 181, `required_level` = 10, `armor` = 18 WHERE (`entry` = 2312);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2312, 3596);
        -- Harlequin Robes
        -- buy_price, from 4310 to 3814
        -- sell_price, from 862 to 762
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 18 to 19
        UPDATE `item_template` SET `buy_price` = 3814, `sell_price` = 762, `item_level` = 22, `required_level` = 17, `stat_value1` = 1, `stat_value2` = 1, `armor` = 19 WHERE (`entry` = 6503);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6503, 3596);
        -- Sage's Sash
        -- name, from Sage's Belt to Sage's Sash
        -- display_id, from 12510 to 14762
        -- required_level, from 15 to 20
        -- armor, from 8 to 9
        UPDATE `item_template` SET `name` = 'Sage\'s Sash', `display_id` = 14762, `required_level` = 20, `armor` = 9 WHERE (`entry` = 6611);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6611, 3596);
        -- Bounty Hunter's Ring
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `stat_type1` = 3, `stat_value1` = 1 WHERE (`entry` = 5351);
        UPDATE `applied_item_updates` SET `entry` = 5351, `version` = 3596 WHERE (`entry` = 5351);
        -- Runic Cloth Cloak
        -- required_level, from 5 to 10
        -- armor, from 3 to 11
        UPDATE `item_template` SET `required_level` = 10, `armor` = 11 WHERE (`entry` = 4686);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4686, 3596);
        -- Living Root
        -- nature_res, from 5 to 1
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `nature_res` = 1, `bonding` = 2 WHERE (`entry` = 6631);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6631, 3596);
        -- Hillman's Leather Vest
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 2
        -- armor, from 33 to 36
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2, `armor` = 36 WHERE (`entry` = 4244);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4244, 3596);
        -- Tanned Leather Pants
        -- display_id, from 3248 to 9640
        -- required_level, from 7 to 12
        -- armor, from 24 to 26
        UPDATE `item_template` SET `display_id` = 9640, `required_level` = 12, `armor` = 26 WHERE (`entry` = 845);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (845, 3596);
        -- Beaten Battle Axe
        -- required_level, from 1 to 5
        -- dmg_min1, from 13.0 to 8
        -- dmg_max1, from 18.0 to 13
        UPDATE `item_template` SET `required_level` = 5, `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 1417);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1417, 3596);
        -- Fine Leather Belt
        -- required_level, from 6 to 11
        -- armor, from 12 to 13
        UPDATE `item_template` SET `required_level` = 11, `armor` = 13 WHERE (`entry` = 4246);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4246, 3596);
        -- Journeyman Quarterstaff
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 39.0 to 27
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 854);
        UPDATE `applied_item_updates` SET `entry` = 854, `version` = 3596 WHERE (`entry` = 854);
        -- Silver Steel Axe
        -- required_level, from 5 to 10
        -- dmg_min1, from 25.0 to 12
        -- dmg_max1, from 39.0 to 23
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 12, `dmg_max1` = 23 WHERE (`entry` = 6966);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6966, 3596);
        -- Forest Leather Mantle
        -- required_level, from 15 to 20
        -- armor, from 27 to 30
        UPDATE `item_template` SET `required_level` = 20, `armor` = 30 WHERE (`entry` = 4709);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4709, 3596);
        -- Gnoll Casting Gloves
        -- spellid_1, from 9396 to 8748
        UPDATE `item_template` SET `spellid_1` = 8748 WHERE (`entry` = 892);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (892, 3596);
        -- Linen Belt
        -- buy_price, from 111 to 105
        -- sell_price, from 22 to 21
        UPDATE `item_template` SET `buy_price` = 105, `sell_price` = 21 WHERE (`entry` = 7026);
        UPDATE `applied_item_updates` SET `entry` = 7026, `version` = 3596 WHERE (`entry` = 7026);
        -- Husk of Naraxis
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 3
        -- armor, from 58 to 63
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 3, `armor` = 63 WHERE (`entry` = 4448);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4448, 3596);
        -- Deadly Stiletto
        -- dmg_min1, from 37.0 to 26
        -- dmg_max1, from 57.0 to 49
        UPDATE `item_template` SET `dmg_min1` = 26, `dmg_max1` = 49 WHERE (`entry` = 2534);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2534, 3596);
        -- Stout Maul
        -- dmg_min1, from 41.0 to 33
        -- dmg_max1, from 57.0 to 50
        UPDATE `item_template` SET `dmg_min1` = 33, `dmg_max1` = 50 WHERE (`entry` = 924);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (924, 3596);
        -- Diviner Long Staff
        -- dmg_min1, from 42.0 to 33
        -- dmg_max1, from 57.0 to 50
        UPDATE `item_template` SET `dmg_min1` = 33, `dmg_max1` = 50 WHERE (`entry` = 928);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (928, 3596);
        -- Scalemail Belt
        -- required_level, from 12 to 17
        -- armor, from 21 to 23
        UPDATE `item_template` SET `required_level` = 17, `armor` = 23 WHERE (`entry` = 1853);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1853, 3596);
        -- Scalemail Boots
        -- required_level, from 12 to 17
        -- armor, from 33 to 36
        UPDATE `item_template` SET `required_level` = 17, `armor` = 36 WHERE (`entry` = 287);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (287, 3596);
        -- Polished Scale Vest
        -- required_level, from 17 to 22
        -- armor, from 52 to 58
        UPDATE `item_template` SET `required_level` = 22, `armor` = 58 WHERE (`entry` = 2153);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2153, 3596);
        -- Polished Scale Leggings
        -- required_level, from 17 to 22
        -- armor, from 46 to 50
        UPDATE `item_template` SET `required_level` = 22, `armor` = 50 WHERE (`entry` = 2152);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2152, 3596);
        -- Polished Scale Boots
        -- required_level, from 17 to 22
        -- armor, from 36 to 40
        UPDATE `item_template` SET `required_level` = 22, `armor` = 40 WHERE (`entry` = 2149);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2149, 3596);
        -- Polished Scale Bracers
        -- required_level, from 17 to 22
        -- armor, from 26 to 29
        UPDATE `item_template` SET `required_level` = 22, `armor` = 29 WHERE (`entry` = 2150);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2150, 3596);
        -- Polished Scale Gloves
        -- required_level, from 17 to 22
        -- armor, from 30 to 32
        UPDATE `item_template` SET `required_level` = 22, `armor` = 32 WHERE (`entry` = 2151);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2151, 3596);
        -- Augmented Chain Vest
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- armor, from 67 to 73
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 4, `armor` = 73 WHERE (`entry` = 2417);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2417, 3596);
        -- Augmented Chain Leggings
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- armor, from 58 to 64
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 4, `armor` = 64 WHERE (`entry` = 2418);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2418, 3596);
        -- Augmented Chain Gloves
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 2
        -- armor, from 37 to 41
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 2, `armor` = 41 WHERE (`entry` = 2422);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2422, 3596);
        -- Augmented Chain Helm
        -- display_id, from 13269 to 15318
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- armor, from 42 to 46
        UPDATE `item_template` SET `display_id` = 15318, `required_level` = 32, `stat_value1` = 4, `armor` = 46 WHERE (`entry` = 3891);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3891, 3596);
        -- Brigandine Helm
        -- display_id, from 13271 to 15320
        -- required_level, from 40 to 45
        -- stat_value1, from 0 to 8
        -- armor, from 51 to 57
        UPDATE `item_template` SET `display_id` = 15320, `required_level` = 45, `stat_value1` = 8, `armor` = 57 WHERE (`entry` = 3894);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3894, 3596);
        -- Reinforced Targe
        -- required_level, from 17 to 22
        -- armor, from 36 to 48
        UPDATE `item_template` SET `required_level` = 22, `armor` = 48 WHERE (`entry` = 2442);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2442, 3596);
        -- Large Metal Shield
        -- required_level, from 12 to 17
        -- armor, from 52 to 83
        UPDATE `item_template` SET `required_level` = 17, `armor` = 83 WHERE (`entry` = 2445);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2445, 3596);
        -- Kite Shield
        -- required_level, from 17 to 22
        -- armor, from 60 to 96
        UPDATE `item_template` SET `required_level` = 22, `armor` = 96 WHERE (`entry` = 2446);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2446, 3596);
        -- Glorious Shoulders
        -- required_level, from 18 to 23
        -- stat_value1, from 0 to 1
        -- armor, from 48 to 53
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 1, `armor` = 53 WHERE (`entry` = 4833);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4833, 3596);
        -- Battleforge Bracers
        -- required_level, from 17 to 22
        -- armor, from 26 to 29
        UPDATE `item_template` SET `required_level` = 22, `armor` = 29 WHERE (`entry` = 6591);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6591, 3596);
        -- Ebon Scimitar
        -- required_level, from 19 to 24
        -- dmg_min1, from 40.0 to 26
        -- dmg_max1, from 61.0 to 49
        UPDATE `item_template` SET `required_level` = 24, `dmg_min1` = 26, `dmg_max1` = 49 WHERE (`entry` = 3186);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3186, 3596);
        -- Worn Mail Pants
        -- required_level, from 2 to 7
        -- armor, from 21 to 23
        UPDATE `item_template` SET `required_level` = 7, `armor` = 23 WHERE (`entry` = 1735);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1735, 3596);
        -- Worn Mail Gloves
        -- required_level, from 1 to 6
        -- armor, from 13 to 14
        UPDATE `item_template` SET `required_level` = 6, `armor` = 14 WHERE (`entry` = 1734);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1734, 3596);
        -- Commoner's Sword
        -- name, from Warped Shortsword to Commoner's Sword
        -- required_level, from 3 to 10
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 20.0 to 11
        UPDATE `item_template` SET `name` = 'Commoner\'s Sword', `required_level` = 10, `dmg_min1` = 6, `dmg_max1` = 11 WHERE (`entry` = 1511);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1511, 3596);
        -- Silver Steel Sword
        -- required_level, from 5 to 10
        -- dmg_min1, from 20.0 to 9
        -- dmg_max1, from 30.0 to 18
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 9, `dmg_max1` = 18 WHERE (`entry` = 6967);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6967, 3596);
        -- Scarab Trousers
        -- buy_price, from 2713 to 2705
        -- sell_price, from 542 to 541
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 1
        -- armor, from 14 to 16
        UPDATE `item_template` SET `buy_price` = 2705, `sell_price` = 541, `required_level` = 15, `stat_type1` = 6, `stat_value1` = 1, `stat_type2` = 7, `stat_value2` = 1, `armor` = 16 WHERE (`entry` = 6659);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6659, 3596);
        -- Wooden Buckler
        -- required_level, from 5 to 10
        -- armor, from 16 to 24
        UPDATE `item_template` SET `required_level` = 10, `armor` = 24 WHERE (`entry` = 2214);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2214, 3596);
        -- Calico Pants
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `required_level` = 6 WHERE (`entry` = 1499);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1499, 3596);
        -- Dark Leather Tunic
        -- required_level, from 10 to 15
        -- armor, from 33 to 36
        UPDATE `item_template` SET `required_level` = 15, `armor` = 36 WHERE (`entry` = 2317);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2317, 3596);
        -- Willow Vest
        -- display_id, from 12437 to 14739
        -- buy_price, from 1348 to 1396
        -- sell_price, from 269 to 279
        -- required_level, from 5 to 10
        -- armor, from 14 to 16
        UPDATE `item_template` SET `display_id` = 14739, `buy_price` = 1396, `sell_price` = 279, `required_level` = 10, `armor` = 16 WHERE (`entry` = 6536);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6536, 3596);
        -- Ancestral Robe
        -- display_id, from 12422 to 14517
        UPDATE `item_template` SET `display_id` = 14517 WHERE (`entry` = 6527);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6527, 3596);
        -- Warped Leather Gloves
        -- name, from Patched Leather Gloves to Warped Leather Gloves
        -- required_level, from 3 to 8
        -- armor, from 9 to 10
        UPDATE `item_template` SET `name` = 'Warped Leather Gloves', `required_level` = 8, `armor` = 10 WHERE (`entry` = 1506);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1506, 3596);
        -- Robe of the Keeper
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- armor, from 14 to 16
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 7, `stat_value1` = 1, `armor` = 16 WHERE (`entry` = 3161);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3161, 3596);
        -- Stonesplinter Dagger
        -- required_level, from 3 to 8
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 20.0 to 12
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 2266);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2266, 3596);
        -- Cured Leather Belt
        -- required_level, from 12 to 17
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 17, `armor` = 15 WHERE (`entry` = 1849);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1849, 3596);
        -- Calico Gloves
        -- required_level, from 5 to 10
        -- armor, from 5 to 6
        UPDATE `item_template` SET `required_level` = 10, `armor` = 6 WHERE (`entry` = 1498);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1498, 3596);
        -- Heavy Shortbow
        -- buy_price, from 2578 to 1432
        -- sell_price, from 515 to 286
        -- item_level, from 15 to 12
        -- dmg_min1, from 10.0 to 13
        -- dmg_max1, from 20.0 to 24
        UPDATE `item_template` SET `buy_price` = 1432, `sell_price` = 286, `item_level` = 12, `dmg_min1` = 13, `dmg_max1` = 24 WHERE (`entry` = 3036);
        UPDATE `applied_item_updates` SET `entry` = 3036, `version` = 3596 WHERE (`entry` = 3036);
        -- Cutthroat Pauldrons
        -- name, from Berserker Pauldrons to Cutthroat Pauldrons
        -- required_level, from 15 to 20
        -- armor, from 45 to 49
        UPDATE `item_template` SET `name` = 'Cutthroat Pauldrons', `required_level` = 20, `armor` = 49 WHERE (`entry` = 3231);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3231, 3596);
        -- Twisted Sabre
        -- dmg_min1, from 24.0 to 13
        -- dmg_max1, from 37.0 to 26
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 26 WHERE (`entry` = 2011);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2011, 3596);
        -- Emblazoned Boots
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- stat_type2, from 0 to 6
        -- stat_value2, from 0 to 1
        -- armor, from 30 to 33
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `stat_type2` = 6, `stat_value2` = 1, `armor` = 33 WHERE (`entry` = 4051);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4051, 3596);
        -- Loksey's Training Stick
        -- spellid_1, from 18207 to 7594
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `spellid_1` = 7594, `bonding` = 2 WHERE (`entry` = 7710);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7710, 3596);
        -- Enchanted Moonstalker Cloak
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 7
        -- armor, from 12 to 14
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 7, `armor` = 14 WHERE (`entry` = 5387);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5387, 3596);
        -- Robe of Solomon
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 10
        -- armor, from 19 to 20
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `stat_value2` = 10, `armor` = 20 WHERE (`entry` = 3555);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3555, 3596);
        -- Scarecrow Trousers
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 2
        -- armor, from 14 to 16
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2, `armor` = 16 WHERE (`entry` = 4434);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4434, 3596);
        -- Shimmering Boots
        -- display_id, from 12466 to 14749
        -- buy_price, from 3304 to 2923
        -- sell_price, from 660 to 584
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        -- armor, from 12 to 13
        UPDATE `item_template` SET `display_id` = 14749, `buy_price` = 2923, `sell_price` = 584, `item_level` = 22, `required_level` = 17, `armor` = 13 WHERE (`entry` = 6562);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6562, 3596);
        -- Grayson's Torch
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1 WHERE (`entry` = 1172);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1172, 3596);
        -- Shimmering Pants
        -- display_id, from 12470 to 14746
        -- buy_price, from 2713 to 2725
        -- sell_price, from 542 to 545
        -- required_level, from 10 to 15
        -- armor, from 14 to 16
        UPDATE `item_template` SET `display_id` = 14746, `buy_price` = 2725, `sell_price` = 545, `required_level` = 15, `armor` = 16 WHERE (`entry` = 6568);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6568, 3596);
        -- Silvered Bronze Shoulders
        -- required_level, from 15 to 20
        -- armor, from 45 to 49
        UPDATE `item_template` SET `required_level` = 20, `armor` = 49 WHERE (`entry` = 3481);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3481, 3596);
        -- Green Iron Boots
        -- required_level, from 19 to 24
        -- stat_value1, from 0 to 3
        -- armor, from 42 to 46
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3, `armor` = 46 WHERE (`entry` = 3484);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3484, 3596);
        -- Banded Buckler
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 1193);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1193, 3596);
        -- Gnarled Ash Staff
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 10
        -- dmg_min1, from 51.0 to 40
        -- dmg_max1, from 70.0 to 61
        UPDATE `item_template` SET `stat_value1` = 4, `stat_value2` = 10, `dmg_min1` = 40, `dmg_max1` = 61 WHERE (`entry` = 791);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (791, 3596);
        -- Emblazoned Hat
        -- name, from Emblazoned Helm to Emblazoned Hat
        -- display_id, from 13257 to 15904
        -- required_level, from 21 to 26
        -- stat_value2, from 0 to 2
        -- stat_value3, from 0 to 15
        -- armor, from 27 to 29
        UPDATE `item_template` SET `name` = 'Emblazoned Hat', `display_id` = 15904, `required_level` = 26, `stat_value2` = 2, `stat_value3` = 15, `armor` = 29 WHERE (`entry` = 4048);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4048, 3596);
        -- Green Leather Bracers
        -- required_level, from 26 to 31
        -- armor, from 24 to 26
        UPDATE `item_template` SET `required_level` = 31, `armor` = 26 WHERE (`entry` = 4259);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4259, 3596);
        -- Shadow Weaver Leggings
        -- buy_price, from 6800 to 8452
        -- sell_price, from 1360 to 1690
        -- item_level, from 25 to 27
        -- required_level, from 15 to 22
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        -- armor, from 32 to 37
        UPDATE `item_template` SET `buy_price` = 8452, `sell_price` = 1690, `item_level` = 27, `required_level` = 22, `stat_value1` = 2, `stat_value2` = 2, `armor` = 37 WHERE (`entry` = 2233);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2233, 3596);
        -- Metalworking Gloves
        -- required_level, from 8 to 13
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 10
        -- armor, from 18 to 19
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 1, `stat_value1` = 10, `armor` = 19 WHERE (`entry` = 1944);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1944, 3596);
        -- Foamspittle Staff
        -- required_level, from 7 to 12
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 38.0 to 25
        -- dmg_max1, from 53.0 to 38
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 1, `dmg_min1` = 25, `dmg_max1` = 38 WHERE (`entry` = 1405);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1405, 3596);
        -- Red Woolen Boots
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        -- armor, from 11 to 13
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1, `armor` = 13 WHERE (`entry` = 4313);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4313, 3596);
        -- Flameweave Armor
        -- display_id, from 12507 to 14563
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 3
        -- armor, from 19 to 21
        UPDATE `item_template` SET `display_id` = 14563, `required_level` = 21, `stat_value1` = 3, `armor` = 21 WHERE (`entry` = 6608);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6608, 3596);
        -- Gloves of Meditation
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 2
        -- armor, from 11 to 12
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2, `armor` = 12 WHERE (`entry` = 4318);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4318, 3596);
        -- Palomino Bridle
        -- allowable_race, from 223 to 415
        UPDATE `item_template` SET `allowable_race` = 415 WHERE (`entry` = 2413);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2413, 3596);
        -- White Stallion Bridle
        -- allowable_race, from 223 to 415
        UPDATE `item_template` SET `allowable_race` = 415 WHERE (`entry` = 2415);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2415, 3596);
        -- Chestnut Horse Bridle
        -- allowable_race, from 223 to 415
        UPDATE `item_template` SET `allowable_race` = 415 WHERE (`entry` = 5655);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5655, 3596);
        -- Silvered Bronze Breastplate
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        -- armor, from 56 to 62
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2, `stat_value2` = 2, `armor` = 62 WHERE (`entry` = 2869);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2869, 3596);
        -- Verigan's Fist
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6953);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6953, 3596);
        -- Forest Leather Belt
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 6
        -- armor, from 16 to 18
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 6, `armor` = 18 WHERE (`entry` = 6382);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6382, 3596);
        -- Scouting Trousers
        -- display_id, from 12484 to 14757
        -- buy_price, from 5070 to 4489
        -- sell_price, from 1014 to 897
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        -- armor, from 31 to 33
        UPDATE `item_template` SET `display_id` = 14757, `buy_price` = 4489, `sell_price` = 897, `item_level` = 22, `required_level` = 17, `armor` = 33 WHERE (`entry` = 6587);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6587, 3596);
        -- Edge of the People's Militia
        -- required_level, from 7 to 12
        -- dmg_min1, from 35.0 to 22
        -- dmg_max1, from 48.0 to 34
        UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 22, `dmg_max1` = 34 WHERE (`entry` = 1566);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1566, 3596);
        -- Large Bore Blunderbuss
        -- dmg_min1, from 15.0 to 19
        -- dmg_max1, from 23.0 to 36
        UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 36 WHERE (`entry` = 3023);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3023, 3596);
        -- Heavy Shot
        -- dmg_min1, from 4.0 to 5
        -- dmg_max1, from 4.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 6 WHERE (`entry` = 2519);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2519, 3596);
        -- Solid Shot
        -- dmg_min1, from 6.0 to 12
        -- dmg_max1, from 7.0 to 13
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 13 WHERE (`entry` = 3033);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3033, 3596);
        -- Cured Leather Pants
        -- required_level, from 12 to 17
        -- armor, from 28 to 30
        UPDATE `item_template` SET `required_level` = 17, `armor` = 30 WHERE (`entry` = 237);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (237, 3596);
        -- Battle Slayer
        -- required_level, from 13 to 18
        -- dmg_min1, from 48.0 to 35
        -- dmg_max1, from 66.0 to 54
        UPDATE `item_template` SET `required_level` = 18, `dmg_min1` = 35, `dmg_max1` = 54 WHERE (`entry` = 3199);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3199, 3596);
        -- Forest Chain
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 3
        -- armor, from 55 to 61
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 3, `armor` = 61 WHERE (`entry` = 1273);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1273, 3596);
        -- Patched Leather Belt
        -- name, from Rawhide Belt to Patched Leather Belt
        -- required_level, from 8 to 13
        -- armor, from 9 to 10
        UPDATE `item_template` SET `name` = 'Patched Leather Belt', `required_level` = 13, `armor` = 10 WHERE (`entry` = 1787);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1787, 3596);
        -- Mud Stompers
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        -- armor, from 29 to 32
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 3, `armor` = 32 WHERE (`entry` = 6188);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6188, 3596);
        -- Bashing Pauldrons
        -- armor, from 24 to 27
        UPDATE `item_template` SET `armor` = 27 WHERE (`entry` = 5319);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5319, 3596);
        -- Tribal Worg Helm
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- stat_value3, from 0 to 2
        -- armor, from 27 to 30
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `stat_value3` = 2, `armor` = 30 WHERE (`entry` = 6204);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6204, 3596);
        -- Infiltrator Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 7411);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7411, 3596);
        -- Holy Shroud
        -- display_id, from 13547 to 15337
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 3
        -- armor, from 14 to 15
        UPDATE `item_template` SET `display_id` = 15337, `stat_value1` = 5, `stat_value2` = 3, `armor` = 15 WHERE (`entry` = 2721);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2721, 3596);
        -- Silk-threaded Trousers
        -- required_level, from 8 to 13
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 13, `stat_type1` = 5, `stat_value1` = 1, `armor` = 15 WHERE (`entry` = 1929);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1929, 3596);
        -- Hardened Root Staff
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 2
        -- dmg_min1, from 50.0 to 40
        -- dmg_max1, from 69.0 to 60
        UPDATE `item_template` SET `required_level` = 20, `stat_value1` = 2, `dmg_min1` = 40, `dmg_max1` = 60 WHERE (`entry` = 1317);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1317, 3596);
        -- Emblazoned Bracers
        -- required_level, from 20 to 25
        -- armor, from 21 to 23
        UPDATE `item_template` SET `required_level` = 25, `armor` = 23 WHERE (`entry` = 4049);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4049, 3596);
        -- Smoldering Wand
        -- dmg_min1, from 23.0 to 14
        -- dmg_max1, from 35.0 to 27
        -- delay, from 3000 to 1600
        UPDATE `item_template` SET `dmg_min1` = 14, `dmg_max1` = 27, `delay` = 1600 WHERE (`entry` = 5208);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5208, 3596);
        -- Dark Leather Shoulders
        -- required_level, from 18 to 23
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 2
        -- armor, from 32 to 35
        UPDATE `item_template` SET `required_level` = 23, `stat_type1` = 3, `stat_value1` = 2, `armor` = 35 WHERE (`entry` = 4252);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4252, 3596);
        -- Thelsamar Axe
        -- required_level, from 8 to 13
        -- dmg_min1, from 22.0 to 11
        -- dmg_max1, from 34.0 to 21
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 11, `dmg_max1` = 21 WHERE (`entry` = 3154);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3154, 3596);
        -- Gold-flecked Gloves
        -- required_level, from 11 to 16
        -- stat_type1, from 0 to 5
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 16, `stat_type1` = 5, `armor` = 11 WHERE (`entry` = 5195);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5195, 3596);
        -- Fist of the People's Militia
        -- required_level, from 7 to 12
        -- dmg_min1, from 16.0 to 8
        -- dmg_max1, from 25.0 to 15
        UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 8, `dmg_max1` = 15 WHERE (`entry` = 1480);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1480, 3596);
        -- Outfitter Boots
        -- armor, from 9 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 2691);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2691, 3596);
        -- Pikeman Shield
        -- armor, from 12 to 19
        UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 6078);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6078, 3596);
        -- Haggard's Axe
        -- required_level, from 5 to 10
        -- dmg_min1, from 25.0 to 12
        -- dmg_max1, from 39.0 to 23
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 12, `dmg_max1` = 23 WHERE (`entry` = 6979);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6979, 3596);
        -- Layered Vest
        -- armor, from 11 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 60);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (60, 3596);
        -- Frostmane Leather Vest
        -- armor, from 8 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2108);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2108, 3596);
        -- Goblin Screwdriver
        -- required_level, from 8 to 13
        -- dmg_min1, from 15.0 to 7
        -- dmg_max1, from 23.0 to 14
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 7, `dmg_max1` = 14 WHERE (`entry` = 1936);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1936, 3596);
        -- Haggard's Dagger
        -- required_level, from 5 to 10
        -- dmg_min1, from 16.0 to 7
        -- dmg_max1, from 24.0 to 15
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 7, `dmg_max1` = 15 WHERE (`entry` = 6980);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6980, 3596);
        -- Rabbit Handler Gloves
        -- armor, from 2 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 719);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (719, 3596);
        -- Rat Cloth Cloak
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        -- armor, from 11 to 12
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 4, `armor` = 12 WHERE (`entry` = 2284);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2284, 3596);
        -- Umbral Axe
        -- name, from Grey Iron Axe to Umbral Axe
        -- required_level, from 5 to 10
        -- dmg_min1, from 25.0 to 12
        -- dmg_max1, from 39.0 to 23
        UPDATE `item_template` SET `name` = 'Umbral Axe', `required_level` = 10, `dmg_min1` = 12, `dmg_max1` = 23 WHERE (`entry` = 6978);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6978, 3596);
        -- Heavy Woolen Pants
        -- required_level, from 12 to 17
        -- stat_value1, from 0 to 2
        -- armor, from 15 to 17
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2, `armor` = 17 WHERE (`entry` = 4316);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4316, 3596);
        -- Sage's Armor
        -- display_id, from 12508 to 14761
        -- buy_price, from 6438 to 6669
        -- sell_price, from 1287 to 1333
        -- required_level, from 17 to 22
        -- armor, from 19 to 21
        UPDATE `item_template` SET `display_id` = 14761, `buy_price` = 6669, `sell_price` = 1333, `required_level` = 22, `armor` = 21 WHERE (`entry` = 6609);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6609, 3596);
        -- Copper Dagger
        -- dmg_max1, from 10.0 to 9
        UPDATE `item_template` SET `dmg_max1` = 9 WHERE (`entry` = 7166);
        UPDATE `applied_item_updates` SET `entry` = 7166, `version` = 3596 WHERE (`entry` = 7166);
        -- Glyphed Helm
        -- display_id, from 13260 to 15548
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 4
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 4
        -- stat_type3, from 0 to 4
        -- stat_value3, from 0 to 2
        -- armor, from 32 to 36
        UPDATE `item_template` SET `display_id` = 15548, `required_level` = 35, `stat_value1` = 4, `stat_type2` = 7, `stat_value2` = 4, `stat_type3` = 4, `stat_value3` = 2, `armor` = 36 WHERE (`entry` = 6422);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6422, 3596);
        -- Crystal Starfire Medallion
        -- item_level, from 33 to 31
        -- required_level, from 23 to 26
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        -- stat_value3, from 0 to 2
        UPDATE `item_template` SET `item_level` = 31, `required_level` = 26, `stat_value1` = 2, `stat_value2` = 2, `stat_value3` = 2 WHERE (`entry` = 5003);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5003, 3596);
        -- Glyphed Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4732);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4732, 3596);
        -- Bent Large Shield
        -- armor, from 6 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 2211);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2211, 3596);
        -- Riverpaw Leather Vest
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 6
        -- armor, from 27 to 29
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 6, `armor` = 29 WHERE (`entry` = 821);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (821, 3596);
        -- Lesser Staff of the Spire
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 45.0 to 31
        -- dmg_max1, from 62.0 to 47
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1, `dmg_min1` = 31, `dmg_max1` = 47 WHERE (`entry` = 1300);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1300, 3596);
        -- Gnoll War Harness
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 1
        -- armor, from 28 to 31
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 4, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 1211);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1211, 3596);
        -- Wendigo Collar
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        -- armor, from 12 to 14
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 5, `armor` = 14 WHERE (`entry` = 2899);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2899, 3596);
        -- Buckler of the Seas
        -- required_level, from 10 to 15
        -- armor, from 39 to 49
        UPDATE `item_template` SET `required_level` = 15, `armor` = 49 WHERE (`entry` = 1557);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1557, 3596);
        -- Darkweave Sash
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 1, `stat_value2` = 1, `armor` = 11 WHERE (`entry` = 4720);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4720, 3596);
        -- Brightweave Gloves
        -- required_level, from 30 to 35
        -- stat_value2, from 0 to 35
        -- armor, from 15 to 16
        UPDATE `item_template` SET `required_level` = 35, `stat_value2` = 35, `armor` = 16 WHERE (`entry` = 4042);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4042, 3596);
        -- Garneg's War Belt
        -- required_level, from 19 to 24
        -- armor, from 27 to 29
        UPDATE `item_template` SET `required_level` = 24, `armor` = 29 WHERE (`entry` = 6200);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6200, 3596);
        -- Fisherman Knife
        -- required_level, from 4 to 11
        -- dmg_min1, from 8.0 to 3
        -- dmg_max1, from 12.0 to 7
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 2763);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2763, 3596);
        -- Phalanx Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 7419);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7419, 3596);
        -- Deputy Chain Coat
        -- required_level, from 15 to 20
        -- stat_value2, from 0 to 2
        -- armor, from 55 to 61
        UPDATE `item_template` SET `required_level` = 20, `stat_value2` = 2, `armor` = 61 WHERE (`entry` = 1275);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1275, 3596);
        -- Emblazoned Gloves
        -- buy_price, from 7217 to 6561
        -- sell_price, from 1443 to 1312
        -- item_level, from 33 to 32
        -- required_level, from 23 to 27
        -- armor, from 25 to 27
        UPDATE `item_template` SET `buy_price` = 6561, `sell_price` = 1312, `item_level` = 32, `required_level` = 27, `armor` = 27 WHERE (`entry` = 6397);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6397, 3596);
        -- Frostweave Robe
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 4
        -- armor, from 22 to 24
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `stat_value2` = 4, `armor` = 24 WHERE (`entry` = 4035);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4035, 3596);
        -- Gladiator War Axe
        -- required_level, from 19 to 24
        -- dmg_min1, from 52.0 to 44
        -- dmg_max1, from 71.0 to 67
        UPDATE `item_template` SET `required_level` = 24, `dmg_min1` = 44, `dmg_max1` = 67 WHERE (`entry` = 3201);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3201, 3596);
        -- Darkweave Cowl
        -- display_id, from 13295 to 15298
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 4
        -- armor, from 15 to 17
        UPDATE `item_template` SET `display_id` = 15298, `required_level` = 32, `stat_value1` = 4, `stat_value2` = 4, `armor` = 17 WHERE (`entry` = 4039);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4039, 3596);
        -- Relic Blade
        -- required_level, from 10 to 15
        -- dmg_min1, from 20.0 to 10
        -- dmg_max1, from 31.0 to 20
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 10, `dmg_max1` = 20 WHERE (`entry` = 5627);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5627, 3596);
        -- Orb of Power
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2 WHERE (`entry` = 4838);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4838, 3596);
        -- Ravager
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7717);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7717, 3596);
        -- Cured Medium Hide
        -- display_id, from 7112 to 7348
        UPDATE `item_template` SET `display_id` = 7348 WHERE (`entry` = 4233);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4233, 3596);
        -- Message in a Bottle
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6307);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6307, 3596);
        -- Calico Belt
        -- required_level, from 4 to 9
        UPDATE `item_template` SET `required_level` = 9 WHERE (`entry` = 3374);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3374, 3596);
        -- Frostbit Staff
        -- required_level, from 1 to 7
        -- dmg_min1, from 19.0 to 12
        -- dmg_max1, from 27.0 to 19
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 2067);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2067, 3596);
        -- Boar Handler Gloves
        -- armor, from 7 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2547);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2547, 3596);
        -- Ironplate Buckler
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        -- armor, from 32 to 40
        UPDATE `item_template` SET `required_level` = 10, `stat_type1` = 1, `stat_value1` = 3, `armor` = 40 WHERE (`entry` = 3160);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3160, 3596);
        -- Ebon Vise
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7690);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7690, 3596);
        -- Thornstone Sledgehammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1722);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1722, 3596);
        -- Heart Ring
        -- name, from Band of Vitality to Heart Ring
        -- display_id, from 9833 to 9834
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 3
        UPDATE `item_template` SET `name` = 'Heart Ring', `display_id` = 9834, `required_level` = 25, `stat_value1` = 3 WHERE (`entry` = 5001);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5001, 3596);
        -- White Woolen Dress
        -- armor, from 16 to 17
        UPDATE `item_template` SET `armor` = 17 WHERE (`entry` = 6787);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6787, 3596);
        -- BKP "Sparrow" Smallbore
        -- required_level, from 23 to 28
        -- dmg_min1, from 16.0 to 25
        -- dmg_max1, from 24.0 to 47
        UPDATE `item_template` SET `required_level` = 28, `dmg_min1` = 25, `dmg_max1` = 47 WHERE (`entry` = 3042);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3042, 3596);
        -- Soldier's Shield
        -- required_level, from 7 to 12
        -- armor, from 60 to 87
        UPDATE `item_template` SET `required_level` = 12, `armor` = 87 WHERE (`entry` = 6560);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6560, 3596);
        -- Torturing Poker
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7682);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7682, 3596);
        -- Fish Gutter
        -- required_level, from 22 to 27
        -- dmg_min1, from 32.0 to 21
        -- dmg_max1, from 49.0 to 41
        UPDATE `item_template` SET `required_level` = 27, `dmg_min1` = 21, `dmg_max1` = 41 WHERE (`entry` = 3755);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3755, 3596);
        -- Staff of the Blessed Seer
        -- spellid_1, from 9314 to 8475
        UPDATE `item_template` SET `spellid_1` = 8475 WHERE (`entry` = 2271);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2271, 3596);
        -- Glinting Scale Bracers
        -- required_level, from 15 to 20
        -- armor, from 25 to 28
        UPDATE `item_template` SET `required_level` = 20, `armor` = 28 WHERE (`entry` = 3212);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3212, 3596);
        -- Cured Leather Armor
        -- name, from Cured Leather Vest to Cured Leather Armor
        -- required_level, from 12 to 17
        -- armor, from 32 to 35
        UPDATE `item_template` SET `name` = 'Cured Leather Armor', `required_level` = 17, `armor` = 35 WHERE (`entry` = 236);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (236, 3596);
        -- Corpsemaker
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6687);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6687, 3596);
        -- Wandering Boots
        -- buy_price, from 3437 to 3440
        -- sell_price, from 687 to 688
        -- required_level, from 14 to 19
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- armor, from 13 to 14
        UPDATE `item_template` SET `buy_price` = 3440, `sell_price` = 688, `required_level` = 19, `stat_type1` = 7, `stat_value1` = 1, `armor` = 14 WHERE (`entry` = 6095);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6095, 3596);
        -- Slime Encrusted Pads
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 16 to 17
        UPDATE `item_template` SET `stat_value1` = 1, `stat_value2` = 1, `armor` = 17 WHERE (`entry` = 6461);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6461, 3596);
        -- Staff of Nobles
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 40.0 to 26
        -- dmg_max1, from 55.0 to 40
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 1, `dmg_min1` = 26, `dmg_max1` = 40 WHERE (`entry` = 3902);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3902, 3596);
        -- Padded Pants
        -- name, from Padded Cloth Pants to Padded Pants
        -- required_level, from 17 to 22
        -- armor, from 15 to 17
        UPDATE `item_template` SET `name` = 'Padded Pants', `required_level` = 22, `armor` = 17 WHERE (`entry` = 2159);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2159, 3596);
        -- Glimmering Mail Pauldrons
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 1
        -- armor, from 51 to 56
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 1, `armor` = 56 WHERE (`entry` = 6388);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6388, 3596);
        -- Darkshire Mail Leggings
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 3
        -- armor, from 49 to 54
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 3, `armor` = 54 WHERE (`entry` = 2906);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2906, 3596);
        -- Green Iron Bracers
        -- required_level, from 23 to 28
        -- armor, from 30 to 33
        UPDATE `item_template` SET `required_level` = 28, `armor` = 33 WHERE (`entry` = 3835);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3835, 3596);
        -- Black Metal Shortsword
        -- required_level, from 16 to 21
        -- dmg_min1, from 23.0 to 13
        -- dmg_max1, from 35.0 to 26
        UPDATE `item_template` SET `required_level` = 21, `dmg_min1` = 13, `dmg_max1` = 26 WHERE (`entry` = 886);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (886, 3596);
        -- Black Husk Shield
        -- required_level, from 14 to 19
        -- stat_value1, from 4 to 1
        -- armor, from 77 to 110
        UPDATE `item_template` SET `required_level` = 19, `stat_value1` = 1, `armor` = 110 WHERE (`entry` = 4444);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4444, 3596);
        -- Deadly Blunderbuss
        -- required_level, from 11 to 16
        -- dmg_min1, from 17.0 to 22
        -- dmg_max1, from 27.0 to 41
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 22, `dmg_max1` = 41 WHERE (`entry` = 4369);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4369, 3596);
        -- Shimmering Robe
        -- display_id, from 12471 to 15221
        -- required_level, from 12 to 17
        -- armor, from 17 to 19
        UPDATE `item_template` SET `display_id` = 15221, `required_level` = 17, `armor` = 19 WHERE (`entry` = 6569);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6569, 3596);
        -- Walking Boots
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 7
        -- armor, from 11 to 12
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 7, `armor` = 12 WHERE (`entry` = 4660);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4660, 3596);
        -- Frostweave Cloak
        -- buy_price, from 9023 to 8203
        -- sell_price, from 1804 to 1640
        -- item_level, from 33 to 32
        -- required_level, from 23 to 27
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 17 to 18
        UPDATE `item_template` SET `buy_price` = 8203, `sell_price` = 1640, `item_level` = 32, `required_level` = 27, `stat_type1` = 7, `stat_value1` = 1, `stat_value2` = 1, `armor` = 18 WHERE (`entry` = 4713);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4713, 3596);
        -- Darkweave Trousers
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 5
        -- armor, from 21 to 23
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 3, `stat_value2` = 5, `armor` = 23 WHERE (`entry` = 6405);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6405, 3596);
        -- Icy Cloak
        -- frost_res, from 11 to 6
        -- bonding, from 2 to 1
        UPDATE `item_template` SET `frost_res` = 6, `bonding` = 1 WHERE (`entry` = 4327);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4327, 3596);
        -- Celestial Orb
        -- spellid_1, from 13595 to 8430
        UPDATE `item_template` SET `spellid_1` = 8430 WHERE (`entry` = 7515);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7515, 3596);
        -- Icefury Wand
        -- dmg_type1, from 4 to 2
        UPDATE `item_template` SET `dmg_type1` = 2 WHERE (`entry` = 7514);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7514, 3596);
        -- Scorching Wand
        -- required_level, from 23 to 28
        -- dmg_min1, from 32.0 to 22
        -- dmg_max1, from 48.0 to 41
        -- delay, from 2600 to 1300
        UPDATE `item_template` SET `required_level` = 28, `dmg_min1` = 22, `dmg_max1` = 41, `delay` = 1300 WHERE (`entry` = 5213);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5213, 3596);
        -- Goblin Nutcracker
        -- material, from 2 to 1
        -- sheath, from 7 to 3
        UPDATE `item_template` SET `material` = 1, `sheath` = 3 WHERE (`entry` = 4090);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4090, 3596);
        -- Shrapnel Blaster
        -- required_level, from 30 to 35
        -- dmg_min1, from 24.0 to 39
        -- dmg_max1, from 37.0 to 74
        UPDATE `item_template` SET `required_level` = 35, `dmg_min1` = 39, `dmg_max1` = 74 WHERE (`entry` = 4127);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4127, 3596);
        -- Fire Hardened Gauntlets
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 15
        -- armor, from 36 to 39
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 2, `stat_value2` = 15, `armor` = 39 WHERE (`entry` = 6974);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6974, 3596);
        -- Battleforge Girdle
        -- buy_price, from 5310 to 4631
        -- sell_price, from 1062 to 926
        -- item_level, from 28 to 26
        -- required_level, from 18 to 21
        -- armor, from 26 to 27
        UPDATE `item_template` SET `buy_price` = 4631, `sell_price` = 926, `item_level` = 26, `required_level` = 21, `armor` = 27 WHERE (`entry` = 6594);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6594, 3596);
        -- Frost Leather Cloak
        -- spellid_1, from 9402 to 9161
        UPDATE `item_template` SET `spellid_1` = 9161 WHERE (`entry` = 7377);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7377, 3596);
        -- Ring of Healing
        -- buy_price, from 1400 to 21400
        -- sell_price, from 350 to 5350
        UPDATE `item_template` SET `buy_price` = 21400, `sell_price` = 5350 WHERE (`entry` = 1713);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1713, 3596);
        -- Heavy Earthen Gloves
        -- spellid_1, from 9329 to 9138
        UPDATE `item_template` SET `spellid_1` = 9138 WHERE (`entry` = 7359);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7359, 3596);
        -- Lesser Belt of the Spire
        -- required_level, from 12 to 17
        UPDATE `item_template` SET `required_level` = 17 WHERE (`entry` = 1299);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1299, 3596);
        -- Battleforge Boots
        -- required_level, from 15 to 20
        -- armor, from 38 to 42
        UPDATE `item_template` SET `required_level` = 20, `armor` = 42 WHERE (`entry` = 6590);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6590, 3596);
        -- Ironspine's Ribcage
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7688);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7688, 3596);
        -- Guillotine Axe
        -- dmg_min1, from 35.0 to 19
        -- dmg_max1, from 53.0 to 37
        UPDATE `item_template` SET `dmg_min1` = 19, `dmg_max1` = 37 WHERE (`entry` = 2807);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2807, 3596);
        -- Mail Combat Spaulders
        -- required_level, from 26 to 31
        -- armor, from 53 to 58
        UPDATE `item_template` SET `required_level` = 31, `armor` = 58 WHERE (`entry` = 6404);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6404, 3596);
        -- Heavy Gnoll War Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1218);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1218, 3596);
        -- Blurred Axe
        -- required_level, from 24 to 22
        -- dmg_min1, from 23.0 to 14
        -- dmg_max1, from 36.0 to 27
        UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 14, `dmg_max1` = 27 WHERE (`entry` = 4824);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4824, 3596);
        -- Insignia Leggings
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 7
        -- armor, from 41 to 45
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 7, `armor` = 45 WHERE (`entry` = 4054);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4054, 3596);
        -- Ironspine's Eye
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7686);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7686, 3596);
        -- Howling Blade
        -- buy_price, from 45542 to 47333
        -- sell_price, from 9108 to 9466
        -- stat_value1, from 0 to 4
        -- dmg_min1, from 27.0 to 18
        -- dmg_max1, from 41.0 to 34
        UPDATE `item_template` SET `buy_price` = 47333, `sell_price` = 9466, `stat_value1` = 4, `dmg_min1` = 18, `dmg_max1` = 34 WHERE (`entry` = 6331);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6331, 3596);
        -- Sage's Pants
        -- display_id, from 12514 to 14767
        -- buy_price, from 5852 to 6220
        -- sell_price, from 1170 to 1244
        -- required_level, from 16 to 21
        -- armor, from 17 to 18
        UPDATE `item_template` SET `display_id` = 14767, `buy_price` = 6220, `sell_price` = 1244, `required_level` = 21, `armor` = 18 WHERE (`entry` = 6616);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6616, 3596);
        -- Golden Scale Shoulders
        -- required_level, from 25 to 30
        -- stat_value2, from 0 to 1
        -- armor, from 57 to 63
        UPDATE `item_template` SET `required_level` = 30, `stat_value2` = 1, `armor` = 63 WHERE (`entry` = 3841);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3841, 3596);
        -- Mail Combat Gauntlets
        -- required_level, from 25 to 30
        -- stat_value1, from 0 to 3
        -- armor, from 39 to 43
        UPDATE `item_template` SET `required_level` = 30, `stat_value1` = 3, `armor` = 43 WHERE (`entry` = 4075);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4075, 3596);
        -- Rune Sword
        -- required_level, from 28 to 33
        -- dmg_min1, from 30.0 to 20
        -- dmg_max1, from 46.0 to 39
        UPDATE `item_template` SET `required_level` = 33, `dmg_min1` = 20, `dmg_max1` = 39 WHERE (`entry` = 864);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (864, 3596);
        -- Combat Shield
        -- buy_price, from 31551 to 26558
        -- sell_price, from 6310 to 5311
        -- item_level, from 38 to 36
        -- required_level, from 28 to 31
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 2
        -- armor, from 109 to 150
        UPDATE `item_template` SET `buy_price` = 26558, `sell_price` = 5311, `item_level` = 36, `required_level` = 31, `stat_value1` = 3, `stat_value2` = 2, `armor` = 150 WHERE (`entry` = 4065);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4065, 3596);
        -- Battleforge Gauntlets
        -- required_level, from 17 to 22
        -- armor, from 30 to 32
        UPDATE `item_template` SET `required_level` = 22, `armor` = 32 WHERE (`entry` = 6595);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6595, 3596);
        -- Wolfclaw Gloves
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 2
        -- armor, from 23 to 25
        UPDATE `item_template` SET `stat_value1` = 2, `stat_value2` = 2, `armor` = 25 WHERE (`entry` = 1978);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1978, 3596);
        -- Thick Cloth Pants
        -- required_level, from 12 to 17
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 17, `armor` = 15 WHERE (`entry` = 201);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (201, 3596);
        -- Serpent Gloves
        -- required_level, from 12 to 17
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 5
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 1, `stat_value2` = 5, `armor` = 11 WHERE (`entry` = 5970);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5970, 3596);
        -- Calico Cloak
        -- required_level, from 4 to 9
        UPDATE `item_template` SET `required_level` = 9 WHERE (`entry` = 1497);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1497, 3596);
        -- Tribal Headdress
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 4
        -- armor, from 15 to 17
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 3, `stat_value2` = 4, `armor` = 17 WHERE (`entry` = 2622);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2622, 3596);
        -- Chipped Quarterstaff
        -- required_level, from 8 to 15
        -- dmg_min1, from 25.0 to 16
        -- dmg_max1, from 34.0 to 25
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 16, `dmg_max1` = 25 WHERE (`entry` = 1813);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1813, 3596);
        -- Scimitar of Atun
        -- required_level, from 9 to 14
        -- dmg_min1, from 28.0 to 14
        -- dmg_max1, from 43.0 to 27
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 14, `dmg_max1` = 27 WHERE (`entry` = 1469);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1469, 3596);
        -- Gloom Reaper
        -- required_level, from 27 to 32
        -- dmg_min1, from 53.0 to 35
        -- dmg_max1, from 80.0 to 66
        UPDATE `item_template` SET `required_level` = 32, `dmg_min1` = 35, `dmg_max1` = 66 WHERE (`entry` = 863);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (863, 3596);
        -- Shadowhide Maul
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 44.0 to 32
        -- dmg_max1, from 60.0 to 49
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 1, `dmg_min1` = 32, `dmg_max1` = 49 WHERE (`entry` = 1458);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1458, 3596);
        -- Blighted Leggings
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7709);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7709, 3596);
        -- Cloak of Rot
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 10
        -- stat_value2, from 0 to 10
        -- armor, from 16 to 18
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 10, `stat_value2` = 10, `armor` = 18 WHERE (`entry` = 4462);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4462, 3596);
        -- Green Carapace Shield
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        -- armor, from 70 to 100
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1, `armor` = 100 WHERE (`entry` = 2021);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2021, 3596);
        -- Chromatic Robe
        -- required_level, from 19 to 24
        -- stat_value1, from 0 to 3
        -- armor, from 19 to 20
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 3, `armor` = 20 WHERE (`entry` = 2615);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2615, 3596);
        -- Robes of Arcana
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        -- armor, from 21 to 23
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 3, `stat_value2` = 3, `armor` = 23 WHERE (`entry` = 5770);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5770, 3596);
        -- Blackfang
        -- dmg_min1, from 20.0 to 12
        -- dmg_max1, from 31.0 to 23
        UPDATE `item_template` SET `dmg_min1` = 12, `dmg_max1` = 23 WHERE (`entry` = 2236);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2236, 3596);
        -- Beastial Manacles
        -- buy_price, from 4828 to 5001
        -- sell_price, from 965 to 1000
        -- required_level, from 17 to 22
        -- stat_type1, from 5 to 1
        -- stat_value1, from 5 to 10
        -- armor, from 29 to 32
        UPDATE `item_template` SET `buy_price` = 5001, `sell_price` = 1000, `required_level` = 22, `stat_type1` = 1, `stat_value1` = 10, `armor` = 32 WHERE (`entry` = 6722);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6722, 3596);
        -- Darkweave Mantle
        -- buy_price, from 14529 to 12230
        -- sell_price, from 2905 to 2446
        -- item_level, from 38 to 36
        -- required_level, from 28 to 31
        -- stat_value1, from 0 to 2
        -- armor, from 20 to 21
        UPDATE `item_template` SET `buy_price` = 12230, `sell_price` = 2446, `item_level` = 36, `required_level` = 31, `stat_value1` = 2, `armor` = 21 WHERE (`entry` = 4718);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4718, 3596);
        -- Palm Frond Mantle
        -- required_level, from 24 to 29
        -- stat_value1, from 0 to 18
        -- armor, from 19 to 20
        UPDATE `item_template` SET `required_level` = 29, `stat_value1` = 18, `armor` = 20 WHERE (`entry` = 4140);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4140, 3596);
        -- Huge Maul
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2525);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2525, 3596);
        -- Fierce War Maul
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2533);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2533, 3596);
        -- Studded Belt
        -- name, from Studded Leather Belt to Studded Belt
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 15
        -- armor, from 19 to 21
        UPDATE `item_template` SET `name` = 'Studded Belt', `required_level` = 32, `stat_value1` = 15, `armor` = 21 WHERE (`entry` = 2464);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2464, 3596);
        -- Studded Pants
        -- name, from Studded Leather Pants to Studded Pants
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- armor, from 39 to 43
        UPDATE `item_template` SET `name` = 'Studded Pants', `required_level` = 32, `stat_value1` = 4, `armor` = 43 WHERE (`entry` = 2465);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2465, 3596);
        -- Studded Boots
        -- name, from Studded Leather Boots to Studded Boots
        -- required_level, from 27 to 32
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 2
        -- armor, from 31 to 34
        UPDATE `item_template` SET `name` = 'Studded Boots', `required_level` = 32, `stat_type1` = 5, `stat_value1` = 2, `armor` = 34 WHERE (`entry` = 2467);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2467, 3596);
        -- Studded Bracers
        -- name, from Studded Leather Bracers to Studded Bracers
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 1
        -- armor, from 22 to 24
        UPDATE `item_template` SET `name` = 'Studded Bracers', `required_level` = 32, `stat_value1` = 1, `armor` = 24 WHERE (`entry` = 2468);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2468, 3596);
        -- Studded Gloves
        -- name, from Studded Leather Gloves to Studded Gloves
        -- required_level, from 27 to 32
        -- armor, from 25 to 27
        UPDATE `item_template` SET `name` = 'Studded Gloves', `required_level` = 32, `armor` = 27 WHERE (`entry` = 2469);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2469, 3596);
        -- Reinforced Leather Cap
        -- display_id, from 13264 to 15311
        -- required_level, from 40 to 45
        -- stat_value1, from 0 to 8
        -- armor, from 34 to 38
        UPDATE `item_template` SET `display_id` = 15311, `required_level` = 45, `stat_value1` = 8, `armor` = 38 WHERE (`entry` = 3893);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3893, 3596);
        -- Bartleby's Mug
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6781);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6781, 3596);
        -- Shiny Dirk
        -- required_level, from 29 to 36
        -- dmg_min1, from 21.0 to 14
        -- dmg_max1, from 33.0 to 28
        UPDATE `item_template` SET `required_level` = 36, `dmg_min1` = 14, `dmg_max1` = 28 WHERE (`entry` = 3786);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3786, 3596);
        -- Skeletal Longsword
        -- required_level, from 17 to 22
        -- dmg_min1, from 30.0 to 18
        -- dmg_max1, from 46.0 to 35
        UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 18, `dmg_max1` = 35 WHERE (`entry` = 2018);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2018, 3596);
        -- Wolf Bracers
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 3
        -- armor, from 18 to 20
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 3, `armor` = 20 WHERE (`entry` = 4794);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4794, 3596);
        -- Bluegill Kukri
        -- required_level, from 14 to 19
        -- dmg_min1, from 36.0 to 20
        -- dmg_max1, from 55.0 to 39
        UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 20, `dmg_max1` = 39 WHERE (`entry` = 2046);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2046, 3596);
        -- Fire Hardened Buckler
        -- required_level, from 17 to 22
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 48 to 60
        UPDATE `item_template` SET `required_level` = 22, `stat_value1` = 1, `stat_value2` = 1, `armor` = 60 WHERE (`entry` = 1276);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1276, 3596);
        -- Smite's Reaver
        -- name, from Spiked Axe to Smite's Reaver
        -- required_level, from 12 to 17
        -- dmg_min1, from 23.0 to 12
        -- dmg_max1, from 35.0 to 24
        UPDATE `item_template` SET `name` = 'Smite\'s Reaver', `required_level` = 17, `dmg_min1` = 12, `dmg_max1` = 24 WHERE (`entry` = 5196);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5196, 3596);
        -- Dwarven Leather Pants
        -- armor, from 7 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 61);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (61, 3596);
        -- Crude Battle Axe
        -- required_level, from 2 to 9
        -- dmg_min1, from 18.0 to 11
        -- dmg_max1, from 24.0 to 17
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 11, `dmg_max1` = 17 WHERE (`entry` = 1512);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1512, 3596);
        -- Frostweave Cowl
        -- display_id, from 13546 to 15331
        -- required_level, from 22 to 27
        -- armor, from 12 to 14
        UPDATE `item_template` SET `display_id` = 15331, `required_level` = 27, `armor` = 14 WHERE (`entry` = 3068);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3068, 3596);
        -- Band of Thorns
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `required_level` = 31, `stat_value1` = 1, `stat_value2` = 2 WHERE (`entry` = 5007);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5007, 3596);
        -- Burrowing Shovel
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6205);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6205, 3596);
        -- Ghostshard Talisman
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7731);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7731, 3596);
        -- Seraph's Strike
        -- sheath, from 1 to 3
        UPDATE `item_template` SET `sheath` = 3 WHERE (`entry` = 5614);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5614, 3596);
        -- Rose Mantle
        -- required_level, from 17 to 22
        -- armor, from 16 to 17
        UPDATE `item_template` SET `required_level` = 22, `armor` = 17 WHERE (`entry` = 5274);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5274, 3596);
        -- Seafarer's Pantaloons
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 14 to 16
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1, `stat_value2` = 1, `armor` = 16 WHERE (`entry` = 3563);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3563, 3596);
        -- Mail Combat Belt
        -- required_level, from 27 to 32
        -- armor, from 32 to 35
        UPDATE `item_template` SET `required_level` = 32, `armor` = 35 WHERE (`entry` = 4717);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4717, 3596);
        -- Necklace of Harmony
        -- required_level, from 24 to 29
        -- stat_value1, from 0 to 6
        UPDATE `item_template` SET `required_level` = 29, `stat_value1` = 6 WHERE (`entry` = 5180);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5180, 3596);
        -- Cryptbone Staff
        -- required_level, from 16 to 21
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 1
        -- stat_value3, from 0 to 1
        -- dmg_min1, from 46.0 to 37
        -- dmg_max1, from 63.0 to 56
        UPDATE `item_template` SET `required_level` = 21, `stat_value1` = 2, `stat_value2` = 1, `stat_value3` = 1, `dmg_min1` = 37, `dmg_max1` = 56 WHERE (`entry` = 2013);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2013, 3596);
        -- Darkweave Robe
        -- display_id, from 12659 to 14606
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 2
        -- stat_value3, from 0 to 1
        -- armor, from 24 to 27
        UPDATE `item_template` SET `display_id` = 14606, `required_level` = 32, `stat_value1` = 2, `stat_value3` = 1, `armor` = 27 WHERE (`entry` = 4038);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4038, 3596);
        -- Belt of Arugal
        -- buy_price, from 3862 to 4135
        -- sell_price, from 772 to 827
        -- stat_value1, from 0 to 25
        -- armor, from 9 to 10
        UPDATE `item_template` SET `buy_price` = 4135, `sell_price` = 827, `stat_value1` = 25, `armor` = 10 WHERE (`entry` = 6392);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6392, 3596);
        -- Vibrant Silk Cape
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        -- armor, from 17 to 18
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 1, `stat_value2` = 10, `armor` = 18 WHERE (`entry` = 5181);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5181, 3596);
        -- Mo'grosh Toothpick
        -- required_level, from 8 to 13
        -- dmg_min1, from 35.0 to 23
        -- dmg_max1, from 48.0 to 35
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 23, `dmg_max1` = 35 WHERE (`entry` = 2822);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2822, 3596);
        -- Shimmering Bracers
        -- display_id, from 12467 to 14750
        -- required_level, from 11 to 16
        UPDATE `item_template` SET `display_id` = 14750, `required_level` = 16 WHERE (`entry` = 6563);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6563, 3596);
        -- Star Belt
        -- spellid_1, from 9342 to 8751
        UPDATE `item_template` SET `spellid_1` = 8751 WHERE (`entry` = 4329);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4329, 3596);
        -- Crimson Silk Gloves
        -- spellid_1, from 9401 to 8755
        UPDATE `item_template` SET `spellid_1` = 8755 WHERE (`entry` = 7064);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7064, 3596);
        -- Glowing Leather Bracers
        -- required_level, from 18 to 23
        -- stat_value1, from 0 to 1
        -- armor, from 20 to 22
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 1, `armor` = 22 WHERE (`entry` = 2017);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2017, 3596);
        -- Shadow Claw
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 43.0 to 34
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 34 WHERE (`entry` = 2912);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2912, 3596);
        -- Chieftain Girdle
        -- required_level, from 13 to 18
        -- armor, from 23 to 26
        UPDATE `item_template` SET `required_level` = 18, `armor` = 26 WHERE (`entry` = 5750);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5750, 3596);
        -- Mail Combat Armguards
        -- buy_price, from 14009 to 11792
        -- sell_price, from 2801 to 2358
        -- item_level, from 38 to 36
        -- required_level, from 28 to 31
        -- armor, from 37 to 39
        UPDATE `item_template` SET `buy_price` = 11792, `sell_price` = 2358, `item_level` = 36, `required_level` = 31, `armor` = 39 WHERE (`entry` = 6403);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6403, 3596);
        -- Wizard's Belt
        -- required_level, from 18 to 23
        -- stat_value1, from 0 to 12
        -- armor, from 9 to 10
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 12, `armor` = 10 WHERE (`entry` = 4827);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4827, 3596);
        -- Gloom Wand
        -- dmg_min1, from 26.0 to 16
        -- dmg_max1, from 40.0 to 31
        -- delay, from 3300 to 1800
        UPDATE `item_template` SET `dmg_min1` = 16, `dmg_max1` = 31, `delay` = 1800 WHERE (`entry` = 5209);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5209, 3596);
        -- Enamelled Broadsword
        -- required_level, from 11 to 9
        -- dmg_min1, from 21.0 to 10
        -- dmg_max1, from 33.0 to 19
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 10, `dmg_max1` = 19 WHERE (`entry` = 4765);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4765, 3596);
        -- Rockjaw Blade
        -- required_level, from 1 to 6
        -- dmg_min1, from 11.0 to 6
        -- dmg_max1, from 17.0 to 11
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 6, `dmg_max1` = 11 WHERE (`entry` = 2065);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2065, 3596);
        -- Glimmering Mail Coif
        -- display_id, from 13284 to 15517
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- stat_value3, from 0 to 2
        -- armor, from 41 to 45
        UPDATE `item_template` SET `display_id` = 15517, `required_level` = 27, `stat_value1` = 2, `stat_value3` = 2, `armor` = 45 WHERE (`entry` = 6389);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6389, 3596);
        -- Gemmed Copper Gauntlets
        -- required_level, from 5 to 10
        -- armor, from 24 to 26
        UPDATE `item_template` SET `required_level` = 10, `armor` = 26 WHERE (`entry` = 3474);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3474, 3596);
        -- Rough Bronze Cuirass
        -- required_level, from 13 to 18
        -- armor, from 49 to 53
        UPDATE `item_template` SET `required_level` = 18, `armor` = 53 WHERE (`entry` = 2866);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2866, 3596);
        -- Hollowfang Blade
        -- required_level, from 8 to 13
        -- dmg_min1, from 15.0 to 7
        -- dmg_max1, from 23.0 to 14
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 7, `dmg_max1` = 14 WHERE (`entry` = 2020);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2020, 3596);
        -- Claymore of the Martyr
        -- stat_value1, from 0 to 3
        -- dmg_min1, from 46.0 to 34
        -- dmg_max1, from 62.0 to 52
        UPDATE `item_template` SET `stat_value1` = 3, `dmg_min1` = 34, `dmg_max1` = 52 WHERE (`entry` = 2877);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2877, 3596);
        -- Brocade Shoulderpads
        -- name, from Brocade Cloth Shoulderpads to Brocade Shoulderpads
        -- required_level, from 12 to 17
        -- armor, from 9 to 10
        UPDATE `item_template` SET `name` = 'Brocade Shoulderpads', `required_level` = 17, `armor` = 10 WHERE (`entry` = 1777);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1777, 3596);
        -- Hefty Battlehammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 2524);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2524, 3596);
        -- Thaumaturgist Staff
        -- dmg_min1, from 67.0 to 59
        -- dmg_max1, from 92.0 to 90
        UPDATE `item_template` SET `dmg_min1` = 59, `dmg_max1` = 90 WHERE (`entry` = 2527);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2527, 3596);
        -- Cured Leather Gloves
        -- required_level, from 12 to 17
        -- armor, from 18 to 20
        UPDATE `item_template` SET `required_level` = 17, `armor` = 20 WHERE (`entry` = 239);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (239, 3596);
        -- Fire Hardened Leggings
        -- required_level, from 19 to 24
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 20
        -- armor, from 53 to 58
        UPDATE `item_template` SET `required_level` = 24, `stat_type1` = 4, `stat_value1` = 3, `stat_type2` = 1, `stat_value2` = 20, `armor` = 58 WHERE (`entry` = 6973);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6973, 3596);
        -- Driving Gloves
        -- required_level, from 1 to 4
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 4, `armor` = 11 WHERE (`entry` = 3152);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3152, 3596);
        -- Stalvan's Reaper
        -- dmg_min1, from 43.0 to 27
        -- dmg_max1, from 65.0 to 51
        UPDATE `item_template` SET `dmg_min1` = 27, `dmg_max1` = 51 WHERE (`entry` = 934);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (934, 3596);
        -- Linked Chain Shoulderpads
        -- required_level, from 11 to 16
        -- armor, from 26 to 29
        UPDATE `item_template` SET `required_level` = 16, `armor` = 29 WHERE (`entry` = 1752);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1752, 3596);
        -- Worn Mail Bracers
        -- required_level, from 4 to 9
        -- armor, from 13 to 14
        UPDATE `item_template` SET `required_level` = 9, `armor` = 14 WHERE (`entry` = 1732);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1732, 3596);
        -- Leech Pants
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6910);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6910, 3596);
        -- Dervish Tunic
        -- display_id, from 12499 to 14773
        -- buy_price, from 6474 to 7056
        -- sell_price, from 1294 to 1411
        -- required_level, from 15 to 20
        -- armor, from 37 to 41
        UPDATE `item_template` SET `display_id` = 14773, `buy_price` = 7056, `sell_price` = 1411, `required_level` = 20, `armor` = 41 WHERE (`entry` = 6603);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6603, 3596);
        -- Battleforge Leggings
        -- required_level, from 15 to 20
        -- armor, from 48 to 53
        UPDATE `item_template` SET `required_level` = 20, `armor` = 53 WHERE (`entry` = 6596);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6596, 3596);
        -- Tempered Bracers
        -- buy_price, from 4828 to 5244
        -- sell_price, from 965 to 1048
        -- required_level, from 17 to 22
        -- stat_value2, from 0 to 5
        -- armor, from 29 to 32
        UPDATE `item_template` SET `buy_price` = 5244, `sell_price` = 1048, `required_level` = 22, `stat_value2` = 5, `armor` = 32 WHERE (`entry` = 6675);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6675, 3596);
        -- Goblin Rocket Boots
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 7189);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7189, 3596);
        -- Beerstained Gloves
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- armor, from 9 to 10
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 7, `stat_value1` = 1, `armor` = 10 WHERE (`entry` = 3565);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3565, 3596);
        -- Feathered Headdress
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 4
        -- armor, from 30 to 33
        UPDATE `item_template` SET `required_level` = 31, `stat_value1` = 4, `stat_value2` = 4, `armor` = 33 WHERE (`entry` = 3011);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3011, 3596);
        -- Glowing Thresher Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6901);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6901, 3596);
        -- Glimmering Shield
        -- required_level, from 21 to 26
        -- armor, from 67 to 107
        UPDATE `item_template` SET `required_level` = 26, `armor` = 107 WHERE (`entry` = 6400);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6400, 3596);
        -- Reinforced Woolen Shoulders
        -- required_level, from 14 to 19
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 19, `armor` = 15 WHERE (`entry` = 4315);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4315, 3596);
        -- Girdle of Nobility
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 7
        -- armor, from 7 to 8
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 7, `armor` = 8 WHERE (`entry` = 5967);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5967, 3596);
        -- Solid Shortblade
        -- required_level, from 8 to 13
        -- dmg_min1, from 30.0 to 13
        -- dmg_max1, from 37.0 to 25
        UPDATE `item_template` SET `required_level` = 13, `dmg_min1` = 13, `dmg_max1` = 25 WHERE (`entry` = 2074);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2074, 3596);
        -- Brightweave Cowl
        -- display_id, from 13534 to 15287
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 8
        -- armor, from 16 to 18
        UPDATE `item_template` SET `display_id` = 15287, `required_level` = 35, `stat_value1` = 8, `armor` = 18 WHERE (`entry` = 4041);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4041, 3596);
        -- Spirit Cloak
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 1
        -- armor, from 13 to 15
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 1, `armor` = 15 WHERE (`entry` = 4792);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4792, 3596);
        -- Glimmering Mail Boots
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        -- stat_value3, from 0 to 10
        -- armor, from 45 to 49
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 1, `stat_value2` = 10, `stat_value3` = 10, `armor` = 49 WHERE (`entry` = 4073);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4073, 3596);
        -- Glimmering Mail Gauntlets
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 3
        -- armor, from 36 to 39
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 3, `armor` = 39 WHERE (`entry` = 4072);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4072, 3596);
        -- Cuirboulli Belt
        -- required_level, from 17 to 22
        -- armor, from 15 to 17
        UPDATE `item_template` SET `required_level` = 22, `armor` = 17 WHERE (`entry` = 2142);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2142, 3596);
        -- Gnomish Zapper
        -- dmg_type1, from 6 to 2
        UPDATE `item_template` SET `dmg_type1` = 2 WHERE (`entry` = 4547);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4547, 3596);
        -- Buzzer Blade
        -- required_level, from 10 to 17
        -- dmg_min1, from 15.0 to 8
        -- dmg_max1, from 24.0 to 15
        UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 8, `dmg_max1` = 15 WHERE (`entry` = 2169);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2169, 3596);
        -- Green Iron Shoulders
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- armor, from 53 to 58
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `armor` = 58 WHERE (`entry` = 3840);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3840, 3596);
        -- Hardened Iron Shortsword
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 20
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 42.0 to 35
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 20, `dmg_min1` = 18, `dmg_max1` = 35 WHERE (`entry` = 3849);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3849, 3596);
        -- Burning Wand
        -- dmg_min1, from 24.0 to 15
        -- dmg_max1, from 36.0 to 28
        -- delay, from 2700 to 1400
        UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 28, `delay` = 1400 WHERE (`entry` = 5210);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5210, 3596);
        -- Ironspine's Fist
        -- bonding, from 1 to 2
        -- material, from 2 to 1
        UPDATE `item_template` SET `bonding` = 2, `material` = 1 WHERE (`entry` = 7687);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7687, 3596);
        -- Darkweave Boots
        -- required_level, from 25 to 30
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        -- armor, from 15 to 16
        UPDATE `item_template` SET `required_level` = 30, `stat_type1` = 5, `stat_value1` = 1, `stat_value2` = 10, `armor` = 16 WHERE (`entry` = 6406);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6406, 3596);
        -- Russet Belt
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 1
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 1, `armor` = 11 WHERE (`entry` = 3593);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3593, 3596);
        -- Cloaked Hood
        -- display_id, from 15298 to 15319
        UPDATE `item_template` SET `display_id` = 15319 WHERE (`entry` = 1280);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1280, 3596);
        -- Gray Woolen Robe
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 2
        -- armor, from 17 to 19
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 2, `armor` = 19 WHERE (`entry` = 2585);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2585, 3596);
        -- Calico Tunic
        -- name, from Calico Vest to Calico Tunic
        -- required_level, from 3 to 8
        -- armor, from 8 to 9
        UPDATE `item_template` SET `name` = 'Calico Tunic', `required_level` = 8, `armor` = 9 WHERE (`entry` = 1501);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1501, 3596);
        -- Guardian Gloves
        -- required_level, from 28 to 33
        -- armor, from 25 to 28
        UPDATE `item_template` SET `required_level` = 33, `armor` = 28 WHERE (`entry` = 5966);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5966, 3596);
        -- Rock Pulverizer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4983);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4983, 3596);
        -- Brashclaw's Zweihander
        -- required_level, from 7 to 12
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 38.0 to 25
        -- dmg_max1, from 53.0 to 38
        UPDATE `item_template` SET `required_level` = 12, `stat_value1` = 1, `dmg_min1` = 25, `dmg_max1` = 38 WHERE (`entry` = 2204);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2204, 3596);
        -- Cookie's Tenderizer
        -- required_level, from 10 to 15
        -- dmg_min1, from 32.0 to 16
        -- dmg_max1, from 48.0 to 31
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 16, `dmg_max1` = 31 WHERE (`entry` = 5197);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5197, 3596);
        -- Artisan's Trousers
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 6
        -- armor, from 20 to 22
        UPDATE `item_template` SET `required_level` = 28, `stat_value1` = 6, `armor` = 22 WHERE (`entry` = 5016);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5016, 3596);
        -- Brackclaw
        -- required_level, from 9 to 14
        -- dmg_min1, from 15.0 to 7
        -- dmg_max1, from 23.0 to 15
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 7, `dmg_max1` = 15 WHERE (`entry` = 2235);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2235, 3596);
        -- Thick Cloth Vest
        -- required_level, from 12 to 17
        -- armor, from 16 to 17
        UPDATE `item_template` SET `required_level` = 17, `armor` = 17 WHERE (`entry` = 200);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (200, 3596);
        -- Thick Cloth Belt
        -- required_level, from 12 to 17
        -- armor, from 7 to 8
        UPDATE `item_template` SET `required_level` = 17, `armor` = 8 WHERE (`entry` = 3597);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3597, 3596);
        -- Spider Silk Slippers
        -- required_level, from 18 to 23
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 10
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 1, `stat_value2` = 10, `armor` = 15 WHERE (`entry` = 4321);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4321, 3596);
        -- Grizzly Tunic
        -- display_id, from 12482 to 14068
        UPDATE `item_template` SET `display_id` = 14068 WHERE (`entry` = 7335);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7335, 3596);
        -- Tusken Helm
        -- display_id, from 13289 to 15492
        -- required_level, from 22 to 27
        -- stat_value2, from 0 to 5
        -- armor, from 41 to 45
        UPDATE `item_template` SET `display_id` = 15492, `required_level` = 27, `stat_value2` = 5, `armor` = 45 WHERE (`entry` = 6686);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6686, 3596);
        -- Thick Cloth Shoes
        -- name, from Thick Cloth Boots to Thick Cloth Shoes
        -- display_id, from 2301 to 3757
        -- required_level, from 12 to 17
        -- armor, from 11 to 12
        UPDATE `item_template` SET `name` = 'Thick Cloth Shoes', `display_id` = 3757, `required_level` = 17, `armor` = 12 WHERE (`entry` = 202);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (202, 3596);
        -- Thick Cloth Gloves
        -- required_level, from 12 to 17
        -- armor, from 9 to 10
        UPDATE `item_template` SET `required_level` = 17, `armor` = 10 WHERE (`entry` = 203);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (203, 3596);
        -- Black Duskwood Staff
        -- dmg_min1, from 49.0 to 42
        -- dmg_max1, from 67.0 to 64
        UPDATE `item_template` SET `dmg_min1` = 42, `dmg_max1` = 64 WHERE (`entry` = 937);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (937, 3596);
        -- Brightweave Robe
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 8
        -- stat_value2, from 0 to 15
        -- armor, from 26 to 29
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 8, `stat_value2` = 15, `armor` = 29 WHERE (`entry` = 6415);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6415, 3596);
        -- Training Sword
        -- required_level, from 2 to 7
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 38.0 to 27
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 18, `dmg_max1` = 27 WHERE (`entry` = 3192);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3192, 3596);
        -- Ringed Helm
        -- display_id, from 13262 to 15313
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 3
        -- armor, from 26 to 29
        UPDATE `item_template` SET `display_id` = 15313, `required_level` = 25, `stat_value1` = 3, `armor` = 29 WHERE (`entry` = 3392);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3392, 3596);
        -- Glimmering Mail Bracers
        -- required_level, from 21 to 26
        -- armor, from 29 to 32
        UPDATE `item_template` SET `required_level` = 26, `armor` = 32 WHERE (`entry` = 6387);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6387, 3596);
        -- Skeletal Gauntlets
        -- required_level, from 7 to 12
        -- armor, from 26 to 28
        UPDATE `item_template` SET `required_level` = 12, `armor` = 28 WHERE (`entry` = 4676);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4676, 3596);
        -- Flesh Piercer
        -- required_level, from 19 to 24
        -- dmg_min1, from 29.0 to 18
        -- dmg_max1, from 44.0 to 35
        UPDATE `item_template` SET `required_level` = 24, `dmg_min1` = 18, `dmg_max1` = 35 WHERE (`entry` = 3336);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3336, 3596);
        -- Scouting Buckler
        -- name, from Defender Buckler to Scouting Buckler
        -- buy_price, from 3528 to 3584
        -- sell_price, from 705 to 716
        -- required_level, from 10 to 15
        -- armor, from 39 to 49
        UPDATE `item_template` SET `name` = 'Scouting Buckler', `buy_price` = 3584, `sell_price` = 716, `required_level` = 15, `armor` = 49 WHERE (`entry` = 6571);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6571, 3596);
        -- Blackwater Cutlass
        -- required_level, from 9 to 14
        -- dmg_min1, from 23.0 to 10
        -- dmg_max1, from 29.0 to 20
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 10, `dmg_max1` = 20 WHERE (`entry` = 1951);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1951, 3596);
        -- Murloc Scale Breastplate
        -- required_level, from 9 to 14
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 1
        -- stat_type2, from 0 to 5
        -- stat_value2, from 0 to 1
        -- armor, from 32 to 35
        UPDATE `item_template` SET `required_level` = 14, `stat_type1` = 3, `stat_value1` = 1, `stat_type2` = 5, `stat_value2` = 1, `armor` = 35 WHERE (`entry` = 5781);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5781, 3596);
        -- Fight Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 7736);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7736, 3596);
        -- Wyvern Tailspike
        -- required_level, from 16 to 21
        -- dmg_min1, from 24.0 to 14
        -- dmg_max1, from 37.0 to 27
        UPDATE `item_template` SET `required_level` = 21, `dmg_min1` = 14, `dmg_max1` = 27 WHERE (`entry` = 5752);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5752, 3596);
        -- Ogremage Staff
        -- required_level, from 17 to 22
        -- dmg_min1, from 55.0 to 45
        -- dmg_max1, from 75.0 to 68
        UPDATE `item_template` SET `required_level` = 22, `dmg_min1` = 45, `dmg_max1` = 68 WHERE (`entry` = 2226);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2226, 3596);
        -- Canvas Bracers
        -- required_level, from 9 to 14
        -- armor, from 5 to 6
        UPDATE `item_template` SET `required_level` = 14, `armor` = 6 WHERE (`entry` = 3377);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3377, 3596);
        -- Infiltrator Shoulders
        -- display_id, from 11270 to 11578
        UPDATE `item_template` SET `display_id` = 11578 WHERE (`entry` = 7408);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7408, 3596);
        -- Death Speaker Mantle
        -- required_level, from 20 to 25
        -- armor, from 17 to 19
        UPDATE `item_template` SET `required_level` = 25, `armor` = 19 WHERE (`entry` = 6685);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6685, 3596);
        -- Flash Rifle
        -- required_level, from 27 to 32
        -- dmg_min1, from 20.0 to 32
        -- dmg_max1, from 31.0 to 60
        UPDATE `item_template` SET `required_level` = 32, `dmg_min1` = 32, `dmg_max1` = 60 WHERE (`entry` = 4086);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4086, 3596);
        -- Zephyr Belt
        -- buy_price, from 5355 to 5485
        -- sell_price, from 1071 to 1097
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 2
        -- armor, from 18 to 20
        UPDATE `item_template` SET `buy_price` = 5485, `sell_price` = 1097, `required_level` = 25, `stat_value1` = 2, `armor` = 20 WHERE (`entry` = 6719);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6719, 3596);
        -- Sentinel Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 7446);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7446, 3596);
        -- Gloves of Holy Might
        -- spellid_1, from 7597 to 5255
        UPDATE `item_template` SET `spellid_1` = 5255 WHERE (`entry` = 867);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (867, 3596);
        -- Blackvenom Blade
        -- dmg_min1, from 25.0 to 15
        -- dmg_max1, from 38.0 to 29
        UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 29 WHERE (`entry` = 4446);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4446, 3596);
        -- Silver-lined Bracers
        -- required_level, from 1 to 5
        -- armor, from 5 to 6
        UPDATE `item_template` SET `required_level` = 5, `armor` = 6 WHERE (`entry` = 3224);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3224, 3596);
        -- Rhahk'Zor's Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 5187);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5187, 3596);
        -- Reinforced Chain Bracers
        -- required_level, from 18 to 23
        -- armor, from 19 to 21
        UPDATE `item_template` SET `required_level` = 23, `armor` = 21 WHERE (`entry` = 1756);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1756, 3596);
        -- Sharp Axe
        -- display_id, from 1383 to 5012
        -- required_level, from 1 to 5
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 21.0 to 13
        UPDATE `item_template` SET `display_id` = 5012, `required_level` = 5, `dmg_min1` = 6, `dmg_max1` = 13 WHERE (`entry` = 1011);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1011, 3596);
        -- Ember Buckler
        -- required_level, from 24 to 29
        -- stat_value1, from 0 to 2
        -- armor, from 57 to 72
        UPDATE `item_template` SET `required_level` = 29, `stat_value1` = 2, `armor` = 72 WHERE (`entry` = 4477);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4477, 3596);
        -- Runed Copper Breastplate
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 1
        -- armor, from 47 to 52
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 1, `armor` = 52 WHERE (`entry` = 2864);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2864, 3596);
        -- Old Greatsword
        -- required_level, from 4 to 11
        -- dmg_min1, from 24.0 to 15
        -- dmg_max1, from 33.0 to 23
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 1513);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1513, 3596);
        -- Magister's Vest
        -- display_id, from 12379 to 14524
        -- required_level, from 5 to 10
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        -- armor, from 14 to 16
        UPDATE `item_template` SET `display_id` = 14524, `required_level` = 10, `stat_type1` = 6, `stat_value1` = 1, `armor` = 16 WHERE (`entry` = 2969);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2969, 3596);
        -- Smooth Walking Staff
        -- required_level, from 1 to 2
        -- dmg_min1, from 15.0 to 9
        -- dmg_max1, from 21.0 to 14
        UPDATE `item_template` SET `required_level` = 2, `dmg_min1` = 9, `dmg_max1` = 14 WHERE (`entry` = 5581);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5581, 3596);
        -- Prospector Gloves
        -- required_level, from 27 to 32
        -- stat_value2, from 0 to 2
        -- armor, from 27 to 30
        UPDATE `item_template` SET `required_level` = 32, `stat_value2` = 2, `armor` = 30 WHERE (`entry` = 4980);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4980, 3596);
        -- Smoldering Boots
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 1
        -- armor, from 12 to 14
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 1, `armor` = 14 WHERE (`entry` = 3076);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3076, 3596);
        -- Crimson Silk Shoulders
        -- display_id, from 13672 to 13673
        UPDATE `item_template` SET `display_id` = 13673 WHERE (`entry` = 7059);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7059, 3596);
        -- Moonsight Rifle
        -- required_level, from 19 to 24
        -- dmg_min1, from 14.0 to 21
        -- dmg_max1, from 21.0 to 40
        UPDATE `item_template` SET `required_level` = 24, `dmg_min1` = 21, `dmg_max1` = 40 WHERE (`entry` = 4383);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4383, 3596);
        -- Bearded Axe
        -- dmg_min1, from 24.0 to 13
        -- dmg_max1, from 37.0 to 26
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 26 WHERE (`entry` = 2878);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2878, 3596);
        -- Battering Hammer
        -- required_level, from 12 to 17
        -- dmg_min1, from 45.0 to 31
        -- dmg_max1, from 61.0 to 48
        UPDATE `item_template` SET `required_level` = 17, `dmg_min1` = 31, `dmg_max1` = 48 WHERE (`entry` = 3198);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3198, 3596);
        -- Veteran Buckler
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 4
        -- armor, from 35 to 44
        UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 1, `stat_value1` = 4, `armor` = 44 WHERE (`entry` = 3652);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3652, 3596);
        -- Fine Leather Boots
        -- required_level, from 8 to 13
        -- armor, from 20 to 22
        UPDATE `item_template` SET `required_level` = 13, `armor` = 22 WHERE (`entry` = 2307);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2307, 3596);
        -- Thick War Axe
        -- required_level, from 7 to 12
        -- dmg_min1, from 26.0 to 12
        -- dmg_max1, from 39.0 to 24
        UPDATE `item_template` SET `required_level` = 12, `dmg_min1` = 12, `dmg_max1` = 24 WHERE (`entry` = 3489);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3489, 3596);
        -- Warped Leather Boots
        -- name, from Patched Leather Boots to Warped Leather Boots
        -- required_level, from 5 to 10
        -- armor, from 12 to 14
        UPDATE `item_template` SET `name` = 'Warped Leather Boots', `required_level` = 10, `armor` = 14 WHERE (`entry` = 1503);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1503, 3596);
        -- Worn Mail Belt
        -- required_level, from 2 to 7
        -- armor, from 11 to 12
        UPDATE `item_template` SET `required_level` = 7, `armor` = 12 WHERE (`entry` = 1730);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1730, 3596);
        -- Giant Tarantula Fang
        -- required_level, from 5 to 10
        -- dmg_min1, from 13.0 to 6
        -- dmg_max1, from 20.0 to 12
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 1287);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1287, 3596);
        -- Coldridge Hammer
        -- required_level, from 2 to 7
        -- dmg_min1, from 25.0 to 16
        -- dmg_max1, from 34.0 to 24
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 16, `dmg_max1` = 24 WHERE (`entry` = 3103);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3103, 3596);
        -- Russet Vest
        -- required_level, from 27 to 32
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 4
        -- armor, from 22 to 24
        UPDATE `item_template` SET `required_level` = 32, `stat_type1` = 6, `stat_value1` = 4, `armor` = 24 WHERE (`entry` = 2429);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2429, 3596);
        -- Russet Pants
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- armor, from 19 to 21
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 4, `armor` = 21 WHERE (`entry` = 2431);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2431, 3596);
        -- Dervish Gloves
        -- display_id, from 12500 to 14775
        -- buy_price, from 2194 to 2408
        -- sell_price, from 438 to 481
        -- required_level, from 16 to 21
        -- armor, from 19 to 21
        UPDATE `item_template` SET `display_id` = 14775, `buy_price` = 2408, `sell_price` = 481, `required_level` = 21, `armor` = 21 WHERE (`entry` = 6605);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6605, 3596);
        -- Thick Murloc Armor
        -- required_level, from 24 to 29
        -- stat_value1, from 0 to 3
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 3
        -- armor, from 46 to 50
        UPDATE `item_template` SET `required_level` = 29, `stat_value1` = 3, `stat_type2` = 7, `stat_value2` = 3, `armor` = 50 WHERE (`entry` = 5782);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5782, 3596);
        -- Mail Combat Leggings
        -- required_level, from 26 to 31
        -- stat_value2, from 0 to 10
        -- armor, from 57 to 63
        UPDATE `item_template` SET `required_level` = 31, `stat_value2` = 10, `armor` = 63 WHERE (`entry` = 6402);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6402, 3596);
        -- Saber Leggings
        -- required_level, from 18 to 23
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 1
        -- stat_value3, from 0 to 20
        -- armor, from 35 to 38
        UPDATE `item_template` SET `required_level` = 23, `stat_value1` = 2, `stat_value2` = 1, `stat_value3` = 20, `armor` = 38 WHERE (`entry` = 4830);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4830, 3596);
        -- Laced Mail Bracers
        -- required_level, from 6 to 11
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 11, `armor` = 15 WHERE (`entry` = 1740);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1740, 3596);
        -- Rat Cloth Belt
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 5
        -- armor, from 6 to 7
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 5, `armor` = 7 WHERE (`entry` = 2283);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2283, 3596);
        -- Mantle of Thieves
        -- stat_value1, from 0 to 3
        -- armor, from 35 to 39
        UPDATE `item_template` SET `stat_value1` = 3, `armor` = 39 WHERE (`entry` = 2264);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2264, 3596);
        -- Flash Wand
        -- dmg_type1, from 3 to 2
        UPDATE `item_template` SET `dmg_type1` = 2 WHERE (`entry` = 5248);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5248, 3596);
        -- Guardian Armor
        -- required_level, from 25 to 30
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 7
        -- armor, from 47 to 51
        UPDATE `item_template` SET `required_level` = 30, `stat_type1` = 6, `stat_value1` = 7, `armor` = 51 WHERE (`entry` = 4256);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4256, 3596);
        -- Heavy Woolen Cloak
        -- required_level, from 10 to 15
        -- armor, from 12 to 14
        UPDATE `item_template` SET `required_level` = 15, `armor` = 14 WHERE (`entry` = 4311);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4311, 3596);
        -- Stock Shortsword
        -- name, from Short Cutlass to Stock Shortsword
        -- display_id, from 5068 to 5150
        -- required_level, from 9 to 16
        -- dmg_min1, from 12.0 to 6
        -- dmg_max1, from 19.0 to 12
        UPDATE `item_template` SET `name` = 'Stock Shortsword', `display_id` = 5150, `required_level` = 16, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 1817);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1817, 3596);
        -- Brightweave Sash
        -- required_level, from 30 to 35
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 35, `armor` = 11 WHERE (`entry` = 6418);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6418, 3596);
        -- Necrotic Wand
        -- dmg_type1, from 5 to 2
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `dmg_type1` = 2, `bonding` = 2 WHERE (`entry` = 7708);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7708, 3596);
        -- Support Girdle
        -- name, from Reinforced Belt to Support Girdle
        -- required_level, from 12 to 17
        -- armor, from 15 to 17
        UPDATE `item_template` SET `name` = 'Support Girdle', `required_level` = 17, `armor` = 17 WHERE (`entry` = 1215);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1215, 3596);
        -- Hard Crawler Carapace
        -- required_level, from 3 to 8
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 3
        -- armor, from 27 to 29
        UPDATE `item_template` SET `required_level` = 8, `stat_type1` = 1, `stat_value1` = 3, `stat_value2` = 3, `armor` = 29 WHERE (`entry` = 2087);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2087, 3596);
        -- Shadow Hood
        -- display_id, from 13549 to 15319
        -- required_level, from 24 to 29
        -- stat_value1, from 0 to 2
        -- armor, from 14 to 16
        UPDATE `item_template` SET `display_id` = 15319, `required_level` = 29, `stat_value1` = 2, `armor` = 16 WHERE (`entry` = 4323);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4323, 3596);
        -- Frostweave Boots
        -- required_level, from 21 to 26
        -- armor, from 13 to 15
        UPDATE `item_template` SET `required_level` = 26, `armor` = 15 WHERE (`entry` = 6394);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6394, 3596);
        -- Canvas Belt
        -- required_level, from 8 to 13
        -- armor, from 4 to 5
        UPDATE `item_template` SET `required_level` = 13, `armor` = 5 WHERE (`entry` = 3376);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3376, 3596);
        -- Whisperwind Headdress
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 3
        -- stat_value3, from 0 to 10
        -- armor, from 27 to 30
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 2, `stat_value2` = 3, `stat_value3` = 10, `armor` = 30 WHERE (`entry` = 6688);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6688, 3596);
        -- Soft Wool Boots
        -- buy_price, from 35 to 15
        -- sell_price, from 7 to 3
        UPDATE `item_template` SET `buy_price` = 15, `sell_price` = 3 WHERE (`entry` = 4915);
        UPDATE `applied_item_updates` SET `entry` = 4915, `version` = 3596 WHERE (`entry` = 4915);
        -- Tattered Cloth Vest
        -- armor, from 2 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 193);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (193, 3596);
        -- Tattered Cloth Belt
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3595);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3595, 3596);
        -- Tattered Cloth Pants
        -- armor, from 2 to 5
        UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 194);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (194, 3596);
        -- Tattered Cloth Bracers
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3596);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3596, 3596);
        -- Primitive Walking Stick
        -- display_id, from 5404 to 8904
        UPDATE `item_template` SET `display_id` = 8904 WHERE (`entry` = 5778);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5778, 3596);
        -- Dirty Leather Vest
        -- display_id, from 8654 to 8717
        -- armor, from 3 to 12
        UPDATE `item_template` SET `display_id` = 8717, `armor` = 12 WHERE (`entry` = 85);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (85, 3596);
        -- Dirty Leather Gloves
        -- armor, from 2 to 7
        UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 714);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (714, 3596);
        -- Tattered Cloth Gloves
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 711);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (711, 3596);
        -- Rusted Chain Vest
        -- armor, from 5 to 17
        UPDATE `item_template` SET `armor` = 17 WHERE (`entry` = 2386);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2386, 3596);
        -- Rusted Chain Belt
        -- armor, from 2 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 2387);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2387, 3596);
        -- Rusted Chain Leggings
        -- armor, from 4 to 15
        UPDATE `item_template` SET `armor` = 15 WHERE (`entry` = 2388);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2388, 3596);
        -- Rusted Chain Boots
        -- armor, from 3 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 2389);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2389, 3596);
        -- Rusted Chain Bracers
        -- armor, from 2 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2390);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2390, 3596);
        -- Rusted Chain Gloves
        -- armor, from 3 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 2391);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2391, 3596);
        -- Large Wooden Shield
        -- armor, from 4 to 19
        UPDATE `item_template` SET `armor` = 19 WHERE (`entry` = 1200);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1200, 3596);
        -- Kodo Hunter's Leggings
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 10 WHERE (`entry` = 4909);
        UPDATE `applied_item_updates` SET `entry` = 4909, `version` = 3596 WHERE (`entry` = 4909);
        -- Ring of Scorn
        -- stat_value2, from 0 to 2
        UPDATE `item_template` SET `stat_value2` = 2 WHERE (`entry` = 3235);
        UPDATE `applied_item_updates` SET `entry` = 3235, `version` = 3596 WHERE (`entry` = 3235);
        -- Poison-tipped Bone Spear
        -- spellid_1, from 16401 to 8313
        UPDATE `item_template` SET `spellid_1` = 8313 WHERE (`entry` = 1726);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1726, 3596);
        -- Faintly Glowing Skull
        -- spellid_1, from 3 to 2006
        UPDATE `item_template` SET `spellid_1` = 2006 WHERE (`entry` = 4945);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4945, 3596);
        -- Banshee Armor
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 5420);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5420, 3596);
        -- Light Chain Leggings
        -- required_level, from 1 to 5
        -- armor, from 7 to 29
        UPDATE `item_template` SET `required_level` = 5, `armor` = 29 WHERE (`entry` = 2400);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2400, 3596);
        -- Woven Bracers
        -- required_level, from 1 to 5
        -- armor, from 2 to 6
        UPDATE `item_template` SET `required_level` = 5, `armor` = 6 WHERE (`entry` = 3607);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3607, 3596);
        -- Woven Gloves
        -- required_level, from 1 to 5
        -- armor, from 2 to 6
        UPDATE `item_template` SET `required_level` = 5, `armor` = 6 WHERE (`entry` = 2369);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2369, 3596);
        -- Crude Bastard Sword
        -- required_level, from 1 to 4
        -- dmg_min1, from 13.0 to 7
        -- dmg_max1, from 18.0 to 12
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 7, `dmg_max1` = 12 WHERE (`entry` = 1412);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1412, 3596);
        -- Sturdy Cloth Trousers
        -- required_level, from 1 to 3
        -- armor, from 2 to 8
        UPDATE `item_template` SET `required_level` = 3, `armor` = 8 WHERE (`entry` = 3834);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3834, 3596);
        -- Darkwood Staff
        -- required_level, from 3 to 8
        -- dmg_min1, from 33.0 to 20
        -- dmg_max1, from 45.0 to 31
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 20, `dmg_max1` = 31, `bonding` = 2 WHERE (`entry` = 3446);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3446, 3596);
        -- Runic Loin Cloth
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- armor, from 13 to 15
        UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 7, `stat_value1` = 1, `armor` = 15 WHERE (`entry` = 3309);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3309, 3596);
        -- Reconnaissance Boots
        -- name, from Scouting Boots to Reconnaissance Boots
        -- quality, from 2 to 1
        -- buy_price, from 585 to 527
        -- sell_price, from 117 to 105
        -- item_level, from 12 to 14
        -- required_level, from 2 to 9
        -- armor, from 3 to 10
        UPDATE `item_template` SET `name` = 'Reconnaissance Boots', `quality` = 1, `buy_price` = 527, `sell_price` = 105, `item_level` = 14, `required_level` = 9, `armor` = 10 WHERE (`entry` = 3454);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3454, 3596);
        -- Pugilist Bracers
        -- stat_value1, from 0 to 3
        -- armor, from 32 to 36
        UPDATE `item_template` SET `stat_value1` = 3, `armor` = 36 WHERE (`entry` = 4438);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4438, 3596);
        -- Runic Cloth Bracers
        -- buy_price, from 651 to 566
        -- sell_price, from 130 to 113
        -- item_level, from 18 to 17
        -- required_level, from 8 to 12
        -- armor, from 2 to 8
        UPDATE `item_template` SET `buy_price` = 566, `sell_price` = 113, `item_level` = 17, `required_level` = 12, `armor` = 8 WHERE (`entry` = 3644);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3644, 3596);
        -- Woven Vest
        -- required_level, from 1 to 5
        -- armor, from 3 to 11
        UPDATE `item_template` SET `required_level` = 5, `armor` = 11 WHERE (`entry` = 2364);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2364, 3596);
        -- Light Chain Belt
        -- required_level, from 1 to 5
        -- armor, from 3 to 14
        UPDATE `item_template` SET `required_level` = 5, `armor` = 14 WHERE (`entry` = 2399);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2399, 3596);
        -- Light Chain Boots
        -- required_level, from 1 to 5
        -- armor, from 5 to 23
        UPDATE `item_template` SET `required_level` = 5, `armor` = 23 WHERE (`entry` = 2401);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2401, 3596);
        -- Heirloom Sword
        -- bonding, from 1 to 4
        UPDATE `item_template` SET `bonding` = 4 WHERE (`entry` = 7118);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7118, 3596);
        -- Vile Fin Oracle Staff
        -- required_level, from 1 to 6
        -- dmg_min1, from 18.0 to 12
        -- dmg_max1, from 25.0 to 19
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 12, `dmg_max1` = 19 WHERE (`entry` = 3327);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3327, 3596);
        -- Engineer's Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 5324);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5324, 3596);
        -- Brackwater Girdle
        -- buy_price, from 1670 to 1263
        -- sell_price, from 334 to 252
        -- item_level, from 18 to 16
        -- required_level, from 8 to 11
        -- stat_value1, from 0 to 6
        -- armor, from 6 to 21
        UPDATE `item_template` SET `buy_price` = 1263, `sell_price` = 252, `item_level` = 16, `required_level` = 11, `stat_value1` = 6, `armor` = 21 WHERE (`entry` = 4681);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4681, 3596);
        -- Ceremonial Leather Gloves
        -- required_level, from 6 to 11
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        -- armor, from 5 to 18
        UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 1, `stat_value1` = 3, `armor` = 18 WHERE (`entry` = 3314);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3314, 3596);
        -- Riveted Gauntlets
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 1 WHERE (`entry` = 5312);
        UPDATE `applied_item_updates` SET `entry` = 5312, `version` = 3596 WHERE (`entry` = 5312);
        -- Dancing Flame
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 6806);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6806, 3596);
        -- Woven Belt
        -- required_level, from 1 to 5
        -- armor, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5, `armor` = 5 WHERE (`entry` = 3606);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3606, 3596);
        -- Woven Pants
        -- required_level, from 1 to 5
        -- armor, from 3 to 10
        UPDATE `item_template` SET `required_level` = 5, `armor` = 10 WHERE (`entry` = 2366);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2366, 3596);
        -- Woven Boots
        -- required_level, from 1 to 5
        -- armor, from 2 to 8
        UPDATE `item_template` SET `required_level` = 5, `armor` = 8 WHERE (`entry` = 2367);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2367, 3596);
        -- Tiller's Vest
        -- required_level, from 1 to 6
        -- armor, from 6 to 24
        UPDATE `item_template` SET `required_level` = 6, `armor` = 24 WHERE (`entry` = 3444);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3444, 3596);
        -- Forsaken Dagger
        -- dmg_min1, from 6.0 to 2
        -- dmg_max1, from 9.0 to 5
        UPDATE `item_template` SET `dmg_min1` = 2, `dmg_max1` = 5 WHERE (`entry` = 3268);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3268, 3596);
        -- Deathguard Buckler
        -- armor, from 3 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 3276);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3276, 3596);
        -- Stamped Trousers
        -- name, from Buckled Cloth Trousers to Stamped Trousers
        -- required_level, from 7 to 13
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        -- stat_value2, from 0 to 5
        -- armor, from 5 to 15
        UPDATE `item_template` SET `name` = 'Stamped Trousers', `required_level` = 13, `stat_type1` = 1, `stat_value1` = 5, `stat_value2` = 5, `armor` = 15 WHERE (`entry` = 3457);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3457, 3596);
        -- Firewalker Boots
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 6
        -- stat_value2, from 0 to 7
        -- armor, from 12 to 14
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 6, `stat_value2` = 7, `armor` = 14 WHERE (`entry` = 6482);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6482, 3596);
        -- Dim Torch
        -- required_level, from 1 to 5
        UPDATE `item_template` SET `required_level` = 5 WHERE (`entry` = 6182);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6182, 3596);
        -- Tribal Boots
        -- required_level, from 1 to 5
        -- armor, from 4 to 15
        UPDATE `item_template` SET `required_level` = 5, `armor` = 15 WHERE (`entry` = 3284);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3284, 3596);
        -- Armor of the Fang
        -- buy_price, from 4486 to 4471
        -- sell_price, from 897 to 894
        -- required_level, from 12 to 17
        -- stat_value1, from 0 to 1
        -- stat_type2, from 0 to 4
        -- stat_value2, from 0 to 1
        -- stat_type3, from 0 to 1
        -- stat_value3, from 0 to 5
        -- armor, from 35 to 38
        UPDATE `item_template` SET `buy_price` = 4471, `sell_price` = 894, `required_level` = 17, `stat_value1` = 1, `stat_type2` = 4, `stat_value2` = 1, `stat_type3` = 1, `stat_value3` = 5, `armor` = 38 WHERE (`entry` = 6473);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6473, 3596);
        -- Cinched Belt
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        UPDATE `item_template` SET `stat_type1` = 1, `stat_value1` = 5 WHERE (`entry` = 5328);
        UPDATE `applied_item_updates` SET `entry` = 5328, `version` = 3596 WHERE (`entry` = 5328);
        -- Crescent Staff
        -- buy_price, from 16185 to 17328
        -- sell_price, from 3237 to 3465
        -- required_level, from 15 to 20
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- stat_value3, from 0 to 1
        -- dmg_min1, from 44.0 to 35
        -- dmg_max1, from 60.0 to 53
        UPDATE `item_template` SET `buy_price` = 17328, `sell_price` = 3465, `required_level` = 20, `stat_value1` = 1, `stat_value2` = 1, `stat_value3` = 1, `dmg_min1` = 35, `dmg_max1` = 53 WHERE (`entry` = 6505);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6505, 3596);
        -- Wand of Decay
        -- dmg_min1, from 16.0 to 15
        -- dmg_max1, from 31.0 to 29
        UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 29 WHERE (`entry` = 5252);
        UPDATE `applied_item_updates` SET `entry` = 5252, `version` = 3596 WHERE (`entry` = 5252);
        -- Ceremonial Leather Harness
        -- name, from Ceremonial Leather Tunic to Ceremonial Leather Harness
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 1
        -- armor, from 8 to 31
        UPDATE `item_template` SET `name` = 'Ceremonial Leather Harness', `required_level` = 10, `stat_value1` = 1, `armor` = 31 WHERE (`entry` = 3313);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3313, 3596);
        -- Patched Leather Bracers
        -- name, from Rawhide Bracers to Patched Leather Bracers
        -- required_level, from 10 to 15
        -- armor, from 10 to 12
        UPDATE `item_template` SET `name` = 'Patched Leather Bracers', `required_level` = 15, `armor` = 12 WHERE (`entry` = 1789);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1789, 3596);
        -- Laced Mail Vest
        -- required_level, from 6 to 11
        -- armor, from 28 to 31
        UPDATE `item_template` SET `required_level` = 11, `armor` = 31 WHERE (`entry` = 1745);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1745, 3596);
        -- Painted Chain Belt
        -- buy_price, from 35 to 23
        -- sell_price, from 7 to 4
        UPDATE `item_template` SET `buy_price` = 23, `sell_price` = 4 WHERE (`entry` = 4913);
        UPDATE `applied_item_updates` SET `entry` = 4913, `version` = 3596 WHERE (`entry` = 4913);
        -- Violet Scale Armor
        -- buy_price, from 6442 to 5701
        -- sell_price, from 1288 to 1140
        -- item_level, from 23 to 22
        -- required_level, from 13 to 17
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 53 to 57
        UPDATE `item_template` SET `buy_price` = 5701, `sell_price` = 1140, `item_level` = 22, `required_level` = 17, `stat_value1` = 1, `stat_value2` = 1, `armor` = 57 WHERE (`entry` = 6502);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6502, 3596);
        -- Dagmire Gauntlets
        -- buy_price, from 3041 to 3209
        -- sell_price, from 608 to 641
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 1
        -- armor, from 30 to 33
        UPDATE `item_template` SET `buy_price` = 3209, `sell_price` = 641, `required_level` = 18, `stat_value1` = 1, `armor` = 33 WHERE (`entry` = 6481);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6481, 3596);
        -- Greater Adept's Robe
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 2
        -- armor, from 18 to 20
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `armor` = 20 WHERE (`entry` = 6264);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6264, 3596);
        -- Nightglow Concoction
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 10
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 10 WHERE (`entry` = 3451);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3451, 3596);
        -- Glimmering Buckler
        -- required_level, from 22 to 27
        -- stat_value1, from 0 to 3
        -- armor, from 55 to 69
        UPDATE `item_template` SET `required_level` = 27, `stat_value1` = 3, `armor` = 69 WHERE (`entry` = 4064);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4064, 3596);
        -- Battle Chain Bracers
        -- required_level, from 1 to 5
        -- armor, from 4 to 16
        UPDATE `item_template` SET `required_level` = 5, `armor` = 16 WHERE (`entry` = 3280);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3280, 3596);
        -- Thun'grim's Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 7328);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7328, 3596);
        -- Dusk Wand
        -- dmg_min1, from 28.0 to 18
        -- dmg_max1, from 43.0 to 34
        -- delay, from 3200 to 1700
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 34, `delay` = 1700 WHERE (`entry` = 5211);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5211, 3596);
        -- Combustible Wand
        -- dmg_min1, from 36.0 to 25
        -- dmg_max1, from 54.0 to 48
        -- delay, from 3100 to 1600
        UPDATE `item_template` SET `dmg_min1` = 25, `dmg_max1` = 48, `delay` = 1600 WHERE (`entry` = 5236);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5236, 3596);
        -- Pitchwood Wand
        -- dmg_min1, from 59.0 to 36
        -- dmg_max1, from 89.0 to 68
        -- delay, from 3200 to 1700
        UPDATE `item_template` SET `dmg_min1` = 36, `dmg_max1` = 68, `delay` = 1700 WHERE (`entry` = 5238);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5238, 3596);
        -- Blackbone Wand
        -- dmg_min1, from 59.0 to 35
        -- dmg_max1, from 89.0 to 66
        -- delay, from 3100 to 1600
        UPDATE `item_template` SET `dmg_min1` = 35, `dmg_max1` = 66, `delay` = 1600 WHERE (`entry` = 5239);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5239, 3596);
        -- Magus Long Staff
        -- dmg_min1, from 95.0 to 86
        -- dmg_max1, from 129.0 to 130
        UPDATE `item_template` SET `dmg_min1` = 86, `dmg_max1` = 130 WHERE (`entry` = 2535);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2535, 3596);
        -- Engineer's Cloak
        -- buy_price, from 4828 to 4962
        -- sell_price, from 965 to 992
        -- required_level, from 17 to 22
        -- stat_type1, from 0 to 5
        -- armor, from 15 to 16
        UPDATE `item_template` SET `buy_price` = 4962, `sell_price` = 992, `required_level` = 22, `stat_type1` = 5, `armor` = 16 WHERE (`entry` = 6667);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6667, 3596);
        -- Summoner's Wand
        -- dmg_type1, from 6 to 2
        UPDATE `item_template` SET `dmg_type1` = 2 WHERE (`entry` = 5245);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5245, 3596);
        -- Tablet of Verga
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6535);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6535, 3596);
        -- Ceremonial Knife
        -- required_level, from 2 to 9
        -- dmg_min1, from 10.0 to 4
        -- dmg_max1, from 15.0 to 9
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 3445);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3445, 3596);
        -- Glowing Lizardscale Cloak
        -- armor, from 27 to 30
        -- material, from 7 to 8
        UPDATE `item_template` SET `armor` = 30, `material` = 8 WHERE (`entry` = 6449);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6449, 3596);
        -- Spiked Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4564);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4564, 3596);
        -- Stinging Mace
        -- display_id, from 5009 to 5410
        -- dmg_max1, from 15.0 to 16
        UPDATE `item_template` SET `display_id` = 5410, `dmg_max1` = 16 WHERE (`entry` = 4948);
        UPDATE `applied_item_updates` SET `entry` = 4948, `version` = 3596 WHERE (`entry` = 4948);
        -- Bound Harness
        -- name, from Strapped Leather Armor to Bound Harness
        -- required_level, from 1 to 6
        -- armor, from 22 to 24
        UPDATE `item_template` SET `name` = 'Bound Harness', `required_level` = 6, `armor` = 24 WHERE (`entry` = 4968);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4968, 3596);
        -- Dreamwatcher Staff
        -- dmg_min1, from 12.0 to 15
        -- dmg_max1, from 18.0 to 23
        UPDATE `item_template` SET `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 4961);
        UPDATE `applied_item_updates` SET `entry` = 4961, `version` = 3596 WHERE (`entry` = 4961);
        -- Ceremonial Leather Loin Cloth
        -- name, from Ceremonial Leather Pants to Ceremonial Leather Loin Cloth
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- armor, from 8 to 29
        UPDATE `item_template` SET `name` = 'Ceremonial Leather Loin Cloth', `required_level` = 12, `stat_type1` = 5, `stat_value1` = 1, `armor` = 29 WHERE (`entry` = 3315);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3315, 3596);
        -- Demon Scarred Cloak
        -- item_level, from 11 to 12
        UPDATE `item_template` SET `item_level` = 12 WHERE (`entry` = 4854);
        UPDATE `applied_item_updates` SET `entry` = 4854, `version` = 3596 WHERE (`entry` = 4854);
        -- Zombie Skin Boots
        -- required_level, from 1 to 3
        -- armor, from 3 to 12
        UPDATE `item_template` SET `required_level` = 3, `armor` = 12 WHERE (`entry` = 3439);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3439, 3596);
        -- Zombie Skin Bracers
        -- required_level, from 1 to 4
        -- armor, from 2 to 10
        UPDATE `item_template` SET `required_level` = 4, `armor` = 10 WHERE (`entry` = 3435);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3435, 3596);
        -- Steel-clasped Bracers
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 2
        UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 2 WHERE (`entry` = 4534);
        UPDATE `applied_item_updates` SET `entry` = 4534, `version` = 3596 WHERE (`entry` = 4534);
        -- Talonstrike
        -- dmg_min1, from 13.0 to 11
        -- dmg_max1, from 21.0 to 22
        UPDATE `item_template` SET `dmg_min1` = 11, `dmg_max1` = 22 WHERE (`entry` = 3462);
        UPDATE `applied_item_updates` SET `entry` = 3462, `version` = 3596 WHERE (`entry` = 3462);
        -- Monkey Ring
        -- required_level, from 21 to 26
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 8
        UPDATE `item_template` SET `required_level` = 26, `stat_value1` = 2, `stat_value2` = 8 WHERE (`entry` = 6748);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6748, 3596);
        -- Girdle of the Blindwatcher
        -- required_level, from 14 to 19
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- armor, from 16 to 18
        UPDATE `item_template` SET `required_level` = 19, `stat_type1` = 5, `stat_value1` = 1, `armor` = 18 WHERE (`entry` = 6319);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6319, 3596);
        -- Sword of Hammerfall
        -- sheath, from 3 to 1
        UPDATE `item_template` SET `sheath` = 1 WHERE (`entry` = 4977);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4977, 3596);
        -- Dredge Boots
        -- buy_price, from 4055 to 4152
        -- sell_price, from 811 to 830
        -- required_level, from 12 to 17
        -- stat_value2, from 0 to 5
        -- armor, from 36 to 39
        UPDATE `item_template` SET `buy_price` = 4152, `sell_price` = 830, `required_level` = 17, `stat_value2` = 5, `armor` = 39 WHERE (`entry` = 6666);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6666, 3596);
        -- Feyscale Cloak
        -- material, from 7 to 5
        UPDATE `item_template` SET `material` = 5 WHERE (`entry` = 6632);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6632, 3596);
        -- Robe of the Moccasin
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 1
        -- armor, from 17 to 19
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1, `stat_value2` = 1, `armor` = 19 WHERE (`entry` = 6465);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6465, 3596);
        -- Glyphs of Summoning
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 7464);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7464, 3596);
        -- Flax Gloves
        -- armor, from 1 to 2
        UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 3275);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3275, 3596);
        -- Brackwater Leggings
        -- required_level, from 7 to 12
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- armor, from 11 to 44
        UPDATE `item_template` SET `required_level` = 12, `stat_type1` = 7, `stat_value1` = 1, `armor` = 44 WHERE (`entry` = 3305);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3305, 3596);
        -- Compact Fighting Knife
        -- display_id, from 3006 to 6432
        -- bonding, from 1 to 3
        UPDATE `item_template` SET `display_id` = 6432, `bonding` = 3 WHERE (`entry` = 4974);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4974, 3596);
        -- Painted Chain Gloves
        -- buy_price, from 38 to 16
        -- sell_price, from 7 to 3
        UPDATE `item_template` SET `buy_price` = 16, `sell_price` = 3 WHERE (`entry` = 4910);
        UPDATE `applied_item_updates` SET `entry` = 4910, `version` = 3596 WHERE (`entry` = 4910);
        -- Nomadic Vest
        -- buy_price, from 65 to 43
        -- sell_price, from 13 to 8
        UPDATE `item_template` SET `buy_price` = 43, `sell_price` = 8 WHERE (`entry` = 6059);
        UPDATE `applied_item_updates` SET `entry` = 6059, `version` = 3596 WHERE (`entry` = 6059);
        -- Nomadic Belt
        -- buy_price, from 30 to 13
        -- sell_price, from 6 to 2
        UPDATE `item_template` SET `buy_price` = 13, `sell_price` = 2 WHERE (`entry` = 4954);
        UPDATE `applied_item_updates` SET `entry` = 4954, `version` = 3596 WHERE (`entry` = 4954);
        -- Shiver Blade
        -- required_level, from 10 to 15
        -- dmg_min1, from 38.0 to 26
        -- dmg_max1, from 53.0 to 40
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 26, `dmg_max1` = 40 WHERE (`entry` = 5182);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5182, 3596);
        -- Windstorm Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6804);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6804, 3596);
        -- Wispy Cloak
        -- armor, from 2 to 5
        UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 3322);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3322, 3596);
        -- Harvest Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 4771);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4771, 3596);
        -- Quilted Bracers
        -- name, from Crochet Bracers to Quilted Bracers
        -- required_level, from 1 to 7
        -- armor, from 2 to 6
        UPDATE `item_template` SET `name` = 'Quilted Bracers', `required_level` = 7, `armor` = 6 WHERE (`entry` = 3453);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3453, 3596);
        -- Savage Trodders
        -- required_level, from 12 to 17
        -- stat_type1, from 0 to 4
        -- stat_type2, from 0 to 1
        -- stat_value2, from 0 to 5
        -- armor, from 36 to 39
        UPDATE `item_template` SET `required_level` = 17, `stat_type1` = 4, `stat_type2` = 1, `stat_value2` = 5, `armor` = 39 WHERE (`entry` = 6459);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6459, 3596);
        -- Medicine Staff
        -- required_level, from 2 to 7
        -- dmg_min1, from 23.0 to 15
        -- dmg_max1, from 32.0 to 23
        UPDATE `item_template` SET `required_level` = 7, `dmg_min1` = 15, `dmg_max1` = 23 WHERE (`entry` = 4575);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4575, 3596);
        -- Sewing Gloves
        -- required_level, from 1 to 3
        -- armor, from 3 to 10
        UPDATE `item_template` SET `required_level` = 3, `armor` = 10 WHERE (`entry` = 5939);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5939, 3596);
        -- Double-bladed Axe
        -- dmg_min1, from 20.0 to 13
        -- dmg_max1, from 28.0 to 21
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 21 WHERE (`entry` = 2499);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2499, 3596);
        -- Wooden Warhammer
        -- dmg_min1, from 19.0 to 13
        -- dmg_max1, from 26.0 to 20
        UPDATE `item_template` SET `dmg_min1` = 13, `dmg_max1` = 20 WHERE (`entry` = 2501);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2501, 3596);
        -- Canvas Scraps
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 4870);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4870, 3596);
        -- Forsaken Shortsword
        -- dmg_min1, from 8.0 to 3
        -- dmg_max1, from 12.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 6 WHERE (`entry` = 3267);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3267, 3596);
        -- Flax Boots
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3274);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3274, 3596);
        -- Zombie Skin Leggings
        -- armor, from 3 to 8
        UPDATE `item_template` SET `armor` = 8 WHERE (`entry` = 3272);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3272, 3596);
        -- Brackwater Vest
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 1
        -- armor, from 11 to 47
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 1, `armor` = 47 WHERE (`entry` = 3306);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3306, 3596);
        -- Brackwater Buckler
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 3
        -- armor, from 7 to 40
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 3, `armor` = 40 WHERE (`entry` = 3653);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3653, 3596);
        -- Forester's Axe
        -- required_level, from 13 to 18
        -- dmg_min1, from 30.0 to 16
        -- dmg_max1, from 45.0 to 31
        UPDATE `item_template` SET `required_level` = 18, `dmg_min1` = 16, `dmg_max1` = 31 WHERE (`entry` = 790);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (790, 3596);
        -- Sword of the Night Sky
        -- required_level, from 14 to 19
        -- dmg_min1, from 22.0 to 12
        -- dmg_max1, from 33.0 to 23
        UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 12, `dmg_max1` = 23 WHERE (`entry` = 2035);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2035, 3596);
        -- Privateer Musket
        -- dmg_min1, from 12.0 to 18
        -- dmg_max1, from 24.0 to 34
        UPDATE `item_template` SET `dmg_min1` = 18, `dmg_max1` = 34 WHERE (`entry` = 5309);
        UPDATE `applied_item_updates` SET `entry` = 5309, `version` = 3596 WHERE (`entry` = 5309);
        -- Ferine Leggings
        -- name, from Ferine Swine Leggings to Ferine Leggings
        -- required_level, from 23 to 28
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 4
        -- armor, from 39 to 43
        UPDATE `item_template` SET `name` = 'Ferine Leggings', `required_level` = 28, `stat_value1` = 3, `stat_value2` = 4, `armor` = 43 WHERE (`entry` = 6690);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6690, 3596);
        -- Black Wolf Bracers
        -- required_level, from 16 to 21
        -- armor, from 19 to 21
        UPDATE `item_template` SET `required_level` = 21, `armor` = 21 WHERE (`entry` = 3230);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3230, 3596);
        -- Insignia Bracers
        -- required_level, from 26 to 31
        -- armor, from 22 to 24
        UPDATE `item_template` SET `required_level` = 31, `armor` = 24 WHERE (`entry` = 6410);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6410, 3596);
        -- Welding Shield
        -- required_level, from 6 to 11
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 5
        -- armor, from 58 to 84
        UPDATE `item_template` SET `required_level` = 11, `stat_type1` = 1, `stat_value1` = 5, `armor` = 84 WHERE (`entry` = 5325);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5325, 3596);
        -- Nomadic Bracers
        -- buy_price, from 32 to 21
        -- sell_price, from 6 to 4
        UPDATE `item_template` SET `buy_price` = 21, `sell_price` = 4 WHERE (`entry` = 4908);
        UPDATE `applied_item_updates` SET `entry` = 4908, `version` = 3596 WHERE (`entry` = 4908);
        -- Canvas Shoes
        -- name, from Canvas Boots to Canvas Shoes
        -- display_id, from 1861 to 4143
        -- required_level, from 7 to 12
        UPDATE `item_template` SET `name` = 'Canvas Shoes', `display_id` = 4143, `required_level` = 12 WHERE (`entry` = 1764);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1764, 3596);
        -- Brackwater Bracers
        -- required_level, from 5 to 10
        -- armor, from 5 to 21
        UPDATE `item_template` SET `required_level` = 10, `armor` = 21 WHERE (`entry` = 3303);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3303, 3596);
        -- Sylvan Cloak
        -- required_level, from 14 to 19
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 8
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 19, `stat_type1` = 1, `stat_value1` = 8, `armor` = 15 WHERE (`entry` = 4793);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4793, 3596);
        -- Ceremonial Leather Ankleguards
        -- name, from Ceremonial Leather Boots to Ceremonial Leather Ankleguards
        -- buy_price, from 1932 to 1460
        -- sell_price, from 386 to 292
        -- item_level, from 18 to 16
        -- required_level, from 8 to 11
        -- stat_value1, from 0 to 5
        -- armor, from 6 to 22
        UPDATE `item_template` SET `name` = 'Ceremonial Leather Ankleguards', `buy_price` = 1460, `sell_price` = 292, `item_level` = 16, `required_level` = 11, `stat_value1` = 5, `armor` = 22 WHERE (`entry` = 3311);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3311, 3596);
        -- Deviate Scale Gloves
        -- required_level, from 11 to 16
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 1
        -- armor, from 19 to 21
        UPDATE `item_template` SET `required_level` = 16, `stat_type1` = 5, `stat_value1` = 1, `armor` = 21 WHERE (`entry` = 6467);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6467, 3596);
        -- Seedcloud Buckler
        -- stat_type1, from 0 to 6
        -- armor, from 52 to 62
        UPDATE `item_template` SET `stat_type1` = 6, `armor` = 62 WHERE (`entry` = 6630);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6630, 3596);
        -- Adept's Gloves
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 3
        -- armor, from 8 to 9
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 3, `armor` = 9 WHERE (`entry` = 4768);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4768, 3596);
        -- Fine Leather Pants
        -- required_level, from 11 to 16
        -- stat_value1, from 0 to 1
        -- armor, from 30 to 33
        UPDATE `item_template` SET `required_level` = 16, `stat_value1` = 1, `armor` = 33 WHERE (`entry` = 5958);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5958, 3596);
        -- Buckskin Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 1355);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1355, 3596);
        -- Bloody Apron
        -- required_level, from 12 to 17
        -- stat_value1, from 0 to 2
        -- armor, from 17 to 19
        UPDATE `item_template` SET `required_level` = 17, `stat_value1` = 2, `armor` = 19 WHERE (`entry` = 6226);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6226, 3596);
        -- Burnished Buckler
        -- required_level, from 10 to 15
        -- stat_type1, from 0 to 3
        -- armor, from 39 to 49
        UPDATE `item_template` SET `required_level` = 15, `stat_type1` = 3, `armor` = 49 WHERE (`entry` = 6380);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6380, 3596);
        -- Grunt Axe
        -- required_level, from 4 to 9
        -- dmg_min1, from 20.0 to 10
        -- dmg_max1, from 31.0 to 19
        UPDATE `item_template` SET `required_level` = 9, `dmg_min1` = 10, `dmg_max1` = 19 WHERE (`entry` = 4568);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4568, 3596);
        -- Glinting Scale Gloves
        -- required_level, from 17 to 22
        -- armor, from 30 to 32
        UPDATE `item_template` SET `required_level` = 22, `armor` = 32 WHERE (`entry` = 3047);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3047, 3596);
        -- Turtle Shell Shield
        -- buy_price, from 2605 to 2810
        -- sell_price, from 521 to 562
        -- required_level, from 10 to 15
        -- armor, from 48 to 78
        UPDATE `item_template` SET `buy_price` = 2810, `sell_price` = 562, `required_level` = 15, `armor` = 78 WHERE (`entry` = 6447);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6447, 3596);
        -- Brass Scale Pants
        -- required_level, from 1 to 6
        -- armor, from 7 to 31
        UPDATE `item_template` SET `required_level` = 6, `armor` = 31 WHERE (`entry` = 5941);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5941, 3596);
        -- Fireproof Orb
        -- fire_res, from 6 to 4
        UPDATE `item_template` SET `fire_res` = 4 WHERE (`entry` = 4836);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4836, 3596);
        -- Assassin's Blade
        -- dmg_min1, from 25.0 to 14
        -- dmg_max1, from 39.0 to 27
        UPDATE `item_template` SET `dmg_min1` = 14, `dmg_max1` = 27 WHERE (`entry` = 1935);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1935, 3596);
        -- Owl's Disk
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 1
        -- armor, from 43 to 54
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 1, `armor` = 54 WHERE (`entry` = 4822);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4822, 3596);
        -- Heavy Spiked Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4778);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4778, 3596);
        -- Cryptwalker Boots
        -- required_level, from 1 to 3
        -- armor, from 4 to 18
        UPDATE `item_template` SET `required_level` = 3, `armor` = 18 WHERE (`entry` = 3447);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3447, 3596);
        -- Runic Cloth Vest
        -- required_level, from 5 to 10
        -- stat_value1, from 0 to 1
        -- armor, from 5 to 16
        UPDATE `item_template` SET `required_level` = 10, `stat_value1` = 1, `armor` = 16 WHERE (`entry` = 3310);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3310, 3596);
        -- Green Woolen Vest
        -- required_level, from 7 to 12
        -- armor, from 14 to 15
        UPDATE `item_template` SET `required_level` = 12, `armor` = 15 WHERE (`entry` = 2582);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2582, 3596);
        -- Pysan's Old Greatsword
        -- stat_value1, from 0 to 4
        -- dmg_min1, from 58.0 to 48
        -- dmg_max1, from 79.0 to 72
        UPDATE `item_template` SET `stat_value1` = 4, `dmg_min1` = 48, `dmg_max1` = 72 WHERE (`entry` = 1975);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1975, 3596);
        -- Umbral Sword
        -- name, from Grey Iron Sword to Umbral Sword
        -- required_level, from 5 to 10
        -- dmg_min1, from 20.0 to 9
        -- dmg_max1, from 30.0 to 18
        UPDATE `item_template` SET `name` = 'Umbral Sword', `required_level` = 10, `dmg_min1` = 9, `dmg_max1` = 18 WHERE (`entry` = 6984);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6984, 3596);
        -- Gold-plated Buckler
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 5443);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5443, 3596);
        -- Oiled Blunderbuss
        -- required_level, from 19 to 26
        -- dmg_min1, from 10.0 to 16
        -- dmg_max1, from 16.0 to 30
        UPDATE `item_template` SET `required_level` = 26, `dmg_min1` = 16, `dmg_max1` = 30 WHERE (`entry` = 2786);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2786, 3596);
        -- Dirty Blunderbuss
        -- required_level, from 8 to 15
        -- dmg_min1, from 8.0 to 10
        -- dmg_max1, from 13.0 to 19
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 10, `dmg_max1` = 19 WHERE (`entry` = 2781);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2781, 3596);
        -- Laced Mail Gloves
        -- required_level, from 8 to 13
        -- armor, from 17 to 18
        UPDATE `item_template` SET `required_level` = 13, `armor` = 18 WHERE (`entry` = 1742);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1742, 3596);
        -- Shadowhide Two-handed Sword
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 38.0 to 26
        -- dmg_max1, from 53.0 to 40
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 1, `dmg_min1` = 26, `dmg_max1` = 40 WHERE (`entry` = 1460);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1460, 3596);
        -- Lancer Boots
        -- required_level, from 20 to 25
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 20
        -- armor, from 29 to 31
        UPDATE `item_template` SET `required_level` = 25, `stat_value1` = 1, `stat_value2` = 20, `armor` = 31 WHERE (`entry` = 6752);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6752, 3596);
        -- Whirlwind Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6976);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6976, 3596);
        -- Huge Ogre Sword
        -- required_level, from 19 to 24
        -- stat_value1, from 0 to 5
        -- dmg_min1, from 64.0 to 55
        -- dmg_max1, from 87.0 to 83
        UPDATE `item_template` SET `required_level` = 24, `stat_value1` = 5, `dmg_min1` = 55, `dmg_max1` = 83 WHERE (`entry` = 913);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (913, 3596);
        -- Ratty Old Belt
        -- required_level, from 1 to 5
        -- armor, from 9 to 10
        UPDATE `item_template` SET `required_level` = 5, `armor` = 10 WHERE (`entry` = 6147);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6147, 3596);
        -- Venom Web Fang
        -- required_level, from 9 to 14
        -- dmg_min1, from 16.0 to 8
        -- dmg_max1, from 25.0 to 16
        UPDATE `item_template` SET `required_level` = 14, `dmg_min1` = 8, `dmg_max1` = 16 WHERE (`entry` = 899);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (899, 3596);
        -- Web-covered Boots
        -- required_level, from 1 to 5
        -- armor, from 7 to 8
        UPDATE `item_template` SET `required_level` = 5, `armor` = 8 WHERE (`entry` = 6148);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6148, 3596);
        -- Butcher's Slicer
        -- required_level, from 11 to 16
        -- dmg_min1, from 38.0 to 18
        -- dmg_max1, from 48.0 to 34
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 18, `dmg_max1` = 34 WHERE (`entry` = 6633);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6633, 3596);
        -- Heavy Copper Broadsword
        -- required_level, from 9 to 16
        -- dmg_min1, from 31.0 to 21
        -- dmg_max1, from 43.0 to 32
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 21, `dmg_max1` = 32 WHERE (`entry` = 3487);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3487, 3596);
        -- Barbaric Harness
        -- required_level, from 28 to 33
        -- stat_value1, from 0 to 5
        -- armor, from 45 to 50
        UPDATE `item_template` SET `required_level` = 33, `stat_value1` = 5, `armor` = 50 WHERE (`entry` = 5739);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5739, 3596);
        -- Siege Brigade Vest
        -- required_level, from 1 to 5
        -- armor, from 30 to 33
        UPDATE `item_template` SET `required_level` = 5, `armor` = 33 WHERE (`entry` = 3151);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3151, 3596);
        -- Calico Bracers
        -- required_level, from 2 to 7
        UPDATE `item_template` SET `required_level` = 7 WHERE (`entry` = 3375);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3375, 3596);
        -- Rectangular Shield
        -- required_level, from 7 to 12
        -- armor, from 30 to 52
        UPDATE `item_template` SET `required_level` = 12, `armor` = 52 WHERE (`entry` = 2217);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2217, 3596);
        -- Phoenix Gloves
        -- required_level, from 15 to 20
        -- armor, from 10 to 11
        UPDATE `item_template` SET `required_level` = 20, `armor` = 11 WHERE (`entry` = 4331);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4331, 3596);
        -- Stormsnout Blood Vials
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5143);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5143, 3596);
        -- Avenger's Armor
        -- name, from Captain's Armor to Avenger's Armor
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 30
        -- armor, from 64 to 70
        UPDATE `item_template` SET `name` = 'Avenger\'s Armor', `stat_value1` = 4, `stat_value2` = 30, `armor` = 70 WHERE (`entry` = 1488);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1488, 3596);
        -- Warped Leather Bracers
        -- name, from Patched Leather Bracers to Warped Leather Bracers
        -- required_level, from 1 to 6
        UPDATE `item_template` SET `name` = 'Warped Leather Bracers', `required_level` = 6 WHERE (`entry` = 1504);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1504, 3596);
        -- Vile Protector
        -- spellid_1, from 7619 to 7618
        UPDATE `item_template` SET `spellid_1` = 7618 WHERE (`entry` = 7747);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7747, 3596);
        -- Swiftrunner Cape
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 6745);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6745, 3596);
        -- Slaghammer
        -- stat_value1, from 0 to 3
        -- stat_value2, from 0 to 5
        -- dmg_min1, from 49.0 to 42
        -- dmg_max1, from 67.0 to 64
        UPDATE `item_template` SET `stat_value1` = 3, `stat_value2` = 5, `dmg_min1` = 42, `dmg_max1` = 64 WHERE (`entry` = 1976);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1976, 3596);
        -- Crude Pocket Watch
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5427);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5427, 3596);
        -- Combat Buckler
        -- required_level, from 25 to 30
        -- stat_type2, from 0 to 7
        -- stat_value2, from 0 to 2
        -- armor, from 59 to 74
        UPDATE `item_template` SET `required_level` = 30, `stat_type2` = 7, `stat_value2` = 2, `armor` = 74 WHERE (`entry` = 4066);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4066, 3596);
        -- Massive Iron Axe
        -- required_level, from 27 to 32
        -- stat_value1, from 0 to 4
        -- stat_value2, from 0 to 5
        -- dmg_min1, from 80.0 to 71
        -- dmg_max1, from 109.0 to 107
        UPDATE `item_template` SET `required_level` = 32, `stat_value1` = 4, `stat_value2` = 5, `dmg_min1` = 71, `dmg_max1` = 107 WHERE (`entry` = 3855);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3855, 3596);
        -- Black Bear Hide Vest
        -- required_level, from 2 to 7
        -- armor, from 23 to 25
        UPDATE `item_template` SET `required_level` = 7, `armor` = 25 WHERE (`entry` = 2069);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2069, 3596);
        -- Slick Deviate Leggings
        -- required_level, from 10 to 15
        -- stat_value1, from 0 to 2
        -- armor, from 29 to 32
        UPDATE `item_template` SET `required_level` = 15, `stat_value1` = 2, `armor` = 32 WHERE (`entry` = 6480);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6480, 3596);
        -- Skorn's Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4971);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4971, 3596);
        -- Laced Mail Boots
        -- required_level, from 10 to 15
        -- armor, from 22 to 24
        UPDATE `item_template` SET `required_level` = 15, `armor` = 24 WHERE (`entry` = 1739);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1739, 3596);
        -- Demolition Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 5322);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5322, 3596);
        -- Short Bastard Sword
        -- buy_price, from 5247 to 3168
        -- sell_price, from 1049 to 633
        -- dmg_min1, from 20.0 to 17
        -- dmg_max1, from 31.0 to 27
        UPDATE `item_template` SET `buy_price` = 3168, `sell_price` = 633, `dmg_min1` = 17, `dmg_max1` = 27 WHERE (`entry` = 4567);
        UPDATE `applied_item_updates` SET `entry` = 4567, `version` = 3596 WHERE (`entry` = 4567);
        -- Clasped Belt
        -- required_level, from 1 to 3
        -- armor, from 3 to 12
        UPDATE `item_template` SET `required_level` = 3, `armor` = 12 WHERE (`entry` = 3437);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3437, 3596);
        -- Bone Buckler
        -- required_level, from 2 to 7
        -- armor, from 6 to 28
        UPDATE `item_template` SET `required_level` = 7, `armor` = 28 WHERE (`entry` = 5940);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5940, 3596);
        -- Warped Leather Pants
        -- name, from Patched Leather Pants to Warped Leather Pants
        -- required_level, from 4 to 9
        -- armor, from 15 to 17
        UPDATE `item_template` SET `name` = 'Warped Leather Pants', `required_level` = 9, `armor` = 17 WHERE (`entry` = 1507);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1507, 3596);
        -- Thornspike
        -- required_level, from 20 to 27
        -- dmg_min1, from 23.0 to 15
        -- dmg_max1, from 35.0 to 28
        UPDATE `item_template` SET `required_level` = 27, `dmg_min1` = 15, `dmg_max1` = 28 WHERE (`entry` = 6681);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6681, 3596);
        -- Heirloom  Axe
        -- bonding, from 1 to 4
        UPDATE `item_template` SET `bonding` = 4 WHERE (`entry` = 7115);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7115, 3596);
        -- Blue Leather Bag
        -- item_level, from 15 to 10
        UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 856);
        UPDATE `applied_item_updates` SET `entry` = 856, `version` = 3596 WHERE (`entry` = 856);
        -- Runescale Girdle
        -- required_level, from 10 to 15
        -- armor, from 22 to 24
        UPDATE `item_template` SET `required_level` = 15, `armor` = 24 WHERE (`entry` = 5425);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5425, 3596);
        -- Patched Leather Boots
        -- name, from Rawhide Boots to Patched Leather Boots
        -- display_id, from 3712 to 703
        -- required_level, from 9 to 14
        -- armor, from 14 to 15
        UPDATE `item_template` SET `name` = 'Patched Leather Boots', `display_id` = 703, `required_level` = 14, `armor` = 15 WHERE (`entry` = 1788);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1788, 3596);
        -- Stretched Leather Trousers
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 1
        UPDATE `item_template` SET `stat_type1` = 6, `stat_value1` = 1 WHERE (`entry` = 2818);
        UPDATE `applied_item_updates` SET `entry` = 2818, `version` = 3596 WHERE (`entry` = 2818);
        -- Nether Bracers
        -- material, from 5 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 5943);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5943, 3596);
        -- Morbid Dawn
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `bonding` = 2 WHERE (`entry` = 7689);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7689, 3596);
        -- Sleek Feathered Tunic
        -- quality, from 2 to 1
        -- buy_price, from 596 to 275
        -- sell_price, from 119 to 55
        UPDATE `item_template` SET `quality` = 1, `buy_price` = 275, `sell_price` = 55 WHERE (`entry` = 4861);
        UPDATE `applied_item_updates` SET `entry` = 4861, `version` = 3596 WHERE (`entry` = 4861);
        -- Rock Mace
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 1382);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1382, 3596);
        -- Webbed Pants
        -- armor, from 2 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 3263);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3263, 3596);
        -- Solliden's Trousers
        -- required_level, from 1 to 3
        -- armor, from 2 to 8
        UPDATE `item_template` SET `required_level` = 3, `armor` = 8 WHERE (`entry` = 4261);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4261, 3596);
        -- Forsaken Bastard Sword
        -- name, from Forsaken Broadsword to Forsaken Bastard Sword
        -- dmg_min1, from 14.0 to 8
        -- dmg_max1, from 20.0 to 13
        UPDATE `item_template` SET `name` = 'Forsaken Bastard Sword', `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 5779);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5779, 3596);
        -- Nondescript Letter
        -- description, from A sealed letter to A sealed letter addressed to Rupert Downes
        UPDATE `item_template` SET `description` = 'A sealed letter addressed to Rupert Downes' WHERE (`entry` = 7628);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7628, 3596);
        -- Weathered Belt
        -- required_level, from 2 to 7
        -- armor, from 3 to 11
        UPDATE `item_template` SET `required_level` = 7, `armor` = 11 WHERE (`entry` = 3583);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3583, 3596);
        -- Ghostly Bracers
        -- required_level, from 1 to 3
        -- armor, from 1 to 4
        UPDATE `item_template` SET `required_level` = 3, `armor` = 4 WHERE (`entry` = 3323);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3323, 3596);
        -- Thistlewood Axe
        -- dmg_min1, from 6.0 to 8
        -- dmg_max1, from 9.0 to 13
        UPDATE `item_template` SET `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 1386);
        UPDATE `applied_item_updates` SET `entry` = 1386, `version` = 3596 WHERE (`entry` = 1386);
        -- Webwood Venom Sac
        -- display_id, from 4045 to 6427
        UPDATE `item_template` SET `display_id` = 6427 WHERE (`entry` = 5166);
        UPDATE `applied_item_updates` SET `entry` = 5166, `version` = 3596 WHERE (`entry` = 5166);
        -- Emblazoned Belt
        -- required_level, from 21 to 26
        -- armor, from 17 to 19
        UPDATE `item_template` SET `required_level` = 26, `armor` = 19 WHERE (`entry` = 6398);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6398, 3596);
        -- Heavy Blasting Powder
        -- display_id, from 1297 to 7372
        UPDATE `item_template` SET `display_id` = 7372 WHERE (`entry` = 4377);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4377, 3596);
        -- Oily Blackmouth
        -- display_id, from 9150 to 11450
        UPDATE `item_template` SET `display_id` = 11450 WHERE (`entry` = 6358);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6358, 3596);
        -- Phoenix Pants
        -- required_level, from 15 to 20
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 2
        -- stat_value2, from 0 to 1
        -- armor, from 16 to 18
        UPDATE `item_template` SET `required_level` = 20, `stat_type1` = 5, `stat_value1` = 2, `stat_value2` = 1, `armor` = 18 WHERE (`entry` = 4317);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4317, 3596);
        -- Light Hunting Bow
        -- required_level, from 9 to 16
        -- dmg_min1, from 6.0 to 8
        -- dmg_max1, from 10.0 to 15
        UPDATE `item_template` SET `required_level` = 16, `dmg_min1` = 8, `dmg_max1` = 15 WHERE (`entry` = 2780);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2780, 3596);
        -- Small Dagger
        -- required_level, from 8 to 15
        -- dmg_min1, from 9.0 to 4
        -- dmg_max1, from 14.0 to 9
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 4, `dmg_max1` = 9 WHERE (`entry` = 2764);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2764, 3596);
        -- Russet Gloves
        -- required_level, from 27 to 32
        -- armor, from 13 to 14
        UPDATE `item_template` SET `required_level` = 32, `armor` = 14 WHERE (`entry` = 2434);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2434, 3596);
        -- Recipe: Dig Rat Stew
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5487);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5487, 3596);
        -- Dig Rat Stew
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5478);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5478, 3596);
        -- Cloudscraper Wings
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5164);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5164, 3596);
        -- Ceremonial Tomahawk
        -- dmg_min1, from 4.0 to 5
        -- dmg_max1, from 9.0 to 10
        UPDATE `item_template` SET `dmg_min1` = 5, `dmg_max1` = 10 WHERE (`entry` = 3443);
        UPDATE `applied_item_updates` SET `entry` = 3443, `version` = 3596 WHERE (`entry` = 3443);
        -- Sillithid Ichor
        -- display_id, from 2885 to 3325
        UPDATE `item_template` SET `display_id` = 3325 WHERE (`entry` = 5269);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5269, 3596);
        -- Soulstone
        -- spellid_1, from 20707 to 3026
        UPDATE `item_template` SET `spellid_1` = 3026 WHERE (`entry` = 5232);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5232, 3596);
        -- Bronze Axe
        -- display_id, from 8474 to 8496
        -- required_level, from 13 to 20
        -- dmg_min1, from 24.0 to 13
        -- dmg_max1, from 36.0 to 25
        UPDATE `item_template` SET `display_id` = 8496, `required_level` = 20, `dmg_min1` = 13, `dmg_max1` = 25 WHERE (`entry` = 2849);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2849, 3596);
        -- Pattern: Blue Linen Vest
        -- quality, from 1 to 2
        UPDATE `item_template` SET `quality` = 2 WHERE (`entry` = 6270);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6270, 3596);
        -- Canvas Cloak
        -- required_level, from 8 to 13
        UPDATE `item_template` SET `required_level` = 13 WHERE (`entry` = 1766);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1766, 3596);
        -- Ken'zigla's Draught
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6624);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6624, 3596);
        -- White Leather Jerkin
        -- required_level, from 3 to 8
        -- armor, from 24 to 27
        UPDATE `item_template` SET `required_level` = 8, `armor` = 27 WHERE (`entry` = 2311);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2311, 3596);
        -- Moonsteel Broadsword
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 6
        -- stat_value2, from 0 to 25
        -- dmg_min1, from 61.0 to 54
        -- dmg_max1, from 83.0 to 81
        UPDATE `item_template` SET `required_level` = 31, `stat_value1` = 6, `stat_value2` = 25, `dmg_min1` = 54, `dmg_max1` = 81 WHERE (`entry` = 3853);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3853, 3596);
        -- Dirt-caked Pendant
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6625);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6625, 3596);
        -- Dogran's Pendant
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6626);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6626, 3596);
        -- Sporid Cape
        -- display_id, from 12597 to 15236
        -- required_level, from 12 to 17
        -- stat_type1, from 0 to 7
        -- armor, from 13 to 14
        UPDATE `item_template` SET `display_id` = 15236, `required_level` = 17, `stat_type1` = 7, `armor` = 14 WHERE (`entry` = 6629);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6629, 3596);
        -- Strong Troll's Blood Potion
        -- required_level, from 25 to 15
        UPDATE `item_template` SET `required_level` = 15 WHERE (`entry` = 3388);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3388, 3596);
        -- Runed Silver Rod
        -- description, from  to Used to permanently enchant powerful items.
        UPDATE `item_template` SET `description` = 'Used to permanently enchant powerful items.' WHERE (`entry` = 6339);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6339, 3596);
        -- Canvas Gloves
        -- required_level, from 9 to 14
        UPDATE `item_template` SET `required_level` = 14 WHERE (`entry` = 1767);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1767, 3596);
        -- Linked Chain Bracers
        -- required_level, from 12 to 17
        -- armor, from 17 to 18
        UPDATE `item_template` SET `required_level` = 17, `armor` = 18 WHERE (`entry` = 1748);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1748, 3596);
        -- Kobold Excavation Pick
        -- required_level, from 1 to 4
        -- dmg_min1, from 12.0 to 5
        -- dmg_max1, from 18.0 to 11
        UPDATE `item_template` SET `required_level` = 4, `dmg_min1` = 5, `dmg_max1` = 11 WHERE (`entry` = 778);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (778, 3596);
        -- Pressed Felt Robe
        -- armor, from 23 to 25
        UPDATE `item_template` SET `armor` = 25 WHERE (`entry` = 1997);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1997, 3596);
        -- Rawhide Belt
        -- name, from Tough Leather Belt to Rawhide Belt
        -- required_level, from 14 to 19
        -- armor, from 10 to 11
        UPDATE `item_template` SET `name` = 'Rawhide Belt', `required_level` = 19, `armor` = 11 WHERE (`entry` = 1795);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1795, 3596);
        -- Wildwood Chain
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 7336);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7336, 3596);
        -- Tough Leather Shoulderpads
        -- name, from Hardened Leather Shoulderpads to Tough Leather Shoulderpads
        -- required_level, from 16 to 21
        -- armor, from 19 to 21
        UPDATE `item_template` SET `name` = 'Tough Leather Shoulderpads', `required_level` = 21, `armor` = 21 WHERE (`entry` = 1809);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1809, 3596);
        -- Heirloom Mace
        -- allowable_race, from 255 to 511
        -- bonding, from 1 to 4
        -- material, from 2 to 1
        UPDATE `item_template` SET `allowable_race` = 511, `bonding` = 4, `material` = 1 WHERE (`entry` = 7117);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7117, 3596);
        -- Scholarly Robes
        -- buy_price, from 4583 to 5179
        -- sell_price, from 916 to 1035
        -- item_level, from 24 to 25
        -- required_level, from 14 to 20
        -- stat_value1, from 0 to 3
        -- armor, from 18 to 20
        UPDATE `item_template` SET `buy_price` = 5179, `sell_price` = 1035, `item_level` = 25, `required_level` = 20, `stat_value1` = 3, `armor` = 20 WHERE (`entry` = 2034);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2034, 3596);
        -- Duskbringer
        -- stat_value1, from 0 to 1
        -- stat_value2, from 0 to 3
        -- dmg_min1, from 54.0 to 43
        -- dmg_max1, from 74.0 to 65
        UPDATE `item_template` SET `stat_value1` = 1, `stat_value2` = 3, `dmg_min1` = 43, `dmg_max1` = 65 WHERE (`entry` = 2205);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2205, 3596);
        -- Bruiser Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 4439);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4439, 3596);
        -- Redridge Machete
        -- required_level, from 6 to 11
        -- dmg_min1, from 23.0 to 11
        -- dmg_max1, from 35.0 to 21
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 11, `dmg_max1` = 21 WHERE (`entry` = 1219);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1219, 3596);
        -- Whirlwind Axe
        -- stat_value2, from 0 to 30
        -- dmg_min1, from 98.0 to 89
        -- dmg_max1, from 133.0 to 134
        UPDATE `item_template` SET `stat_value2` = 30, `dmg_min1` = 89, `dmg_max1` = 134 WHERE (`entry` = 6975);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6975, 3596);
        -- Bluegill Breeches
        -- required_level, from 13 to 18
        -- stat_value1, from 0 to 2
        -- armor, from 31 to 34
        UPDATE `item_template` SET `required_level` = 18, `stat_value1` = 2, `armor` = 34 WHERE (`entry` = 3022);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3022, 3596);
        -- Executioner's Sword
        -- required_level, from 21 to 19
        -- stat_value2, from 0 to 2
        -- dmg_min1, from 51.0 to 39
        -- dmg_max1, from 70.0 to 59
        UPDATE `item_template` SET `required_level` = 19, `stat_value2` = 2, `dmg_min1` = 39, `dmg_max1` = 59 WHERE (`entry` = 4818);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4818, 3596);
        -- Singed Scale
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6486);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6486, 3596);
        -- Spider Belt
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 25
        -- armor, from 10 to 12
        UPDATE `item_template` SET `required_level` = 31, `stat_value1` = 25, `armor` = 12 WHERE (`entry` = 4328);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4328, 3596);
        -- Black Metal Axe
        -- required_level, from 14 to 19
        -- dmg_min1, from 27.0 to 15
        -- dmg_max1, from 41.0 to 29
        UPDATE `item_template` SET `required_level` = 19, `dmg_min1` = 15, `dmg_max1` = 29 WHERE (`entry` = 885);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (885, 3596);
        -- Guardian Belt
        -- required_level, from 24 to 29
        -- stat_type1, from 0 to 5
        -- stat_value1, from 0 to 2
        -- armor, from 20 to 22
        UPDATE `item_template` SET `required_level` = 29, `stat_type1` = 5, `stat_value1` = 2, `armor` = 22 WHERE (`entry` = 4258);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4258, 3596);
        -- Swampchill Fetish
        -- spellid_1, from 9402 to 7703
        -- spellid_2, from 9412 to 7709
        UPDATE `item_template` SET `spellid_1` = 7703, `spellid_2` = 7709 WHERE (`entry` = 1992);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1992, 3596);
        -- Ritual Blade
        -- required_level, from 5 to 10
        -- dmg_min1, from 12.0 to 6
        -- dmg_max1, from 18.0 to 12
        UPDATE `item_template` SET `required_level` = 10, `dmg_min1` = 6, `dmg_max1` = 12 WHERE (`entry` = 5112);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5112, 3596);
        -- Redleaf Tuber
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5876);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5876, 3596);
        -- Crate With Holes
        -- description, from  to Something in this crate is moving...
        UPDATE `item_template` SET `description` = 'Something in this crate is moving...' WHERE (`entry` = 5880);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5880, 3596);
        -- Strike of the Hydra
        -- spellid_1, from 13526 to 8739
        -- bonding, from 1 to 2
        UPDATE `item_template` SET `spellid_1` = 8739, `bonding` = 2 WHERE (`entry` = 6909);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6909, 3596);
        -- Laced Mail Pants
        -- required_level, from 9 to 14
        -- armor, from 27 to 30
        UPDATE `item_template` SET `required_level` = 14, `armor` = 30 WHERE (`entry` = 1743);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1743, 3596);
        -- Gerenzo's Mechanical Arm
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5736);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5736, 3596);
        -- Blessed Claymore
        -- name, from Champion's Claymore to Blessed Claymore
        -- required_level, from 19 to 17
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 36.0 to 25
        -- dmg_max1, from 49.0 to 39
        UPDATE `item_template` SET `name` = 'Blessed Claymore', `required_level` = 17, `stat_value1` = 1, `dmg_min1` = 25, `dmg_max1` = 39 WHERE (`entry` = 4817);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4817, 3596);
        -- Rawhide Cloak
        -- material, from 7 to 8
        UPDATE `item_template` SET `material` = 8 WHERE (`entry` = 1798);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1798, 3596);
        -- Letter to Jin'Zil
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5594);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5594, 3596);
        -- Blue Linen Vest
        -- required_level, from 2 to 7
        -- stat_type1, from 0 to 1
        -- stat_value1, from 0 to 3
        -- armor, from 4 to 14
        UPDATE `item_template` SET `required_level` = 7, `stat_type1` = 1, `stat_value1` = 3, `armor` = 14 WHERE (`entry` = 6240);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6240, 3596);
        -- Omega Orb
        -- spellid_1, from 9416 to 9396
        -- sheath, from 7 to 2
        UPDATE `item_template` SET `spellid_1` = 9396, `sheath` = 2 WHERE (`entry` = 7749);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7749, 3596);
        -- Deathstalker Shortsword
        -- required_level, from 1 to 8
        -- dmg_min1, from 15.0 to 7
        -- dmg_max1, from 19.0 to 13
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 7, `dmg_max1` = 13 WHERE (`entry` = 3455);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3455, 3596);
        -- Nitroglycerin
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5017);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5017, 3596);
        -- Wood Pulp
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5018);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5018, 3596);
        -- Sodium Nitrate
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5019);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5019, 3596);
        -- Hardwood Cudgel
        -- required_level, from 10 to 15
        -- dmg_min1, from 29.0 to 15
        -- dmg_max1, from 45.0 to 29
        UPDATE `item_template` SET `required_level` = 15, `dmg_min1` = 15, `dmg_max1` = 29 WHERE (`entry` = 5757);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5757, 3596);
        -- Big Iron Fishing Pole
        -- dmg_min1, from 12.0 to 3
        -- dmg_max1, from 15.0 to 7
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 7 WHERE (`entry` = 6367);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6367, 3596);
        -- Stone Club
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 3787);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3787, 3596);
        -- Burnished Gold Key
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 3499);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3499, 3596);
        -- Kodo Skin Scroll
        -- description, from  to WRITE THIS!
        UPDATE `item_template` SET `description` = 'WRITE THIS!' WHERE (`entry` = 5838);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5838, 3596);
        -- Deino's Flask
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 7269);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7269, 3596);
        -- Shadowgem Shard
        -- display_id, from 3307 to 6689
        UPDATE `item_template` SET `display_id` = 6689 WHERE (`entry` = 3176);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3176, 3596);
        -- Briarthorn
        -- buy_price, from 100 to 12
        -- sell_price, from 25 to 3
        UPDATE `item_template` SET `buy_price` = 12, `sell_price` = 3 WHERE (`entry` = 2450);
        UPDATE `applied_item_updates` SET `entry` = 2450, `version` = 3596 WHERE (`entry` = 2450);
        -- Razorflank's Heart
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 5793);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5793, 3596);
        -- Warped Leather Vest
        -- name, from Patched Leather Vest to Warped Leather Vest
        -- required_level, from 1 to 6
        -- armor, from 15 to 17
        UPDATE `item_template` SET `name` = 'Warped Leather Vest', `required_level` = 6, `armor` = 17 WHERE (`entry` = 1509);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1509, 3596);
        -- Short Sabre
        -- required_level, from 1 to 6
        -- dmg_min1, from 10.0 to 5
        -- dmg_max1, from 16.0 to 10
        UPDATE `item_template` SET `required_level` = 6, `dmg_min1` = 5, `dmg_max1` = 10 WHERE (`entry` = 3319);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3319, 3596);
        -- Cloak of Blight
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6832);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6832, 3596);
        -- Barbaric Belt
        -- required_level, from 30 to 35
        -- armor, from 23 to 25
        UPDATE `item_template` SET `required_level` = 35, `armor` = 25 WHERE (`entry` = 4264);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4264, 3596);
        -- Noble's Robe
        -- required_level, from 8 to 13
        -- stat_value1, from 0 to 1
        -- armor, from 16 to 17
        UPDATE `item_template` SET `required_level` = 13, `stat_value1` = 1, `armor` = 17 WHERE (`entry` = 3019);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3019, 3596);
        -- Frost Tiger Blade
        -- required_level, from 30 to 35
        -- stat_value1, from 0 to 9
        -- dmg_min1, from 88.0 to 80
        -- dmg_max1, from 120.0 to 121
        UPDATE `item_template` SET `required_level` = 35, `stat_value1` = 9, `dmg_min1` = 80, `dmg_max1` = 121 WHERE (`entry` = 3854);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3854, 3596);
        -- Defias Mage Staff
        -- required_level, from 6 to 11
        -- stat_value1, from 0 to 1
        -- dmg_min1, from 32.0 to 20
        -- dmg_max1, from 44.0 to 31
        UPDATE `item_template` SET `required_level` = 11, `stat_value1` = 1, `dmg_min1` = 20, `dmg_max1` = 31 WHERE (`entry` = 1928);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1928, 3596);
        -- Embroidered Hat
        -- display_id, from 13228 to 15908
        -- required_level, from 40 to 45
        -- stat_type1, from 0 to 6
        -- stat_value1, from 0 to 4
        -- armor, from 17 to 19
        UPDATE `item_template` SET `display_id` = 15908, `required_level` = 45, `stat_type1` = 6, `stat_value1` = 4, `armor` = 19 WHERE (`entry` = 3892);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3892, 3596);
        -- Stone Tomahawk
        -- dmg_min1, from 2.0 to 3
        -- dmg_max1, from 5.0 to 6
        UPDATE `item_template` SET `dmg_min1` = 3, `dmg_max1` = 6 WHERE (`entry` = 1383);
        UPDATE `applied_item_updates` SET `entry` = 1383, `version` = 3596 WHERE (`entry` = 1383);
        -- Cane of Elders
        -- dmg_min1, from 5.0 to 8
        -- dmg_max1, from 8.0 to 13
        UPDATE `item_template` SET `dmg_min1` = 8, `dmg_max1` = 13 WHERE (`entry` = 5776);
        UPDATE `applied_item_updates` SET `entry` = 5776, `version` = 3596 WHERE (`entry` = 5776);
        -- Cured Light Hide
        -- display_id, from 5086 to 6655
        UPDATE `item_template` SET `display_id` = 6655 WHERE (`entry` = 4231);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4231, 3596);
        -- Cured Heavy Hide
        -- display_id, from 3164 to 7347
        UPDATE `item_template` SET `display_id` = 7347 WHERE (`entry` = 4236);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4236, 3596);
        -- Insignia Belt
        -- required_level, from 26 to 31
        -- stat_value1, from 0 to 1
        -- armor, from 19 to 21
        UPDATE `item_template` SET `required_level` = 31, `stat_value1` = 1, `armor` = 21 WHERE (`entry` = 6409);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6409, 3596);
        -- Staff of the Shade
        -- dmg_min1, from 44.0 to 36
        -- dmg_max1, from 60.0 to 55
        UPDATE `item_template` SET `dmg_min1` = 36, `dmg_max1` = 55 WHERE (`entry` = 2549);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2549, 3596);
        -- Guardsman Belt
        -- required_level, from 14 to 19
        -- armor, from 16 to 18
        UPDATE `item_template` SET `required_level` = 19, `armor` = 18 WHERE (`entry` = 3429);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3429, 3596);
        -- Bronze Shortsword
        -- required_level, from 14 to 21
        -- dmg_min1, from 24.0 to 14
        -- dmg_max1, from 37.0 to 26
        UPDATE `item_template` SET `required_level` = 21, `dmg_min1` = 14, `dmg_max1` = 26 WHERE (`entry` = 2850);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2850, 3596);
        -- Horn of the Black Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 1041);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1041, 3596);
        -- Horn of the Gray Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 1134);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1134, 3596);
        -- Horn of the Brown Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 1132);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1132, 3596);
        -- Horn of the Winter Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 1133);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1133, 3596);
        -- Horn of the Dark Gray Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 5665);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5665, 3596);
        -- Horn of the Dark Brown Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 5668);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5668, 3596);
        -- Horn of the Red Wolf
        -- allowable_race, from 223 to 415
        -- bonding, from 3 to 1
        UPDATE `item_template` SET `allowable_race` = 415, `bonding` = 1 WHERE (`entry` = 5663);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5663, 3596);
        -- Bear Buckler
        -- required_level, from 13 to 18
        -- stat_type1, from 0 to 4
        -- stat_value1, from 0 to 1
        -- armor, from 43 to 54
        UPDATE `item_template` SET `required_level` = 18, `stat_type1` = 4, `stat_value1` = 1, `armor` = 54 WHERE (`entry` = 4821);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4821, 3596);
        -- Flawed Power Stone
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 4986);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4986, 3596);
        -- Robe of Power
        -- spellid_1, from 9343 to 8752
        UPDATE `item_template` SET `spellid_1` = 8752 WHERE (`entry` = 7054);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7054, 3596);
        -- Cross-stitched Bracers
        -- required_level, from 18 to 23
        -- armor, from 6 to 7
        UPDATE `item_template` SET `required_level` = 23, `armor` = 7 WHERE (`entry` = 3381);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3381, 3596);
        -- Tortoise Armor
        -- bonding, from 1 to 2
        -- material, from 5 to 8
        UPDATE `item_template` SET `bonding` = 2, `material` = 8 WHERE (`entry` = 6907);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6907, 3596);
        -- Cheap Blunderbuss
        -- required_level, from 3 to 10
        -- dmg_max1, from 11.0 to 15
        UPDATE `item_template` SET `required_level` = 10, `dmg_max1` = 15 WHERE (`entry` = 2778);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2778, 3596);
        -- Logsplitter
        -- required_level, from 6 to 11
        -- dmg_min1, from 42.0 to 26
        -- dmg_max1, from 57.0 to 40
        UPDATE `item_template` SET `required_level` = 11, `dmg_min1` = 26, `dmg_max1` = 40 WHERE (`entry` = 3586);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3586, 3596);
        -- 3734
        -- Test Stationery
        -- sell_price, from 2 to 5
        UPDATE `item_template` SET `sell_price` = 5 WHERE (`entry` = 8164);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (8164, 3734);
        -- Juggernaut Leggings
        -- sell_price, from 2068 to 5170
        -- armor, from 56 to 165
        UPDATE `item_template` SET `sell_price` = 5170, `armor` = 165 WHERE (`entry` = 6671);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6671, 3734);
        -- Schematic: Flash Bomb
        -- sell_price, from 500 to 1000
        UPDATE `item_template` SET `sell_price` = 1000 WHERE (`entry` = 6672);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6672, 3734);
        -- Constable Buckler
        -- subclass, from 5 to 6
        -- sell_price, from 2245 to 5614
        -- sheath, from 4 to 7
        UPDATE `item_template` SET `subclass` = 6, `sell_price` = 5614, `sheath` = 7 WHERE (`entry` = 6676);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6676, 3734);
        -- Elixir of Giant Growth
        -- sell_price, from 95 to 190
        UPDATE `item_template` SET `sell_price` = 190 WHERE (`entry` = 6662);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6662, 3734);
        -- Recipe: Elixir of Giant Growth
        -- sell_price, from 150 to 300
        UPDATE `item_template` SET `sell_price` = 300 WHERE (`entry` = 6663);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6663, 3734);
        -- Sacred Band
        -- sell_price, from 1378 to 2757
        UPDATE `item_template` SET `sell_price` = 2757 WHERE (`entry` = 6669);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6669, 3734);
        -- Savory Deviate Delight
        -- sell_price, from 5 to 10
        UPDATE `item_template` SET `sell_price` = 10 WHERE (`entry` = 6657);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6657, 3734);
        -- Huge Brown Sack
        -- sell_price, from 25000 to 50000
        UPDATE `item_template` SET `sell_price` = 50000 WHERE (`entry` = 4499);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4499, 3734);
        -- Dog Whistle
        -- sell_price, from 6375 to 12750
        UPDATE `item_template` SET `sell_price` = 12750 WHERE (`entry` = 3456);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3456, 3734);
        -- 3810
        -- Tribal Warrior's Shield
        -- armor, from 54 to 131
        UPDATE `item_template` SET `armor` = 131 WHERE (`entry` = 4967);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4967, 3810);
        -- Buckled Harness
        -- armor, from 30 to 67
        UPDATE `item_template` SET `armor` = 67 WHERE (`entry` = 6523);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6523, 3810);
        -- Frayed Pants
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1378);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1378, 3810);
        -- Heavy Cord Bracers
        -- armor, from 6 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 6062);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6062, 3810);
        -- Frayed Gloves
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 1377);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1377, 3810);
        -- Handsewn Cloak
        -- armor, from 10 to 18
        UPDATE `item_template` SET `armor` = 18 WHERE (`entry` = 4944);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4944, 3810);
        -- Cliff Runner Boots
        -- armor, from 23 to 40
        UPDATE `item_template` SET `armor` = 40 WHERE (`entry` = 4972);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4972, 3810);
        -- Animal Skin Belt
        -- armor, from 8 to 12
        UPDATE `item_template` SET `armor` = 12 WHERE (`entry` = 5936);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5936, 3810);
        -- Rough-hewn Kodo Leggings
        -- armor, from 17 to 28
        UPDATE `item_template` SET `armor` = 28 WHERE (`entry` = 4970);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4970, 3810);
        -- Battered Leather Boots
        -- display_id, from 14461 to 17158
        -- armor, from 15 to 25
        UPDATE `item_template` SET `display_id` = 17158, `armor` = 25 WHERE (`entry` = 2373);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2373, 3810);
        -- Plains Hunter Wristguards
        -- armor, from 11 to 18
        UPDATE `item_template` SET `armor` = 18 WHERE (`entry` = 4973);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4973, 3810);
        -- Battered Leather Bracers
        -- display_id, from 14462 to 17002
        -- armor, from 11 to 18
        UPDATE `item_template` SET `display_id` = 17002, `armor` = 18 WHERE (`entry` = 2374);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2374, 3810);
        -- Battered Leather Gloves
        -- display_id, from 14463 to 17051
        -- armor, from 12 to 20
        UPDATE `item_template` SET `display_id` = 17051, `armor` = 20 WHERE (`entry` = 2375);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2375, 3810);
        -- Rainwalker Boots
        -- armor, from 11 to 16
        UPDATE `item_template` SET `armor` = 16 WHERE (`entry` = 4906);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4906, 3810);
        -- Dirty Leather Boots
        -- armor, from 8 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 210);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (210, 3810);
        -- Dirty Leather Pants
        -- armor, from 10 to 13
        UPDATE `item_template` SET `armor` = 13 WHERE (`entry` = 209);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (209, 3810);
        -- Battered Leather Belt
        -- display_id, from 14460 to 17114
        -- armor, from 10 to 16
        UPDATE `item_template` SET `display_id` = 17114, `armor` = 16 WHERE (`entry` = 2371);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2371, 3810);
        -- Roamer's Leggings
        -- armor, from 58 to 21
        UPDATE `item_template` SET `armor` = 21 WHERE (`entry` = 11852);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (11852, 3810);
        -- Buckled Boots
        -- armor, from 26 to 62
        UPDATE `item_template` SET `armor` = 62 WHERE (`entry` = 5311);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5311, 3810);
        -- Acolyte's Pants
        -- armor, from 1 to 2
        UPDATE `item_template` SET `armor` = 2 WHERE (`entry` = 1396);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1396, 3810);
        -- Scarlet Initiate Robes
        -- armor, from 8 to 7
        UPDATE `item_template` SET `armor` = 7 WHERE (`entry` = 3260);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3260, 3810);
        -- 3925
        -- Frayed Belt
        -- armor, from 1 to 5
        UPDATE `item_template` SET `armor` = 5 WHERE (`entry` = 3363);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3363, 3925);
        -- Recruit's Pants
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 6121);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6121, 3925);
        -- Neophyte's Pants
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 52);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (52, 3925);
        -- Novice's Robe
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 6123);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6123, 3925);
        -- Novice's Pants
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 6124);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6124, 3925);
        -- Ragged Leather Pants
        -- armor, from 2 to 10
        UPDATE `item_template` SET `armor` = 10 WHERE (`entry` = 1366);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1366, 3925);
        -- Rugged Trapper's Pants
        -- armor, from 2 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 147);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (147, 3925);
        -- Woodland Tunic
        -- armor, from 12 to 30
        UPDATE `item_template` SET `armor` = 30 WHERE (`entry` = 4907);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4907, 3925);
        -- Sedgeweed Britches
        -- armor, from 9 to 13
        UPDATE `item_template` SET `armor` = 13 WHERE (`entry` = 10655);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (10655, 3925);
        -- Thin Cloth Bracers
        -- armor, from 3 to 6
        UPDATE `item_template` SET `armor` = 6 WHERE (`entry` = 3600);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3600, 3925);
        -- Cracked Leather Belt
        -- armor, from 5 to 17
        UPDATE `item_template` SET `armor` = 17 WHERE (`entry` = 2122);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2122, 3925);
        -- Woodland Shield
        -- armor, from 19 to 38
        UPDATE `item_template` SET `armor` = 38 WHERE (`entry` = 5395);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5395, 3925);
        -- Footpad's Pants
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 48);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (48, 3925);
        -- Neophyte's Robe
        -- armor, from 1 to 3
        UPDATE `item_template` SET `armor` = 3 WHERE (`entry` = 6119);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6119, 3925);
        -- Thin Cloth Gloves
        -- armor, from 3 to 9
        UPDATE `item_template` SET `armor` = 9 WHERE (`entry` = 2119);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2119, 3925);
        -- Handstitched Leather Bracers
        -- armor, from 8 to 18
        UPDATE `item_template` SET `armor` = 18 WHERE (`entry` = 7277);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7277, 3925);
        -- Snapped Spider Limb
        -- name, from Small Spider Limb to Snapped Spider Limb
        UPDATE `item_template` SET `name` = 'Snapped Spider Limb' WHERE (`entry` = 1476);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1476, 3925);
        -- Webwood Egg
        -- display_id, from 13663 to 18047
        UPDATE `item_template` SET `display_id` = 18047 WHERE (`entry` = 5167);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5167, 3925);
        -- Kaldorei Spider Kabob
        -- name, from Kaldorei Caviar to Kaldorei Spider Kabob
        UPDATE `item_template` SET `name` = 'Kaldorei Spider Kabob' WHERE (`entry` = 5472);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5472, 3925);
        -- Sleeping Robes
        -- armor, from 19 to 30
        UPDATE `item_template` SET `armor` = 30 WHERE (`entry` = 9598);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9598, 3925);
        -- Gypsy Sash
        -- armor, from 33 to 38
        UPDATE `item_template` SET `armor` = 38 WHERE (`entry` = 9750);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9750, 3925);
        -- Gypsy Sandals
        -- armor, from 40 to 47
        UPDATE `item_template` SET `armor` = 47 WHERE (`entry` = 9751);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9751, 3925);
        -- Lace Pants
        -- armor, from 19 to 30
        UPDATE `item_template` SET `armor` = 30 WHERE (`entry` = 9600);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9600, 3925);
        -- Small Egg
        -- display_id, from 13211 to 18046
        UPDATE `item_template` SET `display_id` = 18046 WHERE (`entry` = 6889);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6889, 3925);
        -- Jester's Cord
        -- name, from Simple Cord to Jester's Cord
        -- display_id, from 14710 to 16565
        -- armor, from 12 to 19
        UPDATE `item_template` SET `name` = 'Jester\'s Cord', `display_id` = 16565, `armor` = 19 WHERE (`entry` = 9742);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9742, 3925);
        -- Kresh's Back
        -- armor, from 471 to 330
        UPDATE `item_template` SET `armor` = 330 WHERE (`entry` = 13245);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (13245, 3925);
        -- Silithid Egg
        -- name, from Sillithid Egg to Silithid Egg
        UPDATE `item_template` SET `name` = 'Silithid Egg' WHERE (`entry` = 5058);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5058, 3925);
        -- Rough Copper Vest
        -- armor, from 81 to 65
        UPDATE `item_template` SET `armor` = 65 WHERE (`entry` = 10421);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (10421, 3925);
        -- Fire Wand
        -- name, from Bent Fire Wand to Fire Wand
        -- quality, from 1 to 2
        -- flags, from 272 to 256
        -- buy_price, from 13 to 1465
        -- sell_price, from 2 to 293
        -- item_level, from 1 to 12
        -- required_level, from 1 to 7
        -- dmg_min1, from 7.0 to 9.0
        -- dmg_max1, from 11.0 to 17.0
        -- delay, from 2800 to 1500
        UPDATE `item_template` SET `name` = 'Fire Wand', `quality` = 2, `flags` = 256, `buy_price` = 1465, `sell_price` = 293, `item_level` = 12, `required_level` = 7, `dmg_min1` = 9.0, `dmg_max1` = 17.0, `delay` = 1500 WHERE (`entry` = 5069);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5069, 3925);
        -- Rugged Leather Pants
        -- buy_price, from 749 to 814
        -- sell_price, from 149 to 162
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 1
        -- armor, from 23 to 58
        UPDATE `item_template` SET `buy_price` = 814, `sell_price` = 162, `stat_type1` = 7, `stat_value1` = 1, `armor` = 58 WHERE (`entry` = 7280);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7280, 3925);
        -- Gypsy Cloak
        -- armor, from 10 to 16
        -- material, from 7 to 8
        UPDATE `item_template` SET `armor` = 16, `material` = 8 WHERE (`entry` = 9754);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9754, 3925);
        -- Ruffled Feather
        -- buy_price, from 215 to 165
        -- sell_price, from 53 to 41
        UPDATE `item_template` SET `buy_price` = 165, `sell_price` = 41 WHERE (`entry` = 4776);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4776, 3925);
        -- Jester's Cape
        -- name, from Simple Cape to Jester's Cape
        -- display_id, from 27533 to 15109
        -- armor, from 10 to 16
        UPDATE `item_template` SET `name` = 'Jester\'s Cape', `display_id` = 15109, `armor` = 16 WHERE (`entry` = 9745);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9745, 3925);
        -- Gypsy Trousers
        -- armor, from 60 to 72
        UPDATE `item_template` SET `armor` = 72 WHERE (`entry` = 9756);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9756, 3925);
        -- Simple Linen Pants
        -- armor, from 12 to 18
        UPDATE `item_template` SET `armor` = 18 WHERE (`entry` = 10045);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (10045, 3925);
        -- Simple Linen Boots
        -- armor, from 11 to 18
        UPDATE `item_template` SET `armor` = 18 WHERE (`entry` = 10046);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (10046, 3925);
        -- Horn of Vorlus
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6805);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6805, 3925);
        -- Sathrah's Sacrifice
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 8155);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (8155, 3925);
        -- Bandit Cloak
        -- display_id, from 28433 to 23005
        -- buy_price, from 1671 to 2090
        -- sell_price, from 334 to 418
        -- armor, from 16 to 26
        -- material, from 7 to 8
        UPDATE `item_template` SET `display_id` = 23005, `buy_price` = 2090, `sell_price` = 418, `armor` = 26, `material` = 8 WHERE (`entry` = 9779);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9779, 3925);
        -- Gypsy Tunic
        -- armor, from 70 to 87
        UPDATE `item_template` SET `armor` = 87 WHERE (`entry` = 9757);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9757, 3925);
        -- Patched Leather Jerkin
        -- armor, from 70 to 86
        UPDATE `item_template` SET `armor` = 86 WHERE (`entry` = 1794);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1794, 3925);
        -- Druidic Cloak
        -- name, from Greenweave Cloak to Druidic Cloak
        -- buy_price, from 2084 to 1812
        -- sell_price, from 416 to 362
        -- item_level, from 20 to 19
        -- required_level, from 15 to 14
        -- armor, from 17 to 26
        UPDATE `item_template` SET `name` = 'Druidic Cloak', `buy_price` = 1812, `sell_price` = 362, `item_level` = 19, `required_level` = 14, `armor` = 26 WHERE (`entry` = 9770);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9770, 3925);
        -- Gypsy Bands
        -- armor, from 26 to 30
        UPDATE `item_template` SET `armor` = 30 WHERE (`entry` = 9752);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9752, 3925);
        -- Jester's Gloves
        -- name, from Simple Gloves to Jester's Gloves
        -- display_id, from 14706 to 16562
        -- armor, from 15 to 23
        UPDATE `item_template` SET `name` = 'Jester\'s Gloves', `display_id` = 16562, `armor` = 23 WHERE (`entry` = 9746);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9746, 3925);
        -- Gypsy Gloves
        -- armor, from 39 to 46
        UPDATE `item_template` SET `armor` = 46 WHERE (`entry` = 9755);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9755, 3925);
        -- Evergreen Gloves
        -- display_id, from 15865 to 16815
        -- stat_value1, from 0 to 3
        -- armor, from 10 to 32
        UPDATE `item_template` SET `display_id` = 16815, `stat_value1` = 3, `armor` = 32 WHERE (`entry` = 7738);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7738, 3925);
        -- Scaber Stalk
        -- display_id, from 15857 to 19488
        UPDATE `item_template` SET `display_id` = 19488 WHERE (`entry` = 5271);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5271, 3925);
        -- Elven Wand
        -- display_id, from 28159 to 20981
        UPDATE `item_template` SET `display_id` = 20981 WHERE (`entry` = 5604);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5604, 3925);
        -- Relic Hunter Belt
        -- display_id, from 28242 to 11997
        -- armor, from 19 to 31
        UPDATE `item_template` SET `display_id` = 11997, `armor` = 31 WHERE (`entry` = 11936);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (11936, 3925);
        -- Light Bow
        -- buy_price, from 1777 to 5922
        -- sell_price, from 355 to 1184
        -- item_level, from 13 to 21
        -- required_level, from 8 to 16
        UPDATE `item_template` SET `buy_price` = 5922, `sell_price` = 1184, `item_level` = 21, `required_level` = 16 WHERE (`entry` = 4576);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4576, 3925);
        -- Feeble Shortbow
        -- required_level, from 10 to 8
        -- dmg_min1, from 6.0 to 4.0
        -- dmg_max1, from 12.0 to 8.0
        UPDATE `item_template` SET `required_level` = 8, `dmg_min1` = 4.0, `dmg_max1` = 8.0 WHERE (`entry` = 2777);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2777, 3925);
        -- Jester's Britches
        -- name, from Simple Britches to Jester's Britches
        -- display_id, from 14711 to 16561
        -- armor, from 23 to 37
        UPDATE `item_template` SET `name` = 'Jester\'s Britches', `display_id` = 16561, `armor` = 37 WHERE (`entry` = 9747);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9747, 3925);
        -- Explorer's Vest
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 2
        -- armor, from 44 to 125
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 2, `armor` = 125 WHERE (`entry` = 7229);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7229, 3925);
        -- Druidic Mantle
        -- name, from Greenweave Mantle to Druidic Mantle
        -- quality, from 2 to 1
        -- buy_price, from 4822 to 1774
        -- sell_price, from 964 to 354
        -- item_level, from 26 to 22
        -- required_level, from 21 to 17
        -- armor, from 30 to 42
        UPDATE `item_template` SET `name` = 'Druidic Mantle', `quality` = 1, `buy_price` = 1774, `sell_price` = 354, `item_level` = 22, `required_level` = 17, `armor` = 42 WHERE (`entry` = 10287);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (10287, 3925);
        -- Druidic Sash
        -- name, from Greenweave Sash to Druidic Sash
        -- display_id, from 25947 to 14735
        -- buy_price, from 1809 to 1368
        -- sell_price, from 361 to 273
        -- item_level, from 22 to 20
        -- required_level, from 17 to 15
        -- armor, from 20 to 31
        UPDATE `item_template` SET `name` = 'Druidic Sash', `display_id` = 14735, `buy_price` = 1368, `sell_price` = 273, `item_level` = 20, `required_level` = 15, `armor` = 31 WHERE (`entry` = 9766);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9766, 3925);
        -- Druidic Leggings
        -- name, from Greenweave Leggings to Druidic Leggings
        -- display_id, from 25942 to 14738
        -- buy_price, from 6644 to 3703
        -- sell_price, from 1328 to 740
        -- item_level, from 27 to 22
        -- required_level, from 22 to 17
        -- armor, from 36 to 51
        UPDATE `item_template` SET `name` = 'Druidic Leggings', `display_id` = 14738, `buy_price` = 3703, `sell_price` = 740, `item_level` = 22, `required_level` = 17, `armor` = 51 WHERE (`entry` = 9772);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9772, 3925);
        -- Druidic Gloves
        -- name, from Greenweave Gloves to Druidic Gloves
        -- display_id, from 25941 to 14737
        -- buy_price, from 2662 to 1394
        -- sell_price, from 532 to 278
        -- item_level, from 25 to 20
        -- required_level, from 20 to 15
        -- armor, from 24 to 34
        UPDATE `item_template` SET `name` = 'Druidic Gloves', `display_id` = 14737, `buy_price` = 1394, `sell_price` = 278, `item_level` = 20, `required_level` = 15, `armor` = 34 WHERE (`entry` = 9771);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9771, 3925);
        -- Firebane Cloak
        -- display_id, from 28661 to 22998
        -- armor, from 19 to 31
        -- material, from 7 to 8
        UPDATE `item_template` SET `display_id` = 22998, `armor` = 31, `material` = 8 WHERE (`entry` = 12979);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (12979, 3925);
        -- Cadet Vest
        -- armor, from 144 to 143
        UPDATE `item_template` SET `armor` = 143 WHERE (`entry` = 9765);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9765, 3925);
        -- Willow Branch
        -- item_level, from 16 to 19
        -- required_level, from 11 to 14
        UPDATE `item_template` SET `item_level` = 19, `required_level` = 14 WHERE (`entry` = 7554);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7554, 3925);
        -- Jester's Blouse
        -- name, from Simple Blouse to Jester's Blouse
        -- display_id, from 27529 to 16560
        -- armor, from 28 to 45
        UPDATE `item_template` SET `name` = 'Jester\'s Blouse', `display_id` = 16560, `armor` = 45 WHERE (`entry` = 9749);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9749, 3925);
        -- Light Leather Bracers
        -- armor, from 14 to 34
        UPDATE `item_template` SET `armor` = 34 WHERE (`entry` = 7281);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7281, 3925);
        -- War Knife
        -- buy_price, from 2571 to 4896
        -- sell_price, from 514 to 979
        -- item_level, from 13 to 17
        -- required_level, from 8 to 12
        -- dmg_min1, from 7.0 to 10.0
        -- dmg_max1, from 13.0 to 19.0
        UPDATE `item_template` SET `buy_price` = 4896, `sell_price` = 979, `item_level` = 17, `required_level` = 12, `dmg_min1` = 10.0, `dmg_max1` = 19.0 WHERE (`entry` = 4571);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4571, 3925);
        -- Darkshore Grouper
        -- display_id, from 33571 to 24698
        -- buy_price, from 40 to 125
        -- sell_price, from 2 to 6
        UPDATE `item_template` SET `display_id` = 24698, `buy_price` = 125, `sell_price` = 6 WHERE (`entry` = 12238);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (12238, 3925);
        -- Laced Mail Belt
        -- armor, from 15 to 91
        UPDATE `item_template` SET `armor` = 91 WHERE (`entry` = 1738);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1738, 3925);
        -- Raider's Boots
        -- armor, from 113 to 124
        UPDATE `item_template` SET `armor` = 124 WHERE (`entry` = 9784);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9784, 3925);
        -- Raider's Gauntlets
        -- display_id, from 13484 to 12454
        -- armor, from 103 to 113
        UPDATE `item_template` SET `display_id` = 12454, `armor` = 113 WHERE (`entry` = 9787);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9787, 3925);
        -- Bastion of Stormwind
        -- armor, from 495 to 375
        UPDATE `item_template` SET `armor` = 375 WHERE (`entry` = 9607);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9607, 3925);
        -- Bolt of Woolen Cloth
        -- name, from Bolt of Wool Cloth to Bolt of Woolen Cloth
        UPDATE `item_template` SET `name` = 'Bolt of Woolen Cloth' WHERE (`entry` = 2997);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2997, 3925);
        -- Small Leather Ammo Pouch
        -- item_level, from 1 to 5
        -- container_slots, from 4 to 8
        UPDATE `item_template` SET `item_level` = 5, `container_slots` = 8 WHERE (`entry` = 7279);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7279, 3925);
        -- Light Leather Quiver
        -- item_level, from 1 to 5
        -- container_slots, from 4 to 8
        UPDATE `item_template` SET `item_level` = 5, `container_slots` = 8 WHERE (`entry` = 7278);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7278, 3925);
        -- Crawler Meat
        -- display_id, from 22193 to 6680
        UPDATE `item_template` SET `display_id` = 6680 WHERE (`entry` = 2674);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2674, 3925);
        -- Crawler Legs
        -- name, from Crawler Leg to Crawler Legs
        UPDATE `item_template` SET `name` = 'Crawler Legs' WHERE (`entry` = 5385);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5385, 3925);
        -- Farmer's Boots
        -- display_id, from 28167 to 16853
        -- armor, from 13 to 20
        UPDATE `item_template` SET `display_id` = 16853, `armor` = 20 WHERE (`entry` = 11191);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (11191, 3925);
        -- Stonesplinter Rags
        -- required_level, from 7 to 12
        -- armor, from 14 to 47
        UPDATE `item_template` SET `required_level` = 12, `armor` = 47 WHERE (`entry` = 5109);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5109, 3925);
        -- Bandit Bracers
        -- display_id, from 28427 to 14728
        -- quality, from 2 to 1
        -- buy_price, from 1591 to 954
        -- sell_price, from 318 to 190
        -- armor, from 33 to 45
        UPDATE `item_template` SET `display_id` = 14728, `quality` = 1, `buy_price` = 954, `sell_price` = 190, `armor` = 45 WHERE (`entry` = 9777);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9777, 3925);
        -- Heavy Recurve Bow
        -- required_level, from 22 to 20
        -- dmg_min1, from 23.0 to 15.0
        -- dmg_max1, from 43.0 to 29.0
        UPDATE `item_template` SET `required_level` = 20, `dmg_min1` = 15.0, `dmg_max1` = 29.0 WHERE (`entry` = 3027);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3027, 3925);
        -- Wolf Handler Gloves
        -- buy_price, from 21 to 32
        -- sell_price, from 4 to 6
        -- item_level, from 4 to 5
        -- armor, from 5 to 19
        UPDATE `item_template` SET `buy_price` = 32, `sell_price` = 6, `item_level` = 5, `armor` = 19 WHERE (`entry` = 6171);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6171, 3925);
        -- Thresher Eyes
        -- name, from Thresher Eye to Thresher Eyes
        UPDATE `item_template` SET `name` = 'Thresher Eyes' WHERE (`entry` = 5412);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5412, 3925);
        -- Cadet Leggings
        -- armor, from 119 to 117
        UPDATE `item_template` SET `armor` = 117 WHERE (`entry` = 9763);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9763, 3925);
        -- Cadet Shield
        -- display_id, from 18823 to 18820
        -- buy_price, from 1501 to 2160
        -- sell_price, from 300 to 432
        -- item_level, from 13 to 15
        -- required_level, from 8 to 10
        -- armor, from 274 to 225
        UPDATE `item_template` SET `display_id` = 18820, `buy_price` = 2160, `sell_price` = 432, `item_level` = 15, `required_level` = 10, `armor` = 225 WHERE (`entry` = 9764);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9764, 3925);
        -- Tough Leather Bracers
        -- armor, from 35 to 50
        UPDATE `item_template` SET `armor` = 50 WHERE (`entry` = 1805);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1805, 3925);
        -- Threshadon Ambergris
        -- item_level, from 1 to 10
        UPDATE `item_template` SET `item_level` = 10 WHERE (`entry` = 2608);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2608, 3925);
        -- Druidic Sandals
        -- name, from Greenweave Sandals to Druidic Sandals
        -- display_id, from 25946 to 12439
        -- buy_price, from 3080 to 1791
        -- sell_price, from 616 to 358
        -- item_level, from 23 to 19
        -- required_level, from 18 to 14
        -- armor, from 25 to 36
        UPDATE `item_template` SET `name` = 'Druidic Sandals', `display_id` = 12439, `buy_price` = 1791, `sell_price` = 358, `item_level` = 19, `required_level` = 14, `armor` = 36 WHERE (`entry` = 9767);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9767, 3925);
        -- Prelacy Cape
        -- stat_value1, from 0 to 5
        -- armor, from 16 to 33
        UPDATE `item_template` SET `stat_value1` = 5, `armor` = 33 WHERE (`entry` = 7004);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7004, 3925);
        -- Case of Elunite
        -- allowable_class, from 2047 to 32767
        -- allowable_race, from 255 to 511
        UPDATE `item_template` SET `allowable_class` = 32767, `allowable_race` = 511 WHERE (`entry` = 6812);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6812, 3925);
        -- Elunite Hammer
        -- material, from 2 to 1
        UPDATE `item_template` SET `material` = 1 WHERE (`entry` = 6968);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6968, 3925);
        -- Elunite Dagger
        -- name, from Silver Steel Dagger to Elunite Dagger
        -- dmg_min1, from 7.0 to 9.0
        -- dmg_max1, from 15.0 to 17.0
        UPDATE `item_template` SET `name` = 'Elunite Dagger', `dmg_min1` = 9.0, `dmg_max1` = 17.0 WHERE (`entry` = 6969);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6969, 3925);
        -- Raider's Chestpiece
        -- armor, from 168 to 161
        UPDATE `item_template` SET `armor` = 161 WHERE (`entry` = 9783);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9783, 3925);
        -- Raw Rainbow Fin Albacore
        -- buy_price, from 125 to 100
        -- sell_price, from 6 to 5
        UPDATE `item_template` SET `buy_price` = 100, `sell_price` = 5 WHERE (`entry` = 6361);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6361, 3925);
        -- Pioneer Buckler
        -- buy_price, from 639 to 984
        -- sell_price, from 127 to 196
        -- item_level, from 12 to 13
        -- required_level, from 7 to 8
        -- armor, from 28 to 176
        UPDATE `item_template` SET `subclass` = 6, `buy_price` = 984, `sell_price` = 196, `item_level` = 13, `required_level` = 8, `armor` = 176 WHERE (`entry` = 7109);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7109, 3925);
        -- Starsight Tunic
        -- display_id, from 28375 to 19116
        -- armor, from 89 to 116
        UPDATE `item_template` SET `display_id` = 19116, `armor` = 116 WHERE (`entry` = 12988);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (12988, 3925);
        -- Patched Leather Pants
        -- armor, from 19 to 81
        UPDATE `item_template` SET `armor` = 81 WHERE (`entry` = 1792);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1792, 3925);
        -- Cadet Belt
        -- armor, from 65 to 62
        UPDATE `item_template` SET `armor` = 62 WHERE (`entry` = 9758);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9758, 3925);
        -- Light Leather Pants
        -- buy_price, from 2950 to 2998
        -- sell_price, from 590 to 599
        -- stat_value1, from 0 to 5
        -- armor, from 31 to 95
        UPDATE `item_template` SET `buy_price` = 2998, `sell_price` = 599, `stat_value1` = 5, `armor` = 95 WHERE (`entry` = 7282);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7282, 3925);
        -- Chipped Bear Tooth
        -- name, from Small Bear Tooth to Chipped Bear Tooth
        -- buy_price, from 135 to 75
        -- sell_price, from 33 to 18
        UPDATE `item_template` SET `name` = 'Chipped Bear Tooth', `buy_price` = 75, `sell_price` = 18 WHERE (`entry` = 3169);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3169, 3925);
        -- Bandit Pants
        -- display_id, from 28431 to 14730
        -- armor, from 71 to 92
        UPDATE `item_template` SET `display_id` = 14730, `armor` = 92 WHERE (`entry` = 9781);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9781, 3925);
        -- Disciple's Bracers
        -- display_id, from 14705 to 16566
        -- buy_price, from 240 to 148
        -- sell_price, from 48 to 29
        -- item_level, from 12 to 10
        -- required_level, from 7 to 5
        -- armor, from 6 to 13
        UPDATE `item_template` SET `display_id` = 16566, `buy_price` = 148, `sell_price` = 29, `item_level` = 10, `required_level` = 5, `armor` = 13 WHERE (`entry` = 7350);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7350, 3925);
        -- Jester's Bands
        -- name, from Simple Bands to Jester's Bands
        -- display_id, from 14705 to 16566
        -- armor, from 9 to 15
        UPDATE `item_template` SET `name` = 'Jester\'s Bands', `display_id` = 16566, `armor` = 15 WHERE (`entry` = 9744);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9744, 3925);
        -- Sharp Kitchen Knife
        -- dmg_max1, from 9.0 to 10.0
        UPDATE `item_template` SET `dmg_max1` = 10.0 WHERE (`entry` = 2225);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2225, 3925);
        -- Bandit Cinch
        -- display_id, from 28177 to 17113
        -- armor, from 43 to 61
        UPDATE `item_template` SET `display_id` = 17113, `armor` = 61 WHERE (`entry` = 9775);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9775, 3925);
        -- Cadet Boots
        -- armor, from 84 to 81
        UPDATE `item_template` SET `armor` = 81 WHERE (`entry` = 9759);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9759, 3925);
        -- Heavy Hammer
        -- name, from Heavy Club to Heavy Hammer
        -- required_level, from 9 to 7
        -- dmg_min1, from 5.0 to 6.0
        -- dmg_max1, from 11.0 to 12.0
        UPDATE `item_template` SET `name` = 'Heavy Hammer', `required_level` = 7, `dmg_min1` = 6.0, `dmg_max1` = 12.0 WHERE (`entry` = 1510);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1510, 3925);
        -- Jester's Robe
        -- name, from Simple Robe to Jester's Robe
        -- display_id, from 18883 to 16813
        -- armor, from 28 to 45
        UPDATE `item_template` SET `name` = 'Jester\'s Robe', `display_id` = 16813, `armor` = 45 WHERE (`entry` = 9748);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9748, 3925);
        -- Raider's Belt
        -- display_id, from 25775 to 12455
        -- armor, from 91 to 96
        UPDATE `item_template` SET `display_id` = 12455, `armor` = 96 WHERE (`entry` = 9788);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9788, 3925);
        -- Red Leather Bag
        -- item_level, from 10 to 15
        UPDATE `item_template` SET `item_level` = 15 WHERE (`entry` = 2657);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2657, 3925);
        -- Lumberjack Jerkin
        -- armor, from 49 to 53
        UPDATE `item_template` SET `armor` = 53 WHERE (`entry` = 2112);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2112, 3925);
        -- Coal
        -- buy_price, from 1500 to 500
        -- sell_price, from 375 to 125
        UPDATE `item_template` SET `buy_price` = 500, `sell_price` = 125 WHERE (`entry` = 3857);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3857, 3925);
        -- Bandit Boots
        -- display_id, from 16981 to 17157
        -- armor, from 53 to 66
        UPDATE `item_template` SET `display_id` = 17157, `armor` = 66 WHERE (`entry` = 9776);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9776, 3925);
        -- Large Bear Tooth
        -- buy_price, from 290 to 190
        -- sell_price, from 72 to 47
        UPDATE `item_template` SET `buy_price` = 190, `sell_price` = 47 WHERE (`entry` = 3170);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (3170, 3925);
        -- Small Brown Pouch
        -- item_level, from 10 to 5
        UPDATE `item_template` SET `item_level` = 5 WHERE (`entry` = 4496);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (4496, 3925);
        -- Raider's Bracers
        -- display_id, from 25776 to 12456
        -- quality, from 2 to 1
        -- buy_price, from 1344 to 806
        -- sell_price, from 268 to 161
        -- armor, from 69 to 67
        UPDATE `item_template` SET `display_id` = 12456, `quality` = 1, `buy_price` = 806, `sell_price` = 161, `armor` = 67 WHERE (`entry` = 9785);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9785, 3925);
        -- Enchantress Wraps
        -- name, from Ivycloth Tunic to Enchantress Wraps
        -- display_id, from 27751 to 14748
        -- armor, from 42 to 69
        UPDATE `item_template` SET `name` = 'Enchantress Wraps', `display_id` = 14748, `armor` = 69 WHERE (`entry` = 9791);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9791, 3925);
        -- Silver-thread Gloves
        -- name, from Frostweave Gloves to Silver-thread Gloves
        -- quality, from 1 to 2
        -- buy_price, from 3037 to 3803
        -- sell_price, from 607 to 760
        -- item_level, from 31 to 28
        -- required_level, from 26 to 23
        -- stat_type1, from 0 to 3
        -- stat_value1, from 0 to 5
        -- stat_type2, from 0 to 5
        -- stat_value2, from 0 to 5
        -- armor, from 12 to 43
        UPDATE `item_template` SET `name` = 'Silver-thread Gloves', `quality` = 2, `buy_price` = 3803, `sell_price` = 760, `item_level` = 28, `required_level` = 23, `stat_type1` = 3, `stat_value1` = 5, `stat_type2` = 5, `stat_value2` = 5, `armor` = 43 WHERE (`entry` = 6393);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6393, 3925);
        -- Monk's Cloak
        -- name, from Scaled Cloak to Monk's Cloak
        -- display_id, from 27768 to 23047
        -- buy_price, from 6166 to 7708
        -- sell_price, from 1233 to 1541
        -- armor, from 21 to 35
        -- material, from 7 to 8
        UPDATE `item_template` SET `name` = 'Monk\'s Cloak', `display_id` = 23047, `buy_price` = 7708, `sell_price` = 1541, `armor` = 35, `material` = 8 WHERE (`entry` = 9831);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9831, 3925);
        -- Enchantress Sash
        -- name, from Ivycloth Sash to Enchantress Sash
        -- display_id, from 28477 to 14752
        -- armor, from 22 to 37
        UPDATE `item_template` SET `name` = 'Enchantress Sash', `display_id` = 14752, `armor` = 37 WHERE (`entry` = 9799);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9799, 3925);
        -- Beetle Clasps
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 5
        -- stat_type2, from 0 to 3
        -- stat_value2, from 0 to 2
        -- armor, from 32 to 95
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 5, `stat_type2` = 3, `stat_value2` = 2, `armor` = 95 WHERE (`entry` = 7003);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (7003, 3925);
        -- Druidic Vest
        -- name, from Greenweave Vest to Druidic Vest
        -- display_id, from 25949 to 14739
        -- buy_price, from 6872 to 4328
        -- sell_price, from 1374 to 865
        -- item_level, from 27 to 23
        -- required_level, from 22 to 18
        -- armor, from 41 to 60
        UPDATE `item_template` SET `name` = 'Druidic Vest', `display_id` = 14739, `buy_price` = 4328, `sell_price` = 865, `item_level` = 23, `required_level` = 18, `armor` = 60 WHERE (`entry` = 9774);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9774, 3925);
        -- Bandit Gloves
        -- display_id, from 28428 to 14729
        -- armor, from 48 to 60
        UPDATE `item_template` SET `display_id` = 14729, `armor` = 60 WHERE (`entry` = 9780);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (9780, 3925);
        -- Fire Hardened Coif
        -- stat_type1, from 0 to 7
        -- stat_value1, from 0 to 8
        -- stat_type2, from 0 to 3
        -- stat_value2, from 0 to 7
        -- armor, from 44 to 173
        UPDATE `item_template` SET `stat_type1` = 7, `stat_value1` = 8, `stat_type2` = 3, `stat_value2` = 7, `armor` = 173 WHERE (`entry` = 6971);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6971, 3925);
        -- Fire Hardened Hauberk
        -- display_id, from 13011 to 22480
        -- stat_value1, from 0 to 14
        -- armor, from 71 to 226
        UPDATE `item_template` SET `display_id` = 22480, `stat_value1` = 14, `armor` = 226 WHERE (`entry` = 6972);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (6972, 3925);
        -- Rawhide Bracers
        -- name, from Tough Leather Bracers to Rawhide Bracers
        -- required_level, from 11 to 16
        -- armor, from 11 to 40
        UPDATE `item_template` SET `name` = 'Rawhide Bracers', `required_level` = 16, `armor` = 40 WHERE (`entry` = 1797);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (1797, 3925);
        -- Woodsman Sword
        -- dmg_min1, from 44.0 to 34.0
        -- dmg_max1, from 60.0 to 52.0
        UPDATE `item_template` SET `dmg_min1` = 34.0, `dmg_max1` = 52.0 WHERE (`entry` = 5615);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (5615, 3925);
        -- Daryl's Hunting Bow
        -- dmg_min1, from 14.0 to 9.0
        -- dmg_max1, from 27.0 to 18.0
        UPDATE `item_template` SET `dmg_min1` = 9.0, `dmg_max1` = 18.0 WHERE (`entry` = 2903);
        REPLACE INTO `applied_item_updates` (`entry`, `version`) VALUES (2903, 3925);

        insert into applied_updates values ('290820222');
    end if;

    -- 29/08/2022 3
    if (select count(*) from applied_updates where id='290820223') = 0 then
        -- #567 Incorrect item damage.
        UPDATE `item_template` SET `dmg_min1`=28, `dmg_max1`=39 WHERE `entry`=854;

        insert into applied_updates values ('290820223');
    end if;

    -- 29/08/2022 4
    if (select count(*) from applied_updates where id='290820224') = 0 then
        -- Partially fix #589
        -- Basil Frye
        UPDATE `creature_template` SET `subname` = 'Bone Equipment Merchant' WHERE (`entry` = 4605);

        -- Silas Zimmer
        UPDATE `creature_template` SET `subname` = 'Unholy Relic Vendor' WHERE (`entry` = 4572);

        -- Alanna Raveneye
        UPDATE `creature_template` SET `subname` = 'Enchantress' WHERE (`entry` = 3606);

        -- Onu
        UPDATE `creature_template` SET `subname` = 'Ancient of Lore *NEEDS TEXTURE*' WHERE (`entry` = 3616);

        -- #586
        -- Sen'jin Watcher
        UPDATE `creature_template` SET `faction` = 125 WHERE (`entry` = 3297);

        -- Partially fix #414
        -- Peasant Woodpile
        UPDATE `spawns_gameobjects` SET `ignored` = 1 WHERE (`spawn_sentry` = 105568);

        -- Campfire
        UPDATE `spawns_gameobjects` SET `ignored` = 1 WHERE (`spawn_sentry` = 129206);

        -- Barrel of milk
        UPDATE `spawns_gameobjects` SET `ignored` = 1 WHERE (`spawn_id` = 42733);

        insert into applied_updates values ('290820224');
      end if;
end $
delimiter ;
