delimiter $
begin not atomic
    -- 05/05/2021 1
    if (select count(*) from applied_updates where id='050520211') = 0 then
        delete from item_template where entry = 23192;
        update item_template set display_id = 3865 where entry = 7725;
        insert into applied_updates values ('050520211');
    end if;

    -- 06/05/2021 1
    if (select count(*) from applied_updates where id='060520211') = 0 then
        update quest_template set OfferRewardText = 'Another one of Eitrigg''s recruits, hm?$B$BA sorry state of affairs we find ourselves in if this is the best the Horde can produce. No matter. By the time we think you''re ready to leave the Valley, you''ll be a proud warrior of the Horde.', RewXP = 15 where entry = 787;
        insert into applied_updates values ('060520211');
    end if;

    -- 11/05/2021 1
    if (select count(*) from applied_updates where id='110520211') = 0 then
        UPDATE `creature_template` set `npc_flags` = 16388, `level_min` = 30, `level_max` = 30 WHERE `entry` = 5814;
        DELETE FROM `npc_vendor` WHERE `entry` = 5814;
        INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (5814, 2511);
        insert into applied_updates values ('110520211');
    end if;

    -- 11/05/2021 2
    if (select count(*) from applied_updates where id='110520212') = 0 then
        delete from spawns_gameobjects where spawn_id = 49853;
        insert into applied_updates values ('110520212');
    end if;
	
end $
delimiter ;