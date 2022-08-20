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
        -- NE Shadowmeld
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
        
        -- Dwarf, Find Treasure action button placement.
        UPDATE `playercreateinfo_action` SET `button` = '74' WHERE (`race` = '3') and (`class` = '1') and (`button` = '75') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '2' WHERE (`race` = '3') and (`class` = '2') and (`button` = '3') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '2' WHERE (`race` = '3') and (`class` = '3') and (`button` = '4') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '4' WHERE (`race` = '3') and (`class` = '4') and (`button` = '5') and (`id` = '1');
        UPDATE `playercreateinfo_action` SET `button` = '3' WHERE (`race` = '3') and (`class` = '5') and (`button` = '4') and (`id` = '1');
        
        INSERT INTO `playercreateinfo_spell` (`id`, `race`, `class`, `Spell`, `Note`) VALUES ('1505', '3', '8', '2481', 'Find Treasure');
        INSERT INTO `playercreateinfo_action` (`id`, `race`, `class`, `button`, `action`, `type`) VALUES ('1', '3', '8', '3', '2481', '0');
        
        -- Remove all invalid spells.
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '8386') and (`id` = '26');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '8737') and (`id` = '27');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '9077') and (`id` = '28');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '9078') and (`id` = '29');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '9116') and (`id` = '30');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '9125') and (`id` = '31');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '20597') and (`id` = '32');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '20598') and (`id` = '33');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '20599') and (`id` = '34');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '20600') and (`id` = '35');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '20864') and (`id` = '36');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '21651') and (`id` = '37');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '21652') and (`id` = '38');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '22027') and (`id` = '39');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '1') and (`Spell` = '22810') and (`id` = '40');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '8386') and (`id` = '63');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '8737') and (`id` = '64');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '9077') and (`id` = '65');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '9078') and (`id` = '66');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '9116') and (`id` = '67');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '9125') and (`id` = '68');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '20597') and (`id` = '69');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '20598') and (`id` = '70');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '20599') and (`id` = '71');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '20600') and (`id` = '72');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '20864') and (`id` = '73');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '21084') and (`id` = '74');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '21651') and (`id` = '75');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '21652') and (`id` = '76');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '22027') and (`id` = '77');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '22810') and (`id` = '78');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '2') and (`Spell` = '27762') and (`id` = '79');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '8386') and (`id` = '103');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '9077') and (`id` = '104');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '9078') and (`id` = '105');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '9125') and (`id` = '106');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '16092') and (`id` = '107');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '20597') and (`id` = '108');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '20598') and (`id` = '109');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '20599') and (`id` = '110');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '20600') and (`id` = '111');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '20864') and (`id` = '112');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '21184') and (`id` = '113');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '21651') and (`id` = '114');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '21652') and (`id` = '115');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '22027') and (`id` = '116');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '4') and (`Spell` = '22810') and (`id` = '117');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '8386') and (`id` = '141');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '9078') and (`id` = '142');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '9125') and (`id` = '143');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '20597') and (`id` = '144');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '20598') and (`id` = '145');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '20599') and (`id` = '146');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '20600') and (`id` = '147');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '20864') and (`id` = '148');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '21651') and (`id` = '149');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '21652') and (`id` = '150');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '22027') and (`id` = '151');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '5') and (`Spell` = '22810') and (`id` = '152');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '8386') and (`id` = '176');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '9078') and (`id` = '177');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '9125') and (`id` = '178');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '20597') and (`id` = '179');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '20598') and (`id` = '180');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '20599') and (`id` = '181');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '20600') and (`id` = '182');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '20864') and (`id` = '183');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '21651') and (`id` = '184');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '21652') and (`id` = '185');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '22027') and (`id` = '186');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '8') and (`Spell` = '22810') and (`id` = '187');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '8386') and (`id` = '211');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '9078') and (`id` = '212');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '9125') and (`id` = '213');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '20597') and (`id` = '214');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '20598') and (`id` = '215');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '20599') and (`id` = '216');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '20600') and (`id` = '217');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '20864') and (`id` = '218');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '21651') and (`id` = '219');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '21652') and (`id` = '220');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '22027') and (`id` = '221');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '1') and (`class` = '9') and (`Spell` = '22810') and (`id` = '222');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '8386') and (`id` = '248');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '8737') and (`id` = '249');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '9077') and (`id` = '250');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '9078') and (`id` = '251');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '9116') and (`id` = '252');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '9125') and (`id` = '253');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '20572') and (`id` = '254');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '20573') and (`id` = '255');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '20574') and (`id` = '256');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '21563') and (`id` = '257');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '21651') and (`id` = '258');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '21652') and (`id` = '259');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '22027') and (`id` = '260');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '1') and (`Spell` = '22810') and (`id` = '261');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '8386') and (`id` = '284');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '9077') and (`id` = '285');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '9078') and (`id` = '286');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '9125') and (`id` = '287');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '13358') and (`id` = '288');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '20572') and (`id` = '289');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '20573') and (`id` = '290');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '20574') and (`id` = '291');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '20576') and (`id` = '292');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '21651') and (`id` = '293');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '21652') and (`id` = '294');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '22027') and (`id` = '295');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '22810') and (`id` = '296');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '3') and (`Spell` = '24949') and (`id` = '297');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '8386') and (`id` = '321');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '9077') and (`id` = '322');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '9078') and (`id` = '323');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '9125') and (`id` = '324');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '16092') and (`id` = '325');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '20572') and (`id` = '326');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '20573') and (`id` = '327');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '20574') and (`id` = '328');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '21184') and (`id` = '329');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '21563') and (`id` = '330');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '21651') and (`id` = '331');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '21652') and (`id` = '332');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '22027') and (`id` = '333');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '4') and (`Spell` = '22810') and (`id` = '334');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '8386') and (`id` = '358');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '9077') and (`id` = '359');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '9078') and (`id` = '360');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '9116') and (`id` = '361');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '9125') and (`id` = '362');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '20572') and (`id` = '363');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '20573') and (`id` = '364');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '20574') and (`id` = '365');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '21563') and (`id` = '366');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '21651') and (`id` = '367');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '21652') and (`id` = '368');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '22027') and (`id` = '369');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '22810') and (`id` = '370');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '7') and (`Spell` = '27763') and (`id` = '371');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '8386') and (`id` = '395');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '9078') and (`id` = '396');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '9125') and (`id` = '397');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '20572') and (`id` = '398');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '20573') and (`id` = '399');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '20574') and (`id` = '400');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '20575') and (`id` = '401');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '21651') and (`id` = '402');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '21652') and (`id` = '403');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '22027') and (`id` = '404');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '2') and (`class` = '9') and (`Spell` = '22810') and (`id` = '405');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '8386') and (`id` = '433');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '8737') and (`id` = '434');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '9077') and (`id` = '435');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '9078') and (`id` = '436');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '9116') and (`id` = '437');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '9125') and (`id` = '438');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '20594') and (`id` = '439');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '20595') and (`id` = '440');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '20596') and (`id` = '441');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '21651') and (`id` = '442');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '21652') and (`id` = '443');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '22027') and (`id` = '444');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '1') and (`Spell` = '22810') and (`id` = '445');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '8386') and (`id` = '470');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '8737') and (`id` = '471');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '9077') and (`id` = '472');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '9078') and (`id` = '473');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '9116') and (`id` = '474');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '9125') and (`id` = '475');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '20594') and (`id` = '476');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '20595') and (`id` = '477');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '20596') and (`id` = '478');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '21084') and (`id` = '479');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '21651') and (`id` = '480');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '21652') and (`id` = '481');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '22027') and (`id` = '482');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '22810') and (`id` = '483');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '2') and (`Spell` = '27762') and (`id` = '484');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '8386') and (`id` = '509');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '9077') and (`id` = '510');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '9078') and (`id` = '511');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '9125') and (`id` = '512');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '13358') and (`id` = '513');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '20594') and (`id` = '514');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '20595') and (`id` = '515');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '20596') and (`id` = '516');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '21651') and (`id` = '517');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '21652') and (`id` = '518');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '22027') and (`id` = '519');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '22810') and (`id` = '520');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '3') and (`Spell` = '24949') and (`id` = '521');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '8386') and (`id` = '547');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '9077') and (`id` = '548');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '9078') and (`id` = '549');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '9125') and (`id` = '550');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '16092') and (`id` = '551');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '20594') and (`id` = '552');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '20595') and (`id` = '553');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '20596') and (`id` = '554');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '21184') and (`id` = '555');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '21651') and (`id` = '556');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '21652') and (`id` = '557');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '22027') and (`id` = '558');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '4') and (`Spell` = '22810') and (`id` = '559');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '8386') and (`id` = '585');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '9078') and (`id` = '586');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '9125') and (`id` = '587');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '20594') and (`id` = '588');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '20595') and (`id` = '589');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '20596') and (`id` = '590');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '21651') and (`id` = '591');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '21652') and (`id` = '592');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '22027') and (`id` = '593');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '5') and (`Spell` = '22810') and (`id` = '594');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '8386') and (`id` = '1528');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '9078') and (`id` = '1529');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '9125') and (`id` = '1530');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '20594') and (`id` = '1498');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '20595') and (`id` = '1499');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '20596') and (`id` = '1500');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '21651') and (`id` = '1501');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '21652') and (`id` = '1502');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '22027') and (`id` = '1503');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '3') and (`class` = '8') and (`Spell` = '22810') and (`id` = '1504');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '8386') and (`id` = '621');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '8737') and (`id` = '622');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '9077') and (`id` = '623');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '9078') and (`id` = '624');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '9116') and (`id` = '625');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '9125') and (`id` = '626');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '20582') and (`id` = '628');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '20583') and (`id` = '629');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '20585') and (`id` = '630');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '21009') and (`id` = '631');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '21651') and (`id` = '632');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '21652') and (`id` = '633');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '22027') and (`id` = '634');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '1') and (`Spell` = '22810') and (`id` = '635');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '8386') and (`id` = '659');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '9077') and (`id` = '660');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '9078') and (`id` = '661');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '9125') and (`id` = '662');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '13358') and (`id` = '663');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '20582') and (`id` = '665');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '20583') and (`id` = '666');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '20585') and (`id` = '667');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '21009') and (`id` = '668');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '21651') and (`id` = '669');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '21652') and (`id` = '670');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '22027') and (`id` = '671');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '22810') and (`id` = '672');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '3') and (`Spell` = '24949') and (`id` = '673');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '8386') and (`id` = '698');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '9077') and (`id` = '699');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '9078') and (`id` = '700');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '9125') and (`id` = '701');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '16092') and (`id` = '702');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '20582') and (`id` = '704');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '20583') and (`id` = '705');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '20585') and (`id` = '706');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '21009') and (`id` = '707');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '21184') and (`id` = '708');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '21651') and (`id` = '709');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '21652') and (`id` = '710');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '22027') and (`id` = '711');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '4') and (`Spell` = '22810') and (`id` = '712');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '8386') and (`id` = '737');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '9078') and (`id` = '738');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '9125') and (`id` = '739');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '20582') and (`id` = '741');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '20583') and (`id` = '742');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '20585') and (`id` = '743');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '21009') and (`id` = '744');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '21651') and (`id` = '745');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '21652') and (`id` = '746');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '22027') and (`id` = '747');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '5') and (`Spell` = '22810') and (`id` = '748');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '8386') and (`id` = '772');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '9077') and (`id` = '773');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '9078') and (`id` = '774');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '9125') and (`id` = '775');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '20582') and (`id` = '777');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '20583') and (`id` = '778');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '20585') and (`id` = '779');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '21009') and (`id` = '780');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '21651') and (`id` = '781');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '21652') and (`id` = '782');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '22027') and (`id` = '783');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '22810') and (`id` = '784');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '4') and (`class` = '11') and (`Spell` = '27764') and (`id` = '785');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '8386') and (`id` = '813');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '8737') and (`id` = '814');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '9077') and (`id` = '815');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '9078') and (`id` = '816');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '9116') and (`id` = '817');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '9125') and (`id` = '818');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '17737') and (`id` = '819');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '20577') and (`id` = '820');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '20579') and (`id` = '821');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '21651') and (`id` = '822');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '21652') and (`id` = '823');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '22027') and (`id` = '824');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '1') and (`Spell` = '22810') and (`id` = '825');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '8386') and (`id` = '851');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '9077') and (`id` = '852');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '9078') and (`id` = '853');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '9125') and (`id` = '854');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '16092') and (`id` = '855');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '17737') and (`id` = '856');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '20577') and (`id` = '857');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '20579') and (`id` = '858');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '21184') and (`id` = '859');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '21651') and (`id` = '860');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '21652') and (`id` = '861');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '22027') and (`id` = '862');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '4') and (`Spell` = '22810') and (`id` = '863');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '8386') and (`id` = '889');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '9078') and (`id` = '890');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '9125') and (`id` = '891');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '17737') and (`id` = '892');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '20577') and (`id` = '893');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '20579') and (`id` = '894');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '21651') and (`id` = '895');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '21652') and (`id` = '896');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '22027') and (`id` = '897');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '5') and (`Spell` = '22810') and (`id` = '898');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '8386') and (`id` = '924');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '9078') and (`id` = '925');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '9125') and (`id` = '926');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '17737') and (`id` = '927');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '20577') and (`id` = '928');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '20579') and (`id` = '929');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '21651') and (`id` = '930');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '21652') and (`id` = '931');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '22027') and (`id` = '932');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '8') and (`Spell` = '22810') and (`id` = '933');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '8386') and (`id` = '959');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '9078') and (`id` = '960');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '9125') and (`id` = '961');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '17737') and (`id` = '962');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '20577') and (`id` = '963');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '20579') and (`id` = '964');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '21651') and (`id` = '965');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '21652') and (`id` = '966');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '22027') and (`id` = '967');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '5') and (`class` = '9') and (`Spell` = '22810') and (`id` = '968');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '8386') and (`id` = '995');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '8737') and (`id` = '996');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '9077') and (`id` = '997');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '9078') and (`id` = '998');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '9116') and (`id` = '999');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '9125') and (`id` = '1000');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '20549') and (`id` = '1001');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '20550') and (`id` = '1002');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '20551') and (`id` = '1003');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '20552') and (`id` = '1004');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '21651') and (`id` = '1005');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '21652') and (`id` = '1006');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '22027') and (`id` = '1007');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '1') and (`Spell` = '22810') and (`id` = '1008');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '8386') and (`id` = '1032');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '9077') and (`id` = '1033');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '9078') and (`id` = '1034');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '9125') and (`id` = '1035');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '13358') and (`id` = '1036');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '20549') and (`id` = '1037');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '20550') and (`id` = '1038');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '20551') and (`id` = '1039');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '20552') and (`id` = '1040');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '21651') and (`id` = '1041');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '21652') and (`id` = '1042');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '22027') and (`id` = '1043');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '22810') and (`id` = '1044');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '3') and (`Spell` = '24949') and (`id` = '1045');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '8386') and (`id` = '1070');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '9077') and (`id` = '1071');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '9078') and (`id` = '1072');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '9116') and (`id` = '1073');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '9125') and (`id` = '1074');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '20549') and (`id` = '1075');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '20550') and (`id` = '1076');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '20551') and (`id` = '1077');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '20552') and (`id` = '1078');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '21651') and (`id` = '1079');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '21652') and (`id` = '1080');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '22027') and (`id` = '1081');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '22810') and (`id` = '1082');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '7') and (`Spell` = '27763') and (`id` = '1083');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '8386') and (`id` = '1107');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '9077') and (`id` = '1108');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '9078') and (`id` = '1109');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '9125') and (`id` = '1110');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '20549') and (`id` = '1111');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '20550') and (`id` = '1112');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '20551') and (`id` = '1113');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '20552') and (`id` = '1114');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '21651') and (`id` = '1115');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '21652') and (`id` = '1116');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '22027') and (`id` = '1117');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '22810') and (`id` = '1118');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '6') and (`class` = '11') and (`Spell` = '27764') and (`id` = '1119');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '8386') and (`id` = '1146');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '8737') and (`id` = '1147');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '9077') and (`id` = '1148');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '9078') and (`id` = '1149');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '9116') and (`id` = '1150');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '9125') and (`id` = '1151');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '20589') and (`id` = '1152');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '20591') and (`id` = '1153');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '20592') and (`id` = '1154');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '20593') and (`id` = '1155');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '21651') and (`id` = '1156');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '21652') and (`id` = '1157');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '22027') and (`id` = '1158');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '1') and (`Spell` = '22810') and (`id` = '1159');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '8386') and (`id` = '1184');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '9077') and (`id` = '1185');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '9078') and (`id` = '1186');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '9125') and (`id` = '1187');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '16092') and (`id` = '1188');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '20589') and (`id` = '1189');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '20591') and (`id` = '1190');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '20592') and (`id` = '1191');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '20593') and (`id` = '1192');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '21184') and (`id` = '1193');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '21651') and (`id` = '1194');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '21652') and (`id` = '1195');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '22027') and (`id` = '1196');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '4') and (`Spell` = '22810') and (`id` = '1197');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '8386') and (`id` = '1222');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '9078') and (`id` = '1223');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '9125') and (`id` = '1224');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '20589') and (`id` = '1225');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '20591') and (`id` = '1226');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '20592') and (`id` = '1227');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '20593') and (`id` = '1228');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '21651') and (`id` = '1229');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '21652') and (`id` = '1230');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '22027') and (`id` = '1231');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '8') and (`Spell` = '22810') and (`id` = '1232');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '8386') and (`id` = '1257');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '9078') and (`id` = '1258');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '9125') and (`id` = '1259');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '20589') and (`id` = '1260');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '20591') and (`id` = '1261');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '20592') and (`id` = '1262');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '20593') and (`id` = '1263');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '21651') and (`id` = '1264');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '21652') and (`id` = '1265');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '22027') and (`id` = '1266');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '7') and (`class` = '9') and (`Spell` = '22810') and (`id` = '1267');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '8386') and (`id` = '1295');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '8737') and (`id` = '1296');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '9077') and (`id` = '1297');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '9078') and (`id` = '1298');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '9116') and (`id` = '1299');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '9125') and (`id` = '1300');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '20555') and (`id` = '1301');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '20557') and (`id` = '1302');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '20558') and (`id` = '1303');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '21651') and (`id` = '1304');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '21652') and (`id` = '1305');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '22027') and (`id` = '1306');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '22810') and (`id` = '1307');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '26290') and (`id` = '1308');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '1') and (`Spell` = '26296') and (`id` = '1309');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '8386') and (`id` = '1333');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '9077') and (`id` = '1334');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '9078') and (`id` = '1335');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '9125') and (`id` = '1336');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '13358') and (`id` = '1337');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '20554') and (`id` = '1338');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '20555') and (`id` = '1339');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '20557') and (`id` = '1340');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '20558') and (`id` = '1341');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '21651') and (`id` = '1342');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '21652') and (`id` = '1343');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '22027') and (`id` = '1344');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '22810') and (`id` = '1345');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '24949') and (`id` = '1346');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '3') and (`Spell` = '26290') and (`id` = '1347');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '8386') and (`id` = '1372');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '9077') and (`id` = '1373');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '9078') and (`id` = '1374');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '9125') and (`id` = '1375');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '16092') and (`id` = '1376');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '20555') and (`id` = '1377');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '20557') and (`id` = '1378');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '20558') and (`id` = '1379');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '21184') and (`id` = '1380');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '21651') and (`id` = '1381');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '21652') and (`id` = '1382');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '22027') and (`id` = '1383');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '22810') and (`id` = '1384');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '26290') and (`id` = '1385');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '4') and (`Spell` = '26297') and (`id` = '1386');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '8386') and (`id` = '1411');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '9078') and (`id` = '1412');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '9125') and (`id` = '1413');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '20554') and (`id` = '1414');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '20555') and (`id` = '1415');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '20557') and (`id` = '1416');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '20558') and (`id` = '1417');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '21651') and (`id` = '1418');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '21652') and (`id` = '1419');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '22027') and (`id` = '1420');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '22810') and (`id` = '1421');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '5') and (`Spell` = '26290') and (`id` = '1422');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '8386') and (`id` = '1447');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '9077') and (`id` = '1448');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '9078') and (`id` = '1449');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '9116') and (`id` = '1450');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '9125') and (`id` = '1451');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '20554') and (`id` = '1452');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '20555') and (`id` = '1453');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '20557') and (`id` = '1454');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '20558') and (`id` = '1455');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '21651') and (`id` = '1456');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '21652') and (`id` = '1457');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '22027') and (`id` = '1458');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '22810') and (`id` = '1459');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '26290') and (`id` = '1460');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '7') and (`Spell` = '27763') and (`id` = '1461');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '8386') and (`id` = '1486');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '9078') and (`id` = '1487');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '9125') and (`id` = '1488');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '20554') and (`id` = '1489');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '20555') and (`id` = '1490');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '20557') and (`id` = '1491');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '20558') and (`id` = '1492');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '21651') and (`id` = '1493');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '21652') and (`id` = '1494');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '22027') and (`id` = '1495');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '22810') and (`id` = '1496');
        DELETE FROM `playercreateinfo_spell` WHERE (`race` = '8') and (`class` = '8') and (`Spell` = '26290') and (`id` = '1497');

        insert into applied_updates values ('200820223');
    end if;
end $
delimiter ;
