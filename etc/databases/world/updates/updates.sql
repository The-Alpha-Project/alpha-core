delimiter $
begin not atomic

    -- 03/04/2022 1
    if (select count(*) from applied_updates where id='030420221') = 0 then
        -- Delete wrong Stratholme spawns.
        delete from spawns_creatures where spawn_entry1 > 160000;

        insert into applied_updates values ('030420221');
    end if;
	
	-- 03/04/2022 2
	if (select count(*) from applied_updates where id='030420222') = 0 then
        -- Teleport to Stormwind
        UPDATE `spell_target_position` SET `target_position_z` = '129.72' WHERE (`id` = '3561') and (`target_map` = '0');
        -- Teleport to Ironforge
        UPDATE `spell_target_position` SET `target_position_z` = '519.30' WHERE (`id` = '3562') and (`target_map` = '0');
        -- Teleport to Orgrimmar
        UPDATE `spell_target_position` SET `target_position_x` = '1552.5', `target_position_y` = '-4420.66', `target_position_z` = '8.94802' WHERE (`id` = '3567') and (`target_map` = '1');
		
        insert into applied_updates values ('030420222');
    end if;
	
    -- 03/04/2022 3
    if (select count(*) from applied_updates where id='030420223') = 0 then
        -- Dungar Longdrink, Thor, Thorgrum Borrelson, Gryth Thurden, Karos Razok, Tal, Doras, Devrak, Vesprystus, Michael Garrett, Shaethis Darkoak, Sulhasa. [4 -> 6 (2 QuestGiver + 4 FlightMaster)
        UPDATE `creature_template` SET `npc_flags` = '6' WHERE (`entry` in ('352', '523', '1572', '1573', '2226', '2995', '3310', '3615', '3838', '4551', '1233', '14242'));
		
        insert into applied_updates values ('030420223');
    end if;

    -- 04/04/2022 1
    if (select count(*) from applied_updates where id='040420221') = 0 then
        UPDATE `creature_template` SET `npc_flags` = 0 WHERE `npc_flags` = 1;
        UPDATE `creature_template` SET `npc_flags` = 1 WHERE `npc_flags` = 3;
        UPDATE `creature_template` SET `npc_flags` = 3 WHERE `npc_flags` = 5;
        UPDATE `creature_template` SET `npc_flags` = 2 WHERE `entry` = 3150;
        UPDATE `creature_template` SET `npc_flags` = 3 WHERE `entry` IN (233, 384, 491, 1243, 1261, 1460, 1694, 2357, 2393, 2670, 3362, 3413, 3489, 3685, 4200, 4241, 4256, 4730, 4731, 4885, 5520, 5594, 5749, 5750, 5753, 5815, 6027, 6301, 6328, 6373, 6374, 6376, 6382, 6548, 6568, 7564, 7683, 7772, 7775, 7854, 7952, 7955, 8125, 8403, 9087, 10118, 10216, 10618, 11038, 11056, 11057, 11536, 11555, 12031, 12384, 12807, 12919, 13018, 13418, 13429, 13431, 13433, 13434, 13435, 14322, 14437, 14738, 14739, 14847, 15011, 15012, 15197, 15199, 15471, 12384, 14450, 12776, 12776, 12944, 12944);

        insert into applied_updates values ('040420221');
    end if;

end $
delimiter ;