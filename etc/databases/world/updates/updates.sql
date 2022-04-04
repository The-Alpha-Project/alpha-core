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
		-- Dungar Longdrink, Thor, Thorgrum Borrelson, Gryth Thurden, Karos Razok, Tal, Doras, Devrak, Michael Garrett. [4 -> 6 (2 QuestGiver + 4 FlightMaster)
		UPDATE `alpha_world`.`creature_template` SET `npc_flags` = '6' WHERE (`entry` in ('352', '523', '1572', '1573', '2226', '2995', '3310', '3615', '4551'));
		
		insert into applied_updates values ('030420223');
    end if;

	
end $
delimiter ;