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
end $
delimiter ;
