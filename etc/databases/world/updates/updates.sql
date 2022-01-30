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

        insert into applied_updates values ('190120221');
    end if;
end $
delimiter ;