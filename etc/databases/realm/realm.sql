/*M!999999- enable the sandbox mode */
-- MariaDB dump 10.19-11.8.3-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ar
-- ------------------------------------------------------
-- Server version	11.8.3-MariaDB-0+deb13u1 from Debian

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `applied_updates`
--

DROP TABLE IF EXISTS `applied_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `applied_updates` (
  `id` varchar(9) NOT NULL DEFAULT '000000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applied_updates`
--

LOCK TABLES `applied_updates` WRITE;
/*!40000 ALTER TABLE `applied_updates` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `applied_updates` VALUES
('040620221'),
('041220221'),
('050520211'),
('060520211'),
('070820221'),
('090520211'),
('090820221'),
('100120251'),
('110620231'),
('120220231'),
('120620241'),
('150520211'),
('170520211'),
('170620211'),
('180520221'),
('180620231'),
('200420211'),
('200520201'),
('200620211'),
('221220221'),
('230520211'),
('250220211'),
('250320211'),
('270420211'),
('290520211'),
('291120221'),
('300420211'),
('310320231');
/*!40000 ALTER TABLE `applied_updates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_buttons`
--

DROP TABLE IF EXISTS `character_buttons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_buttons` (
  `owner` int(11) unsigned NOT NULL DEFAULT 0,
  `index` int(11) unsigned NOT NULL DEFAULT 0,
  `action` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`owner`,`index`,`action`),
  CONSTRAINT `owner_guid_button_fk` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_buttons`
--

LOCK TABLES `character_buttons` WRITE;
/*!40000 ALTER TABLE `character_buttons` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_buttons` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_deathbind`
--

DROP TABLE IF EXISTS `character_deathbind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_deathbind` (
  `deathbind_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_guid` int(11) unsigned NOT NULL,
  `creature_binder_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `deathbind_map` int(11) unsigned NOT NULL DEFAULT 0,
  `deathbind_zone` int(11) unsigned NOT NULL DEFAULT 0,
  `deathbind_position_x` float NOT NULL DEFAULT 0,
  `deathbind_position_y` float NOT NULL DEFAULT 0,
  `deathbind_position_z` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`deathbind_id`),
  KEY `fk_character_deathbind_characters1_idx` (`player_guid`),
  CONSTRAINT `fk_character_deathbind_characters1` FOREIGN KEY (`player_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_deathbind`
--

LOCK TABLES `character_deathbind` WRITE;
/*!40000 ALTER TABLE `character_deathbind` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_deathbind` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_gifts`
--

DROP TABLE IF EXISTS `character_gifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_gifts` (
  `guid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `creator` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Who wrapped the gift. Shoud not cascade delete',
  `item_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `entry` int(11) unsigned NOT NULL DEFAULT 0,
  `flags` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_gifts`
--

LOCK TABLES `character_gifts` WRITE;
/*!40000 ALTER TABLE `character_gifts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_gifts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_inventory`
--

DROP TABLE IF EXISTS `character_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_inventory` (
  `guid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier',
  `creator` int(11) unsigned NOT NULL DEFAULT 0,
  `bag` int(11) unsigned NOT NULL DEFAULT 0,
  `slot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `item_template` mediumint(8) unsigned NOT NULL DEFAULT 0 COMMENT 'Item Identifier',
  `stackcount` int(11) unsigned NOT NULL DEFAULT 1,
  `SpellCharges1` int(11) NOT NULL DEFAULT -1,
  `SpellCharges2` int(11) NOT NULL DEFAULT -1,
  `SpellCharges3` int(11) NOT NULL DEFAULT -1,
  `SpellCharges4` int(11) NOT NULL DEFAULT -1,
  `SpellCharges5` int(11) NOT NULL DEFAULT -1,
  `item_flags` int(11) NOT NULL DEFAULT 0,
  `duration` int(11) unsigned NOT NULL DEFAULT 0,
  `enchantments` mediumtext NOT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_guid` (`owner`),
  CONSTRAINT `owner_guid` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_inventory`
--

LOCK TABLES `character_inventory` WRITE;
/*!40000 ALTER TABLE `character_inventory` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_inventory` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_pet_spells`
--

DROP TABLE IF EXISTS `character_pet_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_pet_spells` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `pet_id` int(11) unsigned NOT NULL DEFAULT 0,
  `spell_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`spell_id`),
  KEY `fk_character_pet_spells_characters1_idx` (`guid`),
  KEY `fk_character_pet_spells_character_pets1_idx` (`pet_id`),
  CONSTRAINT `fk_character_pet_spells_character_pets1_idx` FOREIGN KEY (`pet_id`) REFERENCES `character_pets` (`pet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_character_pet_spells_characters1_idx` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_pet_spells`
--

LOCK TABLES `character_pet_spells` WRITE;
/*!40000 ALTER TABLE `character_pet_spells` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_pet_spells` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_pets`
--

DROP TABLE IF EXISTS `character_pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_pets` (
  `pet_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `creature_id` int(11) unsigned NOT NULL DEFAULT 0,
  `created_by_spell` int(11) unsigned NOT NULL DEFAULT 0,
  `level` int(11) unsigned NOT NULL DEFAULT 0,
  `xp` int(11) unsigned NOT NULL DEFAULT 0,
  `react_state` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `command_state` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  `rename_time` int(11) unsigned NOT NULL DEFAULT 0,
  `health` int(11) unsigned NOT NULL DEFAULT 0,
  `mana` int(11) unsigned NOT NULL DEFAULT 0,
  `action_bar` tinyblob NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`pet_id`),
  KEY `fk_character_pets_characters1_idx` (`owner_guid`),
  CONSTRAINT `fk_character_pets_characters1` FOREIGN KEY (`owner_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_pets`
--

LOCK TABLES `character_pets` WRITE;
/*!40000 ALTER TABLE `character_pets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_pets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_quest_state`
--

DROP TABLE IF EXISTS `character_quest_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_quest_state` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `quest` int(11) unsigned NOT NULL DEFAULT 0,
  `state` int(11) unsigned NOT NULL DEFAULT 0,
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `explored` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `timer` bigint(20) unsigned NOT NULL DEFAULT 0,
  `mobcount1` int(11) unsigned NOT NULL DEFAULT 0,
  `mobcount2` int(11) unsigned NOT NULL DEFAULT 0,
  `mobcount3` int(11) unsigned NOT NULL DEFAULT 0,
  `mobcount4` int(11) unsigned NOT NULL DEFAULT 0,
  `itemcount1` int(11) unsigned NOT NULL DEFAULT 0,
  `itemcount2` int(11) unsigned NOT NULL DEFAULT 0,
  `itemcount3` int(11) unsigned NOT NULL DEFAULT 0,
  `itemcount4` int(11) unsigned NOT NULL DEFAULT 0,
  `reward_choice` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`quest`),
  CONSTRAINT `char_guid_quest_fk` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_quest_state`
--

LOCK TABLES `character_quest_state` WRITE;
/*!40000 ALTER TABLE `character_quest_state` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_quest_state` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_reputation`
--

DROP TABLE IF EXISTS `character_reputation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_reputation` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `faction` int(11) unsigned NOT NULL DEFAULT 0,
  `standing` int(11) NOT NULL DEFAULT 0,
  `flags` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `index` int(5) NOT NULL,
  PRIMARY KEY (`guid`,`faction`),
  CONSTRAINT `fk_character_reputation_character` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_reputation`
--

LOCK TABLES `character_reputation` WRITE;
/*!40000 ALTER TABLE `character_reputation` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_reputation` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_skills`
--

DROP TABLE IF EXISTS `character_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_skills` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `skill` mediumint(9) unsigned NOT NULL DEFAULT 0,
  `value` mediumint(9) unsigned NOT NULL DEFAULT 0,
  `max` mediumint(9) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`skill`),
  KEY `idx_guid2` (`guid`),
  CONSTRAINT `skill_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_skills`
--

LOCK TABLES `character_skills` WRITE;
/*!40000 ALTER TABLE `character_skills` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_skills` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_social`
--

DROP TABLE IF EXISTS `character_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_social` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Character Global Unique Identifier',
  `other_guid` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Friend Global Unique Identifier',
  `ignore` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT 'Whether player is a friend(0) or ignore(1)',
  PRIMARY KEY (`guid`,`other_guid`,`ignore`),
  KEY `guid` (`guid`),
  KEY `other_guid` (`other_guid`),
  KEY `ignore` (`ignore`),
  CONSTRAINT `social_oth` FOREIGN KEY (`other_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `social_own` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_social`
--

LOCK TABLES `character_social` WRITE;
/*!40000 ALTER TABLE `character_social` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_social` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_spell_book`
--

DROP TABLE IF EXISTS `character_spell_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_spell_book` (
  `owner` int(11) unsigned NOT NULL DEFAULT 0,
  `index` int(11) NOT NULL DEFAULT 0,
  `spell` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`owner`,`spell`),
  CONSTRAINT `owner_guid_spell_book_fk` FOREIGN KEY (`owner`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_spell_book`
--

LOCK TABLES `character_spell_book` WRITE;
/*!40000 ALTER TABLE `character_spell_book` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_spell_book` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_spell_cooldown`
--

DROP TABLE IF EXISTS `character_spell_cooldown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `spell` int(11) unsigned NOT NULL DEFAULT 0,
  `item` int(11) unsigned NOT NULL DEFAULT 0,
  `time` bigint(20) unsigned NOT NULL DEFAULT 0,
  `category_time` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`spell`),
  KEY `idx_guid4` (`guid`),
  CONSTRAINT `spell_cd_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_spell_cooldown`
--

LOCK TABLES `character_spell_cooldown` WRITE;
/*!40000 ALTER TABLE `character_spell_cooldown` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_spell_cooldown` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `character_spells`
--

DROP TABLE IF EXISTS `character_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `character_spells` (
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `spell` int(11) unsigned NOT NULL DEFAULT 0,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`,`spell`),
  KEY `idx_spell` (`spell`),
  KEY `idx_guid3` (`guid`),
  CONSTRAINT `spell_guid` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `character_spells`
--

LOCK TABLES `character_spells` WRITE;
/*!40000 ALTER TABLE `character_spells` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `character_spells` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `characters` (
  `guid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Account Identifier',
  `realm_id` tinyint(3) NOT NULL DEFAULT 1,
  `name` varchar(12) NOT NULL DEFAULT '',
  `race` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `class` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `gender` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `level` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `xp` int(11) unsigned NOT NULL DEFAULT 0,
  `money` int(11) unsigned NOT NULL DEFAULT 0,
  `skin` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `face` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `hairstyle` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `haircolour` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `facialhair` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `bankslots` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `talentpoints` int(11) unsigned NOT NULL DEFAULT 0,
  `skillpoints` int(11) unsigned NOT NULL DEFAULT 0,
  `position_x` float NOT NULL DEFAULT 0,
  `position_y` float NOT NULL DEFAULT 0,
  `position_z` float NOT NULL DEFAULT 0,
  `map` int(11) unsigned NOT NULL DEFAULT 0 COMMENT 'Map Identifier',
  `orientation` float NOT NULL DEFAULT 0,
  `taximask` longtext DEFAULT NULL,
  `explored_areas` longtext DEFAULT NULL,
  `online` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `totaltime` int(11) unsigned NOT NULL DEFAULT 0,
  `leveltime` int(11) unsigned NOT NULL DEFAULT 0,
  `extra_flags` int(11) unsigned NOT NULL DEFAULT 0,
  `zone` int(11) unsigned NOT NULL DEFAULT 0,
  `taxi_path` text DEFAULT NULL,
  `drunk` smallint(5) unsigned NOT NULL DEFAULT 0,
  `health` int(10) unsigned NOT NULL DEFAULT 0,
  `power1` int(10) unsigned NOT NULL DEFAULT 0,
  `power2` int(10) unsigned NOT NULL DEFAULT 0,
  `power3` int(10) unsigned NOT NULL DEFAULT 0,
  `power4` int(10) unsigned NOT NULL DEFAULT 0,
  `power5` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`),
  KEY `idx_online` (`online`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `leader_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `loot_method` int(5) unsigned NOT NULL DEFAULT 0,
  `loot_master` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`),
  KEY `group_leader_guid_fk` (`leader_guid`),
  CONSTRAINT `group_leader_guid_fk` FOREIGN KEY (`leader_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `group_member`
--

DROP TABLE IF EXISTS `group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_member` (
  `group_id` int(11) unsigned NOT NULL DEFAULT 0,
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`,`guid`),
  KEY `group_member_guid_fk` (`guid`),
  CONSTRAINT `group_id_fk` FOREIGN KEY (`group_id`) REFERENCES `group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_member_guid_fk` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_member`
--

LOCK TABLES `group_member` WRITE;
/*!40000 ALTER TABLE `group_member` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `group_member` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guild`
--

DROP TABLE IF EXISTS `guild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guild` (
  `guild_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `realm_id` tinyint(3) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL DEFAULT '',
  `motd` varchar(255) NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `emblem_style` int(5) NOT NULL DEFAULT -1,
  `emblem_color` int(5) NOT NULL DEFAULT -1,
  `border_style` int(5) NOT NULL DEFAULT -1,
  `border_color` int(5) NOT NULL DEFAULT -1,
  `background_color` int(5) NOT NULL DEFAULT -1,
  PRIMARY KEY (`guild_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild`
--

LOCK TABLES `guild` WRITE;
/*!40000 ALTER TABLE `guild` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guild` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guild_member`
--

DROP TABLE IF EXISTS `guild_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guild_member` (
  `guild_id` int(11) unsigned NOT NULL DEFAULT 0,
  `guid` int(11) unsigned NOT NULL DEFAULT 0,
  `rank` tinyint(2) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`guild_id`,`guid`),
  KEY `guild_member_guid_fk` (`guid`),
  CONSTRAINT `guild_id_fk` FOREIGN KEY (`guild_id`) REFERENCES `guild` (`guild_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `guild_member_guid_fk` FOREIGN KEY (`guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_member`
--

LOCK TABLES `guild_member` WRITE;
/*!40000 ALTER TABLE `guild_member` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guild_member` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `petition`
--

DROP TABLE IF EXISTS `petition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `petition` (
  `petition_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `realm_id` tinyint(3) NOT NULL DEFAULT 1,
  `owner_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `item_guid` int(11) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`petition_id`),
  UNIQUE KEY `owner_guid` (`owner_guid`,`item_guid`),
  KEY `petition_guid_item_guid_fk` (`item_guid`),
  CONSTRAINT `owner_guid_character_guid_fk` FOREIGN KEY (`owner_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `petition_guid_item_guid_fk` FOREIGN KEY (`item_guid`) REFERENCES `character_inventory` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petition`
--

LOCK TABLES `petition` WRITE;
/*!40000 ALTER TABLE `petition` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `petition` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `petition_sign`
--

DROP TABLE IF EXISTS `petition_sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `petition_sign` (
  `petition_id` int(11) unsigned NOT NULL DEFAULT 0,
  `player_guid` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`petition_id`,`player_guid`),
  KEY `player_guid_character_guid_fk` (`player_guid`),
  CONSTRAINT `petition_id_petition_fk` FOREIGN KEY (`petition_id`) REFERENCES `petition` (`petition_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `player_guid_character_guid_fk` FOREIGN KEY (`player_guid`) REFERENCES `characters` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petition_sign`
--

LOCK TABLES `petition_sign` WRITE;
/*!40000 ALTER TABLE `petition_sign` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `petition_sign` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_bug` int(1) NOT NULL DEFAULT 0,
  `account_name` varchar(250) NOT NULL DEFAULT '',
  `account_id` int(10) unsigned NOT NULL DEFAULT 0,
  `realm_id` tinyint(3) NOT NULL DEFAULT 1,
  `character_name` varchar(12) NOT NULL DEFAULT '',
  `text_body` text NOT NULL,
  `submit_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-10-30 23:20:39
