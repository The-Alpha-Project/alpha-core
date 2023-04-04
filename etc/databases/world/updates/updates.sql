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
        SET `display_id1`=1557
        WHERE `entry`=5434;
        
        -- Sand Shark
        UPDATE `creature_template`
        SET `display_id1`=1557
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
        SET `display_id1`=1197
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

end $
delimiter ;
