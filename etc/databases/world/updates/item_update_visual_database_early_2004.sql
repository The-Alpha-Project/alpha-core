-- Battered Mallet | ReqLevel 14 -> 9 | DmgMin 17 -> 23 | DmgMax 26 -> 32
update item_template set required_level=9, dmg_min1=23, dmg_max1=32  where entry = 1814;
-- Blackforge Bracers | SPIRIT 3 -> 0 | ItemLevel 43 -> 46 | ReqLevel 38 -> 36 | Armor 106 -> 39 | STAMINA 8 -> 2 | STRENGTH 0 -> 1
update item_template set stat_type1=7, stat_value1=8, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=46, required_level=36, armor=39, stat_type1=7, stat_value1=2, stat_type2=4, stat_value2=1  where entry = 6426;
-- Bludgeoning Cudgel | ReqLevel 17 -> 12 | DmgMin 8 -> 14 | DmgMax 16 -> 21
update item_template set required_level=12, dmg_min1=14, dmg_max1=21  where entry = 1823;
-- Brain Hacker | ItemLevel 60 -> 65 | DmgMin 95 -> 138 | DmgMax 143 -> 187
update item_template set item_level=65, dmg_min1=138, dmg_max1=187  where entry = 1263;
-- Brocade Pants -> Brocade Cloth Pants | ReqLevel 16 -> 11
update item_template set name='Brocade Cloth Pants', required_level=11  where entry = 1776;
-- Brocade Vest -> Brocade Cloth Vest | ReqLevel 18 -> 13 | Armor 33 -> 11
update item_template set name='Brocade Cloth Vest', required_level=13, armor=11  where entry = 1778;
-- Brood Mother Carapace | ItemLevel 10 -> 11 | ReqLevel 5 -> 1 | Armor 55 -> 22
update item_template set item_level=11, required_level=1, armor=22  where entry = 3000;
-- Canvas Vest | ReqLevel 12 -> 7 | Armor 27 -> 10
update item_template set required_level=7, armor=10  where entry = 1770;
-- Cedar Walking Stick -> Cedar Walking Staff | ReqLevel 18 -> 13 | DmgMin 20 -> 26 | DmgMax 31 -> 35
update item_template set name='Cedar Walking Staff', required_level=13, dmg_min1=26, dmg_max1=35  where entry = 1822;
-- Cross-stitched Belt | ReqLevel 25 -> 20
update item_template set required_level=20  where entry = 3380;
-- Cross-stitched Sandals -> Cross-stitched Boots | ReqLevel 24 -> 19 | Armor 26 -> 9
update item_template set name='Cross-stitched Boots', required_level=19, armor=9  where entry = 1780;
-- Cross-stitched Pants | ReqLevel 22 -> 17
update item_template set required_level=17  where entry = 1784;
-- Cross-stitched Shoulderpads | ReqLevel 23 -> 18 | Armor 28 -> 10
update item_template set required_level=18, armor=10  where entry = 1785;
-- Cross-stitched Vest | ReqLevel 24 -> 19 | Armor 38 -> 13
update item_template set required_level=19, armor=13  where entry = 1786;
-- Decapitating Sword | ReqLevel 19 -> 14 | DmgMin 22 -> 33 | DmgMax 42 -> 51
update item_template set required_level=14, dmg_min1=33, dmg_max1=51  where entry = 3740;
-- Double Mail Boots | ReqLevel 27 -> 22 | Armor 126 -> 29
update item_template set required_level=22, armor=29  where entry = 3809;
-- Driftwood Club | STAMINA 1 -> 0
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0  where entry = 1394;
-- Emil's Brand | STRENGTH 11 -> 0 | STAMINA 3 -> 0
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0  where entry = 5813;
-- Foreman's Leggings | STAMINA 3 -> 0 | AGILITY 3 -> 0 | SPIRIT 3 -> 0 | ReqLevel 15 -> 10 | Armor 147 -> 43
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=10, armor=43  where entry = 2166;
-- Frost Bracers | ItemLevel 33 -> 32 | ReqLevel 28 -> 22 | Armor 20 -> 11
update item_template set item_level=32, required_level=22, armor=11  where entry = 1216;
-- Frostmane Chain Vest | ItemLevel 5 -> 11 | Armor 67 -> 16
update item_template set item_level=11, armor=16  where entry = 2109;
-- Frostmane Hand Axe | ItemLevel 9 -> 1 | DmgMin 5 -> 11 | DmgMax 10 -> 17
update item_template set item_level=1, dmg_min1=11, dmg_max1=17  where entry = 2260;
-- Glimmering Flamberge -> Glimmering Great Sword | ItemLevel 32 -> 36 | ReqLevel 27 -> 33 | DmgMin 55 -> 63 | DmgMax 84 -> 86
update item_template set name='Glimmering Great Sword', item_level=36, required_level=33, dmg_min1=63, dmg_max1=86  where entry = 15250;
-- Goblin Power Shovel | STRENGTH 6 -> 0 | AGILITY 10 -> 0 | ItemLevel 34 -> 24 | DmgMin 60 -> 66 | DmgMax 91 -> 90 | STAMINA 0 -> 9
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=24, dmg_min1=66, dmg_max1=90, stat_type1=7, stat_value1=9  where entry = 1991;
-- Gouging Pick | ItemLevel 22 -> 12 | DmgMin 8 -> 14 | DmgMax 16 -> 21
update item_template set item_level=12, dmg_min1=14, dmg_max1=21  where entry = 1819;
-- Greasy Tinker's Pants | STRENGTH 3 -> 0 | ReqLevel 0 -> 8 | AGILITY 3 -> 4
update item_template set stat_type1=3, stat_value1=3, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=8, stat_type1=3, stat_value1=4  where entry = 5327;
-- Guerrilla Cleaver | STAMINA 4 -> 0 | AGILITY 3 -> 0 | ItemLevel 34 -> 24 | DmgMin 34 -> 48 | DmgMax 65 -> 72
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=24, dmg_min1=48, dmg_max1=72  where entry = 4126;
-- Guerrilla Cleaver | ItemLevel 34 -> 24 | DmgMin 34 -> 48 | DmgMax 65 -> 72
update item_template set item_level=24, dmg_min1=48, dmg_max1=72  where entry = 4126;
-- Hardened Leather Boots | ItemLevel 35 -> 26 | ReqLevel 30 -> 16 | Armor 63 -> 16
update item_template set item_level=26, required_level=16, armor=16  where entry = 3801;
-- Hardened Leather Pants | ItemLevel 32 -> 30 | ReqLevel 27 -> 20 | Armor 76 -> 23
update item_template set item_level=30, required_level=20, armor=23  where entry = 3805;
-- Hardened Leather Tunic -> Hardened Leather Vest | ItemLevel 33 -> 27 | ReqLevel 28 -> 17 | Armor 89 -> 25
update item_template set name='Hardened Leather Vest', item_level=27, required_level=17, armor=25  where entry = 3807;
-- Heavy Ogre War Axe | STRENGTH 7 -> 0 | STAMINA 5 -> 0 | ItemLevel 27 -> 17 | DmgMin 55 -> 62
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=17, dmg_min1=62  where entry = 2227;
-- Hefty War Axe | ItemLevel 32 -> 22 | DmgMin 29 -> 32
update item_template set item_level=22, dmg_min1=32  where entry = 3779;
-- Icepane Warhammer | STRENGTH 2 -> 0 | ReqLevel 7 -> 2 | DmgMin 22 -> 31 | DmgMax 34 -> 42
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=2, dmg_min1=31, dmg_max1=42  where entry = 2254;
-- Interlaced Vest | ReqLevel 32 -> 27 | Armor 44 -> 16
update item_template set required_level=27, armor=16  where entry = 3799;
-- Jimmied Handcuffs | STAMINA 7 -> 0 | ItemLevel 26 -> 25 | ReqLevel 21 -> 15 | Armor 89 -> 28 | STRENGTH 3 -> 1
update item_template set stat_type1=4, stat_value1=3, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=25, required_level=15, armor=28, stat_type1=4, stat_value1=1  where entry = 3228;
-- Junglewalker Sandals | INTELLECT 5 -> 0 | ReqLevel 0 -> 27 | Armor 34 -> 17 | SPIRIT 2 -> 3 | STAMINA 8 -> 3
update item_template set stat_type1=7, stat_value1=8, stat_type2=6, stat_value2=2, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=27, armor=17, stat_type2=6, stat_value2=3, stat_type1=7, stat_value1=3  where entry = 4139;
-- Kazon's Maul | STAMINA 4 -> 0 | ReqLevel 22 -> 17 | DmgMin 49 -> 55 | STRENGTH 8 -> 6
update item_template set stat_type1=4, stat_value1=8, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=17, dmg_min1=55, stat_type1=4, stat_value1=6  where entry = 2058;
-- Light Scimitar | ReqLevel 31 -> 26 | DmgMin 15 -> 22 | DmgMax 28 -> 34
update item_template set required_level=26, dmg_min1=22, dmg_max1=34  where entry = 3783;
-- Light Scorpid Armor | ReqLevel 0 -> 1
update item_template set required_level=1  where entry = 4929;
-- Linked Chain Gloves | ReqLevel 19 -> 14 | Armor 101 -> 20
update item_template set required_level=14, armor=20  where entry = 1750;
-- Linked Chain Pants | ReqLevel 20 -> 15 | Armor 144 -> 31
update item_template set required_level=15, armor=31  where entry = 1751;
-- Linked Chain Vest | ReqLevel 17 -> 12 | Armor 156 -> 33
update item_template set required_level=12, armor=33  where entry = 1753;
-- Lovingly Crafted Boomstick | ReqLevel 19 -> 14 | DmgMin 12 -> 13 | DmgMax 23 -> 20
update item_template set required_level=14, dmg_min1=13, dmg_max1=20  where entry = 4372;
-- Lupine Axe | AGILITY 6 -> 0 | ItemLevel 20 -> 10 | DmgMin 24 -> 30 | DmgMax 36 -> 42
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=10, dmg_min1=30, dmg_max1=42  where entry = 1220;
-- Magebane Scion -> Magebane Staff | ItemLevel 60 -> 35 | ReqLevel 0 -> 30 | DmgMin 0 -> 45 | DmgMax 0 -> 53
update item_template set name='Magebane Staff', item_level=35, required_level=30, dmg_min1=45, dmg_max1=53  where entry = 15857;
-- Meat Cleaver | ItemLevel 27 -> 17 | DmgMin 14 -> 21 | DmgMax 26 -> 32
update item_template set item_level=17, dmg_min1=21, dmg_max1=32  where entry = 1827;
-- Oaken War Staff | ReqLevel 23 -> 18 | DmgMin 33 -> 39 | DmgMax 51 -> 54
update item_template set required_level=18, dmg_min1=39, dmg_max1=54  where entry = 1831;
-- Petrified Shinbone | STAMINA 2 -> 0 | ReqLevel 12 -> 7 | DmgMin 12 -> 20 | DmgMax 23 -> 31
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=7, dmg_min1=20, dmg_max1=31  where entry = 1958;
-- Putrid Wooden Hammer -> Putrid Wooden Mace | DmgMin 1 -> 7 | DmgMax 3 -> 11
update item_template set name='Putrid Wooden Mace', dmg_min1=7, dmg_max1=11  where entry = 3262;
-- Rawhide Pants | ItemLevel 24 -> 18 | ReqLevel 19 -> 8 | Armor 66 -> 17
update item_template set item_level=18, required_level=8, armor=17  where entry = 1800;
-- Rawhide Tunic -> Rawhide Vest | ItemLevel 21 -> 20 | ReqLevel 16 -> 10 | Armor 71 -> 21
update item_template set name='Rawhide Vest', item_level=20, required_level=10, armor=21  where entry = 1802;
-- Red Linen Vest | SPIRIT 2 -> 0 | ItemLevel 12 -> 7 | Armor 23 -> 14
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=7, armor=14  where entry = 6239;
-- Reinforced Chain Boots | ReqLevel 22 -> 17 | Armor 117 -> 25
update item_template set required_level=17, armor=25  where entry = 1755;
-- Reinforced Chain Pants | ItemLevel 26 -> 50 | ReqLevel 21 -> 40 | Armor 146 -> 48 | AGILITY 0 -> 9
update item_template set item_level=50, required_level=40, armor=48, stat_type1=3, stat_value1=9  where entry = 1759;
-- Reinforced Chain Vest | ReqLevel 23 -> 18 | Armor 173 -> 38
update item_template set required_level=18, armor=38  where entry = 1761;
-- Rock Maul | ReqLevel 22 -> 17 | DmgMin 25 -> 30 | DmgMax 38 -> 41
update item_template set required_level=17, dmg_min1=30, dmg_max1=41  where entry = 1826;
-- Shiny War Axe | ItemLevel 23 -> 13
update item_template set item_level=13  where entry = 1824;
-- Shoddy Blunderbuss | ReqLevel 17 -> 12 | DmgMin 7 -> 9
update item_template set required_level=12, dmg_min1=9  where entry = 2783;
-- Skull Hatchet | ItemLevel 8 -> 1 | DmgMin 4 -> 10 | DmgMax 9 -> 16
update item_template set item_level=1, dmg_min1=10, dmg_max1=16  where entry = 2066;
-- Skullchipper | STAMINA 1 -> 0 | ItemLevel 20 -> 10 | DmgMin 36 -> 47 | DmgMax 55 -> 64 | STRENGTH 6 -> 2
update item_template set stat_type1=4, stat_value1=6, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=10, dmg_min1=47, dmg_max1=64, stat_type1=4, stat_value1=2  where entry = 5626;
-- Spore-covered Tunic | STAMINA 1 -> 0 | ReqLevel 0 -> 5 | Armor 70 -> 28
update item_template set stat_type1=6, stat_value1=3, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=5, armor=28  where entry = 5341;
-- Staff of Jordan | INTELLECT 11 -> 0 | SPIRIT 11 -> 0 | ItemLevel 40 -> 20 | ReqLevel 35 -> 10 | DmgMin 119 -> 41 | DmgMax 180 -> 56
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=20, required_level=10, dmg_min1=41, dmg_max1=56  where entry = 873;
-- Steelscale Crushfish | STRENGTH 4 -> 0 | ReqLevel 20 -> 15 | DmgMin 22 -> 33 | DmgMax 42 -> 50
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, required_level=15, dmg_min1=33, dmg_max1=50  where entry = 6360;
-- Stone War Axe | ItemLevel 27 -> 17 | DmgMin 22 -> 27 | DmgMax 34 -> 37
update item_template set item_level=17, dmg_min1=27, dmg_max1=37  where entry = 1828;
-- Stonesplinter Axe | STRENGTH 1 -> 0 | ItemLevel 13 -> 3 | DmgMin 10 -> 19 | DmgMax 20 -> 29
update item_template set stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=3, dmg_min1=19, dmg_max1=29  where entry = 2265;
-- Thick Leather Boots | ItemLevel 48 -> 35 | ReqLevel 43 -> 25 | Armor 80 -> 20 | AGILITY 0 -> 3
update item_template set item_level=35, required_level=25, armor=20, stat_type1=3, stat_value1=3  where entry = 3962;
-- Thick Leather Gloves | ItemLevel 49 -> 36 | ReqLevel 44 -> 26
update item_template set item_level=36, required_level=26  where entry = 3965;
-- Tough Leather Boots | ItemLevel 26 -> 25 | ReqLevel 21 -> 15 | Armor 54 -> 16
update item_template set item_level=25, required_level=15, armor=16  where entry = 1804;
-- Tough Leather Pants | ItemLevel 30 -> 24 | ReqLevel 25 -> 14 | Armor 74 -> 20
update item_template set item_level=24, required_level=14, armor=20  where entry = 1808;
-- Tracker's Boots | ItemLevel 44 -> 4 | ReqLevel 39 -> 1 | Armor 82 -> 9
update item_template set item_level=4, required_level=1, armor=9  where entry = 9917;
-- Trogg Dagger | DmgMin 1 -> 5 | DmgMax 2 -> 8
update item_template set dmg_min1=5, dmg_max1=8  where entry = 2787;
-- Turtle Scale Breastplate -> Turtle Skin Vest | SPIRIT 9 -> 0 | ItemLevel 42 -> 25 | ReqLevel 37 -> 15 | Armor 238 -> 39 | INTELLECT 9 -> 4 | STAMINA 9 -> 3
update item_template set name='Turtle Skin Vest', stat_type1=7, stat_value1=9, stat_type2=0, stat_value2=0, stat_type3=5, stat_value3=9, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=25, required_level=15, armor=39, stat_type3=5, stat_value3=4, stat_type1=7, stat_value1=3  where entry = 8189;
-- Tuxedo Shirt | ReqLevel 0 -> 1
update item_template set required_level=1  where entry = 10034;
-- Broad Bladed Knife -> Wavy Bladed Knife | STAMINA 5 -> 0 | ItemLevel 32 -> 18 | ReqLevel 27 -> 8 | DmgMin 23 -> 16 | DmgMax 44 -> 24
update item_template set name='Wavy Bladed Knife', stat_type1=0, stat_value1=0, stat_type2=0, stat_value2=0, stat_type3=0, stat_value3=0, stat_type4=0, stat_value4=0, stat_type5=0, stat_value5=0, stat_type6=0, stat_value6=0, stat_type7=0, stat_value7=0, stat_type8=0, stat_value8=0, stat_type9=0, stat_value9=0, stat_type10=0, stat_value10=0, item_level=18, required_level=8, dmg_min1=16, dmg_max1=24  where entry = 12247;
-- Red Linen Vest | ItemLevel 12 -> 7 | Armor 23 -> 14
update item_template set item_level=7, armor=14  where entry = 6239;
