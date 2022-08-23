delimiter $
begin not atomic
    -- 20/08/2022 2
    if (select count(*) from applied_updates where id='200820222') = 0 then
      -- 23/08/2022 1
      if (select count(*) from applied_updates where id='230820221') = 0 then
        -- Update quest enty 99.
        UPDATE `quest_template` SET `ReqItemCount1`='12' WHERE `entry`=99;
      end if;

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
end $
delimiter ;
