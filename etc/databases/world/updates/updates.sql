delimiter $
begin not atomic
    -- 12/07/2024 1
    if (select count(*) from `applied_updates` where id='120720241') = 0 then
        -- The Defias Brotherhood: The Defias Traitor should have a delay before starting to run.
        DELETE FROM `quest_start_scripts` WHERE `id`=155;
        INSERT INTO `quest_start_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (155, 0, 0, 61, 155, 600, 0, 0, 0, 0, 0, 8, 0, 15502, 1019, 15501, 0, 0, 0, 0, 0, 'The Defias Brotherhood: Start Scripted Map Event'),
        (155, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Say Text'),
        (155, 0, 2, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Remove Questgiver Flag'),
        (155, 3, 3, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Set Run'),
        (155, 3, 4, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'The Defias Brotherhood: The Defias Traitor - Start Waypoints');
        insert into applied_updates values ('120720241');
    end if;
end $
delimiter ;