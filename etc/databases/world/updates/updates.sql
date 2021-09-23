delimiter $
begin not atomic

    -- 23/09/2021 1
    if (select count(*) from applied_updates where id='230920211') = 0 then
    
        -- Remove all useless braziers from IF
        UPDATE spawns_gameobjects 
        SET ignored=1
        WHERE spawn_id IN (1775, 1572, 1566,1483, 969, 827, 835, 790, 749, 666, 658, 5413, 5403, 5206, 5158, 5165, 5116, 5133, 5125, 5082, 5013, 4593, 1948, 1906, 1964, 786, 805, 664, 670, 640, 114, 1848, 1870, 1826, 1780, 5161, 5143);
        
        insert into applied_updates values ('230920211');
    end if;  

end $
delimiter ;