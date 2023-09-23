delimiter $
begin not atomic
    -- 25/08/2023 1
	if (select count(*) from applied_updates where id='250820231') = 0 then
	    -- Replace faction 875 (Gnome, doesn't exist in 0.5.3) with faction 57. At this moment all of these had faction
	    -- 64 which makes them Neutral and not fitting for friendly NPCs.
        UPDATE `creature_template` set `faction` = 57 WHERE `entry` IN (374, 460, 1676, 2682, 2683, 3133, 3181, 3290, 4081, 5100, 5114, 5127, 5132, 5144, 5151, 5152, 5157, 5158, 5162, 5163, 5167, 5169, 5172, 5175, 5177, 5178, 5518, 5519, 5520, 5569, 5612, 6119, 6120, 6169, 6328, 6376, 6382, 6826, 7207, 7312, 7950, 7954, 7955, 7978, 8416, 8681, 9099, 9676, 10455, 10456, 11026, 11028, 11029, 11037, 12784, 13000, 14481, 14724, 15353, 15763, 15707, 15434, 15450, 15455, 15456, 15733, 7954);

        insert into applied_updates values ('250820231');
    end if;

    -- 25/08/2023 2
    if (select count(*) from `applied_updates` where id='250820232') = 0 then

        -- CREATURE CLASSLEVELSTATS GENERATION
        
        -- UNIT CLASS 1
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 64, 130.348, 118.879, 273, 199, 3425, 1952, 0, 0, 146, 107, 276, 51, 85, 3684);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 65, 132.993, 121.1565, 278, 207, 3520, 2011, 0, 0, 148, 108, 281, 51, 86, 3743);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 66, 135.657, 123.4475, 283, 215, 3616, 2071, 0, 0, 150, 110, 286, 51, 87, 3802);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 67, 138.34, 125.752, 289, 223, 3714, 2132, 0, 0, 152, 112, 291, 51, 88, 3861);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 68, 141.042, 128.07, 295, 231, 3813, 2194, 0, 0, 154, 114, 296, 51, 89, 3920);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 69, 143.763, 130.4015, 301, 239, 3913, 2257, 0, 0, 156, 116, 301, 51, 90, 3979);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 70, 146.503, 132.7465, 307, 247, 4015, 2321, 0, 0, 158, 118, 306, 51, 91, 4038);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 71, 149.262, 135.105, 313, 255, 4118, 2386, 0, 0, 160, 120, 312, 51, 92, 4097);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 72, 152.04, 137.477, 319, 263, 4222, 2452, 0, 0, 162, 122, 318, 51, 93, 4156);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 73, 154.837, 139.8625, 325, 271, 4327, 2519, 0, 0, 164, 124, 324, 51, 94, 4215);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 74, 157.653, 142.2615, 331, 279, 4434, 2587, 0, 0, 166, 126, 330, 51, 95, 4274);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 75, 160.488, 144.674, 337, 287, 4542, 2656, 0, 0, 168, 128, 336, 51, 96, 4333);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 76, 163.342, 147.1, 343, 295, 4651, 2726, 0, 0, 170, 130, 342, 51, 97, 4392);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 77, 166.215, 149.5395, 349, 303, 4761, 2796, 0, 0, 172, 132, 348, 51, 98, 4451);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 78, 169.107, 151.9925, 355, 311, 4873, 2867, 0, 0, 174, 134, 354, 51, 99, 4510);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 79, 172.018, 154.459, 361, 319, 4986, 2939, 0, 0, 176, 136, 360, 51, 100, 4569);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 80, 174.948, 156.939, 367, 327, 5100, 3012, 0, 0, 178, 138, 366, 51, 101, 4628);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 81, 177.897, 159.4325, 373, 335, 5216, 3086, 0, 0, 180, 140, 372, 51, 102, 4687);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 82, 180.865, 161.9395, 379, 343, 5333, 3161, 0, 0, 182, 142, 378, 51, 103, 4746);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 83, 183.852, 164.46, 386, 351, 5451, 3237, 0, 0, 185, 144, 384, 51, 104, 4805);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 84, 186.858, 166.994, 393, 359, 5570, 3314, 0, 0, 188, 146, 390, 51, 105, 4864);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 85, 189.883, 169.5415, 400, 367, 5691, 3392, 0, 0, 191, 148, 396, 51, 106, 4923);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 86, 192.927, 172.1025, 407, 375, 5813, 3471, 0, 0, 194, 150, 402, 52, 107, 4982);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 87, 195.99, 174.677, 414, 385, 5936, 3551, 0, 0, 197, 152, 408, 53, 108, 5041);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 88, 199.072, 177.265, 421, 395, 6060, 3632, 0, 0, 200, 154, 414, 54, 109, 5100);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 89, 202.173, 179.8665, 428, 405, 6186, 3713, 0, 0, 203, 156, 420, 55, 110, 5159);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 90, 205.293, 182.4815, 435, 415, 6313, 3795, 0, 0, 206, 158, 426, 56, 111, 5218);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 91, 208.432, 185.11, 442, 425, 6441, 3878, 0, 0, 209, 160, 433, 57, 112, 5277);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 92, 211.59, 187.752, 449, 435, 6571, 3962, 0, 0, 212, 162, 440, 58, 113, 5336);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 93, 214.767, 190.4075, 456, 445, 6702, 4047, 0, 0, 215, 164, 447, 59, 114, 5395);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 94, 217.963, 193.0765, 463, 455, 6834, 4133, 0, 0, 218, 166, 454, 60, 115, 5454);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 95, 221.178, 195.759, 470, 465, 6967, 4220, 0, 0, 221, 168, 461, 61, 116, 5513);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 96, 224.412, 198.455, 477, 475, 7102, 4308, 0, 0, 224, 170, 468, 62, 117, 5572);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 97, 227.665, 201.1645, 484, 485, 7238, 4397, 0, 0, 227, 172, 475, 63, 118, 5631);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 98, 230.937, 203.8875, 491, 495, 7375, 4487, 0, 0, 230, 174, 482, 64, 119, 5690);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 99, 234.228, 206.624, 498, 505, 7513, 4578, 0, 0, 233, 176, 489, 65, 120, 5749);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 100, 237.538, 209.374, 506, 515, 7653, 4670, 0, 0, 236, 178, 496, 66, 121, 5808);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 101, 240.867, 212.1375, 514, 525, 7794, 4763, 0, 0, 239, 180, 503, 67, 122, 5867);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 102, 244.215, 214.9145, 522, 535, 7936, 4856, 0, 0, 242, 182, 510, 68, 123, 5926);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 103, 247.582, 217.705, 530, 545, 8080, 4950, 0, 0, 245, 184, 517, 69, 124, 5985);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 104, 250.968, 220.509, 538, 555, 8225, 5045, 0, 0, 248, 186, 524, 70, 125, 6044);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 105, 254.373, 223.3265, 546, 565, 8371, 5141, 0, 0, 251, 188, 531, 71, 126, 6103);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 106, 257.797, 226.1575, 554, 575, 8518, 5238, 0, 0, 254, 190, 538, 72, 127, 6162);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 107, 261.24, 229.002, 562, 585, 8667, 5336, 0, 0, 257, 192, 545, 73, 128, 6221);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 108, 264.702, 231.86, 570, 595, 8817, 5435, 0, 0, 260, 194, 552, 74, 129, 6280);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 109, 268.183, 234.7315, 578, 605, 8968, 5535, 0, 0, 263, 196, 559, 75, 130, 6339);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 110, 271.683, 237.6165, 586, 615, 9121, 5636, 0, 0, 266, 198, 566, 76, 131, 6398);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 111, 275.202, 240.515, 594, 627, 9275, 5738, 0, 0, 269, 200, 573, 77, 132, 6457);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 112, 278.74, 243.427, 602, 639, 9430, 5841, 0, 0, 272, 202, 581, 78, 133, 6516);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 113, 282.297, 246.3525, 610, 651, 9586, 5945, 0, 0, 275, 204, 589, 79, 134, 6575);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 114, 285.873, 249.2915, 618, 663, 9744, 6050, 0, 0, 278, 206, 597, 80, 135, 6634);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 115, 289.468, 252.244, 626, 675, 9903, 6155, 0, 0, 281, 208, 605, 81, 136, 6693);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 116, 293.082, 255.21, 635, 687, 10063, 6261, 0, 0, 284, 210, 613, 82, 137, 6752);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 117, 296.715, 258.1895, 644, 699, 10224, 6368, 0, 0, 287, 212, 621, 83, 138, 6811);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 118, 300.367, 261.1825, 653, 711, 10387, 6476, 0, 0, 290, 214, 629, 84, 139, 6870);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 119, 304.038, 264.189, 662, 723, 10551, 6585, 0, 0, 293, 216, 637, 85, 140, 6929);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 120, 307.728, 267.209, 671, 735, 10716, 6695, 0, 0, 296, 219, 645, 86, 142, 6988);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 121, 311.437, 270.2425, 680, 747, 10883, 6806, 0, 0, 299, 222, 653, 87, 144, 7047);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 122, 315.165, 273.2895, 689, 759, 11051, 6918, 0, 0, 302, 225, 661, 88, 146, 7106);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 123, 318.912, 276.35, 698, 771, 11220, 7031, 0, 0, 305, 228, 669, 89, 148, 7165);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 124, 322.678, 279.424, 707, 783, 11390, 7145, 0, 0, 308, 231, 677, 90, 150, 7224);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 125, 326.463, 282.5115, 716, 795, 11562, 7260, 0, 0, 311, 234, 685, 91, 152, 7283);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 126, 330.267, 285.6125, 725, 807, 11735, 7376, 0, 0, 314, 237, 693, 92, 154, 7342);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 127, 334.09, 288.727, 734, 819, 11909, 7492, 0, 0, 317, 240, 701, 93, 156, 7401);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 128, 337.932, 291.855, 743, 831, 12084, 7609, 0, 0, 320, 243, 709, 94, 158, 7460);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 129, 341.793, 294.9965, 752, 843, 12261, 7727, 0, 0, 323, 246, 717, 95, 160, 7519);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 130, 345.673, 298.1515, 761, 855, 12439, 7846, 0, 0, 326, 249, 725, 96, 162, 7578);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 131, 349.572, 301.32, 770, 867, 12618, 7966, 0, 0, 329, 252, 733, 97, 164, 7637);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 132, 353.49, 304.502, 779, 879, 12799, 8087, 0, 0, 332, 255, 742, 98, 166, 7696);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 133, 357.427, 307.6975, 789, 891, 12981, 8209, 0, 0, 336, 258, 751, 99, 168, 7755);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 134, 361.383, 310.9065, 799, 903, 13164, 8332, 0, 0, 340, 261, 760, 100, 170, 7814);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 135, 365.358, 314.129, 809, 917, 13348, 8456, 0, 0, 344, 264, 769, 101, 172, 7873);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 136, 369.352, 317.365, 819, 931, 13534, 8581, 0, 0, 348, 267, 778, 102, 174, 7932);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 137, 373.365, 320.6145, 829, 945, 13721, 8707, 0, 0, 352, 270, 787, 103, 176, 7991);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 138, 377.397, 323.8775, 839, 959, 13909, 8834, 0, 0, 356, 273, 796, 104, 178, 8050);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 139, 381.448, 327.154, 849, 973, 14098, 8962, 0, 0, 360, 276, 805, 105, 180, 8109);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 140, 385.518, 330.444, 859, 987, 14289, 9090, 0, 0, 364, 279, 814, 106, 182, 8168);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 141, 389.607, 333.7475, 869, 1001, 14481, 9219, 0, 0, 368, 282, 823, 107, 184, 8227);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 142, 393.715, 337.0645, 879, 1015, 14674, 9349, 0, 0, 372, 285, 832, 108, 186, 8286);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 143, 397.842, 340.395, 889, 1029, 14869, 9480, 0, 0, 376, 288, 841, 109, 188, 8345);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 144, 401.988, 343.739, 899, 1043, 15065, 9612, 0, 0, 380, 291, 850, 110, 190, 8404);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 145, 406.153, 347.0965, 909, 1057, 15262, 9745, 0, 0, 384, 294, 859, 111, 192, 8463);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 146, 410.337, 350.4675, 919, 1071, 15460, 9879, 0, 0, 388, 297, 868, 112, 194, 8522);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 147, 414.54, 353.852, 929, 1085, 15660, 10014, 0, 0, 392, 300, 877, 113, 196, 8581);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 148, 418.762, 357.25, 939, 1099, 15861, 10150, 0, 0, 396, 303, 886, 114, 198, 8640);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 149, 423.003, 360.6615, 950, 1113, 16063, 10287, 0, 0, 400, 306, 895, 115, 200, 8699);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 150, 427.263, 364.0865, 961, 1127, 16267, 10425, 0, 0, 404, 309, 904, 116, 202, 8758);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 151, 431.542, 367.525, 972, 1141, 16472, 10564, 0, 0, 408, 312, 913, 117, 204, 8817);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 152, 435.84, 370.977, 983, 1155, 16678, 10704, 0, 0, 412, 315, 923, 118, 206, 8876);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 153, 440.157, 374.4425, 994, 1169, 16885, 10844, 0, 0, 416, 318, 933, 119, 208, 8935);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 154, 444.493, 377.9215, 1005, 1183, 17094, 10985, 0, 0, 420, 321, 943, 120, 210, 8994);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 155, 448.848, 381.414, 1016, 1197, 17304, 11127, 0, 0, 424, 324, 953, 121, 212, 9053);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 156, 453.222, 384.92, 1027, 1211, 17515, 11270, 0, 0, 428, 327, 963, 122, 214, 9112);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 157, 457.615, 388.4395, 1038, 1225, 17727, 11414, 0, 0, 432, 330, 973, 123, 216, 9171);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 158, 462.027, 391.9725, 1049, 1239, 17941, 11559, 0, 0, 436, 333, 983, 124, 218, 9230);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 159, 466.458, 395.519, 1060, 1255, 18156, 11705, 0, 0, 440, 336, 993, 125, 220, 9289);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 160, 470.908, 399.079, 1071, 1271, 18372, 11852, 0, 0, 444, 339, 1003, 126, 222, 9348);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 161, 475.377, 402.6525, 1082, 1287, 18590, 12000, 0, 0, 448, 342, 1013, 127, 224, 9407);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 162, 479.865, 406.2395, 1093, 1303, 18809, 12149, 0, 0, 452, 345, 1023, 128, 226, 9466);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 163, 484.372, 409.84, 1104, 1319, 19029, 12299, 0, 0, 456, 348, 1033, 129, 228, 9525);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 164, 488.898, 413.454, 1115, 1335, 19250, 12450, 0, 0, 460, 351, 1043, 130, 230, 9584);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 165, 493.443, 417.0815, 1126, 1351, 19473, 12602, 0, 0, 464, 354, 1053, 131, 232, 9643);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 166, 498.007, 420.7225, 1138, 1367, 19697, 12754, 0, 0, 468, 357, 1063, 132, 234, 9702);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 167, 502.59, 424.377, 1150, 1383, 19922, 12907, 0, 0, 472, 360, 1073, 133, 236, 9761);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 168, 507.192, 428.045, 1162, 1399, 20148, 13061, 0, 0, 476, 363, 1083, 134, 238, 9820);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 169, 511.813, 431.7265, 1174, 1415, 20376, 13216, 0, 0, 480, 366, 1093, 135, 240, 9879);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 170, 516.453, 435.4215, 1186, 1431, 20605, 13372, 0, 0, 484, 369, 1103, 136, 242, 9938);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 171, 521.112, 439.13, 1198, 1447, 20835, 13529, 0, 0, 488, 372, 1113, 137, 244, 9997);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 172, 525.79, 442.852, 1210, 1463, 21067, 13687, 0, 0, 492, 375, 1124, 138, 246, 10056);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 173, 530.487, 446.5875, 1222, 1479, 21300, 13846, 0, 0, 496, 378, 1135, 139, 248, 10115);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 174, 535.203, 450.3365, 1234, 1495, 21534, 14006, 0, 0, 500, 382, 1146, 140, 250, 10174);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 175, 539.938, 454.099, 1246, 1511, 21769, 14167, 0, 0, 504, 386, 1157, 141, 252, 10233);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 176, 544.692, 457.875, 1258, 1527, 22006, 14329, 0, 0, 508, 390, 1168, 142, 254, 10292);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 177, 549.465, 461.6645, 1270, 1543, 22244, 14492, 0, 0, 512, 394, 1179, 143, 256, 10351);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 178, 554.257, 465.4675, 1282, 1559, 22483, 14655, 0, 0, 516, 398, 1190, 144, 258, 10410);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 179, 559.068, 469.284, 1294, 1575, 22723, 14819, 0, 0, 520, 402, 1201, 145, 260, 10469);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 180, 563.898, 473.114, 1306, 1591, 22965, 14984, 0, 0, 524, 406, 1212, 146, 262, 10528);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 181, 568.747, 476.9575, 1318, 1607, 23208, 15150, 0, 0, 528, 410, 1223, 147, 264, 10587);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 182, 573.615, 480.8145, 1331, 1623, 23452, 15317, 0, 0, 532, 414, 1234, 148, 266, 10646);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 183, 578.502, 484.685, 1344, 1641, 23698, 15485, 0, 0, 537, 418, 1245, 149, 268, 10705);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 184, 583.408, 488.569, 1357, 1659, 23945, 15654, 0, 0, 542, 422, 1256, 150, 270, 10764);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 185, 588.333, 492.4665, 1370, 1677, 24193, 15824, 0, 0, 547, 426, 1267, 151, 272, 10823);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 186, 593.277, 496.3775, 1383, 1695, 24442, 15995, 0, 0, 552, 430, 1278, 152, 274, 10882);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 187, 598.24, 500.302, 1396, 1713, 24693, 16167, 0, 0, 557, 434, 1289, 153, 276, 10941);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 188, 603.222, 504.24, 1409, 1731, 24945, 16340, 0, 0, 562, 438, 1300, 154, 278, 11000);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 189, 608.223, 508.1915, 1422, 1749, 25198, 16514, 0, 0, 567, 442, 1311, 155, 280, 11059);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 190, 613.243, 512.1565, 1435, 1767, 25453, 16689, 0, 0, 572, 446, 1322, 156, 282, 11118);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 191, 618.282, 516.135, 1448, 1785, 25709, 16864, 0, 0, 577, 450, 1333, 157, 284, 11177);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 192, 623.34, 520.127, 1461, 1803, 25966, 17040, 0, 0, 582, 454, 1345, 158, 286, 11236);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 193, 628.417, 524.1325, 1474, 1821, 26224, 17217, 0, 0, 587, 458, 1357, 159, 288, 11295);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 194, 633.513, 528.1515, 1487, 1839, 26484, 17395, 0, 0, 592, 462, 1369, 160, 290, 11354);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 195, 638.628, 532.184, 1500, 1857, 26745, 17574, 0, 0, 597, 466, 1381, 161, 292, 11413);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 196, 643.762, 536.23, 1513, 1875, 27007, 17754, 0, 0, 602, 470, 1393, 162, 294, 11472);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 197, 648.915, 540.2895, 1526, 1893, 27270, 17935, 0, 0, 607, 474, 1405, 164, 296, 11531);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 198, 654.087, 544.3625, 1539, 1911, 27535, 18117, 0, 0, 612, 478, 1417, 166, 298, 11590);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 199, 659.278, 548.449, 1553, 1929, 27801, 18300, 0, 0, 617, 482, 1429, 168, 300, 11649);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 200, 664.488, 552.549, 1567, 1947, 28068, 18484, 0, 0, 622, 486, 1441, 170, 302, 11708);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 201, 669.717, 556.6625, 1581, 1965, 28337, 18669, 0, 0, 627, 490, 1453, 172, 304, 11767);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 202, 674.965, 560.7895, 1595, 1983, 28607, 18855, 0, 0, 632, 494, 1465, 174, 306, 11826);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 203, 680.232, 564.93, 1609, 2001, 28878, 19042, 0, 0, 637, 498, 1477, 176, 308, 11885);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 204, 685.518, 569.084, 1623, 2019, 29150, 19229, 0, 0, 642, 502, 1489, 178, 310, 11944);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 205, 690.823, 573.2515, 1637, 2037, 29424, 19417, 0, 0, 647, 506, 1501, 180, 312, 12003);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 206, 696.147, 577.4325, 1651, 2057, 29699, 19606, 0, 0, 652, 510, 1513, 182, 314, 12062);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 207, 701.49, 581.627, 1665, 2077, 29975, 19796, 0, 0, 657, 514, 1525, 184, 316, 12121);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 208, 706.852, 585.835, 1679, 2097, 30252, 19987, 0, 0, 662, 518, 1537, 186, 318, 12180);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 209, 712.233, 590.0565, 1693, 2117, 30531, 20179, 0, 0, 667, 522, 1549, 188, 320, 12239);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 210, 717.633, 594.2915, 1707, 2137, 30811, 20372, 0, 0, 672, 526, 1561, 190, 323, 12298);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 211, 723.052, 598.54, 1721, 2157, 31092, 20566, 0, 0, 677, 530, 1573, 192, 326, 12357);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 212, 728.49, 602.802, 1735, 2177, 31375, 20761, 0, 0, 682, 534, 1585, 194, 329, 12416);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 213, 733.947, 607.0775, 1749, 2197, 31659, 20957, 0, 0, 687, 538, 1598, 196, 332, 12475);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 214, 739.423, 611.3665, 1763, 2217, 31944, 21154, 0, 0, 692, 542, 1611, 198, 335, 12534);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 215, 744.918, 615.669, 1777, 2237, 32230, 21352, 0, 0, 697, 546, 1624, 200, 338, 12593);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 216, 750.432, 619.985, 1792, 2257, 32518, 21550, 0, 0, 702, 550, 1637, 202, 341, 12652);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 217, 755.965, 624.3145, 1807, 2277, 32807, 21749, 0, 0, 707, 554, 1650, 204, 344, 12711);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 218, 761.517, 628.6575, 1822, 2297, 33097, 21949, 0, 0, 712, 558, 1663, 206, 347, 12770);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 219, 767.088, 633.014, 1837, 2317, 33388, 22150, 0, 0, 717, 562, 1676, 208, 350, 12829);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 220, 772.678, 637.384, 1852, 2337, 33681, 22352, 0, 0, 722, 566, 1689, 210, 353, 12888);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 221, 778.287, 641.7675, 1867, 2357, 33975, 22555, 0, 0, 727, 570, 1702, 212, 356, 12947);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 222, 783.915, 646.1645, 1882, 2377, 34270, 22759, 0, 0, 732, 574, 1715, 214, 359, 13006);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 223, 789.562, 650.575, 1897, 2397, 34567, 22964, 0, 0, 737, 578, 1728, 216, 362, 13065);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 224, 795.228, 654.999, 1912, 2417, 34865, 23170, 0, 0, 742, 582, 1741, 218, 365, 13124);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 225, 800.913, 659.4365, 1927, 2437, 35164, 23377, 0, 0, 747, 586, 1754, 220, 368, 13183);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 226, 806.617, 663.8875, 1942, 2457, 35464, 23585, 0, 0, 752, 590, 1767, 222, 371, 13242);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 227, 812.34, 668.352, 1957, 2477, 35766, 23794, 0, 0, 757, 594, 1780, 224, 374, 13301);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 228, 818.082, 672.83, 1972, 2497, 36069, 24004, 0, 0, 762, 599, 1793, 226, 377, 13360);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 229, 823.843, 677.3215, 1987, 2517, 36373, 24214, 0, 0, 767, 604, 1806, 228, 380, 13419);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 230, 829.623, 681.8265, 2002, 2539, 36679, 24425, 0, 0, 772, 609, 1819, 230, 383, 13478);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 231, 835.422, 686.345, 2017, 2561, 36986, 24637, 0, 0, 777, 614, 1832, 232, 386, 13537);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 232, 841.24, 690.877, 2033, 2583, 37294, 24850, 0, 0, 782, 619, 1845, 234, 389, 13596);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 233, 847.077, 695.4225, 2049, 2605, 37603, 25064, 0, 0, 788, 624, 1859, 236, 392, 13655);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 234, 852.933, 699.9815, 2065, 2627, 37914, 25279, 0, 0, 794, 629, 1873, 238, 395, 13714);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 235, 858.808, 704.554, 2081, 2649, 38226, 25495, 0, 0, 800, 634, 1887, 240, 398, 13773);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 236, 864.702, 709.14, 2097, 2671, 38539, 25712, 0, 0, 806, 639, 1901, 242, 401, 13832);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 237, 870.615, 713.7395, 2113, 2693, 38853, 25930, 0, 0, 812, 644, 1915, 244, 404, 13891);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 238, 876.547, 718.3525, 2129, 2715, 39169, 26149, 0, 0, 818, 649, 1929, 246, 407, 13950);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 239, 882.498, 722.979, 2145, 2737, 39486, 26369, 0, 0, 824, 654, 1943, 248, 410, 14009);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 240, 888.468, 727.619, 2161, 2759, 39804, 26590, 0, 0, 830, 659, 1957, 250, 413, 14068);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 241, 894.457, 732.2725, 2177, 2781, 40124, 26812, 0, 0, 836, 664, 1971, 252, 416, 14127);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 242, 900.465, 736.9395, 2193, 2803, 40445, 27034, 0, 0, 842, 669, 1985, 254, 419, 14186);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 243, 906.492, 741.62, 2209, 2825, 40767, 27257, 0, 0, 848, 674, 1999, 256, 422, 14245);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 244, 912.538, 746.314, 2225, 2847, 41090, 27481, 0, 0, 854, 679, 2013, 258, 425, 14304);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 245, 918.603, 751.0215, 2241, 2869, 41415, 27706, 0, 0, 860, 684, 2027, 260, 428, 14363);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 246, 924.687, 755.7425, 2257, 2891, 41741, 27932, 0, 0, 866, 689, 2041, 262, 431, 14422);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 247, 930.79, 760.477, 2273, 2913, 42068, 28159, 0, 0, 872, 694, 2055, 264, 434, 14481);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 248, 936.912, 765.225, 2289, 2935, 42396, 28387, 0, 0, 878, 699, 2069, 266, 437, 14540);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 249, 943.053, 769.9865, 2306, 2957, 42726, 28616, 0, 0, 884, 704, 2083, 268, 440, 14599);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 250, 949.213, 774.7615, 2323, 2979, 43057, 28846, 0, 0, 890, 709, 2097, 270, 443, 14658);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 251, 955.392, 779.55, 2340, 3001, 43389, 29077, 0, 0, 896, 714, 2111, 272, 446, 14717);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 252, 961.59, 784.352, 2357, 3023, 43723, 29309, 0, 0, 902, 719, 2125, 274, 449, 14776);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 253, 967.807, 789.1675, 2374, 3045, 44058, 29542, 0, 0, 908, 724, 2140, 276, 452, 14835);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 254, 974.043, 793.9965, 2391, 3069, 44394, 29775, 0, 0, 914, 729, 2155, 278, 455, 14894);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 1, 255, 980.298, 798.839, 2408, 3093, 44731, 30009, 0, 0, 920, 734, 2170, 280, 458, 14953);


        -- UNIT CLASS 2
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 64, 121.088, 107.418, 257, 165, 2740, 1568, 2696, 1616, 138.53, 90, 253, 73, 160, 2964);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 65, 123.408, 109.4955, 262, 172, 2816, 1618, 2773, 1654, 141.08, 91, 258, 74, 162, 3007);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 66, 125.742, 111.5865, 267, 179, 2893, 1668, 2851, 1693, 143.65, 92, 263, 75, 164, 3050);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 67, 128.09, 113.691, 272, 186, 2971, 1719, 2930, 1732, 146.24, 93, 268, 76, 166, 3093);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 68, 130.452, 115.809, 277, 193, 3050, 1771, 3010, 1772, 148.85000000000002, 94, 273, 77, 168, 3136);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 69, 132.828, 117.9405, 282, 200, 3130, 1824, 3091, 1812, 151.48000000000002, 95, 279, 78, 170, 3179);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 70, 135.218, 120.0855, 288, 207, 3211, 1878, 3173, 1852, 154.13000000000002, 96, 285, 79, 172, 3222);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 71, 137.622, 122.244, 294, 214, 3293, 1932, 3256, 1893, 156.8, 97, 291, 80, 174, 3265);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 72, 140.04, 124.416, 300, 221, 3376, 1987, 3340, 1934, 159.49, 98, 297, 81, 176, 3308);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 73, 142.472, 126.6015, 306, 228, 3460, 2043, 3425, 1976, 162.20000000000002, 99, 303, 82, 178, 3351);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 74, 144.918, 128.8005, 312, 235, 3545, 2100, 3511, 2018, 164.93, 100, 309, 83, 180, 3394);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 75, 147.378, 131.013, 318, 242, 3631, 2157, 3598, 2060, 167.68, 101, 315, 84, 182, 3436);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 76, 149.852, 133.239, 324, 249, 3718, 2215, 3686, 2103, 170.45000000000002, 102, 321, 85, 184, 3478);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 77, 152.34, 135.4785, 330, 256, 3806, 2274, 3775, 2146, 173.24, 104, 327, 86, 186, 3520);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 78, 154.842, 137.7315, 336, 263, 3895, 2334, 3865, 2190, 176.05, 106, 333, 87, 188, 3562);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 79, 157.358, 139.998, 342, 270, 3985, 2395, 3956, 2234, 178.88000000000002, 108, 339, 88, 190, 3604);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 80, 159.888, 142.278, 348, 277, 4076, 2456, 4048, 2278, 181.73000000000002, 110, 345, 89, 192, 3646);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 81, 162.432, 144.5715, 354, 284, 4168, 2518, 4141, 2323, 184.60000000000002, 112, 351, 90, 194, 3688);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 82, 164.99, 146.8785, 360, 291, 4261, 2581, 4235, 2368, 187.49, 114, 357, 91, 196, 3730);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 83, 167.562, 149.199, 366, 298, 4355, 2645, 4330, 2414, 190.4, 116, 363, 92, 198, 3772);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 84, 170.148, 151.533, 372, 305, 4450, 2709, 4426, 2460, 193.33, 118, 369, 93, 200, 3814);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 85, 172.748, 153.8805, 378, 312, 4546, 2774, 4523, 2506, 196.28, 120, 375, 94, 202, 3855);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 86, 175.362, 156.2415, 384, 319, 4643, 2840, 4621, 2553, 199.25, 122, 382, 95, 204, 3896);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 87, 177.99, 158.616, 391, 327, 4741, 2907, 4720, 2600, 202.24, 124, 389, 96, 206, 3937);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 88, 180.632, 161.004, 398, 335, 4840, 2974, 4820, 2648, 205.25, 126, 396, 97, 208, 3978);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 89, 183.288, 163.4055, 405, 343, 4940, 3042, 4921, 2696, 208.28, 128, 403, 98, 210, 4019);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 90, 185.958, 165.8205, 412, 351, 5041, 3111, 5024, 2744, 211.33, 130, 410, 99, 212, 4060);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 91, 188.642, 168.249, 419, 359, 5143, 3181, 5128, 2793, 214.4, 132, 417, 100, 214, 4101);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 92, 191.34, 170.691, 426, 368, 5246, 3252, 5233, 2842, 217.49, 134, 424, 101, 216, 4142);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 93, 194.052, 173.1465, 433, 377, 5350, 3323, 5339, 2892, 220.60000000000002, 136, 431, 102, 218, 4183);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 94, 196.778, 175.6155, 440, 386, 5455, 3395, 5446, 2942, 223.73000000000002, 138, 438, 103, 220, 4224);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 95, 199.518, 178.098, 447, 395, 5561, 3468, 5554, 2992, 226.88000000000002, 140, 445, 104, 222, 4264);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 96, 202.272, 180.594, 454, 404, 5668, 3542, 5663, 3043, 230.05, 142, 452, 105, 224, 4304);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 97, 205.04, 183.1035, 461, 413, 5776, 3616, 5773, 3094, 233.24, 144, 459, 106, 226, 4344);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 98, 207.822, 185.6265, 468, 422, 5885, 3691, 5884, 3146, 236.45000000000002, 146, 466, 107, 228, 4384);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 99, 210.618, 188.163, 475, 431, 5995, 3767, 5996, 3198, 239.68, 148, 473, 108, 230, 4424);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 100, 213.428, 190.713, 482, 440, 6106, 3844, 6109, 3250, 242.93, 150, 480, 109, 232, 4464);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 101, 216.252, 193.2765, 489, 449, 6218, 3922, 6223, 3303, 246.20000000000002, 152, 487, 110, 234, 4504);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 102, 219.09, 195.8535, 496, 458, 6331, 4000, 6338, 3356, 249.49, 154, 495, 111, 236, 4544);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 103, 221.942, 198.444, 504, 467, 6445, 4079, 6454, 3410, 252.8, 156, 503, 112, 238, 4584);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 104, 224.808, 201.048, 512, 476, 6560, 4159, 6571, 3464, 256.13, 158, 511, 113, 240, 4624);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 105, 227.688, 203.6655, 520, 485, 6676, 4240, 6689, 3518, 259.48, 160, 519, 114, 242, 4663);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 106, 230.582, 206.2965, 528, 494, 6793, 4321, 6808, 3573, 262.85, 162, 527, 115, 244, 4702);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 107, 233.49, 208.941, 536, 503, 6911, 4403, 6928, 3628, 266.24, 164, 535, 116, 246, 4741);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 108, 236.412, 211.599, 544, 512, 7030, 4486, 7049, 3684, 269.65000000000003, 166, 543, 118, 248, 4780);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 109, 239.348, 214.2705, 552, 521, 7150, 4570, 7171, 3740, 273.08000000000004, 168, 551, 120, 250, 4819);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 110, 242.298, 216.9555, 560, 530, 7271, 4654, 7294, 3796, 276.53000000000003, 170, 559, 122, 253, 4858);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 111, 245.262, 219.654, 568, 540, 7393, 4739, 7418, 3853, 280.00000000000006, 172, 567, 124, 256, 4897);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 112, 248.24, 222.366, 576, 550, 7516, 4825, 7543, 3910, 283.49000000000007, 174, 575, 126, 259, 4936);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 113, 251.232, 225.0915, 584, 560, 7640, 4912, 7669, 3968, 287.00000000000006, 176, 583, 128, 262, 4975);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 114, 254.238, 227.8305, 592, 570, 7765, 5000, 7796, 4026, 290.53000000000003, 178, 591, 130, 265, 5014);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 115, 257.258, 230.583, 600, 580, 7891, 5088, 7924, 4084, 294.08000000000004, 180, 599, 132, 268, 5052);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 116, 260.292, 233.349, 608, 590, 8018, 5177, 8053, 4143, 297.65000000000003, 182, 607, 134, 271, 5090);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 117, 263.34, 236.1285, 616, 600, 8146, 5267, 8183, 4202, 301.24, 184, 615, 136, 274, 5128);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 118, 266.402, 238.9215, 624, 610, 8275, 5358, 8314, 4262, 304.85, 186, 623, 138, 277, 5166);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 119, 269.478, 241.728, 632, 620, 8405, 5449, 8446, 4322, 308.48, 188, 632, 140, 280, 5204);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 120, 272.568, 244.548, 641, 630, 8537, 5541, 8579, 4382, 312.13, 190, 641, 142, 283, 5242);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 121, 275.672, 247.3815, 650, 640, 8670, 5634, 8713, 4443, 315.8, 192, 650, 144, 286, 5280);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 122, 278.79, 250.2285, 659, 650, 8804, 5728, 8848, 4504, 319.49, 194, 659, 146, 289, 5318);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 123, 281.922, 253.089, 668, 660, 8939, 5823, 8984, 4566, 323.2, 196, 668, 148, 292, 5356);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 124, 285.068, 255.963, 677, 670, 9075, 5918, 9122, 4628, 326.93, 198, 677, 150, 295, 5394);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 125, 288.228, 258.8505, 686, 681, 9212, 6014, 9261, 4690, 330.68, 200, 686, 152, 298, 5431);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 126, 291.402, 261.7515, 695, 692, 9350, 6111, 9401, 4753, 334.45, 202, 695, 154, 301, 5468);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 127, 294.59, 264.666, 704, 703, 9489, 6209, 9542, 4816, 338.24, 204, 704, 156, 304, 5505);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 128, 297.792, 267.594, 713, 714, 9629, 6307, 9684, 4880, 342.05, 206, 713, 158, 307, 5542);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 129, 301.008, 270.5355, 722, 725, 9770, 6406, 9827, 4944, 345.88, 208, 722, 160, 310, 5579);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 130, 304.238, 273.4905, 731, 736, 9912, 6506, 9971, 5008, 349.73, 210, 731, 162, 313, 5616);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 131, 307.482, 276.459, 740, 747, 10055, 6607, 10116, 5073, 353.6, 213, 740, 164, 316, 5653);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 132, 310.74, 279.441, 749, 758, 10199, 6708, 10262, 5138, 357.49, 216, 749, 166, 319, 5690);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 133, 314.012, 282.4365, 758, 769, 10344, 6810, 10409, 5204, 361.40000000000003, 219, 758, 168, 322, 5727);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 134, 317.298, 285.4455, 767, 780, 10490, 6913, 10557, 5270, 365.33000000000004, 222, 767, 170, 325, 5764);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 135, 320.598, 288.468, 776, 792, 10637, 7017, 10706, 5336, 369.28000000000003, 225, 777, 172, 328, 5800);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 136, 323.912, 291.504, 786, 804, 10785, 7122, 10856, 5403, 373.25000000000006, 228, 787, 174, 331, 5836);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 137, 327.24, 294.5535, 796, 816, 10934, 7227, 11007, 5470, 377.24000000000007, 231, 797, 176, 334, 5872);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 138, 330.582, 297.6165, 806, 828, 11084, 7333, 11159, 5538, 381.25000000000006, 234, 807, 178, 337, 5908);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 139, 333.938, 300.693, 816, 840, 11235, 7440, 11312, 5606, 385.28000000000003, 237, 817, 180, 340, 5944);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 140, 337.308, 303.783, 826, 852, 11387, 7548, 11466, 5674, 389.33000000000004, 240, 827, 182, 343, 5980);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 141, 340.692, 306.8865, 836, 864, 11540, 7656, 11621, 5743, 393.40000000000003, 243, 837, 184, 346, 6016);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 142, 344.09, 310.0035, 846, 876, 11694, 7765, 11777, 5812, 397.49, 246, 847, 186, 349, 6052);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 143, 347.502, 313.134, 856, 888, 11849, 7875, 11934, 5882, 401.6, 249, 857, 188, 352, 6088);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 144, 350.928, 316.278, 866, 900, 12005, 7986, 12092, 5952, 405.73, 252, 867, 190, 355, 6124);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 145, 354.368, 319.4355, 876, 912, 12162, 8097, 12251, 6022, 409.88, 255, 877, 192, 358, 6159);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 146, 357.822, 322.6065, 886, 924, 12320, 8209, 12411, 6093, 414.05, 258, 887, 194, 361, 6194);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 147, 361.29, 325.791, 896, 936, 12479, 8322, 12572, 6164, 418.24, 261, 897, 196, 364, 6229);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 148, 364.772, 328.989, 906, 948, 12639, 8436, 12734, 6236, 422.45, 264, 907, 198, 367, 6264);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 149, 368.268, 332.2005, 916, 960, 12800, 8551, 12897, 6308, 426.68, 267, 917, 200, 370, 6299);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 150, 371.778, 335.4255, 926, 972, 12962, 8666, 13061, 6380, 430.93, 270, 927, 202, 373, 6334);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 151, 375.302, 338.664, 936, 984, 13125, 8782, 13226, 6453, 435.2, 273, 937, 204, 376, 6369);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 152, 378.84, 341.916, 946, 996, 13289, 8899, 13392, 6526, 439.49, 276, 948, 206, 379, 6404);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 153, 382.392, 345.1815, 957, 1008, 13454, 9017, 13559, 6600, 443.8, 279, 959, 208, 382, 6439);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 154, 385.958, 348.4605, 968, 1020, 13620, 9135, 13727, 6674, 448.13, 282, 970, 210, 385, 6474);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 155, 389.538, 351.753, 979, 1032, 13787, 9254, 13896, 6748, 452.48, 285, 981, 212, 388, 6508);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 156, 393.132, 355.059, 990, 1044, 13955, 9374, 14066, 6823, 456.85, 288, 992, 214, 391, 6542);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 157, 396.74, 358.3785, 1001, 1056, 14124, 9495, 14238, 6898, 461.24, 291, 1003, 216, 394, 6576);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 158, 400.362, 361.7115, 1012, 1068, 14294, 9617, 14411, 6974, 465.65000000000003, 294, 1014, 218, 397, 6610);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 159, 403.998, 365.058, 1023, 1082, 14465, 9739, 14585, 7050, 470.08000000000004, 297, 1025, 220, 400, 6644);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 160, 407.648, 368.418, 1034, 1096, 14637, 9862, 14760, 7126, 474.53000000000003, 300, 1036, 222, 403, 6678);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 161, 411.312, 371.7915, 1045, 1110, 14810, 9986, 14936, 7203, 479.00000000000006, 303, 1047, 224, 406, 6712);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 162, 414.99, 375.1785, 1056, 1124, 14984, 10111, 15113, 7280, 483.49000000000007, 306, 1058, 226, 409, 6746);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 163, 418.682, 378.579, 1067, 1138, 15159, 10236, 15291, 7358, 488.00000000000006, 309, 1069, 228, 412, 6780);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 164, 422.388, 381.993, 1078, 1152, 15335, 10362, 15470, 7436, 492.53000000000003, 312, 1080, 230, 415, 6814);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 165, 426.108, 385.4205, 1089, 1166, 15512, 10489, 15650, 7514, 497.08000000000004, 315, 1091, 232, 418, 6847);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 166, 429.842, 388.8615, 1100, 1180, 15690, 10617, 15831, 7593, 501.65000000000003, 318, 1102, 234, 421, 6880);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 167, 433.59, 392.316, 1111, 1194, 15869, 10745, 16013, 7672, 506.24, 321, 1113, 236, 424, 6913);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 168, 437.352, 395.784, 1122, 1208, 16049, 10874, 16196, 7752, 510.85, 324, 1125, 238, 427, 6946);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 169, 441.128, 399.2655, 1134, 1222, 16230, 11004, 16380, 7832, 515.48, 327, 1137, 240, 430, 6979);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 170, 444.918, 402.7605, 1146, 1236, 16412, 11135, 16565, 7912, 520.13, 330, 1149, 242, 433, 7012);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 171, 448.722, 406.269, 1158, 1250, 16595, 11267, 16751, 7993, 524.8, 333, 1161, 244, 436, 7045);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 172, 452.54, 409.791, 1170, 1264, 16779, 11399, 16938, 8074, 529.49, 336, 1173, 246, 439, 7078);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 173, 456.372, 413.3265, 1182, 1278, 16964, 11532, 17126, 8156, 534.2, 339, 1185, 248, 442, 7111);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 174, 460.218, 416.8755, 1194, 1292, 17150, 11666, 17315, 8238, 538.9300000000001, 342, 1197, 250, 445, 7144);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 175, 464.078, 420.438, 1206, 1306, 17337, 11801, 17505, 8320, 543.6800000000001, 345, 1209, 253, 448, 7176);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 176, 467.952, 424.014, 1218, 1320, 17525, 11936, 17696, 8403, 548.45, 348, 1221, 256, 451, 7208);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 177, 471.84, 427.6035, 1230, 1334, 17714, 12072, 17888, 8486, 553.24, 351, 1233, 259, 454, 7240);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 178, 475.742, 431.2065, 1242, 1348, 17904, 12209, 18081, 8570, 558.05, 354, 1245, 262, 457, 7272);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 179, 479.658, 434.823, 1254, 1362, 18095, 12347, 18275, 8654, 562.88, 357, 1257, 265, 460, 7304);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 180, 483.588, 438.453, 1266, 1376, 18287, 12486, 18470, 8738, 567.73, 360, 1269, 268, 463, 7336);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 181, 487.532, 442.0965, 1278, 1390, 18480, 12625, 18666, 8823, 572.6, 363, 1281, 271, 466, 7368);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 182, 491.49, 445.7535, 1290, 1404, 18674, 12765, 18863, 8908, 577.49, 366, 1293, 274, 469, 7400);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 183, 495.462, 449.424, 1302, 1419, 18869, 12906, 19061, 8994, 582.4, 369, 1305, 277, 472, 7432);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 184, 499.448, 453.108, 1314, 1434, 19066, 13048, 19260, 9080, 587.3299999999999, 372, 1317, 280, 475, 7464);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 185, 503.448, 456.8055, 1326, 1449, 19264, 13190, 19460, 9166, 592.28, 376, 1330, 283, 478, 7495);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 186, 507.462, 460.5165, 1339, 1464, 19463, 13333, 19661, 9253, 597.25, 380, 1343, 286, 481, 7526);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 187, 511.49, 464.241, 1352, 1479, 19663, 13477, 19863, 9340, 602.24, 384, 1356, 289, 484, 7557);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 188, 515.532, 467.979, 1365, 1494, 19864, 13622, 20066, 9428, 607.25, 388, 1369, 292, 487, 7588);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 189, 519.588, 471.7305, 1378, 1509, 20066, 13767, 20270, 9516, 612.28, 392, 1382, 295, 490, 7619);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 190, 523.658, 475.4955, 1391, 1524, 20269, 13913, 20476, 9604, 617.3299999999999, 396, 1395, 298, 493, 7650);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 191, 527.742, 479.274, 1404, 1539, 20473, 14060, 20683, 9693, 622.4, 400, 1408, 301, 496, 7681);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 192, 531.84, 483.066, 1417, 1555, 20678, 14208, 20891, 9782, 627.49, 404, 1421, 304, 499, 7712);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 193, 535.952, 486.8715, 1430, 1571, 20884, 14357, 21100, 9872, 632.6, 408, 1434, 307, 502, 7743);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 194, 540.078, 490.6905, 1443, 1587, 21091, 14506, 21310, 9962, 637.73, 412, 1447, 310, 505, 7774);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 195, 544.218, 494.523, 1456, 1603, 21299, 14656, 21521, 10052, 642.88, 416, 1460, 313, 508, 7804);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 196, 548.372, 498.369, 1469, 1619, 21508, 14807, 21733, 10143, 648.05, 420, 1473, 316, 511, 7834);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 197, 552.54, 502.2285, 1482, 1635, 21718, 14959, 21946, 10234, 653.24, 424, 1486, 319, 514, 7864);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 198, 556.722, 506.1015, 1495, 1651, 21929, 15111, 22160, 10326, 658.45, 428, 1499, 322, 517, 7894);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 199, 560.918, 509.988, 1508, 1667, 22141, 15264, 22375, 10418, 663.6800000000001, 432, 1512, 325, 520, 7924);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 200, 565.128, 513.888, 1521, 1683, 22354, 15418, 22591, 10510, 668.9300000000001, 436, 1525, 328, 524, 7954);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 201, 569.352, 517.8015, 1534, 1699, 22568, 15573, 22808, 10603, 674.2, 440, 1539, 331, 528, 7984);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 202, 573.59, 521.7285, 1548, 1715, 22783, 15729, 23026, 10696, 679.49, 444, 1553, 334, 532, 8014);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 203, 577.842, 525.669, 1562, 1731, 22999, 15885, 23245, 10790, 684.8, 448, 1567, 337, 536, 8044);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 204, 582.108, 529.623, 1576, 1747, 23216, 16042, 23465, 10884, 690.13, 452, 1581, 340, 540, 8074);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 205, 586.388, 533.5905, 1590, 1763, 23434, 16200, 23686, 10978, 695.48, 456, 1595, 343, 544, 8103);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 206, 590.682, 537.5715, 1604, 1780, 23653, 16359, 23908, 11073, 700.85, 460, 1609, 346, 548, 8132);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 207, 594.99, 541.566, 1618, 1797, 23873, 16518, 24131, 11168, 706.24, 464, 1623, 349, 552, 8161);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 208, 599.312, 545.574, 1632, 1814, 24094, 16678, 24355, 11264, 711.65, 468, 1637, 352, 556, 8190);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 209, 603.648, 549.5955, 1646, 1831, 24316, 16839, 24580, 11360, 717.0799999999999, 472, 1651, 355, 560, 8219);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 210, 607.998, 553.6305, 1660, 1848, 24539, 17001, 24806, 11456, 722.53, 476, 1665, 358, 564, 8248);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 211, 612.362, 557.679, 1674, 1865, 24763, 17163, 25033, 11553, 728.0, 480, 1679, 361, 568, 8277);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 212, 616.74, 561.741, 1688, 1882, 24988, 17326, 25261, 11650, 733.49, 484, 1693, 364, 572, 8306);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 213, 621.132, 565.8165, 1702, 1899, 25214, 17490, 25490, 11748, 739.0, 488, 1707, 367, 576, 8335);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 214, 625.538, 569.9055, 1716, 1916, 25441, 17655, 25720, 11846, 744.53, 492, 1721, 370, 580, 8364);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 215, 629.958, 574.008, 1730, 1933, 25669, 17821, 25951, 11944, 750.0799999999999, 496, 1735, 373, 584, 8392);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 216, 634.392, 578.124, 1744, 1950, 25898, 17987, 26183, 12043, 755.65, 500, 1749, 376, 588, 8420);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 217, 638.84, 582.2535, 1758, 1967, 26128, 18154, 26416, 12142, 761.24, 504, 1763, 379, 592, 8448);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 218, 643.302, 586.3965, 1772, 1984, 26359, 18322, 26650, 12242, 766.85, 508, 1778, 382, 596, 8476);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 219, 647.778, 590.553, 1787, 2001, 26591, 18491, 26885, 12342, 772.48, 512, 1793, 385, 600, 8504);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 220, 652.268, 594.723, 1802, 2018, 26824, 18660, 27121, 12442, 778.13, 516, 1808, 388, 604, 8532);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 221, 656.772, 598.9065, 1817, 2035, 27058, 18830, 27358, 12543, 783.8, 520, 1823, 391, 608, 8560);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 222, 661.29, 603.1035, 1832, 2052, 27293, 19001, 27596, 12644, 789.49, 524, 1838, 394, 612, 8588);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 223, 665.822, 607.314, 1847, 2069, 27529, 19173, 27835, 12746, 795.2, 528, 1853, 397, 616, 8616);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 224, 670.368, 611.538, 1862, 2086, 27766, 19346, 28076, 12848, 800.9300000000001, 532, 1868, 400, 620, 8644);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 225, 674.928, 615.7755, 1877, 2104, 28004, 19519, 28318, 12950, 806.6800000000001, 536, 1883, 403, 624, 8671);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 226, 679.502, 620.0265, 1892, 2122, 28243, 19693, 28561, 13053, 812.45, 540, 1898, 406, 628, 8698);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 227, 684.09, 624.291, 1907, 2140, 28483, 19868, 28805, 13156, 818.24, 544, 1913, 409, 632, 8725);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 228, 688.692, 628.569, 1922, 2158, 28724, 20044, 29050, 13260, 824.05, 548, 1928, 412, 636, 8752);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 229, 693.308, 632.8605, 1937, 2176, 28966, 20220, 29296, 13364, 829.88, 552, 1943, 415, 640, 8779);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 230, 697.938, 637.1655, 1952, 2195, 29209, 20397, 29543, 13468, 835.73, 556, 1958, 418, 644, 8806);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 231, 702.582, 641.484, 1967, 2214, 29453, 20575, 29791, 13573, 841.6, 560, 1973, 421, 648, 8833);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 232, 707.24, 645.816, 1982, 2233, 29698, 20754, 30040, 13678, 847.49, 564, 1988, 424, 652, 8860);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 233, 711.912, 650.1615, 1997, 2252, 29944, 20933, 30290, 13784, 853.4, 568, 2003, 427, 656, 8887);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 234, 716.598, 654.5205, 2012, 2271, 30191, 21113, 30541, 13890, 859.3299999999999, 572, 2019, 430, 660, 8914);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 235, 721.298, 658.893, 2028, 2290, 30439, 21294, 30793, 13996, 865.28, 576, 2035, 433, 664, 8940);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 236, 726.012, 663.279, 2044, 2309, 30688, 21476, 31046, 14103, 871.25, 580, 2051, 436, 668, 8966);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 237, 730.74, 667.6785, 2060, 2328, 30938, 21659, 31300, 14210, 877.24, 584, 2067, 439, 672, 8992);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 238, 735.482, 672.0915, 2076, 2347, 31189, 21842, 31555, 14318, 883.25, 588, 2083, 442, 676, 9018);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 239, 740.238, 676.518, 2092, 2366, 31441, 22026, 31811, 14426, 889.28, 593, 2099, 445, 680, 9044);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 240, 745.008, 680.958, 2108, 2385, 31694, 22211, 32068, 14534, 895.3299999999999, 598, 2115, 448, 684, 9070);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 241, 749.792, 685.4115, 2124, 2404, 31948, 22397, 32326, 14643, 901.4, 603, 2131, 451, 688, 9096);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 242, 754.59, 689.8785, 2140, 2423, 32203, 22583, 32585, 14752, 907.49, 608, 2147, 455, 692, 9122);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 243, 759.402, 694.359, 2156, 2442, 32459, 22770, 32845, 14862, 913.6, 613, 2163, 459, 696, 9148);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 244, 764.228, 698.853, 2172, 2461, 32716, 22958, 33106, 14972, 919.73, 618, 2179, 463, 700, 9174);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 245, 769.068, 703.3605, 2188, 2480, 32974, 23147, 33368, 15082, 925.88, 623, 2195, 467, 704, 9199);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 246, 773.922, 707.8815, 2204, 2499, 33233, 23337, 33631, 15193, 932.05, 628, 2211, 471, 708, 9224);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 247, 778.79, 712.416, 2220, 2518, 33493, 23527, 33895, 15304, 938.24, 633, 2227, 475, 712, 9249);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 248, 783.672, 716.964, 2236, 2537, 33754, 23718, 34160, 15416, 944.45, 638, 2243, 479, 716, 9274);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 249, 788.568, 721.5255, 2252, 2556, 34017, 23910, 34426, 15528, 950.6800000000001, 643, 2259, 483, 720, 9299);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 250, 793.478, 726.1005, 2268, 2575, 34281, 24103, 34693, 15640, 956.9300000000001, 648, 2275, 487, 724, 9324);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 251, 798.402, 730.689, 2284, 2594, 34546, 24296, 34961, 15753, 963.2, 653, 2292, 491, 728, 9349);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 252, 803.34, 735.291, 2301, 2613, 34812, 24490, 35230, 15866, 969.49, 658, 2309, 495, 732, 9374);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 253, 808.292, 739.9065, 2318, 2632, 35079, 24685, 35500, 15980, 975.8, 663, 2326, 499, 736, 9399);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 254, 813.258, 744.5355, 2335, 2652, 35347, 24881, 35771, 16094, 982.13, 668, 2343, 503, 740, 9424);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 2, 255, 818.238, 749.178, 2352, 2672, 35616, 25077, 36043, 16208, 988.48, 673, 2360, 507, 744, 9448);

        -- UNIT_CLASS 8
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 64, 94.873, 85.1227, 121, 57, 2397, 1562, 6333, 1269, 131, 37, 92, 278, 279, 1870);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 65, 96.783, 86.6202, 123, 61, 2463, 1610, 6512, 1288, 133, 37, 93, 283, 283, 1896);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 66, 98.707, 88.1232, 126, 65, 2530, 1659, 6694, 1307, 135, 37, 94, 288, 287, 1922);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 67, 100.645, 89.6317, 129, 69, 2598, 1709, 6878, 1326, 137, 37, 95, 293, 291, 1948);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 68, 102.597, 91.1457, 132, 73, 2667, 1760, 7064, 1345, 139, 37, 96, 298, 295, 1974);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 69, 104.563, 92.6652, 135, 77, 2737, 1811, 7253, 1364, 141, 37, 97, 303, 299, 1999);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 70, 106.543, 94.1902, 138, 81, 2808, 1863, 7444, 1383, 143, 37, 98, 308, 304, 2024);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 71, 108.537, 95.7207, 141, 85, 2879, 1916, 7637, 1402, 145, 37, 99, 313, 309, 2049);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 72, 110.545, 97.2567, 144, 89, 2951, 1970, 7833, 1421, 147, 37, 100, 318, 314, 2074);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 73, 112.567, 98.7982, 147, 93, 3024, 2024, 8031, 1440, 149, 37, 101, 323, 319, 2099);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 74, 114.603, 100.3452, 150, 97, 3098, 2079, 8232, 1459, 151, 37, 102, 328, 324, 2124);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 75, 116.653, 101.8977, 153, 101, 3173, 2135, 8435, 1478, 153, 37, 103, 333, 329, 2149);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 76, 118.717, 103.4557, 156, 105, 3249, 2192, 8640, 1497, 155, 37, 104, 338, 334, 2174);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 77, 120.795, 105.0192, 159, 109, 3326, 2249, 8848, 1516, 157, 37, 105, 343, 339, 2199);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 78, 122.887, 106.5882, 162, 113, 3404, 2307, 9058, 1535, 159, 37, 106, 348, 344, 2224);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 79, 124.993, 108.1627, 165, 117, 3483, 2366, 9271, 1554, 161, 37, 107, 353, 349, 2248);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 80, 127.113, 109.7427, 168, 121, 3562, 2426, 9486, 1573, 164, 37, 108, 359, 354, 2272);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 81, 129.247, 111.3282, 171, 125, 3642, 2486, 9703, 1592, 167, 37, 109, 365, 359, 2296);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 82, 131.395, 112.9192, 174, 129, 3723, 2547, 9923, 1611, 170, 37, 110, 371, 364, 2320);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 83, 133.557, 114.5157, 177, 133, 3805, 2609, 10145, 1630, 173, 37, 111, 377, 369, 2344);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 84, 135.733, 116.1177, 180, 137, 3888, 2672, 10370, 1649, 176, 37, 112, 383, 374, 2368);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 85, 137.923, 117.7252, 183, 141, 3972, 2735, 10597, 1668, 179, 37, 113, 389, 379, 2392);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 86, 140.127, 119.3382, 186, 145, 4057, 2799, 10826, 1687, 182, 37, 114, 395, 384, 2416);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 87, 142.345, 120.9567, 189, 150, 4143, 2864, 11058, 1706, 185, 37, 115, 401, 389, 2440);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 88, 144.577, 122.5807, 192, 155, 4230, 2930, 11292, 1725, 188, 37, 116, 407, 394, 2464);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 89, 146.823, 124.2102, 195, 160, 4317, 2996, 11529, 1744, 191, 37, 117, 413, 399, 2487);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 90, 149.083, 125.8452, 198, 165, 4405, 3063, 11768, 1763, 194, 37, 118, 419, 404, 2510);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 91, 151.357, 127.4857, 201, 170, 4494, 3131, 12009, 1782, 197, 37, 119, 425, 409, 2533);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 92, 153.645, 129.1317, 205, 175, 4584, 3200, 12253, 1801, 200, 37, 120, 431, 414, 2556);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 93, 155.947, 130.7832, 209, 180, 4675, 3269, 12499, 1820, 203, 37, 121, 437, 419, 2579);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 94, 158.263, 132.4402, 213, 185, 4767, 3339, 12748, 1839, 206, 37, 122, 443, 424, 2602);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 95, 160.593, 134.1027, 217, 190, 4860, 3410, 12999, 1858, 209, 37, 124, 449, 429, 2625);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 96, 162.937, 135.7707, 221, 195, 4954, 3482, 13252, 1877, 212, 37, 126, 455, 434, 2648);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 97, 165.295, 137.4442, 225, 200, 5049, 3554, 13508, 1896, 215, 37, 128, 461, 439, 2671);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 98, 167.667, 139.1232, 229, 205, 5144, 3627, 13766, 1915, 218, 37, 130, 467, 444, 2694);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 99, 170.053, 140.8077, 233, 210, 5240, 3701, 14027, 1934, 221, 37, 132, 473, 449, 2716);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 100, 172.453, 142.4977, 237, 215, 5337, 3776, 14290, 1953, 224, 37, 134, 479, 454, 2738);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 101, 174.867, 144.1932, 241, 220, 5435, 3851, 14555, 1972, 227, 37, 136, 485, 459, 2760);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 102, 177.295, 145.8942, 245, 225, 5534, 3927, 14823, 1991, 230, 37, 138, 491, 464, 2782);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 103, 179.737, 147.6007, 249, 230, 5634, 4004, 15093, 2010, 233, 37, 140, 497, 469, 2804);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 104, 182.193, 149.3127, 253, 235, 5735, 4082, 15366, 2029, 236, 37, 142, 503, 474, 2826);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 105, 184.663, 151.0302, 257, 240, 5837, 4160, 15641, 2048, 239, 37, 144, 510, 479, 2848);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 106, 187.147, 152.7532, 261, 245, 5940, 4239, 15918, 2067, 242, 37, 146, 517, 484, 2870);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 107, 189.645, 154.4817, 265, 250, 6043, 4319, 16198, 2086, 245, 37, 148, 524, 489, 2892);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 108, 192.157, 156.2157, 269, 255, 6147, 4400, 16480, 2105, 248, 37, 150, 531, 494, 2914);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 109, 194.683, 157.9552, 273, 260, 6252, 4481, 16765, 2124, 251, 37, 152, 538, 499, 2935);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 110, 197.223, 159.7002, 277, 265, 6358, 4563, 17052, 2143, 254, 37, 154, 545, 504, 2956);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 111, 199.777, 161.4507, 281, 271, 6465, 4646, 17341, 2162, 257, 37, 156, 552, 509, 2977);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 112, 202.345, 163.2067, 285, 277, 6573, 4730, 17633, 2181, 260, 37, 158, 559, 515, 2998);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 113, 204.927, 164.9682, 289, 283, 6682, 4814, 17927, 2200, 263, 37, 160, 566, 521, 3019);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 114, 207.523, 166.7352, 293, 289, 6792, 4899, 18223, 2219, 266, 37, 162, 573, 527, 3040);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 115, 210.133, 168.5077, 297, 295, 6903, 4985, 18522, 2238, 269, 37, 164, 580, 533, 3061);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 116, 212.757, 170.2857, 301, 301, 7014, 5072, 18823, 2257, 272, 37, 166, 587, 539, 3082);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 117, 215.395, 172.0692, 305, 307, 7126, 5159, 19127, 2276, 275, 37, 168, 594, 545, 3103);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 118, 218.047, 173.8582, 309, 313, 7239, 5247, 19433, 2295, 278, 37, 170, 601, 551, 3124);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 119, 220.713, 175.6527, 314, 319, 7353, 5336, 19741, 2314, 281, 37, 172, 608, 557, 3144);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 120, 223.393, 177.4527, 319, 325, 7468, 5426, 20052, 2333, 285, 37, 174, 615, 563, 3164);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 121, 226.087, 179.2582, 324, 331, 7584, 5516, 20365, 2352, 289, 37, 176, 622, 569, 3184);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 122, 228.795, 181.0692, 329, 337, 7701, 5607, 20681, 2371, 293, 37, 178, 629, 575, 3204);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 123, 231.517, 182.8857, 334, 343, 7819, 5699, 20999, 2390, 297, 37, 180, 636, 581, 3224);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 124, 234.253, 184.7077, 339, 349, 7937, 5792, 21319, 2409, 301, 37, 182, 643, 587, 3244);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 125, 237.003, 186.5352, 344, 355, 8056, 5885, 21642, 2428, 305, 37, 184, 650, 593, 3264);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 126, 239.767, 188.3682, 349, 361, 8176, 5979, 21967, 2447, 309, 37, 186, 657, 599, 3284);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 127, 242.545, 190.2067, 354, 367, 8297, 6074, 22295, 2466, 313, 37, 188, 664, 605, 3304);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 128, 245.337, 192.0507, 359, 373, 8419, 6170, 22625, 2485, 317, 37, 190, 671, 611, 3324);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 129, 248.143, 193.9002, 364, 379, 8542, 6266, 22957, 2504, 321, 37, 192, 678, 617, 3343);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 130, 250.963, 195.7552, 369, 385, 8666, 6363, 23292, 2523, 325, 37, 194, 686, 623, 3362);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 131, 253.797, 197.6157, 374, 391, 8791, 6461, 23629, 2542, 329, 37, 196, 694, 629, 3381);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 132, 256.645, 199.4817, 379, 397, 8917, 6560, 23969, 2561, 333, 37, 198, 702, 635, 3400);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 133, 259.507, 201.3532, 384, 403, 9043, 6659, 24311, 2580, 337, 37, 200, 710, 641, 3419);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 134, 262.383, 203.2302, 389, 409, 9170, 6759, 24655, 2599, 341, 37, 202, 718, 647, 3438);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 135, 265.273, 205.1127, 394, 416, 9298, 6860, 25002, 2618, 345, 37, 204, 726, 653, 3457);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 136, 268.177, 207.0007, 399, 423, 9427, 6962, 25351, 2637, 349, 37, 206, 734, 659, 3476);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 137, 271.095, 208.8942, 404, 430, 9557, 7064, 25703, 2656, 353, 37, 208, 742, 665, 3495);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 138, 274.027, 210.7932, 409, 437, 9688, 7167, 26057, 2675, 357, 37, 210, 750, 671, 3514);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 139, 276.973, 212.6977, 414, 444, 9820, 7271, 26413, 2694, 361, 37, 212, 758, 677, 3532);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 140, 279.933, 214.6077, 419, 451, 9953, 7376, 26772, 2713, 365, 37, 214, 766, 683, 3550);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 141, 282.907, 216.5232, 424, 458, 10087, 7481, 27133, 2732, 369, 37, 216, 774, 689, 3568);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 142, 285.895, 218.4442, 429, 465, 10221, 7587, 27497, 2751, 373, 37, 218, 782, 695, 3586);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 143, 288.897, 220.3707, 434, 472, 10356, 7694, 27863, 2770, 377, 37, 220, 790, 701, 3604);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 144, 291.913, 222.3027, 439, 479, 10492, 7802, 28231, 2789, 381, 37, 222, 798, 707, 3622);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 145, 294.943, 224.2402, 444, 486, 10629, 7910, 28602, 2808, 385, 37, 224, 806, 713, 3640);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 146, 297.987, 226.1832, 450, 493, 10767, 8019, 28975, 2827, 389, 37, 226, 814, 719, 3658);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 147, 301.045, 228.1317, 456, 500, 10906, 8129, 29351, 2846, 393, 37, 228, 822, 725, 3676);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 148, 304.117, 230.0857, 462, 508, 11046, 8240, 29729, 2865, 397, 37, 230, 830, 731, 3694);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 149, 307.203, 232.0452, 468, 516, 11187, 8351, 30109, 2884, 401, 37, 232, 838, 737, 3711);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 150, 310.303, 234.0102, 474, 524, 11329, 8463, 30492, 2903, 405, 37, 234, 846, 743, 3728);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 151, 313.417, 235.9807, 480, 532, 11471, 8576, 30877, 2922, 409, 37, 236, 854, 749, 3745);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 152, 316.545, 237.9567, 486, 540, 11614, 8690, 31264, 2941, 413, 37, 238, 862, 755, 3762);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 153, 319.687, 239.9382, 492, 548, 11758, 8804, 31654, 2960, 417, 37, 240, 870, 761, 3779);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 154, 322.843, 241.9252, 498, 556, 11903, 8919, 32046, 2979, 421, 37, 242, 878, 768, 3796);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 155, 326.013, 243.9177, 504, 564, 12049, 9035, 32441, 2998, 425, 37, 244, 887, 775, 3813);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 156, 329.197, 245.9157, 510, 572, 12196, 9152, 32838, 3017, 429, 37, 246, 896, 782, 3830);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 157, 332.395, 247.9192, 516, 580, 12344, 9269, 33237, 3036, 433, 37, 248, 905, 789, 3847);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 158, 335.607, 249.9282, 522, 588, 12493, 9387, 33639, 3055, 437, 37, 250, 914, 796, 3864);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 159, 338.833, 251.9427, 528, 597, 12643, 9506, 34043, 3074, 441, 37, 252, 923, 803, 3880);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 160, 342.073, 253.9627, 534, 606, 12793, 9626, 34450, 3093, 446, 37, 254, 932, 810, 3896);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 161, 345.327, 255.9882, 540, 615, 12944, 9746, 34859, 3112, 451, 37, 256, 941, 817, 3912);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 162, 348.595, 258.0192, 546, 624, 13096, 9867, 35270, 3131, 456, 37, 258, 950, 824, 3928);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 163, 351.877, 260.0557, 552, 633, 13249, 9989, 35684, 3150, 461, 37, 260, 959, 831, 3944);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 164, 355.173, 262.0977, 558, 642, 13403, 10112, 36100, 3169, 466, 37, 262, 968, 838, 3960);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 165, 358.483, 264.1452, 564, 651, 13558, 10235, 36519, 3188, 471, 37, 264, 977, 845, 3976);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 166, 361.807, 266.1982, 570, 660, 13714, 10359, 36940, 3207, 476, 37, 266, 986, 852, 3992);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 167, 365.145, 268.2567, 576, 669, 13871, 10484, 37363, 3226, 481, 37, 268, 995, 859, 4008);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 168, 368.497, 270.3207, 582, 678, 14029, 10610, 37789, 3245, 486, 37, 270, 1004, 866, 4024);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 169, 371.863, 272.3902, 588, 687, 14187, 10736, 38217, 3264, 491, 37, 273, 1013, 873, 4039);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 170, 375.243, 274.4652, 594, 696, 14346, 10863, 38648, 3283, 496, 37, 276, 1022, 880, 4054);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 171, 378.637, 276.5457, 600, 705, 14506, 10991, 39081, 3302, 501, 37, 279, 1031, 887, 4069);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 172, 382.045, 278.6317, 607, 714, 14667, 11120, 39516, 3321, 506, 37, 282, 1040, 894, 4084);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 173, 385.467, 280.7232, 614, 723, 14829, 11249, 39954, 3340, 511, 37, 285, 1049, 901, 4099);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 174, 388.903, 282.8202, 621, 732, 14992, 11379, 40394, 3359, 516, 37, 288, 1058, 908, 4114);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 175, 392.353, 284.9227, 628, 741, 15156, 11510, 40837, 3378, 521, 37, 291, 1067, 915, 4129);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 176, 395.817, 287.0307, 635, 750, 15321, 11642, 41282, 3397, 526, 37, 294, 1076, 922, 4144);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 177, 399.295, 289.1442, 642, 759, 15487, 11774, 41729, 3416, 531, 37, 297, 1085, 929, 4159);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 178, 402.787, 291.2632, 649, 768, 15653, 11907, 42179, 3435, 536, 37, 300, 1094, 936, 4174);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 179, 406.293, 293.3877, 656, 777, 15820, 12041, 42631, 3454, 541, 37, 303, 1103, 943, 4188);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 180, 409.813, 295.5177, 663, 786, 15988, 12176, 43086, 3473, 546, 37, 306, 1113, 950, 4202);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 181, 413.347, 297.6532, 670, 795, 16157, 12311, 43543, 3492, 551, 37, 309, 1123, 957, 4216);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 182, 416.895, 299.7942, 677, 804, 16327, 12447, 44002, 3511, 556, 37, 312, 1133, 964, 4230);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 183, 420.457, 301.9407, 684, 814, 16498, 12584, 44464, 3530, 561, 37, 315, 1143, 971, 4244);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 184, 424.033, 304.0927, 691, 824, 16670, 12722, 44928, 3549, 566, 37, 318, 1153, 978, 4258);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 185, 427.623, 306.2502, 698, 834, 16843, 12860, 45395, 3568, 571, 37, 321, 1163, 985, 4272);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 186, 431.227, 308.4132, 705, 844, 17017, 12999, 45864, 3587, 576, 37, 324, 1173, 992, 4286);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 187, 434.845, 310.5817, 712, 854, 17191, 13139, 46335, 3606, 581, 37, 327, 1183, 999, 4300);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 188, 438.477, 312.7557, 719, 864, 17366, 13280, 46809, 3625, 586, 37, 330, 1193, 1006, 4314);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 189, 442.123, 314.9352, 726, 874, 17542, 13421, 47285, 3644, 591, 37, 333, 1203, 1013, 4327);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 190, 445.783, 317.1202, 733, 884, 17719, 13563, 47764, 3663, 596, 37, 336, 1213, 1020, 4340);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 191, 449.457, 319.3107, 740, 894, 17897, 13706, 48245, 3682, 601, 37, 339, 1223, 1027, 4353);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 192, 453.145, 321.5067, 747, 904, 18076, 13850, 48728, 3701, 606, 37, 342, 1233, 1034, 4366);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 193, 456.847, 323.7082, 754, 914, 18256, 13994, 49214, 3720, 611, 37, 345, 1243, 1041, 4379);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 194, 460.563, 325.9152, 761, 924, 18437, 14139, 49702, 3739, 616, 37, 348, 1253, 1048, 4392);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 195, 464.293, 328.1277, 768, 934, 18619, 14285, 50192, 3758, 621, 37, 351, 1263, 1056, 4405);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 196, 468.037, 330.3457, 775, 944, 18801, 14432, 50685, 3777, 626, 37, 354, 1273, 1064, 4418);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 197, 471.795, 332.5692, 782, 954, 18984, 14579, 51180, 3796, 631, 37, 357, 1283, 1072, 4431);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 198, 475.567, 334.7982, 789, 964, 19168, 14727, 51678, 3815, 636, 37, 360, 1293, 1080, 4444);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 199, 479.353, 337.0327, 797, 974, 19353, 14876, 52178, 3834, 641, 37, 363, 1303, 1088, 4456);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 200, 483.153, 339.2727, 805, 984, 19539, 15026, 52680, 3853, 647, 37, 366, 1313, 1096, 4468);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 201, 486.967, 341.5182, 813, 994, 19726, 15176, 53185, 3872, 653, 37, 369, 1323, 1104, 4480);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 202, 490.795, 343.7692, 821, 1004, 19914, 15327, 53692, 3891, 659, 37, 372, 1333, 1112, 4492);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 203, 494.637, 346.0257, 829, 1014, 20103, 15479, 54202, 3910, 665, 37, 375, 1343, 1120, 4504);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 204, 498.493, 348.2877, 837, 1024, 20293, 15632, 54714, 3929, 671, 37, 378, 1353, 1128, 4516);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 205, 502.363, 350.5552, 845, 1034, 20483, 15785, 55228, 3948, 677, 37, 381, 1364, 1136, 4528);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 206, 506.247, 352.8282, 853, 1045, 20674, 15939, 55745, 3967, 683, 37, 384, 1375, 1144, 4540);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 207, 510.145, 355.1067, 861, 1056, 20866, 16094, 56264, 3986, 689, 37, 387, 1386, 1152, 4552);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 208, 514.057, 357.3907, 869, 1067, 21059, 16250, 56786, 4005, 695, 37, 390, 1397, 1160, 4564);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 209, 517.983, 359.6802, 877, 1078, 21253, 16406, 57310, 4024, 701, 37, 393, 1408, 1168, 4575);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 210, 521.923, 361.9752, 885, 1089, 21448, 16563, 57836, 4043, 707, 37, 396, 1419, 1176, 4586);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 211, 525.877, 364.2757, 893, 1100, 21644, 16721, 58365, 4062, 713, 37, 399, 1430, 1184, 4597);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 212, 529.845, 366.5817, 901, 1111, 21841, 16880, 58896, 4081, 719, 37, 402, 1441, 1192, 4608);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 213, 533.827, 368.8932, 909, 1122, 22039, 17039, 59430, 4100, 725, 37, 405, 1452, 1200, 4619);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 214, 537.823, 371.2102, 917, 1133, 22237, 17199, 59966, 4119, 731, 37, 408, 1463, 1208, 4630);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 215, 541.833, 373.5327, 925, 1144, 22436, 17360, 60504, 4138, 737, 37, 411, 1474, 1216, 4641);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 216, 545.857, 375.8607, 933, 1155, 22636, 17522, 61045, 4157, 743, 37, 414, 1485, 1224, 4652);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 217, 549.895, 378.1942, 941, 1166, 22837, 17684, 61588, 4176, 749, 37, 417, 1496, 1232, 4663);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 218, 553.947, 380.5332, 949, 1177, 23039, 17847, 62134, 4195, 755, 37, 420, 1507, 1240, 4674);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 219, 558.013, 382.8777, 957, 1188, 23242, 18011, 62682, 4214, 761, 37, 423, 1518, 1248, 4684);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 220, 562.093, 385.2277, 965, 1199, 23446, 18176, 63232, 4233, 767, 37, 426, 1529, 1256, 4694);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 221, 566.187, 387.5832, 973, 1210, 23651, 18341, 63785, 4252, 773, 37, 429, 1540, 1264, 4704);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 222, 570.295, 389.9442, 981, 1221, 23857, 18507, 64340, 4271, 779, 37, 432, 1551, 1272, 4714);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 223, 574.417, 392.3107, 989, 1232, 24063, 18674, 64898, 4290, 785, 37, 435, 1562, 1280, 4724);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 224, 578.553, 394.6827, 997, 1243, 24270, 18842, 65458, 4309, 791, 37, 438, 1573, 1288, 4734);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 225, 582.703, 397.0602, 1005, 1254, 24478, 19010, 66020, 4328, 797, 37, 441, 1584, 1296, 4744);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 226, 586.867, 399.4432, 1014, 1265, 24687, 19179, 66585, 4347, 803, 37, 444, 1595, 1304, 4754);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 227, 591.045, 401.8317, 1023, 1276, 24897, 19349, 67152, 4366, 809, 37, 447, 1606, 1312, 4764);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 228, 595.237, 404.2257, 1032, 1287, 25108, 19520, 67722, 4385, 815, 37, 450, 1617, 1320, 4774);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 229, 599.443, 406.6252, 1041, 1298, 25320, 19691, 68294, 4404, 821, 37, 453, 1628, 1328, 4783);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 230, 603.663, 409.0302, 1050, 1310, 25533, 19863, 68868, 4423, 827, 37, 456, 1640, 1336, 4792);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 231, 607.897, 411.4407, 1059, 1322, 25747, 20036, 69445, 4442, 833, 37, 459, 1652, 1344, 4801);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 232, 612.145, 413.8567, 1068, 1334, 25961, 20210, 70024, 4461, 839, 37, 462, 1664, 1352, 4810);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 233, 616.407, 416.2782, 1077, 1346, 26176, 20384, 70605, 4480, 845, 37, 465, 1676, 1360, 4819);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 234, 620.683, 418.7052, 1086, 1358, 26392, 20559, 71189, 4499, 851, 37, 468, 1688, 1368, 4828);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 235, 624.973, 421.1377, 1095, 1370, 26609, 20735, 71775, 4518, 857, 37, 471, 1700, 1376, 4837);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 236, 629.277, 423.5757, 1104, 1382, 26827, 20912, 72364, 4537, 863, 37, 474, 1712, 1384, 4846);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 237, 633.595, 426.0192, 1113, 1394, 27046, 21089, 72955, 4556, 869, 37, 477, 1724, 1393, 4855);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 238, 637.927, 428.4682, 1122, 1406, 27266, 21267, 73548, 4575, 875, 37, 480, 1736, 1402, 4864);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 239, 642.273, 430.9227, 1131, 1418, 27487, 21446, 74144, 4594, 881, 37, 483, 1748, 1411, 4872);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 240, 646.633, 433.3827, 1140, 1430, 27709, 21626, 74742, 4613, 888, 37, 486, 1760, 1420, 4880);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 241, 651.007, 435.8482, 1149, 1442, 27931, 21806, 75343, 4632, 895, 37, 489, 1772, 1429, 4888);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 242, 655.395, 438.3192, 1158, 1454, 28154, 21987, 75946, 4651, 902, 37, 492, 1784, 1438, 4896);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 243, 659.797, 440.7957, 1167, 1466, 28378, 22169, 76551, 4670, 909, 37, 496, 1796, 1447, 4904);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 244, 664.213, 443.2777, 1176, 1478, 28603, 22352, 77159, 4689, 916, 37, 500, 1808, 1456, 4912);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 245, 668.643, 445.7652, 1185, 1490, 28829, 22535, 77769, 4708, 923, 37, 504, 1820, 1465, 4920);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 246, 673.087, 448.2582, 1194, 1502, 29056, 22719, 78382, 4727, 930, 37, 508, 1832, 1474, 4928);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 247, 677.545, 450.7567, 1203, 1514, 29284, 22904, 78997, 4746, 937, 37, 512, 1844, 1483, 4936);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 248, 682.017, 453.2607, 1212, 1526, 29513, 23090, 79614, 4765, 944, 37, 516, 1856, 1492, 4944);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 249, 686.503, 455.7702, 1221, 1538, 29742, 23276, 80234, 4784, 951, 37, 520, 1868, 1501, 4951);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 250, 691.003, 458.2852, 1230, 1550, 29972, 23463, 80856, 4803, 958, 37, 524, 1880, 1510, 4958);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 251, 695.517, 460.8057, 1239, 1562, 30203, 23651, 81481, 4822, 965, 37, 528, 1892, 1519, 4965);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 252, 700.045, 463.3317, 1249, 1574, 30435, 23840, 82108, 4841, 972, 37, 532, 1904, 1528, 4972);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 253, 704.587, 465.8632, 1259, 1586, 30668, 24029, 82737, 4860, 979, 37, 536, 1916, 1537, 4979);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 254, 709.143, 468.4002, 1269, 1599, 30902, 24219, 83369, 4879, 986, 37, 540, 1928, 1546, 4986);
        INSERT INTO `creature_classlevelstats` VALUES (NULL, 8, 255, 713.713, 470.9427, 1279, 1612, 31137, 24410, 84003, 4898, 993, 37, 544, 1941, 1555, 4993);


        -- SOME LEVEL CORRECTION

        -- Stormwind City Guard
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 68;

        -- Stormwind Royal Guard
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 1756;

        -- Stormwind City Patroller
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 1976;

        -- Elanaria
        UPDATE `creature_template` SET `level_min`= 65, `level_max`= 65 WHERE `entry`= 4088;
        
        -- Thrall
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 4949;

        -- Cairne
        UPDATE `creature_template` SET `level_min`= 100, `level_max`= 100 WHERE `entry`= 3057;     

        -- Orgrimmar Grunt
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 3296;     
        
        -- Dungar Longdrink
        UPDATE `creature_template` SET `level_min`= 10, `level_max`= 10 WHERE `entry`= 352;     
        
        -- Angus Stern
        UPDATE `creature_template` SET `level_min`= 70, `level_max`= 70 WHERE `entry`= 1141;     
        
        -- Zardeth of the Black Claw
        UPDATE `creature_template` SET `level_min`= 70, `level_max`= 70 WHERE `entry`= 1135;     
        
        -- Highlord Bolvar Fordragon
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 1748;     

        -- Lord Daval Prestor
        UPDATE `creature_template` SET `level_min`= 75, `level_max`= 75 WHERE `entry`= 1749;     
        
        -- Bluffwatcher
        UPDATE `creature_template` SET `level_min`= 75, `level_max`= 75 WHERE `entry`= 3084;     
        
        -- Honor Guard
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 3083;     
                
        -- Undercity Guardian
        UPDATE `creature_template` SET `level_min`= 90, `level_max`= 90 WHERE `entry`= 5624;     
        
        -- VARIOUS DB FIXES

        -- CAMP TAURAJO, despawn some guards
        UPDATE `spawns_creatures` SET `ignored` = 1 WHERE `spawn_id`IN (19384, 19399, 19400, 19379, 19383, 19357, 19358, 19381, 19401, 19382);

        -- Remove torch in Greatwood Vale
        update `spawns_gameobjects` set `ignored` = 1 where `spawn_id` IN (47502, 47504, 47486, 30232, 30226);

        -- Correct campfire location in Greatwood Vale
        UPDATE `spawns_gameobjects` SET `spawn_positionX` = 126.667, `spawn_positionY` = -362.093, `spawn_positionZ` = 3.616 WHERE `spawn_id` = 34176;

        -- WAYPOINTS FOR ZUL FARRAK

        UPDATE `spawns_creatures` SET `movement_type` = 2 WHERE `spawn_id`IN (400182, 400157, 400126, 39666, 400123);
        INSERT INTO creature_movement VALUES (400184, 1, -6197.812, -2927.01, 14.318, 1, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400184, 2, -6207.812, -2979.56, 14.284, 1, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 1, -6629.31103515625, -2914.589111328125, 8.890827178955078, 2.792034387588501, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 2, -6644.35009765625, -2912.31640625, 8.964310646057129, 3.0237269401550293, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 3, -6664.6298828125, -2906.72998046875, 8.890830039978027, 2.979740619659424, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 4, -6674.16845703125, -2903.486083984375, 8.890828132629395, 2.506145715713501, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 5, -6651.21435546875, -2911.152587890625, 9.086282730102539, 6.01216459274292, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 6, -6589.48193359375, -2921.39404296875, 8.887046813964844, 6.215582847595215, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400182, 7, -6627.232421875, -2914.906005859375, 8.890827178955078, 6.071069717407227, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 1, -6629.80712890625, -2918.236083984375, 8.890827178955078, 2.9365475177764893, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 2, -6645.486328125, -2915.03076171875, 8.890829086303711, 2.882355213165283, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 3, -6667.234375, -2909.262939453125, 8.883689880371094, 2.882355213165283, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 4, -6676.60205078125, -2906.442138671875, 8.999785423278809, 2.7951719760894775, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 5, -6652.68017578125, -2914.4462890625, 8.890829086303711, 6.109553813934326, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 6, -6628.705078125, -2918.1484375, 8.890827178955078, 6.168458938598633, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400183, 7, -6594.2548828125, -2922.1181640625, 8.882157325744629, 6.168458938598633, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400213, 1, -6566.318359375, -2922.197021484375, 8.954911231994629, 3.4714066982269287, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400213, 2, -6574.068359375, -2924.845703125, 8.954911231994629, 2.942833423614502, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400213, 3, -6621.86962890625, -2917.2861328125, 8.890827178955078, 2.9601120948791504, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400213, 4, -6587.34375, -2923.382568359375, 8.881696701049805, 6.089925289154053, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400213, 5, -6505.09814453125, -2900.929931640625, 8.890827178955078, 0.3431669771671295, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400177, 1, -6509.85888671875, -2935.16552734375, 8.890824317932129, 2.139373540878296, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400177, 2, -6526.89208984375, -2908.5078125, 8.890829086303711, 0.27954983711242676, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400177, 3, -6493.01611328125, -2897.593505859375, 8.879341125488281, 0.24185070395469666, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400177, 4, -6478.18505859375, -2908.78662109375, 8.891790390014648, 4.084017753601074, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400210, 1, -6412.9169921875, -2860.73193359375, 8.891433715820312, 0.6133419275283813, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400210, 2, -6377.13720703125, -2848.857666015625, 8.891433715820312, 0.29525554180145264, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400210, 3, -6421.66162109375, -2868.473876953125, 8.891790390014648, 3.593144178390503, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400210, 4, -6455.447265625, -2896.172607421875, 8.891790390014648, 3.814626455307007, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400165, 1, -6403.5390625, -2866.319580078125, 8.890827178955078, 0.6094178557395935, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400165, 2, -6377.92236328125, -2853.43017578125, 8.891433715820312, 0.390291690826416, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400157, 3, -6312.1318359375, -2828.310546875, 8.876791954040527, 2.4040536880493164, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400157, 4, -6362.19091796875, -2788.931640625, 8.876775741577148, 2.4417526721954346, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400157, 5, -6380.79736328125, -2751.669189453125, 9.533853530883789, 2.023920774459839, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400157, 6, -6365.16064453125, -2788.013916015625, 8.876775741577148, 5.104253768920898, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400157, 7, -6318.34912109375, -2825.16796875, 8.876791954040527, 5.620260238647461, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400157, 8, -6312.65673828125, -2845.724365234375, 8.876787185668945, 4.982516765594482, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400158, 1, -6321.4052734375, -2879.890380859375, 8.876787185668945, 1.221246361732483, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400158, 2, -6341.216796875, -2929.573486328125, 8.876785278320312, 4.3369221687316895, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400198, 1, -6254.74609375, -2901.07275390625, 8.876786231994629, 3.6434149742126465, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400198, 2, -6293.07763671875, -2922.341064453125, 8.876786231994629, 3.6159262657165527, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400126, 1, -6135.7861328125, -2753.25146484375, 8.8818941116333, 0.7500072121620178, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400126, 2, -6126.27685546875, -2750.72265625, 8.87679386138916, 0.25991854071617126, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400126, 3, -6136.99755859375, -2754.83935546875, 8.8818941116333, 4.172771453857422, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400126, 4, -6176.95849609375, -2819.585205078125, 8.903288841247559, 4.1680588722229, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400121, 1, -6147.2041015625, -2672.5703125, 8.876791000366211, 5.101113796234131, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400121, 2, -6136.89697265625, -2697.736328125, 8.876791954040527, 5.101113796234131, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400121, 3, -6148.0615234375, -2673.720458984375, 8.876790046691895, 1.0516016483306885, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400121, 4, -6120.59423828125, -2624.16748046875, 8.959833145141602, 1.0516016483306885, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400144, 1, -6290.5625, -2540.610107421875, 9.18094253540039, 0.8065624833106995, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400144, 2, -6333.1787109375, -2583.39306640625, 8.876781463623047, 3.941084861755371, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 1, -6292.35107421875, -2521.233642578125, 8.876777648925781, 4.74611759185791, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 2, -6292.21240234375, -2548.15625, 8.908246994018555, 3.934800863265991, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 3, -6345.84375, -2603.046142578125, 9.025752067565918, 4.021194934844971, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 4, -6368.291015625, -2575.3828125, 8.968757629394531, 2.2524774074554443, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 5, -6367.90966796875, -2548.494873046875, 9.03447151184082, 0.8371893167495728, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 6, -6328.72265625, -2509.279541015625, 8.876777648925781, 0.8364039063453674, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400123, 7, -6300.171875, -2486.81298828125, 9.323782920837402, 5.759279251098633, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 1, -6437.015625, -2721.98681640625, 8.876777648925781, 2.103252410888672, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 2, -6426.873046875, -2679.963134765625, 8.876779556274414, 1.2479534149169922, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 3, -6416.369140625, -2651.72412109375, 8.876779556274414, 1.2228206396102905, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 4, -6406.54833984375, -2635.42626953125, 8.876778602600098, 0.8905970454216003, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 5, -6428.58935546875, -2679.637939453125, 8.876779556274414, 4.266239643096924, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 6, -6435.70068359375, -2722.623779296875, 8.876777648925781, 5.463972091674805, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400241, 7, -6410.4580078125, -2749.652099609375, 9.22799301147461, 5.539370536804199, 0, 0, 0);

        -- KAERBRUS WAYPOINTS

        INSERT INTO creature_movement VALUES (39666, 1, -8747.017578125, 985.604736328125, 97.89386749267578, 1.147691011428833, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 2, -8731.4912109375, 1003.0662231445312, 95.74864196777344, 1.5757335424423218, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 3, -8731.6025390625, 1025.5859375, 94.298828125, 1.723388433456421, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 4, -8739.7177734375, 1060.01025390625, 89.67137908935547, 2.1286540031433105, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 5, -8772.416015625, 1066.4442138671875, 90.78028106689453, 2.7546167373657227, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 6, -8788.599609375, 1075.42626953125, 90.78028106689453, 1.8961759805679321, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 7, -8797.1552734375, 1103.9505615234375, 90.78028869628906, 1.3927356004714966, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 8, -8791.830078125, 1133.473876953125, 90.78028106689453, 0.7204344868659973, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 9, -8770.6796875, 1146.765380859375, 90.78028106689453, 0.023000624030828476, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 10, -8750.0654296875, 1146.82470703125, 90.32986450195312, 5.93704891204834, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 11, -8727.994140625, 1137.1412353515625, 90.44760131835938, 5.395909309387207, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 12, -8716.0078125, 1106.9197998046875, 90.50601196289062, 4.500555515289307, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 13, -8714.85546875, 1084.73046875, 90.722412109375, 4.373321056365967, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 14, -8717.982421875, 1075.8656005859375, 95.16466522216797, 3.883232593536377, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 15, -8724.9140625, 1069.515869140625, 95.5447769165039, 3.883232593536377, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 16, -8738.9501953125, 1061.408203125, 89.65679931640625, 4.8414177894592285, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 17, -8730.677734375, 1010.927490234375, 95.41535186767578, 4.0976457595825195, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 18, -8747.5849609375, 989.341796875, 97.60567474365234, 4.858696937561035, 0, 0, 0);
        INSERT INTO creature_movement VALUES (39666, 19, -8743.4677734375, 968.7826538085938, 99.21542358398438, 4.831207752227783, 0, 0, 0);
        
        -- TANARIS adjustements

        -- Correct a lost goblin to look less random
        UPDATE `spawns_creatures` SET `position_x` = -7152.677, `position_y` = -3826.417, `position_z` = 8.378, `orientation`= 0.821  WHERE `spawn_id` = 23443;
        
        -- Despawn GO over the beach at 1.12 pirates location
        update `spawns_gameobjects` set `ignored` = 1 where `spawn_id` IN (17336, 17330, 17338, 17339, 17340, 17350, 17351, 17354, 17343, 17344, 17244, 17349, 17346, 17347, 17348, 17345, 17341);

        -- Correct z, half inserted into floor
        update `spawns_creatures` set `position_z` = 142.24 where `spawn_id` = 26631;


        -- TIRISFAL

        -- Despawn GO at the WPL entrance
        update `spawns_gameobjects` set `ignored` = 1 where `spawn_id` IN (44778, 44795, 45059, 88087, 44771, 44767, 44780, 44802, 44769);

        -- ALTERAC

        -- Despawn Tarren Mill Deathguard at Alterac valley entrance
        update `spawns_creatures` set `ignored` = 1 where `spawn_id` IN (16600, 16602, 16607, 16601);

        -- ARATHI

        -- Despawn Hammerfall guard at Arathi Bassin entrance
        update `spawns_creatures` set `ignored` = 1 where `spawn_id` IN (11237, 11205, 11253, 11240, 11235, 11236, 11212);

        -- ULDAMAN
        
        -- Forgot to change a dwarf to trogg at uldaman entrance
        update `spawns_creatures` set `spawn_entry1` = 2890 where `spawn_id` IN(8187, 8190, 7714);

        -- Boar display_id #1149
        UPDATE `creature_template` SET `display_id1`= 744 WHERE `entry`= 1689;

        -- Lord Maldazzar, given its vanilla display_id he probably use default human caster PH
        UPDATE `creature_template` SET `display_id1`= 263 WHERE `entry`= 1848;

        -- Morbent Fell, most of named caster use default human caster PH as well
        UPDATE `creature_template` SET `display_id1`= 263 WHERE `entry`= 1200; 

        -- Skeletal sorcerer, now we know that caster skel mostly use 201, we set display_id 201
        UPDATE `creature_template` SET `display_id1`= 201 WHERE `entry`= 1784; 

        -- Closes #1288
        UPDATE `creature_template` SET `name`= "Tauren Horde Runner" WHERE `entry`= 2478;
        UPDATE `creature_template` SET `name`= "Orc Horde Runner" WHERE `entry`= 2477; 
        -- this guy has waypoints, we reuse Thargromm original spawn
        update `spawns_creatures` set `ignored` = 0, `spawn_entry1`=2477 where `spawn_id` = 9205;

        -- QUESTS

        -- 844
        UPDATE `quest_template` SET `RewOrReqMoney`= 405, `RewXP` = 1200, `Details` = "So you want to help, %n? There are many things in the Barrens that need attention. However, before I turn your attention towards them, you should first learn a lesson.%B%BYes, I think that is exactly what you need. The greater plainstriders to the east have been harassing some of our food supplies and have become a general nuisance.%B%BPut down the greater plainstriders and return to me seven of their beaks. With their numbers reduced, perhaps they will not look to our foodstores for their daily meal.", `OfferRewardText` = "I feel the spirits of the Greater Plainstriders call out to me, can you not hear them? Ponder their deaths, %n, for I sense that you do not truly understand what it is you have done.%B%BThere will be a falling out because of your actions here today. You have no choice but to follow it through to the end now. Speak with me again, when you are ready." WHERE `entry`= 844; 

        -- 845
        UPDATE `quest_template` SET `RewOrReqMoney`= 467, `RewXP` = 1300, `Details` = "There is an interdependency between the zhevra and the plainstriders. The plainstrider's constant scratching and pecking of the land actually tills the soil, allowing the plants that the zhevra eat to propogate.%B%BWithout steady food, the zhevra have become agitated and encroach upon our field grains. Though your initial path was faulty, we must continue.%B%BSlay the zhevra runners to the north and bring me four zhevra hooves", `OfferRewardText` = "With a good number of Zhevra Runners slaughtered, the orcish graints are safe again. I worry though what effect the deaths of so many Zhevra will have upon the beasts surrounding the Crossroads. Worry not, young one. The mystery of my teachings will become clear in time." WHERE `entry`= 845; 

        -- 903
        UPDATE `quest_template` SET `RewOrReqMoney`= 607, `ReqItemCount1` = 10, `Objectives` = "Collect 10 Prowler Claws from Savannah Prowlers for Sergra Darkthorn in the Crossroads.", `Details` = "It would seem our previous actions return to haunt us. WIth the Zhevra and Plainstrider game diminished, the Savannah Prowlers have turned upon our people as they use the southern road.%B%BGo south and collect 10 Prowler Claws and we just might reach an equilibrium again.", `RequestItemsText`="Hurry, young one. The lives of those around the Crossroads are in your hands. Do you have the 10 Prowler Claws I requested?", `OfferRewardText` = "Well done, young one. Though the bloodshed here seems senseless, I can feel that the lessons of the Earthmother are close to your heart. There are few steps left to complete this circle, but soon you shall have the whole of the picture." WHERE `entry`= 903; 

        -- 905
        UPDATE `quest_template` SET `RewOrReqMoney`= 765, `RewXP` = 1300 WHERE `entry`=905;

        -- 881
        UPDATE `quest_template` SET `RewXP` = 2200 WHERE `entry`=881;
        UPDATE `creature_template` SET `level_min`= 17, `level_max`=17 WHERE `entry`= 3475;

        -- 882
        UPDATE `quest_template` SET `RewXP` = 2300, `Details` = "Ishamuhale, Speartooth, is the fiercest sunscale raptor of the Barrens. He does not hunt for sport, nor for food. He hunts because hunting is his passion. He kills because it is his nature to kill.%B%BAnd you will learn of his nature, %n, for your path now follows the taloned tracks of Ishamuhale.%B%BBegin the hunt. He roams to the east of the Crossroads, where his lesser brothers and sisters stalk their prey." WHERE `entry`=882;
        INSERT INTO `spawns_creatures` VALUES (NULL, 3257, 0, 0, 0, 1, -512, -3485.9, 95.24, 3, 300, 300, 50, 100, 0, 1, 0, 0, 0);

        -- Mull, partial #695
        UPDATE `spawns_creatures` SET `position_x` = -2298.616, `position_y` = -505.560, `position_z` = -8.228, `orientation`= 4.294  WHERE `spawn_id` = 24799;

        -- closes #589
        UPDATE `creature_template` SET `subname`="Leatherworker" WHERE `entry`=3967;
        UPDATE `creature_template` SET `subname`="Enchantress" WHERE `entry`=3606 ;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`=4900 ;
        UPDATE `creature_template` SET `subname`="Superior Alchemist" WHERE `entry`=5594 ;
        UPDATE `creature_template` SET `subname`="Leatherworker" WHERE `entry`=3552 ;
        UPDATE `creature_template` SET `subname`="Superior Leatherworker" WHERE `entry`=2816 ;
        UPDATE `creature_template` SET `subname`="Superior Herbalist" WHERE `entry`=2856 ;
        UPDATE `creature_template` SET `subname`="Rogue Trainer" WHERE `entry`=989 ;
        UPDATE `creature_template` SET `subname`="Needs Model" WHERE `entry`=1880 ;
        UPDATE `creature_template` SET `subname`="Superior Alchemist" WHERE `entry`=2481 ;
        UPDATE `creature_template` SET `subname`="Tailoring Vendor" WHERE `entry`=3364 ;
        UPDATE `creature_template` SET `subname`="Weaponsmith" WHERE `entry`=1441 ;
        UPDATE `creature_template` SET `subname`="Herbalist" WHERE `entry`=4898 ;
        UPDATE `creature_template` SET `subname`="Superior Leatherworker" WHERE `entry`=1385 ;
        UPDATE `creature_template` SET `subname`="Superior Blacksmith" WHERE `entry`=2836 ;
        UPDATE `creature_template` SET `subname`="Specialist Tailor" WHERE `entry`=3096 ;
        UPDATE `creature_template` SET `subname`="Leatherworker" WHERE `entry`=3069 ;
        UPDATE `creature_template` SET `subname`="Cooking Trainer" WHERE `entry`=1355;
        UPDATE `creature_template` SET `subname`="Superior Tailor" WHERE `entry`=2672 ;
        UPDATE `creature_template` SET `subname`="Clothier & Leathercrafter" WHERE `entry`=3166 ;
        UPDATE `creature_template` SET `subname`="Herbalist" WHERE `entry`=3965 ;
        UPDATE `creature_template` SET `subname`="Tailor" WHERE `entry`=2668 ;
        UPDATE `creature_template` SET `subname`="Engineer" WHERE `entry`=3290 ;
        UPDATE `creature_template` SET `subname`="Superior Alchemist" WHERE `entry`=2812 ;
        UPDATE `creature_template` SET `subname`="Blacksmith" WHERE `entry`=3174 ;
        UPDATE `creature_template` SET `subname`="Needs Model" WHERE `entry`=1881 ;
        UPDATE `creature_template` SET `subname`="Engineer" WHERE `entry`=1676 ;
        UPDATE `creature_template` SET `subname`="Superior Herbalist" WHERE `entry`=908 ;
        UPDATE `creature_template` SET `subname`="Engineer" WHERE `entry`=2682 ;
        UPDATE `creature_template` SET `subname`="Tailoring Supplier" WHERE `entry`=3091 ;
        UPDATE `creature_template` SET `subname`="Two Handed Weapons Merchant" WHERE `entry`=4043 ;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`=1470 ;
        UPDATE `creature_template` SET `subname`="Superior Engineer" WHERE `entry`=2687 ;
        UPDATE `creature_template` SET `subname`="Armorer & Shieldcrafter" WHERE `entry`=1213 ;
        UPDATE `creature_template` SET `subname`="Tailor" WHERE `entry`=2627 ;
        UPDATE `creature_template` SET `subname`="Shaman Trainer" WHERE `entry`=3343 ;
        UPDATE `creature_template` SET `subname`="Gryphon Master" WHERE `entry`=2858 ;
        UPDATE `creature_template` SET `subname`="Grom'gol Guard" WHERE `entry`=1064 ;
        UPDATE `creature_template` SET `subname`="Armor Crafter" WHERE `entry`=5164 ;
        UPDATE `creature_template` SET `subname`="Blacksmith" WHERE `entry`=3557 ;
        UPDATE `creature_template` SET `subname`="Leather Armor Merchant" WHERE `entry`=3316 ;
        UPDATE `creature_template` SET `subname`="Wands Merchant" WHERE `entry`=5133 ;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`=3956 ;
        UPDATE `creature_template` SET `subname`="Superior Clothier and Leathercrafter" WHERE `entry`=1147 ;
        UPDATE `creature_template` SET `subname`="Clothier & Leathercrafter" WHERE `entry`=3160 ;
        UPDATE `creature_template` SET `subname`="Superior Blacksmith" WHERE `entry`=2844 ;
        UPDATE `creature_template` SET `subname`="Mage Trainer" WHERE `entry`=1411 ;
        UPDATE `creature_template` SET `subname`="Innkeeper" WHERE `entry`=1247 ;
        UPDATE `creature_template` SET `subname`="Innkeeper" WHERE `entry`=5111 ;
        UPDATE `creature_template` SET `subname`="Leatherworker & Armorer" WHERE `entry`=3483 ;
        UPDATE `creature_template` SET `subname`="Macecrafter" WHERE `entry`=1471 ;
        UPDATE `creature_template` SET `subname`="Superior Blacksmith" WHERE `entry`=2847 ;
        UPDATE `creature_template` SET `subname`="Superior Alchemist" WHERE `entry`=2837 ;
        UPDATE `creature_template` SET `subname`="Herbalist" WHERE `entry`=1473 ;
        UPDATE `creature_template` SET `subname`="Leathercrafter" WHERE `entry`=954 ;
        UPDATE `creature_template` SET `subname`="Maces & Staves" WHERE `entry`=5121 ;
        UPDATE `creature_template` SET `subname`="Tailor" WHERE `entry`=3484 ;
        UPDATE `creature_template` SET `subname`="Wolf Rider" WHERE `entry`=4752 ;
        UPDATE `creature_template` SET `subname`="Enchanting Supplier" WHERE `entry`=3346 ;
        UPDATE `creature_template` SET `subname`="Alchemy Vendor" WHERE `entry`=3348 ;
        UPDATE `creature_template` SET `subname`="Mace Vendor" WHERE `entry`=3360 ;
        UPDATE `creature_template` SET `subname`="Superior Blacksmith" WHERE `entry`=5411 ;
        UPDATE `creature_template` SET `subname`="Leathercrafter" WHERE `entry`=3703 ;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`=3964 ;
        UPDATE `creature_template` SET `subname`="Fruit Seller" WHERE `entry`=1671 ;
        UPDATE `creature_template` SET `subname`="Tiger Handler" WHERE `entry`=4730 ;
        UPDATE `creature_template` SET `subname`="Tailoring Supplier" WHERE `entry`=1672 ;
        UPDATE `creature_template` SET `subname`="Guild Tabard Vendor" WHERE `entry`=5049 ;
        UPDATE `creature_template` SET `subname`="Tailor" WHERE `entry`=3704 ;
        UPDATE `creature_template` SET `subname`="Tailoring Supplier" WHERE `entry`=3005 ;
        UPDATE `creature_template` SET `subname`="Leatherworking Supplier" WHERE `entry`=3008 ;
        UPDATE `creature_template` SET `subname`="Grocer" WHERE `entry`=3961 ;
        UPDATE `creature_template` SET `subname`="Alchemy Supplier" WHERE `entry`=3010 ;
        UPDATE `creature_template` SET `subname`="Superior Engineer" WHERE `entry`=2685 ;
        UPDATE `creature_template` SET `subname`="Horse Trainer" WHERE `entry`=2357 ;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`=3184 ;
        UPDATE `creature_template` SET `subname`="Herbalist" WHERE `entry`=3185 ;
        UPDATE `creature_template` SET `subname`="Engineer" WHERE `entry`=2683 ;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`=2380 ;
        UPDATE `creature_template` SET `subname`="Enchanting Supplier" WHERE `entry`=3012 ;
        UPDATE `creature_template` SET `subname`="Engineering Trainer" WHERE `entry`=3412 ;
        UPDATE `creature_template` SET `subname`="Fisherman" WHERE `entry`=1700 ;
        UPDATE `creature_template` SET `subname`="Stylish Leathercrafter" WHERE `entry`=3684 ;
        UPDATE `creature_template` SET `subname`="Light Armor & Tailoring Supplies" WHERE `entry`=2849 ;
        UPDATE `creature_template` SET `subname`="Armorer & Shieldcrafter" WHERE `entry`=1249 ;
        UPDATE `creature_template` SET `subname`="Tailor" WHERE `entry`=1474 ;
        UPDATE `creature_template` SET `subname`="Superior Leatherworker" WHERE `entry`=2699 ;
        UPDATE `creature_template` SET `subname`="Superior Engineer" WHERE `entry`=2684 ;
        UPDATE `creature_template` SET `subname`="Armorsmith" WHERE `entry`=3543 ;
        UPDATE `creature_template` SET `subname`="Superior Alchemist" WHERE `entry`=1386 ;
        UPDATE `creature_template` SET `subname`="Drink Merchant" WHERE `entry`=3541 ;
        UPDATE `creature_template` SET `subname`="Tailor" WHERE `entry`=2669 ;
        UPDATE `creature_template` SET `subname`="Drum Merchant" WHERE `entry`=3037 ;
        UPDATE `creature_template` SET `subname`="Blade Merchant" WHERE `entry`=3361 ;
        UPDATE `creature_template` SET `subname`="Superior Tailor" WHERE `entry`=2855 ;
        UPDATE `creature_template` SET `subname`="Superior Blacksmith" WHERE `entry`=1383 ;
        UPDATE `creature_template` SET `subname`="Engineering Supplier" WHERE `entry`=3413 ;
        UPDATE `creature_template` SET `subname`="Rogue Trainer" WHERE `entry`=1407 ;
        UPDATE `creature_template` SET `subname`="Leatherworking Supplier" WHERE `entry`=3366 ;
        UPDATE `creature_template` SET `subname`="Leathercrafter" WHERE `entry`=3953 ;
        UPDATE `creature_template` SET `subname`="Blacksmithing Supplier" WHERE `entry`=2999 ;
        UPDATE `creature_template` SET `subname`="Cloth & Leather Merchant" WHERE `entry`=984 ;
        UPDATE `creature_template` SET `subname`="Superior Engineer" WHERE `entry`=2857 ;
        UPDATE `creature_template` SET `subname`="Engineer" WHERE `entry`=3494 ;
        UPDATE `creature_template` SET `subname`="Grocer" WHERE `entry`=4195 ;
        UPDATE `creature_template` SET `subname`="Cloth Armor Merchant" WHERE `entry`=3315 ;
        UPDATE `creature_template` SET `subname`="Blacksmith" WHERE `entry`=3478 ;
        UPDATE `creature_template` SET `subname`="Superior Leatherworker" WHERE `entry`=2819 ;
        UPDATE `creature_template` SET `subname`="Shady Dealer" WHERE `entry`=5169 ;
        UPDATE `creature_template` SET `subname`="Leathercrafter" WHERE `entry`=3079 ;
        UPDATE `creature_template` SET `subname`="Leatherworker" WHERE `entry`=3074 ;
        UPDATE `creature_template` SET `subname`="Clothier & Leathercrafter" WHERE `entry`=3492 ;
        UPDATE `creature_template` SET `subname`="Ancient Blacksmith" WHERE `entry`=3682 ;
        UPDATE `creature_template` SET `subname`="Tailoring Goods" WHERE `entry`=3485 ;
        UPDATE `creature_template` SET `subname`="Superior Tailor" WHERE `entry`=2670 ;
        UPDATE `creature_template` SET `subname`="Mining Trainer" WHERE `entry`=5392 ;
        UPDATE `creature_template` SET `subname`="Darkspear hostage" WHERE `entry`=2530 ;
        UPDATE `creature_template` SET `subname`="Lockpicking Trainer" WHERE `entry`=3402 ;
        UPDATE `creature_template` SET `subname`="Superior Swordsmith" WHERE `entry`=2482 ;
        UPDATE `creature_template` SET `subname`="Axe Vendor" WHERE `entry`=3409 ;

        -- closes #621
        UPDATE `creature_template` SET `subname`="Herbalist" WHERE `entry`= 3185;
        UPDATE `creature_template` SET `subname`="Herbalist" WHERE `entry`= 3965;
        UPDATE `creature_template` SET `subname`="Alchemist" WHERE `entry`= 3956;
        UPDATE `creature_template` SET `subname`="Expert Engineer" WHERE `entry`= 3412;
        UPDATE `creature_template` SET `subname`="Expert Leatherworker" WHERE `entry`= 3365;

        -- Darnassus banker guards fix, there are in a nonsence spot since bankers was moved
        UPDATE `spawns_creatures` SET `position_x` = 10043.713, `position_y` = 2509.819, `position_z` = 1318.398, `orientation`= 4.594  WHERE `spawn_id` = 46883;
        UPDATE `spawns_creatures` SET `position_x` = 10026.343, `position_y` = 2507.747, `position_z` = 1318.414, `orientation`= 5.014  WHERE `spawn_id` = 46841;    

        -- Berthe et Evalyn waypoints
        INSERT INTO creature_movement VALUES (400113, 1, -5352.65771484375, -2963.413818359375, 323.9547119140625, 5.046975612640381, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 1, -5348.97705078125, -2961.716796875, 323.67010498046875, 4.84905481338501, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 2, -5342.2783203125, -2988.3251953125, 323.717529296875, 5.032838821411133, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 2, -5341.6708984375, -2985.308349609375, 323.8820495605469, 4.929166793823242, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 3, -5334.3857421875, -3019.335693359375, 324.0635986328125, 4.974720001220703, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 3, -5330.47802734375, -3022.72265625, 323.9331359863281, 4.764233112335205, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 4, -5342.97216796875, -2987.744140625, 323.72808837890625, 1.900670051574707, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 5, -5359.20556640625, -2947.6494140625, 324.2459411621094, 2.011411428451538, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 4, -5341.47119140625, -2987.35595703125, 323.763916015625, 1.8299880027770996, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 5, -5353.17724609375, -2953.93115234375, 323.9293212890625, 2.08681321144104, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 6, -5384.07568359375, -2918.373046875, 334.5067443847656, 2.3130080699920654, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 6, -5393.248046875, -2911.83837890625, 337.48480224609375, 2.3514928817749023, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 7, -5347.60693359375, -2959.097412109375, 323.5735168457031, 6.055429458618164, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400113, 8, -5338.06884765625, -2957.317626953125, 325.0440979003906, 0.23955610394477844, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 7, -5349.8310546875, -2955.586669921875, 323.7593994140625, 6.00830602645874, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400112, 8, -5333.73974609375, -2955.90869140625, 326.431884765625, 6.272199630737305, 0, 0, 0);
        UPDATE `spawns_creatures` SET `movement_type` = 2 WHERE `spawn_id` IN (400112, 400113);
        UPDATE `creature_template` SET `flags_extra` = 33554432 WHERE `entry` IN (1881, 1880);

        insert into`applied_updates`values ('250820232');
    end if;

    -- 30/08/2023 1
    if (select count(*) from applied_updates where id='300820231') = 0 then

        -- waypoints for redridge bridgeworkers
        INSERT INTO creature_movement VALUES (400103, 1, -9273.5322265625, -2263.800048828125, 66.2210464477539, 4.392728328704834, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400103, 2, -9279.8134765625, -2275.6298828125, 67.5046615600586, 3.707075595855713, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400103, 3, -9292.966796875, -2275.2177734375, 67.95291900634766, 3.046555280685425, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400103, 4, -9308.5224609375, -2274.104736328125, 70.20968627929688, 1.390149474143982, 120000, 0, 0);
        INSERT INTO creature_movement VALUES (400103, 5, -9277.890625, -2276.53466796875, 67.51786041259766, 1.1741650104522705, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400103, 6, -9274.9658203125, -2264.047119140625, 66.4827880859375, 1.4309903383255005, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400103, 7, -9289.3740234375, -2254.568359375, 63.178401947021484, 1.3288885354995728, 30000, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 1, -9275.37109375, -2258.993408203125, 65.47622680664062, 4.620493412017822, 5000, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 2, -9279.107421875, -2294.4033203125, 67.84982299804688, 4.620493412017822, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 3, -9292.9892578125, -2294.510986328125, 67.6749038696289, 3.033203125, 40, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 4, -9382.947265625, -2286.892822265625, 70.42097473144531, 4.523889541625977, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 5, -9305.6181640625, -2292.28369140625, 69.78971862792969, 4.601644515991211, 60, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 6, -9274.1083984375, -2268.1748046875, 66.79535675048828, 1.597497820854187, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 7, -9276.103515625, -2256.450439453125, 64.99832916259766, 3.0834715366363525, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400102, 8, -9292.8056640625, -2256.870849609375, 62.0775260925293, 3.4392571449279785, 30000, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 1, -9272.34765625, -2268.39453125, 66.55569458007812, 4.672332763671875, 5000, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 2, -9282.5068359375, -2285.707275390625, 67.51226806640625, 3.064622163772583, 0 , 0, 0);
        INSERT INTO creature_movement VALUES (400099, 3, -9385.021484375, -2277.675048828125, 70.19278717041016, 3.0693345069885254, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 4, -9293.68359375, -2284.76806640625, 67.93246459960938, 6.2085723876953125, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 5, -9382.025390625, -2278.083984375, 70.44505310058594, 3.0497026443481445, 10000, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 6, -9293.6904296875, -2284.905029296875, 67.92780303955078, 6.20464563369751, 10000, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 7, -9282.6015625, -2285.777587890625, 67.51226806640625, 1.0995579957962036, 10000, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 8, -9272.8974609375, -2262.074462890625, 65.8905029296875, 2.371903657913208, 10000, 0, 0);
        INSERT INTO creature_movement VALUES (400099, 9, -9286.9306640625, -2247.989013671875, 63.22495651245117, 4.04323148727417, 40000, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 1, -9296.796875, -2245.725341796875, 60.652992248535156, 5.209540367126465, 25000, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 2, -9292.1171875, -2254.054443359375, 62.962833404541016, 5.647792816162109, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 3, -9282.5224609375, -2261.12939453125, 66.0398178100586, 5.647792816162109, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 4, -9276.73828125, -2265.875244140625, 66.9942855834961, 4.739086627960205, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 5, -9281.185546875, -2274.3671875, 67.49750518798828, 4.083278656005859, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 6, -9298.6865234375, -2277.63427734375, 68.95601654052734, 3.040269374847412, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 7, -9323.1396484375, -2275.1484375, 71.2531967163086, 3.040269374847412, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 8, -9338.748046875, -2270.497314453125, 71.60730743408203, 2.6750590801239014, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 9, -9346.380859375, -2259.515625, 71.6443862915039, 2.0483107566833496, 200000, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 10, -9338.748046875, -2270.497314453125, 71.60730743408203, 2.6750590801239014, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 11, -9323.1396484375, -2275.1484375, 71.2531967163086, 3.040269374847412, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 12, -9298.6865234375, -2277.63427734375, 68.95601654052734, 3.040269374847412, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 13, -9281.185546875, -2274.3671875, 67.49750518798828, 4.083278656005859, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 14, -9276.73828125, -2265.875244140625, 66.9942855834961, 4.739086627960205, 0, 0, 0);
        INSERT INTO creature_movement VALUES (400100, 15, -9292.1171875, -2254.054443359375, 62.962833404541016, 5.647792816162109, 0, 0, 0);

        UPDATE `spawns_creatures` SET `movement_type` = 2 WHERE `spawn_id` IN (400099, 400102, 400103, 400100);

        -- add datefield
        ALTER TABLE `quest_template` ADD COLUMN `parse_timestamp` DATE NOT NULL DEFAULT "2004-12-04";

        -- default release date for modified quests entries
        UPDATE `quest_template` SET `parse_timestamp` = "1970-01-01" WHERE entry IN (2, 7, 8, 10, 11, 12, 13, 14, 15, 17, 19, 21, 22, 23, 24, 26, 27, 28, 29, 30, 31, 32, 33, 47, 52, 54, 55, 56, 60, 61, 62, 63, 64, 76, 77, 81, 82, 83, 85, 87, 88, 96, 99, 100, 105, 106, 109, 113, 114, 115, 116, 117, 119, 121, 122, 123, 135, 138, 139, 140, 151, 153, 155, 156, 162, 167, 168, 170, 171, 179, 181, 182, 183, 191, 192, 193, 194, 196, 201, 202, 204, 208, 211, 212, 216, 218, 220, 228, 232, 233, 234, 236, 238, 243, 246, 247, 252, 255, 272, 275, 279, 282, 287, 289, 291, 301, 303, 304, 308, 310, 311, 312, 313, 314, 315, 317, 318, 319, 320, 325, 332, 333, 334, 338, 349, 351, 353, 358, 364, 367, 374, 375, 376, 379, 380, 381, 384, 387, 388, 392, 393, 399, 400, 408, 412, 417, 420, 426, 429, 430, 432, 433, 434, 437, 447, 450, 452, 456, 457, 458, 459, 460, 464, 475, 476, 483, 485, 486, 487, 488, 489, 501, 505, 518, 529, 532, 537, 541, 543, 553, 567, 576, 577, 580, 586, 592, 595, 604, 606, 607, 614, 621, 626, 628, 636, 640, 648, 654, 661, 665, 676, 679, 682, 684, 685, 686, 697, 698, 704, 709, 717, 722, 724, 727, 729, 731, 741, 745, 747, 748, 750, 752, 754, 756, 757, 758, 759, 760, 783, 787, 791, 792, 793, 794, 821, 822, 824, 829, 836, 841, 842, 843, 844, 845, 846, 850, 851, 852, 855, 861, 862, 864, 868, 869, 870, 880, 881, 882, 883, 884, 885, 889, 893, 899, 903, 905, 908, 909, 914, 916, 917, 919, 922, 923, 934, 937, 939, 947, 951, 952, 957, 958, 959, 960, 962, 964, 965, 969, 971, 972, 974, 975, 976, 977, 978, 981, 982, 984, 986, 992, 995, 996, 997, 998, 1003, 1013, 1014, 1016, 1021, 1022, 1026, 1031, 1032, 1035, 1036, 1045, 1046, 1048, 1049, 1050, 1051, 1053, 1058, 1059, 1061, 1062, 1063, 1068, 1069, 1072, 1073, 1078, 1079, 1080, 1081, 1089, 1092, 1096, 1097, 1101, 1102, 1103, 1105, 1107, 1113, 1116, 1132, 1133, 1135, 1136, 1137, 1138, 1139, 1141, 1142, 1143, 1144, 1150, 1153, 1156, 1166, 1167, 1168, 1169, 1172, 1173, 1177, 1184, 1189, 1193, 1197, 1199, 1200, 1203, 1206, 1218, 1219, 1221, 1222, 1258, 1264, 1267, 1270, 1273, 1275, 1282, 1286, 1302, 1322);

        -- 0.5.5 date for WDB parsed entries
        UPDATE `quest_template` SET `parse_timestamp` = "2004-03-18" WHERE entry IN (179, 233, 234, 183, 783, 7, 15, 62, 47, 60, 85, 86, 106, 84, 87, 76, 111, 107, 112, 61, 239, 40, 35, 114, 11, 88, 37, 109, 333, 1097, 13, 153, 436, 1678, 1618, 65, 176, 783, 7, 62, 47, 87, 76, 60, 61, 333, 334, 52, 15, 21, 54, 239, 11, 64, 12, 151, 102, 22, 13, 14, 117, 399, 246, 1097, 116, 412, 287, 315, 310, 384, 400, 308, 311, 291, 433, 432, 313, 353, 65, 118, 120, 132, 121, 119, 122, 135, 141, 142);

        -- 0.5.3 date for WDB parsed entries
        UPDATE `quest_template` SET `parse_timestamp` = "2003-12-12" WHERE entry IN (364, 376, 380, 381, 363, 382, 383, 404, 426,  375, 367);

        -- Change Susan Tilinghast mvmt type to be able to use their wp
        UPDATE `spawns_creatures` SET `movement_type`= 2 WHERE `spawn_id`= 38101;


        insert into applied_updates values ('300820231');
    end if;

    -- 01/09/2023 1
    if (select count(*) from `applied_updates` where id='010920231') = 0 then
        -- Closes #1286
        UPDATE `quest_template` SET `RewXP` = 1500, `RewOrReqMoney` = 350, `parse_timestamp` = "2004-03-18" WHERE `entry` = 224;

        insert into `applied_updates` values ('010920231');
    end if;

    -- 08/09/2023 1
    IF (SELECT COUNT(*) FROM `applied_updates` WHERE id='080920231') = 0 THEN
        UPDATE `creature_template` SET `trainer_id` = 280 WHERE `entry` IN (3620, 4901);
        UPDATE `creature_template` SET `trainer_id` = 287 WHERE `entry` IN (3624);
        INSERT INTO `applied_updates` VALUES ('080920231');
    end if;

    -- 13/09/2023 1
	if (select count(*) from applied_updates where id='130920231') = 0 then

        -- Wendigo, go back to normal lvl
        UPDATE `creature_template` SET `level_min`= 6, `level_max`= 7 WHERE `entry`= 1135;     

        -- Zardeth
        UPDATE `creature_template` SET `level_min`= 70, `level_max`= 70 WHERE `entry`= 1435;

        -- Andrew brounel #1294
        UPDATE `spawns_creatures` SET `position_x` = 1861.978, `position_y` = 1571.675, `position_z` = 99.053, `orientation`= 0.185  WHERE `spawn_id` = 32024;

        -- Skeletal enrage
        UPDATE `creature_template` SET `display_id1`= 200 WHERE `entry`= 2454;

        -- Natheril #1161
        UPDATE `creature_template` SET `npc_flags`= 0 WHERE `entry`= 2084;

        -- Ravenholdt GO #1306
        update `spawns_gameobjects` set `ignored` = 1 where `spawn_id` IN (121618, 17977, 17994, 17982, 17984, 17974, 17988, 17993, 17973, 17979, 17986, 17993, 17980, 17991, 17976, 17976);

        -- tiyani #1305
        UPDATE `creature_template` SET `display_id1`= 2575 WHERE `entry`= 4195;

        -- Steed #1291 1
        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5689, 0, 2248.764, 331.255, 35.189, 5.605, 300, 300, 0);

        -- Steed #1291 2
        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (5689, 0, 2246.688, 329.018, 35.189, 5.582, 300, 300, 0);

        -- Darnassus npc, #1313
        UPDATE `spawns_creatures` SET `position_x` = 9825.762, `position_y` = 2338.439, `position_z` = 1329.324, `orientation`= 5.118 WHERE `spawn_id` = 49519;
        UPDATE `spawns_creatures` SET `position_x` = 9826.717, `position_y` = 2336.335, `position_z` = 1321.659, `orientation`= 5.131  WHERE `spawn_id` = 49540;

        -- Darna Spider trainer, he can't be located at current pos since we have tons of ss of it
        UPDATE `spawns_creatures` SET `position_x` = 9895.199, `position_y` = 2121.367, `position_z` = 1329.626 , `orientation`= 2.1142  WHERE `spawn_id` = 32651;

        -- Darna Bag Mrchant, flip o as ss shows
        UPDATE `spawns_creatures` SET `orientation`= 1.433  WHERE `spawn_id` = 46562;

        -- Darna nighsaber inst, correct o to look less random spawned
        UPDATE `spawns_creatures` SET `orientation`= 3.743  WHERE `spawn_id` = 46722;

        -- Lesser Elem 1
        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (691, 0, -11855.547, 1260.772, 2.641, 4.0, 300, 300, 1);

        -- Lesser Elem 2
        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (691, 0, -11858.30, 1230.882, 1.349, 4.0, 300, 300, 1);

        -- Lesser Elem 3
        INSERT INTO spawns_creatures 
        (spawn_entry1, map, position_x, position_y, position_z, orientation, spawntimesecsmin, spawntimesecsmax, movement_type) 
        VALUES 
        (691, 0, -11899.0, 1252.23, 2.631, 1.0, 300, 300, 1);

        -- Correct scale for big dragons
        UPDATE `creature_template` SET `display_id1`= 2717 WHERE `entry` IN (5312, 5314, 5718);

        insert into applied_updates values ('130920231');
    end if;

    -- 14/09/2023 1
    IF (SELECT COUNT(*) FROM `applied_updates` WHERE id='140920231') = 0 THEN

        -- Quests Parsing from Warcraft Strategy
        UPDATE `quest_template` SET `Details` = 'As the mystical taint creeps through the forest the need for self-protection is undeniable, $n.  The winds whisper to me and they speak of a great danger which waits patiently for you in the near-future.$B$BIf you wish to protect yourself, noble $r, bring to me 10 ghoul fangs, 10 skeleton fingers and 5 vials of spider venom.  For you I shall enchant a Totem of Infliction which will harm those who attempt violent acts against you.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 101;
        UPDATE `quest_template` SET `Details` = 'The forest spirits tell me you are brave and willing to travel.$B$BTo the south, not far from Mystral Lake, there lies a tunnel named The Talondeep Path. Through this tunnel you will come to an area known as Windshear Crag in the Stonetalon Mountains. Once there, journey to the southwest past Cragpool Lake and then north, up the steep slope until you reach Stonetalon Peak.$B$BThere awaits Keeper Albagorm. Heed his bidding, $r.$B$BThe journey will be perilous.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 1056;
        UPDATE `quest_template` SET `Objectives` = 'Deliver Darsok\'s letter to Jin\'Zil within his cave in Stonetalon.',  `parse_timestamp`='2004-04-25' WHERE `entry` = 1060;
        UPDATE `quest_template` SET `Objectives` = 'Speak with Apothecary Zamah in the Pools of Vision.',  `parse_timestamp`='2004-05-20' WHERE `entry` = 1064;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1300,  `parse_timestamp`='2004-05-18' WHERE `entry` = 1086;
        UPDATE `quest_template` SET `Objectives` = 'Kill 4 Sons of Cenarius, 4 Daughters of Cenarius and 4 Cenarion Botanists for Braelyn Firehand near Stonetalon Peak.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 1087;
        UPDATE `quest_template` SET `Objectives` = 'Bring Ordanus\' head to Braelyn Firehand near Stonetalon Peak.',  `parse_timestamp`='2004-05-20' WHERE `entry` = 1088;
        UPDATE `quest_template` SET `PrevQuestId` = 1483,  `parse_timestamp`='2004-05-18' WHERE `entry` = 1093;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-05-20' WHERE `entry` = 1098;
        UPDATE `quest_template` SET `Objectives` = 'Bring 12 Salty Scorpid Venoms to Fizzle Brassbolts in the Shimmering Flats.', `ReqItemCount1` = 10, `RewOrReqMoney` = 1500,  `parse_timestamp`='2004-05-20' WHERE `entry` = 1104;
        UPDATE `quest_template` SET `Details` = 'Heh heh, with all the races they\'re running here, it\'s no suprise that a few mishaps happen along the way.  If you look around the Shimmering Flats then you\'ll see evidence of past crashes -- scraps of rocket car parts are littered everywhere!$B$BAnd those parts are worth money to the gnomes and goblins.  They\'re always looking for more contraptions to slap onto their cars.$B$BSo go out and get me parts.  Bring me a heap and I\'ll pay you well.', `RewOrReqMoney` = 1600,  `parse_timestamp`='2004-05-18' WHERE `entry` = 1110;
        UPDATE `quest_template` SET `Objectives` = 'Bring the Delicate Car Parts to Fizzle Brassbolts.', `RewOrReqMoney` = 500,  `parse_timestamp`='2004-05-13' WHERE `entry` = 1114;
        UPDATE `quest_template` SET `Objectives` = 'Find Braug Dimspirit in the Talondeep Path connecting the Stonetalon Mountains and Ashenvale.', `Details` = 'Your time with me is just about finished. I am knowledgeable, but the Test of Lore is not mine to give. There are lessons to be learned and places to visit that others claim domain over.$B$BIf you are prepared, then seek out Braug Dimspirit--he is a shaman of great wisdom. He will test you further, so heed his words, $n.$B$BWhen you are ready, find the tunnel that connects the Stonetalon Mountains with Ashenvale: Braug dwells there. And be careful, $n, the night elves may wish to impede your test.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 1152;
        UPDATE `quest_template` SET `Objectives` = 'Find the Legacy of the Aspects and return it to Braug Dimspirit in Talondeep Path between Ashenvale and Stonetalon.',  `parse_timestamp`='2004-05-18' WHERE `entry` = 1154;
        UPDATE `quest_template` SET `PrevQuestId` = 1156,  `parse_timestamp`='2004-05-18' WHERE `entry` = 1159;
        UPDATE `quest_template` SET `Details` = 'The harlot! The swine! Kenata still lives; her family healthy and prospering while I suffer. Forsaken indeed!$B$BMy family is gone, taken by the plague. Our estate also forfeit; looted and burned during the war. And after all that, her and her lousy children had the audacity to steal the only precious belongings I had left.$B$BI don\'t care about the things they stole any more. What I want now are their heads!$B$BKill them for me! Go to the Dabyrie Farmstead in Arathi, northwest of Refuge Point.',  `parse_timestamp`='2004-05-20' WHERE `entry` = 1164;
        UPDATE `quest_template` SET `Objectives` = 'Get 6 Hollow Vulture Bones for Pozzik in the Shimmering Flats.', `ReqItemCount1` = 6, `RewOrReqMoney` = 2000,  `parse_timestamp`='2004-05-18' WHERE `entry` = 1176;
        UPDATE `quest_template` SET `Objectives` = 'Bring the Fuel Injector Blueprints to Baron Revilgaz in Booty Bay.', `Details` = 'See, the Venture Company shredders out in Lake Nazferiti have been equipped with a new model fuel regulator. I was thinking that Pozzik would be able to take advantage of it, if he could get some details. Unfortunately, Cozzle, the foreman out there, appears to be a little more clever than I gave him credit for.$B$BYou seem like you might have more luck finding the blueprints though. I know he keeps them in his house, but they\'re almost certainly under lock and key.', `RewOrReqMoney` = 2200,  `parse_timestamp`='2004-05-18' WHERE `entry` = 1182;
        UPDATE `quest_template` SET `Objectives` = 'Retrieve the Seaforium Booster for Razzeric on the Shimmering Flats.', `Details` = 'Pozzik\'s a great mechanic, I know that, but he\'s afraid to just load on the firepower and grab on for the ride. Not me, though.$B$BAfter Pozzik finishes with a racer, I take a little time to put my own modifications on. Loosening up the controls, removing parts of the frame, and adding more juice!$B$BI ordered a seaforium booster from Shreev at the Gizmorium in Gadgetzan, but apparently the zeppelin it was being sent on crashed in Dustwallow Marsh! I gotta have it, $n!', `RewOrReqMoney` = 2400,  `parse_timestamp`='2004-05-07' WHERE `entry` = 1187;
        UPDATE `quest_template` SET `Details` = 'The Galak centaur in the Thousand Needles are protecting an artifact from the time of the centaurs\' creation.$B$BWe would like to retrieve it, but we require a phial of water from one of the night elves\' moonwells.$B$BTo collect the water, you will first need to obtain one of the phials carried by the dryads near the Raynewood Retreat in the heart of Ashenvale Forest. There is a moonwell near the western bank of the Falfarren River, south of the main road that you can fill the phial.', `RewOrReqMoney` = 1800,  `parse_timestamp`='2004-05-20' WHERE `entry` = 1195;
        UPDATE `quest_template` SET `Details` = 'Deadmire is an ancient crocilisk in Dustwallow marsh.  And it is his time to die.$B$BOld bones grind as he pulls his huge body through the swamp, and although he still moves with the strength and speed of youth, his aging body tortures the great spirit within it, a spirit whose flame will not waver.$B$BYet now he lives in constant, maddening pain.  You must end the life of this noble creature, $n.  You must lead Deadmire to peace.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 1205;
        UPDATE `quest_template` SET `Objectives` = 'Forman Oslow of Lakeshire wants you to retrieve his toolbox from the bottom of Lake Everstill.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 125;
        UPDATE `quest_template` SET `RewOrReqMoney` = 100,  `parse_timestamp`='2004-06-01' WHERE `entry` = 127;
        UPDATE `quest_template` SET `Details` = 'Excuse me,  sir : madam;. Bishop DeLavey asked me to approach adventurers that might be able to help him with a delicate matter.$B$BIf you could quietly head to Stormwind Keep and speak to him at your earliest convenience, I\'m sure he would appreciate your help. Again, please be discrete. It is a matter of some importance.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 1274;
        UPDATE `quest_template` SET `PrevQuestId` = 1339, `RewOrReqMoney` = 400,  `parse_timestamp`='2004-06-01' WHERE `entry` = 1338;
        UPDATE `quest_template` SET `Details` = 'I hear Mountaineer Stormpike is looking for a runner.  Someone to do a little traveling for him.  How about it?  Are you the  for the job?$B$BIf so, then you\'ll find Stormpike at the top of the northern guard tower.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 1339;
        UPDATE `quest_template` SET `RewOrReqMoney` = 500,  `parse_timestamp`='2004-06-01' WHERE `entry` = 134;
        UPDATE `quest_template` SET `RewItemId1` = 1217, `RewItemCount1` = 1,  `parse_timestamp`='2004-06-01' WHERE `entry` = 136;
        UPDATE `quest_template` SET `Details` = 'Magistrate Solomon\'s note pains me to read.  But it is obvious he knows not the war which is waged in Westfall or else he would know better than to expect aid from the Militia.  If Stormwind had not deserted us as well, we would not have the need for the Militia.$B$BTake this response to your Master in Redridge, $r.  And let him know that my heart is heavy with the loss of good men.', `RewOrReqMoney` = 100,  `parse_timestamp`='2004-06-01' WHERE `entry` = 144;
        UPDATE `quest_template` SET `RewOrReqMoney` = 200,  `parse_timestamp`='2004-06-01' WHERE `entry` = 146;
        UPDATE `quest_template` SET `RewItemId1` = 1217,  `parse_timestamp`='2004-06-01' WHERE `entry` = 150;
        UPDATE `quest_template` SET `RewOrReqMoney` = 300,  `parse_timestamp`='2004-06-01' WHERE `entry` = 154;
        UPDATE `quest_template` SET `Objectives` = 'Bring the Ghost Hair Thread to Abercrombie, in his shack north of the Raven Hill Cemetary.', `RewOrReqMoney` = 500,  `parse_timestamp`='2004-06-01' WHERE `entry` = 157;
        UPDATE `quest_template` SET `Objectives` = 'Bring the Zombie Juice to Abercrombie at this shack.', `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-06-01' WHERE `entry` = 159;
        UPDATE `quest_template` SET `RewOrReqMoney` = 100,  `parse_timestamp`='2004-06-01' WHERE `entry` = 164;
        UPDATE `quest_template` SET `Details` = 'There was an old man who used to come into town to buy supplies rather frequently, but I haven\'t seen him for quite some time now. He lives out in a shack overlooking Raven Hill cemetary, if I remember correctly. Perhaps you should go see if something is amiss.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 165;
        UPDATE `quest_template` SET `Objectives` = 'Behead Gath\'Ilzogg and report to Magistrate Solomon in Lakeshire for the reward.', `RewOrReqMoney` = 1900,  `parse_timestamp`='2004-06-01' WHERE `entry` = 169;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1400,  `parse_timestamp`='2004-06-01' WHERE `entry` = 172;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1100,  `parse_timestamp`='2004-06-01' WHERE `entry` = 173;
        UPDATE `quest_template` SET `Details` = 'Do not be alarmed.  I am Theocritus, High Mage of Tower Azora in Elwynn Forest.  The pendant you are holding is a method of communication between the Shadowhide Gnolls and their master, Morganth.$B$BThrough months of research, I believe I too can communicate through these pendants.  If you can hear this message, then my spell was a success.$B$BBring me this pendant and I will reward you for the service.', `RewOrReqMoney` = 500,  `parse_timestamp`='2004-06-01' WHERE `entry` = 178;
        UPDATE `quest_template` SET `Objectives` = 'Bring 8 Red Burlap Bandanas to Deputy Willem outside the Northshire Abbey.', `Details` = 'Recently, a new group of thieves has been hanging around Northshire.  They call themselves the Defias Brotherhood, and have been seen across the river to the east.$B$BI don\'t know what they\'re up to, but I\'m sure it\'s not good!  Bring me 8 of the bandanas they wear, and I\'ll reward you with a weapon.', `ReqItemCount1` = 8,  `parse_timestamp`='2004-05-13' WHERE `entry` = 18;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1900,  `parse_timestamp`='2004-06-01' WHERE `entry` = 180;
        UPDATE `quest_template` SET `RewOrReqMoney` = 2000,  `parse_timestamp`='2004-05-18' WHERE `entry` = 189;
        UPDATE `quest_template` SET `Details` = 'Hmm. Yes, I do have something you could do, actually. Lieutenant Doren and his followers up in the north need their regular supplies from us.$B$BThey haven\'t been delivered, and with the trolls attacking, I\'ll need someone to do it. Doren\'s camp lies northwest of the road at the entrance to Stranglethorn from Duskwood. Give the supplies to Private Thorsen. He\'ll take care of them.$B$BMind you, if you fail, you\'ll owe me restitution for the supplies.$B$BOf course, you\'ll probably be dead then...', `RewOrReqMoney` = 900,  `parse_timestamp`='2004-06-01' WHERE `entry` = 198;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-06-01' WHERE `entry` = 20;
        UPDATE `quest_template` SET `Details` = 'It\'s expensive and hard to kill enough tigers to support the export of tiger fangs to the islands in the South Seas. Luckily, we\'ve developed a technique that we can use mundane horn-like objects and turn them into undetectable forgeries.$B$BThe closest match we\'ve found, amazingly, are the tusks of the Skullsplitter trolls.$B$BHey, before you say anything, what the buyer doesn\'t know doesn\'t hurt them, am I right? Bring me a large number of them so we can get to work on the monthly shipment!', `RewOrReqMoney` = 2400,  `parse_timestamp`='2004-05-07' WHERE `entry` = 209;
        UPDATE `quest_template` SET `Objectives` = 'Retrieve 12 Tumbled Crystals and return them to Kebok in Booty Bay.', `Details` = 'He\'s done it this time! Bad enough that Gelriz\'s muscling out the moguls who were appointed by the trade princes, now he tries to cut in on the most notorious pirate!$B$BRevilgaz won\'t have it, and he\'s told me to take care of the problem in my own way.$B$BMy way? Theft. The Venture Co. geologists are deeply interested in those strange blue crystals they have been finding in the mines. Bring me samples of the stone from their geologists, I don\'t care what you have to do to get them.', `ReqItemCount1` = 12,  `parse_timestamp`='2004-05-07' WHERE `entry` = 213;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1200,  `parse_timestamp`='2004-06-01' WHERE `entry` = 221;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1200, `RewItemId1` = 5244, `RewItemCount1` = 1,  `parse_timestamp`='2004-06-01' WHERE `entry` = 222;
        UPDATE `quest_template` SET `Details` = 'Here you go, $n. Bring this message to Master Carevin.$B$B$B$BA few more like you, and we will outnumber the Night Watch! Perhaps then we could complete the work that we few carry on today.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 223;
        UPDATE `quest_template` SET `Objectives` = 'Kill 12 Starving Dire Wolves, then return to Lars at Sven\'s Camp on the western border of Duskwood.', `Details` = 'Sven and I have dangerous days ahead of us, what with the Necromancer to the east and all.  And out here alone as we are, we have to hunt and fish for our own food.  It seems every time I\'m heading back to camp with some meat or fish on me, Starving Dire Wolves come out of the forest, wanting a bite.  It goes without saying, living out here is dangerous work!$B$BBut if you can rid us of some of those wolves, we\'d have an easier time of it.  They mostly prowl north and east of here, near the river.', `ReqCreatureOrGOId2` = 0, `ReqCreatureOrGOCount2` = 0,  `parse_timestamp`='2004-06-01' WHERE `entry` = 226;
        UPDATE `quest_template` SET `Details` = 'Mountaineer Cobbleflint had nothing but good things to say about you, $r.  For that reason I am going to entrust upon you a mission of utmost importance.  We need to keep pressure on the invading Trogg forces until our Dwarven brethren return from the Alliance front.$B$BSet forth into the southern hills and kill 10 Stonesplinter Skullthumpers and 10 Stonesplinter Seers.  Your attacks will buy us some time.  Report back when your mission is complete.', `RewOrReqMoney` = 400,  `parse_timestamp`='2004-06-01' WHERE `entry` = 237;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-06-01' WHERE `entry` = 240;
        UPDATE `quest_template` SET `Details` = 'Hail, $r.  I am charged to patrol this stretch of road.  Although the road is safe for now, I\'ve seen gnoll encampments to the north and east of here.$B$BLakeshire must know of the gathering gnoll force!  Report to Deputy Feldon in Lakeshire and tell him of the gnolls.  Do this, and I\'m sure Feldon will offer you a scout\'s wage.$B$BFeldon\'s usually inspecting the area south of the bridge to Lakeshire.', `RewOrReqMoney` = 300,  `parse_timestamp`='2004-06-01' WHERE `entry` = 244;
        UPDATE `quest_template` SET `Objectives` = 'Watcher Dodds would like you to kill 15 Pygmy Venom Web Spiders.', `Details` = 'Hail, $r. Perhaps you\'ve seen those spiders that have taken over the western border? The eight-legged menaces are too much for us to handle, and the Commander hasn\'t enough manpower to spare so far from Darkshire.$B$BI hate to ask this of you, but you seem like you might be able to handle them. I can\'t promise you anything of great value, but I can reward you if you can help root out the filthy bugs.$B$BOh, and a word of advice, you\'ll want to avoid their venom if you can.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 245;
        UPDATE `quest_template` SET `Objectives` = 'Kill 5 Mountain Buzzards and return to Daryl the Youngling in the Farstrider Lodge in 15 minutes.', `Details` = 'Think you can match wits with Daryl the Bold, huh? I should think not! Of course, you\'re more than welcome to try. Here\'s a challenge that should prove to be above your abilities, so don\'t feel too bad if you can\'t face up to it.$B$BA flock of buzzards has nested here in Loch Modan. Why don\'t you try to take down some of the beasts? Tell you what, if you meet my challenge in fifteen minutes, I\'ll give you one of my guns.$B$B$B$BIt seems you haven\'t much to lose, anyways.', `ReqCreatureOrGOCount1` = 5, `RewItemId1` = 2904, `RewItemCount1` = 1,  `parse_timestamp`='2004-06-01' WHERE `entry` = 257;
        UPDATE `quest_template` SET `Objectives` = 'Kill 5 Elder Mountain Boars and return to Daryl the Youngling in the Farstrider Lodge in 12 minutes.', `Details` = '$nath, is it? I can tell you\'re bursting with pride over completing the first test, hm? As I told you before, it\'s no large feat.$B$BYou should try your hand at boar hunting. Trust me, this is no Coldridge Valley boar hunt, so you\'d best have a care with them. I\'ll give you just twelve minutes this time.$B$BDon\'t feel bad if you don\'t have any luck, though, I\'d give you the shirt off my back if you could!$B$BHave I ever related to you the story of how I received my famous scar? No? It was two years ago...',  `parse_timestamp`='2004-06-01' WHERE `entry` = 258;
        UPDATE `quest_template` SET `Objectives` = 'Bring 20 Trogg Stone Teeth to Captain Rugelfuss in the southern guard tower.', `Details` = '$r, you may or may not be aware of the Trogg threat looming over Dwarven lands.  With the Ironforge Reserve called up to the Alliance Front, we are left with a fraction of the defense forces needed to keep these lands safe.  My regiment is assigned to watch over the Gate here and we cannot leave our post for fear of invasion.$B$BBut we need some pressure put on those damned Troggs lurking in the hills.  If you\'re up to the task, wage an assault on the Troggs.  Bring me back 20 Trogg Stone Teeth as proof.', `ReqItemCount1` = 20, `RewOrReqMoney` = 400,  `parse_timestamp`='2004-06-01' WHERE `entry` = 267;
        UPDATE `quest_template` SET `Details` = 'This ain\'t no ordinary blast powder.  Look at the tiny silver crystals.  And the distinct smell!  Why it\'s clear as daylight that this is Seaforium Powder.  Seaforium is harmless enough.  But once it\'s wet it could blow Ironforge out of the mountain.$B$BThe chemical reaction can be defused by mixing four components:  Lurker Venom, Crushed Mo\'Grosh Crystal, a Crocilisk Tear and this Disarming Colloid.  Now tell Hinderweir before it\'s too late!',  `parse_timestamp`='2004-06-01' WHERE `entry` = 274;
        UPDATE `quest_template` SET `PrevQuestId` = 463,  `parse_timestamp`='2004-06-01' WHERE `entry` = 276;
        UPDATE `quest_template` SET `Details` = 'You thoroghly search this cluster of Murloc hovels, and find no trace of the Menethil Statuette.$B$BPerhaps one of the two nearby hovels to the north and northeast will have more clues.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 284;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1200,  `parse_timestamp`='2004-06-01' WHERE `entry` = 294;
        UPDATE `quest_template` SET `Objectives` = 'Ormer Ironbraid wants you to kill 10 Mottled Razormaw raptors, 10 Mottled Scytheclaw raptors and 10 Mottled Riptooth raptors, then return to him at the Whelgar Excavation Site.', `Details` = 'Now it\'s time to really make those dreaded Raptors regret their blood-thirst.  Just down below there are scores of Mottled Razormaws, Mottled Scytheclaws and Mottled Riptooths.  Make those rotten creatures pay by slaying 10 of each!', `ReqCreatureOrGOId3` = 1066, `ReqCreatureOrGOCount3` = 10, `RewOrReqMoney` = 1600,  `parse_timestamp`='2004-06-01' WHERE `entry` = 295;
        UPDATE `quest_template` SET `PrevQuestId` = 436, `Objectives` = 'Bring Magmar Fellhew 5 Carved Stone Idols.', `Details` = 'Recently, just before the Troggs surfaced within the site, we had uncovered a large number of strange, carved idols.  But we didn\'t have the chance to study them, for soon after their discovery the Troggs chased us away from the ruins!  And those idols have a strange effect on the Troggs.  It makes them go berserk!$B$BBring me 5 idols - I want to study them, and I want them out of Trogg hands!  You can find the idols on the Troggs infesting the site.', `ReqItemCount1` = 5,  `parse_timestamp`='2004-06-01' WHERE `entry` = 297;
        UPDATE `quest_template` SET `RewOrReqMoney` = 200,  `parse_timestamp`='2004-06-01' WHERE `entry` = 299;
        UPDATE `quest_template` SET `Details` = 'Ready to go, $n?$B$BFirst, we need to get this powder to Ironband. It\'ll be a lot for me to carry, and these parts can get dangerous--and who knows what else the Dark Irons might have in store for me?$B$BI\'ll feel a lot better with you coming along.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 309;
        UPDATE `quest_template` SET `Objectives` = 'Search the wreckage of The Flying Osprey.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 321;
        UPDATE `quest_template` SET `Objectives` = 'Take the Crate of Lightforge Ingots to Grimand Elmore.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 322;
        UPDATE `quest_template` SET `Objectives` = 'Gather 5 Lightforge Ingots, then return to Glorin Steelbrow.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 324;
        UPDATE `quest_template` SET `Details` = 'Lord Wishock is causing quite a stir amongst the House of Nobles.  He was made aware of our little "establishment" down here and is lobbying for a full investigation.  I have a plan to keep Wishock. . .preoccupied. . .but I\'ll need your help. $B$BThere is a flower growing in the Garden of Stalvan on the outskirts of Darkshire.  This small white flower is known as the Tear of Tilloa.  I will also need a Musquash Root, found only at the very base of the falls far beneath the Stonewrought Dam in the Wetlands.', `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-06-01' WHERE `entry` = 335;
        UPDATE `quest_template` SET `RewOrReqMoney` = 500,  `parse_timestamp`='2004-06-01' WHERE `entry` = 34;
        UPDATE `quest_template` SET `RewOrReqMoney` = 100,  `parse_timestamp`='2004-05-18' WHERE `entry` = 360;
        UPDATE `quest_template` SET `Details` = 'What have we here?  You look like a fledgling $r.  If you hope to prove yourself to The Dark Lady, you need to learn the ways of The Forsaken.$B$BTo the west you\'ll find a farm.  Humans infest the land like mold on a rotting corpse.  And worse yet, the Scarlet Crusade patrols nearby from their tower.  Teach those scum a lesson and steal 10 of their precious pumpkins.$B$BOnce you have 10, take them to Apothecary Johaan in Brill.', `RewOrReqMoney` = 50,  `parse_timestamp`='2004-04-25' WHERE `entry` = 365;
        UPDATE `quest_template` SET `RewOrReqMoney` = 50,  `parse_timestamp`='2004-04-25' WHERE `entry` = 368;
        UPDATE `quest_template` SET `RewOrReqMoney` = 200,  `parse_timestamp`='2004-05-18' WHERE `entry` = 370;
        UPDATE `quest_template` SET `Details` = 'You have proven your loyalty to King Magni, $r.  And your hatred for the Dark Iron scum is as great as my own.$B$BThere is a task I wish to complete myself but I am bound by honor to stay with Longbraid.  But Roggo has gathered intelligence that proves Kam Deepfury was a conspirator in the attack on the Thandol Span.  It was by Deepfury\'s planning that Longbraid lost his kin.$B$BDeepfury is being held for political reasons in the Stormwind Stockade.  I want him dead, $n.  For Longbraid!  Bring me his head!',  `parse_timestamp`='2004-06-01' WHERE `entry` = 378;
        UPDATE `quest_template` SET `RewItemId1` = 1479, `RewItemCount1` = 1, `RewItemId2` = 733, `RewItemCount2` = 3, `RewItemId3` = 728, `RewItemId4` = 0, `RewItemCount4` = 0,  `parse_timestamp`='2004-06-01' WHERE `entry` = 38;
        UPDATE `quest_template` SET `Title` = 'Crocilisk Hunting', `Objectives` = 'Get 6 pieces of Crocilisk Meat and 3 Crocilisk Skins for Marek Ironheart at the Farstrider Lodge.', `Details` = 'Many a hunter is attracted to Loch Modan to hunt our famous crocs. There are always merchants who seek out crocilisk skins for clothing items or armor, and there are also some who enjoy the taste of their meat.$B$BWe do some trade in this, but not a huge amount, as the crocilisks are ferocious and have entrenched themselves on the islands in the Loch. But don\'t let me dissuade you, it\'s quite an experience, wrestling with the jaws of the beasts.$B$BWhy, this one time...', `ReqItemCount1` = 6, `ReqItemCount2` = 3,  `parse_timestamp`='2004-06-01' WHERE `entry` = 385;
        UPDATE `quest_template` SET `Details` = 'Bethor Iceshard, a high-ranking and powerful mage in the Undercity to the south, commands me to send him an agent with proven worth against the Scourge.  You, $n, will be that agent.$B$BPresent these orders to Bethor.  He will then instruct you on your mission.  I don\'t know its details, but it deals with recruiting a wayward Lich.  And it will be dangerous.$B$BSo ready yourself, $r.  You must not fail.$B$BYou may find Bethor in the Magic Quarter of the Undercity.',  `parse_timestamp`='2004-05-18' WHERE `entry` = 405;
        UPDATE `quest_template` SET `Objectives` = 'Bring 9 tunnel rat ears to Mountaineer Kadrell in Thelsamar.', `ReqItemCount1` = 9, `RewOrReqMoney` = 300,  `parse_timestamp`='2004-06-01' WHERE `entry` = 416;
        UPDATE `quest_template` SET `Objectives` = 'Bring 3 pieces of Bear Meat, 3 Boar Intestines, and 3 quantities of Spider Ichor to Vidra Hearthstove in Thelsamar.', `Details` = 'There\'s never a shortage of empty bellies here in Thelsamar, kids running in and out, workers from the excavation coming in after  a hard day\'s work. We\'re famous for our blood sausages, I don\'t suppose you\'ve ever tried them?$B$BNo? Well, around here you\'ve got to work for your meals, and don\'t think just because you\'re a fancy $r, you\'ll be any exception.$B$BI\'ll need bear meat, boar intestines for the casings, and spider ichor for spice. You get me some of those, and leave the cooking to Vidra!', `RewOrReqMoney` = 300,  `parse_timestamp`='2004-06-01' WHERE `entry` = 418;
        UPDATE `quest_template` SET `Objectives` = 'Bring 5 Glutton Shackles and 5 Darksoul Shackles to Dalar Dawnweaver at the Sepulcher.', `Details` = 'After examining Arugal\'s work my worst suspicions were confirmed.  The old hack was not qualified to clean chamber pots in Dalaran let alone represent the Kirin Tor in its most dire hour.  Fools!$B$BArugal used enchanted items to reinforce his weak magic.  I need to examine these items first hand.  Travel forth and slay Moonrage Gluttons and Moonrage Darksouls until you have collected 5 of each of their enchanted shackles for my research.  The foul creatures have been seen to the north and east.', `ReqItemCount1` = 5, `ReqItemCount2` = 5, `RewOrReqMoney` = 500,  `parse_timestamp`='2004-05-18' WHERE `entry` = 423;
        UPDATE `quest_template` SET `RewOrReqMoney` = 500,  `parse_timestamp`='2004-05-18' WHERE `entry` = 424;
        UPDATE `quest_template` SET `RewOrReqMoney` = 200,  `parse_timestamp`='2004-05-18' WHERE `entry` = 425;
        UPDATE `quest_template` SET `RewOrReqMoney` = 44,  `parse_timestamp`='2004-05-18' WHERE `entry` = 427;
        UPDATE `quest_template` SET `RewOrReqMoney` = 600,  `parse_timestamp`='2004-05-18' WHERE `entry` = 443;
        UPDATE `quest_template` SET `RewOrReqMoney` = 44,  `parse_timestamp`='2004-05-18' WHERE `entry` = 445;
        UPDATE `quest_template` SET `RewOrReqMoney` = 300,  `parse_timestamp`='2004-05-18' WHERE `entry` = 449;
        UPDATE `quest_template` SET `RewOrReqMoney` = 600,  `parse_timestamp`='2004-05-18' WHERE `entry` = 461;
        UPDATE `quest_template` SET `Details` = 'You\'ve heard of the Greenwarden?  You\'re not looking for him, are you?  Well I say you\'re crazy if you are, but who am I to keep a fool from :her; death?$B$BIf you are seeking that beast, then I hear he is in the marsh, east of the road where it forks to Dun Modr.  He\'s lurking there among the crocs...and worse!$B$BAnd leave your money here.  You won\'t need it where you\'re going...and you don\'t want to chip ol\' Greenie\'s tooth on your gold when he bites you in half, do you?',  `parse_timestamp`='2004-06-01' WHERE `entry` = 463;
        UPDATE `quest_template` SET `Objectives` = 'One of the oozes in the cemetery has Sida\'s bag, retrieve it and bring it back to her in Menethil Harbor.', `Details` = 'On my weekly visit to Ironbeard\'s Tomb at the base of the mountains north from here, I was attacked by dreadful, dripping oozes! Naturally, I panicked.$B$BI threw my bag at one, but it didn\'t do anything! The ooze just sucked it right up... Luckily, it did give me enough time to get away.$B$BThe bad news is that I really need to get the contents of my bag!$B$BI don\'t know which ooze I threw my bag at--they all looked the same!--so you might have to kill a few to find my bag. Thank you!', `RewOrReqMoney` = 400, `RewItemId1` = 1217,  `parse_timestamp`='2004-06-01' WHERE `entry` = 470;
        UPDATE `quest_template` SET `Details` = 'Dun Modr has fallen to the Dark Iron Dwarves!$B$BMy wounds are grave, $r.  Most of the regiment was killed!  The Dark Iron thugs attacked us before we could regroup from the Thandol Span ambush.$B$BOur leader, Longbraid, sounded the retreat horn.  As we left the town I was hit by a stray axe in the back.  All went black.$B$BI awoke here in Menethil but I fear for my fellow soldiers.  Hope still burns within me.  Perhaps Longbraid is still alive!  See if you can find him near Dun Modr, !',  `parse_timestamp`='2004-06-01' WHERE `entry` = 472;
        UPDATE `quest_template` SET `Objectives` = 'Retrieve the contents of one of the Dalaran wizards\' crates.',  `parse_timestamp`='2004-05-18' WHERE `entry` = 477;
        UPDATE `quest_template` SET `Details` = '', `RewOrReqMoney` = 400,  `parse_timestamp`='2004-05-18' WHERE `entry` = 478;
        UPDATE `quest_template` SET `Objectives` = 'Obtain 6 Rune-inscribed pendants from Dalaran Mages and Conjurers in Ambermill for Shadow Priest Allister at the Sepulcher.', `Details` = 'Dalar is attempting to locate the source of the wizards\' spellcasting. For now, we\'ll have to slow their progress in any way we can...$B$BThe conjurers and mages are no doubt carrying the pendants. Remove and retrieve them.$B$BTake the main road south and the eastern fork into Ambermill.', `ReqItemCount1` = 6,  `parse_timestamp`='2004-05-20' WHERE `entry` = 479;
        UPDATE `quest_template` SET `Details` = 'Be silent and pay attention, $r.$B$BI was sent to this position in order to survey the town of Hillsbrad.  My mission is one of reconnaissance.  It is imperative that you send word to High Executor Darthalia in Tarren Mill at once.  Let her know that I, Deathstalker Lesh, send the following message:$B$B"The raven\'s cry from the west doth beckon."$B$BFollow the road to the east and pay close attention to the signs.  Now, hurry!  Off you go to Tarren Mill, and with urgency I might add!', `RewOrReqMoney` = 500,  `parse_timestamp`='2004-05-18' WHERE `entry` = 494;
        UPDATE `quest_template` SET `Objectives` = 'Apothecary Lydon of Tarren Mill wants 10 Grey Bear Tongues and some Creeper Ichor.', `Details` = 'Ah, another wretched day in Tarren Mill.  All of this clean air puts me in such a foul mood, $n.$B$BThe sooner we can plague the humans here, the better.  I\'ve been conducting intense studies on possible killing agents to use in my concoctions but I haven\'t the time to collect them all.$B$BIf you want to make yourself of use, procure the following items for me:  10 Grey Bear Tongues and the very rare and hard to find, Creeper Ichor.  You\'ll find both bears and creepers just outside of Tarren Mill.', `RewOrReqMoney` = 1200,  `parse_timestamp`='2004-05-20' WHERE `entry` = 496;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1800,  `parse_timestamp`='2004-06-01' WHERE `entry` = 500;
        UPDATE `quest_template` SET `Objectives` = 'Place the Elixir of Pain in Stanley\'s dish.', `Details` = 'Ah, nothing like the smell of fresh blood in the foothills!$B$BNow we\'ll mix in a touch of this and a little of that and let the real fun begin!  What I have created with this blood, I like to call an Elixir of Pain.  If my calculations are correct this concoction could be the start of something very beautiful for Lady Sylvanas.  But what we need is a test.$B$BTake this elixir out to the northern farm in Hillsbrad Fields to the southeast.  Let\'s see how Farmer Ray\'s little dog Stanley likes this "treat."',  `parse_timestamp`='2004-05-20' WHERE `entry` = 502;
        UPDATE `quest_template` SET `Objectives` = 'Kill Lord Aliden Perenolde and retrieve Taretha\'s pendant from his mistress, Elysa.',  `parse_timestamp`='2004-05-13' WHERE `entry` = 507;
        UPDATE `quest_template` SET `Details` = 'A Mudsnout Composite?  Absolutely brilliant!  Why didn\'t I think of that?$B$BLet me contribute my colloid of decay to this devilish brew.$B$BIn order to activate the contaminating agents in this Mudsnout Mixture, Lydon is going to need a Strong Troll\'s Blood Potion, as well as some Daggerspine Scales and Torn Fin Eyes from the southern coast.  He\'ll know what to do once you\'ve gathered him all the reagents.  And my, how anxious I am to hear how his experiment goes!',  `parse_timestamp`='2004-05-20' WHERE `entry` = 515;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1400,  `parse_timestamp`='2004-05-20' WHERE `entry` = 528;
        UPDATE `quest_template` SET `RewItemId1` = 1217, `RewItemCount1` = 1,  `parse_timestamp`='2004-06-01' WHERE `entry` = 531;
        UPDATE `quest_template` SET `Details` = 'At last we begin to hear word and rumor, find evidence of Gol\'dir\'s whereabouts. The humans have been moving him around, but we are narrowing down our search and focusing on the large Syndicate camp just north of here.$B$BGo there, $n, and bring back whatever information you can put your hands on.', `RewOrReqMoney` = 2000,  `parse_timestamp`='2004-05-18' WHERE `entry` = 533;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1300,  `parse_timestamp`='2004-06-01' WHERE `entry` = 536;
        UPDATE `quest_template` SET `Objectives` = 'Bring 5 Recovered Tomes and the the Worn Leather Book containing The Arm of Gri\'lek to Loremaster Dibbs in Southshore.', `Details` = 'Those beastly ogres now reside within Alterac\'s ruins, and I shudder to think what they\'re doing with the precious books still there.  You must recover what you can!$B$BEnter the Ruins of Alterac and search for tomes looted by the ogres.  Get whatever you can find and bring them to me, but also seek out one book in particular: The Arm of Gri\'lek.  It contains ancient troll lore that I must learn, and Alterac was the last known location of an intact copy of this book.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 540;
        UPDATE `quest_template` SET `RewOrReqMoney` = 2500,  `parse_timestamp`='2004-05-20' WHERE `entry` = 544;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1500,  `parse_timestamp`='2004-05-18' WHERE `entry` = 545;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1200,  `parse_timestamp`='2004-05-20' WHERE `entry` = 549;
        UPDATE `quest_template` SET `Details` = 'Because you fought with such valor and perseverance in the Battle of Hillsbrad, I have written this commendation, extolling your heroics in combat for the high command to recognize.$B$BTake this sealed commendation to Varimathras in the Undercity.  Go with pride, $r.',  `parse_timestamp`='2004-05-18' WHERE `entry` = 550;
        UPDATE `quest_template` SET `Details` = 'If there\'s one thing you\'ll learn about Southshore it\'s that we have some of the best cuisine north of Stormwind!$B$BTake my secret recipe for Turtle Bisque, for example.  I\'ve known folks to travel as far as Darkshire just to enjoy a bowl.  Speaking of which, I haven\'t been able to make any lately.  I used to head up past Dalaran to Lake Lordamere myself to hunt Snapjaws but it\'s just too dangerous now. If you bring me some Turtle Meat from the Snapjaws up north and Soothing Spices, I\'ll whip some up!', `RewOrReqMoney` = 500,  `parse_timestamp`='2004-06-01' WHERE `entry` = 555;
        UPDATE `quest_template` SET `RewOrReqMoney` = 2000,  `parse_timestamp`='2004-05-18' WHERE `entry` = 557;
        UPDATE `quest_template` SET `Details` = 'Throm\'ka, $r!$B$BYour arrival at Grom\'gol is timely, indeed.  As commander of the Warchief\'s base camp here in the jungle I am bound by honor to ensure the safety of all members of the Horde.  Our mission to provide a safe chain of supply to Stonard is being hampered by some of the local inhabitants.$B$BI am putting you in charge of thinning out the raptor population outside of Grom\'gol.  Once you have made significant progress, report back to me for reassignment.', `RewItemId1` = 1623, `RewItemCount1` = 1,  `parse_timestamp`='2004-05-13' WHERE `entry` = 568;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-06-01' WHERE `entry` = 57;
        UPDATE `quest_template` SET `Details` = 'The power of the jungle\'s magic must be realized and then harnessed by the Horde.  My rituals have proven successful so far.  I can cast very powerful enchantments.  For you, brave $r, I shall make a special item indeed.$B$BBring to me some Shadowmaw Panther claws along with a Tigress fang.  Not just any fang will do.  It must be in pristine condition.$B$BThe beasts lurk throughout the jungle but you will find some close by, just across the river from Mizjah Ruins to the southeast.',  `parse_timestamp`='2004-05-13' WHERE `entry` = 570;
        UPDATE `quest_template` SET `RewOrReqMoney` = 500,  `parse_timestamp`='2004-06-01' WHERE `entry` = 58;
        UPDATE `quest_template` SET `RewOrReqMoney` = 10,  `parse_timestamp`='2004-05-18' WHERE `entry` = 590;
        UPDATE `quest_template` SET `Objectives` = 'Bring 20 Singing Crystal Shards to Crank Fizzlebub.', `Details` = 'The Singing Crystals are unique to Stranglethorn, and are very valuable to certain parties.  I can move those crystals, but the cursed Venture Company makes it hard for an honest entrepreneur like myself to gather any!$B$BI\'d like to hire you.$B$BThe basilisks in Stranglethorn eat the crystal.  This gives them their hardened skin, and sometimes decent quality crystal can be harvested from it.$B$BYou can get it from any basilisk, but the less nasty ones are along the shores to the distant north.', `ReqItemCount1` = 20, `RewOrReqMoney` = 2000,  `parse_timestamp`='2004-05-18' WHERE `entry` = 605;
        UPDATE `quest_template` SET `Details` = 'My list is shortening, but there are still people who owe me.$B$BNext, we have Maury "Club Foot" Wilkins, Jon-Jon the Crow, and Chucky "Ten Thumbs."$B$BThese scurvy dogs\' debts are months outstanding and I thought they skipped town to avoid paying up!  Later, I heard they\'re cursed and bewitched and now wander the jungle ruins.  But I don\'t care what their fate is - I want what\'s mine!$B$BThey\'re at the Ruins of Aboraz and the Ruins of Jubuwai, northeast of here.  Find them, and collect.', `RewOrReqMoney` = 2500,  `parse_timestamp`='2004-05-07' WHERE `entry` = 609;
        UPDATE `quest_template` SET `Details` = 'Long ago, a great shudder of the earth sunk an old troll city beneath the waters of the Savage Coast to the northeast.  We call that place the Vile Reef, for murlocs now reside in the ruins of the city, attacking any who draw close.$B$BThere is an old tablet among those ruins that tells the ancient tale of Gri\'lek, a hero of troll legends.  The tale is sacred to the Darkspear tribe, and although the tablet is too large to move, I want a shard of it to enshrine in our new home in Orgrimmar.',  `parse_timestamp`='2004-05-18' WHERE `entry` = 629;
        UPDATE `quest_template` SET `RewOrReqMoney` = 2200,  `parse_timestamp`='2004-05-18' WHERE `entry` = 639;
        UPDATE `quest_template` SET `Objectives` = 'Gather Motes of Myzrael.$B$BBring them to the Iridescent Shards in Drywhisker Gorge.', `Details` = 'My name is Myzrael.  I am a princess of the earth, and my captors, the giants, have trapped me deep beneath the Arathi Highlands.  These crystal shards are the only way I can speak with the surface world.$B$BPlease help me.  Allies of the giants, the Drywhisker Kobolds, have a cluster of shards like this one in their Drywhisker Gorge, to the east.  To power the cluster, you must gather Motes of Myzrael from the kobolds and apply them to it.$B$BI beg you, $n, aid me!',  `parse_timestamp`='2004-05-07' WHERE `entry` = 642;
        UPDATE `quest_template` SET `Details` = 'Lolo sees a tiny ! Always on the lookout, Lolo is!$B$BWelcome to Faldir\'s Cove.  Captain O\'Breen said we\'d only be here for a few hours.  Just long enough to gather the treasure and get back to Booty Bay.$B$BBut Lolo thinks we\'re going to be here a lot longer than that.  We lost the other two ships from our formation.  Poor Spirit of Silverpine and Maiden\'s Folly.  On the bottom of the sea they rest now!$B$BLolo suggests you talk to Captain O\'Breen if you plan on sticking around here.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 663;
        UPDATE `quest_template` SET `Details` = 'It has been so long since the treasure has been on the sea floor the gems have calcified into thick stone. But the power harnessed in these goggles will allow you to locate them easily.$B$BA little gnomish ingenuity goes a long way!$B$BSo borrow the Goggles of Gem Hunting, $n, and see if you can collect some of the lost treasure for Captain O\'Breen.$B$BI\'d swim down there myself but...um...well, I have important scientific business to tend to up on the safe, dry land....er, yeah.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 666;
        UPDATE `quest_template` SET `Details` = 'There is no doubt in my mind that a powerful warlock resides within the walls of Stromgarde. From time to time, using an arcane magical relic, this warlock has summoned forth terrible demons in large numbers. We must remove the source of his energy.$B$BFind the warlock and kill him. Bring me whatever magical object you find on his person, and I will take steps to destroy it and see that its power is used to taint this land any longer.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 673;
        UPDATE `quest_template` SET `Details` = 'Tor\'gan sent you, didn\'t he? Pah! Why he feels some mercy towards me I would not understand. Mercy was denied me when I was not allowed to die with my Warchief in battle. A cruel blow fate has dealt me...',  `parse_timestamp`='2004-05-18' WHERE `entry` = 675;
        UPDATE `quest_template` SET `Objectives` = 'Kill 10 Syndicate Mercenaries and 10 Syndicate Highwaymen.$B$BReturn to Captain Nials at Refuge Pointe.', `ReqCreatureOrGOCount2` = 10,  `parse_timestamp`='2004-06-01' WHERE `entry` = 681;
        UPDATE `quest_template` SET `PrevQuestId` = 688,  `parse_timestamp`='2004-05-07' WHERE `entry` = 687;
        UPDATE `quest_template` SET `Details` = 'Free!  I AM FREE!  I am free to gather strength, hidden from my captors.  For if they faced me now they would surely overpower and again imprison me.$B$BBut in time I will confront the giants, and they will regret their wardship of me!$B$BYou are a noble ally, $n.  I will need your help again in time.  When I am ready, I will need you to summon me to the surface$B$BSpeak with Zaruk in Hammerfall.  He knows how I can be summoned.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 688;
        UPDATE `quest_template` SET `Details` = 'The name Stalvan rings a bell.  I remember now.$B$BMany years back, on a stormy night, a messenger came in, seeking refuge for the night.  Near the stroke of midnight, the man ran down the stairs screaming, his face pale with fear.  Still wearing his bedclothes, he dissappeared into the downpour.$B$BIn his haste he forgot his letters in the chest upstairs.  He never returned for them. One remains from that Stalvan fellow, intended for the Canal District in Stormwind.  Help yourself to it.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 70;
        UPDATE `quest_template` SET `Objectives` = 'Bring 5 Large Stone Slabs to Lotwil Veriatus in the Badlands.', `ReqItemCount1` = 5,  `parse_timestamp`='2004-05-07' WHERE `entry` = 711;
        UPDATE `quest_template` SET `Details` = 'Greetin\'s, $r. Be careful \'round here. There be Dark Iron dwarves all around--looked like the Shadowforge clan.$B$BThey just attacked the excavation site I was workin\' at... killed nearly everyone there, including my boss Hammertoe. I barely escaped with me life.$B$BThe site\'s just to the north of here, and I\'m tryin\' to plan a way to get some of our supplies back, especially me lucky pick.$B$BThink you\'d be up to helpin\' me out some? I\'d like to at least get me pick back, if nothing else.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 719;
        UPDATE `quest_template` SET `Details` = 'Inside the crate you find various objects: musty heirlooms, a family portrait, a few hunting trophies and some old books.  Near the bottom, underneath a cermaic vase, you uncover A Torn Journal Page.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 74;
        UPDATE `quest_template` SET `RewOrReqMoney` = 200,  `parse_timestamp`='2004-04-25' WHERE `entry` = 743;
        UPDATE `quest_template` SET `Details` = 'I have traveled many paths through life and these old legs lack the vigor they once had. I can still perform my duties to the tribe. Sometimes it just takes an old woman a little longer to do the task.$B$BBut you look like an eager $r. Let\'s put some of that youthful vitality to the test. Take a water pitcher from the well and bring it to my son, the Chief, in Camp Narache.$B$BRemember that even the most humble task can gain the recognition of elders.', `RewOrReqMoney` = 35,  `parse_timestamp`='2004-04-25' WHERE `entry` = 753;
        UPDATE `quest_template` SET `Details` = 'Your willingness to perform a humble task for the tauren of Narache and your eagerness to learn are noble traits, $n. I believe one day you will be heralded in Thunder Bluff as a $r of greatness.$B$BBefore that you must embark on the Rites of the Earthmother, of which there are three.$B$BThe first test is the Rite of Strength. Travel to Seer Graytongue and tell him Chief Hawkwind has sent you.$B$BYou will find the seer\'s abode directly to the south of Camp Narache, tucked away in the hills.',  `parse_timestamp`='2004-04-25' WHERE `entry` = 755;
        UPDATE `quest_template` SET `Details` = 'To gain acceptance amongst the elders of Thunder Bluff you must next complete the Rite of Wisdom.$B$BNow that you have passed the Rite of Vision, the ancestral spirits of Red Rocks will give you the blessing of our ancestors. Only those who have drank from the Water of Seers can gain the blessing.$B$BTravel east of Thunder Bluff, to Red Rocks and seek out the Ancestral Spirit, $n.',  `parse_timestamp`='2004-04-25' WHERE `entry` = 773;
        UPDATE `quest_template` SET `Details` = 'I know of someone who might be able to assist you.  Back when I was leading the Stormwind Guard, we used to get drinks at the Scarlet Raven Tavern in Darkshire.  The Tavernkeep there, Smitts, was quite an expert on the local lore.  Show him this page and see what he has to say about it.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 78;
        UPDATE `quest_template` SET `Objectives` = 'Grull Hawkwind in Camp Narache wants you to kill Battleboars and bring back 4 Battleboar Snouts and 4 Battleboar Flanks.', `ReqItemCount1` = 4, `ReqItemCount2` = 4,  `parse_timestamp`='2004-04-25' WHERE `entry` = 780;
        UPDATE `quest_template` SET `Details` = 'From the Horde\'s alliance with the dragon Deathwing during the Second War, we know that two of his lieutenants, the black drakes Blacklash and Hematus, were imprisoned within Lethlor Ravine.$B$BNow we seek to silence our depraved allies of old, restoring honor to the name of the Horde. We hired Tho\'grun and his band of ogre mercenaries to help us obtain the Sign of the Earth, a key needed to unlock the drakes\' prison.$B$BTho\'grun betrayed us, however, overwhelming us and taking the Sign for himself.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 782;
        UPDATE `quest_template` SET `Details` = 'Lower your voice, $r. The Kolkar centaurs lie just over the ridge to the west in Kolkar Crag.$B$BLast night while they were raiding, I snuck into their village and discovered that the dirty beasts have a three-tiered attack planned on the trolls and orcs of Durotar.$B$BWe mustn\'t let their invasion come to fruition. Perhaps you can muster the might needed to infiltrate Kolkar Crag and destroy their attack plans.$B$BLast I saw, they had divided them up amongst three of their leaders.',  `parse_timestamp`='2004-04-25' WHERE `entry` = 786;
        UPDATE `quest_template` SET `PrevQuestId` = 787,  `parse_timestamp`='2004-05-20' WHERE `entry` = 788;
        UPDATE `quest_template` SET `Objectives` = 'Get 8 Scorpid Worker Tails for Gornek in the Den.', `Details` = 'Powerful warrior and awkward novice alike have fallen to the venomous sting of the scorpid. You will find large numbers of scorpids northwest of here. Bring me eight of their tails as proof of your prowess in battle.$B$BThe antidote for their sting is actually made from venom extracted from their stingers. We keep large quantities of antidote for scorpid venom on hand to heal young bloods just like you...$B$BBut I\'m sure you won\'t be needing any of that, will you?', `ReqItemCount1` = 8,  `parse_timestamp`='2004-05-20' WHERE `entry` = 789;
        UPDATE `quest_template` SET `Details` = '$r! I thought I would die out here with none to know of it. While I was hunting the scorpids of the Valley, I came across a particularly vicious-looking one. Hurling myself at it, I managed to inflict a massive blow to its claw before it closed around my leg.$B$BI wasn\'t ready for its stinger though, and it sliced down and into my chest, cutting into my flesh and letting my blood. Please, you must kill the scorpid for me! My honor must be upheld! I fought it up on the plateau to the south.',  `parse_timestamp`='2004-04-25' WHERE `entry` = 790;
        UPDATE `quest_template` SET `Title` = 'Journey to the Undercity!',  `parse_timestamp`='2004-05-07' WHERE `entry` = 798;
        UPDATE `quest_template` SET `Title` = 'Journey to the Undercity!',  `parse_timestamp`='2004-05-20' WHERE `entry` = 802;
        UPDATE `quest_template` SET `Title` = 'Journey to Grom\'gol',  `parse_timestamp`='2004-05-18' WHERE `entry` = 803;
        UPDATE `quest_template` SET `Title` = 'Report to Orgnil', `Objectives` = 'Speak with Orgnil Soulscar in Razor Hill.', `Details` = 'Your trials against the Burning Blade are finished...here in the Valley.  But I want you to report your findings.$B$BGo to the town Razor Hill and seek out Orgnil Soulscar.  Razor Hill is east out of the valley, then north along the dry riverbed.$B$BWe must tell Orgnil of the Burning Blade, and that they have reached as far as the Valley of Trials.$B$BGo, $n, and be swift.  I fear the evil found in the Burning Blade Coven is but the herald of a larger threat...',  `parse_timestamp`='2004-04-25' WHERE `entry` = 805;
        UPDATE `quest_template` SET `Details` = '$n, I have grim news.  My investigations into the Burning Blade revealed more groups hiding within Durotar.  We cannot allow this!  We must destroy them before they gain a foothold, and before their evil festers!$B$BA warlock, a goblin called Fizzle Darkstorm, has camped within Thunder Ridge to the northwest.  There he and his cultist minions spread chaos.$B$BFind and defeat Fizzle, and bring me his dead claw!',  `parse_timestamp`='2004-04-25' WHERE `entry` = 806;
        UPDATE `quest_template` SET `Details` = 'I hear the voice of my brother, Minshina, calling to me in my dreams.$B$BHe was taken by Zalazane, the warlock on the Echo Isles. And he is dead.$B$BBut death is not freedom for my poor brother. Minshina\'s spirit was trapped within his own skull by Zalazane\'s evil magics. In my dreams I see it with other skulls, in a circle of power on the largest Echo Isle. As long as it remains there my brother\'s soul is doomed.$B$BPlease, $n. Find the circle and retrieve Minshina\'s skull. Bring it to me.$B$BFree him!',  `parse_timestamp`='2004-04-25' WHERE `entry` = 808;
        UPDATE `quest_template` SET `Details` = 'Many of the hides we use come from Durotar tigers, $n. Blankets, armor, tents: there are a great many reasons we hunt the beasts, and many reasons we let them thrive at the same time.$B$BThe time has come to for us to cull the flock, so to speak. Our numbers grow, and our needs are beginning to overwhelm our stocks. I need more hides if I\'m to prepare suitable goods for our people.$B$BBring me 4 Durotar tiger furs, and I shall reward you.', `RewOrReqMoney` = 200,  `parse_timestamp`='2004-04-25' WHERE `entry` = 817;
        UPDATE `quest_template` SET `Details` = 'Although my eyes fail me, I still can see clearly enough. More often I must rely on my alchemical skills to aid me in magics that once came easily. But I refuse to take on an apprentice--no troll or orc worthy enough has ever come forward.$B$BAre you worthy? Yes, of course you are... of course you think you are.$B$BI need a few things. Will you get them for me?$B$BI need 4 intact makrura eyes, and 8 vials of crawler mucus. You can find them on any crawler or makrura in Durotar. We shall speak again soon.', `RewOrReqMoney` = 50,  `parse_timestamp`='2004-04-25' WHERE `entry` = 818;
        UPDATE `quest_template` SET `Title` = 'Master Gadrin', `Objectives` = 'Speak with Master Gadrin in Sen\'jin Village.', `Details` = 'News regarding the Burning Blade has me troubled.  And I have reports from our troll allies at Sen\'jin Village that other evils may be brewing in our lands.  We must stamp these out!  Our people did not endure and defeat the demon\'s curse to let it infect our new home!$B$BI will investigate the Burning Blade.  You go to Sen\'jin Village to the south and speak with Gadrin.  He will tell you of their troubles.$B$BHelp the trolls, then return to me.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 823;
        UPDATE `quest_template` SET `Objectives` = 'Kill 12 Dustwind Savages and 8 Dustwind Storm Witches for Rezlak near Orgrimmar.',  `parse_timestamp`='2004-04-25' WHERE `entry` = 835;
        UPDATE `quest_template` SET `RewOrReqMoney` = 600,  `parse_timestamp`='2004-05-20' WHERE `entry` = 848;
        UPDATE `quest_template` SET `RewOrReqMoney` = 800,  `parse_timestamp`='2004-05-20' WHERE `entry` = 849;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1800,  `parse_timestamp`='2004-05-20' WHERE `entry` = 857;
        UPDATE `quest_template` SET `Objectives` = 'Bring Root Samples to Mebok Mizzyrix in Ratchet.', `RewOrReqMoney` = 200,  `parse_timestamp`='2004-06-01' WHERE `entry` = 866;
        UPDATE `quest_template` SET `Details` = 'You have hunted the beasts of the Barrens.  Your spirit is strong.  But a hunter must always be prepared.  A true hunter can stalk prey down any path.  Mountains and swamps will not sway :her;.$B$BNot even the sea.$B$BFind my sister Mahren.  She hunts the great water beasts along the coast.  She will be your teacher in their ways.$B$BBut be wary in your search for her, for the Barrens\' coast is held by humans.',  `parse_timestamp`='2004-05-07' WHERE `entry` = 874;
        UPDATE `quest_template` SET `Objectives` = 'Kill 12 Bristleback Geomancers and return to Mangletooth at the Crossroads.', `Details` = 'You! ! Come here. *snort*$B$BTime is short, and my end *snort* is near. Mangletooth shall win; you will see. *snort*$B$BMy capture can still aid *snort* the Razormanes. The Horde wants to know who leads the raids on their people? Then you *snort* shall aid Mangletooth in return for information.$B$BThe Bristleback tribe, our hated enemies, rely too much on their geomancers. To slay them would help my tribe... and yours. *snort* A good deal, yes? Head south and slay them, and we shall talk again..', `ReqCreatureOrGOId1` = 3263, `ReqCreatureOrGOCount1` = 12, `ReqCreatureOrGOId2` = 0, `ReqCreatureOrGOCount2` = 0, `ReqCreatureOrGOId3` = 0, `ReqCreatureOrGOCount3` = 0,  `parse_timestamp`='2004-04-25' WHERE `entry` = 878;
        UPDATE `quest_template` SET `PrevQuestId` = 878, `Objectives` = 'Kill Nak, Kuz, and Lok Orcbane and bring their Skulls to Mangletooth at the Crossroads.', `Details` = 'But now you want the information I promised,  yes? It matters not. I shall turn my back on my tribe, as they turned on me, leaving me to rot in this cage. $B$BHope that I would be rescued once filled my heart, but now I know the truth: my life is meaningless to my tribe.  My sacrifices do not warrant sacrifices of their own. So be it.$B$BNak, Kuz, and Lok Orcbane are the ones you seek. They are to the southeast of the Field of Giants.$B$BKill them, as they have killed me.',  `parse_timestamp`='2004-05-13' WHERE `entry` = 879;
        UPDATE `quest_template` SET `RewOrReqMoney` = 400,  `parse_timestamp`='2004-05-20' WHERE `entry` = 887;
        UPDATE `quest_template` SET `Objectives` = 'Bring 5 Iron Pikes and 5 Iron Rivets to Forman Oslow in Lakeshire.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 89;
        UPDATE `quest_template` SET `Details` = 'I\'ve been waiting forever for my last shipment of goods from Booty Bay! I\'m pretty sure that it must have been stolen by the Freebooters, but just to make sure, will you go down to the dockside and ask Dizzywig if my goods were already put into my warehouse without my knowledge.$B$BHere, take my ledger down to Dizzywig and have him double check my inventory records against his logs.',  `parse_timestamp`='2004-05-20' WHERE `entry` = 890;
        UPDATE `quest_template` SET `Details` = 'Being Wharfmaster of a busy port like Ratchet, I keep my finger on the pulse of information. I know all about the exchange of goods and money between here and Booty Bay.$B$BThe latest bit of news I\'ve heard is about the Venture Company\'s Boulder Load mine northeast of the Sludge Fen. One of the miners discovered an emerald the size of your fist. I know a few buyers who\'d be interested in getting their hands on something like that, and I\'d be willing to go half and half on its sale.',  `parse_timestamp`='2004-05-20' WHERE `entry` = 896;
        UPDATE `quest_template` SET `RewOrReqMoney` = 700,  `parse_timestamp`='2004-06-01' WHERE `entry` = 898;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1000,  `parse_timestamp`='2004-06-01' WHERE `entry` = 90;
        UPDATE `quest_template` SET `Objectives` = 'Bring Lok\'s Skull to Thork at the Crossroads.', `Details` = 'Take Lok\'s head to Thork over there by the wagons, $r. *snort* He should know what\'s happened to my tribe. Ha, not that he\'d believe I helped in *snort* such things, but I\'m sure he\'ll reward you for carrying out such a great deed. *snort*$B$BWe will not speak again. *snort*',  `parse_timestamp`='2004-05-13' WHERE `entry` = 906;
        UPDATE `quest_template` SET `RewOrReqMoney` = 1100,  `parse_timestamp`='2004-06-01' WHERE `entry` = 91;
        UPDATE `quest_template` SET `Title` = 'Cry of the Cloudscraper', `Objectives` = 'Find and slay a Thunderhawk Cloudscraper, return its wings to Sergra Darkthorn in the Crossroads.', `Details` = 'Something is disrupting the energies of my spell! The Earthmother is crying out, can you not hear it, $n?$B$BEarthmother! What is it that tears at your spirit?$B$B$n, you must do as I say. Seek out the flying serpent Cloudscraper to the south, slay it and bring me its wings. Something dark has come upon the Barrens, and we are all at risk.$B$BBe swift, $r. I do not know what atrocities it commits, but they must be of great magnitude to rile the spirits so.',  `parse_timestamp`='2004-05-20' WHERE `entry` = 913;
        UPDATE `quest_template` SET `RewOrReqMoney` = 300,  `parse_timestamp`='2004-06-01' WHERE `entry` = 92;
        UPDATE `quest_template` SET `Details` = 'I\'ll let you in on a little secret - Dusky "Crab" Cakes are really made from spider legs!  I know it\'s a bit disgusting, but the cakes have a nice, tangy flavor and make great snacks!  Bring me Gooey Spider Legs and I\'ll whip you up a few of them.$B$BI hear Venom Web Spiders are a good source - they nest to the northeast between the foothills and the river.  Or, Gooey Spider Legs from any spiders in Duskwood will work.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 93;
        UPDATE `quest_template` SET `RewItemId1` = 1217, `RewItemCount1` = 1,  `parse_timestamp`='2004-06-01' WHERE `entry` = 94;
        UPDATE `quest_template` SET `Objectives` = 'Archaeologist Flagongut in Menethil Harbor wants you to bring him the Stone of Relu.', `Details` = 'Prospector Whelgar now holds the original sample at his site - I gave it to him after the conference. Later, I uncovered the Stone of Relu in Loch Modan that I believed to be the key to unlocking the mystery of the fossil.$B$BWhen I tried to travel to Whelgar, I was attacked by raptors and the relic was lost.$B$BI don\'t know which one of the mottled beasts swallowed the relic but if you can retrieve it, I can unleash the power of these artifacts. We\'ll need the original fossil from Whelgar\'s site as well.', `ReqItemId2` = 0, `ReqItemCount2` = 0,  `parse_timestamp`='2004-06-01' WHERE `entry` = 943;
        UPDATE `quest_template` SET `Details` = 'I used to work one of the farms to the southeast...until Dark Riders from Deadwind Pass descended upon my farm and slaughtered my family when I was away!$B$BWhen I returned I saw a shadowy figure skulking near my barn, burying something.  He fled before I could catch him, and I couldn\'t linger for I was hot on the heels of the Dark Riders.  So I never discovered what was hidden.$B$BIf you can find what that shadowy figured buried, I would be grateful.  The hiding spot is behind the old stump near my barn.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 95;
        UPDATE `quest_template` SET `RewItemId1` = 5622, `RewItemCount1` = 1,  `parse_timestamp`='2004-06-01' WHERE `entry` = 973;
        UPDATE `quest_template` SET `Details` = 'Stalvan Mistmantle led a life of depravity.  Innocent victims died by his hand.  Undoubtedly he is guilty of countless crimes.  Now the lunatic threatens Darkshire.  The Light only knows what sordid acts he is plotting.  Travel to his cottage just north of town, $r, and execute Stalvan, once and for all.$B$BWhen the deed is done, travel to Madame Eva\'s and show her his family ring.  After all, it was her premonition that led to this gruesome discovery.  But Darkshire is safer because of her.',  `parse_timestamp`='2004-06-01' WHERE `entry` = 98;
        UPDATE `quest_template` SET `PrevQuestId` = 990,  `parse_timestamp`='2004-06-01' WHERE `entry` = 991;

        INSERT INTO `applied_updates` VALUES ('140920231');
    end if;

    -- 16/09/2023 1
	if (select count(*) from applied_updates where id='160920231') = 0 then
        -- Quest Ambushed in the Forest - Duskwood zone.
        UPDATE `quest_template` SET `ZoneOrSort` = '10' WHERE (`entry` = '172');
        -- Quest Four-Legged Meneces, correct required kills, xp and rew money. Add offer reward text.
        UPDATE `quest_template` SET `OfferRewardText` = 'Excellent. Your assistance to the people of Duskwood will not be forgotten. Here, a token of my appreciation.', `ReqCreatureOrGOCount1` = '12', `RewXP` = '1500', `RewOrReqMoney` = '800' WHERE (`entry` = '171');
       -- Rot Hide Graverobbers's Display ID.
        UPDATE `creature_template` SET `display_id1` = '847' WHERE (`entry` = '1941');
        -- Closes #1288
        UPDATE `creature_template` SET `subname` = '' WHERE (`entry` = '2477');
        UPDATE `creature_template` SET `subname` = '' WHERE (`entry` = '2478');
        -- Krang Stonehoof - Remove OOC script not valid for alpha.
        DELETE FROM `creature_ai_events` WHERE (`id` = '306301');
        -- Script between Grub (3443) and Duhng (8306 - Ignored spawn)
        DELETE FROM `creature_ai_events` WHERE (`id` = '344301');

        insert into applied_updates values ('160920231');
    end if;

    -- 17/09/2023 1
	if (select count(*) from applied_updates where id='170920231') = 0 then

        -- WEAPON - same models as vanilla
        
        -- Riverpaw Mystic Staff
        UPDATE `item_template` SET `display_id` = 5542 WHERE `entry`= 1391;

        -- Sword Of Decay
        UPDATE `item_template` SET `display_id` = 5166 WHERE `entry`= 1727;

        -- Gouging Pick
        UPDATE `item_template` SET `display_id` = 6259 WHERE `entry`= 1819;

        -- Oaken War Staff
        UPDATE `item_template` SET `display_id` = 1716 WHERE `entry`= 1831;

        -- Cold Iron Pick
        UPDATE `item_template` SET `display_id` = 1682 WHERE `entry`= 1959;

        -- Morning Star
        UPDATE `item_template` SET `display_id` = 7477 WHERE `entry`= 2532;

        -- Spinner Fang
        UPDATE `item_template` SET `display_id` = 6447 WHERE `entry`= 2664;

        -- Hurricane
        UPDATE `item_template` SET `display_id` = 6235 WHERE `entry`= 2824;

        -- BKP 42
        UPDATE `item_template` SET `display_id` = 6592 WHERE `entry`= 3025;

        -- "Mage-Eye" Blunderbuss
        UPDATE `item_template` SET `display_id` = 2409 WHERE `entry`= 3041;

        -- Naga Heatpiercer
        UPDATE `item_template` SET `display_id` = 8106 WHERE `entry`= 3078;

        -- Deadman Cleaver
        UPDATE `item_template` SET `display_id` = 8466 WHERE `entry`= 3293;

        -- Vile Fin Battle Axe
        UPDATE `item_template` SET `display_id` = 8899 WHERE `entry`= 3325;

        -- Decapitating Sword
        UPDATE `item_template` SET `display_id` = 859 WHERE `entry`= 3740;

        -- Compound Bow
        UPDATE `item_template` SET `display_id` = 8107 WHERE `entry`= 3778;

        -- Sharp Shortsword
        UPDATE `item_template` SET `display_id` = 5129 WHERE `entry`= 4017;

        -- Sentinel Musket
        UPDATE `item_template` SET `display_id` = 2409 WHERE `entry`= 4026;

        -- Guerilla Cleaver
        UPDATE `item_template` SET `display_id` = 5639 WHERE `entry`= 4126;

        -- Silver Spade
        UPDATE `item_template` SET `display_id` = 7495 WHERE `entry`= 4128;

        -- Shadow Wand
        UPDATE `item_template` SET `display_id` = 6093 WHERE `entry`= 5071;

        -- Firebelcher
        UPDATE `item_template` SET `display_id` = 9062 WHERE `entry`= 5243;

        -- Elven Wand
        UPDATE `item_template` SET `display_id` = 6093 WHERE `entry`= 5604;

        -- Gemstone Dagger
        UPDATE `item_template` SET `display_id` = 6454 WHERE `entry`= 5742;

        -- Wyvern Tailspike
        UPDATE `item_template` SET `display_id` = 6447 WHERE `entry`= 5752;

        -- Darkwood Fishing Pole
        UPDATE `item_template` SET `display_id` = 7453 WHERE `entry`= 6366;

        -- Big Iron Fishing Pole
        UPDATE `item_template` SET `display_id` = 7453 WHERE `entry`= 6367;

        -- Antipodeon Rod
        UPDATE `item_template` SET `display_id` = 9062 WHERE `entry`= 2879;

        -- SHIELD - Same models as vanilla

        -- Wall Of The Dead
        UPDATE `item_template` SET `display_id` = 2456 WHERE `entry`= 1979;

        -- Small Round Shield
        UPDATE `item_template` SET `display_id` = 1680 WHERE `entry`= 2219;

        -- Box Shield
        UPDATE `item_template` SET `display_id` = 5422 WHERE `entry`= 2220;

        -- Targe Shield
        UPDATE `item_template` SET `display_id` = 1684 WHERE `entry`= 2221;

        -- Deflecting Tower
        UPDATE `item_template` SET `display_id` = 5422 WHERE `entry`= 3987;

        -- Blocking Targe
        UPDATE `item_template` SET `display_id` = 4983 WHERE `entry`= 3989;

        -- Plated Buckler
        UPDATE `item_template` SET `display_id` = 4108 WHERE `entry`= 3991;

        -- Standard Issue Shield
        UPDATE `item_template` SET `display_id` = 4404 WHERE `entry`= 4263;

        -- Reinforced Buckler
        UPDATE `item_template` SET `display_id` = 2916 WHERE `entry`= 3817;

        -- Blackforge Buckler
        UPDATE `item_template` SET `display_id` = 6275 WHERE `entry`= 4069;

        -- Charging Buckler
        UPDATE `item_template` SET `display_id` = 2208 WHERE `entry`= 4937;

        -- Vigilant Buckler
        UPDATE `item_template` SET `display_id` = 6274 WHERE `entry`= 4975;

        -- CLOAK - PH based on screenshot
        
        -- inv_robe_2 (cloth)
        UPDATE `item_template` SET `display_id` = 936 WHERE `entry` IN (1190, 1782, 3331, 3475, 3749, 3803, 3955, 3964, 3972, 3980, 5969, 6417, 6424, 6432, 4735, 3261, 3939, 4944, 4011, 3795, 3995, 4327, 4732);

        -- inv_misc_pelt_wolf (leather)
        UPDATE `item_template` SET `display_id` = 6655 WHERE `entry` IN (4771, 5965, 4963, 1280, 1355, 2308, 3008, 1798);

        -- inv_misc_cap_02 (mail)
        UPDATE `item_template` SET `display_id` = 7952 WHERE `entry` IN (4933, 4958, 1774);

        -- RING, the first ring icon ever avalaible

        -- PH Inv_Jewelry_Ring_01
        UPDATE `item_template` SET `display_id` = 224 WHERE `entry` IN (1993, 862, 1447);

        insert into applied_updates values ('170920231');
    end if;

    -- 19/09/2023 1
    if (select count(*) from `applied_updates` where id='190920231') = 0 then

        -- ROBES

        -- Scarlet Initiate Robe
        UPDATE `item_template` SET `display_id` = 8846 WHERE `entry` = 3260;

        -- Spider Web Robe
        UPDATE `item_template` SET `display_id` = 8856  WHERE `entry` = 3328;

        -- Robe of the Keeper
        UPDATE `item_template` SET `display_id` = 10896  WHERE `entry` = 3161;

        -- Vicar's Robe
        UPDATE `item_template` SET `display_id` = 3876  WHERE `entry` = 3569;

        -- Beastwalker Robe
        UPDATE `item_template` SET `display_id` =  4741 WHERE `entry` = 4476 ;

        -- Mage Dragon Robe
        UPDATE `item_template` SET `display_id` =  8865 WHERE `entry` = 4989;

        -- Dalaran Robe, Lesser Wizard Robe
        UPDATE `item_template` SET `display_id` =  8864 WHERE `entry` in (5110, 5766, 5767);

        -- Robe of Arcana
        UPDATE `item_template` SET `display_id` =  8865 WHERE `entry` = 5770;

        -- Robe of Antiquity
        UPDATE `item_template` SET `display_id` =  9053 WHERE `entry` = 5812;

        -- Bloody Apron
        UPDATE `item_template` SET `display_id` =  10810 WHERE `entry` = 6226;

        -- Green Woolen Robe
        UPDATE `item_template` SET `display_id` =  10894 WHERE `entry` = 6243;

        -- Robe of Arugal
        UPDATE `item_template` SET `display_id` =  11528 WHERE `entry` = 6324;

        -- OFFHAND 

        -- Fireproof Orb, Orb of Power
        UPDATE `item_template` SET `display_id` =  8043 WHERE `entry` IN (4836, 4838) ;

        -- Sakrasis Scepter
        UPDATE `item_template` SET `display_id` =  7479 WHERE `entry` = 5028;

        -- Strength of Will, SpellStone
        UPDATE `item_template` SET `display_id` =  8044 WHERE `entry` IN (4837, 5522) ;

        -- Skull of Impending Doom
        UPDATE `item_template` SET `display_id` =  7469 WHERE `entry` = 4984 ;

        -- Swampchill Fetish
        UPDATE `item_template` SET `display_id` = 7469 WHERE `entry` = 1992;

        -- MISC

        -- Quiver have no models, we use PH icons (first quiver icon)
        UPDATE `item_template` SET `display_id` =  5560 WHERE `entry` IN (3605, 2662, 3573);

        -- Thunderbrew's Boot Flask, inv_wine_02, drink icons are not present
        UPDATE `item_template` SET `display_id` = 7920 WHERE `entry` = 744;

        -- Skullflame Shield, it is a buckler for 0.5.3
        UPDATE `item_template` SET `display_id` = 2456 WHERE `entry` = 1168;

        -- Eye of flames
        UPDATE `item_template` SET `display_id` = 1170 WHERE `entry` = 3075;

        -- Ironheart Chain, PH low lvl mail
        UPDATE `item_template` SET `display_id` = 977 WHERE `entry` = 3166;

        insert into `applied_updates` values ('190920231');
    end if;
    
        -- 22/09/2023 1
    if (select count(*) from `applied_updates` where id='220920231') = 0 then
        DELETE FROM `quest_end_scripts` WHERE (`id` = '407');
        INSERT INTO `quest_end_scripts` (`id`,`delay`,`priority`,`command`,`datalong`,`datalong2`,`datalong3`,`datalong4`,`target_param1`,`target_param2`,`target_type`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`condition_id`,`comments`) VALUES (407,4,0,20,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Fields of Grief 2: Captured Scarlet Zealot - Start Waypoint Movement');
        INSERT INTO `quest_end_scripts` (`id`,`delay`,`priority`,`command`,`datalong`,`datalong2`,`datalong3`,`datalong4`,`target_param1`,`target_param2`,`target_type`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`condition_id`,`comments`) VALUES (407,3,0,15,3287,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,'Fields of Grief 2: Captured Scarlet Zealot - Cast Ghoul Form');
        INSERT INTO `quest_end_scripts` (`id`,`delay`,`priority`,`command`,`datalong`,`datalong2`,`datalong3`,`datalong4`,`target_param1`,`target_param2`,`target_type`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`condition_id`,`comments`) VALUES (407,0,0,0,0,0,0,0,0,0,0,0,425,0,0,0,0,0,0,0,0,'Fields of Grief 2: Captured Scarlet Zealot - Say Text 1');
        INSERT INTO `quest_end_scripts` (`id`,`delay`,`priority`,`command`,`datalong`,`datalong2`,`datalong3`,`datalong4`,`target_param1`,`target_param2`,`target_type`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`condition_id`,`comments`) VALUES (407,6,0,0,0,0,0,0,0,0,0,0,428,0,0,0,0,0,0,0,0,'Fields of Grief 2: Captured Scarlet Zealot - Say Text 2');
        INSERT INTO `quest_end_scripts` (`id`,`delay`,`priority`,`command`,`datalong`,`datalong2`,`datalong3`,`datalong4`,`target_param1`,`target_param2`,`target_type`,`data_flags`,`dataint`,`dataint2`,`dataint3`,`dataint4`,`x`,`y`,`z`,`o`,`condition_id`,`comments`) VALUES (407,22,0,15,7,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,'Fields of Grief 2: Captured Scarlet Zealot - Cast Suicide');

        -- Fix quest Leaders of the Fang given information from June 2004.
        UPDATE `quest_template` SET `PrevQuestId` = '0', `Title` = '<NYI> Leaders of the Fang', `Details` = 'The druids in the Wailing Caverns, the Druids of the Fang, are an aberration.  They were part of an order of noble druids whose plan was to heal the Barrens, but now seek to remake that land to match their own, twisted dreams.$B$BI have seen them in my dreams, and even now their faces haunt me. You must defeat them if the Barrens is ever to know peace.$B$BGo, $N.  You will find them lurking deep within the Wailing Caverns', `Objectives` = 'Kill Cobrahn, Anacondra, Pythas and Serpentis, then return to Nara Wildmane in Thunder Bluff.', `RequestItemsText` = 'Memories of my nightmares haunt me, $N.  Have you defeated the leaders of the fang?', `ReqCreatureOrGOId1` = '3669', `ReqCreatureOrGOId2` = '3670', `ReqCreatureOrGOId3` = '3671', `ReqCreatureOrGOId4` = '3673', `ReqCreatureOrGOCount1` = '1', `ReqCreatureOrGOCount2` = '1', `ReqCreatureOrGOCount3` = '1', `ReqCreatureOrGOCount4` = '1', `RewItemId1` = '1217', `RewItemCount1` = '1' WHERE (`entry` = '914');

        insert into `applied_updates` values ('220920231');
    end if;
    
    -- 23/09/2023 1
    if (select count(*) from `applied_updates` where id='230920231') = 0 then
       
        -- mistake on the last PR, good color for Sakrasis Scepter
        UPDATE `item_template` SET `display_id` =  7203 WHERE `entry` = 5028;

        -- mistake on last PR, good color for Fireproof Orb
        UPDATE `item_template` SET `display_id` =  5566 WHERE `entry` = 4836 ;

        -- mistake on the last PR good color for Skull of Impending Doom, Swampchill Fetish
        UPDATE `item_template` SET `display_id` =  5565 WHERE `entry` IN (4984, 1992);

        -- mistake on the last PR, good color for Antipodeon Rod
        UPDATE `item_template` SET `display_id` = 6168 WHERE `entry`= 2879;

        -- mistake on the last PR, good icons for Quiver
        UPDATE `item_template` SET `display_id` =  1302 WHERE `entry` IN (3605, 2662, 3573);

        -- Brain Hacker
        UPDATE `item_template` SET `display_id` =  8505 WHERE `entry` = 1263;

        -- Red Linen Bag
        UPDATE `item_template` SET `display_id` =  981 WHERE `entry` = 5762;

        -- Axe of the Deep Woods
        UPDATE `item_template` SET `display_id` =  2805 WHERE `entry` = 811;

        -- Glowing Brightwood Staff
        UPDATE `item_template` SET `display_id` =  1469 WHERE `entry` = 812;

        -- Pysan's Old Greatsword
        UPDATE `item_template` SET `display_id` =  1638 WHERE `entry` = 1975;

        -- Staff of the Shade
        UPDATE `item_template` SET `display_id` =  5546 WHERE `entry` = 2549;

        -- Monster - Item, Tankard Wooden
        UPDATE `item_template` SET `display_id` =  6588 WHERE `entry` = 2703;

        -- Monster - Item, Tankard Dirty
        UPDATE `item_template` SET `display_id` =  6586 WHERE `entry` = 2704;

       -- Monster - Item, Tankard Metal
        UPDATE `item_template` SET `display_id` =  6587 WHERE `entry` = 2705;

       -- Troll Dagger
        UPDATE `item_template` SET `display_id` =  11282 WHERE `entry` = 2787;

        -- Monster - Dynamite, Lit
        UPDATE `item_template` SET `display_id` =  7435 WHERE `entry` =2884;

        -- Monster - Dynamite, Unlit
        UPDATE `item_template` SET `display_id` =  7436 WHERE `entry` = 3774;

        -- Monster - Wand, Basic
        UPDATE `item_template` SET `display_id` = 5806   WHERE `entry` = 6230;

        -- Monster - Wand, Jeweled - Green
        UPDATE `item_template` SET `display_id` = 10819   WHERE `entry` = 6231;

        -- Baron's Sceptre
        UPDATE `item_template` SET `display_id` = 1159   WHERE `entry` = 6323;

        -- Spikelash Dagger
        UPDATE `item_template` SET `display_id` = 11282  WHERE `entry` = 6333;

        -- Spikelash Dagger
        UPDATE `item_template` SET `display_id` = 1200 WHERE `entry` = 1282;

        -- Skullsplitter Helm
        UPDATE `item_template` SET `display_id` =  1130 WHERE `entry` = 1684;

        -- Naga Battle Gloves
        UPDATE `item_template` SET `display_id` =  3524 WHERE `entry` = 888;

        insert into `applied_updates` values ('230920231');
    end if;

    -- 24/09/2023 1
    if (select count(*) from `applied_updates` where id='240920231') = 0 then
    
        -- PH leather cloak
        UPDATE `item_template` SET `display_id` =  6655 WHERE `entry` IN (4920, 5313);

        -- Cowl of Necromancy
        UPDATE `item_template` SET `display_id` =  3551 WHERE `entry` = 2621;

        -- Craftsman's Monocle
        UPDATE `item_template` SET `display_id` = 6493 WHERE `entry` = 4393;

        -- Enduring Cap
        UPDATE `item_template` SET `display_id` = 3167 WHERE `entry` = 3020;

        -- Augural Shroud
        UPDATE `item_template` SET `display_id` = 7892 WHERE `entry` = 2620;

        -- Crochet Belt
        UPDATE `item_template` SET `display_id` = 10091 WHERE `entry` = 3936;

        -- Black Velvet Robes
        UPDATE `item_template` SET `display_id` = 9897 WHERE `entry` = 2800;

        -- Blackforge Cowl
        UPDATE `item_template` SET `display_id` = 3761 WHERE `entry` = 4080;

        -- Brigandine Helm
        UPDATE `item_template` SET `display_id` = 1126 WHERE `entry` = 3894;

        -- Cloaked Hood
        UPDATE `item_template` SET `display_id` = 4369 WHERE `entry` = 1280;

        insert into `applied_updates` values ('240920231');
    end if;

end $
delimiter ;
