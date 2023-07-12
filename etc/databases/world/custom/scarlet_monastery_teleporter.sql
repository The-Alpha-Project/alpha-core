-- Scarlet Monastery Game Object Teleporter

-- GO template.
DELETE FROM `gameobject_template` WHERE `entry`=3000492;
INSERT INTO `gameobject_template` VALUES (3000492 , 1, 327, "Scarlet Monastery Teleporter", 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "");

-- GO spawn entry.
DELETE FROM `spawns_gameobjects` WHERE `spawn_entry`=3000492;
INSERT INTO `spawns_gameobjects` VALUES (3998714, 3000492, 0, 2830.448, -697.662, 140, 3.53, 0, 0, 0, 0, 900, 900, 100, 1, 0, 0, 0);

-- Teleport, reset GO active state.
DELETE FROM `gameobject_scripts` WHERE `id`=3998714;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(3998714, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 2851.201, -711.075, 144.4, 5.15, 0, 'Teleport To SM'),
(3998714, 0, 0, 80, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Set GO Ready.');