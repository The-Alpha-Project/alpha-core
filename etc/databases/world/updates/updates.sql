delimiter $
begin not atomic
    -- 11/05/2020 1
    if (select count(*) from applied_updates where id='110520201') = 0 then
        insert into worldports (x, y, z, o, map, name) values (3167.27, -1407.15, 0, 0, 17, 'Kalidar');
        insert into worldports (x, y, z, o, map, name) values (100, 100, 200, 0, 30, 'PvPZone01');
        update worldports set name = 'pvpzone02_new' where entry = 1017;
        insert into worldports (x, y, z, o, map, name) values (277.77, -888.38, 400, 0, 37, 'PvPZone02');
        insert into worldports (x, y, z, o, map, name) values (0, 0, 0, -0.277778, 13, 'testing');
        insert into worldports (x, y, z, o, map, name) values (0, 0, 0, -0.277778, 29, 'CashTest');
        insert into worldports (x, y, z, o, map, name) values (0, 0, 0, -0.277778, 42, 'Collin');
        insert into worldports (x, y, z, o, map, name) values (0.76, -0.91, -2.32, 0, 44, 'OldScarletMonastery');
        insert into worldports (x, y, z, o, map, name) values (52, 0.6, -17.53, 6.2, 34, 'StormwindJail');
        insert into worldports (x, y, z, o, map, name) values (-1.43, 38.9, -23.6, 1.5, 35, 'StormwindPrison');

        insert into spawns_gameobjects (spawn_entry, spawn_map, spawn_positionX, spawn_positionY,
        spawn_positionZ, spawn_orientation, spawn_rotation0, spawn_rotation1, spawn_rotation2, spawn_rotation3,
        spawn_spawntime) values (2169, 0, -9036.7, 842.987, 109.076, 0.410153, 0, 0, 0.203642, 0.979046, 120);

        insert into applied_updates values ('110520201');
    end if;

    -- 11/05/2020 2
    if (select count(*) from applied_updates where id='110520202') = 0 then
        alter table spawns_gameobjects drop column displayid;

        insert into applied_updates values ('110520202');
    end if;

    -- 13/05/2020 1
    if (select count(*) from applied_updates where id='130520201') = 0 then
        update creatures set name = replace(name, '[UNUSED] ', '') where subname = 'Spirit Healer';
        update creatures set name = replace(name, '[PH] ', '') where subname = 'Spirit Healer';
        update creatures set faction = 35, level_min = 45, level_max = 45, health_min = 2972, health_max = 2972 where subname = 'Spirit Healer';

        insert into spawns_creatures (spawn_entry1, display_id, map, position_x, position_y, position_z, orientation) values
        (4318, 2413, 1, -634.062927, -4249.992676, 38.552738, 6.15);

        insert into applied_updates values ('130520201');
    end if;

    -- 15/05/2020 1
    if (select count(*) from applied_updates where id='130520201') = 0 then
        -- https://github.com/vmangos/core/commit/6293b1193cf74aead64a06f0ba75a79f0f35d3f3
        -- Tanaris patch 2.2.0 and patch 3.0.8
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=6849;
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5719;
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5715;

        -- Un'goro patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=7715;
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5749;

        -- Badlands patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=6875;

        -- Stonetalon patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5718;
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5717;

        -- Alterac Mountains patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5725;

        -- Barrens patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5724;

        -- Dustwallow Marsh patch 3.0.8
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5723;

        -- Searing Gorge patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=5729;

        -- Western Plaguelands patch 2.2.0
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=6858;

        -- https://github.com/vmangos/core/commit/02afc0d21df989914aa924b4f03ba048f9baf228
        -- Add missing sign object spawns.
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`,`spawn_map`,`spawn_positionX`,`spawn_positionY`,`spawn_positionZ`,`spawn_rotation0`,`spawn_rotation1`,`spawn_rotation2`,`spawn_rotation3`,`spawn_spawntime`,`spawn_animprogress`,`spawn_state`) VALUES
        (42103, 3229, 1, -94.8737, -4739.08, 24.7169, 0, 0, 1, 0, 7200, 1, 100),
        (42104, 3230, 1, -94.0994, -4739, 24.664, 0, 0, 0, 1, 7200, 1, 100),
        (42105, 3235, 1, -94.1309, -4739, 23.8332, 0, 0, 0, 1, 7200, 1, 100),
        (42106, 38927, 0, -6383.81, 1252.43, 8.34384, 0, 0, -0.75471, 0.656059, 7200, 1, 100),
        (42107, 123215, 0, -4020.33, -1407.01, 155.454, 0, 0, 0.710185, 0.704015, 7200, 1, 100),
        (42108, 123216, 0, -4020.05, -1407.16, 155.463, 0, 0, 1, 0, 7200, 1, 100),
        (42109, 123217, 0, -4020.05, -1407.01, 155.437, 0, 0, 0.004363, 0.99999, 7200, 1, 100);

        -- Add missing Talon Den object spawns from mangos zero.
        -- https://github.com/mangoszero/database/commit/b4d849d77bd03d31e71dfe8108de98b56ce29c87
        REPLACE INTO `spawns_gameobjects` (`spawn_id`, `spawn_entry`,`spawn_map`,`spawn_positionX`,`spawn_positionY`,`spawn_positionZ`,`spawn_orientation`,`spawn_rotation0`,`spawn_rotation1`,`spawn_rotation2`,`spawn_rotation3`,`spawn_spawntime`,`spawn_animprogress`,`spawn_state`) VALUES
        (42110, 152093, 1, 2511.77, 1986.62, 347.705, 3.7958, 0, 0, 0.0524759, 0.998622, 7200, 100, 1),
        (42111, 152093, 1, 2501.17, 1911.33, 344.059, 1.0414, 0, 0, 0.0524759, 0.998622, 7200, 100, 1),
        (42112, 152093, 1, 2403.67, 1809.85, 359.99, 0.403666, 0, 0, 0.0524759, 0.998622, 7200, 100, 1),
        (42113, 152093, 1, 2445.36, 1994.02, 339.368, 6.27765, 0, 0, 0.00276556, -0.999996, 7200, 100, 1),
        (42114, 152093, 1, 2457.19, 1931.27, 362.05, 0.306274, 0, 0, 0.152539, 0.988297, 7200, 100, 1),
        (42115, 152093, 1, 2470.74, 1863.08, 348.472, 4.67701, 0, 0, 0.719504, -0.694488, 7200, 100, 1),
        (42116, 152093, 1, 2460.92, 1798, 352.504, 2.94677, 0, 0, 0.995259, 0.0972552, 7200, 100, 1);

        -- https://github.com/vmangos/core/commit/3d97172ecb0fd689ef236b8c66f966bfb182e0b6
        -- correct positions for stockade guards
        UPDATE `spawns_creatures` SET `position_x` = -8782.927734, `position_y` = 826.459595, `position_z` = 97.426674 WHERE `spawn_id`= 90455;
        UPDATE `spawns_creatures` SET `position_x` = -8787.88281, `position_y` = 832.964172, `position_z` = 97.373196, `orientation` = 0.255604 WHERE `spawn_id`= 90456;
        UPDATE `spawns_creatures` SET `position_x` = -8787.343750, `position_y` = 830.022705, `position_z` = 97.651077, `orientation` = 0.725481 WHERE `spawn_id`= 90454;
        UPDATE `spawns_creatures` SET `position_x` = -8784.890625, `position_y` = 826.708313, `position_z` = 97.650780, `orientation` = 0.763170 WHERE `spawn_id`= 90453;
        UPDATE `spawns_creatures` SET `position_x` = -8792.311523, `position_y` = 831.371094, `position_z` = 97.644211, `orientation` = 0.149050 WHERE `spawn_id`= 90472;
        UPDATE `spawns_creatures` SET `position_x` = -8791.253906, `position_y` = 835.584045, `position_z` = 97.634636, `orientation` = 6.165888 WHERE `spawn_id`= 90473;
        UPDATE `spawns_creatures` SET `position_x` = -8779.591797, `position_y` = 823.153198, `position_z` = 97.635078, `orientation` = 1.459418 WHERE `spawn_id`= 90474;
        UPDATE `spawns_creatures` SET `position_x` = -8786.200195, `position_y` = 822.289551, `position_z` = 97.641891, `orientation` = 1.031716 WHERE `spawn_id`= 90475;

        -- correct positions for injured stockade guards
        UPDATE `spawns_creatures` SET `orientation` = 3.776711 WHERE `spawn_id`= 79522;
        UPDATE `spawns_creatures` SET `orientation` = 3.776711 WHERE `spawn_id`= 79580;
        UPDATE `spawns_creatures` SET `orientation` = 3.776711 WHERE `spawn_id`= 79550;

        -- add missing injured stockade guard
        REPLACE INTO `spawns_creatures` (`spawn_id`, `spawn_entry1`, `spawn_entry2`, `spawn_entry3`, `spawn_entry4`, `map`, `display_id`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `wander_distance`, `health_percent`, `mana_percent`, `movement_type`, `spawn_flags`, `visibility_mod`) VALUES
        (79581, 4996, 0, 0, 0, 0, 0, 0, -8766.31, 819.304, 97.6345, 5.357542, 540, 540, 0, 100, 0, 0, 0, 0);

        -- increase respawn time for injured stockade guard
        UPDATE `spawns_creatures` SET `spawntimesecsmin`=540, `spawntimesecsmax`=540 WHERE `spawn_entry1`=4996;

        UPDATE `spawns_creatures` SET `movement_type`= 2 WHERE `spawn_entry1`= 5042;

        -- https://github.com/vmangos/core/commit/4b80e69c30702cea93ee7a55aeaa5608af27612a
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (26, 'Hello William,\r\n\r\nIt\'s been years since we\'ve spoken, but I trust you and your brother are well, and that your apothecary thrives.\r\n\r\nI must ask a favor of you, William.  In short, my grandson Tommy Joe has lost his heart to young Maybell Maclure.  And although they adore each other... our families, well our families have been feuding for years.', 218);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (28, 'Argus, \r\n\r\nAs you know, I\'m up to my neck in repair requests from the Army.  I can\'t complain about all the work, but it\'s depleting my supply of iron.\r\n\r\nI don\'t have enough iron for horseshoes.  I know you always keep a large stock--I\'d like to borrow 50 pairs of shoes until I get my next shipment of iron.\r\n\r\nYou have my gratitude,\r\n-Verner', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (29, 'A note is attached to the crate.  It reads:\r\n\r\n"Verner - sorry to hear Redridge is having such trouble.  Here are the shoes you need.  Please pay me 100 silver at your earliest convenience."\r\n\r\n"Or if you like, you can pay me in underbelly scales from black dragon whelps (I hear Dragon Whelps are common in the Redridge Mountains).  Because we\'re friends... 4 scales will be enough.  Thanks --Argus"', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (58, 'A Moon over the Vale shines\r\nCasting its glow upon the jungle\r\nWhere proud Warriors heed the call\r\nTo defend our Nation and sacred grounds. \r\n\r\nA Moon over the Vale shines\r\nFar above the cries of battle\r\nWhere blood is spilled\r\nOf foe and comrade alike.', 59);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (59, 'And when our brethren pass\r\nInto realms beyond the known\r\nThe soul-spirit hardens\r\nDeep beneath the Vale.\r\n\r\nAnd when our brethren pass\r\nInto the Mountain\'s Temple\r\nWe shall protect their eternal spirit\r\nEncased within the holy blue crystal.\r\n\r\nAnd when our brethren pass\r\nA Moon over the Vale shines.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (62, 'By moon and fire,\r\nBy flesh and bone,\r\nScribed in blood,\r\nCarved in stone.\r\n\r\nLeave this place\r\nOr meet your doom\r\nDeath stands guard\r\nOver the Emperor\'s Tomb.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (64, 'Morgan Ladimore was a great and noble knight who fought in defense of the innocent, the poor, and the afflicted. For many years, he worked diligently throughout the outlying areas of Azeroth, bringing relief to the suffering and swift justice to evildoers.\r\n\r\nHe was married to a young girl named Lys in the summer of his eighteenth year. They were much in love with each other and would eventually produce three children, a son and two daughters.\r\n\r\nMorgan was thirty-two when war broke out in', 65);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (65, 'Lordaeron. Morgan was called to the side of the legendary paladin Uther the Lightbringer to fight against the orcs and the undead. Leaving his wife and children in the safety of his home, Morgan left for war.\r\n\r\nThe years passed and the war dragged on, and Morgan would witness many horrific events, including the disbanding of the Paladins of the Silver Hand, the death of Uther and the spread of the plague. The only thing that kept him from the brink of madness was the knowledge that he would', 66);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (66, 'someday be reunited with his wife and children.\r\n\r\nMorgan would eventually return to his homeland, but find it nothing like how he remembered it. The once verdant forest was corrupted and teemed with the undead and other dark forces. Destroyed houses and farms could be found everywhere, and the cemetary near Raven\'s Hill now dominated much of the area. A shocked and bewildered Morgan eventually made his way to his home, only to find it in ruins. Not knowing what had befallen his homeland, he', 67);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (67, 'headed towards the village to find answers, and, he hoped, his wife and children.\r\n\r\nMorgan inquired about his family, but could not find any answers. A priest in Darkshire, as it was now called, said that he might search the cemetary at Raven Hill for a gravestone. Morgan refused to believe that his family was dead, and continued to search every farm and house in Duskwood, but to no avail.\r\n\r\nMorgan rode from Darkshire to nearby Lakeshire, thinking that perhaps his family had fled. On his way', 68);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (68, 'there, he decided, against his better judgement, to stop by the Raven Hill cemetary. Morgan spent hours walking amongst the gravestones. He recognized many names of people that he knew and became more and more distraught. Then he saw them: a small, untended plot amongst the many with three small gravestones. A feeling of dread washed over him as he approached. Morgan brushed off the dust of the most prominent gravestone to reveal the name on it. Simply carved upon the grave, letters spelled out', 69);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (69, 'his worst fear:\r\n\r\nLys Ladimore\r\nBeloved Wife and Mother\r\n\r\nMorgan\'s apprehension turned to dismay and then to grief, and he fell to his knees weeping. For hours he stared at that one grave, begging the cold stone for forgiveness and sobbing apologies. Then, hours later, something in him snapped, and he began to lash out. He brought his sword out of its scabbard and began to rain blows on the gravestones, screaming in rage. Blind in his fury, he lashed out and swung wildly, catching the notice', 70);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (70, 'of a trio of the cemetary\'s attendants. As they tried to restrain him, he turned his focus to them, hurling accusations of guilt upon the innocent attendants, then killed them all.\r\n\r\nLater, when the rage had passed, realization crept into Morgan\'s mind, and he saw his bloody sword driven into the chests of one of the attendants. Driven to the brink by his emotions, he removed his belt knife and plunged it into his heart.\r\n\r\nMorgan Ladimore\'s body and the three bodies of his victims were found', 71);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (71, 'the next day. He was quickly buried, without ceremony, in a hastily dug grave on the outskirts of the cemetary. Because Morgan committed murder against innocents, something that went completely against his beliefs and his nature, and because of the grief that he held in being unable to save his family, Morgan could not die a peaceful death, and lived on as one of the restless dead.\r\n\r\nOnly days later, his grave was disturbed, and his body could not be found. The being that was Morgan now', 72);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (72, 'wanders Duskwood, consumed by his grief over the loss of his wife and children and his own self-hatred. Mor\'Ladim, as he now calls himself, roams Duskwood with mindless vengeance and hatred, and has been known to commit murder indiscriminately.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (95, 'The Green Hills of Stranglethorn\r\n\r\nOur first day went as well as one can expect first days to go.  Most of our time was preoccupied with making the necessary arrangements to establish a base camp.  I located an ideal setting by a freshwater river inlet.  Judging by the old, abandoned docks nearby, this site was inhabited sometime ago.  As for the original inhabitants, only time can tell that tale.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (102, 'During one such misstep, Erlgadin laid a heavy hand on Barnil\'s shoulder.  Ajeck and I gave a casual glance, assuming the man was simply giving Barnil a much-needed scolding for his carelessness.  Erlgadin, however, gestured slowly with his head toward a nearby fallen tree.  Gazing back at us were two piercing black eyes just above a mouthful of razor sharp fangs.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (104, 'The kill brought about a festive mood amongst the expedition.  Barnil poured mead for all to enjoy.  But our festivities were short-lived.  As we were preparing the corpse for transport back to base camp we were all caught off guard by a horrendous growl.  In all my years I have never heard anything so blood curdling.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (105, 'On a rocky precipice above, silhouetted by the setting sun, I could make out the largest cat of prey I have ever laid eyes upon.  I was able to loose one clumsy volley with my rifle, but the cat held his ground.  He growled once again, this time louder than the first, and vanished.\r\n\r\nWe gathered our belongings and headed solemnly back to camp.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (110, 'Both Ajeck and Sir Erlgadin stood poised, guns leveled at the bristling overgrowth at the base of the swaying trees.  The midday sun beat heavily upon us.  A slow trickle of perspiration trailed down from Erlgadin\'s temple as he pulled the pin back.  Upon the sound of the click, the thick flora parted and a large black panther -- a beautiful specimen -- darted out onto the plain.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (119, 'I led the party toward the sea, hoping the shoreline would provide refuge from the Raptors.  In our haste we had drifted too far north, to a precariously high elevation.  The mistake was made.  The fault was mine.  We stopped just short of a sheer cliff, the Raptors just a few paces behind.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (120, 'I stepped slowly forward, gun raised.  I had led these brave hunters to their death.  I would die defending them.  Lashtail Raptors are particularly fierce, known for their unrelenting blood-thirst.  They far outnumbered us.  But I would be damned if I let them kill me and my comrades without shedding some of their own blood first.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (121, 'Ajeck and Sir Erlgadin readied their weapons, flanking me on either side, our backs to the sea.  Barnil let out a defeated sigh and drew his axe.  The Lashtails were almost upon us.  Their steady stride had slowed.  They were stalking their prey now for they knew they had us trapped.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (218, 'I fear the war between the Stonefields and the Maclures will kill Tommy Joe and Maybell\'s blossoming romance, and in times like these - where dark news and rumors of war loom over us - youth and love must be nurtured.\r\n\r\nSo, the favor: I ask that you use your skills and concoct a potion or elixir to aid these young lovers in their quest for each other.\r\n\r\nThank you, William.  And please, when you have some time away from work, come visit.  We\'ll have a few chuckles over the past.\r\n\r\n-Mildred', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (223, 'Disperse information as you deem necessary.\r\n\r\nTirisfal Regional Command\r\nCaptain Melrose\r\nCaptain Vachon\r\nCaptain Perrine\r\n\r\nDirectives by the order of the Highlord.\r\n\r\nCaptain Perrine, further fortify your position at the southwest tower (as designated). Additional supplies will be dispatched at a later date. In the meantime, materiel should be obtainable from the surrounding farms. Also, further reconnaissance and information', 224);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (224, 'should be gathered about the organization of the undead in Brill.\r\n\r\nCaptain Vachon, there appears to be increased movement by the undead near the northern tower. This insurgence must be quickly and decisively dealt with.\r\n\r\nCaptain Melrose, there are concerns about the level of organization of the undead near the borders of the Plaguelands. A fresh group of men will be dispatched to your position in the coming weeks.\r\n\r\nGlory under the Light', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (235, 'Greetings Ello Ebonlocke, Mayor of Darkshire.  I\'m afraid I have news for your town.  Grave news.\r\n\r\nYou see, I am a creator.  I fooled the bearer of this note into aiding me in my latest, most dire creation - a fiend of flesh and bone and twisted metal!  As you read this, it\'s likely outside my humble dwelling, gnashing its teeth and waiting for my word to go forth and slaughter.\r\n\r\nBut you\'ll know soon enough.\r\n\r\n-The Embalmer', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (245, 'Missing: Corporal Keeshan\r\n\r\nLast seen during the bloody battle at Stonewatch Keep, Corporal Keeshan was reported to have been dragged away by Blackrock Orcs.\r\n\r\nIt is believed that Corporal Keeshan is being held as a prisoner of war at the Blackrock encampment north of Lakeshire, just west of the pass leading to the Burning Steppes.\r\n\r\nBy mandate of Magistrate Solomon, anyone who aids in the recovery of Corporal Keeshan shall be rewarded by Marshal Marris.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (285, 'Tale of Gri\'lek the Wanderer\r\n\r\n[...The beginnings of the tablet were worn and erased.  But the end was legible...]\r\n\r\nGri\'lek stamped through the jungle.  And his eyes burned and his chest rumbled, for there was great anger in him.  \r\n\r\nIn fury he roared to the sky, and he raised his arm.  He raised his left arm, grown strong and sure from hunting without its twin.  \r\n\r\nFor Gri\'lek\'s right arm was gone, and it would not return.', 387);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (288, 'Ranger Captain Alleria Windrunner\r\n\r\nRenowned Troll Hunter of Quel\'Thalas. Lead Scout and Intelligence Agent for the Alliance Expedition that marched into the orc homeworld of Draenor. Presumed deceased.\r\n\r\nYour heart flew straight as any arrow upon the wind, sister. You were the brightest of our Order. You were the most beloved of our kin. \r\n\r\n- Sylvanas Windrunner - Ranger General of Quel\'Thalas', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (324, 'Rising from the ocean, a tower of water, Neptulon sent the great Krakken to doomed I\'lalai.  So huge were their forms that jungles of kelp swayed through their limbs, and leviathans swam through bodies.  \r\n\r\nThe largest Krakken then raised his arms high and crashed them into the sea, sending waves about him.  And they raged toward I\'lalai.', 325);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (325, 'The Krakken roared, and their voices thundered like an ocean storm: \r\n\r\n"We come."\r\n\r\nMin\'loth, standing firm, called forth his magic.  The waves sent to I\'lalia parted and washed to both sides, and they flooded the jungle beyond.  Min\'loth then bade his minions chant spells of binding, and a din rang out as dozens of troll voices rose.\r\n\r\nAnd one voice rose above the rest.', 326);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (326, 'Min\'loth bellowed and his magic gathered the power of his minion\'s spells, and he cast it at the approaching Krakken.\r\n\r\nThe seas parted and Min\'loth\'s spell sped toward the servants of Neptulon.  Lightning tore the sky and the spell struck them, and a thousand bolts fell, boiling water and burning craters in the earth.\r\n\r\nMin\'loth cried in triumph, knowing his spell would fell the great beasts.', 327);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (327, 'But the Krakken are old, very old.  They remembered when the land was first born from the sea.\r\n\r\nThey remembered when the Old Ones ruled and when the Travelers came and cast them down.  They remembered when magic was new.\r\n\r\nThey are old and they hold many secrets.  And though Min\'loth\'s spell was strong, it, like the troll, was mortal.  \r\n\r\nAnd so it failed.', 328);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (328, 'If failed to bind the Krakken, but it enraged them.  Not in aeons had a mortal caused them pain, and the troll\'s spell was painful.\r\n\r\nAnd so they shed the bindings of Minloth\'s spell, but then roared and stuck with fury.\r\n\r\nA rumble was heard as great waves rose from the deep and raced toward the land.  When they reached I\'lalai they cast a shadow on the city.\r\n\r\nBut before they destroyed it the Krakken halted, poised.', 329);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (329, 'The troll witchdoctors trembled and cried out to their master.  Min\'loth gazed at the mountains of the sea, doomed and defiant.  He turned to his adepts and whispered, and the trolls etched his last words into stone.  Min\'loth then faced the looming Krakken.\r\n\r\nHe grimaced and hurled his staff, his last bold act.\r\n\r\nThe Krakken then bent their fury upon Min\'loth, and an ocean fell upon I\'lalai.\r\n\r\nAnd it was no more.', 330);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (330, 'And then the waters fell upon the jungle, washing clean all they met.  Trolls and beasts cried out as the waters smashed and drowned them.\r\n\r\nMany Gurubashi wondered why the ocean swallowed them, but then they died and knew nothing.\r\n\r\nAnd finally, when the waters reached the mountains, they stopped.  Appeased, they retreated back beyond the shores, and they left a wake of death.\r\n\r\nThey retreated, but they surged around I\'lalai and remained, drowning it forever.', 331);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (331, 'And the chief Var\'gazul, safe behind the mountains in Zul\'Gurub, went out to the jungle and found it washed clean of his people.\r\n\r\nAnd he despaired, for his dreams of conquest were thwarted.\r\n\r\nAnd never was Min\'loth the Serpent found.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (372, 'The Star of Xil\'yeh\r\n\r\nGrel\'borg the Miser has the Star.  He is a greedy ogre who spends his days in the Alterac Mountains, in the Ruins of Alterac, searching for baubles.  Most of his collection is useless, but one item, the Star of Xil\'yeh, has valuable properties.', 373);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (373, 'The Hand of Dagun\r\n  \r\nAncient texts claim that claws of Dagun excrete a poison that does not kill his prey, but mutates it into something else -- a member of the old races.  Its value to us is unquestioned.\r\n\r\nDagun lives in the deep sea, but is regularly enticed to the surface by a tribe of Mirefin Murlocs in Dustwallow Marsh.  Their oracles summon him with an enchanted sea kelp.  If you kill enough oracles you\'ll find the kelp.  Then place it on the Murloc altar, and Dagun will come.', 374);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (374, 'The Legacy Heart\r\n\r\nMogh the Undying is a troll witchdoctor in Stranglethorn.  And he posseses the Legacy Heart, said to stave off death to those who can unlock its secrets.  You will find Mogh in the Ruins of Zul\'Mamwe.  Defeat him, if you can, and bring me the Legacy Heart.', 375);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (375, 'Bring me these three items, the Star, and Hand and the Heart, and Yagyin\'s Digest will be yours.\r\n\r\n-G.B.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (387, 'And so he wandered, and he searched.  And his arm remained lost to him.  And so he cursed and roared as he walked.  \r\n\r\nBut Gri\'lek had long ago turned his ear away from the spirits, and they were angered and would not listen to his curses.\r\n\r\nDoomed was Gri\'lek.  Doomed to wander, armless.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (442, 'To face Frostmaw, you must entice him with the meat of his favorite prey.\r\n\r\nGo to the Alterac Mountains in Azeroth and hunt a hulking mountain lion.  Kill it, and then take its carcass to the Growless Cave, a place held sacred by the bestial wendigo.\r\n\r\nPlace the carcass on the Flame of Uzel and the scent from burning meat will drift from the cave.\r\n\r\nAnd then, in time, Frostmaw will come.\r\n', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (992, 'The bearer of this certificate is entitled to the respect and regard that any first rate pilferer and thief deserves.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1011, 'I have found a method to enter the Chamber of Khaz\'mul!\r\n\r\nTake the Medallion of Gni\'kiv from my chest.\r\n\r\nDefeat the trogg Revelosh in the chamber before the map room and retrieve the Shaft of Tsol.\r\n\r\nJoin the medallion and the shaft into the Staff of Prehistoria.\r\n\r\nUse the staff in the map room to unlock the door to the Chamber of Khaz\'mul.\r\n\r\nDo these things, and the chamber will be yours!\r\n-Baelog', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1031, '<HTML>\r\n<BODY>\r\n<BR/>\r\n<BR/>\r\n<P>\r\nIn memory of my dear mentor, Horatio M. Montgomery, M.D. Healer, Teacher, Friend.\r\n</P>\r\n<BR/>\r\n<H1 align="center">\r\n50 BTFT - 25 ATFT\r\n</H1>\r\n<BR/>\r\n<P>\r\n"The world is full of the sick and weary. It is our job, as healers, NAY, as men and women of medicine, to cleanse them ALL of the \'itis.\'" \r\n</P>\r\n<BR/>\r\n<P>\r\n- H.M.M., M.D., PhD, JD, Grandmaster Farmer, Dancer Extraordinaire, Friend to the Animals\r\n</P>\r\n<BR/>\r\n</BODY>\r\n</HTML>', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1051, 'The guards of this tower seem to be especially weak to my attacks. As I was scouting the backside of the tower, a patroller spotted me and attacked. I was able to easily dispatch the guard with a timely gouge followed by a backstab. \r\n\r\nI waited in hiding for her partner to come investigate the commotion. The patroller came towards the bushes where I had dragged the corpse and began a search. Slowly, carefully, I crept up behind him, not wanting my ambush to be discovered. ', 1052);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1052, 'When the opportunity was made available, I thrust my dagger into his backside! His lungs quickly gave way under the force of the attack as his corpse hit the ground with a dull thud.\r\n\r\nIt had been such a fast and violent ambush that the poor fool did not even have the time to scream in pain. Curiously, when I removed the blade from his backside, a foul odor leaked out of the perforated patroller.\r\n\r\n', 1053);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1053, 'It would appear that whatever it is that Klaven has locked away in the chest is having adverse effects upon the inhabitants of the tower. I suspect that the other guards may have similar weaknesses and perhaps, even Klaven himself has fallen victim to the fallout. \r\n\r\nAgent Amber Kearnen\r\nSI:7 Ground Level Operative, R8', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1091, 'The Mallet of Zul\'Farrak\r\n\r\nTo create the Mallet of Zul\'Farrak, one must first travel to the Altar of Zul and obtain the sacred mallet from a troll Keeper.\r\n\r\nNext, one must bring the sacred mallet to the altar atop of the troll city of Jintha\'alor.\r\n\r\nUsing the sacred mallet at the altar will infuse it with power, and transform it into the Mallet of Zul\'Farrak.\r\n', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1131, 'SUPER CRITICAL TRIPLE-ENCODED DATA CARD\r\n\r\n01010100 01101000 01110010 01100001 01101100 01101100 00100000 01100001 01101110 01100100 00100000 01001010 01100001 01101001 01101110 01100001 00100000 01110011 01101001 01110100 01110100 01101001 01101110 01100111 00100000 01101001 01101110 00100000 01100001 00100000 01110100 01110010 01100101 01100101 00101100 00100000 01001011 00101101 01001001 00101101 01010011 00101101 01010011 00101101 01001001 00101101 01001110 00101101 01000111', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1156, 'Curgle, \r\n\r\nI have been eagerly awaiting your newest invention. I can\'t wait to begin using it to document my studies.\r\n\r\nPlease entrust it to my messenger.\r\n\r\n\r\nWith kindest regards,\r\n\r\nDaryn Lightwind', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1313, 'What was I thinking? \r\n\r\nPerhaps a better question would be: What am I doing writing a note while I\'m sitting captive inside the stomach of a giant?\r\n\r\nBoth good questions that I have no immediate answer for...\r\n\r\nAdmittedly, mine was not a mission of good will. I came in search of Azsharite, a unique crystal to southern Azshara. Oh the riches I would have had!\r\n\r\nBah! Now look at me...', 1314);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1314, 'Should any manner of intelligent life find this note, they must ask themselves something: "Why in the hell are they romping around with violent thirty foot tall giants?"\r\n\r\n- Mook', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1371, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\Linken_sepia_256px"/>\r\n</BODY>\r\n</HTML>', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1432, 'Bethek Stormbrow\r\n\r\nBethek\'s wanderings take him deep within Blackrock.  The secrets of the mountain beckon him.\r\n\r\nMay his spirit never falter.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1434, 'Zimrel Darktooth\r\n\r\nWhen the madness of the dark key takes hold of Zimrel, only the screams of the dying can soothe him.\r\n\r\nFor his sacrifice, he will always have a bench above the arena.  May our blood sports temper the rage in his heart.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1436, 'Pelver Deepstomp\r\n\r\nDark Keeper Pelver is our most honored disciple.  He has borne the key for longer than any, and it has cost him dearly.  When he is called for his burden, he is guarded in the Domicile.\r\n\r\nHis sacrifice is cherished, and he will remain in our hearts for many years... after the darkness takes him.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1471, 'Solomon,$B$BThe carrier of this decree has been granted official status as an acting deputy of Stormwind. You may use $g him:her; to find proof of the black dragonflight\'s involvement with the Blackrock orcs. Should such proof be found, this deputy shall return said proof to me in Stormwind, at which time I shall release the order to dispense sufficient military force to aid Lakeshire.$B$BRegards,$B$B$B$BHighlord Bolvar Fordragon\r\n', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1611, '<The pages are covered in ancient elven runes.>\r\n\r\nThe pages herein contain memories of events that transpired in the collection and creation of the reagents required to craft lesser arcanum.\r\n\r\nMay our enemies never gain access to these libram. \r\n\r\nMay I live to see the pallid light of the moon shine upon Quel\'Thalas once again.\r\n\r\nMay I die but for the grace of Kael\'thas.\r\n\r\nMay I kill for the glory of Illidan.\r\n\r\n-Master Kariel Winthalus', 1642);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1631, '<The pages are covered in ancient elven runes.>\r\n\r\nThe pages herein contain memories of events that transpired in the collection and creation of the reagents required to craft lesser arcanum.\r\n\r\nMay our enemies never gain access to these libram. \r\n\r\nMay I live to see the pallid light of the moon shine upon Quel\'Thalas once again.\r\n\r\nMay I die but for the grace of Kael\'thas.\r\n\r\nMay I kill for the glory of Illidan.\r\n\r\n-Master Kariel Winthalus', 1635);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1632, '<The pages are covered in ancient elven runes.>\r\n\r\nThe pages herein contain memories of events that transpired in the collection and creation of the reagents required to craft lesser arcanum.\r\n\r\nMay our enemies never gain access to these libram. \r\n\r\nMay I live to see the pallid light of the moon shine upon Quel\'Thalas once again.\r\n\r\nMay I die but for the grace of Kael\'thas.\r\n\r\nMay I kill for the glory of Illidan.\r\n\r\n-Master Kariel Winthalus', 1639);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1635, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_blackrock_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1636);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1636, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_blasted_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1637);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1637, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_ungoro_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1638);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1638, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_nightdragon_256"/>\r\n</BODY>\r\n</HTML>\r\n\r\n', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1639, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_blackrock_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1640);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1640, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_bldbank_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1641);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1641, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_ungoro_256"/>\r\n</BODY>\r\n</HTML>\r\n', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1642, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_blackrock_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1643);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1643, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_blasted_256"/>\r\n</BODY>\r\n</HTML>\r\n', 1644);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1644, '<HTML>\r\n<BODY>\r\n<IMG src="Interface\\Pictures\\11733_ungoro_256"/>\r\n</BODY>\r\n</HTML>\r\n', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1844, 'As the centuries passed, the night elves\' new society grew strong and expanded throughout the budding forest that they came to call Ashenvale. Many of the creatures and species that were abundant before the Great Sundering, such as furbolgs and quilboars, reappeared and flourished in the land. Under the druids\' benevolent leadership, the night elves enjoyed an era of unprecedented peace and tranquility under the stars.', 1845);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1845, 'However, many of the original Highborne survivors grew restless. Like Illidan before them, they fell victim to the withdrawal that came from the loss of their coveted magics. They were tempted to tap the energies of the Well of Eternity and exult in their magical practices. Dath\'Remar, the brash, outspoken leader of the Highborne, began to mock the druids publicly, calling them cowards for refusing to wield the magic that he said was theirs by right. ', 1846);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1846, 'Malfurion and the druids dismissed Dath\'Remar\'s arguments and warned the Highborne that any use of magic would be punishable by death. In an insolent and ill-fated attempt to convince the druids to rescind their law, Dath\'Remar and his followers unleashed a terrible magical storm upon Ashenvale.', 1847);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1847, 'The druids could not bring themselves to put so many of their kin to death, so they decided to exile the reckless Highborne from their lands. Dath\'Remar and his followers, glad to be rid of their conservative cousins at last, boarded a number of specially crafted ships and set sail upon the seas. Though none of them knew what awaited them beyond the waters of the raging Maelstrom, they were eager to establish their own homeland, where they could practice their coveted magics with impunity. ', 1848);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (1848, 'The Highborne, or Quel\'dorei, as Azshara had named them in ages past, would eventually set shore upon the eastern land men would call Lordaeron. They planned to build their own magical kingdom, Quel\'Thalas, and reject the night elves\' precepts of moon worship and nocturnal activity. Forever after, they would embrace the sun and be known only as the high elves. ', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2012, 'Kil\'jaeden cast Ner\'zhul\'s icy cask back into the world of Azeroth. The hardened crystal streaked across the night sky and smashed into the desolate arctic continent of Northrend, burying itself deep within the Icecrown glacier. The frozen crystal, warped and scarred by its violent descent, came to resemble a throne, and Ner\'zhul\'s vengeful spirit soon stirred within it.', 2013);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2013, 'From the confines of the Frozen Throne, Ner\'zhul began to reach out his vast consciousness and touch the minds of Northrend\'s native inhabitants. With little effort, he enslaved the minds of many indigenous creatures, including ice trolls and fierce wendigo, and he drew their evil brethren into his growing shadow. His psychic powers proved to be almost limitless, and he used them to create a small army that he housed within Icecrown\'s twisting labyrinths. ', 2014);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2014, 'As the Lich King mastered his growing abilities under the dreadlords\' persistent vigil, he discovered a remote human settlement on the fringe of the vast Dragonblight. On a whim, Ner\'zhul decided to test his powers on the unsuspecting humans. ', 2015);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2015, 'Ner\'zhul cast a plague of undeath - which had originated from deep within the Frozen Throne, out into the arctic wasteland. Controlling the plague with his will alone, he drove it straight into the human village. Within three days, everyone in the settlement was dead, but shortly thereafter, the dead villagers began to rise as zombified corpses. Ner\'zhul could feel their individual spirits and thoughts as if they were his own. ', 2016);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2016, 'The raging cacophony in his mind caused Ner\'zhul to grow even more powerful, as if their spirits provided him with much-needed nourishment. He found it was child\'s play to control the zombies\' actions and steer them to whatever end he wished.', 2017);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2017, 'Over the following months, Ner\'zhul continued to experiment with his plague of undeath by subjugating every human inhabitant of Northrend. With his army of undead growing daily, he knew that the time for his true test was nearing.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2097, 'Ner\'zhul, the Lich King, knew that his time was short. Imprisoned within the Frozen Throne, he suspected that Kil\'jaeden would send his agents to destroy him. The damage caused by Illidan\'s spell had ruptured the Frozen Throne; thus, the Lich King was losing his power daily. Desperate to save himself, he called his greatest mortal servant to his side: the death knight Prince Arthas.', 2098);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2098, 'Though his powers were drained by the Lich King\'s weakness, Arthas had been involved in a civil war in Lordaeron. Half of the standing undead forces, led by the banshee Sylvanas Windrunner, staged a coup for control over the undead empire. Arthas, called by the Lich King, was forced to leave the Scourge in the hands of his lieutenant, Kel\'Thuzad, as the war escalated throughout the Plaguelands.', 2099);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2099, 'Ultimately, Sylvanas and her rebel undead (known as the Forsaken) claimed the ruined capital city of Lordaeron as their own. Constructing their own bastion beneath the wrecked city, the Forsaken vowed to defeat the Scourge and drive Kel\'Thuzad and his minions from the land.', 2100);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2100, 'Weakened, but determined to save his master, Arthas reached Northrend only to find Illidan\'s naga and blood elves waiting for him. He and his nerubian allies raced against Illidan\'s forces to reach the Icecrown Glacier and defend the Frozen Throne.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2176, 'Orman of Stromgarde\r\nThe first Captain General of the Scarlet Crusade \r\nCitizen of Stromgarde\r\nLost at the mouth of Icecrown Glacier', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2212, 'Oh, I am cursed!  Once a great ogre mage of the Spirestone clan, I challenged Urok Doomhowl and he stole my magic and cursed me.  Now, I must walk the halls of Hordemar as this wretched creature!$B$BAid me!  Face Urok and steal back my magic!  It will not be easy, for Urok stays in the shadows and can only be summoned through a great challenge.$B$BThat challenge will be the death of his most trusted aid, Highlord Omokk.$B$BRead on, and you will see.', 2213);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2213, 'Highlord Omokk rules the Spirestones, but he does so through Urok\'s magic.  Urok charmed Omokk with a spell that can strike dead any ogre who challenges him.  He has used that spell many times, and keeps the skulls of his victims in a pile, in a place of power above Omokk\'s chamber.$B$BThat is where you must go to face Urok.', 2214);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2214, 'Find a roughshod pike among the Scarshield camps.  They often stack them by their bed mats near the entrance to the Spirestone ogre\'s domain.$B$BWhen you have the pike, charge your way  to Highlord Omokk.  Kill him, and place his head on the pike.$B$BThen you will be ready for your real challenge.', 2215);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2215, 'Go to the place of power above the Spirestone domain, beyond the Skitterweb Tunnels.  At that place are piled the skulls of Urok\'s enemies and rivals.  It is here where you must drive the pike with Omokk\'s head!$B$BWhen the head is in place, Urok is sure to come... but first he will send his minions against you.  Defeat them, and in time Urok himself will be summoned.$B$BKill Urok and retrieve my magic.  With my powers returned, I will reward you.', 2216);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2216, 'Luck to you.  And here is a clue that may help in your trials against Urok\'s minions:$B$BThe spell Omokk uses against the ogres, the one that strikes them dead, may still have power after you kill Omokk.  During your fight with Urok\'s minions, invoke the power in Omokk\'s head -- with luck, Omokk will strike down Urok\'s minions!$B$BFitting irony.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2461, 'Lok-tar, $gbrother:sister;. The elements beckon you closer and bid me to show you the path of the shaman. The spirits of our ancestors watch from beyond and swell with pride knowing you have joined our ranks.$B$BWhen you are ready, seek me out near the entrance to the Den. It is there that I will be training others of our kind. Until then, may the wind be at your back.$B$B-Shikrik, Shaman Trainer', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2591, 'Set far back in the Valley of Spears is the holy temple of Maraudon. If that were not transgression enough, you will quickly see why I have asked a non-centaur to aid me in my plight.$B$BThere, just beyond the doors where only spirits and our most sacred priests and priestesses may travel is one called The Nameless Prophet. He is the highest of any tribe in spiritual matters and is one of the oldest of any tribe.', 2592);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2592, 'The Prophet is powerful, and communicates with the spirits of our ancestors. But he is a fool! He has no idea the true power he possesses. On his person is the Amulet of Spirits--it is where most of his strength comes from.\r\n\r\nI have learned that the Amulet is powerful, but it is incomplete.', 2593);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2593, 'There are five gems missing from the amulet. And if those gems were found and placed back into the symbol, its power would far exceed that of its current form. I have found the five gems, but need one of your skill to help gather them. Slaying The Nameless Prophet is heresy for sure, as is stealing from his corpse, but what I would ask of you next would condemn any centaur for even thinking it.', 2595);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2595, 'Throughout the caverns of Maraudon roam the spirits of our first Khans. Our Mother and Father\'s first children, and our greatest leaders--they are Gelk, Kolk, Magra, Maraudos, and Veng. Each of these spirits holds one of the missing gems.', 2596);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2596, 'Use the power of the Amulet of Spirits to force them to manifest and take the gems from them! After, place the gems within the Amulet of Spirits and return it to me. Once I have the Amulet of Union, I will be powerful enough to reform the tribes so we can finally be as our ancestors wanted us to be!', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2691, 'To bind a dreadsteed, you must do these three things:\r\n\r\nCreate a Circle of Greater Summoning.\r\n\r\nWithin the Circle, open a portal to Xoroth and pull the dreadsteed through it.\r\n\r\nDefeat the dreadsteed, then dominate its spirit.\r\n\r\nThe following pages will detail how each of these steps may be performed.  It will not be easy, but you have proven to be very able.  With focus and skill, I am confident the dreadsteed will be yours.\r\n\r\nRead on,\r\n-Mor\'zul Bloodbringer', 2692);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2692, 'Implements of the Ritual\r\n\r\nBefore you begin your task, you must have the following magical implements:\r\n\r\nJ\'eevee\'s Jar\r\nA Black Lodestone\r\nXorothian Glyphs\r\n\r\nMy servant Gorzeeki will have them for you, for a price.  Do not attempt any step of your ritual without all of these implements.  Each is essential.\r\n\r\nWithin the next pages, I will describe how each implement must be used.', 2693);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2693, 'Circle of Greater Binding\r\n\r\nA Circle of Greater Binding must be created at a site where magic is strong.  There is such a place deep in the ruins of Eldre\'Thalas, also called Dire Maul.  In Eldre\'Thalas there is imprisoned a being of great power, Immol\'thar; it is on the pedestal of his prison where you must perform the ritual to create the Circle.\r\n\r\nFight your way to the Pedestal, then let J\'eevee out of his jar.', 2694);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2694, 'The Bell, the Wheel and the Candle\r\n\r\nAfter releasing J\'eevee he will then place the Bell, the Wheel and the Candle, and a circle will appear.  This is the start of the ritual.  You must be vigilant; the aforementioned objects conduct vast energies and are prone to failing.  When this happens you must quickly use your Black Lodestone to restart them before your entire ritual fails.\r\n\r\nIf all three objects have failed before you can restart them, then your ritual ends and you must begin it anew.', 2695);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2695, 'In addition to conducting the energies of the ritual, the Bell, Wheel and Candle have unique properties of their own.\r\n\r\nThe Bell of Dethmoora, when ringing, bestows warlocks in the circle with vigor and energy.\r\n\r\nThe Wheel of the Black March, when spinning, protects those in the circle from harm.\r\n\r\nThe Doomsday Candle, when burning, sends eldritch energy at foes who enter the circle.\r\n\r\nBecause of these blessings, it is very important to keep all of these objects working during the ritual.', 2696);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2696, 'It must also be noted that the Black Lodestone, used to restart the Bell, Wheel or Candle if they fail, requires soul shards.  Each time you restart a ritual object with the Lodestone one of your soul shards will be consumed, so be sure to have a large stock of them before the ritual begins.', 2711);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2711, 'Completing the Ritual\r\n\r\nYou can track your progress by the magic runes along the border of the circle.  When nine runes appear then the ritual is complete, and you will see energy rise from the newly empowered Circle.\r\n\r\nFrom there, you may invoke the Xorothian Glyphs and open a portal into Xoroth and pull a dreadsteed through it.\r\n\r\nDefeat the dreadsteed and release his spirit.  Confront the spirit and it will be enthralled, and you will be rewarded with the secret of its summoning.', 0);
        REPLACE INTO `page_text` (`entry`, `text`, `next_page`) VALUES (2785, 'We call upon you, Zanza of Zuldazar.\r\n\r\nBless those that ask for your help, Loa Zanza. Bless those that would ally with the Zandalarian\r\npeople.\r\n\r\nAid us in this time of need. Aid us Loa. Give us the power to strike down our enemies. Give us the power to once more defeat the Blood God.\r\n', 0);

        -- Delete Gadgetzan Bruiser from Un'goro
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=24665;
        DELETE FROM `spawns_creatures` WHERE  `spawn_id`=24664;

        insert into applied_updates values ('150520201');
    end if;

    -- 17/05/2020 1
    if (select count(*) from applied_updates where id='170520201') = 0 then
        -- Correct position of some spawns_creatures spawns.
        UPDATE `spawns_creatures` SET `position_x`=-41.3658, `position_y`=-457.912, `position_z`=-18.5609, `orientation`=0 WHERE `spawn_id`=300463; -- Smolderthorn Witch Doctor
        UPDATE `spawns_creatures` SET `position_x`=-24.0486, `position_y`=-407.81, `position_z`=-18.8517, `orientation`=5.02655 WHERE `spawn_id`=44007; -- Firebrand Darkweaver
        UPDATE `spawns_creatures` SET `position_x`=-17.6312, `position_y`=-454.942, `position_z`=-18.5609, `orientation`=4.29351 WHERE `spawn_id`=45841; -- Mor Grayhoof Trigger
        UPDATE `spawns_creatures` SET `position_x`=-16.0525, `position_y`=-407.129, `position_z`=-18.8517, `orientation`=6.24828 WHERE `spawn_id`=43765; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=-100.963, `position_y`=-491.208, `position_z`=-18.3731, `orientation`=1.72788 WHERE `spawn_id`=44328; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=8.80271, `position_y`=-450.548, `position_z`=111.02, `orientation`=5.68977 WHERE `spawn_id`=42664; -- Rage Talon Captain
        UPDATE `spawns_creatures` SET `position_x`=-125.541, `position_y`=-472.941, `position_z`=24.3398, `orientation`=5.044 WHERE `spawn_id`=43550; -- Smolderthorn Shadow Priest
        UPDATE `spawns_creatures` SET `position_x`=866.556, `position_y`=-195.949, `position_z`=-43.6204, `orientation`=3.99988 WHERE `spawn_id`=90885; -- Grim Patron
        UPDATE `spawns_creatures` SET `position_x`=23.5463, `position_y`=-568.205, `position_z`=-18.5181, `orientation`=2.80998 WHERE `spawn_id`=300467; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=847.848, `position_y`=-230.067, `position_z`=-43.614, `orientation`=1.64061 WHERE `spawn_id`=46615; -- Phalanx
        UPDATE `spawns_creatures` SET `position_x`=19.0928, `position_y`=-581.621, `position_z`=-18.5181, `orientation`=0.541052 WHERE `spawn_id`=300469; -- Firebrand Darkweaver
        UPDATE `spawns_creatures` SET `position_x`=2270.7, `position_y`=279.998, `position_z`=36.7213, `orientation`=2.70526 WHERE `spawn_id`=29798; -- Deathguard Burgess
        UPDATE `spawns_creatures` SET `position_x`=2245.02, `position_y`=326.545, `position_z`=36.888, `orientation`=5.55015 WHERE `spawn_id`=31907; -- Blue Skeletal Horse
        UPDATE `spawns_creatures` SET `position_x`=2256.13, `position_y`=329.335, `position_z`=36.888, `orientation`=5.5676 WHERE `spawn_id`=31906; -- Brown Skeletal Horse
        UPDATE `spawns_creatures` SET `position_x`=2250.26, `position_y`=322.024, `position_z`=36.7816, `orientation`=5.63741 WHERE `spawn_id`=31909; -- Red Skeletal Horse
        UPDATE `spawns_creatures` SET `position_x`=2259.99, `position_y`=325.121, `position_z`=36.7954, `orientation`=5.2709 WHERE `spawn_id`=31920; -- Thomas Arlento
        UPDATE `spawns_creatures` SET `position_x`=2266.06, `position_y`=320.66, `position_z`=35.2273, `orientation`=5.48033 WHERE `spawn_id`=28478; -- Morganus
        UPDATE `spawns_creatures` SET `position_x`=-3720.35, `position_y`=-4551.57, `position_z`=25.917, `orientation`=1.27409 WHERE `spawn_id`=150017; -- Theramore Lieutenant
        UPDATE `spawns_creatures` SET `position_x`=-6672.25, `position_y`=-2240.52, `position_z`=278.577, `orientation`=4.66003 WHERE `spawn_id`=6874; -- Neeka Bloodscar
        UPDATE `spawns_creatures` SET `position_x`=-6656, `position_y`=-2236.71, `position_z`=256.213, `orientation`=6.12611 WHERE `spawn_id`=6899; -- Kargath Grunt
        UPDATE `spawns_creatures` SET `position_x`=1632.21, `position_y`=-4262.19, `position_z`=49.027, `orientation`=3.63029 WHERE `spawn_id`=300378; -- Sergeant Ba'sha
        UPDATE `spawns_creatures` SET `position_x`=-10653.3, `position_y`=1166.43, `position_z`=34.9278, `orientation`=5.77704 WHERE `spawn_id`=66978; -- Innkeeper Heather
        UPDATE `spawns_creatures` SET `position_x`=-10641.7, `position_y`=1093.46, `position_z`=34.043, `orientation`=4.74729 WHERE `spawn_id`=89535; -- Protector Leick
        UPDATE `spawns_creatures` SET `position_x`=1920.07, `position_y`=-4125.69, `position_z`=42.9976, `orientation`=4.79965 WHERE `spawn_id`=4770; -- Thrall
        UPDATE `spawns_creatures` SET `position_x`=1744.9, `position_y`=-4317.86, `position_z`=33.3935, `orientation`=4.2237 WHERE `spawn_id`=301556; -- Horthus
        UPDATE `spawns_creatures` SET `position_x`=-5070.18, `position_y`=480.105, `position_z`=401.726, `orientation`=0.854646 WHERE `spawn_id`=2422; -- Leper Gnome
        UPDATE `spawns_creatures` SET `position_x`=-5090.42, `position_y`=439.002, `position_z`=409.374, `orientation`=0.165834 WHERE `spawn_id`=2416; -- Leper Gnome
        UPDATE `spawns_creatures` SET `position_x`=-5078.93, `position_y`=489.413, `position_z`=401.821, `orientation`=4.61935 WHERE `spawn_id`=2424; -- Leper Gnome
        UPDATE `spawns_creatures` SET `position_x`=5717.89, `position_y`=-4794.96, `position_z`=778.147, `orientation`=1.36136 WHERE `spawn_id`=301303; -- Ranshalla
        UPDATE `spawns_creatures` SET `position_x`=-22.6518, `position_y`=-299.75, `position_z`=31.7016, `orientation`=4.66003 WHERE `spawn_id`=43518; -- Highlord Omokk
        UPDATE `spawns_creatures` SET `position_x`=-10857.2, `position_y`=-4096.36, `position_z`=21.9338, `orientation`=1.3439 WHERE `spawn_id`=32098; -- Stonard Shaman
        UPDATE `spawns_creatures` SET `position_x`=-6657.12, `position_y`=-1151.94, `position_z`=185.447, `orientation`=0.872665 WHERE `spawn_id`=5686; -- Slave Worker
        UPDATE `spawns_creatures` SET `position_x`=6718.92, `position_y`=-4612.77, `position_z`=721.258, `orientation`=1.50098 WHERE `spawn_id`=42295; -- Everlook Bruiser
        UPDATE `spawns_creatures` SET `position_x`=430.377, `position_y`=-574.341, `position_z`=171.188, `orientation`=4.09606 WHERE `spawn_id`=16775; -- Crushridge Brute
        UPDATE `spawns_creatures` SET `position_x`=94.6544, `position_y`=-275.047, `position_z`=60.7526, `orientation`=3.14159 WHERE `spawn_id`=300421; -- Scarshield Legionnaire
        UPDATE `spawns_creatures` SET `position_x`=144.438, `position_y`=-258.034, `position_z`=96.4066, `orientation`=4.67748 WHERE `spawn_id`=40453; -- Pyroguard Emberseer
        UPDATE `spawns_creatures` SET `position_x`=156.815, `position_y`=-283.34, `position_z`=71.0354, `orientation`=1.98968 WHERE `spawn_id`=40263; -- Blackhand Summoner
        UPDATE `spawns_creatures` SET `position_x`=-8655.16, `position_y`=-126.92, `position_z`=89.6724, `orientation`=2.81602 WHERE `spawn_id`=80071; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=1731.76, `position_y`=521.965, `position_z`=35.983, `orientation`=1.58825 WHERE `spawn_id`=160014; -- Darkcaller Yanka
        UPDATE `spawns_creatures` SET `position_x`=573.771, `position_y`=702.362, `position_z`=19.1922, `orientation`=5.11381 WHERE `spawn_id`=17653; -- Lake Frenzy
        UPDATE `spawns_creatures` SET `position_x`=1251.41, `position_y`=313.892, `position_z`=-63.6062, `orientation`=0.139626 WHERE `spawn_id`=32075; -- Horde Warbringer
        UPDATE `spawns_creatures` SET `position_x`=117.153, `position_y`=390.882, `position_z`=28.6844, `orientation`=3.92699 WHERE `spawn_id`=300112; -- Skeletal Highborne
        UPDATE `spawns_creatures` SET `position_x`=1805.01, `position_y`=-1180.72, `position_z`=59.6525, `orientation`=2.90438 WHERE `spawn_id`=47090; -- Skeletal Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=-4770.94, `position_y`=904.221, `position_z`=142.938, `orientation`=5.97428 WHERE `spawn_id`=50494; -- Woodpaw Mystic
        UPDATE `spawns_creatures` SET `position_x`=-4777.08, `position_y`=906.25, `position_z`=143.313, `orientation`=5.94406 WHERE `spawn_id`=50566; -- Woodpaw Alpha
        UPDATE `spawns_creatures` SET `position_x`=-4748.86, `position_y`=859.499, `position_z`=143.56, `orientation`=1.96772 WHERE `spawn_id`=50490; -- Woodpaw Mystic
        UPDATE `spawns_creatures` SET `position_x`=1820.34, `position_y`=1416.71, `position_z`=-7.91731, `orientation`=3.15905 WHERE `spawn_id`=39934; -- Bloodmage Thalnos
        UPDATE `spawns_creatures` SET `position_x`=1635.92, `position_y`=-4785.59, `position_z`=87.3384, `orientation`=0.645772 WHERE `spawn_id`=92335; -- Scarlet Warder
        UPDATE `spawns_creatures` SET `position_x`=-4529.83, `position_y`=326.051, `position_z`=34.6667, `orientation`=2.11185 WHERE `spawn_id`=51408; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=-4462.28, `position_y`=309.811, `position_z`=40.041, `orientation`=2.94961 WHERE `spawn_id`=51405; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=2288.81, `position_y`=-5319.24, `position_z`=89.053, `orientation`=2.19912 WHERE `spawn_id`=53944; -- Argent Guard
        UPDATE `spawns_creatures` SET `position_x`=-4405.64, `position_y`=210.834, `position_z`=25.6852, `orientation`=6.07375 WHERE `spawn_id`=51379; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=-4398.32, `position_y`=158.241, `position_z`=25.2933, `orientation`=6.24828 WHERE `spawn_id`=51380; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=-4374.97, `position_y`=116.699, `position_z`=32.9572, `orientation`=5.53269 WHERE `spawn_id`=51413; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=-10370.8, `position_y`=-3252.49, `position_z`=19.9496, `orientation`=0.680678 WHERE `spawn_id`=31853; -- Stonard Grunt
        UPDATE `spawns_creatures` SET `position_x`=-10453.3, `position_y`=-3216.05, `position_z`=20.6376, `orientation`=1.58825 WHERE `spawn_id`=31946; -- Stonard Grunt
        UPDATE `spawns_creatures` SET `position_x`=-10469.6, `position_y`=-3217.65, `position_z`=21.3671, `orientation`=1.25664 WHERE `spawn_id`=31945; -- Stonard Grunt
        UPDATE `spawns_creatures` SET `position_x`=-10377.6, `position_y`=-3241.58, `position_z`=20.1081, `orientation`=0.558505 WHERE `spawn_id`=31847; -- Stonard Grunt
        UPDATE `spawns_creatures` SET `position_x`=-1055.44, `position_y`=-215.423, `position_z`=159.062, `orientation`=5.41052 WHERE `spawn_id`=24728; -- Rahauro
        UPDATE `spawns_creatures` SET `position_x`=-4364.4, `position_y`=114.47, `position_z`=32.9969, `orientation`=3.40339 WHERE `spawn_id`=51406; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=164.335, `position_y`=522.497, `position_z`=-48.3836, `orientation`=3.07178 WHERE `spawn_id`=56948; -- Lorekeeper Lydros
        UPDATE `spawns_creatures` SET `position_x`=128.643, `position_y`=561.759, `position_z`=-4.31221, `orientation`=3.12414 WHERE `spawn_id`=56961; -- Tsu'zee
        UPDATE `spawns_creatures` SET `position_x`=99.0028, `position_y`=570.998, `position_z`=28.6964, `orientation`=5.2709 WHERE `spawn_id`=300132; -- Eldreth Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=105.119, `position_y`=570.376, `position_z`=28.6945, `orientation`=4.81711 WHERE `spawn_id`=300131; -- Skeletal Highborne
        UPDATE `spawns_creatures` SET `position_x`=-857.096, `position_y`=-570.751, `position_z`=11.2638, `orientation`=1.55334 WHERE `spawn_id`=15326; -- Innkeeper Anderson
        UPDATE `spawns_creatures` SET `position_x`=-852.952, `position_y`=-516.397, `position_z`=12.0977, `orientation`=4.67748 WHERE `spawn_id`=15328; -- Marshal Redpath
        UPDATE `spawns_creatures` SET `position_x`=-859.646, `position_y`=-544.452, `position_z`=10.1391, `orientation`=1.15192 WHERE `spawn_id`=15325; -- Phin Odelic
        UPDATE `spawns_creatures` SET `position_x`=-1381.98, `position_y`=-76.0139, `position_z`=160.602, `orientation`=3.10669 WHERE `spawn_id`=24794; -- Kergul Bloodaxe
        UPDATE `spawns_creatures` SET `position_x`=-3785.34, `position_y`=-4631.58, `position_z`=10.9288, `orientation`=5.2709 WHERE `spawn_id`=30523; -- Theramore Guard
        UPDATE `spawns_creatures` SET `position_x`=-3778.08, `position_y`=-4608.73, `position_z`=10.9345, `orientation`=3.31613 WHERE `spawn_id`=150016; -- Theramore Lieutenant
        UPDATE `spawns_creatures` SET `position_x`=-3895.72, `position_y`=-4495.72, `position_z`=13.1896, `orientation`=2.3911 WHERE `spawn_id`=150015; -- Theramore Lieutenant
        UPDATE `spawns_creatures` SET `position_x`=-3819.66, `position_y`=-4502.27, `position_z`=11.4898, `orientation`=6.26573 WHERE `spawn_id`=302704; -- Theramore Lieutenant
        UPDATE `spawns_creatures` SET `position_x`=2910.7, `position_y`=382.547, `position_z`=31.6674, `orientation`=3.31613 WHERE `spawn_id`=44786; -- Maggot Eye
        UPDATE `spawns_creatures` SET `position_x`=2903.08, `position_y`=379.265, `position_z`=30.5587, `orientation`=2.77507 WHERE `spawn_id`=44794; -- Rot Hide Mongrel
        UPDATE `spawns_creatures` SET `position_x`=-6197.86, `position_y`=-1082.17, `position_z`=-209.42, `orientation`=4.43314 WHERE `spawn_id`=24663; -- Quixxil
        UPDATE `spawns_creatures` SET `position_x`=-4524.3, `position_y`=-788.135, `position_z`=-41.6152, `orientation`=5.54757 WHERE `spawn_id`=51337; -- Falfindel Waywarder
        UPDATE `spawns_creatures` SET `position_x`=-7595.78, `position_y`=-1115.44, `position_z`=252.791, `orientation`=0.471239 WHERE `spawn_id`=5363; -- Franclorn Forgewright
        UPDATE `spawns_creatures` SET `position_x`=2035.12, `position_y`=1885.26, `position_z`=103.22, `orientation`=0.61397 WHERE `spawn_id`=44893; -- Night Web Spider
        UPDATE `spawns_creatures` SET `position_x`=-10547.5, `position_y`=-1212.67, `position_z`=26.9975, `orientation`=3.38594 WHERE `spawn_id`=4184; -- Watchmaster Sorigal
        UPDATE `spawns_creatures` SET `position_x`=-8601.24, `position_y`=-137.716, `position_z`=87.7294, `orientation`=2.95405 WHERE `spawn_id`=80078; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8588.91, `position_y`=-146.787, `position_z`=89.6068, `orientation`=1.47201 WHERE `spawn_id`=80079; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8595.57, `position_y`=-174.25, `position_z`=87.1351, `orientation`=3.5713 WHERE `spawn_id`=80076; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8581.85, `position_y`=-170.643, `position_z`=91.0671, `orientation`=5.31885 WHERE `spawn_id`=80081; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8572.39, `position_y`=-150.957, `position_z`=89.5713, `orientation`=2.73987 WHERE `spawn_id`=80082; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8565.25, `position_y`=-204.42, `position_z`=84.4446, `orientation`=2.29241 WHERE `spawn_id`=80088; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-4907.21, `position_y`=-1368.4, `position_z`=-52.529, `orientation`=5.41052 WHERE `spawn_id`=21584; -- Kanati Greycloud
        UPDATE `spawns_creatures` SET `position_x`=-3147.83, `position_y`=-2951.02, `position_z`=34.1154, `orientation`=4.93928 WHERE `spawn_id`=8471; -- Brackenwall Enforcer
        UPDATE `spawns_creatures` SET `position_x`=-3149.8, `position_y`=-2912.48, `position_z`=35.0493, `orientation`=0.820305 WHERE `spawn_id`=8475; -- Brackenwall Enforcer
        UPDATE `spawns_creatures` SET `position_x`=-8537.62, `position_y`=-182.695, `position_z`=84.0065, `orientation`=1.29357 WHERE `spawn_id`=80085; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8549.15, `position_y`=-205.715, `position_z`=85.2505, `orientation`=0.837106 WHERE `spawn_id`=80086; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-8561.45, `position_y`=-216.73, `position_z`=85.4262, `orientation`=1.64865 WHERE `spawn_id`=80087; -- Kobold Laborer
        UPDATE `spawns_creatures` SET `position_x`=-6816.91, `position_y`=718.773, `position_z`=40.4978, `orientation`=5.2709 WHERE `spawn_id`=42771; -- Cenarion Hold Infantry
        UPDATE `spawns_creatures` SET `position_x`=-6803.39, `position_y`=723.999, `position_z`=42.0662, `orientation`=4.90438 WHERE `spawn_id`=42770; -- Cenarion Hold Infantry
        UPDATE `spawns_creatures` SET `position_x`=-10253.8, `position_y`=-4004.95, `position_z`=-89.5871, `orientation`=4.62512 WHERE `spawn_id`=38705; -- Mummified Atal'ai
        UPDATE `spawns_creatures` SET `position_x`=-12501.7, `position_y`=-162.229, `position_z`=12.4564, `orientation`=4.55045 WHERE `spawn_id`=2179; -- Mosh'Ogg Brute
        UPDATE `spawns_creatures` SET `position_x`=-12489.4, `position_y`=-171.436, `position_z`=12.9415, `orientation`=0.663225 WHERE `spawn_id`=2166; -- Mosh'Ogg Witch Doctor
        UPDATE `spawns_creatures` SET `position_x`=987.48, `position_y`=1419.74, `position_z`=39.0897, `orientation`=0.767945 WHERE `spawn_id`=18475; -- Moonrage Glutton
        UPDATE `spawns_creatures` SET `position_x`=-12332.7, `position_y`=190.718, `position_z`=25.6743, `orientation`=0.0698132 WHERE `spawn_id`=659; -- Grom'gol Grunt
        UPDATE `spawns_creatures` SET `position_x`=-12395.1, `position_y`=131.913, `position_z`=3.74115, `orientation`=4.60767 WHERE `spawn_id`=362; -- Grom'gol Grunt
        UPDATE `spawns_creatures` SET `position_x`=-12389.2, `position_y`=131.967, `position_z`=3.70147, `orientation`=4.64258 WHERE `spawn_id`=603; -- Grom'gol Grunt
        UPDATE `spawns_creatures` SET `position_x`=594.716, `position_y`=1593.54, `position_z`=134.589, `orientation`=5.74213 WHERE `spawn_id`=17641; -- Silverpine Deathguard
        UPDATE `spawns_creatures` SET `position_x`=458.612, `position_y`=1556.36, `position_z`=129.477, `orientation`=4.38078 WHERE `spawn_id`=17869; -- Silverpine Deathguard
        UPDATE `spawns_creatures` SET `position_x`=105.175, `position_y`=-327.111, `position_z`=106.519, `orientation`=2.53073 WHERE `spawn_id`=40469; -- Rage Talon Dragonspawn
        UPDATE `spawns_creatures` SET `position_x`=154.429, `position_y`=-289.456, `position_z`=71.0298, `orientation`=6.17846 WHERE `spawn_id`=40265; -- Blackhand Dreadweaver
        UPDATE `spawns_creatures` SET `position_x`=15.7057, `position_y`=-319.695, `position_z`=48.9296, `orientation`=4.81711 WHERE `spawn_id`=300443; -- Scarshield Worg
        UPDATE `spawns_creatures` SET `position_x`=102.802, `position_y`=-332.121, `position_z`=106.519, `orientation`=2.21657 WHERE `spawn_id`=40459; -- Rage Talon Flamescale
        UPDATE `spawns_creatures` SET `position_x`=-860.528, `position_y`=-3556.43, `position_z`=72.5236, `orientation`=0.20944 WHERE `spawn_id`=11240; -- Hammerfall Guardian
        UPDATE `spawns_creatures` SET `position_x`=-2820.04, `position_y`=-2655.72, `position_z`=33.4073, `orientation`=5.7751 WHERE `spawn_id`=31376; -- Darkmist Silkspinner
        UPDATE `spawns_creatures` SET `position_x`=-87.1873, `position_y`=391.362, `position_z`=28.6844, `orientation`=4.93928 WHERE `spawn_id`=300125; -- Rotting Highborne
        UPDATE `spawns_creatures` SET `position_x`=-2823.14, `position_y`=-2627.11, `position_z`=36.1214, `orientation`=1.81113 WHERE `spawn_id`=31373; -- Darkmist Silkspinner
        UPDATE `spawns_creatures` SET `position_x`=-2813.48, `position_y`=-2651.82, `position_z`=33.5206, `orientation`=5.25035 WHERE `spawn_id`=31370; -- Darkmist Lurker
        UPDATE `spawns_creatures` SET `position_x`=75.6378, `position_y`=760.819, `position_z`=63.7726, `orientation`=4.34587 WHERE `spawn_id`=17749; -- Dalaran Wizard
        UPDATE `spawns_creatures` SET `position_x`=-8869.8, `position_y`=-372.731, `position_z`=71.795, `orientation`=1.36425 WHERE `spawn_id`=80253; -- Defias Thug
        UPDATE `spawns_creatures` SET `position_x`=-15.4464, `position_y`=-3596.94, `position_z`=29.3809, `orientation`=0.314611 WHERE `spawn_id`=13773; -- Peon
        UPDATE `spawns_creatures` SET `position_x`=-5180.45, `position_y`=-2531.37, `position_z`=-50.8602, `orientation`=0.789116 WHERE `spawn_id`=21746; -- Galak Scout
        UPDATE `spawns_creatures` SET `position_x`=2039.39, `position_y`=1849.1, `position_z`=103.807, `orientation`=4.29365 WHERE `spawn_id`=44891; -- Night Web Spider
        UPDATE `spawns_creatures` SET `position_x`=-13350, `position_y`=-29.166, `position_z`=22.3398, `orientation`=3.95073 WHERE `spawn_id`=2225; -- Maury "Club Foot" Wilkins
        UPDATE `spawns_creatures` SET `position_x`=-4052.45, `position_y`=-2982.59, `position_z`=11.941, `orientation`=0.593412 WHERE `spawn_id`=10482; -- Mosshide Gnoll
        UPDATE `spawns_creatures` SET `position_x`=-4138.79, `position_y`=-2946.87, `position_z`=11.8123, `orientation`=1.65806 WHERE `spawn_id`=10304; -- Mosshide Mongrel
        UPDATE `spawns_creatures` SET `position_x`=-13478.2, `position_y`=178.213, `position_z`=43.0187, `orientation`=3.12527 WHERE `spawn_id`=377; -- Bloodsail Elder Magus
        UPDATE `spawns_creatures` SET `position_x`=2342.92, `position_y`=1314.31, `position_z`=34.1193, `orientation`=3.19395 WHERE `spawn_id`=44569; -- Farmer Solliden
        UPDATE `spawns_creatures` SET `position_x`=-14258.7, `position_y`=327.03, `position_z`=26.3636, `orientation`=5.55015 WHERE `spawn_id`=2167; -- Booty Bay Bruiser
        UPDATE `spawns_creatures` SET `position_x`=121.719, `position_y`=-301.577, `position_z`=71.056, `orientation`=0.750492 WHERE `spawn_id`=40251; -- Blackhand Summoner
        UPDATE `spawns_creatures` SET `position_x`=157.88, `position_y`=-359.291, `position_z`=71.0256, `orientation`=1.53589 WHERE `spawn_id`=45834; -- Blackhand Veteran
        UPDATE `spawns_creatures` SET `position_x`=159.006, `position_y`=-347.022, `position_z`=71.0129, `orientation`=0.802851 WHERE `spawn_id`=40261; -- Blackhand Dreadweaver
        UPDATE `spawns_creatures` SET `position_x`=-14448.9, `position_y`=429.528, `position_z`=15.1049, `orientation`=3.735 WHERE `spawn_id`=717; -- Booty Bay Bruiser
        UPDATE `spawns_creatures` SET `position_x`=-9387.45, `position_y`=-117.388, `position_z`=58.8652, `orientation`=2.61799 WHERE `spawn_id`=30; -- Matt
        UPDATE `spawns_creatures` SET `position_x`=-24.9202, `position_y`=509.228, `position_z`=-3.48459, `orientation`=2.44346 WHERE `spawn_id`=300046; -- Eldreth Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=9977.6, `position_y`=2313.53, `position_z`=1330.87, `orientation`=0.698132 WHERE `spawn_id`=49936; -- Aethalas
        UPDATE `spawns_creatures` SET `position_x`=71.7459, `position_y`=-419.106, `position_z`=111.144, `orientation`=4.69494 WHERE `spawn_id`=42153; -- Blackhand Thug
        UPDATE `spawns_creatures` SET `position_x`=-6181.69, `position_y`=-1151.78, `position_z`=-210.605, `orientation`=0.314159 WHERE `spawn_id`=24379; -- Larion
        UPDATE `spawns_creatures` SET `position_x`=2488.19, `position_y`=19.0954, `position_z`=26.3224, `orientation`=1.48849 WHERE `spawn_id`=45115; -- Shambling Horror
        UPDATE `spawns_creatures` SET `position_x`=-10518.8, `position_y`=-1210.91, `position_z`=28.1176, `orientation`=5.38461 WHERE `spawn_id`=4083; -- Lohgan Eva
        UPDATE `spawns_creatures` SET `position_x`=-10532.4, `position_y`=-1213.12, `position_z`=28.1176, `orientation`=2.26332 WHERE `spawn_id`=4195; -- Madame Eva
        UPDATE `spawns_creatures` SET `position_x`=-10522, `position_y`=-1278.78, `position_z`=39.1095, `orientation`=2.67363 WHERE `spawn_id`=4181; -- Watcher Keller
        UPDATE `spawns_creatures` SET `position_x`=-10523.4, `position_y`=-1197.27, `position_z`=27.1923, `orientation`=2.89475 WHERE `spawn_id`=4179; -- Watcher Hartin
        UPDATE `spawns_creatures` SET `position_x`=-10514.9, `position_y`=-1299.42, `position_z`=41.2922, `orientation`=3.19668 WHERE `spawn_id`=4196; -- Whit Wantmal
        UPDATE `spawns_creatures` SET `position_x`=-10565, `position_y`=-1244.66, `position_z`=29.547, `orientation`=4.93982 WHERE `spawn_id`=4180; -- Watcher Jan
        UPDATE `spawns_creatures` SET `position_x`=-10514.6, `position_y`=-1311.46, `position_z`=40.3401, `orientation`=0.476843 WHERE `spawn_id`=4064; -- Malissa
        UPDATE `spawns_creatures` SET `position_x`=-10516.2, `position_y`=-1138.54, `position_z`=26.3151, `orientation`=0.395791 WHERE `spawn_id`=4204; -- Avette Fellwood
        UPDATE `spawns_creatures` SET `position_x`=-10594.1, `position_y`=-1200.87, `position_z`=28.4989, `orientation`=3.13694 WHERE `spawn_id`=4175; -- Elaine Carevin
        UPDATE `spawns_creatures` SET `position_x`=-10609.8, `position_y`=-1166.02, `position_z`=27.1074, `orientation`=4.17348 WHERE `spawn_id`=4242; -- Matt Johnson
        UPDATE `spawns_creatures` SET `position_x`=-240.033, `position_y`=-4186.8, `position_z`=121.811, `orientation`=2.49582 WHERE `spawn_id`=93603; -- Vilebranch Warrior
        UPDATE `spawns_creatures` SET `position_x`=-626.071, `position_y`=-4667.71, `position_z`=6.50807, `orientation`=2.75762 WHERE `spawn_id`=301278; -- Katoom the Angler
        UPDATE `spawns_creatures` SET `position_x`=-11324, `position_y`=-213.783, `position_z`=76.6652, `orientation`=2.25148 WHERE `spawn_id`=1396; -- Rebel Watchman
        UPDATE `spawns_creatures` SET `position_x`=-11958.1, `position_y`=-500.306, `position_z`=17.07, `orientation`=5.11863 WHERE `spawn_id`=1423; -- Venture Co. Mechanic
        UPDATE `spawns_creatures` SET `position_x`=-11948.8, `position_y`=-501.675, `position_z`=17.0548, `orientation`=1.61432 WHERE `spawn_id`=1414; -- Venture Co. Geologist
        UPDATE `spawns_creatures` SET `position_x`=2479.13, `position_y`=1369.2, `position_z`=13.2087, `orientation`=4.13327 WHERE `spawn_id`=41668; -- Vile Fin Minor Oracle
        UPDATE `spawns_creatures` SET `position_x`=-14305, `position_y`=433.285, `position_z`=29.365, `orientation`=1.39626 WHERE `spawn_id`=182; -- Booty Bay Bruiser
        UPDATE `spawns_creatures` SET `position_x`=-14242.2, `position_y`=343.73, `position_z`=25.9658, `orientation`=5.39307 WHERE `spawn_id`=2164; -- Booty Bay Bruiser
        UPDATE `spawns_creatures` SET `position_x`=194.615, `position_y`=-255.949, `position_z`=77.0194, `orientation`=4.31096 WHERE `spawn_id`=40277; -- Blackhand Veteran
        UPDATE `spawns_creatures` SET `position_x`=215.52, `position_y`=-337.733, `position_z`=76.9524, `orientation`=3.10669 WHERE `spawn_id`=40266; -- Blackhand Dreadweaver
        UPDATE `spawns_creatures` SET `position_x`=-9061.28, `position_y`=-46.7949, `position_z`=88.9064, `orientation`=1.5708 WHERE `spawn_id`=79929; -- Northshire Guard
        UPDATE `spawns_creatures` SET `position_x`=223.704, `position_y`=-297.484, `position_z`=77.0515, `orientation`=5.46288 WHERE `spawn_id`=40270; -- Blackhand Summoner
        UPDATE `spawns_creatures` SET `position_x`=224.405, `position_y`=-307.493, `position_z`=77.0506, `orientation`=0.785398 WHERE `spawn_id`=45832; -- Blackhand Summoner
        UPDATE `spawns_creatures` SET `position_x`=222.666, `position_y`=-334.586, `position_z`=77.013, `orientation`=3.07178 WHERE `spawn_id`=40268; -- Blackhand Veteran
        UPDATE `spawns_creatures` SET `position_x`=232.84, `position_y`=-297.491, `position_z`=77.0546, `orientation`=4.08407 WHERE `spawn_id`=40271; -- Blackhand Dreadweaver
        UPDATE `spawns_creatures` SET `position_x`=234.324, `position_y`=-306.764, `position_z`=77.0605, `orientation`=2.44346 WHERE `spawn_id`=40269; -- Blackhand Dreadweaver
        UPDATE `spawns_creatures` SET `position_x`=1901.28, `position_y`=1572.59, `position_z`=89.0794, `orientation`=1.78157 WHERE `spawn_id`=44942; -- Mindless Zombie
        UPDATE `spawns_creatures` SET `position_x`=-9455.43, `position_y`=73.7274, `position_z`=56.9503, `orientation`=3.14159 WHERE `spawn_id`=80335; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=132.626, `position_y`=625.913, `position_z`=-48.3836, `orientation`=4.62512 WHERE `spawn_id`=56951; -- Prince Tortheldrin
        UPDATE `spawns_creatures` SET `position_x`=2155.24, `position_y`=1270.96, `position_z`=52.518, `orientation`=5.49779 WHERE `spawn_id`=28710; -- Deathguard Elite
        UPDATE `spawns_creatures` SET `position_x`=-10361.3, `position_y`=-3965.59, `position_z`=-84.5876, `orientation`=0.225782 WHERE `spawn_id`=38944; -- Kazkaz the Unholy
        UPDATE `spawns_creatures` SET `position_x`=-9181.67, `position_y`=310.567, `position_z`=78.9916, `orientation`=1.58723 WHERE `spawn_id`=79875; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=1069.79, `position_y`=-1902.31, `position_z`=48.0663, `orientation`=3.43562 WHERE `spawn_id`=45413; -- Skeletal Flayer
        UPDATE `spawns_creatures` SET `position_x`=1077.09, `position_y`=-1915.14, `position_z`=63.1365, `orientation`=2.5889 WHERE `spawn_id`=45407; -- Skeletal Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=1075.58, `position_y`=-1932.21, `position_z`=38.6803, `orientation`=3.13942 WHERE `spawn_id`=47189; -- Skeletal Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=1043.73, `position_y`=-1939.94, `position_z`=38.6803, `orientation`=0.762625 WHERE `spawn_id`=45410; -- Slavering Ghoul
        UPDATE `spawns_creatures` SET `position_x`=-457.466, `position_y`=-1468.01, `position_z`=90.1223, `orientation`=4.56161 WHERE `spawn_id`=16053; -- Syndicate Watchman
        UPDATE `spawns_creatures` SET `position_x`=1102.76, `position_y`=-176.101, `position_z`=-65.3086, `orientation`=4.88645 WHERE `spawn_id`=46651; -- Doomforge Arcanasmith
        UPDATE `spawns_creatures` SET `position_x`=-3682.86, `position_y`=-4391.41, `position_z`=10.6955, `orientation`=0.645772 WHERE `spawn_id`=150018; -- Theramore Lieutenant
        UPDATE `spawns_creatures` SET `position_x`=2402.67, `position_y`=500.464, `position_z`=39.9673, `orientation`=5.41052 WHERE `spawn_id`=41294; -- Rotting Dead
        UPDATE `spawns_creatures` SET `position_x`=-2915.42, `position_y`=-313.87, `position_z`=57.4223, `orientation`=0.989173 WHERE `spawn_id`=24949; -- Brave Lightninghorn
        UPDATE `spawns_creatures` SET `position_x`=-3056.28, `position_y`=80.2266, `position_z`=81.3127, `orientation`=4.04916 WHERE `spawn_id`=24715; -- Mulgore Protector
        UPDATE `spawns_creatures` SET `position_x`=-3038.23, `position_y`=99.0721, `position_z`=82.407, `orientation`=1.18682 WHERE `spawn_id`=24718; -- Mulgore Protector
        UPDATE `spawns_creatures` SET `position_x`=-3042.35, `position_y`=161.392, `position_z`=73.9713, `orientation`=0.715585 WHERE `spawn_id`=24720; -- Mulgore Protector
        UPDATE `spawns_creatures` SET `position_x`=-3012.75, `position_y`=140.886, `position_z`=76.1471, `orientation`=1.16937 WHERE `spawn_id`=24716; -- Mulgore Protector
        UPDATE `spawns_creatures` SET `position_x`=1669.34, `position_y`=-336.73, `position_z`=18.6778, `orientation`=1.21184 WHERE `spawn_id`=40133; -- Scarlet Soldier
        UPDATE `spawns_creatures` SET `position_x`=2185.71, `position_y`=-657.377, `position_z`=89.6375, `orientation`=1.2712 WHERE `spawn_id`=44517; -- Scarlet Zealot
        UPDATE `spawns_creatures` SET `position_x`=2168.97, `position_y`=-628.528, `position_z`=87.7579, `orientation`=0.391756 WHERE `spawn_id`=38033; -- Scarlet Zealot
        UPDATE `spawns_creatures` SET `position_x`=-58.5133, `position_y`=-455.796, `position_z`=-18.5609, `orientation`=2.26893 WHERE `spawn_id`=43570; -- Smolderthorn Witch Doctor
        UPDATE `spawns_creatures` SET `position_x`=1485.37, `position_y`=-1679.01, `position_z`=68.7104, `orientation`=2.61443 WHERE `spawn_id`=47196; -- Soulless Ghoul
        UPDATE `spawns_creatures` SET `position_x`=1734.88, `position_y`=-1199.82, `position_z`=59.8584, `orientation`=5.95356 WHERE `spawn_id`=45873; -- Slavering Ghoul
        UPDATE `spawns_creatures` SET `position_x`=1289.27, `position_y`=-412.676, `position_z`=-91.9711, `orientation`=1.37881 WHERE `spawn_id`=53499; -- Anvilrage Reservist
        UPDATE `spawns_creatures` SET `position_x`=-467.178, `position_y`=26.3112, `position_z`=-66.9833, `orientation`=1.5708 WHERE `spawn_id`=39845; -- Loro
        UPDATE `spawns_creatures` SET `position_x`=-2791.94, `position_y`=-3020.85, `position_z`=37.7251, `orientation`=3.49912 WHERE `spawn_id`=39303; -- Theramore Infiltrator
        UPDATE `spawns_creatures` SET `position_x`=-382.673, `position_y`=-2812.39, `position_z`=93.304, `orientation`=4.6792 WHERE `spawn_id`=19319; -- Greater Plainstrider
        UPDATE `spawns_creatures` SET `position_x`=-811.913, `position_y`=-4940.15, `position_z`=20.6154, `orientation`=3.45575 WHERE `spawn_id`=6490; -- Ula'elek
        UPDATE `spawns_creatures` SET `position_x`=-848.051, `position_y`=-4909.01, `position_z`=21.3161, `orientation`=5.64625 WHERE `spawn_id`=3368; -- Bom'bay
        UPDATE `spawns_creatures` SET `position_x`=-825.636, `position_y`=-4920.76, `position_z`=19.7409, `orientation`=3.6579 WHERE `spawn_id`=6462; -- Master Gadrin
        UPDATE `spawns_creatures` SET `position_x`=-498.713, `position_y`=-4456.25, `position_z`=51.1286, `orientation`=3.17724 WHERE `spawn_id`=7376; -- Lazy Peon
        UPDATE `spawns_creatures` SET `position_x`=1075.63, `position_y`=-895.878, `position_z`=-156.615, `orientation`=0.466199 WHERE `spawn_id`=56574; -- Flame Imp
        UPDATE `spawns_creatures` SET `position_x`=2414.29, `position_y`=-3563.18, `position_z`=99.2826, `orientation`=0.392933 WHERE `spawn_id`=33060; -- Horde Shaman
        UPDATE `spawns_creatures` SET `position_x`=267.49, `position_y`=-8.1493, `position_z`=85.2283, `orientation`=3.8115 WHERE `spawn_id`=48374; -- Unstable Corpse
        UPDATE `spawns_creatures` SET `position_x`=-426.677, `position_y`=-85.7376, `position_z`=-88.1407, `orientation`=3.21141 WHERE `spawn_id`=39737; -- Jammal'an the Prophet
        UPDATE `spawns_creatures` SET `position_x`=-422.358, `position_y`=-90.3028, `position_z`=-88.1407, `orientation`=2.67035 WHERE `spawn_id`=39827; -- Ogom the Wretched
        UPDATE `spawns_creatures` SET `position_x`=161.303, `position_y`=-1812.76, `position_z`=92.4406, `orientation`=4.92267 WHERE `spawn_id`=20457; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=31.25, `position_y`=-1792.19, `position_z`=91.7936, `orientation`=3.78886 WHERE `spawn_id`=20456; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=21.0097, `position_y`=-1781.87, `position_z`=92.1568, `orientation`=1.43792 WHERE `spawn_id`=20510; -- Kolkar Stormer
        UPDATE `spawns_creatures` SET `position_x`=1837.73, `position_y`=1314.73, `position_z`=19.0147, `orientation`=5.44187 WHERE `spawn_id`=39888; -- Haunting Phantasm
        UPDATE `spawns_creatures` SET `position_x`=-8895.63, `position_y`=575.369, `position_z`=92.8007, `orientation`=5.41052 WHERE `spawn_id`=79674; -- Stormwind City Guard
        UPDATE `spawns_creatures` SET `position_x`=-6226.67, `position_y`=320.055, `position_z`=383.143, `orientation`=1.55366 WHERE `spawn_id`=349; -- Adlin Pridedrift
        UPDATE `spawns_creatures` SET `position_x`=-6225.61, `position_y`=133.18, `position_z`=431.678, `orientation`=2.67035 WHERE `spawn_id`=328; -- Coldridge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-6169.4, `position_y`=134.66, `position_z`=423.029, `orientation`=3.12757 WHERE `spawn_id`=323; -- Rockjaw Raider
        UPDATE `spawns_creatures` SET `position_x`=-6138.61, `position_y`=123.171, `position_z`=420.97, `orientation`=2.81975 WHERE `spawn_id`=321; -- Rockjaw Raider
        UPDATE `spawns_creatures` SET `position_x`=-6153.21, `position_y`=48.017, `position_z`=416.732, `orientation`=0 WHERE `spawn_id`=1553; -- Rockjaw Raider
        UPDATE `spawns_creatures` SET `position_x`=-6123.15, `position_y`=78.1876, `position_z`=417.071, `orientation`=0.316352 WHERE `spawn_id`=319; -- Rockjaw Raider
        UPDATE `spawns_creatures` SET `position_x`=-5909.4, `position_y`=-68.1109, `position_z`=387.972, `orientation`=4.08634 WHERE `spawn_id`=291; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-6007.46, `position_y`=-202.158, `position_z`=407.081, `orientation`=2.4379 WHERE `spawn_id`=267; -- Shorty
        UPDATE `spawns_creatures` SET `position_x`=-9815.88, `position_y`=152.206, `position_z`=26.1834, `orientation`=2.38709 WHERE `spawn_id`=80614; -- Kobold Miner
        UPDATE `spawns_creatures` SET `position_x`=-6016.42, `position_y`=-332.924, `position_z`=427.592, `orientation`=3.88098 WHERE `spawn_id`=259; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-5766.24, `position_y`=-538.648, `position_z`=417.304, `orientation`=2.42137 WHERE `spawn_id`=229; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-5610.72, `position_y`=-490.063, `position_z`=397.684, `orientation`=2.19912 WHERE `spawn_id`=200; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-5588.39, `position_y`=-464.152, `position_z`=401.81, `orientation`=4.0918 WHERE `spawn_id`=212; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-5565.5, `position_y`=-471.144, `position_z`=399.698, `orientation`=4.66003 WHERE `spawn_id`=205; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-5551.04, `position_y`=-462.461, `position_z`=407.486, `orientation`=4.4855 WHERE `spawn_id`=211; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=1312.49, `position_y`=-1590.76, `position_z`=61.8588, `orientation`=2.07803 WHERE `spawn_id`=52512; -- Skeletal Warlord
        UPDATE `spawns_creatures` SET `position_x`=-5373.57, `position_y`=-544.752, `position_z`=400.573, `orientation`=0.471239 WHERE `spawn_id`=152; -- Ironforge Mountaineer
        UPDATE `spawns_creatures` SET `position_x`=-4118.81, `position_y`=-2311.43, `position_z`=128.585, `orientation`=2.75673 WHERE `spawn_id`=13641; -- Bael'dun Soldier
        UPDATE `spawns_creatures` SET `position_x`=-284.792, `position_y`=-3447.45, `position_z`=188.426, `orientation`=1.41721 WHERE `spawn_id`=93428; -- Qiaga the Keeper
        UPDATE `spawns_creatures` SET `position_x`=-814.062, `position_y`=-1970.83, `position_z`=34.1597, `orientation`=1.57646 WHERE `spawn_id`=12017; -- Syndicate Pathstalker
        UPDATE `spawns_creatures` SET `position_x`=-780.425, `position_y`=-2097.49, `position_z`=34.721, `orientation`=0.137905 WHERE `spawn_id`=11922; -- Syndicate Highwayman
        UPDATE `spawns_creatures` SET `position_x`=10197.8, `position_y`=698.881, `position_z`=1361.25, `orientation`=3.38594 WHERE `spawn_id`=46497; -- Shadowglen Sentinel
        UPDATE `spawns_creatures` SET `position_x`=-9472.87, `position_y`=-219.262, `position_z`=56.3736, `orientation`=2.05899 WHERE `spawn_id`=79635; -- Murloc
        UPDATE `spawns_creatures` SET `position_x`=-9483.19, `position_y`=-424.601, `position_z`=59.7019, `orientation`=5.27762 WHERE `spawn_id`=79621; -- Murloc
        UPDATE `spawns_creatures` SET `position_x`=26.1324, `position_y`=-1734.16, `position_z`=108.818, `orientation`=0.345672 WHERE `spawn_id`=20511; -- Kolkar Stormer
        UPDATE `spawns_creatures` SET `position_x`=-9117.18, `position_y`=-587.363, `position_z`=57.4701, `orientation`=5.90916 WHERE `spawn_id`=80980; -- Kobold Miner
        UPDATE `spawns_creatures` SET `position_x`=-9116.14, `position_y`=-569.412, `position_z`=59.1034, `orientation`=4.41275 WHERE `spawn_id`=80985; -- Kobold Miner
        UPDATE `spawns_creatures` SET `position_x`=-9048.4, `position_y`=-616.413, `position_z`=52.9649, `orientation`=1.85734 WHERE `spawn_id`=80987; -- Mine Spider
        UPDATE `spawns_creatures` SET `position_x`=-9038.72, `position_y`=-608.9, `position_z`=53.1526, `orientation`=5.27785 WHERE `spawn_id`=80991; -- Mine Spider
        UPDATE `spawns_creatures` SET `position_x`=-9030, `position_y`=-613.659, `position_z`=56.5649, `orientation`=0.52706 WHERE `spawn_id`=80993; -- Mine Spider
        UPDATE `spawns_creatures` SET `position_x`=-9024.75, `position_y`=-564.323, `position_z`=54.9264, `orientation`=1.58731 WHERE `spawn_id`=80995; -- Mine Spider
        UPDATE `spawns_creatures` SET `position_x`=-9025.26, `position_y`=-601.833, `position_z`=56.1236, `orientation`=2.68703 WHERE `spawn_id`=80994; -- Mine Spider
        UPDATE `spawns_creatures` SET `position_x`=887.81, `position_y`=-180.491, `position_z`=-43.8419, `orientation`=2.02856 WHERE `spawn_id`=91013; -- Grim Patron
        UPDATE `spawns_creatures` SET `position_x`=178.454, `position_y`=-1530.43, `position_z`=91.7917, `orientation`=0.686192 WHERE `spawn_id`=14214; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=4441.46, `position_y`=-5544.84, `position_z`=107.951, `orientation`=3.53799 WHERE `spawn_id`=35234; -- Timbermaw Den Watcher
        UPDATE `spawns_creatures` SET `position_x`=4689.98, `position_y`=-5391.28, `position_z`=112.363, `orientation`=5.18097 WHERE `spawn_id`=35294; -- Timbermaw Shaman
        UPDATE `spawns_creatures` SET `position_x`=4683.47, `position_y`=-5380.2, `position_z`=111.958, `orientation`=5.11995 WHERE `spawn_id`=35274; -- Timbermaw Shaman
        UPDATE `spawns_creatures` SET `position_x`=-9615.54, `position_y`=-1038.75, `position_z`=39.8703, `orientation`=3.14159 WHERE `spawn_id`=80881; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=582.294, `position_y`=-1518.56, `position_z`=92.1291, `orientation`=4.65765 WHERE `spawn_id`=20610; -- Witchwing Harpy
        UPDATE `spawns_creatures` SET `position_x`=800.604, `position_y`=-1331.68, `position_z`=91.868, `orientation`=2.92758 WHERE `spawn_id`=20654; -- Witchwing Slayer
        UPDATE `spawns_creatures` SET `position_x`=803.39, `position_y`=-1315.16, `position_z`=91.9755, `orientation`=0.450548 WHERE `spawn_id`=20691; -- Witchwing Windcaller
        UPDATE `spawns_creatures` SET `position_x`=1380.95, `position_y`=-792.844, `position_z`=-92.7213, `orientation`=5.53388 WHERE `spawn_id`=90601; -- Doomforge Dragoon
        UPDATE `spawns_creatures` SET `position_x`=-758.539, `position_y`=-4324.67, `position_z`=45.5966, `orientation`=3.94923 WHERE `spawn_id`=6525; -- Lazy Peon
        UPDATE `spawns_creatures` SET `position_x`=-1365.75, `position_y`=-3668.07, `position_z`=93.2412, `orientation`=4.83784 WHERE `spawn_id`=13855; -- Southsea Privateer
        UPDATE `spawns_creatures` SET `position_x`=-1358.07, `position_y`=-3678.09, `position_z`=92.9438, `orientation`=0.152031 WHERE `spawn_id`=13840; -- Southsea Cutthroat
        UPDATE `spawns_creatures` SET `position_x`=-1465.57, `position_y`=-3653.9, `position_z`=92.164, `orientation`=4.39082 WHERE `spawn_id`=13832; -- Southsea Cutthroat
        UPDATE `spawns_creatures` SET `position_x`=-1468.04, `position_y`=-3660.61, `position_z`=92.2071, `orientation`=2.35668 WHERE `spawn_id`=13856; -- Southsea Privateer
        UPDATE `spawns_creatures` SET `position_x`=-1498.71, `position_y`=-3680.65, `position_z`=91.8796, `orientation`=2.49786 WHERE `spawn_id`=13857; -- Southsea Privateer
        UPDATE `spawns_creatures` SET `position_x`=-1492.75, `position_y`=-3657.86, `position_z`=92.1497, `orientation`=2.37213 WHERE `spawn_id`=13839; -- Southsea Cutthroat
        UPDATE `spawns_creatures` SET `position_x`=-1504.17, `position_y`=-3684.38, `position_z`=91.81, `orientation`=3.27837 WHERE `spawn_id`=13837; -- Southsea Cutthroat
        UPDATE `spawns_creatures` SET `position_x`=-1463.56, `position_y`=-3637.29, `position_z`=92.039, `orientation`=2.32645 WHERE `spawn_id`=13852; -- Southsea Privateer
        UPDATE `spawns_creatures` SET `position_x`=-1628.65, `position_y`=-3618.75, `position_z`=91.7791, `orientation`=3.34018 WHERE `spawn_id`=13849; -- Southsea Privateer
        UPDATE `spawns_creatures` SET `position_x`=-1694.99, `position_y`=-3604.42, `position_z`=92.0259, `orientation`=2.12042 WHERE `spawn_id`=13851; -- Southsea Privateer
        UPDATE `spawns_creatures` SET `position_x`=-1689.1, `position_y`=-3608.01, `position_z`=92.6077, `orientation`=4.55172 WHERE `spawn_id`=13833; -- Southsea Cutthroat
        UPDATE `spawns_creatures` SET `position_x`=-2252.53, `position_y`=-2373.72, `position_z`=91.75, `orientation`=0.925025 WHERE `spawn_id`=90921; -- Doan Karhan
        UPDATE `spawns_creatures` SET `position_x`=1217.81, `position_y`=370.138, `position_z`=32.2814, `orientation`=3.735 WHERE `spawn_id`=17732; -- Vile Fin Lakestalker
        UPDATE `spawns_creatures` SET `position_x`=-270.925, `position_y`=-950.258, `position_z`=14.2793, `orientation`=5.48033 WHERE `spawn_id`=40205; -- Seereth Stonebreak
        UPDATE `spawns_creatures` SET `position_x`=-162.766, `position_y`=-1516.05, `position_z`=91.7917, `orientation`=6.13355 WHERE `spawn_id`=14252; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=1179.06, `position_y`=393.7, `position_z`=34.9096, `orientation`=2.29822 WHERE `spawn_id`=17796; -- Vile Fin Oracle
        UPDATE `spawns_creatures` SET `position_x`=-3629.61, `position_y`=-4362.7, `position_z`=6.55041, `orientation`=2.23402 WHERE `spawn_id`=30631; -- Theramore Guard
        UPDATE `spawns_creatures` SET `position_x`=1017.17, `position_y`=713.628, `position_z`=74.0034, `orientation`=5.28267 WHERE `spawn_id`=18272; -- Raging Rot Hide
        UPDATE `spawns_creatures` SET `position_x`=2633.37, `position_y`=-443.655, `position_z`=107.227, `orientation`=4.04916 WHERE `spawn_id`=33408; -- Astranaar Sentinel
        UPDATE `spawns_creatures` SET `position_x`=2637.42, `position_y`=-451.803, `position_z`=107.003, `orientation`=2.9147 WHERE `spawn_id`=33407; -- Astranaar Sentinel
        UPDATE `spawns_creatures` SET `position_x`=-9804.19, `position_y`=685.987, `position_z`=31.9638, `orientation`=4.18879 WHERE `spawn_id`=80475; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=-9815.01, `position_y`=690.105, `position_z`=31.8605, `orientation`=4.31096 WHERE `spawn_id`=80489; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=2814.51, `position_y`=-272.127, `position_z`=107.156, `orientation`=1.71042 WHERE `spawn_id`=33409; -- Astranaar Sentinel
        UPDATE `spawns_creatures` SET `position_x`=-7027.48, `position_y`=-1714.02, `position_z`=241.764, `orientation`=0.542138 WHERE `spawn_id`=6806; -- Dark Iron Watchman
        UPDATE `spawns_creatures` SET `position_x`=-7025.31, `position_y`=-1721.92, `position_z`=241.75, `orientation`=3.78356 WHERE `spawn_id`=6799; -- Dark Iron Geologist
        UPDATE `spawns_creatures` SET `position_x`=-963.536, `position_y`=-3560.84, `position_z`=58.7891, `orientation`=1.61711 WHERE `spawn_id`=11207; -- Tunkk
        UPDATE `spawns_creatures` SET `position_x`=-918.178, `position_y`=-3495.46, `position_z`=70.4501, `orientation`=3.05141 WHERE `spawn_id`=11206; -- Urda
        UPDATE `spawns_creatures` SET `position_x`=-840.657, `position_y`=-3513.86, `position_z`=73.3906, `orientation`=4.10152 WHERE `spawn_id`=11258; -- Defiler Elite
        UPDATE `spawns_creatures` SET `position_x`=536.336, `position_y`=-3020.82, `position_z`=91.7917, `orientation`=2.14626 WHERE `spawn_id`=14183; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=5138.35, `position_y`=-513.015, `position_z`=295.909, `orientation`=3.97592 WHERE `spawn_id`=40638; -- Vile Ooze
        UPDATE `spawns_creatures` SET `position_x`=3512.14, `position_y`=-3071.1, `position_z`=135.08, `orientation`=0.785398 WHERE `spawn_id`=52141; -- Crimson Monk
        UPDATE `spawns_creatures` SET `position_x`=-9760.11, `position_y`=88.2476, `position_z`=12.3849, `orientation`=3.44472 WHERE `spawn_id`=80649; -- Kobold Miner
        UPDATE `spawns_creatures` SET `position_x`=5171.36, `position_y`=-350.738, `position_z`=341.145, `orientation`=6.0912 WHERE `spawn_id`=39084; -- Bloodvenom Post Brave
        UPDATE `spawns_creatures` SET `position_x`=-2589.71, `position_y`=-3999.46, `position_z`=5.38413, `orientation`=2.97821 WHERE `spawn_id`=31713; -- Mirefin Coastrunner
        UPDATE `spawns_creatures` SET `position_x`=1769.79, `position_y`=-2067.71, `position_z`=102.745, `orientation`=2.35573 WHERE `spawn_id`=32581; -- Silverwing Sentinel
        UPDATE `spawns_creatures` SET `position_x`=1514.34, `position_y`=-2143.97, `position_z`=88.6304, `orientation`=1.01509 WHERE `spawn_id`=32569; -- Shadethicket Oracle
        UPDATE `spawns_creatures` SET `position_x`=579.205, `position_y`=-2420.54, `position_z`=92.5695, `orientation`=3.42465 WHERE `spawn_id`=14091; -- Savannah Huntress
        UPDATE `spawns_creatures` SET `position_x`=543.461, `position_y`=-2456.37, `position_z`=91.7917, `orientation`=1.60733 WHERE `spawn_id`=18672; -- Savannah Highmane
        UPDATE `spawns_creatures` SET `position_x`=210.786, `position_y`=-2562.32, `position_z`=91.7917, `orientation`=4.52208 WHERE `spawn_id`=14090; -- Savannah Huntress
        UPDATE `spawns_creatures` SET `position_x`=-10488.2, `position_y`=1212.17, `position_z`=67.1583, `orientation`=4.52324 WHERE `spawn_id`=90344; -- Defias Smuggler
        UPDATE `spawns_creatures` SET `position_x`=-8888.17, `position_y`=566.203, `position_z`=92.6715, `orientation`=2.23402 WHERE `spawn_id`=79669; -- Stormwind City Guard
        UPDATE `spawns_creatures` SET `position_x`=-3005.83, `position_y`=-3242.95, `position_z`=34.8865, `orientation`=1.06293 WHERE `spawn_id`=31262; -- Theramore Sentry
        UPDATE `spawns_creatures` SET `position_x`=-2997.97, `position_y`=-3250.16, `position_z`=34.9326, `orientation`=1.47513 WHERE `spawn_id`=31273; -- Theramore Sentry
        UPDATE `spawns_creatures` SET `position_x`=-8556.37, `position_y`=835.86, `position_z`=106.602, `orientation`=5.32325 WHERE `spawn_id`=44022; -- Brother Sarno
        UPDATE `spawns_creatures` SET `position_x`=-8573.13, `position_y`=861.073, `position_z`=106.602, `orientation`=0.715585 WHERE `spawn_id`=37585; -- Arthur the Faithful
        UPDATE `spawns_creatures` SET `position_x`=-8545.84, `position_y`=845.796, `position_z`=106.601, `orientation`=4.72984 WHERE `spawn_id`=39536; -- Duthorian Rall
        UPDATE `spawns_creatures` SET `position_x`=-8513.31, `position_y`=802.071, `position_z`=106.602, `orientation`=2.26893 WHERE `spawn_id`=15216; -- Shaina Fuller
        UPDATE `spawns_creatures` SET `position_x`=-8564.39, `position_y`=880.634, `position_z`=106.602, `orientation`=3.82227 WHERE `spawn_id`=37586; -- Katherine the Pure
        UPDATE `spawns_creatures` SET `position_x`=-8577.5, `position_y`=881.466, `position_z`=106.602, `orientation`=5.42797 WHERE `spawn_id`=5000; -- Lord Grayson Shadowbreaker
        UPDATE `spawns_creatures` SET `position_x`=-8634.22, `position_y`=886.742, `position_z`=103.266, `orientation`=5.46288 WHERE `spawn_id`=7626; -- Gregory Ardus
        UPDATE `spawns_creatures` SET `position_x`=-8522.61, `position_y`=848.783, `position_z`=106.702, `orientation`=3.71755 WHERE `spawn_id`=7566; -- Archbishop Benedictus
        UPDATE `spawns_creatures` SET `position_x`=-8528.55, `position_y`=855.31, `position_z`=106.702, `orientation`=4.01426 WHERE `spawn_id`=300992; -- Bishop Farthing
        UPDATE `spawns_creatures` SET `position_x`=1319.86, `position_y`=-1298.73, `position_z`=62.1918, `orientation`=0.453237 WHERE `spawn_id`=46894; -- Skeletal Acolyte
        UPDATE `spawns_creatures` SET `position_x`=965.135, `position_y`=-1417.87, `position_z`=66.5527, `orientation`=4.18879 WHERE `spawn_id`=45242; -- Alchemist Arbington
        UPDATE `spawns_creatures` SET `position_x`=615.121, `position_y`=-3031.12, `position_z`=91.7917, `orientation`=1.50723 WHERE `spawn_id`=14151; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-6454.85, `position_y`=-1197.17, `position_z`=180.928, `orientation`=1.0472 WHERE `spawn_id`=5811; -- Enslaved Archaeologist
        UPDATE `spawns_creatures` SET `position_x`=167.109, `position_y`=-267.366, `position_z`=18.6246, `orientation`=2.22933 WHERE `spawn_id`=40078; -- Scarlet Beastmaster
        UPDATE `spawns_creatures` SET `position_x`=591.607, `position_y`=-2923.92, `position_z`=92.3631, `orientation`=2.64532 WHERE `spawn_id`=14168; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=509.863, `position_y`=-3011.21, `position_z`=91.7917, `orientation`=5.51085 WHERE `spawn_id`=14211; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-1014.85, `position_y`=-1119.04, `position_z`=44.4928, `orientation`=4.51853 WHERE `spawn_id`=26351; -- Bristleback Interloper
        UPDATE `spawns_creatures` SET `position_x`=-1001.86, `position_y`=-1087.31, `position_z`=44.4757, `orientation`=3.50141 WHERE `spawn_id`=26260; -- Bristleback Interloper
        UPDATE `spawns_creatures` SET `position_x`=-6882.26, `position_y`=-1248.25, `position_z`=178.947, `orientation`=5.32325 WHERE `spawn_id`=5775; -- Slave Worker
        UPDATE `spawns_creatures` SET `position_x`=1606.86, `position_y`=852.071, `position_z`=146.228, `orientation`=2.23274 WHERE `spawn_id`=29973; -- Pridewing Consort
        UPDATE `spawns_creatures` SET `position_x`=-569.179, `position_y`=-1496.84, `position_z`=52.6321, `orientation`=0.142562 WHERE `spawn_id`=16302; -- Syndicate Watchman
        UPDATE `spawns_creatures` SET `position_x`=-575, `position_y`=-1522.92, `position_z`=52.8159, `orientation`=5.83739 WHERE `spawn_id`=16303; -- Syndicate Shadow Mage
        UPDATE `spawns_creatures` SET `position_x`=-601.302, `position_y`=-1520.55, `position_z`=53.9523, `orientation`=0.93078 WHERE `spawn_id`=16305; -- Syndicate Shadow Mage
        UPDATE `spawns_creatures` SET `position_x`=-1047.61, `position_y`=-2817.11, `position_z`=42.2394, `orientation`=1.37859 WHERE `spawn_id`=12058; -- Marcel Dabyrie
        UPDATE `spawns_creatures` SET `position_x`=2652.92, `position_y`=1433.99, `position_z`=226.351, `orientation`=3.94444 WHERE `spawn_id`=29585; -- Keeper Albagorm
        UPDATE `spawns_creatures` SET `position_x`=-10359.1, `position_y`=-3368.92, `position_z`=22.4278, `orientation`=3.64433 WHERE `spawn_id`=34148; -- Stonard Wayfinder
        UPDATE `spawns_creatures` SET `position_x`=-10384, `position_y`=-3374.19, `position_z`=22.9553, `orientation`=3.56376 WHERE `spawn_id`=34153; -- Stonard Wayfinder
        UPDATE `spawns_creatures` SET `position_x`=-496.395, `position_y`=-1859, `position_z`=91.7916, `orientation`=4.08325 WHERE `spawn_id`=14220; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-1777.89, `position_y`=-3131.81, `position_z`=40.7263, `orientation`=1.77671 WHERE `spawn_id`=14724; -- Witherbark Axe Thrower
        UPDATE `spawns_creatures` SET `position_x`=-1865.19, `position_y`=-3065.53, `position_z`=57.9381, `orientation`=5.77222 WHERE `spawn_id`=14728; -- Witherbark Witch Doctor
        UPDATE `spawns_creatures` SET `position_x`=-580.499, `position_y`=-3668.59, `position_z`=92.2299, `orientation`=4.21651 WHERE `spawn_id`=14129; -- Savannah Matriarch
        UPDATE `spawns_creatures` SET `position_x`=-643.099, `position_y`=-3645.83, `position_z`=94.6301, `orientation`=2.84422 WHERE `spawn_id`=14132; -- Savannah Matriarch
        UPDATE `spawns_creatures` SET `position_x`=-856.781, `position_y`=199.696, `position_z`=17.5879, `orientation`=0.76313 WHERE `spawn_id`=15932; -- Hillsbrad Sentry
        UPDATE `spawns_creatures` SET `position_x`=-4236.46, `position_y`=-2383.33, `position_z`=204.475, `orientation`=5.81879 WHERE `spawn_id`=11084; -- Dragonmaw Grunt
        UPDATE `spawns_creatures` SET `position_x`=-4356.15, `position_y`=-2422.42, `position_z`=228.378, `orientation`=3.88917 WHERE `spawn_id`=11079; -- Dragonmaw Grunt
        UPDATE `spawns_creatures` SET `position_x`=-6632.31, `position_y`=-2726.94, `position_z`=243.537, `orientation`=3.87894 WHERE `spawn_id`=7249; -- Servo
        UPDATE `spawns_creatures` SET `position_x`=-6862.3, `position_y`=-1227.78, `position_z`=176.459, `orientation`=6.22263 WHERE `spawn_id`=6841; -- Dark Iron Taskmaster
        UPDATE `spawns_creatures` SET `position_x`=639.228, `position_y`=-1048.57, `position_z`=-199.736, `orientation`=0.349311 WHERE `spawn_id`=56785; -- Firelord
        UPDATE `spawns_creatures` SET `position_x`=-1930.03, `position_y`=-715.275, `position_z`=3.65329, `orientation`=0.988659 WHERE `spawn_id`=26357; -- Venture Co. Taskmaster
        UPDATE `spawns_creatures` SET `position_x`=-6689.95, `position_y`=-2161.96, `position_z`=244.196, `orientation`=3.9968 WHERE `spawn_id`=6886; -- Thunderheart
        UPDATE `spawns_creatures` SET `position_x`=1362.15, `position_y`=-377.956, `position_z`=-92.0441, `orientation`=0.925025 WHERE `spawn_id`=53380; -- Anvilrage Reservist
        UPDATE `spawns_creatures` SET `position_x`=1405.14, `position_y`=-375.315, `position_z`=-92.0252, `orientation`=3.28338 WHERE `spawn_id`=53412; -- Anvilrage Reservist
        UPDATE `spawns_creatures` SET `position_x`=-1878.12, `position_y`=1116.9, `position_z`=92.4664, `orientation`=0.938042 WHERE `spawn_id`=27124; -- Magram Mauler
        UPDATE `spawns_creatures` SET `position_x`=-1817.65, `position_y`=1183.5, `position_z`=88.4781, `orientation`=3.22262 WHERE `spawn_id`=27101; -- Magram Windchaser
        UPDATE `spawns_creatures` SET `position_x`=-1852.94, `position_y`=1959.51, `position_z`=64.8033, `orientation`=2.8717 WHERE `spawn_id`=27902; -- Nether Maiden
        UPDATE `spawns_creatures` SET `position_x`=602.61, `position_y`=-1097.12, `position_z`=-199.871, `orientation`=2.86904 WHERE `spawn_id`=91260; -- Lava Elemental
        UPDATE `spawns_creatures` SET `position_x`=-8469.34, `position_y`=582.931, `position_z`=96.052, `orientation`=5.37561 WHERE `spawn_id`=8733; -- Morgg Stormshot
        UPDATE `spawns_creatures` SET `position_x`=-8419.3, `position_y`=646.603, `position_z`=97.5324, `orientation`=0.698132 WHERE `spawn_id`=37603; -- Thulman Flintcrag
        UPDATE `spawns_creatures` SET `position_x`=-8424.49, `position_y`=616.944, `position_z`=95.5429, `orientation`=2.23402 WHERE `spawn_id`=37604; -- Therum Deepforge
        UPDATE `spawns_creatures` SET `position_x`=-8433.99, `position_y`=693.397, `position_z`=103.447, `orientation`=0.698132 WHERE `spawn_id`=37606; -- Gelman Stonehand
        UPDATE `spawns_creatures` SET `position_x`=-8430.18, `position_y`=695.138, `position_z`=96.4011, `orientation`=5.06145 WHERE `spawn_id`=37607; -- Brooke Stonebraid
        UPDATE `spawns_creatures` SET `position_x`=-8424.68, `position_y`=608.84, `position_z`=95.3021, `orientation`=3.22886 WHERE `spawn_id`=5169; -- Dane Lindgren
        UPDATE `spawns_creatures` SET `position_x`=-8427.13, `position_y`=600.092, `position_z`=94.7483, `orientation`=3.28122 WHERE `spawn_id`=35250; -- Furen Longbeard
        UPDATE `spawns_creatures` SET `position_x`=-8387.14, `position_y`=685.202, `position_z`=95.356, `orientation`=2.28638 WHERE `spawn_id`=8169; -- Grimand Elmore
        UPDATE `spawns_creatures` SET `position_x`=-8387.6, `position_y`=692.506, `position_z`=95.3568, `orientation`=3.92699 WHERE `spawn_id`=37602; -- Kathrum Axehand
        UPDATE `spawns_creatures` SET `position_x`=-8342.25, `position_y`=638.323, `position_z`=95.4204, `orientation`=3.7001 WHERE `spawn_id`=37612; -- Billibub Cogspinner
        UPDATE `spawns_creatures` SET `position_x`=-443.83, `position_y`=1747.83, `position_z`=131.533, `orientation`=1.55902 WHERE `spawn_id`=27627; -- Burning Blade Augur
        UPDATE `spawns_creatures` SET `position_x`=1178.13, `position_y`=933.951, `position_z`=33.4422, `orientation`=5.31644 WHERE `spawn_id`=18212; -- Vile Fin Shredder
        UPDATE `spawns_creatures` SET `position_x`=-88.3192, `position_y`=-463.206, `position_z`=-18.8517, `orientation`=2.28638 WHERE `spawn_id`=44327; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=-5453.31, `position_y`=1220.63, `position_z`=32.9785, `orientation`=0.904606 WHERE `spawn_id`=50317; -- Gordunni Warlord
        UPDATE `spawns_creatures` SET `position_x`=-7086.68, `position_y`=-3760.42, `position_z`=8.98303, `orientation`=0.139626 WHERE `spawn_id`=23585; -- Gadgetzan Bruiser
        UPDATE `spawns_creatures` SET `position_x`=436.981, `position_y`=-4211.97, `position_z`=24.6614, `orientation`=5.907 WHERE `spawn_id`=7351; -- Razormane Battleguard
        UPDATE `spawns_creatures` SET `position_x`=-2059.52, `position_y`=-1975.37, `position_z`=91.7917, `orientation`=3.05639 WHERE `spawn_id`=20124; -- Bristleback Hunter
        UPDATE `spawns_creatures` SET `position_x`=-2035.93, `position_y`=-1976.12, `position_z`=91.7917, `orientation`=0.470821 WHERE `spawn_id`=20148; -- Bristleback Water Seeker
        UPDATE `spawns_creatures` SET `position_x`=-683.397, `position_y`=-2338.63, `position_z`=17.167, `orientation`=2.70073 WHERE `spawn_id`=13685; -- Deviate Slayer
        UPDATE `spawns_creatures` SET `position_x`=-14134.8, `position_y`=472.693, `position_z`=2.29207, `orientation`=0.072315 WHERE `spawn_id`=2584; -- Bloodsail Mage
        UPDATE `spawns_creatures` SET `position_x`=1046.85, `position_y`=1342.66, `position_z`=29.1465, `orientation`=2.71598 WHERE `spawn_id`=39992; -- Scarlet Myrmidon
        UPDATE `spawns_creatures` SET `position_x`=-11590.8, `position_y`=-619.667, `position_z`=28.5431, `orientation`=3.47321 WHERE `spawn_id`=1586; -- Kurzen Medicine Man
        UPDATE `spawns_creatures` SET `position_x`=-11500.5, `position_y`=-730.693, `position_z`=31.841, `orientation`=1.68446 WHERE `spawn_id`=1631; -- Kurzen Commando
        UPDATE `spawns_creatures` SET `position_x`=-10950.3, `position_y`=-1151.19, `position_z`=39.6178, `orientation`=5.79573 WHERE `spawn_id`=4892; -- Nightbane Vile Fang
        UPDATE `spawns_creatures` SET `position_x`=-11076.1, `position_y`=-1141.2, `position_z`=42.9304, `orientation`=5.63425 WHERE `spawn_id`=6113; -- Nightbane Tainted One
        UPDATE `spawns_creatures` SET `position_x`=-11102.5, `position_y`=-1151.13, `position_z`=41.8456, `orientation`=1.0821 WHERE `spawn_id`=5018; -- Nightbane Tainted One
        UPDATE `spawns_creatures` SET `position_x`=-11106.7, `position_y`=-1161.95, `position_z`=42.2581, `orientation`=5.93412 WHERE `spawn_id`=6093; -- Nightbane Tainted One
        UPDATE `spawns_creatures` SET `position_x`=828.82, `position_y`=-639.731, `position_z`=-203.433, `orientation`=5.0823 WHERE `spawn_id`=91281; -- Lava Annihilator
        UPDATE `spawns_creatures` SET `position_x`=-9170.68, `position_y`=-2115.43, `position_z`=88.9493, `orientation`=1.98739 WHERE `spawn_id`=6259; -- Gerald Crawley
        UPDATE `spawns_creatures` SET `position_x`=-9173.33, `position_y`=-2088.29, `position_z`=89.0329, `orientation`=3.80482 WHERE `spawn_id`=6263; -- Henry Chapal
        UPDATE `spawns_creatures` SET `position_x`=-9239.12, `position_y`=-2035.06, `position_z`=78.1647, `orientation`=4.1105 WHERE `spawn_id`=6152; -- Hannah
        UPDATE `spawns_creatures` SET `position_x`=-9704.43, `position_y`=-648.048, `position_z`=47.3044, `orientation`=0.813016 WHERE `spawn_id`=80824; -- Rockhide Boar
        UPDATE `spawns_creatures` SET `position_x`=-9486.48, `position_y`=-206.128, `position_z`=57.8829, `orientation`=4.29641 WHERE `spawn_id`=81083; -- Murloc
        UPDATE `spawns_creatures` SET `position_x`=-9849.96, `position_y`=1036.8, `position_z`=34.0139, `orientation`=4.68137 WHERE `spawn_id`=90224; -- Defias Footpad
        UPDATE `spawns_creatures` SET `position_x`=-11717.3, `position_y`=224.042, `position_z`=40.4604, `orientation`=0 WHERE `spawn_id`=1223; -- Bloodscalp Scavenger
        UPDATE `spawns_creatures` SET `position_x`=-37.4355, `position_y`=-453.615, `position_z`=16.5437, `orientation`=0.593412 WHERE `spawn_id`=43532; -- Smolderthorn Shadow Hunter
        UPDATE `spawns_creatures` SET `position_x`=-10966.1, `position_y`=-946.828, `position_z`=71.1859, `orientation`=4.69256 WHERE `spawn_id`=4301; -- Nightbane Dark Runner
        UPDATE `spawns_creatures` SET `position_x`=-10961.1, `position_y`=-948.675, `position_z`=71.1881, `orientation`=0.135909 WHERE `spawn_id`=4296; -- Nightbane Dark Runner
        UPDATE `spawns_creatures` SET `position_x`=-7075.2, `position_y`=-1576.09, `position_z`=248.359, `orientation`=4.05015 WHERE `spawn_id`=5651; -- Searing Lava Spider
        UPDATE `spawns_creatures` SET `position_x`=-6463.36, `position_y`=-1248.84, `position_z`=180.411, `orientation`=2.62006 WHERE `spawn_id`=5806; -- Enslaved Archaeologist
        UPDATE `spawns_creatures` SET `position_x`=-5217.74, `position_y`=-3112.37, `position_z`=301.178, `orientation`=3.09857 WHERE `spawn_id`=8220; -- Warg Deepwater
        UPDATE `spawns_creatures` SET `position_x`=-4804.14, `position_y`=-2971.7, `position_z`=321.415, `orientation`=3.0072 WHERE `spawn_id`=9297; -- Tunnel Rat Kobold
        UPDATE `spawns_creatures` SET `position_x`=-3383.85, `position_y`=-2545.83, `position_z`=20.5465, `orientation`=4.47877 WHERE `spawn_id`=10752; -- Dragonmaw Raider
        UPDATE `spawns_creatures` SET `position_x`=-3086.18, `position_y`=-1995.39, `position_z`=9.03481, `orientation`=0.438708 WHERE `spawn_id`=10703; -- Mosshide Fenrunner
        UPDATE `spawns_creatures` SET `position_x`=-3755.34, `position_y`=-849.345, `position_z`=10.0241, `orientation`=5.61441 WHERE `spawn_id`=9464; -- Edwina Monzor
        UPDATE `spawns_creatures` SET `position_x`=-4235.61, `position_y`=-2350.4, `position_z`=204.332, `orientation`=1.59004 WHERE `spawn_id`=11088; -- Dragonmaw Grunt
        UPDATE `spawns_creatures` SET `position_x`=-4249.19, `position_y`=-2373, `position_z`=204.565, `orientation`=1.6844 WHERE `spawn_id`=11087; -- Dragonmaw Scout
        UPDATE `spawns_creatures` SET `position_x`=-4243.95, `position_y`=-2343.69, `position_z`=204.376, `orientation`=5.97079 WHERE `spawn_id`=11118; -- Dragonmaw Grunt
        UPDATE `spawns_creatures` SET `position_x`=-6410.6, `position_y`=-3435.38, `position_z`=248.692, `orientation`=1.27715 WHERE `spawn_id`=7163; -- Shadowforge Tunneler
        UPDATE `spawns_creatures` SET `position_x`=-6397.88, `position_y`=-3415.28, `position_z`=241.727, `orientation`=6.20184 WHERE `spawn_id`=7164; -- Shadowforge Tunneler
        UPDATE `spawns_creatures` SET `position_x`=-6460.54, `position_y`=-3393.8, `position_z`=241.682, `orientation`=3.79946 WHERE `spawn_id`=7190; -- Shadowforge Darkweaver
        UPDATE `spawns_creatures` SET `position_x`=-3850.27, `position_y`=-730.695, `position_z`=8.5083, `orientation`=1.93051 WHERE `spawn_id`=9533; -- Maiden's Virtue Crewman
        UPDATE `spawns_creatures` SET `position_x`=-3869.33, `position_y`=-598.3, `position_z`=6.1641, `orientation`=3.6237 WHERE `spawn_id`=9571; -- Maiden's Virtue Crewman
        UPDATE `spawns_creatures` SET `position_x`=716.405, `position_y`=947.74, `position_z`=34.7559, `orientation`=2.63371 WHERE `spawn_id`=18259; -- Fenwick Thatros
        UPDATE `spawns_creatures` SET `position_x`=-2493.77, `position_y`=-2454.27, `position_z`=79.3046, `orientation`=5.95379 WHERE `spawn_id`=9955; -- Comar Villard
        UPDATE `spawns_creatures` SET `position_x`=-2650.68, `position_y`=-2453.28, `position_z`=80.1836, `orientation`=1.58246 WHERE `spawn_id`=9812; -- Rhag Garmason
        UPDATE `spawns_creatures` SET `position_x`=-8865.55, `position_y`=822.286, `position_z`=98.4002, `orientation`=0.575959 WHERE `spawn_id`=53686; -- Adair Gilroy
        UPDATE `spawns_creatures` SET `position_x`=-8855.71, `position_y`=822.812, `position_z`=98.4, `orientation`=6.21337 WHERE `spawn_id`=26836; -- Mazen Mac'Nadir
        UPDATE `spawns_creatures` SET `position_x`=-8850.79, `position_y`=829.8, `position_z`=104.78, `orientation`=2.49582 WHERE `spawn_id`=90459; -- Acolyte Dellis
        UPDATE `spawns_creatures` SET `position_x`=-8958.82, `position_y`=816.416, `position_z`=109.53, `orientation`=3.78736 WHERE `spawn_id`=90469; -- Sellandus
        UPDATE `spawns_creatures` SET `position_x`=-8963.19, `position_y`=822.125, `position_z`=109.446, `orientation`=3.7001 WHERE `spawn_id`=52922; -- Wynne Larson
        UPDATE `spawns_creatures` SET `position_x`=-9008.98, `position_y`=845.35, `position_z`=105.921, `orientation`=0 WHERE `spawn_id`=90442; -- Archmage Malin
        UPDATE `spawns_creatures` SET `position_x`=-8989.7, `position_y`=861.881, `position_z`=29.704, `orientation`=4.72984 WHERE `spawn_id`=90462; -- Jennea Cannon
        UPDATE `spawns_creatures` SET `position_x`=-9012.53, `position_y`=867.142, `position_z`=29.704, `orientation`=3.735 WHERE `spawn_id`=26835; -- Maginor Dumas
        UPDATE `spawns_creatures` SET `position_x`=-9010.78, `position_y`=876.575, `position_z`=148.702, `orientation`=4.86947 WHERE `spawn_id`=90470; -- High Sorcerer Andromath
        UPDATE `spawns_creatures` SET `position_x`=-9006.11, `position_y`=885.375, `position_z`=29.704, `orientation`=0.802851 WHERE `spawn_id`=90463; -- Elsharin
        UPDATE `spawns_creatures` SET `position_x`=-8951, `position_y`=898.653, `position_z`=108.287, `orientation`=5.28835 WHERE `spawn_id`=52921; -- Owen Vaughn
        UPDATE `spawns_creatures` SET `position_x`=-9085.86, `position_y`=829.043, `position_z`=108.604, `orientation`=0.453786 WHERE `spawn_id`=52924; -- Joachim Brenlow
        UPDATE `spawns_creatures` SET `position_x`=-8886.89, `position_y`=985.503, `position_z`=124.541, `orientation`=4.67748 WHERE `spawn_id`=43441; -- Darian Singh
        UPDATE `spawns_creatures` SET `position_x`=-8833.99, `position_y`=984.074, `position_z`=98.552, `orientation`=4.60767 WHERE `spawn_id`=26834; -- Caretaker Folsom
        UPDATE `spawns_creatures` SET `position_x`=-8741.68, `position_y`=1095.5, `position_z`=93.7959, `orientation`=5.51524 WHERE `spawn_id`=90466; -- Theridran
        UPDATE `spawns_creatures` SET `position_x`=-8776.3, `position_y`=1100.09, `position_z`=92.6261, `orientation`=4.90438 WHERE `spawn_id`=90465; -- Sheldras Moontree
        UPDATE `spawns_creatures` SET `position_x`=-8727.69, `position_y`=1102.96, `position_z`=92.6025, `orientation`=3.87463 WHERE `spawn_id`=90480; -- Nara Meideros
        UPDATE `spawns_creatures` SET `position_x`=512.729, `position_y`=-205.978, `position_z`=-59.1615, `orientation`=3.10972 WHERE `spawn_id`=90699; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=-8750.83, `position_y`=1124.52, `position_z`=92.6338, `orientation`=1.53589 WHERE `spawn_id`=90467; -- Maldryn
        UPDATE `spawns_creatures` SET `position_x`=-8721.29, `position_y`=1137.16, `position_z`=90.761, `orientation`=2.1293 WHERE `spawn_id`=90483; -- Imelda
        UPDATE `spawns_creatures` SET `position_x`=-8787.91, `position_y`=832.669, `position_z`=97.4384, `orientation`=0.261799 WHERE `spawn_id`=90456; -- Stockade Guard
        UPDATE `spawns_creatures` SET `position_x`=-8799.57, `position_y`=828.396, `position_z`=97.6346, `orientation`=0.968697 WHERE `spawn_id`=89325; -- Warden Thelwater
        UPDATE `spawns_creatures` SET `position_x`=-8595.41, `position_y`=740.665, `position_z`=101.987, `orientation`=3.92699 WHERE `spawn_id`=86169; -- Jesper
        UPDATE `spawns_creatures` SET `position_x`=-8533.35, `position_y`=456.655, `position_z`=105.1, `orientation`=2.30383 WHERE `spawn_id`=10506; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-8463.8, `position_y`=516.193, `position_z`=100.639, `orientation`=3.26377 WHERE `spawn_id`=35221; -- Brohann Caskbelly
        UPDATE `spawns_creatures` SET `position_x`=-8524.29, `position_y`=444.579, `position_z`=105.21, `orientation`=3.78736 WHERE `spawn_id`=10510; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-8468.64, `position_y`=501.28, `position_z`=99.9119, `orientation`=2.68781 WHERE `spawn_id`=2435; -- Wilder Thistlenettle
        UPDATE `spawns_creatures` SET `position_x`=-8432.74, `position_y`=554.682, `position_z`=95.3503, `orientation`=1.27409 WHERE `spawn_id`=48424; -- Jenova Stoneshield
        UPDATE `spawns_creatures` SET `position_x`=-8422.21, `position_y`=553.205, `position_z`=95.5317, `orientation`=5.39307 WHERE `spawn_id`=18402; -- Karrina Mekenda
        UPDATE `spawns_creatures` SET `position_x`=-8415.76, `position_y`=552.698, `position_z`=95.5317, `orientation`=3.82227 WHERE `spawn_id`=37608; -- Einris Brightspear
        UPDATE `spawns_creatures` SET `position_x`=-8410.29, `position_y`=548.566, `position_z`=95.5317, `orientation`=3.64774 WHERE `spawn_id`=37609; -- Ulfir Ironbeard
        UPDATE `spawns_creatures` SET `position_x`=-8412.8, `position_y`=541.397, `position_z`=102.578, `orientation`=0.733038 WHERE `spawn_id`=37610; -- Thorfin Stoneshield
        UPDATE `spawns_creatures` SET `position_x`=-8388.84, `position_y`=453.085, `position_z`=123.76, `orientation`=3.80482 WHERE `spawn_id`=10524; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-8394.09, `position_y`=449.423, `position_z`=123.76, `orientation`=0.645772 WHERE `spawn_id`=10523; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-20.3867, `position_y`=2458.55, `position_z`=-4.29719, `orientation`=3.10621 WHERE `spawn_id`=52990; -- Nipsy
        UPDATE `spawns_creatures` SET `position_x`=50.7911, `position_y`=1190.2, `position_z`=-121.307, `orientation`=2.23869 WHERE `spawn_id`=48296; -- Naga Siren
        UPDATE `spawns_creatures` SET `position_x`=-4850.7, `position_y`=-1295.24, `position_z`=501.951, `orientation`=1.39626 WHERE `spawn_id`=302421; -- Fizzlebang Booms
        UPDATE `spawns_creatures` SET `position_x`=-5194.21, `position_y`=-737.037, `position_z`=447.468, `orientation`=1.71042 WHERE `spawn_id`=141; -- Ironforge Guard
        UPDATE `spawns_creatures` SET `position_x`=10099.6, `position_y`=1458.99, `position_z`=1276.42, `orientation`=2.35302 WHERE `spawn_id`=46419; -- Agal
        UPDATE `spawns_creatures` SET `position_x`=387.224, `position_y`=-153.808, `position_z`=-64.949, `orientation`=2.16127 WHERE `spawn_id`=45893; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=410.246, `position_y`=-196.335, `position_z`=-64.877, `orientation`=4.81377 WHERE `spawn_id`=90900; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=379.02, `position_y`=-197.159, `position_z`=-69.8456, `orientation`=5.1853 WHERE `spawn_id`=91030; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=296.717, `position_y`=-179.106, `position_z`=-75.797, `orientation`=2.25729 WHERE `spawn_id`=91055; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=324.4, `position_y`=-213.24, `position_z`=-78.215, `orientation`=4.53814 WHERE `spawn_id`=90849; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=288.172, `position_y`=-92.3701, `position_z`=-75.885, `orientation`=3.97289 WHERE `spawn_id`=90905; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=-8.37479, `position_y`=-902.874, `position_z`=57.5411, `orientation`=6.19215 WHERE `spawn_id`=16051; -- Umpi
        UPDATE `spawns_creatures` SET `position_x`=-0.763534, `position_y`=-938.919, `position_z`=61.9332, `orientation`=0.0486992 WHERE `spawn_id`=15893; -- Captured Farmer
        UPDATE `spawns_creatures` SET `position_x`=512.549, `position_y`=-199.688, `position_z`=-59.6124, `orientation`=0.849916 WHERE `spawn_id`=90701; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=582.85, `position_y`=-152.61, `position_z`=-68.4486, `orientation`=6.11643 WHERE `spawn_id`=47624; -- Ograbisi
        UPDATE `spawns_creatures` SET `position_x`=581.996, `position_y`=-176.436, `position_z`=-84.4941, `orientation`=2.88969 WHERE `spawn_id`=46607; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=582.865, `position_y`=-190.914, `position_z`=-84.4943, `orientation`=0.985207 WHERE `spawn_id`=46302; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=606.685, `position_y`=-193.381, `position_z`=-84.4849, `orientation`=4.87865 WHERE `spawn_id`=46272; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=612.972, `position_y`=-198.379, `position_z`=-84.493, `orientation`=1.27988 WHERE `spawn_id`=46269; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=1350.4, `position_y`=-3653.07, `position_z`=92.763, `orientation`=0.603595 WHERE `spawn_id`=20744; -- Venture Co. Enforcer
        UPDATE `spawns_creatures` SET `position_x`=1358.09, `position_y`=-3640.96, `position_z`=92.7527, `orientation`=2.82316 WHERE `spawn_id`=20741; -- Venture Co. Enforcer
        UPDATE `spawns_creatures` SET `position_x`=1728.7, `position_y`=-1170.43, `position_z`=59.6126, `orientation`=3.5035 WHERE `spawn_id`=45739; -- Skeletal Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=1973.6, `position_y`=-4504.02, `position_z`=82.3923, `orientation`=4.33656 WHERE `spawn_id`=92843; -- Hate Shrieker
        UPDATE `spawns_creatures` SET `position_x`=2016.71, `position_y`=-4555.33, `position_z`=74.9888, `orientation`=6.16923 WHERE `spawn_id`=92536; -- Hate Shrieker
        UPDATE `spawns_creatures` SET `position_x`=5405.6, `position_y`=-551.63, `position_z`=359.588, `orientation`=4.29208 WHERE `spawn_id`=39501; -- Angerclaw Mauler
        UPDATE `spawns_creatures` SET `position_x`=6731.68, `position_y`=-4629.53, `position_z`=721.668, `orientation`=2.78214 WHERE `spawn_id`=42288; -- Everlook Bruiser
        UPDATE `spawns_creatures` SET `position_x`=6727.17, `position_y`=-4654.35, `position_z`=721.031, `orientation`=0.947567 WHERE `spawn_id`=42290; -- Everlook Bruiser
        UPDATE `spawns_creatures` SET `position_x`=6738.09, `position_y`=-4674.12, `position_z`=721.953, `orientation`=1.40012 WHERE `spawn_id`=42278; -- Everlook Bruiser
        UPDATE `spawns_creatures` SET `position_x`=6719.4, `position_y`=-4703, `position_z`=721.583, `orientation`=2.44885 WHERE `spawn_id`=42280; -- Everlook Bruiser

        UPDATE `spawns_creatures` SET `position_x`=66.2384, `position_y`=-274.532, `position_z`=60.7346, `orientation`=6.23082 WHERE `spawn_id`=300420; -- Scarshield Legionnaire
        UPDATE `spawns_creatures` SET `position_x`=70.5436, `position_y`=-420.443, `position_z`=110.847, `orientation`=0.750492 WHERE `spawn_id`=41790; -- Awbee
        UPDATE `spawns_creatures` SET `position_x`=-1477.94, `position_y`=190.359, `position_z`=-7.70947, `orientation`=5.37561 WHERE `spawn_id`=54390; -- Chronos
        UPDATE `spawns_creatures` SET `position_x`=-1586.9, `position_y`=151.369, `position_z`=-7.49291, `orientation`=0.488692 WHERE `spawn_id`=54338; -- Sayge
        UPDATE `spawns_creatures` SET `position_x`=120.713, `position_y`=206.373, `position_z`=-4.90247, `orientation`=5.5676 WHERE `spawn_id`=84252; -- Petrified Treant
        UPDATE `spawns_creatures` SET `position_x`=1821.44, `position_y`=195.831, `position_z`=70.483, `orientation`=2.75507 WHERE `spawn_id`=202833; -- Undercity Reveler
        UPDATE `spawns_creatures` SET `position_x`=819.488, `position_y`=-161.968, `position_z`=-49.6699, `orientation`=5.60345 WHERE `spawn_id`=91047; -- Guzzling Patron
        UPDATE `spawns_creatures` SET `position_x`=819.488, `position_y`=-161.968, `position_z`=-49.6699, `orientation`=5.60345 WHERE `spawn_id`=91067; -- Guzzling Patron
        UPDATE `spawns_creatures` SET `position_x`=889.815, `position_y`=-205.893, `position_z`=-42.6204, `orientation`=1.99706 WHERE `spawn_id`=91070; -- Grim Patron
        UPDATE `spawns_creatures` SET `position_x`=-10836, `position_y`=-2952.57, `position_z`=13.9408, `orientation`=3.05433 WHERE `spawn_id`=40521; -- Spirit Healer
        UPDATE `spawns_creatures` SET `position_x`=-11182.6, `position_y`=-1857.22, `position_z`=73.8614, `orientation`=4.94902 WHERE `spawn_id`=4009; -- Unliving Resident
        UPDATE `spawns_creatures` SET `position_x`=-11172, `position_y`=-1852.65, `position_z`=73.8614, `orientation`=0.623975 WHERE `spawn_id`=4007; -- Unliving Resident
        UPDATE `spawns_creatures` SET `position_x`=2246.33, `position_y`=308.24, `position_z`=36.771, `orientation`=5.58505 WHERE `spawn_id`=28473; -- Eliza Callen
        UPDATE `spawns_creatures` SET `position_x`=2253.9, `position_y`=318.385, `position_z`=36.771, `orientation`=5.51524 WHERE `spawn_id`=33711; -- Velma Warnam
        UPDATE `spawns_creatures` SET `position_x`=2278.08, `position_y`=295.587, `position_z`=36.8172, `orientation`=1.93731 WHERE `spawn_id`=29797; -- Executor Zygand
        UPDATE `spawns_creatures` SET `position_x`=2272.98, `position_y`=290.231, `position_z`=36.666, `orientation`=3.24631 WHERE `spawn_id`=34112; -- Deathguard Cyrus
        UPDATE `spawns_creatures` SET `position_x`=-338.803, `position_y`=5.1802, `position_z`=55.5131, `orientation`=0.595024 WHERE `spawn_id`=16506; -- Hillsbrad Farmer
        UPDATE `spawns_creatures` SET `position_x`=-337.991, `position_y`=17.6618, `position_z`=55.52, `orientation`=4.4472 WHERE `spawn_id`=16527; -- Hillsbrad Farmer
        UPDATE `spawns_creatures` SET `position_x`=-353.514, `position_y`=21.3989, `position_z`=54.7844, `orientation`=1.9557 WHERE `spawn_id`=16020; -- Stanley
        UPDATE `spawns_creatures` SET `position_x`=6408.2, `position_y`=518.467, `position_z`=8.73286, `orientation`=2.84489 WHERE `spawn_id`=90188; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=6437.92, `position_y`=472.23, `position_z`=7.85245, `orientation`=1.99652 WHERE `spawn_id`=37103; -- Sentinel Glynda Nal'Shea
        UPDATE `spawns_creatures` SET `position_x`=-9019.92, `position_y`=476.071, `position_z`=96.1215, `orientation`=2.3011 WHERE `spawn_id`=206210; -- Stormwind Reveler
        UPDATE `spawns_creatures` SET `position_x`=-9019.92, `position_y`=476.071, `position_z`=96.1215, `orientation`=2.3011 WHERE `spawn_id`=206209; -- Stormwind Reveler
        UPDATE `spawns_creatures` SET `position_x`=-9072.43, `position_y`=499.01, `position_z`=76.2405, `orientation`=2.08688 WHERE `spawn_id`=206411; -- Stormwind Reveler
        UPDATE `spawns_creatures` SET `position_x`=-9042.23, `position_y`=434.241, `position_z`=93.2955, `orientation`=2.23402 WHERE `spawn_id`=301304; -- Squire Rowe
        UPDATE `spawns_creatures` SET `position_x`=-8992.91, `position_y`=394.684, `position_z`=72.798, `orientation`=0.416506 WHERE `spawn_id`=206458; -- Stormwind Reveler
        UPDATE `spawns_creatures` SET `position_x`=-11116.5, `position_y`=-2081.65, `position_z`=48.2996, `orientation`=3.24004 WHERE `spawn_id`=4014; -- Unliving Resident
        UPDATE `spawns_creatures` SET `position_x`=-76.3525, `position_y`=312.719, `position_z`=85.5938, `orientation`=1.66955 WHERE `spawn_id`=29431; -- Gogger Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-96.9891, `position_y`=318.316, `position_z`=87.6663, `orientation`=3.41717 WHERE `spawn_id`=29422; -- Gogger Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-5029.11, `position_y`=-813.097, `position_z`=495.274, `orientation`=4.91925 WHERE `spawn_id`=208348; -- Ironforge Reveler
        UPDATE `spawns_creatures` SET `position_x`=-1277.99, `position_y`=107.074, `position_z`=129.592, `orientation`=1.97449 WHERE `spawn_id`=208676; -- Thunder Bluff Reveler
        UPDATE `spawns_creatures` SET `position_x`=-1277.99, `position_y`=107.074, `position_z`=129.592, `orientation`=1.97449 WHERE `spawn_id`=208675; -- Thunder Bluff Reveler
        UPDATE `spawns_creatures` SET `position_x`=8596.23, `position_y`=1009.77, `position_z`=5.79785, `orientation`=0.0257078 WHERE `spawn_id`=208898; -- Darnassus Reveler
        UPDATE `spawns_creatures` SET `position_x`=-9102.33, `position_y`=834.774, `position_z`=105.201, `orientation`=5.11381 WHERE `spawn_id`=54399; -- Connor Rivers
        UPDATE `spawns_creatures` SET `position_x`=2215.43, `position_y`=237.536, `position_z`=34.7272, `orientation`=1.69297 WHERE `spawn_id`=78373; -- Elder Graveborn
        UPDATE `spawns_creatures` SET `position_x`=-8512.4, `position_y`=862.364, `position_z`=109.927, `orientation`=3.82227 WHERE `spawn_id`=1079; -- High Priestess Laurena
        UPDATE `spawns_creatures` SET `position_x`=2755.03, `position_y`=-5395.02, `position_z`=116.28, `orientation`=4.92739 WHERE `spawn_id`=36389; -- Draconic Magelord
        UPDATE `spawns_creatures` SET `position_x`=2570.05, `position_y`=-5481.79, `position_z`=122.175, `orientation`=2.33333 WHERE `spawn_id`=36392; -- Draconic Magelord
        UPDATE `spawns_creatures` SET `position_x`=-8584.07, `position_y`=633.421, `position_z`=96.338, `orientation`=5.07306 WHERE `spawn_id`=79816; -- Roman
        UPDATE `spawns_creatures` SET `position_x`=-20.0212, `position_y`=-366.39, `position_z`=-4.04007, `orientation`=1.81514 WHERE `spawn_id`=300889; -- Warpwood Crusher
        UPDATE `spawns_creatures` SET `position_x`=-1199.45, `position_y`=-96.621, `position_z`=162.744, `orientation`=2.39416 WHERE `spawn_id`=212000; -- Thunder Bluff Reveler
        UPDATE `spawns_creatures` SET `position_x`=2405.9, `position_y`=1808.95, `position_z`=360.101, `orientation`=4.08343 WHERE `spawn_id`=32208; -- Cenarion Caretaker
        UPDATE `spawns_creatures` SET `position_x`=2394.61, `position_y`=1812.49, `position_z`=391.867, `orientation`=6.12611 WHERE `spawn_id`=29235; -- Gatekeeper Kordurus
        UPDATE `spawns_creatures` SET `position_x`=2366.03, `position_y`=1795.21, `position_z`=365.137, `orientation`=3.28122 WHERE `spawn_id`=29238; -- Rynthariel the Keymaster
        UPDATE `spawns_creatures` SET `position_x`=1428.68, `position_y`=-4402.17, `position_z`=25.3187, `orientation`=3.19816 WHERE `spawn_id`=212456; -- Orgrimmar Reveler
        UPDATE `spawns_creatures` SET `position_x`=2343.83, `position_y`=1837.69, `position_z`=381.839, `orientation`=1.23669 WHERE `spawn_id`=32209; -- Cenarion Caretaker
        UPDATE `spawns_creatures` SET `position_x`=-10420, `position_y`=-3242.63, `position_z`=20.2615, `orientation`=4.90438 WHERE `spawn_id`=33815; -- Grunt Tharlak
        UPDATE `spawns_creatures` SET `position_x`=-4882.52, `position_y`=-952.796, `position_z`=501.547, `orientation`=3.26954 WHERE `spawn_id`=86181; -- Goli Krumn
        UPDATE `spawns_creatures` SET `position_x`=-8533.59, `position_y`=367.126, `position_z`=108.569, `orientation`=2.28638 WHERE `spawn_id`=10500; -- Caledra Dawnbreeze
        UPDATE `spawns_creatures` SET `position_x`=-8469.94, `position_y`=361.209, `position_z`=116.933, `orientation`=0.715585 WHERE `spawn_id`=10511; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-8421.2, `position_y`=405.485, `position_z`=120.969, `orientation`=3.57792 WHERE `spawn_id`=16182; -- Major Samuelson
        UPDATE `spawns_creatures` SET `position_x`=-8462.33, `position_y`=367.363, `position_z`=116.913, `orientation`=3.78736 WHERE `spawn_id`=10512; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-8454.62, `position_y`=318.853, `position_z`=120.969, `orientation`=0.698132 WHERE `spawn_id`=54614; -- Elfarran
        UPDATE `spawns_creatures` SET `position_x`=-8437.96, `position_y`=331.033, `position_z`=122.763, `orientation`=2.26893 WHERE `spawn_id`=10497; -- Lady Katrana Prestor
        UPDATE `spawns_creatures` SET `position_x`=-8363.3, `position_y`=407.914, `position_z`=122.458, `orientation`=5.34071 WHERE `spawn_id`=10525; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-8355.78, `position_y`=414.382, `position_z`=122.458, `orientation`=5.42797 WHERE `spawn_id`=10526; -- Stormwind Royal Guard
        UPDATE `spawns_creatures` SET `position_x`=-146.427, `position_y`=-366.639, `position_z`=-4.06831, `orientation`=1.90241 WHERE `spawn_id`=300905; -- Phase Lasher
        UPDATE `spawns_creatures` SET `position_x`=-8332.95, `position_y`=394.82, `position_z`=122.458, `orientation`=2.25148 WHERE `spawn_id`=10502; -- Lord Gregor Lescovar
        UPDATE `spawns_creatures` SET `position_x`=-8345.72, `position_y`=383.766, `position_z`=122.358, `orientation`=2.1293 WHERE `spawn_id`=8704; -- Milton Sheaf
        UPDATE `spawns_creatures` SET `position_x`=-8441.76, `position_y`=311.67, `position_z`=120.969, `orientation`=1.53589 WHERE `spawn_id`=14740; -- Alliance Brigadier General
        UPDATE `spawns_creatures` SET `position_x`=-8394.83, `position_y`=281.69, `position_z`=121.069, `orientation`=3.82227 WHERE `spawn_id`=10498; -- Grand Admiral Jes-Tereth
        UPDATE `spawns_creatures` SET `position_x`=-8401.1, `position_y`=276.694, `position_z`=121.069, `orientation`=0.663225 WHERE `spawn_id`=10499; -- Mithras Ironhill
        UPDATE `spawns_creatures` SET `position_x`=-773.643, `position_y`=-354.978, `position_z`=90.8773, `orientation`=2.54818 WHERE `spawn_id`=150419; -- Frostwolf Bowman
        UPDATE `spawns_creatures` SET `position_x`=6.64531, `position_y`=-460.465, `position_z`=111.016, `orientation`=0.418879 WHERE `spawn_id`=42663; -- Rage Talon Fire Tongue
        UPDATE `spawns_creatures` SET `position_x`=-1354.17, `position_y`=-3909.38, `position_z`=8.65149, `orientation`=4.10568 WHERE `spawn_id`=13760; -- Southsea Brigand
        UPDATE `spawns_creatures` SET `position_x`=-12375, `position_y`=234.228, `position_z`=3.36529, `orientation`=1.8675 WHERE `spawn_id`=611; -- Grom'gol Grunt
        UPDATE `spawns_creatures` SET `position_x`=-12335.5, `position_y`=163.184, `position_z`=3.06546, `orientation`=2.70526 WHERE `spawn_id`=666; -- Angrun
        UPDATE `spawns_creatures` SET `position_x`=-8506.38, `position_y`=328.657, `position_z`=120.885, `orientation`=0.0326069 WHERE `spawn_id`=33821; -- Bishop DeLavey
        UPDATE `spawns_creatures` SET `position_x`=-8681.22, `position_y`=432.526, `position_z`=99.3012, `orientation`=1.65806 WHERE `spawn_id`=79741; -- Dashel Stonefist
        UPDATE `spawns_creatures` SET `position_x`=-10553.6, `position_y`=-1250.2, `position_z`=32.0477, `orientation`=1.93298 WHERE `spawn_id`=4247; -- Watcher Petras
        UPDATE `spawns_creatures` SET `position_x`=-571.081, `position_y`=-263.751, `position_z`=75.092, `orientation`=5.41052 WHERE `spawn_id`=53089; -- Commander Dardosh
        UPDATE `spawns_creatures` SET `position_x`=-491.384, `position_y`=-176.36, `position_z`=57.5352, `orientation`=5.96903 WHERE `spawn_id`=53111; -- Lieutenant Lewis
        UPDATE `spawns_creatures` SET `position_x`=-14293.2, `position_y`=557.623, `position_z`=8.85528, `orientation`=5.21853 WHERE `spawn_id`=655; -- Booty Bay Bruiser
        UPDATE `spawns_creatures` SET `position_x`=-173.069, `position_y`=-452.949, `position_z`=40.9205, `orientation`=3.56047 WHERE `spawn_id`=150408; -- Stormpike Bowman
        UPDATE `spawns_creatures` SET `position_x`=1171.01, `position_y`=-189.006, `position_z`=-65.3757, `orientation`=5.66563 WHERE `spawn_id`=46641; -- Molten War Golem
        UPDATE `spawns_creatures` SET `position_x`=214.099, `position_y`=-373.896, `position_z`=56.4709, `orientation`=2.26893 WHERE `spawn_id`=53226; -- Commander Karl Philips
        UPDATE `spawns_creatures` SET `position_x`=210.875, `position_y`=-357.36, `position_z`=56.4586, `orientation`=5.67232 WHERE `spawn_id`=150103; -- Wing Commander Guse
        UPDATE `spawns_creatures` SET `position_x`=226.311, `position_y`=-369.188, `position_z`=57.0509, `orientation`=5.98648 WHERE `spawn_id`=150404; -- Stormpike Bowman
        UPDATE `spawns_creatures` SET `position_x`=1395.88, `position_y`=1020.38, `position_z`=167.323, `orientation`=1.20017 WHERE `spawn_id`=29964; -- Pridewing Consort
        UPDATE `spawns_creatures` SET `position_x`=7580.48, `position_y`=-2249.03, `position_z`=467.078, `orientation`=4.31096 WHERE `spawn_id`=91667; -- Lunar Festival Sentinel
        UPDATE `spawns_creatures` SET `position_x`=7630.92, `position_y`=-2227.69, `position_z`=465.589, `orientation`=3.00197 WHERE `spawn_id`=91682; -- Lunar Festival Sentinel
        UPDATE `spawns_creatures` SET `position_x`=-8823.37, `position_y`=540.074, `position_z`=96.9894, `orientation`=2.44346 WHERE `spawn_id`=54905; -- Pat's Snowcloud Guy
        UPDATE `spawns_creatures` SET `position_x`=2093.53, `position_y`=-4510.3, `position_z`=78.4227, `orientation`=1.87772 WHERE `spawn_id`=92240; -- Hate Shrieker
        UPDATE `spawns_creatures` SET `position_x`=2021.94, `position_y`=-4563.24, `position_z`=74.9812, `orientation`=3.19908 WHERE `spawn_id`=92537; -- Vile Tutor
        UPDATE `spawns_creatures` SET `position_x`=-194.051, `position_y`=1697.7, `position_z`=105.462, `orientation`=5.28835 WHERE `spawn_id`=27632; -- Burning Blade Reaver
        UPDATE `spawns_creatures` SET `position_x`=1245.4, `position_y`=-9.26176, `position_z`=-5.46087, `orientation`=2.6238 WHERE `spawn_id`=29546; -- Venture Co. Deforester
        UPDATE `spawns_creatures` SET `position_x`=1234.8, `position_y`=43.5027, `position_z`=-5.90117, `orientation`=3.70514 WHERE `spawn_id`=29464; -- Venture Co. Operator
        UPDATE `spawns_creatures` SET `position_x`=-3642.63, `position_y`=-4346.07, `position_z`=8.03261, `orientation`=5.35816 WHERE `spawn_id`=30726; -- Theramore Guard
        UPDATE `spawns_creatures` SET `position_x`=-1141.67, `position_y`=2695.83, `position_z`=111.331, `orientation`=0.463648 WHERE `spawn_id`=27326; -- Maraudine Mauler
        UPDATE `spawns_creatures` SET `position_x`=235.987, `position_y`=-850.581, `position_z`=146.984, `orientation`=2.14003 WHERE `spawn_id`=16958; -- Syndicate Thief
        UPDATE `spawns_creatures` SET `position_x`=-34.983, `position_y`=-448, `position_z`=-37.8785, `orientation`=0.191986 WHERE `spawn_id`=56934; -- Zevrim Thornhoof
        UPDATE `spawns_creatures` SET `position_x`=-455.99, `position_y`=133.747, `position_z`=57.2124, `orientation`=3.92699 WHERE `spawn_id`=15994; -- Hillsbrad Footman
        UPDATE `spawns_creatures` SET `position_x`=-740.656, `position_y`=132.525, `position_z`=20.648, `orientation`=2.54818 WHERE `spawn_id`=15915; -- Hillsbrad Miner
        UPDATE `spawns_creatures` SET `position_x`=-751.105, `position_y`=106.233, `position_z`=14.5482, `orientation`=4.31096 WHERE `spawn_id`=15916; -- Hillsbrad Miner
        UPDATE `spawns_creatures` SET `position_x`=-9424.66, `position_y`=129.056, `position_z`=59.8005, `orientation`=2.33201 WHERE `spawn_id`=80317; -- Mark
        UPDATE `spawns_creatures` SET `position_x`=-1135.43, `position_y`=-846.768, `position_z`=16.921, `orientation`=1.93731 WHERE `spawn_id`=15706; -- Daggerspine Shorehunter
        UPDATE `spawns_creatures` SET `position_x`=-11586.1, `position_y`=678.883, `position_z`=59.6691, `orientation`=5.14475 WHERE `spawn_id`=1936; -- Bloodscalp Witch Doctor
        UPDATE `spawns_creatures` SET `position_x`=6768.6, `position_y`=-4673.69, `position_z`=723.831, `orientation`=0 WHERE `spawn_id`=42282; -- Everlook Bruiser
        UPDATE `spawns_creatures` SET `position_x`=387.409, `position_y`=462.772, `position_z`=-7.14894, `orientation`=2.68781 WHERE `spawn_id`=302364; -- Gordok Reaver
        UPDATE `spawns_creatures` SET `position_x`=484.101, `position_y`=523.808, `position_z`=27.9977, `orientation`=1.44862 WHERE `spawn_id`=302372; -- Gordok Reaver
        UPDATE `spawns_creatures` SET `position_x`=-11838.5, `position_y`=1256.12, `position_z`=2.15493, `orientation`=5.81195 WHERE `spawn_id`=2368; -- Captured Hakkari Zealot
        UPDATE `spawns_creatures` SET `position_x`=704.35, `position_y`=-22.9071, `position_z`=50.2187, `orientation`=0.785398 WHERE `spawn_id`=301909; -- Prospector Stonehewer
        UPDATE `spawns_creatures` SET `position_x`=727.014, `position_y`=2.3412, `position_z`=50.7046, `orientation`=3.87463 WHERE `spawn_id`=150146; -- Dun Baldar South Marshal
        UPDATE `spawns_creatures` SET `position_x`=497.733, `position_y`=523.807, `position_z`=27.9982, `orientation`=1.64061 WHERE `spawn_id`=302371; -- Gordok Reaver
        UPDATE `spawns_creatures` SET `position_x`=522.958, `position_y`=554.504, `position_z`=28.0006, `orientation`=2.19912 WHERE `spawn_id`=302370; -- Gordok Reaver
        UPDATE `spawns_creatures` SET `position_x`=593.228, `position_y`=565.12, `position_z`=-4.67144, `orientation`=3.10669 WHERE `spawn_id`=302369; -- Gordok Reaver
        UPDATE `spawns_creatures` SET `position_x`=-5280.94, `position_y`=1277.44, `position_z`=50.8182, `orientation`=2.90686 WHERE `spawn_id`=50230; -- Gordunni Mauler
        UPDATE `spawns_creatures` SET `position_x`=6866.44, `position_y`=-5100.03, `position_z`=692.812, `orientation`=2.49776 WHERE `spawn_id`=41030; -- Winterfall Shaman
        UPDATE `spawns_creatures` SET `position_x`=1663.39, `position_y`=1151.67, `position_z`=159.351, `orientation`=2.61472 WHERE `spawn_id`=29963; -- Pridewing Consort
        UPDATE `spawns_creatures` SET `position_x`=-11514.4, `position_y`=724.968, `position_z`=61.1043, `orientation`=3.03687 WHERE `spawn_id`=19; -- Gan'zulah
        UPDATE `spawns_creatures` SET `position_x`=9907.93, `position_y`=2206.21, `position_z`=1328.93, `orientation`=1.2103 WHERE `spawn_id`=46502; -- Great Horned Owl
        UPDATE `spawns_creatures` SET `position_x`=-107.998, `position_y`=533.761, `position_z`=28.6972, `orientation`=4.72984 WHERE `spawn_id`=300157; -- Eldreth Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=-104.183, `position_y`=526.692, `position_z`=28.6962, `orientation`=1.0472 WHERE `spawn_id`=300159; -- Rotting Highborne
        UPDATE `spawns_creatures` SET `position_x`=-11553.8, `position_y`=608.401, `position_z`=50.7278, `orientation`=4.18879 WHERE `spawn_id`=1114; -- Bloodscalp Beastmaster
        UPDATE `spawns_creatures` SET `position_x`=-11586.5, `position_y`=562.651, `position_z`=49.9286, `orientation`=4.05296 WHERE `spawn_id`=1081; -- Bloodscalp Hunter
        UPDATE `spawns_creatures` SET `position_x`=-7195.3, `position_y`=-3793.25, `position_z`=9.747, `orientation`=3.32894 WHERE `spawn_id`=60001; -- Gadgetzan Bruiser
        UPDATE `spawns_creatures` SET `position_x`=1667.78, `position_y`=-2363.76, `position_z`=61.6675, `orientation`=5.16163 WHERE `spawn_id`=48590; -- Wailing Death
        UPDATE `spawns_creatures` SET `position_x`=1670.06, `position_y`=-2351.3, `position_z`=60.7904, `orientation`=2.23994 WHERE `spawn_id`=46279; -- Hungering Wraith
        UPDATE `spawns_creatures` SET `position_x`=1665.75, `position_y`=-2372.59, `position_z`=61.666, `orientation`=5.55941 WHERE `spawn_id`=45312; -- Hungering Wraith
        UPDATE `spawns_creatures` SET `position_x`=1537.65, `position_y`=540.831, `position_z`=172.22, `orientation`=6.01743 WHERE `spawn_id`=29968; -- Pridewing Consort
        UPDATE `spawns_creatures` SET `position_x`=1511.72, `position_y`=531.25, `position_z`=158.74, `orientation`=1.46287 WHERE `spawn_id`=29967; -- Pridewing Consort
        UPDATE `spawns_creatures` SET `position_x`=552.073, `position_y`=1593.59, `position_z`=130.111, `orientation`=3.18666 WHERE `spawn_id`=17613; -- Dalar Dawnweaver
        UPDATE `spawns_creatures` SET `position_x`=128.02, `position_y`=-315.29, `position_z`=111.029, `orientation`=2.98451 WHERE `spawn_id`=40462; -- Rage Talon Dragonspawn
        UPDATE `spawns_creatures` SET `position_x`=-11491.9, `position_y`=393.702, `position_z`=62.4361, `orientation`=1.53589 WHERE `spawn_id`=1314; -- Venture Co. Mechanic
        UPDATE `spawns_creatures` SET `position_x`=7949.41, `position_y`=-2616.75, `position_z`=492.439, `orientation`=2.77507 WHERE `spawn_id`=91683; -- Lunar Festival Sentinel
        UPDATE `spawns_creatures` SET `position_x`=1545.77, `position_y`=-1713.62, `position_z`=67.6403, `orientation`=5.25606 WHERE `spawn_id`=45228; -- Skeletal Acolyte
        UPDATE `spawns_creatures` SET `position_x`=7002.13, `position_y`=-2201.5, `position_z`=587.081, `orientation`=1.65806 WHERE `spawn_id`=39729; -- Timbermaw Warder
        UPDATE `spawns_creatures` SET `position_x`=-11844.2, `position_y`=55.5921, `position_z`=14.5074, `orientation`=5.3192 WHERE `spawn_id`=2534; -- Bloodscalp Axe Thrower
        UPDATE `spawns_creatures` SET `position_x`=-166.727, `position_y`=-271.487, `position_z`=-4.06308, `orientation`=5.68977 WHERE `spawn_id`=300935; -- Phase Lasher
        UPDATE `spawns_creatures` SET `position_x`=131.583, `position_y`=-352.838, `position_z`=-4.06887, `orientation`=3.36848 WHERE `spawn_id`=300975; -- Warpwood Crusher
        UPDATE `spawns_creatures` SET `position_x`=216.978, `position_y`=-356.29, `position_z`=-67.4426, `orientation`=5.11381 WHERE `spawn_id`=300897; -- Warpwood Crusher
        UPDATE `spawns_creatures` SET `position_x`=330.651, `position_y`=-375.383, `position_z`=-71.0516, `orientation`=3.9968 WHERE `spawn_id`=300899; -- Warpwood Crusher
        UPDATE `spawns_creatures` SET `position_x`=43.2278, `position_y`=-449.183, `position_z`=111.027, `orientation`=3.85718 WHERE `spawn_id`=300796; -- Rage Talon Dragon Guard
        UPDATE `spawns_creatures` SET `position_x`=6581.42, `position_y`=-5108.81, `position_z`=768.93, `orientation`=5.37275 WHERE `spawn_id`=41604; -- Ice Thistle Yeti
        UPDATE `spawns_creatures` SET `position_x`=-6650.1, `position_y`=-2149.41, `position_z`=245.352, `orientation`=3.9968 WHERE `spawn_id`=6889; -- Innkeeper Shul'kar
        UPDATE `spawns_creatures` SET `position_x`=-11922.2, `position_y`=-905.466, `position_z`=38.162, `orientation`=1.39626 WHERE `spawn_id`=824; -- Gurubashi Warrior
        UPDATE `spawns_creatures` SET `position_x`=-11909.4, `position_y`=-905.137, `position_z`=37.9979, `orientation`=1.85005 WHERE `spawn_id`=825; -- Gurubashi Warrior
        UPDATE `spawns_creatures` SET `position_x`=-11550.2, `position_y`=-228.462, `position_z`=28.2846, `orientation`=6.16101 WHERE `spawn_id`=40520; -- Spirit Healer
        UPDATE `spawns_creatures` SET `position_x`=249.001, `position_y`=-4857.21, `position_z`=13.7579, `orientation`=5.51358 WHERE `spawn_id`=8417; -- Razor Hill Grunt
        UPDATE `spawns_creatures` SET `position_x`=10137.4, `position_y`=2583.92, `position_z`=1325.58, `orientation`=4.38078 WHERE `spawn_id`=70567; -- Elder Bladeswift
        UPDATE `spawns_creatures` SET `position_x`=-285.65, `position_y`=-313.706, `position_z`=-69.1692, `orientation`=3.93039 WHERE `spawn_id`=87131; -- Skum
        UPDATE `spawns_creatures` SET `position_x`=325.609, `position_y`=351.804, `position_z`=2.85293, `orientation`=6.15108 WHERE `spawn_id`=198348; -- Gordok Mastiff
        UPDATE `spawns_creatures` SET `position_x`=-11949.3, `position_y`=-1072.93, `position_z`=92.8714, `orientation`=0.00522972 WHERE `spawn_id`=556; -- Hakkari Oracle
        UPDATE `spawns_creatures` SET `position_x`=-11880.2, `position_y`=-1067.03, `position_z`=97.0762, `orientation`=3.57738 WHERE `spawn_id`=677; -- Hakkari Oracle
        UPDATE `spawns_creatures` SET `position_x`=129.356, `position_y`=443.725, `position_z`=-48.4598, `orientation`=0.389838 WHERE `spawn_id`=56947; -- Lorekeeper Kildrath
        UPDATE `spawns_creatures` SET `position_x`=121.059, `position_y`=488.502, `position_z`=28.6844, `orientation`=4.5204 WHERE `spawn_id`=300106; -- Eldreth Sorcerer
        UPDATE `spawns_creatures` SET `position_x`=-287.854, `position_y`=-3452.69, `position_z`=190.014, `orientation`=2.24965 WHERE `spawn_id`=93453; -- Morta'gya the Keeper
        UPDATE `spawns_creatures` SET `position_x`=24.366, `position_y`=-580.333, `position_z`=-18.5181, `orientation`=2.98451 WHERE `spawn_id`=300468; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=-41.1573, `position_y`=-498.942, `position_z`=29.2434, `orientation`=4.76475 WHERE `spawn_id`=43504; -- Spirestone Enforcer
        UPDATE `spawns_creatures` SET `position_x`=-44.5055, `position_y`=-555.94, `position_z`=29.2742, `orientation`=5.44543 WHERE `spawn_id`=43492; -- Scarshield Worg
        UPDATE `spawns_creatures` SET `position_x`=-44.5055, `position_y`=-555.94, `position_z`=29.2742, `orientation`=5.44543 WHERE `spawn_id`=43491; -- Scarshield Worg
        UPDATE `spawns_creatures` SET `position_x`=-11567.2, `position_y`=-593.903, `position_z`=28.1639, `orientation`=3.24666 WHERE `spawn_id`=1650; -- Kurzen Medicine Man
        UPDATE `spawns_creatures` SET `position_x`=-70.0191, `position_y`=-575.818, `position_z`=29.2742, `orientation`=1.16937 WHERE `spawn_id`=43479; -- Scarshield Legionnaire
        UPDATE `spawns_creatures` SET `position_x`=188.856, `position_y`=-258.877, `position_z`=77.0358, `orientation`=6.07375 WHERE `spawn_id`=40455; -- Blackhand Summoner
        UPDATE `spawns_creatures` SET `position_x`=212.101, `position_y`=-336.132, `position_z`=76.9559, `orientation`=5.09636 WHERE `spawn_id`=45833; -- Blackhand Veteran
        UPDATE `spawns_creatures` SET `position_x`=-1145.3, `position_y`=-3390.21, `position_z`=91.7082, `orientation`=6.0088 WHERE `spawn_id`=14260; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-1046.27, `position_y`=-3668.24, `position_z`=23.9706, `orientation`=1.36136 WHERE `spawn_id`=90289; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=-2005.18, `position_y`=-2788.21, `position_z`=91.8808, `orientation`=2.03383 WHERE `spawn_id`=20152; -- Bristleback Water Seeker
        UPDATE `spawns_creatures` SET `position_x`=-2003.31, `position_y`=-2812.82, `position_z`=92.6828, `orientation`=4.14352 WHERE `spawn_id`=20220; -- Bristleback Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-1945.59, `position_y`=-2706.33, `position_z`=93.3188, `orientation`=0.0734734 WHERE `spawn_id`=20144; -- Bristleback Water Seeker
        UPDATE `spawns_creatures` SET `position_x`=-1929.94, `position_y`=-2702.79, `position_z`=93.466, `orientation`=1.38652 WHERE `spawn_id`=20222; -- Bristleback Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-9416.56, `position_y`=-2289.82, `position_z`=67.9625, `orientation`=2.32129 WHERE `spawn_id`=6157; -- Guard Pearce
        UPDATE `spawns_creatures` SET `position_x`=-10847.3, `position_y`=-2677.95, `position_z`=8.74547, `orientation`=4.93704 WHERE `spawn_id`=2706; -- Dreadmaul Ogre Mage
        UPDATE `spawns_creatures` SET `position_x`=-9495.04, `position_y`=-1929.04, `position_z`=78.9448, `orientation`=5.84685 WHERE `spawn_id`=10152; -- Redridge Thrasher
        UPDATE `spawns_creatures` SET `position_x`=-6232.63, `position_y`=-3844.94, `position_z`=-58.625, `orientation`=2.62578 WHERE `spawn_id`=21557; -- Gnome Pit Crewman
        UPDATE `spawns_creatures` SET `position_x`=667.69, `position_y`=-121.761, `position_z`=64.1092, `orientation`=2.20377 WHERE `spawn_id`=150400; -- Stormpike Bowman
        UPDATE `spawns_creatures` SET `position_x`=733.629, `position_y`=-19.121, `position_z`=50.7046, `orientation`=3.29867 WHERE `spawn_id`=150147; -- Dun Baldar North Marshal
        UPDATE `spawns_creatures` SET `position_x`=-61.1997, `position_y`=-413.017, `position_z`=-18.8517, `orientation`=1.27409 WHERE `spawn_id`=44150; -- Firebrand Invoker
        UPDATE `spawns_creatures` SET `position_x`=-26.7186, `position_y`=-412.36, `position_z`=-18.8517, `orientation`=0.523599 WHERE `spawn_id`=44151; -- Firebrand Invoker
        UPDATE `spawns_creatures` SET `position_x`=-73.6279, `position_y`=-407.391, `position_z`=-18.8517, `orientation`=5.14872 WHERE `spawn_id`=44020; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=-9547.7, `position_y`=-724.959, `position_z`=99.167, `orientation`=2.3766 WHERE `spawn_id`=80931; -- Servant of Azora
        UPDATE `spawns_creatures` SET `position_x`=-9522.79, `position_y`=-701.161, `position_z`=61.6228, `orientation`=4.23045 WHERE `spawn_id`=80936; -- Servant of Azora
        UPDATE `spawns_creatures` SET `position_x`=-14122.2, `position_y`=473.192, `position_z`=1.15794, `orientation`=5.08213 WHERE `spawn_id`=2580; -- "Pretty Boy" Duncan
        UPDATE `spawns_creatures` SET `position_x`=-9060.47, `position_y`=-39.1944, `position_z`=88.3069, `orientation`=4.71239 WHERE `spawn_id`=79930; -- Northshire Guard
        UPDATE `spawns_creatures` SET `position_x`=-9622.5, `position_y`=662.967, `position_z`=52.5756, `orientation`=3.31525 WHERE `spawn_id`=80446; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=-9627.37, `position_y`=677.088, `position_z`=52.5756, `orientation`=2.94424 WHERE `spawn_id`=80458; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=-9615.51, `position_y`=644.183, `position_z`=38.6521, `orientation`=5.01636 WHERE `spawn_id`=80443; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=-9626.8, `position_y`=690.378, `position_z`=52.5756, `orientation`=4.564 WHERE `spawn_id`=80456; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=-9613.27, `position_y`=667.402, `position_z`=38.6522, `orientation`=6.05839 WHERE `spawn_id`=80460; -- Stormwind Guard
        UPDATE `spawns_creatures` SET `position_x`=-9861, `position_y`=1030.69, `position_z`=34.1304, `orientation`=1.66038 WHERE `spawn_id`=90228; -- Defias Footpad
        UPDATE `spawns_creatures` SET `position_x`=-10646.3, `position_y`=1113.48, `position_z`=35.6455, `orientation`=0.890118 WHERE `spawn_id`=45521; -- Westfall Woodworker
        UPDATE `spawns_creatures` SET `position_x`=-79.4082, `position_y`=437.517, `position_z`=28.6859, `orientation`=5.61996 WHERE `spawn_id`=84227; -- Arcane Aberration
        UPDATE `spawns_creatures` SET `position_x`=-90.7518, `position_y`=404.466, `position_z`=28.6844, `orientation`=0.558505 WHERE `spawn_id`=300120; -- Rotting Highborne
        UPDATE `spawns_creatures` SET `position_x`=-1420.63, `position_y`=2923.83, `position_z`=94.3887, `orientation`=0.241436 WHERE `spawn_id`=29080; -- Ghostly Raider
        UPDATE `spawns_creatures` SET `position_x`=6790.28, `position_y`=-2661.51, `position_z`=544.619, `orientation`=3.77771 WHERE `spawn_id`=41061; -- Winterfall Totemic
        UPDATE `spawns_creatures` SET `position_x`=829.697, `position_y`=481.328, `position_z`=37.4015, `orientation`=3.19395 WHERE `spawn_id`=128489; -- King Gordok
        UPDATE `spawns_creatures` SET `position_x`=851.842, `position_y`=13.2664, `position_z`=-53.6419, `orientation`=2.28638 WHERE `spawn_id`=300813; -- Ragereaver Golem
        UPDATE `spawns_creatures` SET `position_x`=606.419, `position_y`=-167.42, `position_z`=-84.4908, `orientation`=1.91671 WHERE `spawn_id`=46281; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=612.84, `position_y`=-173.86, `position_z`=-84.4902, `orientation`=5.3722 WHERE `spawn_id`=46271; -- Bloodhound
        UPDATE `spawns_creatures` SET `position_x`=660.673, `position_y`=-161.784, `position_z`=-73.7256, `orientation`=1.45874 WHERE `spawn_id`=45906; -- Fireguard
        UPDATE `spawns_creatures` SET `position_x`=-213.642, `position_y`=-1662.75, `position_z`=91.7917, `orientation`=3.98733 WHERE `spawn_id`=20465; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-201.479, `position_y`=-1649.25, `position_z`=91.7917, `orientation`=0.129268 WHERE `spawn_id`=20535; -- Kolkar Stormer
        UPDATE `spawns_creatures` SET `position_x`=6514.87, `position_y`=-3270.08, `position_z`=574.585, `orientation`=1.71974 WHERE `spawn_id`=41036; -- Winterfall Den Watcher
        UPDATE `spawns_creatures` SET `position_x`=-164.761, `position_y`=-457.944, `position_z`=87.4736, `orientation`=2.37365 WHERE `spawn_id`=45745; -- Bloodaxe Raider
        UPDATE `spawns_creatures` SET `position_x`=1891.33, `position_y`=-1572.97, `position_z`=59.4183, `orientation`=0.159993 WHERE `spawn_id`=46308; -- Blighted Zombie
        UPDATE `spawns_creatures` SET `position_x`=1930.37, `position_y`=-1615.42, `position_z`=65.8244, `orientation`=4.02373 WHERE `spawn_id`=46289; -- Skeletal Terror
        UPDATE `spawns_creatures` SET `position_x`=-1438.72, `position_y`=-1525.68, `position_z`=92.4579, `orientation`=2.66381 WHERE `spawn_id`=20224; -- Bristleback Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-1423.18, `position_y`=-1530.61, `position_z`=100.574, `orientation`=4.19368 WHERE `spawn_id`=20099; -- Bristleback Hunter
        UPDATE `spawns_creatures` SET `position_x`=-1452.93, `position_y`=-1491.26, `position_z`=97.5759, `orientation`=2.64837 WHERE `spawn_id`=20103; -- Bristleback Hunter
        UPDATE `spawns_creatures` SET `position_x`=-1455.19, `position_y`=-1468.16, `position_z`=102.985, `orientation`=1.88512 WHERE `spawn_id`=20216; -- Bristleback Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-1414.64, `position_y`=-1520.57, `position_z`=106.355, `orientation`=0.684668 WHERE `spawn_id`=20226; -- Bristleback Geomancer
        UPDATE `spawns_creatures` SET `position_x`=-1451.19, `position_y`=-1510.64, `position_z`=92.1666, `orientation`=3.70418 WHERE `spawn_id`=20115; -- Bristleback Hunter
        UPDATE `spawns_creatures` SET `position_x`=-1663.06, `position_y`=-1762.22, `position_z`=91.7917, `orientation`=2.49339 WHERE `spawn_id`=20085; -- Bristleback Hunter
        UPDATE `spawns_creatures` SET `position_x`=2111.46, `position_y`=-1814.58, `position_z`=58.5751, `orientation`=5.52936 WHERE `spawn_id`=45359; -- Scarlet Invoker
        UPDATE `spawns_creatures` SET `position_x`=-131.936, `position_y`=-2009.62, `position_z`=91.7917, `orientation`=4.27015 WHERE `spawn_id`=20470; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-103.71, `position_y`=-2026.18, `position_z`=91.7917, `orientation`=0.0392828 WHERE `spawn_id`=20475; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-186.107, `position_y`=-1525.66, `position_z`=91.7917, `orientation`=1.26989 WHERE `spawn_id`=14166; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-10617.7, `position_y`=-3376.93, `position_z`=-13.217, `orientation`=5.37561 WHERE `spawn_id`=2875; -- Nethergarde Miner
        UPDATE `spawns_creatures` SET `position_x`=-3702.63, `position_y`=-1581.64, `position_z`=92.164, `orientation`=5.26963 WHERE `spawn_id`=14468; -- Razormane Seer
        UPDATE `spawns_creatures` SET `position_x`=-3896, `position_y`=-1638.56, `position_z`=91.7917, `orientation`=1.81753 WHERE `spawn_id`=14852; -- Razormane Seer
        UPDATE `spawns_creatures` SET `position_x`=-3904.11, `position_y`=-1655.46, `position_z`=91.8307, `orientation`=0.610865 WHERE `spawn_id`=14907; -- Razormane Warfrenzy
        UPDATE `spawns_creatures` SET `position_x`=876.666, `position_y`=-503.852, `position_z`=96.7068, `orientation`=0.0349066 WHERE `spawn_id`=53883; -- Stormpike Battleguard
        UPDATE `spawns_creatures` SET `position_x`=1889.6, `position_y`=-1585.37, `position_z`=59.2933, `orientation`=1.86627 WHERE `spawn_id`=48180; -- Skeletal Terror
        UPDATE `spawns_creatures` SET `position_x`=1864.63, `position_y`=-1581.04, `position_z`=59.3816, `orientation`=0.902867 WHERE `spawn_id`=45316; -- Blighted Zombie
        UPDATE `spawns_creatures` SET `position_x`=1905, `position_y`=-1616.26, `position_z`=60.6406, `orientation`=1.52491 WHERE `spawn_id`=47600; -- Rotting Cadaver
        UPDATE `spawns_creatures` SET `position_x`=823.222, `position_y`=-334.283, `position_z`=65.6306, `orientation`=4.88692 WHERE `spawn_id`=301605; -- Irondeep Miner
        UPDATE `spawns_creatures` SET `position_x`=821.006, `position_y`=-387.635, `position_z`=49.0728, `orientation`=3.15905 WHERE `spawn_id`=301687; -- Irondeep Miner
        UPDATE `spawns_creatures` SET `position_x`=-849.416, `position_y`=-93.4279, `position_z`=68.5984, `orientation`=3.22886 WHERE `spawn_id`=150705; -- Masha Swiftcut
        UPDATE `spawns_creatures` SET `position_x`=-5093.57, `position_y`=-2278.03, `position_z`=-54.8101, `orientation`=2.01969 WHERE `spawn_id`=20981; -- Galak Windchaser
        UPDATE `spawns_creatures` SET `position_x`=971.671, `position_y`=-442.657, `position_z`=57.6951, `orientation`=3.1765 WHERE `spawn_id`=150758; -- Irondeep Miner
        UPDATE `spawns_creatures` SET `position_x`=969.979, `position_y`=-457.148, `position_z`=58.1119, `orientation`=4.5204 WHERE `spawn_id`=150759; -- Irondeep Miner
        UPDATE `spawns_creatures` SET `position_x`=-27.4214, `position_y`=-427.44, `position_z`=-18.8517, `orientation`=2.11185 WHERE `spawn_id`=43764; -- Firebrand Grunt
        UPDATE `spawns_creatures` SET `position_x`=2229.05, `position_y`=316.777, `position_z`=36.7124, `orientation`=5.07458 WHERE `spawn_id`=38290; -- Oliver Dwor
        UPDATE `spawns_creatures` SET `position_x`=2253.21, `position_y`=269.817, `position_z`=34.3704, `orientation`=2.394 WHERE `spawn_id`=38291; -- Mrs. Winters
        UPDATE `spawns_creatures` SET `position_x`=2316.85, `position_y`=288.22, `position_z`=37.3107, `orientation`=4.11745 WHERE `spawn_id`=31921; -- Jamie Nore
        UPDATE `spawns_creatures` SET `position_x`=-4442.12, `position_y`=250.631, `position_z`=39.1908, `orientation`=1.97222 WHERE `spawn_id`=89412; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=1707.26, `position_y`=896.115, `position_z`=9.00179, `orientation`=4.11149 WHERE `spawn_id`=81449; -- Sandfury Blood Drinker
        UPDATE `spawns_creatures` SET `position_x`=-7161.96, `position_y`=-3844.55, `position_z`=8.79961, `orientation`=6.00393 WHERE `spawn_id`=90180; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=-7161.96, `position_y`=-3844.55, `position_z`=8.79961, `orientation`=6.00393 WHERE `spawn_id`=90181; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=-7163.59, `position_y`=-3913.28, `position_z`=9.60794, `orientation`=0.15708 WHERE `spawn_id`=54903; -- Wonderform Operator
        UPDATE `spawns_creatures` SET `position_x`=-6974.51, `position_y`=-1503.42, `position_z`=242.747, `orientation`=3.33401 WHERE `spawn_id`=6766; -- Dark Iron Lookout
        UPDATE `spawns_creatures` SET `position_x`=-1685.71, `position_y`=-4324.92, `position_z`=3.38441, `orientation`=4.1493 WHERE `spawn_id`=14358; -- Affray Spectator
        UPDATE `spawns_creatures` SET `position_x`=832.035, `position_y`=-389.301, `position_z`=47.5567, `orientation`=2.11185 WHERE `spawn_id`=301619; -- Irondeep Skullthumper
        UPDATE `spawns_creatures` SET `position_x`=-193.435, `position_y`=-317.738, `position_z`=64.4244, `orientation`=4.03207 WHERE `spawn_id`=40250; -- Bloodaxe Worg Pup
        UPDATE `spawns_creatures` SET `position_x`=-4164.79, `position_y`=-2184.84, `position_z`=50.8403, `orientation`=3.3319 WHERE `spawn_id`=13632; -- Bael'dun Foreman
        UPDATE `spawns_creatures` SET `position_x`=-1504.44, `position_y`=-3828.96, `position_z`=23.4805, `orientation`=4.41829 WHERE `spawn_id`=13767; -- Southsea Brigand
        UPDATE `spawns_creatures` SET `position_x`=1443.21, `position_y`=-2324.43, `position_z`=92.4784, `orientation`=3.38594 WHERE `spawn_id`=33006; -- Horde Deforester
        UPDATE `spawns_creatures` SET `position_x`=119.263, `position_y`=491.5, `position_z`=44.1129, `orientation`=4.7655 WHERE `spawn_id`=16791; -- Dalaran Worker
        UPDATE `spawns_creatures` SET `position_x`=2429.4, `position_y`=-3552.36, `position_z`=99.46, `orientation`=0.713366 WHERE `spawn_id`=33059; -- Horde Shaman
        UPDATE `spawns_creatures` SET `position_x`=-6388.46, `position_y`=-3157.62, `position_z`=301.108, `orientation`=5.78551 WHERE `spawn_id`=7813; -- Shadowforge Warrior
        UPDATE `spawns_creatures` SET `position_x`=-6150.28, `position_y`=-3072.16, `position_z`=226.715, `orientation`=1.86626 WHERE `spawn_id`=7226; -- Shadowforge Surveyor
        UPDATE `spawns_creatures` SET `position_x`=-6117.47, `position_y`=-3020.24, `position_z`=220.615, `orientation`=5.63741 WHERE `spawn_id`=7738; -- Shadowforge Digger
        UPDATE `spawns_creatures` SET `position_x`=-332.554, `position_y`=118.782, `position_z`=-53.638, `orientation`=3.41195 WHERE `spawn_id`=30080; -- Stonevault Oracle
        UPDATE `spawns_creatures` SET `position_x`=218.521, `position_y`=-4717.09, `position_z`=15.1279, `orientation`=0.333576 WHERE `spawn_id`=6388; -- Razor Hill Grunt
        UPDATE `spawns_creatures` SET `position_x`=417.283, `position_y`=-4617.47, `position_z`=54.0366, `orientation`=1.41628 WHERE `spawn_id`=10274; -- Razor Hill Grunt
        UPDATE `spawns_creatures` SET `position_x`=-1106.15, `position_y`=-2789.08, `position_z`=91.7917, `orientation`=6.16686 WHERE `spawn_id`=20512; -- Kolkar Stormer
        UPDATE `spawns_creatures` SET `position_x`=-1127.39, `position_y`=-2797.79, `position_z`=92.0895, `orientation`=4.61005 WHERE `spawn_id`=13995; -- Kolkar Bloodcharger
        UPDATE `spawns_creatures` SET `position_x`=-1394.81, `position_y`=-2734.19, `position_z`=91.7917, `orientation`=4.67501 WHERE `spawn_id`=13994; -- Kolkar Bloodcharger
        UPDATE `spawns_creatures` SET `position_x`=-1418.23, `position_y`=-2739.58, `position_z`=91.7917, `orientation`=3.59305 WHERE `spawn_id`=13997; -- Kolkar Bloodcharger
        UPDATE `spawns_creatures` SET `position_x`=-243.557, `position_y`=265.784, `position_z`=-50.3796, `orientation`=5.26895 WHERE `spawn_id`=29658; -- Stonevault Oracle
        UPDATE `spawns_creatures` SET `position_x`=-40.8641, `position_y`=-553.058, `position_z`=16.2104, `orientation`=0.471239 WHERE `spawn_id`=43557; -- Smolderthorn Axe Thrower
        UPDATE `spawns_creatures` SET `position_x`=4659.88, `position_y`=-5371.88, `position_z`=108.526, `orientation`=3.08305 WHERE `spawn_id`=35265; -- Timbermaw Shaman
        UPDATE `spawns_creatures` SET `position_x`=7033.68, `position_y`=-2114.09, `position_z`=587.312, `orientation`=3.50811 WHERE `spawn_id`=39117; -- Timbermaw Warder
        UPDATE `spawns_creatures` SET `position_x`=8011.8, `position_y`=-2501.53, `position_z`=493.184, `orientation`=0.0418172 WHERE `spawn_id`=42730; -- Rabbit
        UPDATE `spawns_creatures` SET `position_x`=6513.88, `position_y`=-3138.96, `position_z`=573.008, `orientation`=5.46868 WHERE `spawn_id`=41053; -- Winterfall Totemic
        UPDATE `spawns_creatures` SET `position_x`=-4523.56, `position_y`=337.528, `position_z`=35.3209, `orientation`=2.6529 WHERE `spawn_id`=51467; -- Camp Mojache Brave
        UPDATE `spawns_creatures` SET `position_x`=-4755.54, `position_y`=848.648, `position_z`=143.535, `orientation`=2.43485 WHERE `spawn_id`=50565; -- Woodpaw Alpha
        UPDATE `spawns_creatures` SET `position_x`=2370.36, `position_y`=-1181.8, `position_z`=90.8132, `orientation`=4.77953 WHERE `spawn_id`=33034; -- Foulweald Den Watcher
        UPDATE `spawns_creatures` SET `position_x`=-1850.16, `position_y`=1778.95, `position_z`=68.026, `orientation`=4.53438 WHERE `spawn_id`=27922; -- Nether Sister
        UPDATE `spawns_creatures` SET `position_x`=-637.976, `position_y`=-1757.5, `position_z`=92.8842, `orientation`=2.57684 WHERE `spawn_id`=14225; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-524.51, `position_y`=-1851.75, `position_z`=91.7916, `orientation`=1.83026 WHERE `spawn_id`=14228; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=536.011, `position_y`=-2803.2, `position_z`=91.7916, `orientation`=1.94777 WHERE `spawn_id`=14247; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=552.054, `position_y`=-2817.32, `position_z`=92.3576, `orientation`=0.704734 WHERE `spawn_id`=14189; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=580.297, `position_y`=-2824.99, `position_z`=91.7916, `orientation`=2.10103 WHERE `spawn_id`=14150; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=593.562, `position_y`=-2869.37, `position_z`=91.7916, `orientation`=1.38075 WHERE `spawn_id`=14160; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=582.606, `position_y`=-2848.97, `position_z`=91.7916, `orientation`=4.09633 WHERE `spawn_id`=14149; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=612.303, `position_y`=-2934.28, `position_z`=91.7917, `orientation`=1.38665 WHERE `spawn_id`=14170; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=1057.82, `position_y`=-3093.22, `position_z`=105.541, `orientation`=0.259788 WHERE `spawn_id`=20781; -- Venture Co. Drudger
        UPDATE `spawns_creatures` SET `position_x`=1035.57, `position_y`=-3050.69, `position_z`=98.7341, `orientation`=1.40499 WHERE `spawn_id`=20721; -- Venture Co. Mercenary
        UPDATE `spawns_creatures` SET `position_x`=1062.22, `position_y`=-3083.49, `position_z`=105.125, `orientation`=2.19788 WHERE `spawn_id`=20725; -- Venture Co. Mercenary
        UPDATE `spawns_creatures` SET `position_x`=-336.908, `position_y`=-1693.9, `position_z`=92.2039, `orientation`=0.300988 WHERE `spawn_id`=14209; -- Savannah Prowler
        UPDATE `spawns_creatures` SET `position_x`=-555.068, `position_y`=-2966.62, `position_z`=91.7917, `orientation`=5.21747 WHERE `spawn_id`=14391; -- Tarban Hearthgrain
        UPDATE `spawns_creatures` SET `position_x`=6496.8, `position_y`=-3139.72, `position_z`=571.407, `orientation`=5.47776 WHERE `spawn_id`=41054; -- Winterfall Totemic
        UPDATE `spawns_creatures` SET `position_x`=-911.451, `position_y`=-2942.63, `position_z`=91.7917, `orientation`=3.46554 WHERE `spawn_id`=20452; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-1186.66, `position_y`=-2001.55, `position_z`=91.7917, `orientation`=5.27057 WHERE `spawn_id`=20481; -- Kolkar Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-5395.75, `position_y`=1274.43, `position_z`=23.4646, `orientation`=3.32269 WHERE `spawn_id`=50319; -- Gordunni Warlord
        UPDATE `spawns_creatures` SET `position_x`=-1782.99, `position_y`=944.433, `position_z`=92.7692, `orientation`=3.77525 WHERE `spawn_id`=27122; -- Magram Marauder
        UPDATE `spawns_creatures` SET `position_x`=-1900.14, `position_y`=987.388, `position_z`=90.6667, `orientation`=3.64268 WHERE `spawn_id`=27126; -- Magram Mauler
        UPDATE `spawns_creatures` SET `position_x`=-1896.35, `position_y`=1100, `position_z`=92.7145, `orientation`=5.72359 WHERE `spawn_id`=27125; -- Magram Mauler
        UPDATE `spawns_creatures` SET `position_x`=-1801.12, `position_y`=1061.07, `position_z`=91.551, `orientation`=4.96538 WHERE `spawn_id`=27120; -- Magram Marauder
        UPDATE `spawns_creatures` SET `position_x`=-4754.93, `position_y`=-2109.96, `position_z`=83.3396, `orientation`=1.26237 WHERE `spawn_id`=21587; -- Arnak Grimtotem
        UPDATE `spawns_creatures` SET `position_x`=-5080.97, `position_y`=-2211.98, `position_z`=-54.8923, `orientation`=3.88134 WHERE `spawn_id`=21713; -- Galak Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-5066.2, `position_y`=-2297.94, `position_z`=-53.2635, `orientation`=1.33411 WHERE `spawn_id`=21719; -- Galak Wrangler
        UPDATE `spawns_creatures` SET `position_x`=-5165.93, `position_y`=-2411.71, `position_z`=-49.2905, `orientation`=4.22394 WHERE `spawn_id`=20999; -- Galak Windchaser
        UPDATE `spawns_creatures` SET `position_x`=-5199.06, `position_y`=-2418.99, `position_z`=-37.9507, `orientation`=2.38575 WHERE `spawn_id`=20997; -- Galak Windchaser
        UPDATE `spawns_creatures` SET `position_x`=-34.5716, `position_y`=1204.3, `position_z`=98.7365, `orientation`=4.40914 WHERE `spawn_id`=29122; -- Nijel's Point Guard
        UPDATE `spawns_creatures` SET `position_x`=1707.35, `position_y`=-2195.61, `position_z`=62.663, `orientation`=1.37721 WHERE `spawn_id`=48380; -- Wailing Death
        UPDATE `spawns_creatures` SET `position_x`=1749.96, `position_y`=-2330.26, `position_z`=59.7745, `orientation`=5.75488 WHERE `spawn_id`=46275; -- Haunting Vision
        UPDATE `spawns_creatures` SET `position_x`=1755.15, `position_y`=-2336.45, `position_z`=59.8217, `orientation`=3.89093 WHERE `spawn_id`=45306; -- Wailing Death
        UPDATE `spawns_creatures` SET `position_x`=-7596.23, `position_y`=-4584.71, `position_z`=9.13502, `orientation`=3.76207 WHERE `spawn_id`=23491; -- Wastewander Rogue
        UPDATE `spawns_creatures` SET `position_x`=1561.27, `position_y`=-1449.63, `position_z`=68.3028, `orientation`=3.80046 WHERE `spawn_id`=52257; -- Searing Ghoul
        UPDATE `spawns_creatures` SET `position_x`=-28.0891, `position_y`=-551.84, `position_z`=151.23, `orientation`=1.9258 WHERE `spawn_id`=17387; -- Syndicate Footpad
        UPDATE `spawns_creatures` SET `position_x`=-15.3858, `position_y`=-554.598, `position_z`=151.853, `orientation`=5.28572 WHERE `spawn_id`=17549; -- Syndicate Footpad
        UPDATE `spawns_creatures` SET `position_x`=-436.629, `position_y`=-1419.2, `position_z`=101.858, `orientation`=0.239829 WHERE `spawn_id`=16024; -- Syndicate Shadow Mage
        UPDATE `spawns_creatures` SET `position_x`=-502.003, `position_y`=-1350.05, `position_z`=53.6966, `orientation`=2.12663 WHERE `spawn_id`=16107; -- Syndicate Rogue
        UPDATE `spawns_creatures` SET `position_x`=-598.399, `position_y`=-1473.32, `position_z`=53.7535, `orientation`=6.14599 WHERE `spawn_id`=16029; -- Syndicate Watchman
        UPDATE `spawns_creatures` SET `position_x`=-3790.24, `position_y`=-857.93, `position_z`=11.5981, `orientation`=2.83579 WHERE `spawn_id`=9527; -- Murndan Derth
        UPDATE `spawns_creatures` SET `position_x`=-3840.25, `position_y`=-837.344, `position_z`=16.9484, `orientation`=3.25592 WHERE `spawn_id`=9519; -- Fremal Doohickey
        UPDATE `spawns_creatures` SET `position_x`=-3816.05, `position_y`=-831.402, `position_z`=9.4674, `orientation`=4.71071 WHERE `spawn_id`=9535; -- Hargin Mundar
        UPDATE `spawns_creatures` SET `position_x`=-3804.59, `position_y`=-826.894, `position_z`=10.1774, `orientation`=2.30383 WHERE `spawn_id`=90281; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=-3775.48, `position_y`=-825.607, `position_z`=11.8737, `orientation`=4.15097 WHERE `spawn_id`=9555; -- Menethil Sentry
        UPDATE `spawns_creatures` SET `position_x`=-3791.88, `position_y`=-840.344, `position_z`=9.97075, `orientation`=2.21175 WHERE `spawn_id`=9446; -- First Mate Fitzsimmons
        UPDATE `spawns_creatures` SET `position_x`=-3744.08, `position_y`=-759.344, `position_z`=9.63053, `orientation`=4.0045 WHERE `spawn_id`=9561; -- Menethil Sentry
        UPDATE `spawns_creatures` SET `position_x`=-3762.36, `position_y`=-733.714, `position_z`=8.04999, `orientation`=4.1978 WHERE `spawn_id`=9504; -- Karl Boran
        UPDATE `spawns_creatures` SET `position_x`=-3756.07, `position_y`=-721.423, `position_z`=8.18982, `orientation`=4.02539 WHERE `spawn_id`=9562; -- Stuart Fleming
        UPDATE `spawns_creatures` SET `position_x`=83.5659, `position_y`=461.148, `position_z`=43.5036, `orientation`=1.97544 WHERE `spawn_id`=16859; -- Dalaran Summoner
        UPDATE `spawns_creatures` SET `position_x`=-53.0722, `position_y`=284.927, `position_z`=66.0425, `orientation`=3.51175 WHERE `spawn_id`=17313; -- Kegan Darkmar
        UPDATE `spawns_creatures` SET `position_x`=-2910.48, `position_y`=-2571.71, `position_z`=33.953, `orientation`=0.470365 WHERE `spawn_id`=10563; -- Mosshide Fenrunner
        UPDATE `spawns_creatures` SET `position_x`=-3646.35, `position_y`=-2610.42, `position_z`=52.0236, `orientation`=5.23397 WHERE `spawn_id`=9790; -- Dragonmaw Shadowwarder
        UPDATE `spawns_creatures` SET `position_x`=-3654.72, `position_y`=-2602.44, `position_z`=52.0236, `orientation`=4.44534 WHERE `spawn_id`=10581; -- Chieftain Nek'rosh
        UPDATE `spawns_creatures` SET `position_x`=-4709.5, `position_y`=-3077.39, `position_z`=309.185, `orientation`=0.849965 WHERE `spawn_id`=9314; -- Tunnel Rat Kobold
        UPDATE `spawns_creatures` SET `position_x`=-6572.92, `position_y`=-2558.33, `position_z`=291.573, `orientation`=1.07734 WHERE `spawn_id`=7858; -- Lesser Rock Elemental
        UPDATE `spawns_creatures` SET `position_x`=1772.56, `position_y`=675.448, `position_z`=43.9964, `orientation`=2.95356 WHERE `spawn_id`=44874; -- Scarlet Zealot
        UPDATE `spawns_creatures` SET `position_x`=1481.84, `position_y`=-1417.99, `position_z`=67.7724, `orientation`=4.6511 WHERE `spawn_id`=49619; -- Skeletal Warlord
        UPDATE `spawns_creatures` SET `position_x`=-5350, `position_y`=-2981.25, `position_z`=323.999, `orientation`=3.54212 WHERE `spawn_id`=8736; -- Mountaineer Langarr
        UPDATE `spawns_creatures` SET `position_x`=-5348.27, `position_y`=-2961.9, `position_z`=323.761, `orientation`=3.5221 WHERE `spawn_id`=8745; -- Mountaineer Ozmok
        UPDATE `spawns_creatures` SET `position_x`=1151.55, `position_y`=-763.216, `position_z`=-139.682, `orientation`=1.56238 WHERE `spawn_id`=56720; -- Firelord
        UPDATE `spawns_creatures` SET `position_x`=684.124, `position_y`=-495.074, `position_z`=-213.798, `orientation`=2.28459 WHERE `spawn_id`=56622; -- Firesworn
        UPDATE `spawns_creatures` SET `position_x`=688.943, `position_y`=-508.177, `position_z`=-214.46, `orientation`=4.83456 WHERE `spawn_id`=56627; -- Firesworn
        UPDATE `spawns_creatures` SET `position_x`=643.798, `position_y`=-794.985, `position_z`=-208.605, `orientation`=0.976866 WHERE `spawn_id`=91262; -- Lava Elemental
        UPDATE `spawns_creatures` SET `position_x`=600.711, `position_y`=-1108.11, `position_z`=-200.32, `orientation`=3.08242 WHERE `spawn_id`=91259; -- Flameguard
        UPDATE `spawns_creatures` SET `position_x`=-9175.12, `position_y`=-2452.08, `position_z`=118.18, `orientation`=3.08051 WHERE `spawn_id`=31811; -- Blackrock Grunt
        UPDATE `spawns_creatures` SET `position_x`=-9204.5, `position_y`=-2149.08, `position_z`=64.3446, `orientation`=4.6691 WHERE `spawn_id`=6276; -- Gloria Femmel
        UPDATE `spawns_creatures` SET `position_x`=-10506.2, `position_y`=1066.89, `position_z`=55.2721, `orientation`=2.6529 WHERE `spawn_id`=89537; -- Protector Bialon
        UPDATE `spawns_creatures` SET `position_x`=-10929.7, `position_y`=-925.137, `position_z`=72.1258, `orientation`=1.24738 WHERE `spawn_id`=4331; -- Nightbane Dark Runner
        UPDATE `spawns_creatures` SET `position_x`=-10935.5, `position_y`=-933.433, `position_z`=72.1258, `orientation`=3.78396 WHERE `spawn_id`=4300; -- Nightbane Dark Runner
        UPDATE `spawns_creatures` SET `position_x`=-10926.8, `position_y`=-937.832, `position_z`=72.1169, `orientation`=1.33384 WHERE `spawn_id`=4298; -- Nightbane Dark Runner
        UPDATE `spawns_creatures` SET `position_x`=-11102.5, `position_y`=-536.276, `position_z`=33.2065, `orientation`=5.0641 WHERE `spawn_id`=4877; -- Defias Night Blade
        UPDATE `spawns_creatures` SET `position_x`=-11956.1, `position_y`=-490.749, `position_z`=30.4711, `orientation`=5.47399 WHERE `spawn_id`=2204; -- Venture Co. Mechanic
        UPDATE `spawns_creatures` SET `position_x`=-11981.1, `position_y`=-488.592, `position_z`=24.1556, `orientation`=0.0734131 WHERE `spawn_id`=2207; -- Venture Co. Geologist
        UPDATE `spawns_creatures` SET `position_x`=-11964.4, `position_y`=-470.048, `position_z`=17.1005, `orientation`=3.99502 WHERE `spawn_id`=2193; -- Venture Co. Mechanic
        UPDATE `spawns_creatures` SET `position_x`=-11958.1, `position_y`=-483.815, `position_z`=17.0796, `orientation`=0.729954 WHERE `spawn_id`=1846; -- Venture Co. Geologist
        UPDATE `spawns_creatures` SET `position_x`=-14461.9, `position_y`=491.803, `position_z`=15.2063, `orientation`=0.837758 WHERE `spawn_id`=89380; -- Winter Reveler
        UPDATE `spawns_creatures` SET `position_x`=1801.05, `position_y`=720.193, `position_z`=48.9875, `orientation`=3.2828 WHERE `spawn_id`=44582; -- Scarlet Zealot
        UPDATE `spawns_creatures` SET `position_x`=1311.86, `position_y`=-1609.57, `position_z`=62.1422, `orientation`=3.41361 WHERE `spawn_id`=45234; -- Skeletal Acolyte
        UPDATE `spawns_creatures` SET `position_x`=-1239.67, `position_y`=-2512.96, `position_z`=22.2189, `orientation`=3.70311 WHERE `spawn_id`=11263; -- Cedrik Prose
        UPDATE `spawns_creatures` SET `position_x`=258.417, `position_y`=-2009.81, `position_z`=178.211, `orientation`=4.24115 WHERE `spawn_id`=92918; -- Wildhammer Sentry
        UPDATE `spawns_creatures` SET `position_x`=271.739, `position_y`=-2176.42, `position_z`=120.052, `orientation`=1.69297 WHERE `spawn_id`=92917; -- Wildhammer Sentry
        UPDATE `spawns_creatures` SET `position_x`=-227.611, `position_y`=-4181.29, `position_z`=120.924, `orientation`=4.49118 WHERE `spawn_id`=93601; -- Vilebranch Witch Doctor

        UPDATE `spawns_creatures` SET `position_x`=-11897.9, `position_y`=-1364.58, `position_z`=70.1878, `orientation`=2.65936 WHERE `spawn_id`=49118; -- Razzashi Serpent
        UPDATE `spawns_creatures` SET `position_x`=-11951.1, `position_y`=-1072.8, `position_z`=92.8555, `orientation`=3.24016 WHERE `spawn_id`=556; -- Hakkari Oracle
        UPDATE `spawns_creatures` SET `position_x`=-11950.2, `position_y`=-1021.91, `position_z`=67.7891, `orientation`=3.34362 WHERE `spawn_id`=729; -- Gurubashi Warrior

        UPDATE `spawns_creatures` SET `position_x`=-11932.9, `position_y`=-1329.52, `position_z`=79.1473, `orientation`=3.6878 WHERE `spawn_id`=49739; -- Razzashi Adder
        UPDATE `spawns_creatures` SET `position_x`=-11925.8, `position_y`=-1336.62, `position_z`=78.6494, `orientation`=1.17943 WHERE `spawn_id`=49740; -- Razzashi Adder
        UPDATE `spawns_creatures` SET `position_x`=-11881.1, `position_y`=-1025.17, `position_z`=70.2129, `orientation`=4.24045 WHERE `spawn_id`=732; -- Hakkari Oracle
        UPDATE `spawns_creatures` SET `position_x`=-11847.9, `position_y`=-988.341, `position_z`=70.005, `orientation`=6.12404 WHERE `spawn_id`=747; -- Gurubashi Warrior
        UPDATE `spawns_creatures` SET `position_x`=-11882.3, `position_y`=-1015.74, `position_z`=69.5822, `orientation`=1.10973 WHERE `spawn_id`=731; -- Gurubashi Warrior
        UPDATE `spawns_creatures` SET `position_x`=-11977.7, `position_y`=-1465.34, `position_z`=80.0486, `orientation`=5.11326 WHERE `spawn_id`=49191; -- Bloodseeker Bat
        UPDATE `spawns_creatures` SET `position_x`=-11766.1, `position_y`=-1580.68, `position_z`=21.17, `orientation`=1.1063 WHERE `spawn_id`=51395; -- Gurubashi Berserker
        UPDATE `spawns_creatures` SET `position_x`=-12051.5, `position_y`=-1427.27, `position_z`=130.142, `orientation`=1.19443 WHERE `spawn_id`=49143; -- Bloodseeker Bat
        UPDATE `spawns_creatures` SET `position_x`=1496.24, `position_y`=-4805.26, `position_z`=10.0924, `orientation`=4.51881 WHERE `spawn_id`=7337; -- Burning Blade Fanatic

        UPDATE `spawns_creatures` SET `position_x`=-7027.99, `position_y`=-1713.85, `position_z`=241.75, `orientation`=6.26573 WHERE `spawn_id`=6806; -- Dark Iron Watchman
        UPDATE `spawns_creatures` SET `position_x`=-7026.23, `position_y`=-1723.19, `position_z`=241.764, `orientation`=3.69127 WHERE `spawn_id`=6799; -- Dark Iron Geologist
        UPDATE `spawns_creatures` SET `position_x`=-7573.89, `position_y`=-1035.25, `position_z`=449.248, `orientation`=3.76991 WHERE `spawn_id`=84387; -- Broodlord Lashlayer
        UPDATE `spawns_creatures` SET `position_x`=-7504.52, `position_y`=-1043.61, `position_z`=449.325, `orientation`=5.84685 WHERE `spawn_id`=84555; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7547.72, `position_y`=-1014.95, `position_z`=449.325, `orientation`=2.11185 WHERE `spawn_id`=84535; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7547.72, `position_y`=-1014.95, `position_z`=449.325, `orientation`=2.11185 WHERE `spawn_id`=84539; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7471.38, `position_y`=-988.328, `position_z`=449.845, `orientation`=5.53269 WHERE `spawn_id`=84590; -- Death Talon Overseer
        UPDATE `spawns_creatures` SET `position_x`=-7461.63, `position_y`=-985.513, `position_z`=449.782, `orientation`=4.13643 WHERE `spawn_id`=84591; -- Death Talon Overseer
        UPDATE `spawns_creatures` SET `position_x`=-7453.04, `position_y`=-954.129, `position_z`=465.067, `orientation`=3.61283 WHERE `spawn_id`=300983; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7435.87, `position_y`=-1052.21, `position_z`=477.018, `orientation`=0.750492 WHERE `spawn_id`=84639; -- Death Talon Wyrmguard
        UPDATE `spawns_creatures` SET `position_x`=-7405.67, `position_y`=-964.438, `position_z`=465.031, `orientation`=2.00713 WHERE `spawn_id`=84635; -- Death Talon Wyrmguard
        UPDATE `spawns_creatures` SET `position_x`=-7398.46, `position_y`=-967.079, `position_z`=465.055, `orientation`=3.89208 WHERE `spawn_id`=84627; -- Master Elemental Shaper Krixix
        UPDATE `spawns_creatures` SET `position_x`=-7396.24, `position_y`=-961.435, `position_z`=465.044, `orientation`=2.25148 WHERE `spawn_id`=84634; -- Death Talon Wyrmguard
        UPDATE `spawns_creatures` SET `position_x`=-7388.2, `position_y`=-955.983, `position_z`=465.047, `orientation`=2.33874 WHERE `spawn_id`=84628; -- Death Talon Wyrmguard
        UPDATE `spawns_creatures` SET `position_x`=-7408.65, `position_y`=-917.047, `position_z`=465.067, `orientation`=0.418879 WHERE `spawn_id`=85612; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7523.28, `position_y`=-1060.82, `position_z`=449.325, `orientation`=4.72984 WHERE `spawn_id`=84547; -- Blackwing Technician

        UPDATE `spawns_creatures` SET `position_x`=-7551.43, `position_y`=-1040.67, `position_z`=449.325, `orientation`=3.08923 WHERE `spawn_id`=300986; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7513.05, `position_y`=-1051.5, `position_z`=449.325, `orientation`=5.53269 WHERE `spawn_id`=84550; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7527.01, `position_y`=-967.031, `position_z`=449.325, `orientation`=1.90241 WHERE `spawn_id`=84563; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7459.26, `position_y`=-995.384, `position_z`=449.784, `orientation`=2.3911 WHERE `spawn_id`=84589; -- Death Talon Overseer
        UPDATE `spawns_creatures` SET `position_x`=-7524.24, `position_y`=-916.833, `position_z`=457.659, `orientation`=1.85005 WHERE `spawn_id`=84606; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7571.69, `position_y`=-1088.25, `position_z`=413.465, `orientation`=2.16421 WHERE `spawn_id`=84388; -- Razorgore the Untamed
        UPDATE `spawns_creatures` SET `position_x`=-7419.28, `position_y`=-895.444, `position_z`=465.067, `orientation`=0.907571 WHERE `spawn_id`=85625; -- Blackwing Technician
        UPDATE `spawns_creatures` SET `position_x`=-7453.61, `position_y`=-860.511, `position_z`=465.067, `orientation`=1.22173 WHERE `spawn_id`=84762; -- Blackwing Technician

        insert into applied_updates values ('170520201');
    end if;

    -- 18/05/2020 1
    if (select count(*) from applied_updates where id='180520201') = 0 then
        update page_text set text = replace(text, '$g himself : herself', '$g himself : herself;') where entry = 63;

        insert into applied_updates values ('180520201');
    end if;
end $
delimiter ;