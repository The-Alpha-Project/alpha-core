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
        UPDATE `alpha_world`.`quest_template` SET `RewXP` = '220' WHERE (`entry` = '420');

        insert into`applied_updates`values ('040720231');
    end if;

    -- 06/07/2023 1
    if (select count(*) from `applied_updates` where id='060720231') = 0 then

        ALTER TABLE `quest_template` ADD COLUMN `RequiredCondition` MEDIUMINT(5) NOT NULL DEFAULT 0 AFTER `RequiredSkillValue`;
        UPDATE `quest_template` SET `RequiredCondition` = 778 WHERE `entry` = 207;
        UPDATE `quest_template` SET `RequiredCondition` = 215 WHERE `entry` = 215;
        UPDATE `quest_template` SET `RequiredCondition` = 790 WHERE `entry` = 690;
        UPDATE `quest_template` SET `RequiredCondition` = 949 WHERE `entry` = 960;
        UPDATE `quest_template` SET `RequiredCondition` = 108003 WHERE `entry` = 1080;
        UPDATE `quest_template` SET `RequiredCondition` = 20227 WHERE `entry` = 1191;
        UPDATE `quest_template` SET `RequiredCondition` = 1303 WHERE `entry` = 1301;

        insert into`applied_updates`values ('060720231');
    end if;

end $
delimiter ;
