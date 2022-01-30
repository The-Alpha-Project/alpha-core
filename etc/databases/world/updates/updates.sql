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
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '168.787' WHERE (`spawn_id` = '443'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '166.461' WHERE (`spawn_id` = '444'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '172.447' WHERE (`spawn_id` = '449'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '160.752' WHERE (`spawn_id` = '450'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '170.525' WHERE (`spawn_id` = '452'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '168.753' WHERE (`spawn_id` = '454'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '165.485' WHERE (`spawn_id` = '455'); 
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

        insert into applied_updates values ('190120221');
    end if;
end $
delimiter ;