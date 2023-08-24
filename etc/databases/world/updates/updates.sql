delimiter $
begin not atomic
    -- 25/08/2023 1
	if (select count(*) from applied_updates where id='250820231') = 0 then
	    -- Replace faction 875 (Gnome, doesn't exist in 0.5.3) with faction 57. At this moment all of these had faction
	    -- 64 which makes them Neutral and not fitting for friendly NPCs.
        UPDATE `creature_template` set `faction` = 57 WHERE `entry` IN (374, 460, 1676, 2682, 2683, 3133, 3181, 3290, 4081, 5100, 5114, 5127, 5132, 5144, 5151, 5152, 5157, 5158, 5162, 5163, 5167, 5169, 5172, 5175, 5177, 5178, 5518, 5519, 5520, 5569, 5612, 6119, 6120, 6169, 6328, 6376, 6382, 6826, 7207, 7312, 7950, 7954, 7955, 7978, 8416, 8681, 9099, 9676, 10455, 10456, 11026, 11028, 11029, 11037, 12784, 13000, 14481, 14724, 15353, 15763, 15707, 15434, 15450, 15455, 15456, 15733, 7954);

        insert into applied_updates values ('250820231');
    end if;

end $
delimiter ;