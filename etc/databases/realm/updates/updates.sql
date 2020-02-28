delimiter $
begin not atomic
    -- 13/02/2020 1
    if (select count(*) from applied_updates where id='13022021') = 0 then
        set foreign_key_checks = 0;
        alter table characters modify guid int(11) unsigned auto_increment;
        set foreign_key_checks = 1;

        insert into applied_updates values('13022021');
    end if;

    -- 22/02/2020 1
    if (select count(*) from applied_updates where id='22022021') = 0 then
        set foreign_key_checks = 0;
        alter table character_inventory modify guid int(11) unsigned auto_increment;
        set foreign_key_checks = 1;

        insert into applied_updates values('22022021');
    end if;

    -- 23/02/2020 1
    if (select count(*) from applied_updates where id='23022021') = 0 then
        set foreign_key_checks = 0;
        DROP TABLE IF EXISTS `character_inventory`;
        CREATE TABLE `character_inventory` (
          `guid` int(11) unsigned auto_increment,
          `owner` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
          `creator` int(11) unsigned NOT NULL DEFAULT '0',
          `bag` int(11) unsigned NOT NULL DEFAULT '0',
          `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
          `item_template` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'Item Identifier',
          `stackcount` int(11) unsigned NOT NULL DEFAULT '1',
          `SpellCharges1` int(11) unsigned NOT NULL DEFAULT '0',
          `SpellCharges2` int(11) unsigned NOT NULL DEFAULT '0',
          `SpellCharges3` int(11) unsigned NOT NULL DEFAULT '0',
          `SpellCharges4` int(11) unsigned NOT NULL DEFAULT '0',
          `SpellCharges5` int(11) unsigned NOT NULL DEFAULT '0',
          PRIMARY KEY (`guid`),
          KEY `idx_guid` (`owner`),
          CONSTRAINT `owner_guid` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        set foreign_key_checks = 1;

        insert into applied_updates values('23022021');
    end if;

    -- 29/02/2020 1
    if (select count(*) from applied_updates where id='29022021') = 0 then
        alter table character_inventory modify SpellCharges1 int(11) not null default -1;
        alter table character_inventory modify SpellCharges2 int(11) not null default -1;
        alter table character_inventory modify SpellCharges3 int(11) not null default -1;
        alter table character_inventory modify SpellCharges4 int(11) not null default -1;
        alter table character_inventory modify SpellCharges5 int(11) not null default -1;

        insert into applied_updates values('29022021');
    end if;

end $
delimiter ;