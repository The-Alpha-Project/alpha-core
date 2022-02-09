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
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10874.13', `spawn_positionY` = '923.626', `spawn_positionZ` = '1317.481' WHERE (`spawn_id` = '49589');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10874.27', `spawn_positionY` = '917.391', `spawn_positionZ` = '1317.544' WHERE (`spawn_id` = '49590');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10881.17', `spawn_positionY` = '914.299', `spawn_positionZ` = '1317.358' WHERE (`spawn_id` = '49591');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10896.01', `spawn_positionY` = '920.324', `spawn_positionZ` = '1319.054' WHERE (`spawn_id` = '49593');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10900.56', `spawn_positionY` = '920.812', `spawn_positionZ` = '1319.237' WHERE (`spawn_id` = '49595');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '10903.92', `spawn_positionY` = '927.207', `spawn_positionZ` = '1319.866' WHERE (`spawn_id` = '49596');
	
        -- Fix Webwood Spiders wrong Z.
        UPDATE `spawns_creatures` SET `position_z` = '1334.94' WHERE (`spawn_id` = '47061');
        UPDATE `spawns_creatures` SET `position_z` = '1335.55' WHERE (`spawn_id` = '47249');
        UPDATE `spawns_creatures` SET `position_z` = '1335.60' WHERE (`spawn_id` = '47003');
        UPDATE `spawns_creatures` SET `position_x` = '10832.00', `position_y` = '921.21', `position_z` = '1337.127' WHERE (`spawn_id` = '47002');
        UPDATE `spawns_creatures` SET `position_z` = '1332.67' WHERE (`spawn_id` = '47017');
        UPDATE `spawns_creatures` SET `position_z` = '1326.44' WHERE (`spawn_id` = '47018');
        UPDATE `spawns_creatures` SET `position_z` = '1321.23' WHERE (`spawn_id` = '47023');
        UPDATE `spawns_creatures` SET `position_z` = '1319.51' WHERE (`spawn_id` = '47056');

        -- Small Thorium Vein ignored, out of reach.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '132');
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '53.964', `spawn_positionY` = '-4194.94', `spawn_positionZ` = '119.66' WHERE (`spawn_id` = '131');
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.767' WHERE (`spawn_id` = '136');
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.132' WHERE (`spawn_id` = '141');
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '480.185' WHERE (`spawn_id` = '144');
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.19' WHERE (`spawn_id` = '148');
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.39' WHERE (`spawn_id` = '152');
        -- Quilboar Watering Hole placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '99864'); 
        -- Alliance Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47590'); 
        -- Alliance Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47589'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.878' WHERE (`spawn_id` = '19'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.878' WHERE (`spawn_id` = '20'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '25.874' WHERE (`spawn_id` = '30737'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.126' WHERE (`spawn_id` = '30646'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '46'); 
        -- No object template, set ignored.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '52'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '423.01' WHERE (`spawn_id` = '58'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '423.01' WHERE (`spawn_id` = '59'); 
        -- Forge ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47586'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '22.465' WHERE (`spawn_id` = '30591'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '20.76' WHERE (`spawn_id` = '30589'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '93'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '155.184' WHERE (`spawn_id` = '30035'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.14' WHERE (`spawn_id` = '136'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.924' WHERE (`spawn_id` = '156'); 
        -- Small Thorium Vein ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '157'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-27.0' WHERE (`spawn_id` = '163'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '70.317' WHERE (`spawn_id` = '165'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '700.815' WHERE (`spawn_id` = '166'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '697.121' WHERE (`spawn_id` = '167'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.955' WHERE (`spawn_id` = '171'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '55.253' WHERE (`spawn_id` = '173'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '57.667' WHERE (`spawn_id` = '174'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '240.779' WHERE (`spawn_id` = '175'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '693.624' WHERE (`spawn_id` = '185'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '594.675' WHERE (`spawn_id` = '191'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '153.33' WHERE (`spawn_id` = '194'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.598' WHERE (`spawn_id` = '195'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '110.99' WHERE (`spawn_id` = '201'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '7.772' WHERE (`spawn_id` = '204'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-215.479' WHERE (`spawn_id` = '209'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '934.929' WHERE (`spawn_id` = '210'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.213' WHERE (`spawn_id` = '214'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '692.923' WHERE (`spawn_id` = '220'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '9.668' WHERE (`spawn_id` = '221'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.86' WHERE (`spawn_id` = '222'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '66.006' WHERE (`spawn_id` = '226'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '74.424' WHERE (`spawn_id` = '227'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '461.16' WHERE (`spawn_id` = '228'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.558' WHERE (`spawn_id` = '230'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '161.934' WHERE (`spawn_id` = '233'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '906.364' WHERE (`spawn_id` = '238'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '940.785' WHERE (`spawn_id` = '239'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '882.397' WHERE (`spawn_id` = '246'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '424.27' WHERE (`spawn_id` = '251'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.77' WHERE (`spawn_id` = '254'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '70.562' WHERE (`spawn_id` = '255'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.585' WHERE (`spawn_id` = '257'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '242.406' WHERE (`spawn_id` = '258'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '67.875' WHERE (`spawn_id` = '260'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '336.134' WHERE (`spawn_id` = '263'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.657' WHERE (`spawn_id` = '266'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '604.286' WHERE (`spawn_id` = '269'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.938' WHERE (`spawn_id` = '273'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '565.656' WHERE (`spawn_id` = '278'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6354.948', `spawn_positionY` = '-1878.964', `spawn_positionZ` = '-196.699' WHERE (`spawn_id` = '280'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-258.303' WHERE (`spawn_id` = '282'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '944.186' WHERE (`spawn_id` = '287'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.265' WHERE (`spawn_id` = '288'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '6417.55', `spawn_positionY` = '-4285.0', `spawn_positionZ` = '627.528' WHERE (`spawn_id` = '292'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '6417.55', `spawn_positionY` = '-4285.0', `spawn_positionZ` = '699.082' WHERE (`spawn_id` = '292'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '5765.252', `spawn_positionY` = '-4931.604', `spawn_positionZ` = '762.81' WHERE (`spawn_id` = '293'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-31.202' WHERE (`spawn_id` = '294'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '66.178' WHERE (`spawn_id` = '295'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '85.641' WHERE (`spawn_id` = '298'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-257.122' WHERE (`spawn_id` = '299'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '28.691' WHERE (`spawn_id` = '302'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '67.088' WHERE (`spawn_id` = '307'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '19.638' WHERE (`spawn_id` = '310'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.455' WHERE (`spawn_id` = '312'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '454.778' WHERE (`spawn_id` = '314'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-260.0' WHERE (`spawn_id` = '315'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-7212.61', `spawn_positionY` = '-2299.323', `spawn_positionZ` = '-253.81' WHERE (`spawn_id` = '317'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '75.38' WHERE (`spawn_id` = '328'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.836' WHERE (`spawn_id` = '335'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-264.636' WHERE (`spawn_id` = '338'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-7976.028', `spawn_positionY` = '-2348.022', `spawn_positionZ` = '-24.016' WHERE (`spawn_id` = '339'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '911.426' WHERE (`spawn_id` = '340'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.373' WHERE (`spawn_id` = '343'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10604.152', `spawn_positionY` = '-3387.443', `spawn_positionZ` = '39.09' WHERE (`spawn_id` = '344'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '941.338' WHERE (`spawn_id` = '348'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-243.0' WHERE (`spawn_id` = '353'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '792.443' WHERE (`spawn_id` = '358'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '144.124' WHERE (`spawn_id` = '361'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-244.884' WHERE (`spawn_id` = '367'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '71.464' WHERE (`spawn_id` = '368'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-269.5' WHERE (`spawn_id` = '374'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-205.952' WHERE (`spawn_id` = '377'); 
        -- Small Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '789.403' WHERE (`spawn_id` = '384'); 
        -- Solid Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '52.58' WHERE (`spawn_id` = '30018'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.676' WHERE (`spawn_id` = '47584'); 
        -- Greatwood Vale Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '311.76' WHERE (`spawn_id` = '47583'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.676' WHERE (`spawn_id` = '47582'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.369' WHERE (`spawn_id` = '29993'); 
        -- Campfire XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '817.833', `spawn_positionY` = '945.833', `spawn_positionZ` = '94.343' WHERE (`spawn_id` = '47580'); 
        -- TEMP Shadra'Alor Altar Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '87.223' WHERE (`spawn_id` = '99875'); 
        -- Musty Tome Trap Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '71.66' WHERE (`spawn_id` = '12342'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.887' WHERE (`spawn_id` = '512'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.888' WHERE (`spawn_id` = '513'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.887' WHERE (`spawn_id` = '516'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.575' WHERE (`spawn_id` = '522'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '528.499' WHERE (`spawn_id` = '524'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '520.165' WHERE (`spawn_id` = '526'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.887' WHERE (`spawn_id` = '544'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '590'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '592'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.876' WHERE (`spawn_id` = '596'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '519.876' WHERE (`spawn_id` = '601'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '603'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '610'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '611'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '523.496' WHERE (`spawn_id` = '612'); 
        -- Dwarven Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '525.949' WHERE (`spawn_id` = '613'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '525.949' WHERE (`spawn_id` = '617'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-5.602' WHERE (`spawn_id` = '631'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '28.038' WHERE (`spawn_id` = '687'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '30.138' WHERE (`spawn_id` = '764'); 
        -- Barrel of Milk Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.852' WHERE (`spawn_id` = '47558'); 
        -- Dwarven High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '780'); 
        -- Barrel of Milk Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.873' WHERE (`spawn_id` = '47557'); 
        -- Barrel of Milk ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '47552'); 
        -- Dwarven High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '804'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.714' WHERE (`spawn_id` = '955'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-3.627' WHERE (`spawn_id` = '974'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.649' WHERE (`spawn_id` = '1004'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '495.26' WHERE (`spawn_id` = '1009'); 
        -- Silverleaf Bush XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1173.445', `spawn_positionY` = '-3001.554', `spawn_positionZ` = '99.832' WHERE (`spawn_id` = '1078'); 
        -- Silverleaf Bush Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.03' WHERE (`spawn_id` = '1146'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '407.117' WHERE (`spawn_id` = '1173'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '407.117' WHERE (`spawn_id` = '1174'); 
        -- Silverleaf Bush XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5935.646', `spawn_positionY` = '-2903.753', `spawn_positionZ` = '369.238' WHERE (`spawn_id` = '1183'); 
        -- Burning Embers Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '7.126' WHERE (`spawn_id` = '47504'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-2.65' WHERE (`spawn_id` = '1392'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-21.168' WHERE (`spawn_id` = '1399'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '47458'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.838' WHERE (`spawn_id` = '1475'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.913' WHERE (`spawn_id` = '1490'); 
        -- Greatwood Vale Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.42' WHERE (`spawn_id` = '47451'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '96.275' WHERE (`spawn_id` = '1513'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-17.469' WHERE (`spawn_id` = '1557'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.99' WHERE (`spawn_id` = '1608'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.13' WHERE (`spawn_id` = '1609'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.349' WHERE (`spawn_id` = '1676'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '31.074' WHERE (`spawn_id` = '1690'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '114.355' WHERE (`spawn_id` = '47317'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '145.642' WHERE (`spawn_id` = '47317'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '37.011' WHERE (`spawn_id` = '1698'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '47193'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.858' WHERE (`spawn_id` = '47192'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.089' WHERE (`spawn_id` = '1786'); 
        -- Snakeroot XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '3.716', `spawn_positionY` = '-1831.217', `spawn_positionZ` = '96.578' WHERE (`spawn_id` = '1813'); 
        -- Snakeroot XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '380.849', `spawn_positionY` = '1152.36', `spawn_positionZ` = '89.758' WHERE (`spawn_id` = '1840'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.38' WHERE (`spawn_id` = '1901'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.503' WHERE (`spawn_id` = '1925'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '30.935' WHERE (`spawn_id` = '1937'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.03' WHERE (`spawn_id` = '1955'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '23.483' WHERE (`spawn_id` = '2003'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '20.166' WHERE (`spawn_id` = '2004'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.283' WHERE (`spawn_id` = '2005'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '24.98' WHERE (`spawn_id` = '2009'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '22.561' WHERE (`spawn_id` = '2028'); 
        -- Snakeroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.658' WHERE (`spawn_id` = '2042'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.603' WHERE (`spawn_id` = '2088'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.902' WHERE (`spawn_id` = '2096'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.784' WHERE (`spawn_id` = '2098'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.925' WHERE (`spawn_id` = '2108'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.701' WHERE (`spawn_id` = '2158'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '95.836' WHERE (`spawn_id` = '2160'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '107.194' WHERE (`spawn_id` = '2166'); 
        -- Common Magebloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '642.629', `spawn_positionY` = '-1575.349', `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '2179'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.064' WHERE (`spawn_id` = '2191'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.355' WHERE (`spawn_id` = '2192'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.876' WHERE (`spawn_id` = '2193'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.712' WHERE (`spawn_id` = '2213'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '81.35' WHERE (`spawn_id` = '2222'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '82.583' WHERE (`spawn_id` = '2229'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '28.848' WHERE (`spawn_id` = '2233'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '327.869' WHERE (`spawn_id` = '2237'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.457' WHERE (`spawn_id` = '2240'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.891' WHERE (`spawn_id` = '2244'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.433' WHERE (`spawn_id` = '2253'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '30.168' WHERE (`spawn_id` = '2283'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.759' WHERE (`spawn_id` = '2285'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '19.253' WHERE (`spawn_id` = '2295'); 
        -- Common Magebloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '561.842', `spawn_positionY` = '-3738.942', `spawn_positionZ` = '17.718' WHERE (`spawn_id` = '2311'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '19.601' WHERE (`spawn_id` = '2327'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '23.601' WHERE (`spawn_id` = '2333'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '44657'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.76' WHERE (`spawn_id` = '2339'); 
        -- Common Magebloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1028.345', `spawn_positionY` = '-1991.585', `spawn_positionZ` = '79.704' WHERE (`spawn_id` = '2341'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '13.253' WHERE (`spawn_id` = '2346'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '87.728' WHERE (`spawn_id` = '2347'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.406' WHERE (`spawn_id` = '2348'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '90.639' WHERE (`spawn_id` = '2350'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.651' WHERE (`spawn_id` = '2377'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.153' WHERE (`spawn_id` = '2397'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.761' WHERE (`spawn_id` = '2398'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.971' WHERE (`spawn_id` = '2401'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '29.151' WHERE (`spawn_id` = '2403'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.875' WHERE (`spawn_id` = '2406'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '32.255' WHERE (`spawn_id` = '2407'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.887' WHERE (`spawn_id` = '2423'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.861' WHERE (`spawn_id` = '44655'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '74.319' WHERE (`spawn_id` = '2474'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.991' WHERE (`spawn_id` = '2481'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '175.121' WHERE (`spawn_id` = '44654'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '44653'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '59.329' WHERE (`spawn_id` = '2501'); 
        -- Deepmoss Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.876' WHERE (`spawn_id` = '44652'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.71' WHERE (`spawn_id` = '2515'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '2537'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '58.858' WHERE (`spawn_id` = '2561'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.231' WHERE (`spawn_id` = '2577'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '130.707' WHERE (`spawn_id` = '2579'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '102.218' WHERE (`spawn_id` = '2592'); 
        -- Thornroot XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10371.842', `spawn_positionY` = '-1318.831', `spawn_positionZ` = '52.909' WHERE (`spawn_id` = '2608'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '101.945' WHERE (`spawn_id` = '2612'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '150.395' WHERE (`spawn_id` = '2614'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-10.439' WHERE (`spawn_id` = '2619'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.352' WHERE (`spawn_id` = '2625'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '102.397' WHERE (`spawn_id` = '2628'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '32.502' WHERE (`spawn_id` = '2661'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '31.331' WHERE (`spawn_id` = '2671'); 
        -- Thornroot XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '650.887', `spawn_positionY` = '1382.366', `spawn_positionZ` = '82.77' WHERE (`spawn_id` = '2687'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '44.492' WHERE (`spawn_id` = '2690'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '31.089' WHERE (`spawn_id` = '2706'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.293' WHERE (`spawn_id` = '2710'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.749' WHERE (`spawn_id` = '2717'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.131' WHERE (`spawn_id` = '2725'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '129.152' WHERE (`spawn_id` = '2731'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.43' WHERE (`spawn_id` = '2732'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.477' WHERE (`spawn_id` = '2740'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '32.451' WHERE (`spawn_id` = '2806'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '98.731' WHERE (`spawn_id` = '2822'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '88.464' WHERE (`spawn_id` = '2835'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '101.467' WHERE (`spawn_id` = '2868'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '55.729' WHERE (`spawn_id` = '2869'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.827' WHERE (`spawn_id` = '2899'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '49.912' WHERE (`spawn_id` = '2900'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '2931'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '2932'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '86.101' WHERE (`spawn_id` = '3042'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '123.902' WHERE (`spawn_id` = '3078'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '46.646' WHERE (`spawn_id` = '3109'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '107.369' WHERE (`spawn_id` = '3118'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.168' WHERE (`spawn_id` = '3133'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.716' WHERE (`spawn_id` = '3138'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.39' WHERE (`spawn_id` = '3159'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.212' WHERE (`spawn_id` = '3205'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.15' WHERE (`spawn_id` = '3207'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3221'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '20.52' WHERE (`spawn_id` = '3260'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.36' WHERE (`spawn_id` = '3262'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.686' WHERE (`spawn_id` = '3289'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '57.602' WHERE (`spawn_id` = '3329'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '117.274' WHERE (`spawn_id` = '3364'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '252.407' WHERE (`spawn_id` = '3394'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.889' WHERE (`spawn_id` = '3395'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.847' WHERE (`spawn_id` = '3401'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.583' WHERE (`spawn_id` = '3469'); 
        -- Bruiseweed XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2041.671', `spawn_positionY` = '-3208.335', `spawn_positionZ` = '101.091' WHERE (`spawn_id` = '3478'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.175' WHERE (`spawn_id` = '3515'); 
        -- Bruiseweed XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2587.874', `spawn_positionY` = '-2382.282', `spawn_positionZ` = '79.878' WHERE (`spawn_id` = '3531'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.03' WHERE (`spawn_id` = '3538'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-55.438' WHERE (`spawn_id` = '3587'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '17.642' WHERE (`spawn_id` = '3597'); 
		-- Ruins of Stardust Fountain Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '97.061' WHERE (`spawn_id` = '99862'); 
        -- Atal'ai Artifact XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10525.458', `spawn_positionY` = '-3870.514', `spawn_positionZ` = '-17.858' WHERE (`spawn_id` = '30744'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '113.891' WHERE (`spawn_id` = '3665'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.934' WHERE (`spawn_id` = '3692'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.548' WHERE (`spawn_id` = '3732'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '17.187' WHERE (`spawn_id` = '3739'); 
        -- Bruiseweed ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3741'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-37.248' WHERE (`spawn_id` = '3787'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '23.175' WHERE (`spawn_id` = '3793'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.898' WHERE (`spawn_id` = '3854'); 
        -- Wild Steelbloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4286.811', `spawn_positionY` = '-2070.202', `spawn_positionZ` = '88.609' WHERE (`spawn_id` = '3923'); 
        -- Wild Steelbloom ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3968'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '98.374' WHERE (`spawn_id` = '3969'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '255.354' WHERE (`spawn_id` = '4005'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '18.871' WHERE (`spawn_id` = '4024'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '253.799' WHERE (`spawn_id` = '4025'); 
        -- Wild Steelbloom ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4045'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-20.385' WHERE (`spawn_id` = '4050'); 
        -- Wild Steelbloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3600.042', `spawn_positionY` = '-1762.24', `spawn_positionZ` = '139.489' WHERE (`spawn_id` = '4065'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '72.52' WHERE (`spawn_id` = '4090'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.071' WHERE (`spawn_id` = '4095'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '253.317' WHERE (`spawn_id` = '4216'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '95.741' WHERE (`spawn_id` = '4267'); 
        -- Wild Steelbloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2639.203', `spawn_positionY` = '-2318.273', `spawn_positionZ` = '91.608' WHERE (`spawn_id` = '4268'); 
        -- Crownroyal Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '56.356' WHERE (`spawn_id` = '4294'); 
        -- Crownroyal Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.98' WHERE (`spawn_id` = '4311'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.389' WHERE (`spawn_id` = '28518'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.116' WHERE (`spawn_id` = '18909'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.625' WHERE (`spawn_id` = '18890'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.81' WHERE (`spawn_id` = '18889'); 
        -- Thornroot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.744' WHERE (`spawn_id` = '44642'); 
        -- Burning Embers Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '40718'); 
        -- Warm Fire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '40716'); 
        -- Warm Fire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '40715'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '86.9' WHERE (`spawn_id` = '40714'); 
        -- Bruiseweed Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '117.836' WHERE (`spawn_id` = '29658'); 
        -- Alliance Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.586' WHERE (`spawn_id` = '29650'); 
        -- DANGER! Do Not Open! Move Along! Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.99' WHERE (`spawn_id` = '29645'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '32.669' WHERE (`spawn_id` = '4652'); 
        -- Ironforge Main Gate ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4691'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '4699'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '20.049' WHERE (`spawn_id` = '4711'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-55.161' WHERE (`spawn_id` = '4728'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.822' WHERE (`spawn_id` = '18888'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-46.288' WHERE (`spawn_id` = '4762'); 
        -- Black Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.845' WHERE (`spawn_id` = '3998089'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '186.07' WHERE (`spawn_id` = '4766'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-22.613' WHERE (`spawn_id` = '4768'); 
        -- Black Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.604' WHERE (`spawn_id` = '3998088'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '29.679' WHERE (`spawn_id` = '4799'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '249.881' WHERE (`spawn_id` = '4802'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.163' WHERE (`spawn_id` = '4807'); 
        -- Black Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.561' WHERE (`spawn_id` = '3998085'); 
        -- Black Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '7.22' WHERE (`spawn_id` = '3998084'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.841' WHERE (`spawn_id` = '4824'); 
        -- Black Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.976' WHERE (`spawn_id` = '3998081'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '106.417' WHERE (`spawn_id` = '4898'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.014' WHERE (`spawn_id` = '4901'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '52.078' WHERE (`spawn_id` = '4936'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '4302.084', `spawn_positionY` = '943.749', `spawn_positionZ` = '52.078' WHERE (`spawn_id` = '4936'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '46.039' WHERE (`spawn_id` = '5031'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-13.056' WHERE (`spawn_id` = '5061'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '6805.169', `spawn_positionY` = '-679.499', `spawn_positionZ` = '97.658' WHERE (`spawn_id` = '5066'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '20.473' WHERE (`spawn_id` = '5361'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.049' WHERE (`spawn_id` = '5377'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.399' WHERE (`spawn_id` = '5421'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.118' WHERE (`spawn_id` = '5452'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '106.626' WHERE (`spawn_id` = '5464'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '45.543', `spawn_positionY` = '-1725.294', `spawn_positionZ` = '106.626' WHERE (`spawn_id` = '5464'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8918.297', `spawn_positionY` = '-1945.519', `spawn_positionZ` = '134.216' WHERE (`spawn_id` = '5511'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-809.262', `spawn_positionY` = '133.229', `spawn_positionZ` = '18.607' WHERE (`spawn_id` = '5514'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.683' WHERE (`spawn_id` = '18887'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.703' WHERE (`spawn_id` = '5559'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.018' WHERE (`spawn_id` = '5561'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '46.986' WHERE (`spawn_id` = '5633'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8933.606', `spawn_positionY` = '-1977.563', `spawn_positionZ` = '133.189' WHERE (`spawn_id` = '5675'); 
        -- Silver Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '164.403' WHERE (`spawn_id` = '5725'); 
        -- Silver Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '158.827' WHERE (`spawn_id` = '5728'); 
        -- Silver Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '18.83' WHERE (`spawn_id` = '5762'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.865' WHERE (`spawn_id` = '5770'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.513' WHERE (`spawn_id` = '5773'); 
        -- Gold Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1240.966', `spawn_positionY` = '-1257.593', `spawn_positionZ` = '43.924' WHERE (`spawn_id` = '5783'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '5785'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '140.666' WHERE (`spawn_id` = '5801'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '46.276' WHERE (`spawn_id` = '5819'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.676' WHERE (`spawn_id` = '5839'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '73.703' WHERE (`spawn_id` = '5859'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '50.96' WHERE (`spawn_id` = '5861'); 
        -- Gold Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1241.67', `spawn_positionY` = '-1272.324', `spawn_positionZ` = '43.074' WHERE (`spawn_id` = '5863'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.716' WHERE (`spawn_id` = '5914'); 
        -- Gold Vein ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '5959'); 
        -- Gold Vein ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '5960'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '5983'); 
        -- Gold Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10969.125', `spawn_positionY` = '-3695.028', `spawn_positionZ` = '17.251' WHERE (`spawn_id` = '5995'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '70.886' WHERE (`spawn_id` = '6000'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.834' WHERE (`spawn_id` = '6002'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '138.23' WHERE (`spawn_id` = '6019'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '116.027' WHERE (`spawn_id` = '6061'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '367.703' WHERE (`spawn_id` = '6076'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '25.39' WHERE (`spawn_id` = '6107'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '90.278' WHERE (`spawn_id` = '6127'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '12.037' WHERE (`spawn_id` = '6128'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '12.387' WHERE (`spawn_id` = '6147'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-42.434' WHERE (`spawn_id` = '6155'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-48.643' WHERE (`spawn_id` = '6157'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '58.518' WHERE (`spawn_id` = '6197'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5121.117', `spawn_positionY` = '1795.439', `spawn_positionZ` = '50.692' WHERE (`spawn_id` = '6199'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1452.101', `spawn_positionY` = '2943.731', `spawn_positionZ` = '136.712' WHERE (`spawn_id` = '6210'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '144.217' WHERE (`spawn_id` = '6220'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '6229'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '131.359' WHERE (`spawn_id` = '6241'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '113.478' WHERE (`spawn_id` = '6242'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '176.463' WHERE (`spawn_id` = '6249'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '6250'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.387' WHERE (`spawn_id` = '6252'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.092' WHERE (`spawn_id` = '6288'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '79.7' WHERE (`spawn_id` = '6298'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '68.58' WHERE (`spawn_id` = '6304'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-58.749' WHERE (`spawn_id` = '6322'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '178.669' WHERE (`spawn_id` = '6349'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '101.954' WHERE (`spawn_id` = '6366'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '90.481' WHERE (`spawn_id` = '6372'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '87.957' WHERE (`spawn_id` = '6373'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4992.803', `spawn_positionY` = '-2291.727', `spawn_positionZ` = '-61.709' WHERE (`spawn_id` = '6378'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-814.5', `spawn_positionY` = '-3883.0', `spawn_positionZ` = '180.319' WHERE (`spawn_id` = '6414'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6643.518', `spawn_positionY` = '-3714.351', `spawn_positionZ` = '278.994' WHERE (`spawn_id` = '6449'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '40.434' WHERE (`spawn_id` = '14954'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '24.255' WHERE (`spawn_id` = '6485'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10954.143', `spawn_positionY` = '-3706.594', `spawn_positionZ` = '18.849' WHERE (`spawn_id` = '6492'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5099.394', `spawn_positionY` = '1781.258', `spawn_positionZ` = '51.33' WHERE (`spawn_id` = '6495'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '40.564' WHERE (`spawn_id` = '14953'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6467.737', `spawn_positionY` = '-2480.182', `spawn_positionZ` = '326.823' WHERE (`spawn_id` = '6503'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '40.467' WHERE (`spawn_id` = '14952'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-13134.521', `spawn_positionY` = '-481.502', `spawn_positionZ` = '4.085' WHERE (`spawn_id` = '6521'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '40.3' WHERE (`spawn_id` = '14951'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.921' WHERE (`spawn_id` = '14950'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '90.485' WHERE (`spawn_id` = '6551'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-7310.229', `spawn_positionY` = '-1956.119', `spawn_positionZ` = '308.881' WHERE (`spawn_id` = '6556'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.005' WHERE (`spawn_id` = '14949'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.002' WHERE (`spawn_id` = '14948'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4982.301', `spawn_positionY` = '-2316.412', `spawn_positionZ` = '-56.926' WHERE (`spawn_id` = '6560'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5016.368', `spawn_positionY` = '1794.606', `spawn_positionZ` = '65.902' WHERE (`spawn_id` = '6577'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.329' WHERE (`spawn_id` = '6587'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5046.849', `spawn_positionY` = '1792.557', `spawn_positionZ` = '57.756' WHERE (`spawn_id` = '6588'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.695' WHERE (`spawn_id` = '6592'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.181' WHERE (`spawn_id` = '14947'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.168' WHERE (`spawn_id` = '14946'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-884.0', `spawn_positionY` = '-3912.0', `spawn_positionZ` = '147.56' WHERE (`spawn_id` = '6614'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.677' WHERE (`spawn_id` = '6624'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4944.349', `spawn_positionY` = '-2341.905', `spawn_positionZ` = '-57.6' WHERE (`spawn_id` = '6625'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2975.015', `spawn_positionY` = '-3154.677', `spawn_positionZ` = '52.554' WHERE (`spawn_id` = '6639'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.414' WHERE (`spawn_id` = '6645'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2024.515', `spawn_positionY` = '-3336.165', `spawn_positionZ` = '49.725' WHERE (`spawn_id` = '6651'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '86.288' WHERE (`spawn_id` = '6661'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '90.169' WHERE (`spawn_id` = '6668'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-58.75' WHERE (`spawn_id` = '6676'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.112' WHERE (`spawn_id` = '6678'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.206' WHERE (`spawn_id` = '6704'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4937.387', `spawn_positionY` = '-2349.707', `spawn_positionZ` = '-48.827' WHERE (`spawn_id` = '6718'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2038.625', `spawn_positionY` = '-3371.98', `spawn_positionZ` = '46.037' WHERE (`spawn_id` = '6729'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.511' WHERE (`spawn_id` = '6737'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '29.002' WHERE (`spawn_id` = '6740'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '146.556' WHERE (`spawn_id` = '6744'); 
        -- TEMP Nearby Tubers Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '82.474' WHERE (`spawn_id` = '99868'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-7829.0', `spawn_positionY` = '-5004.78', `spawn_positionZ` = '23.592' WHERE (`spawn_id` = '6751'); 
        -- Open To Pass Your Rite. Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '183.149' WHERE (`spawn_id` = '29644'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.493' WHERE (`spawn_id` = '34172'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.676' WHERE (`spawn_id` = '34164'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '34163'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '34162'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.319' WHERE (`spawn_id` = '34161'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.019' WHERE (`spawn_id` = '34150'); 
        -- Atal'ai Artifact Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-75.333' WHERE (`spawn_id` = '30559'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '34077'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '33911'); 
        -- Dwarven Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6836'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6839'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-811.035', `spawn_positionY` = '155.677', `spawn_positionZ` = '2.727' WHERE (`spawn_id` = '21273'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.457' WHERE (`spawn_id` = '33555'); 
        -- Dwarven Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6872'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '6874'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '9.839' WHERE (`spawn_id` = '35551'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-814.012', `spawn_positionY` = '164.024', `spawn_positionZ` = '0.648' WHERE (`spawn_id` = '21259'); 
        -- Tammra Gaea Sapling Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.677' WHERE (`spawn_id` = '33531'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-28.823' WHERE (`spawn_id` = '21249'); 
        -- Atal'ai Artifact Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.693' WHERE (`spawn_id` = '30383'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.457' WHERE (`spawn_id` = '32863'); 
        -- Atal'ai Artifact Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-25.613' WHERE (`spawn_id` = '30378'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '32669'); 
        -- Anvil ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '32667'); 
        -- Meat Smoker ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '32659'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '47.605' WHERE (`spawn_id` = '14930'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '186.07' WHERE (`spawn_id` = '32654'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2351.913', `spawn_positionY` = '2413.787', `spawn_positionZ` = '61.14' WHERE (`spawn_id` = '32647'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2347.225', `spawn_positionY` = '2413.241', `spawn_positionZ` = '62.401' WHERE (`spawn_id` = '32647'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2399.662', `spawn_positionY` = '2420.426', `spawn_positionZ` = '58.416' WHERE (`spawn_id` = '32604'); 
        -- Alliance Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '54.189' WHERE (`spawn_id` = '20885'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '119.487' WHERE (`spawn_id` = '7070'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.102' WHERE (`spawn_id` = '7141'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '79.674' WHERE (`spawn_id` = '7146'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2067.0', `spawn_positionY` = '-3350.525', `spawn_positionZ` = '40.86' WHERE (`spawn_id` = '7177'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '7.082' WHERE (`spawn_id` = '7199'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '90.748' WHERE (`spawn_id` = '7302'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '115.395' WHERE (`spawn_id` = '7315'); 
        -- Liferoot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '13.363' WHERE (`spawn_id` = '7335'); 
        -- Liferoot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '124.15' WHERE (`spawn_id` = '7538'); 
        -- Liferoot Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.062' WHERE (`spawn_id` = '7545'); 
        -- Fadeleaf Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '121.3' WHERE (`spawn_id` = '7577'); 
        -- Fadeleaf Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '117.919' WHERE (`spawn_id` = '7579'); 
        -- Fadeleaf Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '118.866' WHERE (`spawn_id` = '7660'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.715' WHERE (`spawn_id` = '14613'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.405' WHERE (`spawn_id` = '14604'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.006' WHERE (`spawn_id` = '13672'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.853' WHERE (`spawn_id` = '13671'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.834' WHERE (`spawn_id` = '13670'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '12.188' WHERE (`spawn_id` = '13669'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.248' WHERE (`spawn_id` = '13657'); 
        -- Egg of Onyxia Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.207' WHERE (`spawn_id` = '13656'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '120.349' WHERE (`spawn_id` = '7935'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '15.518' WHERE (`spawn_id` = '7963'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.441' WHERE (`spawn_id` = '7966'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.142' WHERE (`spawn_id` = '8047'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '122.04' WHERE (`spawn_id` = '8119'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.448' WHERE (`spawn_id` = '8163'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.824' WHERE (`spawn_id` = '8224'); 
        -- Stranglekelp ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8234'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.635' WHERE (`spawn_id` = '8235'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.678' WHERE (`spawn_id` = '8237'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.618' WHERE (`spawn_id` = '8238'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.333' WHERE (`spawn_id` = '8243'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.599' WHERE (`spawn_id` = '8248'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.302' WHERE (`spawn_id` = '8250'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.56' WHERE (`spawn_id` = '8259'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.528' WHERE (`spawn_id` = '8261'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.147' WHERE (`spawn_id` = '8262'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.808' WHERE (`spawn_id` = '8263'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.844' WHERE (`spawn_id` = '8264'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.659' WHERE (`spawn_id` = '8266'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.637' WHERE (`spawn_id` = '8267'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.459' WHERE (`spawn_id` = '8268'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-3.279' WHERE (`spawn_id` = '8272'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.555' WHERE (`spawn_id` = '8298'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.091' WHERE (`spawn_id` = '8299'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.231' WHERE (`spawn_id` = '8304'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.386' WHERE (`spawn_id` = '8308'); 
        -- Stranglekelp ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8311'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.147' WHERE (`spawn_id` = '8316'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.556' WHERE (`spawn_id` = '8318'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.972' WHERE (`spawn_id` = '8319'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.729' WHERE (`spawn_id` = '8330'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.64' WHERE (`spawn_id` = '8331'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.574' WHERE (`spawn_id` = '8337'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-2.104' WHERE (`spawn_id` = '8339'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-4.136' WHERE (`spawn_id` = '8340'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.625' WHERE (`spawn_id` = '8369'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.859' WHERE (`spawn_id` = '8385'); 
        -- Fadeleaf Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '39.598' WHERE (`spawn_id` = '13641'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.527' WHERE (`spawn_id` = '8404'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.857' WHERE (`spawn_id` = '8406'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.681' WHERE (`spawn_id` = '8411'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.039' WHERE (`spawn_id` = '8428'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.188' WHERE (`spawn_id` = '8442'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-4.566' WHERE (`spawn_id` = '8447'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.087' WHERE (`spawn_id` = '8454'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.651' WHERE (`spawn_id` = '8457'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-2.548' WHERE (`spawn_id` = '8468'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.568' WHERE (`spawn_id` = '8501'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '12.563' WHERE (`spawn_id` = '8508'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.412' WHERE (`spawn_id` = '8509'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.821' WHERE (`spawn_id` = '8534'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.648' WHERE (`spawn_id` = '8535'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.676' WHERE (`spawn_id` = '8536'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.523' WHERE (`spawn_id` = '8537'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.24' WHERE (`spawn_id` = '8538'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.432' WHERE (`spawn_id` = '8540'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.697' WHERE (`spawn_id` = '8542'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.701' WHERE (`spawn_id` = '8543'); 
        -- Stranglekelp XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '2136.485', `spawn_positionY` = '-313.482', `spawn_positionZ` = '91.118' WHERE (`spawn_id` = '8545'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.441' WHERE (`spawn_id` = '8549'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.754' WHERE (`spawn_id` = '8550'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.58' WHERE (`spawn_id` = '8556'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.598' WHERE (`spawn_id` = '8557'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.075' WHERE (`spawn_id` = '8559'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.398' WHERE (`spawn_id` = '8564'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.636' WHERE (`spawn_id` = '8566'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.621' WHERE (`spawn_id` = '8567'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.003' WHERE (`spawn_id` = '8575'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.088' WHERE (`spawn_id` = '8576'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.732' WHERE (`spawn_id` = '8577'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-2.278' WHERE (`spawn_id` = '8578'); 
        -- Stranglekelp Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-12.684' WHERE (`spawn_id` = '8589'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '27.452' WHERE (`spawn_id` = '8608'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.832' WHERE (`spawn_id` = '8699'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '118.894' WHERE (`spawn_id` = '8700'); 
        -- Goldthorn XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '40.752', `spawn_positionY` = '-3667.576', `spawn_positionZ` = '121.721' WHERE (`spawn_id` = '8701'); 
        -- Crownroyal Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.379' WHERE (`spawn_id` = '12566'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.936' WHERE (`spawn_id` = '8712'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '32.887' WHERE (`spawn_id` = '11764'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '39.014' WHERE (`spawn_id` = '11762'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.589' WHERE (`spawn_id` = '11760'); 
        -- Crownroyal Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '39.065' WHERE (`spawn_id` = '11756'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '125.236' WHERE (`spawn_id` = '8868'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '7.189' WHERE (`spawn_id` = '8889'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-6.0' WHERE (`spawn_id` = '8904'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.855' WHERE (`spawn_id` = '8906'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '22.051' WHERE (`spawn_id` = '8913'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-3.555' WHERE (`spawn_id` = '8948'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.688' WHERE (`spawn_id` = '8959'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.583' WHERE (`spawn_id` = '9005'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-4.526' WHERE (`spawn_id` = '9013'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '131.264' WHERE (`spawn_id` = '9039'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '126.952' WHERE (`spawn_id` = '9053'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '85.357' WHERE (`spawn_id` = '9092'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '76.245' WHERE (`spawn_id` = '9201'); 
        -- Goldthorn Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '81.763' WHERE (`spawn_id` = '9202'); 
        -- Goldthorn XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '42.254', `spawn_positionY` = '-3664.0', `spawn_positionZ` = '120.138' WHERE (`spawn_id` = '9210'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '674.997' WHERE (`spawn_id` = '9232'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.173' WHERE (`spawn_id` = '9237'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '126.016' WHERE (`spawn_id` = '9246'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.038' WHERE (`spawn_id` = '9266'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '81.28' WHERE (`spawn_id` = '9271'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-258.168' WHERE (`spawn_id` = '9275'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '28.341' WHERE (`spawn_id` = '9345'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '19.938' WHERE (`spawn_id` = '9347'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-205.408', `spawn_positionY` = '-383.035', `spawn_positionZ` = '65.956' WHERE (`spawn_id` = '9350'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '124.173' WHERE (`spawn_id` = '9364'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.262' WHERE (`spawn_id` = '9390'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '134.366' WHERE (`spawn_id` = '9397'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '811.161' WHERE (`spawn_id` = '9398'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-729.052', `spawn_positionY` = '-3695.72', `spawn_positionZ` = '195.584' WHERE (`spawn_id` = '9401'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-722.33', `spawn_positionY` = '-3692.587', `spawn_positionZ` = '196.207' WHERE (`spawn_id` = '9402'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1334.458', `spawn_positionY` = '-1681.675', `spawn_positionZ` = '73.51' WHERE (`spawn_id` = '9403'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '116.679' WHERE (`spawn_id` = '9418'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-277.437', `spawn_positionY` = '-380.104', `spawn_positionZ` = '68.806' WHERE (`spawn_id` = '9420'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '688.414' WHERE (`spawn_id` = '9423'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2007.75', `spawn_positionY` = '-3290.647', `spawn_positionZ` = '59.618' WHERE (`spawn_id` = '9438'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '688.414' WHERE (`spawn_id` = '9445'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '44.259' WHERE (`spawn_id` = '9446'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.005' WHERE (`spawn_id` = '9455'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.222' WHERE (`spawn_id` = '9455'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-11158.411', `spawn_positionY` = '-1167.057', `spawn_positionZ` = '42.353' WHERE (`spawn_id` = '9457'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '39.272' WHERE (`spawn_id` = '9468'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5618.776', `spawn_positionY` = '3443.809', `spawn_positionZ` = '49.705' WHERE (`spawn_id` = '9481'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-209.05', `spawn_positionY` = '-384.295', `spawn_positionZ` = '65.214' WHERE (`spawn_id` = '9523'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '118.97' WHERE (`spawn_id` = '9575'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.382' WHERE (`spawn_id` = '9587'); 
        -- Iron Deposit ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9592'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-672.413', `spawn_positionY` = '-3772.663', `spawn_positionZ` = '216.557' WHERE (`spawn_id` = '9605'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.964' WHERE (`spawn_id` = '9622'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5640.168', `spawn_positionY` = '3531.055', `spawn_positionZ` = '44.682' WHERE (`spawn_id` = '9623'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '43.766' WHERE (`spawn_id` = '9623'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '240.768' WHERE (`spawn_id` = '9633'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-248.233', `spawn_positionY` = '-400.591', `spawn_positionZ` = '67.74' WHERE (`spawn_id` = '9636'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2358.7', `spawn_positionY` = '2502.176', `spawn_positionZ` = '75.21' WHERE (`spawn_id` = '32601'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2335.491', `spawn_positionY` = '2472.6', `spawn_positionZ` = '76.172' WHERE (`spawn_id` = '32600'); 
        -- Tear of Theradras XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2345.112', `spawn_positionY` = '2453.43', `spawn_positionZ` = '67.707' WHERE (`spawn_id` = '32599'); 
        -- Tear of Theradras Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '72.315' WHERE (`spawn_id` = '32598'); 
        -- Tear of Theradras Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '58.188' WHERE (`spawn_id` = '32596'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5550.423', `spawn_positionY` = '658.624', `spawn_positionZ` = '393.387' WHERE (`spawn_id` = '9938'); 
        -- Vylestem Vine Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.523' WHERE (`spawn_id` = '32573'); 
        -- Barrel of Melon Juice XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-498.822', `spawn_positionY` = '-1536.943', `spawn_positionZ` = '59.761' WHERE (`spawn_id` = '20856'); 
        -- Rise of the Horde Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '39.854' WHERE (`spawn_id` = '29688'); 
        -- The Dark Portal and the Fall of Stormwind Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '20.962' WHERE (`spawn_id` = '29686'); 
        -- The New Horde Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '39.855' WHERE (`spawn_id` = '29681'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.867' WHERE (`spawn_id` = '32535'); 
        -- Karnitol's Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.121' WHERE (`spawn_id` = '32531'); 
        -- MacGrann's Meat Locker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '417.986' WHERE (`spawn_id` = '10027'); 
        -- The Battle of Grim Batol XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1897.128', `spawn_positionY` = '352.391', `spawn_positionZ` = '107.661' WHERE (`spawn_id` = '32506'); 
        -- War of the Three Hammers XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1898.901', `spawn_positionY` = '336.872', `spawn_positionZ` = '105.117' WHERE (`spawn_id` = '32010'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.774' WHERE (`spawn_id` = '20817'); 
        -- Ironforge - the Awakening of the Dwarves XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1896.912', `spawn_positionY` = '355.444', `spawn_positionZ` = '107.55' WHERE (`spawn_id` = '31909'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '386.112' WHERE (`spawn_id` = '10105'); 
        -- Mighty Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '31346'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '31344'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '31342'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30952'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30908'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30907'); 
        -- Mighty Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30906'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '30905'); 
        -- Campfire XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2284.958', `spawn_positionY` = '2657.683', `spawn_positionZ` = '60.66' WHERE (`spawn_id` = '30904'); 
        -- Caravan Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.686' WHERE (`spawn_id` = '29362'); 
        -- Locked ball and chain Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.226' WHERE (`spawn_id` = '20785'); 
        -- Locked ball and chain Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '53.623' WHERE (`spawn_id` = '20784'); 
        -- Alterac Granite XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-241.674', `spawn_positionY` = '-267.344', `spawn_positionZ` = '54.413' WHERE (`spawn_id` = '20782'); 
        -- Alterac Granite XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-212.773', `spawn_positionY` = '-383.497', `spawn_positionZ` = '64.896' WHERE (`spawn_id` = '20781'); 
        -- Flame of Veraz XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-210.968', `spawn_positionY` = '-308.329', `spawn_positionZ` = '49.109' WHERE (`spawn_id` = '20780'); 
        -- Flame of Azel XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-211.04', `spawn_positionY` = '-378.924', `spawn_positionZ` = '65.852' WHERE (`spawn_id` = '20779'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8943.978', `spawn_positionY` = '-2035.95', `spawn_positionZ` = '133.951' WHERE (`spawn_id` = '31124'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8957.213', `spawn_positionY` = '-2000.348', `spawn_positionZ` = '134.091' WHERE (`spawn_id` = '31123'); 
        -- Battered Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8910.886', `spawn_positionY` = '-1962.685', `spawn_positionZ` = '130.836' WHERE (`spawn_id` = '31122'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8946.009', `spawn_positionY` = '-1975.52', `spawn_positionZ` = '135.707' WHERE (`spawn_id` = '20883'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8904.822', `spawn_positionY` = '-1918.278', `spawn_positionZ` = '133.83' WHERE (`spawn_id` = '20882'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8867.052', `spawn_positionY` = '-1849.176', `spawn_positionZ` = '120.721' WHERE (`spawn_id` = '20454'); 
        -- Water Barrel Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '358.872' WHERE (`spawn_id` = '10847'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5704.192', `spawn_positionY` = '-1684.101', `spawn_positionZ` = '358.417' WHERE (`spawn_id` = '10853'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5615.457', `spawn_positionY` = '-1648.702', `spawn_positionZ` = '354.348' WHERE (`spawn_id` = '10855'); 
        -- Battered Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5559.417', `spawn_positionY` = '-1607.08', `spawn_positionZ` = '353.305' WHERE (`spawn_id` = '10856'); 
        -- Ironband's Strongbox Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '408.592' WHERE (`spawn_id` = '10868'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-322.092', `spawn_positionY` = '931.233', `spawn_positionZ` = '131.866' WHERE (`spawn_id` = '35444'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-8747.848', `spawn_positionY` = '-2246.65', `spawn_positionZ` = '153.659' WHERE (`spawn_id` = '18679'); 
        -- Solid Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.926' WHERE (`spawn_id` = '9096'); 
        -- Onyxia's Gate Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.097' WHERE (`spawn_id` = '9091'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4088.002', `spawn_positionY` = '-4537.01', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9087'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4089.954', `spawn_positionY` = '-4530.919', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9082'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-820.755', `spawn_positionY` = '-563.622', `spawn_positionZ` = '16.408' WHERE (`spawn_id` = '18819'); 
        -- Shaman Shrine Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.29' WHERE (`spawn_id` = '35418'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.643' WHERE (`spawn_id` = '17994'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.909' WHERE (`spawn_id` = '17993'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '186.92' WHERE (`spawn_id` = '17991'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.883' WHERE (`spawn_id` = '17988'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.764' WHERE (`spawn_id` = '17986'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.375' WHERE (`spawn_id` = '17984'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.297' WHERE (`spawn_id` = '17982'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '186.743' WHERE (`spawn_id` = '17980'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.607' WHERE (`spawn_id` = '17979'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.638' WHERE (`spawn_id` = '17977'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.764' WHERE (`spawn_id` = '17976'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.542' WHERE (`spawn_id` = '17974'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '182.629' WHERE (`spawn_id` = '17973'); 
        -- Wooden Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '181.718' WHERE (`spawn_id` = '17966'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1818.535', `spawn_positionY` = '-1160.698', `spawn_positionZ` = '84.396' WHERE (`spawn_id` = '20722'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1796.07', `spawn_positionY` = '-1133.676', `spawn_positionZ` = '89.368' WHERE (`spawn_id` = '20721'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2414.816', `spawn_positionY` = '352.55', `spawn_positionZ` = '71.249' WHERE (`spawn_id` = '20717'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2355.516', `spawn_positionY` = '374.086', `spawn_positionZ` = '71.101' WHERE (`spawn_id` = '20716'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1729.654', `spawn_positionY` = '-1183.665', `spawn_positionZ` = '83.191' WHERE (`spawn_id` = '20672'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2409.372', `spawn_positionY` = '392.377', `spawn_positionZ` = '65.291' WHERE (`spawn_id` = '20667'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1803.327', `spawn_positionY` = '-1145.089', `spawn_positionZ` = '86.233' WHERE (`spawn_id` = '20648'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1786.272', `spawn_positionY` = '-995.415', `spawn_positionZ` = '86.124' WHERE (`spawn_id` = '20644'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '85.098' WHERE (`spawn_id` = '20644'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1457.337', `spawn_positionY` = '-920.6', `spawn_positionZ` = '51.495' WHERE (`spawn_id` = '20642'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '50.769' WHERE (`spawn_id` = '20642'); 
		        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '72.494' WHERE (`spawn_id` = '42512'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '72.495' WHERE (`spawn_id` = '42511'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4087.813', `spawn_positionY` = '-4538.993', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9079'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4090.135', `spawn_positionY` = '-4528.345', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9077'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4092.054', `spawn_positionY` = '-4542.481', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9063'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9062'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4093.94', `spawn_positionY` = '-4534.429', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9056'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4080.577', `spawn_positionY` = '-4537.296', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9038'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4090.338', `spawn_positionY` = '-4535.015', `spawn_positionZ` = '0.006' WHERE (`spawn_id` = '9037'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3979.879', `spawn_positionY` = '-4594.738', `spawn_positionZ` = '0.077' WHERE (`spawn_id` = '9034'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3994.309', `spawn_positionY` = '-4594.834', `spawn_positionZ` = '0.077' WHERE (`spawn_id` = '9032'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3992.362', `spawn_positionY` = '-4590.767', `spawn_positionZ` = '0.077' WHERE (`spawn_id` = '9024'); 
        -- Wooden Chair XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3997.958', `spawn_positionY` = '-4611.022', `spawn_positionZ` = '7.394' WHERE (`spawn_id` = '9006'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9001'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '9000'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8996'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8996'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '8979'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '86.522' WHERE (`spawn_id` = '20560'); 
        -- Bonfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '163.335' WHERE (`spawn_id` = '20556'); 
        -- Food Crate XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1925.28', `spawn_positionY` = '417.42', `spawn_positionZ` = '186.07' WHERE (`spawn_id` = '20528'); 
        -- Food Crate XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1948.225', `spawn_positionY` = '377.8', `spawn_positionZ` = '133.381' WHERE (`spawn_id` = '20528'); 
        -- Food Crate XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1886.202', `spawn_positionY` = '-1098.123', `spawn_positionZ` = '87.3' WHERE (`spawn_id` = '20526'); 
        -- Food Crate XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1826.478', `spawn_positionY` = '-1124.856', `spawn_positionZ` = '84.674' WHERE (`spawn_id` = '20525'); 
        -- Solid Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-877.876', `spawn_positionY` = '-3873.885', `spawn_positionZ` = '159.727' WHERE (`spawn_id` = '16977'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2022.357', `spawn_positionY` = '-3371.005', `spawn_positionZ` = '52.244' WHERE (`spawn_id` = '16974'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2012.945', `spawn_positionY` = '-3312.173', `spawn_positionZ` = '52.082' WHERE (`spawn_id` = '16973'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-870.385', `spawn_positionY` = '-3821.466', `spawn_positionZ` = '145.192' WHERE (`spawn_id` = '11993'); 
        -- Lesser Bloodstone Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '143.782' WHERE (`spawn_id` = '11993'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-873.807', `spawn_positionY` = '-3840.334', `spawn_positionZ` = '149.58' WHERE (`spawn_id` = '11995'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '148.947' WHERE (`spawn_id` = '11995'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-797.869', `spawn_positionY` = '-3808.113', `spawn_positionZ` = '144.85' WHERE (`spawn_id` = '11997'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '143.062' WHERE (`spawn_id` = '11997'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-942.759', `spawn_positionY` = '-3857.444', `spawn_positionZ` = '147.871' WHERE (`spawn_id` = '11999'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '147.196' WHERE (`spawn_id` = '11999'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-803.337', `spawn_positionY` = '-3838.042', `spawn_positionZ` = '140.398' WHERE (`spawn_id` = '12001'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '137.824' WHERE (`spawn_id` = '12001'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-834.981', `spawn_positionY` = '-3903.662', `spawn_positionZ` = '153.738' WHERE (`spawn_id` = '12002'); 
        -- Lesser Bloodstone Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '153.38' WHERE (`spawn_id` = '12002'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-852.325', `spawn_positionY` = '-3896.017', `spawn_positionZ` = '155.17' WHERE (`spawn_id` = '12005'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-887.304', `spawn_positionY` = '-3083.02', `spawn_positionZ` = '80.638' WHERE (`spawn_id` = '16965'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '77.763' WHERE (`spawn_id` = '16965'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '153.873' WHERE (`spawn_id` = '16964'); 
        -- Lesser Bloodstone Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-984.15', `spawn_positionY` = '-3845.262', `spawn_positionZ` = '144.812' WHERE (`spawn_id` = '16958'); 
        -- Lesser Bloodstone Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '143.037' WHERE (`spawn_id` = '16958'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-900.728', `spawn_positionY` = '-3824.991', `spawn_positionZ` = '146.628' WHERE (`spawn_id` = '16954'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '146.283' WHERE (`spawn_id` = '16954'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2061.016', `spawn_positionY` = '-3354.228', `spawn_positionZ` = '42.784' WHERE (`spawn_id` = '16931'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '41.178' WHERE (`spawn_id` = '16931'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-7.673' WHERE (`spawn_id` = '20420'); 
        -- Smoke Emitter 02 Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.722' WHERE (`spawn_id` = '16771'); 
        -- Small Barracks Flame Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.164' WHERE (`spawn_id` = '14779'); 
        -- Smoke Emitter 02 Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.901' WHERE (`spawn_id` = '16770'); 
        -- Big Barracks Flame Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.905' WHERE (`spawn_id` = '14776'); 
        -- Small Barracks Flame Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.683' WHERE (`spawn_id` = '14780'); 
        -- Small Barracks Flame Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.9' WHERE (`spawn_id` = '14777'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-983.377', `spawn_positionY` = '-3879.499', `spawn_positionZ` = '142.401' WHERE (`spawn_id` = '16906'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '141.518' WHERE (`spawn_id` = '16906'); 
        -- Firebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '11.493' WHERE (`spawn_id` = '12242'); 
        -- Firebloom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-7262.0', `spawn_positionY` = '-864.0', `spawn_positionZ` = '289.955' WHERE (`spawn_id` = '12243'); 
        -- Firebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.623' WHERE (`spawn_id` = '12250'); 
        -- Firebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.319' WHERE (`spawn_id` = '12274'); 
        -- Forge XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1938.896', `spawn_positionY` = '383.6', `spawn_positionZ` = '133.448' WHERE (`spawn_id` = '30166'); 
        -- Anvil XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1946.268', `spawn_positionY` = '379.568', `spawn_positionZ` = '133.412' WHERE (`spawn_id` = '30168'); 
        -- Firebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '13.28' WHERE (`spawn_id` = '12327'); 
        -- Peacebloom Flower Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-14.139' WHERE (`spawn_id` = '18551'); 
        -- Battered Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18447'); 
        -- Battered Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18445'); 
        -- Water Barrel ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18305'); 
        -- Water Barrel ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18303'); 
        -- Water Barrel ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18302'); 
        -- Campfire ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18167'); 
        -- Thunder Bluff Forge XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1241.988', `spawn_positionY` = '95.77', `spawn_positionZ` = '130.43' WHERE (`spawn_id` = '18126'); 
        -- Bonfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '100.889' WHERE (`spawn_id` = '18116'); 
        -- Bonfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '100.889' WHERE (`spawn_id` = '18112'); 
        -- Solid Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '38.597' WHERE (`spawn_id` = '16648'); 
        -- Solid Chest Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.004' WHERE (`spawn_id` = '15672'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.867' WHERE (`spawn_id` = '18045'); 
        -- Iridescent Shards Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '153.348' WHERE (`spawn_id` = '16635'); 
        -- Rise of the Blood Elves Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '83.769' WHERE (`spawn_id` = '16609'); 
        -- Sargeras and the Betrayal Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '75.614' WHERE (`spawn_id` = '16608'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.566' WHERE (`spawn_id` = '18025'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18024'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18017'); 
        -- Mouthpiece Mount Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '179.327' WHERE (`spawn_id` = '18013'); 
        -- HornCover Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '161.313' WHERE (`spawn_id` = '17228'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6353.775', `spawn_positionY` = '-1884.256', `spawn_positionZ` = '-259.576' WHERE (`spawn_id` = '17593'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6317.152', `spawn_positionY` = '-1846.192', `spawn_positionZ` = '-257.155' WHERE (`spawn_id` = '17592'); 
        -- Solid Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3853.528', `spawn_positionY` = '-2540.012', `spawn_positionZ` = '42.331' WHERE (`spawn_id` = '15212'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.575' WHERE (`spawn_id` = '17484'); 
        -- Egg-O-Matic Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '8.828' WHERE (`spawn_id` = '17475'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17463'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17462'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17461'); 
        -- Stove Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '9.214' WHERE (`spawn_id` = '17445'); 
        -- Gahz'ridian Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '27.36' WHERE (`spawn_id` = '17409'); 
        -- Gahz'ridian Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '60.208' WHERE (`spawn_id` = '17406'); 
        -- Gahz'ridian Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '9.273' WHERE (`spawn_id` = '17395'); 
        -- Gahz'ridian Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.819' WHERE (`spawn_id` = '17386'); 
        -- Stove Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.167' WHERE (`spawn_id` = '17354'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.081' WHERE (`spawn_id` = '17351'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.455' WHERE (`spawn_id` = '17350'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.014' WHERE (`spawn_id` = '17349'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.324' WHERE (`spawn_id` = '17348'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.621' WHERE (`spawn_id` = '17347'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.468' WHERE (`spawn_id` = '17346'); 
        -- Stove Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.527' WHERE (`spawn_id` = '17345'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.762' WHERE (`spawn_id` = '17344'); 
        -- Chair Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.388' WHERE (`spawn_id` = '17343'); 
        -- Old Hatreds - The Colonization of Kalimdor Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.88' WHERE (`spawn_id` = '17342'); 
        -- Food Crate Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.224' WHERE (`spawn_id` = '15194'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3906.052', `spawn_positionY` = '-2520.028', `spawn_positionZ` = '45.379' WHERE (`spawn_id` = '15182'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '44.098' WHERE (`spawn_id` = '15182'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3870.382', `spawn_positionY` = '-2415.092', `spawn_positionZ` = '47.584' WHERE (`spawn_id` = '15181'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '47.402' WHERE (`spawn_id` = '15181'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3918.919', `spawn_positionY` = '-2441.717', `spawn_positionZ` = '41.335' WHERE (`spawn_id` = '15180'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.127' WHERE (`spawn_id` = '15180'); 
        -- Incendicite Mineral Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3871.993', `spawn_positionY` = '-2533.822', `spawn_positionZ` = '45.258' WHERE (`spawn_id` = '15179'); 
        -- Incendicite Mineral Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '43.881' WHERE (`spawn_id` = '15179'); 
        -- Doodad_GeneralMedChair03 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14174'); 
        -- Doodad_GeneralMedChair04 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14173'); 
        -- Doodad_GeneralMedChair02 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14172'); 
        -- Solid Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17329'); 
        -- Moon Well Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.062' WHERE (`spawn_id` = '17328'); 
        -- Captain's Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17327'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.514' WHERE (`spawn_id` = '17326'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.896' WHERE (`spawn_id` = '17324'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.441' WHERE (`spawn_id` = '17326'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.503' WHERE (`spawn_id` = '17325'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.51' WHERE (`spawn_id` = '17324'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.838' WHERE (`spawn_id` = '17323'); 
        -- Stolen Cargo Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.658' WHERE (`spawn_id` = '17322'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.002' WHERE (`spawn_id` = '17321'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.587' WHERE (`spawn_id` = '17320'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.541' WHERE (`spawn_id` = '17319'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.326' WHERE (`spawn_id` = '17318'); 
        -- Couch Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.507' WHERE (`spawn_id` = '17317'); 
        -- Book "Soothsaying for Dummies" Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.827' WHERE (`spawn_id` = '17316'); 
        -- Barrel of Melon Juice Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-10.782' WHERE (`spawn_id` = '14890'); 
        -- Wanted Poster Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '9.962' WHERE (`spawn_id` = '17282'); 
        -- Pew ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14047'); 
        -- Pew Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '52.643' WHERE (`spawn_id` = '14046'); 
        -- Pew ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14046'); 
        -- Pew ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14045'); 
        -- Pew ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14044'); 
        -- Pew ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14043'); 
        -- Pew ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14042'); 
        -- Gate ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14040'); 
        -- Door ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14039'); 
        -- Gate ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14038'); 
        -- Door ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14036'); 
        -- Door ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14035'); 
        -- Door ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14034'); 
        -- Door ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14033'); 
        -- Gate ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14032'); 
        -- Portcullis XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2757.28', `spawn_positionY` = '-5036.39', `spawn_positionZ` = '-1.69' WHERE (`spawn_id` = '7636'); 
        -- Portcullis Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.655' WHERE (`spawn_id` = '7635'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.142' WHERE (`spawn_id` = '7634'); 
        -- Doodad_PortcullisActive02 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14030'); 
        -- Doodad_PortcullisActive06 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14029'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '11.009' WHERE (`spawn_id` = '17243'); 
        -- Food Crate Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '7.236' WHERE (`spawn_id` = '14857'); 
        -- Food Crate Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-0.098' WHERE (`spawn_id` = '14853'); 
        -- Doodad_WroughtIronDoor01 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14014'); 
        -- Forge Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '10.936' WHERE (`spawn_id` = '17240'); 
        -- Doodad_PortcullisActive07 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14013'); 
        -- Doodad_WroughtIronDoor03 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14011'); 
        -- Uldum Pedestal Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '9.323' WHERE (`spawn_id` = '17230'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-3013.538', `spawn_positionY` = '-3293.8', `spawn_positionZ` = '65.469' WHERE (`spawn_id` = '14665'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.179' WHERE (`spawn_id` = '14665'); 
        -- Iron Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '49.327' WHERE (`spawn_id` = '14664'); 
        -- Silver Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2996.575', `spawn_positionY` = '-3302.436', `spawn_positionZ` = '65.892' WHERE (`spawn_id` = '14663'); 
        -- Solid Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2948.437', `spawn_positionY` = '-3202.636', `spawn_positionZ` = '59.875' WHERE (`spawn_id` = '14660'); 
        -- Doodad_WroughtIronDoor04 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14010'); 
        -- Doodad_PortcullisActive05 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14009'); 
        -- Doodad_WroughtIronDoor02 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14005'); 
        -- Bonfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13992'); 
        -- Bonfire ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13991'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13990'); 
        -- Campfire ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13989'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13988'); 
        -- Cauldron ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13987'); 
        -- Turn Back! ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13985'); 
        -- Bonfire ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13983'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13982'); 
        -- Cauldron ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13981'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10945.107', `spawn_positionY` = '-3546.316', `spawn_positionZ` = '30.528' WHERE (`spawn_id` = '16582'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10996.399', `spawn_positionY` = '-3539.051', `spawn_positionZ` = '30.997' WHERE (`spawn_id` = '32135'); 
        -- Truesilver Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10672.617', `spawn_positionY` = '-3564.864', `spawn_positionZ` = '50.989' WHERE (`spawn_id` = '42459'); 
        -- Truesilver Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '49.995' WHERE (`spawn_id` = '42459'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10652.375', `spawn_positionY` = '-3586.477', `spawn_positionZ` = '29.141' WHERE (`spawn_id` = '42458'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '27.309' WHERE (`spawn_id` = '42458'); 
        -- Beyond the Dark Portal ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42443'); 
        -- Burning Embers ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17209'); 
        -- Document Chest ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '17199'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.709' WHERE (`spawn_id` = '7568'); 
        -- Brazier of Everfount ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '33417'); 
        -- The Dark Portal and the Fall of Stormwind ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42442'); 
        -- Aftermath of the Second War ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '42441'); 
        -- House 2 ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '3996095'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '6.775' WHERE (`spawn_id` = '7400'); 
        -- Signal Torch Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.213' WHERE (`spawn_id` = '6992'); 
        -- Mithril Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10637.499', `spawn_positionY` = '-3546.715', `spawn_positionZ` = '32.412' WHERE (`spawn_id` = '42436'); 
        -- Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '31.394' WHERE (`spawn_id` = '42436'); 
        -- Iron Deposit XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-5036.521', `spawn_positionY` = '-2401.981', `spawn_positionZ` = '-55.601' WHERE (`spawn_id` = '17194'); 
        -- Small Thorium Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10926.867', `spawn_positionY` = '-3526.492', `spawn_positionZ` = '47.292' WHERE (`spawn_id` = '40005'); 
        -- Shaman Shrine ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '33369'); 
        -- Solid Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-10860.763', `spawn_positionY` = '-3629.552', `spawn_positionZ` = '24.561' WHERE (`spawn_id` = '13978'); 
        -- The Kaldorei and the Well of Eternity Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '17.073' WHERE (`spawn_id` = '14566'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.949' WHERE (`spawn_id` = '15431'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.364' WHERE (`spawn_id` = '15433'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '42.721' WHERE (`spawn_id` = '15438'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.375' WHERE (`spawn_id` = '15439'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '31.316' WHERE (`spawn_id` = '15440'); 
        -- Ooze Covered Mithril Deposit Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '35.569' WHERE (`spawn_id` = '15442'); 
        -- Ooze Covered Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-328.398' WHERE (`spawn_id` = '15470'); 
        -- Ooze Covered Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-323.104' WHERE (`spawn_id` = '15472'); 
        -- Gorishi Hive Hatchery Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-329.91' WHERE (`spawn_id` = '50381'); 
        -- Incendia Agave Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-41.855' WHERE (`spawn_id` = '16757'); 
        -- Incendia Agave Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-52.562' WHERE (`spawn_id` = '16756'); 
        -- Incendia Agave Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-36.947' WHERE (`spawn_id` = '16755'); 
        -- Incendia Agave Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-52.341' WHERE (`spawn_id` = '16749'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.612' WHERE (`spawn_id` = '15866'); 
        -- Purple Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '115.526' WHERE (`spawn_id` = '15871'); 
        -- Purple Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '109.631' WHERE (`spawn_id` = '15880'); 
        -- Purple Lotus Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '154.385' WHERE (`spawn_id` = '15905'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '71.571' WHERE (`spawn_id` = '15950'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.133' WHERE (`spawn_id` = '15951'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.789' WHERE (`spawn_id` = '15963'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.439' WHERE (`spawn_id` = '15966'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '57.21' WHERE (`spawn_id` = '15967'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '78.472' WHERE (`spawn_id` = '15968'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.125' WHERE (`spawn_id` = '15971'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.122' WHERE (`spawn_id` = '15975'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.415' WHERE (`spawn_id` = '15980'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.338' WHERE (`spawn_id` = '15987'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.555' WHERE (`spawn_id` = '15990'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '59.306' WHERE (`spawn_id` = '15992'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '59.683' WHERE (`spawn_id` = '15994'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '72.59' WHERE (`spawn_id` = '16007'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '62.882' WHERE (`spawn_id` = '16019'); 
        -- Arthas' Tears Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '71.456' WHERE (`spawn_id` = '16022'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '60.102' WHERE (`spawn_id` = '16063'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '120.1' WHERE (`spawn_id` = '16087'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '120.834' WHERE (`spawn_id` = '16079'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-2.065' WHERE (`spawn_id` = '16098'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-1.145' WHERE (`spawn_id` = '16098'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '119.111' WHERE (`spawn_id` = '16109'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '117.854' WHERE (`spawn_id` = '16116'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '124.133' WHERE (`spawn_id` = '16121'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '122.78' WHERE (`spawn_id` = '16125'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '122.385' WHERE (`spawn_id` = '16144'); 
        -- Sungrass Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '71.551' WHERE (`spawn_id` = '16205'); 
        -- Ghost Mushroom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '153.402' WHERE (`spawn_id` = '16417'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '355.608', `spawn_positionY` = '-3752.967', `spawn_positionZ` = '135.822' WHERE (`spawn_id` = '16418'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '329.565', `spawn_positionY` = '-3821.0', `spawn_positionZ` = '142.901' WHERE (`spawn_id` = '16419'); 
        -- Ghost Mushroom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '126.081' WHERE (`spawn_id` = '16421'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '353.627', `spawn_positionY` = '-3779.0', `spawn_positionZ` = '148.453' WHERE (`spawn_id` = '16422'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '378.796', `spawn_positionY` = '-3797.707', `spawn_positionZ` = '154.722' WHERE (`spawn_id` = '16423'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '312.829', `spawn_positionY` = '-3810.0', `spawn_positionZ` = '137.854' WHERE (`spawn_id` = '16424'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '388.011', `spawn_positionY` = '-3733.0', `spawn_positionZ` = '126.703' WHERE (`spawn_id` = '16426'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '363.497', `spawn_positionY` = '-3722.528', `spawn_positionZ` = '123.33' WHERE (`spawn_id` = '16430'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '337.574', `spawn_positionY` = '-3889.219', `spawn_positionZ` = '119.72' WHERE (`spawn_id` = '16431'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '373.483', `spawn_positionY` = '-3757.0', `spawn_positionZ` = '148.096' WHERE (`spawn_id` = '16433'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '405.255', `spawn_positionY` = '-3744.617', `spawn_positionZ` = '116.589' WHERE (`spawn_id` = '16434'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '432.341', `spawn_positionY` = '-3800.962', `spawn_positionZ` = '114.644' WHERE (`spawn_id` = '16437'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '352.612', `spawn_positionY` = '-3820.737', `spawn_positionZ` = '104.034' WHERE (`spawn_id` = '16438'); 
        -- Ghost Mushroom XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '372.982', `spawn_positionY` = '-3784.0', `spawn_positionZ` = '154.539' WHERE (`spawn_id` = '16442'); 
        -- Ghost Mushroom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '121.689' WHERE (`spawn_id` = '16448'); 
        -- Gromsblood Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.918' WHERE (`spawn_id` = '16454'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '5.042' WHERE (`spawn_id` = '16541'); 
        -- Gromsblood Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '567.981' WHERE (`spawn_id` = '16543'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14344'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14345'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14343'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14342'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14341'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14340'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14339'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14338'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14337'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '16614'); 
        -- Stranglekelp ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15761'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '23.918' WHERE (`spawn_id` = '15753'); 
        --  Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '96.532' WHERE (`spawn_id` = '15725'); 
        --  Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '62.411' WHERE (`spawn_id` = '15723'); 
        -- The Punisher (DND) ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15705'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15702'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '94.305' WHERE (`spawn_id` = '15688'); 
        -- Grim Batol Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '19.059' WHERE (`spawn_id` = '13764'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15683'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '96.629' WHERE (`spawn_id` = '15676'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1975.0', `spawn_positionY` = '-3290.534', `spawn_positionZ` = '70.921' WHERE (`spawn_id` = '15675'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '69.406' WHERE (`spawn_id` = '15675'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-1348.71', `spawn_positionY` = '-2963.96', `spawn_positionZ` = '101.549' WHERE (`spawn_id` = '15496'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '100.936' WHERE (`spawn_id` = '15496'); 
        -- Copper Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-2041.03', `spawn_positionY` = '-3471.56', `spawn_positionZ` = '35.338' WHERE (`spawn_id` = '15495'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '34.748' WHERE (`spawn_id` = '15495'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '15150'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15145'); 
        -- Copper Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '60.775' WHERE (`spawn_id` = '15135'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15125'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15123'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15122'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15121'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15120'); 
        -- Buccaneer's Strongbox ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '15119'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13184'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13141'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13138'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13129'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13128'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13126'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13125'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13124'); 
        -- Campfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.994' WHERE (`spawn_id` = '14846'); 
        -- Anvil ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14774'); 
        --  ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14681'); 
        -- Cauldron ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14678'); 
        --  ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14677'); 
        --  ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14642'); 
        --  ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14639'); 
        --  ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14637'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14598'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14596'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14594'); 
        -- Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14542'); 
        -- Stove ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14519'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '14197'); 
        -- Archimonde's Return and the Flight to Kalimdor Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.557' WHERE (`spawn_id` = '13594'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13592'); 
        -- Miblon's Door Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.847' WHERE (`spawn_id` = '17428'); 
        -- The New Horde Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '33.492' WHERE (`spawn_id` = '13538'); 
        -- Lethargy of the Orcs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '32.751' WHERE (`spawn_id` = '13535'); 
        -- Master Control Program Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.572' WHERE (`spawn_id` = '13531'); 
        -- Bonfire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '45.576' WHERE (`spawn_id` = '13526'); 
        -- War of the Three Hammers Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '108.909' WHERE (`spawn_id` = '13514'); 
        -- Fierce Blaze Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '93.956' WHERE (`spawn_id` = '13512'); 
        -- Barrel of Milk Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13510'); 
        -- Barrel of Milk Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.02' WHERE (`spawn_id` = '13501'); 
        -- Ironforge - the Awakening of the Dwarves Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '118.077' WHERE (`spawn_id` = '13496'); 
        -- Crude Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '98.811' WHERE (`spawn_id` = '13491'); 
        -- Burning Embers Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.411' WHERE (`spawn_id` = '13475'); 
        -- Crude Brazier Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '135.031' WHERE (`spawn_id` = '13474'); 
        -- Campfire ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13473'); 
        -- Crude Brazier XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-595.49', `spawn_positionY` = '-3170.718', `spawn_positionZ` = '92.897' WHERE (`spawn_id` = '13470'); 
        -- Campfire ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13469'); 
        -- Exile of the High Elves Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '24.83' WHERE (`spawn_id` = '13468'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13465'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13463'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13459'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13456'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13453'); 
        -- Crude Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13450'); 
        -- Food Crate XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '1247.18', `spawn_positionY` = '-3604.149', `spawn_positionZ` = '114.297' WHERE (`spawn_id` = '13448'); 
        -- Gallywix's Lockbox Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13434'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '27.43' WHERE (`spawn_id` = '13406'); 
        -- Stolen Silver ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13405'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '27.45' WHERE (`spawn_id` = '13399'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.696' WHERE (`spawn_id` = '13397'); 
        -- Bench Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.79' WHERE (`spawn_id` = '13394'); 
        -- Wild Steelbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '36.683' WHERE (`spawn_id` = '13366'); 
        -- Forge Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.129' WHERE (`spawn_id` = '13360'); 
        -- Common Magebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.684' WHERE (`spawn_id` = '13358'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '13.37' WHERE (`spawn_id` = '13356'); 
        -- Nijel's Point Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '89.49' WHERE (`spawn_id` = '30226'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '13.679' WHERE (`spawn_id` = '13354'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13353'); 
        -- Anvil ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13352'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13351'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13350'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.129' WHERE (`spawn_id` = '13344'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.967' WHERE (`spawn_id` = '13343'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.368' WHERE (`spawn_id` = '13342'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '69.855' WHERE (`spawn_id` = '13341'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '49.643' WHERE (`spawn_id` = '13340'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '40.758' WHERE (`spawn_id` = '13337'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.134' WHERE (`spawn_id` = '13336'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '75.836' WHERE (`spawn_id` = '13335'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '57.878' WHERE (`spawn_id` = '13334'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '66.371' WHERE (`spawn_id` = '13333'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.526' WHERE (`spawn_id` = '13332'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.573' WHERE (`spawn_id` = '13331'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.012' WHERE (`spawn_id` = '13330'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '43.784' WHERE (`spawn_id` = '13329'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '22.152' WHERE (`spawn_id` = '13328'); 
        -- Burning Embers Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13326'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13325'); 
        -- Food Crate ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13319'); 
        -- Gallywix's Lockbox Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '13316'); 
        -- Warm Fire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.836' WHERE (`spawn_id` = '13313'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13312'); 
        -- Warm Fire Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.683' WHERE (`spawn_id` = '13308'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13307'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13302'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.229' WHERE (`spawn_id` = '13301'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13299'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13294'); 
        -- The Jewel of the Southsea ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13293'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.129' WHERE (`spawn_id` = '13290'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '16.967' WHERE (`spawn_id` = '13277'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.368' WHERE (`spawn_id` = '13276'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '69.747' WHERE (`spawn_id` = '13275'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '49.643' WHERE (`spawn_id` = '13274'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '40.758' WHERE (`spawn_id` = '13273'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '21.134' WHERE (`spawn_id` = '13272'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '75.836' WHERE (`spawn_id` = '13271'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '57.878' WHERE (`spawn_id` = '13270'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '66.371' WHERE (`spawn_id` = '13269'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.526' WHERE (`spawn_id` = '13268'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.573' WHERE (`spawn_id` = '13267'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '51.011' WHERE (`spawn_id` = '13266'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '43.784' WHERE (`spawn_id` = '13265'); 
        -- Serpentbloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '22.152' WHERE (`spawn_id` = '13264'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13262'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13258'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13257'); 
        -- Kolkars' Booty ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13253'); 
        -- Laden Mushroom ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13198'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13183'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13172'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13169'); 
        -- Kolkar's Booty ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13162'); 
        -- Cannon ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13153'); 
        -- Cannon ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13149'); 
        -- Cannon ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13130'); 
        -- Battered Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6008.708', `spawn_positionY` = '-2972.425', `spawn_positionZ` = '402.824' WHERE (`spawn_id` = '13209'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13122'); 
        -- Tin Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6048.852', `spawn_positionY` = '-2798.129', `spawn_positionZ` = '392.479' WHERE (`spawn_id` = '12860'); 
        -- Tin Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '391.79' WHERE (`spawn_id` = '12860'); 
        -- Barrel of Milk XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-6024.201', `spawn_positionY` = '-2801.919', `spawn_positionZ` = '386.121' WHERE (`spawn_id` = '12801'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13123'); 
        -- Cannon ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13082'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13081'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13065'); 
        -- Kolkar's Booty Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '97.756' WHERE (`spawn_id` = '13061'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13039'); 
        -- Stonetalon Mountains Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '89.488' WHERE (`spawn_id` = '30232'); 
        -- Bonfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12961'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12945'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.667' WHERE (`spawn_id` = '12940'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.836' WHERE (`spawn_id` = '12939'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '91.683' WHERE (`spawn_id` = '12938'); 
        -- Campfire Damage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '92.411' WHERE (`spawn_id` = '12937'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12933'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12931'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12930'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12928'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12857'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12854'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12853'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12852'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12850'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12849'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12835'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12711'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12710'); 
        -- Ironzar's Imported Weaponry ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12708'); 
        -- Anvil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '14.297' WHERE (`spawn_id` = '12705'); 
        -- Jazzik's General Goods ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12704'); 
        -- Damaged Chest XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-4926.41', `spawn_positionY` = '-2345.391', `spawn_positionZ` = '-49.869' WHERE (`spawn_id` = '12699'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12691'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12669'); 
        -- Taillasher Eggs Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '3.932' WHERE (`spawn_id` = '12623'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13072'); 
        -- Rich Thorium Vein ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '18384'); 
        -- Rich Thorium Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-223.106' WHERE (`spawn_id` = '18424'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13070'); 
        -- Gold Vein XYZ placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '-236.393', `spawn_positionY` = '-370.875', `spawn_positionZ` = '69.721' WHERE (`spawn_id` = '33196'); 
        -- Gold Vein Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '68.876' WHERE (`spawn_id` = '33196'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13069'); 
        -- Water Barrel Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '1.252' WHERE (`spawn_id` = '12498'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13025'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13023'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13021'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13020'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13018'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13013'); 
        -- Potbelly Stove ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13009'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13007'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13004'); 
        -- Campfire Damage ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13001'); 
        -- Fiery Brazier ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '13000'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12997');         -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12996'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12988'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12925'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12924'); 
        -- High Back Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12922'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12912'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12911'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12908'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12907'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12897'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12896'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12895'); 
        -- Gnomish Toolbox Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '-14.262' WHERE (`spawn_id` = '12422'); 
        -- Food Crate Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '26.854' WHERE (`spawn_id` = '12392');         -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12889'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12886'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12884'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12881'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12879'); 
        -- Wooden Chair ignored, out of reach. 
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '12878'); 
        -- Golden Sansam Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.8' WHERE (`spawn_id` = '18972'); 
        -- Golden Sansam Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.886' WHERE (`spawn_id` = '19004'); 
        -- Golden Sansam Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '2.886' WHERE (`spawn_id` = '19004'); 
        -- Golden Sansam Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '117.873' WHERE (`spawn_id` = '19093'); 
        -- Golden Sansam Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '65.504' WHERE (`spawn_id` = '19173'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '118.658' WHERE (`spawn_id` = '19287'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '60.256' WHERE (`spawn_id` = '19311'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '64.248' WHERE (`spawn_id` = '19332'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.076' WHERE (`spawn_id` = '19333'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.923' WHERE (`spawn_id` = '19359'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '128.284' WHERE (`spawn_id` = '19363'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '128.454' WHERE (`spawn_id` = '19364'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '62.483' WHERE (`spawn_id` = '19489'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '60.426' WHERE (`spawn_id` = '19490'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.284' WHERE (`spawn_id` = '19560'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.801' WHERE (`spawn_id` = '19592'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '0.201' WHERE (`spawn_id` = '19608'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.781' WHERE (`spawn_id` = '19612'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.534' WHERE (`spawn_id` = '19632'); 
        -- Dreamfoil Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '4.085' WHERE (`spawn_id` = '19656'); 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '106.304' WHERE (`spawn_id` = '19713'); 
        -- Mountain Silversage Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '140.878' WHERE (`spawn_id` = '19736'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '80.112' WHERE (`spawn_id` = '19882'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '84.089' WHERE (`spawn_id` = '19883'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '82.082' WHERE (`spawn_id` = '19884'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '129.702' WHERE (`spawn_id` = '19893'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.77' WHERE (`spawn_id` = '19895'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '63.511' WHERE (`spawn_id` = '19911'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '81.348' WHERE (`spawn_id` = '19912'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '83.893' WHERE (`spawn_id` = '19913'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '62.793' WHERE (`spawn_id` = '19916'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '102.343' WHERE (`spawn_id` = '19920'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.37' WHERE (`spawn_id` = '19940'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '78.101' WHERE (`spawn_id` = '19942'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.924' WHERE (`spawn_id` = '19944'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '66.533' WHERE (`spawn_id` = '19975'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '102.31' WHERE (`spawn_id` = '19996'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '61.002' WHERE (`spawn_id` = '19999'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '60.707' WHERE (`spawn_id` = '20001'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '62.044' WHERE (`spawn_id` = '20002'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '137.031' WHERE (`spawn_id` = '20004'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '80.968' WHERE (`spawn_id` = '20028'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '129.097' WHERE (`spawn_id` = '20031'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '101.295' WHERE (`spawn_id` = '20035'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '126.042' WHERE (`spawn_id` = '20045'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '129.752' WHERE (`spawn_id` = '20062'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '136.219' WHERE (`spawn_id` = '20094'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '82.372' WHERE (`spawn_id` = '20108'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '135.51' WHERE (`spawn_id` = '20124'); 
        -- Plaguebloom Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '103.504' WHERE (`spawn_id` = '20133'); 
        -- Khadgar's Whisker Z placement. 
        UPDATE `spawns_gameobjects` SET `spawn_positionZ` = '120.328' WHERE (`spawn_id` = '34961'); 

        insert into applied_updates values ('190120221');
    end if;
	
	-- 08/02/2022 1
    if (select count(*) from applied_updates where id='08020221') = 0 then
        
		DROP TABLE IF EXISTS `creature_addon`;
        CREATE TABLE IF NOT EXISTS `creature_addon` (
        `guid` int(10) unsigned NOT NULL DEFAULT '0',
        `patch` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Content patch in which this exact version of the entry was added',
        `display_id` smallint(5) unsigned NOT NULL DEFAULT '0',
        `mount_display_id` smallint(6) NOT NULL DEFAULT '-1',
        `equipment_id` int(11) NOT NULL DEFAULT '-1',
        `stand_state` tinyint(3) unsigned NOT NULL DEFAULT '0',
        `sheath_state` tinyint(3) unsigned NOT NULL DEFAULT '1',
        `emote_state` smallint(5) unsigned NOT NULL DEFAULT '0',
        `auras` text,
		 PRIMARY KEY (`guid`,`patch`)
        ) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Extra data for creature spawn.';

        /*!40000 ALTER TABLE `creature_addon` DISABLE KEYS */;
        INSERT INTO `creature_addon` (`guid`, `patch`, `display_id`, `mount_display_id`, `equipment_id`, `stand_state`, `sheath_state`, `emote_state`, `auras`) VALUES
        (1886, 9, 0, 0, -1, 0, 1, 0, '29705'),
        (3348, 0, 0, 0, -1, 0, 0, 0, ''),
        (3347, 0, 0, 0, -1, 0, 0, 0, ''),
        (3346, 0, 0, 0, -1, 0, 0, 0, ''),
        (3345, 0, 0, 0, -1, 0, 0, 0, ''),
        (3256, 0, 0, 2328, -1, 0, 1, 0, NULL),
        (3254, 0, 0, 207, -1, 0, 1, 0, NULL),
        (3277, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (79082, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (79095, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (79097, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (79103, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (79106, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (79139, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79188, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79207, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79222, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79227, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79299, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79322, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (27397, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (79385, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79390, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79628, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79792, 0, 0, 0, -1, 0, 1, 0, '18950'),
        (79910, 0, 0, 0, -1, 0, 1, 0, NULL),
        (80383, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (80389, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (80390, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (285021, 0, 0, 0, -1, 3, 0, 0, NULL),
        (80744, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (80967, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (80969, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (80977, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (80978, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (81105, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (81170, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (81173, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (81176, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (45380, 0, 0, 0, -1, 0, 0, 234, NULL),
        (45384, 0, 0, 0, -1, 0, 0, 234, NULL),
        (46775, 0, 0, 0, -1, 0, 0, 234, NULL),
        (81610, 0, 0, 0, -1, 8, 1, 0, NULL),
        (81604, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (81561, 0, 0, 0, -1, 8, 1, 0, NULL),
        (81447, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (81446, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (81444, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (81440, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (44169, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (44165, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (44164, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (44163, 0, 0, 0, -1, 8, 1, 0, NULL),
        (44162, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (43704, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (43695, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42627, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (42626, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42624, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42622, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42607, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42606, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (42605, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42604, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (42602, 0, 0, 0, -1, 0, 1, 0, '20798'),
        (42600, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (42596, 0, 0, 0, -1, 0, 1, 133, NULL),
        (38016, 0, 0, 0, -1, 1, 1, 0, NULL),
        (12604, 4, 0, 0, -1, 0, 1, 0, NULL),
        (42598, 4, 0, 0, -1, 0, 1, 0, NULL),
        (42601, 4, 0, 0, -1, 0, 1, 69, NULL),
        (56612, 4, 0, 0, -1, 0, 1, 0, NULL),
        (56613, 4, 0, 0, -1, 0, 1, 0, NULL),
        (56680, 4, 0, 0, -1, 0, 1, 0, NULL),
        (18687, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (26252, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (27350, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (27376, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (33933, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (33966, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38113, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38115, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38119, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38124, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38136, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38139, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (38146, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (85948, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (86112, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (42709, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (87207, 0, 0, 0, -1, 0, 1, 0, NULL),
        (87208, 0, 0, 0, -1, 0, 1, 0, NULL),
        (87210, 0, 0, 0, -1, 0, 1, 0, NULL),
        (87211, 0, 0, 0, -1, 0, 1, 0, NULL),
        (87421, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (87488, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (55099, 0, 0, 0, -1, 0, 1, 0, '13236'),
        (190213, 0, 0, 0, -1, 0, 1, 3, ''),
        (54647, 0, 0, 0, -1, 0, 1, 0, '3417 13299 21157'),
        (54130, 0, 0, 0, -1, 0, 1, 0, '21862'),
        (27408, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (27399, 0, 0, 0, -1, 8, 1, 0, NULL),
        (27396, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (26313, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (26311, 0, 0, 0, -1, 8, 1, 0, NULL),
        (26303, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26297, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26146, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26145, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26144, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26143, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26133, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26120, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26119, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26117, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26115, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40044, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40043, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40041, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40040, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40027, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40025, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40024, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40021, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40018, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40017, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40008, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40006, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40005, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40004, 0, 0, 0, -1, 8, 1, 0, NULL),
        (46801, 4, 0, 0, -1, 0, 1, 69, NULL),
        (30135, 0, 0, 0, -1, 7, 1, 0, NULL),
        (30165, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30172, 0, 0, 0, -1, 0, 1, 173, NULL),
        (30173, 0, 0, 0, -1, 0, 1, 173, NULL),
        (30184, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30185, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30193, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30207, 0, 0, 0, -1, 0, 1, 0, '10348'),
        (30232, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (30233, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30234, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (30235, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30236, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (30237, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30292, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30294, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30295, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30302, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30304, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30305, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30307, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30320, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30321, 0, 0, 0, -1, 7, 1, 0, NULL),
        (30322, 0, 0, 0, -1, 7, 1, 0, NULL),
        (30323, 0, 0, 0, -1, 8, 1, 0, '13864'),
        (30324, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30358, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30364, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30366, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30367, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30372, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30377, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30382, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30383, 0, 0, 0, -1, 0, 1, 173, NULL),
        (30388, 0, 0, 0, -1, 0, 1, 0, '10348'),
        (30390, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32006, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32007, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33400, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33401, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33402, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33422, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33485, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16240, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16267, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16268, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16443, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16445, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17901, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18183, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18189, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18241, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18697, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18699, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18703, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18712, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27471, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27472, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27473, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27568, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27691, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27728, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27764, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27765, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27766, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27767, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27769, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27770, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27789, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27790, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27791, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (27793, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27796, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27798, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27800, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28367, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28369, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28370, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28371, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28372, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28373, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28374, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28376, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28377, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28532, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28533, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28534, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28535, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28536, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28537, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28538, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28539, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28540, 0, 0, 0, -1, 0, 1, 233, NULL),
        (28541, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28542, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28543, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28544, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28545, 0, 0, 0, -1, 0, 1, 233, NULL),
        (28546, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28547, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28784, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28786, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28789, 0, 0, 0, -1, 0, 1, 0, NULL),
        (28795, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28796, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28797, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28798, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28799, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (28800, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29384, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (29488, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (29573, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (29574, 0, 0, 0, -1, 0, 1, 233, '7165'),
        (29589, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29591, 0, 0, 0, -1, 0, 1, 173, NULL),
        (29592, 0, 0, 0, -1, 0, 1, 173, NULL),
        (29594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29649, 0, 0, 0, -1, 0, 1, 173, NULL),
        (29651, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29653, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (29654, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (29656, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (29657, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (29659, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (29773, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30022, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30030, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30066, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30067, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30073, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30076, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30078, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (30079, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (33505, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (33506, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (33507, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (33508, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (33511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33512, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33513, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33514, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33515, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33516, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33518, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3276, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (3275, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (3274, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3270, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7889, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7892, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18610, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18611, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18613, 0, 0, 0, -1, 0, 1, 69, NULL),
        (18615, 0, 0, 0, -1, 1, 1, 0, NULL),
        (18616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18624, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18625, 0, 0, 0, -1, 0, 1, 0, NULL),
        (25816, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30468, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30469, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30471, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90284, 6, 0, 0, -1, 0, 1, 0, '26243'),
        (30645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90233, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (30851, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30855, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30856, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30857, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30858, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30859, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30860, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30863, 0, 0, 0, -1, 0, 1, 69, NULL),
        (30871, 0, 0, 0, -1, 3, 1, 0, NULL),
        (90195, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (90194, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (89401, 6, 0, 0, -1, 0, 1, 0, '26245'),
        (90193, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (89400, 6, 0, 0, -1, 0, 1, 0, '26246'),
        (89399, 6, 0, 0, -1, 0, 1, 0, '26245'),
        (90189, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (89406, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (90188, 6, 0, 0, -1, 0, 1, 0, '26245'),
        (90187, 6, 0, 0, -1, 0, 1, 0, '26246'),
        (90186, 6, 0, 0, -1, 0, 1, 0, '26251'),
        (90185, 6, 0, 0, -1, 0, 1, 0, '26252'),
        (90183, 6, 0, 0, -1, 0, 1, 0, '26242'),
        (90182, 6, 0, 0, -1, 0, 1, 0, '26241'),
        (90181, 6, 0, 0, -1, 0, 1, 0, '26243'),
        (89405, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (31222, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (90180, 6, 0, 0, -1, 0, 1, 0, '26244'),
        (89398, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (31336, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (31338, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (31339, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89422, 6, 0, 0, -1, 0, 1, 0, '26250'),
        (89397, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (89421, 6, 0, 0, -1, 0, 1, 0, '26246'),
        (89420, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (89396, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (90426, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (90380, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (90378, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (90377, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (89395, 6, 0, 0, -1, 0, 1, 0, '26250'),
        (89394, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (89419, 6, 0, 0, -1, 0, 1, 0, '26242'),
        (89415, 6, 0, 0, -1, 0, 1, 0, '26241'),
        (31458, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (31459, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (90296, 6, 0, 0, -1, 0, 1, 0, '26243'),
        (31464, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89393, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (89392, 6, 0, 0, -1, 0, 1, 0, '26253'),
        (89391, 6, 0, 0, -1, 0, 1, 0, '26254'),
        (31479, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89412, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (89390, 6, 0, 0, -1, 0, 1, 0, '26253'),
        (31487, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (31488, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (31492, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (31493, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89389, 6, 0, 0, -1, 0, 1, 0, '26254'),
        (89388, 6, 0, 0, -1, 0, 1, 0, '26253'),
        (89387, 6, 0, 0, -1, 0, 1, 0, '26254'),
        (89386, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (89385, 6, 0, 0, -1, 0, 1, 0, '26250'),
        (31526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89384, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (89383, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (89382, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (90289, 6, 0, 0, -1, 0, 1, 0, '26244'),
        (89381, 6, 0, 0, -1, 0, 1, 0, '26250'),
        (89379, 6, 0, 0, -1, 0, 1, 0, '26243'),
        (31615, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89408, 6, 0, 0, -1, 0, 1, 0, '26251'),
        (89380, 6, 0, 0, -1, 0, 1, 0, '26244'),
        (89375, 6, 0, 0, -1, 0, 1, 0, '26245'),
        (89376, 6, 0, 0, -1, 0, 1, 0, '26246'),
        (31623, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89371, 6, 0, 0, -1, 0, 1, 0, '26242'),
        (31626, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89372, 6, 0, 0, -1, 0, 1, 0, '26241'),
        (89370, 6, 0, 0, -1, 0, 1, 0, '26242'),
        (31727, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89369, 6, 0, 0, -1, 0, 1, 0, '26241'),
        (31731, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89368, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (33762, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89403, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (89367, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (34012, 0, 0, 0, -1, 0, 1, 0, '18968'),
        (89366, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (89363, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (89364, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (89365, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (527, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (528, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (534, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90457, 0, 0, 0, -1, 1, 1, 0, NULL),
        (623, 0, 0, 0, -1, 0, 1, 0, NULL),
        (626, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (628, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (728, 0, 0, 0, -1, 0, 1, 0, NULL),
        (762, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (848, 0, 0, 0, -1, 0, 1, 233, NULL),
        (906, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1093, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (1200, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1201, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1202, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1205, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1209, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1211, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1212, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1214, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1216, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1217, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1286, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1313, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1315, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1333, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1334, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1348, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1400, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1410, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1413, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1414, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1415, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1417, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1425, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1431, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1432, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1433, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1435, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1436, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1437, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1440, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1442, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1456, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1458, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1461, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1462, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1465, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1596, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1602, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1617, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1619, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1625, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1627, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1631, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1632, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1633, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1634, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (1676, 0, 0, 0, -1, 0, 1, 0, '184'),
        (1678, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1686, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1687, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1699, 0, 0, 0, -1, 0, 1, 233, NULL),
        (1828, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1839, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1846, 0, 0, 0, -1, 0, 1, 0, NULL),
        (1948, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1951, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1953, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1954, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1958, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1960, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1961, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1964, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1966, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1968, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (1980, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2047, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2066, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2069, 0, 0, 0, -1, 0, 1, 0, '184'),
        (2073, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2149, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2160, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2161, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2165, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2169, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2176, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2202, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2207, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2241, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (2246, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2255, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2260, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2272, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2316, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (2318, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2321, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (2337, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2344, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2361, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2367, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2371, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2372, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2375, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2380, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2394, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2400, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2430, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2486, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2488, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2491, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (2497, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2503, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2506, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2609, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2612, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2613, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2615, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2616, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2617, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2619, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2620, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2623, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2624, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2626, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2630, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (2670, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2671, 0, 0, 0, -1, 0, 1, 28, NULL),
        (2693, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2694, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2695, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2696, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2697, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2698, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2699, 0, 0, 0, -1, 0, 1, 233, NULL),
        (8455, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8454, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2765, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2766, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2769, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2770, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2772, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2788, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2825, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2826, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2827, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2828, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2829, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2830, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2832, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2834, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2868, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2869, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2870, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2871, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2872, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2873, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2875, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2876, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2877, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2978, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2980, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2981, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2982, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2983, 0, 0, 0, -1, 0, 1, 233, NULL),
        (2984, 0, 0, 0, -1, 0, 1, 0, NULL),
        (2986, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3066, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3069, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3071, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3073, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3075, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3076, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3077, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3102, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3631, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3651, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3652, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3653, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3654, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3655, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3656, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3673, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3674, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3675, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3676, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3677, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3679, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3681, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3682, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3692, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3694, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3695, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3697, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3698, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3699, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3702, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3703, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3704, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3705, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3706, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3708, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3709, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3710, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3711, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3714, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3715, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3717, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3718, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3719, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3720, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3721, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3722, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3723, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3724, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3725, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3726, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3728, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3729, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3730, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3731, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3732, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3733, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3734, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3735, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3736, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3737, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3738, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3739, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3740, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3741, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3742, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3743, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3744, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3745, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3758, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3759, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3761, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3762, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3763, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3764, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3765, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3767, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3768, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3769, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3770, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3773, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3776, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3777, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3778, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3779, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3780, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3782, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3784, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3785, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3787, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3789, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3790, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3791, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3792, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3793, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3794, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3795, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3796, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3797, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3798, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3799, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3800, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3801, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3802, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3803, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3836, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3837, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3838, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3839, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3861, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3864, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3865, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3866, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3867, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3868, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3869, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3871, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3872, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3875, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3876, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3877, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3880, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3881, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3882, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3887, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3888, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3891, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3892, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3893, 0, 0, 0, -1, 0, 1, 233, NULL),
        (3896, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3898, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3911, 0, 0, 0, -1, 0, 1, 0, '12898'),
        (3914, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3915, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3916, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3917, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3918, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3919, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3921, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3924, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3925, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3926, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3927, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3928, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3929, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3931, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3932, 0, 0, 0, -1, 0, 1, 0, '12898'),
        (3933, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3938, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3940, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3941, 0, 0, 0, -1, 0, 1, 0, '12898'),
        (3942, 0, 0, 0, -1, 0, 1, 0, '12898'),
        (4264, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4265, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4266, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4267, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4279, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (4281, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4321, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (4323, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4324, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4327, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4336, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4337, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4339, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4342, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4386, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4388, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4389, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4391, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4392, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4395, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4396, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4398, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4400, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4402, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4404, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4405, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4452, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4831, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4862, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4863, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4867, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4869, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4871, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4874, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (4876, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (4882, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4883, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4884, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4885, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4886, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4888, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4889, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4895, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4898, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4914, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (4977, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4980, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4986, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4987, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4989, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4992, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5008, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5013, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (5014, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (5026, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5049, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5052, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5091, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5093, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5094, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5095, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5096, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5101, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5102, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5103, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5120, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5121, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5122, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5130, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5137, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5138, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5968, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5974, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5980, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5984, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5985, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5986, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5987, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5988, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5989, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (5990, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5991, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5992, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (5993, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5994, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5995, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5996, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (5997, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (5998, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5999, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6000, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (6001, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6002, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6003, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (6004, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (6005, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (44020, 0, 0, 0, -1, 1, 1, 0, ''),
        (6174, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6756, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7654, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7655, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18384, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18394, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18397, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18434, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18437, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18440, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18444, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18446, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18452, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18455, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (18457, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (20704, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (20706, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (20708, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (20714, 0, 0, 0, -1, 0, 1, 0, NULL),
        (31829, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (31837, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (31844, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34145, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34157, 0, 0, 0, -1, 0, 1, 0, '12550'),
        (34164, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34262, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34583, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35228, 0, 0, 0, -1, 0, 1, 0, NULL),
        (37601, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38060, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38670, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38671, 0, 0, 0, -1, 8, 1, 0, NULL),
        (38672, 0, 0, 0, -1, 8, 1, 0, NULL),
        (38674, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38675, 0, 0, 0, -1, 8, 1, 0, NULL),
        (38676, 0, 0, 0, -1, 8, 1, 0, NULL),
        (38677, 0, 0, 0, -1, 8, 1, 0, NULL),
        (38678, 0, 0, 0, -1, 8, 1, 0, NULL),
        (38679, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38680, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38683, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38693, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38700, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38704, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38705, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38706, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38707, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38708, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38711, 0, 0, 0, -1, 0, 1, 0, '12550'),
        (38714, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38715, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38716, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38722, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38725, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38726, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38727, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38728, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38729, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38730, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38731, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38738, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38739, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38742, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38743, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38757, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38758, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38791, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38792, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38825, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38826, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38827, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38829, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38830, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38832, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38833, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38834, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38835, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38836, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38837, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38838, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38840, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38841, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38843, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38845, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38849, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38850, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38852, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38862, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38872, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38880, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (38882, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38914, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38925, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38928, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38934, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38938, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38942, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38947, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38948, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38949, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38950, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38952, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38954, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38955, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38956, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38957, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38960, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38964, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39549, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40157, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40158, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40183, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40199, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40212, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41805, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (42111, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42116, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42117, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42838, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42846, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42852, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43584, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43585, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43587, 0, 0, 0, -1, 0, 1, 0, '12550'),
        (43591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43658, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43775, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (44232, 0, 0, 0, -1, 0, 1, 0, NULL),
        (44291, 0, 0, 0, -1, 0, 1, 0, NULL),
        (44293, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46776, 0, 0, 0, -1, 0, 0, 234, NULL),
        (44297, 0, 0, 0, -1, 0, 1, 173, NULL),
        (44303, 0, 0, 0, -1, 0, 1, 69, NULL),
        (45472, 0, 0, 0, -1, 0, 1, 69, NULL),
        (45378, 0, 0, 0, -1, 0, 0, 234, NULL),
        (45520, 0, 0, 0, -1, 0, 1, 173, NULL),
        (46784, 0, 0, 0, -1, 0, 0, 234, NULL),
        (45522, 0, 0, 0, -1, 0, 1, 173, NULL),
        (45523, 0, 0, 0, -1, 0, 1, 173, NULL),
        (45386, 0, 0, 0, -1, 0, 0, 234, NULL),
        (45531, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45534, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45549, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (45558, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45559, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45560, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45561, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45562, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45563, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45564, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45565, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45566, 0, 0, 0, -1, 0, 1, 233, NULL),
        (45567, 0, 0, 0, -1, 0, 1, 233, NULL),
        (48554, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48555, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48556, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48557, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48558, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48872, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48873, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48874, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51560, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51561, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51562, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51563, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51648, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51826, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52055, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52117, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52118, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52120, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52565, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52566, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52567, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52568, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52569, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52570, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52571, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52590, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52592, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52881, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53860, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53861, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53862, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (53959, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53962, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (54045, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54047, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54051, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54110, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54111, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54124, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54439, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (84081, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84263, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84278, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84327, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84612, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86147, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86148, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86150, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86151, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86197, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86226, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86383, 0, 0, 0, -1, 0, 1, 0, NULL),
        (88910, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89436, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89443, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89524, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89528, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89529, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89554, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89555, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89556, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89557, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89558, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89559, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89560, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89561, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89562, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89563, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89590, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89592, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89615, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89662, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89665, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89667, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (89674, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89677, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89678, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89679, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89680, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89774, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89775, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89776, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89777, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89778, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89779, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89780, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89781, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89782, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89783, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89791, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89792, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89793, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89794, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89795, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89796, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89797, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89798, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89810, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89811, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89812, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89813, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89814, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89815, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89816, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89817, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89818, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89819, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89852, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89860, 0, 0, 0, -1, 0, 1, 69, NULL),
        (47156, 0, 0, 0, -1, 0, 0, 234, NULL),
        (89865, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89882, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89883, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89884, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89885, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89886, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89887, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89888, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89889, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89890, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89891, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89907, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89908, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89909, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89979, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89980, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89981, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89982, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89983, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89984, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89985, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89986, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89987, 0, 0, 0, -1, 0, 1, 233, NULL),
        (89988, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90003, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90004, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90005, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90006, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90010, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90011, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90012, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90013, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90030, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90033, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90044, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90045, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90046, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90047, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90048, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90049, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90050, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90051, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90052, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90053, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90116, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90117, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90118, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90119, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90120, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90121, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90122, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90123, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90131, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90132, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90133, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90134, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90135, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90136, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90137, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90138, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90139, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90140, 0, 0, 0, -1, 0, 1, 233, NULL),
        (90198, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90199, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90201, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90219, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90220, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90235, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90255, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90286, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90291, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90325, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90334, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90351, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90356, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90358, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90360, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90361, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90369, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90420, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90424, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45845, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45846, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45847, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45848, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45849, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45852, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45853, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45854, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45855, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45856, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45857, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45858, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45859, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45861, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45862, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45863, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45864, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45865, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45866, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45867, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45869, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45870, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45871, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45872, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45874, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45875, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45876, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45877, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45878, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45879, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45880, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45881, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45882, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45883, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45884, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (45888, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45889, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45890, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45891, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45892, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45893, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45895, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45896, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45897, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45898, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45899, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45900, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45901, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45902, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45903, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45904, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45905, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45908, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45909, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45910, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45911, 0, 0, 0, -1, 0, 1, 0, '13589'),
        (45915, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45916, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45917, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45924, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45925, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45926, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45927, 0, 0, 0, -1, 0, 1, 0, '13589'),
        (45928, 0, 0, 0, -1, 0, 1, 0, '13589'),
        (45934, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45935, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45936, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45937, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45938, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45939, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45940, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45941, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45942, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45946, 0, 0, 0, -1, 8, 1, 0, NULL),
        (45947, 0, 0, 0, -1, 8, 1, 0, NULL),
        (45948, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45950, 0, 0, 0, -1, 8, 1, 0, NULL),
        (45951, 0, 0, 0, -1, 8, 1, 0, NULL),
        (45952, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45953, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46248, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46249, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46250, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46254, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46255, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46256, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46258, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46259, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46260, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46269, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46270, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46271, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46272, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46273, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46281, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46297, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46298, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46299, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46300, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46301, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46302, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46309, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46607, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46608, 0, 0, 0, -1, 0, 1, 0, '10255'),
        (46610, 0, 0, 0, -1, 0, 1, 0, '10255'),
        (46611, 0, 0, 0, -1, 0, 1, 0, '10255'),
        (46612, 0, 0, 0, -1, 0, 1, 0, '10255'),
        (46616, 0, 0, 0, -1, 0, 1, 0, '13299'),
        (46617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46620, 0, 0, 0, -1, 0, 1, 10, NULL),
        (46621, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46622, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46624, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46625, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46626, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46627, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46628, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46629, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47253, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47254, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47256, 0, 0, 0, -1, 0, 1, 0, ''),
        (47257, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47259, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47260, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47292, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47293, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47294, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47297, 0, 0, 0, -1, 7, 1, 0, NULL),
        (47298, 0, 0, 0, -1, 1, 1, 0, NULL),
        (47299, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47301, 0, 0, 0, -1, 0, 1, 93, NULL),
        (47304, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47478, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47561, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47562, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47563, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47564, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47565, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47566, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47568, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47569, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47586, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47590, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47592, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47598, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47599, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47601, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (47602, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47603, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47611, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47612, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47634, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47641, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47643, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (300624, 0, 0, 0, -1, 0, 0, 0, ''),
        (300622, 0, 0, 0, -1, 0, 0, 0, ''),
        (47654, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47655, 0, 0, 0, -1, 0, 1, 0, NULL),
        (300502, 0, 0, 0, -1, 0, 0, 0, ''),
        (300501, 0, 0, 0, -1, 0, 0, 0, ''),
        (300515, 0, 0, 0, -1, 0, 0, 0, ''),
        (300504, 0, 0, 0, -1, 0, 0, 0, ''),
        (47667, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47668, 0, 0, 0, -1, 0, 1, 0, NULL),
        (300514, 0, 0, 0, -1, 0, 0, 0, ''),
        (300509, 0, 0, 0, -1, 0, 0, 0, ''),
        (300503, 0, 0, 0, -1, 0, 0, 0, ''),
        (47676, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47677, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47678, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47679, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47680, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47681, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47682, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47685, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47686, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47687, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47688, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47689, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47690, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47691, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (300513, 0, 0, 0, -1, 0, 0, 0, ''),
        (300618, 0, 0, 0, -1, 0, 0, 0, ''),
        (47694, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47695, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47696, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (300610, 0, 0, 0, -1, 0, 0, 0, ''),
        (300614, 0, 0, 0, -1, 0, 0, 0, ''),
        (300497, 0, 0, 0, -1, 0, 0, 0, ''),
        (300512, 0, 0, 0, -1, 0, 0, 0, ''),
        (300496, 0, 0, 0, -1, 0, 0, 0, ''),
        (47704, 0, 0, 0, -1, 0, 1, 133, NULL),
        (47705, 0, 0, 0, -1, 0, 1, 133, NULL),
        (47706, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47707, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47708, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47709, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47711, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47712, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47713, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47714, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47715, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47716, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47717, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47718, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47719, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47720, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47721, 0, 0, 0, -1, 0, 1, 133, NULL),
        (47722, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47723, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47724, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47725, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47726, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47727, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47728, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47729, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47730, 0, 0, 0, -1, 0, 1, 173, NULL),
        (47731, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47732, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47734, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47735, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47736, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (47739, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47740, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47741, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (47745, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47746, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47747, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47749, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47750, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47751, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47755, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47757, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47758, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47759, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47760, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47762, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47764, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47765, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47766, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47772, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (47773, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (47774, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (47775, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47781, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47782, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47783, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47784, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47785, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47786, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47787, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47788, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47789, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47790, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47791, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47792, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47794, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47798, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47799, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47800, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47801, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47802, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47803, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (47806, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47808, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47809, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47812, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47814, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47815, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47816, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47817, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47818, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47819, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47820, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47821, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47822, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47823, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47826, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47827, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47828, 0, 0, 0, -1, 0, 1, 0, '13589'),
        (47830, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47831, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47832, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (47833, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47834, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47835, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47837, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47838, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47839, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47840, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47841, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47842, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47843, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47846, 0, 0, 0, -1, 8, 1, 0, NULL),
        (47847, 0, 0, 0, -1, 8, 1, 0, NULL),
        (47848, 0, 0, 0, -1, 8, 1, 0, NULL),
        (47849, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47868, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47877, 0, 0, 0, -1, 8, 1, 0, NULL),
        (47878, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47881, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47882, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48092, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48093, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48094, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48152, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48153, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48168, 0, 0, 0, -1, 0, 1, 10, NULL),
        (48169, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48170, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48171, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48172, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90592, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90597, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90598, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90599, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90601, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90602, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90603, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90604, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90605, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90607, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90608, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90609, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90610, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90611, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90612, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90613, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90615, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90619, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90620, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90621, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90622, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90623, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90624, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90625, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90626, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90627, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90628, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90629, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90631, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90632, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90633, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90634, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90635, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90636, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90637, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90640, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90641, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90642, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90643, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90644, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90645, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90647, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90648, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90649, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90651, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90652, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90653, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90654, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90655, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90656, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90657, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90658, 0, 0, 0, 151, 0, 1, 0, '13864'),
        (90659, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90660, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90661, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90662, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90667, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90668, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90669, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90670, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90671, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90672, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90673, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90674, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90675, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90676, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90677, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90678, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90679, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90680, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90681, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90682, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90683, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90684, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90686, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90687, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90688, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90689, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90693, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90694, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90699, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90700, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90701, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90702, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90703, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90704, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90705, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90706, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90707, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90708, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90709, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90711, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90712, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90713, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90714, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90715, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90717, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90718, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90719, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90720, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90721, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90722, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90725, 0, 0, 0, -1, 8, 1, 0, NULL),
        (90726, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90737, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90738, 0, 0, 0, -1, 0, 1, 10, NULL),
        (90739, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90740, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90741, 0, 0, 0, -1, 0, 1, 10, NULL),
        (90742, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90743, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90744, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90745, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90746, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90808, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90809, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90810, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90811, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90813, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90814, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90815, 0, 0, 0, -1, 0, 1, 133, NULL),
        (90818, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90819, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90820, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90821, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90822, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90823, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90824, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90825, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90829, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90830, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90831, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90832, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (90833, 0, 0, 0, -1, 0, 1, 0, '15288'),
        (90835, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90836, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90837, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90839, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90840, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90841, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90842, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90843, 0, 0, 0, -1, 0, 1, 0, '13864'),
        (90846, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90848, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90849, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90851, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90852, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90853, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90855, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90856, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90857, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90858, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90859, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90860, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90861, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90863, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90864, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90865, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90867, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90868, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90869, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90870, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90872, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90874, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90875, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90876, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90877, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90880, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90881, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90882, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90883, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90884, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90885, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90886, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90887, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90888, 0, 0, 0, -1, 0, 1, 10, NULL),
        (90889, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90890, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90892, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90894, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90895, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90896, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90898, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90900, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90905, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90906, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90907, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90912, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90913, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90914, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90915, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90916, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90917, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90918, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (90919, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91010, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91011, 0, 0, 0, -1, 0, 1, 10, NULL),
        (91012, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91013, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91014, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91015, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91016, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91017, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91018, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91019, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91030, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91032, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91033, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91034, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91035, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91036, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91038, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91039, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91040, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91041, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91042, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91043, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91044, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91045, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91046, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91047, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91048, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91049, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91050, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91051, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91052, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91055, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91056, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91057, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91060, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91061, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91062, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91063, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91064, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91065, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91066, 0, 0, 0, -1, 0, 1, 10, NULL),
        (91067, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91068, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91069, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91070, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91071, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91073, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91074, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91075, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91076, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91078, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91079, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91080, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91083, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91085, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91086, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91090, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91093, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91096, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91100, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91101, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91102, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91103, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91104, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (91105, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91106, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91107, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48459, 0, 0, 0, -1, 1, 1, 0, NULL),
        (48460, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48461, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48462, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48463, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48464, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48465, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48466, 0, 0, 0, -1, 1, 1, 0, NULL),
        (48467, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48468, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48470, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48477, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48479, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48563, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48570, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48575, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48585, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48586, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48761, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48762, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48763, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48764, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48765, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48766, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48767, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48768, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48769, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48770, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48772, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48773, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48774, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48775, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48784, 0, 0, 0, -1, 0, 1, 0, ''),
        (48785, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48787, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48790, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48792, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48809, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48810, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48811, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48812, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48813, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48814, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48815, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48816, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48818, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48819, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48820, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48821, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48824, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48825, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48826, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48827, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48829, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48830, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48831, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48832, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48834, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48835, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48836, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48837, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48838, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48839, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48841, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (48842, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (48849, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (48863, 0, 0, 0, -1, 0, 1, 0, '17467'),
        (48870, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48898, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48900, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (48904, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (48906, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48921, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48922, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48923, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48924, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48926, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48937, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48948, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48949, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48950, 0, 0, 0, -1, 1, 1, 0, NULL),
        (48951, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48952, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (48953, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48954, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48955, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48956, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48957, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48958, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48964, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48965, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48967, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48968, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48969, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48970, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48972, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48973, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48974, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (48980, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48981, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48982, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48983, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48986, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48987, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48990, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48991, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48992, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48993, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (48996, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48997, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48998, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (48999, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (49000, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (49001, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (49004, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (49006, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (49008, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91312, 0, 0, 0, -1, 1, 1, 0, NULL),
        (91313, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91314, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91315, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91316, 0, 0, 0, -1, 1, 1, 0, NULL),
        (91317, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91318, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91319, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91320, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91321, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91322, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91328, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91329, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (91333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91336, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (91337, 0, 0, 0, -1, 0, 1, 0, '17151'),
        (91341, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91342, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91344, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91345, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91370, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91371, 0, 0, 0, -1, 1, 1, 0, NULL),
        (91372, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91378, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91380, 0, 0, 0, -1, 0, 1, 0, '16592'),
        (91405, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91406, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91407, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91408, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91409, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91410, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91411, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (91412, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (91413, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91415, 0, 0, 0, -1, 0, 1, 0, '12627'),
        (91416, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91417, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91418, 0, 0, 0, -1, 0, 1, 0, '7942 7940 7743 7941'),
        (91419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91422, 0, 0, 0, -1, 7, 1, 0, NULL),
        (91427, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49051, 5, 0, 0, -1, 8, 1, 0, NULL),
        (49052, 5, 0, 0, -1, 8, 1, 0, NULL),
        (49068, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49069, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49070, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49071, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49072, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49073, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49074, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49075, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49076, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49115, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49123, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49124, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49125, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49127, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49128, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49137, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49138, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49139, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49140, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49143, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49144, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49145, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49146, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49150, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49151, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49153, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49156, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49157, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49158, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49159, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49161, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49186, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49187, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49188, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49190, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49191, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49192, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49259, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49260, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49261, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49262, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49263, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49268, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49269, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49270, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49271, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49272, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49273, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49277, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49278, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49279, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49280, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49281, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49282, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49283, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49284, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49289, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49290, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49291, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49292, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49293, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49294, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49296, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49297, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49298, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49299, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49300, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49311, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49312, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49315, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49316, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49317, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49318, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49319, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49320, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49321, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49322, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49323, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49324, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49325, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49326, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49327, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49328, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49331, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49332, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49333, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49334, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49335, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49336, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49337, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49338, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49339, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49340, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49341, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49342, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49343, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49344, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49345, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49346, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49347, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49348, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49363, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49364, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49365, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49366, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49373, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49374, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49375, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49376, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49383, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49384, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49385, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49387, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49388, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49389, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49390, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49397, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49398, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49402, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49403, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49421, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49573, 5, 0, 0, -1, 0, 1, 10, NULL),
        (49658, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49661, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49662, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49663, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49670, 5, 0, 0, -1, 8, 1, 0, NULL),
        (49672, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49675, 5, 0, 0, -1, 1, 1, 0, NULL),
        (49699, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49700, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49702, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49704, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49716, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49717, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49722, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49723, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49724, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49725, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49726, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49727, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49728, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49729, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49730, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49731, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (49737, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49742, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49752, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49754, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49776, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49777, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49778, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49779, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49780, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49781, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49782, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49783, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49784, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49785, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49786, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49787, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49788, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49789, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49790, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49791, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49792, 5, 0, 0, -1, 0, 1, 333, NULL),
        (49793, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49794, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49795, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49796, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49797, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49798, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49799, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49801, 5, 0, 0, -1, 0, 1, 0, NULL),
        (49802, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49803, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49804, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49805, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49807, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49808, 5, 0, 0, -1, 3, 1, 0, NULL),
        (49809, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51348, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51349, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51350, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51351, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51352, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51355, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51356, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51357, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51358, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51359, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51360, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51361, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51362, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51367, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51368, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51369, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51370, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51371, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51372, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51375, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51381, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51382, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51383, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51384, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51385, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51386, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51397, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51403, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51414, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51415, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51416, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51417, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51421, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51424, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51427, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51430, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51431, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51442, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51443, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51444, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51445, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51446, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51447, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51448, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51449, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51450, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51456, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51457, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51459, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51460, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51461, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51573, 5, 0, 0, -1, 0, 1, 333, NULL),
        (51574, 5, 0, 0, -1, 0, 1, 333, NULL),
        (51578, 5, 0, 0, -1, 0, 1, 333, NULL),
        (51579, 5, 0, 0, -1, 0, 1, 333, NULL),
        (51585, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51586, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51587, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51588, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51589, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51590, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51591, 5, 0, 0, -1, 3, 1, 0, NULL),
        (51592, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51593, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51594, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51595, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51873, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51874, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51880, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51953, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51954, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51963, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (51964, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51965, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51966, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51973, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51974, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51975, 5, 0, 0, -1, 0, 1, 333, NULL),
        (51976, 5, 0, 0, -1, 0, 1, 333, NULL),
        (51985, 5, 0, 0, -1, 0, 1, 0, NULL),
        (51986, 5, 0, 0, -1, 0, 1, 0, NULL),
        (52059, 5, 0, 0, -1, 0, 1, 0, NULL),
        (52104, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91441, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91458, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91477, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91491, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91496, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91512, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91548, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (91549, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (91550, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91551, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (91552, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91553, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91554, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (91555, 5, 0, 0, -1, 0, 1, 0, '18950'),
        (91556, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91557, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91558, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91559, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91560, 5, 0, 0, -1, 0, 1, 0, NULL),
        (91572, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91593, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91600, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91602, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91608, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91613, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91622, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91623, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91624, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91625, 7, 15870, 0, -1, 0, 1, 0, NULL),
        (91626, 7, 15870, 0, -1, 0, 1, 0, NULL),
        (91628, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91629, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91632, 7, 15870, 0, -1, 0, 1, 0, NULL),
        (91633, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91634, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91636, 7, 15870, 0, -1, 0, 1, 0, NULL),
        (91637, 7, 0, 0, -1, 0, 1, 0, NULL),
        (285025, 0, 0, 0, -1, 1, 0, 0, NULL),
        (285024, 0, 0, 0, -1, 1, 0, 0, NULL),
        (190244, 0, 0, 0, -1, 1, 0, 0, NULL),
        (190240, 0, 0, 0, -1, 0, 0, 133, NULL),
        (190239, 0, 0, 0, -1, 0, 0, 133, NULL),
        (190237, 0, 0, 0, -1, 0, 0, 133, NULL),
        (190236, 0, 0, 0, -1, 0, 0, 133, NULL),
        (190199, 0, 0, 0, -1, 0, 0, 22, NULL),
        (190211, 0, 0, 0, -1, 0, 0, 66, NULL),
        (190201, 0, 0, 0, -1, 0, 0, 233, NULL),
        (47164, 0, 0, 0, -1, 0, 0, 234, NULL),
        (91677, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91688, 7, 0, 0, -1, 0, 1, 0, NULL),
        (91689, 7, 15870, 0, -1, 0, 1, 0, NULL),
        (3278, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (3279, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (3331, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3335, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3337, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3339, 0, 0, 0, -1, 1, 1, 0, NULL),
        (3340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3746, 0, 0, 0, -1, 0, 1, 173, NULL),
        (3747, 0, 0, 0, -1, 0, 1, 173, NULL),
        (3748, 0, 0, 0, -1, 0, 1, 173, NULL),
        (3749, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3750, 0, 0, 0, -1, 0, 1, 173, NULL),
        (3751, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3752, 0, 0, 0, -1, 0, 1, 173, NULL),
        (3753, 0, 0, 0, -1, 0, 1, 173, NULL),
        (3754, 0, 0, 0, -1, 0, 1, 173, NULL),
        (4618, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (4620, 0, 0, 0, -1, 1, 1, 0, NULL),
        (4622, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (4623, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (5216, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5217, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5220, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5221, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5222, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5223, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5224, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5225, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5226, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5227, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5228, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5229, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5281, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5285, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (5286, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5315, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5316, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5317, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5318, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5319, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5320, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5321, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5322, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5323, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5362, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (5366, 0, 0, 0, -1, 3, 1, 0, NULL),
        (5367, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (5369, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5375, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5462, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5492, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5493, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5513, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5514, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5515, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5518, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5519, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5525, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5536, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5540, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5543, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5565, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5581, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5582, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5583, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5613, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5614, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5615, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5616, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5628, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5629, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5630, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5641, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5662, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5663, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5664, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5665, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5666, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5669, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5670, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5671, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5672, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5673, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5674, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5675, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5676, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5677, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5679, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5680, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5681, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5682, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5683, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5684, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5685, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5688, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5690, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5692, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5693, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5694, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5697, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5702, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5720, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5744, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5745, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5751, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5774, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5775, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5778, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5779, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5791, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5800, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5801, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5804, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5806, 0, 0, 0, -1, 0, 1, 69, NULL),
        (5807, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5809, 0, 0, 0, -1, 0, 1, 69, NULL),
        (5811, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5813, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5815, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5816, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5817, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5818, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5826, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5830, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5831, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5832, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5835, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5840, 0, 0, 0, -1, 0, 1, 173, NULL),
        (5857, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5860, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5861, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5863, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5864, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5865, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5866, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5867, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5869, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5870, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5871, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5872, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5873, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5874, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5876, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5878, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5879, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5883, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5899, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5901, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5902, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5904, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5905, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5906, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5907, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5911, 0, 0, 0, -1, 0, 1, 0, NULL),
        (5920, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6088, 0, 0, 0, -1, 0, 1, 173, NULL),
        (6089, 0, 0, 0, -1, 0, 1, 173, NULL),
        (6224, 0, 0, 0, -1, 0, 1, 173, NULL),
        (6225, 0, 0, 0, -1, 0, 1, 173, NULL),
        (6243, 0, 0, 0, -1, 0, 1, 173, NULL),
        (6783, 0, 0, 0, -1, 8, 1, 0, NULL),
        (6785, 0, 0, 0, -1, 0, 1, 64, '8734'),
        (6791, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6796, 0, 0, 0, -1, 0, 1, 69, NULL),
        (6800, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6844, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6846, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6847, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6850, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (6851, 0, 0, 0, -1, 8, 1, 0, '8734'),
        (6852, 0, 0, 0, -1, 0, 1, 69, NULL),
        (6853, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6854, 0, 0, 0, -1, 0, 1, 193, '21157'),
        (6855, 0, 0, 0, -1, 0, 1, 69, NULL),
        (6856, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6890, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6891, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6892, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6893, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6894, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6896, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6901, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6902, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6918, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6925, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6930, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6938, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6956, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6962, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (6981, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7022, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7026, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7028, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7049, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7050, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7051, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7052, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7053, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7064, 0, 0, 0, -1, 0, 1, 173, NULL),
        (7065, 0, 0, 0, -1, 0, 1, 173, NULL),
        (7068, 0, 0, 0, -1, 0, 1, 173, NULL),
        (7069, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7071, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7084, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7085, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7086, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7087, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7088, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7118, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7166, 0, 0, 0, -1, 0, 1, 173, NULL),
        (7167, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7187, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7189, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7192, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7219, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7220, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7222, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7223, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7224, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7225, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7226, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7227, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7474, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7682, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7685, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7690, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7714, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7718, 0, 0, 0, -1, 0, 1, 173, NULL),
        (7725, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7726, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7729, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7731, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7732, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7734, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7735, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7736, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7737, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7738, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7743, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7772, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7801, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7802, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7803, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7805, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7808, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (7831, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (7832, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7833, 0, 0, 0, -1, 0, 1, 233, NULL),
        (7840, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (8176, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (8177, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8180, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (8183, 0, 0, 0, -1, 0, 1, 173, NULL),
        (8185, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8186, 0, 0, 0, -1, 0, 1, 173, NULL),
        (8187, 0, 0, 0, -1, 0, 1, 173, NULL),
        (8188, 0, 0, 0, -1, 0, 1, 173, NULL),
        (8189, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (8190, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8191, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (8192, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8193, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (8366, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (8369, 0, 0, 2787, -1, 0, 1, 0, NULL),
        (8789, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (8836, 0, 0, 2784, -1, 0, 1, 0, NULL),
        (300505, 0, 0, 0, -1, 0, 0, 0, ''),
        (9082, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9211, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9216, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9217, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9227, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9362, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9376, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9543, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9544, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9545, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9605, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9607, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9609, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9626, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9627, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9628, 0, 0, 0, -1, 0, 1, 0, '7164'),
        (9675, 0, 0, 0, -1, 0, 1, 0, '7164'),
        (9676, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9686, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9690, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9711, 0, 0, 0, -1, 0, 1, 0, '7164'),
        (9734, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9736, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9738, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9739, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9751, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9753, 0, 0, 0, -1, 0, 1, 0, NULL),
        (9759, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9763, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (9771, 0, 0, 0, -1, 0, 1, 0, '643'),
        (9773, 0, 0, 0, -1, 0, 1, 0, '643'),
        (9785, 0, 0, 0, -1, 0, 1, 0, '643'),
        (9788, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9790, 0, 0, 0, -1, 0, 1, 0, '643'),
        (9796, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9801, 0, 0, 0, -1, 0, 1, 0, '643'),
        (9805, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (9822, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (9823, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (9868, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (9870, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (9874, 0, 0, 0, -1, 0, 1, 0, '8279 7942'),
        (10001, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10002, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10012, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10023, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10040, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10199, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10223, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10262, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10311, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10318, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10489, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10490, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (10543, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10545, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10546, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10571, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10574, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10582, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10584, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10587, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10597, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10599, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10607, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10608, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10615, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10620, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (10624, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10625, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10627, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10631, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10637, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10704, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10714, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10730, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (10756, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10760, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10761, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10762, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10765, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10766, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10768, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10769, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10774, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10776, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10788, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10789, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10790, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10809, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10810, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10811, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10812, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (10920, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10925, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (10928, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (11055, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (11056, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11058, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (11066, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11127, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11205, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11209, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47159, 0, 0, 0, -1, 0, 0, 234, NULL),
        (11212, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11233, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11235, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11236, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11237, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11238, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11240, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11253, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11254, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11256, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11262, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11272, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11293, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11295, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11297, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11346, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11347, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11547, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11550, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11577, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11608, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11612, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11643, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11654, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11656, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11696, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11739, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11742, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11744, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11746, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11812, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (11916, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11917, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11922, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11944, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (11946, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (11950, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11953, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11955, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (11957, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11976, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (12904, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (12910, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (12912, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13251, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13303, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13304, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13310, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13311, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13313, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (13315, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14528, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14535, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14536, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14537, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14541, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14542, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14545, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14546, 0, 0, 0, -1, 8, 1, 0, NULL),
        (14549, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14552, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14556, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14557, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14560, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14564, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (14565, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14566, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (14568, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (14570, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14572, 0, 0, 229, -1, 0, 1, 0, NULL),
        (14574, 0, 0, 2410, -1, 0, 1, 0, NULL),
        (14575, 0, 0, 2410, -1, 0, 1, 0, NULL),
        (14577, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14578, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14586, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14633, 0, 0, 0, -1, 8, 1, 69, NULL),
        (14637, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14639, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14643, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14647, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (14769, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14771, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14791, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14835, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14838, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14842, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14867, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14874, 0, 0, 0, -1, 8, 1, 0, NULL),
        (14875, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14876, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15397, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15398, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15566, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15567, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15568, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15569, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15586, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15695, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15697, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15699, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15733, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15755, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15806, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15807, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15810, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15811, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15812, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15814, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15815, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15816, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15821, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15822, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15858, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15869, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15874, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15897, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15899, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15901, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15907, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15908, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15909, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15911, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15912, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15915, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15916, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15917, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15921, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15922, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15926, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15931, 0, 0, 0, -1, 0, 1, 233, NULL),
        (15954, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15956, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15958, 0, 0, 0, -1, 0, 1, 0, NULL),
        (15960, 0, 0, 0, -1, 0, 1, 173, NULL),
        (15962, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16105, 0, 0, 0, -1, 8, 1, 0, NULL),
        (16113, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16127, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16167, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16179, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16180, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16183, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16583, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16584, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16585, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16586, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16587, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16588, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16589, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16590, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16591, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16592, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16593, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16594, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16595, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16597, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16598, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16603, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16604, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16605, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16606, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16608, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16609, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16610, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16611, 1, 0, 0, -1, 0, 1, 0, NULL),
        (16707, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16709, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16719, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16733, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16735, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16737, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16751, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16754, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16771, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16796, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16863, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16880, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16881, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16882, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16883, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16901, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16962, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16963, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16964, 0, 0, 0, -1, 0, 1, 0, NULL),
        (16985, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16987, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (16991, 3, 0, 0, -1, 0, 1, 0, NULL),
        (17004, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17005, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17006, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17010, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17013, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17017, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17018, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17021, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17028, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17031, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17032, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17044, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17047, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17048, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17051, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17066, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17097, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (17286, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17287, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17600, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19151, 0, 0, 229, -1, 0, 1, 0, NULL),
        (29797, 0, 0, 235, -1, 0, 1, 0, NULL),
        (29810, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (30035, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30038, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (32028, 0, 0, 235, -1, 0, 1, 0, NULL),
        (32072, 2, 0, 0, -1, 0, 1, 0, '18950'),
        (32073, 2, 0, 0, -1, 0, 1, 0, '18950'),
        (32074, 2, 0, 0, -1, 0, 1, 0, '18950'),
        (32075, 6, 0, 0, -1, 0, 1, 0, NULL),
        (37923, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38319, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (38320, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (38322, 0, 0, 0, -1, 0, 1, 0, NULL),
        (38325, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (40168, 0, 0, 0, -1, 0, 1, 0, NULL),
        (44762, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (44771, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (44928, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (44940, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (44964, 0, 0, 0, -1, 0, 1, 0, NULL),
        (44980, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (45326, 0, 0, 0, -1, 0, 1, 0, '8713'),
        (45343, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45344, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45345, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45347, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45348, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45350, 0, 0, 0, -1, 0, 1, 0, '17175'),
        (45351, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45352, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45354, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45356, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45357, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45358, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45360, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45361, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45362, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45364, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45389, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45391, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (45393, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45394, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45395, 0, 0, 0, -1, 0, 1, 0, NULL),
        (45396, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (46609, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46685, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46760, 0, 0, 0, -1, 0, 1, 0, '17175'),
        (46762, 0, 0, 0, -1, 0, 1, 0, '17175'),
        (46763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46786, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46788, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46790, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46791, 0, 0, 0, -1, 0, 1, 233, NULL),
        (46792, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46793, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46794, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46872, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47166, 0, 0, 0, -1, 0, 1, 233, NULL),
        (47167, 0, 0, 0, -1, 0, 1, 233, NULL),
        (47168, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47170, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47171, 0, 0, 0, -1, 0, 1, 233, NULL),
        (47173, 0, 0, 0, -1, 0, 1, 233, NULL),
        (47174, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47892, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47943, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47944, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47977, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47978, 0, 0, 0, -1, 0, 1, 0, NULL),
        (47979, 0, 0, 0, -1, 0, 1, 233, NULL),
        (48189, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48192, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48193, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48196, 0, 0, 0, -1, 0, 1, 233, NULL),
        (48219, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (48474, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48482, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48483, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48484, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48485, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48531, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48532, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48592, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48593, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (48594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48599, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48617, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (48618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48619, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48620, 0, 0, 0, -1, 0, 1, 233, NULL),
        (48621, 0, 0, 0, -1, 0, 1, 0, NULL),
        (48623, 0, 0, 0, -1, 0, 1, 233, NULL),
        (48624, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (48635, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49597, 0, 0, 0, -1, 0, 1, 233, NULL),
        (49598, 0, 0, 0, -1, 0, 1, 233, NULL),
        (49599, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49600, 0, 0, 0, -1, 0, 1, 233, NULL),
        (49990, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49992, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (51323, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51477, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51480, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51743, 0, 0, 0, -1, 0, 1, 233, NULL),
        (51744, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (51745, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (52001, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (52002, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52003, 0, 0, 0, -1, 0, 1, 233, NULL),
        (52006, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52245, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (52247, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (52250, 0, 0, 0, -1, 0, 1, 233, NULL),
        (52252, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52253, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52254, 0, 0, 0, -1, 0, 1, 233, NULL),
        (52498, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52499, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52500, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52501, 0, 0, 0, -1, 0, 1, 233, NULL),
        (52510, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (94490, 8, 0, 0, -1, 0, 1, 0, '27614'),
        (52702, 9, 0, 0, -1, 3, 1, 0, NULL),
        (52849, 9, 0, 0, -1, 3, 1, 0, NULL),
        (52884, 9, 0, 0, -1, 1, 1, 0, NULL),
        (52968, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53038, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53169, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53174, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53738, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53739, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53742, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (53743, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (53855, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (53867, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53897, 9, 0, 0, -1, 0, 1, 0, NULL),
        (53898, 9, 0, 0, -1, 0, 1, 69, NULL),
        (54017, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54025, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54035, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54109, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54192, 9, 0, 0, -1, 5, 1, 0, NULL),
        (54193, 9, 0, 0, -1, 5, 1, 0, NULL),
        (54194, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54195, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54196, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54197, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54198, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54199, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54209, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54254, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54255, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54256, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54264, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54265, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54266, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54267, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (54269, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54277, 0, 0, 0, -1, 0, 1, 0, ''),
        (54594, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (54624, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (54748, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (54759, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54760, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54761, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54766, 9, 0, 0, -1, 5, 1, 0, NULL),
        (54807, 9, 0, 0, -1, 5, 1, 0, NULL),
        (54809, 8, 0, 0, -1, 0, 1, 0, NULL),
        (54859, 8, 0, 0, -1, 0, 1, 0, NULL),
        (55363, 8, 0, 0, -1, 0, 1, 0, NULL),
        (56312, 8, 0, 0, -1, 0, 1, 0, NULL),
        (56313, 8, 0, 0, -1, 0, 1, 0, NULL),
        (56318, 8, 0, 0, -1, 0, 1, 0, NULL),
        (56319, 0, 0, 0, -1, 0, 1, 0, NULL),
        (56321, 0, 0, 0, -1, 0, 1, 0, NULL),
        (56554, 0, 0, 0, -1, 0, 1, 0, NULL),
        (56645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (56663, 0, 0, 0, -1, 0, 1, 0, NULL),
        (56694, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (56696, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (64959, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (69683, 0, 0, 0, -1, 0, 1, 0, NULL),
        (69684, 0, 0, 0, -1, 0, 1, 0, NULL),
        (69685, 0, 0, 0, -1, 0, 1, 0, NULL),
        (69686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (69687, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (69690, 0, 0, 0, -1, 0, 1, 0, NULL),
        (69691, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (69702, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (69704, 0, 0, 0, -1, 0, 1, 0, NULL),
        (69707, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (69710, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (78682, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84364, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84367, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84783, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (84784, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (84798, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84799, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84813, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84814, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84823, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84943, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84946, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84955, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (84963, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (84964, 0, 0, 0, -1, 0, 1, 0, NULL),
        (85490, 0, 0, 0, -1, 0, 1, 0, NULL),
        (85491, 0, 0, 0, -1, 0, 1, 0, NULL),
        (85494, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (85495, 0, 0, 0, -1, 0, 1, 0, NULL),
        (85507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86192, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86294, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86295, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86399, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86403, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86404, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86414, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (86864, 0, 0, 0, -1, 0, 1, 0, NULL),
        (86865, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90488, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (90955, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (90958, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90967, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90968, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91709, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91802, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91833, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91847, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91852, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91859, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91867, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91873, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91894, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91901, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91909, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91921, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91922, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91929, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91931, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (91940, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91943, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91945, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91946, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91954, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91956, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91959, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91962, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91963, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91964, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91965, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91966, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (91970, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91973, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91978, 0, 0, 0, -1, 0, 1, 0, NULL),
        (91980, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92006, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92009, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (92012, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (92013, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (92015, 0, 0, 0, -1, 0, 1, 0, '14775'),
        (92023, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92025, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92026, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92034, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92035, 8, 0, 0, -1, 0, 1, 0, NULL),
        (92038, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92040, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92042, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92043, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92044, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92046, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92047, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92050, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92051, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92054, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92057, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92062, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92068, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92071, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92124, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (92140, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (92144, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92147, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92149, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92164, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92165, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92168, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92172, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92177, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (92178, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92181, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92187, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92188, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92190, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92192, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92193, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92204, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (92206, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92213, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92223, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92229, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92235, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (92238, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92239, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92241, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92242, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92243, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92256, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (92264, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (92267, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92269, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92271, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92272, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92274, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92275, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92278, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92279, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92283, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92321, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92322, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (92324, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (92326, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92327, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92328, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92329, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92330, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (92333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92334, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92335, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92342, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92343, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92344, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92371, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92386, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92387, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92388, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92390, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92392, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92393, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92394, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92395, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92397, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92398, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92399, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92401, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92402, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92403, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92404, 0, 0, 0, -1, 8, 1, 0, NULL),
        (92405, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92406, 0, 0, 0, -1, 8, 1, 0, NULL),
        (92408, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92410, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92411, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92412, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92413, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92415, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92416, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92417, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92424, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92427, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92428, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92429, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92430, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92433, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92434, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (92435, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92436, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (92437, 0, 0, 0, -1, 8, 1, 0, NULL),
        (92438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92439, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92440, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92441, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92442, 0, 0, 0, -1, 8, 1, 0, NULL),
        (92443, 0, 0, 0, -1, 8, 1, 0, NULL),
        (92444, 0, 0, 0, -1, 8, 1, 0, '18100'),
        (92445, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92446, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92447, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92448, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92449, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92450, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92451, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92452, 0, 0, 0, -1, 0, 1, 0, '18100'),
        (92453, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92454, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92459, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92462, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92464, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92466, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92469, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92495, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92500, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92513, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (92518, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (92563, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92636, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92640, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92665, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (92670, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (92671, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (92682, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92684, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92685, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92687, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92689, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92690, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92695, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92697, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92698, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92700, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92707, 0, 0, 0, -1, 0, 1, 0, '16577'),
        (92710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92780, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92782, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92783, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92784, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92785, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92786, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92790, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92813, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92835, 0, 0, 0, -1, 0, 1, 0, NULL),
        (92966, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (92976, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (92981, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (92985, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (92988, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (92991, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93004, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93018, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93020, 0, 0, 0, -1, 0, 1, 0, NULL),
        (93025, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93027, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93058, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93074, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93080, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93082, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93084, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93085, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93089, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93090, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93092, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93093, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93098, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93103, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93108, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93110, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93116, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93118, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93121, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93146, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93147, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93149, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93150, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93151, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93152, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93182, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93197, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93243, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93298, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93299, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93300, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93310, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93311, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93350, 0, 0, 0, -1, 0, 1, 0, NULL),
        (93351, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (93450, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93592, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93596, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93597, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93613, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93614, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93625, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93630, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93653, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93676, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93680, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (93688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (93691, 0, 0, 0, -1, 0, 1, 0, NULL),
        (93707, 0, 0, 0, -1, 0, 1, 0, '5916'),
        (93723, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79522, 0, 0, 0, -1, 3, 1, 0, NULL),
        (79550, 0, 0, 0, -1, 3, 1, 0, NULL),
        (79558, 0, 0, 0, -1, 1, 1, 0, NULL),
        (79580, 0, 0, 0, -1, 3, 1, 0, NULL),
        (3382, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3383, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3384, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3385, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3386, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3387, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3388, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3389, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3390, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3391, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3392, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3462, 0, 0, 0, -1, 0, 1, 0, NULL),
        (3465, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4702, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4705, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4706, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4729, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4730, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4731, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4732, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4733, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4734, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4735, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4736, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4737, 0, 0, 0, -1, 0, 1, 0, NULL),
        (4738, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6417, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6418, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6420, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6422, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6423, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6424, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6425, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6426, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6427, 0, 0, 0, -1, 8, 1, 0, NULL),
        (6428, 0, 0, 0, -1, 1, 1, 0, NULL),
        (6429, 0, 0, 0, -1, 3, 1, 0, NULL),
        (6430, 0, 0, 0, -1, 3, 1, 0, NULL),
        (6431, 0, 0, 0, -1, 8, 1, 0, NULL),
        (6432, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6466, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6467, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6481, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6488, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6489, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6494, 1, 0, 0, -1, 0, 1, 0, '18950'),
        (6495, 1, 0, 0, -1, 0, 1, 0, '18950'),
        (6496, 1, 0, 0, -1, 0, 1, 0, '18950'),
        (6505, 6, 0, 0, -1, 0, 1, 0, NULL),
        (6523, 0, 0, 0, -1, 0, 0, 0, ''),
        (6524, 0, 0, 0, -1, 0, 0, 0, ''),
        (6525, 0, 0, 0, -1, 0, 0, 0, ''),
        (6526, 0, 0, 0, -1, 0, 0, 0, ''),
        (6527, 0, 0, 0, -1, 0, 0, 0, ''),
        (6558, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6559, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6560, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6561, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6562, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6563, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6564, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6565, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6566, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6567, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6568, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6642, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6643, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6644, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6646, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6667, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6668, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6669, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6670, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6671, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6672, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6673, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6674, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6675, 0, 0, 0, -1, 0, 1, 0, NULL),
        (6676, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7334, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7335, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7336, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7337, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7338, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7339, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7342, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7360, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7361, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7366, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7369, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7370, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7372, 0, 0, 0, -1, 0, 0, 0, ''),
        (7373, 0, 0, 0, -1, 0, 0, 0, ''),
        (7374, 0, 0, 0, -1, 0, 0, 0, ''),
        (7375, 0, 0, 0, -1, 0, 0, 0, ''),
        (7376, 0, 0, 0, -1, 0, 0, 0, ''),
        (7397, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7398, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7399, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7415, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7416, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7417, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7418, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7420, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7509, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7572, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7573, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7574, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7576, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7577, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7578, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7579, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7580, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7581, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7880, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7882, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7883, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7884, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7885, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7897, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7898, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7899, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7900, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7901, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7921, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7922, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7923, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7941, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7942, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7943, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7945, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7946, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7948, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7949, 0, 0, 0, -1, 0, 1, 0, NULL),
        (7950, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8006, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8007, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8008, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8009, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8010, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8011, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8012, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8013, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8318, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8428, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8429, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8521, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8522, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8523, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8524, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8525, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8528, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8529, 0, 0, 0, -1, 0, 1, 0, NULL),
        (8530, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10284, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10285, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10286, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10297, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10298, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10299, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10347, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10348, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10350, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10351, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10352, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10353, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10432, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10434, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10436, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10439, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10450, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10462, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10463, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10464, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10465, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10466, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10467, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10468, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10469, 0, 0, 0, -1, 0, 1, 0, NULL),
        (10470, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11774, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11778, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11781, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11782, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11789, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11790, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11791, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11792, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11793, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11794, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11795, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11796, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11852, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11853, 0, 0, 0, -1, 0, 1, 0, NULL),
        (11855, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12068, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12086, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12116, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12120, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12130, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12134, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12136, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12139, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12144, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12148, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12149, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12151, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12153, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12169, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12192, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12193, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12194, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12221, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12229, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12237, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12248, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12290, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12355, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12359, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12368, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12370, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12371, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12386, 0, 0, 0, -1, 0, 1, 0, NULL),
        (12395, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13013, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13055, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13056, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13057, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13058, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13059, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13060, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13062, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13063, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13064, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13065, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13067, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13070, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13073, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13076, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13080, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13177, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13581, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13582, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13583, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13584, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13585, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13590, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13592, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13594, 0, 0, 0, -1, 0, 1, 0, '7164'),
        (13598, 0, 0, 0, -1, 0, 1, 0, '7164'),
        (13599, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13600, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13602, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13603, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13604, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13605, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13607, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13608, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13609, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13610, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13611, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13612, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13613, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13615, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13617, 0, 0, 0, -1, 0, 1, 173, NULL),
        (13692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13693, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13695, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13697, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13698, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13699, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13700, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13751, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13752, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13753, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13754, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13756, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13757, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13759, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13761, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13762, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13763, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13764, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13765, 0, 0, 0, -1, 1, 1, 0, NULL),
        (13769, 0, 0, 0, -1, 0, 1, 233, NULL),
        (13770, 0, 0, 0, -1, 0, 1, 69, NULL),
        (13772, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13773, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13775, 0, 0, 0, -1, 0, 1, 0, NULL),
        (13776, 0, 0, 0, -1, 0, 1, 69, NULL),
        (14078, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14079, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14080, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14081, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14082, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14083, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14084, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14085, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14086, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14087, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14088, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14089, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14090, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14091, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14092, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14093, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14094, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14095, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14096, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14097, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14098, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14099, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14100, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14101, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14102, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14103, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14104, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14105, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14106, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14107, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14108, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14109, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14110, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14111, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14112, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14113, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14114, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14115, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14116, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14117, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14118, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14119, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14120, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14121, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14122, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14123, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14124, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14125, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14126, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14128, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14129, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14130, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14131, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14132, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14133, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14134, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14135, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14148, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14149, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14150, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14151, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14154, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14159, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14160, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14164, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14166, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14167, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14168, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14170, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14174, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14175, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14178, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14179, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14183, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14184, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14187, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14189, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14190, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14191, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14195, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14198, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14200, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14201, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14204, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14205, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14209, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14211, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14214, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14215, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14217, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14218, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14219, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14220, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14221, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14224, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14225, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14226, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14228, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14230, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14234, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14247, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14248, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14249, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14253, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14256, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14259, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14260, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14261, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14262, 0, 0, 0, -1, 3, 1, 0, NULL),
        (14323, 9, 0, 0, -1, 0, 1, 0, NULL),
        (15145, 0, 0, 9991, -1, 0, 1, 0, NULL),
        (15169, 0, 0, 6080, -1, 0, 1, 0, NULL),
        (15246, 0, 0, 9991, -1, 0, 1, 0, NULL),
        (17433, 0, 0, 2410, -1, 0, 1, 0, NULL),
        (17438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17439, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17441, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17442, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17443, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17444, 0, 0, 0, -1, 0, 1, 0, NULL),
        (17445, 0, 0, 0, -1, 3, 1, 0, NULL),
        (18669, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18670, 0, 0, 0, -1, 3, 1, 0, NULL),
        (18671, 0, 0, 0, -1, 3, 1, 0, NULL),
        (18672, 0, 0, 0, -1, 3, 1, 0, NULL),
        (18673, 0, 0, 0, -1, 3, 1, 0, NULL),
        (18674, 0, 0, 0, -1, 3, 1, 0, NULL),
        (19221, 0, 0, 0, -1, 7, 1, 0, NULL),
        (19325, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19326, 0, 0, 0, -1, 3, 1, 0, NULL),
        (19340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19352, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19353, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19354, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19355, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19356, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19357, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19358, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19359, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19360, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19361, 0, 0, 0, -1, 1, 1, 0, NULL),
        (19362, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19379, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19380, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19381, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19382, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19383, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19384, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19385, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19386, 0, 0, 0, -1, 1, 1, 0, NULL),
        (19387, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19399, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19400, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19401, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19402, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19403, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19411, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19412, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19413, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19414, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19415, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19422, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19423, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19424, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19425, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19428, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19429, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19430, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19432, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19433, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (19464, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20249, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20250, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20251, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20252, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20253, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20254, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20255, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20256, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20257, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20258, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20259, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20260, 0, 0, 0, -1, 0, 1, 0, '7966'),
        (20261, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20262, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20263, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20264, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20265, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20266, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20267, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20269, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20270, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20271, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20272, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20273, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20274, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20275, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20276, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20277, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20278, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20279, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20280, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20281, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20282, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20283, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20284, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20285, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20286, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20287, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20288, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20289, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20290, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20291, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20292, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20293, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20294, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20295, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20296, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20300, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20310, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20311, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20312, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20313, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20314, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20315, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20316, 0, 0, 0, -1, 0, 1, 0, '7966'),
        (20317, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20318, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20319, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20320, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20321, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20322, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20323, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20324, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20325, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20326, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20327, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20328, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20329, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20330, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20331, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20332, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20334, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20335, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20336, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20337, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20338, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20339, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20340, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20342, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20343, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20344, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20345, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20346, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20347, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20348, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20349, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20350, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20351, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20352, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20353, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20354, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20355, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20356, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20357, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20358, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20359, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (20360, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20361, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20362, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20364, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20366, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20367, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20368, 0, 0, 0, -1, 0, 1, 0, '7966'),
        (20369, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20370, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20371, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20372, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20373, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20374, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20375, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20376, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20970, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20971, 0, 0, 0, -1, 0, 1, 0, NULL),
        (20972, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21079, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21080, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21081, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21082, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21083, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21084, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21085, 0, 0, 0, -1, 8, 1, 0, NULL),
        (21086, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21087, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21088, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21089, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21090, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21091, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21092, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21093, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21094, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21095, 0, 0, 0, -1, 8, 1, 0, NULL),
        (21096, 0, 0, 0, -1, 8, 1, 0, NULL),
        (21097, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21104, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21105, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21106, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21107, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21108, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21109, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21110, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21111, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21112, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21113, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21114, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21115, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21116, 0, 0, 0, -1, 8, 1, 0, NULL),
        (51789, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51788, 0, 0, 0, -1, 0, 1, 0, NULL),
        (300232, 0, 0, 0, -1, 0, 1, 0, '8279 7941'),
        (21163, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21164, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21165, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21166, 0, 0, 0, -1, 0, 1, 28, NULL),
        (21168, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21169, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21170, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21171, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21172, 0, 0, 0, -1, 0, 1, 28, NULL),
        (21173, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21174, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21175, 0, 0, 0, -1, 0, 1, 28, NULL),
        (21176, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21177, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21301, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21753, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21754, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21755, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21756, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21757, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21758, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21759, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21760, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21761, 0, 0, 0, -1, 3, 1, 0, NULL),
        (21762, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21764, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21765, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21766, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21767, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21768, 0, 0, 0, -1, 3, 1, 0, NULL),
        (21769, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21770, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21771, 0, 0, 0, -1, 0, 1, 0, NULL),
        (21774, 0, 0, 0, -1, 0, 1, 0, '8279'),
        (22247, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22248, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22249, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22250, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22251, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22252, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22253, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22254, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22255, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22256, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22257, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22258, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22259, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22260, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22261, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22262, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22263, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22264, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22265, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22266, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22267, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22268, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22269, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22270, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22271, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22272, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22279, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22280, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22281, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22282, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22283, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22284, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22285, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22286, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22287, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22288, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22289, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22290, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22291, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22292, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22293, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22294, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22295, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22296, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22297, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22298, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22299, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22300, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22301, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22302, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22303, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22304, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22305, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22306, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22309, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22310, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22311, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22312, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22313, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22314, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22315, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22316, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22317, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22319, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22320, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22321, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22322, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22323, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22324, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22325, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22326, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22327, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22328, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22329, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22330, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22331, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22339, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22342, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22343, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22344, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22345, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22346, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22347, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22348, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22349, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22350, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22351, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22352, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22353, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22354, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22355, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22356, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22357, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22358, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22359, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22360, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22361, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22362, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22424, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22425, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22426, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22427, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22428, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22429, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22430, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22431, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22432, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22433, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22434, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22435, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22436, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22437, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22439, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22440, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22441, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22442, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22443, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22444, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22445, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22446, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22447, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22448, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22449, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22450, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22452, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22453, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22454, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22455, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22456, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22457, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22458, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22459, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22460, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22461, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22462, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22463, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22464, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22465, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22466, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22467, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22468, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22469, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22470, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22471, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22472, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22474, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22475, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22476, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22477, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22478, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22479, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22480, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22481, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22482, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22483, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22484, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22485, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22486, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22487, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22488, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22489, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22490, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22492, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22493, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22494, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22495, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22496, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22497, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22498, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22499, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22500, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22501, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22502, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22503, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22504, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22506, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22509, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22510, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22512, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22513, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22514, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22515, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22516, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22517, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22518, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22519, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22520, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22521, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22522, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22523, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22524, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22525, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22528, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22529, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22530, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22531, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22532, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22533, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22534, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22535, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22536, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22537, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22538, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22539, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22540, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22541, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22542, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22543, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22544, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22545, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22546, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22547, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22548, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22549, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22550, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22551, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22552, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22553, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22554, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22555, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22556, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22557, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22558, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22559, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22560, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22561, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22562, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22564, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22565, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22566, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22567, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22568, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22569, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22570, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22571, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22572, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22573, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22574, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22575, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22576, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22577, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22578, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22579, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22580, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22581, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22582, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22583, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22584, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22585, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22586, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22587, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22590, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22591, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22592, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22597, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22598, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22599, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22601, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22602, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22603, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22604, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22605, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22607, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22608, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22609, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22610, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22611, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22612, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22613, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22615, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22619, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22620, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22621, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22622, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22623, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22624, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22625, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22626, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22627, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22628, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22629, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22631, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22632, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22633, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22634, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22636, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22637, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22638, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22639, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22640, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22641, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22642, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22643, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22644, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22646, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22647, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22648, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22651, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22652, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22653, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22655, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22657, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22658, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22659, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22660, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22661, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22682, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22683, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22684, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22685, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22687, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22689, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22690, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22691, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22693, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22695, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22697, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22698, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22699, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22700, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22702, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22703, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22704, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22705, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22706, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22707, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22708, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22709, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22711, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22712, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22713, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22714, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22715, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22716, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22717, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22718, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22719, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22720, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22721, 0, 0, 0, -1, 0, 1, 0, NULL),
        (22722, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23290, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23291, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23292, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23293, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23294, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23295, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23296, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23297, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23298, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23299, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23300, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23301, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23302, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23303, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23304, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23305, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23306, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23307, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23308, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23309, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23310, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23311, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23312, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23313, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23314, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23315, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23316, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23317, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23318, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23319, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23320, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23321, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23322, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23323, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23324, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23325, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23326, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23327, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23328, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23329, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23330, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23331, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23332, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23334, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23335, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23336, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23337, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23338, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23339, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23340, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23341, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23342, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23343, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23344, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23345, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23346, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23347, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23348, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23349, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23350, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23351, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23352, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23353, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23354, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23356, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23357, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23358, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23359, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23360, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23361, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23362, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23363, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23364, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23365, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23366, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23367, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23368, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23369, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23370, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23371, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23372, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23373, 0, 0, 0, -1, 0, 1, 234, NULL),
        (23375, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23376, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23377, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23378, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23379, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23380, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23381, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23382, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23383, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23384, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23385, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23386, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23387, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23388, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23389, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23390, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23391, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23392, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23393, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23394, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23395, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23396, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23397, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23398, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23399, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23400, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23401, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23402, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23403, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23404, 0, 0, 0, -1, 0, 1, 0, NULL),
        (23405, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89362, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (89361, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (89360, 6, 0, 0, -1, 0, 1, 0, '26240'),
        (89359, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (24077, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24078, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24079, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24080, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24081, 0, 0, 0, -1, 7, 1, 0, NULL),
        (24088, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24089, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24090, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24091, 0, 0, 0, -1, 0, 1, 0, NULL),
        (18614, 7, 0, 0, -1, 3, 1, 0, ''),
        (89402, 6, 0, 0, -1, 0, 1, 0, '26246'),
        (26363, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26364, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26365, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26367, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26368, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26369, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26370, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26371, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26372, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26373, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26374, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26375, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26376, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26377, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26378, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26379, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26380, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26381, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26382, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26383, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26384, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26385, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26386, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26387, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26388, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26389, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26390, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26391, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26392, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26393, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26394, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26395, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26396, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26397, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26398, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26399, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26400, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26401, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26402, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26403, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26404, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26405, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26406, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26407, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26408, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26409, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26410, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26411, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26412, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26413, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26414, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26415, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26416, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26417, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26418, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26420, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26422, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26423, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26424, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26425, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26426, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26427, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26428, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26429, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26430, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26431, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26432, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26433, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26434, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26435, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26436, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26437, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26438, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26439, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26440, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26441, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26442, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26443, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26444, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26445, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26446, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26447, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26448, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26449, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26450, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26451, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26452, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26453, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26454, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26455, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26456, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26457, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26458, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26459, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26460, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26461, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26462, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26463, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26464, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26465, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26466, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26467, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26468, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26469, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26470, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26471, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26472, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26473, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26474, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26475, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26476, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26477, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26478, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26479, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26480, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26481, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26482, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26483, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26484, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26485, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26486, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26487, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26488, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26489, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26490, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26584, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26585, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26586, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26587, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26589, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26590, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26591, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26592, 0, 0, 0, -1, 0, 1, 233, NULL),
        (26593, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26597, 0, 0, 0, -1, 0, 1, 0, NULL),
        (26901, 6, 0, 0, -1, 0, 1, 0, NULL),
        (27103, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27104, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27105, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27106, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (27107, 0, 0, 0, -1, 0, 1, 0, '8788'),
        (27108, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27109, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27110, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27111, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27112, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27607, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27608, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27609, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27610, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27611, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27612, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27613, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27615, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27617, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27619, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27620, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27621, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27622, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27623, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27624, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27625, 0, 0, 0, -1, 0, 1, 27, '12380'),
        (27626, 0, 0, 0, -1, 0, 1, 27, '12380'),
        (27627, 0, 0, 0, -1, 0, 1, 27, '12380'),
        (27628, 0, 0, 0, -1, 0, 1, 27, NULL),
        (27629, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27657, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27658, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27668, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27672, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27673, 0, 0, 0, -1, 8, 1, 0, NULL),
        (27674, 0, 0, 0, -1, 8, 1, 0, NULL),
        (27675, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (27676, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27678, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27681, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (27682, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27683, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (27684, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (27685, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (27686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27687, 0, 0, 0, -1, 0, 1, 0, NULL),
        (27688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (84036, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (84034, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (84031, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (28530, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28531, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28715, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28716, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28717, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28718, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28719, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28720, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28721, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28722, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (28723, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29093, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29094, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29095, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29097, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29098, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29100, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29101, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29217, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29218, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29219, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29220, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29221, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29222, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29223, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29224, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29225, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29226, 0, 0, 0, -1, 1, 1, 0, NULL),
        (29227, 0, 0, 0, -1, 1, 1, 0, NULL),
        (29228, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29229, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29230, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29231, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29232, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29243, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29587, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29596, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29597, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29598, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29599, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29600, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29601, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29602, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29603, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29604, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29605, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29606, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29607, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29608, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29609, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29610, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29611, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29612, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29613, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29615, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29616, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29617, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29618, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29619, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29620, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29621, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29622, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29623, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29624, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29625, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29626, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29627, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29628, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29629, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29631, 0, 0, 0, -1, 0, 1, 0, NULL),
        (29632, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29633, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29634, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29635, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29636, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29637, 0, 0, 0, -1, 0, 1, 233, NULL),
        (29638, 0, 0, 0, -1, 0, 1, 233, NULL),
        (32216, 0, 0, 0, -1, 3, 1, 0, NULL),
        (32217, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32218, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32219, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32220, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32221, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32222, 0, 0, 0, -1, 3, 1, 0, NULL),
        (32223, 0, 0, 0, -1, 3, 1, 0, NULL),
        (32224, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32225, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32226, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32227, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32228, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32229, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32230, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32231, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32255, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32256, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32257, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32258, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32259, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32260, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32261, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32262, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32263, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32264, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32265, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32266, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32267, 0, 0, 0, -1, 3, 1, 0, NULL),
        (32268, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32269, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32270, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32271, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32272, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32348, 0, 0, 0, -1, 7, 1, 0, NULL),
        (32352, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32353, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32354, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32355, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32356, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32357, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32358, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32359, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32360, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32361, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32362, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32363, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32364, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32365, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32366, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32367, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32368, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32369, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32370, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32371, 0, 0, 0, -1, 0, 1, 0, '20540'),
        (32438, 0, 0, 0, -1, 7, 1, 0, NULL),
        (32440, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32441, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32442, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32443, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32444, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32445, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32446, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32447, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32448, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (32449, 0, 0, 0, -1, 0, 1, 0, NULL),
        (32450, 0, 0, 0, -1, 0, 1, 0, NULL),
        (136154, 1, 0, 0, -1, 1, 1, 0, NULL),
        (136150, 1, 0, 0, -1, 1, 1, 0, NULL),
        (136159, 1, 0, 0, -1, 1, 1, 0, NULL),
        (136157, 1, 0, 0, -1, 1, 1, 0, NULL),
        (57808, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (57025, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (57000, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (56998, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (56967, 1, 0, 0, -1, 0, 1, 0, '22766'),
        (34185, 0, 0, 0, -1, 0, 1, 0, '7090'),
        (34186, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34187, 0, 0, 0, -1, 0, 1, 0, '7090'),
        (34188, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34189, 0, 0, 0, -1, 0, 1, 0, '7090'),
        (34190, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34191, 0, 0, 0, -1, 0, 1, 0, '7090'),
        (34192, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34504, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34506, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34509, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34510, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34512, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34513, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34514, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34525, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34528, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34529, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34530, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34531, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34532, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34533, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34534, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34535, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34536, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34537, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34538, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34539, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34540, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34541, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34542, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34543, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34544, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34545, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34546, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34547, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34548, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34549, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34550, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34551, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34552, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34553, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34554, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34555, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34556, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34557, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34558, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34559, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34560, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34561, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34562, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34563, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34564, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34565, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34566, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34567, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34568, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34569, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34570, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34571, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34572, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34573, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34574, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34575, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34576, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34577, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34578, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34579, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34580, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34595, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34597, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34598, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34599, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34600, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34601, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34603, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34604, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34605, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34606, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34607, 0, 0, 0, -1, 0, 1, 0, NULL),
        (34608, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35899, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35900, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35901, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35902, 0, 0, 0, -1, 7, 1, 0, NULL),
        (35903, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35904, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35905, 0, 0, 0, -1, 0, 1, 0, NULL),
        (35906, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36168, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36169, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36170, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36171, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36172, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36173, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36174, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36175, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36176, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36177, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (36499, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36500, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36501, 0, 0, 0, -1, 0, 1, 0, '12550'),
        (36502, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36503, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36504, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36506, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36509, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36510, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36512, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36513, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36514, 0, 0, 0, -1, 0, 1, 0, '12550'),
        (36515, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36516, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36517, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36518, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36627, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36628, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36629, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36631, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36632, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36633, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36634, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36635, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36636, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36637, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36638, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36639, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36640, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36641, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36642, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36643, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36644, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36646, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36647, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36648, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36649, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36650, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36651, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36652, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36653, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36654, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36655, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36656, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36657, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36658, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36659, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36660, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36661, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36662, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36663, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36664, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36665, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36666, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36667, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36668, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36669, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36670, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36671, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36672, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36673, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36674, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36675, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36676, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36677, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36678, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36679, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36680, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36681, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36682, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36683, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36684, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36685, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36686, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36687, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36689, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36690, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36691, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36695, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36696, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36697, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36698, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36699, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36700, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36702, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36703, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36704, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36705, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36706, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36707, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36708, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36709, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36710, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36711, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36712, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36713, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36714, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36715, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36716, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36717, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36718, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36719, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36720, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36721, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36722, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36723, 0, 0, 0, -1, 0, 1, 0, NULL),
        (36724, 0, 0, 0, -1, 0, 1, 0, NULL),
        (37077, 0, 0, 0, -1, 0, 1, 0, NULL),
        (37081, 0, 0, 0, -1, 0, 1, 0, NULL),
        (37325, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37326, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37327, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37328, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37329, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37330, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37331, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37332, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37333, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37334, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37335, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37336, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37337, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37338, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37339, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37340, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37341, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37342, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37343, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37344, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37345, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37346, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37347, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37348, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37349, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37350, 0, 0, 0, -1, 0, 1, 0, NULL),
        (37351, 0, 0, 0, -1, 0, 1, 0, '7165'),
        (37954, 0, 0, 0, -1, 0, 1, 233, NULL),
        (39097, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39107, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39124, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39150, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39162, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39169, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39171, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39182, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39193, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39217, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39224, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39225, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39235, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39236, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39334, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39337, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39404, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39492, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39495, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39502, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39503, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39504, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39509, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39626, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39630, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39633, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39636, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39680, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (39687, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39692, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39693, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39695, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39698, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39700, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39702, 0, 0, 0, -1, 0, 1, 0, NULL),
        (39711, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40410, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40418, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40429, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40438, 0, 0, 0, -1, 0, 1, 0, '8699'),
        (40441, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40442, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40443, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40588, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40589, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40609, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40614, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40622, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40641, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40650, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40654, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40659, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (40661, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (40665, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (40669, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40670, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40673, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40676, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40683, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40688, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40694, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40701, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40705, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40746, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40771, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40777, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40803, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40805, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40808, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40814, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40815, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40817, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40818, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40821, 0, 0, 0, -1, 0, 1, 0, NULL),
        (40838, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40839, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40840, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40841, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40842, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40843, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40844, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40845, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40846, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40847, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40848, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40849, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40850, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40851, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40852, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40853, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40854, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40855, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40856, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40857, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40858, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40859, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40860, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40861, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40862, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40863, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40864, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (40910, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (40943, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (40944, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (40946, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (40947, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (40948, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (40949, 0, 0, 0, -1, 0, 1, 0, '6408'),
        (41473, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41474, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41475, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41476, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41477, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41478, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41479, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41480, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41481, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41482, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41483, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41484, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41485, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41486, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41487, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41488, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41489, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41490, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41491, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41492, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41493, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41494, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41495, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41496, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41497, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41498, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41499, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41500, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41501, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41502, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41503, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41504, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41505, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41506, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41507, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41509, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41510, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41511, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41512, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41513, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41514, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41515, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41516, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41517, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41518, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41520, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41521, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41522, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41523, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41524, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41525, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41526, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41527, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41528, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41529, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41530, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41531, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41533, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41534, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41535, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41536, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41537, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41538, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41539, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41540, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41541, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41542, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41543, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41544, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41545, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41546, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41547, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41548, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41549, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41550, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41551, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41552, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41553, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41554, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41555, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41763, 0, 0, 0, -1, 0, 1, 0, NULL),
        (41765, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42305, 0, 0, 0, -1, 0, 1, 0, '7940'),
        (190242, 0, 0, 0, -1, 0, 1, 10, '18950'),
        (42945, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42946, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42947, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42948, 0, 0, 0, -1, 3, 1, 0, NULL),
        (42949, 0, 0, 0, -1, 0, 1, 69, NULL),
        (42950, 0, 0, 0, -1, 0, 1, 69, NULL),
        (42951, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42952, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42953, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42954, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42955, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42956, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42957, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42958, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42959, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42960, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42961, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42962, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42963, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42964, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42965, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42966, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42967, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42969, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42970, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42971, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42972, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42973, 0, 0, 0, -1, 0, 1, 69, NULL),
        (42974, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42975, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42976, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42977, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42978, 0, 0, 0, -1, 0, 1, 69, NULL),
        (42979, 0, 0, 0, -1, 0, 1, 69, NULL),
        (42980, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42981, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42982, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42983, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42984, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42985, 0, 0, 0, -1, 1, 1, 0, NULL),
        (42986, 0, 0, 0, -1, 0, 1, 69, NULL),
        (42987, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42988, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42989, 0, 0, 0, -1, 3, 1, 0, NULL),
        (42990, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42991, 0, 0, 0, -1, 3, 1, 0, NULL),
        (42992, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42993, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42994, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42995, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42996, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42997, 0, 0, 0, -1, 0, 1, 0, NULL),
        (42998, 0, 0, 0, -1, 3, 1, 0, NULL),
        (42999, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43000, 0, 0, 0, -1, 1, 1, 0, NULL),
        (43001, 0, 0, 0, -1, 1, 1, 0, NULL),
        (43002, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43003, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43004, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43005, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43006, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43007, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43008, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43009, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43010, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43011, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43012, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43013, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43014, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43015, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43016, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43017, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43018, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43019, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43020, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43021, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43022, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43023, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43024, 0, 0, 0, -1, 1, 1, 0, NULL),
        (43025, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43026, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43027, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43028, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43029, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43030, 0, 0, 0, -1, 1, 1, 0, NULL),
        (43031, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43032, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43033, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43034, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43035, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43036, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43037, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43038, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43039, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43040, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43041, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43042, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43043, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43078, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43079, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43080, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43081, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43082, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43083, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43084, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43085, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43086, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43087, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43088, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43089, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43090, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43091, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43092, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43093, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43094, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43095, 0, 0, 0, -1, 0, 1, 69, NULL),
        (43096, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43225, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43226, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43227, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43228, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43229, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43230, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43231, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43232, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43233, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43234, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43235, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43322, 6, 0, 0, -1, 0, 1, 0, NULL),
        (43346, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43347, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43348, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43349, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43350, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43351, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43352, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43353, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43354, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43797, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43798, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43799, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43800, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43801, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43802, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43803, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43804, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43805, 0, 0, 0, -1, 0, 1, 0, NULL),
        (43806, 0, 0, 0, -1, 0, 1, 0, NULL),
        (46189, 0, 0, 0, -1, 0, 1, 0, '5232'),
        (46219, 1, 0, 9991, -1, 0, 1, 0, '18950'),
        (46220, 1, 0, 9991, -1, 0, 1, 0, '18950'),
        (46888, 9, 0, 0, -1, 0, 1, 0, NULL),
        (46889, 9, 0, 0, -1, 0, 1, 0, NULL),
        (49449, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49452, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49453, 0, 0, 0, -1, 0, 1, 0, NULL),
        (49852, 6, 0, 0, -1, 0, 1, 0, NULL),
        (50007, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50008, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50009, 0, 0, 0, -1, 0, 1, 0, '7366'),
        (50015, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50016, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50017, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50018, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50019, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50020, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50021, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50022, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50023, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50024, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50025, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50026, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50027, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50028, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50029, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50030, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50031, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50032, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50033, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50034, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50077, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50167, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50183, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50409, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50410, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50411, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50412, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50413, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50414, 0, 0, 0, -1, 7, 1, 0, '16093'),
        (50415, 0, 0, 0, -1, 7, 1, 0, '16093'),
        (50416, 0, 0, 0, -1, 7, 1, 0, '16093'),
        (50417, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50418, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50419, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50421, 0, 0, 0, -1, 0, 1, 0, NULL),
        (50422, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51317, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51318, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51319, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51322, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51324, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (51325, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51326, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51327, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51328, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (51329, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51330, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (51331, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51332, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51334, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (51335, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51336, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51404, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51463, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51464, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51469, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51470, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51471, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51472, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51473, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51474, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51476, 0, 0, 0, -1, 0, 1, 0, '7164'),
        (51478, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51481, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51482, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51483, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51484, 0, 0, 0, -1, 0, 1, 0, NULL),
        (51485, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52615, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52616, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52617, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52618, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52619, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52620, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52621, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52622, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52623, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52643, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52644, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52645, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52646, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52647, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52648, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52649, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52650, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52651, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52652, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52653, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52683, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52837, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52838, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52852, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52853, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52934, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52992, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52993, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52994, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52995, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52996, 0, 0, 0, -1, 0, 1, 0, NULL),
        (52997, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52998, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (52999, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53000, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53001, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53002, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53003, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53004, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53005, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53006, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53007, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53008, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53009, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53010, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53011, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53090, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53091, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53092, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53093, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53094, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53095, 0, 0, 0, -1, 0, 1, 0, '13787'),
        (53096, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53097, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53098, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53243, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53244, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53245, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53246, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53247, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (53248, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53249, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53250, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53251, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53252, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53253, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53254, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53255, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53256, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53273, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53274, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53275, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53276, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53277, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53278, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53279, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53280, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53281, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53282, 0, 0, 0, -1, 8, 1, 193, '12380'),
        (53283, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53284, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53285, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53286, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53287, 0, 0, 0, -1, 8, 1, 0, '12380'),
        (53288, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53289, 0, 0, 0, -1, 8, 1, 0, NULL),
        (53955, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53963, 0, 0, 0, -1, 0, 1, 0, NULL),
        (53968, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54079, 0, 0, 0, -1, 0, 1, 0, '8990'),
        (54081, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54082, 0, 0, 0, -1, 0, 1, 0, '8990'),
        (54083, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54084, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54085, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54086, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54087, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54088, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54140, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54141, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54142, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54144, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54146, 0, 0, 0, -1, 0, 1, 0, '17150'),
        (54147, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54162, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54166, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54167, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54168, 0, 0, 0, -1, 0, 1, 0, '17150'),
        (54169, 0, 0, 0, -1, 0, 1, 0, '12544'),
        (54170, 0, 0, 0, -1, 0, 1, 0, '17150'),
        (54171, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54172, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54173, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54174, 0, 0, 0, -1, 0, 1, 0, '17150'),
        (54175, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54179, 0, 0, 0, -1, 0, 1, 0, NULL),
        (54241, 0, 0, 0, -1, 0, 1, 0, '17467'),
        (94801, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94803, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94804, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94805, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94806, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94807, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94808, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94809, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94810, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94811, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94812, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94813, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94814, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94815, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94817, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94818, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94819, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94820, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94821, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94822, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94823, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94824, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94828, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94829, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94830, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94831, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94832, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94833, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94834, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94835, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94836, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94837, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94838, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94839, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94840, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94841, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94842, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94843, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94844, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94845, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94846, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94847, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94848, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94849, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94850, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94852, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94853, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94854, 9, 0, 0, -1, 0, 1, 0, NULL),
        (51, 0, 0, 0, -1, 0, 0, 0, NULL),
        (91, 1, 0, 0, -1, 0, 1, 0, '18950'),
        (108, 0, 0, 0, -1, 0, 0, 0, NULL),
        (109, 1, 0, 0, -1, 0, 1, 0, '18950'),
        (134, 0, 0, 0, -1, 0, 0, 0, NULL),
        (187, 0, 0, 0, -1, 0, 0, 0, NULL),
        (219, 0, 0, 0, -1, 0, 0, 0, NULL),
        (326, 0, 0, 0, -1, 0, 0, 0, NULL),
        (398, 0, 0, 0, -1, 0, 0, 0, NULL),
        (1012, 0, 0, 0, -1, 0, 0, 0, NULL),
        (1814, 1, 0, 0, -1, 0, 1, 0, '18950'),
        (1887, 0, 0, 0, -1, 0, 0, 0, NULL),
        (1895, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2016, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2413, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2418, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2439, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2453, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2459, 0, 0, 0, -1, 0, 0, 0, NULL),
        (2464, 0, 0, 0, -1, 0, 0, 0, NULL),
        (3022, 0, 0, 0, -1, 0, 0, 0, NULL),
        (3031, 0, 0, 0, -1, 0, 0, 0, NULL),
        (3111, 0, 0, 0, -1, 0, 0, 0, NULL),
        (3557, 0, 0, 0, -1, 0, 0, 0, NULL),
        (3595, 0, 0, 0, -1, 0, 0, 0, NULL),
        (3596, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4144, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4360, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4361, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4364, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4377, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4378, 0, 0, 0, -1, 0, 0, 0, NULL),
        (4522, 0, 0, 0, -1, 0, 0, 0, NULL),
        (10527, 0, 0, 0, -1, 0, 0, 0, NULL),
        (10528, 0, 0, 0, -1, 0, 0, 0, NULL),
        (12088, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (12093, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (21133, 0, 0, 0, -1, 0, 0, 0, NULL),
        (26197, 0, 0, 0, -1, 0, 0, 0, NULL),
        (26228, 0, 0, 0, -1, 0, 0, 0, NULL),
        (26229, 0, 0, 0, -1, 0, 0, 0, NULL),
        (26298, 0, 0, 0, -1, 0, 0, 0, NULL),
        (26333, 0, 0, 0, -1, 0, 1, 0, '8734'),
        (27368, 0, 0, 0, -1, 0, 0, 0, NULL),
        (27402, 0, 0, 0, -1, 0, 0, 0, '8434'),
        (43762, 0, 0, 0, -1, 1, 1, 0, ''),
        (28777, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29936, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29938, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29939, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29940, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29942, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29943, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29947, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29948, 0, 0, 0, -1, 0, 0, 0, NULL),
        (29949, 0, 0, 0, -1, 0, 0, 0, NULL),
        (31980, 0, 0, 0, -1, 0, 0, 0, NULL),
        (38116, 0, 0, 0, -1, 0, 0, 0, NULL),
        (38117, 0, 0, 0, -1, 0, 0, 0, NULL),
        (38347, 0, 0, 0, -1, 0, 0, 0, NULL),
        (39540, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40015, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40031, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40034, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40047, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40058, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40068, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40070, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40082, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40109, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40124, 0, 0, 0, -1, 0, 0, 0, NULL),
        (40129, 0, 0, 0, -1, 0, 0, 0, NULL),
        (42678, 0, 0, 0, -1, 0, 0, 0, NULL),
        (42681, 0, 0, 0, -1, 0, 0, 0, NULL),
        (42787, 0, 0, 0, -1, 0, 0, 0, NULL),
        (46818, 0, 0, 0, -1, 0, 0, 0, NULL),
        (48648, 0, 0, 0, -1, 0, 0, 0, NULL),
        (48655, 0, 0, 0, -1, 0, 0, 0, NULL),
        (48669, 0, 0, 0, -1, 0, 0, 0, NULL),
        (48707, 0, 0, 0, -1, 0, 0, 0, NULL),
        (54652, 0, 0, 0, -1, 0, 0, 0, NULL),
        (55098, 0, 0, 0, -1, 0, 0, 0, NULL),
        (55342, 0, 0, 0, -1, 0, 0, 0, NULL),
        (55458, 0, 0, 0, -1, 0, 0, 0, NULL),
        (55462, 0, 0, 0, -1, 0, 0, 0, NULL),
        (56624, 4, 0, 0, -1, 0, 0, 0, NULL),
        (56625, 4, 0, 0, -1, 0, 0, 0, NULL),
        (79223, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79333, 0, 0, 0, -1, 0, 1, 0, NULL),
        (79666, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79670, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (79675, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (79690, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (79720, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79721, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79723, 0, 0, 0, -1, 0, 0, 0, NULL),
        (45383, 0, 0, 0, -1, 0, 0, 234, NULL),
        (79768, 2, 0, 0, -1, 0, 1, 0, '18950'),
        (79769, 0, 0, 0, -1, 0, 0, 0, NULL),
        (46777, 0, 0, 0, -1, 0, 0, 234, NULL),
        (79796, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79807, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (79814, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (79815, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79816, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79817, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79818, 2, 0, 0, -1, 0, 1, 0, '18950'),
        (79857, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79881, 0, 0, 0, -1, 0, 0, 0, NULL),
        (79927, 0, 0, 0, -1, 0, 0, 0, NULL),
        (80119, 0, 0, 0, -1, 0, 0, 0, NULL),
        (80127, 0, 89, 0, -1, 0, 0, 0, NULL),
        (80137, 0, 89, 0, -1, 0, 0, 0, NULL),
        (80145, 0, 89, 0, -1, 0, 0, 0, NULL),
        (80262, 0, 89, 0, -1, 0, 0, 0, NULL),
        (80283, 0, 0, 0, -1, 0, 0, 0, NULL),
        (80320, 0, 0, 0, -1, 0, 0, 0, NULL),
        (80730, 0, 0, 0, -1, 0, 1, 0, NULL),
        (80732, 0, 0, 0, -1, 0, 1, 0, NULL),
        (80737, 0, 0, 0, -1, 0, 0, 0, NULL),
        (81181, 0, 0, 0, -1, 0, 0, 0, NULL),
        (81463, 0, 0, 0, -1, 0, 0, 0, NULL),
        (81526, 0, 0, 0, -1, 0, 0, 0, NULL),
        (81529, 0, 0, 0, -1, 0, 0, 0, NULL),
        (81550, 0, 0, 0, -1, 0, 0, 0, NULL),
        (81577, 0, 0, 0, -1, 0, 0, 0, NULL),
        (84587, 0, 0, 0, -1, 0, 1, 0, NULL),
        (85375, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85378, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85379, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85380, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85529, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85530, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85545, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85546, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85547, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85548, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85549, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85550, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85551, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85552, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85553, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85554, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85555, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85556, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85557, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85562, 0, 0, 0, -1, 0, 0, 0, NULL),
        (85963, 0, 0, 0, -1, 0, 0, 0, NULL),
        (47161, 0, 0, 0, -1, 0, 0, 234, NULL),
        (87205, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87206, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87226, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87227, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87289, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87321, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87354, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87363, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87377, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87396, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87429, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87430, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87431, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87435, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87446, 0, 0, 0, -1, 0, 0, 0, NULL),
        (87486, 0, 0, 0, -1, 0, 0, 0, NULL),
        (89002, 0, 0, 0, -1, 0, 0, 0, NULL),
        (90438, 0, 0, 0, -1, 0, 0, 0, '18950'),
        (90484, 2, 0, 0, -1, 0, 0, 0, '18950'),
        (94491, 0, 0, 0, -1, 0, 0, 0, NULL),
        (94492, 0, 0, 0, -1, 0, 0, 0, NULL),
        (23508, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90288, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (90285, 6, 0, 0, -1, 0, 1, 0, '26248'),
        (30444, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90283, 6, 0, 0, -1, 0, 1, 0, '26244'),
        (90282, 6, 0, 0, -1, 0, 1, 0, '26242'),
        (90281, 6, 0, 0, -1, 0, 1, 0, '26241'),
        (90197, 6, 0, 0, -1, 0, 1, 0, '26250'),
        (30741, 0, 0, 0, -1, 8, 1, 0, NULL),
        (30742, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90196, 6, 0, 0, -1, 0, 1, 0, '26247'),
        (30757, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30769, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30770, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30771, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30772, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30773, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30774, 0, 0, 0, -1, 0, 1, 0, NULL),
        (30776, 0, 0, 0, -1, 0, 1, 0, NULL),
        (90192, 6, 0, 0, -1, 0, 1, 0, '26253'),
        (90191, 6, 0, 0, -1, 0, 1, 0, '26254'),
        (90190, 6, 0, 0, -1, 0, 1, 0, '26239'),
        (90179, 6, 0, 0, -1, 0, 1, 0, '26249'),
        (89411, 6, 0, 0, -1, 0, 1, 0, '26250'),
        (89410, 6, 0, 0, -1, 0, 1, 0, '26246'),
        (31594, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89409, 6, 0, 0, -1, 0, 1, 0, '26245'),
        (31596, 0, 0, 0, -1, 0, 1, 0, NULL),
        (31601, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33792, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33793, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33798, 0, 0, 0, -1, 0, 1, 0, NULL),
        (33829, 0, 0, 0, -1, 0, 1, 0, NULL),
        (89407, 6, 0, 0, -1, 0, 1, 0, '26252'),
        (89404, 6, 0, 0, -1, 0, 1, 0, '26245'),
        (94529, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94530, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94531, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94532, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94533, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94534, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94535, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94536, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94537, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94538, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94539, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94540, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94541, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94542, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94543, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94544, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94545, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94546, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94547, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94548, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94549, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94550, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94551, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94552, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94553, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94554, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94555, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94556, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94557, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94558, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94559, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94560, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94561, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94562, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94563, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94564, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94565, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94566, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94567, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94568, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94569, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94570, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94571, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94574, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94575, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94576, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94577, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94578, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94579, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94580, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94581, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94582, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94583, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94584, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94585, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94586, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94587, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94588, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94589, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94590, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94591, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94592, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94593, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94594, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94595, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94596, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94597, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94598, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94599, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94600, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94601, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94602, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94603, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94604, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94605, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94606, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94607, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94608, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94609, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94610, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94611, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94612, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94615, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94616, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94617, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94618, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94619, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94620, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94621, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94622, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94623, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94627, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94628, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94629, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94630, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94634, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94635, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94636, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94637, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94638, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94639, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94640, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94641, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94642, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94643, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94644, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94645, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94646, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94647, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94648, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94649, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94650, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94651, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94652, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94653, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94654, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94655, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94656, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94657, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94658, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94659, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94660, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94661, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94662, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94663, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94664, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94669, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94670, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94671, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94672, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94673, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94674, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94675, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94676, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94677, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94678, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94679, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94680, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94681, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94682, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94683, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94684, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94685, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94686, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94687, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94688, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94689, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94690, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94691, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94692, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94693, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94694, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94695, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94696, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94697, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94698, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94699, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94700, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94701, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94702, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94703, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94704, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94705, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94706, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94707, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94708, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94709, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94710, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94711, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94715, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94716, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94717, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94723, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94724, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94725, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94726, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94727, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94728, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94729, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94730, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94731, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94732, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94733, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94734, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94735, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94738, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94739, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94740, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94741, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94742, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94743, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94744, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94745, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94746, 9, 0, 0, -1, 0, 1, 0, NULL),
        (94747, 9, 0, 0, -1, 0, 1, 0, NULL),
        (40253, 0, 0, 0, -1, 1, 1, 0, NULL),
        (40261, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40252, 0, 0, 0, -1, 1, 1, 0, NULL),
        (51781, 0, 0, 0, -1, 0, 0, 0, '10848'),
        (300851, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300857, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300855, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300854, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300852, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300172, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (56952, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300856, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300853, 1, 0, 0, -1, 0, 0, 0, '23017'),
        (300506, 0, 0, 0, -1, 0, 0, 0, ''),
        (300499, 0, 0, 0, -1, 0, 0, 0, ''),
        (300500, 0, 0, 0, -1, 0, 0, 0, ''),
        (300507, 0, 0, 0, -1, 0, 0, 0, ''),
        (300510, 0, 0, 0, -1, 0, 0, 0, ''),
        (300508, 0, 0, 0, -1, 0, 0, 0, ''),
        (300498, 0, 0, 0, -1, 0, 0, 0, ''),
        (300511, 0, 0, 0, -1, 0, 0, 0, ''),
        (300577, 0, 0, 0, -1, 0, 0, 0, ''),
        (300578, 0, 0, 0, -1, 0, 0, 0, ''),
        (300579, 0, 0, 0, -1, 0, 0, 0, ''),
        (300580, 0, 0, 0, -1, 0, 0, 0, ''),
        (300581, 0, 0, 0, -1, 0, 0, 0, ''),
        (300582, 0, 0, 0, -1, 0, 0, 0, ''),
        (300583, 0, 0, 0, -1, 0, 0, 0, ''),
        (300584, 0, 0, 0, -1, 0, 0, 0, ''),
        (300585, 0, 0, 0, -1, 0, 0, 0, ''),
        (300586, 0, 0, 0, -1, 0, 0, 0, ''),
        (300587, 0, 0, 0, -1, 0, 0, 0, ''),
        (300588, 0, 0, 0, -1, 0, 0, 0, ''),
        (300589, 0, 0, 0, -1, 0, 0, 0, ''),
        (300590, 0, 0, 0, -1, 0, 0, 0, ''),
        (300591, 0, 0, 0, -1, 0, 0, 0, ''),
        (300592, 0, 0, 0, -1, 0, 0, 0, ''),
        (300593, 0, 0, 0, -1, 0, 0, 0, ''),
        (300594, 0, 0, 0, -1, 0, 0, 0, ''),
        (300595, 0, 0, 0, -1, 0, 0, 0, ''),
        (300596, 0, 0, 0, -1, 0, 0, 0, ''),
        (300599, 0, 0, 0, -1, 0, 0, 0, ''),
        (300600, 0, 0, 0, -1, 0, 0, 0, ''),
        (300601, 0, 0, 0, -1, 0, 0, 0, ''),
        (300603, 0, 0, 0, -1, 0, 0, 0, ''),
        (300606, 0, 0, 0, -1, 0, 0, 0, ''),
        (300609, 0, 0, 0, -1, 0, 0, 0, ''),
        (300613, 0, 0, 0, -1, 0, 0, 0, ''),
        (300617, 0, 0, 0, -1, 0, 0, 0, ''),
        (300621, 0, 0, 0, -1, 0, 0, 0, ''),
        (300626, 0, 0, 0, -1, 0, 0, 0, ''),
        (301002, 0, 0, 0, -1, 8, 1, 0, '13236'),
        (300234, 0, 0, 0, -1, 0, 1, 233, ''),
        (300235, 0, 0, 0, -1, 0, 1, 233, ''),
        (300236, 0, 0, 0, -1, 0, 1, 233, ''),
        (300238, 0, 0, 0, -1, 0, 1, 233, ''),
        (300239, 0, 0, 0, -1, 0, 1, 233, ''),
        (300240, 0, 0, 0, -1, 0, 1, 233, ''),
        (300241, 0, 0, 0, -1, 0, 1, 233, ''),
        (300242, 0, 0, 0, -1, 0, 1, 233, ''),
        (300243, 0, 0, 0, -1, 0, 1, 233, ''),
        (300244, 0, 0, 0, -1, 0, 1, 0, ''),
        (300245, 0, 0, 0, -1, 0, 1, 0, ''),
        (300246, 0, 0, 0, -1, 0, 1, 69, ''),
        (300247, 0, 0, 0, -1, 0, 1, 233, ''),
        (300248, 0, 0, 0, -1, 0, 1, 234, ''),
        (300249, 0, 0, 0, -1, 0, 1, 234, ''),
        (300250, 0, 0, 0, -1, 0, 1, 234, ''),
        (300251, 0, 0, 0, -1, 0, 1, 234, ''),
        (300252, 0, 0, 0, -1, 0, 1, 234, ''),
        (300253, 0, 0, 0, -1, 0, 1, 234, ''),
        (300254, 0, 0, 0, -1, 0, 1, 234, ''),
        (300255, 0, 0, 0, -1, 0, 1, 234, ''),
        (300256, 0, 0, 0, -1, 0, 1, 234, ''),
        (300257, 0, 0, 0, -1, 0, 1, 234, ''),
        (300258, 0, 0, 0, -1, 0, 1, 234, ''),
        (300259, 0, 0, 0, -1, 0, 1, 234, ''),
        (300260, 0, 0, 0, -1, 0, 1, 0, ''),
        (300261, 0, 0, 0, -1, 0, 1, 234, ''),
        (300262, 0, 0, 0, -1, 0, 1, 69, ''),
        (300267, 0, 0, 0, -1, 0, 1, 233, ''),
        (300269, 5, 0, 0, -1, 0, 1, 233, ''),
        (300270, 5, 0, 0, -1, 0, 1, 234, ''),
        (300271, 5, 0, 0, -1, 0, 1, 234, ''),
        (300272, 5, 0, 0, -1, 0, 1, 234, ''),
        (300273, 5, 0, 0, -1, 0, 1, 234, ''),
        (300274, 5, 0, 0, -1, 0, 1, 234, ''),
        (300275, 5, 0, 0, -1, 0, 1, 234, ''),
        (300276, 5, 0, 0, -1, 0, 1, 234, ''),
        (300277, 5, 0, 0, -1, 0, 1, 234, ''),
        (300278, 5, 0, 0, -1, 0, 1, 234, ''),
        (300279, 5, 0, 0, -1, 0, 1, 234, ''),
        (300280, 0, 0, 0, -1, 0, 1, 233, ''),
        (300288, 0, 0, 0, -1, 0, 1, 0, ''),
        (300289, 0, 0, 0, -1, 0, 1, 0, ''),
        (300290, 0, 0, 0, -1, 0, 1, 0, ''),
        (300291, 0, 0, 0, -1, 0, 1, 0, ''),
        (300292, 0, 0, 0, -1, 0, 1, 0, ''),
        (300293, 0, 0, 0, -1, 0, 1, 0, ''),
        (300294, 0, 0, 0, -1, 0, 1, 233, ''),
        (300295, 0, 0, 0, -1, 0, 1, 234, ''),
        (300296, 0, 0, 0, -1, 0, 1, 0, ''),
        (300297, 0, 0, 0, -1, 0, 1, 233, ''),
        (300298, 0, 0, 0, -1, 0, 1, 233, ''),
        (300299, 0, 0, 0, -1, 0, 1, 0, ''),
        (300300, 0, 0, 0, -1, 0, 1, 233, ''),
        (300301, 0, 0, 0, -1, 0, 1, 233, ''),
        (300302, 0, 0, 0, -1, 0, 1, 233, ''),
        (300303, 0, 0, 0, -1, 0, 1, 233, ''),
        (300304, 0, 0, 0, -1, 0, 1, 233, ''),
        (300305, 0, 0, 0, -1, 0, 1, 0, ''),
        (300306, 0, 0, 0, -1, 0, 1, 233, ''),
        (300307, 0, 0, 0, -1, 0, 1, 69, ''),
        (300308, 0, 0, 0, -1, 0, 1, 133, ''),
        (43765, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (44330, 0, 0, 0, -1, 1, 1, 0, NULL),
        (44327, 0, 0, 0, -1, 1, 1, 0, NULL),
        (43764, 0, 0, 0, -1, 1, 1, 0, NULL),
        (44321, 0, 0, 0, -1, 1, 1, 0, NULL),
        (45785, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (300311, 0, 0, 0, -1, 0, 1, 0, ''),
        (45776, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (45796, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (45797, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (300467, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (44328, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (44312, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (44311, 0, 0, 0, -1, 0, 1, 12, '6606'),
        (44320, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (300312, 0, 0, 0, -1, 0, 1, 0, ''),
        (300313, 0, 0, 0, -1, 0, 1, 233, ''),
        (300314, 0, 0, 0, -1, 0, 1, 233, ''),
        (300315, 0, 0, 0, -1, 0, 1, 233, ''),
        (300316, 0, 0, 0, -1, 0, 1, 233, ''),
        (300317, 0, 0, 0, -1, 0, 1, 69, ''),
        (300320, 0, 0, 0, -1, 0, 1, 69, ''),
        (300321, 0, 0, 0, -1, 0, 1, 233, ''),
        (44319, 0, 0, 0, -1, 0, 1, 0, '12380'),
        (81107, 0, 0, 0, -1, 1, 0, 0, NULL),
        (83185, 0, 0, 0, -1, 1, 0, 0, NULL),
        (83187, 0, 0, 0, -1, 1, 0, 0, NULL),
        (300322, 0, 0, 0, -1, 0, 1, 0, ''),
        (300323, 0, 0, 0, -1, 0, 1, 0, ''),
        (300324, 0, 0, 0, -1, 0, 1, 0, ''),
        (300325, 0, 0, 0, -1, 0, 1, 0, ''),
        (300326, 0, 0, 0, -1, 0, 1, 69, ''),
        (300327, 0, 0, 0, -1, 0, 1, 0, ''),
        (44009, 0, 0, 0, -1, 0, 1, 0, '13236'),
        (300328, 0, 0, 0, -1, 0, 1, 0, ''),
        (300330, 0, 0, 0, -1, 0, 1, 0, ''),
        (300331, 0, 0, 0, -1, 0, 1, 0, ''),
        (45834, 0, 0, 0, -1, 1, 1, 0, NULL),
        (40263, 0, 0, 0, -1, 8, 1, 0, NULL),
        (40268, 0, 0, 0, -1, 1, 1, 0, NULL),
        (41821, 0, 0, 0, -1, 1, 1, 0, NULL),
        (42159, 0, 0, 0, -1, 1, 1, 0, NULL),
        (42158, 0, 0, 0, -1, 1, 1, 0, NULL),
        (42639, 0, 0, 0, -1, 1, 1, 0, NULL),
        (100029, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100030, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100031, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100032, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100033, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100034, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100035, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100036, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100037, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100038, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100039, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100040, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100041, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100042, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100043, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100044, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100046, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100047, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100045, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100048, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100049, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100050, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100051, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100052, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100053, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100054, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100055, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100056, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100057, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100058, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100059, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100060, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100061, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100062, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100063, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100066, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100067, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100068, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100069, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100070, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100071, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100072, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100073, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100074, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100075, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100076, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100077, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100078, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100079, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100080, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100081, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100082, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100083, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100084, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100085, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100086, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100087, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100088, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100089, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100090, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100091, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100092, 7, 0, 0, -1, 0, 1, 28, NULL),
        (100093, 7, 0, 0, -1, 0, 1, 28, NULL),
        (134794, 1, 0, 0, -1, 1, 1, 0, NULL),
        (134798, 1, 0, 0, -1, 1, 1, 0, NULL),
        (134827, 1, 0, 0, -1, 1, 1, 0, NULL),
        (8465, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14806, 0, 0, 0, -1, 0, 1, 0, NULL),
        (14807, 0, 0, 0, -1, 0, 1, 0, NULL),
        (24048, 0, 0, 0, -1, 0, 1, 0, NULL),
        (106004, 0, 0, 0, -1, 1, 1, 0, NULL),
        (100, 0, 0, -1, -1, 0, 1, 233, NULL),
        (31875, 0, 0, -1, -1, 1, 1, 0, NULL),
        (79161, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79159, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79142, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79182, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79183, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79131, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79178, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79187, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79175, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79154, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79145, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79127, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79174, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79184, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79194, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79172, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79169, 0, 0, -1, -1, 0, 1, 233, NULL),
        (84082, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79155, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79143, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79162, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79135, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79158, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79160, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79190, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79156, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79140, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79176, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79128, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79179, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79181, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79133, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79148, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79146, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79129, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79136, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79173, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79185, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79137, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79134, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79149, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79157, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79163, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79164, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79180, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79191, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79144, 0, 0, -1, -1, 0, 1, 233, NULL),
        (49314, 0, 0, -1, -1, 8, 1, 0, NULL),
        (4687, 0, 0, -1, -1, 0, 1, 69, NULL),
        (79241, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79224, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79220, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79192, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79221, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79231, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79193, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79219, 0, 0, -1, -1, 0, 1, 234, NULL),
        (79225, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79239, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79234, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79258, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79251, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79238, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79216, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79232, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79226, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79240, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79130, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79255, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79215, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79250, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79256, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79237, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79248, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79236, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79252, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79210, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79235, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79249, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79253, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79257, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79259, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79261, 0, 0, -1, -1, 0, 1, 233, NULL),
        (79271, 0, 0, -1, -1, 0, 1, 233, NULL),
        (40020, 0, 0, -1, -1, 8, 1, 0, NULL),
        (40013, 0, 0, -1, -1, 8, 1, 0, NULL),
        (40011, 0, 0, -1, -1, 8, 1, 0, NULL),
        (40007, 0, 0, -1, -1, 8, 1, 0, NULL),
        (49194, 0, 0, -1, -1, 8, 1, 0, NULL),
        (46222, 0, 0, -1, -1, 7, 1, 0, NULL),
        (37061, 0, 0, -1, -1, 8, 1, 0, NULL),
        (1795, 0, 0, -1, -1, 0, 1, 69, NULL),
        (54164, 0, 0, -1, -1, 0, 1, 69, NULL),
        (46212, 0, 0, -1, -1, 3, 1, 0, NULL),
        (46213, 0, 0, -1, -1, 3, 1, 0, NULL),
        (46214, 0, 0, -1, -1, 3, 1, 0, NULL),
        (46215, 0, 0, -1, -1, 3, 1, 0, NULL),
        (39850, 0, 0, -1, -1, 7, 1, 0, NULL),
        (54423, 0, 0, -1, -1, 8, 1, 0, NULL),
        (54422, 0, 0, -1, -1, 8, 1, 0, NULL),
        (57168, 0, 0, -1, -1, 8, 1, 0, NULL),
        (14389, 0, 0, -1, -1, 0, 1, 173, NULL),
        (2013, 0, 0, -1, -1, 0, 1, 233, NULL),
        (47572, 0, 0, -1, -1, 3, 1, 0, NULL),
        (26136, 0, 0, -1, -1, 7, 1, 0, NULL),
        (87442, 0, 0, -1, -1, 7, 1, 0, NULL),
        (2084, 0, 0, -1, -1, 0, 1, 69, NULL),
        (93301, 0, 0, -1, -1, 7, 1, 0, NULL),
        (102, 0, 0, -1, -1, 1, 1, 0, NULL),
        (53036, 0, 0, -1, -1, 7, 1, 0, NULL),
        (39856, 0, 0, -1, -1, 7, 1, 0, NULL),
        (39849, 0, 0, -1, -1, 7, 1, 0, NULL),
        (84825, 0, 0, -1, -1, 7, 1, 0, NULL),
        (86149, 0, 0, -1, -1, 7, 1, 0, NULL),
        (95115, 0, 0, -1, -1, 3, 1, 0, NULL),
        (87185, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87192, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87184, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87172, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87180, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87177, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87174, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87178, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87186, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87173, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87175, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87179, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87181, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87182, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87183, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87188, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87189, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87190, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87191, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87193, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87194, 0, 0, -1, -1, 0, 1, 10, NULL),
        (87195, 0, 0, -1, -1, 0, 1, 10, NULL),
        (150524, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150484, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150485, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301597, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150487, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150516, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150508, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150512, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150480, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150509, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150493, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150479, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150521, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150526, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150486, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150492, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150501, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150478, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150519, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301595, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150496, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150489, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150505, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150488, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150518, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301596, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150498, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150506, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150527, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150502, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150515, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150525, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150523, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150522, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150520, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150517, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150511, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150510, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150507, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150503, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150499, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150495, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150494, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150490, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150483, 0, 0, -1, -1, 0, 1, 233, NULL),
        (4216, 0, 0, -1, -1, 8, 1, 0, NULL),
        (87187, 0, 0, -1, -1, 0, 1, 10, NULL),
        (47391, 0, 0, -1, -1, 8, 1, 0, NULL),
        (81085, 0, 0, -1, -1, 8, 1, 0, NULL),
        (5579, 0, 0, -1, -1, 1, 1, 0, NULL),
        (46327, 0, 0, -1, -1, 3, 1, 0, NULL),
        (46566, 0, 0, -1, -1, 1, 1, 0, NULL),
        (2011, 0, 0, -1, -1, 0, 1, 233, NULL),
        (9474, 0, 0, -1, -1, 3, 1, 0, NULL),
        (24778, 0, 0, -1, -1, 1, 1, 0, NULL),
        (7723, 0, 0, -1, -1, 8, 1, 0, NULL),
        (48641, 0, 0, -1, -1, 7, 1, 0, NULL),
        (46321, 0, 0, -1, -1, 3, 1, 0, NULL),
        (46332, 0, 0, -1, -1, 3, 1, 0, NULL),
        (6460, 0, 0, -1, -1, 0, 1, 69, NULL),
        (224, 0, 0, -1, -1, 8, 1, 0, NULL),
        (51680, 0, 0, -1, -1, 3, 1, 0, NULL),
        (3431, 0, 0, -1, -1, 8, 1, 0, NULL),
        (4770, 0, 0, -1, -1, 0, 1, 13, NULL),
        (95116, 0, 0, -1, -1, 3, 1, 0, NULL),
        (95126, 0, 0, -1, -1, 3, 1, 0, NULL),
        (11220, 0, 0, -1, -1, 1, 1, 0, NULL),
        (301274, 0, 0, -1, -1, 0, 1, 234, NULL),
        (301271, 0, 0, -1, -1, 0, 1, 234, NULL),
        (301276, 0, 0, -1, -1, 0, 1, 234, NULL),
        (301272, 0, 0, -1, -1, 0, 1, 234, NULL),
        (38004, 0, 0, -1, -1, 0, 1, 234, NULL),
        (27660, 0, 0, -1, -1, 0, 1, 234, NULL),
        (44187, 0, 0, -1, -1, 0, 1, 234, NULL),
        (8969, 0, 0, -1, -1, 0, 1, 234, NULL),
        (8971, 0, 0, -1, -1, 0, 1, 234, NULL),
        (301275, 0, 0, -1, -1, 0, 1, 234, NULL),
        (301273, 0, 0, -1, -1, 0, 1, 234, NULL),
        (39094, 0, 0, -1, -1, 7, 1, 0, NULL),
        (6609, 0, 0, -1, -1, 3, 1, 0, NULL),
        (150709, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150711, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150754, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150737, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150734, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150717, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150724, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150745, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150716, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150725, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150748, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301685, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150721, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301604, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150708, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150740, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150736, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150756, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150718, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301684, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150710, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150757, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150731, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150720, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150726, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150738, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150747, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150753, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150735, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150728, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150713, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150741, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150732, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150722, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150714, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150744, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150715, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150752, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301686, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150727, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150730, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150733, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150739, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150742, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150743, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150746, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150750, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150751, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150755, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301683, 0, 0, -1, -1, 0, 1, 233, NULL),
        (46717, 0, 0, -1, -1, 8, 1, 0, NULL),
        (45225, 0, 0, -1, -1, 8, 1, 0, NULL),
        (33973, 0, 0, -1, -1, 3, 1, 0, NULL),
        (13175, 0, 0, -1, -1, 7, 1, 0, NULL),
        (56945, 0, 0, -1, -1, 1, 1, 0, NULL),
        (150556, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150546, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150570, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150561, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150576, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150542, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150571, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150551, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301591, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150562, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150548, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150559, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301590, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301592, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150558, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150533, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150574, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150572, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150536, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150538, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150544, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150566, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150555, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150539, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150567, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150575, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150557, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150545, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150552, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150565, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150577, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150573, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150569, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150568, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150560, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150553, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150549, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150543, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150540, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150537, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150535, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150534, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150530, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150529, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150528, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150453, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150469, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150449, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150455, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150467, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150461, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150452, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150435, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301586, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150430, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150442, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150434, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150462, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150458, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150468, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150440, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150439, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150456, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150473, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150472, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150446, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150433, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301587, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150460, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150448, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150443, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150444, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150457, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150429, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150437, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150465, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150459, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150466, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150476, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150438, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150436, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150445, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150428, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150451, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301585, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150475, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150477, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150474, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150471, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150470, 0, 0, -1, -1, 0, 1, 233, NULL),
        (29590, 0, 0, -1, -1, 7, 1, 0, NULL),
        (150827, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150840, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150857, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150808, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150825, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150824, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150828, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150837, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150833, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150853, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150821, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150813, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150846, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301690, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150852, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150826, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150851, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150847, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150820, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301688, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150814, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150817, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150838, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150841, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150835, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150830, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150850, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150854, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150842, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150849, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150839, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150855, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150848, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150810, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150818, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301689, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301603, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150809, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150811, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150815, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150816, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150822, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150831, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150832, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150834, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150836, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150843, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150844, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150845, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150856, 0, 0, -1, -1, 0, 1, 233, NULL),
        (4670, 0, 0, -1, -1, 0, 1, 233, NULL),
        (705, 0, 0, -1, -1, 0, 1, 10, NULL),
        (150768, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150765, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150792, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150761, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150777, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150790, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150781, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150787, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301605, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150771, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150760, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150784, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150772, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301691, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150793, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150785, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301692, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150807, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150789, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150801, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150786, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150766, 0, 0, -1, -1, 0, 1, 233, NULL),
        (301687, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150775, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150767, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150805, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150774, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150788, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150800, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150780, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150783, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150763, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150798, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150758, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150799, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150797, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150759, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150764, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150770, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150776, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150778, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150782, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150791, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150794, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150795, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150796, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150802, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150803, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150804, 0, 0, -1, -1, 0, 1, 233, NULL),
        (150806, 0, 0, -1, -1, 0, 1, 233, NULL),
        (15031, 0, 0, -1, -1, 1, 1, 0, NULL),
        (65607, 0, 0, -1, -1, 3, 1, 0, NULL),
        (9462, 0, 0, -1, -1, 1, 1, 0, NULL),
        (7463, 0, 0, -1, -1, 0, 1, 233, NULL),
        (30682, 0, 0, -1, -1, 1, 1, 0, NULL),
        (49657, 0, 0, -1, -1, 8, 1, 0, NULL),
        (53297, 0, 0, -1, -1, 8, 1, 0, NULL),
        (6397, 0, 0, -1, -1, 0, 1, 10, NULL),
        (42798, 0, 0, -1, -1, 8, 1, 0, NULL),
        (86184, 0, 0, -1, -1, 5, 1, 0, NULL),
        (393, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2132, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2146, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2141, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2133, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2148, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2130, 0, 0, -1, -1, 0, 1, 233, NULL),
        (395, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2128, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2136, 0, 0, -1, -1, 0, 1, 233, NULL),
        (2131, 0, 0, -1, -1, 0, 1, 233, NULL),
        (394, 0, 0, -1, -1, 0, 1, 233, NULL),
        (542, 0, 0, -1, -1, 7, 1, 0, NULL),
        (9566, 0, 0, -1, -1, 3, 1, 0, NULL),
        (32329, 0, 0, -1, -1, 1, 1, 0, NULL),
        (49199, 0, 0, -1, -1, 0, 1, 193, NULL),
        (42296, 0, 0, -1, -1, 0, 1, 10, NULL),
        (50003, 0, 0, -1, -1, 1, 1, 0, NULL),
        (49656, 0, 0, -1, -1, 8, 1, 0, NULL),
        (92997, 0, 0, -1, -1, 7, 1, 0, NULL),
        (48577, 0, 0, -1, -1, 3, 1, 0, NULL),
        (6166, 0, 0, -1, -1, 3, 1, 0, NULL),
        (50004, 0, 0, -1, -1, 1, 1, 0, NULL),
        (37062, 0, 0, -1, -1, 8, 1, 0, NULL),
        (7448, 0, 0, -1, -1, 0, 1, 233, NULL),
        (32347, 0, 0, -1, -1, 3, 1, 0, NULL),
        (33808, 0, 0, -1, -1, 7, 1, 0, NULL),
        (24707, 0, 0, -1, -1, 1, 1, 0, NULL),
        (51676, 0, 0, -1, -1, 3, 1, 0, NULL),
        (13166, 0, 0, -1, -1, 0, 1, 173, NULL),
        (4681, 0, 0, -1, -1, 0, 1, 69, NULL),
        (47771, 0, 0, -1, -1, 8, 1, 0, NULL),
        (47898, 0, 0, -1, -1, 8, 1, 0, NULL),
        (48925, 0, 0, -1, -1, 0, 1, 69, NULL),
        (49086, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49084, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49082, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49085, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49081, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49087, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49079, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49083, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49080, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49078, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49257, 0, 0, -1, -1, 8, 1, 0, NULL),
        (49288, 0, 0, -1, -1, 8, 1, 0, NULL),
        (49313, 0, 0, -1, -1, 8, 1, 0, NULL),
        (39088, 0, 0, -1, -1, 1, 1, 0, NULL),
        (49577, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49575, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49380, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49386, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49391, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49400, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49576, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49574, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49399, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49394, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49393, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49392, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49379, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49378, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49377, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49369, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49368, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49367, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49609, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49371, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49382, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49396, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49370, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49650, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49395, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49381, 0, 0, -1, -1, 0, 1, 10, NULL),
        (49372, 0, 0, -1, -1, 0, 1, 10, NULL),
        (31870, 0, 0, -1, -1, 8, 1, 0, NULL),
        (49655, 0, 0, -1, -1, 0, 1, 10, NULL),
        (3419, 0, 0, -1, -1, 1, 1, 0, NULL),
        (5569, 0, 0, -1, -1, 7, 1, 0, NULL),
        (23229, 0, 0, -1, -1, 7, 1, 0, NULL),
        (37523, 0, 0, -1, -1, 3, 1, 0, NULL),
        (24781, 0, 0, -1, -1, 1, 1, 0, NULL),
        (5799, 0, 0, -1, -1, 7, 1, 0, NULL),
        (6823, 0, 0, -1, -1, 7, 1, 0, NULL),
        (6882, 0, 0, -1, -1, 8, 1, 0, NULL),
        (42917, 0, 0, -1, -1, 7, 1, 0, NULL),
        (50381, 0, 0, -1, -1, 7, 1, 0, NULL),
        (9443, 0, 0, -1, -1, 7, 1, 0, NULL),
        (9473, 0, 0, -1, -1, 3, 1, 0, NULL),
        (4672, 0, 0, -1, -1, 0, 1, 69, NULL),
        (90956, 0, 0, -1, -1, 0, 1, 69, NULL),
        (90954, 0, 0, -1, -1, 0, 1, 69, NULL),
        (29210, 0, 0, -1, -1, 3, 1, 0, NULL),
        (17627, 0, 0, -1, -1, 1, 1, 0, NULL),
        (24268, 0, 0, -1, -1, 7, 1, 0, NULL),
        (31804, 0, 0, -1, -1, 1, 1, 0, NULL),
        (31864, 0, 0, -1, -1, 0, 1, 69, NULL),
        (31877, 0, 0, -1, -1, 1, 1, 0, NULL),
        (13180, 0, 0, -1, -1, 0, 1, 173, NULL),
        (44557, 0, 0, -1, -1, 8, 1, 0, NULL),
        (68946, 0, 0, -1, -1, 8, 1, 0, NULL),
        (4685, 0, 0, -1, -1, 0, 1, 69, NULL),
        (42916, 0, 0, -1, -1, 0, 1, 69, NULL),
        (37064, 0, 0, -1, -1, 8, 1, 0, NULL),
        (45439, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92626, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92623, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92628, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92621, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92625, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92627, 0, 0, -1, -1, 7, 1, 0, NULL),
        (92848, 0, 0, -1, -1, 0, 1, 93, NULL),
        (92884, 0, 0, -1, -1, 1, 1, 0, NULL),
        (42331, 0, 0, -1, -1, 8, 1, 0, NULL),
        (37853, 0, 0, -1, -1, 0, 1, 69, NULL),
        (92912, 0, 0, -1, -1, 0, 1, 10, NULL),
        (93209, 0, 0, -1, -1, 7, 1, 0, NULL),
        (3417, 0, 0, -1, -1, 1, 1, 0, NULL),
        (6402, 0, 0, -1, -1, 0, 1, 10, NULL),
        (6471, 0, 0, -1, -1, 7, 1, 0, NULL),
        (6613, 0, 0, -1, -1, 0, 1, 233, NULL),
        (35937, 0, 0, -1, -1, 7, 1, 0, NULL),
        (300319, 0, 0, -1, -1, 1, 1, 0, NULL),
        (7325, 0, 0, -1, -1, 0, 1, 10, NULL),
        (37096, 0, 0, -1, -1, 1, 1, 0, NULL),
        (7444, 0, 0, -1, -1, 0, 1, 233, NULL),
        (7973, 0, 0, -1, -1, 0, 1, 233, NULL),
        (40428, 0, 0, -1, -1, 8, 1, 0, NULL),
        (12325, 0, 0, -1, -1, 8, 1, 0, NULL),
        (13170, 0, 0, -1, -1, 1, 1, 0, NULL),
        (13989, 0, 0, -1, -1, 8, 1, 0, NULL),
        (23708, 0, 0, -1, -1, 7, 1, 0, NULL),
        (30013, 0, 0, -1, -1, 0, 1, 173, NULL),
        (24784, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26767, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26761, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26766, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26765, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26764, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26763, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26762, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26760, 0, 0, -1, -1, 1, 1, 0, NULL),
        (26987, 0, 0, -1, -1, 8, 1, 0, NULL),
        (32294, 0, 0, -1, -1, 1, 1, 0, NULL),
        (32293, 0, 0, -1, -1, 1, 1, 0, NULL),
        (32292, 0, 0, -1, -1, 1, 1, 0, NULL),
        (33023, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33026, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33011, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33015, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33022, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33006, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33014, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33024, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33021, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33018, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33016, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33013, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33012, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33010, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33009, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33008, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33007, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32349, 0, 0, -1, -1, 3, 1, 0, NULL),
        (32380, 0, 0, -1, -1, 8, 1, 0, NULL),
        (32379, 0, 0, -1, -1, 8, 1, 0, NULL),
        (32378, 0, 0, -1, -1, 8, 1, 0, NULL),
        (32829, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32820, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32817, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32832, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32846, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32824, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32814, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32836, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32843, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32815, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32844, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32847, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32841, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32838, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32835, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32810, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32839, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32842, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32826, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32812, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32845, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32848, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32828, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32816, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32823, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32849, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32840, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32837, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32834, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32833, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32831, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32830, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32827, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32825, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32822, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32821, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32819, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32818, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32813, 0, 0, -1, -1, 0, 1, 234, NULL),
        (32811, 0, 0, -1, -1, 0, 1, 234, NULL),
        (33148, 0, 0, -1, -1, 1, 1, 0, NULL),
        (39059, 0, 0, -1, -1, 3, 1, 0, NULL),
        (42753, 0, 0, -1, -1, 1, 1, 0, NULL),
        (43097, 0, 0, -1, -1, 8, 1, 0, NULL),
        (50005, 0, 0, -1, -1, 8, 1, 0, NULL),
        (49183, 0, 0, -1, -1, 3, 1, 0, NULL),
        (84079, 0, 0, -1, -1, 0, 1, 233, NULL),
        (85781, 0, 0, -1, -1, 7, 1, 0, NULL),
        (85782, 0, 0, -1, -1, 7, 1, 0, NULL),
        (80881, 0, 3258, -1, -1, 0, 1, 0, ''),
        (81391, 0, 236, -1, -1, 0, 1, 0, ''),
        (94919, 7, 15871, -1, -1, 0, 1, 0, ''),
        (94920, 7, 15870, -1, -1, 0, 1, 0, ''),
        (8969, 4, 0, -1, 1715, 0, 1, 0, NULL),
        (8971, 4, 0, -1, 1715, 0, 1, 0, NULL),
        (27660, 4, 0, -1, 1715, 0, 1, 0, NULL),
        (38004, 4, 0, -1, 1715, 0, 1, 0, NULL),
        (44187, 4, 0, -1, 1715, 0, 1, 0, NULL),
        (52728, 2, 0, -1, 12798, 0, 1, 0, NULL),
        (52729, 2, 0, -1, 12797, 0, 1, 0, NULL),
        (86991, 6, 0, -1, 15350, 0, 1, 0, NULL),
        (86992, 6, 0, -1, 15350, 0, 1, 0, NULL),
        (86993, 6, 0, -1, 15350, 0, 1, 0, NULL),
        (92287, 0, 0, -1, 429, 0, 1, 0, NULL),
        (92288, 0, 0, -1, 2058, 0, 1, 0, NULL),
        (92289, 0, 0, -1, 2058, 0, 1, 0, NULL),
        (92290, 0, 0, -1, 2058, 0, 1, 0, NULL),
        (92291, 0, 0, -1, 2058, 0, 1, 0, NULL),
        (300451, 0, 0, -1, 918, 0, 1, 0, NULL),
        (300452, 0, 0, -1, 918, 0, 1, 0, NULL),
        (300457, 0, 0, -1, 782, 0, 1, 0, NULL),
        (300461, 0, 0, -1, 1070, 0, 1, 0, NULL),
        (300462, 0, 0, -1, 1072, 0, 1, 0, NULL),
        (300463, 0, 0, -1, 1070, 0, 1, 0, NULL),
        (302704, 0, 0, -1, 4947, 0, 1, 0, NULL);

        insert into applied_updates values ('08020221');
    end if;
	
end $
delimiter ;