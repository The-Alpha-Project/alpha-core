delimiter $
begin not atomic
    -- 26/09/2019 2
    if (select count(*) from applied_updates where id='260920192') = 0 then
        update item_template set display_id = 926 where entry = 8766;
        update item_template set display_id = 2209 where entry = 17184;

        insert into applied_updates values('260920192');
    end if;

    -- 26/09/2019 3
    if (select count(*) from applied_updates where id='260920193') = 0 then
        update item_template set display_id = 6639 where entry = 6276;
        update item_template set display_id = 2702 where entry = 2481;
        update item_template set display_id = 2380 where entry = 2128;
        update item_template set display_id = 8479 where entry = 2482;
        update item_template set display_id = 8515 where entry = 2483;
        update item_template set display_id = 5219 where entry = 2485;
        update item_template set display_id = 4423 where entry = 2486;
        update item_template set display_id = 2388 where entry = 2487;
        update item_template set display_id = 8479 where entry = 2398;
        update item_template set display_id = 2398 where entry = 2496;
        update item_template set display_id = 2404 where entry = 2503;
        update item_template set display_id = 8576 where entry = 2500;
        update item_template set display_id = 6444 where entry = 2502;
        update item_template set display_id = 2399 where entry = 2497;
        update item_template set display_id = 7414 where entry = 6216;
        update item_template set display_id = 8687 where entry = 2501;

        update item_template set name='Forsaken Mace', display_id = 5206 where entry = 3269;
        update item_template set name='Runic Cloth Cloak', armor=25, display_id = 4613, quality=2, buy_price=1012, sell_price=22, required_level=10, item_level = 15, stat_type1=6, stat_value1=1 where entry = 4686;
        update item_template set display_id = 6639 where entry = 6276;
        update item_template set name='Inscribed Leather Cloak', buy_price=1579, sell_price=315, stat_type1=1, stat_value1=10, armor=50, display_id = 8792 where entry = 4701;
        update item_template set name='Runic Cloth Belt', buy_price=677, sell_price=135, stat_type1=5, stat_value1=1, required_level=10, item_level=15 where entry = 4687;
        update item_template set name='Runic Cloth Gloves', display_id=11423, required_level=11, buy_price=829, sell_price=165, stat_type1=5, stat_value1=1, stat_type2=3, stat_value2=1, stat_type3=0, stat_value3=0, armor=20 where entry = 3308;
        update item_template set name='Buckled Cloth Trousers', display_id=3731, armor=12 where entry=3834;
        update item_template set armor=257, block=6, stat_type1=4, stat_value1=1, stat_type2=7, stat_value2=2, required_level=12, item_level=16, display_id=3931, buy_price=2911, sell_price=582 where entry = 3654;
        update item_template set name='Sturdy Flail', display_id=5197 where entry = 852;
        update item_template set display_id=2632, armor=114, block=2, required_level=5, item_level=10, sell_price=88, buy_price=342 where entry = 3650;
        update item_template set display_id=11424, name='Runic Cloth Bracers', item_level=16, required_level=12, armor=18, buy_price=566, sell_price=113, armor=18 where entry = 3644;
        update item_template set name='Runic Cloth Vest', display_id=11419, armor=33, item_level=15, required_level=10, buy_price=1454, sell_price=290, stat_type1=7, stat_value1=1, stat_type2=6, stat_value2=3 where entry = 3310;
        update item_template set name='Large Broad Axe', display_id=8524 where entry = 1196;

        insert into applied_updates values('260920193');
    end if;

    -- 28/09/2019 1
    if (select count(*) from applied_updates where id='280920191') = 0 then
        update creatures set display_id2 = 0 where display_id2 = 5446;
        update creatures set display_id2 = 0 where display_id2 = 3258;
        update creatures set display_id2 = 0 where display_id2 = 3257;
        update creatures set display_id1 = 2361 where entry = 94;

        update creatures set display_id1 = 5035 where entry = 38;
        update creatures set display_id1 = 4418 where entry = 95;
        update creatures set display_id1 = 2357 where entry = 116;
        update creatures set display_id1 = 2344 where entry = 449;
        update creatures set display_id1 = 4420 where entry = 450;
        update creatures set display_id1 = 2359 where entry = 474;
        update creatures set display_id1 = 2333 where entry = 481;
        update creatures set display_id1 = 2331 where entry = 504;
        update creatures set display_id1 = 308 where entry = 598;
        update creatures set display_id1 = 2329 where entry = 619;
        update creatures set display_id1 = 2316 where entry = 634;
        update creatures set display_id1 = 2441 where entry = 824;
        update creatures set display_id1 = 2677 where entry = 1434;
        update creatures set display_id1 = 2318 where entry = 1729;
        update creatures set display_id1 = 4017 where entry = 2588;
        update creatures set display_id1 = 1451 where entry = 2972;
        update creatures set display_id1 = 4602 where entry = 3296;
        update creatures set display_id1 = 4849 where entry = 3571;
        update creatures set display_id1 = 1141 where entry = 4075;
        update creatures set display_id1 = 2989 where entry = 4995;
        update creatures set display_id1 = 2985 where entry = 4996;
        update creatures set display_id1 = 6926 where entry = 5568;
        update creatures set display_id1 = 2357 where entry = 6927;


        insert into applied_updates values('280920191');
    end if;

    -- 01/10/2019 1
    if (select count(*) from applied_updates where id='011020191') = 0 then
        update creatures set npc_flags = 0 where npc_flags = 65;
        update quests set ReqCreatureOrGOCount1=5, ReqCreatureOrGOCount2=3, objectives='Shadow Priest Sarvis wants you to kill 5 Mindless Zombies and 3 Wretched Zombies.', rewchoiceitemid2=0, rewchoiceitemcount2=0 where entry = 364;
        update creatures set display_id1 = 1196 where display_id1 = 10973;
        update creatures set display_id1 = 1197 where display_id1 = 10979;
        update creatures set display_id1 = 201 where display_id1 = 11400;
        update quests set reqitemcount1=4, reqitemcount2=4, objectives=replace(objectives, '6', '4'), details=replace(details, 'south', 'west') where entry = 376;
        update quests set details=replace(details, 'inside the abbey behind me', 'next to me') where entry = 783;

        insert into applied_updates values('011020191');
    end if;

    -- 30/12/2019 1
    if (select count(*) from applied_updates where id='301220191') = 0 then
        delete from playercreateinfo_spell where Spell = 2479;
        insert into playercreateinfo_spell (race, class, Spell, Note) values
        (3, 8, 20594, 'Stoneform'),
        (3, 8, 20595, 'Gun Specialization'),
        (3, 8, 20596, 'Frost Resistance'),
        (3, 8, 21651, 'Opening'),
        (3, 8, 21652, 'Closing'),
        (3, 8, 22027, 'Remove Insignia'),
        (3, 8, 22810, 'Opening - No Text'),

        (3, 8, 81, 'Dodge'),
        (3, 8, 133, 'Fireball'),
        (3, 8, 168, 'Frost Armor'),
        (3, 8, 203, 'Unarmed'),
        (3, 8, 204, 'Defense'),
        (3, 8, 227, 'Staves'),
        (3, 8, 522, 'SPELLDFENSE (DND)'),
        (3, 8, 668, 'Language Common'),
        (3, 8, 672, 'Language Dwarven'),
        (3, 8, 2382, 'Generic'),
        (3, 8, 3050, 'Detect'),
        (3, 8, 3365, 'Opening'),
        (3, 8, 5009, 'Wands'),
        (3, 8, 5019, 'Shoot'),
        (3, 8, 6233, 'Closing'),
        (3, 8, 6246, 'Closing'),
        (3, 8, 6247, 'Opening'),
        (3, 8, 6477, 'Opening'),
        (3, 8, 6478, 'Opening'),
        (3, 8, 6603, 'Attack'),
        (3, 8, 7266, 'Duel'),
        (3, 8, 7267, 'Grovel'),
        (3, 8, 7355, 'Stuck'),
        (3, 8, 8386, 'Attacking'),
        (3, 8, 9078, 'Cloth'),
        (3, 8, 9125, 'Generic');

        insert into applied_updates values('301220191');
    end if;

    -- 29/02/2020 1
    if (select count(*) from applied_updates where id='29022021') = 0 then
        update item_template set subclass = 5 where subclass = 6 and name like '%buckler%';

        insert into applied_updates values('29022021');
    end if;

    -- 29/02/2020 2
    if (select count(*) from applied_updates where id='29022022') = 0 then
        replace into page_text (entry, text) values (691, 'If you are reading this note, then you survived the ordeal of undeath and have returned to us to join the ranks of the Forsaken.   This new life is viewed by many as more of a curse than a blessing, but make of it what you will.$B$BWhen you are ready for more training in the path of arcane magics, then I will show you what you need to know.  You will find me in the old church in Deathknell.$B$B   -Isabella, Mage Trainer.');

        insert into applied_updates values('29022022');
    end if;

    -- 2/03/2020 1
    if (select count(*) from applied_updates where id='02032021') = 0 then
        update item_template set display_id = 11160 where entry = 6277;
        update item_template set display_id = 11161 where entry = 6278;
        update item_template set display_id = 3093 where entry = 6279;
        update item_template set display_id = 3093 where entry = 6280;

        insert into applied_updates values('02032021');
    end if;

    -- 16/03/2020 1
    if (select count(*) from applied_updates where id='16032021') = 0 then
        replace into page_text (entry, text) values (692, 'You led a quiet life of love and good deeds.   You gave to the poor, cured the sick, and comforted the dying.   You waited with joyful certain, secure in the belief that you would be granted an afterlife of everlasting peace.$B$BYou were betrayed.$B$BI cannot offer you comfort.   Revenge, on the other hand, is well within my power.   Come to the old church in Deathknell, and I will teach you how to inflict deadly damage through the very faith you were taught.$B$B   -Dark Cleric Duesten, Priest Trainer.');
        replace into page_text (entry, text) values (693, 'Revel in your new state of undeath, and wield your powers to cleanse the world of those who would see us eradicated.   Although our enemies are legion, we will destroy them with flame and shadow.$B$BWhen you are ready for me to teach you the ways of darkness and summoning you will find me in the old Deathknell church.$B$B   -Maximillion, Warlock Trainer.');
        replace into page_text (entry, text) values (694, 'Get your bones up and out of that crypt; there''s work to be done!   The Scarlet Crusade moves swiftly against our people, and other humans kill us whenever they can.   We have need of your sword.$B$BWhen you want to learn more of weapons, come find me in the ruined tavern in Deathknell.   I will teach you.$B$B   -Dannal Stern, Warrior Trainer.');
        replace into page_text (entry, text) values (695, 'Don''t get all weepy about being undead and losing your family and all that rot.   You live, and that''s what matters.   Even though you are now undead, possession is still nine tenths of the law.   Sneak past your enemies, or kill them and take what they had.$B$BI can teach you what you need to know about deadly strikes and stealth.   Come look for me in the ruined tavern in Deathknell.$B$B   -David Trias, Rogue Trainer.');

        insert into applied_updates values('16032021');
    end if;

    -- 07/04/2020 1
    if (select count(*) from applied_updates where id='07042021') = 0 then
        update item_template set name = 'Primitive Leather Belt' where entry = 152;

        update item_template set name = 'Brawler\'s Pants', display_id = 9988 where entry = 139;
        update item_template set name = 'Shortsword of Vengeance', display_id = 8276 where entry = 754;
        update item_template set name = 'Heavy Weave Shoes', display_id = 3757 where entry = 840;
        update item_template set name = 'Chainmail Armor', display_id = 1019 where entry = 847;
        update item_template set name = 'Chainmail Pants', display_id = 697 where entry = 848;
        update item_template set name = 'Libram: Resurrection', display_id = 1155 where entry = 1146;
        update item_template set name = 'Frayed Shoes', display_id = 4143 where entry = 1374;
        update item_template set name = 'Rusty Hatchet', display_id = 8495 where entry = 1416;
        update item_template set name = 'Patchwork Shoes', display_id = 4143 where entry = 1427;
        update item_template set name = 'Calico Shoes', display_id = 3757 where entry = 1495;
        update item_template set name = 'Tanglewood Staff', display_id = 2840 where entry = 1720;
        update item_template set name = 'Mithril Warhammer', display_id = 8581 where entry = 1721;
        update item_template set name = 'Dusty Chain Armor', display_id = 1727 where entry = 2016;
        update item_template set name = 'Rustic Belt', display_id = 9895 where entry = 2172;
        update item_template set name = 'Spirit Claws of the Bear', display_id = 4485 where entry = 2564;
        update item_template set name = 'Flimsy Chain Vest', display_id = 2215 where entry = 2656;
        update item_template set name = 'Copper Chain Pants', display_id = 4333 where entry = 2852;
        update item_template set name = 'Copper Bracers', display_id = 6966 where entry = 2853;
        update item_template set name = 'Tomb Rot', display_id = 7414 where entry = 2929;
        update item_template set name = 'Torment Vine', display_id = 7415 where entry = 2932;
        update item_template set name = 'Wicked Dagger', display_id = 6349 where entry = 3222;
        update item_template set name = 'Webbed Pants', display_id = 3432 where entry = 3263;
        update item_template set name = 'Executor Staff', display_id = 3405 where entry = 3277;
        update item_template set name = 'Warrior\'s Buckler', display_id = 2632 where entry = 3648;
        update item_template set name = 'Double-stitched Woolen Shoulders', display_id = 9997 where entry = 4314;
        update item_template set name = 'Flint and Tinder', display_id = 4720 where entry = 4471;
        update item_template set name = 'Ruined Pelt', display_id = 7086 where entry = 4865;
        update item_template set name = 'Coral Band', display_id = 9835 where entry = 5000;
        update item_template set name = 'Mark of the Kirin Tor', display_id = 9857 where entry = 5004;
        update item_template set name = 'Inscribed Gold Ring', display_id = 3453 where entry = 5010;
        update item_template set name = 'Small Spider Eye', display_id = 7986 where entry = 5465;
        update item_template set name = 'Sacred Burial Trousers', display_id = 11166 where entry = 6282;
        update item_template set name = 'Formula: Enchant Boots - Minor Stamina', display_id = 11431 where entry = 6376;
        update item_template set name = 'Viridian Band', display_id = 9833 where entry = 6589;
        update item_template set name = 'Cerulean Ring', display_id = 9832 where entry = 7426;
        update item_template set name = 'Cerulean Talisman', display_id = 9853 where entry = 7427;
        update item_template set name = 'Vermilion Band', display_id = 9832 where entry = 7466;
        update item_template set name = 'Vermilion Necklace', display_id = 9853 where entry = 7467;
        update item_template set name = 'Ivory Band', display_id = 9850 where entry = 7497;

        insert into applied_updates values('07042021');
    end if;

    -- 07/04/2020 2
    if (select count(*) from applied_updates where id='07042022') = 0 then
        update item_template set name = 'Jagged Knife', display_id = 6442 where entry = 2484;
        update item_template set name = 'Battle Buckler', display_id = 2632 where entry = 3649;
        update item_template set name = 'Scroll of Spirit Armor', spellid_1 = 308 where entry = 3013;
        update item_template set name = 'Brackwater Buckler' where entry = 3653;

        insert into applied_updates values('07042022');
    end if;

    -- 09/04/2020 1 https://www.youtube.com/watch?v=WwhGBixG2_k
    if (select count(*) from applied_updates where id='09042021') = 0 then
        update quests set reqcreatureorgocount1 = 5, reqcreatureorgocount2 = 3, RewChoiceItemId2 = 0, RewChoiceItemCount2 = 0,
        RewOrReqMoney = 35, objectives = 'Kill 5 Young Nightsabers and 3 Young Thistle Boars and return to Conservator Ilthalaine.' where entry = 456;
        update item_template set armor = 7 where entry = 5394;

        update quests set reqcreatureorgocount1 = 4, reqcreatureorgocount2 = 4, RewOrReqMoney = 52,
        objectives = 'Conservator Ilthalaine needs you to kill 4 Mangy Nightsabers and 4 Thistle Boars.',
        RequestItemsText = 'Your task is not yet complete, $N. Return to me once 4 mangy nightsabers and 4 thistle boars have been killed.' where entry = 457;
        update item_template set armor = 4 where entry = 5405;

        update quests set details = replace(details, 'southwest', 'west') where entry = 458;
        update quests set details = replace(details, 'Look long the hills to where the peaceful furbolgs used to dwell.',
        'Look yonder to where the peaceful furbolgs used to dwell.'), objectives = replace(objectives, '8', '6'), RewChoiceItemId3 = 0,
        RewChoiceItemCount3 = 0, RequestItemsText = replace(RequestItemsText, '8', '6') where entry = 459;
        update item_template set armor = 12 where entry = 5399;
        update item_template set armor = 2 where entry = 3365;
        update item_template set armor = 1 where entry = 3363;
        update item_template set armor = 3 where entry = 1370;
        update item_template set armor = 1 where entry = 1378;
        update item_template set armor = 1 where entry = 6124;
        update item_template set armor = 10 where entry = 5398;

        update item_template set name = 'Initiate Staff', dmg_min1 = 8, dmg_max1 = 13 where entry = 2132;
        update item_template set name = 'Peasant Sword' where entry = 2131;
        update item_template set name = 'Simple Dagger' where entry = 2139;
        update item_template set name = 'Damaged Claymore' where entry = 1194;
        update item_template set name = 'Old Hand Axe' where entry = 2134;
        update item_template set name = 'Dull Broad Axe' where entry = 2479;
        update item_template set name = 'Short Cudgel' where entry = 2130;
        update item_template set name = 'Large Crooked Club' where entry = 2480;

        update quests set objectives = replace(details, '10', '5'), ReqItemCount1 = 5, RewChoiceItemId1 = 1386,
        RewChoiceItemId5 = 0, RewChoiceItemId6 = 0, RewChoiceItemCount5 = 0, RewChoiceItemCount6 = 0 where entry = 916;
        update item_template set armor = 9 where entry = 2652;
        update item_template set display_id = 5287 where entry = 5166;
        update item_template set armor = 4 where entry = 1369;
        update item_template set dmg_min1 = 8, dmg_max1 = 13 where entry = 5393;
        update item_template set dmg_min1 = 9, dmg_max1 = 15, display_id = 8516 where entry = 1386;

        update quests set RewChoiceItemId3 = 0, RewChoiceItemCount3 = 0 where entry = 917;
        update item_template set armor = 12 where entry = 4907;
        update item_template set armor = 19, block = 7, display_id = 1680 where entry = 5395;
        update item_template set armor = 2 where entry = 1366;
        update item_template set armor = 12 where entry = 2656;

        update creatures set level_min = 90, level_max = 90 where entry in (2041, 3468, 3469);
        update creatures set level_min = 70, level_max = 70 where entry in (4262, 3516);
        update creatures set level_min = 75, level_max = 75 where entry = 4423;
        update creatures set level_min = 35, level_max = 35, subname = 'Nightsaber Riding Instructor' where entry = 4753;
        update creatures set subname = 'Tiger Handler' where entry = 4730;

        insert into applied_updates values('09042021');
    end if;

    -- 11/04/2020 1
    if (select count(*) from applied_updates where id='11042021') = 0 then
        update creatures set display_id1 = 1560 where display_id1 = 4626;
        update creatures set display_id2 = 1560 where display_id2 = 4626;
        update creatures set display_id3 = 1560 where display_id3 = 4626;
        update creatures set display_id4 = 1560 where display_id4 = 4626;

        update creatures set display_id1 = 1534 where entry = 8208;

        insert into applied_updates values('11042021');
    end if;

    -- 12/04/2020 1
    if (select count(*) from applied_updates where id='12042021') = 0 then
        update creatures set display_id1 = 3831 where display_id1 = 10699;
        update creatures set display_id1 = 169 where entry in (89, 4676, 6073, 7135, 7136, 8608, 8616, 8680, 11437);

        insert into applied_updates values('12042021');
    end if;
end $
delimiter ;

