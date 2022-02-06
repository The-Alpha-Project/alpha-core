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
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.821' WHERE (`spawn_id` = '8534'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.648' WHERE (`spawn_id` = '8535'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.676' WHERE (`spawn_id` = '8536'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.523' WHERE (`spawn_id` = '8537'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.24' WHERE (`spawn_id` = '8538'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.432' WHERE (`spawn_id` = '8540'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.697' WHERE (`spawn_id` = '8542'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.701' WHERE (`spawn_id` = '8543'); 
        -- Stranglekelp XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '2136.485', `spawn_positionY` = '-313.482', `spawn_positionZ` = '91.118' WHERE (`spawn_id` = '8545'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.441' WHERE (`spawn_id` = '8549'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.754' WHERE (`spawn_id` = '8550'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.58' WHERE (`spawn_id` = '8556'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.598' WHERE (`spawn_id` = '8557'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.075' WHERE (`spawn_id` = '8559'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.398' WHERE (`spawn_id` = '8564'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.636' WHERE (`spawn_id` = '8566'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.621' WHERE (`spawn_id` = '8567'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.003' WHERE (`spawn_id` = '8575'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.088' WHERE (`spawn_id` = '8576'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.732' WHERE (`spawn_id` = '8577'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-2.278' WHERE (`spawn_id` = '8578'); 
        -- Stranglekelp Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-12.684' WHERE (`spawn_id` = '8589'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '27.452' WHERE (`spawn_id` = '8608'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.832' WHERE (`spawn_id` = '8699'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '118.894' WHERE (`spawn_id` = '8700'); 
        -- Goldthorn XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '40.752', `spawn_positionY` = '-3667.576', `spawn_positionZ` = '121.721' WHERE (`spawn_id` = '8701'); 
        -- Crownroyal Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.379' WHERE (`spawn_id` = '12566'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.936' WHERE (`spawn_id` = '8712'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '32.887' WHERE (`spawn_id` = '11764'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '39.014' WHERE (`spawn_id` = '11762'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.589' WHERE (`spawn_id` = '11760'); 
        -- Crownroyal Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '39.065' WHERE (`spawn_id` = '11756'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '125.236' WHERE (`spawn_id` = '8868'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '7.189' WHERE (`spawn_id` = '8889'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-6.0' WHERE (`spawn_id` = '8904'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.855' WHERE (`spawn_id` = '8906'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '22.051' WHERE (`spawn_id` = '8913'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-3.555' WHERE (`spawn_id` = '8948'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.688' WHERE (`spawn_id` = '8959'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.583' WHERE (`spawn_id` = '9005'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-4.526' WHERE (`spawn_id` = '9013'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '131.264' WHERE (`spawn_id` = '9039'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '126.952' WHERE (`spawn_id` = '9053'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '85.357' WHERE (`spawn_id` = '9092'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '76.245' WHERE (`spawn_id` = '9201'); 
        -- Goldthorn Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '81.763' WHERE (`spawn_id` = '9202'); 
        -- Goldthorn XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '42.254', `spawn_positionY` = '-3664.0', `spawn_positionZ` = '120.138' WHERE (`spawn_id` = '9210'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '674.997' WHERE (`spawn_id` = '9232'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.173' WHERE (`spawn_id` = '9237'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '126.016' WHERE (`spawn_id` = '9246'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.038' WHERE (`spawn_id` = '9266'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '81.28' WHERE (`spawn_id` = '9271'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-258.168' WHERE (`spawn_id` = '9275'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '28.341' WHERE (`spawn_id` = '9345'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '19.938' WHERE (`spawn_id` = '9347'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-205.408', `spawn_positionY` = '-383.035', `spawn_positionZ` = '65.956' WHERE (`spawn_id` = '9350'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '124.173' WHERE (`spawn_id` = '9364'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.262' WHERE (`spawn_id` = '9390'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '134.366' WHERE (`spawn_id` = '9397'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '811.161' WHERE (`spawn_id` = '9398'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-729.052', `spawn_positionY` = '-3695.72', `spawn_positionZ` = '195.584' WHERE (`spawn_id` = '9401'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-722.33', `spawn_positionY` = '-3692.587', `spawn_positionZ` = '196.207' WHERE (`spawn_id` = '9402'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '1334.458', `spawn_positionY` = '-1681.675', `spawn_positionZ` = '73.51' WHERE (`spawn_id` = '9403'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '116.679' WHERE (`spawn_id` = '9418'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-277.437', `spawn_positionY` = '-380.104', `spawn_positionZ` = '68.806' WHERE (`spawn_id` = '9420'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '688.414' WHERE (`spawn_id` = '9423'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2007.75', `spawn_positionY` = '-3290.647', `spawn_positionZ` = '59.618' WHERE (`spawn_id` = '9438'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '688.414' WHERE (`spawn_id` = '9445'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '44.259' WHERE (`spawn_id` = '9446'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.005' WHERE (`spawn_id` = '9455'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.222' WHERE (`spawn_id` = '9455'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-11158.411', `spawn_positionY` = '-1167.057', `spawn_positionZ` = '42.353' WHERE (`spawn_id` = '9457'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '39.272' WHERE (`spawn_id` = '9468'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5618.776', `spawn_positionY` = '3443.809', `spawn_positionZ` = '49.705' WHERE (`spawn_id` = '9481'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-209.05', `spawn_positionY` = '-384.295', `spawn_positionZ` = '65.214' WHERE (`spawn_id` = '9523'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '118.97' WHERE (`spawn_id` = '9575'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.382' WHERE (`spawn_id` = '9587'); 
        -- Iron Deposit ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9592'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-672.413', `spawn_positionY` = '-3772.663', `spawn_positionZ` = '216.557' WHERE (`spawn_id` = '9605'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.964' WHERE (`spawn_id` = '9622'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5640.168', `spawn_positionY` = '3531.055', `spawn_positionZ` = '44.682' WHERE (`spawn_id` = '9623'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '43.766' WHERE (`spawn_id` = '9623'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '240.768' WHERE (`spawn_id` = '9633'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-248.233', `spawn_positionY` = '-400.591', `spawn_positionZ` = '67.74' WHERE (`spawn_id` = '9636'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2358.7', `spawn_positionY` = '2502.176', `spawn_positionZ` = '75.21' WHERE (`spawn_id` = '32601'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2335.491', `spawn_positionY` = '2472.6', `spawn_positionZ` = '76.172' WHERE (`spawn_id` = '32600'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2345.112', `spawn_positionY` = '2453.43', `spawn_positionZ` = '67.707' WHERE (`spawn_id` = '32599'); 
        -- Tear of Theradras Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '72.315' WHERE (`spawn_id` = '32598'); 
        -- Tear of Theradras Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '58.188' WHERE (`spawn_id` = '32596'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5550.423', `spawn_positionY` = '658.624', `spawn_positionZ` = '393.387' WHERE (`spawn_id` = '9938'); 
        -- Vylestem Vine Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.523' WHERE (`spawn_id` = '32573'); 
        -- Barrel of Melon Juice XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-498.822', `spawn_positionY` = '-1536.943', `spawn_positionZ` = '59.761' WHERE (`spawn_id` = '20856'); 
        -- Rise of the Horde Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '39.854' WHERE (`spawn_id` = '29688'); 
        -- The Dark Portal and the Fall of Stormwind Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '20.962' WHERE (`spawn_id` = '29686'); 
        -- The New Horde Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '39.855' WHERE (`spawn_id` = '29681'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.867' WHERE (`spawn_id` = '32535'); 
        -- Karnitol's Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.121' WHERE (`spawn_id` = '32531'); 
        -- MacGrann's Meat Locker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '417.986' WHERE (`spawn_id` = '10027'); 
        -- The Battle of Grim Batol XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1897.128', `spawn_positionY` = '352.391', `spawn_positionZ` = '107.661' WHERE (`spawn_id` = '32506'); 
        -- War of the Three Hammers XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1898.901', `spawn_positionY` = '336.872', `spawn_positionZ` = '105.117' WHERE (`spawn_id` = '32010'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.774' WHERE (`spawn_id` = '20817'); 
        -- Ironforge - the Awakening of the Dwarves XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1896.912', `spawn_positionY` = '355.444', `spawn_positionZ` = '107.55' WHERE (`spawn_id` = '31909'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '386.112' WHERE (`spawn_id` = '10105'); 
        -- Mighty Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '31346'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '31344'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '31342'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30952'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30908'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30907'); 
        -- Mighty Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30906'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30905'); 
        -- Campfire XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2284.958', `spawn_positionY` = '2657.683', `spawn_positionZ` = '60.66' WHERE (`spawn_id` = '30904'); 
        -- Caravan Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.686' WHERE (`spawn_id` = '29362'); 
        -- Locked ball and chain Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.226' WHERE (`spawn_id` = '20785'); 
        -- Locked ball and chain Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '53.623' WHERE (`spawn_id` = '20784'); 
        -- Alterac Granite XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-241.674', `spawn_positionY` = '-267.344', `spawn_positionZ` = '54.413' WHERE (`spawn_id` = '20782'); 
        -- Alterac Granite XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-212.773', `spawn_positionY` = '-383.497', `spawn_positionZ` = '64.896' WHERE (`spawn_id` = '20781'); 
        -- Flame of Veraz XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-210.968', `spawn_positionY` = '-308.329', `spawn_positionZ` = '49.109' WHERE (`spawn_id` = '20780'); 
        -- Flame of Azel XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-211.04', `spawn_positionY` = '-378.924', `spawn_positionZ` = '65.852' WHERE (`spawn_id` = '20779'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8943.978', `spawn_positionY` = '-2035.95', `spawn_positionZ` = '133.951' WHERE (`spawn_id` = '31124'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8957.213', `spawn_positionY` = '-2000.348', `spawn_positionZ` = '134.091' WHERE (`spawn_id` = '31123'); 
        -- Battered Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8910.886', `spawn_positionY` = '-1962.685', `spawn_positionZ` = '130.836' WHERE (`spawn_id` = '31122'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8946.009', `spawn_positionY` = '-1975.52', `spawn_positionZ` = '135.707' WHERE (`spawn_id` = '20883'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8904.822', `spawn_positionY` = '-1918.278', `spawn_positionZ` = '133.83' WHERE (`spawn_id` = '20882'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8867.052', `spawn_positionY` = '-1849.176', `spawn_positionZ` = '120.721' WHERE (`spawn_id` = '20454'); 
        -- Water Barrel Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '358.872' WHERE (`spawn_id` = '10847'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5704.192', `spawn_positionY` = '-1684.101', `spawn_positionZ` = '358.417' WHERE (`spawn_id` = '10853'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5615.457', `spawn_positionY` = '-1648.702', `spawn_positionZ` = '354.348' WHERE (`spawn_id` = '10855'); 
        -- Battered Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5559.417', `spawn_positionY` = '-1607.08', `spawn_positionZ` = '353.305' WHERE (`spawn_id` = '10856'); 
        -- Ironband's Strongbox Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '408.592' WHERE (`spawn_id` = '10868'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-322.092', `spawn_positionY` = '931.233', `spawn_positionZ` = '131.866' WHERE (`spawn_id` = '35444'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-8747.848', `spawn_positionY` = '-2246.65', `spawn_positionZ` = '153.659' WHERE (`spawn_id` = '18679'); 
        -- Solid Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.926' WHERE (`spawn_id` = '9096'); 
        -- Onyxia's Gate Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.097' WHERE (`spawn_id` = '9091'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4088.002', `spawn_positionY` = '-4537.01', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9087'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4089.954', `spawn_positionY` = '-4530.919', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9082'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-820.755', `spawn_positionY` = '-563.622', `spawn_positionZ` = '16.408' WHERE (`spawn_id` = '18819'); 
        -- Shaman Shrine Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.29' WHERE (`spawn_id` = '35418'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.643' WHERE (`spawn_id` = '17994'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.909' WHERE (`spawn_id` = '17993'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '186.92' WHERE (`spawn_id` = '17991'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.883' WHERE (`spawn_id` = '17988'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.764' WHERE (`spawn_id` = '17986'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.375' WHERE (`spawn_id` = '17984'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.297' WHERE (`spawn_id` = '17982'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '186.743' WHERE (`spawn_id` = '17980'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.607' WHERE (`spawn_id` = '17979'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.638' WHERE (`spawn_id` = '17977'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.764' WHERE (`spawn_id` = '17976'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.542' WHERE (`spawn_id` = '17974'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '182.629' WHERE (`spawn_id` = '17973'); 
        -- Wooden Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '181.718' WHERE (`spawn_id` = '17966'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1818.535', `spawn_positionY` = '-1160.698', `spawn_positionZ` = '84.396' WHERE (`spawn_id` = '20722'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1796.07', `spawn_positionY` = '-1133.676', `spawn_positionZ` = '89.368' WHERE (`spawn_id` = '20721'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2414.816', `spawn_positionY` = '352.55', `spawn_positionZ` = '71.249' WHERE (`spawn_id` = '20717'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2355.516', `spawn_positionY` = '374.086', `spawn_positionZ` = '71.101' WHERE (`spawn_id` = '20716'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1729.654', `spawn_positionY` = '-1183.665', `spawn_positionZ` = '83.191' WHERE (`spawn_id` = '20672'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2409.372', `spawn_positionY` = '392.377', `spawn_positionZ` = '65.291' WHERE (`spawn_id` = '20667'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1803.327', `spawn_positionY` = '-1145.089', `spawn_positionZ` = '86.233' WHERE (`spawn_id` = '20648'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1786.272', `spawn_positionY` = '-995.415', `spawn_positionZ` = '86.124' WHERE (`spawn_id` = '20644'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '85.098' WHERE (`spawn_id` = '20644'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1457.337', `spawn_positionY` = '-920.6', `spawn_positionZ` = '51.495' WHERE (`spawn_id` = '20642'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '50.769' WHERE (`spawn_id` = '20642'); 
		        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '72.494' WHERE (`spawn_id` = '42512'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '72.495' WHERE (`spawn_id` = '42511'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4087.813', `spawn_positionY` = '-4538.993', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9079'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4090.135', `spawn_positionY` = '-4528.345', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9077'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4092.054', `spawn_positionY` = '-4542.481', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9063'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9062'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4093.94', `spawn_positionY` = '-4534.429', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9056'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4080.577', `spawn_positionY` = '-4537.296', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9038'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4090.338', `spawn_positionY` = '-4535.015', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9037'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3979.879', `spawn_positionY` = '-4594.738', `spawn_positionZ` = '0.077' WHERE (`spawn_id` = '9034'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3994.309', `spawn_positionY` = '-4594.834', `spawn_positionZ` = '0.077' WHERE (`spawn_id` = '9032'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3992.362', `spawn_positionY` = '-4590.767', `spawn_positionZ` = '0.077' WHERE (`spawn_id` = '9024'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3997.958', `spawn_positionY` = '-4611.022', `spawn_positionZ` = '7.394' WHERE (`spawn_id` = '9006'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9001'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9000'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8996'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8996'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8979'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '86.522' WHERE (`spawn_id` = '20560'); 
        -- Bonfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '163.335' WHERE (`spawn_id` = '20556'); 
        -- Food Crate XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1925.28', `spawn_positionY` = '417.42', `spawn_positionZ` = '186.07' WHERE (`spawn_id` = '20528'); 
        -- Food Crate XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1948.225', `spawn_positionY` = '377.8', `spawn_positionZ` = '133.381' WHERE (`spawn_id` = '20528'); 
        -- Food Crate XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1886.202', `spawn_positionY` = '-1098.123', `spawn_positionZ` = '87.3' WHERE (`spawn_id` = '20526'); 
        -- Food Crate XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1826.478', `spawn_positionY` = '-1124.856', `spawn_positionZ` = '84.674' WHERE (`spawn_id` = '20525'); 
        -- Solid Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-877.876', `spawn_positionY` = '-3873.885', `spawn_positionZ` = '159.727' WHERE (`spawn_id` = '16977'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2022.357', `spawn_positionY` = '-3371.005', `spawn_positionZ` = '52.244' WHERE (`spawn_id` = '16974'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2012.945', `spawn_positionY` = '-3312.173', `spawn_positionZ` = '52.082' WHERE (`spawn_id` = '16973'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-870.385', `spawn_positionY` = '-3821.466', `spawn_positionZ` = '145.192' WHERE (`spawn_id` = '11993'); 
        -- Lesser Bloodstone Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '143.782' WHERE (`spawn_id` = '11993'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-873.807', `spawn_positionY` = '-3840.334', `spawn_positionZ` = '149.58' WHERE (`spawn_id` = '11995'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '148.947' WHERE (`spawn_id` = '11995'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-797.869', `spawn_positionY` = '-3808.113', `spawn_positionZ` = '144.85' WHERE (`spawn_id` = '11997'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '143.062' WHERE (`spawn_id` = '11997'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-942.759', `spawn_positionY` = '-3857.444', `spawn_positionZ` = '147.871' WHERE (`spawn_id` = '11999'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '147.196' WHERE (`spawn_id` = '11999'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-803.337', `spawn_positionY` = '-3838.042', `spawn_positionZ` = '140.398' WHERE (`spawn_id` = '12001'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '137.824' WHERE (`spawn_id` = '12001'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-834.981', `spawn_positionY` = '-3903.662', `spawn_positionZ` = '153.738' WHERE (`spawn_id` = '12002'); 
        -- Lesser Bloodstone Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '153.38' WHERE (`spawn_id` = '12002'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-852.325', `spawn_positionY` = '-3896.017', `spawn_positionZ` = '155.17' WHERE (`spawn_id` = '12005'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-887.304', `spawn_positionY` = '-3083.02', `spawn_positionZ` = '80.638' WHERE (`spawn_id` = '16965'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '77.763' WHERE (`spawn_id` = '16965'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '153.873' WHERE (`spawn_id` = '16964'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-984.15', `spawn_positionY` = '-3845.262', `spawn_positionZ` = '144.812' WHERE (`spawn_id` = '16958'); 
        -- Lesser Bloodstone Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '143.037' WHERE (`spawn_id` = '16958'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-900.728', `spawn_positionY` = '-3824.991', `spawn_positionZ` = '146.628' WHERE (`spawn_id` = '16954'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '146.283' WHERE (`spawn_id` = '16954'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2061.016', `spawn_positionY` = '-3354.228', `spawn_positionZ` = '42.784' WHERE (`spawn_id` = '16931'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '41.178' WHERE (`spawn_id` = '16931'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-7.673' WHERE (`spawn_id` = '20420'); 
        -- Smoke Emitter 02 Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.722' WHERE (`spawn_id` = '16771'); 
        -- Small Barracks Flame Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.164' WHERE (`spawn_id` = '14779'); 
        -- Smoke Emitter 02 Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.901' WHERE (`spawn_id` = '16770'); 
        -- Big Barracks Flame Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.905' WHERE (`spawn_id` = '14776'); 
        -- Small Barracks Flame Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.683' WHERE (`spawn_id` = '14780'); 
        -- Small Barracks Flame Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.9' WHERE (`spawn_id` = '14777'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-983.377', `spawn_positionY` = '-3879.499', `spawn_positionZ` = '142.401' WHERE (`spawn_id` = '16906'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '141.518' WHERE (`spawn_id` = '16906'); 
        -- Firebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '11.493' WHERE (`spawn_id` = '12242'); 
        -- Firebloom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-7262.0', `spawn_positionY` = '-864.0', `spawn_positionZ` = '289.955' WHERE (`spawn_id` = '12243'); 
        -- Firebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.623' WHERE (`spawn_id` = '12250'); 
        -- Firebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.319' WHERE (`spawn_id` = '12274'); 
        -- Forge XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1938.896', `spawn_positionY` = '383.6', `spawn_positionZ` = '133.448' WHERE (`spawn_id` = '30166'); 
        -- Anvil XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1946.268', `spawn_positionY` = '379.568', `spawn_positionZ` = '133.412' WHERE (`spawn_id` = '30168'); 
        -- Firebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '13.28' WHERE (`spawn_id` = '12327'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-14.139' WHERE (`spawn_id` = '18551'); 
        -- Battered Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18447'); 
        -- Battered Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18445'); 
        -- Water Barrel ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18305'); 
        -- Water Barrel ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18303'); 
        -- Water Barrel ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18302'); 
        -- Campfire ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18167'); 
        -- Thunder Bluff Forge XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1241.988', `spawn_positionY` = '95.77', `spawn_positionZ` = '130.43' WHERE (`spawn_id` = '18126'); 
        -- Bonfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '100.889' WHERE (`spawn_id` = '18116'); 
        -- Bonfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '100.889' WHERE (`spawn_id` = '18112'); 
        -- Solid Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '38.597' WHERE (`spawn_id` = '16648'); 
        -- Solid Chest Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.004' WHERE (`spawn_id` = '15672'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.867' WHERE (`spawn_id` = '18045'); 
        -- Iridescent Shards Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '153.348' WHERE (`spawn_id` = '16635'); 
        -- Rise of the Blood Elves Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '83.769' WHERE (`spawn_id` = '16609'); 
        -- Sargeras and the Betrayal Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '75.614' WHERE (`spawn_id` = '16608'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.566' WHERE (`spawn_id` = '18025'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18024'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18017'); 
        -- Mouthpiece Mount Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '179.327' WHERE (`spawn_id` = '18013'); 
        -- HornCover Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '161.313' WHERE (`spawn_id` = '17228'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6353.775', `spawn_positionY` = '-1884.256', `spawn_positionZ` = '-259.576' WHERE (`spawn_id` = '17593'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6317.152', `spawn_positionY` = '-1846.192', `spawn_positionZ` = '-257.155' WHERE (`spawn_id` = '17592'); 
        -- Solid Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3853.528', `spawn_positionY` = '-2540.012', `spawn_positionZ` = '42.331' WHERE (`spawn_id` = '15212'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.575' WHERE (`spawn_id` = '17484'); 
        -- Egg-O-Matic Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '8.828' WHERE (`spawn_id` = '17475'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17463'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17462'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17461'); 
        -- Stove Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '9.214' WHERE (`spawn_id` = '17445'); 
        -- Gahz'ridian Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '27.36' WHERE (`spawn_id` = '17409'); 
        -- Gahz'ridian Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '60.208' WHERE (`spawn_id` = '17406'); 
        -- Gahz'ridian Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '9.273' WHERE (`spawn_id` = '17395'); 
        -- Gahz'ridian Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.819' WHERE (`spawn_id` = '17386'); 
        -- Stove Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.167' WHERE (`spawn_id` = '17354'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.081' WHERE (`spawn_id` = '17351'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.455' WHERE (`spawn_id` = '17350'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.014' WHERE (`spawn_id` = '17349'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.324' WHERE (`spawn_id` = '17348'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.621' WHERE (`spawn_id` = '17347'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.468' WHERE (`spawn_id` = '17346'); 
        -- Stove Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.527' WHERE (`spawn_id` = '17345'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.762' WHERE (`spawn_id` = '17344'); 
        -- Chair Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.388' WHERE (`spawn_id` = '17343'); 
        -- Old Hatreds - The Colonization of Kalimdor Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.88' WHERE (`spawn_id` = '17342'); 
        -- Food Crate Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.224' WHERE (`spawn_id` = '15194'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3906.052', `spawn_positionY` = '-2520.028', `spawn_positionZ` = '45.379' WHERE (`spawn_id` = '15182'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '44.098' WHERE (`spawn_id` = '15182'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3870.382', `spawn_positionY` = '-2415.092', `spawn_positionZ` = '47.584' WHERE (`spawn_id` = '15181'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '47.402' WHERE (`spawn_id` = '15181'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3918.919', `spawn_positionY` = '-2441.717', `spawn_positionZ` = '41.335' WHERE (`spawn_id` = '15180'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.127' WHERE (`spawn_id` = '15180'); 
        -- Incendicite Mineral Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3871.993', `spawn_positionY` = '-2533.822', `spawn_positionZ` = '45.258' WHERE (`spawn_id` = '15179'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '43.881' WHERE (`spawn_id` = '15179'); 
        -- Doodad_GeneralMedChair03 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14174'); 
        -- Doodad_GeneralMedChair04 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14173'); 
        -- Doodad_GeneralMedChair02 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14172'); 
        -- Solid Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17329'); 
        -- Moon Well Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.062' WHERE (`spawn_id` = '17328'); 
        -- Captain's Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17327'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.514' WHERE (`spawn_id` = '17326'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.896' WHERE (`spawn_id` = '17324'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.441' WHERE (`spawn_id` = '17326'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.503' WHERE (`spawn_id` = '17325'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.51' WHERE (`spawn_id` = '17324'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.838' WHERE (`spawn_id` = '17323'); 
        -- Stolen Cargo Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.658' WHERE (`spawn_id` = '17322'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.002' WHERE (`spawn_id` = '17321'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.587' WHERE (`spawn_id` = '17320'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.541' WHERE (`spawn_id` = '17319'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.326' WHERE (`spawn_id` = '17318'); 
        -- Couch Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.507' WHERE (`spawn_id` = '17317'); 
        -- Book "Soothsaying for Dummies" Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.827' WHERE (`spawn_id` = '17316'); 
        -- Barrel of Melon Juice Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-10.782' WHERE (`spawn_id` = '14890'); 
        -- Wanted Poster Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '9.962' WHERE (`spawn_id` = '17282'); 
        -- Pew ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14047'); 
        -- Pew Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '52.643' WHERE (`spawn_id` = '14046'); 
        -- Pew ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14046'); 
        -- Pew ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14045'); 
        -- Pew ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14044'); 
        -- Pew ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14043'); 
        -- Pew ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14042'); 
        -- Gate ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14040'); 
        -- Door ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14039'); 
        -- Gate ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14038'); 
        -- Door ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14036'); 
        -- Door ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14035'); 
        -- Door ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14034'); 
        -- Door ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14033'); 
        -- Gate ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14032'); 
        -- Portcullis XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2757.28', `spawn_positionY` = '-5036.39', `spawn_positionZ` = '-1.69' WHERE (`spawn_id` = '7636'); 
        -- Portcullis Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.655' WHERE (`spawn_id` = '7635'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.142' WHERE (`spawn_id` = '7634'); 
        -- Doodad_PortcullisActive02 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14030'); 
        -- Doodad_PortcullisActive06 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14029'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '11.009' WHERE (`spawn_id` = '17243'); 
        -- Food Crate Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '7.236' WHERE (`spawn_id` = '14857'); 
        -- Food Crate Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-0.098' WHERE (`spawn_id` = '14853'); 
        -- Doodad_WroughtIronDoor01 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14014'); 
        -- Forge Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '10.936' WHERE (`spawn_id` = '17240'); 
        -- Doodad_PortcullisActive07 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14013'); 
        -- Doodad_WroughtIronDoor03 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14011'); 
        -- Uldum Pedestal Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '9.323' WHERE (`spawn_id` = '17230'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-3013.538', `spawn_positionY` = '-3293.8', `spawn_positionZ` = '65.469' WHERE (`spawn_id` = '14665'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.179' WHERE (`spawn_id` = '14665'); 
        -- Iron Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '49.327' WHERE (`spawn_id` = '14664'); 
        -- Silver Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2996.575', `spawn_positionY` = '-3302.436', `spawn_positionZ` = '65.892' WHERE (`spawn_id` = '14663'); 
        -- Solid Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2948.437', `spawn_positionY` = '-3202.636', `spawn_positionZ` = '59.875' WHERE (`spawn_id` = '14660'); 
        -- Doodad_WroughtIronDoor04 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14010'); 
        -- Doodad_PortcullisActive05 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14009'); 
        -- Doodad_WroughtIronDoor02 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14005'); 
        -- Bonfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13992'); 
        -- Bonfire ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13991'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13990'); 
        -- Campfire ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13989'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13988'); 
        -- Cauldron ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13987'); 
        -- Turn Back! ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13985'); 
        -- Bonfire ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13983'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13982'); 
        -- Cauldron ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13981'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10945.107', `spawn_positionY` = '-3546.316', `spawn_positionZ` = '30.528' WHERE (`spawn_id` = '16582'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10996.399', `spawn_positionY` = '-3539.051', `spawn_positionZ` = '30.997' WHERE (`spawn_id` = '32135'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10672.617', `spawn_positionY` = '-3564.864', `spawn_positionZ` = '50.989' WHERE (`spawn_id` = '42459'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '49.995' WHERE (`spawn_id` = '42459'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10652.375', `spawn_positionY` = '-3586.477', `spawn_positionZ` = '29.141' WHERE (`spawn_id` = '42458'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '27.309' WHERE (`spawn_id` = '42458'); 
        -- Beyond the Dark Portal ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42443'); 
        -- Burning Embers ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17209'); 
        -- Document Chest ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17199'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.709' WHERE (`spawn_id` = '7568'); 
        -- Brazier of Everfount ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '33417'); 
        -- The Dark Portal and the Fall of Stormwind ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42442'); 
        -- Aftermath of the Second War ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42441'); 
        -- House 2 ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3996095'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '6.775' WHERE (`spawn_id` = '7400'); 
        -- Signal Torch Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.213' WHERE (`spawn_id` = '6992'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10637.499', `spawn_positionY` = '-3546.715', `spawn_positionZ` = '32.412' WHERE (`spawn_id` = '42436'); 
        -- Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '31.394' WHERE (`spawn_id` = '42436'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-5036.521', `spawn_positionY` = '-2401.981', `spawn_positionZ` = '-55.601' WHERE (`spawn_id` = '17194'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10926.867', `spawn_positionY` = '-3526.492', `spawn_positionZ` = '47.292' WHERE (`spawn_id` = '40005'); 
        -- Shaman Shrine ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '33369'); 
        -- Solid Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-10860.763', `spawn_positionY` = '-3629.552', `spawn_positionZ` = '24.561' WHERE (`spawn_id` = '13978'); 
        -- The Kaldorei and the Well of Eternity Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '17.073' WHERE (`spawn_id` = '14566'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.949' WHERE (`spawn_id` = '15431'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.364' WHERE (`spawn_id` = '15433'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '42.721' WHERE (`spawn_id` = '15438'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.375' WHERE (`spawn_id` = '15439'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '31.316' WHERE (`spawn_id` = '15440'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '35.569' WHERE (`spawn_id` = '15442'); 
        -- Ooze Covered Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-328.398' WHERE (`spawn_id` = '15470'); 
        -- Ooze Covered Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-323.104' WHERE (`spawn_id` = '15472'); 
        -- Gorishi Hive Hatchery Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-329.91' WHERE (`spawn_id` = '50381'); 
        -- Incendia Agave Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-41.855' WHERE (`spawn_id` = '16757'); 
        -- Incendia Agave Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-52.562' WHERE (`spawn_id` = '16756'); 
        -- Incendia Agave Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-36.947' WHERE (`spawn_id` = '16755'); 
        -- Incendia Agave Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-52.341' WHERE (`spawn_id` = '16749'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.612' WHERE (`spawn_id` = '15866'); 
        -- Purple Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '115.526' WHERE (`spawn_id` = '15871'); 
        -- Purple Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '109.631' WHERE (`spawn_id` = '15880'); 
        -- Purple Lotus Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '154.385' WHERE (`spawn_id` = '15905'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '71.571' WHERE (`spawn_id` = '15950'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.133' WHERE (`spawn_id` = '15951'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.789' WHERE (`spawn_id` = '15963'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.439' WHERE (`spawn_id` = '15966'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '57.21' WHERE (`spawn_id` = '15967'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '78.472' WHERE (`spawn_id` = '15968'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.125' WHERE (`spawn_id` = '15971'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.122' WHERE (`spawn_id` = '15975'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.415' WHERE (`spawn_id` = '15980'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.338' WHERE (`spawn_id` = '15987'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.555' WHERE (`spawn_id` = '15990'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '59.306' WHERE (`spawn_id` = '15992'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '59.683' WHERE (`spawn_id` = '15994'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '72.59' WHERE (`spawn_id` = '16007'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '62.882' WHERE (`spawn_id` = '16019'); 
        -- Arthas' Tears Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '71.456' WHERE (`spawn_id` = '16022'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '60.102' WHERE (`spawn_id` = '16063'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '120.1' WHERE (`spawn_id` = '16087'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '120.834' WHERE (`spawn_id` = '16079'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-2.065' WHERE (`spawn_id` = '16098'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-1.145' WHERE (`spawn_id` = '16098'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '119.111' WHERE (`spawn_id` = '16109'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '117.854' WHERE (`spawn_id` = '16116'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '124.133' WHERE (`spawn_id` = '16121'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '122.78' WHERE (`spawn_id` = '16125'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '122.385' WHERE (`spawn_id` = '16144'); 
        -- Sungrass Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '71.551' WHERE (`spawn_id` = '16205'); 
        -- Ghost Mushroom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '153.402' WHERE (`spawn_id` = '16417'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '355.608', `spawn_positionY` = '-3752.967', `spawn_positionZ` = '135.822' WHERE (`spawn_id` = '16418'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '329.565', `spawn_positionY` = '-3821.0', `spawn_positionZ` = '142.901' WHERE (`spawn_id` = '16419'); 
        -- Ghost Mushroom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '126.081' WHERE (`spawn_id` = '16421'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '353.627', `spawn_positionY` = '-3779.0', `spawn_positionZ` = '148.453' WHERE (`spawn_id` = '16422'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '378.796', `spawn_positionY` = '-3797.707', `spawn_positionZ` = '154.722' WHERE (`spawn_id` = '16423'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '312.829', `spawn_positionY` = '-3810.0', `spawn_positionZ` = '137.854' WHERE (`spawn_id` = '16424'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '388.011', `spawn_positionY` = '-3733.0', `spawn_positionZ` = '126.703' WHERE (`spawn_id` = '16426'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '363.497', `spawn_positionY` = '-3722.528', `spawn_positionZ` = '123.33' WHERE (`spawn_id` = '16430'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '337.574', `spawn_positionY` = '-3889.219', `spawn_positionZ` = '119.72' WHERE (`spawn_id` = '16431'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '373.483', `spawn_positionY` = '-3757.0', `spawn_positionZ` = '148.096' WHERE (`spawn_id` = '16433'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '405.255', `spawn_positionY` = '-3744.617', `spawn_positionZ` = '116.589' WHERE (`spawn_id` = '16434'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '432.341', `spawn_positionY` = '-3800.962', `spawn_positionZ` = '114.644' WHERE (`spawn_id` = '16437'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '352.612', `spawn_positionY` = '-3820.737', `spawn_positionZ` = '104.034' WHERE (`spawn_id` = '16438'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '372.982', `spawn_positionY` = '-3784.0', `spawn_positionZ` = '154.539' WHERE (`spawn_id` = '16442'); 
        -- Ghost Mushroom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '121.689' WHERE (`spawn_id` = '16448'); 
        -- Gromsblood Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.918' WHERE (`spawn_id` = '16454'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '5.042' WHERE (`spawn_id` = '16541'); 
        -- Gromsblood Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '567.981' WHERE (`spawn_id` = '16543'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14344'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14345'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14343'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14342'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14341'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14340'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14339'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14338'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14337'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '16614'); 
        -- Stranglekelp ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15761'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '23.918' WHERE (`spawn_id` = '15753'); 
        --  Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '96.532' WHERE (`spawn_id` = '15725'); 
        --  Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '62.411' WHERE (`spawn_id` = '15723'); 
        -- The Punisher (DND) ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15705'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15702'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '94.305' WHERE (`spawn_id` = '15688'); 
        -- Grim Batol Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '19.059' WHERE (`spawn_id` = '13764'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15683'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '96.629' WHERE (`spawn_id` = '15676'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1975.0', `spawn_positionY` = '-3290.534', `spawn_positionZ` = '70.921' WHERE (`spawn_id` = '15675'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '69.406' WHERE (`spawn_id` = '15675'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-1348.71', `spawn_positionY` = '-2963.96', `spawn_positionZ` = '101.549' WHERE (`spawn_id` = '15496'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '100.936' WHERE (`spawn_id` = '15496'); 
        -- Copper Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-2041.03', `spawn_positionY` = '-3471.56', `spawn_positionZ` = '35.338' WHERE (`spawn_id` = '15495'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '34.748' WHERE (`spawn_id` = '15495'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '15150'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15145'); 
        -- Copper Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '60.775' WHERE (`spawn_id` = '15135'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15125'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15123'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15122'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15121'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15120'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15119'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13184'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13141'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13138'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13129'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13128'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13126'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13125'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13124'); 
        -- Campfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.994' WHERE (`spawn_id` = '14846'); 
        -- Anvil ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14774'); 
        --  ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14681'); 
        -- Cauldron ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14678'); 
        --  ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14677'); 
        --  ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14642'); 
        --  ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14639'); 
        --  ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14637'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14598'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14596'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14594'); 
        -- Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14542'); 
        -- Stove ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14519'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14197'); 
        -- Archimonde's Return and the Flight to Kalimdor Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.557' WHERE (`spawn_id` = '13594'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13592'); 
        -- Miblon's Door Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.847' WHERE (`spawn_id` = '17428'); 
        -- The New Horde Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '33.492' WHERE (`spawn_id` = '13538'); 
        -- Lethargy of the Orcs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '32.751' WHERE (`spawn_id` = '13535'); 
        -- Master Control Program Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.572' WHERE (`spawn_id` = '13531'); 
        -- Bonfire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '45.576' WHERE (`spawn_id` = '13526'); 
        -- War of the Three Hammers Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '108.909' WHERE (`spawn_id` = '13514'); 
        -- Fierce Blaze Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '93.956' WHERE (`spawn_id` = '13512'); 
        -- Barrel of Milk Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13510'); 
        -- Barrel of Milk Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.02' WHERE (`spawn_id` = '13501'); 
        -- Ironforge - the Awakening of the Dwarves Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '118.077' WHERE (`spawn_id` = '13496'); 
        -- Crude Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '98.811' WHERE (`spawn_id` = '13491'); 
        -- Burning Embers Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.411' WHERE (`spawn_id` = '13475'); 
        -- Crude Brazier Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '135.031' WHERE (`spawn_id` = '13474'); 
        -- Campfire ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13473'); 
        -- Crude Brazier XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-595.49', `spawn_positionY` = '-3170.718', `spawn_positionZ` = '92.897' WHERE (`spawn_id` = '13470'); 
        -- Campfire ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13469'); 
        -- Exile of the High Elves Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '24.83' WHERE (`spawn_id` = '13468'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13465'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13463'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13459'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13456'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13453'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13450'); 
        -- Food Crate XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '1247.18', `spawn_positionY` = '-3604.149', `spawn_positionZ` = '114.297' WHERE (`spawn_id` = '13448'); 
        -- Gallywix's Lockbox Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13434'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '27.43' WHERE (`spawn_id` = '13406'); 
        -- Stolen Silver ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13405'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '27.45' WHERE (`spawn_id` = '13399'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.696' WHERE (`spawn_id` = '13397'); 
        -- Bench Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.79' WHERE (`spawn_id` = '13394'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '36.683' WHERE (`spawn_id` = '13366'); 
        -- Forge Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.129' WHERE (`spawn_id` = '13360'); 
        -- Common Magebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.684' WHERE (`spawn_id` = '13358'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '13.37' WHERE (`spawn_id` = '13356'); 
        -- Nijel's Point Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '89.49' WHERE (`spawn_id` = '30226'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '13.679' WHERE (`spawn_id` = '13354'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13353'); 
        -- Anvil ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13352'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13351'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13350'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.129' WHERE (`spawn_id` = '13344'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.967' WHERE (`spawn_id` = '13343'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.368' WHERE (`spawn_id` = '13342'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '69.855' WHERE (`spawn_id` = '13341'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '49.643' WHERE (`spawn_id` = '13340'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '40.758' WHERE (`spawn_id` = '13337'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.134' WHERE (`spawn_id` = '13336'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '75.836' WHERE (`spawn_id` = '13335'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '57.878' WHERE (`spawn_id` = '13334'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '66.371' WHERE (`spawn_id` = '13333'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.526' WHERE (`spawn_id` = '13332'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.573' WHERE (`spawn_id` = '13331'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.012' WHERE (`spawn_id` = '13330'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '43.784' WHERE (`spawn_id` = '13329'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '22.152' WHERE (`spawn_id` = '13328'); 
        -- Burning Embers Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13326'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13325'); 
        -- Food Crate ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13319'); 
        -- Gallywix's Lockbox Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13316'); 
        -- Warm Fire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.836' WHERE (`spawn_id` = '13313'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13312'); 
        -- Warm Fire Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.683' WHERE (`spawn_id` = '13308'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13307'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13302'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.229' WHERE (`spawn_id` = '13301'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13299'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13294'); 
        -- The Jewel of the Southsea ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13293'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.129' WHERE (`spawn_id` = '13290'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '16.967' WHERE (`spawn_id` = '13277'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.368' WHERE (`spawn_id` = '13276'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '69.747' WHERE (`spawn_id` = '13275'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '49.643' WHERE (`spawn_id` = '13274'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '40.758' WHERE (`spawn_id` = '13273'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '21.134' WHERE (`spawn_id` = '13272'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '75.836' WHERE (`spawn_id` = '13271'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '57.878' WHERE (`spawn_id` = '13270'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '66.371' WHERE (`spawn_id` = '13269'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.526' WHERE (`spawn_id` = '13268'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.573' WHERE (`spawn_id` = '13267'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '51.011' WHERE (`spawn_id` = '13266'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '43.784' WHERE (`spawn_id` = '13265'); 
        -- Serpentbloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '22.152' WHERE (`spawn_id` = '13264'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13262'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13258'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13257'); 
        -- Kolkars' Booty ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13253'); 
        -- Laden Mushroom ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13198'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13183'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13172'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13169'); 
        -- Kolkar's Booty ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13162'); 
        -- Cannon ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13153'); 
        -- Cannon ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13149'); 
        -- Cannon ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13130'); 
        -- Battered Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6008.708', `spawn_positionY` = '-2972.425', `spawn_positionZ` = '402.824' WHERE (`spawn_id` = '13209'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13122'); 
        -- Tin Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6048.852', `spawn_positionY` = '-2798.129', `spawn_positionZ` = '392.479' WHERE (`spawn_id` = '12860'); 
        -- Tin Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '391.79' WHERE (`spawn_id` = '12860'); 
        -- Barrel of Milk XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-6024.201', `spawn_positionY` = '-2801.919', `spawn_positionZ` = '386.121' WHERE (`spawn_id` = '12801'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13123'); 
        -- Cannon ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13082'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13081'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13065'); 
        -- Kolkar's Booty Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '97.756' WHERE (`spawn_id` = '13061'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13039'); 
        -- Stonetalon Mountains Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '89.488' WHERE (`spawn_id` = '30232'); 
        -- Bonfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12961'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12945'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '12940'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.836' WHERE (`spawn_id` = '12939'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '91.683' WHERE (`spawn_id` = '12938'); 
        -- Campfire Damage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '92.411' WHERE (`spawn_id` = '12937'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12933'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12931'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12930'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12928'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12857'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12854'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12853'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12852'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12850'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12849'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12835'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12711'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12710'); 
        -- Ironzar's Imported Weaponry ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12708'); 
        -- Anvil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '14.297' WHERE (`spawn_id` = '12705'); 
        -- Jazzik's General Goods ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12704'); 
        -- Damaged Chest XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-4926.41', `spawn_positionY` = '-2345.391', `spawn_positionZ` = '-49.869' WHERE (`spawn_id` = '12699'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12691'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12669'); 
        -- Taillasher Eggs Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '3.932' WHERE (`spawn_id` = '12623'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13072'); 
        -- Rich Thorium Vein ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18384'); 
        -- Rich Thorium Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-223.106' WHERE (`spawn_id` = '18424'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13070'); 
        -- Gold Vein XYZ placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionX` = '-236.393', `spawn_positionY` = '-370.875', `spawn_positionZ` = '69.721' WHERE (`spawn_id` = '33196'); 
        -- Gold Vein Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '68.876' WHERE (`spawn_id` = '33196'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13069'); 
        -- Water Barrel Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '1.252' WHERE (`spawn_id` = '12498'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13025'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13023'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13021'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13020'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13018'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13013'); 
        -- Potbelly Stove ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13009'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13007'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13004'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13001'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13000'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12997');         -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12996'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12988'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12925'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12924'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12922'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12912'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12911'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12908'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12907'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12897'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12896'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12895'); 
        -- Gnomish Toolbox Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '-14.262' WHERE (`spawn_id` = '12422'); 
        -- Food Crate Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '26.854' WHERE (`spawn_id` = '12392');         -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12889'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12886'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12884'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12881'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12879'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12878'); 
        -- Golden Sansam Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.8' WHERE (`spawn_id` = '18972'); 
        -- Golden Sansam Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.886' WHERE (`spawn_id` = '19004'); 
        -- Golden Sansam Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '2.886' WHERE (`spawn_id` = '19004'); 
        -- Golden Sansam Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '117.873' WHERE (`spawn_id` = '19093'); 
        -- Golden Sansam Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '65.504' WHERE (`spawn_id` = '19173'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '118.658' WHERE (`spawn_id` = '19287'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '60.256' WHERE (`spawn_id` = '19311'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '64.248' WHERE (`spawn_id` = '19332'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.076' WHERE (`spawn_id` = '19333'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.923' WHERE (`spawn_id` = '19359'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '128.284' WHERE (`spawn_id` = '19363'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '128.454' WHERE (`spawn_id` = '19364'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '62.483' WHERE (`spawn_id` = '19489'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '60.426' WHERE (`spawn_id` = '19490'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.284' WHERE (`spawn_id` = '19560'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.801' WHERE (`spawn_id` = '19592'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '0.201' WHERE (`spawn_id` = '19608'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.781' WHERE (`spawn_id` = '19612'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.534' WHERE (`spawn_id` = '19632'); 
        -- Dreamfoil Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '4.085' WHERE (`spawn_id` = '19656'); 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '106.304' WHERE (`spawn_id` = '19713'); 
        -- Mountain Silversage Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '140.878' WHERE (`spawn_id` = '19736'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '80.112' WHERE (`spawn_id` = '19882'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '84.089' WHERE (`spawn_id` = '19883'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '82.082' WHERE (`spawn_id` = '19884'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '129.702' WHERE (`spawn_id` = '19893'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.77' WHERE (`spawn_id` = '19895'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '63.511' WHERE (`spawn_id` = '19911'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '81.348' WHERE (`spawn_id` = '19912'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '83.893' WHERE (`spawn_id` = '19913'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '62.793' WHERE (`spawn_id` = '19916'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '102.343' WHERE (`spawn_id` = '19920'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.37' WHERE (`spawn_id` = '19940'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '78.101' WHERE (`spawn_id` = '19942'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.924' WHERE (`spawn_id` = '19944'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '66.533' WHERE (`spawn_id` = '19975'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '102.31' WHERE (`spawn_id` = '19996'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '61.002' WHERE (`spawn_id` = '19999'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '60.707' WHERE (`spawn_id` = '20001'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '62.044' WHERE (`spawn_id` = '20002'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '137.031' WHERE (`spawn_id` = '20004'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '80.968' WHERE (`spawn_id` = '20028'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '129.097' WHERE (`spawn_id` = '20031'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '101.295' WHERE (`spawn_id` = '20035'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '126.042' WHERE (`spawn_id` = '20045'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '129.752' WHERE (`spawn_id` = '20062'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '136.219' WHERE (`spawn_id` = '20094'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '82.372' WHERE (`spawn_id` = '20108'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '135.51' WHERE (`spawn_id` = '20124'); 
        -- Plaguebloom Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '103.504' WHERE (`spawn_id` = '20133'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `alpha_world`.`spawns_gameobjects` SET `spawn_positionZ` = '120.328' WHERE (`spawn_id` = '34961'); 

        insert into applied_updates values ('190120221');
    end if;
end $
delimiter ;