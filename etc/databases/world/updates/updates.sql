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
end $
delimiter ;
