delimiter $
begin not atomic

    -- 15/04/2020 1
    if (select count(*) from applied_updates where id='150420201') = 0 then
        update gameobjects set entry = 4171 where entry = 47296;
        update gameobjects set entry = 4172 where entry = 47297;

        update spawns_creatures set ignored = 0 where spawn_entry1 = 4305;

        -- darkhounds
        UPDATE creatures SET display_id1='3916' WHERE  entry=1547;
        UPDATE creatures SET display_id1='3916' WHERE  entry=1548;

        -- bats
        UPDATE creatures SET display_id1='4185' WHERE  entry=1512;
        UPDATE creatures SET display_id1='4184' WHERE  entry=1513;
        UPDATE creatures SET display_id1='4184' WHERE  entry=1553;
        UPDATE creatures SET display_id1='1953' WHERE  entry=1554;

        -- rattlecage skeleton color fix
        UPDATE creatures SET display_id1='200' WHERE  entry=1890;

        -- some unique npcs that had different visuals
        UPDATE creatures SET display_id1='1200' WHERE  entry=1916;
        UPDATE creatures SET display_id1='200' WHERE  entry=1919;

        -- rot hides
        UPDATE creatures SET display_id1='543' WHERE  entry=1674;
        UPDATE creatures SET display_id1='3197' WHERE  entry=1941;


        -- Spawn_creatures table
        -- remove some npcs that were added later such as death guards
        UPDATE spawns_creatures SET ignored='1' WHERE  spawn_entry1 IN (3150, 12428, 10665, 7980, 12341, 11156, 10358, 12343, 10666, 9566, 6784);

        insert into applied_updates values('150420201');
    end if;

    -- 16/04/2020 1
    if (select count(*) from applied_updates where id='160420201') = 0 then
        REPLACE INTO `item_template` VALUES (23192,4,0,'Tabard of the Scarlet Crusade','',3865,1,0,1,28575,7143,19,-1,-1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,0,0,0,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0);
        update item_template set display_id = 6255 where entry = 11364;
        update item_template set display_id = 8021 where entry = 7997;


        insert into applied_updates values('160420201');
    end if;

end $
delimiter ;