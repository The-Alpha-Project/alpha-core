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

    -- 16/04/2020 2
    if (select count(*) from applied_updates where id='160420202') = 0 then
        update item_template set display_id = 9199 where entry = 5863;
        update creatures set display_id1 = 760 where display_id1 = 759;
        update creatures set display_id1 = 768 where entry = 4263;

        -- Elwynn
        -- Servants of Azora
        UPDATE creatures SET display_id1='3539' WHERE  entry=3096;
        UPDATE creatures SET display_id1='3538', display_id2='3539', display_id3='0', display_id4='0' WHERE  entry=1949;
        -- Eastvale npcs:
        UPDATE creatures SET display_id1='3274' WHERE  entry=1198;
        UPDATE creatures SET display_id1='89' WHERE  entry=1975;
        UPDATE creatures SET display_id1='3264' WHERE  entry=1650;

        -- Murlocs:
        UPDATE creatures SET display_id1='478' WHERE  entry=544;
        -- Blackrock orcs :
        UPDATE creatures SET display_id1='516' WHERE  entry=485;
        UPDATE creatures SET display_id1='112' WHERE  entry=440;
        UPDATE creatures SET display_id1='496' WHERE  entry=437;
        UPDATE creatures SET display_id1='516' WHERE  entry=4064;
        UPDATE creatures SET display_id1='496' WHERE  entry=4065;
        UPDATE creatures SET display_id1='113' WHERE  entry=436;
        UPDATE creatures SET display_id1='495' WHERE  entry=486;
        UPDATE creatures SET display_id1='456' WHERE  entry=334;
        UPDATE creatures SET display_id1='495' WHERE  entry=4464;
        UPDATE creatures SET display_id1='113' WHERE  entry=4463;
        UPDATE creatures SET display_id1='496' WHERE  entry=4462;
        UPDATE creatures SET display_id1='565' WHERE  entry=615;
        UPDATE creatures SET display_id1='517' WHERE  entry=435;
        UPDATE creatures SET display_id1='553' WHERE  entry=584;

        -- More npcs
        UPDATE creatures SET display_id1='3382' WHERE  entry=3097;
        UPDATE creatures SET display_id1='494' WHERE  entry=947;
        UPDATE creatures SET display_id1='3447' WHERE  entry=900;

        -- Westfall
        -- Smugglers :
        UPDATE creatures SET display_id1='2344', display_id2='2345' WHERE  entry=95;
        -- Benny Blaanco
        UPDATE creatures SET display_id1='2354' WHERE  entry=502;

        UPDATE creatures SET display_id1='2149' WHERE  entry=4305;

        UPDATE creatures SET display_id1='383' WHERE  entry=125;

        UPDATE creatures SET display_id1='69' WHERE  entry=832;

        -- Remove npcs
        UPDATE spawns_creatures SET ignored='1' WHERE spawn_entry1 IN (8096,8931,7067,7053,7056,7051,7024, 7052, 11072, 6491);
        UPDATE spawns_creatures SET ignored='1' WHERE spawn_entry1 IN (81411,14273,6295,6727,6728,8963,7009,6966,6778,6374,6121, 6306);


        insert into applied_updates values('160420202');
    end if;

    -- 17/04/2020 1
    if (select count(*) from applied_updates where id='170420201') = 0 then
        update creatures set npc_flags = 192 where subname = 'Guild Master';
        update creatures set npc_flags = 16 where subname = 'Spirit Healer';


        insert into applied_updates values('170420201');
    end if;

end $
delimiter ;