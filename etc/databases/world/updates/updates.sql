delimiter $
begin not atomic

    -- 27/03/2023 1
    if(select count(*) from applied_updates where id = '270320231') = 0 then
        -- Set subname for Brock Stoneseeker
        update creature_template set subname = "Cartography Trainer" where entry = 1681;
        -- Set subname for Karm Ironquill
        update creature_template set subname = "Cartography Supplies" where entry = 1764;
        -- Set subname for Berte & Evalyn
        update creature_template set subname = "Needs Model" where entry in(1880, 1881);
        -- Set faction for Evalyn
        update creature_template set faction = 35 where entry = 1881;
        -- Spawn Berte & Evalyn
        insert into spawns_creatures (spawn_entry1, position_x, position_y, position_z, orientation) VALUES
            (1880, -5333.290, -2955.981, 326.585, 3.444),
            (1881, -5337.208, -2957.187, 325.299, 3.469);
        -- Set faction and level 20 stats for Noma Bluntnose (identical to her husband Magistrate Bluntnose)
        update creature_template set faction = 57, level_min = 20, level_max = 20, health_min = 484, health_max = 484, armor = 852 where entry = 1879;
        -- Spawn Noma Bluntnose
        insert into spawns_creatures (spawn_entry1, position_x, position_y, position_z, orientation) VALUES
            (1879, -5296.893, -2953.931, 336.758, 2.971);

        -- make squirrels small again! and non-humanoid for a change!
        -- ... and Private Merle should not be a squirrel either.
        update creature_template set display_id1 = 134 where entry = 1412;
        update creature_template set display_id1 = 173 where entry = 1421;

        -- move Whaldak Darkbenk <Spider Trainer> to his true location
        update spawns_creatures set position_x = -4828.347, position_y = -2716.226, position_z = 328.332, orientation = 1.585 where spawn_id = 400071;
        -- set proper faction and have him spawn his spider pet
        update creature_template set faction = 57, spell_id1 = 7912 where entry = 2872;

        insert into applied_updates values ('270320231');
    end if;

    -- 29/03/2023 1
    if (select count(*) from `applied_updates` where id='290320231') = 0 then

        -- Alchemist Narett
        UPDATE `creature_template` SET `display_id1`=18 WHERE `entry`=4900;

        -- Brant Jasperbloom
        UPDATE `creature_template` SET `display_id1`=226 WHERE `entry`=4898;

        -- Uma Barthum
        UPDATE `creature_template` SET `display_id1`=15 WHERE `entry`=4899;

        -- Hans Weston
        UPDATE `creature_template` SET `display_id1`=17 WHERE `entry`=4886;

        -- Marie Holdston
        UPDATE `creature_template` SET `display_id1`=327 WHERE `entry`=4888;

        -- Gregor MacVince
        UPDATE `creature_template` SET `display_id1`=107 WHERE `entry`=4885;

        -- Helenia Olden
        UPDATE `creature_template` SET `display_id1`=162 WHERE `entry`=4897;

        -- Jensen Farran
        UPDATE `creature_template` SET `display_id1`=106 WHERE `entry`=4892;

        -- Guard Lasiter
        UPDATE `creature_template` SET `display_id1`=3138 WHERE `entry`=4973;

        -- Piter Verance
        UPDATE `creature_template` SET `display_id1`=17 WHERE `entry`=4890;

        -- Torq Ironblast
        UPDATE `creature_template` SET `display_id1`=2584 WHERE `entry`=4889;

        -- Dwane Wertle
        UPDATE `creature_template` SET `display_id1`=285 WHERE `entry`=4891;

        -- Morgan Stern
        UPDATE `creature_template` SET `display_id1`=280 WHERE `entry`=4794;

        -- Craig Nollward
        UPDATE `creature_template` SET `display_id1`=126 WHERE `entry`=4894;

        -- Bartender Lillian
        UPDATE `creature_template` SET `display_id1`=1049 WHERE `entry`=4893;

        -- Ingo Woolybush
        UPDATE `creature_template` SET `display_id1`=2584 WHERE `entry`=5388;

        -- Theramore Lieutenant
        UPDATE `creature_template` SET `display_id1` = 2981, `display_id2`= 2982, `display_id3` = 2983, `display_id4` = 2984 where `entry` = 4947;

        -- Theramore Skirmisher
        UPDATE `creature_template` SET `display_id1` = 2977, `display_id2` = 2978, `display_id3` = 2979, `display_id4` = 2980 where `entry` = 5044;

        insert into`applied_updates`values ('290320231');
    end if;

    -- 29/03/2023 3
    if (select count(*) from `applied_updates` where id='290320233') = 0 then

        -- Vilebranch Axe Trower
        UPDATE `creature_template` SET `display_id1` = 590, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2639;

        -- Vilebranch Witch Doctor
        UPDATE `creature_template` SET `display_id1` = 1117, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2640;

        -- Vilebranch Headhunter
        UPDATE `creature_template` SET `display_id1` = 1113, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2641;

        -- Vilebranch Shadowcaster
        UPDATE `creature_template` SET `display_id1` = 1115, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2642;

        -- Vilebranch Berserker
        UPDATE `creature_template` SET `display_id1` = 1118, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2643;

        -- Vilebranch Hideskinner
        UPDATE `creature_template` SET `display_id1` = 1154, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2644;

        -- Vilebranch Shadow Hunter
        UPDATE `creature_template` SET `display_id1` = 590, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2645;

        -- Vilebranch Blood Drinker
        UPDATE `creature_template` SET `display_id1` = 1118, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2646;

        -- Vilebranch Soul Eater
        UPDATE `creature_template` SET `display_id1` = 590, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2647;

        -- Vilebranch Aman'zasi Guard
        UPDATE `creature_template` SET `display_id1` = 1151, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2648;

        -- Whiterbark Scalper
        UPDATE `creature_template` SET `display_id1` = 337, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2649;

        -- Whiterbark Zealot
        UPDATE `creature_template` SET `display_id1` = 1113, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2650;

        -- Wetherbark Hideskinner
        UPDATE `creature_template` SET `display_id1` = 337, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2651;

        -- Wetherbark Venomblood
        UPDATE `creature_template` SET `display_id1` = 1116, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2652;

        -- Wetherbark Sadist
        UPDATE `creature_template` SET `display_id1` = 1114, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2653;

        -- Wetherbark Caller
        UPDATE `creature_template` SET `display_id1` = 1115, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 2654;

        -- Vilebranch Warrior
        UPDATE `creature_template` SET `display_id1` = 1118, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 4465;

        -- Vilebranch Scalper
        UPDATE `creature_template` SET `display_id1` = 1111, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 4466;

        -- Vilebranch Soothsayer
        UPDATE `creature_template` SET `display_id1` = 1115, `display_id2` = 0, `display_id3` = 0, `display_id4` = 0 where `entry` = 4467;

        -- Jade Sludge
        UPDATE `creature_template` SET `display_id1` = 1146 where `entry` = 4468;

        insert into`applied_updates`values ('290320233');
    end if;

    -- 29/03/2023 4
    if (select count(*) from `applied_updates` where id='290320234') = 0 then

        -- Defias Renegade Mage
        UPDATE `creature_template` SET `display_id1` = 263, `display_id2` = 278, `display_id3` = 0, `display_id4` = 0 where `entry` = 450;

        insert into`applied_updates`values ('290320234');
    end if;

    -- 30/03/2023 1
    if (select count(*) from `applied_updates` where id='300320231') = 0 then

        -- Update Juli Stormbraid
        update creature_template set display_id1 = 3067, faction = 57 where entry = 5145;
        -- Update Alyssa Griffith
        update creature_template set display_id1 = 1520 where entry = 1321;
        -- Update Jorgen
        update creature_template set display_id1 = 2960 where entry = 4959;
        -- Update Elyssia <Portal Trainer>
        update creature_template set display_id1 = 2204 where entry = 4165;
        -- Update Ainethil <Herbalism Trainer>
        update creature_template set display_id1 = 2215 where entry = 4160;
        -- Update Ursyn Ghull
        update creature_template set display_id1 = 2136 where entry = 3048;
        -- Update Bretta Goldfury
        update creature_template set display_id1 = 3058 where entry = 5123;
        -- Update Witherbark Shadow Hunter
        update creature_template set display_id2 = 4000 where entry = 2557;
        -- Updathe Rhinag
        update creature_template set display_id1 = 4075 where entry = 3190;
        -- Update Theresa Moulaine
        update creature_template set display_id1 = 1498 where entry = 1350;
        -- Update Defias Pirate
        update creature_template set display_id2 = 2348 where entry = 657;
        -- Update Belstaff Stormeye
        update creature_template set display_id2 = 3090 where entry = 2489;

        -- Update Dark Strand creatures
        update creature_template set display_id1 = 1642, display_id2 = 1643, display_id3 = 0, display_id4 = 0 where entry in(2336, 2337, 3879);

        -- Fix Tursk <Crawler Trainer>
        update creature_template set level_min = 50, level_max = 50, faction = 29, name = "Tursk", health_min = 1938, health_max = 1938, armor = 1341, spell_id1 = 7907 where entry = 3623;

        -- Update Charity Mipsy
        update creature_template set display_id1 = 213 where entry = 4896;

        -- Update Witherbark Zealot
        update creature_template set display_id1 = 337 where entry = 2650;
        -- Update Jade Ooze
        update creature_template set display_id1 = 1146 where entry = 2656;

        -- Despawn a bunch of objects related to NYI quest "Counterattack!" from The Barrens
        update spawns_gameobjects set ignored = 1 where spawn_id in(16771, 14777, 14779, 16770, 14776);
        -- Despawn a Fierce Blaze, the camp is NYI
        update spawns_gameobjects set ignored = 1 where spawn_id = 13512;

        -- Set correct quest objective for Regthar Deathgate's quests as he isn't west of Crossroads
        -- but in Crossroads proper in 0.5.3
        -- Kolkar Leaders, proof: https://web.archive.org/web/20040825094143/http://wow.allakhazam.com/db/quest.html?wquest=855
        update quest_template set Objectives = 'Bring 15 Centaur Bracers to Regthar Deathgate at the Crossroads.' where entry = 855;
        -- Same for quest Hezrul Bloodmark, proof: https://web.archive.org/web/20040903231152/http://www.goblinworkshop.com/quests/hezrul-bloodmark.html
        update quest_template set Objectives = "Bring Hezrul's Head to Regthar Deathgate at the Crossroads." where entry = 852;
        -- Same for quest Verog the Dervish, proof: https://web.archive.org/web/20040918103729/http://www.goblinworkshop.com/quests/verog-the-dervish.html
        update quest_template set Objectives = "Bring Verog's Head to Regthar Deathgate at the Crossroads." where entry = 851;
        -- Same for quest Kolkar Leaders, proof: https://web.archive.org/web/20040906103419/http://www.goblinworkshop.com/quests/kolkar-leaders.html
        update quest_template set Objectives = "Bring Barak's Head to Regthar Deathgate at the Crossroads." where entry = 850;

        -- Set placeholder for Kreenig Snarlsnout
        update creature_template set display_id1 = 1420 where entry = 3438;

        -- Add trainer id to Kil'hala
        update creature_template set trainer_id = 507 where entry = 3484;

        -- Update Deathguard Lundmark with placeholder
        update creature_template set display_id1 = 1021 where entry = 5725;

        -- Fix broken SFK cell doors (they spawn too low so you can't ever pass even when opened)
        update spawns_gameobjects set spawn_positionZ = 83.5 where spawn_id in(33219, 32445, 32446);

        -- Despawn objects affected by vanilla terrain change in Forgotten Pools/Barrens
        update spawns_gameobjects set ignored = 1 where spawn_id in(1814, 13202, 15688, 2725, 2611);

        -- Set placeholder for Barak Kodobane, Verog and Hezrul
        update creature_template set display_id1 = 1257 where entry in(3394, 3395, 3396);

        -- Despawn object from Camp Taujaro (shane cube with no use)
        update spawns_gameobjects set ignored = 1 where spawn_id = 14708;

        -- Have Harb Clawhoof spawn his pet cat
        update creature_template set spell_id1 = 7906 where entry = 3685;

        insert into`applied_updates`values ('300320231');
    end if;

    -- 31/03/2023 2
    if (select count(*) from `applied_updates` where id='310320232') = 0 then

        -- Fix Ratchet/Tanaris faction templates by aligning all these goblins with Booty Bay
        update creature_template set faction = 121 where faction in(474, 637);

        -- Despawn objects from Barrens affected by vanilla terrain changes
        update spawns_gameobjects set ignored = 1 where spawn_id in(13241, 13505, 13320, 12935, 2183, 13202, 1814, 2066, 15688, 2725, 1901, 2160);

        -- Fix quest Verog the Dervish - he's not near any command tents since there is no command tent yet.
        update quest_template set Details = "The centaur Verog the Dervish wanders the Barrens, and will be difficult to find. But he is based at the camps near the Stagnant Oasis to the southeast. It may be possible to draw him to you.$B$BTravel to the centaur camps near the Stagnant Oasis and attack the centaurs there. It will be dangerous, but if you can kill enough centaurs at those camps then they should raise an alarm. And Verog will come.$B$BBring me his head and I will place it with Barak Kodobane's." where entry = 851;

        -- Fix quest Echeyakee - he's not summoned by any horn, nor does the horn item even exist
        -- Also fix Objectives to mention the changed questgiver (see below)
        update quest_template set Objectives = "Bring Echeyakee's Hide to Jorn Skyseer at Camp Taujaro.", Details = "Whitemist, Echeyakee in our tongue, is the king of the savannah cats. With such steath does he hunt, he is like a thin white mist on the earth. And with such speed does he kill, his prey have no time for fear, or pain.$B$BHe is mercy, and he is death.$B$BYou will learn this, for I set you on the path to hunt Echeyakee. He stalks with his lion brethren, northeast of The Crossroads...$B$BGo. He is waiting.", OfferRewardText = "You have beaten Echeyakee, and though he hunts no more... his spirit is with you. He will show you the strength found in subtlety, and the honor in mercy.$B$BYour path is long, young $c. Stride it well." where entry = 881;

        -- Spawn Echeyakee at retail position of his lair - it's northeast of the Crossroads and with his "lion brethren"
        insert into spawns_creatures (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) values (3475, 1, 458.11, -3035.91, 91.6839, 0, 300, 300, 1);

        -- Move quest Echeyakee to Jorn Skyseer in Camp Taujaro. Evidence suggests he was originally the quest starter, not Sergra Darkthorn.
        update creature_quest_starter set entry = 3387 where quest = 881;
        update creature_quest_finisher set entry = 3387 where quest = 881;

        -- Fix quest text of The Angry Scytheclaws
        update quest_template set Details = "The Sunscale Scytheclaws have gone berserk. Normally they fight with Savannah Prowlers for food, keeping both predators scarce.$B$BWithout their natural enemy, they have started stalking the roads, picking off unwary travelers. You must thin their numbers, $N.$B$BFind the Sunscale Scytheclaws to the south, slay them and cut out their bladders. Use the Scytheclaw Bladders to defile the Scytheclaw nests, southwest of the Stagnant Oasis. WIth their nests defiled they will abandon them and move elsewhere.", RequestItemsText = "Is your task finished? Ponder the life of the Scytheclaw as you do it. There are important lessons within every creature's lifespawn.", OfferRewardText = "Some of the others believe I have been too heavy handed in my lesson. I know that you are simply following my orders, but I want you to consider the life of the creatures you are slaughtering.$B$BThough they are at times a nuisance, they only become threatening when we seek their slaughter. This days defilement will cause us more trouble than it will solve problems...", Objectives = "Kill Sunscale raptors and collect their bladders. Use the bladders on the 3 Scytheclaw nests. Return to Sergra Darkthorn in the Crossroads." where entry = 905;

        -- Despawn Horde Guards from a non-existant camp
        update spawns_creatures set ignored = 1 where spawn_id in(19402, 19361, 19326, 19438, 19412);
        -- Despawn shane cubed benches from the same camp
        update spawns_gameobjects set ignored = 1 where spawn_id in(13407, 13403);

        -- Fix quest text of Deepmoss Spider Eggs
        update quest_template set Details = "Spider egg omelettes are a new fad in Booty Bay! The problem is... Booty Bay's got no supply of eggs.$B$BI smell an opportunity!$B$BIn Windshear Crag -- in the Stonetalon Mountains to the northwest -- lives the deepmoss spider. Bring me its eggs and I'll pay a bundle!$B$BThe spiders like to creep under the shade of trees... Too bad the Venture Company cut down most of their trees!$B$BBut go to Windshear Crag anyway and look for deepmoss spiders. Their eggs will be clustered under what trees remain." where entry = 1069;

        insert into`applied_updates`values ('310320232');
    end if;


end $
delimiter ;
