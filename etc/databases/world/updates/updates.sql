delimiter $
begin not atomic

    -- 27/03/2023 2
    if(select count(*) from applied_updates where id = '270320232') = 0 then
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

        insert into applied_updates values ('270320232');
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
        update spawns_gameobjects set ignored = 1 where spawn_id in(13241, 13505, 13320, 12935, 2183, 13202, 1814, 2066, 15688, 2725, 1901, 2160, 13314, 2501, 1992);

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
        update quest_template set Details = "The Sunscale Scytheclaws have gone berserk. Normally they fight with Savannah Prowlers for food, keeping both predators scarce.$B$BWithout their natural enemy, they have started stalking the roads, picking off unwary travelers. You must thin their numbers, $N.$B$BFind the Sunscale Scytheclaws to the south, slay them and cut out their bladders. Use the Scytheclaw Bladders to defile the Scytheclaw nests, southwest of the Stagnant Oasis. With their nests defiled they will abandon them and move elsewhere.", RequestItemsText = "Is your task finished? Ponder the life of the Scytheclaw as you do it. There are important lessons within every creature's lifespawn.", OfferRewardText = "Some of the others believe I have been too heavy handed in my lesson. I know that you are simply following my orders, but I want you to consider the life of the creatures you are slaughtering.$B$BThough they are at times a nuisance, they only become threatening when we seek their slaughter. This days defilement will cause us more trouble than it will solve problems...", Objectives = "Kill Sunscale raptors and collect their bladders. Use the bladders on the 3 Scytheclaw nests. Return to Sergra Darkthorn in the Crossroads." where entry = 905;

        -- Despawn Horde Guards from a non-existant camp
        update spawns_creatures set ignored = 1 where spawn_id in(19402, 19361, 19326, 19438, 19412);
        -- Despawn shane cubed benches from the same camp
        update spawns_gameobjects set ignored = 1 where spawn_id in(13407, 13403);

        -- Fix quest text of Deepmoss Spider Eggs
        update quest_template set Details = "Spider egg omelettes are a new fad in Booty Bay! The problem is... Booty Bay's got no supply of eggs.$B$BI smell an opportunity!$B$BIn Windshear Crag -- in the Stonetalon Mountains to the northwest -- lives the deepmoss spider. Bring me its eggs and I'll pay a bundle!$B$BThe spiders like to creep under the shade of trees... Too bad the Venture Company cut down most of their trees!$B$BBut go to Windshear Crag anyway and look for deepmoss spiders. Their eggs will be clustered under what trees remain." where entry = 1069;

        -- Fix Z of two NPCs in Sepulcher
        update spawns_creatures set position_z = 104.877 where spawn_id in(17622, 17625);

        -- Fix Z for Barrel of Milk in Stonetalon Mountains
        update spawns_gameobjects set spawn_positionZ = 22.9 where spawn_id = 47559;

        -- Restore quest Goblin Invaders
        update quest_template set Objectives = "Kill 12 Venture Co. Cutters, 10 Venture Co. Grinders and 6 Venture Co. Loggers, then return to Seereth Stonebreak on the border of Stonetalon and the Barrens.", ReqCreatureOrGOId3 = 3989, ReqCreatureOrGOCount3 = 6 where entry = 1062;

        -- Despawn a floating book in Ratchet, table is missing
        update spawns_gameobjects set ignored = 1 where spawn_id = 13452;

        -- Remove invalid display_id from Southsea Cannoneer
        update creature_template set display_id2 = 3828, display_id3 = 0 where entry = 3382;
        -- Same for Southsea Brigand
        update creature_template set display_id4 = 0 where entry = 3381;
        -- And for Southsea Cutthroat
        update creature_template set display_id2 = 3836, display_id3 = 0, display_id4 = 0 where entry = 3383;

        -- Set proper faction for Theramore units in The Barrens - they need to be hostile to Horde
        update creature_template set faction = 150 where entry in(3454, 3455, 3393, 3385, 3386);

        -- Despawn a bunch of objects from not-yet-existant Northwatch Hold
        update spawns_gameobjects set ignored = 1 where spawn_id in(13360, 12705, 13365, 13354);

        -- Spawn Cannoneers Smythe & Wesson
        update spawns_creatures set ignored = 0, position_x = -2088.116, position_y = -3683.056, position_z = 50.397, orientation = 4.450 where spawn_id = 12165;
        update spawns_creatures set ignored = 0, position_x = -2097.684 , position_y = -3675.315, position_z = 50.254, orientation = 4.450 where spawn_id = 12166;

        -- Slightly move a Lost Barrens Kodo spawn as it spawns inside a house
        update spawns_creatures set position_x = 753.196, position_y = -2777.454, position_z = 92.003 where spawn_id = 15119;

        -- Despawn unused object Tool Bucket from Barrens
        update spawns_gameobjects set ignored = 1 where spawn_entry = 161752;

        -- Despawn unused object Gallywix' Lockbox and trap object
        update spawns_gameobjects set ignored = 1 where spawn_entry in(129127, 130126);

        -- Despawn Venture Co. Drudgers spawning under water
        update spawns_creatures set ignored = 1 where spawn_id in(20791, 20784);

        -- Despawn shane cubed benches
        update spawns_gameobjects set ignored = 1 where spawn_id in(13396, 13392);

        -- Despawn various shane cubed objects that serve no purpose in 0.5.3
        update spawns_gameobjects set ignored = 1 where spawn_id in(13531, 20389, 10808, 12353, 14685, 17202, 17198, 17203, 17204, 17205, 40668, 47699, 32611, 14106, 20637, 1712, 1657, 16873, 3996126, 28294, 12863, 12872, 12864, 15175, 15176, 40694, 42107, 42108, 42109, 14411, 14412, 14422, 33253, 33221, 14441, 14393, 14394, 47966, 47968, 49828, 10919, 40696, 40698, 17228, 18013, 50016, 399472, 230924, 6910, 50158, 99847, 11389, 6447, 17633, 7024, 11922, 32045, 399323, 48357, 48460, 42112, 4523, 98643, 17972, 6942, 13500, 17428, 17598, 17599, 17600, 17926, 17500, 2, 33240, 5258, 6813, 6936, 17597, 17745);
        update spawns_gameobjects set ignored = 1 where spawn_entry in(89634, 90566, 90858, 102985, 126052, 126053, 141812, 141853, 141857, 141858, 141859, 141931, 142175, 142176, 142208, 142209, 142210, 142211, 142212, 142213, 142344, 142345, 142475, 142476, 142487, 142488, 142696, 143979, 147516, 147517, 148418, 148419, 148420, 148421, 148503, 148837, 148883, 148937, 124370, 149432, 149433, 150140, 153204, 153205, 157816, 157817, 157818, 157819, 157820, 161527, 162024, 164870, 175084, 175085, 175207, 175226, 175227, 175233, 175246, 175247, 175248, 175249, 175324, 175329, 175330, 175331, 175490, 175491, 175492, 175586, 175524, 175587, 175787, 175788, 175889, 175890, 175891, 175894, 175924, 175925, 175926, 175928, 175933, 175659, 175944, 175948, 176157, 176165, 176188, 176190, 176196, 176197, 176198, 176208, 176591, 176209, 176865, 176210, 176213, 176214, 176306, 176361, 176393, 176392, 176582, 176635, 176745, 176747, 176967, 176968, 176969, 176970, 176971, 176972, 176973, 176987, 176988, 176989, 176990, 176991, 176992, 176993, 176994, 177045, 177185, 177188, 177198, 177226, 177227, 177243, 177249, 177250, 177251, 177252, 177253, 177254, 177255, 177256, 177264, 177271, 177289, 177307, 177365, 177366, 177369, 177397, 177398, 177399, 177400, 177484, 177485, 177644, 177667, 177677, 177747, 177785, 177787, 177791, 177794, 177793, 177804, 177805, 177806, 177884, 177927, 177964, 178087, 178089, 178125, 178144, 178146, 178147, 178195, 178247, 178324, 178325, 178386, 178553, 178571, 178934, 179144, 179224, 179469, 179736, 179827, 179879, 180100, 180104, 180323, 180335, 180811, 180866, 186218, 68865, 164651);
        -- Set placeholders for Azsharite Formation
        update gameobject_template set displayId = 219 where entry in(152620, 152621, 152631);

        -- Fix faction for Wizzlecrank's Shredder
        update creature_template set faction = 121 where entry = 3439;

        -- Fix Ransin Donner to actually be a Crab Trainer
        update creature_template set faction = 11, trainer_type = 3, trainer_class = 3, trainer_id = 282, spell_id1 = 7907 where entry = 2943;
        -- Fix Kurll to be a Cat Trainer
        update creature_template set trainer_type = 3, trainer_class = 3, spell_id1 = 7906, trainer_id = 277 where entry = 3621;
        -- Fix Rarck to be a Raptor Trainer
        update creature_template set trainer_type = 3, trainer_class = 3, spell_id1 = 7910, trainer_id = 285, faction = 85 where entry = 3625;
        -- Fix Harb Clawhoof to be a Cat Trainer
        update creature_template set trainer_type = 3, trainer_class = 3, trainer_id = 277 where entry = 3685;
        -- Fix Alanndrian Nightsong to be a Tallstrider Trainer
        update creature_template set trainer_type = 3, trainer_class = 3, trainer_id = 286, spell_id1 = 7913 where entry = 3702;
        -- Fix Galthuk to be a Bear Trainer
        update creature_template set trainer_type = 3, trainer_class = 3, trainer_id = 278, spell_id1 = 7903 where entry = 4043;

        -- Rewrite quest Blueleaf Tubers to it's original form
        -- Proof: https://web.archive.org/web/20040908182039/http://www.goblinworkshop.com/quests/redleaf-tubers.html
        update quest_template set Title = "Redleaf Tubers", Details = "Redleaf tubers are a delicacy around the world! But they're rare, very rare. The only place to find them is here in the Barrens, deep in the earth, in Razorfen Kraul.$B$BAnd even then, they're impossible to find unless you know just where to look! That's why I've trained these snufflenose gophers to find them for me. They have great noses and can smell a tuber from fifty paces away.$B$BIt won't be easy, but if you get me some tubers I'll pay you handsomely.", Objectives = "Grab a Crate with Holes. Grab a Snufflenose Command Stick. Grab and read the Snufflenose Owner's Manual. In Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher, and use the Command Stick on the gopher to make it search for Tubers. Bring 10 Redleaf Tubers, the Snufflenose Command Stick and the Crate with Holes to Mebok Mizzyrix in Ratchet." where entry = 1221;
        -- Rename Blueleaf Tubers object to Redleaf Tubers
        update gameobject_template set name = "Redleaf Tuber" where entry = 20920;

        -- Restore quest Shards of a God (replaces Spirits of the Wind)
        update quest_template set Title = "Shards of a God", SpecialFlags = 0, PrevQuestId = 0, Details = "When the vines came out of the earth, they often forced veins of minerals to surface also.$B$BOne special mineral found near the vines has been named blood ore. The Bristleback tribe think the blood ore is sacred and part of Agammagan's body. They sometimes carry shards of it for good fortune.$B$BI think I may be able to create a new alloy from the ore if I were to get enough of it. Find the Bristleback to the south of here, across the dry riverbed, and bring me back as many blood shards as you can.", Objectives = "Bring 20 Blood Shards to Tatternack Steelforge at the Crossroads.", ReqItemCount1 = 20, RewOrReqMoney = 854, RewSpell = 0, RewSpellCast = 0, OfferRewardText = "", RequestItemsText = "" where entry = 889;
        -- Move quest Shards of a God to Tatternack Steelforge
        update creature_quest_starter set entry = 3433 where quest = 889;
        update creature_quest_finisher set entry = 3433 where quest = 889;

        -- Restore original quest details of Weapons of Choice
        update quest_template set Details = "The warchief has instructed me to study all kinds of weapons and armor. He thinks there's something to be learned from even the most pathetic of cultures.$B$BTake the Razormane quillboars to the south, beyond the Field of Giants. As far as I know, they have no skilled blacksmiths, but I'm told they've started to develop sturdier weapons. I'd like to get my hands on a few to learn their techniques.$B$BIf you come across some of their rarer items, bring them to me, and you'll bring honor to the Horde." where entry = 893;

        -- Set proper display_id for Watcher Mocarski
        update creature_template set display_id1 = 2395 where entry = 827;

        -- Set trainer list for Teg Dawnstrider <Enchanting Trainer>
        update creature_template set trainer_id = 508 where entry = 3011;

        -- Fix display_id for Jezelle's Imp and Succubus
        update creature_template set display_id1 = 1213 where entry = 5730;
        update creature_template set display_id1 = 159 where entry = 5728;

        -- Fix Helena Atwood's OOC script (used NYI spell id)
        update creature_ai_scripts set datalong = 1485 where id = 566901;

        -- Restore Skeletal Enforcer based on level 24-25 Skeletal Fiend
        update creature_template set name = "Skeletal Enforcer", faction = 21, static_flags = 0, level_min = 24, level_max = 25, health_min = 664, health_max = 712, armor = 1009, dmg_min = 36, dmg_max = 46, attack_power = 106, loot_id = 531, pickpocket_loot_id = 531, gold_min = 33, gold_max = 48, ai_name = 'EventAI', movement_type = 1, mechanic_immune_mask = 8602131 where entry = 725;
        -- Spawn Skeletal Enforcer as replacement for some Skeletal Fiend and Skeletal Horror on Duskwood Cemetary
        update spawns_creatures set spawn_entry1 = 725 where spawn_id in(4941, 5160, 5040, 4944);
        update spawns_creatures set spawn_entry1 = 725 where spawn_id in(5178, 4993, 4974, 5942);

        -- Set Lord Daval display_id
        update creature_template set display_id1 = 2039 where entry = 1749;
        -- Revert Scarlet Mage display_id to placeholder
        update creature_template set display_id1 = 1640, display_id2 = 1641 where entry = 1832;

        insert into`applied_updates`values ('310320232');
    end if;

    -- 31/03/2023 1
    if (select count(*) from `applied_updates` where id='310320231') = 0 then

        -- Set Unique models for Belstaff (it was set to display_id2 instead of 1 on recent change)
        update creature_template set display_id1 = 3090, display_id2 = 0 where entry = 2489;

        -- Set placeholder for NE male
        update creature_template set display_id1 = 2572 where entry in (3583, 4182, 4183, 4189, 4192, 4193, 4265, 3672, 3797, 4307, 4050, 4052, 4753, 2077);

        -- Set placeholder for NE female
        update creature_template set display_id1 = 2575 where entry in (4185, 4186, 4190, 4191, 4266, 4188, 4051, 4184, 4521, 4194);
        update creature_template set display_id2 = 2575 where entry = 4052;

        -- Set placeholder for Tauren male
        update creature_template set display_id1 = 2578 where entry in (4451, 3222, 4310, 2987, 2549, 4309, 3689, 3978, 3050);

        -- Set placeholder for Tauren female
        update creature_template set display_id1 = 2579 where entry in (4046, 3447);

        -- Set placeholder for UD male
        update creature_template set display_id1 = 1027 where entry in (5414, 2934, 5748, 4488, 5651, 223);

        -- Set placeholder for UD female
        update creature_template set display_id1 = 1029 where entry in (2802);

        -- Set placeholder for Gnome male
        update creature_template set display_id1 = 2581 where entry in (3666);
            -- Since we have evidence showing Ruppo (engineer) using old gnome, we apply old gnomes on engineer related NPCs
        update creature_template set display_id1 = 352 where entry in (374, 1676, 2687, 3133, 1454, 2683);

        -- Set placeholder for Gnome female
        update creature_template set display_id1 = 2590 where entry in (1454);

        -- Set placeholder for Troll male
        update creature_template set display_id1 = 2588 where entry in (2704, 3410, 3406, 3402, 3401);

        -- Set placeholder for Troll female
        update creature_template set display_id1 = 2589 where entry in (3407, 3404, 3405, 3408);

        -- Set placeholder for Orc male
        update creature_template set display_id1 = 2576 where entry in (2856, 4485, 2091, 2108, 2858, 986, 4752, 4618, 2857, 4047);

        -- Set placeholder for Orc female
        update creature_template set display_id1 = 2577 where entry in (3411);

        insert into`applied_updates`values ('310320231');
    end if;

    -- 01/04/2023 1
    if (select count(*) from `applied_updates` where id='010420231') = 0 then
        UPDATE `quest_template` SET `NextQuestId` = '1091', `ExclusiveGroup` = '-1079' WHERE (`entry` = '1079');
        UPDATE `quest_template` SET `PrevQuestId` = '0', `NextQuestId` = '1091', `ExclusiveGroup` = '-1079' WHERE (`entry` = '1080');
        UPDATE `gameobject_template` SET `data0` = '0' WHERE (`entry` = '24776');
        UPDATE `item_template` SET `spellid_1` = '0' WHERE (`entry` = '6145');

        insert into`applied_updates`values ('010420231');
    end if;

    -- 04/04/2023 1
    if (select count(*) from `applied_updates` where id='040420231') = 0 then
        -- Fix alternate display_id for Cenarion NPCs, closes #1120
        update creature_template set display_id2 = 0 where entry in(4041, 3797);

        -- Fix remaining Scarlet NPCs
        update creature_template set display_id1 = 1611, display_id2 = 1612 where entry = 4493;
        update creature_template set display_id1 = 1640, display_id2 = 1641, display_id3 = 0, display_id4 = 0 where entry = 4494;

        -- Fix Maris Granger
        update creature_template set subname = "Mail Armor Merchant", npc_flags = 1 where entry = 1292;
        -- Copy from another Mail Armor Merchant's vendor table
        INSERT INTO npc_vendor (entry, item) SELECT 1292, item FROM npc_vendor WHERE entry = 1349;

        -- Change Tannysa to Tailoring Trainer
        update creature_template set subname = "Tailoring Trainer", trainer_id = 507 where entry = 5566;
        -- Relocate Eldraith to The Park
        update spawns_creatures set position_x = -8722.818, position_y = 1172.953, position_z = 98.34, orientation = 3.304 where spawn_entry1 = 5503;

        -- Fixes for Thousand Needles NPCs
        update creature_template set display_id1 = 2578 where entry = 2986;
        update creature_template set display_id1 = 2576 where entry in(4483, 4545, 4546, 4547);
        update creature_template set display_id1 = 1452, display_id2 = 1453 where entry = 5523;
        update creature_template set display_id1 = 2576 where entry = 4875;
        update creature_template set display_id1 = 2578 where entry in(4876, 4878);
        update creature_template set display_id1 = 2579 where entry = 4877;

        -- Fix Valyen Wolfsong and spawn his pet
        update creature_template set faction = 79 where entry in(4207, 4245);
        insert into spawns_creatures (spawn_entry1, map, position_x, position_y, position_z, orientation) VALUES (4245, 1, 10124.806, 2540.995, 1317.636, 2.174);

        -- Fix quest text of 1072 "An Old Colleague"
        update quest_template set Details = "The device I'm thinking about is my most advanced version to date. But we'll need a special potion if it's to work. I'm thinking we might as well get the really good stuff since this mission could be your last if you decide to help.$B$BAnd for that, we're going to need some potent explosives: Nitromirglyceronium.$B$BThe only person who can make NG-5 is an ol' friend of mine in Ironforge: Lomac Gearstrip.$B$BIf you can talk him into making us some NG-5, I'll get to work on placement for my devices…" where entry = 1072;

        insert into`applied_updates`values ('040420231');
    end if;
        
    -- 05/04/2023 1
    if (select count(*) from `applied_updates` where id='050420231') = 0 then

        -- Witch doctor Unbagwa
        UPDATE `creature_template`
        SET `display_id1`=1115
        WHERE `entry`=1449;
        
        -- Rot Hide Bruiser
        UPDATE `creature_template`
        SET `display_id1`=858
        WHERE `entry`=1944;
        
        -- Shadow Sprite
        UPDATE `creature_template`
        SET `display_id1`=1185
        WHERE `entry`=2003;
        
        -- Vicious Grell
        UPDATE `creature_template`
        SET `display_id1`=1015
        WHERE `entry`=2005;
        
        -- Maruk Wyrmscale
        UPDATE `creature_template`
        SET `display_id1`=1139
        WHERE `entry`=2090;
        
        -- Shadra
        UPDATE `creature_template`
        SET `display_id1`=1160
        WHERE `entry`=2707;
        
        -- Wooly kodo
        UPDATE `creature_template`
        SET `display_id1`=1230
        WHERE `entry`=3237;
        
        -- Elder Mystic Razorsnout
        UPDATE `creature_template`
        SET `display_id1`=1420
        WHERE `entry`=3270;
        
        -- Kuz
        UPDATE `creature_template`
        SET `display_id1`=1420
        WHERE `entry`=3436;
        
        -- Devouring Ectoplasm
        UPDATE `creature_template`
        SET `display_id1`=360
        WHERE `entry`=3638;
        
        -- Pridewing Patriarch
        UPDATE `creature_template`
        SET `display_id1`=2298
        WHERE `entry`=4015;
        
        -- Strashaz Serpent Guard
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4366;
        
        -- Strashaz Siren
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4371;
        
        -- Elder Murk Thresher 
        UPDATE `creature_template`
        SET `display_id1`=2602
        WHERE `entry`=4390;
        
        -- Mudrock Snapjaw
        UPDATE `creature_template`
        SET `display_id1`=1244
        WHERE `entry`=4400;
        
        -- Deepstrider Searcher 
        UPDATE `creature_template`
        SET `display_id1`=1135
        WHERE `entry`=4687;
        
        -- Ogron
        UPDATE `creature_template`
        SET `display_id1`=655
        WHERE `entry`=4983;
        
        -- Coral Shark 
        UPDATE `creature_template`
        SET `display_id1`=1557, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5434;
        
        -- Sand Shark
        UPDATE `creature_template`
        SET `display_id1`=1557, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5435;
        
        -- Noboru the Cudgel 
        UPDATE `creature_template`
        SET `display_id1`=628
        WHERE `entry`=5477;
        
        -- Ongeku
        UPDATE `creature_template`
        SET `display_id1`=628
        WHERE `entry`=5622;
        
        -- Moshogg spellcrafter
        UPDATE `creature_template`
        SET `display_id1`=326
        WHERE `entry`=710;
        
        -- Moshogg Butcher
        UPDATE `creature_template`
        SET `display_id1`=655
        WHERE `entry`=723;

        -- Moshogg Lord
        UPDATE `creature_template`
        SET `display_id1`=655
        WHERE `entry`=680;
        
        -- Mayzoth
        UPDATE `creature_template`
        SET `display_id1`=33
        WHERE `entry`=818;
        
        -- Twilight runner
        UPDATE `creature_template`
        SET `display_id1`=633
        WHERE `entry`=4067;
        
        -- Galak Centaur
        UPDATE `creature_template`
        SET `display_id1`=2292
        WHERE `entry`=2967;
        
        -- Galak Outrunner
        UPDATE `creature_template`
        SET `display_id1`=2292
        WHERE `entry`=2968;
        
        -- Barak
        UPDATE `creature_template`
        SET `display_id1`=1349
        WHERE `entry`=3394;
        
        -- Deepstrider
        UPDATE `creature_template`
        SET `display_id1`=1135
        WHERE `entry`=4686;
        
        -- Coast Strider
        UPDATE `creature_template`
        SET `display_id1`=1135
        WHERE `entry`=5466;
        
        -- Anillia
        UPDATE `creature_template`
        SET `display_id1`=2722
        WHERE `entry`=3920;
        
        -- Boss thogrun
        UPDATE `creature_template`
        SET `display_id1`=1054
        WHERE `entry`=2944;
        
        -- Broken Tooth
        UPDATE `creature_template`
        SET `display_id1`=1978
        WHERE `entry`=2850;
        
        -- Swapwalker Elder
        UPDATE `creature_template`
        SET `display_id1`=2024
        WHERE `entry`=765;
        
        -- Saltscale Oracle
        UPDATE `creature_template`
        SET `display_id1`=3615
        WHERE `entry`=873;
        
        -- Mire Lord
        UPDATE `creature_template`
        SET `display_id1`=2023
        WHERE `entry`=1081;
        
        -- Razormaw Matriach
        UPDATE `creature_template`
        SET `display_id1`=788
        WHERE `entry`=1140;
        
        -- Rotting Ancestor
        UPDATE `creature_template`
        SET `display_id1`=1197, `display_id2`=1198, `display_id3`=0, `display_id4`=0
        WHERE `entry`=1530;
        
        -- Tormented Spirit
        UPDATE `creature_template`
        SET `display_id1`=985
        WHERE `entry`=1533;
        
        -- Wailing Ancestor
        UPDATE `creature_template`
        SET `display_id1`=984
        WHERE `entry`=1534;
        
        -- Logrosh
        UPDATE `creature_template`
        SET `display_id1`=1046
        WHERE `entry`=2453;

        -- Rot Hide Gnoll (atm scale is way too big)
        UPDATE `creature_template`
        SET `display_id1`=3196
        WHERE `entry`=1674;

        insert into`applied_updates`values ('050420231');
    end if;

    -- 06/04/2023 1
    if (select count(*) from `applied_updates` where id='060420231') = 0 then
        -- Fix mistakenly removed subname
        update creature_template set subname = "" where entry = 1764;
        update creature_template set subname = "Cartography Supplies" where entry = 372;
        -- Move Crossroads guards
        update spawns_creatures set position_x = -336.823, position_y = -2702.599, position_z = 95.796, orientation = 0.024 where spawn_id = 19413;
        update spawns_creatures set position_x = -332.090, position_y = -2668.597, position_z = 95.491, orientation = 5.913 where spawn_id = 19415;
        -- Change display_id of Brimgore
        update creature_template set display_id1 = 2718 where entry = 4339;
        insert into`applied_updates`values ('060420231');
    end if;


    -- 14/04/2023 1
    if (select count(*) from `applied_updates` where id='140420231') = 0 then
        -- Set display_id for Anaya Dawnrunner and Lady Moongazer
        update creature_template set display_id1 = 915 where entry in(3667, 2184);

        insert into`applied_updates`values ('140420231');
    end if;

    -- 03/05/2023 1
    if (select count(*) from `applied_updates` where id='030520231') = 0 then
        -- Change diplay_id for Krolg from 1945 to 1012, issue #1140
        update creature_template set display_id1 = 1012 where entry = 3897;
        -- Change diplay_id for Druid of the Talon to NE PH
        update creature_template set display_id1 = 2572 where entry = 2852;
        -- Change diplay_id for Druid of the Fang to NE PH
        update creature_template set display_id1 = 2572, display_id2 = 0, display_id3 = 0, display_id4 = 0 where entry = 3840;


        insert into`applied_updates`values ('030520231');
    end if;


    -- 04/05/2023 1
    if (select count(*) from `applied_updates` where id='040520231') = 0 then
        -- Relocate Jordan Croft,  issue #1141
        update spawns_creatures set position_x = -9496.263,  position_y = -1194.701, position_z = 49.565, orientation = 5.820 where spawn_id = 400054;
        update creature_template set level_min = 10, level_max = 10, health_min = 198, health_max = 198, armor = 20, dmg_min = 9, dmg_max = 13, attack_power = 62 where entry = 1649;
        -- Spawn Natheril and change his display id to NE PH, stats were changed to stats of lvl 27 npcs, issue #1137
        update spawns_creatures set position_x = 9950.535,  position_y = 1926.531, position_z = 1327.937, orientation = 4.913, ignored = 0 where spawn_id = 41643;
        update creature_template set display_id1 = 2572, level_max = 27, level_min = 27, health_max = 839, health_min = 839, armor = 1097, dmg_max = 46, dmg_min = 36, attack_power = 112, ranged_dmg_max = 56.8458, ranged_dmg_min = 41.3424 where entry = 2084;
        -- Spawn Port Master Szik, issue #1138
        insert into spawns_creatures (spawn_entry1, map, position_x, position_y, position_z, orientation) values (2662, 0, -14344.031, 422.664, 6.630, 4.820);
        update creature_template set level_min = 42, level_max = 42, health_min = 1981, health_max = 1981, armor = 2174, faction = 120, dmg_min = 64, dmg_max = 83, attack_power = 172 where entry = 2662;
        -- Spawn Shaia, issue #1132
        insert into spawns_creatures (spawn_entry1, map, position_x, position_y, position_z, orientation) values (4178, 1, 9698.450, 2339.279, 1331.971, 4.146);
        update creature_template set level_min = 30, level_max = 30, health_min = 1002, health_max = 1002, armor = 1200, faction = 79, dmg_min = 42, dmg_max = 53, attack_power = 122 where entry = 4178;
        -- Spawn Lewin Starfeather, issue #1132
        insert into spawns_creatures (spawn_entry1, map, position_x, position_y, position_z, orientation) values (4239, 1, 9670.684, 2374.456, 1343.310, 3.844);
        update creature_template set level_min = 30, level_max = 30, health_min = 1002, health_max = 1002, armor = 1200, faction = 79, dmg_min = 42, dmg_max = 53, attack_power = 122 where entry = 4239;
        insert into`applied_updates`values ('040520231');
    end if;

    -- 09/06/2023 1
    if (select count(*) from `applied_updates` where id='090620231') = 0 then
        -- Fix encoding for quest text 1072 "An Old Colleague"
        update quest_template set Details = "The device I'm thinking about is my most advanced version to date. But we'll need a special potion if it's to work. I'm thinking we might as well get the really good stuff since this mission could be your last if you decide to help.$B$BAnd for that, we're going to need some potent explosives: Nitromirglyceronium.$B$BThe only person who can make NG-5 is an ol' friend of mine in Ironforge: Lomac Gearstrip.$B$BIf you can talk him into making us some NG-5, I'll get to work on placement for my devices..." where entry = 1072;

        insert into`applied_updates`values ('090620231');
    end if;


    -- 21/06/2023 1
    if (select count(*) from `applied_updates` where id='210620231') = 0 then

        -- DISPLAY ID UPDATE

        -- Sandfury Shadowcaster
        UPDATE creature_template SET display_id1 = 1117, display_id2 = 0  WHERE entry = 5648;

        -- Sandfury Blood Drinker
        UPDATE creature_template SET display_id1 = 1118, display_id2 = 0  WHERE entry = 5649;

        -- Sandfury Witch Doctor
        UPDATE creature_template SET display_id1 = 1115, display_id2 = 0  WHERE entry = 5650;

        -- ZUL FARRAK OUTDOOR SPAWN
        
        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6274.34, -2451.214, 14.5964, 5.42797, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6120.889999999999, -2624.584, 8.95783, 4.57276, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6115.0599999999995, -3005.358, 33.1269, 3.42085, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6299.82, -2486.924, 9.80135, 5.76632, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6118.44, -2944.427, 36.2795, 1.51022, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6189.48, -2795.2470000000003, 8.99004, 0.541052, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6177.37, -2821.036, 9.00179, 4.11501, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6138.639999999999, -2906.504, 24.1171, 3.64774, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6333.12, -2501.6240000000003, 9.40873, 4.71239, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6240.46, -3004.9700000000003, 17.6822, 3.18886, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6379.44, -2543.5240000000003, 9.1335, 1.09956, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6223.19, -2921.568, 23.2348, 3.24631, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6375.24, -2542.284, 9.08505, 2.72271, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6356.5, -2535.1140000000005, 9.05309, 1.81514, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6300.28, -2501.384, 8.96111, 1.15192, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6348.03, -2515.3140000000003, 9.67312, 1.44862, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6356.08, -2630.264, 9.20275, 3.03687, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6367.55, -2568.474, 9.05948, 4.60767, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6363.91, -2628.5240000000003, 8.96013, 0.017453, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6364.04, -2630.164, 8.96016, 0.087266, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6363.25, -2625.324, 8.9902, 5.75959, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6351.91, -2582.9440000000004, 9.01227, 5.39307, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6285.71, -2516.6440000000002, 8.96012, 5.48033, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6344.9, -3017.858, 27.1727, 1.27409, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6332.8, -2583.334, 8.96011, 3.63029, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6288.02, -2547.6540000000005, 9.39765, 5.49779, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6285.17, -2544.914, 10.3375, 4.31096, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6279.51, -2551.647, 10.506, 5.46288, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6291.78, -2837.5660000000003, 9.00179, 5.09013, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6391.63, -2756.367, 9.01275, 4.32842, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6286.41, -2951.1420000000003, 17.346, 5.48033, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6293.04, -2820.831, 10.2081, 1.18682, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6293.91, -2817.496, 11.1787, 5.81195, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6396.95, -2764.51, 9.18092, 0.820305, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6343.3099999999995, -2792.266, 9.11468, 5.65487, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6339.33, -2797.632, 9.17103, 2.19912, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6394.41, -2765.6150000000002, 9.18042, 1.29154, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6314.18, -2846.3770000000004, 9.00179, 1.37218, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6341.57, -2929.6850000000004, 9.29566, 1.36264, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6330.42, -2838.772, 8.96012, 2.51327, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6339.42, -2833.9930000000004, 8.8914, 0.355068, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6385.48, -2838.1980000000003, 9.75628, 5.74213, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6360.13, -2937.1310000000003, 8.97168, 1.48353, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6383.23, -2957.054, 11.32, 5.3058, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6418.09, -2884.3990000000003, 9.89255, 5.96903, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6453.62, -2899.998, 8.8914, 3.8113, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6358.03, -2833.159, 9.54633, 1.9141, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6084.54, -2540.974, 8.96012, 1.0821, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6086.59, -2535.6940000000004, 9.04154, 5.81195, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6413.63, -2882.103, 9.98523, 4.24115, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6435.87, -2863.597, 9.70283, 4.46804, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6417.09, -2887.5570000000002, 12.134, 1.090118, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6437.78, -2866.277, 9.52113, 1.0821, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6469.05, -2912.679, 9.17081, 0.628319, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6494.77, -2890.7120000000004, 9.4491, 0.069813, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6511.55, -2919.1020000000003, 9.21445, 5.37561, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6495.21, -2916.646, 8.97416, 2.46091, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6478.19, -2908.838, 8.8919, 3.82264, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6488.78, -2890.4100000000003, 9.72667, 2.87979, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6569.57, -2940.111, 11.9563, 2.33874, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6572.32, -2940.772, 11.6592, 1.79769, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6574.04, -2934.9210000000003, 10.6506, 5.14872, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6592.07, -2922.254, 8.88956, 2.98858, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6595.12, -2922.1440000000002, 8.88956, 2.99251, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6206.6, -2981.842, 14.3114, 1.67303, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6099.76, -2568.7740000000003, 8.96588, 0.785398, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6634.66, -2915.23, 8.97416, 3.71755, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6672.36, -2897.062, 9.23823, 3.24631, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6641.338, -2917.501, 8.97416, 0.174533, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6680.5, -2898.338, 8.97416, 0.418879, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6734.27, -2894.815, 9.10481, 2.19912, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6738.02, -2894.4170000000004, 8.9959, 0.383972, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6150.889999999999, -2550.674, 8.9883, 6.19592, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6100.49, -2598.3740000000003, 9.09823, 5.68977, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6088.27, -2581.754, 9.60223, 2.51327, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6095.52, -2599.534, 8.9936, 2.54818, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6074.01, -2604.094, 10.8489, 1.90241, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6185.22, -2787.907, 8.97432, 4.74729, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6233.49, -2879.056, 8.8768, 3.96897, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6290.01, -2819.849, 11.0054, 2.49582, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6338.15, -2796.683, 9.24633, 2.33874, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6311.65, -2866.581, 8.96012, 2.87979, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6319.24, -2863.702, 8.96821, 5.8294, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6327.49, -2828.8100000000004, 9.01447, 3.55316, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6474.92, -2800.05, 11.8075, 5.22015, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6335.99, -2823.9680000000003, 8.96011, 4.99164, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6366.76, -2864.922, 10.4543, 5.02655, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6380.95, -2841.937, 9.35544, 2.32129, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6387.05, -2842.9530000000004, 9.0397, 6.23082, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6380.0, -2961.753, 11.5338, 2.18166, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6455.389999999999, -2896.286, 8.8912, 3.85389, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6464.84, -2909.413, 8.87731, 4.08407, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6467.96, -2914.183, 9.34458, 1.13446, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6504.86, -2900.9030000000002, 8.89086, 3.46603, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6494.59, -2889.1180000000004, 9.74815, 6.10865, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6510.36, -2911.0570000000002, 9.08669, 6.00393, 300, 300, 0);

        INSERT INTO spawns_creatures
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6534.92, -2901.655, 10.0631, 1.91986, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6674.43, -2891.802, 11.7873, 4.01426, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6707.28, -2924.291, 10.6402, 5.72468, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6703.54, -2927.494, 14.1035, 2.00713, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6703.27, -2922.213, 11.1528, 4.50295, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6409.83, -2644.9440000000004, 8.8781, 4.28345, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6333.139999999999, -2475.994, 10.4681, 3.35103, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6377.83, -2538.254, 9.42084, 4.69494, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6286.86, -2552.784, 9.14993, 0.837758, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6114.45, -2512.684, 9.1649, 4.27606, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6136.98, -2535.2740000000003, 8.96012, 4.93928, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6393.66, -2629.164, 8.96011, 4.95674, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6389.71, -2626.8740000000003, 8.96011, 3.52556, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6423.92, -2656.1440000000002, 9.02151, 1.25664, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6414.99, -2699.724, 8.96012, 3.03687, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6484.28, -2684.3640000000005, 18.1446, 1.36136, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6458.96, -2733.464, 8.96011, 5.23599, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6473.05, -2717.914, 9.81576, 0.959931, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6444.40, -2726.092, 8.96011, 4.41568, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6443.74, -2732.914, 8.96011, 2.6529, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6474.62, -2716.154, 9.98873, 0.436332, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6469.83, -2713.824, 9.72279, 3.61283, 300, 300, 0);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6521.49, -2755.1330000000003, 16.3627, 5.60251, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6544.33, -2789.655, 26.5751, 3.71755, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5650, 1, -6543.2, -2701.954, 29.3484, 1.46608, 300, 300, 1);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5648, 1, -6410.73, -2749.784, 9.15524, 2.24523, 300, 300, 2);

        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5649, 1, -6738.54, -2888.851, 9.28673, 5.34071, 300, 300, 0);


        insert into`applied_updates`values ('210620231');
    end if;

    -- 22/06/2023 1
    if (select count(*) from `applied_updates` where id='220620231') = 0 then
        -- # SCARLET MONASTERY DISPLAY_ID

        -- Scarlet Adept
        UPDATE creature_template SET display_id1 = 1640, display_id2 = 1641 WHERE entry = 4296;

        -- Bloodmage boss
        UPDATE creature_template SET display_id1 = 1245 WHERE entry = 4543;

        -- Unfettered Spirit
        UPDATE creature_template SET display_id1 = 146, scale=0.6 WHERE entry = 4308;


        -- # SCARLET MONASTERY SPAWN

        -- CREATE spawns_creatures 4285
        INSERT INTO spawns_creatures VALUES (NULL, 4285, 0, 0, 0, 44, 61.20868682861328, 8.221044540405273, 18.67734146118164, 1.5425058603286743, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4284
        INSERT INTO spawns_creatures VALUES (NULL, 4284, 0, 0, 0, 44, 61.435794830322266, 13.404674530029297, 18.67734146118164, 4.684100151062012, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 80.1650619506836, 22.348621368408203, 18.677343368530273, 4.606348514556885, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 79.8206558227539, -24.05950355529785, 18.677345275878906, 1.5959153175354004, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4284
        INSERT INTO spawns_creatures VALUES (NULL, 4284, 0, 0, 0, 44, 62.21089553833008, -15.782360076904297, 18.67734146118164, 1.566855549812317, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4285
        INSERT INTO spawns_creatures VALUES (NULL, 4285, 0, 0, 0, 44, 62.15839767456055, -10.594425201416016, 18.67734146118164, 4.708449363708496, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 106.28458404541016, -24.045188903808594, 18.678449630737305, 1.682308554649353, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4285
        INSERT INTO spawns_creatures VALUES (NULL, 4285, 0, 0, 0, 44, 127.16918182373047, -0.7003735303878784, 18.677650451660156, 4.729650497436523, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 124.9183120727539, -11.703500747680664, 18.677701950073242, 3.1345057487487793, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 124.8828353881836, 10.324862480163574, 18.677705764770508, 3.131364345550537, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 156.88282775878906, 13.355033874511719, 18.006990432739258, 4.761847019195557, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 156.9886932373047, 9.311752319335938, 18.006990432739258, 1.5731316804885864, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 156.95687866210938, -17.447349548339844, 18.00699806213379, 3.2719478607177734, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 153.96755981445312, -18.04072380065918, 18.00699806213379, 0.15313304960727692, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 153.1455841064453, -35.50927734375, 18.006996154785156, 4.097402572631836, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4296
        INSERT INTO spawns_creatures VALUES (NULL, 4296, 0, 0, 0, 44, 151.1444854736328, -37.74823760986328, 18.006996154785156, 0.8804130554199219, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 146.3372802734375, -47.61099624633789, 18.00699806213379, 6.181065559387207, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 154.04507446289062, -64.22149658203125, 18.006996154785156, 3.417245388031006, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4296
        INSERT INTO spawns_creatures VALUES (NULL, 4296, 0, 0, 0, 44, 149.89622497558594, -65.0346450805664, 18.006996154785156, 0.2253885269165039, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4296
        INSERT INTO spawns_creatures VALUES (NULL, 4296, 0, 0, 0, 44, 155.68621826171875, -57.29583740234375, 18.00699806213379, 1.577841877937317, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4288
        INSERT INTO spawns_creatures VALUES (NULL, 4288, 0, 0, 0, 44, 183.4946746826172, -68.68872833251953, 18.293745040893555, 2.1449005603790283, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 182.2350616455078, -70.44640350341797, 18.138744354248047, 2.5289602279663086, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4288
        INSERT INTO spawns_creatures VALUES (NULL, 4288, 0, 0, 0, 44, 192.18560791015625, -90.86404418945312, 18.165571212768555, 4.069906711578369, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 194.1005401611328, -89.36634826660156, 18.116897583007812, 5.332042217254639, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4288
        INSERT INTO spawns_creatures VALUES (NULL, 4288, 0, 0, 0, 44, 197.8074188232422, -76.85205841064453, 18.104774475097656, 2.371875286102295, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 199.91004943847656, -75.19420623779297, 18.31986427307129, 2.5163888931274414, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 192.48756408691406, -104.61534881591797, 18.677331924438477, 1.6092509031295776, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 163.37269592285156, -75.65628814697266, 18.677335739135742, 6.198331832885742, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 192.2702178955078, -54.386653900146484, 18.67732048034668, 4.658161640167236, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 213.57777404785156, -75.52764892578125, 18.67732810974121, 3.1156411170959473, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4288
        INSERT INTO spawns_creatures VALUES (NULL, 4288, 0, 0, 0, 44, 209.93914794921875, -56.679473876953125, 18.677326202392578, 3.1549081802368164, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 210.07757568359375, -54.803462982177734, 18.677326202392578, 3.148624897003174, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 211.32534790039062, -101.08364868164062, 18.677326202392578, 1.5880368947982788, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 167.0591278076172, -102.42378997802734, 18.677330017089844, 6.259584903717041, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 3974
        INSERT INTO spawns_creatures VALUES (NULL, 3974, 0, 0, 0, 44, 184.5865020751953, -138.36582946777344, 18.022817611694336, 1.588822364807129, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 184.96774291992188, -134.49969482421875, 18.02281951904297, 4.6267409324646, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 182.63046264648438, -135.1958465576172, 18.02281951904297, 5.261342525482178, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4304
        INSERT INTO spawns_creatures VALUES (NULL, 4304, 0, 0, 0, 44, 181.2280731201172, -137.0644073486328, 18.02281951904297, 5.996475696563721, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4298
        INSERT INTO spawns_creatures VALUES (NULL, 4298, 0, 0, 0, 44, 230.5638427734375, -83.3134994506836, 18.00699806213379, 3.1792540550231934, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4290
        INSERT INTO spawns_creatures VALUES (NULL, 4290, 0, 0, 0, 44, 222.77687072753906, -106.38179779052734, 18.00699806213379, 0.07850369811058044, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4298
        INSERT INTO spawns_creatures VALUES (NULL, 4298, 0, 0, 0, 44, 224.8974609375, -109.15126037597656, 18.006999969482422, 1.5621190071105957, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4295
        INSERT INTO spawns_creatures VALUES (NULL, 4295, 0, 0, 0, 44, 226.29466247558594, -106.59800720214844, 18.00699806213379, 3.5790226459503174, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 3975
        INSERT INTO spawns_creatures VALUES (NULL, 3975, 0, 0, 0, 44, 255.2139892578125, -99.9120101928711, 18.679365158081055, 3.146263837814331, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 305.0462341308594, -100.3953857421875, 30.82321548461914, 3.1085503101348877, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 300.9446105957031, -76.61844635009766, 30.823219299316406, 3.9583518505096436, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 298.4822998046875, -79.22891235351562, 30.823217391967773, 0.8167579174041748, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 305.0079345703125, -63.123085021972656, 30.823219299316406, 3.0637834072113037, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 297.2182922363281, -46.12883377075195, 30.82322120666504, 0.04471130669116974, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4287
        INSERT INTO spawns_creatures VALUES (NULL, 4287, 0, 0, 0, 44, 301.5986633300781, -46.19062042236328, 30.82322120666504, 3.062997817993164, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4291
        INSERT INTO spawns_creatures VALUES (NULL, 4291, 0, 0, 0, 44, 328.703857421875, -59.07202911376953, 30.828676223754883, 3.3912856578826904, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);
        -- CREATE spawns_creatures 4291
        INSERT INTO spawns_creatures VALUES (NULL, 4291, 0, 0, 0, 44, 318.9059753417969, -42.41212844848633, 30.828672409057617, 3.077118158340454, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4291
        INSERT INTO spawns_creatures VALUES (NULL, 4291, 0, 0, 0, 44, 325.0407409667969, -20.489118576049805, 30.828676223754883, 0.024273494258522987, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4291
        INSERT INTO spawns_creatures VALUES (NULL, 4291, 0, 0, 0, 44, 328.8355407714844, -26.864055633544922, 30.828672409057617, 2.0985107421875, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 297.38299560546875, -27.905975341796875, 32.37169647216797, 1.6013509035110474, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 294.32476806640625, -33.404396057128906, 32.37168502807617, 0.4711626470088959, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 296.148681640625, -31.64642333984375, 32.3716926574707, 3.914349317550659, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 319.3476867675781, -1.648572564125061, 30.82866859436035, 6.267398357391357, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 324.9609375, -1.5419814586639404, 30.82866859436035, 3.1226654052734375, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 305.2064208984375, -9.292184829711914, 32.3717155456543, 3.1250221729278564, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 296.3812255859375, -11.64564037322998, 32.3716926574707, 1.5746480226516724, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4291
        INSERT INTO spawns_creatures VALUES (NULL, 4291, 0, 0, 0, 44, 296.3627014160156, -7.0306782722473145, 32.3716926574707, 4.6691155433654785, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4298
        INSERT INTO spawns_creatures VALUES (NULL, 4298, 0, 0, 0, 44, 364.9994812011719, -3.9089114665985107, 30.82412338256836, 4.699740886688232, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4298
        INSERT INTO spawns_creatures VALUES (NULL, 4298, 0, 0, 0, 44, 365.0293273925781, -14.693588256835938, 30.82412338256836, 1.5581493377685547, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4295
        INSERT INTO spawns_creatures VALUES (NULL, 4295, 0, 0, 0, 44, 343.8344421386719, -14.863336563110352, 30.824125289916992, 1.541650414466858, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4295
        INSERT INTO spawns_creatures VALUES (NULL, 4295, 0, 0, 0, 44, 382.0777282714844, -12.012577056884766, 30.824127197265625, 1.610762596130371, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4298
        INSERT INTO spawns_creatures VALUES (NULL, 4298, 0, 0, 0, 44, 381.89910888671875, -6.627150535583496, 30.824127197265625, 4.702091217041016, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 367.9074401855469, -39.33707046508789, 30.829992294311523, 4.68951940536499, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 369.27655029296875, -39.19841003417969, 30.829984664916992, 4.742926597595215, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 381.0075378417969, -39.18628692626953, 30.829984664916992, 4.653388023376465, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4303
        INSERT INTO spawns_creatures VALUES (NULL, 4303, 0, 0, 0, 44, 379.6044921875, -39.15510177612305, 30.82998275756836, 4.737426280975342, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4303
        INSERT INTO spawns_creatures VALUES (NULL, 4303, 0, 0, 0, 44, 377.9299621582031, -51.784053802490234, 30.830686569213867, 4.675376892089844, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4303
        INSERT INTO spawns_creatures VALUES (NULL, 4303, 0, 0, 0, 44, 371.3196105957031, -51.552024841308594, 30.830673217773438, 4.7177886962890625, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 377.48797607421875, -64.19990539550781, 30.83098602294922, 4.6793036460876465, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 378.82806396484375, -64.22728729248047, 30.83098602294922, 4.726428031921387, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4303
        INSERT INTO spawns_creatures VALUES (NULL, 4303, 0, 0, 0, 44, 371.31964111328125, -64.05171203613281, 30.83098602294922, 4.770410537719727, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 365.6876220703125, -78.83854675292969, 30.83098602294922, 4.772767543792725, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 367.9111022949219, -78.54216766357422, 30.83098602294922, 4.772767543792725, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 383.09027099609375, -78.65242004394531, 30.83098602294922, 4.366716384887695, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4303
        INSERT INTO spawns_creatures VALUES (NULL, 4303, 0, 0, 0, 44, 380.98095703125, -78.1936264038086, 30.83098602294922, 4.759415626525879, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 3976
        INSERT INTO spawns_creatures VALUES (NULL, 3976, 0, 0, 0, 44, 373.9609375, -102.6358413696289, 33.05110549926758, 4.676159858703613, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 391.9476318359375, -26.628173828125, 30.829946517944336, 5.881746292114258, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 401.7771911621094, -29.293540954589844, 30.829946517944336, 3.121858835220337, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 401.88043212890625, -47.975257873535156, 30.830474853515625, 3.124215602874756, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 397.5728759765625, -52.57415771484375, 30.830732345581055, 4.537145137786865, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 401.8379211425781, -66.44190979003906, 30.83098602294922, 3.089658498764038, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 397.3166809082031, -72.66360473632812, 30.830984115600586, 4.732709884643555, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4300
        INSERT INTO spawns_creatures VALUES (NULL, 4300, 0, 0, 0, 44, 392.9870300292969, -83.0877456665039, 30.83098793029785, 1.5714807510375977, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 353.0223388671875, -25.72920036315918, 30.829925537109375, 4.583483695983887, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 347.2741394042969, -29.37743377685547, 30.82959747314453, 6.151139259338379, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 347.1222839355469, -47.91024398803711, 30.83047103881836, 6.238318920135498, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 347.23992919921875, -66.6267318725586, 30.83098602294922, 6.23831844329834, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 354.1416320800781, -55.43657684326172, 30.830890655517578, 1.5439940690994263, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4300
        INSERT INTO spawns_creatures VALUES (NULL, 4300, 0, 0, 0, 44, 357.4685363769531, -59.507469177246094, 30.83098793029785, 5.4238600730896, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4300
        INSERT INTO spawns_creatures VALUES (NULL, 4300, 0, 0, 0, 44, 352.7135009765625, -71.37552642822266, 30.830984115600586, 5.33903694152832, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 353.0116882324219, -83.17613983154297, 30.83098793029785, 1.5219998359680176, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 313.31219482421875, -82.55992126464844, 30.822834014892578, 6.274439811706543, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4300
        INSERT INTO spawns_creatures VALUES (NULL, 4300, 0, 0, 0, 44, 316.3389892578125, -85.03884887695312, 30.82417106628418, 4.898421764373779, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 317.900390625, -89.05941009521484, 30.82632064819336, 1.898199439048767, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 310.72039794921875, -89.18510437011719, 30.824464797973633, 6.180191993713379, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 315.7038269042969, -114.74170684814453, 32.072689056396484, 4.7680463790893555, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4542
        INSERT INTO spawns_creatures VALUES (NULL, 4542, 0, 0, 0, 44, 329.8094787597656, -106.8153076171875, 30.82891082763672, 2.9443535804748535, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4301
        INSERT INTO spawns_creatures VALUES (NULL, 4301, 0, 0, 0, 44, 438.6317443847656, -89.02783203125, 30.82200050354004, 3.1014299392700195, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 431.5087585449219, -84.88352966308594, 30.82390594482422, 2.859527111053467, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4300
        INSERT INTO spawns_creatures VALUES (NULL, 4300, 0, 0, 0, 44, 426.1101379394531, -84.2994155883789, 30.826461791992188, 2.0003013610839844, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4300
        INSERT INTO spawns_creatures VALUES (NULL, 4300, 0, 0, 0, 44, 435.9577941894531, -82.79151153564453, 30.82200050354004, 3.1045713424682617, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4299
        INSERT INTO spawns_creatures VALUES (NULL, 4299, 0, 0, 0, 44, 432.3927307128906, -107.138671875, 30.828096389770508, 1.5989586114883423, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 432.196044921875, -113.9665756225586, 32.071876525878906, 4.691855430603027, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4302
        INSERT INTO spawns_creatures VALUES (NULL, 4302, 0, 0, 0, 44, 413.8451232910156, -106.62232971191406, 30.828094482421875, 1.5534026622772217, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 415.2341613769531, -113.78944396972656, 32.07188034057617, 4.241819381713867, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4540
        INSERT INTO spawns_creatures VALUES (NULL, 4540, 0, 0, 0, 44, 412.7303466796875, -113.73188018798828, 32.071876525878906, 5.024076461791992, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 3977
        INSERT INTO spawns_creatures VALUES (NULL, 3977, 0, 0, 0, 44, 374.3002014160156, -149.76394653320312, 29.533010482788086, 1.5447630882263184, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4075
        INSERT INTO spawns_creatures VALUES (NULL, 4075, 0, 0, 0, 44, 276.0992126464844, -53.840301513671875, 31.493806838989258, 2.498227119445801, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4075
        INSERT INTO spawns_creatures VALUES (NULL, 4075, 0, 0, 0, 44, 249.06883239746094, -53.219337463378906, 31.49358367919922, 3.3173978328704834, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4075
        INSERT INTO spawns_creatures VALUES (NULL, 4075, 0, 0, 0, 44, 250.38449096679688, -28.932281494140625, 31.49361228942871, 1.8314237594604492, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4075
        INSERT INTO spawns_creatures VALUES (NULL, 4075, 0, 0, 0, 44, 279.1425476074219, -31.60256004333496, 31.493698120117188, 6.116555213928223, 18000, 18000, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4293
        INSERT INTO spawns_creatures VALUES (NULL, 4293, 0, 0, 0, 44, 278.0079345703125, -63.43807601928711, 31.493513107299805, 3.9245080947875977, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 274.5926818847656, -63.79273986816406, 31.4935359954834, 5.569918155670166, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4293
        INSERT INTO spawns_creatures VALUES (NULL, 4293, 0, 0, 0, 44, 250.70338439941406, -55.064579010009766, 31.493614196777344, 4.742108345031738, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 3983
        INSERT INTO spawns_creatures VALUES (NULL, 3983, 0, 0, 0, 44, 256.4114074707031, -57.25048828125, 31.49388313293457, 3.1430366039276123, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 254.52593994140625, -20.696273803710938, 31.49355697631836, 5.434042453765869, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 256.7969970703125, -23.28974723815918, 31.49379539489746, 2.239043951034546, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4293
        INSERT INTO spawns_creatures VALUES (NULL, 4293, 0, 0, 0, 44, 278.1042175292969, -26.037797927856445, 31.493553161621094, 4.724827766418457, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 276.3821105957031, -26.143049240112305, 31.493663787841797, 5.657880783081055, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 278.9228515625, -29.524349212646484, 31.493633270263672, 1.8769749402999878, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 277.30108642578125, -30.06794548034668, 31.49375343322754, 1.3366206884384155, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4293
        INSERT INTO spawns_creatures VALUES (NULL, 4293, 0, 0, 0, 44, 277.52740478515625, -55.444801330566406, 31.49366569519043, 1.557315468788147, 18000, 18000, 0, 100, 0, 2, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 234.6766357421875, -34.47034454345703, 30.823219299316406, 2.01127552986145, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4283
        INSERT INTO spawns_creatures VALUES (NULL, 4283, 0, 0, 0, 44, 224.3471221923828, -10.927236557006836, 30.823226928710938, 6.248498439788818, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4293
        INSERT INTO spawns_creatures VALUES (NULL, 4293, 0, 0, 0, 44, 232.1105194091797, 33.44544982910156, 30.823225021362305, 3.099052667617798, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4306
        INSERT INTO spawns_creatures VALUES (NULL, 4306, 0, 0, 0, 44, 227.5698699951172, 33.452293395996094, 30.823225021362305, 0.025002865120768547, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4543
        INSERT INTO spawns_creatures VALUES (NULL, 4543, 0, 0, 0, 44, 177.99781799316406, 25.786996841430664, 31.49356460571289, 0.0037943858187645674, 18000, 18000, 0, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4308
        INSERT INTO spawns_creatures VALUES (NULL, 4308, 0, 0, 0, 44, 196.94068908691406, 20.90924644470215, 30.839046478271484, 4.015606880187988, 18000, 18000, 5, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4308
        INSERT INTO spawns_creatures VALUES (NULL, 4308, 0, 0, 0, 44, 191.66236877441406, 21.656526565551758, 30.97735595703125, 6.262632369995117, 18000, 18000, 5, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4308
        INSERT INTO spawns_creatures VALUES (NULL, 4308, 0, 0, 0, 44, 194.86183166503906, 24.896621704101562, 30.839046478271484, 4.885046005249023, 18000, 18000, 5, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4308
        INSERT INTO spawns_creatures VALUES (NULL, 4308, 0, 0, 0, 44, 199.48472595214844, 28.760902404785156, 30.839046478271484, 3.7666409015655518, 18000, 18000, 5, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4308
        INSERT INTO spawns_creatures VALUES (NULL, 4308, 0, 0, 0, 44, 203.85415649414062, 29.59072494506836, 30.883066177368164, 3.3228909969329834, 18000, 18000, 5, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4308
        INSERT INTO spawns_creatures VALUES (NULL, 4308, 0, 0, 0, 44, 200.7442169189453, 32.96062088012695, 30.839046478271484, 4.435800552368164, 18000, 18000, 5, 100, 0, 1, 0, 0, 0);

        insert into`applied_updates`values ('220620231');
    end if;

    -- 24/06/2023 1
    if (select count(*) from `applied_updates` where id='240620231') = 0 then

        -- RAZORFEN DOWN

        -- Quillguard
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4436;
        
        -- Warrior
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4435;
        
        -- Defender
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4442;
        
        -- Geomancer
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4442;
        
        -- Overlord
        UPDATE `creature_template`
        SET `display_id1`=2449
        WHERE `entry`=4420;
        
        -- Speakhide
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4438;
        
        -- Death...
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4518;
        
        -- Earthbraker
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4525;
        
        -- Totemic
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4440;
        
        -- Champion
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4623;
        
        -- Defender
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4442;
        
        -- Groundshaker
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4523;
        
        -- Dustweaver
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4522;

        -- Wind howler
        UPDATE `creature_template`
        SET `display_id1`=69
        WHERE `entry`=4526;

        -- Beast
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4531;
        
        -- Aggem
        UPDATE `creature_template`
        SET `display_id1`=2449
        WHERE `entry`=4424;
        
        -- Geomancer
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4520;
        
        -- Acolyte 
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4515;
        
        -- Adept
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4516;
        
        -- Jagba
        UPDATE `creature_template`
        SET `display_id1`=2449
        WHERE `entry`=4428;
        
        -- Master
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4532;
        
        -- Warrior
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4435;
        
        -- Quillbeast
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4426;
        
        -- Sage
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4518;
        
        -- Seer
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4519;
        
        -- Guardian
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4427;
        
        -- Ward keeper
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4625;
        
        -- Charlga
        UPDATE `creature_template`
        SET `display_id1`=2449
        WHERE `entry`=4421;
        
        -- Priest
        UPDATE `creature_template`
        SET `display_id1`=1963
        WHERE `entry`=4517;
        
        -- Halmgar
        UPDATE `creature_template`
        SET `display_id1`=2449
        WHERE `entry`=4842;
        
        -- Warden
        UPDATE `creature_template`
        SET `display_id1`=1964
        WHERE `entry`=4437;
        
        -- Agamar
        UPDATE `creature_template`
        SET `display_id1`=2453
        WHERE `entry`=4511;
        
        -- Rotting Agamar
        UPDATE `creature_template`
        SET `display_id1`=2453
        WHERE `entry`=4512;
        
        -- Blood Of Agamaggan
        UPDATE `creature_template`
        SET `display_id1`=2028
        WHERE `entry`=4541;
        
        -- Blind hunter
        UPDATE `creature_template`
        SET `display_id1`=1566
        WHERE `entry`=4425;

        -- SHADOWFANG
        
        -- Worg
        UPDATE `creature_template`
        SET `display_id1`=784
        WHERE `entry`=3862;
        
        -- Vile Bat
        UPDATE `creature_template`
        SET `display_id1`=1954
        WHERE `entry`=3866;

        -- DEADMINES
        
        -- Defias Companion 
        UPDATE `creature_template`
        SET `display_id1`=1419
        WHERE `entry`=3450;

        -- WAILLING CAVERN
        
        -- Lady anaconda 
        UPDATE `creature_template`
        SET `display_id1`=2575
        WHERE `entry`=3671;
        
        -- Lord Cobrhan
        UPDATE `creature_template`
        SET `display_id1`=2572
        WHERE `entry`=3669;
        
        -- Deviate Lasher
        UPDATE `creature_template`
        SET `display_id1`=4091
        WHERE `entry`=5055;
        
        -- Deviate Viper 
        UPDATE `creature_template`
        SET `display_id1`=3205
        WHERE `entry`=5755;
        
        -- Deviate Adder
        UPDATE `creature_template`
        SET `display_id1`=3006
        WHERE `entry`=5048;
        
        --  Lord Serpentis
        UPDATE `creature_template`
        SET `display_id1`=2572
        WHERE `entry`=3673;
        
        -- Lord Pythas
        UPDATE `creature_template`
        SET `display_id1`=2572
        WHERE `entry`=3670;
        
        -- Naralex
        UPDATE `creature_template`
        SET `display_id1`=2572
        WHERE `entry`=3679;
        
        -- Kresh 
        UPDATE `creature_template`
        SET `display_id1`=2308
        WHERE `entry`=3653;
        
        -- Akumai Snapjaw
        UPDATE `creature_template`
        SET `display_id1`=2308
        WHERE `entry`=4825;
        
        -- Twilight Lord
        UPDATE `creature_template`
        SET `display_id1`=495
        WHERE `entry`=4832;
        
        -- See Witch
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4805;
        
        -- Myrmidon
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4807;
        
        -- Ghamoora
        UPDATE `creature_template`
        SET `display_id1`=2902
        WHERE `entry`=4887;
        
        -- Tide Priest
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4802;
        
        -- Oracle
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4803;
        
        -- Muckdweller
        UPDATE `creature_template`
        SET `display_id1`=3617
        WHERE `entry`=4819;
        
        -- Lord Sarevess
        UPDATE `creature_template`
        SET `display_id1`=4036
        WHERE `entry`=4831;
        
        insert into`applied_updates`values ('240620231');
    end if;

    -- 24/06/2023 2
    if (select count(*) from `applied_updates` where id='240620232') = 0 then

        -- Kayren Southallow #1167
        update spawns_creatures set position_x = -63.989,  position_y = -931.456, position_z = 56.745, orientation = 0.498 where spawn_id = 15525;
        update creature_template set subname = "Binder", npc_flags=16, faction=35 where entry = 2401;

        -- Tharm #1156
        update spawns_creatures set position_x = -184.182,  position_y = -295.170, position_z = 11.55, orientation = 6.239, map=1 where spawn_id = 32245;
        update creature_template set subname = "Wind Rider Master", npc_flags=4, faction=29 where entry = 4312;

        -- Baros Alexston #1155
        update spawns_creatures set position_x = -8743.631,  position_y = 657.649, position_z = 105.091, orientation = 3.429 where spawn_id = 79766;

        -- Aldric Moore #1063
        update spawns_creatures set position_y = 638.412 where spawn_id = 400097;
        update creature_template set subname = "Leather Armor Merchant" where entry = 1294;

        -- Andrew Brounel #1139
        update spawns_creatures set position_x = 1854.942,  position_y = 1575.886, position_z = 99.072, orientation = 0.050 where spawn_id = 32024;

        -- Hill Giant #1128 (PARTIAL)
        INSERT INTO spawns_creatures
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type)
        VALUES
        (2689, 0, 45.1769, -4277.32, 123.17, 4.222, 180000, 180000, 2);

        -- Misha #1077 (PARTIAL)
        update spawns_creatures set position_x = 710.107,  position_y = -4307.204, position_z = 19.37, orientation = 3.064 where spawn_id = 6461;

        -- Harruk #1077 (PARTIAL)
        update spawns_creatures set position_x = 246.668,  position_y = -3856.381, position_z = 31.852, orientation = 0.587 where spawn_id = 7673;

        -- Tursk #1077 (PARTIAL)
        update spawns_creatures set position_x = 107.789,  position_y = -5049.07, position_z = 7.421, orientation = 2.972 where spawn_id = 400066;

        -- IF guards #1142
        update spawns_creatures set position_x = -4629.728,  position_y = -988.332, position_z = 501.66, orientation = 2.076 where spawn_id = 2079;
        update spawns_creatures set position_x = -4624.874,  position_y = -985.732, position_z = 501.66, orientation = 2.076 where spawn_id = 2023;
        update spawns_creatures set position_x = -5003.002,  position_y = -1176.698, position_z = 501.66, orientation = 5.172 where spawn_id = 2024;
        update spawns_creatures set position_x = -5007.91,  position_y = -1179.113, position_z = 501.66, orientation = 5.172 where spawn_id = 2081;

        insert into`applied_updates`values ('240620232');
    end if;

    -- 24/06/2023 3
    if (select count(*) from `applied_updates` where id='240620233') = 0 then

        -- CREATE WAYPOINT FOR SPAWN 400252
        INSERT INTO alpha_world.creature_movement VALUES (400252, 1, 78.681, 10.243, 18.678, 6.272, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400252
        INSERT INTO alpha_world.creature_movement VALUES (400252, 2, 124.910, 10.219, 18.678, 0.013, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400251
        INSERT INTO creature_movement VALUES (400251, 1, 78.85399627685547, -11.843199729919434, 18.677560806274414, 3.093668222427368, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400251
        INSERT INTO creature_movement VALUES (400251, 2, 124.82247924804688, -11.765533447265625, 18.677703857421875, 6.280815124511719, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400275
        INSERT INTO creature_movement VALUES (400275, 1, 211.30665588378906, -58.178070068359375, 18.677326202392578, 1.5715714693069458, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400275
        INSERT INTO creature_movement VALUES (400275, 2, 211.29052734375, -100.8717041015625, 18.677326202392578, 4.696672439575195, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400276
        INSERT INTO creature_movement VALUES (400276, 1, 209.7820587158203, -102.40733337402344, 18.67732810974121, 6.280035018920898, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400276
        INSERT INTO creature_movement VALUES (400276, 2, 167.18728637695312, -102.38860321044922, 18.677330017089844, 3.087392568588257, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400273
        INSERT INTO creature_movement VALUES (400273, 1, 167.02503967285156, -56.747440338134766, 18.677330017089844, 3.090531826019287, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400273
        INSERT INTO creature_movement VALUES (400273, 2, 209.7213134765625, -56.652549743652344, 18.677326202392578, 0.051041990518569946, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 1, 192.25550842285156, -55.979942321777344, 18.67732048034668, 3.1203794479370117, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 2, 183.61572265625, -54.8859748840332, 18.677326202392578, 3.1203792095184326, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 3, 167.1152801513672, -54.81371307373047, 18.677330017089844, 3.1203792095184326, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 4, 184.35482788085938, -54.54459762573242, 18.677324295043945, 6.239193916320801, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 5, 192.06362915039062, -55.85224533081055, 18.67732048034668, 0.005488688126206398, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 6, 199.4667510986328, -54.616912841796875, 18.677324295043945, 6.278463840484619, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400274
        INSERT INTO creature_movement VALUES (400274, 7, 209.525634765625, -54.664405822753906, 18.677326202392578, 6.278463840484619, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400368
        INSERT INTO creature_movement VALUES (400368, 1, 277.53167724609375, -32.34305953979492, 31.493772506713867, 1.5134526491165161, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400368
        INSERT INTO creature_movement VALUES (400368, 2, 273.583984375, -30.744016647338867, 31.493867874145508, 3.0944597721099854, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400368
        INSERT INTO creature_movement VALUES (400368, 3, 254.30714416503906, -30.6525821685791, 31.49383544921875, 3.187136650085449, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400368
        INSERT INTO creature_movement VALUES (400368, 4, 254.32249450683594, -54.91840362548828, 31.493831634521484, 4.77442741394043, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400368
        INSERT INTO creature_movement VALUES (400368, 5, 277.21875, -55.22489547729492, 31.493694305419922, 0.08874264359474182, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400337
        INSERT INTO creature_movement VALUES (400337, 1, 352.9067687988281, -30.573667526245117, 30.829944610595703, 1.5707917213439941, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400337
        INSERT INTO creature_movement VALUES (400337, 2, 352.9384765625, -83.08306121826172, 30.83098793029785, 4.712385654449463, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400329
        INSERT INTO creature_movement VALUES (400329, 1, 392.72796630859375, -32.038414001464844, 30.829946517944336, 1.5888582468032837, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400329
        INSERT INTO creature_movement VALUES (400329, 2, 392.95965576171875, -83.14067077636719, 30.83098793029785, 4.691966533660889, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400347
        INSERT INTO creature_movement VALUES (400347, 1, 396.9627685546875, -82.67427825927734, 30.83098793029785, 3.1298115253448486, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400347
        INSERT INTO creature_movement VALUES (400347, 2, 435.7950134277344, -82.76931762695312, 30.82200050354004, 6.262766361236572, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400338
        INSERT INTO creature_movement VALUES (400338, 1, 351.2063293457031, -82.50768280029297, 30.83098793029785, 6.272976398468018, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400338
        INSERT INTO creature_movement VALUES (400338, 2, 313.46929931640625, -82.52023315429688, 30.82281494140625, 3.173011064529419, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400262
        INSERT INTO creature_movement VALUES (400262, 1, 154.98622131347656, -34.06648254394531, 18.006996154785156, 1.5213205814361572, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400262
        INSERT INTO creature_movement VALUES (400262, 2, 147.674072265625, 1.1428062915802002, 18.006994247436523, 1.7106016874313354, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400262
        INSERT INTO creature_movement VALUES (400262, 3, 155.12229919433594, -32.46809387207031, 18.006996154785156, 4.719462871551514, 0, 0, 0);

        -- CREATE WAYPOINT FOR SPAWN 400262
        INSERT INTO creature_movement VALUES (400262, 4, 155.63497924804688, -57.28042984008789, 18.00699806213379, 4.655845642089844, 0, 0, 0);

        -- UPDATE MOVEMENT TYPE FOR SPAWN 400262
        UPDATE spawns_creatures SET movement_type=2 WHERE spawn_id=400262;

        insert into`applied_updates`values ('240620233');
    end if;
    
    -- 24/06/2023 4
    if(select count(*) from applied_updates where id = '240620234') = 0 then
        -- Bows
        UPDATE `trainer_template` SET `spell` = '5991' WHERE (`template_entry` = '23') and (`spell` = '3828');
        UPDATE `trainer_template` SET `spell` = '5991' WHERE (`template_entry` = '26') and (`spell` = '3828');

        -- Guns
        UPDATE `trainer_template` SET `spell` = '5992' WHERE (`template_entry` = '23') and (`spell` = '3830');
        UPDATE `trainer_template` SET `spell` = '5992' WHERE (`template_entry` = '26') and (`spell` = '3830');

        UPDATE `creature_template` SET `armor`=685, `dmg_min`=37.5879, `dmg_max`=49.8247, `attack_power`=54, `base_attack_time`=2000, `ranged_attack_time`=2000, `unit_flags`=64, `ranged_dmg_max`=27.8801, `ranged_attack_power`=44 WHERE `entry`=2068;
        UPDATE `creature_template` SET `armor`=615, `dmg_min`=31.3535, `dmg_max`=41.4931, `attack_power`=48, `base_attack_time`=2000, `ranged_attack_time`=2000, `ranged_dmg_min`=17.3575, `ranged_dmg_max`=23.322, `ranged_attack_power`=40 WHERE `entry` IN (2060, 2061, 2062, 2063, 2064, 2065, 2066, 2067);
        UPDATE `creature_template` SET `speed_walk`=1, `dmg_min`=26.2333, `dmg_max`=34.7785, `attack_power`=64, `ranged_dmg_min`=24.519, `ranged_dmg_max`=33.0643, `ranged_attack_power`=52, `armor`=791, `spell_id1`=2589, `spell_list_id`=20580, `faction`=68, `unit_flags`=32768, `script_name`='', `ai_name`='EventAI' WHERE `entry`=2058;
        UPDATE `creature_template` SET `ai_name`='EventAI', `script_name`='' WHERE `entry` IN (2060, 2061, 2062, 2063, 2064, 2065, 2066, 2067, 2068);


        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES
        (20580, 'Deathstalker Faerleia', 2589, 100, 1, 0, 0, 0, 6, 20, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        UPDATE `quest_template` SET `StartScript`=452 WHERE `entry`=452;

        insert into applied_updates values ('240620234');
    end if;
        
    -- 25/06/2023 1
    if (select count(*) from `applied_updates` where id='250620231') = 0 then
        -- ULDAMAN

        -- Jadespine Basilisk
        UPDATE `creature_template`
        SET `display_id1`=141
        WHERE `entry`=4863;

        -- Stonevault Brawler
        UPDATE `creature_template`
        SET `display_id1`=1193
        WHERE `entry`=4855;

        -- Grimlok
        UPDATE `creature_template`
        SET `display_id1`=830
        WHERE `entry`=4854;

        -- Stone keeper
        UPDATE `creature_template`
        SET `display_id1`=2234
        WHERE `entry`=4857;

        -- Archeologist
        UPDATE `creature_template`
        SET `display_id1`=3487
        WHERE `entry`=4849;

        -- Chanter
        UPDATE `creature_template`
        SET `display_id1`=3490
        WHERE `entry`=2742;

        -- Commander
        UPDATE `creature_template`
        SET `display_id1`=3456
        WHERE `entry`=2744;

        -- Darkcaster
        UPDATE `creature_template`
        SET `display_id1`=3970
        WHERE `entry`=4848;

        -- Darkweaver
        UPDATE `creature_template`
        SET `display_id1`=3488
        WHERE `entry`=2740;

        -- Digger
        UPDATE `creature_template`
        SET `display_id1`=3452
        WHERE `entry`=4846;

        -- Excavator
        UPDATE `creature_template`
        SET `display_id1`=825
        WHERE `entry`=2741;

        -- Relic Hunter
        UPDATE `creature_template`
        SET `display_id1`=3954
        WHERE `entry`=4847;

        -- Ruffian
        UPDATE `creature_template`
        SET `display_id1`=825
        WHERE `entry`=4845;

        -- Surveyor
        UPDATE `creature_template`
        SET `display_id1`=870
        WHERE `entry`=4844;

        -- Tunneler
        UPDATE `creature_template`
        SET `display_id1`=870
        WHERE `entry`=2739;

        -- Warrior
        UPDATE `creature_template`
        SET `display_id1`=825
        WHERE `entry`=2743;

        -- SUNKEN TEMPLE

        -- Jade
        UPDATE `creature_template`
        SET `display_id1`=2930
        WHERE `entry`=1063;

        -- Murk Slitherer
        UPDATE `creature_template`
        SET `display_id1`=3006, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5224;

        -- Murk Splitter
        UPDATE `creature_template`
        SET `display_id1`=3006, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5225;

        -- Mummified atalai
        UPDATE `creature_template`
        SET `display_id1`=1478, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5263;

        -- Enthralled atalai
        UPDATE `creature_template`
        SET `display_id1`=1478, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5261;

        -- Atalai Priest
        UPDATE `creature_template`
        SET `display_id1`=1478, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5269;

        -- Cursed Atalai
        UPDATE `creature_template`
        SET `display_id1`=1478, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5243;

        -- Kazkaz The Unholy
        UPDATE `creature_template`
        SET `display_id1`=1478, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=5401;

        -- Archaedas
        UPDATE `spawns_creatures`
        SET `position_x` = 104.421,  `position_y` = 272.728, `position_z` = -50.251, `orientation` = 3.606
        WHERE `spawn_id` = 33537;

        UPDATE `creature_template`
        SET `display_id1`=40, `display_id2`=0, `display_id3`=0, `display_id4`=0
        WHERE `entry`=2748;


        insert into`applied_updates`values ('250620231');
    end if;

    -- 25/06/2023 4
    if (select count(*) from `applied_updates` where id='250620234') = 0 then

        -- DISPLAY ID FIX

        -- Ambassador Infernus
        UPDATE `creature_template`
        SET `display_id1`=1070
        WHERE `entry`=2745;

        -- Fireman Caller
        UPDATE `creature_template`
        SET `display_id1`=263
        WHERE `entry`=2192;

        -- Arcticus
        UPDATE `creature_template`
        SET `display_id1`=665
        WHERE `entry`=1260;

        -- Itharus
        UPDATE `creature_template`
        SET `display_id1`=1642
        WHERE `entry`=5353;

        -- Jutak
        UPDATE `creature_template`
        SET `display_id1`=2577
        WHERE `entry`=2843;

        -- Silithid harvester
        UPDATE `creature_template`
        SET `display_id1`=2592
        WHERE `entry`=3253;

        -- Skum
        UPDATE `creature_template`
        SET `display_id1`=1540
        WHERE `entry`=3674;

        -- Stone Golem
        UPDATE `creature_template`
        SET `display_id1`=473
        WHERE `entry`=2723;

        -- Swamp talker
        UPDATE `creature_template`
        SET `display_id1`=627
        WHERE `entry`=950;

        -- The Husk
        UPDATE `creature_template`
        SET `display_id1`=2832
        WHERE `entry`=1851;

        insert into`applied_updates`values ('250620234');
    end if;

    -- 25/06/2023 5
    if (select count(*) from `applied_updates` where id='250620235') = 0 then
        
        -- Hill Giant waypoints (Grimungous port)
        UPDATE creature_movement_template SET entry=2689 WHERE entry=8215;

        -- Hill Giant stats (Grimungous port)
        UPDATE creature_template SET armor=2999, dmg_min=292, dmg_max=377, attack_power=226, level_min=50, level_max=50, health_min=6645, health_max=6645, rank=2, gold_min=545, gold_max=717, faction=14, speed_walk=0.777776 WHERE entry=2689;

        insert into`applied_updates`values ('250620235');
    end if;

   -- 26/06/2023 1
    if (select count(*) from `applied_updates` where id='260620231') = 0 then
        
        -- Change outdoor IF guards to mountaineer, partial #1149
        UPDATE `spawns_creatures` SET spawn_entry1=727 WHERE spawn_id IN (136, 141, 142, 132, 138, 133, 139, 135);

        -- Avette, #1193
        UPDATE `creature_template`
        SET `display_id1`=15
        WHERE `entry`=228;

        -- Argent Dawn, #1190
        INSERT INTO spawns_creatures VALUES (NULL, 4783, 0, 0, 0, 1, 10067.546, 2344.827, 1331.886, 2.169, 300, 300, 0, 100, 0, 0, 0, 0, 0);
        INSERT INTO spawns_creatures VALUES (NULL, 4784, 0, 0, 0, 1, 10063.946, 2353.328, 1331.888, 5.361, 300, 300, 0, 100, 0, 0, 0, 0, 0);
        INSERT INTO spawns_creatures VALUES (NULL, 4786, 0, 0, 0, 1, 10073.348, 2350.134, 1331.892, 2.207, 300, 300, 0, 100, 0, 0, 0, 0, 0);

        UPDATE `creature_template`
        SET `display_id1`=2572
        WHERE `entry`IN (4784, 4786);

        UPDATE `creature_template`
        SET `display_id1`=2582
        WHERE `entry`=4783;

        -- Gromgol Adjustements
        update spawns_creatures set position_x = -12346.161, position_y = 154.915, position_z = 2.974, orientation = 5.355 where spawn_id = 316;
        update spawns_creatures set position_x = -12351.228, position_y = 217.586, position_z = 4.795, orientation = 4.481 where spawn_id = 607;
        update spawns_creatures set position_x = -12367.681, position_y = 216.648, position_z = 3.237, orientation = 4.635 where spawn_id = 664;
        update spawns_gameobjects set spawn_positionZ=3.5 where spawn_id = 10718;
        update spawns_gameobjects set spawn_positionZ=2.8 where spawn_id=10721;

        insert into`applied_updates`values ('260620231');
    end if;

    -- 26/06/2023 2
    if (select count(*) from `applied_updates` where id='260620232') = 0 then

        -- STONETALON VENTURE SPAWN

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, -103.22578430175781, -643.1570434570312, -3.2517786026000977, 1.400368332862854, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, -122.39275360107422, -652.5399780273438, -2.5280532836914062, 4.34404182434082, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, -128.76705932617188, -638.5053100585938, -2.104145050048828, 0.5144388675689697, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, -112.99739074707031, -618.3390502929688, -0.24555061757564545, 0.9071381092071533, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 16.54450225830078, -710.3645629882812, -19.201173782348633, 5.215831756591797, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, -26.202068328857422, -701.9427490234375, -13.734065055847168, 2.581785793154, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, -3.247903347015381, -701.1491088867188, -19.12977409362793, 0.3675690293312073, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4070
        INSERT INTO spawns_creatures VALUES (NULL, 4070, 0, 0, 0, 1, 57.91869354248047, -666.2796630859375, -11.953057289123535, 1.0147347450256348, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, -59.25220489501953, -496.7125244140625, -36.01194381713867, 4.7862138748168945, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, -81.57341003417969, -505.9495849609375, -33.322113037109375, 3.030848264694214, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, -51.036903381347656, -474.4364929199219, -37.44758987426758, 4.872605323791504, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, -66.92344665527344, -478.894775390625, -37.44758987426758, 4.699817657470703, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, -45.129302978515625, -652.6919555664062, -19.038650512695312, 4.1374735832214355, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 52.09547805786133, -640.4288940429688, -14.64133358001709, 3.7212088108062744, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 164.22708129882812, -890.9057006835938, 4.7319865226745605, 1.8818118572235107, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3998
        INSERT INTO spawns_creatures VALUES (NULL, 3998, 0, 0, 0, 1, 183.0899658203125, -857.1746826171875, 7.617861270904541, 3.3159468173980713, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 164.58543395996094, -866.5665283203125, 2.5231266021728516, 3.171433448791504, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 179.38209533691406, -881.3180541992188, 6.4656572341918945, 1.445124864578247, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 132.95779418945312, -577.1720581054688, -0.6031491756439209, 3.1588644981384277, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 114.80517578125, -594.4067993164062, -2.1140248775482178, 4.312614917755127, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 108.08291625976562, -587.7420654296875, -1.5271341800689697, 0.07853417843580246, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 120.39892578125, -579.2853393554688, -0.7511696219444275, 4.142186164855957, 300, 300, 3, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 2.8149447441101074, -569.1878662109375, -48.189239501953125, 0.7264880537986755, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, -14.377157211303711, -534.758056640625, -37.1672477722168, 5.307720184326172, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, -16.863216400146484, -614.3746948242188, -38.84021759033203, 5.7098388671875, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, -13.811149597167969, -639.596923828125, -39.06477355957031, 0.9817426800727844, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3090
        INSERT INTO spawns_creatures VALUES (NULL, 3090, 0, 0, 0, 1, -58.83843994140625, -598.578857421875, -41.98210144042969, 5.758533477783203, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 51.332237243652344, -814.4895629882812, -5.8527655601501465, 5.618732929229736, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3089
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 53.04977798461914, -832.9111938476562, -3.554927349090576, 0.4036894738674164, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 69.11625671386719, -833.4298095703125, -5.257763862609863, 2.191256284713745, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 73.77717590332031, -807.3950805664062, -5.8932085037231445, 0.0408380888402462, 300, 300, 3, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 74.83368682861328, -727.0685424804688, -20.81070899963379, 3.0724730491638184, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 136.99253845214844, -804.7415771484375, -7.496026992797852, 1.2102934122085571, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 133.58131408691406, -783.3330078125, -7.149320125579834, 2.4386565685272217, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 128.76690673828125, -813.1980590820312, -7.4929633140563965, 2.2949306964874268, 300, 300, 3, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 137.6255340576172, -832.2217407226562, -2.086172342300415, 3.312807559967041, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 167.13507080078125, -751.8831787109375, -4.382238388061523, 0.5725375413894653, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 165.24365234375, -737.7525024414062, -2.3084945678710938, 1.972115159034729, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 151.33558654785156, -732.9699096679688, -5.0252227783203125, 4.34244441986084, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 176.0355682373047, -764.9703979492188, -2.898024320602417, 1.358717441558838, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 97.86324310302734, -237.6961669921875, 6.706205368041992, 5.057149887084961, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 117.05250549316406, -267.47705078125, 5.854121685028076, 5.193023681640625, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 53.83110427856445, -246.25103759765625, 6.5067877769470215, 6.043612480163574, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 66.27933502197266, -266.53558349609375, 13.25736141204834, 5.899099349975586, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3989
        INSERT INTO spawns_creatures VALUES (NULL, 3989, 0, 0, 0, 1, 110.12708282470703, -348.502685546875, 3.22333025932312, 5.333612442016602, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 3990
        INSERT INTO spawns_creatures VALUES (NULL, 3990, 0, 0, 0, 1, 133.13160705566406, -359.9857177734375, 4.086468696594238, 3.480074644088745, 300, 300, 3, 100, 0, 0, 0, 0, 0);

        -- CREATE spawns_creatures 4071
        INSERT INTO spawns_creatures VALUES (NULL, 4071, 0, 0, 0, 1, 132.30230712890625, -343.0064392089844, 5.421562194824219, 2.345959186553955, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        -- CREATE spawns_creatures 4069
        INSERT INTO spawns_creatures VALUES (NULL, 4069, 0, 0, 0, 1, 95.99101257324219, -372.2847900390625, 4.293388843536377, 1.6932932138442993, 300, 300, 3, 100, 0, 1, 0, 0, 0);

        insert into`applied_updates`values ('260620232');
    end if;

    -- 26/06/2023 4
    if (select count(*) from `applied_updates` where id='260620234') = 0 then
        
        UPDATE `quest_template` SET `RequestItemsText` = 'Perhaps I did not make myself clear, pledge.  In order to prove your worth as a servant to The People\'s Militia and to the Light you need to slay 20 Defias Trappers and then return to me when the deed is done.' WHERE (`entry` = '12');       
        UPDATE `spawns_creatures` SET `position_x` = '-3298.854', `position_y` = '-1044.855', `position_z` = '115.258', `orientation` = '2.834' WHERE (`spawn_id` = '25951');

        insert into`applied_updates`values ('260620234');
    end if;

    -- 01/07/2023 1
    if (select count(*) from `applied_updates` where id='010720231') = 0 then
        
        -- Alchemy - Elixir of Minor Fortitude
        INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('505', '2363', '2334', '100', '0', '0', '171', '50', '1');
        -- Elixir of Fortitude -> Elixir of Minor Fortitude
        UPDATE `item_template` SET `name` = 'Elixir of Minor Fortitude' WHERE (`entry` = '2458');

        insert into`applied_updates`values ('010720231');
    end if;

    -- 01/07/2023 2
    if (select count(*) from `applied_updates` where id='010720232') = 0 then
        
        -- Captain Eo
        UPDATE `spawns_creatures` SET `position_x` = '6481.107', `position_y` = '611.4338', `position_z` = '5.151847', `orientation` = '2.23402' WHERE (`spawn_id` = '400030');
        UPDATE `creature_template` SET `health_min` = '1752', `health_max` = '1752', `armor` = '1890', `dmg_min` = '61', `dmg_max` = '78', `attack_power` = '156', `level_min` = '40', `level_max` = '40', `unit_class` = '4' WHERE (`entry` = '3895');
        UPDATE `creature_addon` SET `emote_state` = '0' WHERE (`guid` = '400030');

        insert into`applied_updates`values ('010720232');
    end if;

    -- 02/07/2023 2
    if (select count(*) from `applied_updates` where id='020720232') = 0 then
        
        -- Captain Eo, wrong Z, dance upon quest completion.
        UPDATE `spawns_creatures` SET `position_z` = '5.451847' WHERE (`spawn_id` = '400030');
        DELETE FROM `quest_end_scripts` WHERE `id`=1019;
        INSERT INTO `quest_end_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(1019, 5, 0, 1, 10, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain EO - Dance');
        -- Dance.
        DELETE FROM `quest_end_scripts` WHERE `id`=1126;
        INSERT INTO `quest_end_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(1126, 6, 0, 1, 10, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain EO - Dance');

        -- The Plains Vision
        DELETE FROM `creature_ai_events` WHERE `creature_id`=2983;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (2983001, 2983, 0, 11, 0, 100, 0, 0, 0, 0, 0, 2983001, 0, 0, 'Rite of Vision');

        DELETE FROM `creature_ai_scripts` WHERE `id`=2983001;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(2983001, 5, 0, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Start Waypoints');

        INSERT INTO `creature_movement_template` 
        VALUES 
        (2983,0,-2237.22,-402.207,-9.42413,100,0,0,0),
        (2983,1,-2177.19,-454.185,-5.91219,100,0,0,0),
        (2983,2,-2122.69,-446.433,-9.26146,100,0,0,0),
        (2983,3,-2102.45,-423.9,-5.37892,100,0,0,0),
        (2983,4,-2052.26,-354.836,-5.33621,100,0,0,0),
        (2983,5,-2030.62,-315.119,-9.38673,100,0,0,0),
        (2983,6,-2002.57,-247.985,-10.8341,100,0,0,0),
        (2983,7,-1946.97,-155.28,-11.3127,100,0,0,0),
        (2983,8,-1894.82,-90.1517,-11.3003,100,0,0,0),
        (2983,9,-1828.63,-30.0814,-11.9404,100,0,0,0),
        (2983,10,-1796.66,26.3394,-3.18109,100,0,0,0),
        (2983,11,-1742.18,113.846,-3.63277,100,0,0,0),
        (2983,12,-1641.27,185.452,1.49467,100,0,0,0),
        (2983,13,-1565.87,246.907,5.7669,100,0,0,0),
        (2983,14,-1550.53,270.841,16.5373,100,0,0,0),
        (2983,15,-1536.88,315.944,49.0035,100,0,0,0),
        (2983,16,-1528.78,327.115,59.4182,100,0,0,0),
        (2983,17,-1520.91,337.194,63.8113,100,0,0,0),
        (2983,18,-1516.17,350.146,62.5674,100,5000,0,0);

        DELETE FROM `quest_end_scripts` WHERE `id`=772;
        INSERT INTO `quest_end_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(772, 0, 0, 15, 1126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rite of Vision: Seer Wiserunner - Cast Spell Mark of the Wild'),
(772, 0, 0, 18, 0, 0, 0, 0, 2983, 30, 8, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Despawn Plains Vision');


        insert into`applied_updates`values ('020720232');
    end if;

    -- 04/07/2023 1
    if (select count(*) from `applied_updates` where id='040720231') = 0 then
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '68.3087', `spawn_positionY` = '-137.575', `spawn_positionZ` = '11.2933' WHERE (`spawn_id` = '47447');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '68.3294', `spawn_positionY` = '-137.5541', `spawn_positionZ` = '10.7427' WHERE (`spawn_id` = '47449');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '68.4392', `spawn_positionY` = '-137.4797', `spawn_positionZ` = '10.2576' WHERE (`spawn_id` = '47450');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '68.60', `spawn_positionY` = '-138.40', `spawn_positionZ` = '10.561' WHERE (`spawn_id` = '47451');
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = '68', `spawn_positionY` = '-139.10', `spawn_positionZ` = '8.5955' WHERE (`spawn_id` = '47452');

        -- Port Master Szik
        UPDATE `creature_template` SET `equipment_id` = '400000' WHERE (`entry` = '2662');

        -- Ironforge Mountaineer's stats.
        UPDATE `creature_template` SET `level_min` = '18', `level_max` = '22' WHERE (`entry` = '727');
        -- Change Frostmane Hold quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '750' WHERE (`entry` = '287');
        -- Change A Favour for Evershine quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '600' WHERE (`entry` = '319');
        -- Unequip Mountaineer Barleybrew
        UPDATE `creature_template` SET `equipment_id` = '0' WHERE (`entry` = '1959');
        -- Change A Pilot's Revenge quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '575' WHERE (`entry` = '417');
        -- Change an Elite's lvl.
        UPDATE `creature_template` SET `level_min` = '12', `level_max` = '12' WHERE (`entry` = '1388');
        -- Change Evershine quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '170' WHERE (`entry` = '318');
        -- Change binders' lvls. Kerik Firebeard and Fulgar Iceforge should be changed to lvl 65.
        UPDATE `creature_template` SET `level_min` = '65', `level_max` = '65' WHERE (`entry` = '2297');
        UPDATE `creature_template` SET `level_min` = '65', `level_max` = '65' WHERE (`entry` = '2296');
        -- Rudra Amberstill should /beg when offering the Protecting the Herd quest.
        UPDATE `quest_template` SET `DetailsEmote1` = '20' WHERE (`entry` = '314');
        -- Change Coldridge Mountaineers' lvl and equipment.
        UPDATE `creature_equip_template` SET `equipentry2` = '1985' WHERE (`entry` = '853');
        UPDATE `creature_template` SET `level_min` = '9', `level_max` = '12' WHERE (`entry` = '853');
        -- Change an NPC's subname, Keeg Gibn should have a subname.
        UPDATE `creature_template` SET `subname` = 'Drinks' WHERE (`entry` = '1697');
        -- Change an NPC's subname.
        UPDATE `quest_template` SET `RewXP` = '1150' WHERE (`entry` = '412');
        -- Ironforge Guards should be lvl 90.
        UPDATE `creature_template` SET `level_min` = '90', `level_max` = '90' WHERE (`entry` = '5595');
        -- Springspindle Fizzlegear should be lvl 35.
        -- Gryth Thurden should be lvl 45.
        -- Soleil Stonemantle, Bailey Stonemandle and Barnum Stonemantle should be lvl 35.
        UPDATE `creature_template` SET `level_min` = '35', `level_max` = '35' WHERE (`entry` = '5174');
        UPDATE `creature_template` SET `level_min` = '45', `level_max` = '45' WHERE (`entry` = '1573');
        UPDATE `creature_template` SET `level_min` = '35', `level_max` = '35' WHERE (`entry` = '5099');
        UPDATE `creature_template` SET `level_min` = '35', `level_max` = '35' WHERE (`entry` = '2461');
        UPDATE `creature_template` SET `level_min` = '35', `level_max` = '35' WHERE (`entry` = '2460');
        -- Change the quest's text, Knowledge in the Deeps , Ashenvale -> Darkshore.
        UPDATE `quest_template` SET `Details` = 'As you might know, I collect lore.  Old lore.  Powerful lore.  Lore that opens doorways, and lore that can awaken Those Who Sleep.$B$BThere are rumors of an old piece of lore, the Lorgalis Manuscript, at the bottom of Blackfathom Deeps in Darkshore.  That place is the old dwelling of long-dead elves.  Elves who held great knowledge before their city fell to ruin.$B$BSearch Blackfathom Deeps for the manuscript.  Do this, and I will not forget it.  Not even after ... the end days.' WHERE (`entry` = '971');
        -- Change The Reports quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '575' WHERE (`entry` = '291');
        -- Fizzlebang Booms should be renamed Fizzlebang Sparks.
        UPDATE `creature_template` SET `name` = 'Fizzlebang Sparks' WHERE (`entry` = '5569');
        -- Bretta Goldfury should have a DisplayID of 3077, the same as Skolmin Goldfury.
        UPDATE `creature_template` SET `display_id1` = '3077' WHERE (`entry` = '5123');
        -- Report to Ironforge should award 490 experience.
        UPDATE `quest_template` SET `RewXP` = '490' WHERE (`entry` = '301');
        -- Peria Lamenur and her Tamed Cat should be lvl 50.
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50' WHERE (`entry` = '2878');
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50' WHERE (`entry` = '5438');
        -- Grelin Whitebeard should wield [Monster - Staff, Crooked].
        UPDATE `creature_template` SET `equipment_id` = '786' WHERE (`entry` = '786');
        INSERT INTO `creature_equip_template` (`entry`, `equipentry1`, `equipentry2`, `equipentry3`) VALUES ('786', '1908', '0', '0');
        -- Apprentice Soren should wield [Monster - Torch] (The only main hand torch in the database).
        UPDATE `item_template` SET `display_id` = '6537' WHERE (`entry` = '1906');
        UPDATE `item_template` SET `display_id` = '6537' WHERE (`entry` = '6088');
        --  Adjust The Stolen Journal quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '550' WHERE (`entry` = '218');
        -- Swap Anvilmar trainers' locations.
        UPDATE `spawns_creatures` SET `position_x` = '-6048.79', `position_y` = '391.078', `position_z` = '398.958', `orientation` = '3.63028' WHERE (`spawn_id` = '421');
        UPDATE `spawns_creatures` SET `position_x` = '-6093.75', `position_y` = '404.918', `position_z` = '395.62', `orientation` = '4.5204' WHERE (`spawn_id` = '1024');
        -- Change Coldridge Mail Delivery (part 1)'s experience reward.
        UPDATE `quest_template` SET `RewXP` = '10' WHERE (`entry` = '233');
        -- Change Senir's Observations (part 1) quest's experience reward
        UPDATE `quest_template` SET `RewXP` = '110' WHERE (`entry` = '282');
        -- Change Senir's Observations (part 2) quest's experience reward.
        UPDATE `quest_template` SET `RewXP` = '220' WHERE (`entry` = '420');

        insert into`applied_updates`values ('040720231');
    end if;

    -- 06/07/2023 1
    if (select count(*) from `applied_updates` where id='060720231') = 0 then

        ALTER TABLE `quest_template` ADD COLUMN `RequiredCondition` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0 AFTER `RequiredSkillValue`;
        UPDATE `quest_template` SET `RequiredCondition` = 778 WHERE `entry` = 207;
        UPDATE `quest_template` SET `RequiredCondition` = 215 WHERE `entry` = 215;
        UPDATE `quest_template` SET `RequiredCondition` = 790 WHERE `entry` = 690;
        UPDATE `quest_template` SET `RequiredCondition` = 949 WHERE `entry` = 960;
        UPDATE `quest_template` SET `RequiredCondition` = 108003 WHERE `entry` = 1080;
        UPDATE `quest_template` SET `RequiredCondition` = 20227 WHERE `entry` = 1191;
        UPDATE `quest_template` SET `RequiredCondition` = 1303 WHERE `entry` = 1301;

        insert into`applied_updates`values ('060720231');
    end if;

    -- 06/07/2023 2
    if (select count(*) from `applied_updates` where id='060720232') = 0 then
        
        -- Shamans.
        -- Item Conditions, not having the totems.
        -- This aint custom, since we need to take ownership of the ID's from Conditions table, else it could be used by something else in the future invalidating the custom quests.

        -- 1678804:  Not (Target Has 1 Stacks Of Item 5175 In Inventory) -- Earth Totem
        DELETE FROM `conditions` WHERE `condition_entry`=1678804;
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1678804, 2, 5175, 1, 0, 0, 1);
        -- 1678805:  Not (Target Has 1 Stacks Of Item 5176 In Inventory) -- Fire Totem
        DELETE FROM `conditions` WHERE `condition_entry`=1678805;
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1678805, 2, 5176, 1, 0, 0, 1);
        -- 1678806:  Not (Target Has 1 Stacks Of Item 5177 In Inventory) -- Water Totem
        DELETE FROM `conditions` WHERE `condition_entry`=1678806;
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1678806, 2, 5177, 1, 0, 0, 1);
        -- 1678807:  Not (Target Has 1 Stacks Of Item 5178 In Inventory) - Air Totem
        DELETE FROM `conditions` WHERE `condition_entry`=1678807;
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (1678807, 2, 5178, 1, 0, 0, 1);
       
        -- Grik'nir should use Frostmane Strenght and Fire Ward.
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (8080, 'Dun Morogh - Grik\'nir the Cold', 6957, 50, 14, 0, 0, 0, 1, 3, 16, 19, 0, 543, 100, 0, 0, 0, 0, 0, 6, 30, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        -- Make Frostmane Whelps flee on low hp
        DELETE FROM `creature_ai_scripts` WHERE `id`=70602;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(70602, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostmane Troll Whelp - Flee');

        -- Events list for Frostmane Troll Whelp
        DELETE FROM `creature_ai_events` WHERE `creature_id`=706;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (70601, 706, 0, 4, 0, 20, 0, 0, 0, 0, 0, 70601, 0, 0, 'Frostmane Troll Whelp - Chance Say on Aggro');
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (70602, 706, 0, 2, 0, 100, 0, 15, 0, 0, 0, 70602, 0, 0, 'Frostmane Troll Whelp - Flee at 15%');

        -- Crag Boars and Large Crag Boars shoud use Boar Charge
        DELETE FROM `creature_ai_scripts` WHERE `id`=112501;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(112501, 0, 0, 15, 3385, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crag Boar - Cast Boar Charge');

        DELETE FROM `creature_ai_scripts` WHERE `id`=112601;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(112601, 0, 0, 15, 3385, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Large Crag Boar - Cast Boar Charge');

        -- New creature spell lists. Winter Wolves should use Furious Howl.
        UPDATE `creature_template` SET `spell_list_id` = '11310' WHERE (`entry` = '1131');
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (11310, 'Winter Wolves', 3149, 100, 0, 0, 0, 0, 4, 14, 34, 59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        -- Kreg Bilmn should wield [Monster - Item, Bread]
        UPDATE `creature_equip_template` SET `equipentry1` = '2197' WHERE (`entry` = '1691');
        -- Granis Swiftaxe should wield [Monster - Axe, Large Basic]
        UPDATE `creature_equip_template` SET `equipentry1` = '1909' WHERE (`entry` = '1229');
        -- Maxan Anvol should wield [Monster - Staff, Basic]
        UPDATE `creature_equip_template` SET `equipentry1` = '1907' WHERE (`entry` = '1226');
        -- Magis Stonemantle should wield [Monster - Staff, Basic].
        INSERT INTO `creature_equip_template` (`entry`, `equipentry1`, `equipentry2`, `equipentry3`) VALUES ('1228', '1907', '0', '0');
        UPDATE `creature_template` SET `equipment_id` = '1228' WHERE (`entry` = '1228');
        -- Azar Stronghammer should wield [Monster - Mace, Basic Metal Hammer].
        UPDATE `creature_equip_template` SET `equipentry1` = '1903' WHERE (`entry` = '1232');
        -- Frostmane Seers should use Lightning Shield.
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (13970, 'Dun Morogh - Frostmane Seer', 403, 100, 1, 0, 0, 8, 0, 0, 2, 2, 0, 324, 100, 0, 0, 0, 0, 8, 16, 182, 190, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        -- Relocate Advisor Belgrum
        UPDATE `spawns_creatures` SET `position_x` = '-4605.064', `position_y` = '-1085.849', `orientation` = '2.264' WHERE (`spawn_id` = '2006');

        insert into`applied_updates`values ('060720232');
    end if;

    -- 08/07/2023 1
    if (select count(*) from `applied_updates` where id='080720231') = 0 then     
        -- Invalid factions 1070 -> 14 (Monster: Not Social) Private Hendel, Theramore Deserter.
        UPDATE `creature_template` SET `faction` = '14' WHERE (`entry` = '4966');
        UPDATE `creature_template` SET `faction` = '14' WHERE (`entry` = '5057');
        -- Wrong event descriptions.
        UPDATE `creature_ai_events` SET `comment` = 'Crag Boar - Cast Boar Charge on Aggro' WHERE (`id` = '112501');
        UPDATE `creature_ai_events` SET `comment` = 'Large Crag Boar - Cast Boar Charge on Aggro' WHERE (`id` = '112601');
        -- The People's Militia Incorrect Text 
        UPDATE `quest_template` SET `RequestItemsText` = 'We have not time to talk, $N. The Defias Pillagers are denying the people of Westfall the peace and prosperity they deserve. Make sure at least 20 Defias Pillagers have been killed. That will send a clear message that corruption is not welcome here.' WHERE (`entry` = '13');
        -- Radnaal Maneweaver, wrong Z (Falling underground)
        UPDATE `spawns_creatures` SET `position_z` = '1326.81' WHERE (`spawn_id` = '46719');
        -- Elder Crag Boar should use Boar Charge.
        UPDATE `creature_ai_events` SET `comment` = 'Elder Crag Boar - Cast Boar Charge on Aggro' WHERE (`id` = '112701');
        DELETE FROM `creature_ai_scripts` WHERE `id`=112701;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(112701, 0, 0, 15, 3385, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Crag Boar - Cast Boar Charge');

        insert into`applied_updates`values ('080720231');
    end if;

    -- 13/07/2023 1
    if (select count(*) from `applied_updates` where id='130720231') = 0 then

        -- Fix spell 124 target position. (Not used below but still)
        UPDATE `spell_target_position` SET `target_map` = '0', `target_position_x` = '2851.201', `target_position_y` = '-711.075', `target_position_z` = '144.4', `target_orientation` = '5.45' WHERE (`id` = '427') and (`target_map` = '189');
        insert into`applied_updates`values ('130720231');
    end if;

    -- 16/07/2023 1
    if (select count(*) from `applied_updates` where id='160720231') = 0 then
        -- Sarilus Foulborne - Sarilus's Elementals, Frostbolt rank2.
        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (3986, 'Sarilus Foulborne', 6490, 100, 0, 0, 0, 0, 0, 4, 120, 120, 0, 205, 100, 1, 0, 0, 0, 7, 12, 9, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        -- Minor Water Guardian - DisplayID, Feed Sarilus Passive, Sarilus's Elementals Passive
        UPDATE `creature_template` SET `display_id1` = '2069', `level_min` = '5', `level_max` = '25', `auras` = '6488 6498' WHERE (`entry` = '3950');

        insert into`applied_updates`values ('160720231');
    end if;

    -- 18/07/2023 1
    if (select count(*) from `applied_updates` where id='180720231') = 0 then
        -- Set Sarilus Foulborne spell list.
        UPDATE `creature_template` SET `spell_list_id` = '3986' WHERE (`entry` = '3986');

        insert into`applied_updates`values ('180720231');
    end if;

    -- 22/07/2023 1
    if (select count(*) from `applied_updates` where id='220720231') = 0 then
        -- Hin Denburg npc text.
        UPDATE `npc_text` SET `text0_0` = 'My zeppelin is the sturdiest vessel in the land. And if I have a any more grog tonight it will be the sturdiest vessel in the sea!' WHERE (`id` = '2753');

        -- Hin Denburg Journey To Orgrimmar
        INSERT INTO `creature_quest_starter` (`entry`, `quest`) VALUES ('3150', '799');
        INSERT INTO `creature_quest_finisher` (`entry`, `quest`) VALUES ('3150', '799');

        -- Torc the Orc
        INSERT INTO `npc_text` (`id`, `text0_0`, `text0_1`, `lang0`, `prob0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `lang1`, `prob1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `lang2`, `prob2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `lang3`, `prob3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `lang4`, `prob4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `lang5`, `prob5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `lang6`, `prob6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `lang7`, `prob7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`) VALUES ('3148', 'I am Torc the Orc! Where would you like to fly today?', '', '0', '1', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0', '0');

        insert into`applied_updates`values ('220720231');
    end if;

    -- 22/07/2023 2
    if (select count(*) from `applied_updates` where id='220720232') = 0 then
        -- Torc the Orc missing npc_gossip link.
        INSERT INTO `npc_gossip` (`npc_guid`, `textid`) VALUES ('400033','3148');

        insert into`applied_updates`values ('220720232');
    end if;

    -- 26/07/2023 2
    if (select count(*) from `applied_updates` where id='260720232') = 0 then
        -- Escorting Erland
        DELETE FROM `generic_scripts` WHERE `id`=43507;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES (43507, 0, 0, 70, 435, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1014, 'Escorting Erland - Fail Quest');

        DELETE FROM `quest_start_scripts` WHERE `id`=435;
        INSERT INTO `quest_start_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(435, 0, 0, 61, 435, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1014, 43507, 0, 0, 0, 0, 0, 'Escorting Erland - Start Map Event'),
(435, 0, 1, 22, 232, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Set Faction Escortee'),
(435, 0, 2, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland  - Remove NPC flags.'),
(435, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 481, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - SayText'),
(435, 0, 4, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Start Waypoints');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197801;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197801, 0, 0, 0, 0, 0, 0, 0, 435, 0, 21, 0, 482, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Say Start 2');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197802;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197802, 0, 0, 0, 0, 0, 0, 0, 435, 0, 21, 0, 484, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Say End Text'),
(197802, 0, 0, 7, 435, 0, 0, 0, 435, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Complete Quest');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197803;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197803, 0, 0, 0, 0, 0, 0, 0, 1950, 0, 8, 2, 534, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Rane Text');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197804;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197804, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 535, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Erland Reply');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197805;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 536, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Check Next');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197806;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197806, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 537, 0, 0, 0, 0, 0, 0, 0, 0, 'Ecorting Erland - Hello Quinn');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197807;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197807, 0, 0, 0, 0, 0, 0, 0, 1951, 0, 8, 2, 539, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Quinn Reply');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197808;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 538, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Bye'),
(197808, 60, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Despawn');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197809;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197809, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 483, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Almost There.');

        -- Events list for Deathstalker Erland
        DELETE FROM `creature_ai_events` WHERE `creature_id`=1978;
        INSERT INTO `creature_ai_events` (`id`, `creature_id`, `condition_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_script`, `action2_script`, `action3_script`, `comment`) VALUES (1, 1978, 0, 4, 0, 100, 3, 0, 0, 0, 0, 197801, 0, 0, 'Deathstalker Erland - Aggro Text');

        DELETE FROM `creature_ai_scripts` WHERE `id`=197801;
        INSERT INTO `creature_ai_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 543, 544, 541, 0, 0, 0, 0, 0, 0, 'Deathstalker Erland - Aggro Text');

        DELETE FROM `creature_movement_template` WHERE `entry`=1978;
        INSERT INTO `creature_movement_template`
        VALUES 
        ('1978', '0', '1406.32', '1083.1', '52.55', '100', '0', '0', '0'),
        ('1978', '1', '1400.49', '1080.42', '52.5', '100', '0', '0', '197801'),
        ('1978', '2', '1388.48', '1083.1', '52.52', '100', '0', '0', '0'),
        ('1978', '3', '1370.16', '1084.02', '52.3', '100', '0', '0', '0'),
        ('1978', '4', '1359.02', '1080.85', '52.46', '100', '0', '0', '0'),
        ('1978', '5', '1341.43', '1087.39', '52.69', '100', '0', '0', '0'),
        ('1978', '6', '1321.93', '1090.51', '50.66', '100', '0', '0', '0'),
        ('1978', '7', '1312.98', '1095.91', '47.49', '100', '0', '0', '0'),
        ('1978', '8', '1301.09', '1102.94', '47.76', '100', '0', '0', '0'),
        ('1978', '9', '1297.73', '1106.35', '50.18', '100', '0', '0', '0'),
        ('1978', '10', '1295.49', '1124.32', '50.49', '100', '0', '0', '0'),
        ('1978', '11', '1294.84', '1137.25', '51.75', '100', '0', '0', '197809'),
        ('1978', '12', '1292.89', '1158.99', '52.65', '100', '0', '0', '0'),
        ('1978', '13', '1290.75', '1168.67', '52.56', '100', '2000', '0', '197802'),
        ('1978', '14', '1287.12', '1203.49', '52.66', '100', '5000', '0', '197803'),
        ('1978', '15', '1288.3', '1203.89', '52.68', '100', '5000', '0', '197804'),
        ('1978', '16', '1288.3', '1203.89', '52.68', '100', '5000', '0', '197805'),
        ('1978', '17', '1290.72', '1207.44', '52.69', '100', '0', '0', '0'),
        ('1978', '18', '1297.5', '1207.18', '53.74', '100', '0', '0', '0'),
        ('1978', '19', '1301.32', '1220.9', '53.74', '100', '0', '0', '0'),
        ('1978', '20', '1298.55', '1220.43', '53.74', '100', '0', '0', '0'),
        ('1978', '21', '1297.38', '1212.87', '58.51', '100', '0', '0', '0'),
        ('1978', '22', '1297.8', '1210.04', '58.51', '100', '0', '0', '0'),
        ('1978', '23', '1305.01', '1206.1', '58.51', '100', '0', '0', '0'),
        ('1978', '24', '1310.51', '1207.36', '58.51', '100', '5000', '0', '197806'),
        ('1978', '25', '1312.59', '1207.21', '58.51', '100', '5000', '0', '197807'),
        ('1978', '26', '1312.59', '1207.21', '58.51', '100', '30000', '0', '197808');

        insert into`applied_updates`values ('260720232');
    end if;

    -- 27/07/2023 1
    if (select count(*) from `applied_updates` where id='270720231') = 0 then
        -- Escorting Erland, skip dialogs if source/targets not found.
        DELETE FROM `creature_movement_scripts` WHERE `id`=197803;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197803, 0, 0, 0, 0, 0, 0, 0, 1950, 0, 8, 18, 534, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Rane Text');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197804;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197804, 0, 0, 0, 0, 0, 0, 0, 1950, 0, 8, 16, 535, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Erland Reply');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197805;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197805, 0, 0, 0, 0, 0, 0, 0, 1950, 0, 8, 16, 536, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Check Next');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197806;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197806, 0, 0, 0, 0, 0, 0, 0, 1951, 0, 8, 16, 537, 0, 0, 0, 0, 0, 0, 0, 0, 'Ecorting Erland - Hello Quinn');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197807;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197807, 0, 0, 0, 0, 0, 0, 0, 1951, 0, 8, 18, 539, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Quinn Reply');

        DELETE FROM `creature_movement_scripts` WHERE `id`=197808;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(197808, 0, 0, 0, 0, 0, 0, 0, 1951, 0, 8, 16, 538, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Bye'),
(197808, 60, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Escorting Erland - Despawn');

        insert into`applied_updates`values ('270720231');
    end if;

    -- 29/07/2023 1
    if (select count(*) from `applied_updates` where id='290720231') = 0 then
        -- Deadly Poison <Rank 1> Level 30
        UPDATE `trainer_template` SET `reqlevel` = '30' WHERE (`template_entry` = '25') and (`spell` = '2843');
        UPDATE `trainer_template` SET `reqlevel` = '30' WHERE (`template_entry` = '26') and (`spell` = '2843');
        -- Deadly Poison <Rank 2> Level 38
        UPDATE `trainer_template` SET `reqlevel` = '38' WHERE (`template_entry` = '25') and (`spell` = '2844');
        UPDATE `trainer_template` SET `reqlevel` = '38' WHERE (`template_entry` = '26') and (`spell` = '2844');
        -- Crippling Poison <Rank 1> Level 20
        UPDATE `trainer_template` SET `reqlevel` = '20' WHERE (`template_entry` = '25') and (`spell` = '3422');
        UPDATE `trainer_template` SET `reqlevel` = '20' WHERE (`template_entry` = '26') and (`spell` = '3422');
        -- Crippling Poison <Rank 2> Level 50
        UPDATE `trainer_template` SET `reqlevel` = '50' WHERE (`template_entry` = '25') and (`spell` = '3423');
        UPDATE `trainer_template` SET `reqlevel` = '50' WHERE (`template_entry` = '26') and (`spell` = '3423');

        -- Changed Skeletal Enforcer level range to 25-26 and equipped with [Monster - Axe, 2H Rev. Bearded Single Bladed]
        UPDATE `creature_template` SET `level_min` = '25', `level_max` = '26', `equipment_id` = '725' WHERE (`entry` = '725');
        INSERT INTO `creature_equip_template` (`entry`, `equipentry1`, `equipentry2`, `equipentry3`) VALUES ('725', '5288', '0', '0');
        -- Rot Hide Gnoll Display ID.
        UPDATE `creature_template` SET `display_id1` = '847' WHERE (`entry` = '1674');

        insert into`applied_updates`values ('290720231');
    end if;

    -- 29/07/2023 2
    if (select count(*) from `applied_updates` where id='290720232') = 0 then

        -- Corporal Keeshan - Shield Bash
        UPDATE `creature_template` SET `spell_list_id` = '3490' WHERE (`entry` = '349');

        REPLACE INTO `creature_spells` (`entry`, `name`, `spellId_1`, `probability_1`, `castTarget_1`, `targetParam1_1`, `targetParam2_1`, `castFlags_1`, `delayInitialMin_1`, `delayInitialMax_1`, `delayRepeatMin_1`, `delayRepeatMax_1`, `scriptId_1`, `spellId_2`, `probability_2`, `castTarget_2`, `targetParam1_2`, `targetParam2_2`, `castFlags_2`, `delayInitialMin_2`, `delayInitialMax_2`, `delayRepeatMin_2`, `delayRepeatMax_2`, `scriptId_2`, `spellId_3`, `probability_3`, `castTarget_3`, `targetParam1_3`, `targetParam2_3`, `castFlags_3`, `delayInitialMin_3`, `delayInitialMax_3`, `delayRepeatMin_3`, `delayRepeatMax_3`, `scriptId_3`, `spellId_4`, `probability_4`, `castTarget_4`, `targetParam1_4`, `targetParam2_4`, `castFlags_4`, `delayInitialMin_4`, `delayInitialMax_4`, `delayRepeatMin_4`, `delayRepeatMax_4`, `scriptId_4`, `spellId_5`, `probability_5`, `castTarget_5`, `targetParam1_5`, `targetParam2_5`, `castFlags_5`, `delayInitialMin_5`, `delayInitialMax_5`, `delayRepeatMin_5`, `delayRepeatMax_5`, `scriptId_5`, `spellId_6`, `probability_6`, `castTarget_6`, `targetParam1_6`, `targetParam2_6`, `castFlags_6`, `delayInitialMin_6`, `delayInitialMax_6`, `delayRepeatMin_6`, `delayRepeatMax_6`, `scriptId_6`, `spellId_7`, `probability_7`, `castTarget_7`, `targetParam1_7`, `targetParam2_7`, `castFlags_7`, `delayInitialMin_7`, `delayInitialMax_7`, `delayRepeatMin_7`, `delayRepeatMax_7`, `scriptId_7`, `spellId_8`, `probability_8`, `castTarget_8`, `targetParam1_8`, `targetParam2_8`, `castFlags_8`, `delayInitialMin_8`, `delayInitialMax_8`, `delayRepeatMin_8`, `delayRepeatMax_8`, `scriptId_8`) VALUES (3490, 'Corporal Keeshan', 1672, 100, 1, 0, 0, 320, 0, 0, 8, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

        -- Missing In Action Scripts.
        DELETE FROM `quest_start_scripts` WHERE `id`=219;
        INSERT INTO `quest_start_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(219, 0, 0, 61, 219, 0, 0, 0, 0, 0, 0, 0, 21901, 0, 1014, 21901, 0, 0, 0, 0, 0, 'Missing in Action - Start Map Event'),
(219, 0, 2, 4, 147, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Remove NPC flags'),
(219, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 16, 25, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Say Text'),
(219, 3, 4, 60, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Start Waypoints');

        -- Success condition 21901: Target Has Done Quest 219
        INSERT INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`, `value3`, `value4`, `flags`) VALUES (21901, 8, 219, 0, 0, 0, 0);
        
        -- Fail condition script.
        DELETE FROM `generic_scripts` WHERE `id`=21901;
        INSERT INTO `generic_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(21901, 0, 0, 70, 219, 0, 0, 0, 219, 0, 21, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1014, 'Missing in Action - Fail Quest');

        DELETE FROM `creature_movement_scripts` WHERE `id`=34901;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(34901, 0, 0, 0, 0, 0, 0, 0, 219, 0, 21, 16, 26, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Take Break Text'),
(34901, 0, 0, 28, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 'Missing in Action - Sit'),
(34901, 44, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 'Missing in Action - Stand'),
(34901, 45, 0, 0, 0, 0, 0, 0, 219, 0, 21, 16, 27, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Say Text After Break');

        DELETE FROM `creature_movement_scripts` WHERE `id`=34902;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(34902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - SayText, Run.'),
(34902, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Misisng in Action - Set Running');

        DELETE FROM `creature_movement_scripts` WHERE `id`=34903;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(34903, 0, 0, 0, 0, 0, 0, 0, 219, 0, 21, 16, 29, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Say Text'),
(34903, 0, 0, 7, 219, 60, 1, 0, 219, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Quest Complete');

        DELETE FROM `creature_movement_scripts` WHERE `id`=34904;
        INSERT INTO `creature_movement_scripts` (`id`, `delay`, `priority`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `target_param1`, `target_param2`, `target_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `condition_id`, `comments`) VALUES
(34904, 0, 0, 0, 0, 0, 0, 0, 219, 0, 21, 16, 30, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Say Goodbye'),
(34904, 60, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing in Action - Despawn.');

        -- Waypoints.
        DELETE FROM `creature_movement_template` WHERE `entry`=349;
        INSERT INTO `creature_movement_template`
        VALUES
        (349,1,-8769.59,-2185.73,141.975,100, 0,0,0),
        (349,2,-8776.54,-2193.78,140.96,100, 0,0,0),
        (349,3,-8783.29,-2194.82,140.462,100, 0,0,0),
        (349,4,-8792.52,-2188.8,142.078,100, 0,0,0),
        (349,5,-8807.55,-2186.1,141.504,100, 0,0,0),
        (349,6,-8818,-2184.8,139.153,100, 0,0,0),
        (349,7,-8825.81,-2188.84,138.459,100, 0,0,0),
        (349,8,-8827.52,-2199.81,139.622,100, 0,0,0),
        (349,9,-8821.14,-2212.64,143.126,100, 0,0,0),
        (349,10,-8809.18,-2230.46,143.438,100, 0,0,0),
        (349,11,-8797.04,-2240.72,146.548,100, 0,0,0),
        (349,12,-8795.24,-2251.81,146.808,100, 0,0,0),
        (349,13,-8780.16,-2258.62,148.554,100, 0,0,0),
        (349,14,-8762.65,-2259.56,151.144,100, 0,0,0),
        (349,15,-8754.36,-2253.74,152.243,100, 0,0,0),
        (349,16,-8741.87,-2251,154.486,100, 0,0,0),
        (349,17,-8733.22,-2251.01,154.36,100, 0,0,0),
        (349,18,-8717.47,-2245.04,154.686,100, 0,0,0),
        (349,19,-8712.24,-2246.83,154.709,100, 0,0,0),
        (349,20,-8693.84,-2240.41,152.91,100, 0,0,0),
        (349,21,-8681.82,-2245.33,155.518,100, 0,0,0),
        (349,22,-8669.86,-2252.77,154.854,100, 0,0,0),
        (349,23,-8670.56,-2264.69,156.978,100, 0,0,0),
        (349,24,-8676.56,-2269.2,155.411,100, 0,0,0),
        (349,25,-8673.34,-2288.65,157.054,100, 0,0, 0),
        (349,26,-8677.76,-2302.56,155.917, 3.146, 45000,0, 34901),
        (349,27,-8682.46,-2321.69,155.917,100, 0,0,0),
        (349,28,-8690.4,-2331.78,155.971,100, 0,0,0),
        (349,29,-8715.1,-2353.95,156.188,100, 0,0,0),
        (349,30,-8748.04,-2370.7,157.988,100, 0,0,0),
        (349,31,-8780.9,-2421.37,156.109,100, 0,0,0),
        (349,32,-8792.01,-2453.38,142.746,100, 0,0,0),
        (349,33,-8804.78,-2472.43,134.192,100, 0,0,0),
        (349,34,-8841.35,-2503.63,132.276,100, 0,0,0),
        (349,35,-8867.57,-2529.89,134.739,100, 0,0,0),
        (349,36,-8870.67,-2542.08,131.044,100, 0,0,0),
        (349,37,-8922.05,-2585.31,132.446,100, 0,0,34902),
        (349,38,-8949.08,-2596.87,132.537,100, 0,0,0),
        (349,39,-8993.46,-2604.04,130.756,100, 0,0,0),
        (349,40,-9006.71,-2598.47,127.966,100, 0,0,0),
        (349,41,-9038.96,-2572.71,124.748,100, 0,0,0),
        (349,42,-9046.92,-2560.64,124.447,100, 0,0,0),
        (349,43,-9066.69,-2546.63,123.11,100, 0,0,0),
        (349,44,-9077.54,-2541.67,121.17,100, 0,0,0),
        (349,45,-9125.32,-2490.06,116.057,100, 0,0,0),
        (349,46,-9145.06,-2442.24,108.232,100, 0,0,0),
        (349,47,-9158.2,-2425.36,105.5,100, 0,0,0),
        (349,48,-9151.92,-2393.67,100.856,100, 0,0,0),
        (349,49,-9165.19,-2376.03,94.8215,100, 0,0,0),
        (349,50,-9187.1,-2360.52,89.9231,100, 0,0,0),
        (349,51,-9235.44,-2305.24,77.9253,100, 0,0,0),
        (349,52,-9264.73,-2292.92,70.0089,100, 0,0,0),
        (349,53,-9277.47,-2296.19,68.0896, 0, 4000,0,34903),
        (349,54,-9277.47,-2296.19,68.0896, 0, 4000,0,34904);

        insert into`applied_updates`values ('290720232');
    end if;

    -- 31/07/2023 1
    if (select count(*) from `applied_updates` where id='310720231') = 0 then
        -- Bo - Move spawn location to its first waypoint.
        UPDATE `spawns_creatures` SET `position_x` = '-9425.55', `position_y` = '129.192', `position_z` = '59.5418' WHERE (`spawn_id` = '80320');

        insert into`applied_updates`values ('310720231');
    end if;

    -- 01/08/2023 1
    if (select count(*) from `applied_updates` where id='010820231') = 0 then
        -- Update DisplayID, name and static_flags.
        UPDATE `creature_template` SET `display_id1` = '1752', `name` = 'Mud Thresh', `static_flags` = '268697616' WHERE (`entry` = '3461');
        
        -- Update the related quest text and reward money.
        UPDATE `quest_template` SET `Details` = 'Your findings are incredible, $N.  These oases hold properties that must come from an outside source.  Or perhaps an inside one.$B$BI want to know how these fissures are affecting the beasts who drink from the oases\' water.$B$BHunt mud threshers at the Lushwater and Stagnant Oases.  Bring me their hides so I may examine them.', `Objectives` = 'Bring 8 Mud Thresh Hides to Tonga Runetotem at the Crossroads.', `OfferRewardText` = 'Thank you, $N.  Studying the beasts of an area can tell much about the area itself.  We shall see what tale these hides tell.$B$BPlease accept my gratitude for your aid ... and perhaps you can use these coins.  I find that I do not need them.', `RequestItemsText` = 'How goes your collection?  Did you get the hides?', `RewOrReqMoney` = '750' WHERE (`entry` = '880');
        
        -- The spell_list already points to 34610 in 'creature_spells', which already have the spell set, update its name.
        UPDATE `creature_spells` SET `name` = 'Barrens - Mud Thresher' WHERE (`entry` = '34610');
        
        -- Bring those spawns outside water into water.
        -- https://db.thealphaproject.eu/index.php?action=show_quest&id=880 (Helps)
        UPDATE `spawns_creatures` SET `position_x` = '-1070.88', `position_y` = '-2200.54', `position_z` = '78.3212' WHERE (`spawn_id` = '14962');
        UPDATE `spawns_creatures` SET `position_x` = '-1121.84', `position_y` = '-2247.62', `position_z` = '78.4574' WHERE (`spawn_id` = '14946');
        UPDATE `spawns_creatures` SET `position_x` = '-1115.4', `position_z` = '78.3876' WHERE (`spawn_id` = '14941');
        UPDATE `spawns_creatures` SET `position_x` = '-1091.6', `position_y` = '-2038.12', `position_z` = '78.199' WHERE (`spawn_id` = '14966');
        UPDATE `spawns_creatures` SET `position_x` = '-1078.92', `position_y` = '-2021.58', `position_z` = '78.25' WHERE (`spawn_id` = '14944');
        UPDATE `spawns_creatures` SET `position_x` = '-1212.26', `position_y` = '-2998.36', `position_z` = '85.95' WHERE (`spawn_id` = '14960');
        UPDATE `spawns_creatures` SET `position_x` = '-1250.93', `position_z` = '86.114' WHERE (`spawn_id` = '14953');
        UPDATE `spawns_creatures` SET `position_x` = '-1261.16', `position_z` = '86.16' WHERE (`spawn_id` = '14967');
        UPDATE `spawns_creatures` SET `position_x` = '-1317.19', `position_z` = '86.161' WHERE (`spawn_id` = '14973');
        UPDATE `spawns_creatures` SET `position_x` = '-1279.18', `position_y` = '-2969.77', `position_z` = '86.16' WHERE (`spawn_id` = '14969');
        UPDATE `spawns_creatures` SET `position_x` = '-1237.41', `position_y` = '-2970.69', `position_z` = '86.1426' WHERE (`spawn_id` = '14968');

        insert into`applied_updates`values ('010820231');
    end if;

    -- 06/08/2023 1
    if (select count(*) from `applied_updates` where id='060820231') = 0 then
        -- Invalid sign.
        UPDATE `spawns_gameobjects` SET `ignored` = '1' WHERE (`spawn_id` = '26434');
        -- Skeletal Mage display id.
        UPDATE `creature_template` SET `display_id1` = '201' WHERE (`entry` = '203');
        -- Aldric Moore - Mail -> Leather Merchant
        UPDATE `creature_template` SET `subname` = 'Leather Armor Merchant' WHERE (`entry` = '1294');
        UPDATE `npc_vendor` SET `item` = '236' WHERE (`entry` = '1294') and (`item` = '285');
        UPDATE `npc_vendor` SET `item` = '237' WHERE (`entry` = '1294') and (`item` = '286');
        UPDATE `npc_vendor` SET `item` = '238' WHERE (`entry` = '1294') and (`item` = '287');
        UPDATE `npc_vendor` SET `item` = '239' WHERE (`entry` = '1294') and (`item` = '718');
        UPDATE `npc_vendor` SET `item` = '796' WHERE (`entry` = '1294') and (`item` = '847');
        UPDATE `npc_vendor` SET `item` = '797' WHERE (`entry` = '1294') and (`item` = '848');
        UPDATE `npc_vendor` SET `item` = '798' WHERE (`entry` = '1294') and (`item` = '849');
        UPDATE `npc_vendor` SET `item` = '799' WHERE (`entry` = '1294') and (`item` = '850');
        UPDATE `npc_vendor` SET `item` = '843' WHERE (`entry` = '1294') and (`item` = '1845');
        UPDATE `npc_vendor` SET `item` = '844' WHERE (`entry` = '1294') and (`item` = '1846');
        UPDATE `npc_vendor` SET `item` = '845' WHERE (`entry` = '1294') and (`item` = '1852');
        UPDATE `npc_vendor` SET `item` = '846' WHERE (`entry` = '1294') and (`item` = '1853');
        UPDATE `npc_vendor` SET `item` = '1839' WHERE (`entry` = '1294') and (`item` = '2392');
        UPDATE `npc_vendor` SET `item` = '1840' WHERE (`entry` = '1294') and (`item` = '2393');
        UPDATE `npc_vendor` SET `item` = '1843' WHERE (`entry` = '1294') and (`item` = '2394');
        UPDATE `npc_vendor` SET `item` = '1844' WHERE (`entry` = '1294') and (`item` = '2395');
        UPDATE `npc_vendor` SET `item` = '1849' WHERE (`entry` = '1294') and (`item` = '2396');
        UPDATE `npc_vendor` SET `item` = '1850' WHERE (`entry` = '1294') and (`item` = '2397');

        --  Krolg display_id.
        UPDATE `creature_template` SET `display_id1` = '2003' WHERE (`entry` = '3897');


        insert into`applied_updates`values ('060820231');
    end if;


    -- 06/08/2023 2
    if (select count(*) from `applied_updates` where id='060820232') = 0 then
        -- Man Brewnall Village with Mountaineers
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400436', '727', '0', '0', '0', '0', '-5382.093', '296.163', '393.711', '1.174', '300', '300', '0', '100', '100', '2', '0', '0', '0');
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400437', '727', '0', '0', '0', '0', '-5342.680', '270.096', '389.924', '1.656', '300', '300', '0', '100', '100', '2', '0', '0', '0');

        -- Waypoints around camp.
        DELETE FROM `creature_movement` WHERE `id`=400436;
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '1', '-5382.09', '296.163', '393.711', '1.174', '3000', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '2', '-5386.013', '305.535', '393.975', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '3', '-5398.224', '306.474', '395.696', '100', '1000', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '4', '-5386.488', '322.309', '394.674', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '5', '-5364.005', '325.863', '394.2444', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '6', '-5351.439', '317.126', '394.231', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '7', '-5353.012', '299.844', '394.627', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '8', '-5340.248', '269.987', '389.800', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '9', '-5358.914', '275.520', '394.103', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '10', '-5376.484', '277.488', '394.261', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400436', '11', '-5387.113', '288.699', '394.158', '100', '0', '0', '0');
        DELETE FROM `creature_movement` WHERE `id`=400437;
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '1', '-5382.09', '296.163', '393.711', '1.174', '3000', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '2', '-5386.013', '305.535', '393.975', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '3', '-5398.224', '306.474', '395.696', '100', '1000', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '4', '-5386.488', '322.309', '394.674', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '5', '-5364.005', '325.863', '394.2444', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '6', '-5351.439', '317.126', '394.231', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '7', '-5353.012', '299.844', '394.627', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '8', '-5340.248', '269.987', '389.800', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '9', '-5358.914', '275.520', '394.103', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '10', '-5376.484', '277.488', '394.261', '100', '0', '0', '0');
        INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `waittime`, `wander_distance`, `script_id`) VALUES ('400437', '11', '-5387.113', '288.699', '394.158', '100', '0', '0', '0');

        -- Barkeep Belm shouldn't sell Moonberry Juice and Soft Banana Bread.
        DELETE FROM `npc_vendor` WHERE (`entry` = '1247') and (`item` = '1645');
        DELETE FROM `npc_vendor` WHERE (`entry` = '1247') and (`item` = '4601');

        -- Spawn a White Ram.
        INSERT INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('400438', '4777', '0', '0', '0', '0', '-5540.217', '-1336.507', '398.664', '2.642', '300', '300', '0', '100', '100', '0', '0', '0', '0');
        -- Kreg Bilmn should sell Unlit Poor Torches.
        INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `itemflags`, `slot`) VALUES ('1691', '6183', '0', '0', '0', '0');

        insert into`applied_updates`values ('060820232');
    end if;

    -- 10/08/2023 1
    if (select count(*) from `applied_updates` where id='100820231') = 0 then
        -- Bring back a lost quest [Ambushed in the Forest]
        INSERT INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredClasses`, `RequiredRaces`, `RequiredSkill`, `RequiredSkillValue`, `RequiredCondition`, `RepObjectiveFaction`, `RepObjectiveValue`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewXP`, `RewOrReqMoney`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `RewMailMoney`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `ignored`) VALUES ('172', '2', '0', '25', '0', '25', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 'Ambushed in the Forest', 'Lord Ebonlocke sent me to Stormwind to represent Darkshire at the recent council of the House of Nobles. I was tasked with requesting military aid in light of the undead infestation which has taken over the forest.$B$BBut on my way back a band of thieves ambushed me. I was forced to drive my cart to The Rotting Orchard in southern Duskwood.$B$BBefore the thieves could rob me of my goods, a pack of ferocious Worgen overtook the thugs. Now I need you to retrieve my satchel from the chest in the wagon.', 'Retrieve Ambassador Berrybuck\'s satchel and bring it back to him in Darkshire.', 'Most impressive, $N. I can\'t thank you enough for your assistance. This satchel contains all of my notes and correspondence from my recent trip to Stormwind. Now, I must present the dark news to Lord Ebonlocke. We might not have the assistance of the Stormwind Army but at least we have our Night Watch.', 'Were you able to locate my satchel? I had it stashed in my chest which was in the back of the wagon. Last I saw, the thieves had the cart south at The Rotting Orchard.', '', '', '', '', '', '1923', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1982', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');

        -- Add A Talking Head to Rot Hide Graverobbers' loot table.
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('1941', '3317', '2', '0', '1', '1', '0');
        -- Adjust the lvl and lvl requirement of Resting in Pieces quest.
        UPDATE `quest_template` SET `MinLevel` = '0', `QuestLevel` = '12' WHERE (`entry` = '460');

        -- Change [Raptor Thieves] quest's characteristics.
        UPDATE `quest_template` SET `Title` = 'Stolen Silver', `Details` = 'Not long ago, a shipment of silver was stolen from our guard tower.  It was meant as payroll to the Crossroads\' guards, and we want that silver back.$B$BThe strange thing is... we caught one of the thieves on the night of the theft.  And... it was a raptor!  Unbelievable!$B$BI don\'t know what raptors would want with silver.  But I don\'t care -- I want it back, and I want the raptors dead so they won\'t steal from us again!$B$BSearch for raptors in the Barrens.  Collect  their heads, and find out stolen silver.', `Objectives` = 'Bring 15 Raptor Heads and 4 crates of Stolen Silver to Gazrog at the Crossroads.', `OfferRewardText` = 'You found the silver! And what\'s more important, you got rid of the raptors!$B$BThank you, $N.  You are a $c of worth.', `ReqItemId2` = '5061', `ReqItemCount1` = '15', `ReqItemCount2` = '4' WHERE (`entry` = '869');

        -- Stolen Silver, stackable 4.
        UPDATE `item_template` SET `stackable` = '4' WHERE (`entry` = '5061');
        -- Drop from Raptors.
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3254', '5061', '11', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3255', '5061', '11', '0', '1', '1', '0');
        INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES ('3256', '5061', '11', '0', '1', '1', '0');
        -- Remove [Sunscale Scytheclaw] spawns from their proto-nest.
        UPDATE `spawns_creatures` SET `ignored` = '1' WHERE `spawn_id` in ('20070', '19988', '20061', '20060', '20005', '20064', '20063', '20065');

        -- Rebald Yorglun <Raptor Trainer>. Level, stats from another level 50.
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50', `health_min` = '2768', `health_max` = '2768', `armor` = '2999', `dmg_min` = '85', `dmg_max` = '109' WHERE (`entry` = '4621');
        -- Jackson Bayne <Boar Trainer>, same, add tamed board.
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50', `health_min` = '2768', `health_max` = '2768', `armor` = '2999', `dmg_min` = '85', `dmg_max` = '109', `spell_id1` = '7905' WHERE (`entry` = '2939');
        -- Frank Ward <Bird Trainer>, same, add tamed bird.
        UPDATE `creature_template` SET `level_min` = '50', `level_max` = '50', `health_min` = '2768', `health_max` = '2768', `armor` = '2999', `dmg_min` = '85', `dmg_max` = '109', `spell_id1` = '7904' WHERE (`entry` = '2940');
        -- Hurom Juggendolf <Boar Trainer>, add boar.
        UPDATE `creature_template` SET `spell_id1` = '7905' WHERE (`entry` = '2880');
        -- Kyln Longclaw <Boar Trainer>, level 10.
        UPDATE `creature_template` SET `level_min` = '10', `level_max` = '10', `health_min` = '198', `health_max` = '198', `armor` = '20', `dmg_min` = '9', `dmg_max` = '13', `attack_power` = '62' WHERE (`entry` = '3697');
        -- Whaldak Darkbenk <Spider Trainer>, level 30.
        UPDATE `creature_template` SET `level_min` = '30', `level_max` = '30', `armor` = '1200', `dmg_min` = '42', `dmg_max` = '53', `attack_power` = '122' WHERE (`entry` = '2872');
        -- Henria Derth <Wolf Trainer>, tamed wolf, faction.
        UPDATE `creature_template` SET `faction` = '57', `spell_id1` = '4946' WHERE (`entry` = '2870');
        -- Brogun Stoneshield <Boar Trainer>, add boar, faction.
        UPDATE `creature_template` SET `spell_id1` = '7905', `faction` = '57' WHERE (`entry` = '5118');
        -- Aldric Hunter <Bear Trainer>, add bear.
        UPDATE `creature_template` SET `spell_id1` = '7903' WHERE (`entry` = '2938');
        -- Claude Erksine <Bear Trainer>, add bear.
        UPDATE `creature_template` SET `spell_id1` = '7903' WHERE (`entry` = '3545');
        -- Karrina Mekenda <Bird Trainer>, add bird.
        UPDATE `creature_template` SET `spell_id1` = '7904' WHERE (`entry` = '2879');
        -- Kar Stormsinger <Bird Trainer>, add bird.
        UPDATE `creature_template` SET `spell_id1` = '7904' WHERE (`entry` = '3690');
        -- Reban Freerunner <Tallstrider Trainer>, add strider.
        UPDATE `creature_template` SET `spell_id1` = '7913' WHERE (`entry` = '3688');
        -- Tamed Turtle.
        UPDATE `creature_template` SET `level_min` = '39', `level_max` = '39', `faction` = '85' WHERE (`entry` = '5448');
        INSERT INTO `spawns_creatures` (`spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`, `ignored`) VALUES ('5448', '0', '0', '0', '1', '-3144.601', '-2841.289', '34.626', '5.13', '300', '300', '0', '100', '100', '0', '0', '0', '0');
        -- Varng <Turtle Trainer>, level 39, stats.
        UPDATE `creature_template` SET `level_min` = '39', `level_max` = '39', `health_min` = '1677', `health_max` = '1677', `armor` = '1834', `dmg_min` = '57', `dmg_max` = '74', `attack_power` = '152' WHERE (`entry` = '4881');
        -- Om'kan  <Spider Trainer>, level 39, stats.
        UPDATE `creature_template` SET `level_min` = '39', `level_max` = '39', `health_min` = '1677', `health_max` = '1677', `armor` = '1834', `dmg_min` = '57', `dmg_max` = '74', `attack_power` = '152' WHERE (`entry` = '4882');

        insert into`applied_updates`values ('100820231');
    end if;

    -- 03/08/2023 1
    if (select count(*) from `applied_updates` where id='030820231') = 0 then
        -- https://github.com/The-Alpha-Project/alpha-core/issues/1199
        UPDATE `quest_template` SET `Title` = 'Awaiting Word', `OfferRewardText` = 'Hm, it seems that Watcher Dodds hasn''t been receiving my progress reports. I will have to take more care when I send my next. Thank you for bringing word to me.', `RewXP` = 1250 WHERE `entry` = 236;

        insert into`applied_updates`values ('030820231');
    end if;
    
	-- 13/08/2023 1
    if (select count(*) from `applied_updates` where id='130820231') = 0 then
        DROP TABLE IF EXISTS `gossip_menu`;
        CREATE TABLE `gossip_menu` (
        `entry` smallint(6) unsigned NOT NULL DEFAULT '0',
        `text_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
        `script_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
        `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
        PRIMARY KEY (`entry`,`text_id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

        INSERT INTO `gossip_menu` VALUES (64,564,0,90),(83,580,0,0),(265,764,0,0),(342,820,0,0),(345,823,0,0),(349,825,0,0),(382,879,0,0),(383,882,0,0),(401,898,0,0),(402,899,0,0),(403,900,0,0),(404,901,0,0),(405,902,0,0),(406,903,0,0),(407,904,0,0),(408,905,0,0),(409,906,0,0),(410,4797,0,101),(421,918,0,0),(422,919,0,0),(423,920,0,0),(424,921,0,0),(425,922,0,0),(426,923,0,0),(427,924,0,0),(428,925,0,0),(430,927,0,0),(431,928,0,0),(432,929,0,0),(435,933,0,0),(436,934,0,100),(441,938,0,0),(443,940,0,0),(444,941,0,0),(523,1040,0,98),(581,1118,0,0),(593,1261,0,0),(6089,7244,0,1359),(4264,5424,0,14),(685,1235,0,0),(686,1236,0,0),(688,1238,0,0),(699,1250,0,0),(704,1256,0,0),(721,1272,0,0),(900,1471,0,0),(922,1493,0,0),(942,1519,0,0),(4264,5423,0,372),(1142,1758,0,0),(1221,1853,0,0),(1290,938,0,0),(1291,820,0,0),(1293,824,0,0),(1296,821,0,0),(1297,823,0,0),(1403,2037,0,88),(1404,2038,0,0),(1405,2039,0,0),(1423,2055,0,0),(1467,2135,0,0),(1467,2136,0,7408),(2782,3470,0,367),(1481,2154,0,0),(1482,2153,0,0),(1561,2234,0,0),(1581,824,0,0),(1623,2275,0,0),(1630,2285,0,0),(1631,2286,0,0),(1662,2313,0,0),(1663,2315,0,0),(1721,2355,0,0),(1761,2393,0,0),(1781,2414,0,0),(1801,2434,0,0),(1802,2433,0,0),(1844,2496,0,0),(1901,2554,0,0),(1902,2555,0,0),(1903,2556,0,0),(1904,2557,0,0),(1905,2558,0,0),(1914,2568,0,3909),(1915,2570,0,0),(1922,2575,0,0),(1951,2593,0,0),(1961,2633,0,0),(1961,2634,0,60001),(1963,2637,0,0),(1965,2639,0,0),(1969,2642,0,0),(1971,2644,0,0),(2075,2728,0,0),(2076,2729,0,0),(2076,2727,0,0),(2081,2734,0,0),(2101,2753,0,0),(2121,2760,0,0),(2141,2761,0,0),(2142,2762,0,0),(2143,2764,0,0),(2144,2766,0,0),(2145,2768,0,0),(2146,2769,0,0),(2147,2770,0,0),(2148,2771,0,0),(2149,2772,0,0),(2150,2773,0,0),(2151,2774,0,0),(2152,2775,0,0),(2153,2776,0,0),(2161,2794,0,0),(2162,2795,0,0),(2163,2796,0,0),(2164,2797,0,0),(2165,2798,0,0),(2166,2799,0,0),(2167,2800,0,0),(2168,2793,0,0),(2169,2801,0,0),(2170,2802,0,0),(2172,2804,0,0),(2173,2805,0,0),(2175,2807,0,0),(2184,2817,0,0),(2188,2821,0,1145),(2188,2816,0,0),(2221,2873,0,0),(2242,2954,0,0),(2283,2973,0,0),(2321,3014,0,0),(2322,3017,0,0),(2324,3019,0,0),(2325,3020,0,0),(2326,3021,0,0),(2327,3023,0,0),(2328,3024,0,0),(2341,3026,0,0),(2342,3033,0,0),(2343,3022,0,0),(2344,3035,0,0),(2345,3036,0,0),(2347,3337,0,0),(2348,3037,0,0),(2349,3038,0,0),(2351,3034,0,0),(2352,3016,0,0),(2354,3040,0,0),(2356,3042,0,0),(2358,3044,0,0),(2403,3075,0,0),(2404,3076,0,0),(2422,3094,0,0),(2423,3095,0,0),(2424,3096,0,0),(2441,3133,0,0),(2562,3234,0,0),(2703,3375,0,0),(2782,3468,0,366),(2744,3405,0,0),(2782,3467,0,4),(2746,3409,0,0),(2782,3466,0,0),(4353,5562,0,374),(2781,3461,0,0),(2783,3471,0,0),(2852,3546,0,0),(2883,3559,0,0),(2890,3566,0,0),(2910,3583,0,0),(2911,3585,0,60029),(2911,3584,0,0),(2921,3633,0,2),(2984,3673,0,0),(3042,3754,0,0),(3081,3813,0,0),(3082,3814,0,0),(3101,3833,0,0),(3102,3834,0,0),(3126,3860,0,0),(3130,3854,0,0),(3131,4788,0,979),(3131,3866,0,0),(3141,3873,3141,0),(3161,3893,0,4117),(3181,3935,0,0),(6089,7243,0,0),(3184,3940,0,0),(3184,4039,0,60011),(3185,3942,0,4119),(3186,3945,0,4123),(3203,3961,0,0),(3202,3960,0,0),(3228,3985,0,278),(3228,3984,0,0),(3241,3996,0,0),(3285,4037,0,0),(3383,4135,0,0),(3421,4173,0,0),(3461,4213,0,0),(3506,4259,0,0),(3507,4260,0,0),(3508,4261,0,0),(3509,4262,0,0),(3510,4263,0,0),(3511,4265,0,0),(3512,4266,0,0),(3519,4264,0,0),(3520,4274,0,0),(3521,4275,0,0),(3526,4280,0,0),(3532,4273,0,0),(3533,4287,0,0),(3534,4288,0,0),(3535,4289,0,0),(3536,4290,0,0),(3537,4291,0,0),(3538,4293,0,0),(3539,4294,0,0),(3540,4295,0,0),(3541,4296,0,0),(3542,4297,0,0),(3543,4298,0,0),(3544,4299,0,0),(3545,4292,0,0),(3546,4301,0,0),(3547,4302,0,0),(3548,4303,0,0),(3549,4304,0,0),(3550,4305,0,0),(3551,4306,0,0),(3552,4307,0,0),(3553,4308,0,0),(3554,4310,0,0),(3556,4312,0,0),(3557,4313,0,0),(3558,4300,0,0),(3560,4317,0,0),(3561,4318,0,0),(3562,4319,0,0),(3563,4320,0,0),(3564,4322,0,0),(3565,4323,0,0),(3566,4324,0,0),(3567,4325,0,0),(3568,4326,0,0),(3569,4327,0,0),(3570,4329,0,0),(3571,4330,0,0),(3572,4328,0,0),(3573,4331,0,0),(3574,4332,0,0),(3575,4333,0,0),(3576,4334,0,0),(3577,4335,0,0),(3578,4336,0,0),(3579,4337,0,0),(3580,4316,0,0),(3603,4355,0,0),(3623,4396,0,0),(3624,4395,0,0),(3626,4401,0,0),(3642,4435,0,95),(3651,4450,0,0),(3664,4477,0,0),(3701,4513,0,0),(3721,4516,0,0),(3722,4517,0,0),(3723,4518,0,0),(3724,4519,0,0),(3761,4573,0,0),(3801,4633,0,0),(3802,4634,0,0),(3821,4357,0,0),(3841,4693,0,0),(3842,4694,0,0),(3864,4716,0,0),(3924,4781,0,88),(3985,4841,0,0),(4004,4859,0,4116),(4008,4863,0,96),(4009,4316,0,96),(4010,4866,0,96),(4013,4870,0,0),(4016,4878,0,4123),(4018,4876,0,4116),(4019,4877,0,4119),(4020,4879,0,4117),(4022,4875,0,4129),(4043,4933,0,0),(4044,4934,0,0),(4048,4938,0,0),(4085,4979,0,0),(4106,5009,0,0),(4107,5010,0,0),(4353,5565,0,373),(4353,5564,0,14),(4135,5112,0,0),(4353,5561,0,0),(4142,5133,0,0),(4147,5152,0,0),(4161,5208,0,381),(4150,5167,0,0),(4161,5211,0,380),(4161,5210,0,203),(4161,5207,0,0),(4262,5416,0,0),(4174,5265,0,0),(4262,5418,0,14),(4281,5453,0,0),(4282,5454,0,0),(4301,5473,0,0),(4302,5474,0,0),(4303,5475,0,0),(4306,5479,0,0),(4307,5454,0,0),(4323,5495,0,0),(4324,5496,0,0),(4326,5500,0,0),(4341,5515,0,0),(4342,5516,0,0),(4343,5517,0,0),(4262,5417,0,372),(2745,3406,0,0),(4358,5580,0,0),(4360,5582,0,0),(4362,5584,0,0),(4463,5674,0,0),(4485,538,0,90),(4506,4987,0,96),(4509,1040,0,98),(4511,1040,0,98),(4551,4999,0,96),(4552,560,0,90),(4558,4435,0,95),(4571,4781,0,88),(4572,4437,0,0),(4573,4437,0,0),(4576,4795,0,100),(4649,5721,0,0),(4659,4835,0,100),(4660,538,0,90),(4661,538,0,90),(4664,3976,0,0),(4666,4434,0,0),(4566,2193,0,67),(4680,4436,0,94),(4683,5724,0,0),(4689,5740,0,0),(4691,4438,0,94),(4697,1217,0,98),(4743,5816,0,0),(4743,5795,0,2),(4743,5817,0,805),(4746,5798,0,0),(4762,7026,0,66),(4781,5834,0,289),(4783,5838,0,96),(4783,5839,0,97),(4821,5875,0,91),(4822,5876,0,90),(4823,5878,0,90),(4826,5884,0,90),(4902,5974,0,0),(4921,5980,0,0),(4923,5982,0,0),(4924,5983,0,0),(4925,5984,0,0),(4926,5985,0,0),(4927,5986,0,0),(5102,6154,0,0),(5103,6155,0,0),(5221,6233,0,0),(5262,6277,0,0),(5263,6275,0,0),(5270,6290,0,0),(5271,6289,0,0),(5381,6413,0,0),(5382,6414,0,66),(5483,6535,0,0),(5665,6960,0,185),(5665,6961,0,0),(5741,6917,0,0),(5750,6933,0,0),(5751,6935,0,7491),(5753,6936,0,0),(5782,6957,0,0),(5851,7013,0,0),(2745,3407,0,4),(2745,3408,0,366),(657,1221,0,0),(5882,7046,0,0),(5883,7047,0,0),(63,563,0,91),(5967,7122,0,0),(6023,7175,0,0),(6028,7179,0,0),(6094,7251,0,0),(6162,7315,0,0),(6231,7390,0,0),(6235,7454,0,0),(6381,7574,0,0),(6422,7615,0,0),(6441,7634,0,0),(6442,7707,0,0),(542,1059,0,0),(6515,7713,0,0),(6519,7720,0,0),(6563,7778,0,0),(6585,7804,0,0),(6586,7803,0,0),(6587,7802,0,0),(6588,7801,0,0),(6597,7818,0,0),(6598,7819,0,0),(6599,7824,0,0),(6602,7829,0,0),(6603,7831,0,0),(6604,7833,0,0),(6605,7835,0,0),(6606,7837,0,0),(6607,7840,0,0),(6608,7843,0,0),(6609,7845,0,0),(6610,7847,0,0),(6612,7851,0,0),(6613,7853,0,0),(6614,7856,0,0),(6615,7859,0,0),(6616,7861,0,0),(6646,7902,0,0),(6658,7916,0,0),(6772,8084,0,1631),(6671,8209,0,0),(6672,7944,0,0),(6673,7945,0,0),(6674,7946,0,0),(6675,7947,0,0),(6676,7948,0,0),(6685,7965,0,0),(6696,8070,0,0),(6700,8072,0,0),(6702,8072,0,0),(6704,8070,0,0),(6708,8072,0,0),(6710,8070,0,0),(6712,8072,0,0),(6714,8070,0,0),(6716,8070,0,0),(6718,8070,0,0),(6720,8072,0,0),(6722,8072,0,0),(6724,8070,0,0),(6726,8070,0,0),(6771,8071,0,0),(6772,8082,0,0),(6773,8087,0,0),(6774,8088,0,0),(6775,8089,0,0),(6776,8090,0,0),(6777,8091,0,0),(6785,8101,0,0),(6800,8123,0,0),(6801,8124,0,0),(6803,8126,0,0),(6804,8128,0,0),(6805,8129,0,0),(6806,8130,0,0),(6837,8143,0,0),(6944,7778,0,0),(7034,8269,0,0),(7071,8333,0,0),(7104,8358,0,0),(7109,8366,0,0),(7238,8538,0,0),(7379,8834,0,0),(6207,7356,0,0),(6794,8112,0,15727),(8558,7778,0,0),(6333,7526,0,0),(6284,7483,0,0),(6457,7650,0,0),(15014,7898,0,0),(4764,5822,0,6628),(4764,5821,0,0),(4763,5820,0,6627),(6763,8076,0,0),(6761,8077,0,0),(6074,7224,0,0),(6073,7223,0,0),(6076,7226,0,0),(6075,7225,0,0),(6072,7222,0,0),(6071,7221,0,0),(6070,7220,0,0),(6069,7218,0,0),(6794,8078,0,0),(2521,3213,0,0),(6066,7231,0,0),(6065,7217,0,0),(6068,7219,0,0),(6067,7218,0,0),(6061,7214,0,0),(6060,7213,0,0),(6058,7212,0,0),(6057,7210,0,0),(6063,7216,0,0),(6062,7215,0,0),(6056,7209,0,0),(6055,7208,0,0),(6054,7207,0,0),(6053,7206,0,0),(6050,7203,0,0),(6049,7202,0,0),(6052,7205,0,0),(6051,7204,0,0),(6081,7230,0,0),(6080,7229,0,0),(6048,7201,0,0),(6047,7200,0,0),(6040,7185,0,0),(6032,7197,0,0),(6039,7183,0,0),(6031,7192,0,0),(6079,7187,0,0),(6033,7227,0,0),(6038,7177,0,0),(6026,7191,0,0),(6025,7180,0,0),(2621,3310,0,0),(2622,3309,0,0),(2623,3308,0,0),(2624,3307,0,0),(2625,3306,0,0),(2626,3305,0,0),(2627,3304,0,0),(2628,3303,0,0),(7058,8321,0,0),(2629,3302,0,0),(2630,3311,0,63),(2630,3301,0,0),(5357,6393,0,0),(5356,6381,0,0),(5355,6380,0,0),(5354,6379,0,0),(2329,3025,0,0),(2350,3039,0,0),(3201,3959,0,0),(3187,3953,0,1357),(3187,3954,0,0),(6092,7249,0,0),(5353,6378,0,0),(5352,6377,0,0),(5358,6385,0,0),(5351,6384,0,0),(5350,6374,0,0),(6222,7379,0,0),(6213,7375,0,946),(2944,3670,0,324),(5349,6373,0,53493),(2944,3656,0,0),(2541,3218,0,0),(20025,2013,0,0),(22,520,0,0),(21,519,0,315),(21,518,0,0),(2861,3554,0,943),(2861,3553,0,0),(1470,2140,0,0),(1470,2139,0,50408),(5502,6553,0,0),(5502,6555,0,400),(5503,6556,0,0),(5503,6557,0,1098),(5820,6993,0,0),(703,1255,0,0),(5819,6992,0,0),(6931,8218,0,0),(6812,8137,0,113),(6930,8220,0,0),(6929,8219,0,0),(4475,5721,0,99),(6934,8223,0,0),(4466,4434,0,95),(6932,8221,0,0),(6645,7900,0,0),(6644,7899,0,0),(2521,3214,0,3692),(5349,6375,0,53490),(5349,6354,0,0),(6924,8213,0,0),(5739,6913,0,0),(5738,6915,0,0),(5735,6907,0,0),(5733,6905,0,0),(5731,6903,0,0),(5721,6894,0,0),(5739,6914,0,0),(2601,3294,0,2601),(6627,7901,0,48),(15013,7897,0,0),(15012,7896,0,0),(15011,7895,0,0),(15010,7894,0,0),(15009,7893,0,0),(15008,7892,0,0),(15007,7891,0,0),(15006,7890,0,0),(15005,7889,0,0),(15004,7888,0,0),(15003,7887,0,0),(15002,7886,0,0),(6627,7885,0,45),(6627,7881,0,0),(321,818,0,0),(5382,6573,0,396),(5382,6415,0,0),(6363,7556,0,0),(6341,7534,0,0),(2601,3293,0,0),(6658,7917,0,57),(1141,1757,0,0),(50405,1924,0,0),(6321,7514,0,0),(6322,7515,0,0),(3922,4777,0,0),(2323,3018,0,0),(1341,1995,0,1341),(2991,3674,0,0),(16034,1998,0,0),(16035,1999,0,0),(6206,7360,0,0),(7083,8335,0,0),(740,1300,0,0),(742,1291,0,0),(743,1292,0,0),(744,1293,0,0),(751,1301,0,0),(1942,2594,0,0),(1949,2599,0,0),(2461,3153,0,0),(2462,3154,0,0),(2463,3155,0,0),(3280,4032,0,0),(3281,4033,0,0),(3282,4034,0,0),(3283,4035,0,0),(3284,4036,0,0),(3311,4051,0,0),(3312,4052,0,0),(3313,4053,0,0),(3329,4069,0,0),(3330,4070,0,0),(3334,4074,0,0),(3335,4075,0,0),(3336,4076,0,0),(3354,4095,0,0),(3355,4096,0,0),(3513,4267,0,0),(3514,4268,0,0),(3515,4269,0,0),(3516,4270,0,0),(3517,4271,0,0),(3518,4272,0,0),(3522,4276,0,0),(3523,4277,0,0),(3524,4278,0,0),(3525,4279,0,0),(3527,4281,0,0),(3528,4282,0,0),(3529,4283,0,0),(3530,4284,0,0),(3531,4285,0,0),(3555,4311,0,0),(3725,4520,0,0),(4901,5973,0,0),(4903,5976,0,0),(4904,5977,0,0),(4905,5978,0,0),(6339,7532,0,0),(6338,7531,0,0),(3127,3861,0,0),(3353,4093,0,0),(3352,4092,0,0),(3351,4091,0,0),(3350,4090,0,0),(3349,4089,0,0),(3348,4088,0,0),(3347,4087,0,0),(3346,4086,0,0),(3345,4085,0,0),(3344,4084,0,0),(3343,4083,0,0),(3342,4082,0,0),(3341,4081,0,0),(3340,4080,0,0),(3339,4079,0,0),(3338,4078,0,0),(3337,4077,0,0),(3356,4097,0,0),(3328,4068,0,0),(3327,4067,0,0),(3326,4066,0,0),(3325,4065,0,0),(3324,4064,0,0),(3323,4063,0,0),(3322,4062,0,0),(3321,4061,0,0),(3320,4060,0,0),(3319,4059,0,0),(3318,4058,0,0),(3317,4057,0,0),(3316,4056,0,0),(3315,4055,0,0),(3314,4054,0,0),(3331,4072,0,0),(6205,7359,0,0),(1912,2565,0,0),(1911,2564,0,0),(1910,2563,0,0),(1909,2562,0,0),(1908,2561,0,0),(1907,2560,0,0),(1906,2559,0,0),(1871,2518,0,0),(1869,2516,0,0),(1868,2515,0,0),(1866,2513,0,0),(1865,2504,0,0),(1864,2503,0,0),(1863,2502,0,0),(1981,2653,0,0),(1862,2501,0,0),(1861,2500,0,0),(1846,2499,0,0),(1845,2497,0,0),(789,1341,0,0),(791,1343,0,0),(788,1340,0,0),(787,1339,0,0),(786,1338,0,0),(785,1337,0,0),(784,1336,0,0),(783,1335,0,0),(782,1334,0,0),(781,1333,0,0),(780,1332,0,0),(750,1299,0,0),(749,1298,0,0),(748,1297,0,0),(747,1296,0,0),(746,1295,0,0),(745,1294,0,0),(842,1411,0,0),(5304,6336,0,0),(3083,3815,0,0),(1053,1653,0,0),(1045,1643,0,0),(1045,1753,0,38),(1044,1644,0,0),(1047,1647,0,0),(1047,1754,0,39),(1046,1648,0,0),(20005,1656,0,0),(20005,1655,0,42),(20006,1657,0,0),(1049,1649,0,0),(1049,1755,0,40),(1048,1650,0,0),(1050,1651,0,0),(1050,1756,0,41),(1282,1918,0,0),(20011,1656,0,0),(20011,1655,0,43),(1052,1652,0,0),(6626,7880,0,0),(161,581,0,0),(3062,3795,0,60),(4762,7027,0,65),(4827,5885,0,91),(4827,5886,0,90),(4762,7028,0,0),(4566,5722,0,0),(2044,2693,0,0),(60400,2694,0,0),(690,1240,0,0),(6808,8131,0,0),(6811,8081,0,0),(4782,5836,0,0),(4782,5835,0,67),(4763,5819,0,0),(3062,3794,0,0),(3702,4533,0,0),(3703,4534,0,0),(3704,4535,0,0),(3705,4536,0,0),(6204,7358,0,0),(3001,3693,0,0),(3001,3694,0,75),(4081,4974,0,0),(4082,4975,0,0),(4083,4976,0,0),(2849,3543,0,0),(2822,3514,0,0),(2823,3515,0,0),(2824,3516,0,0),(2825,3517,0,0),(2826,3518,0,0),(2827,3519,0,0),(2828,3520,0,0),(2847,3541,0,0),(2848,3542,0,0),(3726,4521,0,0),(4906,5979,0,0),(2821,3513,0,0),(2829,3521,0,0),(2830,3524,0,0),(2832,3526,0,0),(2833,3527,0,0),(2834,3528,0,0),(2835,3529,0,0),(2836,3530,0,0),(2837,3531,0,0),(2838,3532,0,0),(2839,3533,0,0),(2840,3534,0,0),(2841,3535,0,0),(2842,3536,0,0),(2843,3537,0,0),(2844,3538,0,0),(2845,3539,0,0),(6203,7357,0,0),(3261,4013,0,0),(3262,4014,0,0),(3263,4015,0,0),(3264,4016,0,0),(3265,4017,0,0),(3266,4018,0,0),(3267,4019,0,0),(3268,4020,0,0),(3269,4021,0,0),(3270,4022,0,0),(3271,4023,0,0),(3272,4024,0,0),(3273,4025,0,0),(3274,4026,0,0),(3275,4027,0,0),(3276,4028,0,0),(3277,4029,0,0),(3278,4030,0,0),(3279,4031,0,0),(1882,2533,0,0),(1883,2534,0,0),(5749,6929,0,246),(5749,6930,0,248),(5749,6931,0,247),(5749,6932,0,244),(3301,4048,0,0),(3302,4050,0,0),(3303,4049,0,0),(3304,4047,0,0),(3305,4046,0,0),(3306,4045,0,0),(3307,4044,0,0),(3308,4043,0,0),(3309,4042,0,0),(3310,4041,0,0),(1628,2282,0,0),(5762,6947,0,0),(1161,1793,0,0),(6282,7481,0,107),(6282,7599,0,0),(6459,7599,0,0),(6459,7652,0,107),(6460,7599,0,0),(6460,7653,0,107),(6461,7599,0,0),(6461,7654,0,107),(6462,7599,0,0),(6462,7655,0,107),(6463,7656,0,0),(6464,7616,0,0),(6464,7657,0,1010),(6465,7658,0,0),(6466,7616,0,0),(6466,7659,0,1010),(6467,7616,0,0),(6467,7660,0,1010),(6468,7616,0,0),(6468,7661,0,1010),(6469,7616,0,0),(6469,7662,0,1010),(6470,7642,0,0),(6470,7663,0,1011),(6471,7664,0,0),(6472,7642,0,0),(6472,7665,0,1011),(6473,7642,0,0),(6473,7666,0,1011),(6474,7642,0,0),(6474,7667,0,1011),(6475,7668,0,0),(6478,7678,0,0),(6478,7679,0,1011),(6484,7683,0,0),(6484,7684,0,1010),(6490,7688,0,0),(6490,7689,0,107),(6506,7699,0,326),(6506,7700,0,0),(6512,7704,0,0),(6512,7705,0,107),(6496,7693,0,0),(6496,7694,0,1010),(5442,6476,0,0),(6262,7435,0,0),(6323,7516,0,0),(6324,7517,0,0),(6362,7555,0,0),(6523,7725,0,0),(5746,6922,0,0),(1442,2115,0,0),(6518,7718,0,0),(5869,7042,0,0),(4663,3976,0,0),(4461,5673,0,0),(4678,3974,0,106),(4678,3975,0,105),(2304,2999,0,0),(4659,4837,0,101),(4676,4833,0,101),(4676,4834,0,100),(381,878,0,100),(381,4799,0,101),(4502,4835,0,100),(4502,4837,0,101),(4502,5993,0,198),(4577,5996,0,198),(410,907,0,100),(4512,638,0,100),(4512,4793,0,101),(4512,5996,0,198),(4690,4795,0,100),(4690,4794,0,101),(436,4794,0,101),(4576,4794,0,101),(4576,5996,0,198),(4540,581,0,100),(4540,4796,0,101),(4540,5996,0,198),(411,908,0,100),(411,4798,0,101),(411,5993,0,198),(4562,4834,0,100),(4562,4833,0,101),(4561,5695,0,100),(4561,4833,0,101),(4561,5993,0,198),(4650,1216,0,98),(4650,5721,0,99),(4684,1215,0,98),(4684,5724,0,99),(523,4985,0,99),(4653,1219,0,98),(4653,4984,0,99),(4526,1218,0,98),(4526,4973,0,99),(4510,4987,0,98),(4510,4986,0,99),(4697,5725,0,99),(4568,4989,0,98),(4568,4988,0,99),(4091,4992,0,98),(4091,4991,0,99),(4675,4999,0,96),(4675,5000,0,97),(4101,5001,0,96),(4101,5002,0,97),(4011,4867,0,96),(4011,4998,0,97),(4023,4889,0,96),(4023,4996,0,97),(4524,4997,0,96),(4524,4998,0,97),(4012,4868,0,96),(4012,4998,0,97),(4648,4987,0,96),(4648,5004,0,97),(4017,4888,0,0),(4010,5003,0,97),(4695,4863,0,96),(4695,4993,0,97),(4009,4993,0,97),(4092,4867,0,96),(4092,4993,0,97),(4621,4994,0,96),(4621,4993,0,97),(4693,6160,0,96),(4693,4993,0,97),(4550,4890,0,96),(4550,5000,0,97),(4474,4893,0,96),(4474,5000,0,97),(6402,7598,0,0),(6401,7594,0,0),(4665,4433,0,94),(4665,4434,0,95),(4680,4435,0,95),(3645,4442,0,94),(3645,4439,0,95),(4691,4437,0,95),(3644,4441,0,94),(3644,4440,0,95),(4652,5005,0,92),(4652,5006,0,93),(4515,5007,0,92),(4515,5008,0,93),(4660,539,0,91),(4552,561,0,91),(4685,558,0,90),(4685,559,0,91),(4654,562,0,90),(4654,563,0,91),(4822,5875,0,91),(4823,5877,0,91),(4826,5883,0,91),(64,565,0,91),(4825,5881,0,90),(4825,5882,0,91),(3921,4774,0,88),(3921,4775,0,89),(4606,5717,0,88),(4606,5716,0,89),(3926,4785,0,88),(3926,4786,0,89),(4688,4783,0,88),(4688,4784,0,89),(3923,4780,0,88),(3923,4779,0,89),(1403,4782,0,89),(3924,4782,0,89),(5266,6279,0,0),(5265,6281,0,0),(5269,6286,0,0),(5268,6287,0,0),(5277,6295,0,0),(5276,6296,0,0),(6327,7520,0,0),(6452,7644,0,0),(6285,7484,0,0),(6328,7521,0,0),(6453,7646,0,0),(6332,7525,0,0),(6334,7527,0,0),(5275,6293,0,0),(5274,6294,0,0),(6330,7523,0,0),(6455,7648,0,0),(2481,3173,0,0),(6329,7522,0,0),(6331,7524,0,0),(6283,7482,0,0),(6458,7651,0,0),(6325,7518,0,0),(6326,7519,0,0),(6335,7528,0,0),(6456,7649,0,0),(5273,6291,0,0),(5272,6292,0,0),(6336,7529,0,0),(5222,6235,0,0),(6337,7530,0,0),(344,822,0,0),(347,824,0,0),(1294,822,0,0),(6059,7211,0,0),(6525,7727,0,0),(6525,7820,0,18),(269,769,0,0),(4304,5476,0,0),(4138,5121,0,0),(4138,5122,0,391),(4138,5123,0,44),(1007,1598,0,0),(1007,1597,0,4),(1007,1599,0,366),(4263,5419,0,0),(4263,5420,0,372),(4263,5421,0,14),(5004,6062,0,0),(5062,6104,0,0),(4261,5413,0,0),(4261,5414,0,372),(4261,5415,0,14),(2801,3494,0,0),(2801,3495,0,104),(4110,5013,0,0),(4110,5014,0,25),(4110,5015,0,361),(5301,6333,0,0),(2581,3273,0,0),(3050,3273,0,0),(4322,5494,0,0),(1162,1794,0,0),(6644,8701,0,717),(6644,8702,0,718),(5065,8542,0,4213),(5065,8541,0,4214),(5065,6158,0,4212),(5065,6109,0,4207),(5065,6108,0,0),(4047,4937,0,0),(705,1257,0,0),(268,766,0,0),(1422,2054,0,0),(6655,7911,0,0),(7175,8455,0,7175),(7175,8454,0,0),(6582,7792,0,0),(6577,7793,0,0),(6578,7794,0,0),(6579,7795,0,0),(6581,7799,0,0),(7093,8347,0,0),(7095,8349,0,0),(6202,7355,0,0),(6933,8222,0,0),(6690,8063,0,0),(6692,8065,0,0),(6537,7740,0,0),(6538,7741,0,0),(6691,8064,0,0),(8400,8517,0,0),(8401,8518,0,0),(8402,8519,0,0),(8403,8520,0,0),(8404,8521,0,0),(8405,8522,0,0),(8406,8523,0,0),(8407,8529,0,0),(8408,8530,0,0),(8409,8531,0,0),(7268,8610,0,0),(7269,8609,0,0),(7270,8608,0,0),(7271,8607,0,0),(7272,8606,0,0),(7273,8605,0,0),(7274,8604,0,0),(7275,8603,0,0),(7276,8602,0,0),(7277,8601,0,0),(7278,8600,0,0),(7279,8599,0,0),(7280,8598,0,0),(7281,8597,0,0),(7282,8596,0,0),(7283,8595,0,0),(7284,8612,0,0),(7044,8271,0,0),(7044,50009,0,57006),(6476,7676,0,0),(6476,7677,0,6478),(6513,7711,0,0),(6513,7712,0,6478),(2184,2833,0,4321),(2203,2836,0,0),(2202,2834,0,0),(2186,2820,0,0),(6665,7942,0,0),(6665,8006,0,1631),(6790,8107,0,0),(6790,7969,0,264),(6788,8105,0,0),(6788,8084,0,264),(6789,8106,0,0),(6789,8094,0,264),(6810,8133,0,0),(6785,8006,0,264),(6786,8052,0,264),(6786,8103,0,0),(6787,8104,0,0),(6787,7969,0,264),(7157,8422,0,0),(7174,8452,0,0),(7219,8513,0,0),(6182,7334,0,0),(7239,8539,0,0),(4308,5480,0,0),(7054,8313,0,0),(5110,8306,0,0),(5111,8308,0,0),(5112,8307,0,0),(5113,8317,0,3),(5113,8319,0,2),(4188,5294,0,0),(4131,5098,0,362),(4122,5053,0,361),(687,1237,0,0),(1828,2477,0,0),(343,821,0,0),(6092,7254,0,1381),(701,1253,0,0),(700,1252,0,0),(4522,4441,0,94),(706,1258,0,0),(702,1254,0,0),(4522,4440,0,95),(684,1234,0,0),(4687,4784,0,89),(5902,7055,0,0),(6951,8238,0,0),(4182,5276,0,0),(4687,4783,0,88),(5348,6383,0,0),(6565,7780,0,0),(1017,1615,0,0),(4128,5079,0,0),(2906,3576,0,0),(1624,2278,0,0),(4741,6960,0,129),(4508,4784,0,89),(1012,1606,0,0),(4571,4782,0,89),(4741,6793,0,128),(4747,5799,0,0),(522,1039,0,0),(4644,5717,0,88),(980,1571,0,0),(4644,5716,0,89),(4305,5477,0,0),(4359,5581,0,0),(4348,5536,0,375),(4283,5455,0,0),(4741,5794,0,10217),(4741,5793,0,0),(4210,5355,0,0),(1022,1619,0,0),(2750,3421,0,0),(4130,5089,0,0),(4165,5224,0,381),(1501,2114,0,0),(3186,5857,0,4125),(4242,5399,0,379),(4242,5402,0,378),(656,1219,0,98),(656,4984,0,99),(4742,5794,0,0),(4086,4982,0,0),(4656,5719,0,67),(646,1208,0,0),(4201,5016,0,0),(4112,5019,0,0),(683,1233,0,0),(4125,5067,0,25),(4656,5720,0,236),(4655,5719,0,67),(4655,5720,0,236),(3862,4714,0,0),(5641,6755,0,0),(6229,7403,0,0),(3182,3938,0,1357),(1120,1734,0,0),(4325,5497,0,0),(1681,2333,0,0),(2207,2849,0,344),(2501,3194,0,0),(4569,5724,0,99),(4569,1215,0,98),(4657,5001,0,96),(4657,5002,0,0),(2941,3653,0,0),(2943,3657,0,0),(4677,3975,0,0),(4677,3974,0,106),(4007,4999,0,96),(4007,5000,0,97),(9556,5047,0,0),(4683,1215,0,98),(4119,5040,0,0),(4642,5714,0,67),(4642,5715,0,236),(4649,1216,0,98),(4666,4433,0,94),(4486,539,0,91),(4181,5273,0,0),(4486,538,0,90),(4661,539,0,91),(3661,4473,0,0),(3662,4474,0,0),(4264,5422,0,0),(5848,7010,0,0),(6041,7196,0,0),(6043,7195,0,0),(6042,7194,0,0),(6044,7193,0,0),(6035,7188,0,0),(6034,7186,0,0),(6037,7190,0,0),(6036,7189,0,0),(4112,5020,0,25),(4201,5316,0,25),(4201,5314,0,362),(4112,5021,0,361),(4201,5317,0,361),(4131,5097,0,25),(4165,5223,0,0),(4187,5291,0,0),(4187,5292,0,377),(4165,5226,0,203),(4187,5293,0,18),(4165,5227,0,380),(4351,5552,0,373),(4351,5551,0,0),(4351,5555,0,372),(4242,5398,0,0),(4351,5554,0,14),(4242,5401,0,18),(4143,5136,0,0),(4265,5425,0,0),(4265,5426,0,372),(4143,5138,0,44),(4265,5427,0,14),(4143,5137,0,391),(4349,5543,0,14),(4148,5161,0,391),(4349,5540,0,0),(4349,5544,0,372),(4148,5158,0,392),(4349,5541,0,373),(4519,565,0,91),(4519,564,0,90),(4345,5527,0,14),(4205,5334,0,377),(4345,5524,0,0),(4345,5528,0,372),(4205,5331,0,378),(4345,5525,0,373),(5853,7017,0,127),(5853,7021,0,0),(5853,7015,0,86),(4241,5393,0,0),(5853,7016,0,87),(4241,5396,0,18),(4344,5519,0,0),(840,1391,0,0),(1186,1818,0,0),(1188,1820,0,0),(840,1451,0,3301),(1187,1819,0,0),(841,1392,0,0),(4354,5567,0,374),(4354,5566,0,0),(4354,5570,0,373),(4843,5918,0,0),(4354,5569,0,14),(4144,5139,0,0),(4166,5229,0,381),(4166,5228,0,0),(4166,5232,0,380),(4205,5330,0,0),(4166,5231,0,203),(4205,5333,0,18),(1582,938,0,0),(4113,5024,0,361),(348,821,0,0),(3663,4476,0,0),(2021,2676,0,0),(5852,7014,0,0),(4160,5203,0,381),(4160,5202,0,0),(4160,5206,0,380),(4748,7017,0,127),(4160,5205,0,203),(4748,7016,0,87),(4128,5083,0,362),(645,1206,0,0),(4128,5081,0,25),(4119,5041,0,25),(4128,5080,0,361),(4119,5042,0,361),(4163,5216,0,203),(4241,5397,0,378),(4163,5213,0,0),(4163,5217,0,380),(4241,5394,0,379),(4163,5214,0,381),(5901,4859,0,4116),(24,522,0,0),(5901,5855,0,0),(543,1060,0,0),(23,523,0,0),(6522,7724,0,0),(126,623,0,0),(125,624,0,0),(2916,3590,0,0),(4209,5351,0,378),(4209,5350,0,0),(4209,5354,0,377),(4148,5157,0,0),(4209,5353,0,18),(4148,5160,0,44),(4347,5533,0,14),(4126,5073,0,361),(4347,5530,0,0),(4347,5534,0,372),(4126,5070,0,362),(4347,5531,0,373),(4309,5481,0,0),(6142,7295,0,0),(1824,2481,0,0),(1827,2478,0,0),(1825,2480,0,0),(1823,2482,0,0),(1826,2479,0,0),(4122,5051,0,25),(4132,5102,0,25),(4144,5141,0,44),(4132,5099,0,0),(4132,5103,0,362),(4144,5140,0,391),(4132,5100,0,363),(4168,5239,0,381),(4168,5238,0,0),(4168,5242,0,380),(4126,5069,0,0),(4168,5241,0,203),(4126,5072,0,25),(681,1231,0,0),(4518,565,0,91),(4518,564,0,90),(1822,2473,0,0),(1822,2474,0,3),(1830,2475,0,0),(1402,2035,0,0),(1829,2476,0,0),(4667,2193,0,67),(4667,5722,0,0),(4567,2193,0,67),(4567,5723,0,0),(2381,2193,0,67),(2381,5723,0,0),(4517,564,0,90),(4517,565,0,91),(6091,7248,0,1359),(6090,7245,0,0),(6091,7247,0,0),(6093,7250,0,0),(6090,7246,0,1359),(6095,7252,0,0),(6028,7178,0,398),(4150,5168,0,393),(4150,5170,0,44),(5753,6937,0,397),(4150,5171,0,392),(4941,5994,0,0),(1501,2173,0,1274),(1442,2174,0,1275),(4131,5095,0,363),(4467,4434,0,95),(4467,4433,0,94),(4607,5717,0,88),(4607,5716,0,89),(4481,5721,0,99),(4481,1216,0,98),(2360,3046,0,0),(2208,2848,0,341),(2208,2845,0,2),(2207,2842,0,0),(2208,2844,0,0),(2207,2843,0,3),(6798,8109,0,0),(6802,8125,0,0),(6792,8109,0,0),(6813,8139,0,0),(6797,8109,0,0),(1421,2053,0,0),(2405,3077,0,0),(2405,3098,0,60034),(1761,2394,0,2394),(4114,5027,0,361),(4131,5094,0,0),(4114,5026,0,25),(4125,5064,0,0),(4114,5025,0,0),(4125,5065,0,362),(6186,7339,0,866),(5708,6895,0,5742),(5740,6916,0,0),(6186,7393,0,0),(5715,6882,0,0),(6185,7340,0,0),(361,838,0,0),(60401,2695,0,0),(2662,3334,0,0),(4482,1216,0,98),(60402,2696,0,0),(4482,5721,0,99),(3161,5841,0,0),(4019,5862,0,0),(4020,5863,0,0),(4016,5860,0,4125),(3185,5844,0,0),(4016,4881,0,0),(5742,6918,0,5742),(5730,6904,0,0),(5734,6908,0,0),(5742,6923,0,0),(5732,6906,0,0),(5708,6876,0,0),(1043,1640,0,0),(597,1135,0,0),(597,1633,0,1354),(1043,1641,0,1354),(597,1136,0,1357),(3182,3937,0,0),(4120,5045,0,361),(7326,8703,0,0),(63,562,0,90),(4120,5044,0,25),(4471,3976,0,0),(4120,5043,0,0),(5855,7027,0,65),(657,7027,0,65),(5855,7028,0,0),(5855,7026,0,66),(657,7026,0,66),(657,1220,0,396),(4508,4783,0,88),(6208,7361,0,0),(6187,7341,0,0),(6212,7365,0,0),(6209,7362,0,0),(6211,7364,0,0),(6210,7363,0,0),(4147,5156,0,391),(6535,7737,0,334),(4147,5155,0,44),(4147,5153,0,392),(6535,7738,0,335),(1443,2113,0,0),(4002,4856,0,0),(3963,4815,0,0),(4003,4857,0,0),(5381,6414,0,66),(4271,5443,0,0),(5381,6573,0,396),(2189,2822,0,0),(6403,7597,0,0),(6404,7596,0,0),(6536,7739,0,0),(6590,7806,0,0),(6593,7812,0,0),(6807,8127,0,0),(2952,3666,0,0),(4348,5535,0,0),(2907,3575,0,0),(6024,7176,0,0),(4348,5539,0,372),(2908,3574,0,0),(4348,5833,0,376),(4121,5046,0,0),(4130,5090,0,362),(4130,5093,0,361),(4121,5047,0,25),(4130,5092,0,25),(4121,5048,0,361),(707,1259,0,0),(4581,5725,0,99),(4581,1217,0,98),(2882,3558,0,0),(4761,5813,0,0),(2881,3557,0,0),(4721,5773,0,0),(524,1041,0,0),(6770,8135,0,0),(4821,5876,0,90),(7063,8270,0,461),(7063,8243,0,460),(7063,8285,0,454),(7063,8282,0,459),(7021,8287,0,454),(7063,8286,0,458),(4572,4438,0,94),(6046,7198,0,0),(6600,7825,0,0),(6045,7199,0,0),(2703,3377,0,256),(5981,7134,0,0),(2704,3382,0,0),(7017,8291,0,458),(7017,8270,0,461),(7017,8290,0,455),(7017,8296,0,460),(7017,8284,0,459),(7016,8285,0,454),(6811,8137,0,113),(3502,4673,0,281),(3681,4495,0,0),(3683,4493,0,0),(3502,4254,0,0),(3682,4494,0,0),(1668,2320,0,0),(4520,565,0,91),(4127,5513,0,364),(4520,564,0,90),(6517,7717,0,0),(2903,3579,0,0),(643,1202,0,0),(2902,3580,0,0),(2904,3578,0,0),(2901,3573,0,0),(2905,3577,0,0),(4507,4783,0,88),(4507,4784,0,89),(5601,6694,0,0),(2705,3383,0,0),(3648,4446,0,0),(5601,6695,0,11492),(50300,3425,0,0),(3961,4813,0,0),(1629,2284,0,0),(1701,2353,0,0),(7088,8343,0,0),(7173,8448,0,0),(2951,3659,0,0),(2950,3660,0,0),(2949,3661,0,0),(2948,3662,0,0),(2947,3663,0,0),(2946,3664,0,0),(2945,3665,0,0),(6534,7736,0,0),(6558,7762,0,0),(6557,7763,0,0),(6556,7764,0,0),(6555,7765,0,0),(6554,7766,0,0),(6553,7767,0,0),(6552,7768,0,0),(6533,7735,0,0),(6551,7755,0,0),(6550,7756,0,0),(6549,7757,0,0),(6548,7758,0,0),(6547,7759,0,0),(6546,7760,0,0),(6545,7761,0,0),(6227,7400,0,0),(6227,7401,0,14871),(2190,2823,0,0),(6445,7638,0,0),(6445,7639,0,8227),(12920,7640,0,0),(4346,5529,0,0),(4381,5593,0,0),(4383,5595,0,0),(4382,5594,0,0),(1503,2175,0,67),(1503,5722,0,0),(4681,2193,0,67),(4681,5723,0,0),(4503,5693,0,67),(4503,5722,0,0),(4505,5693,0,67),(4505,5722,0,0),(4504,5693,0,67),(4504,5722,0,0),(4682,2193,0,67),(4682,5722,0,0),(56000,7038,0,0),(56001,7039,0,0),(56002,7040,0,0),(2187,2819,0,0),(5441,6475,0,0),(5482,6534,0,0),(1288,1923,0,0),(6927,8216,0,0),(6928,8217,0,0),(6925,8214,0,0),(6539,7742,0,0),(3186,3944,0,0),(4021,4874,0,4121),(4021,5864,0,0),(4006,4862,0,4121),(4006,5843,0,0),(4014,4871,0,4118),(4014,5858,0,0),(4001,4855,0,4118),(4001,5856,0,0),(4018,5861,0,0),(4004,5855,0,0),(4015,4873,0,4128),(4015,5859,0,4127),(4015,8368,0,4105),(4005,4869,0,4128),(4005,5840,0,0),(4022,5865,0,4127),(4022,8407,0,4105),(3162,3896,0,4129),(3162,5842,0,0),(880,1452,0,0),(884,1453,0,0),(883,1454,0,0),(882,1455,0,0),(881,1456,0,0),(1541,2213,0,0),(1541,6598,0,3313),(2387,3055,0,0),(2388,3056,0,0),(6087,7241,0,0),(1621,2273,0,0),(1621,2274,0,60000),(1622,2276,0,0),(1622,2277,0,60000),(7089,8342,0,0),(7090,8341,0,0),(2721,3380,0,0),(40002,2574,0,0),(4270,5440,0,0),(5961,7114,0,0),(5961,7116,0,60020),(4085,4980,0,60021),(301,798,0,0),(302,799,0,0),(3649,4447,0,0),(6541,7746,0,0),(6541,7747,0,60005),(6544,7753,0,0),(6544,7752,0,60004),(6596,7816,0,0),(6596,7817,0,60006),(2961,3668,0,0),(3183,3939,0,0),(3183,4040,0,60007),(3241,3997,0,60015),(3241,3998,0,60016),(3241,3999,0,60017),(2921,3634,0,3),(2921,3635,0,60028),(7085,8340,0,0),(2406,3100,0,0),(2407,3101,0,0),(2408,3102,0,0),(3382,4134,0,0),(3441,4193,0,0),(7070,8332,0,0),(1641,2293,0,0),(1641,3073,0,1012),(1323,1953,0,0),(1322,1954,0,0),(1321,1955,0,0),(1285,1920,0,0),(1286,1922,0,0),(1287,1921,0,0),(6094,7253,0,1382),(3067,3801,0,0),(3070,3804,0,0),(3072,3805,0,0),(6234,7387,0,0),(6233,7389,0,0),(6230,7404,0,0),(6574,7790,0,0),(6575,7789,0,0),(6201,7354,0,0),(6201,7382,0,946),(462,942,0,0),(446,943,0,0),(6769,6194,0,0),(5181,6194,0,0),(6768,6194,0,0),(5665,6793,0,186),(3665,5733,0,0),(3666,5734,0,0),(3667,5735,0,0),(3668,5736,0,0),(3669,5737,0,0),(3670,5738,0,0),(5813,6985,0,0),(50310,6986,0,0),(50311,6987,0,0),(50312,6988,0,0),(50313,6989,0,0),(6646,7884,0,1973),(3622,4393,0,0),(1201,1833,0,0),(1202,1834,0,0),(1203,1835,0,0),(1204,1836,0,0),(1205,1837,0,0),(1206,1838,0,0),(2884,3560,0,0),(2885,3561,0,0),(2886,3562,0,0),(2887,3563,0,0),(2888,3564,0,0),(2889,3565,0,0),(2201,2835,0,0),(6821,7933,0,0),(6873,8174,0,0),(6865,8168,0,0),(45000,8172,0,0),(6867,8169,0,0),(6833,7933,0,0),(6876,8176,0,0),(6858,8162,0,0),(6868,8170,0,0),(6872,7933,0,0),(45001,8173,0,0),(45002,8171,0,0),(6825,7935,0,0),(6874,7956,0,0),(45003,8175,0,0),(45004,8211,0,0),(6866,7933,0,0),(6921,7956,0,0),(6829,7935,0,0),(6855,7933,0,0),(6854,8157,0,0),(6906,7933,0,0),(45005,8192,0,0),(45006,8193,0,0),(6861,7933,0,0),(45007,8158,0,0),(45008,8166,0,0),(45009,8163,0,0),(45010,8167,0,0),(6905,7935,0,0),(45011,8190,0,0),(45012,8195,0,0),(6903,7935,0,0),(6830,7956,0,0),(45013,8186,0,0),(45014,8187,0,0),(45015,8194,0,0),(45016,8185,0,0),(6818,7935,0,0),(45017,8184,0,0),(45018,8191,0,0),(6814,7935,0,0),(6895,8188,0,0),(6815,7935,0,0),(6896,8189,0,0),(6899,7935,0,0),(45019,8150,0,0),(6841,7933,0,0),(6890,7935,0,0),(6828,7935,0,0),(6817,7956,0,0),(6832,7933,0,0),(6842,8148,0,0),(6843,8149,0,0),(6816,7933,0,0),(45020,8210,0,0),(45021,8152,0,0),(45022,8153,0,0),(6849,7956,0,0),(45023,8154,0,0),(45024,8155,0,0),(6819,7933,0,0),(6848,7933,0,0),(6834,7933,0,0),(45025,8156,0,0),(6852,7956,0,0),(6919,7956,0,0),(6853,7956,0,0),(6822,7956,0,0),(6877,8177,0,0),(6880,7956,0,0),(6878,8178,0,0),(6879,8179,0,0),(6826,7956,0,0),(45026,8180,0,0),(45027,8181,0,0),(6887,7956,0,0),(45028,8183,0,0),(45029,8182,0,0),(6831,7935,0,0),(45030,8197,0,0),(45031,8199,0,0),(45032,8198,0,0),(6824,7933,0,0),(6856,7933,0,0),(6823,7933,0,0),(6916,7933,0,0),(45033,8200,0,0),(6911,7935,0,0),(45034,8196,0,0),(6885,7935,0,0),(6912,7935,0,0),(6914,7935,0,0),(45035,8201,0,0),(6820,7935,0,0),(6864,7935,0,0),(6835,7956,0,0),(6889,7956,0,0),(6827,7956,0,0),(6888,7956,0,0),(4357,5579,0,0),(4355,5571,0,0),(4122,5049,0,0),(4122,5050,0,362),(541,1058,0,0),(6584,7800,0,0),(5481,6533,0,0),(6526,7728,0,0),(6562,7778,0,0),(262,759,0,0),(261,760,0,0),(6668,7937,0,0),(6669,7937,0,0),(6670,7937,0,0),(5743,6919,0,0),(4475,1216,0,98),(7086,8339,0,0),(6812,8134,0,0),(7087,8338,0,0),(7092,8345,0,0),(4466,4433,0,94),(5864,7037,0,0),(4544,4439,0,0),(4544,4442,0,94),(4545,4439,0,0),(4545,4442,0,94),(5818,6991,0,0),(1970,2643,0,0),(1262,1914,0,0),(2831,3523,0,0),(2741,3396,0,4),(2741,3395,0,0),(2741,3397,0,366),(4090,4990,0,0),(1632,2288,0,0),(1632,2289,0,0),(5854,7021,0,0),(5854,7015,0,86),(5854,7019,0,87),(5854,7017,0,127),(4208,5348,0,0),(4208,5345,0,377),(4208,5346,0,378),(4134,5108,0,0),(4134,5111,0,25),(4134,5110,0,363),(4115,5028,0,0),(4115,5029,0,25),(4115,5030,0,361),(4172,5258,0,377),(4172,5259,0,18),(4172,5257,0,0),(4744,6961,0,0),(4744,6793,0,128),(4744,6960,0,129),(4145,5142,0,0),(4145,5145,0,44),(4145,5146,0,391),(4145,5143,0,392),(4361,5583,0,0),(3501,4253,0,0),(4046,4936,0,0),(4127,5078,0,365),(4127,5075,0,361),(4127,5074,0,0),(264,761,0,0),(4129,5084,0,0),(4129,5087,0,25),(4129,5088,0,361),(4129,5085,0,362),(5542,6595,0,0),(4356,5575,0,0),(4356,5578,0,14),(4356,5577,0,374),(648,1210,0,0),(4116,5032,0,25),(4116,5031,0,0),(4116,5033,0,361),(2784,3488,0,0),(2784,3489,0,4),(2784,3490,0,368),(4045,4935,0,0),(4185,5285,0,0),(4185,5287,0,18),(4185,5286,0,377),(4117,5034,0,0),(4117,5035,0,25),(4117,5036,0,361),(4136,5116,0,391),(4136,5117,0,44),(4136,5115,0,0),(1242,1875,0,0),(2942,3654,0,0),(4140,5127,0,0),(4140,5129,0,44),(4140,5131,0,394),(4140,5128,0,395),(4267,5431,0,0),(4267,5433,0,14),(4267,5432,0,372),(4184,5282,0,0),(4184,5284,0,18),(4184,5283,0,377),(2749,3418,0,0),(2749,3419,0,4),(2749,3420,0,366),(4125,5068,0,361),(4156,5191,0,380),(4156,5192,0,203),(4156,5190,0,0),(4206,5335,0,0),(4206,5338,0,18),(4206,5339,0,377),(4206,5336,0,378),(4350,5545,0,0),(4350,5549,0,372),(4350,5546,0,373),(2561,3233,0,0),(4124,5059,0,0),(4124,5061,0,25),(4124,5060,0,361),(4124,5063,0,362),(4211,5360,0,0),(4211,5363,0,18),(4211,5364,0,377),(4211,5361,0,378),(2762,1261,0,0),(2762,3482,0,4),(2762,1262,0,367),(2762,3484,0,368),(282,778,0,0),(284,780,0,0),(4701,5753,0,0),(4202,5233,0,0),(4202,5319,0,203),(4202,5318,0,380),(4186,5288,0,0),(4186,5289,0,377),(1281,1916,0,0),(2385,2193,0,0),(2912,3591,0,1803),(2913,3592,0,1803),(2603,3298,0,0),(2603,3299,0,4788),(2603,3594,0,1803),(1301,1933,0,0),(1301,1934,0,174),(181,678,0,0),(4861,5935,0,1008),(4861,5934,0,1007),(4861,5933,0,1004),(4862,5940,0,1008),(4862,5939,0,1007),(4862,5938,0,1004),(4113,5023,0,25),(4113,5022,0,0),(4696,5725,0,99),(1601,2253,0,0),(4696,1217,0,98),(5763,6948,0,0),(752,1302,0,0),(800,1351,0,0),(820,1371,0,0),(2851,3545,0,0),(1143,1759,0,0),(1964,2368,0,0),(6228,7402,0,0),(4133,5104,0,0),(4133,5105,0,25),(4133,5106,0,363),(4164,5218,0,0),(4164,5220,0,380),(4164,5219,0,381),(1469,2138,0,0),(4842,5335,0,0),(1362,1994,0,0),(2306,3001,0,0),(1625,2279,0,0),(1401,2033,0,0),(4152,5177,0,0),(4152,5180,0,44),(4152,5179,0,393),(1465,2133,0,0),(1664,2316,0,0),(1665,2317,0,0),(1666,2318,0,0),(1941,2595,0,0),(1943,2596,0,0),(1944,2597,0,0),(1946,2600,0,0),(1948,2602,0,0),(1661,2314,0,0),(3142,3874,0,0),(5630,6741,0,0),(2421,3093,0,0),(56004,3793,0,0),(5541,6594,0,0),(1962,2636,0,0),(1966,2758,0,0),(1967,2640,0,0),(1968,2641,0,0),(2464,3156,0,0),(2362,3048,0,0),(4863,5943,0,0),(2602,3296,0,0),(3041,3753,0,0),(3074,3807,0,0),(4141,5130,0,0),(4141,5129,0,44),(4141,5131,0,394),(4141,5128,0,395),(3128,3864,0,0),(3133,3868,0,0),(4169,5243,0,0),(4169,5246,0,203),(4169,5247,0,381),(4169,5244,0,382),(4170,5248,0,0),(4170,5251,0,203),(4170,5252,0,381),(4170,5249,0,382),(4243,5403,0,0),(4243,5406,0,18),(4243,5405,0,379),(4244,5407,0,0),(4244,5410,0,18),(4244,5408,0,379),(4025,4891,0,0),(3646,4443,0,0),(7208,8498,0,0),(7213,8503,0,0),(7209,8499,0,0),(7210,8500,0,0),(7212,8502,0,0),(3481,4233,0,0),(3481,4953,0,676),(4061,4954,0,0),(4062,4955,0,0),(4063,4956,0,0),(4064,4957,0,0),(4065,4958,0,0),(3601,4353,0,0),(3602,4354,0,0),(3604,4356,0,0),(4084,4977,0,0),(3901,4753,0,0),(3962,4814,0,0),(5101,6153,0,0),(4066,4959,0,0),(4162,5212,0,0),(5161,6193,0,0),(4442,5654,0,0),(4441,5653,0,0),(4401,5613,0,0),(4981,6033,0,0),(4601,5713,0,0),(4841,5894,0,0),(4922,5981,0,0),(5109,6161,0,0),(5232,6250,0,0),(5521,6574,0,0),(5302,6334,0,0),(5303,6335,0,0),(5321,6353,0,0),(6261,7434,0,0),(5751,6934,0,0),(5824,6995,0,0),(5921,7074,0,0),(5962,7115,0,0),(5962,7121,0,228),(5966,7120,0,0),(5963,7117,0,0),(5942,7095,0,0),(5941,7094,0,0),(6085,7239,0,0),(6083,7237,0,0),(6086,7240,0,0),(6088,7242,0,0),(6524,7726,0,0),(6184,7338,0,0),(6183,7337,0,0),(6161,7314,0,0),(6223,7394,0,0),(6224,7395,0,0),(6225,7397,0,0),(6214,7366,0,955),(6221,7376,0,954),(6232,7406,0,0),(6343,7536,0,0),(6342,7535,0,0),(6361,7554,0,0),(6514,7696,0,0),(6447,7641,0,0),(6527,7729,0,0),(6528,7730,0,0),(6529,7731,0,0),(6530,7732,0,0),(6531,7751,0,1020),(6531,7733,0,0),(6564,7779,0,0),(6567,7782,0,0),(6583,7797,0,0),(6623,7874,0,0),(6796,8114,0,0),(6926,8215,0,0),(6791,8108,0,0),(6917,8202,0,0),(6936,8225,0,0),(6918,8205,0,0),(6923,8212,0,0),(7046,8292,0,0),(7045,8280,0,0),(7099,8353,0,0),(7151,8415,0,0),(7106,8363,0,0),(7107,8364,0,0),(7108,8363,0,0),(7098,8352,0,0),(7100,8354,0,0),(7097,8351,0,0),(7096,8350,0,0),(7135,8388,0,0),(7134,8389,0,0),(7133,8390,0,0),(7132,8391,0,0),(7131,8392,0,0),(7130,8393,0,0),(7129,8394,0,0),(7128,8395,0,0),(7127,8396,0,0),(7126,8397,0,0),(7150,8414,0,0),(7101,8355,0,0),(7145,8409,0,0),(7118,8384,0,0),(7119,8383,0,0),(7120,8382,0,0),(7121,8381,0,0),(7122,8380,0,0),(7102,8356,0,0),(7144,8408,0,0),(7111,8369,0,0),(7112,8368,0,0),(7105,8359,0,0),(7103,8357,0,0),(7152,8416,0,0),(7123,8387,0,0),(7124,8386,0,0),(7125,8385,0,0),(7236,8536,0,0),(7237,8537,0,0),(5968,7123,0,0),(433,932,0,0),(5856,7024,0,66),(5856,7025,0,65),(5856,7028,0,0),(4521,4441,0,94),(4521,4440,0,95),(1702,2354,0,0),(4042,4916,0,88),(4042,4918,0,206),(4042,4917,0,232),(4223,5373,0,0),(4224,5374,0,0),(4041,4913,0,88),(4041,4914,0,232),(4041,4915,0,206),(4225,5375,0,234),(4226,5376,0,233),(3801,4773,0,297),(5729,6896,0,0),(5728,6897,0,0),(5727,6898,0,0),(5726,6899,0,0),(5725,6900,0,0),(5724,6901,0,0),(5723,6902,0,0),(5756,6940,0,0),(5748,6927,0,0),(5857,7029,0,0),(5858,7034,0,0),(5859,7033,0,0),(5860,7032,0,0),(5861,7031,0,0),(5862,7030,0,0),(7084,8336,0,0),(6809,8132,0,0),(4781,3673,0,0),(4781,7006,0,7605),(5847,7007,0,0),(5846,7008,0,0),(682,1232,0,0),(689,1239,0,0),(692,1242,0,0),(691,1241,0,0),(4658,6165,0,100),(4658,6164,0,101),(6993,8243,0,460),(85,4796,0,101),(85,581,0,100),(4577,4795,0,100),(2685,3358,0,0),(141,4793,0,101),(141,638,0,100),(4577,4793,0,101),(4513,4793,0,101),(4513,638,0,100),(4513,5993,0,198),(1626,2280,0,0),(521,1124,0,1024),(521,1038,0,100),(521,4793,0,101),(521,5993,0,198),(4542,4796,0,0),(4542,581,0,100),(4542,5993,0,198),(4541,4796,0,0),(4541,581,0,100),(4541,5996,0,198),(5108,6159,0,0),(708,1260,0,0),(5461,6513,0,0),(5462,6514,0,0),(693,1243,0,0),(3043,3757,0,3757),(3043,3756,0,3756),(3043,3755,0,0),(3625,4399,0,0),(6024,7174,0,7784),(4845,5920,0,0),(5747,6925,0,0),(5747,6926,0,190),(5737,6911,0,0),(5755,6939,0,0),(5849,7011,0,0),(4748,7015,0,86),(4748,5800,0,0),(4123,5054,0,0),(4123,5057,0,25),(4123,5058,0,361),(4123,5055,0,362),(660,1225,0,0),(660,1226,0,0),(4146,5147,0,0),(4146,5150,0,44),(4146,5151,0,391),(4146,5148,0,392),(698,1249,0,0),(4203,5320,0,0),(4203,5323,0,18),(4203,5324,0,377),(4203,5321,0,378),(643,1203,0,235),(4183,5279,0,0),(4183,5281,0,18),(4183,5280,0,377),(1042,1635,0,0),(1041,1133,0,0),(1468,2137,0,0),(4844,5919,0,0),(2747,3412,0,0),(2747,3413,0,4),(2747,3414,0,366),(2761,3456,0,0),(2761,3457,0,4),(2761,3459,0,366),(2761,3460,0,367),(2742,3400,0,366),(2742,3399,0,4),(2742,3398,0,0),(2748,3415,0,0),(2748,3416,0,4),(2748,3417,0,366),(4151,5172,0,0),(4151,5175,0,44),(4151,5176,0,392),(4151,5173,0,393),(4139,5124,0,0),(4139,5126,0,44),(4139,5125,0,391),(4137,5119,0,391),(4137,5120,0,44),(4137,5118,0,0),(4149,5162,0,0),(4149,5165,0,44),(4149,5164,0,391),(4149,5163,0,392),(4118,5037,0,0),(4118,5038,0,25),(4118,5039,0,361),(4268,5434,0,0),(4268,5436,0,14),(4268,5435,0,372),(4352,5556,0,0),(4352,5559,0,14),(4352,5560,0,372),(4352,5557,0,373),(4269,5438,0,372),(4269,5439,0,14),(4269,5437,0,0),(4266,5428,0,0),(4266,5430,0,14),(4266,5429,0,372),(4154,5184,0,0),(4154,5186,0,203),(4154,5185,0,380),(4159,5199,0,0),(4159,5201,0,203),(4159,5200,0,380),(4157,5193,0,0),(4157,5195,0,203),(4157,5194,0,380),(4153,5182,0,380),(4153,5183,0,203),(4153,5181,0,0),(4155,5188,0,380),(4155,5189,0,203),(4155,5187,0,0),(4158,5196,0,0),(4158,5198,0,203),(4158,5197,0,380),(4204,5325,0,0),(4204,5328,0,18),(4204,5329,0,377),(4204,5326,0,378),(4207,5340,0,0),(4207,5343,0,18),(4207,5344,0,377),(4207,5341,0,378),(4173,5260,0,0),(4173,5262,0,18),(4173,5261,0,377),(6993,8286,0,458),(6993,8285,0,454),(6993,8250,0,461),(6993,8282,0,459),(4647,4997,0,96),(4647,4998,0,97),(4506,5004,0,97),(6984,8243,0,460),(6984,8286,0,458),(6984,8285,0,454),(6984,8282,0,459),(6984,8245,0,461),(7025,8296,0,460),(4008,4993,0,97),(7025,8286,0,458),(7025,8283,0,459),(7025,8263,0,461),(7025,8285,0,454),(6955,8296,0,460),(6955,8291,0,458),(4549,4999,0,96),(4549,5000,0,97),(6955,8290,0,455),(6955,8284,0,459),(6955,8235,0,461),(6980,8243,0,460),(6980,8286,0,458),(6980,8285,0,454),(4551,5000,0,97),(6980,8282,0,459),(6980,8245,0,461),(7009,8296,0,460),(7009,8291,0,458),(7009,8283,0,459),(7009,8244,0,461),(4694,4993,0,97),(4694,6160,0,96),(4528,5005,0,92),(4528,5006,0,93),(7009,8289,0,455),(7030,8291,0,458),(7030,8283,0,459),(7030,8263,0,461),(7030,8289,0,455),(7030,8241,0,460),(4530,5005,0,92),(4530,5006,0,93),(7004,8286,0,458),(7004,8283,0,459),(7004,8255,0,461),(7004,8287,0,454),(7004,8241,0,460),(6994,8298,0,455),(4529,5005,0,92),(4529,5006,0,93),(6994,8291,0,458),(6994,8283,0,459),(6994,8254,0,461),(6994,8242,0,460),(7024,8243,0,460),(7024,8286,0,458),(4525,1218,0,98),(4525,4973,0,99),(7024,8282,0,459),(7024,8245,0,461),(7024,8285,0,454),(7029,8296,0,460),(7029,8291,0,458),(7029,8283,0,459),(4527,1218,0,98),(4527,4973,0,99),(7029,8263,0,461),(7029,8290,0,455),(6996,8296,0,460),(6996,8251,0,461),(6996,8291,0,458),(6996,8290,0,455),(4533,4442,0,94),(4533,4439,0,95),(6996,8284,0,459),(7069,8291,0,458),(7069,8283,0,459),(7069,8263,0,461),(7069,8290,0,455),(7069,8242,0,460),(4531,4442,0,94),(4531,4439,0,95),(7018,8296,0,460),(7018,8291,0,458),(7018,8283,0,459),(7018,8270,0,461),(7018,8290,0,455),(7010,8296,0,460),(4532,4442,0,94),(4532,4439,0,95),(7010,8291,0,458),(7010,8283,0,459),(7010,8244,0,461),(7010,8290,0,455),(7001,8291,0,458),(7001,8283,0,459),(4534,562,0,90),(4534,563,0,91),(7001,8289,0,455),(4573,4438,0,94),(7001,8241,0,460),(7001,5725,0,99),(7001,1217,0,98),(7059,8296,0,460),(4536,562,0,90),(4536,563,0,91),(7059,8291,0,458),(7059,8283,0,459),(7059,8270,0,461),(7059,8290,0,455),(7028,8296,0,460),(7028,8291,0,458),(4535,562,0,90),(4535,563,0,91),(7028,8283,0,459),(7028,8263,0,461),(7028,8289,0,455),(7002,8283,0,459),(7002,8291,0,458),(7002,8290,0,455),(4645,1218,0,98),(4645,4973,0,99),(4103,5005,0,92),(4103,5006,0,93),(655,1218,0,98),(655,4973,0,99),(4643,5715,0,0),(4643,5714,0,67),(4641,5715,0,0),(4641,5714,0,67),(4104,5005,0,92),(4104,5006,0,93),(4603,5715,0,0),(4603,5714,0,67),(7002,8257,0,461),(7002,8242,0,460),(7026,8291,0,458),(7026,8283,0,459),(7026,8263,0,461),(7026,8290,0,455),(4604,5715,0,0),(4604,5714,0,67),(7026,8242,0,460),(7033,8303,0,446),(7033,8288,0,458),(7033,8283,0,459),(7033,8270,0,461),(7033,8241,0,460),(2384,5715,0,0),(2384,5714,0,67),(7035,8254,0,461),(7035,8291,0,458),(7035,8290,0,455),(7035,8284,0,459),(7035,8242,0,460),(6979,8243,0,460),(4516,5005,0,92),(4516,5006,0,93),(6979,8286,0,458),(6979,8285,0,454),(6979,8282,0,459),(6979,8250,0,461),(6982,8296,0,460),(6982,8291,0,458),(4509,4985,0,99),(6982,8290,0,455),(6982,8284,0,459),(6982,8251,0,461),(6986,8296,0,460),(6986,8244,0,461),(6986,8289,0,455),(4511,4985,0,99),(6986,8288,0,458),(6986,8283,0,459),(6986,4784,0,89),(6986,4783,0,88),(6985,8296,0,460),(6985,8286,0,458),(4578,1217,0,98),(4578,5725,0,99),(6985,8285,0,454),(6985,8282,0,459),(6985,8245,0,461),(6978,8286,0,458),(6978,8285,0,454),(6978,8282,0,459),(2383,5715,0,0),(2383,5714,0,67),(6978,8245,0,461),(6978,8243,0,460),(6964,8244,0,461),(6964,8299,0,458),(6964,8298,0,455),(6964,8297,0,459),(4609,5720,0,0),(4609,5714,0,67),(6964,8247,0,460),(6964,1206,0,0),(6964,1205,0,10217),(6997,8291,0,458),(6997,8290,0,455),(6997,8284,0,459),(4610,5720,0,0),(4610,5714,0,67),(6997,8242,0,460),(6997,8235,0,461),(7080,8298,0,455),(7080,8291,0,458),(7080,8284,0,459),(7080,8254,0,461),(4539,562,0,90),(4539,563,0,91),(7080,8242,0,460),(7079,8252,0,461),(7079,8286,0,458),(7079,8285,0,454),(7079,8282,0,459),(7079,8243,0,460),(4538,562,0,90),(4538,563,0,91),(7077,8286,0,458),(7077,8285,0,454),(7077,8282,0,459),(7077,8250,0,461),(7077,8243,0,460),(7078,8291,0,458),(4537,562,0,90),(4537,563,0,91),(7078,8251,0,461),(7078,8290,0,455),(7078,8284,0,459),(7078,8242,0,460),(7060,8296,0,460),(7060,8291,0,458),(4548,1219,0,98),(4548,4984,0,99),(7060,8283,0,459),(7060,8270,0,461),(7060,8290,0,455),(7019,8296,0,460),(7019,8291,0,458),(7019,8283,0,459),(4546,1219,0,98),(4546,4984,0,99),(7019,8270,0,461),(7019,8289,0,455),(7020,8296,0,460),(7020,8286,0,458),(7020,8283,0,459),(7020,8270,0,461),(4547,1219,0,98),(4547,4984,0,99),(7020,8285,0,454),(7021,8296,0,460),(7021,8286,0,458),(7021,8283,0,459),(7021,8270,0,461),(6999,8283,0,459),(4543,4442,0,94),(4543,4439,0,95),(6999,8286,0,458),(6999,8285,0,454),(6999,8255,0,461),(6999,8243,0,460),(6995,8296,0,460),(6995,8251,0,461),(4570,1215,0,98),(4570,5724,0,99),(6995,8291,0,458),(6995,8290,0,455),(6995,8284,0,459),(7076,8291,0,458),(7076,8283,0,459),(7076,8290,0,455),(4557,3974,0,106),(4557,3975,0,105),(7076,8257,0,461),(7076,8242,0,460),(7005,8291,0,458),(7005,8283,0,459),(7005,8256,0,461),(7005,8289,0,455),(4556,3974,0,106),(4556,3975,0,105),(7005,8241,0,460),(7005,5996,0,198),(7005,4795,0,100),(7005,4794,0,101),(7003,8286,0,458),(7003,8282,0,459),(4468,4433,0,94),(4468,4434,0,95),(7003,8287,0,454),(7003,8256,0,461),(7003,8241,0,460),(7075,8286,0,458),(7075,8282,0,459),(7075,8285,0,454),(4469,3976,0,0),(7075,8255,0,461),(7075,8243,0,460),(6954,8296,0,460),(6954,8289,0,455),(6954,8288,0,458),(6954,8283,0,459),(4470,3976,0,0),(6954,8235,0,461),(7032,8291,0,458),(7032,8283,0,459),(7032,8263,0,461),(7032,8289,0,455),(7032,8241,0,460),(4485,539,0,91),(7072,8296,0,460),(7072,8291,0,458),(7072,8283,0,459),(7072,8263,0,461),(7072,8290,0,455),(7068,8286,0,458),(4484,538,0,90),(4484,539,0,91),(7068,8282,0,459),(7068,8265,0,461),(7068,8285,0,454),(7068,8243,0,460),(7023,8291,0,458),(7023,8283,0,459),(4473,4893,0,96),(4473,5000,0,97),(7023,8287,0,454),(7023,8263,0,461),(7023,8241,0,460),(7022,8291,0,458),(7022,8283,0,459),(7022,8263,0,461),(4472,4893,0,96),(4472,5000,0,97),(7022,8289,0,455),(7022,8241,0,460),(6988,8296,0,460),(6988,8291,0,458),(6988,8244,0,461),(6988,8287,0,454),(4523,4441,0,94),(4523,4440,0,95),(6988,8283,0,459),(6987,8296,0,460),(6987,8291,0,458),(6987,8283,0,459),(6987,8244,0,461),(6987,8289,0,455),(4662,3976,0,0),(4674,4999,0,96),(4674,5000,0,97),(3643,4438,0,94),(3643,4437,0,95),(7008,8296,0,460),(7008,8291,0,458),(7008,8244,0,461),(7008,8290,0,455),(7008,8284,0,459),(7013,8296,0,460),(5061,4835,0,100),(5061,4837,0,101),(2912,3586,0,0),(7013,8291,0,458),(7013,8283,0,459),(7013,8270,0,461),(7013,8287,0,454),(7012,8296,0,460),(7012,8291,0,458),(5123,5005,0,92),(5123,5006,0,93),(7012,8283,0,459),(7012,8270,0,461),(7012,8289,0,455),(7011,8296,0,460),(7011,8291,0,458),(7011,8244,0,461),(3650,4449,3650,0),(4579,1217,0,98),(4579,5725,0,99),(7011,8289,0,455),(7011,8283,0,459),(7074,8243,0,460),(7074,8286,0,458),(7074,8282,0,459),(7074,8255,0,461),(201,698,201,0),(202,699,0,0),(1061,1674,0,0),(1062,1676,0,0),(1063,1675,0,0),(1064,1677,0,0),(1065,1678,0,0),(1066,1679,0,0),(1561,2235,0,8879),(1562,2238,0,0),(1563,2239,0,0),(1564,2237,0,0),(1565,2236,0,0),(2209,2846,0,0),(2061,2713,0,0),(2064,2725,0,0),(2065,2723,0,0),(2066,2722,0,0),(2067,2721,0,0),(2068,2720,0,0),(2069,2719,0,0),(2070,2718,0,0),(2071,2717,0,0),(2072,2716,0,0),(2073,2715,0,0),(2074,2714,0,0),(2802,3496,0,0),(2210,2847,0,0),(2301,2993,0,0),(3129,3865,0,0),(3129,4113,0,5202),(3224,3980,0,0),(3225,3981,0,0),(3226,3982,0,0),(3227,3983,0,0),(3223,3978,0,0),(3223,3979,0,277),(5562,6655,0,0),(5781,6955,0,0),(5784,6956,0,0),(5783,6958,0,0),(5675,6812,0,0),(5675,6954,0,313),(5689,6842,0,0),(5688,6843,0,0),(5687,6844,0,0),(5702,6867,0,0),(5701,6868,0,0),(5704,6869,0,0),(5703,6870,0,0),(50001,6984,0,0),(5709,6877,0,0),(5710,6878,0,0),(5711,6879,0,0),(5712,6880,0,0),(5713,6881,0,0),(5845,7001,0,0),(6421,7614,0,0),(6421,7714,0,7715),(6521,7723,0,0),(6532,7734,0,0),(6678,7949,0,0),(6678,8055,0,1631),(6679,7951,0,0),(6680,7952,0,0),(6681,7953,0,0),(6682,7954,0,0),(6683,7955,0,0),(6759,8071,0,0),(6629,7883,0,0),(7047,8305,0,0),(7048,8304,0,0),(6859,8164,0,0),(6778,8092,0,0),(6778,8094,0,1631),(6779,8209,0,0),(6780,8096,0,0),(6781,8097,0,0),(6782,8098,0,0),(6783,8099,0,0),(6784,8100,0,0),(6840,8147,0,0),(6839,8146,0,0),(6838,8145,0,0),(7091,8344,0,0),(7418,8960,0,0),(4558,4436,0,94),(7074,8285,0,454),(7016,8243,0,460),(7016,8286,0,458),(7016,8282,0,459),(7016,8270,0,461),(7000,8286,0,458),(4560,4435,0,95),(4560,4436,0,94),(7000,8282,0,459),(6977,8291,0,458),(6977,8290,0,455),(6977,8284,0,459),(6977,8244,0,461),(6977,8242,0,460),(4554,560,0,90),(4554,561,0,91),(6960,8243,0,460),(6960,8286,0,458),(6960,8285,0,454),(6960,8282,0,459),(6960,8245,0,461),(6983,8242,0,460),(4553,560,0,90),(4553,561,0,91),(6983,8291,0,458),(6983,8290,0,455),(6983,8284,0,459),(6983,8244,0,461),(6990,8291,0,458),(6990,8290,0,455),(3647,4445,0,0),(3642,4436,0,94),(6990,8284,0,459),(6990,8251,0,461),(6990,8242,0,460),(6971,8296,0,460),(6971,8302,0,458),(6971,8301,0,455),(5736,6909,0,0),(4093,4995,0,0),(4108,5012,0,0),(4109,5011,0,0),(5871,7044,0,0),(6591,7808,0,0),(6591,7809,0,8312),(6592,7810,0,0),(6592,7811,0,8311),(6589,7805,0,0),(6594,7813,0,0),(2402,3074,0,0),(3362,4118,0,0),(3363,4119,0,0),(3372,4130,0,0),(3381,4133,0,0),(3361,4117,0,0),(5863,7036,0,0),(2204,2837,0,0),(2205,2838,0,0),(6029,7182,0,0),(1914,2567,0,0),(3984,4839,0,101),(3984,4838,0,100),(2985,3677,0,0),(6030,7181,0,0),(561,1080,0,0),(562,1079,0,0),(563,1081,0,0),(564,1082,0,0),(565,1083,0,0),(566,1084,0,0),(567,1085,0,0),(568,1086,0,0),(569,1087,0,0),(570,1088,0,0),(571,1089,0,0),(572,1090,0,0),(573,1091,0,0),(574,1092,0,0),(575,1093,0,0),(576,1094,0,0),(943,1521,0,0),(1002,1646,0,0),(7230,8525,0,7200),(7230,8526,0,7201),(7230,8527,0,7202),(7166,8436,0,0),(4533,8653,0,9300),(7418,8653,0,9302),(1341,1973,0,0),(1363,1996,0,0),(1366,1997,0,0),(2992,3675,0,0),(2993,3676,0,0),(2986,3695,0,0),(2987,3696,0,0),(2988,3697,0,0),(2989,3699,0,0),(2990,3698,0,0),(6214,7374,0,946),(6221,7378,0,953),(6222,7377,0,945),(6213,7366,0,955),(1483,2155,0,0),(7053,8312,0,0),(7138,8400,0,0),(7110,8367,0,0),(7136,8399,0,0),(7137,8398,0,0),(7113,8371,0,0),(7114,8372,0,0),(7115,8373,0,0),(6767,8080,0,0),(6766,8079,0,0),(7168,8438,0,0),(6102,7257,0,0),(6141,7294,0,0),(6084,7238,0,0),(5081,6288,0,0),(1841,2493,0,0),(4067,4960,0,0),(3371,4122,0,0),(3370,4123,0,0),(3369,4124,0,0),(3368,4125,0,0),(3367,4126,0,0),(3366,4127,0,0),(3365,4128,0,0),(3364,4129,0,0),(282,779,0,983),(284,781,0,983),(433,930,0,983),(2177,2810,0,984),(2177,2933,0,4321),(2181,2812,0,0),(2178,2810,0,984),(2178,2933,0,4321),(2180,2811,0,0),(2179,2810,0,984),(2179,2933,0,4321),(2182,2813,0,0),(24,521,0,701),(7000,8285,0,454),(7081,8243,0,460),(7081,8286,0,458),(7081,8285,0,454),(7081,8282,0,459),(7081,8245,0,461),(7000,8255,0,461),(6959,8295,0,458),(6959,8296,0,460),(6959,8293,0,459),(6959,8235,0,461),(6959,8294,0,455),(6971,8249,0,461),(6976,8290,0,455),(6976,8284,0,459),(6976,8235,0,461),(6976,8291,0,458),(6976,8242,0,460),(6981,8286,0,458),(6981,8285,0,454),(6981,8282,0,459),(6981,8245,0,461),(7000,8243,0,460),(6981,8243,0,460),(2301,2994,0,11739),(1842,2494,0,0),(6971,8300,0,459),(6958,8286,0,458),(6958,8285,0,454),(6958,8282,0,459),(6958,8245,0,461),(4575,4793,0,101),(4575,4795,0,100),(4575,5996,0,198),(6958,8243,0,460),(6957,8291,0,458),(6957,8290,0,455),(6957,8284,0,459),(6957,8244,0,461),(6957,8242,0,460),(4562,5993,0,198),(2913,3587,0,0),(1469,2133,0,1367),(1468,2134,0,1368),(2853,3550,0,0),(6001,7154,0,0),(6001,7155,0,300),(6935,8224,0,0),(3803,4635,0,0),(3803,4636,0,221),(3063,3797,0,0),(3064,3798,0,0),(3065,3799,0,0),(3066,3800,0,0),(1945,2598,0,0),(1945,2605,0,494),(20023,2604,0,0),(20025,2606,0,0),(1947,2601,0,0),(3068,3802,0,0),(3069,3803,0,0),(3073,3806,0,0),(5817,6990,0,0),(1163,1796,0,0),(1164,1813,0,0),(1181,1813,0,0),(1182,1814,0,0),(1183,1815,0,0),(1184,1816,0,0),(1185,1817,0,0),(3049,3758,0,0),(3044,3763,0,0),(3045,3762,0,0),(3046,3761,0,0),(3047,3760,0,0),(3048,3759,0,0),(5872,7045,0,0),(5841,7005,0,0),(5842,7004,0,0),(5843,7003,0,0),(5844,7002,0,0),(6595,7814,0,0),(2465,3157,0,0),(2465,3158,0,501),(5501,6554,0,0),(7336,8720,0,0),(7336,8721,0,9124),(5283,6316,0,0),(5283,6317,0,21865),(5261,6273,0,0),(5261,6274,0,21829),(6766,8113,0,15727),(6767,8111,0,15727),(6561,7770,0,0),(6560,7770,0,0),(6559,7770,0,0),(3882,4718,0,0),(3882,4719,0,499),(3881,4721,0,0),(3883,4733,0,0),(3884,4734,0,0),(3885,4735,0,0),(3863,4715,0,0),(1381,2013,0,0),(2961,3669,0,299),(6799,8120,0,0),(6799,8121,0,348),(6799,8122,0,350),(6540,7744,6540,887),(6540,7771,0,888),(6543,7754,6540,887),(6543,7774,0,894),(6543,7775,0,892),(6543,7776,0,888),(6443,7635,0,0),(6443,7636,0,351),(6121,7274,0,0),(2211,2850,2211,0),(4679,4435,0,95),(4679,4436,0,94),(4686,560,0,90),(4686,561,0,91);

        insert into`applied_updates`values ('130820231');
    end if;

    -- 15/08/2023 1
    if (select count(*) from `applied_updates` where id='150820231') = 0 then
        -- https://github.com/vmangos/core/commit/4b4ef6682df96d9398ffc43507ad1d19486c9471
        INSERT INTO `creature_spells` VALUES (18950,'Silverpine Forest - Pyrewood Elder',2053,100,15,0,0,0,3,15,10,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
        UPDATE `creature_template` SET `spell_list_id`= 18950 WHERE `entry`=1895;

        insert into`applied_updates`values ('150820231');
    end if;

    -- 16/08/2023 2
    if (select count(*) from `applied_updates` where id='160820232') = 0 then

        DROP TABLE IF EXISTS `creature_pools`;

        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!40101 SET character_set_client = utf8 */;
        CREATE TABLE `creature_pools` (
        `id` mediumint(8) unsigned NOT NULL DEFAULT 0,
        `pool_entry` mediumint(8) unsigned NOT NULL DEFAULT 0,
        `chance` mediumint(8) unsigned NOT NULL DEFAULT 0,
        `description` varchar(255) NOT NULL DEFAULT '',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;


        -- CREATURE POOLING WORKING EXAMPLE WITH VULTROS IN WESTFALL
        INSERT INTO creature_pools (id, pool_entry, chance, description) 
        VALUES
            (28407, 1, 0, "Vultros"),
            (99118, 1, 0, "Vultros"),
            (99119, 1, 0, "Vultros"),
            (99120, 1, 0, "Vultros"),
            (99121, 1, 0, "Vultros"),
            (99122, 1, 0, "Vultros"),
            (99123, 1, 0, "Vultros"),
            (99124, 1, 0, "Vultros"),
            (99125, 1, 0, "Vultros"),
            (99126, 1, 0, "Vultros"),
            (99127, 1, 0, "Vultros"),
            (99128, 1, 0, "Vultros"),
            (99129, 1, 0, "Vultros"),
            (99130, 1, 0, "Vultros"),
            (99131, 1, 0, "Vultros"),
            (99132, 1, 0, "Vultros");
        
        insert into`applied_updates`values ('160820232');
    end if;
end $
delimiter ;
