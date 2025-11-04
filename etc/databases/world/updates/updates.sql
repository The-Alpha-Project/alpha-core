delimiter $
begin not atomic

    -- 31/10/2025 1
    if (select count(*) from applied_updates where id='311020251') = 0 then
        -- Fix Chickens not being melee attackable.
        UPDATE creature_template SET npc_flags = 0 WHERE entry = 620;

        insert into applied_updates values ('311020251');
    end if;

    -- 31/10/2025 2
    if (select count(*) from applied_updates where id='311020252') = 0 then
        -- Remove wrong text said at the end of Skirmish at Echo Ridge.
        -- This text should be said upon accepting Report to Goldshire.
        -- Proof: https://www.youtube.com/watch?v=SH3HhIsDZ4k&t=373s
        DELETE FROM `quest_end_scripts` WHERE `id`=21;
        UPDATE `quest_template` SET `CompleteScript`=0 WHERE `entry`=21;

        insert into applied_updates values ('311020252');
    end if;

    -- 02/11/2025 1
    if (select count(*) from applied_updates where id='021120251') = 0 then
        -- Fix level for Healing Wards.
        -- Closes https://github.com/The-Alpha-Project/alpha-core/issues/1531
        UPDATE `creature_template` SET `level_min` = 1, `level_max` = 1 WHERE `entry` IN (2992, 3560, 3844);

        insert into applied_updates values ('021120251');
    end if;

    -- 03/11/2025 1
    if (select count(*) from applied_updates where id='031120251') = 0 then
        -- Closes https://github.com/The-Alpha-Project/alpha-core/issues/1503
        -- Events list for Snufflenose Gopher
        DELETE FROM `creature_ai_events` WHERE `creature_id`=4781;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES
        (478101, 4781, 122101, 1, 0, 40, 1, 2000, 30000, 20000, 30000, 478101, 0, 0, 'Snufflenose');

        DELETE FROM `creature_ai_scripts` WHERE `id`=478101;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
        (478101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1592, 0, 0, 0, 0, 0, 0, 0, 0, 'Snufflenose - Sniff Text'),
        (478101, 0, 0, 15, 6900, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Snufflenose - Create Tuber');

        DELETE FROM `conditions` WHERE `condition_entry` in (122101, 122102, 122103, 122104);
        -- 122101: (122102: GameObject 20920 Is Within 60 Yards Of The Target) And (122103:  Not (GameObject 20920 Is Within 5 Yards Of The Target)) And (122104: Friendly Player Within 15 Yards Of The Target)
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122101, -1, 122102, 122103, 122104, 0, 0);
        -- 122102: GameObject 20920 Is Within 60 Yards Of The Target
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122102, 21, 20920, 60, 0, 0, 0);
        -- 122103:  Not (GameObject 20920 Is Within 5 Yards Of The Target)
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122103, 21, 20920, 5, 0, 0, 1);
        -- 122104: Friendly Player Within 15 Yards Of The Target
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (122104, 56, 2, 15, 0, 0, 0);

        insert into applied_updates values ('031120251');
    end if;

end $
delimiter ;
