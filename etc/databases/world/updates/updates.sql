delimiter $
begin not atomic

    -- 25/09/2021 1
    if (select count(*) from applied_updates where id='250920211') = 0 then
        UPDATE `creature_template` SET `static_flags` = 0 WHERE `static_flags` < 0;

        insert into applied_updates values ('250920211');
    end if;  

    -- 27/09/2021 1
    if (select count(*) from applied_updates where id='270920211') = 0 then
        UPDATE `item_template` SET `buy_count` = `stackable` WHERE `buy_count` > `stackable`;

        insert into applied_updates values ('270920211');
    end if;
	
    -- 19/01/2022 1
    if (select count(*) from applied_updates where id='190120221') = 0 then
        -- Webwood Eggs proper placement.
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '10874.13', `spawn_positionY` = '923.626', `spawn_positionZ` = '1317.481' WHERE (`spawn_id` = '49589');
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '10874.27', `spawn_positionY` = '917.391', `spawn_positionZ` = '1317.544' WHERE (`spawn_id` = '49590');
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '10881.17', `spawn_positionY` = '914.299', `spawn_positionZ` = '1317.358' WHERE (`spawn_id` = '49591');
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '10896.01', `spawn_positionY` = '920.324', `spawn_positionZ` = '1319.054' WHERE (`spawn_id` = '49593');
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '10900.56', `spawn_positionY` = '920.812', `spawn_positionZ` = '1319.237' WHERE (`spawn_id` = '49595');
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '10903.92', `spawn_positionY` = '927.207', `spawn_positionZ` = '1319.866' WHERE (`spawn_id` = '49596');
	
        -- Fix Webwood Spiders wrong Z.
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1334.94' WHERE (`spawn_id` = '47061');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1335.55' WHERE (`spawn_id` = '47249');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1335.60' WHERE (`spawn_id` = '47003');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_x` = '10832.00', `position_y` = '921.21', `position_z` = '1337.127' WHERE (`spawn_id` = '47002');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1332.67' WHERE (`spawn_id` = '47017');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1326.44' WHERE (`spawn_id` = '47018');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1321.23' WHERE (`spawn_id` = '47023');
        UPDATE `alpha_world`.`spawns_creatures` SET `position_z` = '1319.51' WHERE (`spawn_id` = '47056');

        -- Ignore Webwood Spiders that have wrong placement in 0.5.3. (Out of reach)
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46958');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46971');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46972');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46974');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46981');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46997');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46998');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '46999');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47000');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47001');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47004');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47006');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47008');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47009');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47010');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47012');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47016');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47021');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47029');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47030');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47031');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47037');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47038');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47039');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47052');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47053');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47054');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47055');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47057');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47060');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47062');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47208');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47262');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47263');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47266');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47267');
        UPDATE `alpha_world`.`spawns_creatures` SET `ignored` = '1' WHERE (`spawn_id` = '47268');

        insert into applied_updates values ('190120221');
    end if;
end $
delimiter ;