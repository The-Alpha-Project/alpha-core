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
        UPDATE `alpha_world`.`spell_target_position` SET `target_position_z` = '129.72' WHERE (`id` = '3561') and (`target_map` = '0');
        -- Teleport to Ironforge
        UPDATE `alpha_world`.`spell_target_position` SET `target_position_z` = '519.30' WHERE (`id` = '3562') and (`target_map` = '0');
        -- Teleport to Orgrimmar (X,Y placement is still wrong in this one, but player wont fall throught the world anymore)
        UPDATE `alpha_world`.`spell_target_position` SET `target_position_z` = '120.99' WHERE (`id` = '3567') and (`target_map` = '1');
		
        insert into applied_updates values ('030420222');
    end if;
	
end $
delimiter ;