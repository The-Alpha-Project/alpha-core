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
	
        -- Small Thorium Vein ignored, out of reach.
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '132');
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '53.964', `spawn_positionY` = '-4194.94', `spawn_positionZ` = '119.66' WHERE (`spawn_id` = '131');
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.767' WHERE (`spawn_id` = '136');
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.132' WHERE (`spawn_id` = '141');
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '480.185' WHERE (`spawn_id` = '144');
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '15.19' WHERE (`spawn_id` = '148');
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.39' WHERE (`spawn_id` = '152');
        -- Quilboar Watering Hole placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '99864'); 
        -- Alliance Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47590'); 
        -- Alliance Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47589'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.878' WHERE (`spawn_id` = '19'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.878' WHERE (`spawn_id` = '20'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '25.874' WHERE (`spawn_id` = '30737'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.126' WHERE (`spawn_id` = '30646'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46'); 
        -- No object template, set ignored.
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '52'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '423.01' WHERE (`spawn_id` = '58'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '423.01' WHERE (`spawn_id` = '59'); 
        -- Forge ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47586'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '22.465' WHERE (`spawn_id` = '30591'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '20.76' WHERE (`spawn_id` = '30589'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '93'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '155.184' WHERE (`spawn_id` = '30035'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.14' WHERE (`spawn_id` = '136'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.924' WHERE (`spawn_id` = '156'); 
        -- Small Thorium Vein ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '157'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-27.0' WHERE (`spawn_id` = '163'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '70.317' WHERE (`spawn_id` = '165'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '700.815' WHERE (`spawn_id` = '166'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '697.121' WHERE (`spawn_id` = '167'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.955' WHERE (`spawn_id` = '171'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '55.253' WHERE (`spawn_id` = '173'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '57.667' WHERE (`spawn_id` = '174'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '240.779' WHERE (`spawn_id` = '175'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '693.624' WHERE (`spawn_id` = '185'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '594.675' WHERE (`spawn_id` = '191'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '153.33' WHERE (`spawn_id` = '194'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.598' WHERE (`spawn_id` = '195'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '110.99' WHERE (`spawn_id` = '201'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '7.772' WHERE (`spawn_id` = '204'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-215.479' WHERE (`spawn_id` = '209'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '934.929' WHERE (`spawn_id` = '210'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.213' WHERE (`spawn_id` = '214'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '692.923' WHERE (`spawn_id` = '220'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '9.668' WHERE (`spawn_id` = '221'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '5.86' WHERE (`spawn_id` = '222'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '66.006' WHERE (`spawn_id` = '226'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '74.424' WHERE (`spawn_id` = '227'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '461.16' WHERE (`spawn_id` = '228'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.558' WHERE (`spawn_id` = '230'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '161.934' WHERE (`spawn_id` = '233'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '906.364' WHERE (`spawn_id` = '238'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '940.785' WHERE (`spawn_id` = '239'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '882.397' WHERE (`spawn_id` = '246'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '424.27' WHERE (`spawn_id` = '251'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.77' WHERE (`spawn_id` = '254'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '70.562' WHERE (`spawn_id` = '255'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.585' WHERE (`spawn_id` = '257'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '242.406' WHERE (`spawn_id` = '258'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '67.875' WHERE (`spawn_id` = '260'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '336.134' WHERE (`spawn_id` = '263'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.657' WHERE (`spawn_id` = '266'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '604.286' WHERE (`spawn_id` = '269'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.938' WHERE (`spawn_id` = '273'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '565.656' WHERE (`spawn_id` = '278'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6354.948', `spawn_positionY` = '-1878.964', `spawn_positionZ` = '-196.699' WHERE (`spawn_id` = '280'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-258.303' WHERE (`spawn_id` = '282'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '944.186' WHERE (`spawn_id` = '287'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.265' WHERE (`spawn_id` = '288'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '6417.55', `spawn_positionY` = '-4285.0', `spawn_positionZ` = '627.528' WHERE (`spawn_id` = '292'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '6417.55', `spawn_positionY` = '-4285.0', `spawn_positionZ` = '699.082' WHERE (`spawn_id` = '292'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '5765.252', `spawn_positionY` = '-4931.604', `spawn_positionZ` = '762.81' WHERE (`spawn_id` = '293'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-31.202' WHERE (`spawn_id` = '294'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '66.178' WHERE (`spawn_id` = '295'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '85.641' WHERE (`spawn_id` = '298'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-257.122' WHERE (`spawn_id` = '299'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '28.691' WHERE (`spawn_id` = '302'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '67.088' WHERE (`spawn_id` = '307'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '19.638' WHERE (`spawn_id` = '310'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '15.455' WHERE (`spawn_id` = '312'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '454.778' WHERE (`spawn_id` = '314'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-260.0' WHERE (`spawn_id` = '315'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-7212.61', `spawn_positionY` = '-2299.323', `spawn_positionZ` = '-253.81' WHERE (`spawn_id` = '317'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '75.38' WHERE (`spawn_id` = '328'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.836' WHERE (`spawn_id` = '335'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-264.636' WHERE (`spawn_id` = '338'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-7976.028', `spawn_positionY` = '-2348.022', `spawn_positionZ` = '-24.016' WHERE (`spawn_id` = '339'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '911.426' WHERE (`spawn_id` = '340'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.373' WHERE (`spawn_id` = '343'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10604.152', `spawn_positionY` = '-3387.443', `spawn_positionZ` = '39.09' WHERE (`spawn_id` = '344'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '941.338' WHERE (`spawn_id` = '348'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-243.0' WHERE (`spawn_id` = '353'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '792.443' WHERE (`spawn_id` = '358'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '144.124' WHERE (`spawn_id` = '361'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-244.884' WHERE (`spawn_id` = '367'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '71.464' WHERE (`spawn_id` = '368'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-269.5' WHERE (`spawn_id` = '374'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-205.952' WHERE (`spawn_id` = '377'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '789.403' WHERE (`spawn_id` = '384'); 
        -- Solid Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '52.58' WHERE (`spawn_id` = '30018'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.676' WHERE (`spawn_id` = '47584'); 
        -- Greatwood Vale Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '311.76' WHERE (`spawn_id` = '47583'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.676' WHERE (`spawn_id` = '47582'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.369' WHERE (`spawn_id` = '29993'); 
        -- Campfire XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '817.833', `spawn_positionY` = '945.833', `spawn_positionZ` = '94.343' WHERE (`spawn_id` = '47580'); 
        -- TEMP Shadra'Alor Altar Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '87.223' WHERE (`spawn_id` = '99875'); 
        -- Musty Tome Trap Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '71.66' WHERE (`spawn_id` = '12342'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.887' WHERE (`spawn_id` = '512'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.888' WHERE (`spawn_id` = '513'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.887' WHERE (`spawn_id` = '516'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.575' WHERE (`spawn_id` = '522'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '528.499' WHERE (`spawn_id` = '524'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '520.165' WHERE (`spawn_id` = '526'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.887' WHERE (`spawn_id` = '544'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '590'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '592'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.876' WHERE (`spawn_id` = '596'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '519.876' WHERE (`spawn_id` = '601'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '603'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '610'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '611'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '612'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '525.949' WHERE (`spawn_id` = '613'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '525.949' WHERE (`spawn_id` = '617'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-5.602' WHERE (`spawn_id` = '631'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '28.038' WHERE (`spawn_id` = '687'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '30.138' WHERE (`spawn_id` = '764'); 
        -- Barrel of Milk Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.852' WHERE (`spawn_id` = '47558'); 
        -- Dwarven High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '780'); 
        -- Barrel of Milk Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.873' WHERE (`spawn_id` = '47557'); 
        -- Barrel of Milk ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47552'); 
        -- Dwarven High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '804'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '53.714' WHERE (`spawn_id` = '955'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-3.627' WHERE (`spawn_id` = '974'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.649' WHERE (`spawn_id` = '1004'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '495.26' WHERE (`spawn_id` = '1009'); 
        -- Silverleaf Bush XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1173.445', `spawn_positionY` = '-3001.554', `spawn_positionZ` = '99.832' WHERE (`spawn_id` = '1078'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.03' WHERE (`spawn_id` = '1146'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '407.117' WHERE (`spawn_id` = '1173'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '407.117' WHERE (`spawn_id` = '1174'); 
        -- Silverleaf Bush XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5935.646', `spawn_positionY` = '-2903.753', `spawn_positionZ` = '369.238' WHERE (`spawn_id` = '1183'); 
        -- Burning Embers Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '7.126' WHERE (`spawn_id` = '47504'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-2.65' WHERE (`spawn_id` = '1392'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-21.168' WHERE (`spawn_id` = '1399'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '47458'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.838' WHERE (`spawn_id` = '1475'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.913' WHERE (`spawn_id` = '1490'); 
        -- Greatwood Vale Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.42' WHERE (`spawn_id` = '47451'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '96.275' WHERE (`spawn_id` = '1513'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-17.469' WHERE (`spawn_id` = '1557'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.99' WHERE (`spawn_id` = '1608'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.13' WHERE (`spawn_id` = '1609'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.349' WHERE (`spawn_id` = '1676'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '31.074' WHERE (`spawn_id` = '1690'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '114.355' WHERE (`spawn_id` = '47317'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '145.642' WHERE (`spawn_id` = '47317'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '37.011' WHERE (`spawn_id` = '1698'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '47193'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.858' WHERE (`spawn_id` = '47192'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.089' WHERE (`spawn_id` = '1786'); 
        -- Snakeroot XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '3.716', `spawn_positionY` = '-1831.217', `spawn_positionZ` = '96.578' WHERE (`spawn_id` = '1813'); 
        -- Snakeroot XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '380.849', `spawn_positionY` = '1152.36', `spawn_positionZ` = '89.758' WHERE (`spawn_id` = '1840'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.38' WHERE (`spawn_id` = '1901'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.503' WHERE (`spawn_id` = '1925'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '30.935' WHERE (`spawn_id` = '1937'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.03' WHERE (`spawn_id` = '1955'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '23.483' WHERE (`spawn_id` = '2003'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '20.166' WHERE (`spawn_id` = '2004'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.283' WHERE (`spawn_id` = '2005'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '24.98' WHERE (`spawn_id` = '2009'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '22.561' WHERE (`spawn_id` = '2028'); 
        -- Snakeroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.658' WHERE (`spawn_id` = '2042'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.603' WHERE (`spawn_id` = '2088'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.902' WHERE (`spawn_id` = '2096'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.784' WHERE (`spawn_id` = '2098'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.925' WHERE (`spawn_id` = '2108'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.701' WHERE (`spawn_id` = '2158'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '95.836' WHERE (`spawn_id` = '2160'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '107.194' WHERE (`spawn_id` = '2166'); 
        -- Common Magebloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '642.629', `spawn_positionY` = '-1575.349', `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '2179'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.064' WHERE (`spawn_id` = '2191'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.355' WHERE (`spawn_id` = '2192'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.876' WHERE (`spawn_id` = '2193'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.712' WHERE (`spawn_id` = '2213'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '81.35' WHERE (`spawn_id` = '2222'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '82.583' WHERE (`spawn_id` = '2229'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '28.848' WHERE (`spawn_id` = '2233'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '327.869' WHERE (`spawn_id` = '2237'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.457' WHERE (`spawn_id` = '2240'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.891' WHERE (`spawn_id` = '2244'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.433' WHERE (`spawn_id` = '2253'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '30.168' WHERE (`spawn_id` = '2283'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.759' WHERE (`spawn_id` = '2285'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '19.253' WHERE (`spawn_id` = '2295'); 
        -- Common Magebloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '561.842', `spawn_positionY` = '-3738.942', `spawn_positionZ` = '17.718' WHERE (`spawn_id` = '2311'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '19.601' WHERE (`spawn_id` = '2327'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '23.601' WHERE (`spawn_id` = '2333'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '44657'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.76' WHERE (`spawn_id` = '2339'); 
        -- Common Magebloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1028.345', `spawn_positionY` = '-1991.585', `spawn_positionZ` = '79.704' WHERE (`spawn_id` = '2341'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '13.253' WHERE (`spawn_id` = '2346'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '87.728' WHERE (`spawn_id` = '2347'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.406' WHERE (`spawn_id` = '2348'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '90.639' WHERE (`spawn_id` = '2350'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.651' WHERE (`spawn_id` = '2377'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.153' WHERE (`spawn_id` = '2397'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.761' WHERE (`spawn_id` = '2398'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.971' WHERE (`spawn_id` = '2401'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '29.151' WHERE (`spawn_id` = '2403'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.875' WHERE (`spawn_id` = '2406'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '32.255' WHERE (`spawn_id` = '2407'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.887' WHERE (`spawn_id` = '2423'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.861' WHERE (`spawn_id` = '44655'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '74.319' WHERE (`spawn_id` = '2474'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '15.991' WHERE (`spawn_id` = '2481'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '175.121' WHERE (`spawn_id` = '44654'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '44653'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '59.329' WHERE (`spawn_id` = '2501'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '44652'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.71' WHERE (`spawn_id` = '2515'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '2537'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '58.858' WHERE (`spawn_id` = '2561'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '15.231' WHERE (`spawn_id` = '2577'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '130.707' WHERE (`spawn_id` = '2579'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '102.218' WHERE (`spawn_id` = '2592'); 
        -- Thornroot XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10371.842', `spawn_positionY` = '-1318.831', `spawn_positionZ` = '52.909' WHERE (`spawn_id` = '2608'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '101.945' WHERE (`spawn_id` = '2612'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '150.395' WHERE (`spawn_id` = '2614'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-10.439' WHERE (`spawn_id` = '2619'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.352' WHERE (`spawn_id` = '2625'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '102.397' WHERE (`spawn_id` = '2628'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '32.502' WHERE (`spawn_id` = '2661'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '31.331' WHERE (`spawn_id` = '2671'); 
        -- Thornroot XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '650.887', `spawn_positionY` = '1382.366', `spawn_positionZ` = '82.77' WHERE (`spawn_id` = '2687'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '44.492' WHERE (`spawn_id` = '2690'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '31.089' WHERE (`spawn_id` = '2706'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.293' WHERE (`spawn_id` = '2710'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '5.749' WHERE (`spawn_id` = '2717'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.131' WHERE (`spawn_id` = '2725'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '129.152' WHERE (`spawn_id` = '2731'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.43' WHERE (`spawn_id` = '2732'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.477' WHERE (`spawn_id` = '2740'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '32.451' WHERE (`spawn_id` = '2806'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '98.731' WHERE (`spawn_id` = '2822'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '88.464' WHERE (`spawn_id` = '2835'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '101.467' WHERE (`spawn_id` = '2868'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '55.729' WHERE (`spawn_id` = '2869'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.827' WHERE (`spawn_id` = '2899'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '49.912' WHERE (`spawn_id` = '2900'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '2931'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '2932'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '86.101' WHERE (`spawn_id` = '3042'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '123.902' WHERE (`spawn_id` = '3078'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '46.646' WHERE (`spawn_id` = '3109'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '107.369' WHERE (`spawn_id` = '3118'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.168' WHERE (`spawn_id` = '3133'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.716' WHERE (`spawn_id` = '3138'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.39' WHERE (`spawn_id` = '3159'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '53.212' WHERE (`spawn_id` = '3205'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '53.15' WHERE (`spawn_id` = '3207'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3221'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '20.52' WHERE (`spawn_id` = '3260'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '53.36' WHERE (`spawn_id` = '3262'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.686' WHERE (`spawn_id` = '3289'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '57.602' WHERE (`spawn_id` = '3329'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '117.274' WHERE (`spawn_id` = '3364'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '252.407' WHERE (`spawn_id` = '3394'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.889' WHERE (`spawn_id` = '3395'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.847' WHERE (`spawn_id` = '3401'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.583' WHERE (`spawn_id` = '3469'); 
        -- Bruiseweed XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2041.671', `spawn_positionY` = '-3208.335', `spawn_positionZ` = '101.091' WHERE (`spawn_id` = '3478'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.175' WHERE (`spawn_id` = '3515'); 
        -- Bruiseweed XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2587.874', `spawn_positionY` = '-2382.282', `spawn_positionZ` = '79.878' WHERE (`spawn_id` = '3531'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.03' WHERE (`spawn_id` = '3538'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-55.438' WHERE (`spawn_id` = '3587'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '17.642' WHERE (`spawn_id` = '3597'); 
		        -- Ruins of Stardust Fountain Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '97.061' WHERE (`spawn_id` = '99862'); 
        -- Atal'ai Artifact XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10525.458', `spawn_positionY` = '-3870.514', `spawn_positionZ` = '-17.858' WHERE (`spawn_id` = '30744'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '113.891' WHERE (`spawn_id` = '3665'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.934' WHERE (`spawn_id` = '3692'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.548' WHERE (`spawn_id` = '3732'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '17.187' WHERE (`spawn_id` = '3739'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3741'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-37.248' WHERE (`spawn_id` = '3787'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '23.175' WHERE (`spawn_id` = '3793'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.898' WHERE (`spawn_id` = '3854'); 
        -- Wild Steelbloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4286.811', `spawn_positionY` = '-2070.202', `spawn_positionZ` = '88.609' WHERE (`spawn_id` = '3923'); 
        -- Wild Steelbloom ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3968'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '98.374' WHERE (`spawn_id` = '3969'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '255.354' WHERE (`spawn_id` = '4005'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '18.871' WHERE (`spawn_id` = '4024'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '253.799' WHERE (`spawn_id` = '4025'); 
        -- Wild Steelbloom ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4045'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-20.385' WHERE (`spawn_id` = '4050'); 
        -- Wild Steelbloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3600.042', `spawn_positionY` = '-1762.24', `spawn_positionZ` = '139.489' WHERE (`spawn_id` = '4065'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '72.52' WHERE (`spawn_id` = '4090'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.071' WHERE (`spawn_id` = '4095'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '253.317' WHERE (`spawn_id` = '4216'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '95.741' WHERE (`spawn_id` = '4267'); 
        -- Wild Steelbloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2639.203', `spawn_positionY` = '-2318.273', `spawn_positionZ` = '91.608' WHERE (`spawn_id` = '4268'); 
        -- Crownroyal Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '56.356' WHERE (`spawn_id` = '4294'); 
        -- Crownroyal Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.98' WHERE (`spawn_id` = '4311'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.389' WHERE (`spawn_id` = '28518'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.116' WHERE (`spawn_id` = '18909'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.625' WHERE (`spawn_id` = '18890'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.81' WHERE (`spawn_id` = '18889'); 
        -- Thornroot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.744' WHERE (`spawn_id` = '44642'); 
        -- Burning Embers Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '40718'); 
        -- Warm Fire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '40716'); 
        -- Warm Fire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '40715'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '86.9' WHERE (`spawn_id` = '40714'); 
        -- Bruiseweed Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '117.836' WHERE (`spawn_id` = '29658'); 
        -- Alliance Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.586' WHERE (`spawn_id` = '29650'); 
        -- DANGER! Do Not Open! Move Along! Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.99' WHERE (`spawn_id` = '29645'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '32.669' WHERE (`spawn_id` = '4652'); 
        -- Ironforge Main Gate ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4691'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4699'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '20.049' WHERE (`spawn_id` = '4711'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-55.161' WHERE (`spawn_id` = '4728'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.822' WHERE (`spawn_id` = '18888'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-46.288' WHERE (`spawn_id` = '4762'); 
        -- Black Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '53.845' WHERE (`spawn_id` = '3998089'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '186.07' WHERE (`spawn_id` = '4766'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-22.613' WHERE (`spawn_id` = '4768'); 
        -- Black Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.604' WHERE (`spawn_id` = '3998088'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '29.679' WHERE (`spawn_id` = '4799'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '249.881' WHERE (`spawn_id` = '4802'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '5.163' WHERE (`spawn_id` = '4807'); 
        -- Black Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.561' WHERE (`spawn_id` = '3998085'); 
        -- Black Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '7.22' WHERE (`spawn_id` = '3998084'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.841' WHERE (`spawn_id` = '4824'); 
        -- Black Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.976' WHERE (`spawn_id` = '3998081'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '106.417' WHERE (`spawn_id` = '4898'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.014' WHERE (`spawn_id` = '4901'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '52.078' WHERE (`spawn_id` = '4936'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '4302.084', `spawn_positionY` = '943.749', `spawn_positionZ` = '52.078' WHERE (`spawn_id` = '4936'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '46.039' WHERE (`spawn_id` = '5031'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-13.056' WHERE (`spawn_id` = '5061'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '6805.169', `spawn_positionY` = '-679.499', `spawn_positionZ` = '97.658' WHERE (`spawn_id` = '5066'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '20.473' WHERE (`spawn_id` = '5361'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.049' WHERE (`spawn_id` = '5377'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.399' WHERE (`spawn_id` = '5421'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.118' WHERE (`spawn_id` = '5452'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '106.626' WHERE (`spawn_id` = '5464'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '45.543', `spawn_positionY` = '-1725.294', `spawn_positionZ` = '106.626' WHERE (`spawn_id` = '5464'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8918.297', `spawn_positionY` = '-1945.519', `spawn_positionZ` = '134.216' WHERE (`spawn_id` = '5511'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-809.262', `spawn_positionY` = '133.229', `spawn_positionZ` = '18.607' WHERE (`spawn_id` = '5514'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.683' WHERE (`spawn_id` = '18887'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '5.703' WHERE (`spawn_id` = '5559'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.018' WHERE (`spawn_id` = '5561'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '46.986' WHERE (`spawn_id` = '5633'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8933.606', `spawn_positionY` = '-1977.563', `spawn_positionZ` = '133.189' WHERE (`spawn_id` = '5675'); 
        -- Silver Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '164.403' WHERE (`spawn_id` = '5725'); 
        -- Silver Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '158.827' WHERE (`spawn_id` = '5728'); 
        -- Silver Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '18.83' WHERE (`spawn_id` = '5762'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.865' WHERE (`spawn_id` = '5770'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.513' WHERE (`spawn_id` = '5773'); 
        -- Gold Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '1240.966', `spawn_positionY` = '-1257.593', `spawn_positionZ` = '43.924' WHERE (`spawn_id` = '5783'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '5785'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '140.666' WHERE (`spawn_id` = '5801'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '46.276' WHERE (`spawn_id` = '5819'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.676' WHERE (`spawn_id` = '5839'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '73.703' WHERE (`spawn_id` = '5859'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '50.96' WHERE (`spawn_id` = '5861'); 
        -- Gold Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '1241.67', `spawn_positionY` = '-1272.324', `spawn_positionZ` = '43.074' WHERE (`spawn_id` = '5863'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.716' WHERE (`spawn_id` = '5914'); 
        -- Gold Vein ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '5959'); 
        -- Gold Vein ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '5960'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '5983'); 
        -- Gold Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10969.125', `spawn_positionY` = '-3695.028', `spawn_positionZ` = '17.251' WHERE (`spawn_id` = '5995'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '70.886' WHERE (`spawn_id` = '6000'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.834' WHERE (`spawn_id` = '6002'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '138.23' WHERE (`spawn_id` = '6019'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '116.027' WHERE (`spawn_id` = '6061'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '367.703' WHERE (`spawn_id` = '6076'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '25.39' WHERE (`spawn_id` = '6107'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '90.278' WHERE (`spawn_id` = '6127'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '12.037' WHERE (`spawn_id` = '6128'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '12.387' WHERE (`spawn_id` = '6147'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-42.434' WHERE (`spawn_id` = '6155'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-48.643' WHERE (`spawn_id` = '6157'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '58.518' WHERE (`spawn_id` = '6197'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5121.117', `spawn_positionY` = '1795.439', `spawn_positionZ` = '50.692' WHERE (`spawn_id` = '6199'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1452.101', `spawn_positionY` = '2943.731', `spawn_positionZ` = '136.712' WHERE (`spawn_id` = '6210'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '144.217' WHERE (`spawn_id` = '6220'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '6229'); 

        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '131.359' WHERE (`spawn_id` = '6241'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '113.478' WHERE (`spawn_id` = '6242'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '176.463' WHERE (`spawn_id` = '6249'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '6250'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.387' WHERE (`spawn_id` = '6252'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.092' WHERE (`spawn_id` = '6288'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '79.7' WHERE (`spawn_id` = '6298'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '68.58' WHERE (`spawn_id` = '6304'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-58.749' WHERE (`spawn_id` = '6322'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '178.669' WHERE (`spawn_id` = '6349'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '101.954' WHERE (`spawn_id` = '6366'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '90.481' WHERE (`spawn_id` = '6372'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '87.957' WHERE (`spawn_id` = '6373'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4992.803', `spawn_positionY` = '-2291.727', `spawn_positionZ` = '-61.709' WHERE (`spawn_id` = '6378'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-814.5', `spawn_positionY` = '-3883.0', `spawn_positionZ` = '180.319' WHERE (`spawn_id` = '6414'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6643.518', `spawn_positionY` = '-3714.351', `spawn_positionZ` = '278.994' WHERE (`spawn_id` = '6449'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '40.434' WHERE (`spawn_id` = '14954'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '24.255' WHERE (`spawn_id` = '6485'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10954.143', `spawn_positionY` = '-3706.594', `spawn_positionZ` = '18.849' WHERE (`spawn_id` = '6492'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5099.394', `spawn_positionY` = '1781.258', `spawn_positionZ` = '51.33' WHERE (`spawn_id` = '6495'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '40.564' WHERE (`spawn_id` = '14953'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6467.737', `spawn_positionY` = '-2480.182', `spawn_positionZ` = '326.823' WHERE (`spawn_id` = '6503'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '40.467' WHERE (`spawn_id` = '14952'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-13134.521', `spawn_positionY` = '-481.502', `spawn_positionZ` = '4.085' WHERE (`spawn_id` = '6521'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '40.3' WHERE (`spawn_id` = '14951'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.921' WHERE (`spawn_id` = '14950'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '90.485' WHERE (`spawn_id` = '6551'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-7310.229', `spawn_positionY` = '-1956.119', `spawn_positionZ` = '308.881' WHERE (`spawn_id` = '6556'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.005' WHERE (`spawn_id` = '14949'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.002' WHERE (`spawn_id` = '14948'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4982.301', `spawn_positionY` = '-2316.412', `spawn_positionZ` = '-56.926' WHERE (`spawn_id` = '6560'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5016.368', `spawn_positionY` = '1794.606', `spawn_positionZ` = '65.902' WHERE (`spawn_id` = '6577'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.329' WHERE (`spawn_id` = '6587'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5046.849', `spawn_positionY` = '1792.557', `spawn_positionZ` = '57.756' WHERE (`spawn_id` = '6588'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.695' WHERE (`spawn_id` = '6592'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.181' WHERE (`spawn_id` = '14947'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.168' WHERE (`spawn_id` = '14946'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-884.0', `spawn_positionY` = '-3912.0', `spawn_positionZ` = '147.56' WHERE (`spawn_id` = '6614'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.677' WHERE (`spawn_id` = '6624'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4944.349', `spawn_positionY` = '-2341.905', `spawn_positionZ` = '-57.6' WHERE (`spawn_id` = '6625'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2975.015', `spawn_positionY` = '-3154.677', `spawn_positionZ` = '52.554' WHERE (`spawn_id` = '6639'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '15.414' WHERE (`spawn_id` = '6645'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2024.515', `spawn_positionY` = '-3336.165', `spawn_positionZ` = '49.725' WHERE (`spawn_id` = '6651'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '86.288' WHERE (`spawn_id` = '6661'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '90.169' WHERE (`spawn_id` = '6668'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '6676'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.112' WHERE (`spawn_id` = '6678'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.206' WHERE (`spawn_id` = '6704'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4937.387', `spawn_positionY` = '-2349.707', `spawn_positionZ` = '-48.827' WHERE (`spawn_id` = '6718'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2038.625', `spawn_positionY` = '-3371.98', `spawn_positionZ` = '46.037' WHERE (`spawn_id` = '6729'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.511' WHERE (`spawn_id` = '6737'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '29.002' WHERE (`spawn_id` = '6740'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '146.556' WHERE (`spawn_id` = '6744'); 
        -- TEMP Nearby Tubers Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '82.474' WHERE (`spawn_id` = '99868'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-7829.0', `spawn_positionY` = '-5004.78', `spawn_positionZ` = '23.592' WHERE (`spawn_id` = '6751'); 
        -- Open To Pass Your Rite. Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '183.149' WHERE (`spawn_id` = '29644'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.493' WHERE (`spawn_id` = '34172'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.676' WHERE (`spawn_id` = '34164'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '34163'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '34162'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.319' WHERE (`spawn_id` = '34161'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.019' WHERE (`spawn_id` = '34150'); 
        -- Atal'ai Artifact Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-75.333' WHERE (`spawn_id` = '30559'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '34077'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '33911'); 
        -- Dwarven Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6836'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6839'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-811.035', `spawn_positionY` = '155.677', `spawn_positionZ` = '2.727' WHERE (`spawn_id` = '21273'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.457' WHERE (`spawn_id` = '33555'); 
        -- Dwarven Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6872'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6874'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '9.839' WHERE (`spawn_id` = '35551'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-814.012', `spawn_positionY` = '164.024', `spawn_positionZ` = '0.648' WHERE (`spawn_id` = '21259'); 
        -- Tammra Gaea Sapling Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '33531'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-28.823' WHERE (`spawn_id` = '21249'); 
        -- Atal'ai Artifact Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.693' WHERE (`spawn_id` = '30383'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.457' WHERE (`spawn_id` = '32863'); 
        -- Atal'ai Artifact Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-25.613' WHERE (`spawn_id` = '30378'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '32669'); 
        -- Anvil ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '32667'); 
        -- Meat Smoker ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '32659'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '47.605' WHERE (`spawn_id` = '14930'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '186.07' WHERE (`spawn_id` = '32654'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2351.913', `spawn_positionY` = '2413.787', `spawn_positionZ` = '61.14' WHERE (`spawn_id` = '32647'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2347.225', `spawn_positionY` = '2413.241', `spawn_positionZ` = '62.401' WHERE (`spawn_id` = '32647'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2399.662', `spawn_positionY` = '2420.426', `spawn_positionZ` = '58.416' WHERE (`spawn_id` = '32604'); 
        -- Alliance Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '54.189' WHERE (`spawn_id` = '20885'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '119.487' WHERE (`spawn_id` = '7070'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.102' WHERE (`spawn_id` = '7141'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '79.674' WHERE (`spawn_id` = '7146'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2067.0', `spawn_positionY` = '-3350.525', `spawn_positionZ` = '40.86' WHERE (`spawn_id` = '7177'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '7.082' WHERE (`spawn_id` = '7199'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '90.748' WHERE (`spawn_id` = '7302'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '115.395' WHERE (`spawn_id` = '7315'); 
        -- Liferoot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '13.363' WHERE (`spawn_id` = '7335'); 
        -- Liferoot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '124.15' WHERE (`spawn_id` = '7538'); 
        -- Liferoot Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.062' WHERE (`spawn_id` = '7545'); 
        -- Fadeleaf Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '121.3' WHERE (`spawn_id` = '7577'); 
        -- Fadeleaf Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '117.919' WHERE (`spawn_id` = '7579'); 
        -- Fadeleaf Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '118.866' WHERE (`spawn_id` = '7660'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.715' WHERE (`spawn_id` = '14613'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.405' WHERE (`spawn_id` = '14604'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.006' WHERE (`spawn_id` = '13672'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.853' WHERE (`spawn_id` = '13671'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.834' WHERE (`spawn_id` = '13670'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '12.188' WHERE (`spawn_id` = '13669'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.248' WHERE (`spawn_id` = '13657'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.207' WHERE (`spawn_id` = '13656'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '120.349' WHERE (`spawn_id` = '7935'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '15.518' WHERE (`spawn_id` = '7963'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.441' WHERE (`spawn_id` = '7966'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.142' WHERE (`spawn_id` = '8047'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '122.04' WHERE (`spawn_id` = '8119'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.448' WHERE (`spawn_id` = '8163'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.824' WHERE (`spawn_id` = '8224'); 
        -- Stranglekelp ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8234'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.635' WHERE (`spawn_id` = '8235'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.678' WHERE (`spawn_id` = '8237'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.618' WHERE (`spawn_id` = '8238'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.333' WHERE (`spawn_id` = '8243'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.599' WHERE (`spawn_id` = '8248'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.302' WHERE (`spawn_id` = '8250'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.56' WHERE (`spawn_id` = '8259'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.528' WHERE (`spawn_id` = '8261'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.147' WHERE (`spawn_id` = '8262'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.808' WHERE (`spawn_id` = '8263'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.844' WHERE (`spawn_id` = '8264'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.659' WHERE (`spawn_id` = '8266'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.637' WHERE (`spawn_id` = '8267'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.459' WHERE (`spawn_id` = '8268'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-3.279' WHERE (`spawn_id` = '8272'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.555' WHERE (`spawn_id` = '8298'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.091' WHERE (`spawn_id` = '8299'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.231' WHERE (`spawn_id` = '8304'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.386' WHERE (`spawn_id` = '8308'); 
        -- Stranglekelp ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8311'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.147' WHERE (`spawn_id` = '8316'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.556' WHERE (`spawn_id` = '8318'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.972' WHERE (`spawn_id` = '8319'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.729' WHERE (`spawn_id` = '8330'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.64' WHERE (`spawn_id` = '8331'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.574' WHERE (`spawn_id` = '8337'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-2.104' WHERE (`spawn_id` = '8339'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-4.136' WHERE (`spawn_id` = '8340'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.625' WHERE (`spawn_id` = '8369'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.859' WHERE (`spawn_id` = '8385'); 
        -- Fadeleaf Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '39.598' WHERE (`spawn_id` = '13641'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.527' WHERE (`spawn_id` = '8404'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.857' WHERE (`spawn_id` = '8406'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.681' WHERE (`spawn_id` = '8411'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.039' WHERE (`spawn_id` = '8428'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.188' WHERE (`spawn_id` = '8442'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-4.566' WHERE (`spawn_id` = '8447'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.087' WHERE (`spawn_id` = '8454'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.651' WHERE (`spawn_id` = '8457'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-2.548' WHERE (`spawn_id` = '8468'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.568' WHERE (`spawn_id` = '8501'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '12.563' WHERE (`spawn_id` = '8508'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.412' WHERE (`spawn_id` = '8509'); 

        insert into applied_updates values ('190120221');
    end if;
end $
delimiter ;