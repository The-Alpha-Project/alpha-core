delimiter $
begin not atomic

    -- 12/07/2024 1
	if (select count(*) from applied_updates where id='120720241') = 0 then
        -- Green Tea Leaf
        UPDATE `item_template` SET `display_id` = 2336 WHERE (`entry` = 1401);

        -- Scroll of Strength
        UPDATE `item_template` SET `spellid_1` = 365 WHERE (`entry` = 954);

        -- Scroll of Intellect
        UPDATE `item_template` SET `spellid_1` = 1459 WHERE (`entry` = 955);

        -- Scroll of Stamina
        UPDATE `item_template` SET `spellid_1` = 344 WHERE (`entry` = 1180);

        -- Scroll of Stamina II
        UPDATE `item_template` SET `spellid_1` = 554 WHERE (`entry` = 1711);

        -- Scroll of Strength II
        UPDATE `item_template` SET `spellid_1` = 549 WHERE (`entry` = 2289);

        -- Scroll of Intellect II
        UPDATE `item_template` SET `spellid_1` = 1460 WHERE (`entry` = 2290);

        -- Scroll of Intellect III
        UPDATE `item_template` SET `spellid_1` = 1461 WHERE (`entry` = 4419);

        -- Scroll of Stamina III
        UPDATE `item_template` SET `spellid_1` = 909 WHERE (`entry` = 4422);

        -- Conjured Fresh Water
        UPDATE `item_template` SET `display_id` = 1484 WHERE (`entry` = 2288);

        -- Inferno Robe
        UPDATE `item_template` SET `display_id` = 4498, `fire_res` = 1, `spellid_1` = 0, `spelltrigger_1` = 0 WHERE (`entry` = 2231);

        -- Elixir of Fortitude
        UPDATE `item_template` SET `display_id` = 2221 WHERE (`entry` = 2458);

        -- Crocilisk Steak
        UPDATE `item_template` SET `display_id` = 1117 WHERE (`entry` = 3662);

        -- Mind Numbing Poison
        UPDATE `item_template` SET `display_id` = 9731 WHERE (`entry` = 5237);

        -- Forget to update name for Magebane Staff
        UPDATE `item_template` SET `name` = 'Magebane Staff' WHERE (`entry` = 944);

        -- Brilliant Smallfish
        UPDATE `item_template` SET `display_id` = 7988 WHERE (`entry` = 6290);

        -- Coyote Meat
        UPDATE `item_template` SET `display_id` = 1762 WHERE (`entry` = 2684);

        -- Dry Pork Ribs
        UPDATE `item_template` SET `display_id` = 1118 WHERE (`entry` = 2687);

        -- Deadly Poison
        UPDATE `item_template` SET `display_id` = 2533 WHERE (`entry` = 2892);

        -- Deadly Poison II
        UPDATE `item_template` SET `display_id` = 2533 WHERE (`entry` = 2893);

        -- Crocilisk Meat
        UPDATE `item_template` SET `display_id` = 2603 WHERE (`entry` = 2924);

        -- Curiously Tasty Omelet
        UPDATE `item_template` SET `display_id` = 3967 WHERE (`entry` = 3665);

        -- Southshore Stout
        UPDATE `item_template` SET `display_id` = 9304 WHERE (`entry` = 3703);

        -- Big Bear Steak
        UPDATE `item_template` SET `display_id` = 7998 WHERE (`entry` = 3726);

        -- Shadow Oil
        UPDATE `item_template` SET `display_id` = 2533 WHERE (`entry` = 3824);

        -- Junglewine
        UPDATE `item_template` SET `display_id` = 2754 WHERE (`entry` = 4595);

        -- Poisonious Mushroom
        UPDATE `item_template` SET `display_id` = 6624 WHERE (`entry` = 5823);

        -- Holy Protection Potion
        UPDATE `item_template` SET `display_id` = 6326 WHERE (`entry` = 6051);

        -- Raw Bristle Whisker Catfish
        UPDATE `item_template` SET `display_id` = 1208 WHERE (`entry` = 4593);

        -- Rune Sword, only one katana model available
        UPDATE `item_template` SET `display_id` = 5181 WHERE (`entry` = 864);

        -- Kazon's Maul
        UPDATE `item_template` SET `display_id` = 1206 WHERE (`entry` = 2058);

        -- Monster - Mace2H, Kazon's Maul
        UPDATE `item_template` SET `display_id` = 1206 WHERE (`entry` = 10685);

        -- Hillborne Axe
        UPDATE `item_template` SET `display_id` = 1390 WHERE (`entry` = 2080);

        -- Prison Shank
        UPDATE `item_template` SET `display_id` = 9344 WHERE (`entry` = 2941);

        -- Dreadblade
        UPDATE `item_template` SET `display_id` = 8755 WHERE (`entry` = 4088);

        -- Captain's armor
        UPDATE `item_template` SET `display_id` = 3082 WHERE (`entry` = 1488);

        -- Rawhides Gloves
        UPDATE `item_template` SET `display_id` = 3848 WHERE (`entry` = 1791);

        -- Tough Leather Armor
        UPDATE `item_template` SET `display_id` = 684 WHERE (`entry` = 1810);

        -- Dirty Leather Belt
        UPDATE `item_template` SET `display_id` = 7746 WHERE (`entry` = 1835);

        -- Dirty Leather Bracer
        UPDATE `item_template` SET `display_id` = 10016 WHERE (`entry` = 1836);

        -- Cozzy Moccasins
        UPDATE `item_template` SET `display_id` = 6190 WHERE (`entry` = 2959);

        -- Mantle of Thieves
        UPDATE `item_template` SET `display_id` = 8807 WHERE (`entry` = 2264);

        -- Reinforced Leather Vest
        UPDATE `item_template` SET `display_id` = 8331 WHERE (`entry` = 2470);

        -- Reinforced Leather Belt
        UPDATE `item_template` SET `display_id` = 9551 WHERE (`entry` = 2471);

        -- Reinforced Leather Cap
        UPDATE `item_template` SET `display_id` = 1124 WHERE (`entry` = 3893);

        -- Woolen Boots
        UPDATE `item_template` SET `display_id` = 4296 WHERE (`entry` = 2583);

        -- Holy Diadem
        UPDATE `item_template` SET `display_id` = 6491 WHERE (`entry` = 2623);

        -- Silken Thread
        UPDATE `item_template` SET `display_id` = 4750 WHERE (`entry` = 4291);

        -- Studded Leather Cap
        UPDATE `item_template` SET `display_id` = 3785 WHERE (`entry` = 3890);

        insert into applied_updates values ('120720241');
    end if;
end $
delimiter ;