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
        INSERT INTO `spawns_creatures` VALUES (29884,1501,0,1196,0,1946.66,1470.27,76.7557,3.95143,120,10,0,42,0,0,1),(37869,1501,0,1196,0,1969,1611.12,88.1992,4.22559,120,2,0,42,0,0,1),(37871,1501,0,1196,0,1945.65,1455.6,73.3928,0.320091,120,10,0,42,0,0,1),(38331,1501,0,1196,0,1886.93,1455.56,78.448,0.274813,120,5,0,42,0,0,1),(41906,1501,0,1196,0,1905.06,1462.11,82.1722,5.87028,120,5,0,42,0,0,1),(41976,1501,0,1196,0,1963.58,1606.24,88.201,1.12033,120,3,0,42,0,0,1),(42014,1501,0,1196,0,1965.06,1610.41,83.4242,0.315183,120,0,0,42,0,0,0),(42016,1501,0,1196,0,1902.39,1491.73,89.1655,5.23592,120,0,0,42,0,0,0),(42048,1501,0,1196,0,1897.77,1493.79,93.9501,1.81434,120,2,0,42,0,0,1),(44641,1501,0,1196,0,1912.97,1516.68,87.0453,0.608325,120,5,0,42,0,0,1),(44680,1501,0,1196,0,1904.37,1645.94,90.5127,2.69251,120,5,0,42,0,0,1),(44686,1501,0,1196,0,1872.06,1503.12,87.9231,2.66062,120,5,0,42,0,0,1),(44695,1501,0,1196,0,1977.14,1647.29,75.3515,-1.24838,120,0,0,42,0,0,0),(44788,1501,0,1196,0,1940.97,1562.82,86.8106,-1.29707,120,0,0,42,0,0,0),(44801,1501,0,1196,0,1922.85,1593.8,84.4355,2.93639,120,10,0,42,0,0,1),(44818,1501,0,1196,0,1914.18,1533.72,86.9618,6.27027,120,5,0,42,0,0,1),(44823,1501,0,1196,0,1901.45,1524.82,87.7641,0.146859,120,10,0,42,0,0,1),(44827,1501,0,1196,0,1893.58,1540.56,88.2019,1.38298,120,5,0,42,0,0,1),(44830,1501,0,1196,0,1888.04,1520.42,88.1731,1.82163,120,10,0,42,0,0,2),(44926,1501,0,1196,0,1905.41,1601.54,86.3339,4.53082,120,5,0,42,0,0,1),(44930,1501,0,1196,0,1940.15,1629.43,80.1276,5.53251,120,10,0,42,0,0,1),(44935,1501,0,1196,0,1919.49,1623.68,85.5839,4.92853,120,5,0,42,0,0,1),(44936,1501,0,1196,0,1966.14,1636.96,78.0026,1.17677,120,10,0,42,0,0,1),(44941,1501,0,1196,0,1983.2,1641.61,76.1643,1.18989,120,5,0,42,0,0,1),(44942,1501,0,1196,0,1901.98,1571.76,89.0864,6.02667,120,0,0,42,0,0,0),(44961,1501,0,1196,0,1899.31,1547.72,89.1474,0.296706,120,0,0,42,0,0,0),(44974,1501,0,1196,0,1939.47,1571.19,83.0324,0,120,0,0,42,0,0,0),(44979,1501,0,1196,0,1920.66,1574.64,85.9355,3.70597,120,5,0,42,0,0,1),(29883,1502,0,1197,0,1853.81,1487.77,91.1091,1.3634,120,5,0,42,0,0,1),(37868,1502,0,1197,0,1976.31,1515.04,86.8198,6.13592,120,5,0,42,0,0,1),(37870,1502,0,1197,0,1965.1,1598.7,88.1981,3.6461,120,2,0,42,0,0,1),(38330,1502,0,1197,0,1952.19,1608.97,83.4339,0.955828,120,0,0,42,0,0,0),(41905,1502,0,1197,0,1973.7,1597.14,82.3567,3.85391,120,5,0,42,0,0,1),(41975,1502,0,1197,0,1903.94,1489.82,93.9509,1.08002,120,2,0,42,0,0,1),(42015,1502,0,1197,0,1913.02,1501.98,89.1851,1.12645,120,5,0,42,0,0,1),(42047,1502,0,1197,0,1903.63,1504.34,93.9357,6.1759,120,2,0,42,0,0,1),(42075,1502,0,1197,0,1921.09,1487.49,87.5093,0.832834,120,5,0,42,0,0,1),(42076,1502,0,1197,0,1961.64,1603.7,83.4338,2.0583,120,0,0,42,0,0,0),(43923,1502,0,1197,0,1945.01,1506.9,87.3372,5.93766,120,5,0,42,0,0,1),(44518,1502,0,1197,0,1956.25,1553.19,87.6134,5.95711,120,0,0,42,0,0,0),(44684,1502,0,1197,0,1987.96,1614.69,82.1956,4.82802,120,3,0,42,0,0,1),(44688,1502,0,1197,0,1852.51,1507.48,88.8269,1.75722,120,5,0,42,0,0,1),(44697,1502,0,1197,0,2013.66,1581.97,77.1212,1.63115,120,5,0,42,0,0,1),(44698,1502,0,1197,0,2008.93,1567.19,79.1212,3.27444,120,5,0,42,0,0,1),(44779,1502,0,1197,0,1945.58,1591.01,82.4922,5.30879,120,5,0,42,0,0,1),(44791,1502,0,1197,0,1930.99,1498.88,86.3843,5.12447,120,5,0,42,0,0,1),(44808,1502,0,1197,0,1923.08,1547.92,87.3368,1.8731,120,5,0,42,0,0,1),(44831,1502,0,1197,0,1930.21,1662.69,79.1377,3.80412,120,5,0,42,0,0,1),(44833,1502,0,1197,0,1881.17,1526.82,88.1731,4.49383,120,5,0,42,0,0,1),(44839,1502,0,1197,0,1898.78,1504.84,89.1851,1.96264,120,0,0,42,0,0,0),(44845,1502,0,1197,0,1864.55,1528.08,88.5208,1.35432,120,2,0,42,0,0,1),(44847,1502,0,1197,0,1858.38,1527.96,88.5499,0.646406,120,2,0,42,0,0,1),(44850,1502,0,1197,0,1934.1,1518.73,88.0872,3.57589,120,5,0,42,0,0,1),(44927,1502,0,1197,0,1928.76,1603.64,83.3339,4.93894,120,5,0,42,0,0,1),(44956,1502,0,1197,0,1990.45,1549.62,79.9522,0.586652,120,5,0,42,0,0,1),(44958,1502,0,1197,0,1905.9,1561.9,88.1273,4.92183,120,0,0,42,0,0,0),(44960,1502,0,1197,0,1994.96,1532.48,78.382,0,120,0,0,42,0,0,0),(44962,1502,0,1197,0,1926.79,1522.18,87.3504,2.68243,120,5,0,42,0,0,1),(44963,1502,0,1197,0,2008.63,1478.11,69.4733,4.57726,120,5,0,42,0,0,1),(44965,1502,0,1197,0,1934.11,1579.17,82.536,3.29743,120,5,0,42,0,0,1),(44967,1502,0,1197,0,1964.68,1550.69,85.6722,1.5365,120,5,0,42,0,0,1),(44969,1502,0,1197,0,1962.82,1559.83,84.6423,5.9083,120,5,0,42,0,0,1),(44971,1502,0,1197,0,1946.86,1561.32,87.4658,0.24497,120,2,0,42,0,0,1);
        INSERT INTO `spawns_creatures` VALUES (44524,1890,0,201,0,1898.19,1467.73,83.6047,5.35794,300,5,0,55,0,0,1),(44526,1890,0,201,0,1889.25,1488.25,88.0136,1.7437,300,5,0,55,0,0,1),(44537,1890,0,201,0,1877.55,1480.87,85.4797,0.325998,300,5,0,55,0,0,1),(44696,1890,0,201,0,2052.56,1577.75,73.5502,0.24773,300,5,0,55,0,0,1),(44721,1890,0,201,0,1939.61,1542.91,90.165,3.40744,300,0,0,55,0,0,0),(44725,1890,0,201,0,1954.62,1517.1,88.0872,0.896311,300,0,0,55,0,0,0),(44727,1890,0,201,0,1943.36,1484.81,81.5057,4.65508,300,10,0,55,0,0,1),(44735,1890,0,201,0,1980.03,1590.94,82.489,3.36789,300,0,0,55,0,0,0),(44840,1890,0,201,0,2005.93,1631.66,73.0787,3.75139,300,5,0,55,0,0,1),(44842,1890,0,201,0,2020.85,1610.26,71.7037,0.621895,300,5,0,55,0,0,1),(44846,1890,0,201,0,2027.26,1585.13,73.9962,0.552396,300,5,0,55,0,0,1),(44849,1890,0,201,0,1998.59,1588.13,79.8567,6.15124,300,3,0,55,0,0,1),(44851,1890,0,201,0,2015.96,1553.96,79.0252,3.49227,300,10,0,55,0,0,1),(44854,1890,0,201,0,2040.73,1539.46,78.1985,3.52835,300,10,0,55,0,0,1),(44856,1890,0,201,0,2025.7,1531.22,79.1395,1.7135,300,10,0,55,0,0,1),(44857,1890,0,201,0,2006.65,1503.75,73.3895,4.31804,300,10,0,55,0,0,1),(44858,1890,0,201,0,1977.45,1578.14,79.9817,2.80789,300,5,0,55,0,0,1),(44859,1890,0,201,0,1981.18,1546.04,86.4956,2.82386,300,0,0,55,0,0,0),(44860,1890,0,201,0,1980.11,1529.24,87.1908,1.05178,300,5,0,55,0,0,1),(44861,1890,0,201,0,1974.18,1499.69,86.4142,3.75379,300,5,0,55,0,0,1);
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
end $
delimiter ;

