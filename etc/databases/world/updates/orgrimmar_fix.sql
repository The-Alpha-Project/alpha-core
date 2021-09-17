    -- ORGRIMMAR 0.5.3

    -- - # I've done : 
    --    - Ignored all big shop signs with missing display_id
    --    - Ignored all NPC 6000+ entries
    --    - Ignored somes guards in walls location
    --    - Ignored all floating streets signs
    --    - Moved all NPCs in their dedicated houses
    --    - Moved some guards in weird locations
    --    - Fixed all messed up gameobjects (because of layout change)
    --    - Created braziers in Thrall keep
    --    - Created Forges/anvils in forge quarter
    --    - Fixed missing display_id for all Bonfires
    --    - Fixed missing displayid for all guards (see notes)

    -- - # TODO : 
    --    - Resolve display_id (Thrall and some more)
    --    - Fix spawn of undermap guards
    --    
    -- - # Notes :
    --    - Hunter and warrior houses are swapped(we can see Hunter Quarter Area name in Warrior 1.12 room)
    --    - No lake in Orgrimmar 0.5.3 so where fishing trainer/supplier are suposed to stand ?
    --    - I changed a bit NPC position of first house (entrance of orgrimmar, at right), cause render bug
    --    - Orgrimmar guards display_id is a guess but high probability, one rarest model with both female/male
    --    - Also, it's display_id of named grunts, so it's make sense
    --    - Based on all screenshots presents in Orgrimmar city's folder
    --    - This file is auto-generated and requests are not sorted

delimiter $
begin not atomic
    -- 17/09/2021 1
    if (select count(*) from applied_updates where id='170920211') = 0 then

        -- FIX missing display_id ALL GUARDS ORGRIMMAR
        UPDATE alpha_world.creature_template SET 
        display_id1=3546, display_id2=3564,display_id4=0,display_id3=0
        WHERE entry=3296;

        -- FIX missing display_ID ALL BONFIRE
        UPDATE gameobject_template SET 
        displayId=200
        WHERE displayId=4572;  

        -- IGNORED spawns_gameobjects 4546
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4546;

        -- IGNORED spawns_gameobjects 4543
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4543;

        -- IGNORED spawns_gameobjects 2329
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=2329;

        -- IGNORED spawns_gameobjects 4547
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4547;

        -- IGNORED spawns_gameobjects 11796
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11796;


        -- FIX spawns_creatures 4652
        UPDATE spawns_creatures SET 
        position_x=1582.921875,
        position_y=-4466.2978515625,
        position_z=7.780925750732422,
        orientation=1.3578277826309204
        WHERE spawn_id=4652;

        -- FIX spawns_creatures 6605
        UPDATE spawns_creatures SET 
        position_x=1588.1998291015625,
        position_y=-4463.97412109375,
        position_z=7.8216872215271,
        orientation=2.2861711978912354
        WHERE spawn_id=6605;

        -- FIX spawns_creatures 6599
        UPDATE spawns_creatures SET 
        position_x=1591.111083984375,
        position_y=-4461.7041015625,
        position_z=7.839587688446045,
        orientation=2.9616119861602783
        WHERE spawn_id=6599;

        -- IGNORED spawns_creatures 12325
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=12325;

        -- IGNORED spawns_creatures 4661
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4661;

        -- IGNORED spawns_gameobjects 10110
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10110;

        -- IGNORED spawns_gameobjects 4557
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4557;

        -- IGNORED spawns_gameobjects 11123
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11123;

        -- IGNORED spawns_gameobjects 10101
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10101;

        -- FIX spawns_creatures 4655
        UPDATE spawns_creatures SET 
        position_x=1622.35400390625,
        position_y=-4366.19873046875,
        position_z=12.659010887145996,
        orientation=4.324277400970459
        WHERE spawn_id=4655;

        -- FIX spawns_creatures 6598
        UPDATE spawns_creatures SET 
        position_x=1624.8724365234375,
        position_y=-4371.76171875,
        position_z=12.594976425170898,
        orientation=3.391223907470703
        WHERE spawn_id=6598;

        -- FIX spawns_creatures 4653
        UPDATE spawns_creatures SET 
        position_x=1623.4716796875,
        position_y=-4377.12890625,
        position_z=12.61293888092041,
        orientation=2.237473726272583
        WHERE spawn_id=4653;

        -- FIX spawns_creatures 4655
        UPDATE spawns_creatures SET 
        position_x=1621.85791015625,
        position_y=-4367.13232421875,
        position_z=12.67182731628418,
        orientation=4.30071496963501
        WHERE spawn_id=4655;

        -- IGNORED spawns_gameobjects 10099
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10099;

        -- IGNORED spawns_gameobjects 11097
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11097;

        -- IGNORED spawns_gameobjects 11616
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11616;

        -- IGNORED spawns_gameobjects 11339
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11339;

        -- IGNORED spawns_gameobjects 4581
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4581;

        -- IGNORED spawns_gameobjects 11929
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11929;

        -- IGNORED spawns_gameobjects 11323
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11323;

        -- IGNORED spawns_gameobjects 11593
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11593;

        -- IGNORED spawns_gameobjects 11229
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11229;

        -- IGNORED spawns_gameobjects 11204
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11204;

        -- IGNORED spawns_gameobjects 11735
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11735;

        -- IGNORED spawns_gameobjects 11726
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11726;

        -- IGNORED spawns_gameobjects 7036
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=7036;

        -- IGNORED spawns_gameobjects 7014
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=7014;

        -- IGNORED spawns_gameobjects 11797
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11797;

        -- IGNORED spawns_gameobjects 11926
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11926;

        -- IGNORED spawns_gameobjects 11632
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11632;

        -- IGNORED spawns_gameobjects 10074
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10074;

        -- IGNORED spawns_gameobjects 11141
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11141;

        -- IGNORED spawns_gameobjects 7045
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=7045;

        -- IGNORED spawns_gameobjects 11597
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11597;

        -- IGNORED spawns_gameobjects 7043
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=7043;

        -- IGNORED spawns_gameobjects 11584
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11584;

        -- IGNORED spawns_gameobjects 11631
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11631;

        -- IGNORED spawns_gameobjects 11630
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11630;

        -- IGNORED spawns_gameobjects 10974
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10974;

        -- FIX spawns_creatures 95008
        UPDATE spawns_creatures SET 
        position_x=1933.0025634765625,
        position_y=-4040.735107421875,
        position_z=40.91740036010742,
        orientation=4.068272113800049
        WHERE spawn_id=95008;

        -- FIX spawns_creatures 3418
        UPDATE spawns_creatures SET 
        position_x=1930.66064453125,
        position_y=-4199.71142578125,
        position_z=42.06083297729492,
        orientation=3.9771621227264404
        WHERE spawn_id=3418;

        -- FIX spawns_creatures 4664
        UPDATE spawns_creatures SET 
        position_x=1921.6966552734375,
        position_y=-4217.52880859375,
        position_z=42.0606575012207,
        orientation=2.123621940612793
        WHERE spawn_id=4664;

        -- FIX spawns_gameobjects 9947
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1926.279541015625,
        spawn_positionY=-4213.25244140625,
        spawn_positionZ=42.060699462890625,
        spawn_orientation=6.059256076812744
        WHERE spawn_id=9947;

        -- FIX spawns_gameobjects 9978
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1917.7730712890625,
        spawn_positionY=-4218.7265625,
        spawn_positionZ=42.06024932861328,
        spawn_orientation=4.4091339111328125
        WHERE spawn_id=9978;

        -- FIX spawns_gameobjects 9977
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1917.7730712890625,
        spawn_positionY=-4218.7265625,
        spawn_positionZ=42.06024932861328,
        spawn_orientation=4.4091339111328125
        WHERE spawn_id=9977;

        -- FIX spawns_gameobjects 11942
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1916.06787109375,
        spawn_positionY=-4193.4033203125,
        spawn_positionZ=42.06106185913086,
        spawn_orientation=2.321544885635376
        WHERE spawn_id=11942;

        -- FIX spawns_gameobjects 11939
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1916.06787109375,
        spawn_positionY=-4193.4033203125,
        spawn_positionZ=42.06106185913086,
        spawn_orientation=2.321544885635376
        WHERE spawn_id=11939;

        -- FIX spawns_gameobjects 10159
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1933.16162109375,
        spawn_positionY=-4192.13671875,
        spawn_positionZ=42.05936813354492,
        spawn_orientation=1.1324514150619507
        WHERE spawn_id=10159;

        -- FIX spawns_gameobjects 10156
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1933.16162109375,
        spawn_positionY=-4192.13671875,
        spawn_positionZ=42.05936813354492,
        spawn_orientation=1.1324514150619507
        WHERE spawn_id=10156;

        -- FIX spawns_gameobjects 9997
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1924.2449951171875,
        spawn_positionY=-4197.37255859375,
        spawn_positionZ=42.061092376708984,
        spawn_orientation=3.8844854831695557
        WHERE spawn_id=9997;

        -- FIX spawns_gameobjects 9994
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1924.50341796875,
        spawn_positionY=-4197.0888671875,
        spawn_positionZ=42.0610237121582,
        spawn_orientation=4.471963405609131
        WHERE spawn_id=9994;

        -- FIX spawns_gameobjects 4572
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1934.726806640625,
        spawn_positionY=-4217.66650390625,
        spawn_positionZ=42.059974670410156,
        spawn_orientation=5.531467437744141
        WHERE spawn_id=4572;

        -- FIX spawns_gameobjects 4571
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1934.726806640625,
        spawn_positionY=-4217.66650390625,
        spawn_positionZ=42.059974670410156,
        spawn_orientation=5.531467437744141
        WHERE spawn_id=4571;

        -- IGNORED spawns_gameobjects 9929
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=9929;

        -- IGNORED spawns_gameobjects 6975
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=6975;

        -- FIX spawns_gameobjects 11720
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1886.876953125,
        spawn_positionY=-4114.70068359375,
        spawn_positionZ=42.51376724243164,
        spawn_orientation=4.873288154602051
        WHERE spawn_id=11720;

        -- FIX spawns_gameobjects 9930
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1886.876953125,
        spawn_positionY=-4114.70068359375,
        spawn_positionZ=42.51376724243164,
        spawn_orientation=4.873288154602051
        WHERE spawn_id=9930;

        -- FIX spawns_gameobjects 6977
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1890.8221435546875,
        spawn_positionY=-4153.94091796875,
        spawn_positionZ=42.51123046875,
        spawn_orientation=1.744260311126709
        WHERE spawn_id=6977;

        -- FIX spawns_gameobjects 9953
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1890.2154541015625,
        spawn_positionY=-4153.94873046875,
        spawn_positionZ=42.529483795166016,
        spawn_orientation=4.932979106903076
        WHERE spawn_id=9953;

        -- IGNORED spawns_gameobjects 9957
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=9957;

        -- IGNORED spawns_gameobjects 4615
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4615;

        -- FIX spawns_gameobjects 10083
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1932.1131591796875,
        spawn_positionY=-4131.349609375,
        spawn_positionZ=42.53128433227539,
        spawn_orientation=0.17660628259181976
        WHERE spawn_id=10083;

        -- FIX spawns_gameobjects 4620
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1932.1131591796875,
        spawn_positionY=-4131.349609375,
        spawn_positionZ=42.53128433227539,
        spawn_orientation=0.17660628259181976
        WHERE spawn_id=4620;

        -- FIX spawns_gameobjects 6903
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1952.79,
        spawn_positionY=-4150.57,
        spawn_positionZ=42.4859,
        spawn_orientation=-1.37008
        WHERE spawn_id=6903;

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1908.7181396484375, -4024.607421875, 43.490840911865234, 3.9496614933013916, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1916.4102783203125, -4024.187255859375, 43.52632141113281, 6.210824012756348, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1907.4871826171875, -4041.90673828125, 40.929527282714844, 0.5339621305465698, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1920.531494140625, -4040.650146484375, 40.92469787597656, 3.2176694869995117, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1921.677490234375, -4068.26220703125, 40.93016052246094, 5.030369281768799, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1910.3402099609375, -4069.06494140625, 40.93067932128906, 0.07843437790870667, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_creatures 4770
        UPDATE spawns_creatures SET 
        position_x=1913.2120361328125,
        position_y=-4030.385986328125,
        position_z=42.9190673828125,
        orientation=4.775106906890869
        WHERE spawn_id=4770;

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1932.8394775390625, -4029.335205078125, 43.49723815917969, 4.053326606750488, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1938.2696533203125, -4034.553955078125, 43.535789489746094, 0.7138150334358215, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1945.8753662109375, -4049.87841796875, 43.49451446533203, 3.9559412002563477, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1946.20361328125, -4055.807861328125, 43.492286682128906, 4.691074371337891, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1941.060546875, -4072.310302734375, 43.54011154174805, 0.7444464564323425, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1936.4122314453125, -4077.6181640625, 43.49383544921875, 4.127940654754639, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1893.8289794921875, -4031.7392578125, 43.37834167480469, 0.8143407702445984, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1889.391845703125, -4036.845458984375, 43.41600036621094, 3.952793598175049, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1883.6693115234375, -4054.622802734375, 43.48993682861328, 1.7348281145095825, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1884.00244140625, -4060.132080078125, 43.4904899597168, 4.949464797973633, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1892.4287109375, -4076.879150390625, 43.416622161865234, 2.385139226913452, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1897.1868896484375, -4081.3408203125, 43.37863540649414, 5.792983531951904, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1873.5791015625, -4121.44677734375, 42.53453063964844, 6.257936954498291, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1869.156494140625, -4135.66259765625, 42.52946853637695, 3.117128610610962, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1876.0594482421875, -4149.01904296875, 42.5187873840332, 4.024263858795166, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1908.345703125, -4132.9326171875, 42.52677536010742, 0.12005005031824112, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1966.4918212890625, -4142.783203125, 42.524436950683594, 5.280909061431885, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1964.5206298828125, -4115.2412109375, 42.5197868347168, 0.9855672121047974, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1950.5997314453125, -4110.3994140625, 42.51792526245117, 1.6429458856582642, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173135, 1, 1971.341552734375, -4128.81298828125, 42.51963806152344, 6.032535552978516, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- IGNORED spawns_gameobjects 11581
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11581;

        -- IGNORED spawns_creatures 7479
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=7479;

        -- IGNORED spawns_gameobjects 4567
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4567;

        -- IGNORED spawns_creatures 3467
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=3467;

        -- FIX spawns_creatures 4687
        UPDATE spawns_creatures SET 
        position_x=1953.294677734375,
        position_y=-4466.9541015625,
        position_z=41.29138946533203,
        orientation=3.501966953277588
        WHERE spawn_id=4687;

        -- FIX spawns_creatures 4681
        UPDATE spawns_creatures SET 
        position_x=1964.376953125,
        position_y=-4477.5400390625,
        position_z=41.29138946533203,
        orientation=5.174866199493408
        WHERE spawn_id=4681;

        -- FIX spawns_creatures 6630
        UPDATE spawns_creatures SET 
        position_x=1857.1378173828125,
        position_y=-4555.5498046875,
        position_z=35.8028564453125,
        orientation=2.684360980987549
        WHERE spawn_id=6630;

        -- FIX spawns_creatures 7478
        UPDATE spawns_creatures SET 
        position_x=1852.188232421875,
        position_y=-4556.1259765625,
        position_z=35.8028564453125,
        orientation=2.4031882286071777
        WHERE spawn_id=7478;

        -- FIX spawns_creatures 6623
        UPDATE spawns_creatures SET 
        position_x=1800.72265625,
        position_y=-4563.27294921875,
        position_z=30.308612823486328,
        orientation=1.6452795267105103
        WHERE spawn_id=6623;

        -- FIX spawns_creatures 7481
        UPDATE spawns_creatures SET 
        position_x=1791.77294921875,
        position_y=-4565.8779296875,
        position_z=30.308612823486328,
        orientation=1.3271931409835815
        WHERE spawn_id=7481;

        -- FIX spawns_creatures 6629
        UPDATE spawns_creatures SET 
        position_x=1806.6883544921875,
        position_y=-4573.94140625,
        position_z=30.308612823486328,
        orientation=1.492909550666809
        WHERE spawn_id=6629;

        -- IGNORED spawns_gameobjects 7031
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=7031;

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1815.401611328125, -4557.7822265625, 30.308612823486328, 0.2692575454711914, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1813.071044921875, -4573.24169921875, 30.308612823486328, 5.3814167976379395, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1796.1951904296875, -4574.2041015625, 30.308612823486328, 4.389461040496826, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1791.3524169921875, -4558.8662109375, 30.308612823486328, 3.2616283893585205, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1841.8421630859375, -4561.34326171875, 35.8028564453125, 3.894660472869873, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- IGNORED spawns_gameobjects 11099
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11099;

        -- FIX spawns_gameobjects 4551
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1766.3194580078125,
        spawn_positionY=-4497.1220703125,
        spawn_positionZ=47.025962829589844,
        spawn_orientation=5.847156047821045
        WHERE spawn_id=4551;

        -- FIX spawns_creatures 6631
        UPDATE spawns_creatures SET 
        position_x=1779.1795654296875,
        position_y=-4487.8125,
        position_z=47.71612548828125,
        orientation=4.651778697967529
        WHERE spawn_id=6631;
        -- FIX spawns_creatures 4684
        UPDATE spawns_creatures SET 
        position_x=1775.3707275390625,
        position_y=-4483.48974609375,
        position_z=47.71612548828125,
        orientation=2.1542141437530518
        WHERE spawn_id=4684;

        -- FIX spawns_creatures 4685
        UPDATE spawns_creatures SET 
        position_x=1769.14892578125,
        position_y=-4485.41162109375,
        position_z=47.71612548828125,
        orientation=1.7206740379333496
        WHERE spawn_id=4685;

        -- CREATE spawns_gameobjects 173135
        INSERT INTO spawns_gameobjects VALUES (NULL, 173007, 1, 1775.770751953125, -4480.80224609375, 47.71612548828125, 2.2468912601470947, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_gameobjects 10139
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1852.3870849609375,
        spawn_positionY=-4477.31591796875,
        spawn_positionZ=47.21323013305664,
        spawn_orientation=0.6093359589576721
        WHERE spawn_id=10139;

        -- IGNORED spawns_gameobjects 4613
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4613;

        -- FIX spawns_gameobjects 10136
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1902.230224609375,
        spawn_positionY=-4438.255859375,
        spawn_positionZ=49.63488006591797,
        spawn_orientation=4.11298942565918
        WHERE spawn_id=10136;



        -- IGNORED spawns_gameobjects 11949
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11949;

        -- IGNORED spawns_gameobjects 10171
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10171;

        -- IGNORED spawns_gameobjects 11801
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11801;

        -- FIX spawns_gameobjects 7033
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1736.8804931640625,
        spawn_positionY=-4371.1943359375,
        spawn_positionZ=34.493404388427734,
        spawn_orientation=4.955719947814941
        WHERE spawn_id=7033;

        -- FIX spawns_gameobjects 7033
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1736.8804931640625,
        spawn_positionY=-4371.1943359375,
        spawn_positionZ=33.493404388427734,
        spawn_orientation=4.955719947814941
        WHERE spawn_id=7033;

        -- IGNORED spawns_creatures 4654
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4654;

        -- FIX spawns_gameobjects 10973
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1955.0274658203125,
        spawn_positionY=-4470.78759765625,
        spawn_positionZ=41.29138946533203,
        spawn_orientation=0.7946893572807312
        WHERE spawn_id=10973;

        -- FIX spawns_gameobjects 11604
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1955.0274658203125,
        spawn_positionY=-4470.78759765625,
        spawn_positionZ=41.29138946533203,
        spawn_orientation=0.7946893572807312
        WHERE spawn_id=11604;

        -- IGNORED spawns_gameobjects 11730
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11730;

        -- IGNORED spawns_gameobjects 10207
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10207;

        -- FIX spawns_gameobjects 4591
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1778.6552734375,
        spawn_positionY=-4309.93310546875,
        spawn_positionZ=5.869444847106934,
        spawn_orientation=0.5237321853637695
        WHERE spawn_id=4591;

        -- IGNORED spawns_gameobjects 11729
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11729;

        -- IGNORED spawns_creatures 3460
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=3460;

        -- IGNORED spawns_creatures 3419
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=3419;

        -- IGNORED spawns_gameobjects 11571
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11571;

        -- IGNORED spawns_gameobjects 4564
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=4564;

        -- IGNORED spawns_gameobjects 11230
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11230;

        -- FIX spawns_creatures 3461
        UPDATE spawns_creatures SET 
        position_x=1847.650634765625,
        position_y=-4354.06005859375,
        position_z=-13.485188484191895,
        orientation=3.0857064723968506
        WHERE spawn_id=3461;

        -- FIX spawns_creatures 6596
        UPDATE spawns_creatures SET 
        position_x=1850.7701416015625,
        position_y=-4356.73974609375,
        position_z=-13.485188484191895,
        orientation=4.328207015991211
        WHERE spawn_id=6596;

        -- FIX spawns_creatures 3452
        UPDATE spawns_creatures SET 
        position_x=1836.1973876953125,
        position_y=-4359.892578125,
        position_z=-13.485188484191895,
        orientation=2.4401116371154785
        WHERE spawn_id=3452;

        -- FIX spawns_creatures 3459
        UPDATE spawns_creatures SET 
        position_x=1774.1575927734375,
        position_y=-4375.7021484375,
        position_z=-13.485191345214844,
        orientation=5.464674472808838
        WHERE spawn_id=3459;

        -- IGNORED spawns_gameobjects 11594
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11594;

        -- IGNORED spawns_gameobjects 6916
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=6916;

        -- IGNORED spawns_gameobjects 6854
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=6854;

        -- IGNORED spawns_gameobjects 11933
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11933;

        -- IGNORED spawns_gameobjects 11931
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11931;

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1929.425537109375, -4584.22021484375, 61.45838928222656, 5.282449245452881, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1915.740966796875, -4594.19140625, 61.458396911621094, 3.6079795360565186, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1896.8741455078125, -4597.43408203125, 61.458396911621094, 3.7603468894958496, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 1896.4124755859375, -4618.4755859375, 61.458396911621094, 5.3971171379089355, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_creatures 6611
        UPDATE spawns_creatures SET 
        position_x=1886.14208984375,
        position_y=-4697.82763671875,
        position_z=61.29545211791992,
        orientation=0.9289880394935608
        WHERE spawn_id=6611;

        -- FIX spawns_creatures 6611
        UPDATE spawns_creatures SET 
        position_x=1911.6712646484375,
        position_y=-4765.73291015625,
        position_z=58.35573196411133,
        orientation=1.7049670219421387
        WHERE spawn_id=7451;

        -- FIX spawns_creatures 4668
        UPDATE spawns_creatures SET 
        position_x=2026.4666748046875,
        position_y=-4709.3955078125,
        position_z=48.736572265625,
        orientation=2.241391658782959
        WHERE spawn_id=4668;

        -- FIX spawns_creatures 4671
        UPDATE spawns_creatures SET 
        position_x=2030.2105712890625,
        position_y=-4706.23291015625,
        position_z=48.736572265625,
        orientation=2.9584600925445557
        WHERE spawn_id=4671;

        -- FIX spawns_creatures 7968
        UPDATE spawns_creatures SET 
        position_x=2037.318603515625,
        position_y=-4740.16748046875,
        position_z=51.09325408935547,
        orientation=3.6016993522644043
        WHERE spawn_id=7968;

        -- FIX spawns_creatures 4672
        UPDATE spawns_creatures SET 
        position_x=2035.9459228515625,
        position_y=-4746.220703125,
        position_z=51.09325408935547,
        orientation=4.83634614944458
        WHERE spawn_id=4672;

        -- FIX spawns_creatures 4676
        UPDATE spawns_creatures SET 
        position_x=2047.39013671875,
        position_y=-4745.67626953125,
        position_z=51.09325408935547,
        orientation=4.868547439575195
        WHERE spawn_id=4676;

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 2043.992919921875, -4757.6064453125, 51.09325408935547, 4.952585220336914, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 2030.915771484375, -4740.67724609375, 51.09325408935547, 2.0026309490203857, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_creatures 7973
        UPDATE spawns_creatures SET 
        position_x=2049.005859375,
        position_y=-4835.291015625,
        position_z=46.28427505493164,
        orientation=0.6462447643280029
        WHERE spawn_id=7973;

        -- FIX spawns_creatures 4670
        UPDATE spawns_creatures SET 
        position_x=2057.607666015625,
        position_y=-4840.5234375,
        position_z=46.28427505493164,
        orientation=1.2117314338684082
        WHERE spawn_id=4670;

        -- FIX spawns_creatures 7444
        UPDATE spawns_creatures SET 
        position_x=2096.33447265625,
        position_y=-4834.6044921875,
        position_z=46.05913543701172,
        orientation=0.31716087460517883
        WHERE spawn_id=7444;

        -- CREATE spawns_gameobjects 147048
        INSERT INTO spawns_gameobjects VALUES (NULL, 147048, 1, 2099.31787109375, -4833.625, 46.05913543701172, 3.5090203285217285, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 147048
        INSERT INTO spawns_gameobjects VALUES (NULL, 147048, 1, 2106.375, -4830.875, 46.05913543701172, 3.4139864444732666, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 169969
        INSERT INTO spawns_gameobjects VALUES (NULL, 169969, 1, 2050.63330078125, -4834.64697265625, 47.42182922363281, 4.393381118774414, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_gameobjects 3998701
        UPDATE spawns_gameobjects SET 
        spawn_positionX=2050.63330078125,
        spawn_positionY=-4834.64697265625,
        spawn_positionZ=46.42182922363281,
        spawn_orientation=4.393381118774414
        WHERE spawn_id=3998701;

        -- CREATE spawns_gameobjects 147048
        INSERT INTO spawns_gameobjects VALUES (NULL, 147048, 1, 2062.971435546875, -4795.0947265625, 44.61478805541992, 4.602296829223633, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 147048
        INSERT INTO spawns_gameobjects VALUES (NULL, 147048, 1, 2059.18603515625, -4800.18115234375, 44.367820739746094, 3.9582698345184326, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 196969
        INSERT INTO spawns_gameobjects VALUES (NULL, 196969, 1, 2051.30908203125, -4810.25439453125, 44.38002014160156, 4.450714588165283, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_creatures 7447
        UPDATE spawns_creatures SET 
        position_x=2147.54736328125,
        position_y=-4650.90234375,
        position_z=72.20052337646484,
        orientation=2.338780164718628
        WHERE spawn_id=7447;

        -- FIX spawns_creatures 4677
        UPDATE spawns_creatures SET 
        position_x=2153.88037109375,
        position_y=-4657.1123046875,
        position_z=72.16580200195312,
        orientation=5.412830352783203
        WHERE spawn_id=4677;

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 2034.2320556640625, -4710.3271484375, 48.736572265625, 5.22512149810791, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 2107.78125, -4834.88330078125, 46.05913543701172, 5.893495082855225, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173137
        INSERT INTO spawns_gameobjects VALUES (NULL, 173137, 1, 2088.934326171875, -4825.5908203125, 46.05913543701172, 3.2121453285217285, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- IGNORED spawns_gameobjects 11328
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11328;

        -- IGNORED spawns_gameobjects 11724
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11724;

        -- IGNORED spawns_gameobjects 11317
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11317;

        -- IGNORED spawns_gameobjects 11955
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11955;

        -- IGNORED spawns_gameobjects 11203
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11203;

        -- FIX spawns_creatures 7972
        UPDATE spawns_creatures SET 
        position_x=1970.4447021484375,
        position_y=-4808.423828125,
        position_z=78.69815063476562,
        orientation=0.8858109712600708
        WHERE spawn_id=7972;

        -- FIX spawns_creatures 7449
        UPDATE spawns_creatures SET 
        position_x=1998.2325439453125,
        position_y=-4808.0166015625,
        position_z=78.69815063476562,
        orientation=2.4330458641052246
        WHERE spawn_id=7449;

        -- FIX spawns_creatures 6620
        UPDATE spawns_creatures SET 
        position_x=2003.2244873046875,
        position_y=-4796.92724609375,
        position_z=78.69742584228516,
        orientation=1.6468620300292969
        WHERE spawn_id=6620;

        -- FIX spawns_creatures 7971
        UPDATE spawns_creatures SET 
        position_x=2099.62890625,
        position_y=-4586.6044921875,
        position_z=76.82025146484375,
        orientation=3.623710870742798
        WHERE spawn_id=7971;

        -- FIX spawns_creatures 6610
        UPDATE spawns_creatures SET 
        position_x=2072.32958984375,
        position_y=-4580.3017578125,
        position_z=76.82025146484375,
        orientation=5.419917106628418
        WHERE spawn_id=6610;

        -- IGNORED spawns_gameobjects 10102
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=10102;

        -- FIX spawns_gameobjects 1627
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1319.56494140625,
        spawn_positionY=-4396.31591796875,
        spawn_positionZ=28.358409881591797,
        spawn_orientation=4.709155082702637
        WHERE spawn_id=1627;

        -- FIX spawns_gameobjects 440
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1318.9727783203125,
        spawn_positionY=-4395.63447265625,
        spawn_positionZ=28.31260871887207,
        spawn_orientation=3.2679507732391357
        WHERE spawn_id=440;

        -- FIX spawns_gameobjects 3998697
        UPDATE spawns_gameobjects SET 
        spawn_positionX=2050.63,
        spawn_positionY=-4834.65,
        spawn_positionZ=46.4218,
        spawn_orientation=4.39338
        WHERE spawn_id=3998697;

        -- CREATE spawns_gameobjects 169969
        INSERT INTO spawns_gameobjects VALUES (NULL, 169969, 1, 2054.594970703125, -4810.4921875, 44.26823425292969, 2.968709945678711, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_gameobjects 10064
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1751.3087158203125,
        spawn_positionY=-4258.4990234375,
        spawn_positionZ=28.151695251464844,
        spawn_orientation=3.4155941009521484
        WHERE spawn_id=10064;

        -- FIX spawns_creatures 10348
        UPDATE spawns_creatures SET 
        position_x=1611.7718505859375,
        position_y=-4379.20849609375,
        position_z=9.305490493774414,
        orientation=3.2278873920440674
        WHERE spawn_id=10348;

        -- IGNORED spawns_gameobjects 11913
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11913;

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1864.0833740234375, -4554.76220703125, 36.41095733642578, 5.668907642364502, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- CREATE spawns_gameobjects 173019
        INSERT INTO spawns_gameobjects VALUES (NULL, 173019, 1, 1969.1361083984375, -4463.85400390625, 41.29138946533203, 0.24415789544582367, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);

        -- FIX spawns_creatures 6605
        UPDATE spawns_creatures SET 
        position_x=1587.2479248046875,
        position_y=-4464.8623046875,
        position_z=7.800971508026123,
        orientation=1.9539704322814941
        WHERE spawn_id=6605;

        -- FIX spawns_creatures 6599
        UPDATE spawns_creatures SET 
        position_x=1590.7357177734375,
        position_y=-4462.07861328125,
        position_z=7.844184398651123,
        orientation=2.7927732467651367
        WHERE spawn_id=6599;

        -- IGNORED spawns_creatures 4656
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4656;

        -- IGNORED spawns_creatures 6601
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=6601;

        -- IGNORED spawns_creatures 4659
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4659;

        -- IGNORED spawns_creatures 8530
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=8530;

        -- IGNORED spawns_creatures 7949
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=7949;

        -- IGNORED spawns_creatures 11796
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=11796;

        -- IGNORED spawns_creatures 3370
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=3370;

        -- IGNORED spawns_creatures 6624
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=6624;

        -- IGNORED spawns_creatures 4766
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4766;

        -- IGNORED spawns_creatures 4767
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4767;

        -- FIX spawns_creatures 11793
        UPDATE spawns_creatures SET 
        position_x=1899.7581787109375,
        position_y=-4486.64501953125,
        position_z=21.5030574798584,
        orientation=1.5039339065551758
        WHERE spawn_id=11793;

        -- FIX spawns_creatures 7941
        UPDATE spawns_creatures SET 
        position_x=1935.0863037109375,
        position_y=-4405.67236328125,
        position_z=22.485361099243164,
        orientation=3.715616226196289
        WHERE spawn_id=7941;

        -- FIX spawns_creatures 11792
        UPDATE spawns_creatures SET 
        position_x=1903.1468505859375,
        position_y=-4333.51708984375,
        position_z=20.93185043334961,
        orientation=5.912372589111328
        WHERE spawn_id=11792;

        -- FIX spawns_creatures 6561
        UPDATE spawns_creatures SET 
        position_x=1673.3726806640625,
        position_y=-4249.85400390625,
        position_z=52.29265594482422,
        orientation=4.594476699829102
        WHERE spawn_id=6561;

        -- IGNORED spawns_creatures 300378
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=300378;

        -- IGNORED spawns_gameobjects 7012
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=7012;

        -- FIX spawns_creatures 10299
        UPDATE spawns_creatures SET 
        position_x=1614.626220703125,
        position_y=-4256.220703125,
        position_z=45.903968811035156,
        orientation=2.3034682273864746
        WHERE spawn_id=10299;

        -- FIX spawns_creatures 11790
        UPDATE spawns_creatures SET 
        position_x=1685.4818115234375,
        position_y=-4077.04345703125,
        position_z=42.97343826293945,
        orientation=4.832448959350586
        WHERE spawn_id=11790;

        -- FIX spawns_creatures 8526
        UPDATE spawns_creatures SET 
        position_x=1518.2288818359375,
        position_y=-4425.73486328125,
        position_z=19.38093376159668,
        orientation=1.2031073570251465
        WHERE spawn_id=8526;

        -- IGNORED spawns_creatures 4680
        UPDATE spawns_creatures SET ignored=1
        WHERE spawn_id=4680;

        -- FIX spawns_creatures 11789
        UPDATE spawns_creatures SET 
        position_x=1907.9892578125,
        position_y=-4412.59765625,
        position_z=48.24418640136719,
        orientation=1.2628225088119507
        WHERE spawn_id=11789;

        -- IGNORED spawns_gameobjects 11122
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11122;

        -- FIX spawns_gameobjects 4554
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1794.958740234375,
        spawn_positionY=-4498.13232421875,
        spawn_positionZ=45.91668701171875,
        spawn_orientation=1.6437287330627441
        WHERE spawn_id=4554;

        -- FIX spawns_gameobjects 4553
        UPDATE spawns_gameobjects SET 
        spawn_positionX=1794.958740234375,
        spawn_positionY=-4498.13232421875,
        spawn_positionZ=45.91668701171875,
        spawn_orientation=1.6437287330627441
        WHERE spawn_id=4553;

        -- IGNORED spawns_gameobjects 11206
        UPDATE spawns_gameobjects SET ignored=1
        WHERE spawn_id=11206;

        insert into applied_updates values ('170920211');
    end if;  
end $
delimiter ;





