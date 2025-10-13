-- Darnassus Game Object Teleporter

-- GO template.
DELETE FROM `gameobject_template` WHERE `entry`=3000493;
INSERT INTO `gameobject_template` VALUES (3000493, 1, 327, "[CUSTOM] Darnassus Teleporter", 79, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "");

-- GO spawn entry.
DELETE FROM `spawns_gameobjects` WHERE `spawn_entry`=3000493;
INSERT INTO `spawns_gameobjects` VALUES (3998715, 3000493, 1, 8724.637, 1007.518, 14.676, 4.256, 0, 0, 0, 0, 900, 900, 100, 1, 0, 0, 0);

-- Teleport, reset GO active state.
DELETE FROM `gameobject_scripts` WHERE `id`=3998715;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(3998715, 0, 0, 6, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 9951.630, 2153.080, 1327.683, 1.533, 0, 'Teleport To Darnassus'),
(3998715, 0, 0, 80, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Set GO Ready');

-- Reposition 2 Darnassus Sentinels.
UPDATE `spawns_creatures` SET `position_x` = 8716.393, `position_y` = 1005.549, `position_z` = 13.437, orientation = 4.988 WHERE spawn_id = 46833;
UPDATE `spawns_creatures` SET `position_x` = 8728.609, `position_y` = 999.079, `position_z` = 16.846, orientation = 3.369 WHERE spawn_id = 46822;